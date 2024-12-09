/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../if/if_drv_control.dart';
import '../../../../../if/if_scan_isolate.dart';
import '../../../../../inc/apl/rxmem_define.dart';
import '../../../../../inc/sys/tpr_aid.dart';
import '../../../../../regs/checker/rc_key.dart';
import '../../../../component/w_inputbox.dart';
import '../../../common/component/w_msgdialog.dart';
import '../model/m_specfile.dart';
import 'c_key_controller_base.dart';

/// キーボードー用コントローラー
class KeyboardController extends KeyControllerBase {
  final isShifted = false.obs;
  final keyBordStr1 = 'QWERTYUIOP'.obs;
  final keyBordStr2 = 'ASDFGHJKL'.obs;
  final keyBordStr3 = 'ZXCVBNM'.obs;
  final symbols =
      ["!+", "#*", "＄?", "%=", "&|", "@^", "({", ")}", "<[", ">]"].obs;

  KeyboardController(this.inputBox, this.setting);


  @override
  KeyDispatch? getKeyCtrl() {
    late  KeyDispatch keyCon ;
    if(IfDrvControl().mkeyIsolateCtrl.dispatch == null){
          keyCon = KeyDispatch(Tpraid.TPRAID_NONE);
    }else{
      // キー登録の処理が既にあるなら引き継ぐ.
      keyCon = KeyDispatch.copy(IfDrvControl().mkeyIsolateCtrl.dispatch!);
    }
    keyCon.funcNum = (key){
      addString(key.getFuncKeyNumberStr());
    };
    keyCon.funcClr = (){
    
      clearString();
    };
    return keyCon;
  }

    @override
   Function(RxInputBuf)? getScanCtrl(){
    // スキャンの処理が既にあるなら引き継ぐ.
    if(IfDrvControl().scanMap.isEmpty){
      // 登録されていない
          return null;
    }
    return IfScanIsolate().funcScan;
  }


  final GlobalKey<InputBoxWidgetState> inputBox;
  final StringInputSetting setting;

  String getNowStr() {
    InputBoxWidgetState? state = inputBox.currentState;
    return state?.inputStr ?? "";
  }

  /// 入力されている文字列に、[strVal]を追加する.
  /// lengthの範囲内に収まらなくなる場合には追加しない
  @override
  void addString(String strVal) {
    if (strVal.length == 2 && strVal != "00") {
      strVal = strVal[0];
    }
    bool valid = checkOverLimit(strVal.toString());
    if (!valid) {
      MsgDialog.show(
        //todo ダイアログメッセージ確定出来たらdialogKindを追加
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message:"${setting.digitTo}文字以内で入力してください",
        ),
      );

    } else {
      inputBox.currentState?.onAddStr(strVal);
    }
  }

  /// 入力されている内容が上限の範囲内か
  @override
  bool checkOverLimit(String strVal) {
    int val = getNowStr().length + strVal.length;
    if ( val <= setting.digitTo) {
      return true;
    }
    return false;
  }

  /// 入力されている内容が指定の範囲内に収まっているか.
  @override
  bool checkWithInRange() {
    int val = getNowStr().length;
    if (val >= setting.digitFrom && val <= setting.digitTo) {
      return true;
    }
    return false;
  }

  // 文字クリア関数
  @override
  void clearString() {
    inputBox.currentState?.onDeleteAll();
  }

  //一文字削除関数
  @override
  void deleteOneChar() {
    inputBox.currentState?.onDeleteOne();
  }

  @override
  void tabKey(bool addCalc) {
    // 何もしない
  }

  @override
  void pushInputKey(dynamic num) {
    // キーなし
  }

  /// enterキー押下処理
  void enterKey(String strVal) {
    bool valid = checkOverLimit(strVal);
    if (valid) {
      Get.back(result: getNowStr());
    } else {
      MsgDialog.show(
        //todo ダイアログメッセージ確定出来たらdialogKindを追加
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message:"${setting.digitTo}文字以内で入力してください",
        ),
      );
    }
  }

  //　シフトキー. キーボードの文字を変更する 
  void toggleShift() {
    isShifted.value = !isShifted.value;

    //shiftが有効の場合
    if (isShifted.value) {
      //各キーボードを小文字に転換
      keyBordStr1.value = keyBordStr1.value.toLowerCase();
      keyBordStr2.value = keyBordStr2.value.toLowerCase();
      keyBordStr3.value = keyBordStr3.value.toLowerCase();
      //symbolsの文字列左右スワップ
      symbols.value = symbols.map((sym) => String.fromCharCodes(sym.runes.toList().reversed))
          .toList();
    } else {
      //shift無効の場合　キーボードを大文字に変換
      keyBordStr1.value = keyBordStr1.value.toUpperCase();
      keyBordStr2.value = keyBordStr2.value.toUpperCase();
      keyBordStr3.value = keyBordStr3.value.toUpperCase();
      //symbolsの文字列左右再度スワップ
      symbols.value = symbols.map((sym) => String.fromCharCodes(sym.runes.toList().reversed))
          .toList();
    }
  }
}
