/* system include */
#include <ctype.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/io.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <termio.h>     /* For DIO include */
#include <termios.h>
#include <time.h>
#include <linux/input.h>
#include <linux/kd.h>
#include <linux/vt.h>
#include <iconv.h>


typedef int BOOL;
#define TRUE                   (1)
#define FALSE                  (0)
#define RES_TIMEOUT_CNT        (1000*30)
#define RES_WAIT_TIME_1MS      (1000)     // 1ms

#define RES_FAIL (-1)

typedef enum
{
    KIND_TYPE_NONE = 0, // 初期状態
    KIND_TYPE_LNG,
    KIND_TYPE_BOL,
    KIND_TYPE_STR,
} KIND_TYPE;

#include "cat.h"
#include "IfMultiTmn.h"
#include "MultiTmnMem.h"
#include "MultiTmnAPI.h"

static TMN_TMNIF_BUF *IF_BUF = NULL;

// 参考ソースrc_multi_Tmn.c

// デバッグ用
#define MultiTmnDebug 0
char    c_log[4096+512];
#if MultiTmnDebug
    #define SEP        0x09
    #define drvName "multiTmnAPI"
    int    LogWrite( char *add )
    {
        struct timeval    t_tv;
        int        t;
        struct tm    *l;
        if(gettimeofday(&t_tv, NULL) != 0) {
            t = time(0);
            l = localtime((time_t *)&t);
            printf("%d-%02d-%02d %02d:%02d:%02d%c %s %s\n",
                l->tm_year+1900, l->tm_mon+1, l->tm_mday,/* date */
                l->tm_hour, l->tm_min, l->tm_sec,    /* time */
                SEP,                    /* separate */
                drvName,
                add );                    /* user data */
        }
        else {
            l = localtime((const time_t*)&t_tv.tv_sec);
            printf("%d-%02d-%02d %02d:%02d:%02d.%06ld%c %s %s\n",
                l->tm_year+1900, l->tm_mon+1, l->tm_mday,/* date */
                l->tm_hour, l->tm_min, l->tm_sec,    /* time */
                (long)t_tv.tv_usec,            /* msec */
                SEP,                    /* separate */
                drvName,
                add );                    /* user data */

        }
    }
#else
    #define LogWrite(a)
#endif

/**********************************************************************
    関数：getMode
    機能：CAT.iniよりモードを取得する。
    引数：なし
    戻値：0：通常モード／1：テストモード（エラー発生時は通常モード）／-1：multiTMN非対応
***********************************************************************/
#define    AIRPOS_DB_CONF              "/pj/tprx/conf/multi_tmn/CAT.ini"
#define    AIRPOS_DB_SRCH_HOST         "OfflineTestMode="

int getMode() {
    FILE    *fp;
    char    DB_Host[256] = {0};
    char    buf[512];
    char    *setPnt;
    int     setSize;
    int     len;
    int     mode = -1;//multiTMN非対応

    fp = fopen(AIRPOS_DB_CONF, "r");
    if ( fp != NULL ) {
        while ( 1 )
        {
            memset(buf, 0x00, sizeof(buf) );
            if ( fgets(buf, sizeof(buf), fp) == NULL )
            {
                break;
            }

            if ( buf[0] == '#' )
            {
                continue;
            }

            len = 0;
            if ( strstr(buf, AIRPOS_DB_SRCH_HOST) != NULL )
            {
                setPnt = DB_Host;
                setSize = sizeof(DB_Host);
                len = strlen(AIRPOS_DB_SRCH_HOST);
                strncpy( setPnt, &buf[len], strlen(buf) - len - 1 );
                mode = atoi(setPnt);

                snprintf(c_log, sizeof(c_log), "--- mode(%d)", mode);
                LogWrite(c_log);
            }
        }
        if( fclose(fp) != 0 )
        {
            snprintf( c_log, sizeof(c_log), "%s : (%s) close エラー", __FUNCTION__, AIRPOS_DB_CONF );
            LogWrite(c_log);
        }
    } else {
        snprintf( c_log, sizeof(c_log), "%s : (%s) 読込エラー", __FUNCTION__, AIRPOS_DB_CONF );
        LogWrite(c_log);
    }
    return mode;
}
/**********************************************************************
    関数：TmnApiInit
    機能：TMN システムインタフェース初期化
    引数：int *mode: [IN/OUT] 0：通常モード／1：テストモード
    戻値：TMN_OK   成功
          TMN_NG   失敗
***********************************************************************/
int TmnApiInit(char *path, int *mode)
{
    char        sys_cmd[256];
    LogWrite("--- TmnApiInit");

    sprintf(sys_cmd, "/bin/sh %s 2> /dev/null", path);
    system(sys_cmd);

    if(rxMemGet(RXMEM_TMNIF) != RXMEM_OK) {
        LogWrite("rxMemGet error");
    }

    if(rxMemPtr(RXMEM_TMNIF, (void **)&IF_BUF) != RXMEM_OK) {
        LogWrite("IF_BUF get error");
        return TMN_NG;
    }
    IF_BUF->isReady = FALSE;
    IF_BUF->isBusy = FALSE;
    /* ファイル書き換え */
    *mode = getMode();
    return TMN_OK;
}
/**********************************************************************
    関数：TmnApiIsReady
    機能：TMN システム準備確認
    引数：なし
    戻値：TMN_OK   準備OK
          TMN_NG   準備NG
***********************************************************************/
int TmnApiIsReady(void)
{
    int ret = TMN_NG;
    if( IF_BUF->isReady == TRUE ) {
        LogWrite("--- TmnApiIsReady Ready to go");
        ret = TMN_OK;
    }
    return ret;
}

