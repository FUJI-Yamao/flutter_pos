/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../regs/checker/rc_clxos.dart';
import '../../../../regs/checker/rcky_stl.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/checker/regs.dart';
import '../../../../regs/common/rxkoptcmncom.dart';
import '../../../../regs/spool/rsmain.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../controller/c_common_controller.dart';
import '../../../enum/e_presetcd.dart';
import '../../common/component/w_msgdialog.dart';
import '../component/discount_item.dart';
import 'c_coupons_controller.dart';

///小計画面のコントローラー一覧
class SubtotalController extends GetxController {
  //
  // 合計値エリア------
  /// 小計エリアの高さ
  RxDouble subtotalAreaHeight = 0.0.obs;

  /// 点数. 返品時はマイナス
  RxInt totalQty = 0.obs;

  /// 小計 clxos subtotal
  RxInt subtotal = 0.obs;

  /// 値引合計 clxos subDscAmount
  RxInt subDscAmount = 0.obs;

  /// 税額合計 clxos exTaxAmount
  RxInt exTaxAmount = 0.obs;

  ///合計金額. clxos amount
  RxInt totalAmount = 0.obs;

  ///値引／割引 情報受け渡し用リスト
  var dscItemList = <DiscountItem>[].obs;

  //　支払額エリア-------
  /// 預かり金額
  RxInt receivedAmount = 0.obs;

  /// 現金支払い画面で入金した額
  RxInt changeReceivedAmount = 0.obs;

  /// 不足金額
  RxInt notEnoughAmount = 0.obs;

  /// おつり金額
  RxInt changeAmount = 0.obs;

  /// 釣り銭支払  0:あり 1:なし
  RxInt nochgFlg = 0.obs;

  ///trueになったら、おつり金額に変える、さもなければ不足を表示
  var isChange = false.obs;

  /// 現在の現金支払いモード
  var currentPaymentMethod = 'haveChangeMachine'.obs;

  /// 小計値下ボタンを表示するかどうか
  final dspStlButton = false.obs;

  /// タワー側から送信される登録データの監視用
  Isolate? _isolateRegistData;
  late StreamSubscription subscription;
  final ReceivePort _receivePort = ReceivePort();

  CommonController commonCtrl = Get.find();

  ///不足時の色
  final notEnoughBorderColor = BaseColor.attentionColor;
  final notEnoughBackgroundColor = BaseColor.tenkeyBackColor2;

  ///文字色
  final notEnoughTextColor = BaseColor.attentionColor;
  final changeTextColor = BaseColor.accentsColor;

  ///おつり時の色
  final changeBorderColor = BaseColor.accentsColor;
  final changeBackgroundColor = BaseColor.loginBackColor;

  bool receiveDataPaymentProcessing = false;

  ///不足とお釣りの変更関数
  void toggleChange() {
    isChange.value = !isChange.value;
  }

