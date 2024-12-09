/* system include */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <termios.h>
#include <linux/input.h>
#include <sys/stat.h>
#include <errno.h>


/* define */
#define	SCAN_OK		0
#define	SCAN_NG		-1

#define PLUS_SCAN_D		0
#define PLUS_SCAN_T		1
#define PLUS_SCAN_P		20

unsigned long scan_baudrate;
unsigned long scan_databit;
unsigned long scan_stopbit;
char scan_parity[16];

int ScanPortInit(long fds, unsigned long baudrate, unsigned long databit, unsigned long stopbit);

int main()
{
	return 0;
}
int execute_test(int arg)
{
	return arg + 1;
}

static int DrvScanPortCheck(unsigned long fds)
{
	int		dsr;
	int		mcs = 0;
	short	i;

	for (i = 0; i < 20; i++) {
		/* check online */
		if (ioctl(fds, TIOCMGET, &mcs) != -1 ) {
			dsr =  (mcs & TIOCM_DSR) != 0 ? 1 : 0;

			if (dsr != 0) {
				/* ポートチェックOK */
				return( 0 );
			}
		}
		usleep(10000);
	}

	/* POWER OFF or NOT READY */
	return( -1 );
}

static int DrvScanSerialWrite(long fds, char *sendData, unsigned long sendDataSize)
{
	int ret = 0;
	int      rd;
	char   readData[1];
	char   writeData[1];

	ret = ScanPortInit(fds, 9600, 7, 2);
	if (ret != 0) {
		return -5;
	}

	ret = write(fds, sendData, sendDataSize);
	if (ret != sendDataSize) {
		/* Writeエラー */
		return errno;
	}
//	printf("DrvScanSerialWrite!! %d %ld\n", ret, fds);

	return ret;
}


/****************************************************
	ドライバ部（スキャナ）
****************************************************/
int ScanPortOpen(const char *pathName, long *fds)
{
	if (0 > (*fds = open(pathName, O_RDWR|O_NONBLOCK))) {
		return SCAN_NG;
	}

//	printf("ScanPortOpen!!          PATH:%s FD:%ld ADRR%p\n", pathName, *fds, fds);
	return SCAN_OK;
}

int ScanPortClose(unsigned long fds)
{
	if (0 > (close(fds))) {
		return SCAN_NG;
	}
	return SCAN_OK;
}

int ScanPortInit(long fds, unsigned long baudrate, unsigned long databit, unsigned long stopbit)
{
	int		speed = -1;			/* baudrate code	*/
	int		swflow = 0;			/* XONOFF			*/
	struct	termios tty;		/* tty structure	*/
	struct	termios tty2;		/* tty structure	*/
	int		cnt, ret;

//	printf("ScanPortInit Start!! %ld\n", fds);

	/* baudrate */
	switch(baudrate) {
		case 1200:	speed = B1200;	break;
		case 2400:	speed = B2400;	break;
		case 4800:	speed = B4800;	break;
		case 9600:	speed = B9600;	break;
		case 19200:	speed = B19200;	break;
		case 38400:	speed = B38400;	break;
		default:
			return( -1 );
	}

	/* get TTY attribute */
	if (tcgetattr(fds, &tty) < 0) {
		return( -2 );
	}

	/* set output speed */
	cfsetospeed(&tty, (speed_t)speed);
	/* set input speed */
	cfsetispeed(&tty, (speed_t)speed);

	/* select databit */
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
	tty.c_iflag = IGNBRK;
	tty.c_lflag = 0;
	tty.c_oflag = 0;
	tty.c_cflag |= CLOCAL | CREAD;
	tty.c_cc[VMIN] = 1;
	tty.c_cc[VTIME] = 5;

	/* XONOFF = alway OFF */
	if (swflow != 0) {
		tty.c_iflag |= IXON | IXOFF;
	}
	else {
		tty.c_iflag &= ~(IXON|IXOFF|IXANY);
	}

	/* set parity */
	tty.c_cflag &= ~(PARENB | PARODD);  /* parity none */
	tty.c_cflag |= (PARENB | PARODD);

	/* set stop bit */
	if (stopbit == 2) {
		tty.c_cflag |= CSTOPB;
	}
	else {
		tty.c_cflag &= ~CSTOPB;
	}

	memcpy( &tty2, &tty, sizeof(tty) );

	/* 最大リトライ回数分のループ処理 */
	for(cnt = 0; cnt < 10; cnt++) {
		/* setup TTY attribute */
		if (tcsetattr(fds, TCSANOW, &tty2) < 0) {
			return( -3 );
		}

		/* get TTY attribute */
		if (tcgetattr(fds, &tty) < 0) {
			return( -4 );
		}

		if (memcmp(&tty, &tty2, sizeof(tty)) != 0) {
			ret = -5;
		}
		else {
			ret = 0;
			break;
		}  
		/* リトライ時の待ち時間(msec)を設定 */
		usleep(200000);
	}
//	printf("ScanPortInit End!! %d\n", ret);

	return(ret);
}


int ScanDataRcv(long *fds, const char *pathName, unsigned char *readData, int readSize)
{
	int		rd;
	unsigned char	SendData = 'O';
	unsigned char	SendData2 = 'N';


		/* reopen処理追加 */
//		close(*fds);
//		ScanPortOpen(pathName, fds);
//		ScanPortInit(*fds, 9600, 7, 2);
		if (*fds > 0 ) {

			rd = read(*fds, &readData[0], 1);
			if (rd < 0) {
//				printf("Read Size Zero!! %d\n", errno);
			}
			else {
				//printf("Read 0x%02x \n", *readData);
				/* ACK */
				DrvScanSerialWrite(*fds, &SendData, sizeof(SendData));

			}
		}

	return 0;
}
