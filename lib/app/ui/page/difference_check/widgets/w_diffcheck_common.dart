/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///差異チェックで使用する表以外のウィジット,ウィジットの大きさを定義
class DiffCheckCommon {
// 現金以外を表示ボタン用
// Trueで現金 False で現金以外
  var cashBtnBool = true.obs;

//売り上げ回収遷移画面用
  var salesCollectionBool = false.obs;

// 内訳表示ボタン用
  var breakdownBool = false.obs;

// 全体系
  double wholeWidth = 1024.w; // 画面横幅
  double leftSideWidth = 648.w; // 左側(表)の横幅
  double rightSideWidth = 1024.w - 648.w; //　右側(値表示)の横幅
  double bodyHeight = 712.h; // ヘッダ分マイナスをした値

// 過不足在高合計等の右表示部分
  double labelWigitWidth = 268.w;
  double labelWholeHeight = 80.h;
  double labelTitleHeight = 32.h;
  double labelBodyHeight = 48.h;

// 表関連
  double tableAreaWidth = 644.w; //表エリアの横幅
  double tableHeaderHeight = 48.h; // 表のヘッダの高さ
  double tableHeaderLabelWidth = 120.w; //表のラベルヘッダ部分の横幅
  double tableHeaderBodyWidth = 200.w; //表のヘッダ部分の横幅
  double tableRowWidth = 320.w; //表の横幅
  double tableRowHeight = 56.h; //表の行の高さ
  double tableIconAriaWidth = 56.w; //表のアイコン部分の横幅
  double tableLabelAriaWidth = 90.w; //表の行ラベルの横幅
  double tableValueAriaWidth = 76.w; //表の行の値部分のの横幅
  double tableInputAriaWidth = 111.w; //表の入力部分の横幅
  double tableInputAriaHeight = 40.h; //表の入力部分の高さ
  double tableUnitAriaWidth = 18.w; //表の単位部分の横幅

// 内訳表
  double breakDownTableWidth = 960.w; // 内訳表の横幅
  double breakDownTableHeight = 336.w; //内訳表の縦幅
  double breakDownTableTopMargin = 120.h; //内訳表の縦幅
  double breakDownBtnHeight = 56.h; //前の画面に戻る遷移画面のボタンの縦幅
  double breakDownBtnWidth = 200.w; //前の画面に戻る遷移画面のボタンの横幅
  double breakDownBtnTopMargin = 116.h; //前の画面に戻る遷移画面のボタンの横幅
  double breakDownBtnSvgHeight = 32.h; //前の画面に戻る遷移画面のボタンの横幅
  double breakDownBtnSvgWidth = 32.w; //前の画面に戻る遷移画面のボタンの横幅


  double breakDownLeftMargin = 32.w; //内訳を表示画面の左マージン
  double breakDownRightMargin = 32.w; //内訳を表示画面の右マージン

// 現金以外表
  double nonCashTableWholeHeight = 588.w; //現金以外表の縦幅
  double nonCashTableInputAriaWidth = 150.w; //現金以外表の入力部分の横幅
  double nonCashTableRowWidth = 320.w; //現金以外表の行の横幅
  double nonCashTableRowHeight = 56.h; //現金以外表の行の縦幅
  double nonCashTableRowLeftAreaWidth = 320.w - 150.w - 18.w; //現金以外表の行ラベルの縦幅

  double scrollBtnHeight = 48.h; //スクロールボタン縦幅
  double scrollBtnWidth = 64.w; //スクロールボタン横幅

  double breakDownHeight = 56.h; //内訳を表示のボタンの高さ
  double appearBtnAreaWidth = 216.w; // 現金以外を表示ボタンエリアの横幅
  double appearBtnAreaHeight = 52.h; // 現金以外を表示ボタンエリアの縦幅
  double appearBtnHeight = 40.h; // 現金以外を表示ボタンの縦幅
  double appearBtnSvgWidth = 40.w; // 現金以外を表示ボタンのsvgの横幅

