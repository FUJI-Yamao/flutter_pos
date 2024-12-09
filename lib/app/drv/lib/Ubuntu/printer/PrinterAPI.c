
/* system include */
#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <linux/input.h>
#include <iconv.h>
#include <errno.h>
#include <signal.h>

#include "sii_api.h"



/* define */
#define	CMD_DC2				0x12
#define	CMD_DC3				0x13
#define	CMD_ESC				0x1b
#define	CMD_FS				0x1c
#define	CMD_GS				0x1d
#define	CMD_LF				0x0A
#define	TPRTSS_TMPBUFSIZ	256
#define	WRITE_BUF_SIZ		(WRITE_LEN_MAX + 3)
#define	WRITE_LEN_MAX		1000
#define	WRITE_CNT_MAX		15
#define	READ_BUF_SIZ		512
#define	NO_CONVERSION_REQUIRED	1
#define	CONVERSION_REQUIRED		2
#define	OPEN_RETRY				20
#define	OPEN_WAIT_TIME			200000
#define	OPEN_AFTERWAIT			300000
#define	RESET_WAITTIME			500000

#define	utf_trail(c)			((c) >= 0x80 && (c) <= 0xBF)
#define	nr_of_code_list_utf		(sizeof(utf2sjis_utf_code)/sizeof(utf2sjis_utf_code[0]))


typedef struct tagBITMAPFILEHEADER {
	char			bfType[2];
	unsigned int	bfSize;
	unsigned short	bfReserved1;
	unsigned short	bfReserved2;
	unsigned int	bfOffBits;
} BITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER{
	unsigned int	biSize;
	unsigned int	biWidth;
	unsigned int	biHeight;
	unsigned short	biPlanes;
	unsigned short	biBitCount;
	unsigned int	biCompression;
	unsigned int	biSizeImage;
	unsigned int	biXPixPerMeter;
	unsigned int	biYPixPerMeter;
	unsigned int	biClrUsed;
	unsigned int	biClrImporant;
} BITMAPINFOHEADER;

/* bitmapfile RGB infomation */
typedef struct tagRGBQUAD{
	unsigned char	rgbBlue;
	unsigned char	rgbGreen;
	unsigned char	rgbRed;
	unsigned char	rgbReserved;
} RGBQUAD;

SIIAPIHANDLE handle;
struct sigaction	oldaction;

int PrinterWriteDevice(unsigned char *writebuf, size_t bufSize, size_t *writeSize);

int main()
{
	return 0;
}
int execute_test(int arg)
{
	return arg + 1;
}

static void signalControl(unsigned char control)
{
	struct sigaction action;

	if (control) {
		sigemptyset(&action.sa_mask);
		action.sa_handler = SIG_IGN;

		/* シグナル割り込み禁止(プロファイル・タイマーの有効期限切れ) */
		sigaction(SIGPROF, &action, &oldaction);
	}
	else {
		/* シグナル受信(プロファイル・タイマーの有効期限切れ) */
		sigaction(SIGPROF, &oldaction, NULL);
	}

	return;
}

/*----------------------------------------------------------------------*
 * bit_change
 *----------------------------------------------------------------------*/
static void bit_change(unsigned char *linebuf, int size)
{
	int	cnt;

	for (cnt = 0 ; cnt < size ; cnt++) {
		linebuf[cnt] = ~linebuf[cnt];
	}
}

/*----------------------------------------------------------------------*
 * tprtss_get_bmpfileheader
 *----------------------------------------------------------------------*/
