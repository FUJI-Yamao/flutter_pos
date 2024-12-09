/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../controller/c_purchase_detail_modify_controller.dart';
import '../enum/e_purchase_detail_modify_enum.dart';

/// 売価変更タイトル／売価入力項目行の構築Widget
class ChangePriceRowWidget extends StatelessWidget {
  late final DetailModifyInputController detailModifyInputCtrl;
  ///売価変更できるかどうか
  final bool isEditable;
  final String prcChgVal;
  final bool focus;

  bool firstFlg = true;

  ChangePriceRowWidget({
    Key? key,
    required this.detailModifyInputCtrl,
    required this.isEditable,
    required this.prcChgVal,
    required this.focus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (firstFlg) {
      if (focus && isEditable) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          detailModifyInputCtrl.onInputBoxTap(3);
        });
      }
      firstFlg = false;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 16, 0, 0),
      child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            const Text(
             // 'l_reg_chprice'.trns,
               '売価変更',
              style: TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font18px,
                  fontFamily: BaseFont.familyDefault),
            ),
            SizedBox(width: 156.w),
            Container(
              alignment: Alignment.centerLeft,
              child: InputBoxWidget(
                key: detailModifyInputCtrl.detailModifyInputBoxList[
                  PurchaseDetailModifyLabel.modification.index],
                width: 200.w,
                height: 56.h,
                fontSize: BaseFont.font22px,
                textAlign: TextAlign.right,
                padding: EdgeInsets.only(right: 32.w),
                unfocusedColor: isEditable
                    ? BaseColor.someTextPopupArea
                    : BaseColor.edgeBtnTenkeyColor,
                cursorColor:
                    isEditable ? BaseColor.baseColor : BaseColor.transparent,
                unfocusedBorder: BaseColor.inputFieldColor,
                focusedBorder: BaseColor.accentsColor,
                focusedColor: isEditable
                    ? BaseColor.inputBaseColor
                    : BaseColor.edgeBtnTenkeyColor,
                borderRadius: 4,
                blurRadius: 6,
                funcBoxTap: isEditable
                    ? () {
                        detailModifyInputCtrl.onInputBoxTap(3);
                      }
                    : null,
                onComplete: () {},
                iniShowCursor: false,
                mode: InputBoxMode.payNumber,
                initStr: isEditable ? prcChgVal : '-',
              ),
            ),
          ]),
    );
  }
}
