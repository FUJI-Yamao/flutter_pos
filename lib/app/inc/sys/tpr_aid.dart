/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// アプリケーションID定義
/// 関連tprxソース:tpraid.h
///
class Tpraid {
  static const TPRAID_NONE = 0x00000000;	/* none task (anonymouse) */
  static const TPRAID_SYST = 0x00000001;	/* sys task */
  static const TPRAID_CHK = 0x00000002;	/* regs:checker */
  static const TPRAID_CASH = 0x00000003;	/* regs:casher */
  static const TPRAID_SPL = 0x00000004;	/* regs:spool */
  static const TPRAID_UPD = 0x00000005;	/* regs:update */
  static const TPRAID_PRN = 0x00000006;	/* regs:print */
  static const TPRAID_MASK = 0x00000007;	/* regs:task id */
  static const TPRAID_MUPD = 0x00000008;	/* backend:update */
  static const TPRAID_HIST = 0x00000009;	/* backend:history */
  static const TPRAID_VUP_DB = 0x0000000a;	/* version up:db */
  static const TPRAID_DRW = 0x0000000b;	/* regs:drw */
  static const TPRAID_ACX = 0x0000000c;	/* regs:acx */
  static const TPRAID_JPO = 0x0000000d;	/* regs:jpo */
  static const TPRAID_SCL = 0x0000000e;	/* regs:scl */
  static const TPRAID_RWC = 0x0000000f;	/* regs:rwc */

  static const TPRAID_MNTSPL = 0x00000010;
  static const TPRAID_IIS = 0x00000011; /* regs:iis */
  static const TPRAID_SGSCL1 = 0x00000012;	/* regs:self-gate scl1 */
  static const TPRAID_SGSCL2 = 0x00000013;	/* regs:self-gate scl2 */
  static const TPRAID_HQFTP = 0x00000014;	/* backend:send csv data to HQ */
  static const TPRAID_SUPD = 0x00000015;	/* backend:sub update */
  static const TPRAID_HQHIST = 0x00000016;	/* backend:TX/RX history log for HQASP */
  static const TPRAID_ELCHK = 0X00000017;	/* regs checker: electric log - only use Login */
  static const TPRAID_ELCASH = 0X00000018;	/* regs cashier: electric log - only use Login */
  static const TPRAID_MOBILE = 0x00000019;	/* regs:mobile */
  static const TPRAID_STPR = 0x0000001a;	/* regs:stpr */
  static const TPRAID_HISTORY = 0x0000001b;	/* history */
  static const TPRAID_SOUND = 0x0000001c; /* sound */
  static const TPRAID_MCFTP = 0x0000001d; /* backend:send mclog to */
  static const TPRAID_S2PR = 0x0000001e;	/* regs:s2pr */
  static const TPRAID_BANK = 0x0000001f;  /* bankprg   */
  static const TPRAID_HQPROD = 0x00000020;	/* backend:send Prpdecer Sale Data */
  static const TPRAID_SOUND2 = 0x00000021;	/* sound */
  static const TPRAID_SUICA = 0x00000022;	/* regs:suica */
  static const TPRAID_ACXREAL = 0x00000023;	/* acx real */
  static const TPRAID_MP1 = 0x00000024;	/* MP1 */
  static const TPRAID_MULTI = 0x00000025;	/* regs:multi */
  static const TPRAID_ICC = 0x00000026;	/* regs:icc */
  static const TPRAID_JPO_TM = 0x00000027;  /* regs:jpo time */
  static const TPRAID_CUSTREAL = 0x00000028;	/* regs:real */
  static const TPRAID_HIST_CSRV = 0x00000029;	/* backend:hist_csrv */
  static const TPRAID_WIZS = 0x0000002a;	/* regs:WizS */
  static const TPRAID_WIZC = 0x0000002b;	/* regs:WizC */
  static const TPRAID_CUSTREAL_NETDOA = 0x0000002c;	/* regs:netDoA cust real */
  static const TPRAID_CREDIT = 0x0000002d;	/* regs:credit */
  static const TPRAID_NTTD_PRECA = 0x0000002e;	/* regs:NTT DATA Prepaid Card */
  static const TPRAID_CASH_RECYCLE = 0x0000002f;	/* cash recycle */

