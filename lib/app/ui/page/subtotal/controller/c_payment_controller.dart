/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/regs.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rc_ext.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../enum/e_presetcd.dart';
import '../../register/controller/c_registerbody_controller.dart';

///小計画面支払方法に関するコントローラー
class PaymentController extends GetxController {
  ///支払い成功したら支払い完了画面の表示
  var isPaymentSuccess = false.obs;

  //送信成功したら支払い完了画面の表示
  var isSentToMachineSuccess = false.obs;

  //送信用精算機の名前
   RxString machineName = '○○'.obs;

  ///支払方法のタイトル
  var paymentMethodTitle = ''.obs;

  ///支払方法
  var paymentMethods = <PresetInfo>[].obs;

  /// 支払い完了時に自動で画面遷移する秒数を管理するタイマー
  Timer? _timer;

  /// 支払成功状態を設定
  Future<void> setPaymentSuccess(bool success) async {
    isPaymentSuccess.value = success;

    CommonController commonCtrl = Get.find();
    if (await DualCashierUtil.isDualCashier(commonCtrl.isDualMode.value)) {
      return;
    }
    // 支払い完了時に自動で画面遷移する
    if (success) {
      _timer = Timer(const Duration(seconds: 5), () async {
        if (_timer != null) {
          _timer = null;
          Get.back();
        }
      });
    }

  }

  ///コントローラー
  final RegisterBodyController registerbodyCtrl = Get.find();

  ///支払い方法アイコンのマッピング
  final Map<String, String> icons = {
    'Money': 'assets/images/icon_cash.svg',
    'credit': 'assets/images/icon_credit.svg',
    'account_balance_wallet': 'assets/images/icon_emoney.svg',
    'prepaid': 'assets/images/icon_prepaid.png',
    'redeem': 'assets/images/icon_back.svg',
    'barcode': 'assets/images/icon_barcode.svg',
    'transport_ic': 'assets/images/icon_traffic_id.png',
    'coupon': 'assets/images/icon_coupon.svg',
  };

  ///初期化処理
  @override
  void onInit() {
    super.onInit();
    loadPaymentMethods();
    CommonController commonCtrl = Get.find();
    if (commonCtrl.rcKySelf.value == RcRegs.KY_DUALCSHR) {
      isPaymentSuccess.value = true;
    }
  }

  ///プリセットデータ読み込み処理
  void loadPaymentMethods() async {
    List<PresetInfo> allPresets = await RegistInitData.getPresetData();
    var presetsWithCorrectPresetCd = allPresets
        .where((item) => item.presetCd == PresetCd.paymentList.value)
        .toList();
    var titlePreset =
        presetsWithCorrectPresetCd.firstWhere((item) => item.presetNo == 0);
    paymentMethodTitle.value = titlePreset.kyName;
    var filteredPresets =
        presetsWithCorrectPresetCd.where((item) => item.kyCd != 0).toList();
    paymentMethods.assignAll(filteredPresets);
  }

  /// 支払方法のアイコン取得
  String getIconPath(String imgNameKey) {
    return icons[imgNameKey] ?? '';
  }

  // TODO:10138 再発行、領収書対応 の為小計画面破棄時にデータリセット
  ///　クローズ処理
  @override
  Future<void> onClose() async {
    // TODO: implement onClose
    super.onClose();

    if (isPaymentSuccess.value) {
      await RcExt.rxChkModeReset("");
      registerbodyCtrl.delTabList();
    }
  }

  /// タイマーが動いていたら止める
  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

}
