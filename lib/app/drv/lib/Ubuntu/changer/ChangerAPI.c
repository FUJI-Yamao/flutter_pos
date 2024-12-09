/* system include */

#include "ChangerAPI.h"

void changer_initVariable( void );
int changer_initport(int fd, int baudrate, int databit, int stopbit, int parity);
int changer_drvspdchg(int fd , int chgspd);
void changer_drvdatabitchg( int fd , int chgbit);
int changer_checkport(int fd);

int changer_main_devnotify(tprmsg_t *tprmsg);
int changer_main_devack(tprmsg_t *tprmsg);
void changer_main_tim(int signum);
int changer_devreq(int fds, tprmsg_t *tprmsg);
int changer_devack(tprmsg_t *tprmsg);
int changer_conf(int result, tprmsg_t *tprmsg);
int changer_status(int fds, tprmsg_t *tprmsg);
int changer_devnotify(tprmsg_t *tprmsg);
int changer_reply(int result, tprmsg_t *tprmsg);
int changer_nak(int fds, tprmsg_t *tprmsg_req, tprmsg_t *tprmsg_rep);
int changer_code(char code, tprmsg_t *tprmsg);
int changer_tmout( tprmsg_t *tprmsg );
int changer_SetTimer( int timeout );
int changer_ResetTimer( void );
int changer_2res_SetTimer( int timeout );
int changer_2res_ResetTimer( void );
long changer_GetTimer( char cmd );
void changer_drvspeedchg( void );
void changer_OpeSet( void );

int changerrd_resp(char data, rcv_buf *rcv_buf);
int changerrd_dle(char data, rcv_buf *rcv_buf);
int changerrd_text(char data, rcv_buf *rcv_buf);
int changerrd_stx(char data, rcv_buf *rcv_buf);
int changerrd_etx(char data, rcv_buf *rcv_buf);
int changerrd_notify(int result, rcv_buf *rcv_buf);
unsigned char changerrd_bcc(rcv_buf *rcv_buf);

int changerwd_main_devreq(int fds, tprmsg_t *tprmsg);
int changerwd_write( int fds, tprmsg_t *tprmsg );
int changerwd_conf( int result, tprmsg_t *tprmsg );
unsigned char changerwd_bcc( snd_buf *snd_buf );

#ifdef FEATURE_SYSPIPE
static  int   hSysPipe;           /* Sys task's pipe fds      */
#endif

static  int   cRetryEnq;        /* Retry send ENQ count ENQリトライ回数 */
static  short acx_enq_interval; /* mac_info.ini [acx_timer] acx_enq_interval */
static  short acx_enq_cnt;      /* mac_info.ini [acx_timer] acx_enq_timeout * 60 / acx_enq_interval */
static  short retry_enq_timer;  /* ENQ待ち時間 */
static  short retry_enq_cnt;    /* ENQリトライ回数(MAX) */

static  short ecs_recalc;       /* 1:ECS精査コマンドレスポンス待ち状態 0:その他の状態 */
static  tprmsg_t tprmsgDLESave; /* ENQレスポンス待ち状態時にコマンドレスポンスを先に受信した場合に
                                   受信データを格納するバッファ */

static	short save_data_stat;   /* 受信データ格納状態　0：格納なし　1：格納あり */
static	short pickup_flg;   	/* 1:回収コマンドレスポンス待ち　0:その他の状態 */
static	short start_flg;   	/* 入金開始コマンド後Enqチェック処理 */
static  int   save_seq_no;      /* Sequence No. */
static  short OpeSet_flg;       /* 釣銭機のOpeSet変更フラグ*/
static int selectType;
static int serial_fds;
static tprmsg_t tprmsgdevreq;
static tprmsg_t tprmsgdevrcv;
static  short drvspeedchg_flg;	/* 釣銭機の速度変更フラグ */
static  tprmsg_t tprmsg_speedchg;	/* 速度変更コマンドを受信時、リードとライトタスクに通知用バッファ*/

static changer_state state = CHANGER_STATE_INIT;
static changerrd_state rcvState = CHANGERRD_STATE_NONE;
static changerwd_state sndState = CHANGERWD_STATE_INIT;

tprmsg_t *tprmsgSave = &tprmsgdevreq;    /* save message pointer */

typedef struct {    /* tty set */
	int baudrate;	/* baurate  */
	int databit;	/* data bit */
	int stopbit;	/* stop bit */
	int parity;		/* parity   */
} tty_set;

tty_set ttySet;
TPRTID	MyDid = 0;

static char	c_log[512];

static int retry_cnt;
#if ChangerDebug
#define SEP		0x09
int	TprLibLogWriteAdd( char *add )
{
	struct timeval	t_tv;
	int		t;
	struct tm	*l;
	if(gettimeofday(&t_tv, NULL) != 0) {
		t = time(0);
		l = localtime((time_t *)&t);
		printf("%d-%02d-%02d %02d:%02d:%02d%c changer %s\n",
			l->tm_year+1900, l->tm_mon+1, l->tm_mday,/* date */
			l->tm_hour, l->tm_min, l->tm_sec,	/* time */
			SEP,					/* separate */
			add );					/* user data */
	}
	else {
		l = localtime((const time_t*)&t_tv.tv_sec);
		printf("%d-%02d-%02d %02d:%02d:%02d.%06ld%c changer %s\n",
			l->tm_year+1900, l->tm_mon+1, l->tm_mday,/* date */
			l->tm_hour, l->tm_min, l->tm_sec,	/* time */
			(long)t_tv.tv_usec,			/* msec */
			SEP,					/* separate */
			add );					/* user data */

	}
}
#else
    #define TprLibLogWriteAdd(a)
#endif
short if_acb_select()
{
	return selectType;
}
/**********************************************************************
	関数：ChangerPortOpen
	機能：デバイスオープン
    引数：const char *pathName  [IN]
        ：int *fds              [IN/OUT]
        ：int inputSelectType   [IN]
	戻値：OK(0)
		  NG(-1)
***********************************************************************/
int ChangerPortOpen(const char *pathName, int *fds, int inputSelectType)
{
	snprintf(c_log, sizeof(c_log), "%s path(%s) select(%d)", __FUNCTION__,pathName, inputSelectType);
	LogWrite(c_log);

    /* sei MID */
//    MyDid = TPRDIDCHANGER3;
    /* sei select type */
	switch(inputSelectType) {
		case    RT_300 : break;
		case    ECS_777 : break;
		default:
	        snprintf( c_log, sizeof(c_log), "ChangerPortOpen : inputSelectType error(%d)", inputSelectType);
		    LogWrite(c_log);
	        return NG;
	}
	selectType = inputSelectType;
    /* Open systask's pipe */
#ifdef FEATURE_SYSPIPE
    if ( 0 > ( hSysPipe = open ( TPRPIPE_SYS, O_RDWR ) ) ) {
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Pipe open err(sys pipe)");
        return CHANGER_NG;
    }
#endif
	if (( *fds = open ( pathName, O_RDWR )) < 0) {
        snprintf( c_log, sizeof(c_log), "ChangerPortOpen : tty driver open error[%s](%d)(%s)\n", pathName, *fds, strerror(errno) );
	    LogWrite(c_log);
        return NG;
    }
	serial_fds = *fds;
	changer_initVariable();
	return OK;
}

/**********************************************************************
	関数：ChangerPlusClose
	機能：デバイスクローズ
    引数：int fds  [IN]
	戻値：OK(0)
		  NG(-1)
***********************************************************************/
int ChangerPortClose(int fds)
{
	int ret = NG;
	snprintf(c_log, sizeof(c_log), "%s call", __FUNCTION__);
	LogWrite(c_log);
	if (state != CHANGER_STATE_INIT) {
		close(fds);
#ifdef FEATURE_SYSPIPE
        close( hSysPipe );
#endif
		state = CHANGER_STATE_INIT;
		serial_fds = -1;
		ret = OK;
	}
	return ret;
}

/**********************************************************************
	関数：ChangerPortInit
	機能：port 初期化
    引数：fds		[IN]
        ：baudrate	[IN]
        ：databit	[IN]
        ：stopbit	[IN]
        ：parity	[IN]
	戻値：OK(0)
		  NG(-1)
***********************************************************************/
int ChangerPortInit(int fds, int baudrate, int databit, int stopbit, int parity)
{
	snprintf(c_log, sizeof(c_log), "%s baudrate(%d) databit(%d) stopbit(%d) parity(%d)", __FUNCTION__, baudrate, databit, stopbit, parity);
	LogWrite(c_log);
	serial_fds = fds;
	ttySet.baudrate = baudrate;	/* baurate  */
	ttySet.databit = databit;	/* data bit */
	ttySet.stopbit = stopbit;	/* stop bit */
	ttySet.parity = parity;		/* parity   */
	if ((state == CHANGER_STATE_INIT) || (changer_initport(fds, baudrate, databit, stopbit, parity)  < 0)) {
		return NG;
	}
	
	return OK;
}


