/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_inputbox.dart';
import '../../../common/component/w_msgdialog.dart';
import '../component/w_ipaddress.dart';
import 'c_key_controller_base.dart';

/// IPAddress入力用コントローラー
class IPAddressController extends KeyControllerBase {
  IPAddressController(this.inputBoxList,
      {this.minValue = const [0, 0, 0, 0],
      this.maxValue = const [255, 255, 255, 255]});

  final List<GlobalKey<InputBoxWidgetState>> inputBoxList;

  // 編集しているIPTextboxの位置. 0始まり
  int ipPosition = 0;
  static const editColor = BaseColor.maintainTenkeyCursor;
  static const normalColor = BaseColor.someTextPopupArea;

  final List<int> minValue;
  final List<int> maxValue;

  @override
  void onInit() {
    super.onInit();
    // 初期位置の指定
    changeEditPosition(0);
  }

  String getNowStr() {
    InputBoxWidgetState? state = inputBoxList[ipPosition].currentState;
    return state?.inputStr ?? "";
  }

  @override
  bool checkOverLimit(String strVal) {
    if (maxValue[ipPosition] < (int.tryParse(getNowStr() + strVal) ?? 0)) {
      return false;
    }
    return true;
  }

  @override
  bool checkWithInRange() {
    for (int i = 0; i < IpaddressInputWidget.ipBoxNum; i++) {
      String data = inputBoxList[i].currentState?.inputStr ?? "";
      if (data.isEmpty) {
        return false;
      }
      int minNum = minValue[ipPosition];
      int maxNum = maxValue[ipPosition];
      try {
        int address = int.parse(data);
        if (address < minNum || maxNum < address) {
          return false;
        }
      } catch (e) {
        // intに変換できない文字が入っていた.
        return false;
      }
    }

    return true;
  }

  @override
  void deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) {
      if (0 < ipPosition) {
        changeEditPosition(ipPosition - 1);
        if (getNowStr().isNotEmpty) {
          deleteOneChar();
        }
      }
      return;
    }
    inputBoxList[ipPosition].currentState?.onDeleteOne();
  }

  /// IPアドレスのIPv4の各8ビットの部分をチェックし画面に再描画
  @override
  void addString(String val) {
    // 現在位置
    int i = ipPosition;

    int ipForm = minValue[i];
    int ipTo = maxValue[i];

    String ipAddress = getNowStr();

    if ((ipAddress + val).length <= 3) {
      String afterValue = ipAddress + val;
      if (int.parse(afterValue) >= ipForm && int.parse(afterValue) <= ipTo) {
        // 先頭の0を消すために一旦数字に直す.
        int num = int.tryParse(afterValue) ?? 0;
        inputBoxList[i].currentState?.onChangeStr(num.toString());
      }
    }
  }

  /// Cをタップされた場合のクリア関数
  @override
  void clearString() {
    inputBoxList[ipPosition].currentState?.onDeleteAll();
  }

  /// 対象となるIPv4の各8ビット部分の色を変更
  void changeEditPosition(int i) {
    // ポジション変更
    ipPosition = i;
    for (int index = 0; index < IpaddressInputWidget.ipBoxNum; index++) {
      if (ipPosition != index) {
        inputBoxList[index].currentState?.setCursorOff();
      } else {
        inputBoxList[index].currentState?.setCursorOn();
        inputBoxList[index].currentState?.setCursorPositionLast();
      }
    }
  }

  /// 画面タブキーでのテキスト間移動
  @override
  void tabKey(bool addCalc) {
    int pos = ipPosition;
    if (addCalc) {
      if (pos == 3) {
        pos = 0;
      } else {
        pos++;
      }
    } else {
      if (pos == 0) {
        pos = 3;
      } else {
        pos--;
      }
    }
    changeEditPosition(pos);
  }

  ///　IPアドレス入力Widgetから戻り値の編集
  String ipJoin() {
    List<String> ipaddr = [];
    for (int i = 0; i < IpaddressInputWidget.ipBoxNum; i++) {
      InputBoxWidgetState? state = inputBoxList[i].currentState;
      ipaddr.add(state?.inputStr ?? "0");
    }
    return ipaddr.join(".");
  }

  @override
  void pushInputKey(dynamic num) {
    bool valid = checkOverLimit(num.toString());
    if (!valid) {
      int minNum = minValue[ipPosition];
      int maxNum = maxValue[ipPosition];
      MsgDialog.show(
        //todo ダイアログメッセージ確定出来たらdialogKindを追加
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message:"$minNumから$maxNumの範囲内の値を入力してください",
        ),
      );

    } else {
      addString(num.toString());
    }
  }
}

/// IP情報
class IpInfo {
  String ipAddress;
  Color backColor;

  IpInfo({required this.ipAddress, required this.backColor});
}
