/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// レジ側画面
enum RegisterPage {
  mainMenu(routeName: '/mainmenu'),
  register(routeName: '/register'),
  tranining(routeName: '/tranining'),
  storeOpen(routeName: '/storeopen', pageTitleName: '開設'),
  storeClose(routeName: '/storeclose', pageTitleName: '閉設'),
  maintenanceTop(routeName: '/maintenance_top', pageTitleName: 'メンテナンスTOP'),
  soundSetting(routeName: '/sound_setting', pageTitleName: '音の設定'),
  terminalInfo(routeName: '/terminal_info', pageTitleName: '端末情報'),
  modeChange(routeName: '/mode_change', pageTitleName: 'モード切替');

  /// コンストラクタ
  const RegisterPage({
    required this.routeName,
    this.pageTitleName = '',
  });

  /// ルーティング名称
  final String routeName;
  /// 画面タイトル
  final String pageTitleName;
}
