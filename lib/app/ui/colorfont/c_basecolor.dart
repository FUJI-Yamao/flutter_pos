/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/material.dart';

/// ガイドラインの色/フォントサイズ
/// https://xd.adobe.com/view/f529dd6a-7066-47b8-ba65-564de8758e73-a07a/
class BaseColor {
  /// 基本カラー
  /// プリセット/テンキーの背景 押下可能エリアの背景
  static const Color mainColor = Color(0xFFF2F2EC);
  /// プリセットボタンの背景 押下可能エリアの背景
  static const Color newMainColor = Color(0xFFCBDDFC);
  /// 基本的なテキスト　見出しの背景　ステータス表示の背景　決定ボタン　商品プリセットのタブ
  static const Color baseColor = Color(0xFF45494E);
  /// 一部トリガーのテキスト　ステータス表示（精算機）のテキスト　領域エリアのハイライト
  static const Color accentsColor = Color(0xFF374BBA);
  ///その他の選択肢/トリガーボタン色
  static const Color otherButtonColor = Color(0xFF606F80);

  static const Color maintainBaseColor =Color(0xFF667885);
  /// other Color.1
  /// テンキーの背景
  static const Color tenkeyBackColor1 = Color(0xFFF2F2EC);
  /// テンキーの背景　金額表示の背景
  static const Color tenkeyBackColor2 = Color(0xFFFCB3A9);
  /// ボタン/テンキーの縁どり線
  static const Color edgeBtnTenkeyColor = Color(0xFF98A2AD);
  /// ボタンの縁どり線
  static const Color edgeBtnColor = Color(0xFF727981);
  /// 一部のテキスト　ポップアップ/エリアの背景
  static const Color someTextPopupArea = Color(0xFFFFFFFF);
  /// 背景
  static const Color backColor = Color(0xFFDCDCDC);
  /// 「エラー」「緊急」「注目」の意味合い　ステータス表示（背景/テキスト）
  static const Color attentionColor = Color(0xFFC1371E);
 /// divider
  static const Color dividerColor = Color(0xFFABB8C3);

  /// メンテンナス画面ヘッダー部　戻るボタン
  static const Color maintainButtonAreaBG = Color(0xFF2B363C);
  static const Color maintainTitleBG = Color(0xFF008B9D);

  // メンテナンス画面　スイッチのON部分の背景色.透過あり.
  static const Color maintainSwitchOnColor = Color(0x34008B9E);

  static const Color maintainInputAreaBorder = Color(0xFF707070);

  ///　入力ボックスのフォントの色
  static const Color maintainInputFontColor = Color(0xFF45494E);
  /// 　入力ボックスのカーソルの色
  static const Color maintainInputCursor = Color(0xFF00E2FF);

  static const Color maintainTenkey = Color(0xFF3E3E3E);
  static const Color maintainTenkeyAccent = Color(0xFFBE4A4A);
  static const Color maintainTenkeyText = Color(0xFFF7F6F5);
  static const Color maintainTenkeyBG = Color(0xFF000000);
  static const Color maintainTenkeyCursor = Color(0xFF00E2FF);
  static const Color maintainTenkeyNull = Color(0xFF191919);

  static const Color GrdBdrButtonEndColor = Color(0xFF027080);

  /// スクロールバーのつまみの色
  static const Color scrollbarThumbColor = Color(0xFF45494E);
  /// スクロールバーのトラックリアの色
  static const Color scrollbartrackColor = Color(0xFFAFB1B3);

  /// other Color.2
  /// 登録/小計　ヘッダー部
  static const Color transparent = Color(0x00000000);
  static const Color registerColorFrom = Color(0xFF145FE3);
  static const Color registerColorTo = Color(0xFF001CBA);
  static const Color drpdwnWaitColor = Color(0xFFFA6202);
  static const Color vegetableColor = Color(0xFFFA6202);

  /// 透明色
  static const Color transparentColor = Color(0x00000000);

  // アイコンカラー（通常）
  static const Color iconNormalColor = Color(0xFF000000);
  // アイコンカラー（強調）
  static const Color iconEmphasizeColor = Color(0xFFFF0000);

  // スクロールエリアのscroll可能時のグラデーション
  static const Color registerScrollFrom = Color(0xFF1C265D);
  static const Color registerScrollTo = Color(0xFFEFF2F7);

  /// 小計左背景色
  static const Color subtotalLeftBackColor =  Color(0xFFEFF5F7);
  ///確定ボタンと✓ボタンのグラデーション
  static const Color confirmBtnFrom = Color(0xFF565B62);
  static const Color confirmBtnTo =  Color(0xFF0E0F10);
  ///ドロップシャドウの色
  static const Color dropShadowColor = Color(0xFF45494E59);

