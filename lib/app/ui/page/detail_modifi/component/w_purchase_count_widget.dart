/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_purchase_detail_modify_controller.dart';
import '../enum/e_purchase_detail_modify_enum.dart';

/// 購入商品明細 個数変更アップダウンボタン
class PurchaseCountWidget extends StatefulWidget {
  final int quantity;

  ///編集できるかどうか
  final bool isEditable;

  final Function(bool) onEditingChange;

  // callback
  final Function onCallBackAdd;
  final Function onCallBackPull;

  final DetailModifyInputController detailModifyInputCtrl;

  // final RegisterChangeController registerChangeCtrl;
  ///コンストラクタ
  const PurchaseCountWidget({
    super.key,
    required this.quantity,
    required this.onCallBackAdd,
    required this.onCallBackPull,
    required this.isEditable,
    required this.detailModifyInputCtrl,
    required this.onEditingChange,
  });

  @override
  _PurchaseCountWidgetState createState() => _PurchaseCountWidgetState();
}

/// 購入商品明細 個数変更アップダウンボタン　状態
class _PurchaseCountWidgetState extends State<PurchaseCountWidget> {
  //inutboxWidgetとして編集できるかどうか
  bool _isEditable = false;

  void initState() {
    super.initState();
    widget.detailModifyInputCtrl.showPlusMinusButtons.listen((value) {
      if (value) {
        setState(() {
          _isEditable = false;
        });
      }
    });
    widget
        .detailModifyInputCtrl
        .detailModifyInputBoxList[PurchaseDetailModifyLabel.quantity.index]
        .currentState
        ?.onChangeStr(widget.quantity.toString());
  }

  //編集可能と不可の変換メソッド
  void _toggleEditing() {
    setState(() {
      _isEditable = !_isEditable;
      widget.detailModifyInputCtrl.showPlusMinusButtons.value = false;
      widget.onEditingChange(_isEditable);
    });
  }

  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        if (widget.isEditable && !_isEditable)
          Material(
              type: MaterialType.button,
              color: BaseColor.accentsColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: SoundInkWell(
                onTap: () {
                  widget.onCallBackPull();
                },
                callFunc: runtimeType.toString(),
                child: SizedBox(
                  width: 56.w,
                  height: 56.h,
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: BaseColor.someTextPopupArea,
                  ),
                ),
              )),
        SizedBox(
          width: 16.w,
        ),
        if (!_isEditable)
          Material(
            color: BaseColor.someTextPopupArea,
            child: SoundInkWell(
              onTap: widget.isEditable
                  ? () {
                      _toggleEditing();
                      widget.detailModifyInputCtrl.onInputBoxTap(0);
                    }
                  : null,
              callFunc: runtimeType.toString(),
              child: Container(
                width: 104.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: widget.isEditable
                      ? BaseColor.someTextPopupArea
                      : BaseColor.edgeBtnTenkeyColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: BaseColor.edgeBtnColor,
                  ),
                ),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    '${widget.quantity}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: BaseFont.font22px,
                      color: BaseColor.baseColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (_isEditable)
          InputBoxWidget(
            key: widget.detailModifyInputCtrl.detailModifyInputBoxList[
                PurchaseDetailModifyLabel.quantity.index],
            width: 104.w,
            height: 56.h,
            fontSize: BaseFont.font22px,
            textAlign: TextAlign.right,
            padding: EdgeInsets.only(right: 32.w),
            unfocusedColor: widget.isEditable
                ? BaseColor.someTextPopupArea
                : BaseColor.edgeBtnTenkeyColor,
            cursorColor:
                widget.isEditable ? BaseColor.baseColor : BaseColor.transparent,
            unfocusedBorder: BaseColor.inputFieldColor,
            focusedBorder: BaseColor.accentsColor,
            focusedColor: widget.isEditable
                ? BaseColor.inputBaseColor
                : BaseColor.edgeBtnTenkeyColor,
            borderRadius: 4,
            blurRadius: 6,
            funcBoxTap: () {},
            iniShowCursor: true,
            mode: InputBoxMode.defaultMode,
            initStr: '${widget.quantity}',
          ),
        SizedBox(
          width: 16.w,
        ),
        if (widget.isEditable && !_isEditable)
          Material(
            type: MaterialType.button,
            color: BaseColor.accentsColor,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: SoundInkWell(
              onTap: () {
                widget.onCallBackAdd();
              },
              callFunc: runtimeType.toString(),
              child: SizedBox(
                height: 56.h,
                width: 56.w,
                child: const Icon(
                  Icons.add,
                  size: 20,
                  color: BaseColor.someTextPopupArea,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