  static const TPRAID_REGLOG = 0x00000030;	/* manage pc log */
  static const TPRAID_FTPLOG = 0x00000031;	/* FTP communication log */
  static const TPRAID_ICCLOG = 0x00000032;	/* IC_Connect LIB log */
  static const TPRAID_CUSTREAL2 = 0x00000034;	/* regs:custreal2 */
  static const TPRAID_CUSTREAL_NEC = 0x00000035;	/* regs:nec cust real */
  static const TPRAID_MULTI_TMN = 0x00000036;	/* regs:multi_tmn */
  static const TPRAID_QCJC_C_PRN = 0x00000037;	/* regs:QCJC_C print */
  static const TPRAID_MULTI_GLORY = 0x00000038;	/* regs:multi_glory */
  static const TPRAID_QCJC_C_MNTPRN = 0x00000039;	/* regs:QCJC_C MNT print */
  static const TPRAID_SQRC = 0x0000003a;  /* regs:SQRC Ticket */
  static const TPRAID_TRK_PRECA = 0x0000003b;	/* regs:Teraoka Prepaid Card */
  static const TPRAID_REPICA = 0x0000003c;	/* regs:Repica Prepaid Card */
  static const TPRAID_KITCHEN1_PRN = 0x0000003d;	/* regs:Kitchen1 print */
  static const TPRAID_KITCHEN2_PRN = 0x0000003e;	/* regs:Kitchen2 print */
  static const TPRAID_COGCA = 0x0000003f;	/* regs:Cogca Prepaid Card */

  static const TPRAID_CUSTREAL_ODBC = 0x00000040;	/* regs:ODBC cust real */
  static const TPRAID_CUSTRESV = 0x00000041;	/* backend:cust reserve update */
  static const TPRAID_VALUECARD = 0x00000044;	/* regs:バリューカード仕様 */
  static const TPRAID_AJS_EMONEY = 0x00000046;	/* regs:Ajs Emoney Prepaid Card */
  static const TPRAID_PRINT_COM = 0x00000047;	/* 印字プロセス */
  static const TPRAID_COLORDSP_MSG = 0x00000048;	/* カラー客表メッセージ表示 */
  static const TPRAID_MULTI_PANA = 0x0000004c;	/* WAON仕様 [Panasonic] */
  static const TPRAID_BARCODE_PAY = 0x0000004d;	/* バーコード決済 */
  static const TPRAID_VEGA3000 = 0x0000004e;	/* regs:VEGA3000 Terminal */
  static const TPRAID_SHOP_GO_API = 0x00000140;	/* Shop&Go API通信 */

  static const TPRAID_PMOD = 0x00000050;	/* program mode */

  static const TPRAID_SYSINI = 0x00000051;	/* sys task initial log */

  static const TPRAID_REPT = 0x00000052;	/* report mode */
  static const TPRAID_RETOTAL = 0x00000053;	/* retotal mode */
  static const TPRAID_KILL = 0x00000054;	/* backend:kill_proc */
  static const TPRAID_KILLCHD = 0x00000055;	/* backend:kill_child */
  static const TPRAID_STR = 0x00000056;	/* store open close */
  static const TPRAID_FREQ = 0x00000057;	/* file request */
  static const TPRAID_FCON = 0x00000058;	/* file confirm */
  static const TPRAID_TCOUNT = 0x00000059;	/* table count */
  static const TPRAID_USETUP_AUTO = 0x0000005a;	/* user setup of auto stropncls */
  static const TPRAID_DPOINT = 0x0000005c;	/* ｄポイント仕様 */
  static const TPRAID_OFF = 0x00000060;	/* offline log */
  static const TPRAID_CSV = 0x00000061;	/* csv send proc */
  static const TPRAID_CSV2 = 0x00000062;	/* csv send proc */
  static const TPRAID_CSVS = 0x00000063;	/* csv server proc */
  static const TPRAID_SCHCTRL = 0x00000064;	/* csv server proc */
  static const TPRAID_MENTES = 0x00000065;	/* mentenance server */
  static const TPRAID_MENTESS = 0x00000066;	/* mentenance server special */
  static const TPRAID_MENTEC = 0x00000067;	/* mentenance client */
  static const TPRAID_DATAREAD = 0x00000068;	/* txt data read */
  static const TPRAID_CHPRICE = 0x00000069;	/* chprice */
  static const TPRAID_SUBVERUP = 0x0000006a;	/* mentenance subverup */
  static const TPRAID_UPD_ERLOG = 0x0000006b;	/* mentenance upd erlog confirm */
  static const TPRAID_USETUP_SELF = 0x0000006c;	/* user setup of self */
  static const TPRAID_FCLSETUP = 0x0000006d;	/* fcl setup */
  static const TPRAID_USETUP_CMLOGO = 0x0000006e;	/* user setup of cm logo */
  static const TPRAID_USETUP_WIZ = 0x0000006f;	/* user setup of wiz */

