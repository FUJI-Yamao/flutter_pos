/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../inc/apl/rxsys.dart';
import '../../page/file_request/p_freq.dart';
import '../../page/maintenance/menu/p_maintenance_menu_page.dart';
import '../../page/maintenance/specfile/model/e_speckind.dart';
import '../../page/maintenance/specfile/template/p_recogkey.dart';
import '../../page/maintenance/specfile/template/p_sio.dart';
import '../../page/maintenance/specfile/template/p_specfile.dart';
import '../../page/test_mode/p_display_test_15_inch_main.dart';
import '../../page/test_mode/p_keyboard_test_15_inch.dart';
import 'enum/e_maintenance_page.dart';

/// メンテナンスメニュー
/// メンテナンスTOP以外の画面はルーティン登録はしない。
/// 理由は、メンテナンス画面のコンストラクタで、現在のぱんくず情報をパラメータで渡したいが、
/// ルーティング登録した場合は、コンストラクタで渡せず、Get.toNamedのargumentsで渡す必要がある。
/// 例：Get.toNamed(menuList[index].pageInfo.routeName, arguments: breadcrumb);
/// なので、コンストラクタ渡しとargumentsの2通りを用意したくないので、コンストラクタ渡しのみにする。
class MaintenanceMenu {
  /// メンテナンスTOPのメニューリスト
  static List<MaintenanceMenuItem> topList = [
    // 1:スペックファイル
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.specFile,
      goToPage: (String currentBreadcrumb) => Get.to(() => MaintenanceMenuPage(
            title: MaintenancePage.specFile.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
            menuList: specList,
          )),
    ),
    // 2:接続機器
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.connectionEquipment,
      goToPage: null,
    ),
    // 3:セルフ設定
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.selfSetup,
      goToPage: (String currentBreadcrumb) => Get.to(() => MaintenanceMenuPage(
            title: MaintenancePage.selfSetup.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
            menuList: selfSetupList,
          )),
    ),
    // 4:承認キー
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.recogkey,
      goToPage: (String currentBreadcrumb) => Get.to(() => RecogekeyPageWidget(
            title: MaintenancePage.recogkey.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // 5:再セットアップ
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.reSetup,
      goToPage: (String currentBreadcrumb) => Get.to(() => MaintenanceMenuPage(
            title: MaintenancePage.reSetup.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
            menuList: reSetupList,
          )),
    ),
    // 6:データ取込／保存
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.importData,
      goToPage: null,
    ),
    // 7:バージョンアップ上位接続設定
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.versionUp,
      goToPage: null,
    ),
    // 8:上位接続設定
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.upperConnectionSetup,
      goToPage: null,
    ),
    // 9:テストモード
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.testMode,
      goToPage: (String currentBreadcrumb) => Get.to(() => MaintenanceMenuPage(
            title: MaintenancePage.testMode.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
            menuList: testModeList,
          )),
    ),
  ];

  /// スペックファイルのメニューリスト
  static List<MaintenanceMenuItem> specList = [
    // マシン環境
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.machineEnv,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.machine,
            title: MaintenancePage.machineEnv.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // ネットワーク
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.network,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.network,
            title: MaintenancePage.network.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // 動作環境
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.operationEnv,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.operating,
            title: MaintenancePage.operationEnv.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // カウンター
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.counter,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.counter,
            title: MaintenancePage.counter.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // SIO
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.sio,
      goToPage: (String currentBreadcrumb) => Get.to(() => SioPageWidget(
            title: MaintenancePage.sio.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // 周辺装置
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.peripheralDevice,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.peripheralDevice,
            title: MaintenancePage.peripheralDevice.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // 釣銭機関連
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.changeMachine,
      goToPage: (String currentBreadcrumb) => Get.to(
          () => MaintenanceMenuPage(
                title: MaintenancePage.changeMachine.pageTitleName,
                currentBreadcrumb: currentBreadcrumb,
                menuList: changeMachineList,
              ),
          routeName: 'changeMachineMenuPage'),
    ),
  ];

  /// 釣銭機関連のメニューリスト
  static List<MaintenanceMenuItem> changeMachineList = [
    // ACB
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.acb,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.acb,
            title: MaintenancePage.acb.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // ECS
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.ecs,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.ecs,
            title: MaintenancePage.ecs.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
  ];

  /// 再セットアップのメニューリスト
  static List<MaintenanceMenuItem> reSetupList = [
    // ファイルリクエスト
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.fileRequest,
      goToPage: (String currentBreadcrumb) => Get.to(() => FileRequestPage()),
    ),
    // ファイル初期化
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.fileInitialize,
      goToPage: (String currentBreadcrumb) =>
          Get.to(() => FileRequestPage(freqCallMode: Rxsys.RXSYS_MSG_FINIT.id)),
    ),
  ];

  /// セルフ設定のメニューリスト
  static List<MaintenanceMenuItem> selfSetupList = [
    // Speeza設定
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.speeza,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.speeza,
            title: MaintenancePage.speeza.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // QCashier設定（共通部）
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.qCashierCommon,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
        SpecKind.qCashierCommon,
        title: MaintenancePage.qCashierCommon.pageTitleName,
        currentBreadcrumb: currentBreadcrumb,
      )),
    ),
    // QCashier設定（動作関連）
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.qCashierOperation,
      goToPage: (String currentBreadcrumb) => Get.to(() => SpecfilePageWidget(
            SpecKind.qCashierOperation,
            title: MaintenancePage.qCashierOperation.pageTitleName,
            currentBreadcrumb: currentBreadcrumb,
          )),
    ),
    // Shop&Go設定
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.shopAndGo,
      goToPage: null,
    ),
  ];

  /// テストモードのメニューリスト
  static List<MaintenanceMenuItem> testModeList = [
    // 表示
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.display,
      goToPage: (String currentBreadcrumb) => Get.to(
          () => MaintenanceMenuPage(
                title: MaintenancePage.display.pageTitleName,
                currentBreadcrumb: currentBreadcrumb,
                menuList: displayTestList,
              ),
          routeName: 'displayTestMenuPage'),
    ),
    // キーボード
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.keyboard,
      goToPage: (String currentBreadcrumb) => Get.to(
          () => MaintenanceMenuPage(
                title: MaintenancePage.keyboard.pageTitleName,
                currentBreadcrumb: currentBreadcrumb,
                menuList: keyboardTestList,
              ),
          routeName: 'keyboardTestMenuPage'),
    ),
  ];

  /// 表示テストのメニューリスト
  static List<MaintenanceMenuItem> displayTestList = [
    // １５インチＬＣＤ表示（main）
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.lcdDisplay15InchMain,
      goToPage: (String currentBreadcrumb) =>
          Get.to(() => const DisplayTestPage15InchMainWidget()),
    ),
    // １５インチＬＣＤ表示（sub）
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.lcdDisplay15InchSub,
      goToPage: null,
    ),
  ];

  /// キーボードテストのメニューリスト
  static List<MaintenanceMenuItem> keyboardTestList = [
    // １５インチＬＣＤ表示
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.keyboardTest15Inch,
      goToPage: (String currentBreadcrumb) =>
          Get.to(() => const KeyboardTestPage15InchWidget()),
    ),
    // 客側１５インチＬＣＤキー
    MaintenanceMenuItem(
      pageInfo: MaintenancePage.keyboardTestCustomerSide,
      goToPage: null,
    ),
  ];
}

/// メンテナンスメニューの項目
class MaintenanceMenuItem {
  /// コンストラクタ
  MaintenanceMenuItem({
    required this.pageInfo,
    this.goToPage,
  });

  /// 画面の情報
  final MaintenancePage pageInfo;

  // 画面遷移
  final Function(String currentBreadcrumb)? goToPage;
}
