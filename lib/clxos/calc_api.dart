/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../app/inc/sys/tpr_log.dart';
import '../app/lib/cm_sys/cm_cksys.dart';
import '../app/regs/checker/rc_clxos_drwcheck.dart';
import '../app/regs/checker/rcky_plu.dart';
import '../app/regs/checker/rc_clxos.dart';
import 'calc_api_data.dart';
import 'calc_api_result_data.dart';

/// クラウドＰＯＳ アプリインターフェース
class CalcApi{
  /// PROC_TYPE 無し
  static const _procNoneType           = "0";
  /// PROC_TYPE 従業員クローズ
  static const _procStaffClose         = "1";
  /// PROC_TYPE 従業員オープン
  static const _procStaffOpen          = "2";
  /// PROC_TYPE 閉設(クローズ)
  static const _procStrClose           = "3";
  /// PROC_TYPE 開設(オープン)
  static const _procStrOpen            = "4";
  /// PROC_TYPE 開設済みかチェック(オープンチェック)
  static const _procRegCheck           = "5";
  /// PROC_TYPE 計算処理
  static const _procItemCalc           = "6";
  /// PROC_TYPE 支払処理
  static const _procPaymentCalc        = "7";
  /// PROC_TYPE 支払確認
  static const _procPaymentCheckCalc   = "8";
  /// PROC_TYPE 再発行
  static const _procReprint            = "11";
  /// PROC_TYPE 領収書
  static const _procReceipt            = "12";
  /// PROC_TYPE 売価チェック(実績を残さない, 参照しない)
  static const _procPriceCheck         = "13";
  /// PROC_TYPE 取消
  static const _procCancel             = "14";
  /// PROC_TYPE 釣準備
  static const _procInoutLoan          = "21";
  /// PROC_TYPE 売上回収
  static const _procInoutPick          = "22";
  /// PROC_TYPE 差異チェック
  static const _procInoutDrwchk        = "23";
  /// PROC_TYPE 実在高セット
  static const _procActDrwSet          = "24";
  /// PROC_TYPE 入金
  static const _procChangerIn          = "25";
  /// PROC_TYPE 支払
  static const _procChangerOut         = "26";
  /// PROC_TYPE 釣機回収
  static const _procChangerPick        = "27";
  /// PROC_TYPE 釣機参照
  static const _procChangerRef         = "29";
  /// PROC_TYPE 記録一覧
  static const _procEjList             = "31";
  /// PROC_TYPE 記録表示
  static const _procEjView             = "32";
  /// PROC_TYPE 前さばき保存
  static const _procCustomerCardSave   = "41";
  /// PROC_TYPE 前さばき呼出
  static const _procCustomerCardLoad   = "42";
  /// PROC_TYPE 前さばき削除
  static const _procCustomerCardDelete = "43";
  /// PROC_TYPE 訂正確認
  static const _procVoidSearchCalc     = "51";
  /// PROC_TYPE 訂正処理
  static const _procVoidCalc           = "52";
  /// PROC_TYPE 検索領収書
  static const _procSearchReceipt      = "56";
  /// PROC_TYPE QC指定
  static const _procQcSelect           = "60";
  /// 端末保持情報 分類登録用
  static const _procMstCls             = "100";
  /// 端末保持情報 支払種別
  static const _procMstPayfnc          = "101";
  /// 端末保持情報 インストア
  static const _procMstInstre          = "102";
  /// 端末保持情報 レポート
  static const _procReportRegi         = "200";
  /// 端末保持情報 予約レポート
  static const _procBatchReport        = "202";

  /// Process.run起動でエラーが発生したのエラーコード
  static const _procErrorSts          = 99999;
  static const _procErrorMsg          = "Process error";
  static const _procResponseErrorMsg  = "Response data length is 0 bytes";

  /// クラウドPOSのパス
  static const  _webcalcPluOnly       = '/ts2100/appl/htdocs/aip/air_brain/webcalc_plu_only';
  static const  _webcalcStaffOnly     = '/ts2100/appl/htdocs/aip/air_brain/webcalc_staff_only';
  static const  _webcalcStropnclsOnly = '/ts2100/appl/htdocs/aip/air_brain/webcalc_stropncls_only';
  static const  _webcalcInoutOnly     = '/ts2100/appl/htdocs/aip/air_brain/webcalc_inout_only';
  static const  _webcalcVoidOnly      = '/ts2100/appl/htdocs/aip/air_brain/webcalc_void_only';
  static const  _webcalcSumOnly       = '/ts2100/appl/htdocs/aip/air_brain/webcalc_sum_only';
  static const  _webcalcReportOnly    = '/ts2100/appl/htdocs/aip/air_brain/webcalc_report_only';
  static const  _webcalcCalcOnly      = '/ts2100/appl/htdocs/aip/air_brain/webcalc_calc_only';
  static const  _webcalcMstGetOnly    = '/ts2100/appl/htdocs/aip/air_brain/webcalc_mst_get_only';

  /// ユーザー名
  static const  _username             = "xxx";                     // ToDo
  /// cart
  static const String _cart           = "cart";

