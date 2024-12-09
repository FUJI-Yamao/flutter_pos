/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../ui/page/manual_input/controller/c_keypresed_controller.dart';

/// 価格変更
/// 関連tprxソース: rckypchg.c
class RcKyPrcChg{
  /// 関連tprxソース: rckypchg.c - rcKyPrcChg
  static void rcKyPrcChg() async {
    // TODO: 未清算一覧の処理.画面によって機能が変わったり特定の画面だけ動かす場合は画面分岐を入れること
    //todo: 暫定の手入力操作売価変更キー押されたら売価変更モードに変える処理
    final  keyPressCtrl = Get.find<KeyPressController>();
    keyPressCtrl.priceChangeMode();
    debugPrint('call  PriceChangeMode');
     debugPrint("call rcKyPrcChg");
  }

}
