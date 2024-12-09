/* system include */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <termios.h>
#include <linux/input.h>

/* define */
#define	MKEY_OK		0
#define	MKEY_NG		-1

#define	OPEN_RETRY_CNT		15
#define	OPEN_RETRY_WAIT		300000
#define	READ_ERR_RETRY_CNT	100
#define	READ_ERR_WAIT		50000

#define DEVBIT(bit, array) (array[bit/8] & (1<<(bit%8)))

int main()
{
	return 0;
}

/**********************************************************************
	関数：MechanicalKeyPortOpen
	機能：メカキーのポートオープン
	引数：[IN]	ファイルパス
		  [OUT]	ファイルディスクリプタへのポインタ
	戻値：MKEY_OK(0)
		  MKEY_NG(-1)
***********************************************************************/
int MechanicalKeyPortOpen(const char *pathName, long *fds)
{
	int				i;
	int				version;
	char			name[256] = "Unknown";
	unsigned short	id[4];
	unsigned char	bit[EV_MAX/8 + 1];


	for (i = 0; i < OPEN_RETRY_CNT; i++) {
		if((*fds = open (pathName, O_RDONLY|O_NONBLOCK)) >= 0) {
			break;
		}
		usleep(OPEN_RETRY_WAIT);
	}

	if (*fds < 0) {
		return MKEY_NG;
	}
	else {
		if (ioctl(*fds, EVIOCGVERSION, &version)) {
		}
		else {
		}

		if (ioctl(*fds, EVIOCGID, id)) {
		}
		else {
		}

		memset(name, 0x00, sizeof(name));
		if (ioctl(*fds, EVIOCGNAME(sizeof(name)), name) < 0) {
		}
		else {
		}

		memset(bit, 0, sizeof(bit));
		if (ioctl(*fds, EVIOCGBIT(0, sizeof(bit)), bit) < 0) {
		}
		else {
			for (i = 0; i < EV_MAX; i++) {
				if (DEVBIT(i, bit)) {
					switch(i) {
						case EV_KEY:	break;
						case EV_REL:	break;
						case EV_ABS:	return MKEY_NG;
						case EV_MSC:	break;
						case EV_LED:	break;
						case EV_SND:	break;
						case EV_REP:	break;
						case EV_FF:		break;
						default:		break;
					}
				}
			}
		}

		if (ioctl(*fds, EVIOCGRAB, (void *)1)) {
		}
	}

	return MKEY_OK;
}


/**********************************************************************
	関数：MechanicalKeyPortClose
	機能：メカキーのデバイスクローズ
	引数：[IN]	ファイルディスクリプタ
	戻値：MKEY_OK(0)
		  MKEY_NG(-1)
***********************************************************************/
int MechanicalKeyPortClose(long fds)
{
	if (0 > (close(fds))) {
		return MKEY_NG;
	}
	return MKEY_OK;
}


/**********************************************************************
	関数：MechanicalKeyEventRcv
	機能：イベントキー受信処理
	引数：	[IN]	ファイルディスクリプタ
			[IN]	ファイルパス
	戻値：キーコード
***********************************************************************/
int MechanicalKeyEventRcv(unsigned long *fds, const char *pathName)
{
	int		rd = 0;
	int		i;
	struct	input_event ev[64];

	/* キー入力なしの場合は0を返却 */
	memset(&ev[0], 0x00, sizeof(struct input_event));

	if (fds >= 0 ) {

		rd = read(*fds, ev, sizeof(struct input_event) * 64);
		if (rd < (int) sizeof(struct input_event)) {
			return 0;
		}
	}
	for (i = 0; i < rd /sizeof(struct input_event); i++) {
		/* キーボードのキー入力 */
		if (ev[i].type == EV_KEY) {
			/* キー押下 または リリース */
			if ((ev[i].value == 1) || (ev[i].value == 0)) {
				break;
			}
		}
	}

	return ev[i].code;
}