/**********************************************************************
	関数：ChangerDataSend
	機能：データ送信
    引数：fds		[IN]
        ：sndData	[IN]
        ：sndDataLength	[IN]
	戻値：0 正常終了
        ：エラーコード エラー内容に対応したコード番号
***********************************************************************/
int ChangerDataSend(int fds, char *sndData, int sndDataLength, int mid, int tid, int src, int io)
{
	tprmsgdevreq.devreq2.mid     = mid;               /* Set device id */
	tprmsgdevreq.devreq2.tid     = tid;               /* Set device id */
	tprmsgdevreq.devreq2.src     = src;               /* Set src */
	tprmsgdevreq.devreq2.io      = io;                /* Set src */
	save_seq_no                  = io;                /* Set io kind */
	if (state != CHANGER_STATE_RCV) {
		LogWrite("device is not open");
		changer_conf(CHANGER_RESULT_WRERROR, &tprmsgdevreq);
		return tprmsgdevreq.devreq2.result;
	}
	if(rcvState == CHANGERRD_STATE_NONE) {
		LogWrite("Receiving process not started");
		changer_conf(CHANGER_RESULT_WRERROR, &tprmsgdevreq);
		return tprmsgdevreq.devreq2.result;
	}
	memcpy(tprmsgdevreq.devreq2.data, sndData, sndDataLength);
	tprmsgdevreq.devreq2.datalen = sndDataLength;
	tprmsgdevreq.devreq2.result = -1;
    /* check ENQ */
    if (sndData[0] == ENQ) {    /* ENQ */
        /* get printer status */
        if (changer_status(fds, &tprmsgdevreq) < 0) {
            changer_conf(CHANGER_RESULT_WRERROR, &tprmsgdevreq);   /* confirm NG */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to get statue (ENQ)" );
			changer_initVariable();
			return tprmsgdevreq.devreq2.result;
        }
        TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] ENQ send (APL req)" );
    } else {
        start_flg  = 0;
        pickup_flg = 0;
        retry_enq_timer = 1000;
        retry_enq_cnt = 60*15*2;	/* 釣銭機をフルにして再精査すると15.06分なので、その２倍の時間リトライする*/
        if (changer_devreq(fds, &tprmsgdevreq) < 0) {
            changer_conf(CHANGER_RESULT_WRERROR, &tprmsgdevreq);   /* confirmm NG */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to device request" );
			changer_initVariable();
			return tprmsgdevreq.devreq2.result;
        }
    }
	return OK;
}
/**********************************************************************
	関数：ChangerReceive
	機能：データ（1byte）受信
    引数：fds		[IN]
        ：rcvData	[IN]
	戻値：OK(0)
		  NG(-1)
          OFFLINE(-2)
          timeout(-3)
***********************************************************************/
int ChangerReceive(int fds, int interval, int timeout)
{
	return ChangerDataReceive(fds, interval, timeout, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
}

int ChangerDataReceive(int fds, int interval, int timeout, char *rcvData, int *rcvDataLength, int *mid, int *tid, int *src, int *io, int *rcvResult)
{
	struct	timeval tmo;
	fd_set	readfds;
    char     ReadBuf[BUFSIZE];      /* read buffer */
    rcv_buf  rcv_buf;           /* receive buffer (work) */
	int		r;
	int		ret;

	snprintf(c_log, sizeof(c_log), "%s call interval(%d)  timeout(%d)", __FUNCTION__, interval, timeout);
	LogWrite(c_log);
    acx_enq_interval = interval; /* mac_info.ini [acx_timer] acx_enq_interval */
    acx_enq_cnt = timeout * 60 / acx_enq_interval;       /* mac_info.ini [acx_timer] acx_enq_timeout * 60 / acx_enq_interval */

	tprmsgdevrcv.devnotify2.result = -1;

	if (rcvState != CHANGERRD_STATE_BYTE) {
		snprintf(c_log, sizeof(c_log), "%s[%d]", __FUNCTION__, __LINE__);
		LogWrite(c_log);
		changer_conf(CHANGER_RESULT_RDERROR, &tprmsgdevrcv);
		*rcvResult = tprmsgdevrcv.devnotify2.result;
		return NG;
	}
	rcv_buf.count = 0;

	while(1) {
		FD_ZERO(&readfds);
		FD_SET(fds, &readfds);

		tmo.tv_sec = 0;
		tmo.tv_usec = 0;

		if( (select(fds+1, &readfds, (fd_set *)0, (fd_set *)0, &tmo)) < 0) {
		} else {
        	/* check device input */
            if (FD_ISSET(fds, &readfds)) {
            	if (read(fds, ReadBuf, 1) != 1) {
					continue;
                }
	            /* select input byte */
	            switch (*ReadBuf) {
	                case ACK:
	                case CAN:
	                case ETB:
	                case NAK:
	                case DC3:
	                case DC4:
	                case SUB:
	                case BON:
	                case BEL:
	                case DC2:
	                case DC1:
	                case SOH:
	                case EM:
	                case 0x7f:
	                    /* control code event */
	                    if ((r = changerrd_resp(*ReadBuf, &rcv_buf)) < 0) {
	                        LogWrite( "[changer] Failed to code process" );
	                        /* notify NG */
	                        changerrd_notify(r, &rcv_buf);
	                    }
	                    break;

	                case DLE:
	                    /* reply event */
	                    if ((r = changerrd_dle(*ReadBuf, &rcv_buf)) < 0) {
	                        LogWrite( "[changer] Failed to DLE process" );
	                        /* notify NG */
	                        changerrd_notify(r, &rcv_buf);
	                    }
	                    break;

	                case STX:
	                    /* STX event */
	                    if ((r = changerrd_stx(*ReadBuf, &rcv_buf)) < 0) {
	                        LogWrite( "[changer] Failed to STX process" );
	                        /* notify NG */
	                        changerrd_notify(r, &rcv_buf);
	                    }
	                    break;

	                case ETX:
	                    /* ETX event */
	                    if ((r = changerrd_etx(*ReadBuf, &rcv_buf)) < 0) {
	                        LogWrite( "[changer] Failed to ETX process" );
	                        /* notify NG */
	                        changerrd_notify(r, &rcv_buf);
	                    }
	                    break;

	                default:
	                    /* TEXT event */
	                    if ((r = changerrd_text(*ReadBuf, &rcv_buf)) < 0) {
	                        LogWrite( "[changer] Failed to TEXT process" );
	                        /* notify NG */
	                        changerrd_notify(r, &rcv_buf);
	                    }
	                    break;
	            }
            }
        }
		if( tprmsgdevrcv.devnotify2.result >= 0) break;
	}
	// 受信データセット
    if( mid != NULL ) *mid = tprmsgdevreq.devnotify2.mid;
    if( tid != NULL ) *tid = tprmsgdevreq.devnotify2.tid;
    if( src != NULL ) *src = tprmsgdevreq.devnotify2.src;
    if( io != NULL ) *io = tprmsgdevreq.devnotify2.io;
    if( rcvResult != NULL ) *rcvResult = tprmsgdevrcv.devnotify2.result;
    if( rcvDataLength != NULL ) *rcvDataLength = tprmsgdevrcv.devnotify2.datalen;
	if( rcvData != NULL && tprmsgdevrcv.devnotify2.datalen > 0) {   
        memcpy(rcvData, tprmsgdevrcv.devnotify2.data, tprmsgdevrcv.devnotify2.datalen);
		rcvData[tprmsgdevrcv.devnotify2.datalen] = 0;
	} else {
        if( rcvDataLength != NULL ) *rcvDataLength = 0;
	}
	changer_initVariable();
	snprintf(c_log, sizeof(c_log), "%s[%d] datalen(%d)", __FUNCTION__, __LINE__, tprmsgdevrcv.devnotify2.datalen);
	LogWrite(c_log);
	if( tprmsgdevrcv.devnotify2.result != CHANGER_RESULT_OK) {
		return NG;
	}
	return OK;
}
/**********************************************************************
	関数：ChangerSpeedChange
	機能：速度変更
    引数：fds		[IN]
        ：speed		[IN]
	戻値：OK(0)
		  NG(-1)
***********************************************************************/
int ChangerSpeedChange(int fds, int speed)
{
	snprintf(c_log, sizeof(c_log), "%s speed(%d)", __FUNCTION__, speed);
	LogWrite(c_log);
	if ((state != CHANGER_STATE_RCV) || (changer_drvspdchg(fds, speed) != CHANGER_OK)) {
		return NG;
	}
	return OK;
}
/**********************************************************************
	関数：ChangerCheckPort
	機能：ポートチェック
    引数：fds		[IN]
	戻値：OK(0)
		  NG(-1)
          OFFLINE(-2)
***********************************************************************/
int ChangerCheckPort(int fds)
{
	int ret = NG;
	snprintf(c_log, sizeof(c_log), "%s call", __FUNCTION__);
	LogWrite(c_log);
	if (state == CHANGER_STATE_RCV) {
		ret = changer_checkport(fds);
	}
	return ret;
}
/**********************************************************************
	関数：ChangerCheckBcc
	機能：BCCをチェック
    引数：data			[IN] (DLE～BCC)
        ：dataLength	[IN]
	戻値：OK(0)
		  NG(-1)
***********************************************************************/
int ChangerCheckBcc(char *data, int dataLength)
{
	int ret = NG;
    rcv_buf  rcv_buf;           /* receive buffer (work) */

	snprintf(c_log, sizeof(c_log), "%s call", __FUNCTION__);
	LogWrite(c_log);
	memcpy(rcv_buf.data, data, dataLength);
	rcv_buf.count = dataLength - 1;
	if ( changerrd_bcc(&rcv_buf) == data[dataLength-1] ) {  /* -1:BCC -2:ETX */
		ret = OK;
	}
	return ret;
}
/**********************************************************************
	内部関数
***********************************************************************/
/****************************************************************************************/
/*  関数：changer_initVariable()                                                        */
/*  機能：グローバル変数初期化。                                                        */
/*  引数: なし                                                                          */
/*  戻値: なし                                                                          */
/****************************************************************************************/
void changer_initVariable( )
{
	snprintf(c_log, sizeof(c_log), "%s", __FUNCTION__);
	LogWrite(c_log);
	state = CHANGER_STATE_RCV;
	rcvState = CHANGERRD_STATE_BYTE;
    sndState = CHANGERWD_STATE_RCV;

	memset(&tprmsg_speedchg, 0, sizeof(tprmsg_speedchg));
	drvspeedchg_flg = 0;
	OpeSet_flg = 0;
    ecs_recalc = 0;
	drvspeedchg_flg = 0;
	save_data_stat = 0;
	pickup_flg = 0;
    memset(&tprmsgDLESave, 0, sizeof(tprmsgDLESave));

    /* Flag initialize */
    cRetryEnq = 0;

	acx_enq_interval = 3;                                  // mac_info.iniで設定
    acx_enq_cnt = 30 * 60 / acx_enq_interval;              // mac_info.iniで設定
	
    changer_ResetTimer();   /* release timer */
    changer_2res_ResetTimer();   /* release 2res_timer */

}

/******************************************************************
 *  Usage : int changer_initport(int fd)
 *      fd : device file descriptor
 *      baudrate : 1200,2400,4800,9600,19200,38400
 *      databit  : 7:7bit,8:8bit
 *      stopbit  : 1:1bit,2:2bit
 *      parity   : 0:NONE,1:EVEN,2:ODD
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : initialize tty
 ******************************************************************/
int changer_initport(int fd, int baudrate, int databit, int stopbit, int parity)
{
	struct  termios tty;        /* tty structure */

	int     r = 0;
	int     speed = -1;         /* baude rate code */
    int     swflow = 0;         /* XONOFF */
    int     mcs = 0;            /* register */

    /* set TTY parameters */
    /* select baudrate */
    switch (baudrate) {
        case 1200:
            speed = B1200;
            break;

        case 2400:
            speed = B2400;
            break;

        case 4800:
            speed = B4800;
            break;

        case 9600:
            speed = B9600;
            break;

        case 19200:
            speed = B19200;
            break;

        case 38400:
            speed = B38400;
            break;

        default:
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "changer_initport Unknown baudrate" );
            return CHANGER_NG;
    }

#if ACX_LOG_SPEEDUP
	if(drvspeedchg_flg != 0)
	{
		TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "changer_initport DrvSpeedChangeflg ON" );
		speed = drvspeedchg_flg;
	}
#endif

    /* get tty attribute */
    if (tcgetattr(fd, &tty) < 0) {
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] fail to tcgetattr" );
        return CHANGER_NG;
    }
    /* setup output speed */
    cfsetospeed(&tty, (speed_t)speed);
    /* setup input speed */
    cfsetispeed(&tty, (speed_t)speed);

	if(OpeSet_flg != 0)
	{
		TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] DrvdatabitChangeflg ON" );
		databit = OpeSet_flg;
	}

    /* select data bit */
    switch (databit) {
        case 7:
            tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS7;
            break;

        case 8:
        default:
            tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;
            break;
    }

    /* Set into raw, no echo mode */
    tty.c_iflag =  IGNBRK;
    tty.c_lflag = 0;
    tty.c_oflag = 0;
    tty.c_cflag |= CLOCAL | CREAD;
    tty.c_cc[VMIN] = 1;
    tty.c_cc[VTIME] = 5;

    /* set XONOFF = alway OFF */
    if (swflow)
        tty.c_iflag |= IXON | IXOFF;
    else
        tty.c_iflag &= ~(IXON|IXOFF|IXANY);

    /* set parity */
    tty.c_cflag &= ~(PARENB | PARODD);
    if (parity == 1)
        tty.c_cflag |= PARENB;
    else if (parity == 2)
        tty.c_cflag |= (PARENB | PARODD);

    /* set stop bit */
    if (stopbit == 2)
        tty.c_cflag |= CSTOPB;
    else
        tty.c_cflag &= ~CSTOPB;

    /* setup attribute */
    if (tcsetattr(fd, TCSANOW, &tty) < 0) {
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "changer_initport fail to tcsetattr" );
        return CHANGER_NG;
    }

    /* set tty READY (DTR ON) */
    if( ioctl(fd, TIOCMGET, &mcs) < 0 ) { /* get mcs */
        snprintf( c_log, sizeof(c_log), "changer_initport ioctl error[%s]", strerror(errno) );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
        return CHANGER_NG;
    }
    mcs |= TIOCM_DTR;
    if( ioctl(fd, TIOCMSET, &mcs) < 0 ) { /* set msc */
        snprintf( c_log, sizeof(c_log), "changer_initport ioctl error[%s]", strerror(errno) );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
        return CHANGER_NG;
    }

    /* set tty ONLINE (RTS ON) */
    if( ioctl(fd, TIOCMGET, &mcs) < 0 ) { /* get mcs */
        snprintf( c_log, sizeof(c_log), "changer_initport ioctl error[%s]", strerror(errno) );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
        return CHANGER_NG;
    }
    mcs |= TIOCM_RTS;
    if( ioctl(fd, TIOCMSET, &mcs) < 0 ) { /* set mcs */
        snprintf( c_log, sizeof(c_log), "changer_initport ioctl error[%s]", strerror(errno) );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
        return CHANGER_NG;
    }
    return r;
}
/****************************************************************************************/
/*  関数：changerrd_drvspdchg()                                                         */
/*  機能：ドライバの速度変更処理、chgspdの値により速度を変更する。                      */
/*  引数：int fd , int chgspd                                                           */
/*  戻値：正常：0、異常：-1                                                             */
/****************************************************************************************/
int changer_drvspdchg( int fd , int chgspd)
{
	int     r = 0;          // return
	struct  termios tty;    // tty structure
	int speed = -1;
 
	/* 通信速度変更 */
	if (chgspd == CHANGER_DRV_SPEED115200)
	{
		speed = B115200;
		drvspeedchg_flg = speed;
	}
	else if (chgspd == CHANGER_DRV_SPEED57600)
	{
		speed = B57600;
		drvspeedchg_flg = speed;
	}
	else if (chgspd == CHANGER_DRV_SPEED38400)
	{
		speed = B38400;
		drvspeedchg_flg = speed;
	}
	else if (chgspd == CHANGER_DRV_SPEED19200)
	{
		speed = B19200;
		drvspeedchg_flg = speed;
	}
	else if (chgspd == CHANGER_DRV_SPEED9600)
	{
		speed = B9600;
		drvspeedchg_flg = speed;
	}
	else if (chgspd == CHANGER_DRV_SPEED4800)
	{
		speed = B4800;
		drvspeedchg_flg = speed;
	}
	else if (chgspd == CHANGER_DRV_SPEED2400)
	{
		speed = B2400;
		drvspeedchg_flg = speed;
	}
	else
	{
		speed = B9600;
		drvspeedchg_flg = 0;
	}

	// get TTY attribute
	if(tcgetattr( fd, &tty) < 0 )
	{
		TprLibLogWrite( MyTid, TPRLOG_ERROR, -1, "[changerrd] drvspdchg tcgetattr() error" );
		return( CHANGER_NG );
	}

	// set output speed
	cfsetospeed(&tty, (speed_t)speed);
	// set input speed
	cfsetispeed(&tty, (speed_t)speed);
	// setup TTY attribute
	if(tcsetattr( fd, TCSANOW, &tty) < 0 )
	{
		TprLibLogWrite( MyTid, TPRLOG_ERROR, -1, "[changerrd] drvspdchg tcsetattr() error" );
		return  ( CHANGER_NG );
	}

	snprintf( c_log, sizeof(c_log), "changer_drvspdchg %x", chgspd );
	TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log);

	return r;
}
/****************************************************************************************/
/*  関数：changerrd_drvdatabitchg()                                                     */
/*  機能：ドライバのレコード長、chgbitの値により速度を変更する。                        */
/*  引数：int fd , int chgbit                                                           */
/*  戻値：                                                                              */
/****************************************************************************************/
void changer_drvdatabitchg( int fd , int chgbit)
{
	struct  termios tty;        /* tty structure */

	snprintf( c_log, sizeof(c_log), "[changerrd] drvdatabitchg %d", chgbit );
	TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log);

	switch (chgbit) {
		case 7:
			OpeSet_flg = 7;
			tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS7;
			break;

		case 8:
			OpeSet_flg = 8;
			tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;
			break;
		default:
			OpeSet_flg = 0;
			break;

	}

}

