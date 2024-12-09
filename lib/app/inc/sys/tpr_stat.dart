/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// 関連tprxソース:tprstat.h
///

/// System Status Number.
/// System Status Number
/// System Status shown below are supported in TPR-X System Control
/// and classified into System Basic Status, System Detail Status,
/// and System Fail Status.
/// Each Status fields are:
///	 15(MSB)     12 11            8 7                             0(LSB)
///	|--------------|---------------|-------------------------------|
///	  System Basic   System Detail      Syetem Fail Status
///	  Status         Status
class TprStatDef {
  /// Mask Constant of System Status
  static const TPRTST_BASIC = 0xf000;
  static const TPRTST_DETAIL = 0x0f00;
  static const TPRTST_FAIL = 0x00ff;

  /// System Basic Status
  static const TPRTST_NOTREADY = 0x0000; /* not executed */
  static const TPRTST_READY = 0x1000; /* executed */
  static const TPRTST_PAUSE = 0x2000; /* executed and pause */
  static const TPRTST_BUSY = 0x4000; /* executed and pause */

  /// System Detail Status
  static const TPRTST_IDLE = 0x8000; /* idle */
  static const TPRTST_EXECUTING = 0x0100; /* executing */

  /// System Fail Status
  static const TPRTST_NOPROBLEM = 0x0000;
  static const TPRTST_EMERG = 0x0001; /* emergency */
  static const TPRTST_ALERT = 0x0002; /* alert */
  static const TPRTST_WARNING = 0x0004; /* warning */

  /// Main function status
  static const TPRTST_STATUS01 = 0x0100; /* status 1 */
  static const TPRTST_STATUS02 = 0x0200; /* status 2 */
  static const TPRTST_STATUS03 = 0x0300; /* status 3 */
  static const TPRTST_STATUS04 = 0x0400; /* status 4 */
  static const TPRTST_STATUS05 = 0x0500; /* status 5 */
  static const TPRTST_STATUS06 = 0x0600; /* status 6 */
  static const TPRTST_STATUS07 = 0x0700; /* status 7 */
  static const TPRTST_STATUS08 = 0x0800; /* status 8 */
  static const TPRTST_STATUS09 = 0x0900; /* status 9 */
  static const TPRTST_STATUS10 = 0x0A00; /* status 10 */
  static const TPRTST_STATUS11 = 0x0B00; /* status 11 */
  static const TPRTST_STATUS12 = 0x0C00; /* status 12 */
  static const TPRTST_STATUS13 = 0x0D00; /* status 13 */
  static const TPRTST_STATUS14 = 0x0E00; /* status 14 */
  static const TPRTST_STATUS15 = 0x1000; /* status 15 */
  static const TPRTST_STATUS16 = 0x1100; /* status 16 */
  static const TPRTST_STATUS17 = 0x1200; /* status 17 */
  static const TPRTST_STATUS18 = 0x1300; /* status 18 */

  static const TPRTST_STATUS21 = 0x2000;
  static const TPRTST_STATUS22 = 0x2100;
  static const TPRTST_STATUS23 = 0x2200;
  static const TPRTST_STATUS24 = 0x2300;
  static const TPRTST_STATUS25 = 0x2400;
  static const TPRTST_STATUS26 = 0x2500;
  static const TPRTST_STATUS27 = 0x2600;
  static const TPRTST_STATUS28 = 0x2700;
  static const TPRTST_STATUS29 = 0x2800;
  static const TPRTST_STATUS30 = 0x2900;
  static const TPRTST_STATUS31 = 0x2A00;
  static const TPRTST_STATUS32 = 0x2B00;
  static const TPRTST_STATUS33 = 0x2C00;
  static const TPRTST_STATUS34 = 0x2D00;
  static const TPRTST_STATUS35 = 0x2E00;
  static const TPRTST_STATUS36 = 0x2F00;
  static const TPRTST_STATUS37 = 0x3000;
  static const TPRTST_STATUS38 = 0x3100;

