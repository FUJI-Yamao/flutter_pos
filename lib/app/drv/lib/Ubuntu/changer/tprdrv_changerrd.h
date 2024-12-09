#ifndef __tprdrv_changerrd_h
#define __tprdrv_changerrd_h

/* system include */

/* project include */

/* Definitions */
#define BUFSIZE     1024
#define SYS_INI     "conf/sys.ini"
#define TTYAUX      "/dev/cua"      /* (not in use) */
#define TTY         "/dev/ttyS"     /* TTY special file prefix */
#define MSGDATASIZE 1024

#define COM         "com"   /* com name index */

#ifdef DELETE
#define ACK  0x06
#define CAN  0x18
#define ETB  0x17
#define NAK  0x15
#define DC3  0x13
#define DC4  0x14
#define SUB  0x1a
#define BON  0x1c
#endif
//#define BON  FS

typedef enum {  /* ECR type */
    DESKTOP,    /* desktop */
    TOWER       /* tower */
} ecr_type;

typedef enum {                      /* process stats */
    CHANGERRD_STATE_INIT,            /* initialize */
    CHANGERRD_STATE_BYTE,            /* wait for any byte */
    CHANGERRD_STATE_STX,             /* wait for STX */
    CHANGERRD_STATE_ETX,             /* wait for ETX */
    CHNAGERRD_STATE_BCC,             /* wait for BCC */
    CHANGERRD_STATE_SYSFAIL,         /* in SYSFAIL */
    CHANGERRD_STATE_NONE             /* 受信プロセス非起動 */
} changerrd_state;

/* default com parameters */
#define CHANGER_TTY_BAUDRATE      2400      /* baudrate */
#define CHANGER_TTY_STARTBIT      1         /* start bit */
#define CHANGER_TTY_STOPBIT       1         /* stop bit */
#define CHANGER_TTY_DATABIT       7         /* data bit */
#define CHANGER_TTY_PARTY         'E'       /* party */

#define CHANGER_DRV_SPEED2400   0x30
#define CHANGER_DRV_SPEED4800   0x31
#define CHANGER_DRV_SPEED9600   0x32
#define CHANGER_DRV_SPEED19200  0x33
#define CHANGER_DRV_SPEED38400  0x34
#define CHANGER_DRV_SPEED57600  0x35
#define CHANGER_DRV_SPEED115200 0x36

#define CHANGER_DRV_BIT7        7
#define CHANGER_DRV_BIT8        8

typedef struct {    /* receive buffer */
    int           count;            /* data count */
    unsigned char data[BUFSIZE];    /* data */
} rcv_buf;

/* global area */
extern  int     tprx_errno;


#endif
/* End of tprdrv_changerrd.h */
