/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../enum/e_input_enum.dart';
import '../../../../inc/sys/tpr_log.dart';

///通番訂正スキャン画面コントローラー（仮）
class ReceiptScanController extends GetxController {
  ///現在の支払方法
  var currentPaymentType = PaymentType.cash.obs;

  /// 共通のラベル
  final List<ReceiptVoidInputFieldLabel> _commonLabels = [
    ReceiptVoidInputFieldLabel.businessDay,
    ReceiptVoidInputFieldLabel.registerNum,
    ReceiptVoidInputFieldLabel.receiptNum,
    ReceiptVoidInputFieldLabel.totalAmount,
  ];

  ///クレジット特有のラベル
  final List<ReceiptVoidInputFieldLabel> _creditCardExtraLabels = [
    ReceiptVoidInputFieldLabel.slipNum,
    ReceiptVoidInputFieldLabel.cardNum,
  ];

  ///クイックペイ特有のラベル
  final List<ReceiptVoidInputFieldLabel> _quicPayExtraLabels = [
    ReceiptVoidInputFieldLabel.slipNum,
  ];

  ///　支払方法を設定
  List<ReceiptVoidInputFieldLabel> onPaymentType(PaymentType type) {
    switch (type) {
      case PaymentType.cash:
        return _commonLabels;
      case PaymentType.creditCard:
        return [..._commonLabels, ..._creditCardExtraLabels];
      case PaymentType.quicPay:
        return [..._commonLabels, ..._quicPayExtraLabels];
      default:
        throw UnimplementedError("Payment type $type is not supported");
    }
  }

  ///todo スキャン後処理
  /// スキャン後処理
  void onScanCompleted(String scanResult) {
  }

}
