/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../regs/checker/rc_chgitm_dsp.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_purchase_detail_modify_controller.dart';
import '../enum/e_purchase_detail_modify_enum.dart';

///値引き割引Widget
class DiscountWidget extends StatefulWidget {
  final DetailModifyInputController detailModifyInputCtrl;
  final String initItemDscVal;
  final DscChangeType initItemDscType;
  final FuncKey initItemFuncKey;
  final bool focus;

  ///値引き、割引できるかどうか
  final bool isEditable;

  const DiscountWidget({
    super.key,
    required this.detailModifyInputCtrl,
    required this.isEditable,
    required this.initItemDscVal,
    required this.initItemDscType,
    required this.initItemFuncKey,
    required this.focus,
  });

  @override
  DiscountWidgetState createState() => DiscountWidgetState();
}

///値引き割引Widget状態
class DiscountWidgetState extends State<DiscountWidget> {
  bool firstFlg = true;

  /// 処理概要：選択済みキーフレーム作成処理
  /// パラメータ：キー番号
  /// 戻り値：ファンクションキーフレーム
  BoxDecoration _getSelectedButtonFrame(int index) {
    bool isSelected = widget.detailModifyInputCtrl.getSelectedButton(index);
    if (isSelected) {
      return  BoxDecoration(
        border:
        Border.all(color: Colors.blue, width: 5),
      );
    }
    return BoxDecoration(
      border: Border.all(
          color: Colors.transparent, width: 5),
    );
  }

  /// 処理概要：不透明度設定
  /// パラメータ：キー番号
  /// 戻り値：ファンクションキーフレーム
  double _getOpacity(DscChangeType dscType) {
    if (widget.detailModifyInputCtrl.getDiscountType() == dscType) {
      return 1.0;
    } else {
      return 0.4;
    }
  }

  /// 処理概要：選択済みキーフレーム作成処理
  /// パラメータ：キー番号
  /// 戻り値：ファンクションキーフレーム
  BoxDecoration _getAnimatedOpacitydecoration(DscChangeType dscType) {
    if (widget.detailModifyInputCtrl.getDiscountType() == dscType) {
      return BoxDecoration(
        color: BaseColor.accentsColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: BaseColor.someTextPopupArea,
        ),
      );
    }
    return BoxDecoration(
      border: Border.all(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEditable = widget.isEditable;
    String itemDscVal = '0';
    if (firstFlg) {
      if (widget.focus && isEditable) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.detailModifyInputCtrl.onInputBoxTap(4);
        });
      }
      itemDscVal = widget.initItemDscVal;
      if (widget.initItemDscType == DscChangeType.none) {
        widget.detailModifyInputCtrl.setDiscountType(DscChangeType.dsc);
      } else {
        widget.detailModifyInputCtrl.setDiscountType(widget.initItemDscType);
      }
      widget.detailModifyInputCtrl.setSelectedFuncKey(widget.initItemFuncKey);
      firstFlg = false;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 32, 0, 0),
      child: Visibility(
        visible: widget.detailModifyInputCtrl.getDiscountAreaEnable(),
        child: Column(children: [
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: BaseColor.accentsColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(children: [
                    Positioned(
                      left: 4,
                      top: 4,
                      bottom: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.detailModifyInputCtrl
                                .changeDiscountSwitch(DscChangeType.dsc);
                          });
                        },
                        child: AnimatedOpacity(
                          opacity: _getOpacity(DscChangeType.dsc),
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            width: 96.w,
                            height: 48.h,
                            decoration: _getAnimatedOpacitydecoration(DscChangeType.dsc),
                            alignment: Alignment.center,
                            child: Text(
                              '値引き',
                              style: TextStyle(
                                color: isEditable
                                    ? BaseColor.someTextPopupArea
                                    : BaseColor.edgeBtnTenkeyColor,
                                fontSize: BaseFont.font18px,
                                fontFamily: BaseFont.familyDefault,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      bottom: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.detailModifyInputCtrl
                                .changeDiscountSwitch(DscChangeType.pdsc);
                          });
                        },
                        child: AnimatedOpacity(
                          opacity: _getOpacity(DscChangeType.pdsc),
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            width: 96.w,
                            height: 48.h,
                            decoration: _getAnimatedOpacitydecoration(DscChangeType.pdsc),
                            alignment: Alignment.center,
                            child: Text(
                              '割引き',
                              style: TextStyle(
                                color: isEditable
                                    ? BaseColor.someTextPopupArea
                                    : BaseColor.edgeBtnTenkeyColor,
                                fontSize: BaseFont.font18px,
                                fontFamily: BaseFont.familyDefault,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: 28.w),
                Container(
                  alignment: Alignment.centerLeft,
                  child: InputBoxWidget(
                    key: widget.detailModifyInputCtrl.detailModifyInputBoxList[
                        PurchaseDetailModifyLabel.discount.index],
                    width: 200.w,
                    height: 56.h,
                    fontSize: BaseFont.font22px,
                    textAlign: TextAlign.right,
                    padding: EdgeInsets.only(right: 32.w),
                    unfocusedColor: isEditable
                        ? BaseColor.someTextPopupArea
                        : BaseColor.edgeBtnTenkeyColor,
                    cursorColor: isEditable
                        ? BaseColor.baseColor
                        : BaseColor.transparent,
                    unfocusedBorder: BaseColor.inputFieldColor,
                    focusedBorder: BaseColor.accentsColor,
                    focusedColor: isEditable
                        ? BaseColor.inputBaseColor
                        : BaseColor.edgeBtnTenkeyColor,
                    borderRadius: 4,
                    blurRadius: 6,
                    funcBoxTap: () {
                      widget.detailModifyInputCtrl.callDiscountInputBox();
                      setState(() {

                      });
                    },
                    onComplete: () {},
                    iniShowCursor: false,
                    mode: widget.detailModifyInputCtrl.getDiscountType() == DscChangeType.dsc
                        ? (RegsMem().refundFlag
                            ? InputBoxMode.payNumber
                            : InputBoxMode.minusPayNumber)
                        : InputBoxMode.percentNumber,
                    initStr: isEditable ? itemDscVal : '-',
                  ),
                ),
                SizedBox(width: 16.w),
                const Text(
                  '引',
                  style: TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ]),
          SizedBox(height: 44.h),
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(DscPdscKeyOptionButtonType.values.length,
                  (index) {
                return Flexible(
                    flex: 1,
                    child: Visibility(
                      visible: isEditable,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Container(
                          decoration: _getSelectedButtonFrame(index),
                          child: SoundElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BaseColor.someTextPopupArea,
                              minimumSize: const Size(120, 56),
                              maximumSize: const Size(120, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(
                                  color: BaseColor.edgeBtnColor,
                                  width: 1,
                                ),
                              ),
                              elevation: 3.0,
                            ),
                            callFunc: runtimeType.toString(),
                            onPressed: () => {
                              widget.detailModifyInputCtrl
                                  .discountButtonPressed(index),
                              setState(() {})
                            },
                            child: Text(
                              widget.detailModifyInputCtrl.getKeyString(index),
                              style: const TextStyle(
                                color: BaseColor.baseColor,
                                fontSize: BaseFont.font22px,
                                fontFamily: BaseFont.familySub,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
              })),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 324, 0),
            child: const Divider(
              color: BaseColor.edgeBtnTenkeyColor,
              thickness: 1,
            ),
          ),
        ]),
      ),
    );
  }
}
