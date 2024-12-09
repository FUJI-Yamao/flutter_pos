/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rcky_erctfm.dart';
import '../component/w_receiptcomplete.dart';
import '../controller/c_receipt_scan_ctrl.dart';
import '../enum/e_input_enum.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../../../component/w_inputbox.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/date_util.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rc_elog.dart';
import '../../../../regs/checker/rckycrdtvoid.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../../../postgres_library/src/db_manipulation_ps.dart';

///通番訂正入力コントローラ
class ReceiptInputController extends GetxController {
  ///コンストラクタ
  ReceiptInputController({
    //required List<GlobalKey<InputBoxWidgetState>> inputBoxList,
    required List<ReceiptVoidInputFieldLabel> labels}) {}

  int oldOpeModeFlg = 0;
  int oldOpeMode = 0;
  int oldScrMode = 0;
  @override
  void onInit() {
    super.onInit();
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    // 通番訂正　検定対応　画面に入った時点のopeModeなどを退避させておく
    oldOpeModeFlg = mem.tHeader.ope_mode_flg;
    oldOpeMode = cMem.stat.opeMode;
    oldScrMode = cMem.stat.scrMode;
    // 通番訂正　検定対応　訓練モード以外は訂正モードを設定する
    switch(cMem.stat.opeMode){
      case RcRegs.TR:
        cMem.stat.scrMode = RcRegs.TR_CRDTVOIDS;
        break;
      default:
        cMem.stat.opeMode = RcRegs.VD;
        cMem.stat.scrMode = RcRegs.VD_CRDTVOIDS;
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    // 通番訂正　検定対応　画面を閉じる際に、画面に入った時点のopeModeなどに戻す処理
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    mem.tHeader.ope_mode_flg = oldOpeModeFlg;
    cMem.stat.opeMode = oldOpeMode;
    cMem.stat.scrMode = oldScrMode;
  }

  bool lblAddFlg = false;    //入力項目追加フラグ

  ///各入力boxの状態を管理ためのGlobalKeyリスト
  // late final List<GlobalKey<InputBoxWidgetState>> inputBoxList;

  final ReceiptScanController scanCtrl = Get.find();

  /// テンキー表示フラグ
  var showRegisterTenkey = true.obs;

  ///「決定」ボタン表示フラグ
  var showDecisionButton = false.obs;

  /// 日付の有効ステータス
  var isCurrentDateValid = true.obs;

  /// 編集している入力boxの位置. 0始まり
  int inputBoxPosition = 0;

  /// 現在の入力フィールドタイプ.
  InputFieldType currentFieldType = InputFieldType.none;

  /// レジ番号桁数
  static const int registerNumLength = 6;

  /// レシート番号桁数
  static const int receiptNumLength = 4;

  /// 入力フィールドラベル.
  // final List<ReceiptVoidInputFieldLabel> labels;

  /// 各ラベルの状態を管理ためのG入力フィールドラベル.
  var labels = <ReceiptVoidInputFieldLabel>[].obs;

  /// 各入力boxの状態を管理ためのGlobalKeyリスト
  var inputBoxList = <GlobalKey<InputBoxWidgetState>>[].obs;

  /// 画面のタイトル
  late String title;

  /// バーコードスキャンで取得した値を保持するリスト
  List<String> initValues = [];

  /// タップした入力boxから文字列取得処理
  String getNowStr() {
    if (inputBoxPosition < 0 || inputBoxPosition >= inputBoxList.length) {
      return "";
    }
    InputBoxWidgetState? state = inputBoxList[inputBoxPosition].currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理
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
    inputBoxList[inputBoxPosition].currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    inputBoxList[inputBoxPosition].currentState?.onDeleteAll();
  }

  /// キータイプに応じた入力処理
  void inputKeyType(KeyType key) {
    if(!showRegisterTenkey.value){
      return;
    }
    switch (key) {
      case KeyType.delete:
        _deleteOneChar();
        break;
      case KeyType.check:
        _decideButtonPressed();
        break;
      case KeyType.clear:
        _clearString();
        break;
      default:
        _handleOtherKeys(key);
        break;
    }
  }

  /// QUICPayID訂正処理を実装する
  Future<bool> excuteVoidProcessing() async {
    updateCrdtVoidValues(false);
    int errNo = await checkCrdtVoidValues(RcKyCrdtVoid.crdtVoid.recNo, null);
    if (errNo != 0) {
      _showErrorErrID(errNo);
      return false;
    }

    //合計金額の設定
    RegsMem().tTtllog.calcData.stlTaxAmt = RcKyCrdtVoid.crdtVoid.amt;

    // かざす画面に行く前にデータをチェックするための処理.
    if (scanCtrl.currentPaymentType.value == PaymentType.cash) {
      errNo = await RcKyCrdtVoid.rcCrdtVoidStart(0);
    } else {
      errNo = await RcKyCrdtVoid.rcCrdtVoidStart(1);
    }
    if (errNo != 0) {
      return false;
    }

    return true;
  }

  /// 支払方法に沿った、入力画面の追加項目を生成する
  void quickPayProcessExcute(PaymentType selected) {
    List<ReceiptVoidInputFieldLabel> newlabels =
    scanCtrl.onPaymentType(selected);
    initLabels(newlabels);
    showDecisionButton.value = allInput();
  }

  /// ラベル初期化
  void initLabels(List<ReceiptVoidInputFieldLabel> initalLabels) {
    labels.assignAll(initalLabels);
    updateInputBoxList();
  }

  /// ラベル追加
  void addlabels(ReceiptVoidInputFieldLabel label) {
    labels.add(label);
    updateInputBoxList();
  }

  /// InputBoxList更新し、既存の入力ボックスの状態を保持する
  void updateInputBoxList() {
    var newInputBoxList = <GlobalKey<InputBoxWidgetState>>[];
    for (var i = 0; i < labels.length; i++) {
      if (i < inputBoxList.length) {
        newInputBoxList.add(inputBoxList[i]);
      } else {
        newInputBoxList.add(GlobalKey<InputBoxWidgetState>());
      }
    }
    inputBoxList.value = newInputBoxList;
  }

  /// フィールドタイプに基づいた入力処理.
  void _handleOtherKeys(KeyType key) {
    switch (currentFieldType) {
      case InputFieldType.date:
        _handleDateInput(key);
        break;
      case InputFieldType.registerNum:
        _handleRegisterNumInput(key);
        break;
      case InputFieldType.receiptNum:
        _handleReceiptNumInput(key);
        break;
      case InputFieldType.amount:
        _handleAmountInput(key);
        break;
      case InputFieldType.slipNum:
      case InputFieldType.cardNum:
        _handleSlipNumInput(key);
      default:
        break;
    }
  }

  /// 更新フォーカス.
  void updateFocus(int focusedIndex) {
    if (inputBoxPosition >= 0 && inputBoxPosition < inputBoxList.length) {
      inputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
    inputBoxPosition = focusedIndex;
    currentFieldType = labels[focusedIndex].fieldType;
    inputBoxList[inputBoxPosition].currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  void onInputBoxTap(int focusedIndex) {
    if (currentFieldType == InputFieldType.date) {
      final currentDateStr = getNowStr();
      if (!checkAndShowDateValidity(currentDateStr)) {
        return;
      }
    }
    updateFocus(focusedIndex);
    showRegisterTenkey.value = true;
    showDecisionButton.value = false;
    inputBoxList[focusedIndex].currentState?.setCursorOn();
  }

  /// 日付入力処理.
  void _handleDateInput(KeyType key) {
    String currentValue = getNowStr();
    if (currentValue.length >= 8) return;
    if (key == KeyType.zero || key == KeyType.doubleZero) {
      if (currentValue.isEmpty) return;
    }
    currentValue += key.name;
    inputBoxList[inputBoxPosition].currentState?.onChangeStr(currentValue);

    if (currentValue.length == 10) {
      checkAndShowDateValidity(currentValue);
    }
  }

  /// レジ番号入力処理.
  void _handleRegisterNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, registerNumLength)) {
      _showErrorMessage("レジ番号は6桁の数字でなければなりません。");
      return;
    }
    inputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// レシート番号入力処理.
  void _handleReceiptNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, receiptNumLength)) {
      /// 仮のメッセージ内容
      _showErrorMessage("レシート番号は4桁の数字でなければなりません。");
      return;
    }
    inputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// 合計金額入力処理.
  void _handleAmountInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (currentValue.isEmpty && key == KeyType.doubleZero) return;

    if (currentValue == '0' && key != KeyType.doubleZero) {
      currentValue = "";
    }
    String newValue = currentValue + keyValue;
    if (isValueInRange(newValue)) {
      currentValue += keyValue;
      inputBoxList[inputBoxPosition].currentState?.onChangeStr(currentValue);
    } else {
      return;
    }
  }

  /// 伝票番号、カード番号入力処理
  void _handleSlipNumInput(KeyType key) {
    String keyValue = key.name;
    inputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// 金額欄入力範囲
  bool isValueInRange(String value) {
    if (value.isEmpty) {
      return false;
    }
    int intValue = int.tryParse(value) ?? 0;
    return intValue >= -99999999 && intValue <= 99999999;
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    if (inputBoxPosition >= 0 && inputBoxPosition < inputBoxList.length) {
      inputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
  }

  /// 全ての入力欄が入力したかどうかのチェック処理
  bool allInput() {
    for (var inputBoxStateKey in inputBoxList) {
      var inputStr = inputBoxStateKey.currentState?.inputStr ?? "";
      if (inputStr.isEmpty) {
        return false;
      }
    }
    return true;
  }

  /// エラーダイアログ表示処理
  /// 引数:エラーメッセージ
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );

  }

  /// エラーダイアログ表示処理
  /// 引数:エラーNo
  void _showErrorErrID(int errId) {
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errId,
      ),
    );
  }

  /// 番号入力条件
  bool _isValidNumberInput(String currentValue, String keyValue,
      int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) {
      return false;
    }
    return true;
  }

  /// 日付フォーマット処理
  String _formatDate(String dateStr) {
    if (dateStr.length >= 4) {
      String year = dateStr.substring(0, 4);
      String month = '';
      String day = '';

      if (dateStr.length > 4) {
        int monthLength = dateStr.length >= 6 ? 2 : dateStr.length - 4;
        month = dateStr.substring(4, 4 + monthLength);
      }
      if (dateStr.length > 6) {
        day = dateStr.substring(6);
      }
      return year +
          (month.isNotEmpty ? "/$month" : "") +
          (day.isNotEmpty ? "/$day" : "");
    } else {
      return dateStr;
    }
  }

  /// テンキー入力の日付が正確の日付かどうか
  bool isValidDate(String dateStr) {
    String formattedDate = _formatDate(dateStr);

    try {
      final date = DateTime.tryParse(formattedDate.replaceAll('/', '-'));
      if (date == null) return false;

      final inputParts = formattedDate.split('/');
      final inputYear = int.parse(inputParts[0]);
      final inpuMonth = int.parse(inputParts[1]);
      final inputDay = int.parse(inputParts[2]);

      bool isValid = date.year == inputYear &&
          date.month == inpuMonth &&
          date.day == inputDay;

      return isValid;
    } catch (e) {
      debugPrint('解析日付エラー： $e');
      return false;
    }
  }

  /// 日付チェックの関数、９９日以内かと正確の日付なのか
  bool checkAndShowDateValidity(String dateStr) {
    final currebtdate = getNowStr();
    String formatDate = _formatDate(currebtdate);
    if (!isValidDate(currebtdate)) {
      debugPrint('無効の日付： $currebtdate');
      isCurrentDateValid.value = isValidDate(formatDate) &&
          DateUtil.isDateWithinRange(formatDate, DateUtil.daysIn99);

      if (!isCurrentDateValid.value) {
        _showErrorMessage("正しい日付を入力してください");

        return false;
      }
    }

    if (!DateUtil.isDateWithinRange(formatDate, DateUtil.daysIn99)) {
      _showErrorMessage("99日以内の日付を入力してください");
      return false;
    }
    return true;
  }

  ///「決定」ボタンでカーソル移動 とテンキー入力の日付チェック
  void _decideButtonPressed() {
    if (currentFieldType == InputFieldType.date) {
      final currentDateStr = getNowStr();
      if (!checkAndShowDateValidity(currentDateStr)) {
        return;
      }
    }
    int pos = inputBoxPosition;
    if (pos < inputBoxList.length - 1) {
      pos++;
      updateFocus(pos);
    } else {
      if (allInput()) {
        showRegisterTenkey.value = false;
        showDecisionButton.value = true;
        _closeCurrentCursor();
        return;
      } else {
        _closeCurrentCursor();
        showRegisterTenkey.value = false;
      }
      return;
    }
  }

  /// 更新RcKyCrdtVoid.crdtVoidの値(仮)
  /// 引数: 伝票番号、カード番号設定有無（false=なし  true=あり）
  void updateCrdtVoidValues(bool addFlg) {
    if (addFlg) {
      // QUICPay&iD、VEGA、ハウスクレジット
      int slipNoPosition = 4;
      String slipNoStr =
          inputBoxList[slipNoPosition].currentState?.inputStr ?? "";
      int slipNo = int.tryParse(slipNoStr) ?? 0;
      RcKyCrdtVoid.crdtVoid.slipNo = slipNo;
      if (scanCtrl.currentPaymentType.value == PaymentType.creditCard) {
        // ハウスクレジットのみ
        int cardNoPosition = 5;
        String cardNoStr =
            inputBoxList[cardNoPosition].currentState?.inputStr ?? "";
        int cardNo = int.tryParse(cardNoStr) ?? 0;
        RcKyCrdtVoid.crdtVoid.cardNo = cardNo;
      }
    } else {
      // 共有
      int chkDatePosition = 0;
      int macNoPosition = 1;
      int recNoPosition = 2;
      int amtPosition = 3;
      String chkDate = inputBoxList[chkDatePosition].currentState?.inputStr ?? "";
      if (chkDate.length == 8) {
        chkDate =
        '${chkDate.substring(0, 4)}-${chkDate.substring(4, 6)}-${chkDate
            .substring(6)}';
      }
      String macNoStr = inputBoxList[macNoPosition].currentState?.inputStr ?? "";
      String recNoStr = inputBoxList[recNoPosition].currentState?.inputStr ?? "";
      String amtStr = inputBoxList[amtPosition].currentState?.inputStr ?? "";

      int macNo = int.tryParse(macNoStr) ?? 0;
      int recNo = int.tryParse(recNoStr) ?? 0;
      int amt = int.tryParse(amtStr) ?? 0;

      RcKyCrdtVoid.crdtVoid.chkDate = chkDate;
      RcKyCrdtVoid.crdtVoid.macNo = macNo;
      RcKyCrdtVoid.crdtVoid.recNo = recNo;
      RcKyCrdtVoid.crdtVoid.amt = amt;
      RcKyCrdtVoid.crdtVoid.date = chkDate; //画面で設定された営業日を設定することにした
      RcKyCrdtVoid.crdtVoid.nowDisplay = RcElog.CRDTVOID_LCDDISP;
      RcKyCrdtVoid.crdtVoid.dialog = 0;
      RcKyCrdtVoid.crdtVoid.regsprnFlg = false;
      RcKyCrdtVoid.crdtVoid.errNo = 0;
    }
  }

  /// 検索領収書バックエンドに渡す情報の更新
  void updateSearchReceiptValues() {
    int chkDatePosition = 0;
    int macNoPosition = 1;
    int recNoPosition = 2;
    int amtPosition = 3;
    String chkDate = inputBoxList[chkDatePosition].currentState?.inputStr ?? "";
    if (chkDate.length == 8) {
      chkDate = '${chkDate.substring(0, 4)}-${chkDate.substring(4, 6)}-${chkDate.substring(6)}';
    }
    String macNoStr = inputBoxList[macNoPosition].currentState?.inputStr ?? "";
    String recNoStr = inputBoxList[recNoPosition].currentState?.inputStr ?? "";
    String amtStr = inputBoxList[amtPosition].currentState?.inputStr ?? "";

    int macNo = int.tryParse(macNoStr) ?? 0;
    int recNo = int.tryParse(recNoStr) ?? 0;
    int amt = int.tryParse(amtStr) ?? 0;

    RckyErctfm.eRctfm.macNo = macNo;
    RckyErctfm.eRctfm.recNo = recNo;
    RckyErctfm.eRctfm.amt = amt;
    RckyErctfm.eRctfm.date = chkDate; //画面で設定された営業日を設定することにした
    RckyErctfm.eRctfm.nowDisplay = RcElog.ERCTFM_LCDDISP;
    RckyErctfm.eRctfm.dialog = 0;
    RckyErctfm.eRctfm.errNo = 0;
  }

  /// 指定された伝票番号に関連するデータをDBから確認する（仮）
  Future<int> checkCrdtVoidValues(int recNo, FuncKey? funcKey) async {
    int errNo = 0;
    String saleDateForComparison = "";
    String sql2 = "";
    String tmpSql = "";
    String serialNo = "";
    DbManipulationPs db = DbManipulationPs();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    // 比較用営業日(2024-04-05 00:00:00 の形に整形する) chkDateは2024-04-05の形になっている)
    if (funcKey == null) {
      saleDateForComparison = '${RcKyCrdtVoid.crdtVoid.chkDate} 00:00:00';
    } else if (funcKey == FuncKey.KY_ERCTFM) {  // 検索領収書
      saleDateForComparison = '${RckyErctfm.eRctfm.date} 00:00:00';
    }

    String sql =
        "SELECT serial_no, print_no, ope_mode_flg FROM c_header_log WHERE comp_cd=@comp_cd AND stre_cd=@stre_cd AND mac_no=@mac_no AND receipt_no=@receipt_no AND sale_date=@sale_date;";
    Map<String, dynamic>? subValues = {
      "comp_cd": pCom.dbRegCtrl.compCd,
      "stre_cd": pCom.dbRegCtrl.streCd,
      "mac_no": pCom.dbRegCtrl.macNo,
      "receipt_no": recNo,
      "sale_date": saleDateForComparison
    };
    Result results = await db.dbCon.execute(Sql.named(sql), parameters: subValues);

    if (results.isEmpty) {
      //レシートNoが存在しない
      if (funcKey == null) {
        errNo = DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId;
      } else if (funcKey == FuncKey.KY_ERCTFM) { // 検索領収書
        errNo = DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId;
      }
    } else {
      for (var result in results) {
        Map<String, dynamic> data = result.toColumnMap();
        if (funcKey == null) {
          serialNo = RcKyCrdtVoid.crdtVoid.serialNo = data["serial_no"];
          RcKyCrdtVoid.crdtVoid.printNo = (double.tryParse(data["print_no"]) ?? 0).toInt();
        } else if (funcKey == FuncKey.KY_ERCTFM) {  // 検索領収書
          serialNo = RckyErctfm.eRctfm.serialNo = data["serial_no"];
          RckyErctfm.eRctfm.printNo = (double.tryParse(data["print_no"]) ?? 0).toInt();
          RckyErctfm.eRctfm.opeModeFlg = (int.tryParse(data["ope_mode_flg"]) ?? 0).toInt();
        }
        break;
      }
      sql2 =
          "SELECT n_data12 FROM c_data_log WHERE serial_no=@serial_no AND func_cd=@func_cd";
      Map<String, dynamic>? subValues = {
        "serial_no": serialNo,
        "func_cd": 400000
      };
      Result results2 = await db.dbCon.execute(Sql.named(sql2), parameters: subValues);

      if (results2.isEmpty) {
        tmpSql = "SELECT * FROM c_data_log WHERE serial_no=@serial_no";
        Map<String, dynamic>? subValues = {"serial_no": serialNo};
        results = await db.dbCon.execute(Sql.named(tmpSql), parameters: subValues);
        if (results.isNotEmpty) {
          //登録シリアルNo = キャッシュ決済時
          scanCtrl.currentPaymentType.value = PaymentType.cash;
          return 0;
        } else {
          //未登録シリアルNo
          if (funcKey == null) {
            errNo = DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId;
          } else if (funcKey == FuncKey.KY_ERCTFM) {  // 検索領収書
            errNo = DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId;
          }
        }
        if (funcKey == null) {
          errNo = DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId;
        } else if (funcKey == FuncKey.KY_ERCTFM) { // 検索領収書
          errNo = DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId;
        }
      } else {
        for (var result2 in results2) {
          Map<String, dynamic> data = result2.toColumnMap();
          cMem.working.crdtReg.icCardType = (double.tryParse(data["n_data12"]) ?? 0).toInt();
          switch (cMem.working.crdtReg.icCardType) {
            case 0: //キャッシュ
              scanCtrl.currentPaymentType.value = PaymentType.cash;
              break;
            case 52: //ハウスクレジット
              scanCtrl.currentPaymentType.value = PaymentType.creditCard;
              break;
            default: //上記以外（QUICPay,iD,VEGA）
              scanCtrl.currentPaymentType.value = PaymentType.quicPay;
              break;
          }
          break;
        }
      }
    }

    return errNo;
  }

  ///「実行」ボタン押下する処理（仮）
  Future<void> onDecisionButtonPressed(FuncKey funcKey) async {
     if (funcKey == FuncKey.KY_RCPT_VOID) {
      await excuteVoidProcessing().then((bool isSuccess) async {
        if (isSuccess) {
          if (!lblAddFlg &&
              (scanCtrl.currentPaymentType.value != PaymentType.cash)) {
            MsgDialog.show(
              MsgDialog.noButtonMsg(
                type: MsgDialogType.info,
                message: "お待ちください",
              ),
            );
            // 入力項目「伝票番号」「カード番号」の設定（クレジット、QUICPay&iD時）
            quickPayProcessExcute(scanCtrl.currentPaymentType.value);
            lblAddFlg = true;
            Get.back();
          } else {
            if (scanCtrl.currentPaymentType.value != PaymentType.cash) {
              updateCrdtVoidValues(true);
            }
            int errNo = await RcKyCrdtVoid.rcCrdtVoidInquStart(
                FuncKey.KY_CRDTVOID.keyId);
            if (errNo != 0) {
              await RcKyCrdtVoid.rcCrdtVoidDialogErr(errNo, 1, '');
            }
          }
        }
      });
    } else if (funcKey == FuncKey.KY_ERCTFM) { // 検索領収書
      updateSearchReceiptValues();
      int? errNo = await checkCrdtVoidValues(RckyErctfm.eRctfm.recNo, funcKey);
      if (errNo != 0) {
        _showErrorErrID(errNo);
        return;
      }
      // 検索領収書のメイン処理
      errNo = await RckyErctfm.erctfmStart();

      // 検索領収書の終了処理
      await RckyErctfm.rcERctfmEnd(errNo!);
      if (errNo != 0) {
        _showErrorErrID(errNo);
        return;
      }
    }
    debugPrint('新しいlabel追加: ${labels.map((e) => e.label).join(',')}');
    debugPrint('現時点の支払いタイプは： ${scanCtrl.currentPaymentType.value}');
  }

  /// 完了画面へ遷移(仮)
  void navigateToReceiptCompletePage() {
    lblAddFlg = false;
    Get.to(() => ReceiptCompletePage(title: title));
  }

  /// カレンダー画面「決定する」ボタン処理
  void moveFocusToNextInputBox(){
    int pos = inputBoxPosition;
    if(pos<inputBoxList.length-1){
      updateFocus(pos+1);
    }
  }
}
