/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/lib/mcd.dart';
import '../../../../regs/checker/rcmbrflrd.dart';
import '../../../../regs/checker/rcmbrkymbr.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../component/w_inputbox.dart';
import '../../../controller/c_common_controller.dart';
import '../../../enum/e_member_kind.dart';
import '../../../menu/register/m_menu.dart';
import '../../common/component/w_msgdialog.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../register/model/m_membermodels.dart';
import '../../subtotal/component/w_register_tenkey.dart';

/// 会員呼出画面のコントローラ
class MemberCallInputController extends GetxController {
  /// コンストラクタ
  MemberCallInputController()
      : inputBoxKey = GlobalKey<InputBoxWidgetState>();

  /// 入力boxの状態を管理するためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey;

  /// 会員コード
  var memberCode = ''.obs;

  /// テンキー表示フラグ
  var showRegisterTenkey = true.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  /// 画面上の会員コード最大桁数
  static int maxMemberCodeDisplayLength = 20;
  /// 会員コードの最大桁数
  static int maxMemberCodeLength = 12;
  /// 会員コードの最小桁数
  static int minMemberCodeLength = 9;
  /// 会員コード桁数(最大)
  var memberCodeMaxLength = maxMemberCodeDisplayLength.obs;
  /// 会員コード桁数(最小)
  var memberCodeMinLength = minMemberCodeLength.obs;

  @override
  void onInit() {
    super.onInit();
    // 対象会員の最大桁数を取得して最大値設定する
    // （~/src/lib/apllib/rmdbread.c の rmDbInstreDataSet() 参照）
    // 現時点では12桁固定
    setMemberCodeMaxLength(maxMemberCodeLength);
    setMemberCodeMinLength(minMemberCodeLength);
  }
  /// タップした入力boxから文字列取得処理
  String getNowStr() {
    InputBoxWidgetState? state = inputBoxKey.currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理
  void _deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) return;