  ///選択時の色（中）
  static const Color selectInColor = Color(0xFFCBE7EB);
  ///選択時の色（線）
  static const Color selectLineColor = Color(0xFF32ADC2);

  ///会計業務メニュートップの色
  static const Color topCloseButtonColor = Color(0xFFC9C9C9);
  ///新しいデザインのプリセット/テンキーの背景 押下可能エリアの背景
  static const Color newBaseColor = Color(0xFFCBDDFC);
  ///商品登録の背景 押下可能エリアの背景色
  static const Color loginBackColor = Color(0xFFE1ECF8);
  ///商品登録の背景 タブの押されてない背景色
  static const Color loginTabBackColor = Color(0xFFD5DFEA);
  ///商品登録の背景 タブの押されてないテキスト色
  static const Color loginTabTextColor = Color(0xFF727981);
  ///商品登録画面商品ボタンプリセットカラー
  static const Color presetColorCd201 = Color(0xFFC7AFA1);
  static const Color presetColorCd202 = Color(0xFFF3A8A7);
  static const Color presetColorCd203 = Color(0xFFFFB38C);
  static const Color presetColorCd204 = Color(0xFFF5D271);
  static const Color presetColorCd205 = Color(0xFFBBDB74);
  static const Color presetColorCd206 = Color(0xFF8AD9C0);
  static const Color presetColorCd207 = Color(0xFF81D7EC);
  static const Color presetColorCd208 = Color(0xFFA9B1F6);
  static const Color presetColorCd209 = Color(0xFFD3A6FF);
  static const Color presetColorCd210 = Color(0xFFFFADE8);
  static const Color presetColorCd211 = Color(0xFFC7C7C7);
  /// 商品登録画面カテゴリータブカラー
  static const Color presetColorCd101 = Color(0xFF8D5F42);
  static const Color presetColorCd102 = Color(0xFFE55050);
  static const Color presetColorCd103 = Color(0xFFFA7D3D);
  static const Color presetColorCd104 = Color(0xFFFAB702);
  static const Color presetColorCd105 = Color(0xFF8CC900);
  static const Color presetColorCd106 = Color(0xFF17B380);
  static const Color presetColorCd107 = Color(0xFF00AED8);
  static const Color presetColorCd108 = Color(0xFF5362EC);
  static const Color presetColorCd109 = Color(0xFFA94DFF);
  static const Color presetColorCd110 = Color(0xFFFF65D4);


  ///通番訂正スキャン画面ボタン色
  static const Color scanButtonColor = Color(0xFF606F80);
  ///通番訂正スキャン画面ボタンシャドウ色
  static const Color scanBtnShadowColor = Color(0x5945494E);
  ///通番訂正入力欄枠線色
  static const Color inputFieldColor = Color(0xFF98A2AD);
  ///通番訂正完了画面下の色
  static const Color receiptBottomColor = Color(0xFFE1ECF8);
  ///通番訂正完了画面「再売り上げ」ボタン色
  static const Color receiptButtonColor = Color(0xFF515E6C);
  ///通番訂正入力時背景色
  static const Color inputBaseColor = Color(0xFFD3F2F2);
  ///通番訂正フィールドシャドウ色
  static const Color inputShadowColor = Color(0x59374BBA);

  ///記録確認スクロールバーの背景色
  static const Color scrollerColor = Color(0xFF727981);


  /// 音の選択画面の背景色
  static const Color soundSettingPageBackgroundColor = Color(0xFFE1ECF8);
  /// 音の選択画面の説明文の背景色
  static const Color soundSettingCommentBackgroundColor = Color(0xFFF6F9FD);
  /// 音の選択画面のボタンの背景色
  static const Color soundSettingButtonBackgroundColor = Color(0xFF374BBA);
  /// 音の選択画面のスライダーの色
  static const Color soundSettingSliderBackgroundColor = Colors.blue;
  /// 音の選択画面のタブの選択時のテキストの色
  static const Color soundSettingTabSelectedForegroundColor = Color(0xFF374BBA);
  /// 音の選択画面のタブの非選択時の背景色
  static const Color soundSettingTabUnselectedBackgroundColor = Color(0xFFD5DFEA);
  /// 音の選択画面のタブの非選択時のテキストの色
  static const Color soundSettingTabUnselectedForegroundColor = Color(0xFF727981);

  /// 音の選択画面選択時の色（中）
  static const Color soundSelectInColor = Color(0xFFEFF5F7);
  /// 音の選択画面選択時の色（線）
  static const Color soundSelectLineColor = Color(0xFF374BBA);
  /// 音の選択画面非選択時の色（中）
  static const Color soundUnSelectInColor = Color(0xFFFFFFFF);
  /// 音の選択画面非選択時の色（線）
  static const Color soundUnSelectLineColor = Color(0xFF98A2AD);

