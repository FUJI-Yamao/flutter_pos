/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/dual_cashier_util.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../menu/register/m_menu.dart';
import '../../common/component/w_msgdialog.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../model/m_mix_match_data.dart';
import '../model/m_price_check_data.dart';

/// 価格確認画面のデータコントローラ
class PriceCheckController extends GetxController {
  /// コンストラクタ
  PriceCheckController();

  /// 価格確認リスト
  final priceCheckItemData = <PriceCheckData>[].obs;

  /// ミックスマッチ
  var mixMatchData = MixMatchData(mixMatchItems: <MixMatchItem>[],
      generalAverageUnitPrice: 1000,
      memberAverageUnitPrice: 800,
      isGeneralExist: true,
      isMemberExist: true).obs;

  /// 商品名
  var itemName = ''.obs;

  /// JANコード
  var janCode = ''.obs;

  /// 分類コード
  var clsCode = ''.obs;

  /// 価格確認画面の表示状態
  var isPrcChkView = false.obs;

  /// 価格情報を削除する
  void clearPriceData() {
    itemName.value = '';
    janCode.value = '';
    clsCode.value = '';
    priceCheckItemData.clear();
    mixMatchData.value = MixMatchData(mixMatchItems: <MixMatchItem>[],
        isGeneralExist: false,
        isMemberExist: false);
  }

  /// 価格確認情報の商品名、JANコード、分類コードを設定する
  void setPriceDataHeader(String itemName, String janCode, String clsCode) {
    this.itemName.value = itemName;
    this.janCode.value = janCode;
    this.clsCode.value = clsCode;
  }

  /// 価格確認リストに価格確認データを追加する
  void addPriceCheckData(PriceCheckData priceCheckData) {
    priceCheckItemData.add(priceCheckData);
  }

  /// ミックスマッチデータを設定する
  void setMixMatchData(MixMatchData mixMatchData) {
    this.mixMatchData.value = mixMatchData;
  }

  /// 価格確認モードを開始する
  Future<void> startPrcChkStatus() async {
    RegisterBodyController bodyCtrl = Get.find();
    CommonController commonCtrl = Get.find();
    bodyCtrl.prcChkMode.value = true;

    // キー状態の設定
    AcMem cMem = SystemFunc.readAcMem();
    RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_PRCCHK.keyId);
    debugPrint('価格確認モード：オン');

    if (commonCtrl.onSubtotalRoute.value) {
      // 登録画面に遷移
      SetMenu1.navigateToRegisterPage();
    }
  }

  /// 価格確認モードを終了する
  Future<void> endPrcChkStatus() async {
    RegisterBodyController bodyCtrl = Get.find();
    CommonController commonCtrl = Get.find();
    bodyCtrl.prcChkMode.value = false;

    // キー状態の設定
    AcMem cMem = SystemFunc.readAcMem();
    RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_PRCCHK.keyId);

    debugPrint('価格確認モード：オフ');

    if (await DualCashierUtil.isDualCashier(commonCtrl.isDualMode.value)) {
      // 小計画面に遷移
      SetMenu1.navigateToPaymentCompletePage();
    }
  }

  /// 価格確認キーのオペエラーダイアログ表示
  void showOperationErrorDialog() {
    MsgDialog.show(MsgDialog.singleButtonDlgId(
      type: MsgDialogType.error,
      dialogId: DlgConfirmMsgKind.MSG_OPEBUSYERR_KEYSTATUS.dlgId,
      replacements: const ['価格確認'],
    ));
  }
}
