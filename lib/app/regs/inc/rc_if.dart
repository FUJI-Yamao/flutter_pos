/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcIf{
  /*********************************************************/
  /* このクラスには GTK+ や PostgreSQLの内容は入れないこと */
  /*********************************************************/

/*----------------------------------------------------------------------*
 * Definitions
 *----------------------------------------------------------------------*/
  static const int OPEN_DRW = 0x10000000;    /* Drower Open Status        */

/* mm_reptlib.hにも在るので、そちらも対応すること	*/
  static const int BASEPORT  = 0x378;          /* Printer Base Port         */
  static const int XPRN_BSY  = 0x80;           /* Printer Status:Busy       */
  static const int XPRN_PE   = 0x20;           /* Printer Status:Drawer open*/
  static const int XPRN_SLCT = 0x10;           /* Printer Status:SLCT       */
  static const int XPRN_ERR  = 0x08;           /* Printer Status:Error      */

  static const int APL_DEVICE_MASK = 0x0000ff00; /* Device Mask             */
}