  /// 客表画面背景色
  static const Color customerPageBackGroundColor = Color(0xFFF5F9FF);
  /// 客表画面合計金額表示欄
  static const Color customerPageSumAreaBackGroundColor = Color(0xFF333333);
  /// 客表画面商品一覧奇数番目
  static const Color customerPageOddsPurchaseColor = Color(0xFFEBF2FF);
  /// 客表画面商品一覧偶数番目
  static const Color customerPageEvensPurchaseColor = Color(0xFFFFFFFF);
  /// 客表画面最新の登録商品の背景色
  static const Color customerPageNewPurchaseBackGroundColor = Color(0xFF5065A8);
  /// 客表画面最新の登録商品の値引の背景色
  static const Color customerPageDiscountBackGroundColor = Color(0xFFEBF2FF);
  /// 客表画面の値引きの文字色
  static const Color customerPageDiscountTextColor = Color(0xFFC1371E);
  /// 客表画面の取り消しの背景色
  static const Color customerPageCancelBackGroundColor = Color(0xFFFFFFFF);
  /// 客表画面の取り消しのボーダーの色
  static const Color customerPageCancelBorderColor = Color(0xFFA2A2A2);
  /// 客表画面合計金額及び最新の登録商品の文字色
  static const Color customerPageSumAndNewPurchaseTextColor = Color(0xFFFFFFFF);
  /// 客表画面の基本の文字色
  static const Color customerPageBaseTextColor = Color(0xFF000000);
  /// 返品時の商品明細欄の背景色
  static const Color customerPageRefundOddsPurchaseColor = Color(0xFFEDEFEF);

  /// メインメニュー画面右側のボタン(音の、切替、メモ、即時)
  static const Color mainRightBtnBackColor = Color(0xfff89960);
  static const Color mainRightBtnBorderColor = Color(0xfffbc288);
  static const Color mainRightBtnShadowColor = Color(0xffbf5821);

  /// 開設閉設画面の背景色
  static const Color storeOpenCloseBackColor = Color(0xFFE0EBF7);
  static const Color storeOpenBackColor = Color(0xFF737980);
  /// 開設閉設画面のテキスト背景色
  static const Color storeOpenMessageColor = Color(0xFFF5F8FC);
  /// 開設閉設画面のテキスト色
  static const Color storeOpenFontColor = Color(0xFF45494E);
  /// 開設閉設画面のドロップダウンの色
  static const Color storeOpenDropDownColor = Color(0xFF45494E);
  /// 開設閉設画面の電源OFFボタンの影の色
  static const Color storeOpenPowerOffColor = Color(0xffec4f50);
  static const Color storeOpenPowerOffBackColor = Color(0xfffde7e4);
  static const Color storeCloseGoBackColor = Color(0xff4281fe);
  /// 閉設画面のテキスト色
  static const Color storeCloseFontColor = Color(0xff9e9e9e);
  /// 閉設画面の実行ボタン色
  static const Color storeCloseStartButtonColor = Color(0xFF5065A8);
  static const Color storeOpenCloseWhiteColor = Color(0xFFffffff);
  static const Color storeCloseBlack54Color = Color(0x8a000000);
  /// 閉設画面のプロセス中の色
  static const Color storeCloseProcessFailColor = Color(0xffe57373);
  static const Color storeCloseProcessSuccessColor = Color(0xff32945c);
  /// 新しいメインメニューの背景色
  static const Color newMainMenuWhiteColor = Color(0xFFffffff);
  static const Color newMainMenuBlack87Color = Color(0xdd000000);
  static const Color newMainMenuBlack45Color = Color(0x73000000);
  static const Color newMainMenuIconColor = Color(0xFF717880);
  static const Color newMainMenuBlackColor = Color(0xFF000000);
  static const Color newMainMenuBackColor = Color(0xFFECECE6);
  /// 登録画面の商品一覧の値引き情報
  static const Color registDiscountBackColor = Color(0xffffe8e5);
  /// 登録画面の商品一覧のスクロールボタン配置エリアの背景色
  static const Color registScrollAreaBackColor = Color(0xffc9c9c9);
  /// 登録画面の会員詳細情報表示ボタンの開始色
  static const Color registMemverDetailStartColor = Color(0xff808790);
  /// 登録画面の会員詳細情報表示ボタンの終了色
  static const Color registMemverDetailEndColor = Color(0xff484c52);

  /// モード切替画面の背景色
  static const Color modeChangePageBackgroundColor = Color(0xFFE1ECF8);
  /// モード切替画面の説明文の背景色
  static const Color modeChangeCommentBackgroundColor = Color(0xFFF6F9FD);

