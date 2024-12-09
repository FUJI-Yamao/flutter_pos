/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


/// 関連tprxソース:tprdrv_tprtim.h
class DrvPrnDef {
  static const TPRT_PSTAT_INIT = 1;
  static const TPRT_PSTAT_RCV = 2;
  static const TPRT_PSTAT_SYSFAIL = 999;

  //printer command category
  static const TPRT_KIND_CMD = 0;
  static const TPRT_KIND_ECMD = 1;
  static const TPRT_KIND_DATA = 2;
  static const TPRT_KIND_STATUS = 3;
  static const TPRT_KIND_PORTINIT = 4;
  static const TPRT_KIND_PARASTATUS = 5;
  static const TPRT_KIND_FLAGSTATUS = 6;

  // returns
  static const PRN_OK = 0;
  static const PRN_NG = -1;
  static const TPRT_RTN_POFF = -2;
  static const TPRT_RTN_PERR = -3;
  static const TPRT_RTN_PINIT = 1;
  static const TPRTSSDRV = "/dev/usb/tprtss";
  static const TPRTSS2DRV = "/dev/usb/tprtss2";
  static const TPRTCPN = "/dev/usb/tprtcpn";
  static const UPDATE_LOG = "/pj/tprx/tmp/boot_ej.txt";
  static const RCT_PATH = "/bmp/rct/";
  static const CMLOGO_PATH = "/bmp/cmlogo/";
  static const DEFAULT_LOGO = "receipt.bmp";
  static const DEFAULT_LOGO_PATH = "/bmp/rct/$DEFAULT_LOGO";
  static const ASSETS_LOGO = "assets/images/$DEFAULT_LOGO";
  static const TPRT_PRIORITY = 0;
  static const TPRT_MAX_FAIL = 3;
  static const TPRTS_DEBUG = false;
  static const DISP_BUFF = false;
  static const TPRTSS_TMPBUFSIZ = 256;
  static const TPRT_X_DOTS = 640; // 8[dot/mm] x 80[mm]
  static const TPRT_Y_DOTS = 3200; // 8[dot/mm] x 400[mm]
  static const TPRT_SHM_DATASIZE =
      (TPRT_X_DOTS * TPRT_Y_DOTS / 8) + 4 + 4 + 4; // [byte]
  static const TPRT_SHM_DATABOTTOM = TPRT_SHM_DATASIZE - 4; // [byte]
  static const SII_LTPF347_RECIPT_WIDE = 576; // 72 x 8 [dot]
  static const SII_LTPF247_RECIPT_WIDE = 432; // 54mm x 8 [dot]
  static const DRW_DEF_NUM = 0; // Default Pin Appointment
  static const DRW_DEF_T1 = 10; // Default On Time
  static const DRW_DEF_T2 = 50; // Default OFF Time
  static const TPRTS_LOGO_FEED = 8;
  static const TPRTS_CUTAFTR_FEED = 10;
  // TODO:フィードサイズ暫定的に変更中（100 → 48）
  //  static const TPRTS_CUTAFTR_FEED2 = 100;
  static const TPRTS_CUTAFTR_FEED2 = 48;
  static const TPRTS_CUTAFTRLOGO_FEED = 10;
  static const TPRTS_CUTBFRE_FEED = 100; // cut and log feed
  static const TPRTS_CUTBFRE_FEED2 = 50; // cut and log feed
  static const TPRTS_CUTAFT_BFEED = 16;
  static const TPRTS_CUTAFTRLOGO_FEED2 = 40;
  static const TPRTS_BARAFTR_FEED = 15;
  static const CMD_DC2 = '\x12';
  static const CMD_DC3 = '\x13';
  static const CMD_ESC = '\x1b';
  static const CMD_FS = '\x1c';
  static const CMD_GS = '\x1d';
  static const CMD_MAX = 8000;
  static const CMD_DATA_MAX = 200;
  static const CMD_DATA_MAX80 = 360;
  static const WRITE_CNT_MAX = 15;
  static const WRITE_BUF_SIZ = (WRITE_LEN_MAX + 3);
  static const WRITE_LEN_MAX = 1000;
  static const READ_BUF_SIZ = 512;
  static const DATA_SAVE_CTRL_MAX = 3;
  static const DATA_SAVE_1 = 0x1F;
  static const DATA_SAVE_2 = 0x0E;
  static const DATA_SAVE_3 = 0x0F;
  static const DATA_SAVE_SIZ_MAX = 6;
  static const TPRTSS_STAT_PAPEREND = 0x00000010;
  static const TPRTSS_STAT_NEAREND = 0x00000020;
  static const TPRTSS_STAT_PRTNOPN = 0x00000080;
  static const TPRTSS_STAT_CUTERR = 0x00000008;
  static const TPRTSS_STAT_DRWHIGH = 0x00008000;
  static const TPRTSS_DENSITY_80 = 85;
  static const TPRTSS_DENSITY_0 = 95;
  static const TPRTSS_DENSITY_1 = 100;
  static const TPRTSS_DENSITY_2 = 105;
  static const TPRTSS_DENSITY_3 = 110;
  static const TPRTSS_DENSITY_RPD_0 = 80;
  static const TPRTSS_DENSITY_RPD_1 = 85;
  static const TPRTSS_DENSITY_RPD_2 = 90;
  static const TPRTSS_DENSITY_RPD_3 = 100;
  static const TPRTSS_ROOP_TIME = 500000;
  static const TPRTSS_OPEN_RETRY = 20;
  static const TPRTSS_OPEN_WAITTIME = 200000;
  static const TPRTSS_OPEN_AFTERWAIT = 300000;
  static const TPRTSS_RESET_WAITTIME = 500000;
  static const TPRTSS_SEMOP_RETRY = 200;
  static const TPRTSS_SEMOP_WAIT = 10000;
  static const TPRTSS_DWNLD_RETRY = 100;
  static const TPRTSS_DWNLD_WAITTIME = 100000;
  static const TPRTSS_READ_RETRY = 8;
  static const TPRTSS_READ_WAITTIME = 100000;
  static const RPCONNECT = 1;
  static const RPCONNECT2 = 2;
  static const RPCONNECT3 = 3; // PT06
  static const RPCONNECT4 = 4; // SLP720RT
  static const DESK_PRINTER = 1;
  static const QCJC_PRINTER = 2;
  static const COUPON_PRINTER = 3;
  static const HW_RESET_MAX = 3;
  static const HW_RECOVER = 0;
  static const HW_ERROR = 1;
  static const SWDIP_CHK_MAX = 5;
  static const SWDIP_CHK_MAX_RP = 7;

