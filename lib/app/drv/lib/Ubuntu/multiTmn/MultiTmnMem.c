/**********************************************************************

    共有メモリ登録共通関数ソースファイル

***********************************************************************/

/**********************************************************************
    インクルード
***********************************************************************/

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stddef.h>
#include <stdio.h>
#include <errno.h>

typedef int BOOL;  // for cat.h
#define TRUE 1     // for cat.h
#define FALSE 0    // for cat.h
#include "cat.h"
#include "IfMultiTmn.h"
#include "MultiTmnMem.h"

/**********************************************************************
    共有メモリ定義
***********************************************************************/

/*-----  共有メモリ取得キー  -----*/
#define RXMEM_KEY(idx)  (key_t)(idx + 1)

/*-----  共有メモリ管理テーブル構造体  -----*/
typedef struct {
    int     shmid;              /* メモリID */
    char    *ptr;               /* メモリのポインタ */
    size_t  size;               /* サイズ(固定) */
} RX_SHM_TBL;

/*-----  共有メモリ管理テーブル  -----*/
static RX_SHM_TBL rxShmTbl[RXMEM_TBLMAX] = {
    {-1, (char *)-1, sizeof(TMN_TMNIF_BUF)},    /* TMN IFメモリ */
};

/**********************************************************************
    ローカル関数プロトタイプ宣言
***********************************************************************/
static int rxMemFreeDel(RXMEM_IDX idx, int fDel);
static int rxMemPtrChk(RXMEM_IDX idx);
static int rxMemSize(RXMEM_IDX idx);

// デバッグ用
#define MultiTmnDebug 0
//char    c_log[512];
#if MultiTmnDebug
    #define SEP        0x09
    #define drvName "multiTmn"
    int    LogWriteMem( char *add )
    {
        printf("%s  {%s}",drvName,add);
    }
#else
    #define LogWriteMem(a)
#endif

/**********************************************************************
    関数：int rxMemGet(RXMEM_IDX idx)
    機能：共有メモリを取得、アタッチする(メモリ単位)
    引数：idx     共有メモリのインデックス
    戻値：RXMEM_OK / RXMEM_NG
***********************************************************************/
int rxMemGet(RXMEM_IDX idx)
{
    int shmid;
    char *ptr;
    char erlog[256];

    /* 取得 */
    shmid = shmget(RXMEM_KEY(idx), rxMemSize(idx), (0666 | IPC_CREAT));
    if (shmid == -1) {
        snprintf(erlog, sizeof(erlog), "rxMemGet() get error idx[%d] errno[%d]\n", idx, errno);
        LogWriteMem(erlog);
        return RXMEM_NG;
    }
    snprintf(erlog, sizeof(erlog), "rxMemGet() idx[%d] rxMemSize[%d]\n", idx, rxMemSize(idx));
    LogWriteMem(erlog);

    /* アタッチ */
    ptr = shmat(shmid, (void *)0, 0);
    if (ptr == (char *)-1) {
        snprintf(erlog, sizeof(erlog), "rxMemGet() attach error idx[%d] errno[%d]\n", idx, errno);
        LogWriteMem(erlog);
        return RXMEM_NG;
    }

    /* テーブルに情報設定 */
    rxShmTbl[idx].shmid = shmid;
    rxShmTbl[idx].ptr   = ptr;

    return RXMEM_OK;;
}


/**********************************************************************
    関数：int rxMemFree(RXMEM_IDX idx)
    機能：共有メモリを開放する(メモリ単位、削除しない)
    引数：idx     共有メモリのインデックス
    戻値：RXMEM_OK / RXMEM_NG
***********************************************************************/
int rxMemFree(RXMEM_IDX idx)
{
    return rxMemFreeDel(idx, 0);
}


/**********************************************************************
    関数：int rxMemPtr(RXMEM_IDX idx, void **ptr)
    機能：共有メモリのポインタをセットする
    引数：idx     共有メモリのインデックス
        ：**ptr   共有メモリポインタのポインタ
    戻値：RXMEM_OK / RXMEM_NG
***********************************************************************/
int rxMemPtr(RXMEM_IDX idx, void **ptr)
{
    char        erlog[128];

    /* ポインタのチェック */
    if (rxShmTbl[idx].ptr == (char *)-1) {
        return RXMEM_NG;
    }

    /* ポインタセット */
    *ptr = rxShmTbl[idx].ptr;

    return RXMEM_OK;
}

/**********************************************************************
    関数：int rxMemFreeDel(RXMEM_IDX idx, int fDel)
    機能：共有メモリを開放し、削除する(メモリ単位)
    引数：idx     共有メモリのインデックス
        ：fDel    削除フラグ(0:削除しない / 1:削除する)
    戻値：RXMEM_OK / RXMEM_NG
***********************************************************************/
static
int rxMemFreeDel(RXMEM_IDX idx, int fDel)
{
    /* ポインタチェック */
    if (rxMemPtrChk(idx) == RXMEM_NG) {
        return RXMEM_NG;
    }

    /* デタッチ */
    if (shmdt(rxShmTbl[idx].ptr) == -1) {
        return RXMEM_NG;
    }
    rxShmTbl[idx].ptr = (char *)-1;

    if (fDel == 0) {
        return RXMEM_OK;
    }

    /* メモリIDのチェック */
    if (rxShmTbl[idx].shmid == -1) {
        return RXMEM_NG;
    }

    /* 削除 */
    if (shmctl(rxShmTbl[idx].shmid, IPC_RMID, 0) == -1) {
        return RXMEM_NG;
    }
    rxShmTbl[idx].shmid = -1;

    return RXMEM_OK;
}


/**********************************************************************
    関数：int rxMemPtrChk(RXMEM_IDX idx)
    機能：共有メモリポインタのチェック
    引数：idx     共有メモリのインデックス
    戻値：RXMEM_OK / RXMEM_NG
***********************************************************************/
static
int rxMemPtrChk(RXMEM_IDX idx)
{
    /* ポインタチェック */
    if (rxShmTbl[idx].ptr == (char *)-1) {
        return RXMEM_NG;
    }

    return RXMEM_OK;
}


/**********************************************************************
    関数：int rxMemSize(RXMEM_IDX idx)
    機能：共有メモリのサイズを取得
    引数：idx     共有メモリのインデックス
    戻値：共有メモリのサイズ
***********************************************************************/
static
int rxMemSize(RXMEM_IDX idx)
{
    return rxShmTbl[idx].size;
}

