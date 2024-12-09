/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import '../../../colorfont/c_basecolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basefont.dart';

/// トグルボタン
/// [toggleBool]  トグルボタンの切り替えbool <RxBool>
/// [setState]  setStateを渡してください(GetX Package)
/// [leftText]  左ラベルテキスト <String>
/// [rightText] 右ラベルテキスト <String>

class ToggleSwitch {
  Widget toggleSwitch(
      RxBool toggleBool, setState, String leftTxt, String rightTxt) {
    return Container(
        //全体
        decoration: BoxDecoration(
          color: BaseColor.accentsColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(children: [
          // 左側
          Positioned(
            left: 4,
            top: 4,
            bottom: 4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  toggleBool.value = true;
                });
              },
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 112.w,
                  height: 48.h,
                  decoration: toggleBool.value
                      ? BoxDecoration(
                          color: BaseColor.accentsColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: BaseColor.someTextPopupArea,
                          ))
                      : const BoxDecoration(),
                  alignment: Alignment.center,
                  child: Text(
                    leftTxt,
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font18px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //右側の表示
          Positioned(
            right: 4,
            top: 4,
            bottom: 4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  toggleBool.value = false;
                });
              },
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 112.w,
                  height: 48.h,
                  decoration: toggleBool.value
                      ? const BoxDecoration()
                      : BoxDecoration(
                          color: BaseColor.accentsColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: BaseColor.someTextPopupArea,
                          )),
                  alignment: Alignment.center,
                  child: Text(
                    rightTxt,
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font18px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
