/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_inputbox.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_dicisionbutton.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_member_call_controller.dart';

/// 動作概要
/// 起動方法： Get.to(() => MemberCallScreen(title: '会員呼出')); など
/// 処理結果：確定処理後、会員コードは以下から取得する
///   会員コード memberCallCtrl.memberCode.value

/// 会員呼出のページ
class MemberCallScreen extends CommonBasePage {
  MemberCallScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'MemberCallScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                Get.back();
              },
              callFunc: className,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  SizedBox(
                    width: 19.w,
                  ),
                  Text('l_cmn_cancel'.trns,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px)),
                ],
              ),
            ),
          ];
        });

  @override
  Widget buildBody(BuildContext context) {
    return MemberCallWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class MemberCallWidget extends StatefulWidget {
  final Color backgroundColor;

  const MemberCallWidget({super.key, required this.backgroundColor});

  @override
  MemberCallState createState() => MemberCallState();
}

class MemberCallState extends State<MemberCallWidget> {
  MemberCallInputController memberCallCtrl = Get.put(MemberCallInputController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: const Center(
            child: Text(
              textAlign: TextAlign.center,
              '会員コードを入力し、確定するボタンを押してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 128),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                  ),
                  Container(
                    color: BaseColor.someTextPopupArea,
                    width: 450.w,
                    height: 108.h,
                    child: buildInputRow(
                      leftText: '会員コード',
                      rightText: memberCallCtrl.memberCode.value,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 確定ボタン
          Obx(() {
            if (!memberCallCtrl.showRegisterTenkey.value && memberCallCtrl.memberCode.value.isNotEmpty) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback: () async {
                    await memberCallCtrl.onConfirmButtonPressed();
                  },
                  text: '確定する',
                  isdecision: true,
                ),
              );
            } else {
              return Container();
            }
          }),

          // テンキー
          Obx(() {
            if (memberCallCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    memberCallCtrl.inputKeyType(key);
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  /// 入力行を作成する
  /// leftText  左ラベルテキスト
  /// rightText 右ラベルテキスト
  Widget buildInputRow(
      {String leftText = '',
       String rightText = ''}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              leftText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          InputBoxWidget(
            initStr: rightText,
            key: memberCallCtrl.inputBoxKey,
            width: 280.w,
            height: 56.h,
            fontSize: BaseFont.font22px,
            textAlign: TextAlign.right,
            padding: const EdgeInsets.only(right: 32),
            cursorColor: BaseColor.baseColor,
            unfocusedBorder: BaseColor.inputFieldColor,
            focusedBorder: BaseColor.accentsColor,
            focusedColor: BaseColor.inputBaseColor,
            borderRadius: 4,
            blurRadius: 6,
            funcBoxTap: () {
              memberCallCtrl.onInputBoxTap();
            },
            iniShowCursor: true,
            mode: InputBoxMode.defaultMode,
          ),
        ],
      ),
    );
  }
}
