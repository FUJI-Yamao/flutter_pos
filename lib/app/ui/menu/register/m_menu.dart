/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// すべてのページを登録する（キャッシャー側）

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/page/search_registration/p_registration_input.dart';
import 'package:get/get.dart';

import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/apl/rxsys.dart';
import '../../../regs/checker/rcsyschk.dart';
import '../../page/batch_report/p_batch_report.dart';
import '../../page/file_request/p_freq.dart';
import '../../page/full_self/controller/c_full_self_pay_complete_controller.dart';
import '../../page/full_self/page/p_full_self_select_pay_page.dart';
import '../../page/maintenance/menu/p_maintenance_menu_page.dart';
import '../../page/mode_change/p_mode_change.dart';
import '../../page/receipt_void/p_receipt_input.dart';
import '../../page/register/p_register.dart';
import '../../page/sound_setting/p_sound_setting.dart';
import '../../page/store_close/p_store_close.dart';
import '../../page/store_close/p_store_close_complete.dart';
import '../../page/store_open/p_store_open.dart';
import '../../page/subtotal/basepage/p_loginaccount_page.dart';
import '../../page/subtotal/controller/c_payment_controller.dart';
import '../../page/subtotal/p_subtotal.dart';
import '../../page/terminal/p_terminal_info.dart';
import '../../page/test/p_tmp_store_close_ut1.dart';
import 'enum/e_register_page.dart';
import 'm_maintenance.dart';

/// （暫）サンプルページ
import '../../page/test/test_page1.dart';
import '../../page/test/test_page2/test_page2.dart';
import '../../page/test/test_page3.dart';
import '../../page/test/test_setting.dart';
/// メニュー
import '/app/ui/menu/p_main_menu.dart';
/// すべてのページをimport
/// （暫）サンプルページ


/// キャッシャー側のメニュー
class SetMenu1 {

  ///訓練モードと登録画面のページに戻る判定関数
  static void navigateToRegisterPage() {
    //訓練モードの場合なら
    if (RcSysChk.rcTROpeModeChk()) {
      Get.until((route) => route.settings.name == RegisterPage.tranining.routeName);
    }
    else {
      Get.until((route) => route.settings.name == RegisterPage.register.routeName);
    }
  }  
  /// 支払い完了画面へ.
  static Future<void> navigateToPaymentCompletePage() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    int selfMode = pCom.iniMacInfo.select_self.kpi_hs_mode;
    if(await RcSysChk.rcSGChkSelfGateSystem() || (selfMode == 2)) {
      // フルセルフ、またはセミセルフの場合
      FullSelfPayCompleteController fPaymentCtrl = Get.find();
      await fPaymentCtrl.setPaymentSuccess();
      return;
    }
    PaymentController paymentCtrl = Get.find();
    await paymentCtrl.setPaymentSuccess(true);
    Get.until((route) =>  route.settings.name == '/subtotal');
  }

  /// 支払い選択画面へ戻る.
  static Future<void> navigateToPaymentSelectPage() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    int selfMode = pCom.iniMacInfo.select_self.kpi_hs_mode;
    if(await RcSysChk.rcSGChkSelfGateSystem()){
      // フルセルフの場合
      Get.until((route) => route.settings.name == '/fullself_selectpay');
      return;
    } else if (selfMode == 2) {
      // セミセルフの場合
      Get.back();
      return;
    }
    Get.until((route) =>  route.settings.name == '/subtotal');
  }

  /// 二人制卓上側取消時の支払い完了画面へ.
  static Future<void> navigateToPaymentCompletePageCancelMode() async {
    PaymentController paymentCtrl = Get.find();
    paymentCtrl.isPaymentSuccess.value = true;
    Get.until((route) =>  route.settings.name == '/subtotal');
  }

  /// キャッシャー側のルーティング情報を設定する
  List<GetPage<dynamic>> setScreen1Menu() {
    /// getPagesに設定するための変数
    List<GetPage<dynamic>> lstPage = [];

    /// すべてのページを記載
    /// （暫）下記サンプルページ（page1-3）
    lstPage.add(GetPage(name: '/page1', page: () => Page1()));
    lstPage.add(GetPage(name: '/page2', page: () => Page2()));
    lstPage.add(GetPage(name: '/page3', page: () => Page3()));

    /// レジ登録
    lstPage.add(
        GetPage(name: RegisterPage.register.routeName, page: () => RegisterPageWidget (title: 'レジ登録')));

    /// 訓練モード
    lstPage.add(
        GetPage(name: RegisterPage.tranining.routeName, page: () => RegisterPageWidget (title: 'レジ登録')));

    /// モード切替
    lstPage.add(
        GetPage(name: RegisterPage.modeChange.routeName, page: () => const ModeChangePage()));

    /// メンテナンスTOP画面を設定
    lstPage.add(GetPage(
      name: RegisterPage.maintenanceTop.routeName,
      page: () => MaintenanceMenuPage(
        title: RegisterPage.maintenanceTop.pageTitleName,
        currentBreadcrumb: '',
        menuList: MaintenanceMenu.topList,
      ),
    ));

    /// 音の設定
    lstPage.add(
        GetPage(name: RegisterPage.soundSetting.routeName, page: () => const SoundSettingPage()));

    /// 端末情報
    lstPage.add(
        GetPage(name: RegisterPage.terminalInfo.routeName, page: () => TerminalInfoPage()));

    // 小計画面
    lstPage.add(
        GetPage(name: '/subtotal', page: () => SubtotalPage()));

    // 通番訂正画面
    lstPage.add(
        GetPage(name: '/receiptinputpage', page: () => ReceiptInputPageWidget()));

    // 検索登録画面
    lstPage.add(
        GetPage(name: '/registrationinputpage', page: () => RegistrationInputPageWidget()));

    // ファクションキー画面
    lstPage.add(
        GetPage(name: '/LoginAccountPage', page: () => LoginAccountPage(title: '業務')));

    /// 開設画面
    lstPage.add(GetPage(name: RegisterPage.storeOpen.routeName, page: () => const StoreOpenPage()));

    /// 精算画面
    lstPage
        .add(GetPage(name: RegisterPage.storeClose.routeName, page: () => const StoreClosePage()));

    /// mainmenu
    lstPage
        .add(GetPage(name: RegisterPage.mainMenu.routeName, page: () => const MainMenuPage()));

    /// 精算完了画面
    lstPage.add(GetPage(
        name: '/storeclosecomplete',
        page: () => const StoreCloseCompletePage()));


    /// ファイルリクエスト画面
    lstPage.add(GetPage(name: '/freq', page: () => FileRequestPage()));

    /// ファイル初期化画面
    lstPage.add(GetPage(name: '/finit', page: () => FileRequestPage(freqCallMode: Rxsys.RXSYS_MSG_FINIT.id)));


    /// 設定(テスト用)
    lstPage.add(
        GetPage(name: '/testsetting', page: () => TestSettingPage()));
    lstPage
        .add(GetPage(name: '/tmpstorecloseut1', page: () => const TmpStoreCloseUT1()));

    /// 予約レポートの出力画面
    lstPage.add(GetPage(name: '/batchReportOutput', page: () => const BatchReportOutputPage()));

    lstPage.add(
        GetPage(name: '/fullself_selectpay', page: () => FullSelfSelectPayPage()));

    return lstPage;
  }
}
