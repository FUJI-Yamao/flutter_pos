
#ifndef __changer_api_h
#define __changer_api_h

#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <termios.h>
#include <linux/input.h>
#include <sys/stat.h>
#include <errno.h>

#include <signal.h>
#include <time.h>

#define    ACX_LOG_SPEEDUP  1
#include "tprdef.h"
#include "tprdef_asc.h"
#include "tprtypes.h"
#include "tpripc.h"
#include "tprdid.h"
#include "tprmid.h"
#include "tprpipe.h"
#include "if_acx.h"
#include "tprdrv_changer.h"
#include "tprdrv_changerrd.h"
#include "tprdrv_changerwd.h"

int ChangerPortOpen(const char *pathName, int *fds, int inputSelect);
int ChangerPortClose(int fds);
int ChangerPortInit(int fds, int baudrate, int databit, int stopbit, int parity);
int ChangerDataSend(int fds, char *sndData, int sndDataLength, int mid, int tid, int src, int io);
int ChangerDataReceive(int fds, int interval, int timeout, char *rcvData, int *rcvDataLength, int *mid, int *tid, int *src, int *io, int *rcvResult);
int ChangerReceive(int fds, int interval, int timeout);

#define OK 0
#define NG -1
#define OFFLINE	-2
#define TIMEOUT	-3

/*  */
#define         SELECT_ACB_10          0
#define         SELECT_ACB_20          1
#define         SELECT_ACB_50          2
#define         SELECT_ECS             3
#define         SELECT_SST1            4
#define         SELECT_ACB_200         5
#define			SELECT_FAL2            6
#define         SELECT_RT_300          7
#define			SELECT_ECS_777         8

// debug
#define ChangerDebug 1
int	TprLibLogWriteAdd( char *add );
#define TprLibLogWrite(a,b,c,d) TprLibLogWriteAdd(d)
#if ChangerDebug
    #define LogWrite(a) TprLibLogWriteAdd(a)
#else
    #define LogWrite(a)
#endif

#endif
/* End of ChangerAPI.h */