/*
 *  Usage : int changer_checkport(int fd)
 *  
 *  sDrvIni : ini file path
 *      fd : device file descriptor
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : initialize tty
 */
int changer_checkport(int fd)
{
    int cts;        /* CTS */
    int mcs = 0;    /* parameter */

    /* check online */
    /* get mcs */
    if( ioctl(fd, TIOCMGET, &mcs) < 0 )  /* get mcs */
    {
        snprintf( c_log, sizeof(c_log), "[changer_checkport] ioctl error[%s]", strerror(errno) );
        LogWrite( c_log );
        return CHANGER_OFFLINE;
    }
    /* get CTS */
    cts = mcs & TIOCM_CTS ? 1 : 0;
 
    if (cts)
        return CHANGER_OK;
    else
        return CHANGER_OFFLINE;
}

/********************************************************************************************************************************************************************
     changer
********************************************************************************************************************************************************************/
/*
 *  Usage : int changer_main_devnotify( tprmsg_t *tprmsg )
 *  Function : 釣銭機からのデータ Data from device
 */

int changer_main_devnotify(tprmsg_t *tprmsg)
{
    int r = CHANGER_OK;
    changer_ResetTimer();   /* release timer */

    if(( tprmsgDLESave.devnotify2.datalen > 0 )&&(save_data_stat)){
        changer_2res_ResetTimer();   /* release 2res_timer */
    }

//    tprmsg->devnotify2.src = src; /* Spec-N001 */
    /* check NAK */
    if( (tprmsg->devnotify2.data[0] == NAK)    /* NAK */
      ||(tprmsg->devnotify2.data[0] == BEL)) { /* BEL */
        /* NAK process */
        if (changer_nak(serial_fds, tprmsgSave, tprmsg) < 0) {
            changer_reply(CHANGER_RESULT_RDERROR, tprmsgSave);  /* reply NG */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to NAK recovery" );
            r = CHANGER_NG;
        }
    } else {
        /* normal reply */
        if (changer_devnotify(tprmsg) < 0) {
            changer_reply(CHANGER_RESULT_RDERROR, tprmsg);  /* reply for AP */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to device notify" );
            r = CHANGER_NG;
        }
    }
	return r;
}
/*
 *  Usage : void changer_main_devack( tprmsg_t *tprmsg )
 *  Function : Ack from changer write task
 */

int changer_main_devack(tprmsg_t *tprmsg)
{
    int r = CHANGER_OK;
    /* check ACK */
//    tprmsg->devack2.src = src; /* Spec-N001 */

    if (changer_devack(tprmsg) < 0) {
        changer_reply(CHANGER_RESULT_RDERROR, tprmsg);  /* reply NG */
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to device ack" );
    	r = CHANGER_NG;
    }
	return r;
}
/*
 *  Usage : void changer_main_tim( int signum )
 *  Function : タイムアウト通知 Timer expierd
 */
void changer_main_tim(int signum)
{
	tprmsg_t *tprmsg = tprmsgSave;
	
	snprintf(c_log, sizeof(c_log), "called %s signum(%d)", __FUNCTION__, signum);
	LogWrite(c_log);
	if( signum == SIGALRM) {
        TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] timeout\n" );
        if(( tprmsgDLESave.devnotify2.datalen > 0 )&&(save_data_stat)){
            changer_ResetTimer();   /* release timer */
            changer_2res_ResetTimer();   /* release 2res_timer */
        }
//        tprmsgSave->devack2.src = src; /* Spec-N001 */

        if(( tprmsgDLESave.devnotify2.datalen > 0 )&&(save_data_stat)){
        /* check NAK */
            if( (tprmsgdevrcv.devnotify2.data[0] == NAK)    /* NAK */
                ||(tprmsgdevrcv.devnotify2.data[0] == BEL)) { /* BEL */
                /* NAK process */
                if (changer_nak(serial_fds, tprmsgSave, tprmsg) < 0) {
                    changer_reply(CHANGER_RESULT_RDERROR, tprmsgSave);  /* reply NG */
                    TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to NAK recovery" );
                }
            }
            else if (changer_devnotify(tprmsg) < 0) {
                changer_reply(CHANGER_RESULT_RDERROR, tprmsg);  /* reply for AP */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to device notify" );
            }
        }
        /* timeout process */
        else if (changer_tmout(tprmsgSave) < 0) {
            save_data_stat = 0;
            changer_reply(CHANGER_RESULT_WRERROR, tprmsgSave);  /* reply NG */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Fail to time out" );
        }
	}
}
/*
 *  Usage : int changer_devreq( tprmsg_t *tprmsg )
 *      tprmsg : request message.
 *  Functions : devreq event process
 */
int changer_devreq(int fds, tprmsg_t *tprmsg)
{
    int r = CHANGER_OK;
	int ret;
    long    timer;

    /* state select */
    switch (state) {
        case CHANGER_STATE_INIT:    /* initial */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devreq CHANGER_STATE_INIT" );
            r = CHANGER_NG;
            break;

        case CHANGER_STATE_RCV:     /* wait for receive */
            start_flg  = 0;
            pickup_flg = 0;
            if ( ( if_acb_select() & ACB_20_X            ) &&	/* ACB-20以降釣銭機 */
                 (tprmsg->devreq2.data[1] == ACR_CINSTART) ){	/* 入金開始コマンド */
                //timerはdefaultセット
                start_flg = 1;
            }

            //タイムアウト値はwrite遅延問題への安全策のため、retry_enq_cnt x retry_enq_timer + GetTimer が５秒以上になるようにすること
            if (tprmsg->devreq2.data[1] == ECS_RECALC)  {	/* 精査コマンド(ECS) */
                retry_enq_timer = 1000;
                retry_enq_cnt = 60*15*2;	/* 釣銭機をフルにして再精査すると15.06分なので、その２倍の時間リトライする*/
            }
            else if ( (tprmsg->devreq2.data[1] == ACR_PICKUP ) ||	/* 回収コマンド(ACX) */
                      (tprmsg->devreq2.data[1] == ECS_PICKUP ) ) {	/* 回収コマンド(ECS) */
                retry_enq_timer = acx_enq_interval * 1000;
                retry_enq_cnt = acx_enq_cnt;
                pickup_flg = 1;
            } else if ( tprmsg->devreq2.data[1] == ECS_CINEND) {	/* 入金終了コマンド */
                retry_enq_timer = 1000;
                retry_enq_cnt = 60*7;
            } else if ( (tprmsg->devreq2.data[1] == ACR_COINOUT) ||     /* 金額指定放出コマンド */
                        (tprmsg->devreq2.data[1] == ACR_SPECOUT) ||     /* 枚数指定放出コマンド */
                        (tprmsg->devreq2.data[1] == ECS_COINOUT6DIGIT) ||     /* 金額指定放出6桁コマンド */
                        (tprmsg->devreq2.data[1] == SST1_CINCANCEL)) {  /* 入金キャンセルコマンド */
                retry_enq_timer = 2000;
				if(tprmsg->devreq2.data[1] == ACR_SPECOUT)	/* 枚数指定放出コマンド */
				{
			                //釣機払出（金種別登録する）を回収の代わりに使用してPOS前から離れ、貨幣をタイムアウトまで取らずに放置する運用をされることによる問い合わせが複数あったため(2018/05/01)
			                retry_enq_cnt = (30 - 1) * 5;
				}
				else if( if_acb_select() & ECS_X )
				{
					//富士電機は出金硬貨判定が行われ、一度入金->再出金という処理が発生することがあるため（メーカー指定のタイムアウト値）
					retry_enq_cnt = (30 - 1) * 3;
				}
				else
				{
					retry_enq_cnt = (30 - 1);
				}
            } else if ( (! ( if_acb_select() & SST1                 )) &&	/* NEC釣銭機でない */
                        (( tprmsg->devreq2.data[1] == ACR_CINREAD   ) ||	/* 計数データリードコマンド */
                         ( tprmsg->devreq2.data[1] == ACR_INSPECT   ) ||	/* 精査コマンド */
                         ( tprmsg->devreq2.data[1] == ACR_STATEREAD ) ||	/* 状態リードコマンド */
                         ( tprmsg->devreq2.data[1] == ECS_CINREAD   ) ||	/* 入金枚数コマンド */
                         ( tprmsg->devreq2.data[1] == ECS_STATEREAD )) ) {	/* 詳細状態リードココマンド */
                /* 非動作系のデータ読込関連コマンドはリトライ短くてよい */
                /* ただし、NEC釣銭機は状態遷移が遅いため除く */
                retry_enq_timer = 1000;
                retry_enq_cnt = 4;
            } else {
                retry_enq_timer = 1000;
                retry_enq_cnt = 10;
            }

            if ( (tprmsg->devreq2.data[0] &  0x99) == SST1_CONNECTON ) { /* モードリセット */
                retry_enq_timer = 1000;
                retry_enq_cnt = 25;
            }
#if ACX_LOG_SPEEDUP
			if((if_acb_select() & ECS_X) && (tprmsg->devreq2.data[1] == ECS_SPEEDCHG))
			{
				TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devreq ECS SpeedChageCommand");
				drvspeedchg_flg = 1;
				memcpy(&tprmsg_speedchg , tprmsg , sizeof(tprmsg_speedchg));
			}
#endif
			if((if_acb_select() & ECS_X) /* 設定がECS */
				&& (tprmsg->devreq2.data[1] == ECS_OPESET))  /* 動作条件設定コマンド */
			{
				if((tprmsg->devreq2.datalen == 10) && (tprmsg->devreq2.data[4] == 0x3c))  /* 標準仕様 モードC */
				{
					TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devreq ECS OpeSet modeC");
					OpeSet_flg = 1;
					memcpy(&tprmsg_speedchg , tprmsg , sizeof(tprmsg_speedchg));
				}
				else if((tprmsg->devreq2.datalen == 18) && (tprmsg->devreq2.data[4] == 0x30) && (tprmsg->devreq2.data[5] == 0x3c))	/* 拡張仕様 モードC */
				{
					TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devreq ECS OpeSet Expansion modeC");
					OpeSet_flg = 1;
					memcpy(&tprmsg_speedchg , tprmsg , sizeof(tprmsg_speedchg));
				}
			}

            cRetryEnq = 0;

            /* forward to write task */
            if(start_flg != 2)	//入金開始コマンドとENQをセットで送信する場合のENQではseq_noをsaveしない
               save_seq_no = tprmsg->devreq2.io;   /* Set io kind  */
              if ((ret = changerwd_main_devreq(fds, tprmsg)) < 0) {
                  r = CHANGER_NG;
                  snprintf( c_log, sizeof(c_log), "[changer] changer_devreq write error[%d]", ret );
                  TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );

                  /* state not changed */
                  break;
              }
            
				/* 2013/11/05:再精査も他コマンドと同様にドライバにてENQを投げるよう修正 */
                timer = changer_GetTimer( tprmsg->devreq2.data[1] );
                /* request timer */
                if (changer_SetTimer( timer ) < 0) {
                    r = CHANGER_NG;

                    /* state not changed */
                    break;
                }
            
                state = CHANGER_STATE_REPLY;
                snprintf( c_log, sizeof(c_log), "[changer] changer_devreq state set CHANGER_STATE_REPLY cmd[%x]", tprmsg->devreq2.data[1] );
                TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
            break;

        case CHANGER_STATE_REPLY:   /* wait for reply */
        case CHANGER_STATE_ENQ:     /* wait for remind */
        case CHANGER_STATE_RETRY:   /* in retry */
        case CHANGER_STATE_STATUS:  /* wait for reply status */
            snprintf( c_log, sizeof(c_log), "[changer] changer_devreq CHANGER_RESULT_BUSY state[%d]", state );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
            if (changer_conf(CHANGER_RESULT_BUSY, tprmsg) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                break;
            }
            /* state not changed */
            break;

        case CHANGER_STATE_SYSFAIL: /* in SYSFAIL */
            /* nothing to do */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devreq CHANGER_STATE_SYSFAIL" );
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_devreq state[%d] error", state );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            break;
    }

    return r;
}

/*
 *  Usage : int changer_devack( tprmsg_t *tprmsg )
 *      tprmsg : request message.
 *  Functions : devack event process
 */
