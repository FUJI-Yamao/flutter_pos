/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rcmbr_fsp.h - #define
class RcMbrFsp {
  static const POINT_CALC = 0;
  static const FSP_CALC = 1;
}

/// 会員複数売価動作状態
/// 関連tprxソース: rcmbr_fsp.h - enum ANYPRC_STET
enum AnyprcStet {
  STAT_NONE(0),  /* ０：しない */
  STAT_ADD(1),  /* １：加算 */
  STAT_SVC(2),  /* ２：サービス */
  STAT_ADD_SVC(3);  /* ３：加算＋サービス */

  final int value;
  const AnyprcStet(this.value);
}
