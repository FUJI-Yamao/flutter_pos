/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:get/get.dart';

import '../../../component/w_sound_buttons.dart';

///商品登録ボタン押された後のとじるhearderボタン
class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: BaseColor.topCloseButtonColor,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child:
            SoundElevatedIconTextButton(
              onPressed:() {
                Get.back();
              },
              callFunc: runtimeType.toString(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColor.topCloseButtonColor,
                  minimumSize: const Size(136, 64),elevation: 0),
              icon: const Icon(
                Icons.close,
                size: 64,
                  color:BaseColor.baseColor
              ), //アイコン
              label: const Text(
                'とじる',
                style: TextStyle(
                    fontSize: 18,
                    color: BaseColor.baseColor,
                    fontFamily: BaseFont.familyDefault),
              ), //テキスト
            )
          ),
        ],
      ),
    );
  }
}