  /// 予約レポートの出力画面の背景色
  static const Color batchReportOutputPageBackgroundColor = Color(0xFFE1ECF8);
  /// 予約レポートの出力画面の説明文の背景色
  static const Color batchReportOutputPageCommentBackgroundColor = Color(0xFFF6F9FD);
  /// 予約レポートの出力画面スクロールボタン
  static const Color batchReportOutputPageScrollButton = Color(0xFF606F80);

  /// フルセルフのスタート画面の上部のタイトルバーの色
  static const Color fullSelfStartPageUpperTitleBar = Color(0xFF5065A8);
  /// フルセルフの登録画面のバーコードがない商品ボタン
  static const Color fullSelfRegisterPageNoBarcodeButton = Color(0xFFB7D0FF);
  /// フルセルフの登録画面の会計するボタン
  static const Color fullSelfRegisterPageToCheckButton = Color(0xFF0D62FF);
  /// フルセルフの支払方法選択画面の戻るボタン
  static const Color fullSelfSelectPayPageBackButton = Color(0xFF606F80);

  /// 商品券支払画面の変更不可数値のテキストの色
  static const Color ticketPayFixedForegroundColor = Color(0xFF727981);
  /// 商品券支払画面の支払金額に不足がない場合のテキスト・線の色
  static const Color ticketPayEnoughColor = Color(0xFF374BBA);

  /// 釣機参照画面のタイトルのテキストの色
  static const Color changeCoinReferTitleColor = Color(0xFF26282B);
  /// 釣機参照画面の金額のテキストの色
  static const Color changeCoinBillCoinColor = Color(0xFF727981);
  /// 釣機参照画面の回収必要時の状態表示色
  static const Color changeCoinCollectFontColor = Color(0xFF7C6903);
  /// 釣機参照画面の回収必要時のバー色
  static const Color changeCoinCollectBarColor = Color(0xFFFAB702);


  /// データ送出、データ呼出ボタン色(RGB値は249, 146, 53)
  static const Color dataCallButtonColor = Color(0xFFF99235);

  /// 返品時の概算合計エリア背景色
  static const Color refundAreaBackColor = Color(0xffffe8e5);
  /// 返品時の背景色
  static const Color refundBackColor = Color(0xffcfc7d6);
  /// 返品時の格子の編みかけ色
  static const Color refunStripeColor = Color(0xFFF2F2EC);

  /// 顧客情報がRARA会員、RARAプリカ会員、RARAハウス会員、RARAクレジット会員時の背景色
  static const Color memberInfoNormalBackColoer = Color(0xFFD3A6FF);
  /// 顧客情報が社員の背景色
  static const Color memberInfoEmployeeBackColoer = Color(0xFFA9B1F6);
  /// 顧客情報がRARAクレジット会員+社員の背景色
  static const Color memberInfoCreditEmployeeBackColoer = Color(0xFF17B380);
  /// 顧客情報が会員売価の背景色
  static const Color memberInfoMemberPriceBackColoer = Color(0xFFF3A8A7);
  /// 顧客情報が社員売価の背景色
  static const Color memberInfoEmployeePriceBackColoer = Color(0xFFFFADE8);

  ///価格確認画面の通常行の内容の背景
  static const Color priceCheckNormalContentBackColor = Color(0xFFE1ECF8);
  ///価格確認画面の先頭行の内容の背景
  static const Color priceCheckTopContentBackColor = Color(0xFFCBDDFC);
  ///価格確認画面の先頭行の項目名の背景
  static const Color priceCheckTopItemNameBackColor = Color(0xFF374BBA);
  ///価格確認モード時のモード表示背景色　todo 暫定で色が設定されていることを確認するために定義
  static const Color priceCheckModeBackColor = Color(0xFFB7D0FF);

  ///従業員メンテナンス画面スクロールバー色
  static const Color staffMaintenanceScrollbarColor = Color(0xFFD0D7E3);
  //フルセルフLanguage背景色
  static const Color languageButtonColor = Color(0xFF96BAFF);

  /// ラジオボタンの非選択状態の色
  static const Color radioButtonUnselectedColor = Color(0xFFA3B1BD);

  /// つり機接続画面の背景
  static const Color changeConnectBackColor = Color(0xFFE1ECF8);
  /// つり機接続画面の釣札・釣銭アイコンとそれに付随する文字
  static const Color changeCoinIconFontColor = Color(0xFF727981);
  
/// unnamed-color-ffe8e5
// 色が決定次第追記（ガイドライン Ohter Color.2 p7）
// static const baseColor = "#";

}