int changer_devack(tprmsg_t *tprmsg)
{
    int r = CHANGER_OK;     /* return */
    int result = 0;         /* result */

    /* select state */
    switch (state) {
        case CHANGER_STATE_INIT:    /* initial */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devack CHANGER_STATE_INIT" );
            r = CHANGER_NG;
            break;

        case CHANGER_STATE_RCV:     /* wait for receive */
#if 0
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devack CHANGER_STATE_RCV" );
#endif
            /* nothing to do */
            break;

        case CHANGER_STATE_REPLY:   /* wait for reply */
            if (tprmsg->devack2.result != TPRDEVRESULTOK) {
                changer_ResetTimer();   /* release timer */
                /* select result */
                switch (tprmsg->devack2.result) {
                    case TPRDEVRESULTOFFLINE:   /* OFFLINE */
                        result = CHANGER_RESULT_OFFLINE;
#if ACX_LOG_SPEEDUP
						if(drvspeedchg_flg == 1)
						{
							TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devack OFFLINE drvspeedchg_flg = 1" );
							changer_drvspeedchg();
							drvspeedchg_flg = 0;
						}
#endif
                        break;

                    case TPRDEVRESULTPWOFF:     /* POWER OFF */
                        result = CHANGER_RESULT_POWEROFF;
                        break;

                    case TPRDEVRESULTWERR:      /* WRITE ERROR */
                        result = CHANGER_RESULT_WRERROR;
                        break;

                    default:
                        snprintf( c_log, sizeof(c_log), "[changer] changer_devack CHANGER_STATE_REPLY result[%d]", tprmsg->devack2.result );
                        TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                        break;
                }
                /* confirm */
                if (changer_conf(result, tprmsg) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    break;
                }

                state = CHANGER_STATE_RCV;
            }
            else {
#if 0
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] changer_devack CHANGER_STATE_REPLY OK? " );
#endif
            }
            break;

        case CHANGER_STATE_ENQ:     /* wait for remind */
            if (tprmsg->devack2.result != TPRDEVRESULTOK) {
                changer_ResetTimer();   /* release timer */
                /* select result */
                switch (tprmsg->devack2.result) {
                    case TPRDEVRESULTOFFLINE:   /* OFFLINE */
                        result = CHANGER_RESULT_OFFLINE;
                        break;

                    case TPRDEVRESULTPWOFF:     /* POWER OFF */
                        result = CHANGER_RESULT_POWEROFF;
                        break;

                    case TPRDEVRESULTWERR:      /* WRITE ERROR */
                        result = CHANGER_RESULT_WRERROR;
                        break;

                    default:
                        snprintf( c_log, sizeof(c_log), "[changer] changer_devack CHANGER_STATE_ENQ result[%d]", tprmsg->devack2.result );
                        TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                        break;
                }
                /* confirm */
                if (changer_conf(result, tprmsg) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    break;
                }

                state = CHANGER_STATE_RCV;
            }
            else {
#if 0
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] changer_devack CHANGER_STATE_ENQ OK? " );
#endif
            }
            break;

        case CHANGER_STATE_RETRY:   /* in retry */
            if (tprmsg->devack2.result != TPRDEVRESULTOK) {
                changer_ResetTimer();   /* release timer */
                /* select result */
                switch (tprmsg->devack2.result) {
                    case TPRDEVRESULTOFFLINE:   /* OFFLINE */
                        result = CHANGER_RESULT_OFFLINE;
                        break;

                    case TPRDEVRESULTPWOFF:     /* POWER OFF */
                        result = CHANGER_RESULT_POWEROFF;
                        break;

                    case TPRDEVRESULTWERR:      /* WRITE ERROR */
                        result = CHANGER_RESULT_WRERROR;
                        break;

                    default:
                        snprintf( c_log, sizeof(c_log), "[changer] changer_devack CHANGER_STATE_RETRY result[%d]", tprmsg->devack2.result );
                        TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                        break;
                }
                /* confirm */
                if (changer_conf(result, tprmsg) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    break;
                }

                state = CHANGER_STATE_RCV;
            }
            else {
#if 0
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] changer_devack CHANGER_STATE_RETRY OK? " );
#endif
            }
            break;

        case CHANGER_STATE_STATUS:  /* wait for status reply */
            if (tprmsg->devack2.result != TPRDEVRESULTOK) {
                changer_ResetTimer();   /* release timer */
                switch (tprmsg->devack2.result) {
                    case TPRDEVRESULTOFFLINE:   /* OFFLINE */
                        result = CHANGER_RESULT_OFFLINE;
                        break;

                    case TPRDEVRESULTPWOFF:     /* POWER OFF */
                        result = CHANGER_RESULT_POWEROFF;
                        break;

                    case TPRDEVRESULTWERR:      /* WRITE ERROR */
                        result = CHANGER_RESULT_WRERROR;
                        break;

                    default:
                        snprintf( c_log, sizeof(c_log), "[changer] changer_devack CHANGER_STATE_STATUS result[%d]", tprmsg->devack2.result );
                        TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                        break;
                }
                /* confirm */
                if (changer_conf(result, tprmsg) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    break;
                }

                state = CHANGER_STATE_RCV;
            }
            else {
#if 0
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] changer_devack CHANGER_STATE_STATUS OK? " );
#endif
            }
            break;

        case CHANGER_STATE_SYSFAIL: /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devack CHANGER_STATE_SYSFAIL" );
            /* nothing to do */
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_devack state[%d] error", state );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            break;
    }

    return r;
}

/*
 *  Usage : int changer_conf( int result, tprmsg_t *tprmsg )
 *      tprmsg : request message.
 *      result : result
 *  Functions :  confirm process
 */
int changer_conf(int result, tprmsg_t *tprmsgReq)
{
    int r = CHANGER_OK;         /* return */
    int         length, ret;    /* message size, write result */
    char        WriteBuf[sizeof(tprmsg_t)];         /* Data Write buffer */
    tprmsg_t    *tprmsgAck = (tprmsg_t *)WriteBuf;  /* ack message */

    /* Make device notify message for protocol driver   */
                            /* Calc. length of cmd and data part */
    length = 0;
    memset(WriteBuf, 0, sizeof(tprmsg_t));

    tprmsgAck->devack2.datalen = tprmsgReq->devreq2.datalen;  /* set datalen */
    length += sizeof( uint );                           /* + sizeof datalen */
	/* select result */
    switch (result) {
        case CHANGER_RESULT_OK:         /* result OK */
            tprmsgAck->devack2.result = TPRDEVRESULTOK;
            break;

        case CHANGER_RESULT_OFFLINE:    /* result OFFLINE */
            tprmsgAck->devack2.result = TPRDEVRESULTOFFLINE;
            break;

        case CHANGER_RESULT_POWEROFF:   /* result POWER OFF */
            tprmsgAck->devack2.result = TPRDEVRESULTPWOFF;
            break;

        case CHANGER_RESULT_WRERROR:    /* result WRITE ERROR */
            tprmsgAck->devack2.result = TPRDEVRESULTWERR;
            break;

        case CHANGER_RESULT_RDERROR:    /* result READ ERROR */
            tprmsgAck->devack2.result = TPRDEVRESULTRERR;
            break;
            
        case CHANGER_RESULT_BUSY:       /* result BUSY */
            tprmsgAck->devack2.result = TPRDEVRESULTEERR;
            break;
            
        case CHANGER_RESULT_GIVEUP:     /* result giveup retry */
            tprmsgAck->devack2.result = TPRDEVRESULTGIVEUP;
            break;

        case CHANGER_RESULT_TMOUT:      /* result timeup */
            tprmsgAck->devack2.result = TPRDEVRESULTTIMEOUT;
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_conf result[%d]", result );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
            break;
    }
    tprmsgReq->devreq2.result = tprmsgAck->devack2.result;
    length += sizeof( int );                            /* + sizeof result */

    tprmsgAck->devack2.io     = save_seq_no;            /* Set Sequence No.  */
    length += sizeof( int );                            /* + sizeof io */

    tprmsgAck->devack2.src    = tprmsgReq->devreq2.src;   /* Set src  */
    length += sizeof( TPRTID );                            /* + sizeof src */

    tprmsgAck->devack2.tid    = tprmsgReq->devreq2.tid;   /* Set device id */
    length += sizeof( TPRDID );                         /* + sizeof tid */

    tprmsgAck->devack2.length = length;                  /* set length */
    length += sizeof( int );                            /* + sizeof length */

    tprmsgAck->devack2.mid = TPRMID_DEVACK;              /* Set message id */
    length += sizeof( TPRMID );                         /* + sizeof mid */

    length += 4;

	/* send to SYS */
#ifdef FEATURE_SYSPIPE
    if ( ( ret = write( hSysPipe, tprmsgAck, length ) ) != length )
    {
        snprintf( c_log, sizeof(c_log), "[changer] changer_conf write error[%d:%s]", errno, strerror(errno) );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
        r = CHANGER_NG;
    }
    else
#endif
    {
		r = CHANGER_OK;
    }

    return r;
}


/*
 *  Usage : int changer_status( tprmsg_t *tprmsg )
 *      tprmsg : request message.
 *  Functions : status request process
 */
int changer_status(int fds, tprmsg_t *tprmsg)
{
    int r = CHANGER_OK;     /* return */

    /* select statue */
    switch (state) {
        case CHANGER_STATE_INIT:    /* initial */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_status CHANGER_STATE_INIT" );
            r = CHANGER_NG;
            break;

        case CHANGER_STATE_RCV:     /* wait for receive */
            if(start_flg != 2)	//入金開始コマンドとENQをセットで送信する場合のENQではseq_noをsaveしない
               save_seq_no = tprmsg->devreq2.io;   /* Set io kind  */
            if (changerwd_main_devreq(fds, tprmsg) < 0) {
                r = CHANGER_NG;

                snprintf( c_log, sizeof(c_log), "[changer] changer_status write error[%d]", errno );
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
                /* state not changed */
                break;
            }
            /* request timer */
            if (changer_SetTimer(TIMER_ENQ) < 0) {
                r = CHANGER_NG;

                /* state not changed */
                break;
            }

            state = CHANGER_STATE_STATUS;
            break;

        case CHANGER_STATE_REPLY:   /* wait for reply */
        case CHANGER_STATE_ENQ:     /* wait for remind */
        case CHANGER_STATE_RETRY:   /* in retry */
        case CHANGER_STATE_STATUS:  /* wait for status reply */
            snprintf( c_log, sizeof(c_log), "[changer] changer_status CHANGER_RESULT_BUSY state[%d]", state );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
            /* confirm BUSY */
            if (changer_conf(CHANGER_RESULT_BUSY, tprmsg) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                break;
            }
            /* state not changed */
            break;

        case CHANGER_STATE_SYSFAIL: /* in SYSFAIL */
            /* nothing to do */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_status CHANGER_STATE_SYSFAIL" );
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_status state[%d] error", state );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            break;
    }

    return r;
}

/*
 *  Usage : int changer_devnotify( tprmsg_t *tprmsg )
 *      tprmsg : request message.
 *  Functions : devnotify event process
 */