  /// 業務モード仕様
  static const TPRTST_STATUS41 = 0x4100; /* status 1 */
  static const TPRTST_STATUS42 = 0x4200; /* status 2 */
  static const TPRTST_STATUS43 = 0x4300; /* status 3 */
  static const TPRTST_STATUS44 = 0x4400; /* status 4 */
  static const TPRTST_STATUS45 = 0x4500; /* status 5 */
  static const TPRTST_STATUS46 = 0x4600; /* status 6 */
  static const TPRTST_STATUS47 = 0x4700; /* status 7 */
  static const TPRTST_STATUS48 = 0x4800; /* status 8 */
  static const TPRTST_STATUS49 = 0x4900; /* status 9 */
  static const TPRTST_STATUS50 = 0x4A00; /* status 10 */
  static const TPRTST_STATUS51 = 0x4B00; /* status 11 */
  static const TPRTST_STATUS52 = 0x4C00; /* status 12 */
  static const TPRTST_STATUS53 = 0x4D00; /* status 13 */
  static const TPRTST_STATUS54 = 0x4E00; /* status 14 */
  static const TPRTST_STATUS55 = 0x5000; /* status 15 */
  static const TPRTST_STATUS56 = 0x5100; /* status 16 */
  static const TPRTST_STATUS57 = 0x5200; /* status 17 */
  static const TPRTST_STATUS58 = 0x5300; /* status 18 */

  /// 入出金モード仕様
  static const TPRTST_STATUS101 = 0xA100; /* status 1 */
  static const TPRTST_STATUS102 = 0xA200; /* status 2 */
  static const TPRTST_STATUS103 = 0xA300; /* status 3 */
  static const TPRTST_STATUS104 = 0xA400; /* status 4 */
  static const TPRTST_STATUS105 = 0xA500; /* status 5 */
  static const TPRTST_STATUS106 = 0xA600; /* status 6 */
  static const TPRTST_STATUS107 = 0xA700; /* status 7 */
  static const TPRTST_STATUS108 = 0xA800; /* status 8 */
  static const TPRTST_STATUS109 = 0xA900; /* status 9 */
  static const TPRTST_STATUS110 = 0xAA00; /* status 10 */
  static const TPRTST_STATUS111 = 0xAB00; /* status 11 */
  static const TPRTST_STATUS112 = 0xAC00; /* status 12 */
  static const TPRTST_STATUS113 = 0xAD00; /* status 13 */
  static const TPRTST_STATUS114 = 0xAE00; /* status 14 */
  static const TPRTST_STATUS115 = 0xB000; /* status 15 */
  static const TPRTST_STATUS116 = 0xB100; /* status 16 */
  static const TPRTST_STATUS117 = 0xB200; /* status 17 */
  static const TPRTST_STATUS118 = 0xB300; /* status 18 */

  static const TPRTST_INIT = 0x5500;
  static const TPRTST_MENTE = 0x6600; /* mentenance mode */
  static const TPRTST_STATUS77 = 0x7700; /* SCPU download */
  static const TPRTST_STATUS88 = 0x8800; /* test mode */
  static const TPRTST_STATUS99 = 0x9900; /* calibration */
  static const TPRTST_START = 0xFF00; /* system init */
  static const TPRTST_POWEROFF = 0x1400;
  static const TPRTST_HISTGET = 0x1500; /* history get */
  static const TPRTST_RESETDEV = 0x1600; /* reset device */
  static const TPRTST_SELFCHG = 0x1700; /* self change */
  static const TPRTST_ACXCHG = 0x1800; /* acx change */
  static const TPRTST_SUICAOPN = 0x1900; /* suica change */
  static const TPRTST_USBCHK = 0x5600; /* usb connect check */
  static const TPRTST_TWOCONNECT = 0x5700; /* two connect system change */
  static const TPRTST_SP_SETING = 0x5800; /* SP department seting */
  static const TPRTST_CASH_RECYCLE = 0x5900; /* cash recycle */
  static const TPRTST_ACXRECALG = 0x5A00; /* 在高不確定解除 */
  static TPRTST_GETSTS(sts) => (sts & 0xff00);
}
