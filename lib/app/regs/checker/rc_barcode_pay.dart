/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_barcode_pay.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_crdt.dart';

class RcBarcodePay {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_barcode_pay.c - rcChk_Barcode_Pay_Deposit_Item()
  static int rcChkBarcodePayDepositItem(int flg) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_barcode_pay.c - rcKy_Barcode_Pay_In()
  static void rcKyBarcodePayIn() {
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_barcode_pay.c - rcKy_Barcode_Pay_Deposit()
  static void rcKyBarcodePayDeposit() {
    return ;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C rc_barcode_pay.c - rcChk_Barcode_Pay_KeyOpt(short fnc_code)
  static int rcChkBarcodePayKeyOpt(int fncCode){
    return 0;
  }

  /// 機能概要     : クレジット実績の実績タイプがバーコード決済であればtypeをreturn
  /// 呼び出し方法 : #include
  ///              : rcChk_Barcode_Pay_Actual_TranType();
  /// パラメータ   : long tran_type
  /// 戻り値       : バーコード決済の種類
  /// /// 関連tprxソース:C rc_barcode_pay.c - rcChk_Barcode_Pay_Actual_TranType
  static Future<int> rcChkBarcodePayActualTranType(int tranType) async {
    if(await RcSysChk.rcChkOnepaySystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_ALIPAY.cd){
      return(BCDPAY_TYPE.BCDPAY_TYPE_ALIPAY.id);
    }
    if(await RcSysChk.rcChkLinePaySystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_LINEPAY.cd){
      return(BCDPAY_TYPE.BCDPAY_TYPE_LINEPAY.id);
    }
    if(await RcSysChk.rcChkOnepaySystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_WECHATPAY.cd){
      return(BCDPAY_TYPE.BCDPAY_TYPE_WECHATPAY.id);
    }
    if(await RcSysChk.rcChkBarcodePay1System()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_BARCODE_PAY1.cd){
      return (BCDPAY_TYPE.BCDPAY_TYPE_BARCODE_PAY1.id);
    }
    if(await RcSysChk.rcChkCANALPaymentServiceSystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_CANAL_PAY.cd){
      return (BCDPAY_TYPE.BCDPAY_TYPE_CANALPAY.id);
    }
    if(await RcSysChk.rcChkFujitsuFIPCodepaySystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_FIP_CODEPAY.cd){
      return (BCDPAY_TYPE.BCDPAY_TYPE_FIP.id);
    }
    if(await RcSysChk.rcChkMultiOnepaySystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_MULTIONEPAY.cd){
      return(BCDPAY_TYPE.BCDPAY_TYPE_MULTIONEPAY.id);
    }
    if(await RcSysChk.rcChkNetstarsCodepaySystem()
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_NETSTARS.cd){
      return(BCDPAY_TYPE.BCDPAY_TYPE_NETSTARS.id);
    }
    if(await RcSysChk.rcsyschkQuizCodepaySystem() != 0
        && tranType == CrdtTranType.CRDT_TRAN_TYPE_QUIZ.cd){
      return (BCDPAY_TYPE.BCDPAY_TYPE_QUIZ.id);
    }
    return 0;
  }

  /// 機能概要     : 取引タイプがOnepay仕様のものかチェック
  /// パラメータ   : int payType
  /// 戻り値       : OK,NG
  /// 関連tprxソース:C rc_barcode_pay.c - rcChk_Barcode_Pay_Trans_Onepay
  static Future<int> rcChkBarcodePayTransOnepay(int payType) async {
    if (payType == BCDPAY_TYPE.BCDPAY_TYPE_ALIPAY.id) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_ALIPAY.id);
    }
    if (payType == BCDPAY_TYPE.BCDPAY_TYPE_WECHATPAY.id) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_WECHATPAY.id);
    }
    if (await RcSysChk.rcChkMultiOnepaySystem()) {
      if (payType == BCDPAY_TYPE.BCDPAY_TYPE_MULTIONEPAY.id) {
        return (BCDPAY_TYPE.BCDPAY_TYPE_MULTIONEPAY.id);
      }
    }
    return (0);
  }

  /// 機能概要     : チャージ用の小分類番号の取得（及びチェック）
  /// パラメータ   : int payType (BCDPAY_TYPE_ALIPAY:LINEPayのみ, BCDPAY_TYPE_ALL:すべてチェック)
  /// 戻り値       : パラメータの小分類番号と一致していたら、その小分類番号を返す
  /// 関連tprxソース:C rc_barcode_pay.c - rcChk_Barcode_Pay_Deposit_Smlcls_Code
  static Future<int> rcChkBarcodePayDepositSmlclsCode(int payType,
      int code) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "PLU rxMemRead error");
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((await rcChkBarcodePayTransOnepay(payType) != 0)
        && (await rcChkBarcodePayTransOnepay(mem.bcdpay.txData.payType) !=
            BCDPAY_TYPE.BCDPAY_TYPE_MULTIONEPAY.id)) {
      if ((cBuf.dbTrm.outSmlclsNum7 != 0) &&
          (cBuf.dbTrm.outSmlclsNum7 == code)) {
        return (cBuf.dbTrm.outSmlclsNum7);
      }
    }
    return (0);
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C rc_barcode_pay.c - rcBarcode_Pay_Fresta_ConfDsp
  static void rcBarcodePayFrestaConfDsp(){}

}