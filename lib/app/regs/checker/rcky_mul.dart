/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/cmn_sysfunc.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../ui/page/manual_input/controller/c_keypresed_controller.dart';
import '../inc/rc_mem.dart';
import 'rcsyschk.dart';


///メカキー　×  FuncKey.KY_MUL
class RckyMul {

  /// FuncKey.KY_MULの実値
  static const String actualValue = 'x';

  ///  関連tprxソース: rcky_mul.c - rcKyMul
  static void rcKyMul() async {
   // TODO:×キーの処理を記載. 画面によって機能が変わったり特定の画面だけ動かす場合は画面分岐を入れること
   debugPrint("call rcKyMul");
   final  keyPressCtrl = Get.find<KeyPressController>();
   ///FuncKey.KY_MUL 押したら　'x'　を表示する
   keyPressCtrl.updateKey(actualValue);

  }
  
  ///  関連tprxソース: rcky_mul.c - rcChk_Ky_Mul_busy_ichiyama
  static Future<bool> rcChkKyMulBusyIchiyama(int kMul1) async {
    AcMem cMem = SystemFunc.readAcMem();
    if (((await CmCksys.cmIchiyamaMartSystem() != 0) ||
        (await RcSysChk.rcChkSchMultiSelectSystem()))
        && (cMem.scrData.mulkey != 0)
        && (kMul1 > 0)
        && (kMul1 < cMem.scrData.mulkey)) {
      return true;
    }
    return false;
  }
}