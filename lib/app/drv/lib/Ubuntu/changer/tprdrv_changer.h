#ifndef __tprdrv_changer_h
#define __tprdrv_changer_h

/* system include */

/* project include */

/* Definitions */
#define BUFSIZE         1024

#define SYS_INI         "conf/sys.ini"
#define DRVRDTSK        "tprdrv_changerrd"  /* Module name of changer READ task */
#define DRVWRTSK        "tprdrv_changerwd"  /* Module name of changer WRITE task */

#define COM             "com"       /* com keyname */

#define MAXRETRYCNT     3           /* max retry count */

#define TIMER1          1           /* timer number */
#define TIMER2          2           /* timer number */

#define TIMER_REQ       1500 /* ms : TPR-DRV-IT-109 */
#define TIMER_NAK       1500 /* ms : TPR-DRV-IT-109 */
#define TIMER_ENQ       3500  /* ms : TPR-DRV-IT-109 */	//ENQのレスポンス待ち時間
//2012/10/24 OSのwrite遅延問題への安全策のため、タイムアウトを5秒程度に拡張(ログ解析より3.5秒程度の遅延が多い)
//TIMER_ENQ x cntで長大になる可能性があるが釣銭機側の処理が遅れるわけではないので
//アプリは最小で5秒以上にしておけばドライバより先にあきらめる可能性はないと思われる
//ただし、write遅延問題が連続しておきることは考慮していない

//念のためのメモ：
//コマンド -> 待機(GetTimer) -> ENQ -> 待機(TIMER_ENQ) -> ENQレス -> 待機(retry_enq_timer) -> retry_enq_cnt繰り返し
//よって、アプリのタイムアウト値は最小でもGetTimer(default:1500)+TIMER_ENQ=5秒以上でなくてはならない

#define CHANGER_OK      0               /* return OK */
#define CHANGER_NG     -1               /* return NG */
#define CHANGER_OFFLINE     -2          /* return OFFLINE */

#define CHANGER_RESULT_WAIT        1    /* result WAIT */
#define CHANGER_RESULT_OK          0    /* result OK */
#define CHANGER_RESULT_OFFLINE    -1    /* result OFFLINE */
#define CHANGER_RESULT_POWEROFF   -2    /* result POWER OFF */
#define CHANGER_RESULT_WRERROR    -3    /* result WRITE ERROR */
#define CHANGER_RESULT_RDERROR    -4    /* result READ ERROR */
#define CHANGER_RESULT_BUSY       -5    /* result BUSY */
#define CHANGER_RESULT_GIVEUP     -6    /* result GIVEUP RETRY */
#define CHANGER_RESULT_TMOUT      -7    /* result TIMEOUT */

#ifdef DELETE
#define TPRTST_POWEROFF 0x1400
#endif

#define CHANGER_DRV_SPEED2400	0x30
#define CHANGER_DRV_SPEED4800	0x31
#define CHANGER_DRV_SPEED9600	0x32
#define CHANGER_DRV_SPEED19200  0x33
#define CHANGER_DRV_SPEED38400  0x34
#define CHANGER_DRV_SPEED57600  0x35
#define CHANGER_DRV_SPEED115200 0x36

#define	CHANGER_DRV_BIT7	7
#define	CHANGER_DRV_BIT8	8

typedef enum {      /* state */
    CHANGER_STATE_INIT,     /* initial */
    CHANGER_STATE_RCV,      /* wait fo receive request */
    CHANGER_STATE_REPLY,    /* wait for reply */
    CHANGER_STATE_ENQ,      /* wait for remind */
    CHANGER_STATE_RETRY,    /* in retry */
    CHANGER_STATE_STATUS,   /* wait fo reply status */
    CHANGER_STATE_SYSFAIL   /* in SYSFAIL */
} changer_state;

/* global area */
extern  int tprx_errno;

#endif
/* End of tprdrv_changer.h */