  double btnHeight = 52.h; //釣り機入金 売り上げ回収ボタンの縦幅
  double btnWidth = 132.w; //釣り機入金 売り上げ回収ボタンの横幅

  double breakdownBtnHeight = 56.h; // 理論在高ボタンの高さ

//テンキー
  double tenkeyHeight = 432.h; //テンキーの縦幅
  double tenkeyWidth = 268.w; //テンキーの横幅
  double rightMargin = 32.w; //右側のマージン
  double bottomMargin = 32.h; //下のマージン

// 売上回収遷移用画面
  double toSalesMessageAreaHeight = 88.h; //売り上げ回収遷移画面のメッセージエリアの縦幅
  double toSalesTableWidth = 880.w; //売り上げ回収遷移画面の表の横幅
  double toSalesTableHeight = 440.h; //売り上げ回収遷移画面の表の縦幅
  double toSalesTableTopMargin = 32.h; //売り上げ回収遷移画面の表の上部マージン
  double toSalesLeftMargin = 108.w; //売り上げ回収遷移画面の左側マージン
  double toSalesRightMargin = 76.w; //売り上げ回収遷移画面の右側マージン
  double toSalestableRowHeight = 440.h / 5; //売り上げ回収遷移画面の表の行の縦幅

  double toSalesBtnAreaHeight = 144.h; //売り上げ回収遷移画面のボタンエリアの縦幅

  double toSalesBtnHeight = 80.h; //売り上げ回収遷移画面のボタンの縦幅
  double toSalesBtnWidth = 200.w; //売り上げ回収遷移画面のボタンの横幅
  double toSalesBtnAreaMargin = 32.w; //売り上げ回収遷移画面のボタンのマージン
  double toSalesToggleSideMargin = 24.w; //売り上げ回収遷移画面のトグルボタンの横幅調整用マージン
  double toSalesToggleUpDownMargin = 16.h; //売り上げ回収遷移画面のトグルボタンの縦幅調整用マージン

  double toSalesRowCellAreaWidth = 880.w / 3; //売り上げ回収画面の表の横幅
  double toSalesSvgAreaWidth = 100.w; //売り上げ回収画面のsvg表示の横幅
  double toSalesSvgAreaHeight = 56.h; //売り上げ回収画面のsvg表示の縦幅

  /// 右の過不足在高合計とかの表示
  Widget drawValueDisplay(
      {String topText = '', String downText = '', bool emergency = false}) {
    return Container(
      color: BaseColor.changeCoinReferTitleColor,
      width: labelWigitWidth,
      height: labelWholeHeight,
      child: Column(
        children: [
          Container(
            width: labelWigitWidth,
            height: labelTitleHeight,
            color: BaseColor.changeCoinReferTitleColor,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              topText,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font16px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 32),
            width: labelWigitWidth,
            height: labelBodyHeight,
            decoration: BoxDecoration(
              color:
                  emergency ? BaseColor.someTextPopupArea : BaseColor.baseColor,
              border: emergency
                  ? Border.all(
                      color: BaseColor.attentionColor,
                      width: 2,
                    )
                  : Border.all(color: BaseColor.baseColor),
            ),
            child: Text(
              textAlign: TextAlign.right,
              downText,
              style: emergency
                  ? const TextStyle(
                      color: BaseColor.attentionColor,
                      fontSize: BaseFont.font28px,
                      fontFamily: BaseFont.familyNumber,
                    )
                  : const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font28px,
                      fontFamily: BaseFont.familyNumber,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// スクロールボタン
  Widget scrollButton(IconData icon, VoidCallback onPressed) {
    // String callFunc = 'scrollButton';
    return Stack(
      children: [
        Container(
          width: scrollBtnWidth,
          height: scrollBtnHeight,
          decoration: const BoxDecoration(
            color: BaseColor.maintainBaseColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: BaseColor.newMainMenuWhiteColor,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              onTap: onPressed,
              callFunc: '',
            ),
          ),
        ),
      ],
    );
  }
}
