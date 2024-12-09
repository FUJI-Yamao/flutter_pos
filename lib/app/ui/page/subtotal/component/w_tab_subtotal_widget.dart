/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../component/mx_tab_control_grey_border.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_loginAccount_controller.dart';

///登録/会計メニューのコンテナー構築
class LoginTabContainer extends StatelessWidget {
  final String svgPath;
  final String text;
  final VoidCallback onTap;
  final Color containerColor;
  final Color textColor;
  final Border border;
  final int selectIndex = 1;

  const LoginTabContainer({
    super.key,
    required this.svgPath,
    required this.text,
    required this.onTap,
    required this.containerColor,
    required this.textColor,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> boxShadow = [
      BoxShadow(
        color: BaseColor.baseColor.withOpacity(0.5),
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(0, 0),
      ),
    ];

    return Stack(children: [
      Container(
        height: 104.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: containerColor,
          boxShadow: boxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: SvgPicture.asset(
                  svgPath,
                  width: 56,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 10.w),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: BaseFont.font18px,
                    color: textColor,
                    fontFamily: BaseFont.familySub),
              ),
            ),
          ],
        ),
      ),
      Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: SoundInkWell(
            onTap: onTap,
            child: null,
            callFunc: '${runtimeType.toString()} $text',
          ),
        ),
      )
    ]);
  }
}

///登録/会計メニューのタブ構築
class LoginAccountTab extends StatelessWidget with TabControlGreyBorder {
  /// 各タブのインデックス
  static const int scanOff1 = 1;
  static const int scanOff2 = 2;
  static const int changeOff = 3;
  static const int recordOff = 4;

  /// コントローラ
  final loginCtrl = Get.put(LoginAccountController());

  /// アイコンのSVGファイルパス
  final String svgPath;

  /// コンストラクタ
  LoginAccountTab({super.key, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    Widget buildTab(int index, String svgPath) {
      ///タイトルテキスト
      String text = '';
      if (index - 1 < loginCtrl.titleData.length) {
        text = loginCtrl.titleData[index - 1];
      }
      return Expanded(
        flex: (loginCtrl.selectedIndex.value == index) ? 2 : 1,
        child: LoginTabContainer(
          svgPath: svgPath,
          text: text,
          onTap: () {
            loginCtrl.selectContainer(index);
          },
          containerColor: loginCtrl.selectedIndex.value == index
              ? BaseColor.loginBackColor
              : BaseColor.loginTabBackColor,
          textColor: loginCtrl.selectedIndex.value == index
              ? BaseColor.accentsColor
              : BaseColor.loginTabTextColor,
          border: border(
              idx: index, tabSelectedIndex: loginCtrl.selectedIndex.value),
        ),
      );
    }

    return SizedBox(
      width: 1024.w,
      height: 104.h,
      child: Obx(() {
        return Row(
          children: [
            buildTab(
              scanOff1,
              'assets/images/icon_function_scan_off.svg',
            ),
            buildTab(
              scanOff2,
              'assets/images/icon_function_scan_off.svg',
            ),
            buildTab(
              changeOff,
              'assets/images/icon_function_change_off.svg',
            ),
            buildTab(
              recordOff,
              'assets/images/icon_function_record_off.svg',
            ),
          ],
        );
      }),
    );
  }
}
