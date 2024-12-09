/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../controller/c_common_controller.dart';

/// 言語切り替え用ダイアログ
class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15),),
      ),
      content: SizedBox(
        width: 912,
        height: 656,
        child: Column(
          children: <Widget>[
            // 右上のとじるボタン
            Align(
              alignment: Alignment.topRight,
              child: SoundTextButton(
                onPressed: () {
                  Get.back();
                },
                callFunc: runtimeType.toString(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.close,
                      color: BaseColor.baseColor,
                      size: 45,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => Text(
                      'l_full_self_back'.trns,
                      style: const TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font18px,
                      ),
                    ),),
                  ],
                ),
              ),
            ),
            // タイトル上のスペース
            const SizedBox(height: 20.0,),
            // 中央上部のアイコンとタイトル
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.language, size: 48.0, color: BaseColor.baseColor,),
                SizedBox(width: 20.0),
                Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: BaseColor.baseColor
                  ),
                ),
              ],
            ),
            // タイトル下のスペース
            const SizedBox(height: 40.0),
            // 言語を切り替えるためのボタン
            _switchLanguageButtons(),
          ],
        ),
      ),
    );
  }

  /// 言語を切り替えるためのボタン
  Widget _switchLanguageButtons() {
    CommonController commonController = Get.find();
    List<LocaleNo> languageList = [
      LocaleNo.English,
      LocaleNo.Chinese,
      LocaleNo.Korean,
      LocaleNo.Japanese,
    ];
    return Column(
      children: [
        for (int i = 0; i < languageList.length; i++)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Stack(
              children: [
                Container(
                  height: 80.0,
                  width: 240.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: BaseColor.edgeBtnColor,),
                    color: commonController.intCountry.value == languageList[i].no
                        ? BaseColor.baseColor
                        : BaseColor.someTextPopupArea,
                  ),
                  child: Text(
                    getLanguageName(languageList[i]),
                    style: TextStyle(
                      color: commonController.intCountry.value == languageList[i].no
                          ? BaseColor.someTextPopupArea
                          : BaseColor.baseColor,
                      fontSize: BaseFont.font28px,
                    ),
                  ),
                ),
                if (commonController.intCountry.value == languageList[i].no)
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        Icons.check,
                        color: BaseColor.someTextPopupArea,
                        size: 32.0,
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: SoundInkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      // 言語切り替えの処理
                      onTap: () {
                        commonController.intCountry.value = languageList[i].no;
                      },
                      callFunc: runtimeType.toString(),
                    ),
                  ),
                ),
              ],
            ),),
          ),
      ],
    );
  }

  /// enumの定義に応じて言語名を返す
  String getLanguageName(LocaleNo localeNo) {
    switch(localeNo) {
      case LocaleNo.English:
        return 'English';
      case LocaleNo.Japanese:
        return '日本語';
      case LocaleNo.Chinese:
        return '中文';
      case LocaleNo.Korean:
        return '한국';
    }
  }

}