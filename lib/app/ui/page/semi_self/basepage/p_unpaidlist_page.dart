/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../component/w_semiself_bottom_buttonsection.dart';
import '../component/w_semiself_unpaid_list.dart';
import '../component/w_semiself_unpaidlist_receiptdata.dart';
import '../controller/c_unpaid_controller.dart';

///未精算一覧のページ画面
class UnpaidListPage extends StatelessWidget {
  final UnPaidListController unPaidCtrl = Get.put(UnPaidListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '未精算一覧',
          style: TextStyle(
            fontSize: 36,
            color: BaseColor.baseColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: BaseColor.inputBaseColor,
        automaticallyImplyLeading: false,
        actions: [
          //右上のキャンセルボタン
          SoundTextButton(
              onPressed: () {
                Get.back();
              },
              callFunc: runtimeType.toString(),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.close,
                      color: BaseColor.baseColor, size: 45),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'キャンセル',
                    style: TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font18px),
                  ),
                ],
              )),
        ],
      ),
      backgroundColor: BaseColor.customerPageBackGroundColor,
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0, left: 10.0),
                      //未精算一覧の左リスト
                      child: UnpaidListLeftSection(),
                    ),
                  ),
                  //未精算一覧の右詳細
                  UnpaidListRightSection(),
                ],
              ),
            ),
            SizedBox(height: 20,),
            //未精算一覧の底ボタン
            UnpaidBottomButtonSection(),
          ],
        ),
      ),
    );
  }
}