  static const SWDIP_INIT = [
    "\xde",
    "\xc5", // 58mm Center; 392dot; 300mm/sec
    "\x81", // TF50KS-E2D
    "\x64", // 100%
    "\x78" // AutoStatus Enable; Error through Enable; Partial Cut
  ];
  static const SWDIP_INIT_RP = [
    "\x7f", // LED Enable; AutoActivation by AC Enable; PowerSW Disable
    "\xe0", // Error Buzzer Disable
    "\xe0", // Cut Buzzer Disable
    "\xf7", // 2div./288dots; Dynamic; 58mm ; 576/432dots; High Speed
    "\x78", // AutoStatus Enable; Init Resonse Enable; Error through Enable; NearEnd Error Disable; Partial Cut
    "\x06", // 100%
    "\x04" // KT48FA
  ];
  static const SWDIP_INIT_RP80 = [
    "\x7f", // LED Enable; AutoActivation by AC Enable; PowerSW Disable
    "\xe0", // Error Buzzer Disable
    "\xe0", // Cut Buzzer Disable
    "\xff", // 2div./288dots; Dynamic; 80mm ; 576/432dots; High Speed
    "\x78", // AutoStatus Enable; Init Resonse Enable; Error through Enable; NearEnd Error Disable; Partial Cut
    "\x06", // 100%
    "\x02" // KT48FA
  ];
  static const SWDIP_INIT_RPE = [
    "\x7b", // LED Enable; AutoActivation by AC Enable; PowerSW Disable
    "\xe0", // Error Buzzer Disable
    "\xe0", // Cut Buzzer Disable
    "\xf7", // 2div./288dots; Dynamic; 58mm ; 576/432dots; High Speed
    "\x78", // AutoStatus Enable; Init Resonse Enable; Error through Enable; NearEnd Error Disable; Partial Cut
    "\x06", // 100%
    "\x04" // KT48FA
  ];
  static const SWDIP_INIT_PT06 = [
    "\xd7", // LED Enable; AutoActivation by AC Enable; PowerSW Disable
    "\xf0", // Error Buzzer Disable
    "\xf0", // Cut Buzzer Disable
    "\xf7", // 2div./288dots; Dynamic; 58mm ; 576/432dots; High Speed
    "\x78", // AutoStatus Enable; Init Resonse Enable; Error through Enable; NearEnd Error Disable; Partial Cut
    "\x06", // 100%
    "\x00" // Standard
  ];
  static const SWDIP_INIT_SLP = [
    "\x6f", // TakenSensor Disable, MarkSensor Disable, LED Green, AutoActivation by AC Enable, PowerSW Disable
    "\xe0", // Error Buzzer Disable
    "\xe0", // Cut Buzzer Disable
    "\xff", // Paper 58mm, PaperAutoDetection Disable, PrintSpeed High
    "\x78", // AutoStatusBack Enable, InitResonse Enable, ErrorThrough Enable, ResponseDataDiscarding Disable, PaperSetHandle Disable, CuttingMethod Partial
    "\x03", // 85%
    "\x00" // Receipt
  ];
}

