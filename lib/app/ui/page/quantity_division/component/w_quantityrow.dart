/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../detail_modifi/component/w_purchase_count_widget.dart';
import '../../detail_modifi/controller/c_purchase_detail_modify_controller.dart';
import '../../register/controller/c_register_change.dart';
import '../../register/controller/c_registerbody_controller.dart';

/// 数量／＋－ボタン／数量分割ボタン行の構築Widget
class QuantityRowWidget extends StatefulWidget {
  late final DetailModifyInputController detailModifyInputCtrl;

  ///コントローラー
  final RegisterChangeController registerChangeCtrl;

  ///コントローラー
  RegisterBodyController bodyctrl = Get.find();

  ///個数変更できるかどうか
  final bool isEditable;

  final int index;

  ///個数変更ボタン押された動作
  final VoidCallback onQuantityChanged;

  QuantityRowWidget({
    Key? key,
    required this.bodyctrl,
    required this.detailModifyInputCtrl,
    required this.isEditable,
    required this.index,
    required this.registerChangeCtrl,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _QuantityRowWidgetState createState() => _QuantityRowWidgetState();
}

class _QuantityRowWidgetState extends State<QuantityRowWidget> {

  //inputboxとしてテンキー入力できるかどうか
  bool _isEditing = false;

  ///inputbox編集状態変更するメソッド
  void _handleEditingChange(bool isEditing) {
    setState(() {
      _isEditing = isEditing;

    });
  }


  @override
  void initState() {
    super.initState();
    //showPlusMinusButtonsの値が変わったときリスナーを追加し
    // _handleEditingChangeを呼び出し編集状態リセット
    widget.detailModifyInputCtrl.showPlusMinusButtons.listen((value) {
      _handleEditingChange(false);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(48, 32, 0, 0),
        child: Flex(
            mainAxisAlignment: MainAxisAlignment.start,
            direction: Axis.horizontal,
            children: [
              const Text(
                "数量",
                style: TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font18px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
              SizedBox(
                  width: _isEditing  ? 200.w : 144.w
              ),

              /// ＋－ボタン
              Container(
                child: Obx(() {
                  return PurchaseCountWidget(
                    isEditable: widget.isEditable,
                    quantity: widget.bodyctrl.purchaseData[widget.index].itemLog
                        .itemData.qty!,
                    onCallBackAdd: () {
                      widget.registerChangeCtrl.updateQuantity(widget.index, 1, false);
                      setState(() {});
                      widget.onQuantityChanged();
                    },
                    onCallBackPull: () {
                      widget.registerChangeCtrl
                          .updateQuantity(widget.index, -1, false);
                      setState(() {});
                      widget.onQuantityChanged();
                    },
                    detailModifyInputCtrl: widget.detailModifyInputCtrl,
                    onEditingChange: _handleEditingChange,
                  );
                }),
              ),
              // SizedBox(width: 56.w),
              //
              // /// 数量分割ボタン
              // if (isEditable)
              // SizedBox(
              //   width: 168.w,
              //   height: 56.h,
              //   child: SoundElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: BaseColor.otherButtonColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(4),
              //       ),
              //       shadowColor: BaseColor.dropShadowColor,
              //       elevation: 3,
              //     ),
              //     onPressed: () {
              //      // Get.to(() => QuantityDivisionScreen(title: '数量変更'));
              //     },
              //     child: Row(
              //       children: [
              //         SvgPicture.asset(
              //           'assets/images/icon_divide.svg',
              //           width: 32.w,
              //           height: 32.h,
              //         ),
              //         const Text(
              //           "数量を分割",
              //           style: TextStyle(
              //             fontSize: BaseFont.font18px,
              //             color: BaseColor.someTextPopupArea,
              //             fontFamily: BaseFont.familyDefault,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ]));
  }
}
