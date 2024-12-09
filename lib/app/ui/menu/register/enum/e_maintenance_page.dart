/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// メンテナンス画面
enum MaintenancePage {

  specFile(pageTitleName: 'スペックファイル', menuItemName: '1:スペックファイル'),
  connectionEquipment(pageTitleName: '接続機器', menuItemName: '2:接続機器'),
  selfSetup(pageTitleName: 'セルフ設定', menuItemName: '3:セルフ設定'),
  recogkey(pageTitleName: '承認キー設定', menuItemName: '4:承認キー'),
  reSetup(pageTitleName: '再セットアップ', menuItemName: '5:再セットアップ'),
  importData(pageTitleName: 'データ取込／保存', menuItemName: '6:データ取込／保存'),
  versionUp(pageTitleName: 'バージョンアップ', menuItemName: '7:バージョンアップ'),
  upperConnectionSetup(pageTitleName: '上位接続設定', menuItemName: '8:上位接続設定'),
  testMode(pageTitleName: 'テストモード', menuItemName: '9:テストモード'),

  machineEnv(pageTitleName: 'マシン環境'),
  network(pageTitleName: 'ネットワーク'),
  operationEnv(pageTitleName: '動作環境'),
  counter(pageTitleName: 'カウンター'),
  sio(pageTitleName: 'SIO'),
  peripheralDevice(pageTitleName: '周辺装置'),
  changeMachine(pageTitleName: '釣銭機関連'),

  acb(pageTitleName: 'ACB'),
  ecs(pageTitleName: 'ECS'),

  fileRequest(pageTitleName: 'ファイルリクエスト'),
  fileInitialize(pageTitleName: 'ファイル初期化'),

  speeza(pageTitleName: 'Speeza設定'),
  qCashierCommon(pageTitleName: 'QCashier設定（共通部）'),
  qCashierOperation(pageTitleName: 'QCashier設定（動作関連）'),
  shopAndGo(pageTitleName: 'Shop&Go設定'),

  display(pageTitleName: '表示'),
  keyboard(pageTitleName: 'キーボード'),

  lcdDisplay15InchMain(pageTitleName: '１５インチＬＣＤ表示（main）'),
  lcdDisplay15InchSub(pageTitleName: '１５インチＬＣＤ表示（sub）'),

  keyboardTest15Inch(pageTitleName: '１５インチＬＣＤ表示'),
  keyboardTestCustomerSide(pageTitleName: '客側１５インチＬＣＤキー＜テスト不可＞');

  /// コンストラクタ
  const MaintenancePage({
    required this.pageTitleName,
    String? menuItemName
  }) : menuItemName = menuItemName ?? pageTitleName;

  /// 画面タイトル
  final String pageTitleName;
  /// メニュー項目名
  final String menuItemName;
}
