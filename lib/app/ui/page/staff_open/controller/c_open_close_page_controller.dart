/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_staffpw.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_register_tenkey.dart';
import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/environment.dart';
import '../../../../if/if_drv_control.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/lib/ean.dart';
import '../../../../inc/lib/jan_inf.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../lib/cm_jan/set_jinf.dart';
import '../../../../lib/cm_sys/cm_stf.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../enum/e_screen_kind.dart';
import '../../common/component/w_msgdialog.dart';
import '../enum/e_openclose_enum.dart';

///従業員オープンクローズ画面のコントローラ
class OpenCloseInputController extends GetxController {
  final List<OpenCloseInputFieldLabel> labels;
  final String drvCtrlTag;

  ///コンストラクタ
  OpenCloseInputController({required this.labels, required this.drvCtrlTag})
      : opencloseinputBoxList = List.generate(
            labels.length, (index) => GlobalKey<InputBoxWidgetState>());

  ///各入力boxの状態を管理ためのGlobalKeyリスト
  final List<GlobalKey<InputBoxWidgetState>> opencloseinputBoxList;

  ///テンキー表示フラグ
  var showRegisterTenkey = true.obs;

  /// 編集している入力boxの位置. 0始まり
  int inputBoxPosition = 0;

  /// 現在の入力フィールドタイプ.
  OpenCloseInputFieldType currentFieldType = OpenCloseInputFieldType.codeNumber;

  ///従業員コード番号桁数
  static const int openCodeNumLength = 9;

  ///従業員パスワード番号桁数
  static const int openPasswordNumLength = 8;

  ///DBテーブル"c_staff_mst"から従業員パスワードを取得したか
  bool getPassFlg = false;

