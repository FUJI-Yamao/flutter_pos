/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../regs/inc/rc_crdt.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../model/m_credit_installment_number_models.dart';
import '../model/m_creditpaymentmethodmodels.dart';
// todo 業務宣言画面の実装後にコメントを解除
// import '../../register/model/m_membermodels.dart';
// import '../../../../common/cmn_sysfunc.dart';
// import '../../../../inc/apl/rxregmem_define.dart';

/// クレジット宣言画面の状態
enum CreditProcessState {
  readCard,         // クレジットカード読み込み中
  selectPayment,    // 支払方法選択中
  confirmPayment,   // 支払方法確認中
  processPayjment,  // クレジット支払い処理中
}

/// クレジット宣言画面のコントローラ
class CreditPaymentController extends GetxController {
  /// コンストラクタ
  CreditPaymentController();

  /// 支払方法、分割回数の表示時の水平方向の最大数
  static const int maxHorizontal = 6;

  /// 支払方法、分割回数の表示時の垂直方向の最大数
  static const int maxVertical = 3;

  /// CCrdtDemandTblColumnsの分割数の有効フラグの接頭語
  static const String dividePrefix = 'divide';

  /// クレジット宣言画面の状態
  var creditProcessState = CreditProcessState.readCard.obs;
  /// 支払方法
  var paymentMethod = ''.obs;
  /// クレジット会社名
  var creditName = ''.obs;
  /// カード番号
  var cardNumber = ''.obs;
  /// 有効期限
  var expiration = ''.obs;
  /// 選択した支払方法
  var selectPaymentType = 0.obs;
  /// 支払方法のリスト
  List<CreditPaymentMethod> paymentList = <CreditPaymentMethod>[];

  /// 分割回数のリスト
  List<CreditInstallmentNumber> installmentList = <CreditInstallmentNumber>[];

  /// 選択した分割回数
  int selectedInstallmentNumber = 0;

  /// 支払方法の詳細１の見出し
  var paymentDetailTopic1 = ''.obs;
  /// 支払法の詳細１の内容
  var paymentDetailContent1 = ''.obs;
  /// 支払方法の詳細２の見出し
  var paymentDetailTopic2 = ''.obs;
  /// 支払法の詳細２の内容
  var paymentDetailContent2 = ''.obs;

  /// 実行ボタンの表示状態
  var performBtnView = true.obs;

  /// appBarのメッセージ内容
  var appBarMessage = ''.obs;
  /// 支払方法を三段表示する際の一段目の最終アイテムのリストインデックス
  var listFirstStageNum = 0.obs;
  /// 支払方法を三段表示する際の二段目の最終アイテムのリストインデックス
  var listSecondStageNum = 0.obs;

