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
import '../../register/pixel/c_pixel.dart';
import '../controller/c_text_subtotaldrpdwn.dart';


/// ドロップダウン
class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.listData,
    required this.selected,
    required this.val,
    required this.idx,
    required this.selectedIdx,
    required this.onCallback,
  });

  final listData; //obs
  final selected; //obs
  final val; //obs
  final int idx;
  final selectedIdx; //obs
  final Function onCallback;

  @override
  Widget build(BuildContext context) {

    return Flex(
      direction: Axis.vertical,
      children: [
        Obx(
          () => GestureDetector(
            onTap: () => onCallback(),
            child: Container(
              width: 190.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: selected.value
                    ? BaseColor.tenkeyBackColor1
                    : BaseColor.someTextPopupArea,
                border:
                    Border.all(width: 1, color: BaseColor.edgeBtnTenkeyColor),
                borderRadius: BorderRadius.circular(BasePixel.pix05),
                boxShadow: selected.value
                    ? [
                        BoxShadow(
                          color: Color.fromRGBO(55, 75, 186, 0.35),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Obx(
                    () => Container(
                      width: 135.w,
                      alignment: Alignment.center,
                      child: Text(
                        '${val.value}',
                        style: TextStyle(
                          fontSize: BaseFont.font22px,
                          fontFamily: BaseFont.familyNumber,
                          color: BaseColor.baseColor,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      alignment: Alignment.center,
                      color: (selectedIdx.value == idx && selected.value)
                          ? BaseColor.tenkeyBackColor1
                          : BaseColor.someTextPopupArea,
                      width: 50.w,
                      height: 60.h,
                      child: Icon(Icons.expand_more),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => selected.value && selectedIdx.value == idx
              ? Flex(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  direction: Axis.vertical,
                  children: [
                    for (int i = 0; i < listData.length; i++)
                      DrpDwnContainer(
                        val: listData[i],
                        rtn: val,
                        selected: selected,
                      ),
                  ],
                )
              : Container(),
        ),
      ],
    );
  }
}

/// ドロップダウンの１つ１つの箱
class DrpDwnContainer extends StatelessWidget {
  const DrpDwnContainer({
    super.key,
    required this.val,
    required this.rtn,
    required this.selected,
  });

  final val;
  final rtn;
  final selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        rtn.value = val;
        selected.value = !selected.value;
      },
      child: Container(
        alignment: Alignment.center,
        width: 190.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: BaseColor.someTextPopupArea,
          border: Border.all(width: 1, color: BaseColor.edgeBtnTenkeyColor),
        ),
        child: Text(
          '$val',
          style: TextStyle(
            fontSize: BaseFont.font22px,
            fontFamily: BaseFont.familyNumber,
            color: BaseColor.baseColor,
          ),
        ),
      ),
    );
  }
}