int changer_devnotify(tprmsg_t *tprmsg)
{
    int r = CHANGER_OK;     /* return */
    int result = 0;         /* result */

     /* chenge result code */
     switch (tprmsg->devnotify2.result) {
        case TPRDEVRESULTOFFLINE:   /* OFFLINE */
            result = CHANGER_RESULT_OFFLINE;
            break;

        case TPRDEVRESULTPWOFF:     /* POWER OFF */
            result = CHANGER_RESULT_POWEROFF;
            break;

        case TPRDEVRESULTWERR:      /* WRITE ERROR */
            result = CHANGER_RESULT_WRERROR;
            break;

        case TPRDEVRESULTRERR:      /* READ ERROR */
            result = CHANGER_RESULT_RDERROR;
            break;

        case TPRDEVRESULTEERR:      /* BUSY */
            result = CHANGER_RESULT_BUSY;
            break;

        case TPRDEVRESULTGIVEUP:    /* GIVEUP RETRY */
            result = CHANGER_RESULT_GIVEUP;
            break;

        case TPRDEVRESULTTIMEOUT:   /* TIMEOUT */
            result = CHANGER_RESULT_TMOUT;
            break;

        default:
            break;
    }
    /* select state */
    switch (state) {
        case CHANGER_STATE_INIT:    /* initial */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] changer_devnotify CHANGER_STATE_INIT" );
            r = CHANGER_NG;
            break;

        case CHANGER_STATE_RCV:     /* wait for receive */
            if (ecs_recalc) {     /* 精査コマンド(ECS)レスポンス待ち状態 */
                if (tprmsg->devnotify2.result == TPRDEVRESULTOK) {
                    result = TPRDEVRESULTOK;
                }
                if (changer_reply(result, tprmsg) < 0) {
                    r = CHANGER_NG;

                    break;
                }
                ecs_recalc = 0;
            }
            /* state not changed */
            break;

        case CHANGER_STATE_REPLY:   /* wait for reply */
            if(( tprmsgDLESave.devnotify2.datalen > 1               ) || /* 一つめが電文レスポンス */
               ((tprmsg->devnotify2.datalen < 2) && (save_data_stat)) ){ /* 二つめが電文レスポンスでない datalen 0:タイムアウト時(二つめなし) 1:1バイトレス */
            /* コマンド > コマンド > レスポンス > レスポンス という処理順になった場合の一つめレスポンスLoad条件 */
                snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify return_savedata[%d] ",tprmsgDLESave.devnotify2.data[0]  );
                TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                memcpy(tprmsg, &tprmsgDLESave, sizeof(tprmsgDLESave));
                memset(&tprmsgDLESave, 0, sizeof(tprmsgDLESave));
                save_data_stat = 0;
            }
            else if ( tprmsgDLESave.devnotify2.datalen > 0 ){
            /* save_dataがある場合のクリア */
                snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify return_data[%d] ",tprmsg->devnotify2.data[0]  );
                TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                memset(&tprmsgDLESave, 0, sizeof(tprmsgDLESave));
                save_data_stat = 0;
            }

            if(start_flg == 1) {
                memcpy(&tprmsgDLESave, tprmsg, sizeof(tprmsgDLESave));
                snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify enq save_data[%d] ",tprmsg->devnotify2.data[0]  );
                TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                /* send ENQ (remind) */
                start_flg = 2; //ENQ送信
                if (changer_code(ENQ, tprmsg) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    return r;
                }
                /* request timer */
                if (changer_SetTimer(TIMER_ENQ) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    return r;
                }

                start_flg = 3; //ENQレスポンス待ち
                state = CHANGER_STATE_ENQ;
                break;
            }
#if ACX_LOG_SPEEDUP
			if((if_acb_select() & ECS_X) && (tprmsg->devnotify2.data[0] == ACK) && (drvspeedchg_flg == 1))
			{
				TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devnotify changer_drvspeedchg" );
				changer_drvspeedchg();
				drvspeedchg_flg = 0;
			}
#endif
			if((if_acb_select() & ECS_X) && (tprmsg->devnotify2.data[0] == ACK) && (OpeSet_flg == 1))
			{
				TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devnotify changer_OpeSet_flg ON" );
				changer_OpeSet();
				OpeSet_flg = 0;
			}


            if (tprmsg->devnotify2.result == TPRDEVRESULTOK) {
                result = TPRDEVRESULTOK;
            }
            if (changer_reply(result, tprmsg) < 0) {
                r = CHANGER_NG;
            }
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devnotify end" );
            state = CHANGER_STATE_RCV;
            break;

        case CHANGER_STATE_ENQ: /* wait for remind */
            if(start_flg == 3) {
                changer_ResetTimer();   /* release timer */
                start_flg  = 0;
				if(tprmsg->devnotify2.data[0] == SOH){
                   snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify enq OK return_savedata[%d] ",tprmsgDLESave.devnotify2.data[0]  );
                   TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                   memcpy(tprmsg, &tprmsgDLESave, sizeof(tprmsgDLESave));
                   memset(&tprmsgDLESave, 0, sizeof(tprmsgDLESave));
                   if (changer_reply(CHANGER_RESULT_OK, tprmsg) < 0) {
                       r = CHANGER_NG;

                       state = CHANGER_STATE_RCV;
                       break;
                   }
                }
                else{
                   snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify enq NG return_savedata[%d] ",tprmsgDLESave.devnotify2.data[0]  );
                   TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                   memcpy(tprmsg, &tprmsgDLESave, sizeof(tprmsgDLESave));
                   memset(&tprmsgDLESave, 0, sizeof(tprmsgDLESave));
                   if (changer_reply(CHANGER_RESULT_WRERROR, tprmsg) < 0) {
                       r = CHANGER_NG;

                       state = CHANGER_STATE_RCV;
                       break;
                   }
                }

                state = CHANGER_STATE_RCV;
                break;
            }
            if(pickup_flg == 1) {  /* 回収コマンドレスポンス待ち */
//                memcpy(&TS_BUF->acx.pick_status[0], &tprmsg->devnotify2.data[0], 1);	//ENQのレスポンスをセット
            }
            if(( tprmsg->devnotify2.datalen > 1 ) ||	/* 電文レスポンス */
              ( tprmsg->devnotify2.data[0] == ACK ) ||
              ( tprmsg->devnotify2.data[0] == CAN ) ||
              ( tprmsg->devnotify2.data[0] == ETB ) ||
              ( tprmsg->devnotify2.data[0] == NAK ) ||
              ( tprmsg->devnotify2.data[0] == BEL ) ||
              ( tprmsg->devnotify2.data[0] == FS )) {
            /* コマンド > コマンド > レスポンス > レスポンス という処理順になった場合の一つめレスポンスSave条件 */
                memcpy(&tprmsgDLESave, tprmsg, sizeof(tprmsgDLESave));
                snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify save_data[%d] ",tprmsg->devnotify2.data[0]  );
                TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
                save_data_stat = 1;
                changer_2res_SetTimer(1000);

            }
            else {
//                if((pCom->ini_macinfo.pick_end == 1)) {  /* 回収作業終了待ち しない */
//                if((pCom->ini_macinfo.pick_end == 1)&&(pickup_flg == 1)) {  /* 回収作業終了待ち しない & 回収コマンドレスポンス待ち */
                if((pickup_flg == 1)) {  /* 回収コマンドレスポンス待ち */
                    if( tprmsg->devnotify2.data[0] == DC2 ) {
                        if (tprmsg->devnotify2.result == TPRDEVRESULTOK) {
                            result = TPRDEVRESULTOK;
                        }
                        if (changer_reply(result, tprmsg) < 0) {
                            r = CHANGER_NG;
                        }
                        state = CHANGER_STATE_RCV;
                        break;
                    }
                }
            }
            /* request timer */
            if (changer_SetTimer(retry_enq_timer) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                break;
            }
            state = CHANGER_STATE_REPLY;
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devnotify state = CHANGER_STATE_REPLY\n" );
            break;

        case CHANGER_STATE_RETRY:
#if ACX_LOG_SPEEDUP
			// state CHANGER_STATE_RETRYのみで処理させる
			if((if_acb_select() & ECS_X) && (tprmsg->devnotify2.data[0] == ACK) && (drvspeedchg_flg == 1))
			{
				TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devnotify changer_drvspeedchg");
				changer_drvspeedchg();
				drvspeedchg_flg = 0;
			}
			/* No break */
#endif
        case CHANGER_STATE_STATUS:
            snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify tprmsg[%d] ",tprmsg->devnotify2.data[0]  );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
            if (tprmsg->devnotify2.result == TPRDEVRESULTOK) {
                result = TPRDEVRESULTOK;
            }
            if (changer_reply(result, tprmsg) < 0) {
                r = CHANGER_NG;
            }
            state = CHANGER_STATE_RCV;
            break;
        case CHANGER_STATE_SYSFAIL:
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_devnotify CHANGER_STATE_SYSFAIL" );
            /* nothing to do */
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_devnotify state[%d] error", state );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            break;
    }

    return r;
}

/*
 *  Usage : int changer_reply( int result, tprmsg_t *tprmsg )
 *      tprmsg : request message.
 *      result : result
 *  Functions : reply process
 */
int changer_reply(int result, tprmsg_t *tprmsgNotify)
{
    int         r = CHANGER_OK;     /* return */
    int         length = 0;         /* message length */
    char        Type[32];
    char        VerCtrl[32];
    char        VerCoin[32];
    char        VerBill[32];
    char        *p;
    tprmsg_t    *tprmsgAck = &tprmsgdevrcv;  /* ack message */

    /* Make device notify message for protocol driver   */
    /* check result */
    if (result == CHANGER_RESULT_OK) {
        /* set datalen */
        tprmsgAck->devack2.datalen = tprmsgNotify->devnotify2.datalen;
        /* set reply data */
        memcpy(tprmsgAck->devack2.data, tprmsgNotify->devnotify2.data, tprmsgNotify->devnotify2.datalen);
    } else {
        tprmsgAck->devack2.datalen = 0;
    }

    length += sizeof( uint );                            /* + sizeof datalen */

    switch (result) {
        case CHANGER_RESULT_OK:         /* OK */
            tprmsgAck->devack2.result = TPRDEVRESULTOK;
            break;

        case CHANGER_RESULT_OFFLINE:    /* OFFLINE */
            tprmsgAck->devack2.result = TPRDEVRESULTOFFLINE;
            break;

        case CHANGER_RESULT_POWEROFF:   /* POWER OFF */
            tprmsgAck->devack2.result = TPRDEVRESULTPWOFF;
            break;

        case CHANGER_RESULT_WRERROR:    /* WRITE ERROR */
            tprmsgAck->devack2.result = TPRDEVRESULTWERR;
            break;

        case CHANGER_RESULT_RDERROR:    /* READ ERROR */
            tprmsgAck->devack2.result = TPRDEVRESULTRERR;
            break;
            
        case CHANGER_RESULT_BUSY:       /* BUSY */
            tprmsgAck->devack2.result = TPRDEVRESULTEERR;
            break;
            
        case CHANGER_RESULT_GIVEUP:     /* GIVEUP RETRY */
            tprmsgAck->devack2.result = TPRDEVRESULTGIVEUP;
            break;

        case CHANGER_RESULT_TMOUT:      /* TIMEOUT */
            tprmsgAck->devack2.result = TPRDEVRESULTTIMEOUT;
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_devreply result[%d]", result );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
           break;
    }
	tprmsgNotify->devnotify2.result = tprmsgAck->devack2.result;
    length += sizeof( int );                            /* + sizeof result */

//    tprmsgAck->devack2.io     = tprmsgNotify->devnotify2.io;  /* Set io kind  */
    tprmsgAck->devack2.io     = save_seq_no;            /* Set Sequence No.  */
    length += sizeof( int );                            /* + sizeof io */

    tprmsgAck->devack2.src    = tprmsgNotify->devnotify2.src; /* Set src  */
    length += sizeof( TPRTID );                            /* + sizeof src */

    tprmsgAck->devack2.tid    = tprmsgNotify->devnotify2.tid; /* Set device id */
    length += sizeof( TPRDID );                         /* + sizeof tid */

    tprmsgAck->devack2.length = length;
    length += sizeof( int );                            /* + sizeof length */

    tprmsgAck->devack2.mid = TPRMID_DEVACK;              /* Set message id */
    length += sizeof( TPRMID );                         /* + sizeof mid */

    /* send to SYS */
#ifdef FEATURE_SYSPIPE
    if ( write( hSysPipe, tprmsgAck, length ) != length ) {
        snprintf( c_log, sizeof(c_log), "[changer] changer_reply write error[%d]", errno );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
        return CHANGER_NG;
    }
#endif

    return r;
}


/*
 *  Usage : int changer_nak( tprmsg_t *tprmsg_req, tprmsg_t tprmsg_rep )
 *      tprmsg_req : request message.
 *      tprmsg_rep : reply message.
 *  Functions : nak event process
 */
int changer_nak(int fds, tprmsg_t *tprmsg_req, tprmsg_t *tprmsg_rep)
{
    int r = CHANGER_OK;     /* return */

    /* select state */
    switch (state) {
        case CHANGER_STATE_INIT:    /* initial */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_nak CHANGER_STATE_INIT" );
            r = CHANGER_NG;
            break;

        case CHANGER_STATE_RCV:     /* wait for receive */
            if (changer_reply(CHANGER_RESULT_OK, tprmsg_rep) < 0)
                r = CHANGER_NG;
            break;

        case CHANGER_STATE_REPLY:   /* wait for reply */
		    retry_cnt = 1;
            /* send retry to write task */
            if(start_flg != 2)	//入金開始コマンドとENQをセットで送信する場合のENQではseq_noをsaveしない
               save_seq_no = tprmsg_req->devreq2.io;   /* Set io kind  */
            if (changerwd_main_devreq(fds, tprmsg_req) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                snprintf( c_log, sizeof(c_log), "[changer] changer_nak write error[%d]", errno );
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
                break;
            }
            /* request timer */
            if (changer_SetTimer(TIMER_NAK) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                break;
            }

            state = CHANGER_STATE_RETRY;
            break;

        case CHANGER_STATE_ENQ:     /* wait for remind */
            /* reply */
            if (changer_reply(CHANGER_RESULT_OK, tprmsg_rep) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                break;
            }

            state = CHANGER_STATE_RCV;
            break;

        case CHANGER_STATE_RETRY:   /* in retry */
            retry_cnt++;     /* update retry counter */
            /* check retr counter */
            if (retry_cnt > MAXRETRYCNT) {   /* retry over */
				if((drvspeedchg_flg != 0) && (tprmsg_req->devreq2.data[1] == ECS_SPEEDCHG))
				{
					TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_nak acx.retry_cnt > MAXRETRYCNT drvspeedchg_flg = 0" );
					drvspeedchg_flg = 0;
				}
				if( (tprmsg_req->devreq2.data[1] == ECS_OPESET)
					&& (tprmsg_req->devreq2.data[4] == 0x3c)
					&& (OpeSet_flg != 0) )
				{
					TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_nak acx.retry_cnt > MAXRETRYCNT OpeSet_flg = 0" );
					OpeSet_flg = 0;
				}
                /* reply */
                if (changer_reply(CHANGER_RESULT_GIVEUP, tprmsg_rep) < 0) {
                    r = CHANGER_NG;
                    
                    state = CHANGER_STATE_RCV;
                    break;
                }

                state = CHANGER_STATE_RCV;
            }
            else {                        /* retry */
                /* send retry to write task */
                if(start_flg != 2)	//入金開始コマンドとENQをセットで送信する場合のENQではseq_noをsaveしない
                  save_seq_no = tprmsg_req->devreq2.io;   /* Set io kind  */
//                if (write(hDrvWrPipe, &tprmsg_req->devreq, sizeof(tprcommon_t) + tprmsg_req->devreq2.length) < 0) {
                if (changerwd_main_devreq(fds, tprmsg_req) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    snprintf( c_log, sizeof(c_log), "[changer] changer_nak retry write error[%d]", errno );
                    TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
                    break;
                }
                /* request timer */
                if (changer_SetTimer(TIMER_NAK) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    break;
                }

                /* state = CHANGER_STATE_RETRY; */
            }
            break;

        case CHANGER_STATE_STATUS:  /* wait for reply status */
            /* reply */
            if (changer_reply(CHANGER_RESULT_OK, tprmsg_rep) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                break;
            }

            state = CHANGER_STATE_RCV;
            break;

        case CHANGER_STATE_SYSFAIL: /* in SYSFAIL */
            /* nothing to do */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_nak CHANGER_STATE_SYSFAIL" );
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_nak state[%d] error", state );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            break;
    }

    return r;
}

