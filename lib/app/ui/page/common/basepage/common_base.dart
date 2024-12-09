/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';

/// 通番訂正画面と記録確認共通のAppBarと背景
abstract class CommonBasePage extends StatelessWidget {
  ///画面タイトル
  late String title;

  ///ファンクションキー
  late FuncKey funcKey;

  /// アクションを構築するためのコールバック関数
  /// nullの場合キャンセルボタンが表示されない
  final List<Widget> Function(BuildContext)? buildActionsCallback;

  ///画面背景色
  final Color backgroundColor;

  //title　右側のサブ説明
  final String addInfo;

  /// 右側ボタンテキスト
  final String cancelButtonText;

  ///コンストラクタ
  CommonBasePage({
    super.key,
    this.title = "",
    this.funcKey = FuncKey.KY_NONE,
    this.buildActionsCallback,
    this.backgroundColor = BaseColor.someTextPopupArea,
    this.addInfo = '',
    this.cancelButtonText = 'l_cmn_cancel',
  });

  ///　具体的なページのボディを構築
  Widget buildBody(BuildContext context);

  ///キャンセルボタン
  List<Widget> buildActions(BuildContext context) {
    String callFunc = 'buildActions';
    return <Widget>[
      SoundTextButton(
        onPressed: () {
          Get.back();
        },
        callFunc: '$callFunc ${'l_cmn_cancel'.trns}',
        child: Row(
          children: <Widget>[
            const Icon(Icons.close,
                color: BaseColor.someTextPopupArea, size: 45),
            SizedBox(
              width: 19.w,
            ),
            Text(cancelButtonText.trns,
                style: const TextStyle(
                    color: BaseColor.someTextPopupArea,
                    fontSize: BaseFont.font18px)),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(title,
              style: const TextStyle(
                  color: BaseColor.someTextPopupArea,
                  fontSize: BaseFont.font28px),
            ),
            if (addInfo!.isNotEmpty) ... [
             SizedBox(width: 80.w),
              Text(addInfo!,
                style: const TextStyle(
                    color: BaseColor.someTextPopupArea,
                    fontSize: BaseFont.font16px),
              ),
            ]
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: BaseColor.baseColor.withOpacity(0.7),
        actions: buildActionsCallback?.call(context) ?? buildActions(context),
      ),
      body: buildBody(context),
      backgroundColor: backgroundColor,
    );
  }
}