  static const TPRAID_PROCINST = 0x00000070;	/* process instration proc */
  static const TPRAID_OPNCLS = 0x00000071;	/* open close */
  static const TPRAID_PBCHGLOG = 0x00000072;	/* pbchg send log */
  static const TPRAID_MASR = 0x00000073;	/* masr log */
  static const TPRAID_UPDCON = 0x00000077;	/* update process control */
  static const TPRAID_FTP = 0x00000078; /* ftp lib */
  static const TPRAID_MOVIE = 0x00000079; /* Movie send */

  static const TPRAID_USETUP_VESCA = 0x0000007b;	/* user setup of vesca */
  static const TPRAID_USETUP_COLORFIP15 = 0x0000007c;	/* user setup of 15inch colorfip */
  static const TPRAID_USETUP_DPOINT = 0x0000007d;	/* user setup of dpoint */

  static const TPRAID_TAXFREE = 0x0000007f;	/* 免税サーバー通信 */

  static const TPRAID_MUPDS = 0x00000080;	/* NEW_TRANS server */
  static const TPRAID_FENCE_OVER = 0x00000081;	/* Fence Over */
  static const TPRAID_WSERRCHK = 0x00000082;	/* WS Data Error Log */
  static const TPRAID_RPOINT = 0x00000083;	/* 楽天ポイント通信 */

  static const TPRAID_QUICK = 0x00000090;	/* mentenance quicke DSD */
  static const TPRAID_QUICK_RSV = 0x00000091;	/* mentenance reserve set, exe, rtn */
  static const TPRAID_RSV_CUSTREAL = 0x00000092;	/* mentenance reserve custreal */
  static const TPRAID_QUCIK_NEW = 0x00000097;	/* mentenance Quicke Setup(for Checkout Revolution)  */

  static const TPRAID_SPQCS = 0x00000093;	/* Speeza & QCashier Server */
  static const TPRAID_SPQCC = 0x00000094;	/* Speeza & QCashier Client */
  static const TPRAID_QCSELECT_SVR = 0x00000095;	// KY_QCSELECT Data Server
  static const TPRAID_QCCONNECT = 0x00000096;	// QCashier Status Get Proc
  static const TPRAID_NETDOA_PQS = 0x00000098;	// Custreal NetDoa PQS
  static const TPRAID_TPOINT_FTP = 0x0000009a;	// T-Point FTP
  static const TPRAID_QUICK_RESETUP = 0x0000009b;	// QUICK_RESETUP
  static const TPRAID_USETUP_AUTH = 0x0000009c; /* user setup of wireless lan */
  static const TPRAID_LOOP_CNCT = 0x0000009d;	// Loop Connect
  static const TPRAID_HWINFO_SEND = 0x0000009e;	// HW情報　ポータルサーバー送信

  static const TPRAID_DRVCHECK = 0x00000099;	/* driver check */
  static const TPRAID_ECOA = 0x00000111;	/* ecoa server */
  static const TPRAID_AUTO_STROPNCLS = 0x00000112;	/* 自動開閉店 */
  static const TPRAID_ACX_STOCK = 0x00000acb;	// 釣銭機在高

  static const TPRAID_MAIL_SENDER = 0x00000201;	/* 電子メール送信 */
  static const TPRAID_USETUP_MAIL_SENDER = 0x00000202;	/* user setup of 電子メール送信 */
  static const TPRAID_DUMMY_PRN = 0x00000203;	/* regs:dummy print */

  static const TPRAID_STAFF_BUTTON = 0x00002000; /* 店員操作画面 */
  static const TPRAID_CUSTOMER_BUTTON = 0x00015000; /* 客操作画面 */

  static const TPRAID_ACTUAL_RESULTS = 0x77777777;  /* 実績集計 */

  static const TPRAID_SYSTEM = 0xffffffff;	/* recog */
}