  /// 分割回数を三段表示する際の一段目の最終アイテムのリストインデックス
  var insListFirstStageNum = 0.obs;
  /// 分割回数を三段表示する際の二段目の最終アイテムのリストインデックス
  var insListSecondStageNum = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    setCreditPaymentStatus(CreditProcessState.readCard);
    paymentMethod.value = '';
    creditName.value = '';
    cardNumber.value = '';
    expiration.value = '';
    selectPaymentType.value = 0;
    paymentDetailTopic1.value = '';
    paymentDetailContent1.value = '';
    paymentDetailTopic2.value = '';
    paymentDetailContent2.value = '';
    performBtnView.value = true;
    paymentList.clear();
    installmentList.clear();
    // todo フロント・バックエンド結合後：以下を削除
    //loadTestPaymentData();
  }

  /// クレジットカード情報を設定する
  void setCreditInfo(String creditName, String cardNumber, String expiration) {
    this.creditName.value = creditName;
    this.cardNumber.value = cardNumber;
    this.expiration.value = expiration;
  }

  /// 支払方法を追加する
  void addPaymentMethod(CreditPaymentMethod creditPaymentMethod) {
    if (paymentList.length < maxHorizontal * maxVertical) {
      paymentList.add(creditPaymentMethod);
      _setPaymentListViewIndex();
    } else {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "addPaymentMethod paymentList add error : length is max");
    }
  }

  /// 支払方法を設定する
  void setPaymentMethods(List<CreditPaymentMethod> creditPaymentMethods) {
    // 最大数以下の場合
    if (creditPaymentMethods.length <= maxHorizontal * maxVertical) {
      paymentList.addAll(creditPaymentMethods);
    } else {
      // 最大数を超える場合は最大件数までを設定
      paymentList.addAll(creditPaymentMethods.getRange(0, maxHorizontal * maxVertical - paymentList.length).toList());
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "setPaymentMethods paymentList set error : length over");
    }
    _setPaymentListViewIndex();
  }

  /// 支払方法の行ごとの表示indexを設定する
  void _setPaymentListViewIndex() {
    listFirstStageNum.value = paymentList.length > maxHorizontal ? maxHorizontal - 1 : paymentList.length - 1;
    listSecondStageNum.value = (paymentList.length > maxHorizontal * 2) ? (maxHorizontal * 2 - 1)
        : (paymentList.length - 1);
  }

  /// 分割回数を追加する
  void addInstallmentNumber(CreditInstallmentNumber creditInstallmentNumber) {
    if (installmentList.length < maxHorizontal * maxVertical) {
      installmentList.add(creditInstallmentNumber);
      _setInstallmentListViewIndex();
    } else {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "addInstallmentNumber installmentList add error : length is max");
    }
  }

  /// 支払回数を設定する
  void setInstallmentNumbers(List<CreditInstallmentNumber> creditInstallmentNumbers) {
    installmentList.clear();
    if (creditInstallmentNumbers.length <= maxHorizontal * maxVertical) {
      // 最大数以下の場合
      installmentList.addAll(creditInstallmentNumbers);
    } else {
      // 最大数を超える場合は最大件数までを設定
      installmentList.addAll(creditInstallmentNumbers.getRange(0, maxHorizontal * maxVertical).toList());
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "setInstallmentNumbers installmentList set error : length over");
    }
    _setInstallmentListViewIndex();
  }

  /// 分割回数の行ごとの表示indexを設定する
  void _setInstallmentListViewIndex() {
    insListFirstStageNum.value = installmentList.length > maxHorizontal ? maxHorizontal - 1 : installmentList.length - 1;
    insListSecondStageNum.value = (installmentList.length > maxHorizontal * 2) ? (maxHorizontal * 2 - 1)
        : (installmentList.length - 1);
  }

  /// CreditDeclarationPage画面の状態を設定する
  void setCreditPaymentStatus(CreditProcessState creditProcessState) {
    this.creditProcessState.value = creditProcessState;
    switch (creditProcessState) {
      case CreditProcessState.readCard:
        appBarMessage.value = '端末にカードを読ませてください';
      case CreditProcessState.selectPayment:
        appBarMessage.value = 'お支払い方法を選択してください';
      case CreditProcessState.confirmPayment:
        appBarMessage.value = '内容を確認し、「確定する」を押してください';
      default:
        appBarMessage.value = '';
    }
  }

  /// 分割回数のリストを取得する
  /// paymentCodeは未使用
  List<CreditInstallmentNumber> getInstallmentList(int paymentCode) {
    AcMem cMem = SystemFunc.readAcMem();
    List<CreditInstallmentNumber> list = <CreditInstallmentNumber>[];

    var tbl = cMem.working.refData.crdtTbl;
    var divideMap = tbl.toDivideMap();
    for (int i = 0; i < divideMap.length; i++) {
      var element = divideMap.entries.elementAt(i);
      var item = getInstallmentObj(element.key, element.value, paymentCode);
      if (item != null) {
        list.add(item);
      }
    }

    return list;
  }

  /// crdtTblのdivide～要素からCreditInstallmentNumberを返す
  /// paymentCodeは未使用
  CreditInstallmentNumber? getInstallmentObj(String name, int value, int paymentCode) {
    if (value == 1) {
      var installmentStr = name.replaceAll(dividePrefix, '');
      var installmentNum = int.tryParse(installmentStr);
      if (installmentNum != null) {
        // 分割回数に対応した支払区分を取得
        int? installmentPaymentCode = installmentCodes[installmentNum];
        if (installmentPaymentCode != null) {
          return CreditInstallmentNumber(
              installmentNumber: installmentNum,
              installmentPaymentCode: installmentPaymentCode);
        }
      }
    }
    return null;
  }

  /// 分割回数の支払区分
  static const Map<int, int> installmentCodes = {
    3: RcCrdt.DIVIDE3,
    5: RcCrdt.DIVIDE5,
    6: RcCrdt.DIVIDE6,
    10: RcCrdt.DIVIDE10,
    12: RcCrdt.DIVIDE12,
    15: RcCrdt.DIVIDE15,
    18: RcCrdt.DIVIDE18,
    20: RcCrdt.DIVIDE20,
    24: RcCrdt.DIVIDE24,
    30: RcCrdt.DIVIDE30,
    36: RcCrdt.DIVIDE36,
  };

  // todo フロント・バックエンド結合後：以下メソッドを削除
  void loadTestPaymentData() {
    creditName.value = 'VISA';
    cardNumber.value = '5250-72XX-XXXX-1003';
    expiration.value = 'XX/XX';
    CreditPaymentMethod method = CreditPaymentMethod(paymentMethodName: '一括払い', paymentType: 1,
        paymentDetailTopic1: '見出し1-1', paymentDetailContent1: '内容1-1', paymentDetailTopic2: '見出し1-2', paymentDetailContent2: '内容1-2');
    paymentList.add(method);

    // todo 業務宣言画面の実装後にコメントを解除
    // RegsMem regsMem = SystemFunc.readRegsMem();
    // if (regsMem.workInType != 2) {
    bool houseDeclaration = true;
    if (!houseDeclaration) {
      method = CreditPaymentMethod(paymentMethodName: '2回払い', paymentType: 2,
          paymentDetailTopic1: '見出し2-1', paymentDetailContent1: '内容2-1', paymentDetailTopic2: '見出し2-2', paymentDetailContent2: '内容2-2');
      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: '分割払い', paymentType: 3,
          paymentDetailTopic1: '見出し3-1', paymentDetailContent1: '内容3-1', paymentDetailTopic2: '見出し3-2', paymentDetailContent2: '内容3-2',
          orgCode: RcCrdt.DIVIDE);

      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: 'ボーナス一括払い', paymentType: 4,
          paymentDetailTopic1: '見出し4-1', paymentDetailContent1: '内容4-1', paymentDetailTopic2: '見出し4-2', paymentDetailContent2: '内容4-2');
      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: 'リボ払い', paymentType: 5,
          paymentDetailTopic1: '見出し5-1', paymentDetailContent1: '内容5-1', paymentDetailTopic2: '見出し5-2', paymentDetailContent2: '内容5-2',
          orgCode: RcCrdt.RIBO);
      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: '支払い1', paymentType: 6,
          paymentDetailTopic1: '見出し6-1', paymentDetailContent1: '内容6-1', paymentDetailTopic2: '見出し6-2', paymentDetailContent2: '内容6-2');
      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: '支払い2', paymentType: 7,
          paymentDetailTopic1: '見出し7-1', paymentDetailContent1: '内容7-1', paymentDetailTopic2: '見出し7-2', paymentDetailContent2: '内容7-2');
      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: '支払い3', paymentType: 8,
          paymentDetailTopic1: '見出し8-1', paymentDetailContent1: '内容8-1', paymentDetailTopic2: '見出し8-2', paymentDetailContent2: '内容8-2');
      paymentList.add(method);
      method = CreditPaymentMethod(paymentMethodName: '支払い4', paymentType: 9,
          paymentDetailTopic1: '見出し9-1', paymentDetailContent1: '内容9-1', paymentDetailTopic2: '見出し9-2', paymentDetailContent2: '内容9-2');
      paymentList.add(method);
      // method = CreditPaymentMethod(paymentMethodName: '支払い5', paymentType: 10 );
      // paymentList.add(method);
      // method = CreditPaymentMethod(paymentMethodName: '支払い6', paymentType: 11 );
      // paymentList.add(method);
      // method = CreditPaymentMethod(paymentMethodName: '支払い7', paymentType: 12 );
      // paymentList.add(method);
      // method = CreditPaymentMethod(paymentMethodName: '支払い8', paymentType: 13 );
      // paymentList.add(method);
    }
    listFirstStageNum.value = paymentList.length > maxHorizontal ? maxHorizontal - 1 : paymentList.length - 1;
  }

}
