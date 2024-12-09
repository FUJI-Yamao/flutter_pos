/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/enum/e_presetcd.dart';
import 'package:flutter_pos/app/ui/page/subtotal/controller/c_loginAccount_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../component/w_sound_buttons.dart';

/// 商品登録ページメニューのアイテムUI
class ItemContainer extends StatelessWidget {
  final PresetInfo preset;
  late final  Color buttonColor;
  late final  Color borderColor;
  final loginCtrl = Get.find<LoginAccountController>();

  ///コンストラクタ
  ItemContainer({
    super.key,
    required this.preset,
  }){
    buttonColor = PresetCd.getBtnColor(preset.presetColor);
    /// ボタン枠線色
    borderColor = buttonColor == PresetCd.getBtnColor(PresetCd.transColorCd)
        ? BaseColor.loginTabTextColor
        : buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 184.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: BaseColor.someTextPopupArea,
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),
              Center(
                child: Text(
                  preset.kyName,
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familySub,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
            child: Material(
          color: BaseColor.transparent,
          child: SoundInkWell(
            onTap: () async =>
                await TchKeyDispatch.rcDTchByKeyId(preset.kyCd, preset),
            child: null,
            callFunc: '${runtimeType.toString()} ${preset.kyName}',
          ),
        ))
      ],
    );
  }
}

///複数のアイテム構築UI
class DisplayContainers extends StatelessWidget {
  /// ファクションキー画面のインデックス
  final int containerIndex;

  ///コンストラクタ
  const DisplayContainers({super.key, required this.containerIndex});

  @override
  Widget build(BuildContext context) {
    ///　コントローラー
    final loginCtrl = Get.find<LoginAccountController>();
    ///　テキスト
    List<PresetInfo> items = loginCtrl.getTextsAndColorsForPresetCd(containerIndex);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 2 / 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, keyIdx) {
        return Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 15.h, bottom: 16.h),
          child: ItemContainer(
            preset: items[keyIdx]
          ),
        );
      },
    );
  }
}

///登録会計メニュー下の画面構築
class BottomSection extends StatelessWidget {
  ///コントローラー
  final loginCtrl = Get.find<LoginAccountController>();

  ///コンストラクタ
  BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: BaseColor.loginBackColor,
        child: Container(
          margin: EdgeInsets.only(
              top: 72.h, left: 96.w, right: 96.w, bottom: 112.h),
          color: BaseColor.loginBackColor,
          child: Obx(
            () => DisplayContainers(
              containerIndex: loginCtrl.selectedIndex.value,
            ),
          ),
        ),
      ),
    );
  }
}
