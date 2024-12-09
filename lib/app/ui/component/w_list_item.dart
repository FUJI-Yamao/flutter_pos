/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'w_sound_buttons.dart';

/// 項目名 項目値　変更ボタン　を表示するWidget
class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.lblsetting,
    required this.txtsetting,
    required this.btnsetting,
    required this.axis,
    required this.containsSwitch,
    this.flex = 5,
  });

  /// 項目名のUI設定.
  final lblsetting;

  /// 項目値のUI設定.
  final txtsetting;

  /// 変更ボタンのUI設定.
  final btnsetting;

  /// 縦に並べるか横に並べるか.
  final axis;

  /// flex
  final int flex;

  /// スイッチが含まれるかどうか.
  final bool containsSwitch;

  @override
  Widget build(BuildContext context) {
    int lastSecFlex = 8 - flex;
    int lastflex = 1;
    int maxFontNum = 12;
    return SizedBox(
      height: 98,
      child: Flex(
        direction: axis.value,
        children: [
          // 項目名.
          Expanded(
            flex: flex,
            child: Material(
              color: lblsetting.value.backcolor, // .withOpacity(0.3)
              child: SoundInkWell(
                onTap: () {
                  lblsetting.value.isSelectedKey = true;
                  lblsetting.value.onTap?.call();
                },
                callFunc: '${runtimeType.toString()} ${lblsetting.value.text}',
                child: Container(
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
              ),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          // 項目値 + 変更ボタン
          Expanded(
            flex: lastSecFlex + lastflex,
            child: Material(
              color: txtsetting.value.backcolor, // .withOpacity(0.3)
              child: SoundInkWell(
                onTap: txtsetting.value.onTap,
                callFunc: '${runtimeType.toString()} ${txtsetting.value.text}',
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Row(
                    children: [
                      // 項目値.
                      Expanded(
                        flex: lastSecFlex,
                        child: Container(
                          alignment: txtsetting.value.alignment,
                          height: txtsetting.value.height,
                          width: txtsetting.value.width,
                          child: Obx(
                            () => Text(
                              txtsetting.value.text,
                              style: TextStyle(
                                color: txtsetting.value.textcolor,
                                fontSize: txtsetting.value.fontsize,
                                letterSpacing: 2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      // 変更ボタン.
                      if (btnsetting != null)
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