static int tprtss_get_bmpfileheader(char *buf, BITMAPFILEHEADER *hdr, BITMAPINFOHEADER *bhdr,
				RGBQUAD *colorhd1, RGBQUAD *colorhd2)
{
	memcpy(hdr->bfType,buf,sizeof(hdr->bfType)); buf += sizeof(hdr->bfType);
	memcpy(&(hdr->bfSize),buf,sizeof(hdr->bfSize)); buf += sizeof(hdr->bfSize);
	memcpy(&(hdr->bfReserved1),buf,sizeof(hdr->bfReserved1)); buf += sizeof(hdr->bfReserved1);
	memcpy(&(hdr->bfReserved2),buf,sizeof(hdr->bfReserved2)); buf += sizeof(hdr->bfReserved2);
	memcpy(&(hdr->bfOffBits),buf,sizeof(hdr->bfOffBits));buf += sizeof(hdr->bfOffBits);

	memcpy(&(bhdr->biSize),buf,sizeof(bhdr->biSize));buf += sizeof(bhdr->biSize);
	memcpy(&(bhdr->biWidth),buf,sizeof(bhdr->biWidth));buf += sizeof(bhdr->biWidth);
	memcpy(&(bhdr->biHeight),buf,sizeof(bhdr->biHeight));buf += sizeof(bhdr->biHeight);
	memcpy(&(bhdr->biPlanes),buf,sizeof(bhdr->biPlanes));buf += sizeof(bhdr->biPlanes);
	memcpy(&(bhdr->biBitCount),buf,sizeof(bhdr->biBitCount));buf += sizeof(bhdr->biBitCount);
	memcpy(&(bhdr->biCompression),buf,sizeof(bhdr->biCompression));buf += sizeof(bhdr->biCompression);
	memcpy(&(bhdr->biSizeImage),buf,sizeof(bhdr->biSizeImage));buf += sizeof(bhdr->biSizeImage);
	memcpy(&(bhdr->biXPixPerMeter),buf,sizeof(bhdr->biXPixPerMeter));buf += sizeof(bhdr->biXPixPerMeter);
	memcpy(&(bhdr->biYPixPerMeter),buf,sizeof(bhdr->biYPixPerMeter));buf += sizeof(bhdr->biYPixPerMeter);
	memcpy(&(bhdr->biClrUsed),buf,sizeof(bhdr->biClrUsed));buf += sizeof(bhdr->biClrUsed);
	memcpy(&(bhdr->biClrImporant),buf,sizeof(bhdr->biClrUsed));buf += sizeof(bhdr->biClrImporant);

	if (bhdr->biSize != 40) {
		return -1;
	}
	memcpy(&(colorhd1->rgbBlue),buf,sizeof(colorhd1->rgbBlue));buf += sizeof(colorhd1->rgbBlue);
	memcpy(&(colorhd1->rgbGreen),buf,sizeof(colorhd1->rgbGreen));buf += sizeof(colorhd1->rgbGreen);
	memcpy(&(colorhd1->rgbRed),buf,sizeof(colorhd1->rgbRed));buf += sizeof(colorhd1->rgbRed);
	memcpy(&(colorhd1->rgbReserved),buf,sizeof(colorhd1->rgbReserved));buf += sizeof(colorhd1->rgbReserved);

	memcpy(&(colorhd2->rgbBlue),buf,sizeof(colorhd2->rgbBlue));buf += sizeof(colorhd2->rgbBlue);
	memcpy(&(colorhd2->rgbGreen),buf,sizeof(colorhd2->rgbGreen));buf += sizeof(colorhd2->rgbGreen);
	memcpy(&(colorhd2->rgbRed),buf,sizeof(colorhd2->rgbRed));buf += sizeof(colorhd2->rgbRed);
	memcpy(&(colorhd2->rgbReserved),buf,sizeof(colorhd2->rgbReserved));buf += sizeof(colorhd2->rgbReserved);

	return 0;
}

/*----------------------------------------------------------------------*
 * tprtss_get_bmpimage
 *----------------------------------------------------------------------*/
int tprtss_get_bmpimage(char *filePath, int *OffBits, int *Width, int *Height)
{
	int		ret = 0;    /* return */
	struct	stat s;     /* stat */
	off_t	st_size;    /* stat size */
	int		fp = -1;
	char	*buf = NULL;
	int			len = 0;
	BITMAPFILEHEADER	hdr;
	BITMAPINFOHEADER	bhdr;
	RGBQUAD				colorhd1;
	RGBQUAD				colorhd2;

	memset(&hdr,0x00,sizeof(hdr));
	memset(&bhdr,0x00,sizeof(bhdr));
	memset(&colorhd1,0x00,sizeof(colorhd1));
	memset(&colorhd2,0x00,sizeof(colorhd2));

	if (stat(filePath, &s) < 0) {
		printf( "ERROR : tprtss_get_bmpimage1 %d\n",errno);
		goto tprtss_get_bmpimage_err;
	}
	st_size = s.st_size;
	if (st_size <= 0) {
		printf( "ERROR : tprtss_get_bmpimage2 %d\n",ret );
		goto tprtss_get_bmpimage_err;
	}
	if ((fp = open(filePath, O_RDONLY)) < 0) {
		printf( "ERROR : tprtss_get_bmpimage3 %d\n",ret );
		goto tprtss_get_bmpimage_err;
	}
	if ((buf = malloc(st_size)) == NULL) {
		printf( "ERROR : tprtss_get_bmpimage4 %d\n",ret );
		goto tprtss_get_bmpimage_err;
	}
	memset(buf,0x00,st_size);

	len = read(fp, buf, st_size);
	if (len != st_size) {
		printf( "ERROR : tprtss_get_bmpimage5 %d\n",ret );
		goto tprtss_get_bmpimage_err;
	}
	ret = tprtss_get_bmpfileheader(buf, &hdr, &bhdr, &colorhd1, &colorhd2);
	if ( ret != 0 ) {
		printf( "ERROR : tprtss_get_bmpimage6 %d\n",ret );
		goto tprtss_get_bmpimage_err;
	}
	*OffBits = hdr.bfOffBits;
	*Width = bhdr.biWidth;
	*Height = bhdr.biHeight;

tprtss_get_bmpimage_err:
	if (buf != NULL) {
		free(buf);
	}
	if (fp >= 0) {
		close(fp);
	}
	return 0;
}

