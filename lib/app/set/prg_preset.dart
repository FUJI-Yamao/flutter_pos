/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: prg_preset.h
class PrgPresetDef {
// プリセットコード
  static const REGPRESET01D = 101; // 登録プリセット１頁
  static const REGPRESET02D = 201; // 登録プリセット２頁
  static const REGPRESET03D = 301; // 登録プリセット３頁
  static const REGPRESET04D = 401; // 登録プリセット４頁
  static const REGPRESET05D = 501; // 登録プリセット５頁
  static const REGPRESET06D = 601; // 登録プリセット６頁
  static const REGPRESET07D = 701; // 登録プリセット７頁
  static const REGSTL104D = 2101; // = 10;.4登録小計
  static const REGSTL104_2D = 2102; // = 10;.4登録小計(拡張)
  static const REGEXTITMD = 2103; // 拡張(商品明細(登録))
  static const REGEXTSTLD = 2104; // 拡張(商品明細(小計))
  static const REGEXT_2D = 2105; // 拡張(商品登録補助)
  static const REGEXT_3D = 2106; // 拡張(登録補助)
  static const REGEXT_4D = 2107; // 拡張(決済)
  static const REGSTL57D = 2201; // = 5;.7登録小計
  static const REGMAINKEYD = 3201; // 登録本体キー
  static const REGTOWERKEYD = 3101; // 登録タワーキー
  static const REGJRKEYD = 4201; // 登録Jr本体
  static const REG2800IKEYD = 5201; // 登録2800i
  static const REG2800IMKEYD = 6201; // 登録2800iM 2011.01.26
  static const REG2800TOWERKEYD = 6101; // 登録2800タワー 2011.01.26
  static const REG52KEYD = 7201; // 登録卓上52キー
  static const REG52TOWERKEYD = 7101; // 登録タワー52キー
  static const REGCOMD = 8101; // 登録共通
  static const REGSELFMNTS1D = 9101; // セルフメンテナンス スタート画面（ページ1）
  static const REGSELFMNTS2D = 9102; // セルフメンテナンス スタート画面（ページ2）
  static const REGSELFMNTR1D = 9105; // セルフメンテナンス 取引中画面（ページ1）
  static const REGSELFMNTR2D = 9106; // セルフメンテナンス 取引中画面（ページ2）
  static const REGSELFD = 9999; // プリセットグループ名
  static const REG35KEYD = 10201; // 登録卓上35キー
}
