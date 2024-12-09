/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: L_rccrdt.h
class LRccrdt{
/************************************************************************/
/*                      #define Image Datas                             */
/************************************************************************/
  static const String MSG_KEYINQ_MNG = "鍵配信処理";
  static const String	CCT_PAYMENT = "決済";
  static const String IMG_YAMATO_EDY = "Ｅｄｙ";
  static const String IMG_YAMATO_SUICA = "Ｓｕｉｃａ";
  static const String IMG_YAMATO_WAON  = "ＷＡＯＮ";
  static const String IMG_YAMATO_NANACO = "ｎａｎａｃｏ";
  static const String IMG_YAMATO_EMONEY = "電子マネー";
  static const String IMG_YAMATO_BAL_EDY = "Ｅｄｙ残高【%ld円】";
  static const String IMG_YAMATO_BAL_SUICA = "Ｓｕｉｃａ残高【%ld円】";
  static const String IMG_YAMATO_BAL_WAON = "ＷＡＯＮ残高【%ld円】";
  static const String IMG_YAMATO_BAL_NANACO = "ｎａｎａｃｏ残高【%ld円】";
  static const String IMG_YAMATO_BAL_EMONEY = "電子マネー残高【%ld円】";

  static const VEGA_ERROR_D01 = "初期化エラー";
  static const VEGA_ERROR_D02 = "パラメータエラー";
  static const VEGA_ERROR_D05 = "ソケットエラー";
  static const VEGA_ERROR_D06_D07 = "コネクションエラー";
  static const VEGA_ERROR_D10_D11 = "要求電文送信エラー";
  static const VEGA_ERROR_D20 = "応答電文受信エラー";
  static const VEGA_ERROR_D21 = "取引不成立";
  static const VEGA_ERROR_D90 = "取引結果不明";
  static const VEGA_ERROR_D41 = "決済端末接続エラー";
  static const VEGA_ERROR_D42 = "決済端末電文送信エラー";
  static const VEGA_ERROR_D43 = "決済端末電文受信エラー";
  static const VEGA_ERROR_D52 = "決済端末リセットキー押下";
  static const VEGA_ERROR_D53 = "カード読取タイムアウト";
  static const VEGA_ERROR_D54 = "カード読取失敗";
  static const VEGA_ERROR_D55 = "カード情報取得エラー";
  static const VEGA_ERROR_D91 = "決済端末取引結果不明";
  static const VEGA_ERROR_D97 = "端末処理エラー";
  static const VEGA_ERROR_D98 = "ICカード抜き忘れエラー";
  static const VEGA_ERROR_D99 = "端末取引エラー";
  static const VEGA_ERROR_DXX = "その他エラー";

  static const String KEY_LUMP = "一括払い";
  static const String KEY_TWICE = "２回払い";
  static const String KEY_DIVID = "分割払い";
  static const String KEY_RIBO = "リボ";
  static const String KEY_3TIMES = "３回";
  static const String KEY_5TIMES = "５回";
  static const String KEY_6TIMES = "６回";
  static const String KEY10TIMES = "１０　回";
  static const String KEY12TIMES = "１２　回";
  static const String KEY15TIMES = "１５　回";
  static const String KEY18TIMES = "１８　回";
  static const String KEY20TIMES = "２０　回";
  static const String KEY24TIMES = "２４　回";
  static const String KEY30TIMES = "３０　回";
  static const String KEY36TIMES = "３６　回";
  static const String KEY_BONUS_LUMP = "ボー一括";
  static const String KEY_BONUS_LUMP104 = "ボー\n一括";
  static const String KEY_BONUS_TWICE = "ボー２回";
  static const String KEY_BONUS_TWICE104 = "ボー\n２回";
  static const String KEY_BONUS_USE = "ボー併用";
  static const String KEY_BONUS_USE104 = "ボー\n併用";
}

