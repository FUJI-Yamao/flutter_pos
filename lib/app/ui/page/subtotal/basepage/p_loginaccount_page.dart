/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/page/common/basepage/common_base.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_tab_subtotal_widget.dart';
import 'package:flutter_pos/app/ui/page/subtotal/controller/c_loginAccount_controller.dart';
import 'package:get/get.dart';
import '../component/w_loginitem_container.dart';

class LoginAccountPage extends CommonBasePage {
  /// コントローラ
  final loginCtrl = Get.put(LoginAccountController());

  /// コンストラクタ
  LoginAccountPage({super.key, required this.title})
      : super(
    title: title,
  );
  ///　画面タイトル
  final String title;


  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: [
          LoginAccountTab(svgPath: 'assets/images/',),
          BottomSection(),
        ],
      ),
    );
  }



}
