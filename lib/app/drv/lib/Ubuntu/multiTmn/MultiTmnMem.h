/*-------------------------------------------------------------------------
 * File Name    : MultiTmnMem.h
 *-------------------------------------------------------------------------*/

#ifndef  _TMNMEM_H_
#define  _TMNMEM_H_

/**********************************************************************
    共通メモリ定義(共有メモリ)
***********************************************************************/

/* 共通メモリ構造定義 */
typedef struct {
    int             isReady;
    int             isBusy;
    TMN_OPOS_CMD    order;
    TMN_OPOS_RES    response;
    long            result;
    long            timeout;
    long            level;
    long            command;
    long            data;
    char            str[4096];
    long            errorResponse;
    long            eventNumber;
    long            kind;
    long            lng;
    long            bol;
    long            sequenceNumber;
    CY              amount;
    CY              taxOthers;
    long            type;
} TMN_TMNIF_BUF;

/**********************************************************************
    共通メモリ定義
***********************************************************************/

/*-----  共有メモリインデックス  -----*/
typedef enum {
    RXMEM_TMNIF = 0,            /* 全タスク共通メモリ */
    RXMEM_TBLMAX,                /*  */
} RXMEM_IDX;

/*-----  共有メモリ関数の戻り値  -----*/
#define RXMEM_OK        0            /* 正常終了 */
#define RXMEM_NG        -1            /* 異常終了 */
/*-----  プロトタイプ宣言  -----*/
int rxMemGet(RXMEM_IDX idx);
int rxMemPtr(RXMEM_IDX idx, void **ptr);
int rxMemFree(RXMEM_IDX idx);
#endif

/* end of _TMNMEM_H_ */
