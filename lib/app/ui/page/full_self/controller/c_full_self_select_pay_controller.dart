/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/checker/regs.dart';
import '../../../enum/e_presetcd.dart';

/// フルセルフの支払い方法選択画面のコントローラー
class FullSelfSelectPayController extends GetxController {
  /// チェックされたかのフラグ
  RxBool isChecked = false.obs;

  /// idとQuicPay支払いボタンを表示するフラグ
  RxBool isShowIDQuicPay = false.obs;

  ///支払い成功したら支払い完了画面の表示
  var isPaymentSuccess = false.obs;

  ///支払方法のタイトル
  var fullSelfPaymentMethodTitle = ''.obs;

  ///支払方法
  var fullSelfPaymentMethods = <PresetInfo>[].obs;

  /// 支払成功状態を設定
  void setPaymentSuccess(bool success) {
    isPaymentSuccess.value = success;
  }

  /// 待機中画面フラグ
  final RxBool isQcUse = true.obs;

  //初期化処理
  @override
  void onInit() {
    super.onInit();
    loadFullSelfPaymentMethods();
    loadFullSelfElectronicMoneyData();
  }

  @override
  void onReady() {
    super.onReady();

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfSelectPayNumber,
      isLoop: true
    );
  }

  ///プリセットデータ読み込み処理
  void loadFullSelfPaymentMethods() async {
    List<PresetInfo> allPresets = await RegistInitData.getPresetData();
    var presetsWithCorrectPresetCd = allPresets
        .where((item) => item.presetCd == PresetCd.paymentList.value)
        .toList();
    var titlePreset =
    presetsWithCorrectPresetCd.firstWhere((item) => item.presetNo == 0);
    fullSelfPaymentMethodTitle.value = titlePreset.kyName;
    var filteredPresets =
    presetsWithCorrectPresetCd.where((item) => item.kyCd != 0).toList();
    fullSelfPaymentMethods.assignAll(filteredPresets);
  }


  /// チェックされたかのフラグを切り替える
  void changeCheckedFlg() {
    isChecked.value = !isChecked.value;
  }

  /// 電子マネーリスト
  final fullSelfeMoneyList = <PresetInfo>[].obs;


  ///電子マネーの支払方法リストデータ取得
  void loadFullSelfElectronicMoneyData() async {
    var allPresets = await RegistInitData.getPresetData();
    var filteredPresets = allPresets
        .where((item) =>
    item.presetCd == PresetCd.electronicMoney.value && item.kyCd != 0)
        .toList();
    fullSelfeMoneyList.assignAll(filteredPresets);
  }


  ///支払いボタン押されたら挙動
  void paymentButtonAction(PresetInfo presetData) {
    // ガイダンス音声の停止
    RcSound.stop();

    TchKeyDispatch.rcDTchByKeyId(presetData.kyCd, presetData);
  }
}
