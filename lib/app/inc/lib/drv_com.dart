/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
/// ドライバ共通定数
///  関連tprxソース:drv_com.h
class DrvCom {
  /// drv local define
  static const COM = "com";          /* com name index */
  static const TTYS = "/dev/ttyS";    /* TTY prefix */
  static const TTYUSB = "/dev/ttyUSB";  /* TTY prefix */
  static const TTYFIP = "/dev/ttyFIP";  /* TTY prefix */
  static const TTYSCAN = "/dev/ttySCAN"; /* TTY prefix */
  static const TTYMSR = "/dev/ttyMSR";  /* TTY prefix */
  static const TTYSELF = "/dev/ttySELF"; /* TTY prefix */
  static const TTYMST = "/dev/ttyMST";
  static const TTYPASS = "/dev/ttyPASS"; /* TTY prefix */
  static const TTYAPBF = "/dev/ttyAPBF"; /* TTY prefix */

  static const ACK = "\x06";
  static const NAK = "\x15";
  static const ETB = "\x17";
  static const BEL = "\x07";
  static const NUL = "\x00";

  static const BUFFSIZ = 1024;

  /// default com parameters
  static const CHANGER_TTY_BAUDRATE = 2400;    /* baud rate */
  static const CHANGER_TTY_DATABIT = 7;       /* data bit */
  static const CHANGER_TTY_PARTY = 'E';      /* parity */
  static const CHANGER_TTY_STARTBIT = 1;       /* start bit */
  static const CHANGER_TTY_STOPBIT = 1;       /* stop bit */

  static const LINBUFSIZ = 260;
  static const LINEBUFSIZ = 260;
  static const MAXRETRYCNT = 3;           /* max retry count */
  static const PATHSIZ = 1024;

  //static const SUBCPU_CENTER_MOUSE = _IO('s', 5);
  //static const SUBCPU_MOVE_MOUSE = _IOW('s', 3, unsigned long *);
  //static const SUBCPU_ORIGIN_MOUSE = _IO('s', 6);

  static const SYS_INI = "conf/sys.ini";
  static const MACINFO_INI = "conf/mac_info.ini";
  static const QC_INI = "conf/qcashier.ini";
}

