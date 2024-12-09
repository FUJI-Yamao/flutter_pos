/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */



import 'dart:io';

import 'package:flutter_pos/app/inc/db/c_ttllog_sts.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../regs/common/tax_util.dart';
import 'fnc_code.dart';
import 'rx_cnt_list.dart';
import '../db/c_item_log.dart';
import '../db/c_itemlog_sts.dart';
import 'rxmem_calc.dart';
/// 登録商品情報.
///
///  関連tprxソース: rxregmem.h -t_itemlog
///
class TItemLog {

  /// FNo.10000 : 登録商品情報1
  late T10000 t10000 = T10000();
  /// FNo.10001 : 登録商品情報2
  late T10001 t10001 = T10001();
  ///  FNo.10002 : 登録商品情報3
  late T10002 t10002 = T10002();
  ///  FNo.10003 : 登録商品情報4（商品登録時生成）
  late T10003 t10003 = T10003();
  T10004? t10004;
  ///  FNo.10100 : 特売
  late T10100 t10100 = T10100();
  ///  FNo.10200 : 値引
  late T10200 t10200 = T10200();
  ///  FNo.10300 : 割引
  late  T10300 t10300 = T10300();
  /// 売価変更.
  late T10400 t10400 = T10400();
  ///  FNo.10500 : 分類値下
  late T10500 t10500 = T10500();
  T10700? t10700;
  ///  FNo.10800 : ミックスマッチ
  late T10800 t10800 = T10800();
  ///  FNo.10900 : セットマッチ
  late T10900 t10900 = T10900();
  T10901? t10901;
  T10902? t10902;
  T10903? t10903;
  T10904? t10904;
  T10905? t10905;
  ///  FNo.11000 : 会員売価
  late T11000 t11000 = T11000();
  /// FNo.11100 : 顧客
  late  T11100 t11100 = T11100();
  T11101? t11101;
  ///  FNo.11200 : One to Oneプロモーション
  List<T11200?> t11200 = List.filled(CntList.loyPromItmMax, null);
  List<T11300?> t11300 = List.filled(CntList.acntMax, null);
  List<T11400?> t11400 = List.filled(CntList.stldscRegsMax, null);
  List<T11500?> t11500 = List.filled(CntList.dsckindMax, null);
  T11600? t11600;
  List<T11700?> t11700 = List.filled(CntList.promStldscMax, null);
  T11800? t11800;
  T11900? t11900;
  T12000? t12000;
  T12100? t12100;
  T12200? t12200;
  T12300? t12300;
  late T50100 t50100 = T50100();
  T50200? t50200;
  late T50300 t50300 = T50300();
  T50400? t50400;
  T50500? t50500;
  T50600? t50600;
  ///  商品登録情報１：ステータスデータ
  late T10000Sts t10000Sts = T10000Sts();
  late T10001Sts t10001Sts = T10001Sts();
  late T10002Sts t10002Sts = T10002Sts();
  /// 特売：ステータスデータ
  late T10100Sts t10100Sts = T10100Sts();
  ///  分類値下：ステータスデータ
  late T10500Sts t10500Sts = T10500Sts();
  T10700Sts? t10700Sts;
  ///  ミックスマッチ：ステータスデータ
  late T10800Sts t10800Sts = T10800Sts();
  ///  セットマッチ：ステータスデータ
  late T10900Sts t10900Sts = T10900Sts();
  T10901Sts? t10901Sts;
  T10902Sts? t10902Sts;
  T10903Sts? t10903Sts;
  T10904Sts? t10904Sts;
  T10905Sts? t10905Sts;
  /// 顧客：ステータスデータ
  late T11100Sts t11100Sts = T11100Sts();
  T11101Sts? t11101Sts;
  List<T11200Sts?> t11200Sts = List.filled(CntList.loyPromItmMax, null);
  List<T11210Sts?> t11210Sts = List.filled(CntList.loyPromItmMax, null);
  List<T11211Sts?> t11211Sts = List.filled(CntList.othPromMax, null);
  List<T11212Sts?> t11212Sts = List.filled(CntList.othPromMax, null);
  List<T11300Sts?> t11300Sts = List.filled(CntList.acntMax, null);
  T50100Sts? t50100Sts;
  T50500Sts? t50500Sts;
  T90000Sts? t90000Sts;

  late CalcItem calcData = CalcItem(); // 一時的なデータ. 実績としては残さないが印字などで使用
  int seqNo = 0;


  // ▼▼▼クラウドPOS対応▼▼▼▼▼
  /// クラウドPOSへ商品登録の結果
  late ResultItemData itemData;

  // ▲▲▲クラウドPOS対応▲▲▲▲▲


  /// アイテムの登録した番号(1始まり).
  int getSeqNo() {
    return itemData.seqNo!;
  }

  /// アイテムの価格を取得する.
  int getItemPrc() {
    // 売価変更などが含まれる.
    return itemData.price!;
  }

  /// アイテムの名前を取得する.
  String getItemName() {
    return itemData.name!;
  }

  /// アイテムの税タイプを取得する.
  int getItemTax() {
    return t10000.taxTyp;
  }
  /// アイテムの税タイプを取得する.
  double getItemTaxPer() {
    return t10000.taxPer;
  }

  /// アイテムの税タイプ/税率の文字列を取得する.
  String getItemTaxStr() {
    TaxTypeDefine define = TaxTypeDefine.getDefine(getItemTax());
    switch (define) {
      case TaxTypeDefine.excludeTax:
        return "外${getItemTaxPer()}";
      case TaxTypeDefine.includeTax:
        return "内${getItemTaxPer()}";
      case TaxTypeDefine.nonTax:
        return "非課税";
      default:
    }

    return "";
  }

  /// アイテムの個数を取得する.
  int getItemQty() {
    return itemData.qty!;
  }

  // ---訂正-------------------------
  /// 訂正済み商品
  /// 関連tprxソース:rcCorrection_Chk
  bool isDeletedItem() {
    return itemData.type == 1;
  }

  /// 訂正された種類を取得する.
  FuncKey? getDeletedKind() {
    if (t10000Sts.corrFlg) {
      // 直前訂正.
      return FuncKey.KY_CORR;
    } else if (t10002.scrvoidFlg) {
      //　指定訂正.
      return FuncKey.KY_VOID;
    }
    // 訂正されていない.
    return null;
  }

  ///　訂正を取り消せるかどうか.
  ///  訂正されていない場合はfalse
  bool isAbleCancelDeleted() {
    if (getDeletedKind() == FuncKey.KY_VOID) {
      return true;
    }
    return false;
  }

  // ---値引き値下げ売価変更------------------------
  int getPriceChangeValue(){
    return itemData.price!;
  }

  List<DiscountData>? getDiscountData(){
    return itemData.discountList;
  }

}
