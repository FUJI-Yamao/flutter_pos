/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 起動用コントローラー

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../if/if_drv_control.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../regs/checker/rc_key.dart';


/// デバイスの処理を登録するページ.
/// ページごとにenumを作成する必要がある.
/// 他のページのenumを流用するとデバイスが意図しない挙動をする可能性があるので注意.
enum IfDrvPage{
  /// 登録画面.
  register,
  /// 小計画面.
  subtotal,
  /// 現金支払い画面
  cashPayment,
  /// 小計画面_電子マネー選択画面
  subtotalElectronicMoney,
  /// 小計画面_電子マネーカード選択画面
  subtotalPaymentCardTouch,
  /// 従業員オープンクローズ画面
  openclose,
  /// 商品券選択ページ
  giftcertificate,
  /// テンキーページ
  tenkey,
  /// 従業員を呼ぶページ
  callStaff,
  /// 通番訂正スキャン画面
  receiptVoid,
  ///分類登録ダイアログ画面
  MGLoginPage,
  /// メッセージダイアログ
  messageDialog,
  /// 価格確認画面
  priceCheck,
}
/// デバイスでイベントがあった際の挙動を登録する.
/// <使い方>
/// 1.デバイスのイベントを受信したいページクラスでwithする
///  例　class XXXX with RegisterDeviceEvent
/// 2.withしたクラスのコンストラクタでregistrationEvent()を呼ぶ.
/// 3. getTagを実装する
/// 4. getKeyCtrlやgetScanCtrlをoverrideして登録したい処理を実装する.
mixin  RegisterDeviceEvent{
  /// controllerのタグに日時ではなく任意のタグを追加する場合に[addTag]使用する.
  String registrationEvent({String? addTag}){
      
      String tagBase = getTag().name;
      String tag;
      if(addTag != null){
        tag = getTagWithAddStr(tagBase, addTag);
     
      }else{
        var now = DateTime.now();
        tag =  getTagWithAddStr(tagBase, now.toString());
      }
      Get.put(_DeviceController(getKeyCtrl(),getScanCtrl(),tag),tag: tag);
      return tag;
  }

  static getTagWithAddStr(String baseStr ,String add){
    return "${baseStr}_$add";
  }
 
  /// ページタグ.
  /// ページごとにUniqなenumを返す.
  IfDrvPage getTag();

  /// メカキーを押したときの処理.
  /// 処理が必要な場合にoverrideする.
  /// nullを返すとキーを押しても何もしない
  KeyDispatch? getKeyCtrl(){
    return null;
  }
  /// スキャナでスキャンした時の処理
  /// 処理が必要な場合にoverrideする.
  /// nullを返すとスキャンしても何もしない.
  Function(RxInputBuf)? getScanCtrl(){
    return null;
  }

  /// デバイスコントローラーを破棄する
  void deleteDeviceController(String tag) {
    Get.delete<_DeviceController>(tag: tag);
  }
}

/// デバイスでイベントがあった際の挙動をコントロールする.
/// ページが作成されたときにデバイスの処理を登録し、
/// ページが破棄されたときに今回登録する前の処理に戻す.
class _DeviceController extends GetxController {


  final String page;

  _DeviceController(KeyDispatch? dispatch, Function(RxInputBuf)? scan,this.page){
    IfDrvControl().dispatchMap[page] = dispatch;
    IfDrvControl().scanMap[page] = scan;
    debugPrint("page_drv_controller open $page");
  }
  /// 破棄時の処理
  @override
  void onClose() {
    super.onClose();
    IfDrvControl().dispatchMap.remove(page);
    IfDrvControl().scanMap.remove(page);

    debugPrint("page_drv_controller close $page");
  }

}
