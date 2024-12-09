/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: rc_tpoint.h - TPOINT_INPUT_TYP
// 会員番号読取区分
enum TPointInputTyp {
  tPointInputNone,
  tPointInputPos,		    // POS
  tPointInputManual,		// 手入力
  tPointInputMisc,
  tPointInputPhone,
  tPointInputWeb,
  tPointInputBarcode,		// モバイルバーコード
  tPointInputBcdMan,		// モバイルバーコード手入力
}
