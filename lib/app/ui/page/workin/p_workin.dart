/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../colorfont/c_basefont.dart';
import '../../colorfont/c_basecolor.dart';
import '../../component/w_sound_buttons.dart';
import '../common/basepage/common_base.dart';
import 'controller/c_workin.dart';
import '../../../inc/apl/image.dart';
import '../../../lib/apllib/image_label_dbcall.dart';

/// 業務宣言画面
class WorkInScreen extends CommonBasePage {
  /// 業務宣言画面用のコントローラを取得
  WorkinController get workinController => Get.put(WorkinController());

  /// ボタンのタイトル
  List<int> buttonTitleIds = [
    ImageDefinitions.IMG_PRECA_IN,
    ImageDefinitions.IMG_HOUSE_IN
  ];

  /// 画像パス
  final Map<int, Widget> workinImgDict = {
    ImageDefinitions.IMG_PRECA_IN: SvgPicture.asset(
        'assets/images/icon_prepaid.svg',
        width: 152.w,
        height: 112.h),
    ImageDefinitions.IMG_HOUSE_IN: SvgPicture.asset(
        'assets/images/icon_housecard.svg',
        width: 152.w,
        height: 112.h),
    ImageDefinitions.IMG_PRECA_REF: SvgPicture.asset(
        'assets/images/icon_prepaidbalance.svg',
        width: 152.w,
        height: 112.h),
  };

  /// 業務宣言画面のデフォルトテキストスタイル
  final TextStyle workinDefaultTextStyle = const TextStyle(
    color: BaseColor.baseColor,
    fontSize: BaseFont.font22px,
    fontFamily: BaseFont.familyDefault,
  );

  /// コンストラクタ
  WorkInScreen({super.key, bool inPrecaRef = false})
      : super(
          title: '業務宣言',
          backgroundColor: BaseColor.receiptBottomColor,
        ) {
    if (inPrecaRef) {
      buttonTitleIds = [
        ImageDefinitions.IMG_PRECA_IN,
        ImageDefinitions.IMG_HOUSE_IN,
        ImageDefinitions.IMG_PRECA_REF
      ];
    }
  }

  /// ページ全体の生成
  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.receiptBottomColor,
      appBar: _buildAppBar(
        height: 88.h,
        appbarText: '支払方法 または 残高照会を選択してください',
      ),
      body: _buildBody(),
    );
  }

  /// ヘッダの下のAppBarの生成
  /// [height] AppBarの高さ
  /// [appbarText] AppBarのテキスト
  /// [return] PreferredSize
  PreferredSize _buildAppBar(
      {required double height, required String appbarText}) {
    return PreferredSize(
      // AppBarの高さ
      preferredSize: Size.fromHeight(height),
      // AppBarの中身
      child: Container(
        color: BaseColor.someTextPopupArea.withOpacity(0.7),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            appbarText,
            style: workinDefaultTextStyle,
          ),
        ),
      ),
    );
  }

  /// ボディ部の生成
  /// [return] Widget
  Widget _buildBody() {
    // ボディ部の生成
    return Align(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          SizedBox(
            height: 150.h,
          ),
          SizedBox(
            width: 744.h,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: buttonTitleIds.length,
              // gridviewの配置間隔の設定
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: buttonTitleIds.length,
                childAspectRatio: 1.0,
                mainAxisSpacing: 72,
                crossAxisSpacing: 72,
              ),
              itemBuilder: (context, index) {
                return _buildWorkinButton(buttonTitleIds[index]);
              },
            ),
          ),
        ]));
  }

  /// 業務宣言画面で使用するボタンの生成
  /// [title] ボタンのタイトル
  /// [return] SoundElevatedButton
  SoundElevatedButton _buildWorkinButton(int titleId) {
    return SoundElevatedButton(
        onPressed: () async => await workinController.onWorkinButtonPressed(titleId),
        style: ElevatedButton.styleFrom(
          foregroundColor: BaseColor.backColor,
          backgroundColor: BaseColor.someTextPopupArea,
          shadowColor: BaseColor.dropShadowColor.withOpacity(0.5),
          side: BorderSide(color: BaseColor.edgeBtnColor, width: 1.w),
        ),
        callFunc: 'WorkInScreen $titleId',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              workinImgDict[titleId]!,
              SizedBox(
                height: 16.h,
              ),
              Text(
                titleId.imageData,
                style: workinDefaultTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
