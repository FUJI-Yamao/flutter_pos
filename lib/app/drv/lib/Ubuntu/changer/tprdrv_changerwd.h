#ifndef __tprdrv_changerwd_h
#define __tprdrv_changerwd_h

/* system include */

/* project include */

/* Definitions */
#define MULTILENMSK 0x3FFFFFFF  /* Mask for pick data length -  */
                    /* from multi packet information */
#define MYDID       0x00000000
#define BUFSIZE     1024
#define MSGDATASIZE 1024
#define SYS_INI     "conf/sys.ini"
#define TTYAUX      "/dev/cua"
#define TTY         "/dev/ttyS"     /* TTY prefix */

/* return */
#define CHANGERWD_OK  0         /* OK */
#define CHANGERWD_NG -1         /* NG */

#define COM         "com"

#define DESKTOP     0           /* desktop type */
#define TOWER1      1           /* tower type */

typedef enum {  /* process status */
    CHANGERWD_STATE_INIT,           /* initialize */
    CHANGERWD_STATE_RCV,            /* wait for receive */
    CHANGERWD_STATE_ERR,            /* in error */
    CHANGERWD_STATE_SYSFAIL         /* in STSFAIL */
} changerwd_state;

/* default TTY parameters */
#define CHANGER_TTY_BAUDRATE        2400    /* baud rate */
#define CHANGER_TTY_STARTBIT        1       /* start bit */
#define CHANGER_TTY_STOPBIT         1       /* stop bit */
#define CHANGER_TTY_DATABIT         7       /* data bit */
#define CHANGER_TTY_PARTY          'E'      /* parity */

#if ACX_LOG_SPEEDUP
#define CHANGER_DRV_SPEED2400   0x30
#define CHANGER_DRV_SPEED4800   0x31
#define CHANGER_DRV_SPEED9600   0x32
#define CHANGER_DRV_SPEED19200  0x33
#define CHANGER_DRV_SPEED38400  0x34
#define CHANGER_DRV_SPEED57600  0x35
#define CHANGER_DRV_SPEED115200 0x36
#endif

#define CHANGER_DRV_BIT7        7
#define CHANGER_DRV_BIT8        8

typedef struct {    /* TTY data */
    int  count;         /* data count */
    char data[BUFSIZE]; /* data */
} snd_buf;

/* global area */
extern  int     tprx_errno;

#endif
/* End of tprdrv_changerwd.h */