  ///2人制稼働時にタワー側で動作する
  var isDualModeChecker = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    if (await DualCashierUtil.check2Person()) {
      isDualModeChecker.value =
          EnvironmentData().screenKind == ScreenKind.register2 ? 1 : 0;
    }
  }

  ///インプットボックス状態リセット
  void resetState() {
    inputBoxPosition = 0;
    currentFieldType = OpenCloseInputFieldType.codeNumber;
    getPassFlg = false;

    for (var inputBoxKey in opencloseinputBoxList) {
      inputBoxKey.currentState?.onDeleteAll();
      inputBoxKey.currentState?.setCursorOff();
    }
    opencloseinputBoxList[0].currentState?.setCursorOn();
  }

  ///　タップした入力boxから文字列取得処理
  String getNowStr() {
    if (inputBoxPosition < 0 ||
        inputBoxPosition >= opencloseinputBoxList.length) {
      return "";
    }
    InputBoxWidgetState? state =
        opencloseinputBoxList[inputBoxPosition].currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理.
  void _deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) {
      if (0 < inputBoxPosition) {
        updateFocus(inputBoxPosition - 1);
        if (getNowStr().isNotEmpty) {
          _deleteOneChar();
        }
      }
      return;
    }
    opencloseinputBoxList[inputBoxPosition].currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    opencloseinputBoxList[inputBoxPosition].currentState?.onDeleteAll();
  }

  ///フィールドタイプに基づいた入力処理.
  void _handleOtherKeys(KeyType key) {
    switch (currentFieldType) {
      case OpenCloseInputFieldType.codeNumber:
        _opencloseCodeNumInput(key);
        break;
      case OpenCloseInputFieldType.passwordNumber:
        _openclosePassNumInput(key);
        break;
      default:
        break;
    }
  }

  ///キータイプに応じた入力処理.
  Future<void> inputKeyType(KeyType key) async {
    if (!showRegisterTenkey.value) {
      return;
    }
    switch (key) {
      case KeyType.delete:
        _deleteOneChar();
        break;
      case KeyType.check:
        await decideButtonPressed();
        break;
      case KeyType.clear:
        _clearString();
        break;
      default:
        _handleOtherKeys(key);
        break;
    }
  }

  ///　従業員コードの入力処理.
  void _opencloseCodeNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, openCodeNumLength)) {
      _showErrorMessage("従業員コードは最大9桁の数字でなければなりません。");
      return;
    }
    opencloseinputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// 番号入力条件
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) return false;
    return true;
  }

  ///パスワードの入力処理.
  void _openclosePassNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, openPasswordNumLength)) {
      _showErrorMessage("パスワードは最大8桁の数字でなければなりません。");
      return;
    }
    opencloseinputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// エラーダイアログ表示処理（引数：メッセージ）
  /// 「とじる」でダイアログをクリアし,入力済みの従業員コードがクリアされる
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: message,
          btnFnc: () {
            resetState();
            Get.back();
          }),
    );
  }

  /// エラーダイアログ表示処理（引数：エラーNo）
  void _showErrorMessageId(int errCode) {
    //すでにエラーダイアログが表示されたら、新しいerrダイアログを出せない
    if (MsgDialog.isDialogShowing) {
      return;
    }

    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errCode,
      ),
    );
  }

  /// 更新フォーカス.
  void updateFocus(int focusedIndex) {
    if (inputBoxPosition >= 0 &&
        inputBoxPosition < opencloseinputBoxList.length) {
      opencloseinputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
    showRegisterTenkey.value = true;
    inputBoxPosition = focusedIndex;
    currentFieldType = labels[focusedIndex].OpenCloseieldType;
    opencloseinputBoxList[inputBoxPosition].currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  /// パスワードの入力欄をタップしても、入力フォーカスを移動しない,決定ボタンしか動けない
  void onInputBoxTap(int focusedIndex) {
    if (labels[focusedIndex].OpenCloseieldType !=
        OpenCloseInputFieldType.passwordNumber) {
      updateFocus(focusedIndex);
      showRegisterTenkey.value = true;
      opencloseinputBoxList[focusedIndex].currentState?.setCursorOn();
    }
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    if (inputBoxPosition >= 0 &&
        inputBoxPosition < opencloseinputBoxList.length) {
      opencloseinputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
  }

  /// 全ての入力欄が入力したかどうかのチェック処理（未使用）
  bool allInput() {
    for (var inputBoxStateKey in opencloseinputBoxList) {
      var inputStr = inputBoxStateKey.currentState?.inputStr ?? "";
      if (inputStr.isEmpty) {
        return false;
      }
    }
    return true;
  }

  ///「決定」ボタンでカーソル移動 とテンキー入力の日付チェック
  Future<void> decideButtonPressed() async {
    int pos = inputBoxPosition;
    int errNo = 0;
    int scanTyp = 0;
    AplLibStaffPw.exeFlgSet(1);
    if (AplLibStaffPw.staffPw.inpStart == 0) {
      if (AplLibStaffPw.staffPw.inpFlg == 0) {
        AplLibStaffPw.staffPw.inpCode = "";
      }
      AplLibStaffPw.staffPw.inpStart = 1;
    }
    if (pos < opencloseinputBoxList.length - 1) {
      AplLibStaffPw.staffPw.beam = await CmStf.apllibStaffCDInputLimit(2);
      if (AplLibStaffPw.staffPw.scanBuf.isNotEmpty) {
        JANInf ji = JANInf();
        ji.code = AplLibStaffPw.staffPw.scanBuf;
        AplLibStaffPw.staffPw.scanBuf = "";
        await SetJinf.cmSetJanInf(ji, 0, 1);
        if (ji.type != JANInfConsts.JANtypeClerk &&
            ji.type != JANInfConsts.JANtypeClerk2 &&
            ji.type != JANInfConsts.JANtypeClerk3) {
          _showErrorMessageId(
              DlgConfirmMsgKind.MSG_BARFMTERR.dlgId); //バーコードフォーマットエラー
          AplLibStaffPw.exeFlgSet(0);
          return;
        } else {
          // 正しいバーコードなら入力欄にセット
          opencloseinputBoxList[0]
              .currentState!
              .onChangeStr(AplLibStaffPw.staffPw.inpCode);
        }
        if (ji.type == JANInfConsts.JANtypeClerk3) {
          int stfLen = await CmStf.apllibStaffCDInputLimit(2);
          int indataBuf =
              int.parse(ji.code.substring(Ean.ASC_EAN_13 - stfLen - 1, stfLen));
          if (indataBuf == 0) {
            TprLog().logAdd(AplLibStaffPw.staffPw.tid, LogLevelDefine.normal,
                "Ji.Type=JANtype_CLERK_3 zero err");
            _showErrorMessageId(DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
            AplLibStaffPw.exeFlgSet(0);
            return;
          }
        }
        scanTyp = 1;
      } else {
        // 従業員コード入力欄
        if (opencloseinputBoxList[0].currentState!.inputStr.isEmpty) {
          _showErrorMessageId(DlgConfirmMsgKind.MSG_NONEREC.dlgId);
          AplLibStaffPw.exeFlgSet(0);
          return;
        }
        AplLibStaffPw.staffPw.inpCode =
            opencloseinputBoxList[0].currentState!.inputStr;
      }
      errNo = await AplLibStaffPw.readCheckStaff(scanTyp);
      if (errNo != 0) {
        _showErrorMessageId(errNo);
        if (errNo == DlgConfirmMsgKind.MSG_CLKNONFILE.dlgId) {
          _clearString();
        }
      } else {
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        RxCommonBuf pCom = xRet.object;
        if (pCom.dbTrm.chkPasswordClkOpen != 0) {
          //パスワード入力欄あり
          pos++;
          getPassFlg = true;
          updateFocus(pos);
        } else {
          //パスワード入力欄なし
          errNo = await AplLibStaffPw.staffPwOpen(
              checkerFlag: isDualModeChecker.value);
          if (errNo != 0) {
            _showErrorMessageId(errNo);
            AplLibStaffPw.exeFlgSet(0);
            return;
          }
          _closeCurrentCursor();
          resetState();
          removeCtrl();
          Get.back(result: true);
        }
      }
    } else {
      // パスワード入力欄
      if (getPassFlg) {
        errNo = AplLibStaffPw.readCheckPw(
            opencloseinputBoxList[1].currentState!.inputStr);
        if (errNo != 0) {
          _showErrorMessageId(errNo);
          AplLibStaffPw.exeFlgSet(0);
          return;
        }
        // 従業員番号およびパスワードの確認,成功後入力ボックスリセット
        errNo = await AplLibStaffPw.staffPwOpen(
            checkerFlag: isDualModeChecker.value);
        if (errNo != 0) {
          _showErrorMessageId(errNo);
          AplLibStaffPw.exeFlgSet(0);
          return;
        }
        getPassFlg = false;
        _closeCurrentCursor();
        resetState();
        removeCtrl();
        Get.back(result: true);
      } else {
        _closeCurrentCursor();
      }
    }
    AplLibStaffPw.exeFlgSet(0);
  }

  /// 従業員オープンクローズがダイアログのため、controllerの破棄が適切に行われないことがある
  /// 手動でコントローラーを削除する
  /// TODO:00015 江原 要検討
  void removeCtrl() {
    // 従業員スキャン処理の削除
    IfDrvControl().scanMap.remove(drvCtrlTag);
    IfDrvControl().dispatchMap.remove(drvCtrlTag);
    // テンキーも削除.
    IfDrvControl().scanMap.remove(RegisterDeviceEvent.getTagWithAddStr(
        IfDrvPage.tenkey.name, drvCtrlTag));
    IfDrvControl().dispatchMap.remove(RegisterDeviceEvent.getTagWithAddStr(
        IfDrvPage.tenkey.name, drvCtrlTag));
  }
}