/*----------------------------------------------------------------------*
 * tprtss_record_logo
 *----------------------------------------------------------------------*/
int tprtss_get_bmpimage_data(int logono, char *filePath, int OffBits, int Width, int Height, int line_byte, unsigned char *bitMapData, int *bitMapDataSize)
{
	int				ret = 0;
	FILE			*fp = NULL;
	unsigned char	*p = NULL, *p2 = NULL;
	unsigned char	*p_tmp = NULL, *p_tmp2 = NULL;
	int				i, len;
	int				position;
	int				cnt, cnt2, cnt3, bit_num, x, y, TrueHeight, boundary_bit;
	size_t			tagRetSize;

	TrueHeight = Height;
	if (TrueHeight % 8 != 0) {
		Height = TrueHeight + 8 - (TrueHeight % 8);
	}

	boundary_bit = 0;
	boundary_bit = line_byte % 4;
	if (boundary_bit != 0) {
		line_byte = ((line_byte / 4) + 1) * 4;
    }
	if (line_byte < 1 || 0x7f < line_byte) {
		printf( "ERROR : tprtss_record_logo2 %d\n",line_byte );
		goto tprtss_record_logo_err;
	}
	if (Height < 1 || 0x7ff < Height) {
		printf( "ERROR : tprtss_record_logo3 %d\n",Height );
		goto tprtss_record_logo_err;
	}
	if ((fp = fopen(filePath, "r")) == NULL) {
		printf( "ERROR : tprtss_record_logo4 %s\n",filePath );
		goto tprtss_record_logo_err;
	}
	if ((p = malloc((line_byte * Height) + 32)) == NULL) {
		printf( "ERROR : tprtss_record_logo5" );
		goto tprtss_record_logo_err;
	}
	memset(p, 0x0, (line_byte * Height) + 32);

	if ((p2 = malloc(line_byte * Height)) == NULL) {
		printf( "ERROR : tprtss_record_logo6" );
		goto tprtss_record_logo_err;
	}
	memset(p2, 0x0, (line_byte * Height));

	len = 0;
	p_tmp = p + len;
	p_tmp2 = p2;

	for(i=0; i<TrueHeight; i++) {
		position = OffBits + line_byte * (TrueHeight - (i + 1));
		fseek(fp, position, SEEK_SET);
		fread(p_tmp2, line_byte, 1, fp);
		bit_change(p_tmp2, line_byte);   /* 1 -> 0 : 0 -> 1 */
		p_tmp2 += line_byte;
	}
	for(cnt2 = 0; cnt2 < Height; cnt2++) {
		for(cnt = 0; cnt < line_byte; cnt++) {
			for(cnt3 = 7; cnt3 >= 0; cnt3--) {
				if((p2[(cnt2 * line_byte) + cnt] >> cnt3) & 0x01) {
					if(logono == 2) {
						bit_num=(((cnt2 * line_byte) * 8) + (cnt * 8) + (7 - cnt3));
						x = bit_num % (line_byte * 8);
						y = bit_num / (line_byte * 8);
						if (!(cnt == line_byte -1 && cnt3 <= boundary_bit && boundary_bit != 0))
							p_tmp[(x * (Height / 8)) + (y / 8)] |= 0x80 >> (y % 8);
					} else {
						if (!(cnt == line_byte -1 && cnt3 <= boundary_bit && boundary_bit != 0))
							p_tmp[(cnt2 * line_byte) + cnt] |= 0x80 >> ((7 - cnt3) % 8);
					}
				}
			}
		}
	}
	len = 16+((((Width % 256) + ((Width / 256) * 256) + 7) / 8) * Height);

	memcpy(bitMapData, p, (line_byte * Height) + 32);
    *bitMapDataSize = len;

tprtss_record_logo_err:
	if (p2 != NULL) {
		free(p2);
	}
	if (p != NULL) {
		free(p);
	}
	if (fp != NULL) {
		fclose(fp);
	}

	return 0;
}


