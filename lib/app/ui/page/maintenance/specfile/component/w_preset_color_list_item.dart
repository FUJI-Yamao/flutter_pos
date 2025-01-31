/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_sound_buttons.dart';
import '../../../../enum/e_presetcd.dart';
import '../model/m_widgetsetting.dart';

/// 項目名 項目値　変更ボタン　を表示するWidget
/// QC指定のプリセット色の設定値が201～212のときは、背景色が表示される
class PresetColorListItem extends StatelessWidget {
  const PresetColorListItem({
    super.key,
    required this.lblsetting,
    required this.txtsetting,
    required this.btnsetting,
    this.flex = 5,
  });

  /// 項目名のUI設定.
  final Rx<SpecFileLblSetting> lblsetting;

  /// 項目値のUI設定.
  final Rx<SpecFileTxtSetting> txtsetting;

  /// 変更ボタンのUI設定.
  final Rx<SpecFileBtnSetting> btnsetting;

  /// flex
  final int flex;

  @override
  Widget build(BuildContext context) {
    int lastSecFlex = 8 - flex;
    int lastflex = 1;
    int maxFontNum = 12;
    return SizedBox(
      height: 98,
      child: Row(
        children: [
          // 項目名.
          Expanded(
            flex: flex,
            child: Stack(
              children: [
                Container(
                  margin: lblsetting.value.margin,
                  alignment: lblsetting.value.alignment,
                  padding: lblsetting.value.padding,
                  height: ScreenUtil().setHeight(lblsetting.value.height),
                  width: ScreenUtil().setWidth(lblsetting.value.width),
                  child: Text(
                    lblsetting.value.text,
                    maxLines:
                    lblsetting.value.text.length <= maxFontNum ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: lblsetting.value.textcolor,
                      fontSize: lblsetting.value.fontsize,
                      height: 1 + (6 / lblsetting.value.fontsize),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: lblsetting.value.backcolor, // .withOpacity(0.3)
                    child: SoundInkWell(
                      onTap: () {
                        lblsetting.value.isSelectedKey = true;
                        lblsetting.value.onTap?.call();
                      },
                      callFunc: '${runtimeType.toString()} ${lblsetting.value.text}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          // 項目値 + 変更ボタン
          Expanded(
            flex: lastSecFlex + lastflex,
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Row(
                    children: [
                      // 項目値.
                      Expanded(
                        flex: lastSecFlex,
                        child: Obx(() {
                          Color backColor = PresetCd.getBtnColor(int.tryParse(txtsetting.value.text)!);
                          return Container(
                            color: backColor,
                            padding: backColor == Colors.transparent
                                ? txtsetting.value.padding
                                : const EdgeInsets.only(left: 8.0),
                            alignment: backColor == Colors.transparent
                                ? txtsetting.value.alignment
                                : Alignment.centerLeft,
                            height: txtsetting.value.height,
                            width: txtsetting.value.width,
                            child: Text(
                              txtsetting.value.text,
                              style: TextStyle(
                                // 背景色が透明なら白、透明でないなら黒で表示
                                color: backColor == Colors.transparent
                                    ? txtsetting.value.textcolor
                                    : BaseColor.baseColor,
                                fontSize: txtsetting.value.fontsize,
                                letterSpacing: 2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }),
                      ),
                      // 変更ボタン.
                      Expanded(
                        flex: lastflex,
                        child: SizedBox(
                          width: btnsetting.value.width,
                          height: btnsetting.value.height,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_forward_ios,
                                  size: 25, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: SoundInkWell(
                      onTap: () => txtsetting.value.onTap?.call(),
                      callFunc: '${runtimeType.toString()} ${txtsetting.value.text}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
