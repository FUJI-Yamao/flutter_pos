/* system include */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include "CashDrawerAPI.h"

/* define */
#define	DRW_OK	0
#define	DRW_NG	-1

#define	DEVICE_DRW1		0x01003100
#define	DEVICE_DRW2		0x02003100

#define	DRW1OPENCOMMAND		"1"
#define	DRW2OPENCOMMAND		"2"

#define UPSFILE "/dev/shm/ups/ups_stat"

#define XPRN_PE	0x20


/**********************************************************************
	関数：DrwPortOpen
	機能：ドロワのポートオープン
	引数：pathName	[IN]	ファイルパス
		  fds		[OUT]	ファイルディスクリプタへのポインタ
	戻値：DRW_OK(0)
		  DRW_NG(-1)
***********************************************************************/
int DrwPortOpen(const char *pathName, long *fds)
{
#if 0
	if (0 > (*fds = open(pathName, O_RDWR))) {
		return DRW_NG;
	}
#endif
	return DRW_OK;
}


/**********************************************************************
	関数：DrwPortClose
	機能：ドロワのデバイスクローズ
	引数：fds	[IN]	ファイルディスクリプタ
	戻値：DRW_OK(0)
		  DRW_NG(-1)
***********************************************************************/
int DrwPortClose(long fds)
{
#if 0
	if (0 > (close(fds))) {
		return DRW_NG;
	}
#endif
	return DRW_OK;
}


/**********************************************************************
	関数：DrwOpenCmd
	機能：ドロワを開く
	引数：fds	[IN]	書き込み対象のファイルディスクリプタ
	戻値：DRW_OK(0)
		  DRW_NG(-1)
***********************************************************************/
#include <stdlib.h>
#define G3_DRWOPN "/sys/kernel/trk03igpio/gpo21"
int DrwOpenCmd(long fds)
{
/* SlideSwitch使用時はこっちを有効化 */
#if 0
	unsigned char	buf[32];
	unsigned long	len;
	unsigned long	wret;
	unsigned long	ret = DRW_NG;

	memset(buf, 0x00, sizeof(buf));

	if (deviceId == DEVICE_DRW1) {
		strcpy(buf, DRW1OPENCOMMAND);
	}
	if (deviceId == DEVICE_DRW2) {
		strcpy(buf, DRW2OPENCOMMAND);
	}

	len = strlen(buf);
	wret = write(fds, &buf, len);
	if (wret != len) {
		ret = DRW_NG;
	}
	else {
		ret = DRW_OK;
	}

	return ret;
#endif
/* プロトタイプではSlideSwitch内の処理を移植 */
	FILE    *fpdopn;
	int j;

	// DrawerOpen
	fpdopn = fopen(G3_DRWOPN,"w");
	if(fpdopn == NULL) {
	}
	else {
		for (j = 0; j < 5; j++) {
			system("echo 1 > /sys/kernel/trk03igpio/gpo21");
			usleep(20000);
		}
		usleep(100000);
		for (j = 0; j < 5; j++) {
			system("echo 0 > /sys/kernel/trk03igpio/gpo21");
			usleep(20000);
		}
		fclose(fpdopn);
	}
	return DRW_OK;
/* プロトタイプではSlideSwitch内の処理を移植 */
}

#define G3_DRWSTAT "/sys/kernel/trk03igpio/gpi15"
/**********************************************************************
	関数：DrwStatusCheck
	機能：ドロワ状態更新
	引数：[IN]	ドロワ状態1
				ドロワ状態2
		  [OUT]	更新後のドロワ状態1
		  		更新後のドロワ状態2
	戻値：DRW_OK(0)
		  DRW_NG(-1)
***********************************************************************/
int DrwStatusCheck(unsigned char drwStatus1, unsigned char drwStatus2,
					char *newDrwStatus1, char *newDrwStatus2)
{
#if 1/* 暫定対応 */
	FILE	*fpdrw;
	char	readbuf[4];
	char	status[16];


	fpdrw = fopen(G3_DRWSTAT,"r");
	if(fpdrw == NULL) {
		printf("fopen %s Error errno:%d\n", G3_DRWSTAT, errno);
	}
	else {
		memset(readbuf, 0x00, sizeof(readbuf));
		fgets(readbuf, sizeof(readbuf), fpdrw);
		fclose(fpdrw);

		if (readbuf[0] == 0x31) {
			*newDrwStatus1 = drwStatus1 |= XPRN_PE;
		}
		else {
			*newDrwStatus1 = drwStatus1 &= ~XPRN_PE;
		}
		*newDrwStatus2 = 0;
	}
#else
	FILE	*fp;
	char	readbuf[16];

	fp = fopen(UPSFILE,"r");
	if (fp == NULL) {
		return DRW_NG;
	}
	else {
		memset(readbuf, 0x00, sizeof(readbuf));
		fgets(readbuf, sizeof(readbuf), fp);
		fclose(fp);
	}

	if (readbuf[6] == 0x31) {
		*newDrwStatus1 = drwStatus1 |= XPRN_PE;
	}
	else { 
		*newDrwStatus1 = drwStatus1 &= ~XPRN_PE;
	}

	if (readbuf[5] == 0x31) {
		*newDrwStatus2 = drwStatus2 |= XPRN_PE;
	}
	else {
		*newDrwStatus2 = drwStatus2 &= ~XPRN_PE;
	}
#endif

	return DRW_OK;
}
