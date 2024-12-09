/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';

import '../inc/apl/rxmem_define.dart';
import '../inc/apl/rxregmem_define.dart';
import '../inc/lib/cm_sys.dart';
import '../inc/sys/tpr_dlg.dart';
import '../inc/sys/tpr_log.dart';
import '../lib/apllib/apllib_staffpw.dart';
import '../lib/cm_sys/cm_cksys.dart';
import '../lib/cm_sys/cm_cktwr.dart';
import '../lib/cm_sys/cm_stf.dart';
import '../regs/checker/rc_clxos.dart';
import '../regs/checker/rcky_stl.dart';
import '../regs/checker/rcsyschk.dart';
import '../regs/inc/rc_regs.dart';
import '../regs/spool/rsmain.dart';
import '../ui/colorfont/c_basecolor.dart';
import '../ui/enum/e_dual_response.dart';
import '../ui/enum/e_dual_status.dart';
import '../ui/enum/e_screen_kind.dart';
import '../ui/menu/register/enum/e_register_page.dart';
import '../ui/menu/register/m_menu.dart';
import '../ui/page/common/component/w_lock_message_panel.dart';
import '../ui/page/common/component/w_msgdialog.dart';
import '../ui/page/register/controller/c_registerbody_controller.dart';
import '../ui/page/subtotal/controller/c_coupons_controller.dart';
import '../ui/page/subtotal/controller/c_payment_controller.dart';
import '../ui/page/subtotal/controller/c_subtotal_controller.dart';
import '../ui/socket/client/register2_socket_client.dart';
import '../ui/socket/model/customer_socket_model.dart';
import '../ui/socket/model/dual_response_socket_model.dart';
import 'cls_conf/sysJsonFile.dart';
import 'cmn_sysfunc.dart';

/// 2人制を実行するクラス
class DualCashierUtil {
  /// 機種がDualCashierか判定
  static Future<bool> isDualCashier(bool isDual) async {
    return await rcKySelf(isDual) == RcRegs.KY_DUALCSHR;
  }

  /// 機種がCheckerか判定
  static Future<bool> isChecker(bool isDual) async {
    return await rcKySelf(isDual) == RcRegs.KY_CHECKER;
  }

  /// 機種がDesktopTypeか判定
  static Future<bool> isDesktopType(bool isDual) async {
    return await rcKySelf(isDual) == RcRegs.DESKTOPTYPE;
  }

  /// register2か判定
  static bool isRegister2() {
    return EnvironmentData().screenKind == ScreenKind.register2;
  }

