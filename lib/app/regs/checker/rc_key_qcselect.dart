/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_atct.dart';

/// 関連tprxソース:rcky_qcselect.c
class RcKyQcSelect {
  /// 関連tprxソース:rcky_qcselect.c - rcKy_QcSelect()
  static void rcKyQcSelect(){
    // TODO: QC指定が押されたときの処理.画面によって機能が変わったり特定の画面だけ動かす場合は画面分岐を入れること
    debugPrint("call rcKyQcSelect");
  }


  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_qcselect.c - rcCall_Sus_Ajs_Emoney()
  static void rcCallSusAjsEmoney(int sfncCode) {
    return ;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// お釣りありの品券や会計キーで締めた時にQC指定キーを画面に表示するか確認する関数
  /// 関連tprxソース:rcky_qcselect.c - rcChkChoiceQcSlct()
  /// 引数：なし
  /// 戻値：true:表示する  false:表示しない
  static  bool rcChkChoiceQcSlct(){
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// お釣りありの場合に指定キーを選択させる画面
  /// 関連tprxソース:rcky_qcselect.c - rcDispChoiceQcSlct( TEND_TYPE eTendType )
  /// 引数：TendType eTendType
  ///       (TendTypeは基本的にTEND_TYPE_NO_ENTRY_DATA or TEND_TYPE_TEND_AMOUNT)
  /// 戻値：true:表示する  false:表示しない
  static void rcDispChoiceQcSlct(TendType eTendType){
    return;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 取引終了時に動作する関数
  /// 関連tprxソース:rcky_qcselect.c - rcCreateTranBkupFile( int createType )
  static void rcCreateTranBkupFile(int createType){}

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcky_qcselect.c - rc_ScanDlg_Show2()
  static int rcScanDlgShow2(String callFunc, int waitFlg) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_qcselect.c - rcQC_Auto_Call_Preca()
  static int rcQCAutoCallPreca(int receiptNo, int macNo) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_qcselect.c - rcQC_Auto_Call_TRK_Preca()
  static int rcQCAutoCallTRKPreca(int receiptNo, int macNo) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_qcselect.c - rcQC_Auto_Call_Repica()
  static int rcQCAutoCallRepica(int receiptNo, int macNo) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_qcselect.c - rcQC_Auto_Call_Cogca()
  static int rcQCAutoCallCogca(int receiptNo, int macNo) {
    return 0;
  }

  // 実装は必要だがARKS対応では除外
  ///関連tprxソース:rcky_qcselect.c - rcQC_Auto_Call_ValueCard()
  static int rcQCAutoCallValueCard(int receiptNo, int macNo) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_qcselect.c - rcQC_Auto_Call_Ajs_Emoney()
  static int rcQCAutoCallAjsEmoney(int receiptNo, int macNo) {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  ///関連tprxソース:rcky_qcselect.c - rcChkQcSlctExpand()
  static int rcChkQcSlctExpand() {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  ///関連tprxソース:rcky_qcselect.c - QcSel_ExpandShow()
  static void qcSelExpandShow() {
    return ;
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース:rcky_qcselect.c - rcClearStlPopUpQcSelect
  static void	rcClearStlPopUpQcSelect() {
  }
}