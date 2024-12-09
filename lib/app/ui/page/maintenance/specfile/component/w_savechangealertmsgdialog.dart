/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_btn.dart';

/// メッセージボックス
/// 保存して移動する場合はtrue,保存せず移動する場合はfalseをして前のページへ戻る
/// todo ファイル名/クラス名/フォントサイズ/フォントファミリー/カラーは適当に合わせてください。
/// todo 今は、フォントやカラーはハードコーディングしてあります。ガイドラインが更新された時点で、baseColorやbaseFont等合わせるようにしてください。
class SaveChangeAlertMsgDialog extends StatelessWidget {
  const SaveChangeAlertMsgDialog(
      {super.key,
      this.title = "",
      required this.msgList,
      this.buttonText1 = '保存せず移動',
      this.buttonText2 = '保存して移動'});

  final String title;
  final List<String> msgList;
  final String buttonText1;
  final String buttonText2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: BaseColor.someTextPopupArea),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: BaseColor.baseColor,
      titlePadding: const EdgeInsets.only(right: 30),
      title: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                title,
                style: TextStyle(
                  color: BaseColor.someTextPopupArea,
                  fontSize: BaseFont.font28px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Ink(
                child: IconButton(
                  iconSize: 60,
                  icon: const Icon(
                    Icons.close,
                    size: BaseFont.font44px,
                    color: BaseColor.mainColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )),
        ],
      ),
      content: MessageBoxContainer(
        msgList: msgList,
        title: title,
        buttonText1: buttonText1,
        buttonText2: buttonText2,
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}

/// メッセージボックスcontent
class MessageBoxContainer extends StatelessWidget {
  const MessageBoxContainer(
      {super.key,
      required this.msgList,
      this.title = '',
      required this.buttonText1,
      required this.buttonText2});

  final String title;
  final List<String> msgList;
  final String buttonText1;
  final String buttonText2;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 900,
        height: 400,
        decoration: const BoxDecoration(
            color: BaseColor.maintainBaseColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Stack(
          children: [
            //padding: EdgeInsets.f Color.fromRGBO(86, 103, 113, 1)romLTRB(50,0, 50, 10),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 700,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                    ),
                    for (String msg in msgList)
                      Text(
                        msg,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: BaseFont.familyDefault,
                          height: 1 + (6 / 28),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 220),
                child: SizedBox(
                  width: 650,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BorderButton(
                          width: 200,
                          height: 80,
                          text: buttonText1,
                          shadow: true,
                          onTap: () {
                            Get.back(result: false);
                          },
                          backgroundColor: BaseColor.maintainBaseColor),
                      const SizedBox(
                        width: 60,
                      ),
                      GradientBorderButton(
                        width: 200,
                        height: 80,
                        shadow: true,
                        onTap: () {
                          Get.back(result: true);
                          ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(0, 138, 158, 1)),
                          );
                        },
                        text: buttonText2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