/**********************************************************************
    関数：TmnOposOpen
    機能：TMN システム利用開始時に呼び出す
    引数：なし
    戻値：OposOpen()戻り値
            OPOS_SUCCESS     成功。
            OPOS_E_ILLEGAL   当該プロセス内で既にオープン済み。
            OPOS_E_NOEXIST   DeviceName が不正。
            OPOS_E_NOSERVICE 必要な TMN モジュール群が見つからない。
            OPOS_E_EXTENDED  TMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposOpen(void)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->order = CMD_OPOS_OPEN;
            LogWrite("--- OposOpen()");

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposOpen return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposOpen BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposOpen IF_BUF fail");
    }
    return(ret);
}

/**********************************************************************
    関数：TmnOposClose
    機能：TMN システム利用終了時に呼び出す
    引数：なし
    戻値：OposClose()戻り値
            OPOS_SUCCESS    成功。
            OPOS_E_EXTENDED 123000001 成功だが、実行中要求のキャンセルに失敗
                            他はTMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposClose(void)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->order = CMD_OPOS_CLOSE;
            LogWrite("--- OposClose()");

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposClose return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposClose BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposClose IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposClaimDevice
    機能：TMN システムの使用権を獲得します。
    引数：long timeout
    戻値：OposClaimDevice()戻り値
            OPOS_SUCCESS    成功。
            OPOS_E_CLOSED   オープンされていない。
            OPOS_E_ILLEGAL  Timeout 値が不正。
            OPOS_E_EXTENDED TMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposClaimDevice(long timeout)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->timeout = timeout;
            IF_BUF->order = CMD_OPOS_CLAIM_DEVICE;
            snprintf(c_log, sizeof(c_log), "--- OposClaimDevice(timeout=%ld)", IF_BUF->timeout);
            LogWrite(c_log);

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposClaimDevice return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposClaimDevice BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposClaimDevice IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposReleaseDevice
    機能：TMN システムの使用権を放棄します。
    引数：なし
    戻値：OposReleaseDevice()戻り値
            OPOS_SUCCESS    成功。
            OPOS_E_CLOSED   オープンされていない。
            OPOS_E_ILLEGAL  アプリケーションは使用権を有していない。
            OPOS_E_EXTENDED TMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposReleaseDevice(void)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->order = CMD_OPOS_RELEASE_DEVICE;
            LogWrite("--- OposReleaseDevice");

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposReleaseDevice return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposReleaseDevice BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposReleaseDevice IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposCheckHealth
    機能：自己診断の実行。
    引数：long level
    戻値：OposCheckHealth()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    Level 値が不正。
            OPOS_E_BUSY       先に発行された要求が完了していない。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposCheckHealth(long level)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->level = level;
            IF_BUF->order = CMD_OPOS_CHECK_HEALTH;
            snprintf(c_log, sizeof(c_log), "--- OposCheckHealth(level=%ld)", IF_BUF->level);
            LogWrite(c_log);

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposCheckHealth return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposCheckHealth BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposCheckHealth IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposClearOutput
    機能：非同期要求のキャンセル
    引数：なし
    戻値：OposClearOutput()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    キャンセル不可能な取引状態。
            OPOS_E_BUSY       先に発行された要求が完了していない。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposClearOutput(void)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->order = CMD_OPOS_CLEAR_OUTPUT;
            LogWrite("--- OposClearOutput");

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposClearOutput return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposClearOutput BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposClearOutput IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposDirectIO
    機能：コマンド番号により、様々な保守機能を実行
    引数：long command, long *pData, char *pString
    戻値：OposDirectIO()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    パラメータ値が不正。
            OPOS_E_BUSY       先に発行された要求が完了していない。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposDirectIO(long command, long *pData, char *pString)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->command = command;
            IF_BUF->data = *pData;
            memcpy(IF_BUF->str, pString, sizeof(IF_BUF->str));
            IF_BUF->order = CMD_OPSOS_DIRECT_IO;
            snprintf(c_log, sizeof(c_log), "--- OposDirectIO(command=%ld, pData=%ld, pString=(%s))", IF_BUF->command, IF_BUF->data, IF_BUF->str);
            LogWrite(c_log);

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    *pData = IF_BUF->data;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposDirectIO return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposDirectIO BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposDirectIO IF_BUF fail");
    }
    snprintf(c_log, sizeof(c_log), "--- OposDirectIO(command=%ld, pData=%ld, pString=(%s))  ret(%ld)", IF_BUF->command, IF_BUF->data, IF_BUF->str, ret);
    LogWrite(c_log);
    return(ret);
}
/**********************************************************************
    関数：TmnCifGetEvent
    機能：イベントの取得。
    引数：long *pOutputID, long *pResultCode, long *pResultCodeExtended, long *pErrorLocus, long *pErrorResponse, long *pEventNumber, long *pData, char *pString
    戻値：CifGetEvent()戻り値
            CIF_EVT_NONE           イベントなし。
            OPOS_E_CLOSED          オープンされていない。
            OPOS_E_NOTCLAIMED      アプリケーションは使用権を有していない。
            OPOS_E_DISABLED        DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL         pEvent 値が不正。
            OPOS_E_BUSY            イベント関数実行中。
            OPOS_E_EXTENDED        TMN エラーコードリストを参照してください。
            CIF_EVT_OUTPUTCOMPLETE OutputCompleteEvent を受信。
            CIF_EVT_ERROR          ErrorEvent を受信。
            CIF_EVT_DIRECTIO       DirectIOEvent を受信。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnCifGetEvent(long *pErrorResponse, long *pEventNumber, long *pData, char *pString)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->errorResponse = *pErrorResponse;
            IF_BUF->eventNumber = *pEventNumber;
            IF_BUF->data = *pData;
            memcpy(IF_BUF->str, pString, sizeof(IF_BUF->str));
            IF_BUF->order = CMD_CIF_GET_EVENT;
            snprintf(c_log, sizeof(c_log), "--- CifGetEvent(command=%ld, pData=%ld, pString=(%s))", IF_BUF->command, IF_BUF->data, IF_BUF->str);
            LogWrite(c_log);

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    *pErrorResponse = IF_BUF->errorResponse;
                    *pEventNumber = IF_BUF->eventNumber;
                    *pData = IF_BUF->data;
                    memcpy(pString, IF_BUF->str, sizeof(IF_BUF->str));
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnCifGetEvent return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnCifGetEvent BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnCifGetEvent IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnCifGetProperty
    機能：プロパティ値の取得。
    引数：long kind, long *lng, long *bol, char *bstr
    戻値：CifGetProperty()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    Kind または pProperty が不正。
            OPOS_E_BUSY       イベント関数実行中。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください
          RES_FAIL          パラメータ異常
***********************************************************************/
long TmnCifGetProperty(long kind, long *plng, long *pbol, char *pbstr)
{
    long ret = RES_FAIL;
    KIND_TYPE kindType = KIND_TYPE_NONE;
    char        log[4096];

    iconv_t ic;
    char    *ptr_in  = IF_BUF->str;
    char    *ptr_out = pbstr;
    size_t  mybufsz = (size_t) 4096;
    
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->kind = kind;
            switch( IF_BUF->kind ) {
                case RESULTCODE:
                case RESULTCODEEXTENDED:
                    kindType = KIND_TYPE_LNG;
                    IF_BUF->lng = *plng;
                    break;
                case ADDITIONALSECURITYINFORMATION:
                case CENTERRESULTCODE:
                case ACCOUNTNUMBER:
                case SLIPNUMBER:
                case TRANSACTIONNUMBER:
                    kindType = KIND_TYPE_STR;
                    memset(IF_BUF->str, 0, sizeof(IF_BUF->str));
                    break;
                default:
                    // error
                    snprintf(c_log, sizeof(c_log), "--- CifGetProperty error(kind=%ld)", kind);
                    LogWrite(c_log);
                    IF_BUF->isBusy = FALSE;
                    return RES_FAIL;
            }
            IF_BUF->order = CMD_CIF_GET_PROPERTY;
            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    switch( kindType ) {
                        case KIND_TYPE_LNG:
                            *plng = IF_BUF->lng;
                            snprintf(c_log, sizeof(c_log), "--- CifGetProperty(kind=%ld) ret=%ld lng=%ld)", kind, ret, *plng);
                            LogWrite(c_log);
                            break;
                        case KIND_TYPE_STR:
                            // EUC-JP -> UTF-8
                            ic = iconv_open("UTF-8", "EUC-JP");
                            iconv(ic, &ptr_in,  &mybufsz, &ptr_out,  &mybufsz);
                            iconv_close(ic);
                            snprintf(c_log, sizeof(c_log), "--- CifGetProperty(kind=%ld) ret=%ld pbstr=(%s)", kind, ret, pbstr);
                            LogWrite(c_log);
                            if(pbstr[strlen(pbstr)-1] == 0x0d){
                                pbstr[strlen(pbstr)-1] = 0x00;
                            }
                            break;
                        default:
                            break;
                    }
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnCifGetProperty return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnCifGetProperty BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnCifGetProperty IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnCifSetProperty
    機能：プロパティ値の設定。
    引数：long kind, long *lng, long *bol, char *bstr
    戻値：CifSetProperty()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_FAILURE    内部エラー。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    Kind または pProperty 値が不正。
            OPOS_E_BUSY       イベント関数実行中。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
          RES_FAIL          パラメータ異常
***********************************************************************/
long TmnCifSetProperty(long kind, long *plng, long *pbol, char *pbstr)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->kind = kind;
            switch( IF_BUF->kind ) {
                case PAYMENTMEDIA:
                    IF_BUF->lng = *plng;
                    snprintf(c_log, sizeof(c_log), "--- CifSetProperty(kind=%ld, lng=%ld)", kind, IF_BUF->lng);
                    break;
                case ASYNCMODE:
                case TRAININGMODE:
                case DEVICEENABLED:
                    IF_BUF->bol = *pbol;
                    snprintf(c_log, sizeof(c_log), "--- CifSetProperty(kind=%ld, bol=%ld)", kind, IF_BUF->bol);
                    break;
                case ADDITIONALSECURITYINFORMATION:
                    memcpy(IF_BUF->str, pbstr, sizeof(IF_BUF->str));
                    snprintf(c_log, sizeof(c_log), "--- CifSetProperty(kind=%ld, bstr=(%s))", kind, IF_BUF->str);
                    break;
                default:
                    // error
                    snprintf(c_log, sizeof(c_log), "--- CifSetProperty error(kind=%ld)", kind);
                    LogWrite(c_log);
                    IF_BUF->isBusy = FALSE;
                    return RES_FAIL;
            }
            LogWrite(c_log);
            IF_BUF->order = CMD_CIF_SET_PROPERTY;

            for(int i=0; i<RES_TIMEOUT_CNT; i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnCifSetProperty return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnCifSetProperty BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnCifSetProperty IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposAuthorizeSales
    機能：決済の実行。
    引数：long sequenceNumber, long *pAmountHi, long *pAmountLo, long *pTaxOthersHi, long *pTaxOthersLo, long timeout
    戻値：OposAuthorizeSales()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    Timeout 値が不正。
            OPOS_E_BUSY       先に発行された要求が完了していない。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposAuthorizeSales(long sequenceNumber, long *pAmountHi, long *pAmountLo, long *pTaxOthersHi, long *pTaxOthersLo, long timeout)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->sequenceNumber = sequenceNumber;
            IF_BUF->amount.Hi = *pAmountHi;
            IF_BUF->amount.Lo = *pAmountLo;
            IF_BUF->taxOthers.Hi = *pTaxOthersHi;
            IF_BUF->taxOthers.Lo = *pTaxOthersLo;
            IF_BUF->timeout = timeout;
            snprintf(c_log, sizeof(c_log), "--- OposAuthorizeSales(sequenceNumber=%ld, amount.Hi=%ld, amount.Lo=%ld, taxOthers.Hi=%ld, taxOthers.Lo=%ld, timeout=%ld)"
                , IF_BUF->sequenceNumber, IF_BUF->amount.Hi, IF_BUF->amount.Lo, IF_BUF->taxOthers.Hi, IF_BUF->taxOthers.Lo, IF_BUF->timeout);
            LogWrite(c_log);

            IF_BUF->order = CMD_OPOS_AUTHORIZE_SALES;
            for(long i=0; i<(timeout+100); i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    *pAmountHi = IF_BUF->amount.Hi;
                    *pAmountLo = IF_BUF->amount.Lo;
                    *pTaxOthersHi = IF_BUF->taxOthers.Hi;
                    *pTaxOthersLo = IF_BUF->taxOthers.Lo;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposAuthorizeSales return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposAuthorizeSales BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposAuthorizeSales IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposAuthorizeVoid
    機能：決済の取消。
    引数：long sequenceNumber, long *pAmountHi, long *pAmountLo, long *pTaxOthersHi, long *pTaxOthersLo, long timeout
    戻値：OposAuthorizeVoid()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    Timeout 値が不正。
            OPOS_E_BUSY       先に発行された要求が完了していない。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してくださ
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposAuthorizeVoid(long sequenceNumber, long *pAmountHi, long *pAmountLo, long *pTaxOthersHi, long *pTaxOthersLo, long timeout)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->sequenceNumber = sequenceNumber;
            IF_BUF->amount.Hi = *pAmountHi;
            IF_BUF->amount.Lo = *pAmountLo;
            IF_BUF->taxOthers.Hi = *pTaxOthersHi;
            IF_BUF->taxOthers.Lo = *pTaxOthersLo;
            IF_BUF->timeout = timeout;
            snprintf(c_log, sizeof(c_log), "--- OposAuthorizeVoid(sequenceNumber=%ld, amount.Hi=%ld, amount.Lo=%ld, taxOthers.Hi=%ld, taxOthers.Lo=%ld, timeout=%ld)"
                , IF_BUF->sequenceNumber, IF_BUF->amount.Hi, IF_BUF->amount.Lo, IF_BUF->taxOthers.Hi, IF_BUF->taxOthers.Lo, IF_BUF->timeout);
            LogWrite(c_log);

            IF_BUF->order = CMD_OPOS_AUTHORIZE_VOID;
            for(long i=0; i<(timeout+100); i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    *pAmountHi = IF_BUF->amount.Hi;
                    *pAmountLo = IF_BUF->amount.Lo;
                    *pTaxOthersHi = IF_BUF->taxOthers.Hi;
                    *pTaxOthersLo = IF_BUF->taxOthers.Lo;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposAuthorizeSales return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposAuthorizeSales BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposAuthorizeSales IF_BUF fail");
    }
    return(ret);
}
/**********************************************************************
    関数：TmnOposAccessDailyLog
    機能：集計または中間系の実行。
    引数：long sequenceNumber, long type, long timeout
    戻値：OposAccessDailyLog()戻り値
            OPOS_SUCCESS      成功。
            OPOS_E_CLOSED     オープンされていない。
            OPOS_E_NOTCLAIMED アプリケーションは使用権を有していない。
            OPOS_E_DISABLED   DeviceEnabled プロパティが真ではない。
            OPOS_E_ILLEGAL    Timeout 値が不正。
            OPOS_E_BUSY       先に発行された要求が完了していない。
            OPOS_E_EXTENDED   TMN エラーコードリストを参照してください。
          RES_FAIL         システムエラー
***********************************************************************/
long TmnOposAccessDailyLog(long sequenceNumber, long type, long timeout)
{
    long ret = RES_FAIL;
    if( IF_BUF != NULL ) {
        if( IF_BUF->isBusy != TRUE ) {
            IF_BUF->isBusy = TRUE;
            IF_BUF->response = RES_NONE;
            IF_BUF->sequenceNumber = sequenceNumber;
            IF_BUF->type = type;
            IF_BUF->timeout = timeout;
            snprintf(c_log, sizeof(c_log), "--- OposAccessDailyLog(sequenceNumber=%ld, type=%ld, timeout=%ld)"
                , IF_BUF->sequenceNumber, IF_BUF->type, IF_BUF->timeout);
            LogWrite(c_log);

            IF_BUF->order = CMD_OPOS_ACCESS_DAILY_LOG;
            for(long i=0; i<(timeout+100); i++) {
                if(IF_BUF->response != RES_NONE) {
                    IF_BUF->response = RES_NONE;
                    ret = IF_BUF->result;
                    break;
                }
                usleep(RES_WAIT_TIME_1MS);
            }
            snprintf(c_log, sizeof(c_log), "--- TmnOposAccessDailyLog return(%ld)",ret);
            LogWrite(c_log);
            IF_BUF->isBusy = FALSE;
        } else {
            LogWrite("--- TmnOposAccessDailyLog BUSY");
            ret = OPOS_E_BUSY;
        }
    } else {
        LogWrite("--- TmnOposAccessDailyLog IF_BUF fail");
    }
    return(ret);
}
