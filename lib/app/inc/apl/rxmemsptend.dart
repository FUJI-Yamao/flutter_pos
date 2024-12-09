/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 一時格納用スプリット情報
/// 関連tprxソース:rxmemreason.h - RXMEM_TEMP_SPTEND
class RxMemTempSptend {
  int num = 0;		/* スプリット段数 */
  int keyCd = 0;		/* スプリットキーコード */
  int data = 0;		/* スプリット額 */
  int cnt = 0;		/* 回数 */
  int qty = 0;		/* 枚数 */
  int amt = 0;		/* 金額 */
  int drwAmt = 0;	/* 理論在高 */
  /* 伊徳様仕様時、プリペイド関連で使用しているスプリット情報一時保存メモリ */
  int privilegeAmt = 0;
  int privilege8Amt = 0;
  int privilege8Tax = 0;
  int privilege10Amt = 0;
  int privilege10Tax = 0;
  int privilegeothAmt = 0;
  int privilegeothTax = 0;
  int privilegeoutAmt = 0;
}