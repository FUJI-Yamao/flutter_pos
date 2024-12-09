/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../if/if_drv_control.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../regs/checker/rcky_mul.dart';
import '../../register/controller/c_registerbody_controller.dart';


/// 手入力操作メカキー偽装コントローラー
class KeyPressController extends GetxController {
  ///手入力操作が行われている状態判定
  var isMKInputMode = false.obs;

  ///入力したキーの状態
  var funcKeyValue = ''.obs;

  //分類登録ダイアログ画面表示してるかどうか
  //todo:将来必要かも
  //var isShowMgLogPage = false.obs;

  ///現在の入力モード設定
  var currentMode = MKInputMode.normal.obs;

  /// 二段バーコード入力前のモードを保持
  var twinBarBeforeMode = MKInputMode.normal.obs;

  /// 2段バーコード入力待ち表示の状態（false:非表示　true:表示中）
  bool waitDisplayState = false;

  ///メカキー数値状態更新
  void updateKey(String key) {
    var canUpdate = (String inputtedValue) {
      if (
      inputtedValue == RckyMul.actualValue
          && funcKeyValue.value.contains(inputtedValue)
      ) {
        debugPrint(
            '$runtimeType#updateKey(): 手入力操作で乗算キーの複数登録は認めない');
        return false;
      }

      return true;
    }(key);

    if (!canUpdate) {
      debugPrint('$runtimeType#updateKey(): メカキー数値状態更新不可');
      return;
    }

    if ((currentMode.value == MKInputMode.waitingSecond) &&
        (twinBarBeforeMode.value == MKInputMode.priceChange)) {
      currentMode.value = MKInputMode.priceChange;
    }

    funcKeyValue.value += key;
    isMKInputMode.value = true;
    debugPrint(
        '$runtimeType#updateKey(): \${funcKeyValue}=${funcKeyValue.value}');
  }

  ///二段バーコード入力待ち状態
  void startSecondBarcodeState() {
    funcKeyValue.value = '';
    waitDisplayState = true;
    if (currentMode.value == MKInputMode.priceChange) {
      twinBarBeforeMode.value = MKInputMode.priceChange;
    } else if (currentMode.value == MKInputMode.normal) {
      twinBarBeforeMode.value = MKInputMode.normal;
    }
    currentMode.value = MKInputMode.waitingSecond;
  }

  ///クリアキー押したら入力エリアを非表示にする,精算機画面に戻る
  void resetKey() {
    currentMode.value = MKInputMode.normal;
    twinBarBeforeMode.value = MKInputMode.normal;
    funcKeyValue.value = '';
    isMKInputMode.value = false;
    waitDisplayState = false;
  }

  ///売価変更モード設定
  void priceChangeMode() {
    funcKeyValue.value = '';
    currentMode.value = MKInputMode.priceChange;
  }

  ///モードによって決定ボタンの処理
  Future<void> handleConfirm() async {
    RegisterBodyController bodyController = Get.find();

    if ((currentMode.value == MKInputMode.normal) ||
        ((currentMode.value == MKInputMode.waitingSecond) &&
            (twinBarBeforeMode.value == MKInputMode.normal))) {
      debugPrint('normalJAN入力モード');
      await bodyController.manualRegistration(FuncKey.KY_PLU, funcKeyValue.value, '');
    }
    if ((currentMode.value == MKInputMode.priceChange) ||
        ((currentMode.value == MKInputMode.waitingSecond) &&
            (twinBarBeforeMode.value == MKInputMode.priceChange))) {
      debugPrint('売価変更モード');
      await bodyController.inputManualChgPrice(
          FuncKey.KY_PLU, funcKeyValue.value, '');
    }
  }



  ///メカキー模擬するメソッド
  ///todo:メカキー入力テスト用
  void simulateKeyPress(int keyCode) {
    int adjustedCode = keyCode + 1;
    debugPrint(
        "模擬するメカキー調整前:    keyCode:$keyCode  調整後adjustedCode :$adjustedCode");
    IfDrvControl().mkeyIsolateCtrl.keyCodeLoopbackIn(adjustedCode);
  }

  //todo:メカキー入力テスト用
  @override
  void onInit() {
    super.onInit();
    test();
  }

  ///8秒後二秒ずつリストのキーを模擬入力する
  //todo:メカキー入力テスト用
  Future<void> test() async {
    await Future.delayed(const Duration(seconds: 8));

    List<int> keySequence = [
      //2,49,//先に分類登録した場合
      //9,10, 22,
      //22 = 金額キー　４９＝小分類　　１０＝数値0
      // 189 = FuncKey.KY_CLR
    ];
    for (int keyCode in keySequence) {
      simulateKeyPress(keyCode);
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}

///手入力操作モード
enum MKInputMode {
  //普通モード
  normal,
  //売価変更モード
  priceChange,
  //二段目バーコード入力待ちモード
  waitingSecond,
  //割り込み中モード
  //Interrupt,
}