/*
 *  Usage : int changer_code( char code, tprmsg_t *tprmsg )
 *      tprmsg : request code message.
 *  Functions :  send code
 */
int changer_code(char code, tprmsg_t *tprmsgReq)
{
    int         r = CHANGER_OK;         /* return */
    int         length, ret;            /* message length, write result */
    char        WriteBuf[sizeof(tprmsg_t)];         /* Data Write buffer */
    tprmsg_t    *tprmsgTmp = (tprmsg_t *)WriteBuf;  /* tmp message */

    TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "changer_code" );
    /* Make device notify message for protocol driver   */
                            /* Calc. length of cmd and data part */
    length = 0;
    memset(WriteBuf, 0, sizeof(WriteBuf));

    tprmsgTmp->devreq2.data[0] = code;   /* set code */
    length += 1;

    tprmsgTmp->devreq2.datalen = tprmsgReq->devreq2.datalen;  /* set datalen */
    length += sizeof( uint );                           /* + sizeof datalen */


    length += sizeof( int );                            /* + sizeof result */

    tprmsgTmp->devreq2.io    = tprmsgReq->devreq2.io;   /* Set io kind  */
    length += sizeof( int );                            /* + sizeof io */

    tprmsgTmp->devreq2.src   = tprmsgReq->devreq2.src;  /* Set src */
    length += sizeof( TPRTID );                         /* + sizeof src */

    tprmsgTmp->devreq2.tid   = tprmsgReq->devreq2.tid;  /* Set device id */
    length += sizeof( TPRDID );                         /* + sizeof tid */

    tprmsgTmp->devreq2.length = length;                 /* set length */
    length += sizeof( int );                            /* + sizeof length */

    tprmsgTmp->devreq2.mid = TPRMID_DEVREQ;             /* Set message id */
    length += sizeof( TPRMID );                         /* + sizeof mid */

    /* send to write task */
    if(start_flg != 2)	//入金開始コマンドとENQをセットで送信する場合のENQではseq_noをsaveしない
       save_seq_no = tprmsgTmp->devreq2.io;   /* Set io kind  */
    if ( ( ret = changerwd_main_devreq(serial_fds, tprmsgTmp) ) < 0 )
	{
        r = CHANGER_NG;
        snprintf( c_log, sizeof(c_log), "[changer] changer_code write error[%d]", errno );
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
    }
    else
        r = CHANGER_OK;

    return r;
}

/*
 *  Usage : int changer_tmout( tprmsg_t *tprmsg )
 *      tprmsg   : Pointer to receive message
 *  Functions : Manage communication timeout
 */
int changer_tmout( tprmsg_t *tprmsg )
{
    int r = CHANGER_OK;     /* return */

    /* select state */
    switch (state) {
        case CHANGER_STATE_INIT:    /* initial */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_tmout CHANGER_STATE_INIT" );
            r = CHANGER_NG;
            break;

        case CHANGER_STATE_RCV:     /* wait for receive */
            /* nothing to do */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_tmout CHANGER_STATE_RCV" );
            break;

        case CHANGER_STATE_REPLY:   /* wait for reply */
            if( cRetryEnq > retry_enq_cnt ) {
                TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] retry end"  );
                state = CHANGER_STATE_RCV;
                /* reply NG */
                if (changer_code(EOT, tprmsg) < 0) {
                    r = CHANGER_NG;
                    return r;
                }

                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] changer_tmout retry error" );
                if (changer_reply(CHANGER_RESULT_TMOUT, tprmsg) < 0) {
                    r = CHANGER_NG;
                    return r;
                }
            } else {
                cRetryEnq++;
                /* send ENQ (remind) */
                if (changer_code(ENQ, tprmsg) < 0) {
                    r = CHANGER_NG;

                    state = CHANGER_STATE_RCV;
                    return r;
                }
                /* request timer */
                if (changer_SetTimer(TIMER_ENQ) == 0) {
                    state = CHANGER_STATE_ENQ;
                    snprintf( c_log, sizeof(c_log), "[changer] retry[%d/%d]", cRetryEnq, retry_enq_cnt );
                    TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
				    if(OpeSet_flg == 1)
				    {
					    TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_tmout OpeSet_flg = 1" );
					    changer_OpeSet();
					    OpeSet_flg = 0;
				    }
				    if(drvspeedchg_flg == 1)
				    {   
					   TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_tmout drvspeedchg_flg = 1" );
					   changer_drvspeedchg();
					   drvspeedchg_flg = 0;
				    }       

                } else {
                    r = CHANGER_NG;
                    
                    state = CHANGER_STATE_RCV;
                }
            }
            break;

        case CHANGER_STATE_ENQ:     /* wait for remind */
            /* send EOT */
            if (changer_code(EOT, tprmsg) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                return r;
            }
            /* reply TIMEOUT */
            if (changer_reply(CHANGER_RESULT_TMOUT, tprmsg) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                return r;
            }

            state = CHANGER_STATE_RCV;
            break;

        case CHANGER_STATE_RETRY:   /* in retry */
            /* send ENQ (remind) */
            if (changer_code(ENQ, tprmsg) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                return r;
            }
            /* request timer */
            if (changer_SetTimer(TIMER_ENQ) < 0) {
                r = CHANGER_NG;
                
                state = CHANGER_STATE_RCV;
                return r;
            }

            state = CHANGER_STATE_ENQ;
            break;

        case CHANGER_STATE_STATUS:  /* wait for reply status */
            /* reply TIMEOUT */
            if (changer_reply(CHANGER_RESULT_TMOUT, tprmsg) < 0) {
                r = CHANGER_NG;

                state = CHANGER_STATE_RCV;
                return r;
            }

            state = CHANGER_STATE_RCV;
            break;

        case CHANGER_STATE_SYSFAIL: /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changer] changer_tmout CHANGER_STATE_SYSFAIL" );
            /* nothing to do */
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changer] changer_tmout state[%d] error", state );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            break;
    }

    return r;
}

    timer_t tid1;
    timer_t tid2;
    struct sigaction act, oldact;
    struct sigaction act2, oldact2;
int changer_SetTimer( int timeout )
{
    int ret = OK;   /* return */
	int i;
    struct itimerspec itval;
 
    changer_ResetTimer();   /* release timer */
	snprintf(c_log, sizeof(c_log), "%s timeout(%d)", __FUNCTION__, timeout);
	LogWrite(c_log);

    memset(&act, 0, sizeof(struct sigaction));
    memset(&oldact, 0, sizeof(struct sigaction));
 
    // シグナルハンドラの登録
    act.sa_handler = changer_main_tim;
    act.sa_flags = SA_RESTART;
    if(sigaction(SIGALRM, &act, &oldact) < 0) {
		snprintf(c_log, sizeof(c_log), "%s sigaction() error", __FUNCTION__);
		LogWrite(c_log);
        return NG;
    }
 
    // タイマ割り込みを発生させる
	itval.it_value.tv_sec = timeout / 1000;     // 秒に変更
	itval.it_value.tv_nsec = (timeout % 1000) * 1000000;
    itval.it_interval.tv_sec = itval.it_value.tv_sec;
    itval.it_interval.tv_nsec = itval.it_value.tv_nsec;

    // タイマの作成
    if(timer_create(CLOCK_REALTIME, NULL, &tid1) < 0) {
		snprintf(c_log, sizeof(c_log), "%s timer_create error", __FUNCTION__);
		LogWrite(c_log);
        return NG;
    }

    //  タイマのセット
    if(timer_settime(tid1, 0, &itval, NULL) < 0) {
		snprintf(c_log, sizeof(c_log), "%s timer_settime error", __FUNCTION__);
		LogWrite(c_log);
        return NG;
    }
   return( ret );
}
/*-------------------------------------------------------------------------*
 *	関数: changer_ResetTimer()
 *  Functions : Reset timer #1
 *
 *	引数: なし
 *	戻値: なし
 *-------------------------------------------------------------------------*/
int changer_ResetTimer( void )
{
    int ret = OK;   /* return */
	snprintf(c_log, sizeof(c_log), "%s", __FUNCTION__);
	LogWrite(c_log);

	// タイマの解除
    timer_delete(tid1);
 
    // シグナルハンドラの解除
    sigaction(SIGALRM, &oldact, NULL);

    return( ret );
}


/*
 *  Usage : int changer_2res_SetTimer( int timeout )
 *      timeout : Timeout value in ms.
 *  Functions : 
 */
int changer_2res_SetTimer( int timeout )
{
    int ret = OK;   /* return */
    struct itimerspec itval;

	snprintf(c_log, sizeof(c_log), "%s timeout(%d)", __FUNCTION__, timeout);
	LogWrite(c_log);


    if (! ( if_acb_select() & ACB_20_X ) ){	/* ACB-20以降釣銭機 */
       return( ret );
    }

    memset(&act2, 0, sizeof(struct sigaction));
    memset(&oldact2, 0, sizeof(struct sigaction));
 
    // シグナルハンドラの登録
    act2.sa_handler = changer_main_tim;
    act2.sa_flags = SA_RESTART;
    if(sigaction(SIGALRM, &act2, &oldact2) < 0) {
		snprintf(c_log, sizeof(c_log), "%s sigaction() error", __FUNCTION__);
		LogWrite(c_log);
        return NG;
    }
 
    // タイマ割り込みを発生させる
    itval.it_value.tv_sec = timeout / 1000;     // 秒に変更
	itval.it_value.tv_nsec = (timeout % 1000) * 1000000;
    itval.it_interval.tv_sec = 0;
    itval.it_interval.tv_nsec = 0;

    // タイマの作成
    if(timer_create(CLOCK_REALTIME, NULL, &tid2) < 0) {
		snprintf(c_log, sizeof(c_log), "%s timer_create error", __FUNCTION__);
		LogWrite(c_log);
        return NG;
    }

    //  タイマのセット
    if(timer_settime(tid2, 0, &itval, NULL) < 0) {
		snprintf(c_log, sizeof(c_log), "%s timer_settime error", __FUNCTION__);
		LogWrite(c_log);
        return NG;
    }
    return( ret );
}

/*
 *  Usage : int changer_2res_ResetTimer( void )
 *  Functions : 
 */
int changer_2res_ResetTimer( void )
{
    int ret = OK;   /* return */

	snprintf(c_log, sizeof(c_log), "%s", __FUNCTION__);
	LogWrite(c_log);

    if (! ( if_acb_select() & ACB_20_X ) ){	/* ACB-20以降釣銭機 */
       return( ret );
    }

	// タイマの解除
    timer_delete(tid2);
 
    // シグナルハンドラの解除
    sigaction(SIGALRM, &oldact2, NULL);

    return( ret );
}


/*
 *  Usage : long changer_GetTimer( char cmd )
 *      char cmd   : Command
 *  Functions : Send timer get
 */
long    changer_GetTimer( char cmd )
{//このタイムアウトにてENQ送信を行う
    long timer;

    if( if_acb_select() & ECS_X )
    {
        switch( cmd )
        {
            case ECS_CINEND:   timer = 1000;         break;
            case ECS_OPESET:   timer = 10000;        break;
                               //釣札機offlineにて釣札機への設定送信を行うと約10秒かかる場合あり
//            case ECS_RECALC:   timer = 0;            break;
            case ECS_RECALC:   timer = 1000;            break;
	    /* ダウンロード開始コマンド→レスポンス（釣銭機内の処理）には4[s]ほど時間がかかる */
	    case ECS_DOWNLOAD:			timer = 5000;   break;
	    case ECS_PROGRAMLOAD:		timer = 5000;	break;
            default:           timer = TIMER_REQ;    break;
        }
    }
    else
    {
        timer = TIMER_REQ;
    }
    return( timer );
}

