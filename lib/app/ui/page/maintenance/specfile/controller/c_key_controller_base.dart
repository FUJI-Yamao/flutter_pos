/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:get/get.dart';

import '../../../../../if/if_drv_control.dart';
import '../../../../../if/if_scan_isolate.dart';
import '../../../../../inc/apl/rxmem_define.dart';
import '../../../../../inc/sys/tpr_aid.dart';
import '../../../../../regs/checker/rc_key.dart';
import '../../../../controller/c_drv_controller.dart';

/// テンキー用コントローラー
abstract class KeyControllerBase extends GetxController  with RegisterDeviceEvent {

  KeyControllerBase();

  @override
  void onInit() {
    super.onInit();
    registrationEvent();     
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.tenkey;
  }

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
        pushInputKey(key.getFuncKeyNumberStr());
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

  /// 入力されている文字列に、[strVal]を追加する.
  /// from,toの範囲内に収まらなくなる場合には追加しない
  void addString(String strVal);
  /// 入力されている内容が上限の範囲内か
  bool checkOverLimit(String strVal);

  /// 入力されている内容が指定の範囲内に収まっているか.
  bool checkWithInRange();


  // 文字クリア関数
  void clearString() ;

  //一文字削除関数
  void deleteOneChar();

  /// 画面タブキーでのテキスト間移動.
  void tabKey(bool addCalc) ;

  /// 入力(0~9やA~Fなどテキストボックスに入力する)キーの押下関数.
  void pushInputKey(dynamic num);
}