class READ_RET_ENUM {
  static const READ_SYSERR = -2;
  static const READ_ERR = -1;
  static const READ_NONE = 0;
  static const READ_CHAR = 1;
  static const READ_HEX = 2;
  static const READ_REPLY = 3;
  static const READ_INIT_HW = 4;
  static const READ_INIT_SW = 5;
  static const READ_INIT_CMD = 6;
  static const READ_STAT = 7;
  static const READ_DOWNLOAD_1 = 8;
  static const READ_DOWNLOAD_2 = 9;
}

// printer command request
class TprtssCmdMsg {
  int kind = 0; // category
  int length = 0; // length = command + parameter
  String cmd = ""; // command
  List<String> param = []; // parameter
  String printData = ""; // printer command & data
}

// reply
class TprtssReplyMsg {
  int kind = 0; // category
  String cmd = ""; // command
}

// extend printer command request
class TprtssECmdMsg {
  int kind = 0; // category
  int length = 0; // length = command + parameter
  String cmd = ""; // command
  List<String> param = []; // parameter (+file path)
}

// status reply
class TprtssSttsMsg {
  int kind = 0; // category
  int status = 0; // printer status
}

// message union
class TprtssMsg {
  int kind = 0;
  TprtssCmdMsg tprtssCmdMsg = TprtssCmdMsg();
  TprtssReplyMsg tprtssReplyMsg = TprtssReplyMsg();
  TprtssECmdMsg tprtssECmdMsg = TprtssECmdMsg();
  TprtssSttsMsg tprtssStatusMsg = TprtssSttsMsg();
}

class BitmapFileHdr {
  String bfType = "";
  int bfSize = 0;
  int bfReserved1 = 0;
  int bfReserved2 = 0;
  int bfOffBits = 0;
}

class BitmapInfoHdr {
  int biSize = 0;
  int biWidth = 0;
  int biHeight = 0;
  int biPlanes = 0;
  int biBitCount = 0;
  int biCompression = 0;
  int biSizeImage = 0;
  int biXPixPerMeter = 0;
  int biYPixPerMeter = 0;
  int biClrUsed = 0;
  int biClrImportant = 0;
}

class BitmapRGBquad {
  String rgbBlue = "";
  String rgbGreen = "";
  String rgbRed = "";
  String rgbReserved = "";
}

class Tprtss_ShmBuf {
  int wrPtr = 0; // write start pointer
  int rdPtr = 0; // read start pointer
  String data = ""; // print data
}
/// Semaphore Parameter <sys/sem.h>
class SemBuf {
	int semNum = 0;	/* セマフォ番号 */
	int semOp = 0;		/* セマフォ操作 */
	int semFlg = 0;	/* 操作フラグ */
}

enum CMD_ENUM {
  TPRTS_CMD_RESET,
  TPRTS_CMD_CSPC0,
  TPRTS_CMD_LSPC6,
  TPRTS_CMD_SJIS,
  TPRTS_CMD_N_AB,
  TPRTS_CMD_NOTRES,
  TPRTS_CMD_LMSB,
  TPRTS_CMD_CHAR_REG,
  TPRTS_CMD_CHAR_PRINT,
  TPRTS_CMD_NVBIT_REG,
  TPRTS_CMD_CUT,
  TPRTS_CMD_PALSE,
  TPRTS_CMD_NVBIT_PRINT,
  TPRTS_CMD_FEED,
  TPRTS_CMD_SPEED,
  TPRTS_CMD_DENSITY,
  TPRTS_CMD_ERR_THROW,
  TPRTS_CMD_BMP,
  TPRTS_CMD_BARCODE,
  TPRTS_CMD_LINE,
  TPRTS_CMD_INTERNATIONAL,
  TPRTS_CMD_CODETABLE,
  TPRTS_CMD_FONT,
  TPRTS_CMD_KANJI,
  TPRTS_CMD_DLBMP_PRINT,
  TPRTS_CMD_BFEED,
  TPRTS_CMD_LOGO_CENTERING,
  TPRTS_CMD_FULLCUT,
  TPRTS_CMD_CENTERING_CANCEL,
  TPRTS_CMD_HW_RESET,
  TPRTS_CMD_MARGIN_RESET
}

enum READ_ANALYSIS_ENUM {
  ANALYSIS_NONE,
  ANALYSIS_SWDIP,
  ANALYSIS_VER,
  ANALYSIS_ID,
  ANALYSIS_REPLY,
  ANALYSIS_DOWNLOAD_1,
  ANALYSIS_DOWNLOAD_2,
  ANALYSIS_MCOUNTER,
  ANALYSIS_GETSTAT,
  ANALYSIS_MAX
}
