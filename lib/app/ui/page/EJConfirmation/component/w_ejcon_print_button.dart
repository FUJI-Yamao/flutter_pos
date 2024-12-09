/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///印字ボタンの構築
class PrintButton extends StatelessWidget {
  final Function() onPrintPressed;
  const PrintButton({super.key, required this.onPrintPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      child: SizedBox(
        width: 104.w,
        height: 56.h,
        child: SoundElevatedButton(
          onPressed: onPrintPressed,
          callFunc: runtimeType.toString(),
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.scanButtonColor,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: Text(
            //'印字',
            'l_cmn_print'.trns,
            style: TextStyle(
              color: BaseColor.someTextPopupArea,
              fontSize: BaseFont.font18px,
              fontFamily: BaseFont.familySub,
            ),
          ),
        ),
      ),
    );
  }
}