  ///金額変数名初期化
  @override
  void onInit() async {
    super.onInit();
    receivedAmount.value = 0; //受け取り金額初期化
    notEnoughAmount.value = 0; //不足金額初期化
    changeAmount.value = 0; //お釣り

    // お預り金額や合計金額が変更された場合に再計算する
    ever(receivedAmount, (_) => calculateAmounts());
    ever(totalAmount, (_) => calculateAmounts());
    // 小計情報を更新する
    changeDiscountValue();

    // 2人制の場合のみ以下listenが稼働する
    subscription = _receivePort.listen((message) async {
      // 登録データファイル数の取得
      var fileNum = await RsMain.getSpoolCount();
      if (fileNum > 0 &&
          !MsgDialog.isDialogShowing &&
          commonCtrl.dualModeDataReceived.value &&
          !receiveDataPaymentProcessing) {
        receiveDataPaymentProcessing = true;
        // データ呼出処理を行う
        int errNo = RcClxosCommon.validClxos
            ? await RckyStl.rcKyStlError(isDual: true)
            : 0;
        if (errNo != 0) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: errNo,
          ));
        }
        int logLevel =
            errNo == 0 ? LogLevelDefine.normal : LogLevelDefine.error;
        TprLog().logAdd(Tpraid.TPRAID_NONE, logLevel,
            'rcKyStlError error=${errNo.toString()}');
        onInit();
        return;
      }
    });
    List<PresetInfo> allPresets = await RegistInitData.presetReadDB();
    var presetTitles = allPresets
        .where((item) => item.presetCd == PresetCd.subtotalSupport.value && item.kyCd != 0)
        .toList();
    dspStlButton.value = presetTitles.isNotEmpty;
  }

  @override
  void onClose() {
    _receivePort.close();
    _isolateRegistData?.kill(priority: Isolate.immediate);
    super.onClose();
  }

  /// 小計情報を更新する
  void _updateSubttlInfo() {
    try {
      // 点数
      totalQty.value = RegsMem().tTtllog.getItemCount();

      // 小計金額（税込み商品合計金額）
      subtotal.value = RegsMem().lastTotalData?.subtotal ?? 0 ;
      // 値引き合計額.通常モード時値引き額が正の値であるため、表示用にマイナスに変換する
      subDscAmount.value = -(RegsMem().lastTotalData?.subDscAmount ?? 0);

      // 税額合計
      exTaxAmount.value = RegsMem().lastTotalData?.exTaxAmount ?? 0 ;
      // 合計金額を計算
      totalAmount.value = RegsMem().lastTotalData?.amount ?? 0;
    } catch (e) {
      debugPrint('エラー : $e');
    }
  }
  /// 小計情報を初期化する
  void initializationSubttlInfo() {
    // 税データ以外をリセット
    RegsMem().resetTranData();
    // 現金支払い画面で入金した額
    changeReceivedAmount.value = 0;
    // 預かり金額
    receivedAmount.value = 0;
    // お釣り
    changeAmount.value = 0;

    CouponsController couponCtrl = Get.find();
    couponCtrl.clearList();
  }

  ///暫定の不足額とおつり額の計算ロジック
  void calculateAmounts() {
    if (nochgFlg.value == 1) {
      notEnoughAmount.value = 0;
      changeAmount.value = 0;
    } else {
      notEnoughAmount.value =
          totalAmount.value - receivedAmount.value - changeReceivedAmount.value;
      changeAmount.value =
          receivedAmount.value + changeReceivedAmount.value - totalAmount.value;
    }
    isChange.value =
        receivedAmount.value + changeReceivedAmount.value >= totalAmount.value;
    if (receivedAmount.value + changeReceivedAmount.value >=
        totalAmount.value) {
      currentPaymentMethod.value = 'paymentComplete';
    } else {
      currentPaymentMethod.value =
          currentPaymentMethod.value == 'noChangeMachine'
              ? 'noChangeMachine'
              : 'haveChangeMachine';
    }
  }

  ///現在の支払いメソッドを更新
  void updatePaymentMethod(String method) {
    currentPaymentMethod.value = method;
  }

  ///タワー側からの受信データ監視処理の開始
  Future<void> startIsolateRegistData() async {
    if (_isolateRegistData == null) {
      _isolateRegistData =
          await Isolate.spawn(isolateEntryPoint, _receivePort.sendPort);
    } else {
      subscription.resume();
    }
  }

  ///タワー側からの登録データ監視停止
  void stopIsolateRegistData() {
    subscription.pause();
  }

  ///登録データ監視のエントリポイント
  static void isolateEntryPoint(SendPort sendPort) {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final currentTime = DateTime.now().toString();
      sendPort.send(currentTime);
    });
  }

  /// 小計情報を更新する
  void changeDiscountValue() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    List<SubttlResData> discountItemList = RegsMem().lastResultData?.subttlList ?? [];
    dscItemList.clear();
    dscItemList.value = discountItemList.map((e) => DiscountItem(
      dscType: getDscTypeValue(cBuf, e.stlDscCode ?? 0),
      dscValue: -(e.stlDscAmount ?? 0),
      title: e.stlDscName ?? "",
    )).toList();
    dscItemList.refresh();
    _updateSubttlInfo();
  }

  /// 小計値下タイプを取得する.
  StlDscType getDscTypeValue(RxCommonBuf cBuf , int fncCd){
      if(Rxkoptcmncom.rxChkKeyKindPdsc(cBuf,fncCd)){
        return StlDscType.pdsc;
      }
      if(Rxkoptcmncom.rxChkKeyKindDsc(cBuf, fncCd)){
        return StlDscType.dsc;
      }
      return StlDscType.none;
  }
}