/****************************************************************************************/
/*  関数：changer_drvspeedchg( void )                                                   */
/*  機能：リードとライトタスクにドライバの速度を変更通知する処理。                      */
/*  引数：                                                                              */
/*  戻値：                                                                              */
/****************************************************************************************/
void changer_drvspeedchg( void )
{

	tprmsg_speedchg.sysnotify.mid = TPRMID_SYSNOTIFY;
	tprmsg_speedchg.sysnotify.length = sizeof( tprsysnotify_t ) - sizeof( tprcommon_t );
	switch(tprmsg_speedchg.devnotify2.data[4])
	{
		case 0x36:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED115200;
			break;
		case 0x35:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED57600;
			break;
		case 0x34:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED38400;
			break;
		case 0x33:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED19200;
			break;
		case 0x32:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED9600;
			break;
		case 0x31:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED4800;
			break;
		case 0x30:
			tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_SPEED2400;
			break;
		default:
			TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changer] Unknown baudrate" );
			return;
	}

	snprintf( c_log, sizeof(c_log), "[changer] changer_drvspeedchg %lx", tprmsg_speedchg.sysnotify.mode );
	TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );

	changer_drvspdchg(serial_fds , tprmsg_speedchg.sysnotify.mode );
}

/****************************************************************************************/
/*  関数：changer_OpeSet( void )                                                        */
/*  機能：リードとライトタスクにドライバのレコード長を変更通知する処理。                */
/*  引数：                                                                              */
/*  戻値：                                                                              */
/****************************************************************************************/
void changer_OpeSet( void )
{
	int	pos;

	tprmsg_speedchg.sysnotify.mid = TPRMID_SYSNOTIFY;
	tprmsg_speedchg.sysnotify.length = sizeof( tprsysnotify_t ) - sizeof( tprcommon_t );

	if(tprmsg_speedchg.devnotify2.datalen == 10)		// 標準仕様
	{
		pos = 7;
	}
	else if(tprmsg_speedchg.devnotify2.datalen == 18)	// 拡張仕様
	{
		pos = 8;
	}

	if(tprmsg_speedchg.devnotify2.data[pos] == 0x00)
	{
		tprmsg_speedchg.sysnotify.mode = 0;
	}
	else if(tprmsg_speedchg.devnotify2.data[pos] < 0x3A) /* レコード長が7 */
	{
		tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_BIT7;
	}
	else
	{
		tprmsg_speedchg.sysnotify.mode = CHANGER_DRV_BIT8;
        }

	snprintf( c_log, sizeof(c_log), "[changer] changer_OpeSet %lx", tprmsg_speedchg.sysnotify.mode );
	TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );

	changer_drvdatabitchg(serial_fds , tprmsg_speedchg.sysnotify.mode );
}


/********************************************************************************************************************************************************************
     changerrd
********************************************************************************************************************************************************************/

/*
 *  Usage : int changerrd_resp(char data, rcv_buf *rcv_buf)
 *      data : received data
 *      rcv_buf : received data buffer
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : response code event handler
 */
int changerrd_resp(char data, rcv_buf *rcv_buf)
{
    int           r = 0;    /* return */

    /* select rcvState */
    switch (rcvState) {
        case CHANGERRD_STATE_BYTE:  /* wait for an any byte */
            memset(rcv_buf->data, 0, sizeof(rcv_buf->data));
            rcv_buf->data[0] = data;    /* set code */
            rcv_buf->count = 1;         /* set data size */
            /* notify */
            if (changerrd_notify(CHANGER_RESULT_OK, rcv_buf) < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] Fail to notify" );
                /* r = CHANGER_RESULT_RDERROR; */
            }
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, rcv_buf->data, rcv_buf->count);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_STX:   /* wait for STX */
            r = CHANGER_RESULT_RDERROR;
            rcvState = CHANGERRD_STATE_BYTE;
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_resp CHANGERRD_STATE_STX" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_ETX:   /* wait for ETX */
            r = CHANGER_RESULT_RDERROR;
            rcvState = CHANGERRD_STATE_BYTE;
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_resp CHANGERRD_STATE_ETX" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHNAGERRD_STATE_BCC:   /* wait for BCC */
            changer_ResetTimer();   /* release timer */
            /* check BCC */
            if (data != changerrd_bcc(rcv_buf)) {   /* bad BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc error" );
                r = CHANGER_RESULT_RDERROR;
            }
            else {  /* legal BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc success" );
                r = CHANGER_RESULT_OK;
            }
            /* notify */
            if (changerrd_notify(r, rcv_buf) < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] Fail to notify" );
            }
            rcvState = CHANGERRD_STATE_BYTE;
#if CHANGERRD_LOGWRITE
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, rcv_buf->data, rcv_buf->count);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_SYSFAIL:   /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_resp CHANGER_STATE_SYSFAIL" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_resp rcvState[%d] error", rcvState );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;
    }

    return r;
}

/*
 *  Usage : int changerrd_dle(char data, rcv_buf *rcv_buf)
 *      data : received data
 *      rcv_buf : receive data buffer
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : DLE code event handler
 */
int changerrd_dle(char data, rcv_buf *rcv_buf)
{
    int           r = 0;        /* return */

    /* select rcvState */
    switch (rcvState) {
        case CHANGERRD_STATE_BYTE:  /* wait for any byte */
#ifdef DELETE
            memset(rcv_buf->data, 0, sizeof(rcv_buf->data));
            rcv_buf->count = 0;
#endif
            memset(rcv_buf->data, 0, sizeof(rcv_buf->data));
            rcv_buf->count = 0;
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
            rcvState = CHANGERRD_STATE_STX;
            break;

        case CHANGERRD_STATE_STX:   /* wait for STX */
        case CHANGERRD_STATE_ETX:   /* wait for ETX */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_dle bcc state stx/etx" );
            rcvState = CHANGERRD_STATE_BYTE;
            r = changerrd_dle(data, rcv_buf);
            break;

        case CHNAGERRD_STATE_BCC:   /* wait for BCC */
            changer_ResetTimer();   /* release timer */
            /* check BCC */
            if (data != changerrd_bcc(rcv_buf)) {   /* bad BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc error" );
                r = CHANGER_RESULT_RDERROR;
            }
            else {  /* legal BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc success" );
                r = CHANGER_RESULT_OK;
            }
            /* notify */
            if (changerrd_notify(r, rcv_buf) < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] Fail to notify" );
            }
            rcvState = CHANGERRD_STATE_BYTE;
#if CHANGERRD_LOGWRITE
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, rcv_buf->data, rcv_buf->count);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_SYSFAIL:   /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_dle CHANGERRD_STATE_SYSFAIL" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_dle rcvState[%d] error", rcvState );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;
    }

    return r;
}

/*
 *  Usage : intchangerrd_text(char data, rcv_buf *rcv_buf) 
 *      data : received data
 *      rcv_buf : receive data buffer
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : TEXT event handler
 */
int changerrd_text(char data, rcv_buf *rcv_buf)
{
    int           r = 0;        /* return */

    /* select rcvState */
    switch (rcvState) {
        case CHANGERRD_STATE_BYTE:  /* wait for any byte */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_text CHANGERRD_STATE_BYTE" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            r = CHANGER_RESULT_RDERROR;
            break;

        case CHANGERRD_STATE_STX:   /* wait for STX */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_text CHANGERRD_STATE_STX" );
            r = CHANGER_RESULT_RDERROR;
            rcvState = CHANGERRD_STATE_BYTE;
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_ETX:   /* wait for ETX */
            /* check ascii (non coherent mode) */
            if (!isascii((int)data)) {  /* not ASCII */
                r = CHANGER_RESULT_RDERROR;
                rcvState = CHANGERRD_STATE_BYTE;
                snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_text not ascii[%02x]", data );
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
            }
            else {  /* regal TEXT (ASCII) */
                /* stock a byte */
                rcv_buf->data[rcv_buf->count] = data;
                rcv_buf->count += 1;    /* update count */
            }
            break;

        case CHNAGERRD_STATE_BCC:   /* wait for BCC */
            changer_ResetTimer();   /* release timer */
            /* check BCC */
            if (data != changerrd_bcc(rcv_buf)) {   /* bad BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc error" );
                r = CHANGER_RESULT_RDERROR;
            }
            else {  /* legal BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc success" );
                r = CHANGER_RESULT_OK;
            }
            /* notify */
            if (changerrd_notify(r, rcv_buf) < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] Fail to notify" );
            }
            rcvState = CHANGERRD_STATE_BYTE;
#if CHANGERRD_LOGWRITE
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, rcv_buf->data, rcv_buf->count);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_SYSFAIL:   /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_text CHANGERRD_STATE_SYSFAIL" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_text rcvState[%d] error", rcvState );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;
    }

    return r;
}

/*
 *  Usage : int changerrd_stx(char data, rcv_buf *rcv_buf)
 *      data : received data
 *      rcv_buf : receive data buffer
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : ETX code event handler
 */
int changerrd_stx(char data, rcv_buf *rcv_buf)
{
    int           r = 0;        /* return */

    /* select rcvState */
    switch (rcvState) {
        case CHANGERRD_STATE_BYTE:  /* wait for any byte */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_stx CHANGERRD_STATE_BYTE" );
            r = CHANGER_RESULT_RDERROR;
            break;

        case CHANGERRD_STATE_STX:   /* wait for STX */
            /* initialize receive buffer */
#if 0
            memset(rcv_buf->data, 0, sizeof(rcv_buf->data));
            rcv_buf->count = 0; /* TEXT to begin */
#endif
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */

            rcvState = CHANGERRD_STATE_ETX;
            break;

        case CHANGERRD_STATE_ETX:   /* wait for ETX */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_stx CHANGERRD_STATE_ETX" );
            r = CHANGER_RESULT_RDERROR;
            rcvState = CHANGERRD_STATE_BYTE;
            break;

        case CHNAGERRD_STATE_BCC:   /* wait for BCC */
            changer_ResetTimer();   /* release timer */
            /* check BCC */
            if (data != changerrd_bcc(rcv_buf)) {   /* bad BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc error" );
                r = CHANGER_RESULT_RDERROR;
            }
            else {  /* legal BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc success" );
                r = CHANGER_RESULT_OK;
            }
            /* notify */
            if (changerrd_notify(r, rcv_buf) < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] Fail to notify" );
            }
            rcvState = CHANGERRD_STATE_BYTE;
#if CHANGERRD_LOGWRITE
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, rcv_buf->data, rcv_buf->count);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_SYSFAIL:   /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_stx CHANGERRD_STATE_SYSFAIL" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_stx rcvState[%d] error", rcvState );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;
    }

    return r;
}
/*
 *  Usage : int changerrd_etx(char data, rcv_buf *rcv_buf)
 *      data : received data
 *      rcv_buf : receive data buffer
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : ETX code event handler
 */
int changerrd_etx(char data, rcv_buf *rcv_buf)
{
    int           r = 0;        /* return */

    /* select rcvState */
    switch (rcvState) {
        case CHANGERRD_STATE_BYTE:  /* wait for any byte */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_etx CHANGERRD_STATE_BYTE" );
            r = CHANGER_RESULT_RDERROR;
            break;

        case CHANGERRD_STATE_STX:   /* wait for STX */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_etx CHANGERRD_STATE_STX" );
            r = CHANGER_RESULT_RDERROR;
            rcvState = CHANGERRD_STATE_BYTE;
            break;

        case CHANGERRD_STATE_ETX:   /* wait for ETX */
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
            rcvState = CHNAGERRD_STATE_BCC;
            break;

        case CHNAGERRD_STATE_BCC:   /* wait for BCC */
            changer_ResetTimer();   /* release timer */
            /* check BCC */
            if (data != changerrd_bcc(rcv_buf)) {   /* bad BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc error" );
                r = CHANGER_RESULT_RDERROR;
            }
            else {  /* legal BCC */
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] changerrd_etx bcc success" );
                r = CHANGER_RESULT_OK;
            }
            /* notify */
            if (changerrd_notify(r, rcv_buf) < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerrd] Fail to notify" );
            }
            rcvState = CHANGERRD_STATE_BYTE;
#if CHANGERRD_LOGWRITE
            rcv_buf->data[rcv_buf->count] = data;
            rcv_buf->count += 1;    /* update count */
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, rcv_buf->data, rcv_buf->count);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        case CHANGERRD_STATE_SYSFAIL:   /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, "[changerrd] changerrd_etx CHANGERRD_STATE_SYSFAIL" );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_etx rcvState[%d] error", rcvState );
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, c_log );
#if CHANGERRD_LOGWRITE
	    acx_res_write = TS_BUF->acx.acx_res_write;
            cm_rs232c_log_write(RS232C_ACX, RS232C_RCV, &data, 1);
            TS_BUF->acx.acx_res_write = acx_res_write;
#endif
            break;
    }

    return r;
}

/*
 *  Usage : int changerrd_notify(int result, rcv_buf *rcv_buf)
 *      result : receive result
 *      rcv_buf : received data
 *  Return :  0 = Normal End
 *           -1 = Error
 *  Functions : notify for driver task
 */
