/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/inc/apl/rx_cnt_list.dart';

///関連tprxソース:rxmemtax.h - 税率別税情報メモリ
class RxMemTax {
  InvTaxDataParam invTaxDataParam = InvTaxDataParam();
  InvTaxDataPRN invTaxDataPRN = InvTaxDataPRN();
}
class InvTaxDataParam {
  int blAmt = 0;      // 対象額
  int amt = 0;        // 税額
  int typ = 0;        // 税種(外/内/非)
  double per = 0;     // 税率
  bool odd = false;   // 端数
}
class InvTaxDataPRN {
  String prnTitle = "";     // タイトル
  List<String> prnLine = List.filled(CntList.taxMax, "");     // 対象額
  List<String> prnLineTax = List.filled(CntList.taxMax, "");  // 税額
  int dataLine = 0;
}

/* 税データタイプ */
enum InvTaxKind {
  INV_TAXPER(0),          /*税率（トータル）*/
  INV_TAX_BU(1),          /*課税		*/
  INV_TAXEX_BU(2),        /*免税事業者	*/
  INV_TAX_AFT_DSCPNT(3),  /*ポイント値引後*/
  INV_TAX_MAX(4);

  final int value;
  const InvTaxKind(this.value);
}