    inputBoxKey.currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    inputBoxKey.currentState?.onDeleteAll();
  }

  /// 会員コードの入力処理
  /// key   キー種別
  void _handleOtherKeys(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    if (!_isValidNumberInput(currentValue, keyValue, memberCodeMaxLength.value)) {
      _showErrorMessage('会員コードは最大${memberCodeMaxLength.value.toString()}桁です');
      return;
    }

    currentValue += keyValue;
    inputBoxKey.currentState?.onChangeStr(currentValue);
  }

  /// キータイプに応じた入力処理
  /// key   キー種別
  Future<void> inputKeyType(KeyType key) async {
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
        // タップ直後は文字入力時に古い内容をクリアする
        if (isFirstInput.value) {
          // 一文字でも入力したらクリアしないようにフラグ削除
          isFirstInput.value = false;
          _clearString();
        }
        _handleOtherKeys(key);
        break;
    }
  }

  /// 番号入力条件
  /// currentValue  現在の入力内容
  /// keyValue      キー入力された内容
  /// maxLength     最大入力桁数
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) {
      return false;
    }
    return true;
  }

  /// 番号入力条件
  /// currentValue  現在の入力内容
  /// minLength     最小入力桁数
  bool _isValidMinNumberInput(
      String currentValue, int minLength) {
    if (currentValue.length < minLength) {
      return false;
    }
    return true;
  }

  /// エラーダイアログ表示処理
  /// 引数：メッセージ
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

  /// 更新フォーカス.
  void updateFocus() {
    showRegisterTenkey.value = true;
    inputBoxKey.currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  /// テンキーを表示する、フォーカスをon
  void onInputBoxTap() {
    updateFocus();
    showRegisterTenkey.value = true;
    // タップ直後は文字入力時に古い内容をクリアする
    isFirstInput.value = true;
    inputBoxKey.currentState?.setCursorOn();
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    inputBoxKey.currentState?.setCursorOff();
  }

  /// テンキーの「決定」ボタンで入力完了の処理
  void _decideButtonPressed() {
    String currentValue = getNowStr();
    if (!_isValidMinNumberInput(currentValue, memberCodeMinLength.value)) {
      _showErrorMessage('会員コードは最小${memberCodeMinLength.value.toString()}桁です');
      return;
    }

    _closeCurrentCursor();
    showRegisterTenkey.value = false;
    memberCode.value = inputBoxKey.currentState!.inputStr;
  }

  /// 会員コードの最大桁数を設定する
  /// maxLength  会員コード最大桁数
  void setMemberCodeMaxLength(int maxLength) {
    memberCodeMaxLength.value = maxLength;
  }

  /// 会員コードの最小桁数を設定する
  /// minLength  会員コード最小桁数
  void setMemberCodeMinLength(int minLength) {
    memberCodeMinLength.value = minLength;
  }

  /// バックエンド処理を実装する
  Future<bool> executeMemberCallProcessing(String memberCode) async {
    debugPrint('呼び出し会員コード=${memberCode.toString()}');

    AcMem cMem = SystemFunc.readAcMem();
    Rcmbrkymbr.mbrId = memberCode;

    await Rcmbrkymbr.rcKyMbr();
    if (cMem.ent.errNo != 0) {
      _showErrorErrID(cMem.ent.errNo);
      return false;
    }
    return true;
  }

  ///「確定する」ボタン押下時の処理
  Future<void> onConfirmButtonPressed() async {
    await executeMemberCallProcessing(memberCode.value).then((bool isSuccess) async {
      if (isSuccess) {
        // TODO:10155 顧客呼出 正常動作確認用（フロント側へ渡すパラメタ）
        debugPrint('********** custNo = ${RcMbrFlrd.cust.cust_no}');
        debugPrint('********** status = ${RcMbrFlrd.rcdStatus}');
        debugPrint('********** ttlPoint = ${RcMbrFlrd.ttlPoint}');
        debugPrint('********** lapsePoint = ${RcMbrFlrd.lapsePoint}');
        debugPrint('********** lapseDay = ${RcMbrFlrd.lapseDay}');
        setMemberInfo();
        toBackPage();
     }
   });
  }

  /// 顧客情報をRegisterBodyControllerに設定する
  void setMemberInfo() {
    MemberInfo memberInfo = getMemberInfo();
    RegisterBodyController registerBodyCtrl = Get.find();
    registerBodyCtrl.setMemberType(memberInfo);
  }

  /// 顧客情報を取得する
  MemberInfo getMemberInfo() {
    // MemberInfoインスタンスを作成する
    MemberInfo memberInfo = createMemberInfo();

    memberInfo.makeMemberInfo();
    return memberInfo;
  }

  // 顧客情報を作成する
  MemberInfo createMemberInfo() {
    // 顧客種別を示すMemberKindを取得する
    MemberInfo memberInfo = MemberInfo(memberKind: MemberKind.rara);
    // 顧客No
    memberInfo.memberNo = RcMbrFlrd.cust.cust_no != null ? int.parse(RcMbrFlrd.cust.cust_no!) : 0;
    // ポイント累計
    memberInfo.pointCumulateTotal = RcMbrFlrd.ttlPoint;
    // 顧客情報としてクレジットカードの種別を表す文字列を取得する
    switch (RcMbrFlrd.cardType) {
      case Mcd.MCD_RLSCARD:
        memberInfo.creditName = '会員RARA';
        break;
      case Mcd.MCD_RLSCRDT:
        memberInfo.creditName = '会員RARAJCB';
        break;
      case Mcd.MCD_RLSVISA:
        memberInfo.creditName = '会員RARAVISA';
        break;
      case Mcd.MCD_RLSJACCS:
        memberInfo.creditName = '会員RARAJACCS';
        break;
      case Mcd.MCD_RLSSTAFF:
        memberInfo.creditName = '社員';
        break;
      default:
        memberInfo.creditName = '';
        break;
    }
    // 顧客情報としてシニア会員フラグを取得する
    memberInfo.isSenior = RcMbrFlrd.seniorFlg;

    return memberInfo;
  }

  /// 呼出元の画面へ遷移
  void toBackPage() {
    CommonController commonCtrl = Get.find();
    if (commonCtrl.onSubtotalRoute.value) {  //小計画面から端末読込画面を起動
      SetMenu1.navigateToPaymentSelectPage();
    } else {  //登録画面から端末読込画面を起動
      SetMenu1.navigateToRegisterPage();
    }
  }
}