/****************************************************
	ドライバ部（プリンタ）
****************************************************/
int PrinterPortOpen(char *devicePath, bool debugMode)
{
	int				nRetVal;
	int		i;

	signalControl(1);

	for (i = 0; i < OPEN_RETRY; i++) {
	nRetVal = sii_api_open_device(&handle, devicePath);
		if (nRetVal >= 0) {
			break;
		}
		usleep(OPEN_WAIT_TIME);
	}
	if (nRetVal < 0) {
		printf( "ERROR : sii_api_open_device %d\n",nRetVal );
		return nRetVal;
	}
	usleep(OPEN_AFTERWAIT);

	signalControl(0);

	return nRetVal;
}

int PrinterPortClose()
{
	int	ret;

	signalControl(1);

	ret = sii_api_close_device(handle);

	signalControl(0);

	return ret;

}

int PrinterLogoWrite(int index, char *filePath)
{
	int	ret = 0;
	int				nSize;
	unsigned char	pbyCmdBuf[48];
	int				nRetVal;
	size_t			tagRetSize;

	signalControl(1);

	/********************************************************/
	/* 指定された NV グラフィックスデータの消去				*/
	/********************************************************/
	nSize = 0;
	pbyCmdBuf[nSize++] = CMD_GS;
	pbyCmdBuf[nSize++] = '(';		/* 0x28 */
	pbyCmdBuf[nSize++] = 'L';		/* 0x4C */
	pbyCmdBuf[nSize++] = 4;
	pbyCmdBuf[nSize++] = 0;
	pbyCmdBuf[nSize++] = 0x30;
	pbyCmdBuf[nSize++] = 66;
	pbyCmdBuf[nSize++] = 31 + index;
	pbyCmdBuf[nSize++] = 31 + index;
	nRetVal = sii_api_write_device(
					handle,
					pbyCmdBuf,
					nSize,
					&tagRetSize );
	if (nRetVal < 0) {
		printf( "ERROR : sii_api_write_device12 %d\n",nRetVal );
	}

	//ret = tprtss_record_logo(index, filePath);

	signalControl(0);

	return ret;
}


int PrinterReadDevice(unsigned char *readbuf, size_t bufSize, size_t *readSize)
{
	int	ret;

	signalControl(1);

	ret = sii_api_read_device(handle, readbuf, bufSize, readSize);

#if 0
printf("Read Size = %ld\n", *readSize);
int i = 0;
int cnt = 1;
for (i = 0; i < *readSize; i++) {
	printf("0x%02x ",readbuf[i]);
	if (cnt%16 == 0) {
		printf("\n");
	}
	cnt++;
}
printf("\n");
#endif
	signalControl(0);

	return ret;
}

int PrinterWriteDevice(unsigned char *writebuf, size_t bufSize, size_t *writeSize)
{
	int	ret;

#if 0
printf("Write Size = %ld\n", bufSize);
int i = 0;
int cnt = 1;
for (i = 0; i < bufSize; i++) {
	printf("0x%02x ",writebuf[i]);
	if (cnt%16 == 0) {
		printf("\n");
	}
	cnt++;
}
printf("\n");
#endif

	signalControl(1);

	ret = sii_api_write_device(handle, writebuf, bufSize, writeSize);

	signalControl(0);

	return ret;
}

int PrinterGetStatus(unsigned long *status)
{
	int	ret;

	signalControl(1);

	ret = sii_api_get_status(handle, status);

	signalControl(0);

	return ret;

}

int PrinterResetDevice()
{
	int	ret;

	signalControl(1);

	ret = sii_api_reset_device(handle);

	signalControl(0);

	return ret;
}

