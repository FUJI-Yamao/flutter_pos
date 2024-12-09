import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:get/get.dart';

import '../../../../model/m_widgetsetting.dart';
import 'm_specfile.dart';

// ヘッダー用：HeaderTitleWidget
class HeaderSetting {
  String title;
  String comment;
  bool isBtnShow;
  Rx<SpecFileBtnSetting>? btnSetting;
  Function? onTapCallBack;

  HeaderSetting(
      {this.title = '',
      this.comment = '',
      this.btnSetting,
      this.isBtnShow = false,
      this.onTapCallBack});
}

// ラベルボタンのラベル用：LabelBtnWidget
class SpecFileLblSetting extends LblSetting{
  SpecFileDispRow specInfo;

  SpecFileLblSetting({
    required this.specInfo,
    super.isSelectedKey = false,
    super.text = '',
    super.visible = true,
    super.margin = const EdgeInsets.fromLTRB(0, 30, 0, 30),
    super.padding = EdgeInsets.zero,
    super.height = 90.0,
    //this.width = 450.0,
    super.width = 450,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor =  BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.center,
    super.onTap,
  });
}

// ボタンのボタン用：LabelBtnWidget
class SpecFileBtnSetting extends BtnSetting{
  Widget ? icon;
  SpecFileBtnSetting({
    super.isSelectedKey = false,
    super.visible = true,
    super.margin = EdgeInsets.zero,
    super.padding = EdgeInsets.zero,
    super.height = 65.0,
    super.width = 20.0,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor =  BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.centerLeft,
    super.onTap,
    this.icon,
  });
}

//ラベル＆テキスト：LblTxtWidget
class LblTxtSetting {
  Rx<SpecFileLblSetting>? lblsetting;
  Rx<SpecFileTxtSetting>? txtsetting;
  int flex;
  double width;
  bool txtvisible;

  LblTxtSetting({
    this.lblsetting,
    this.txtsetting,
    this.flex = 3,
    this.width = 450,
    this.txtvisible = true,
  });
}

//ラベル＆テキスト：LblTxtWidget
class LblTxtBtnSetting {
  Rx<SpecFileLblSetting>? lblsetting;
  Rx<SpecFileTxtSetting>? txtsetting;
  Rx<SpecFileBtnSetting>? btnsetting;
  int flex;
  double width;
  final axis;
  bool containsSwitch;

  LblTxtBtnSetting({
    this.lblsetting,
    this.txtsetting,
    this.btnsetting,
    this.flex = 5,
    //this.width = 650,
    this.width = 720,
    this.axis,
    required this.containsSwitch,
  });
}

class LblSwitchSetting {
  Rx<SpecFileLblSetting>? lblsetting;
  SwitchSetting switchsetting;
  int flex;
  double width;
  final axis;
  bool containsSwitch;

  LblSwitchSetting({
    this.lblsetting,
    required this.switchsetting,
    this.flex = 5,
    //this.width = 650,
     //this.width = 720,
    //this.width = 900,
    this.width = 720,
    this.axis,
    required this.containsSwitch,
  });
}


// テキスト用：TextBtnWidget
class SpecFileTxtSetting extends TxtSetting{
  SpecFileTxtSetting({
    super.text = '',
    super.margin = EdgeInsets.zero,
    super.padding = EdgeInsets.zero,
    super.height = 35.0,
    super.width = 450.0,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor = BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.topLeft,
    super.onTap,
    super.visible = true,
  });
}

// テキスト用：TextBtnWidget
class SpecFileTxtSetting2 extends SpecFileTxtSetting{
  String dbText;
  SpecFileTxtSetting2({
    super.text = '',
    super.margin = EdgeInsets.zero,
    super.padding = EdgeInsets.zero,
    super.height = 35.0,
    super.width = 450.0,
    super.backcolor = Colors.transparent,
    super.shadowcolor = Colors.transparent,
    super.bordercolor = Colors.transparent,
    super.textcolor = BaseColor.someTextPopupArea,
    super.fontsize = 23,
    super.alignment = Alignment.topLeft,
    super.onTap,
    super.visible = true,
    required this.dbText,
  });
}

// ドロップダウン：DropDownWidget
class DropDownSetting {
  List<String>? lists;
  double height;
  double width;
  String dropdownValue;
  Color backcolor;
  Color shadowcolor;
  Color bordercolor;
  Color textcolor;
  double fontsize;
  AlignmentGeometry alignment;
  Function? onChangedCallBack;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  DropDownSetting({
    this.dropdownValue = '',
    this.lists,
    this.margin = const EdgeInsets.fromLTRB(0, 20, 0, 20),
    this.padding = EdgeInsets.zero,
    this.height = 80.0,
    this.width = 450.0,
    this.backcolor = const Color(0xff999999),
    this.shadowcolor = Colors.transparent,
    this.bordercolor = Colors.transparent,
    this.textcolor =  BaseColor.someTextPopupArea,
    this.fontsize = 20,
    this.alignment = Alignment.topLeft,
    this.onChangedCallBack,
  });
}

// tenkey
class TenkeySetting {
  bool isTnKyShow;
  Function? onTap;

  TenkeySetting({this.isTnKyShow = false, this.onTap});
}
