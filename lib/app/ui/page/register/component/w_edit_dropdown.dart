/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_edit_dropdown.dart';

/// ドロップダウンのID
/// controllerはIDが同じ物を指定すると同じcontrollerを参照してしまうため、
/// 区別をつけるためにプルダウンごとにIDを定義する.
enum EditAndDropdownId {
  /// 何もなし.
  none,

  /// 商品登録:値引き.
  purchaseDsc,

  /// 商品登録:割引.
  purchasePDsc,

  // プルダウンを追加するとき定義を追加.
}

/// 文字入力&ドロップダウンWidget.
/// ドロップダウンから値を選択するだけでなく、値の自由入力が可能なWidget.
/// テンキーは表示位置の関係上、このWidgetでは作成していない.
/// テンキーを使用する場合は、別途テンキーWidgetを呼び出し、
/// 入力値を[EditAndDropDownController]のeditValueと連携させること.
class EditAndDropdownWidget extends StatelessWidget {
  EditAndDropdownWidget(
      {super.key,
      required EditAndDropdownId drpdwnId,
      required this.selectMap,
      required int selectedKey,
      required this.onTapEditBox,
      this.onSelected,
      this.prefix = "",
      this.suffix = ""}) {
    controller =
        Get.put(tag: drpdwnId.name, EditAndDropDownController(selectedKey));
  }

  late final EditAndDropDownController controller;

  final Function onTapEditBox;

  /// keyとプルダウンに表示する文字のマップ.
  late final Map<int, String> selectMap;

  /// ドロップダウンでアイテムを選択した後の処理..
  final Function()? onSelected;

  // 選択肢や表示ボックスで値の前に表示する文言.
  final String prefix;

  // 選択肢や表示ボックスで値の後に表示する文言.
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Obx(
          () => Material(
            type: MaterialType.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                  color: BaseColor.edgeBtnTenkeyColor, width: 1),
            ),
            color: controller.focus.value
                ? BaseColor.tenkeyBackColor1
                : BaseColor.someTextPopupArea,
            shadowColor: controller.focus.value ? BaseColor.accentsColor:Colors.transparent,
            elevation: 2,
            child: SizedBox(
              width: 190.w,
              height: 60.h,

              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Obx(
                    () => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        SoundUtil.playPushSoundLog(runtimeType.toString());
                        //　文字入力へ切り替える
                        controller.selectedKey.value = null;
                        onTapEditBox();
                      },
                      child: Container(
                        width: 140.w,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          controller.editValue.value.isEmpty
                              ? ""
                              : "$prefix${controller.editValue.value}$suffix",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: BaseFont.font22px,
                            fontFamily: BaseFont.familyNumber,
                            color: BaseColor.baseColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() => PopupMenuButton<int>(
                        initialValue: controller.selectedKey.value,
                        onOpened: () {
                          SoundUtil.playPushSoundLog(runtimeType.toString());
                          controller.focusOn();
                        },
                        onSelected: (int s) {
                          SoundUtil.playPushSoundLog(runtimeType.toString());
                          controller.selectedKey.value = s;
                          controller.editValue.value =
                              selectMap[controller.selectedKey.value]!;
                          onSelected?.call();
                          controller.focusOff();
                        },
                        onCanceled: () {
                          SoundUtil.playPushSoundLog(runtimeType.toString());
                          controller.focusOff();
                        },
                        icon: const Icon(Icons.expand_more),
                        itemBuilder: (BuildContext context) {
                          return selectMap.keys.map((int? key) {
                            return PopupMenuItem(
                              padding: EdgeInsets.zero,
                              value: key,
                              child: EditDropDownItem(
                                showValue: "$prefix${selectMap[key]!}$suffix",
                              ),
                            );
                          }).toList();
                        },
                        padding: EdgeInsets.zero,
                        position: PopupMenuPosition.under,
                        constraints: BoxConstraints(
                          minWidth: 188.w,
                          maxWidth: 188.w,
                        ),
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// ドロップダウンの１つ１つの箱
class EditDropDownItem extends StatelessWidget {
  const EditDropDownItem({
    super.key,
    required this.showValue,
  });

  final String showValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.centerLeft,
        width: 190.w,
        height: 60.h,
        padding: const EdgeInsets.only(left: 40),
        decoration: BoxDecoration(
          //  color: BaseColor.someTextPopupArea,
          border: Border.all(width: 1, color: BaseColor.edgeBtnTenkeyColor),
        ),
        child: Text(
          showValue,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: BaseFont.font22px,
            fontFamily: 'TucN3m',
            color: BaseColor.baseColor,
          ),
        ),
      ),
    );
  }
}