  /// 機種を返す
  static Future<int> rcKySelf(bool isDual) async {
    if (RcClxosCommon.validClxos) {
      var ret = await RcSysChk.rcKySelf();
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "機種 rcKySelf=${ret.toString()}");
      return ret;
    }
    else {
      return !isDual
          ? RcRegs.DESKTOPTYPE
          : EnvironmentData().screenKind == ScreenKind.register
          ? RcRegs.KY_DUALCSHR : RcRegs.KY_CHECKER;
    }
  }

  /// 従業員の自動オープンを行う
  static Future<void> autoOpenStaff(int? checkerFlag) async {
    CommonController commonCtrl = Get.find();
    var autoStaffInfo = commonCtrl.autoStaffInfo;
    if (autoStaffInfo == null) {
      // ログ出力
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "autoOpenStaff autoStaffInfo null");
      return;
    }
    AplLibStaffPw.staffPw.staffData.staffCd = int.parse(autoStaffInfo.staffCd);
    await AplLibStaffPw.callOpenStaffAPI(checkerFlag);
  }

  /// 従業員の自動クローズを行う
  static Future<void> autoCloseStaff(int? checkerFlag) async {
    await AplLibStaffPw.callCloseStaffAPI(checkerFlag: checkerFlag);
  }

  /// 従業員オープン情報を取得する
  static Future<AutoStaffInfo?> getOpenStaffInfo() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      // システムエラー
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "_registerButtonClick rxMemRead error");
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: DlgConfirmMsgKind.MSG_SYSERR.dlgId,
        ),
      );
      return null;
    }
    RxCommonBuf pCom = xRet.object;

    return AutoStaffInfo(
      compCd: pCom.iniMacInfoCrpNoNo,
      streCd: pCom.iniMacInfoShopNo,
      macNo: pCom.iniMacInfoMacNo,
      staffCd: AplLibStaffPw.staffPw.staffData.staffCd.toString(),
    );
  }

  /// ロック状態を設定する
  static void setLockStatus(bool isLocked, String message) {
    if ((LockMessagePanel.isShowing && isLocked) ||
        (!LockMessagePanel.isShowing && !isLocked)) {
      return;
    }

    if (isLocked) {
      Get.dialog(
        barrierColor: BaseColor.transparentColor,
        LockMessagePanel(message: message),
      );
      LockMessagePanel.isShowing = true;
    }
    else {
      Get.back();
      LockMessagePanel.isShowing = false;
    }
  }

  /// 2人制キーが有効か判定
  static Future<bool> isDualModeSwitchEnable(int rcKySelf, {bool viewDialog = false}) async {
    bool isPaymentSuccess = false;

    // registerまたはregister2以外は2人制キー無効
    if (EnvironmentData().screenKind != ScreenKind.register &&
        EnvironmentData().screenKind != ScreenKind.register2) {
      if (viewDialog) {
        MsgDialog.show(
          MsgDialog.singleButtonMsg(
            type: MsgDialogType.error,
            message: '2人制未対応の機種です',
          ),
        );
      }
      return false;
    }

    CommonController commonCtrl = Get.find();
    if (commonCtrl.dualStatus != DualStatus.none && commonCtrl.dualStatus != DualStatus.dual) {
      // 2人制キー押下処理中のため無効
      if (viewDialog) {
        MsgDialog.show(
          MsgDialog.singleButtonMsg(
            type: MsgDialogType.error,
            message: '2人制キー押下処理中です',
          ),
        );
      }
      return false;
    }

    // ダイアログ表示時は無効とする
    if (MsgDialog.isDialogShowing) {
      return false;
    }

    TprLog().logAdd(
        Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "DualCashierUtil isDualModeSwitchEnable rcKySelf=${rcKySelf.toString()} ",
    );
    switch (rcKySelf) {
      case RcRegs.KY_DUALCSHR:
        try {
          PaymentController paymentCtrl = Get.find();
          isPaymentSuccess = paymentCtrl.isPaymentSuccess.value;
        } catch (e) {
          // 支払が行われていない状態としてfalseのまま
          isPaymentSuccess = false;
        }
        try {
          CommonController commonCtrl = Get.find();
          isPaymentSuccess =
              !commonCtrl.dualModeDataReceived.value || isPaymentSuccess;
        } catch (e) {
          // データを受信していない状態としてtrueとみなす
          isPaymentSuccess = true;
        }

        // 支払完了時
        if (isPaymentSuccess) {
          // タワー側からの送信データが残っている場合はキー無効
          var fileNum = await RsMain.getSpoolCount();
          if (fileNum == 0) {
            return true;
          }
        }
        if (viewDialog) {
          MsgDialog.show(
            MsgDialog.singleButtonMsg(
              type: MsgDialogType.error,
              message: '取り引き中または操作中です',
            ),
          );
        }
        return false;
      case RcRegs.KY_CHECKER:
        bool isRegistration = RckyStl.checkRegistration();
        if (isRegistration && viewDialog) {
          MsgDialog.show(
            MsgDialog.singleButtonMsg(
              type: MsgDialogType.error,
              message: '登録処理中です',
            ),
          );
        }
        return !isRegistration;
      default:
        // 取り引き中か判定
        var result = RegsMem().lastResultData?.totalDataList?.isEmpty ?? true;
        if (!result && viewDialog) {
          MsgDialog.show(
            MsgDialog.singleButtonMsg(
              type: MsgDialogType.error,
              message: '取り引き中です',
            ),
          );
        }
        return result;
    }
  }

  /// 2人制開始処理
  static Future<void> startDualMode() async {
    CommonController commonCtrl = Get.find();
    commonCtrl.isDualMode.value = true;
    var cmStf = CmStf();
    await cmStf.cmPersonSet(2);
    try {
      commonCtrl.dualModeDataReceived.value = false;
    }
    catch (e) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "startDualMode CommonController error=${e.toString()}");
    }
  }

  /// 2人制終了処理
  static Future<void> endDualMode() async {
    CommonController commonCtrl = Get.find();
    commonCtrl.isDualMode.value = false;
    var cmStf = CmStf();
    await cmStf.cmPersonSet(1);
  }

  /// 2人制初期化処理
  static Future<void> initDualMode() async {
    var cmStf = CmStf();
    await cmStf.cmPersonSet(1);
    await autoCloseStaff(0);
    await autoCloseStaff(1);
  }

  /// 小計画面に遷移する
  static Future<bool> transSubtotal() async {
    try {
      var paymentCtrl = Get.find<PaymentController>();
      paymentCtrl.isPaymentSuccess.value = true;
    } catch(_) {}

    try {
      // 小計画面がpush済みか判定用。pushしていない場合は例外になる。
      Get.find<SubtotalController>();
      Get.until((route) =>
        route.settings.name == '/subtotal');
    }
    catch (e) {
      CommonController commonCtrl = Get.find();
      if (!commonCtrl.onRegisterRoute.value) {
        transRegister();
        await Future.delayed(const Duration(milliseconds: 100));
      }
      Get.toNamed('/subtotal', arguments: true);
    }
    return true;
  }

  /// 登録画面に遷移する
  static void transRegister() {
    try {
      // 登録画面がpush済みか判定用。pushしていない場合は例外になる。
      Get.find<RegisterBodyController>();
      SetMenu1.navigateToRegisterPage();
    }
    catch (e) {
      Get.until((route) =>
      route.settings.name == RegisterPage.mainMenu.routeName);
      Get.toNamed(RegisterPage.register.routeName, arguments: true);
    }
  }

  /// 2人制で支払後の処理
  /// 卓上側が待ち状態の場合trueを返す
  static Future<bool> paymentPostProcess() async {

    var fileNum = await RsMain.getSpoolCount();
    if (fileNum > 0) {

      SubtotalController subtotalCtrl = Get.find();
      subtotalCtrl.changeReceivedAmount.value = 0;
      subtotalCtrl.receivedAmount.value = 0;
      subtotalCtrl.totalAmount.value = 0;
      subtotalCtrl.exTaxAmount.value = 0;

      CouponsController couponCtrl = Get.find();
      couponCtrl.clearList();

      PaymentController paymentCtrl = Get.find();
      paymentCtrl.onInit();
      paymentCtrl.isPaymentSuccess.value = false;
      RegisterBodyController registBodyCntrl = Get.find();
      registBodyCntrl.refreshPurchaseData();
      registBodyCntrl.delTabList();

      CommonController commonCtrl = Get.find();

      commonCtrl.dualModeDataReceived.value = true;
      subtotalCtrl.receiveDataPaymentProcessing = false;
      subtotalCtrl.startIsolateRegistData();
    }
    else {

      CommonController commonCtrl = Get.find();

      commonCtrl.dualModeDataReceived.value = false;
      return true;
    }
    return false;
  }

  /// 2人制キー押下時処理
  static Future<void> key2Person({bool isAuto = false}) async {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "key2Person call isAuto=${isAuto.toString()}");

    if (! await check2Person()) return;

    CommonController commonCtrl = Get.find();
    int rcKySelf = await DualCashierUtil.rcKySelf(commonCtrl.isDualMode.value);
    if (await isDualModeSwitchEnable(rcKySelf, viewDialog: !isAuto)) {
      switch (rcKySelf) {
        case RcRegs.KY_DUALCSHR:
          Register2SocketClient().sendDualModeEndRequest(isAuto: isAuto);
          commonCtrl.dualStatus = DualStatus.sendEndRequest;
        case RcRegs.KY_CHECKER:
          if (commonCtrl.isDualMode.value) {
            Register2SocketClient().sendDualModeEndRequest(isAuto: isAuto);
            commonCtrl.dualStatus = DualStatus.sendEndRequest;
          }
          else {
            AutoStaffInfo? autoStaffInfo = await DualCashierUtil.getOpenStaffInfo();
            Register2SocketClient().sendDualModeRequest(autoStaffInfo!);
            commonCtrl.dualStatus = DualStatus.sendRequest;
          }
        default:
          AutoStaffInfo? autoStaffInfo = await DualCashierUtil.getOpenStaffInfo();
          Register2SocketClient().sendDualModeRequest(autoStaffInfo!);
          commonCtrl.dualStatus = DualStatus.sendRequest;
      }
    }
  }

  /// 2人制状態か判定
  static Future<bool> is2Person() async {
    CommonController commonCtrl = Get.find();
    if (await isDualCashier(commonCtrl.isDualMode.value) && EnvironmentData().screenKind == ScreenKind.register ||
        await isChecker(commonCtrl.isDualMode.value) && EnvironmentData().screenKind == ScreenKind.register2) {
      return true;
    }
    return false;
  }

  /// 2人制を使用できるか判定する
  static Future<bool> check2Person() async {
    String type = await getWebType();
    if (CmCktWr.cm_chk_tower() == CmSys.TPR_TYPE_TOWER && type == CmSys.BOOT_WEB2800_TOWER) {
      return true;
    }
    return false;
  }
  /// WEBの機種タイプを取得する
  static Future<String> getWebType() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    String retWebType = CmSys.BOOT_WEB2800_DESKTOP;
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      SysJsonFile sysIni = pCom.iniSys;
      retWebType = CmCksys.cmWebTypeGet(sysIni);
    }
    return retWebType;
  }

  /// チェッカーまたはキャッシャーの表示値を返す
  static String getTargetName() {
    return EnvironmentData().screenKind == ScreenKind.register ? 'チェッカー' : 'キャッシャー';
  }

  /// 2人制ソケット通信で応答エラー時のエラーメッセージを取得する
  static String getErrorMessage(DualResponseInfo dualResponseInfo, String targetName) {
    return dualResponseInfo.error == DualResponse.changeFailed.index
        ? '$targetName側が取り引き中または操作中です'
        : '$targetName側でエラーが発生しました';
  }

  static void transMainMenu() {
    String currentRoute = Get.currentRoute;
    if (currentRoute == RegisterPage.register.routeName ||
        currentRoute == RegisterPage.tranining.routeName) {
      Get.until(ModalRoute.withName(RegisterPage.mainMenu.routeName));
    }
    else {
      Get.back();
    }
  }
}