int changerrd_notify(int result, rcv_buf *rcv_buf)
{
    int         r = 0;      /* return */
    int         length = 0; /* message length */
    tprmsg_t    *tprmsg;    /* message */

    /* Make device notify message for protocol driver   */
    tprmsg = &tprmsgdevrcv;

    tprmsg->devnotify2.datalen = 0;

    /* check result */
    if (result == CHANGER_RESULT_OK) {    /* OK */
        /* set data */
        memset(tprmsg->devnotify2.data, 0, sizeof(tprmsg->devnotify2.data));
        if(rcv_buf->data[0] == DLE) {
            memcpy(tprmsg->devnotify2.data, &rcv_buf->data[2], rcv_buf->count-2);
            length += rcv_buf->count-2;   /* set count */
        }
        else {
            memcpy(tprmsg->devnotify2.data, rcv_buf->data, rcv_buf->count);
            length += rcv_buf->count;   /* set count */
        }
        tprmsg->devnotify2.datalen = length;
    }
    length += sizeof( uint );                           /* + sizeof datalen */

    /* select result */
    switch (result) {
        case CHANGER_RESULT_OK:       /* OK */
            tprmsg->devnotify2.result = TPRDEVRESULTOK;
            break;

        case CHANGER_RESULT_OFFLINE:  /* OFFLINE */
            tprmsg->devnotify2.result = TPRDEVRESULTOFFLINE;
            break;

        case CHANGER_RESULT_POWEROFF: /* POWER OFF */
            tprmsg->devnotify2.result = TPRDEVRESULTPWOFF;
            break;

        case CHANGER_RESULT_RDERROR:  /* READ ERROR */
            tprmsg->devnotify2.result = TPRDEVRESULTRERR;
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerrd] changerrd_notify result[%d]", result );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
           break;
    }
    length += sizeof( int );                            /* + sizeof result */

    tprmsg->devnotify2.src    = 0;                      /* Set src kind  */
    length += sizeof( TPRTID );                         /* + sizeof src */

    tprmsg->devnotify2.io     = 0;                      /* (未使用)changerにてseq_noをセット */
    length += sizeof( int );                            /* + sizeof io */

    tprmsg->devnotify2.tid    = MyDid;                  /* Set device id */
    length += sizeof( TPRDID );                         /* + sizeof tid */

    tprmsg->devnotify2.length = length;                 /* set length */
    length += sizeof( int );                            /* + sizeof length */

    tprmsg->devnotify2.mid = TPRMID_DEVNOTIFY;          /* Set message id */
    length += sizeof( TPRMID );                         /* + sizeof mid */

    /* send to DRV */
	r = changer_main_devnotify(tprmsg);
    snprintf( c_log, sizeof(c_log), "[%s] tprmsgdevrcv.devnotify2.result(%d)", __FUNCTION__, tprmsgdevrcv.devnotify2.result );
	LogWrite(c_log);
    return r;
}

/*
 *  Usage : unsigned char changerrd_bcc(rcv_buf *rcv_buf)
 *      rcv_buf : received data buffer
 *  Return :  calclated BCC
 *  Functions : calclate BCC
 */
unsigned char changerrd_bcc(rcv_buf *rcv_buf)
{
    unsigned char bcc = 0;  /* BCC */
    int           i;        /* work */

    bcc = rcv_buf->data[0+2]; /* set the first byte */
    /* calclation loop */
    for (i = 1+2; i < rcv_buf->count-1; i++) /* +2:DLE+STX -1:ETX */
        bcc ^= rcv_buf->data[i];    /* EXOR calclation */

    bcc ^= ETX;     /* add for ETX */
    return bcc;     /* return BCC */
}



/********************************************************************************************************************************************************************
     changerwd
********************************************************************************************************************************************************************/
int changerwd_main_devreq(int fds, tprmsg_t *tprmsg)
{
	int	ret = 0;
    /* select sndState */
    switch (sndState) {
        case CHANGERWD_STATE_RCV:   /* wait for receive */
            /* write to port */
            if ((ret = changerwd_write( fds, tprmsg )) < 0) {    /* fail */
                /* confirm */
                changerwd_conf(ret, tprmsg);
                /* initialize port */
                if( changer_initport(serial_fds, ttySet.baudrate, ttySet.databit, ttySet.stopbit, ttySet.parity) < 0) {
                    TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] fail to initialize tty port" );
                    sndState = CHANGERWD_STATE_ERR;
                }
                else {
#ifdef DELETE
                    /* check port */
                    if (changer_checkport(fds) < 0)
                        sndState = CHANGERWD_STATE_ERR;
                    else
                        sndState = CHANGERWD_STATE_RCV;
#endif
                    /* check port */
                    if (changer_checkport(fds) < 0) {
#ifdef DEBUG_CHANGERWD
                        printf("changerwd main TTY OFFLINE\n");
#endif
                        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] TTY is yet OFFLINE" );
                    }
                }
            	return CHANGER_NG;
            }
            else {
                /* confirm */
                if (changerwd_conf(CHANGER_RESULT_OK, tprmsg) < 0) {
                    TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] fail to confirm for parent" );
                	return CHANGER_NG;
                }
            }
            break;

        case CHANGERWD_STATE_ERR:   /* in error */
            /* confirm */
            changerwd_conf(CHANGER_RESULT_WRERROR, tprmsg);
            /* initialize port */
            if( changer_initport(serial_fds, ttySet.baudrate, ttySet.databit, ttySet.stopbit, ttySet.parity)  < 0) {
                TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] fail to initialize tty port" );
                sndState = CHANGERWD_STATE_ERR;
            }
            else {
                /* check port */
                if (changer_checkport(fds) < 0) {
#ifdef DEBUG_CHANGERWD
                    printf("changer main TTY OFFLINE\n");
#endif
                    sndState = CHANGERWD_STATE_ERR;
                }
                else
                    sndState = CHANGERWD_STATE_RCV;
            }
           	ret = CHANGER_NG;
    	    break;

        case CHANGERWD_STATE_SYSFAIL:   /* in SYSFAIL */
            TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] main CHANGERWD_STATE_SYSFAIL" );
           	ret = CHANGER_NG;
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerwd] main sndState[%d] error", sndState );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
           	ret = CHANGER_NG;
            break;
    }
	return ret;
}
/*
 *  Usage : int changerwd_write( char *msg );
 *      char    *msg :  Pointer to write message for subcpu driver 
 *  Functions : Write command to changer
 */
int changerwd_write( int fds, tprmsg_t *tprmsg )
{
    int         r = 0;      /* return */
    snd_buf     snd_buf;    /* send buffer */
#ifdef ChangerDebug
    int         i;          /* work */
#endif
    int         len;        /* message length (work) */
    
    memset(snd_buf.data, 0, sizeof(snd_buf.data));
    snd_buf.count = 0;

#ifdef ChangerDebug
    printf("changerwd_write data[0] 0x%x\n", tprmsg->devreq2.data[0]);
#endif
    /* select byte */
    switch (tprmsg->devreq2.data[0]) {
        case ACK:
        case NAK:
        case ENQ:
        case EOT:
        case BEL:
            /* control code */
            snd_buf.data[0] = tprmsg->devreq2.data[0];
            snd_buf.count = 1;
            break;

        default:
            /* data */
#ifdef DELETE
            if ((tprmsg->devreq2.data[0] & 0xf0) != 0x30) {
#endif
                /* check DC1 */
                if (tprmsg->devreq2.data[0] != DC1) {
                    TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] send TEXT not begin at 0x3?" );
                    return CHANGER_RESULT_WRERROR;
                }
#ifdef DELETE
            }
#endif
            snd_buf.data[0] = STX;  /* set STX to head */
            snd_buf.count = 1;      /* set count */
#ifdef DELETE
            len = tprmsg->common.length - sizeof(tprmsg->devreq2.tid) - sizeof(tprmsg->devreq2.io) -
                sizeof(tprmsg->devreq2.result) - sizeof(tprmsg->devreq2.datalen);
#endif
            len = tprmsg->devreq2.datalen;
            /* set data */
            memcpy(&snd_buf.data[snd_buf.count], tprmsg->devreq2.data, len);
            snd_buf.count += len;   /* update for data */
            snd_buf.data[snd_buf.count] = ETX;  /* set ETX */
            snd_buf.count += 1;     /* update for ETX */
            snd_buf.data[snd_buf.count] = changerwd_bcc(&snd_buf);  /* set BCC */
            snd_buf.count += 1;     /* update for BCC */
            break;
    }

    /* initialize port */
    if( changer_initport(serial_fds, ttySet.baudrate, ttySet.databit, ttySet.stopbit, ttySet.parity)  < 0) {
        TprLibLogWrite( MyTid, TPRLOG_ERROR, 0, "[changerwd] Changer port initialize error" );
        return CHANGER_RESULT_WRERROR;
    }

    /* check port */
    if ((r = changer_checkport(fds)) < 0) {
        LogWrite( "[changerwd] Changer Offline" );
        return r;
    }
#ifdef ChangerDebug
    printf("changerwd_write snd_buf : ");
    for (i = 0; i < snd_buf.count; i++)
        printf(" %02x", snd_buf.data[i]);
    printf("\n");
#endif

    /* write to TTY port */
    if (write(fds, snd_buf.data, snd_buf.count) != snd_buf.count) {
        snprintf( c_log, sizeof(c_log), "[changerwd] changerwd_write write error[%d]", errno );
        LogWrite( c_log );
        return CHANGER_RESULT_WRERROR;
    }
#if CHANGERWD_LOGWRITE
	acx_retry_cnt = TS_BUF->acx.retry_cnt;
	acx_res_write = TS_BUF->acx.acx_res_write;
	cm_rs232c_log_write(RS232C_ACX, RS232C_SEND, snd_buf.data, snd_buf.count);
	TS_BUF->acx.acx_res_write = acx_res_write;
#endif

    return r;
}

/*
 *  Usage : int changerwd_conf( int result, tprmsg *tprmsg );
 *      int     result : write result
 *      char    *msg :  Pointer to write message for subcpu driver 
 *  Functions :Confirm Changer Command Write
 */
int changerwd_conf( int result, tprmsg_t *tprmsgReq  )
{
    int         r = 0;      /* return */
    int         length;     /* message length */
    tprmsg_t    *tprmsgAck; /* message */
    char        WriteBuf[sizeof(tprmsg_t)];         /* Data Write buffer */

    /* Make device notify message for protocol driver   */
                            /* Calc. length of cmd and data part */
    length = 0;
                            /* Set data length */
    tprmsgAck = (tprmsg_t *)WriteBuf;
    memset(WriteBuf, 0, sizeof(WriteBuf));

    tprmsgAck->devack2.datalen = tprmsgReq->devreq2.datalen;
    length += sizeof( uint );                           /* + sizeof datalen */

#ifdef DEBUG_CHANGER
    printf("changerwd_conf result %d\n", result);
#endif
    /* select result */
    switch (result) {
        case CHANGER_RESULT_OK:       /* OK */
            tprmsgAck->devack2.result = TPRDEVRESULTOK;
            break;

        case CHANGER_RESULT_OFFLINE:  /* OFFLINE */
            tprmsgAck->devack2.result = TPRDEVRESULTOFFLINE;
            break;

        case CHANGER_RESULT_POWEROFF: /* POWER OFF */
            tprmsgAck->devack2.result = TPRDEVRESULTPWOFF;
            break;

        case CHANGER_RESULT_WRERROR:  /* WRITE ERROR */
            tprmsgAck->devack2.result = TPRDEVRESULTWERR;
            break;

        default:
            snprintf( c_log, sizeof(c_log), "[changerwd] changerwd_conf result[%d]", result );
            TprLibLogWrite( MyTid, TPRLOG_NORMAL, 0, c_log );
            break;
    }
    length += sizeof( int );                            /* + sizeof result */

    tprmsgAck->devack2.io     = tprmsgReq->devreq2.io;  /* Set io kind  */
    length += sizeof( int );                            /* + sizeof io */

    tprmsgAck->devack2.tid    = tprmsgReq->devreq2.tid; /* Set device id */
    length += sizeof( TPRDID );                         /* + sizeof tid */

    tprmsgAck->devack2.src    = tprmsgReq->devreq2.src; /* Set src id */
    length += sizeof( TPRDID );                         /* + sizeof tid */

    tprmsgAck->devack2.length = length;                 /* set length */
    length += sizeof( int );                            /* + sizeof length */

    tprmsgAck->devack2.mid = TPRMID_DEVACK;             /* Set message id */
    length += sizeof( TPRMID );                         /* + sizeof mid */

    /* send to parent */
	r = changer_main_devack(tprmsgAck);
    return r;
}

/*
 *  Usage : unsigned char changerwd_bcc(rcv_buf *snd_buf)
 *      snd_buf : send data buffer
 *  Return :  calculated BCC
 *  Functions : calclate BCC
 */
unsigned char changerwd_bcc(snd_buf *snd_buf)
{
    unsigned char bcc = 0;  /* BCC */
    int           i;        /* work */

    bcc = snd_buf->data[1];     /* set top byte : data[0] is STX */
    /* calculate BCC loop */
    for (i = 2; i < snd_buf->count; i++)
        bcc ^= snd_buf->data[i];    /* calculate BCC */

    return bcc; /* return BCC */
}


