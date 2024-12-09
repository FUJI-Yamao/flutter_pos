/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/w_sound_buttons.dart';

///ページ3画面
class Page3 extends StatelessWidget {
  ///コンストラクタ
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Page3',
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            SoundElevatedButton(
              onPressed: () => Get.back(),
              callFunc: runtimeType.toString(),
              child: Text(
                'l_cmn_back'.trns,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
