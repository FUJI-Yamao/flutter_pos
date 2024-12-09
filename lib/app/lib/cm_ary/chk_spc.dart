/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  chk_spc.dart	 :  Common functions for array
///  関連tprxソース  :  chk_spc.c

class ChkSpc {

  static const int SPC   = 0x20;
  static const bool TRUE  = true;   /* 真 */
  static const bool FALSE = false;  /* 偽 */
  static const int E_OK  = 0;       /* 正常終了 */

/*
 *		Find out space code (ASCII)
 *
 *	Foramt	: bool cm_chk_spc(char *dst, int size)
 *	Input	: char *dst		destination address
 *			  int size		size of ASCII buffer
 *	Output	: bool result	if destination data is all'SPACE' character, then
 *							return FALSE, else return TRUE.
 */
  ///  Find out space code (ASCII)
  ///
  ///  引数　dst  検索対象
  ///
  ///  　　　size 検索対象の文字数
  ///
  ///  戻値　全てスペースであればFALSE、否ならTRUE
  ///
  ///  関連tprxソース: chk_spc.c - cm_chk_spc()
  static bool cmChkSpc (String dst, int size) {
    String spase = " " * size;
    if (dst == spase) {
      return (FALSE);
    }
    return (TRUE);
  }
}