/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';

///ページ1画面
class Page1 extends StatelessWidget {
  ///コンストラクタ
   const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '上から順番に　fontFamily: TS UD角ゴ DemiBold(DB)　／　TS UD角ゴ Medium(M)　／　NUDモトヤN3等幅　フォントサイズ22',
                  style: TextStyle(fontSize: BaseFont.font18px),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'あいうえお1234567890１２３４５６７８９０ABCDEFabcdef',
                  style: TextStyle(fontSize: BaseFont.font22px, fontFamily: BaseFont.familySub),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'あいうえお1234567890１２３４５６７８９０ABCDEFabcdef',
                  style: TextStyle(fontSize: BaseFont.font22px, fontFamily:  BaseFont.familyDefault),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'あいうえお1234567890１２３４５６７８９０ABCDEFabcdef',
                  style: TextStyle(fontSize: BaseFont.font22px, fontFamily:  BaseFont.familyNumber),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => Get.back(),
                  callFunc: runtimeType.toString(),
                  child: Text(
                    'l_cmn_back'.trns,
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