  /// レジ開設
  /// 関連 cloudPOS phpソース:store_open_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultStore> openStore(CalcRequestStore para) async {
      CalcResultStore result = CalcResultStore(retSts: null,errMsg: null,saleDate: null,forcedClose: null);
      try {
          String paraJson = _convertFromCalcRequestStoreToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "openStore Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcStropnclsOnly, [paraJson, _username, _procStrOpen, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "openStore Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultStore.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "openStore() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// レジ精算
  /// 関連 cloudPOS phpソース:store_close_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultStore> closeStore(CalcRequestStore para) async {
      CalcResultStore result = CalcResultStore(retSts: null,errMsg: null,saleDate: null,forcedClose: null);
      try {
          String paraJson = _convertFromCalcRequestStoreToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "closeStore Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcStropnclsOnly, [paraJson, _username, _procStrClose, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "closeStore Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultStore.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "closeStore() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 従業員オープン
  /// 関連 cloudPOS phpソース:staff_open_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultStaff> openStaff(CalcRequestStaff para) async {
      CalcResultStaff result = CalcResultStaff(retSts: null,errMsg: null,posErrCd: null,staffCd: null,staffName: null,menuAuthNotCodeList: null,keyAuthNotCodeList: null);
      try {
          String paraJson = _convertFromCalcRequestStaffToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "openStaff Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcStaffOnly, [paraJson, _username, _procStaffOpen, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "openStaff Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultStaff.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "openStaff() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 従業員クローズ
  /// 関連 cloudPOS phpソース:staff_close_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultStaff> closeStaff(CalcRequestStaff para) async {
      CalcResultStaff result = CalcResultStaff(retSts: null,errMsg: null,posErrCd: null,staffCd: null,staffName: null,menuAuthNotCodeList: null,keyAuthNotCodeList: null);
      try {
          String paraJson = _convertFromCalcRequestStaffToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "closeStaff Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcStaffOnly, [paraJson, _username, _procStaffClose, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "closeStaff Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultStaff.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "closeStaff() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 商品情報の呼出
  /// 関連 cloudPOS phpソース:item_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultWithRawJson> loadItem(CalcRequestParaItem para) async {
      String rawJson = '';
      CalcResultItem result = CalcResultItem.empty();
      try {
          String paraJson = _convertFromCalcRequestParaItemToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "loadItem Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procNoneType, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "loadItem Result=${procResult.stdout}");
          rawJson = procResult.stdout;
          if( procResult.stdout.length > 0 ) {
              result = CalcResultItem.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "loadItem() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return CalcResultWithRawJson(rawJson: rawJson, result:  result);
  }

  /// 支払操作
  /// 関連 cloudPOS phpソース:payment_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> payment(CalcRequestParaPay para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaPayToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "payment Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procPaymentCalc, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "payment Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "payment() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// QC指定操作
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> qcSelect(CalcRequestParaPay para, String uuid) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaPayToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "qcSelect Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, uuid, _procQcSelect]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "qcSelect Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "qcSelect() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 支払確認
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> paymentCheck(CalcRequestParaPay para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaPayToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "paymentCheck Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procPaymentCheckCalc, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "paymentCheck Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "paymentCheck() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 訂正操作
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultVoid> payVoid(CalcRequestParaVoid para) async {
      CalcResultVoid result = CalcResultVoid(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaVoidToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "payVoid Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcVoidOnly, [paraJson, _username, _procVoidCalc, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "payVoid Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultVoid.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "payVoid() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 訂正確認
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultVoidSearch> payVoidSearch(CalcRequestParaVoidSearch para) async {
      CalcResultVoidSearch result = CalcResultVoidSearch(retSts: null,errMsg: null,posErrCd: null,serialNo: null,saleDate: null,receiptNo: null,printNo: null,macNo: null,saleAmt: null,crdtInfo: null);
      try {
          String paraJson = _convertFromCalcRequestParaVoidSearchToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "payVoidSearch Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcVoidOnly, [paraJson, _username, _procVoidSearchCalc, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "payVoidSearch Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultVoidSearch.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "payVoidSearch() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 再発行
  /// 関連 cloudPOS phpソース:reprint_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> reprint(CalcRequestParaPay para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaPayToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "reprint Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procReprint, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "reprint Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "reprint() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 領収書
  /// 関連 cloudPOS phpソース:receipt_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> receipt(CalcRequestParaPay para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaPayToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "receipt Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procReceipt, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "receipt Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "receipt() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 売価チェック
  /// 関連 cloudPOS phpソース:prc_chk_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultItem> checkPrice(CalcRequestParaItem para) async {
      CalcResultItem result = CalcResultItem.empty();
      try {
          String paraJson = _convertFromCalcRequestParaItemToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "checkPrice Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, "prc_chk", _procPriceCheck, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "checkPrice Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultItem.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "checkPrice() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 取引リセット
  /// 関連 cloudPOS phpソース:cancel_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> cancel(CalcRequestParaPay para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaPayToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "cancel Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procCancel, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "cancel Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "cancel() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 前さばき削除
  /// 関連 cloudPOS phpソース:customercard_delete_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultReturn> deleteCustomerCard(CalcRequestCustomercardDel para) async {
      CalcResultReturn result = CalcResultReturn(retSts: null,errMsg: null);
      try {
          String paraJson = _convertFromCalcRequestCustomercardDelToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "deleteCustomerCard Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, "s_and_g_customer_delete", _procCustomerCardDelete, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "deleteCustomerCard Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultReturn.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "deleteCustomerCard() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 前さばき呼出
  /// 関連 cloudPOS phpソース:customercard_load_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultCustomercard> loadCustomerCard(CalcRequestCustomercardLoad para) async {
      CalcResultCustomercard result = CalcResultCustomercard(retSts: null,errMsg: null,resultItemDataList: null,totalDataList: null,custData: null,uuid:null,staffCode:null,saveMacNo:null,saveTime:null);
      try {
          String paraJson = _convertFromCalcRequestCustomercardLoadToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "loadCustomerCard Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, "s_and_g_customer_load", _procCustomerCardLoad, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "loadCustomerCard Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultCustomercard.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "loadCustomerCard() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 前さばき保存
  /// 関連 cloudPOS phpソース:customercard_save_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultReturn> saveCustomerCard(CalcRequestCustomercardSave para) async {
      CalcResultReturn result = CalcResultReturn(retSts: null,errMsg: null);
      try {
          String paraJson = _convertFromCalcRequestCustomercardSaveToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "saveCustomerCard Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcPluOnly, [paraJson, _username, _procCustomerCardSave, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "saveCustomerCard Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultReturn.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "saveCustomerCard() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 予約レポート
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultBatchReport> batchReport(int tid, CalcRequestBatchReport para) async {
      CalcResultBatchReport result = CalcResultBatchReport(retSts: null,errMsg: null,totalData: null,digitalReceipt: null);
      Map<String, dynamic> paraMap = para.toJson();
      String paraJson = jsonEncode(paraMap);
      TprLog().logAdd(tid, LogLevelDefine.normal, "batchReport Request=$paraJson");
      ProcessResult procResult = await Process.run(_webcalcReportOnly, [paraJson, _cart, _procBatchReport]);
      TprLog().logAdd(tid, LogLevelDefine.normal, "batchReport Result=${procResult.stdout}");
      if ( procResult.stdout.length > 0 ) {
          result = CalcResultBatchReport.fromJson(jsonDecode(procResult.stdout));
      } else {
          result.retSts = _procErrorSts;
          result.errMsg = _procResponseErrorMsg;
      }
      return (result);
  }

  /// 実績集計
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultActualResults> actualResult(int tid, int compCd, int streCd) async {
      CalcResultActualResults result = CalcResultActualResults(retSts: null, errMsg: null, posErrCd: null, count: null, remain: null);
      TprLog().logAdd(tid, LogLevelDefine.normal, "actualResult compCd=$compCd streCd=$streCd");
      ProcessResult procResult = await Process.run(_webcalcSumOnly, ['$compCd', '$streCd']);
      TprLog().logAdd(tid, LogLevelDefine.normal, "actualResult Result=${procResult.stdout}");
      if (procResult.stdout.length > 0 ) {
          result = CalcResultActualResults.fromJson(jsonDecode(procResult.stdout));
      } else {
          result.retSts = _procErrorSts;
          result.errMsg = _procResponseErrorMsg;
      }
      return (result);
  }

  /// バージョン取得
  /// 関連 cloudPOS phpソース:ver_api.php
  /// Process.run起動エラーは_procErrorMsgを返す。
  static Future<String> getVersion() async {
      try {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "getVersion Request");
          ProcessResult result = await Process.run(_webcalcPluOnly, ["--version"]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "getVersion Result=${result.stdout}");
          return (result.stdout);
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "getVersion() clxos $e $s");
          return(_procErrorMsg);
      }
  }

  /// 差異チェック
  /// 関連 cloudPOS phpソース:drwchk_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultDrwchkWithRawJson> checkDrw(CalcRequestDrwchk para) async {
      String rawJson = '';
      CalcResultDrwchk result = CalcResultDrwchk(retSts: null,errMsg: null,paychkDataList: null,cashInfoData: null,chaInfoData: null,chkInfoData: null);
      try {
          String paraJson = _convertFromCalcRequestDrwchkToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "checkDrw Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procInoutDrwchk, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "checkDrw Result=${procResult.stdout}");
          rawJson = procResult.stdout;
          if( procResult.stdout.length > 0 ) {
              result = CalcResultDrwchk.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "checkDrw() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return CalcResultDrwchkWithRawJson(rawJson: rawJson, result:  result);
  }

  /// 釣準備
  /// 関連 cloudPOS phpソース:loan_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> loan(CalcRequestPick para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestPickToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "loan Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procInoutLoan, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "loan Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "loan() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 売上回収
  /// 関連 cloudPOS phpソース:pick_api.php
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultPay> pick(CalcRequestPick para) async {
      CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestPickToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "pick Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procInoutPick, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "pick Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultPay.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "pick() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 入金
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultChanger> changerIn(CalcRequestParaChanger para) async {
      CalcResultChanger result = CalcResultChanger(retSts: null,errMsg: null, digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestChangerToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerIn Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procChangerIn, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerIn Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultChanger.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "changerIn() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 支払
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultChanger> changerOut(CalcRequestParaChanger para) async {
      CalcResultChanger result = CalcResultChanger(retSts: null,errMsg: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestChangerToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerOut Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procChangerOut, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerOut Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultChanger.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "changerOut() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 釣機参照
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultChanger> changerRef(CalcRequestParaChanger para) async {
      CalcResultChanger result = CalcResultChanger(retSts: null,errMsg: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestChangerToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerRef Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procChangerRef, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerRef Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultChanger.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "changerRef() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 検索領収書
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultSearchReceipt> searchReceipt(CalcRequestParaSearchReceipt para) async {
      CalcResultSearchReceipt result = CalcResultSearchReceipt(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestParaSearchReceiptToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "searchReceipt Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcVoidOnly, [paraJson, _username, _procSearchReceipt, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "searchReceipt Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultSearchReceipt.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "searchReceipt() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 釣機回収
  /// 例外が発生した場合は_procErrorSts,_procErrorMsgの値を返す。
  static Future<CalcResultChanger> changerPick(CalcRequestParaChanger para) async {
      CalcResultChanger result = CalcResultChanger(retSts: null,errMsg: null,digitalReceipt: null);
      try {
          String paraJson = _convertFromCalcRequestChangerToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerPick Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcInoutOnly, [paraJson, _username, _procChangerPick, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "changerPick Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = CalcResultChanger.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "changerPick() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// 分類情報取得
  static Future<GetClassInfo> getClassInfoApi(GetClassInfoParaChanger para) async {
      GetClassInfo result = GetClassInfo(retSts: null, errMsg: null, lastUpdated:null, clsList: null);
      try {
          String paraJson = _convertFromGetClassInfoParaToJson(para);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "getClassInfoApi Request=$paraJson");
          ProcessResult procResult = await Process.run(_webcalcMstGetOnly, [paraJson, _username, _procMstCls, AppPath().path]);
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "getClassInfoApi Result=${procResult.stdout}");
          if( procResult.stdout.length > 0 ) {
              result = GetClassInfo.fromJson(jsonDecode(procResult.stdout));
          } else {
              result.retSts = _procErrorSts;
              result.errMsg = _procResponseErrorMsg;
          }
      } catch (e,s) {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "changerOut() clxos $e $s");
          result.retSts = _procErrorSts;
          result.errMsg = _procErrorMsg;
      }
      return (result);
  }

  /// CalcRequestStoreからJsonへ変換
  static String _convertFromCalcRequestStoreToJson(CalcRequestStore data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
          "rMacNo": data.macNo,        // マシン番号
          "rSaleDate": data.saleDate,  // 営業日
      };
      if (data.again != 0) {
          body["rAgain"] = data.again;          // 同一営業日で再度開設をする
      }
      String jsonResult = jsonEncode(body);
      return(jsonResult);
  }

  /// CalcRequestStaffからJsonへ変換
  static String _convertFromCalcRequestStaffToJson(CalcRequestStaff data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
          "rMacNo": data.macNo,        // マシン番号
          "rStaffCd": data.staffCd,    // 従業員番号
      };
      if (data.passwd.isNotEmpty) {
          body["rPasswd"] = data.passwd;        // 従業員パスワード
      }
      if (data.scanFlag != null) {
          body["rScanFlag"] = data.scanFlag;    // バーコードスキャンしたときのフラグ
      }
      if (data.checkerFlag != null) {
          body["rCheckerFlag"] = data.checkerFlag;    // チェッカーフラグ
      }
      String jsonResult = jsonEncode(body);
      return(jsonResult);
  }

  /// CalcRequestParaItemからJsonへ変換
  static String _convertFromCalcRequestParaItemToJson(CalcRequestParaItem data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
      };

      if (data.custCode.isNotEmpty) {
          body["rCustCode"] = data.custCode;        // 顧客コード
      }
      if (data.macNo != null) {
          body["rMacNo"] = data.macNo;              // マシン番号
      }
      if (data.uuid.isNotEmpty) {
          body["rUUID"] = data.uuid;                // 取引別のUUID
      }
      if (data.refundFlag != null) {
          body["rRefundFlag"] = data.refundFlag;    // 返品操作フラグ
      }
      if (data.opeMode != null) {
          body["rOpeMode"] = data.opeMode;          // オペモード
      }
      if (data.priceMode != null) {
          body["rPriceMode"] = data.priceMode;      // 価格セットモード
      }
      if (data.posSpec != null) {
          body["rPosSpec"] = data.posSpec;      // POS動作仕様
      }

      String jsonResult = jsonEncode(body);

      // 商品情報リストをJsonに変換
      String dataJsonItemListString = "";
      if( data.itemList.isNotEmpty ) {
          dataJsonItemListString = _convertFromItemListToJson(data.itemList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rItemList" : ' + dataJsonItemListString + '}';
      }
      // 小計値下情報をJsonに変換
      String dataJsonSubttlListString = "";
      if( data.subttlList.isNotEmpty ) {
          dataJsonSubttlListString = _convertFromSubttlListToJson(data.subttlList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rSubttlList" : ' + dataJsonSubttlListString + '}';
      }


      // ユーザ別情報をJsonに変換
      String dataJsonArcsInfoString = "";
      if( data.arcsInfo != null ) {
          dataJsonArcsInfoString = _convertFromArcsInfoToJson(data.arcsInfo!);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rArcsInfo" : ' + dataJsonArcsInfoString + '}';
      }
      return(jsonResult);
  }

  /// CalcRequestParaPayからJsonへ変換
  static String _convertFromCalcRequestParaPayToJson(CalcRequestParaPay data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,         // 企業コード
          "rStreCd": data.streCd,         // 店舗コード
      };

      if (data.custCode.isNotEmpty) {
          body["rCustCode"] = data.custCode;        // 顧客コード
      }
      if (data.macNo != null) {
          body["rMacNo"] = data.macNo;              // マシン番号
      }
      if (data.uuid.isNotEmpty) {
          body["rUUID"] = data.uuid;                // 取引別のUUID
      }
      if (data.opeMode != null) {
          body["rOpeMode"] = data.opeMode;          // オペモード
      }
      if (data.refundFlag != null) {
          body["rRefundFlag"] = data.refundFlag;    // 返品操作フラグ
      }
      if (data.refundDate.isNotEmpty) {
          body["rRefundDate"] = data.refundDate;    // 返品操作日（YYYY-MM-DD）
      }
      if (data.priceMode != null) {
          body["rPriceMode"] = data.priceMode;      // 価格セットモード
      }
      if (data.posSpec != null) {
          body["rPosSpec"] = data.posSpec;      // POS動作仕様
      }
      if (data.qcSendMacNo != null) {
          body["rQCSendMacNo"] = data.qcSendMacNo;      // 送信先レジ番号
      }
      if (data.qcSendMacName != null) {
          body["rQCSendMacName"] = data.qcSendMacName;      // 送信先レジ名称
      }

      String jsonResult = jsonEncode(body);

      // 商品情報リストをJsonに変換
      String dataJsonItemListString = "";
      if( data.itemList.isNotEmpty ) {
          dataJsonItemListString = _convertFromItemListToJson(data.itemList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rItemList" : ' + dataJsonItemListString + '}';
      }
      // 小計値下情報をJsonに変換
      String dataJsonSubttlListString = "";
      if( data.subttlList.isNotEmpty ) {
          dataJsonSubttlListString = _convertFromSubttlListToJson(data.subttlList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rSubttlList" : ' + dataJsonSubttlListString + '}';
      }
      // 支払情報リストをJsonに変換
      String dataJsonPayListString = "";
      if( data.payList.isNotEmpty ) {
          dataJsonPayListString = _convertFromPayListToJson(data.payList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rPayList" : ' + dataJsonPayListString + '}';
      }


      // ユーザ別情報をJsonに変換
      String dataJsonArcsInfoString = "";
      if( data.arcsInfo != null ) {
          dataJsonArcsInfoString = _convertFromArcsInfoToJson(data.arcsInfo!);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rArcsInfo" : ' + dataJsonArcsInfoString + '}';
      }
      return(jsonResult);
  }

  /// CalcRequestParaVoidからJsonへ変換
  static String _convertFromCalcRequestParaVoidToJson(CalcRequestParaVoid data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,               // 企業コード
          "rStreCd": data.streCd,               // 店舗コード
          "rMacNo": data.macNo,                 // マシン番号
          "rUUID": data.uuid,                   // 取引別のUUID
          "rOpeMode": data.opeMode,             // オペモード
          "rVoidMacNo": data.voidMacNo,         // 訂正レジ番号
          "rVoidSaleDate": data.voidSaleDate,   // 訂正営業日
          "rVoidReceiptNo": data.voidReceiptNo, // 訂正レシート番号
          "rVoidPrintNo": data.voidPrintNo,     // 訂正ジャーナル番号
      };
      if (data.voidPosReceiptNo != null) {
          body["rVoidPosReceiptNo"] = data.voidPosReceiptNo;      // 訂正伝票番号
      }

      String jsonResult = jsonEncode(body);

      // 支払情報リストをJsonに変換
      String dataJsonPayListString = "";
      if( data.payVoidList.isNotEmpty ) {
          dataJsonPayListString = _convertFromPayVoidListToJson(data.payVoidList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rPayList" : ' + dataJsonPayListString + '}';
      }

      return(jsonResult);
  }

  /// CalcRequestParaVoidSearchからJsonへ変換
  static String _convertFromCalcRequestParaVoidSearchToJson(CalcRequestParaVoidSearch data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,               // 企業コード
          "rStreCd": data.streCd,               // 店舗コード
          "rMacNo": data.macNo,                 // マシン番号
          "rUUID": data.uuid,                   // 取引別のUUID
          "rOpeMode": data.opeMode,             // オペモード
          "rVoidMacNo": data.voidMacNo,         // 訂正レジ番号
          "rVoidSaleDate": data.voidSaleDate,   // 訂正営業日
          "rVoidReceiptNo": data.voidReceiptNo, // 訂正レシート番号
      };
      if (data.voidPrintNo != null) {
          body["rVoidPrintNo"] = data.voidPrintNo;    // 訂正ジャーナル番号
      }
      if (data.voidAmt != null) {
          body["rVoidAmt"] = data.voidAmt;            // 訂正取引金額
      }

      String jsonResult = jsonEncode(body);

      return(jsonResult);
  }

  /// List<ItemData>からJsonへ変換
  static String _convertFromItemListToJson(List<ItemData> lstItemList){
      List<Map<String, dynamic>> jsnList = [];
      for( int i=0; i<lstItemList.length; i++) {
          Map<String, dynamic> body = {};

          body["rSeqNo"] = lstItemList[i].seqNo;              // 登録番号
          body["rQty"] = lstItemList[i].qty;                  // 登録点数
          body["rType"] = lstItemList[i].type;                // 0:通常　1:取消　2:カゴ抜け
          if (lstItemList[i].barcode1.isNotEmpty) {
              body["rBarcode1"] = lstItemList[i].barcode1;        // バーコード１段目
          }
          if (lstItemList[i].barcode2.isNotEmpty) {
              body["rBarcode2"] = lstItemList[i].barcode2;        // バーコード２段目
          }
          if (lstItemList[i].cnctTime.isNotEmpty) {
              body["rCnctTime"] = lstItemList[i].cnctTime;        // スキャン時間（YYYY-MM-DD HH:MM:SS）
          }
          if (lstItemList[i].itemDscType != null) {
              body["rItemDscType"] = lstItemList[i].itemDscType;  // 値下タイプ
          }
          if (lstItemList[i].itemDscVal != null) {
              body["rItemDscVal"] = lstItemList[i].itemDscVal;    // 値下額
          }
          if (lstItemList[i].itemDscCode != null) {
              body["rItemDscCode"] = lstItemList[i].itemDscCode;  // 値下コード
          }
          if (lstItemList[i].prcChgVal != null) {
              body["rPrcChgVal"] = lstItemList[i].prcChgVal;      // 売価変更金額
          }
          body["rClsNo"] = lstItemList[i].clsNo;              // 分類登録時のコード
          if (lstItemList[i].clsVal != null) {
              body["rClsVal"] = lstItemList[i].clsVal;            // 分類登録時の金額
          }
          if (lstItemList[i].decimalVal.isNotEmpty) {
              body["rDecimalVal"] = lstItemList[i].decimalVal;    // 小数点登録値　　小数点以下2桁まで
          }
          if (lstItemList[i].taxChgCode != null) {
              body["rTaxChgCode"] = lstItemList[i].taxChgCode;    // 税変換キーコード
          }

          jsnList.add(body);
      }
      String jsonResult = jsonEncode(jsnList);

      return(jsonResult);
  }

  /// List<SubttlData>からJsonへ変換
  static String _convertFromSubttlListToJson(List<SubttlData> lstSubttlList){
      List<Map<String, dynamic>> jsnList = [];
      for( int i=0; i<lstSubttlList.length; i++) {
          Map<String, dynamic> body = {};

          if (lstSubttlList[i].stlDscCode != null) {
              body["rStlDscCode"] = lstSubttlList[i].stlDscCode;        // 小計値下のキーコード
          }
          if (lstSubttlList[i].stlDscVal != null) {
              body["rStlDscVal"] = lstSubttlList[i].stlDscVal;          // 小計値下の値引額/割引率/割増率
          }
          jsnList.add(body);
      }
      String jsonResult = jsonEncode(jsnList);

      return(jsonResult);
  }

  /// List<PayData>からJsonへ変換
  static String _convertFromPayListToJson(List<PayData> lstPayList){
      List<Map<String, dynamic>> jsnList = [];
      for( int i=0; i<lstPayList.length; i++) {
          Map<String, dynamic> body = {};

          body["rPayCode"] = lstPayList[i].payCode;              // 支払キーコード
          body["rAmount"]  = lstPayList[i].amount;               // 支払金額
          if (lstPayList[i].sheet != null) {
              body["rSheet"] = lstPayList[i].sheet;
          }
          if (lstPayList[i].creditNo != null) {
              body['rCreditNo'] = lstPayList[i].creditNo;
          }
          if (lstPayList[i].dataDivision != null) {
              body['rDataDivision'] = lstPayList[i].dataDivision;
          }
          if (lstPayList[i].totalLevel != null) {
              body['rTotalLevel'] = lstPayList[i].totalLevel;
          }
          if (lstPayList[i].tranDivision != null) {
              body['rTranDivision'] = lstPayList[i].tranDivision;
          }
          if (lstPayList[i].divideCount != null) {
              body['rDivideCount'] = lstPayList[i].divideCount;
          }
          if (lstPayList[i].memberCode != null) {
              body['rMemberCode'] = lstPayList[i].memberCode;
          }
          if (lstPayList[i].saleyymmdd != null) {
              body['rSaleyymmdd'] = lstPayList[i].saleyymmdd;
          }
          if (lstPayList[i].saleAmount != null) {
              body['rSaleAmount'] = lstPayList[i].saleAmount;
          }
          if (lstPayList[i].recognizeNo != null) {
              body['rRecognizeNo'] = lstPayList[i].recognizeNo;
          }
          if (lstPayList[i].goodThru != null) {
              body['rGoodThru'] = lstPayList[i].goodThru;
          }
          if (lstPayList[i].posRecognizeNo != null) {
              body['rPosRecognizeNo'] = lstPayList[i].posRecognizeNo;
          }
          if (lstPayList[i].posReceiptNo != null) {
              body['rPosReceiptNo'] = lstPayList[i].posReceiptNo;
          }
          if (lstPayList[i].chaCount1 != null) {
              body['rChaCount_1'] = lstPayList[i].chaCount1;
          }
          if (lstPayList[i].chaAmount1 != null) {
              body['rChaAmount_1'] = lstPayList[i].chaAmount1;
          }
          if (lstPayList[i].chaCount2 != null) {
              body['rChaCount_2'] = lstPayList[i].chaCount2;
          }
          if (lstPayList[i].chaAmount2 != null) {
              body['rChaAmount_2'] = lstPayList[i].chaAmount2;
          }
          if (lstPayList[i].chaCount3 != null) {
              body['rChaCount_3'] = lstPayList[i].chaCount3;
          }
          if (lstPayList[i].chaAmount3 != null) {
              body['rChaAmount_3'] = lstPayList[i].chaAmount3;
          }
          if (lstPayList[i].chaCount7 != null) {
              body['rChaCount_7'] = lstPayList[i].chaCount7;
          }
          if (lstPayList[i].chaAmount7 != null) {
              body['rChaAmount_7'] = lstPayList[i].chaAmount7;
          }
          if (lstPayList[i].sellKind != null) {
              body['rSellKind'] = lstPayList[i].sellKind;
          }
          if (lstPayList[i].seqInqNo != null) {
              body['rSeqInqNo'] = lstPayList[i].seqInqNo;
          }
          if (lstPayList[i].chargeCheckNo != null) {
              body['rChangeCheckNo'] = lstPayList[i].chargeCheckNo;
          }
          if (lstPayList[i].cancelSlipNo != null) {
              body['rCancelSlipNo'] = lstPayList[i].cancelSlipNo;
          }
          if (lstPayList[i].reqCode != null) {
              body['rReqCode'] = lstPayList[i].reqCode;
          }
          if (lstPayList[i].cardJis1 != null) {
              body['rCardJis_1'] = lstPayList[i].cardJis1;
          }
          if (lstPayList[i].cardJis2 != null) {
              body['rCardJis_2'] = lstPayList[i].cardJis2;
          }
          if (lstPayList[i].handleDivide != null) {
              body['rHandleDivide'] = lstPayList[i].handleDivide;
          }
          if (lstPayList[i].payAWay != null) {
              body['rPayAWay'] = lstPayList[i].payAWay;
          }
          if (lstPayList[i].cardName != null) {
              body['rCardName'] = lstPayList[i].cardName;
          }
          jsnList.add(body);
      }
      String jsonResult = jsonEncode(jsnList);

      return(jsonResult);
  }

  /// List<PayVoidData>からJsonへ変換
  static String _convertFromPayVoidListToJson(List<PayVoidData> lstPayList){
      List<Map<String, dynamic>> jsnList = [];
      for( int i=0; i<lstPayList.length; i++) {
          Map<String, dynamic> body = {};

          if (lstPayList[i].creditNo != null) {
              body['rCreditNo'] = lstPayList[i].creditNo;
          }
          if (lstPayList[i].dataDivision != null) {
              body['rDataDivision'] = lstPayList[i].dataDivision;
          }
          if (lstPayList[i].totalLevel != null) {
              body['rTotalLevel'] = lstPayList[i].totalLevel;
          }
          if (lstPayList[i].tranDivision != null) {
              body['rTranDivision'] = lstPayList[i].tranDivision;
          }
          if (lstPayList[i].divideCount != null) {
              body['rDivideCount'] = lstPayList[i].divideCount;
          }
          if (lstPayList[i].memberCode != null) {
              body['rMemberCode'] = lstPayList[i].memberCode;
          }
          if (lstPayList[i].saleyymmdd != null) {
              body['rSaleyymmdd'] = lstPayList[i].saleyymmdd;
          }
          if (lstPayList[i].saleAmount != null) {
              body['rSaleAmount'] = lstPayList[i].saleAmount;
          }
          if (lstPayList[i].recognizeNo != null) {
              body['rRecognizeNo'] = lstPayList[i].recognizeNo;
          }
          if (lstPayList[i].goodThru != null) {
              body['rGoodThru'] = lstPayList[i].goodThru;
          }
          if (lstPayList[i].posRecognizeNo != null) {
              body['rPosRecognizeNo'] = lstPayList[i].posRecognizeNo;
          }
          if (lstPayList[i].posReceiptNo != null) {
              body['rPosReceiptNo'] = lstPayList[i].posReceiptNo;
          }
          if (lstPayList[i].chaCount1 != null) {
              body['rChaCount_1'] = lstPayList[i].chaCount1;
          }
          if (lstPayList[i].chaAmount1 != null) {
              body['rChaAmount_1'] = lstPayList[i].chaAmount1;
          }
          if (lstPayList[i].chaCount2 != null) {
              body['rChaCount_2'] = lstPayList[i].chaCount2;
          }
          if (lstPayList[i].chaAmount2 != null) {
              body['rChaAmount_2'] = lstPayList[i].chaAmount2;
          }
          if (lstPayList[i].chaCount3 != null) {
              body['rChaCount_3'] = lstPayList[i].chaCount3;
          }
          if (lstPayList[i].chaAmount3 != null) {
              body['rChaAmount_3'] = lstPayList[i].chaAmount3;
          }
          if (lstPayList[i].chaCount7 != null) {
              body['rChaCount_7'] = lstPayList[i].chaCount7;
          }
          if (lstPayList[i].chaAmount7 != null) {
              body['rChaAmount_7'] = lstPayList[i].chaAmount7;
          }
          if (lstPayList[i].sellKind != null) {
              body['rSellKind'] = lstPayList[i].sellKind;
          }
          if (lstPayList[i].seqInqNo != null) {
              body['rSeqInqNo'] = lstPayList[i].seqInqNo;
          }
          if (lstPayList[i].chargeCheckNo != null) {
              body['rChangeCheckNo'] = lstPayList[i].chargeCheckNo;
          }
          if (lstPayList[i].cancelSlipNo != null) {
              body['rCancelSlipNo'] = lstPayList[i].cancelSlipNo;
          }
          if (lstPayList[i].reqCode != null) {
              body['rReqCode'] = lstPayList[i].reqCode;
          }
          if (lstPayList[i].cardJis1 != null) {
              body['rCardJis_1'] = lstPayList[i].cardJis1;
          }
          if (lstPayList[i].cardJis2 != null) {
              body['rCardJis_2'] = lstPayList[i].cardJis2;
          }
          if (lstPayList[i].handleDivide != null) {
              body['rHandleDivide'] = lstPayList[i].handleDivide;
          }
          if (lstPayList[i].payAWay != null) {
              body['rPayAWay'] = lstPayList[i].payAWay;
          }
          if (lstPayList[i].cardName != null) {
              body['rCardName'] = lstPayList[i].cardName;
          }
          jsnList.add(body);
      }
      String jsonResult = jsonEncode(jsnList);

      return(jsonResult);
  }

  /// List<PickPayData>からJsonへ変換
  static String _convertFromPickPayListToJson(List<PickPayData> lstPayList){
      List<Map<String, dynamic>> jsnList = [];
      for( int i=0; i<lstPayList.length; i++) {
          Map<String, dynamic> body = {};

          if (lstPayList[i].code != null) {
              body["rCode"] = lstPayList[i].code;                     // 支払コード
          }
          if (lstPayList[i].pickAmount != null) {
              body["rPickAmount"] = lstPayList[i].pickAmount;         // 回収金額
          }

          jsnList.add(body);
      }
      String jsonResult = jsonEncode(jsnList);

      return(jsonResult);
  }

  /// CalcRequestCustomercardDelからJsonへ変換
  static String _convertFromCalcRequestCustomercardDelToJson(CalcRequestCustomercardDel data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,               // 企業コード
          "rStreCd": data.streCd,               // 店舗コード
          "rMacNo": data.macNo,                 // マシン番号
          "rCustomerCard": data.customerCard,   // バーコード18桁の情報
      };
      String jsonResult = jsonEncode(body);
      return(jsonResult);
  }

  /// CalcRequestCustomercardLoadからJsonへ変換
  static String _convertFromCalcRequestCustomercardLoadToJson(CalcRequestCustomercardLoad data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,               // 企業コード
          "rStreCd": data.streCd,               // 店舗コード
          "rCustomerCard": data.customerCard,   // バーコード18桁の情報
      };
      String jsonResult = jsonEncode(body);
      return(jsonResult);
  }

  /// CalcRequestCustomercardSaveからJsonへ変換
  static String _convertFromCalcRequestCustomercardSaveToJson(CalcRequestCustomercardSave data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
      };

      if (data.custCode.isNotEmpty) {
          body["rCustCode"] = data.custCode;        // 顧客コード
      }
      if (data.macNo != null) {
          body["rMacNo"] = data.macNo;              // マシン番号
      }
      if (data.uuid.isNotEmpty) {
          body["rUUID"] = data.uuid;                // 取引別のUUID
      }
      if (data.opeMode != null) {
          body["rOpeMode"] = data.opeMode;          // オペモード
      }
      if (data.customerCard.isNotEmpty) {
          body["rCustomerCard"] = data.customerCard;      // バーコード18桁の情報
      }
      String jsonResult = jsonEncode(body);

      // 商品情報リストをJsonに変換
      String dataJsonItemListString = "";
      if( data.itemList.isNotEmpty ) {
          dataJsonItemListString = _convertFromItemListToJson(data.itemList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rItemList" : ' + dataJsonItemListString + '}';
      }
      return(jsonResult);
  }

  /// CalcRequestDrwchkからJsonへ変換
  static String _convertFromCalcRequestDrwchkToJson(CalcRequestDrwchk data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
          "rMacNo": data.macNo,        // マシン番号
      };

      if (data.opeMode != null) {
          body["rOpeMode"] = data.opeMode;          // オペモード
      }
      String jsonResult = jsonEncode(body);

      // InoutInfoをJsonに変換
      String dataJsoninoutInfoString = "";
      if( data.inoutInfo != null ) {
          dataJsoninoutInfoString = _convertFromInoutInfoToJson(data.inoutInfo as InoutInfo);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rInoutInfo" : ' + dataJsoninoutInfoString + '}';
      }

      return(jsonResult);
  }

  /// CalcRequestPickからJsonへ変換
  static String _convertFromCalcRequestPickToJson(CalcRequestPick data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
          "rMacNo": data.macNo,        // マシン番号
      };

      if (data.opeMode != null) {
          body["rOpeMode"] = data.opeMode;          // オペモード
      }
      String jsonResult = jsonEncode(body);

      // InoutInfoをJsonに変換
      String dataJsoninoutInfoString = "";
      if( data.inoutInfo != null ) {
          dataJsoninoutInfoString = _convertFromInoutInfoToJson(data.inoutInfo as InoutInfo);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rInoutInfo" : ' + dataJsoninoutInfoString + '}';
      }
      // 売上回収List<PickPayData>をJsonに変換
      String dataJsonPayListString = "";
      if( data.payList.isNotEmpty ) {
          dataJsonPayListString = _convertFromPickPayListToJson(data.payList);
          jsonResult = jsonResult.substring(0, jsonResult.length - 1) + ', "rPayList" : ' + dataJsonPayListString + '}';
      }
      return(jsonResult);
  }

  /// InoutInfoからJsonへ変換
  static String _convertFromInoutInfoToJson(InoutInfo data){
      Map<String, dynamic> body = {};

      if (data.amtTotal != null) {
          body["rAmtTotal"] = data.amtTotal;      // 一括入力金額（円）
      }
      if (data.sht10000 != null) {
          body["rSht10000"] = data.sht10000;      // 金種別登録時の10000円の枚数
      }
      if (data.sht05000 != null) {
          body["rSht05000"] = data.sht05000;      // 金種別登録時の5000円の枚数
      }
      if (data.sht02000 != null) {
          body["rSht02000"] = data.sht02000;      // 金種別登録時の2000円の枚数
      }
      if (data.sht01000 != null) {
          body["rSht01000"] = data.sht01000;      // 金種別登録時の1000円の枚数
      }
      if (data.sht00500 != null) {
          body["rSht00500"] = data.sht00500;      // 金種別登録時の500円の枚数
      }
      if (data.sht00100 != null) {
          body["rSht00100"] = data.sht00100;      // 金種別登録時の100円の枚数
      }
      if (data.sht00050 != null) {
          body["rSht00050"] = data.sht00050;      // 金種別登録時の50円の枚数
      }
      if (data.sht00010 != null) {
          body["rSht00010"] = data.sht00010;      // 金種別登録時の10円の枚数
      }
      if (data.sht00005 != null) {
          body["rSht00005"] = data.sht00005;      // 金種別登録時の5円の枚数
      }
      if (data.sht00001 != null) {
          body["rSht00001"] = data.sht00001;      // 金種別登録時の1円の枚数
      }
      if (data.stockSht10000 != null) {
          body["rStockSht10000"] = data.stockSht10000; // 釣機収納庫枚数　１００００円
      }
      if (data.stockSht05000 != null) {
          body["rStockSht05000"] = data.stockSht05000; // 釣機収納庫枚数　５０００円
      }
      if (data.stockSht02000 != null) {
          body["rStockSht02000"] = data.stockSht02000; // 釣機収納庫枚数　２０００円
      }
      if (data.stockSht01000 != null) {
          body["rStockSht01000"] = data.stockSht01000; // 釣機収納庫枚数　１０００円
      }
      if (data.stockSht00500 != null) {
          body["rStockSht00500"] = data.stockSht00500; // 釣機収納庫枚数　５００円
      }
      if (data.stockSht00100 != null) {
          body["rStockSht00100"] = data.stockSht00100; // 釣機収納庫枚数　１００円
      }
      if (data.stockSht00050 != null) {
          body["rStockSht00050"] = data.stockSht00050; // 釣機収納庫枚数　５０円
      }
      if (data.stockSht00010 != null) {
          body["rStockSht00010"] = data.stockSht00010; // 釣機収納庫枚数　１０円
      }
      if (data.stockSht00005 != null) {
          body["rStockSht00005"] = data.stockSht00005; // 釣機収納庫枚数　５円
      }
      if (data.stockSht00001 != null) {
          body["rStockSht00001"] = data.stockSht00001; // 釣機収納庫枚数　１円
      }
      if (data.stockPolSht10000 != null) {
          body["rStockPolSht10000"] = data.stockPolSht10000; // 釣機金庫枚数　　１００００円
      }
      if (data.stockPolSht05000 != null) {
          body["rStockPolSht05000"] = data.stockPolSht05000; // 釣機金庫枚数　　５０００円
      }
      if (data.stockPolSht02000 != null) {
          body["rStockPolSht02000"] = data.stockPolSht02000; // 釣機金庫枚数　　２０００円
      }
      if (data.stockPolSht01000 != null) {
          body["rStockPolSht01000"] = data.stockPolSht01000; // 釣機金庫枚数　　１０００円
      }
      if (data.stockPolSht00500 != null) {
          body["rStockPolSht00500"] = data.stockPolSht00500; // 釣機金庫枚数　　５００円
      }
      if (data.stockPolSht00100 != null) {
          body["rStockPolSht00100"] = data.stockPolSht00100; // 釣機金庫枚数　　１００円
      }
      if (data.stockPolSht00050 != null) {
          body["rStockPolSht00050"] = data.stockPolSht00050; // 釣機金庫枚数　　５０円
      }
      if (data.stockPolSht00010 != null) {
          body["rStockPolSht00010"] = data.stockPolSht00010; // 釣機金庫枚数　　１０円
      }
      if (data.stockPolSht00005 != null) {
          body["rStockPolSht00005"] = data.stockPolSht00005; // 釣機金庫枚数　　５円
      }
      if (data.stockPolSht00001 != null) {
          body["rStockPolSht00001"] = data.stockPolSht00001; // 釣機金庫枚数　　１円
      }
      if (data.stockPolShtOth != null) {
          body["rStockPolShtOth"] = data.stockPolShtOth; // 釣銭機金庫枚数　その他
      }
      if (data.stockPolShtFil != null) {
          body["rStockPolShtFil"] = data.stockPolShtFil; // 釣札機回収予備枚数
      }
      if (data.stockRjct != null) {
          body["rStockRjct"] = data.stockRjct; // 釣札機収納部リジェクト回数
      }
      if (data.coinSlot != null) {
          body["rCoinSlot"] = data.coinSlot; // 釣銭機硬貨投入部情報
      }
      if (data.stockGetDate != null) {
          body["rStockGetDate"] = data.stockGetDate; // 釣機在高取得日時
      }
      if (data.stockStateErrCode != null) {
          body["rStockStateErrCode"] = data.stockStateErrCode; // 釣機在高不確定情報
      }
      if (data.drwChkPickFlg != null) {
          body["rDrwChkPickFlg"] = data.stockStateErrCode; // 差異チェック入力データ反映フラグ
      }
      if (data.closeFlg != null) {
          body["rCloseFlg"] = data.stockStateErrCode; // 従業員精算フラグ
      }
      if (data.fncCode != null) {
          body["rFncCode"] = data.fncCode; // ファンクションキーコード
      }
      if (data.divCode != null) {
          body["rDivCode"] = data.divCode; // 区分
      }
      if (data.divName != null) {
          body["rDivName"] = data.divName; // 支払理由名称
      }
      if (data.recycleNo != null) {
          body["rRecycleNo"] = data.recycleNo; // 発行番号
      }
      if (data.recycleStaffNo != null) {
          body["rRecycleStaffNo"] = data.recycleStaffNo; // 操作従業員番号
      }
      if (data.recycleOfficeTtlAmt != null) {
          body["rRecycleOfficeTtlAmt"] = data.recycleOfficeTtlAmt; // 事務所指示金額
      }
      if (data.recycleInMacNo != null) {
          body["rRecycleInMacNo"] = data.recycleInMacNo; // 入金レジ番号　　　
      }
      if (data.recycleOutMacNo != null) {
          body["rRecycleOutMacNo"] = data.recycleOutMacNo; // 出金レジ番号　　　
      }
      if (data.recycleInOutType != null) {
          body["rRecycleInOutType"] = data.recycleInOutType; // 入出金フラグ　　　　
      }
      if (data.recycleExchgFlg != null) {
          body["rRecycleExchgFlg"] = data.recycleExchgFlg; // 両替フラグ　　　　　
      }
      if (data.recycleRein != null) {
          body["rRecycleRein"] = data.recycleRein; // 再入金　　　　　　　
      }
      if (data.recycleInDiff != null) {
          body["rRecycleInDiff"] = data.recycleInDiff; // 入金差異フラグ
      }
      if (data.recycleChgOutAmt != null) {
          body["rRecycleChgOutAmt"] = data.recycleChgOutAmt; // 両替出金額
      }
      if (data.recycleTtlAmt != null) {
          body["rRecycleTtlAmt"] = data.recycleTtlAmt; // 入出金額
      }
      if (data.recycleOfficeSht10000 != null) {
          body["rRecycleOfficeSht10000"] = data.recycleOfficeSht10000; // 事務所指示10000円枚数
      }
      if (data.recycleOfficeSht05000 != null) {
          body["rRecycleOfficeSht05000"] = data.recycleOfficeSht05000; // 事務所指示5000円枚数
      }
      if (data.recycleOfficeSht02000 != null) {
          body["rRecycleOfficeSht02000"] = data.recycleOfficeSht02000; // 事務所指示2000円枚数
      }
      if (data.recycleOfficeSht01000 != null) {
          body["rRecycleOfficeSht01000"] = data.recycleOfficeSht01000; // 事務所指示1000円枚数
      }
      if (data.recycleOfficeSht00500 != null) {
          body["rRecycleOfficeSht00500"] = data.recycleOfficeSht00500; // 事務所指示500円枚数
      }
      if (data.recycleOfficeSht00100 != null) {
          body["rRecycleOfficeSht00100"] = data.recycleOfficeSht00100; // 事務所指示100円枚数
      }
      if (data.recycleOfficeSht00050 != null) {
          body["rRecycleOfficeSht00050"] = data.recycleOfficeSht00050; // 事務所指示50円枚数
      }
      if (data.recycleOfficeSht00010 != null) {
          body["rRecycleOfficeSht00010"] = data.recycleOfficeSht00010; // 事務所指示10円枚数
      }
      if (data.recycleOfficeSht00005 != null) {
          body["rRecycleOfficeSht00005"] = data.recycleOfficeSht00005; // 事務所指示5円枚数
      }
      if (data.recycleOfficeSht00001 != null) {
          body["rRecycleOfficeSht00001"] = data.recycleOfficeSht00001; // 事務所指示1円枚数
      }
      if (data.recycleSht10000 != null) {
          body["rRecycleSht10000"] = data.recycleSht10000; // 入出金10000円枚数
      }
      if (data.recycleSht05000 != null) {
          body["rRecycleSht05000"] = data.recycleSht05000; // 入出金5000円枚数
      }
      if (data.recycleSht02000 != null) {
          body["rRecycleSht02000"] = data.recycleSht02000; // 入出金2000円枚数
      }
      if (data.recycleSht01000 != null) {
          body["rRecycleSht01000"] = data.recycleSht01000; // 入出金1000円枚数
      }
      if (data.recycleSht00500 != null) {
          body["rRecycleSht00500"] = data.recycleSht00500; // 入出金500円枚数
      }
      if (data.recycleSht00100 != null) {
          body["rRecycleSht00100"] = data.recycleSht00100; // 入出金100円枚数
      }
      if (data.recycleSht00050 != null) {
          body["rRecycleSht00050"] = data.recycleSht00050; // 入出金50円枚数
      }
      if (data.recycleSht00010 != null) {
          body["rRecycleSht00010"] = data.recycleSht00010; // 入出金10円枚数
      }
      if (data.recycleSht00005 != null) {
          body["rRecycleSht00005"] = data.recycleSht00005; // 入出金5円枚数
      }
      if (data.recycleSht00001 != null) {
          body["rRecycleSht00001"] = data.recycleSht00001; // 入出金1円枚数
      }
      if (data.recycleInOutCnt != null) {
          body["rRecycleInOutCnt"] = data.recycleInOutCnt; // 入出金回数
      }

      String jsonResult = jsonEncode(body);
      return(jsonResult);
  }


  /// ArcsInfoからJsonへ変換
  static String _convertFromArcsInfoToJson(ArcsInfo data){
      Map<String, dynamic> body = {};

      if (data.custType != null) {
          body["rCustType"] = data.custType;      // 顧客状態
      }
      if (data.workType != null) {
          body["rWorkType"] = data.workType;      // 宣言状態
      }


      String jsonResult = jsonEncode(body);
      return(jsonResult);
  }

  /// CalcRequestParaChangerからJsonへ変換
  static String _convertFromCalcRequestChangerToJson(CalcRequestParaChanger data) {
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
          "rMacNo": data.macNo,        // マシン番号
      };

      if (data.opeMode != null) {
          body["rOpeMode"] = data.opeMode;          // オペモード
      }
      String jsonResult = jsonEncode(body);

      // InoutInfoをJsonに変換
      String dataJsonInOutInfoString = "";
      if( data.inoutInfo != null ) {
          dataJsonInOutInfoString = _convertFromInoutInfoToJson(data.inoutInfo as InoutInfo);
          jsonResult = '${jsonResult.substring(0, jsonResult.length - 1)}, "rInoutInfo" : $dataJsonInOutInfoString}';
      }
      return(jsonResult);
  }

  /// CalcRequestParaSearchReceiptからJsonへ変換
  static String _convertFromCalcRequestParaSearchReceiptToJson(CalcRequestParaSearchReceipt data){
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,               // 企業コード
          "rStreCd": data.streCd,               // 店舗コード
          "rMacNo": data.macNo,                 // マシン番号
          "rUUID": data.uuid,                   // 取引別のUUID
          "rOpeMode": data.opeMode,             // オペモード
          "rVoidMacNo": data.voidMacNo,         // 発行したいレジ番号
          "rVoidSaleDate": data.voidSaleDate,   // 発行したい営業日
          "rVoidReceiptNo": data.voidReceiptNo, // 発行したいレシート番号
          "rVoidPrintNo": data.voidPrintNo,     // 発行したいジャーナル番号
          "rVoidPastSet": data.voidPastSet,     // 過去テーブルセットのフラグ
      };

      String jsonResult = jsonEncode(body);

      return(jsonResult);
  }

  /// GetClassInfoParaChangerからJsonへ変換
  static String _convertFromGetClassInfoParaToJson(GetClassInfoParaChanger data) {
      Map<String, dynamic> body = {
          "rCompCd": data.compCd,      // 企業コード
          "rStreCd": data.streCd,      // 店舗コード
          "rMacNo": data.macNo,        // マシン番号
          "rLastUpdated": data.lastUpdated,   // 前回更新日時（YYYY/MM/DD HH:MM:SS）
      };

      return jsonEncode(body);
  }
}















