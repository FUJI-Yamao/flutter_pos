/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import '../../../enum/e_presetcd.dart';
import 'p_presetselect.dart';
import 'w_purchase_scroll_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_registerpluare_controller.dart';

/// PLUボタンエリア
class PluButtonArea extends StatelessWidget {
  /// コンストラクタ
  const PluButtonArea({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラ
    PluAreaController pluAreaCtrl = Get.find();

    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Container(
          alignment: Alignment.topRight,
          color: BaseColor.someTextPopupArea,
          child: Column(
            children: [
              SizedBox(
                width: 436.w,
                height: 482.h,
                child: ScrollbarTheme(
                  data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(
                        BaseColor.baseColor.withOpacity(0.5),
                      ),
                      thickness: MaterialStateProperty.all(5)),
                  child: Scrollbar(
                    controller: pluAreaCtrl.purchaseScrollCtrl,
                    thumbVisibility: true,
                    child: Stack(children: [
                      Obx(
                        () => ListView.builder(
                          controller: pluAreaCtrl.purchaseScrollCtrl,
                          itemCount: (pluAreaCtrl.pluBtnData.length /
                                  pluAreaCtrl.pluBtnCnt)
                              .ceil(),
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: PluButtons(idx: index),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 428.w,
                  child: Stack(
                    children: [
                      Center(
                        child: PurchaseScrollButton(
                          backgroundColor: BaseColor.someTextPopupArea,
                          scrollHeight: pluAreaCtrl.scrollHeight.value,
                          purchaseScrollController:
                              pluAreaCtrl.purchaseScrollCtrl,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 17.w, top: 20.h),
                          child: SoundInkWell(
                            onTap: () {
                              Get.to(() => PresetSelectPage());
                            },
                            callFunc: runtimeType.toString(),
                            child: SvgPicture.asset(
                              'assets/images/icon_expansion.svg',
                              width: 48.w,
                              height: 48.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// PLUボタンを動的に2個作成して戻す
class PluButtons extends StatelessWidget {
  ///コンストラクタ
  const PluButtons({super.key, required this.idx});

  ///インデックス
  final int idx;

  @override
  Widget build(BuildContext context) {
    /// コントローラ
    PluAreaController pluAreaCtrl = Get.find();
    return Container(
        child: pluAreaCtrl.buildChild(pluAreaCtrl.pluBtnData, idx));
  }
}

/// PluボタンWidgetクラス（関数で利用）
class PluWidget extends StatelessWidget {
  /// コンストラクタ
  const PluWidget({
    super.key,
    required this.dispData,
    required this.visible,
    this.onTapCallback,
    this.widgetMargin,
  });

  /// 表示データ
  final PresetInfo dispData;

  ///　表示するか判断
  final bool visible;

  ///  表示margin
  final EdgeInsetsGeometry? widgetMargin;

  ///  押下した際のコールバック
  final VoidCallback? onTapCallback;

  @override
  Widget build(BuildContext context) {
    /// コントローラー
    PluAreaController pluAreaCtrl = Get.find();

    return Container(
      margin: widgetMargin ??
          EdgeInsets.only(
            left: 8.w,
          ),
      height: 72.h,
      width: 208.w,
      child: Material(
        type: MaterialType.button,
        color: BaseColor.someTextPopupArea,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        child: SoundInkWell(
          onTap: () async {
            await TchKeyDispatch.rcDTchByKeyId(dispData.kyCd, dispData);
            if (onTapCallback != null) {
              onTapCallback!();
            }
          },
          callFunc: runtimeType.toString(),
          child: Visibility(
            visible: visible,
            child: Column(
              children: [
                Container(
                  height: 8.h,
                  width: 208.w,
                  decoration: BoxDecoration(
                    color: PresetCd.getBtnColor(dispData.presetColor),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ),
                Container(
                  height: 64.h,
                  width: 208.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: PresetCd.getBtnColor(dispData.presetColor),
                      width: 1.0,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (dispData.imgName != '')
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 2, bottom: 3, left: 8, right: 9),
                              height: 56.0.h,
                              width: 74.0.w,
                              child: Image.asset(
                                "assets/images/${dispData.imgName}.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(maxWidth: 110.w),
                            child: Text(
                              dispData.kyName,
                              style: const TextStyle(
                                color: BaseColor.baseColor,
                                fontSize: BaseFont.font18px,
                                fontFamily: BaseFont.familySub,
                                height: 1 + (6 / BaseFont.font18px),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
