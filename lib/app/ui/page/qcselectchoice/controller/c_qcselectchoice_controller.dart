/* 
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../page/p_qcselectchoice_page.dart';

///お釣り払い出し精算機選択画面コントローラー
class QcSelectChoiceController extends GetxController{

  ///お釣り払い出し精算機選択　0＝する、　１＝しない
  ///する　＝　Get.to QcSelectChoicePage()
  ///しない　＝　お会計券が印字され、客がQCashierのレシート読み取り部に読ませることで
  ///お釣りを受け取ることが出来る。
 
  int qcSelectChoice = 0;

  ///todo:お釣り払い出し精算機選択の動き
  void handleQcSelectChoice() {
    if(qcSelectChoice == 0) {
      Get.to(() => QcSelectChoicePage());
    } else if (qcSelectChoice == 1) {
      ///しない　＝　お会計券が印字され、客がQCashierのレシート読み取り部に読ませることで
    }
  }
}

