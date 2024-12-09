/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: chg_asc.c
class ChgAsc{

	/// Foramt	: char cm_chg_asc (short opt, char bcd_data);
	/// Input	: short opt	option
	/// 			0: 0x0a-0x0f --> 0x3a(:)-0x3f(?)
	/// 			1: 0x0a-0x0f --> 0x41(A)-0x46(F)
	/// 			2: 0x0a-0x0f --> 0x61(a)-0x66(f)
	/// 			other: same as optin "0"
	/// 	  char bcd_data	BCD data (1 digit)
	/// Output	: void
  /// 
	/// Change BCD low NIBBLE to ASCII
	/// 	BCD (1 digit) --> ASCII (1 byte)
	/// 	0x12 --> '2'
  ///  関連tprxソース: chg_asc.c - cm_chg_asc
  static String cmChgAsc (
      int	opt,		/* option */
            /*	0: 0x0a-0x0f --> 0x3a(:)-0x3f(?) */
            /*	1: 0x0a-0x0f --> 0x41(A)-0x46(F) */
            /*	2: 0x0a-0x0f --> 0x61(a)-0x66(f) */
            /*  other: same as optin "0" */
      int	bcdData	/* BCD data (1 digit) */ ) {
    bcdData &= 0x0F;
    if (bcdData < 0x0A) {
      bcdData |= 0x30;
    } else {
      switch (opt) {
          case  1: bcdData -= 0x09; bcdData |= 0x40; break;	/* 'A'-'F' */
          case  2: bcdData -= 0x09; bcdData |= 0x60; break;	/* 'a'-'f' */
          default:		       bcdData        |= 0x30; break;	/* ':'-'?' */
      }
    }
    return (String.fromCharCode(bcdData));				/* return ASCII data */
  }
}