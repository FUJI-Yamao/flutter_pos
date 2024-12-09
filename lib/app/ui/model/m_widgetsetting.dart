/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
/// 各Widgetで使うコンストラクター

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colorfont/c_basecolor.dart';

/// ヘッダー用：HeaderTitleWidget
class HeaderSetting {
  String title;
  String comment;
  bool isBtnShow;
  Rx<BtnSetting>? btnSetting;
  Function? onTapCallBack;

  HeaderSetting(
      {this.title = '',
      this.comment = '',
      this.btnSetting,
      this.isBtnShow = false,
      this.onTapCallBack});
}

/// ラベルボタンのラベル用：LabelBtnWidget
class LblSetting {
  bool isSelectedKey;
  bool visible;
  double height;
  double width;
  String text;
  Color backcolor;
  Color shadowcolor;
  Color bordercolor;
  Color textcolor;
  double fontsize;
  AlignmentGeometry alignment;
  Function? onTap;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  bool showBoxDecoration;

  LblSetting({
    this.isSelectedKey = false,
    this.text = '',
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.height = 65.0,
    this.width = 450.0,
    this.backcolor = const Color(0xFF6099c9),
    this.shadowcolor = const Color(0xFF2C5A80),
    this.bordercolor = Colors.black12,
    this.textcolor = Colors.white,
    this.fontsize = 23,
    this.alignment = Alignment.center,
    this.onTap,
    this.showBoxDecoration = false,
  });
}

/// ボタンのボタン用：LabelBtnWidget
class BtnSetting {
  bool isSelectedKey;
  bool visible;
  double height;
  double width;
  String text;
  Color backcolor;
  Color shadowcolor;
  Color bordercolor;
  Color textcolor;
  double fontsize;
  AlignmentGeometry alignment;
  Function? onTap;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  bool showBoxDecoration;

  BtnSetting({
    this.isSelectedKey = false,
    this.text = '',
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.height = 65.0,
    this.width = 65.0,
    this.backcolor = const Color(0xFF6099c9),
    this.shadowcolor = const Color(0xFF2C5A80),
    this.bordercolor = Colors.black12,
    this.textcolor = Colors.white,
    this.fontsize = 20,
    this.alignment = Alignment.center,
    this.onTap,
    this.showBoxDecoration = false,
  });
}

/// テキスト用：TextBtnWidget
class TxtSetting {
  double height;
  double width;
  String text;
  Color backcolor;
  Color shadowcolor;
  Color bordercolor;
  Color textcolor;
  double fontsize;
  AlignmentGeometry alignment;
  Function? onTap;
  bool visible;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  TxtSetting({
    this.text = '',
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.height = 65.0,
    this.width = 450.0,
    this.backcolor = const Color(0xff999999),
    this.shadowcolor = Colors.black54,
    this.bordercolor = Colors.black12,
    this.textcolor = Colors.black,
    this.fontsize = 20.0,
    this.alignment = Alignment.centerLeft,
    this.onTap,
    this.visible = true,
  });
}

class SioLblSetting extends LblSetting{
  SioLblSetting({
    super.isSelectedKey = false,
    super.text = '',
    super.visible = true,
    super.margin = const EdgeInsets.fromLTRB(0, 30, 0, 30),
    super.padding = EdgeInsets.zero,
    super.height = 90.0,
    super.width = 450,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor =  BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.center,
    super.onTap,
    super.showBoxDecoration,
  });
}

/// テキスト用：TextBtnWidget
class SioTxtSetting extends TxtSetting{
  SioTxtSetting({
    super.text = '',
    super.margin = EdgeInsets.zero,
    super.padding = EdgeInsets.zero,
    super.height = 28.0,
    super.width = 450.0,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor = BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.centerLeft,
    super.onTap,
    super.visible = true,
  });
}

// ボタンのボタン用：LabelBtnWidget
class SioBtnSetting extends BtnSetting{
  SioBtnSetting({
    super.isSelectedKey = false,
    super.visible = true,
    super.margin = EdgeInsets.zero,
    super.padding = EdgeInsets.zero,
    super.height = 90.0,
    super.width = 20.0,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor =  BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.centerLeft,
    super.onTap,
  });
}

/// ラベルテキストボタン用：LblTxtBtnWidget
class SioLblTxtBtnSetting {
  Rx<SioLblSetting>? lblsetting;
  Rx<SioTxtSetting>? txtsetting;
  Rx<BtnSetting>? btnsetting;
  int flex;
  double width;
  Axis axis;

  SioLblTxtBtnSetting({
    this.lblsetting,
    this.txtsetting,
    this.btnsetting,
    this.flex = 5,
    this.width = 500,
    required this.axis,
  });
}

/// スイッチボタン用：SwitchWidget
class SwitchSetting {
  double height;
  double conBtnWidth;
  double containerWidth;
  Color backcolor;
  double fontsize;
  Color boxPressedColor;
  Color pressedBorderColor;
  Color pressedFontColor;
  Color fontcolor;
  String onText;
  String offText;
  /// 今スイッチの状態.
  /// 使用するUIはObs()で囲う.
  final isSwitchedOn = false.obs;
  /// 選択中の文字列.
  /// 使用するUIはObs()で囲う.
  final switched = "".obs;

  Function() onTap;
  SwitchSetting({
    this.height = 50,
    this.conBtnWidth = 135,
    this.containerWidth = 260,
    this.backcolor = Colors.white,
    this.fontsize = 24,
    this.boxPressedColor =  BaseColor.maintainSwitchOnColor,
    this.pressedBorderColor =  BaseColor.maintainTitleBG,
    this.pressedFontColor = BaseColor.baseColor,
    this.fontcolor = BaseColor.baseColor,
    this.onText = "",
    this.offText = "",
    required this.onTap,
  });
}

/// メンテ画面基調色
class MenteBaseColor {
  static Color baseColor = Color.fromRGBO(86, 103, 113, 1);
}