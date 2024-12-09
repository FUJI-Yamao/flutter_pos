/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rx_cnt_list.dart';
import '../db/c_ttllog.dart';
import '../db/c_ttllog_sts.dart';

/// rxmemcalc.h

/// 売価変更の種類
enum PointType {
  pnttypeNon(-1), // -1:対象ポイントなし
  pnttypeHousepoint(0), // 0:自社ポイント
  pnttypeRpoint(1), // 1:楽天ポイント
  pnttypeTpoint(2), // 2:tポイント
  pnttypeDpoint(3); // 3:dポイント

  final int id;
  const PointType(this.id);
  static int get pnttypeMax => PointType.values.last.id + 1;
}

///  一時的なデータ. 実績としては残さないが印字などには用いる
class CalcItem {
  int validFlg = 0; // 常に0
  int nomiPrc = 0; // 利用乗算売値  uuse_prc * item_ttl_qty
  int uuseMulPrc = 0; // 通常乗算売値  u_prc * item_ttl_qty
  int uactPrc = 0; // 基本売価  uuse_prc - item_udsc_prc - ucls_dsc_amt
  int exInTaxAmt = 0; // 単品理論税 (単品理論外税 + 内税)
  int clsMultdscAmt = 0; // 複数売価一括値下額
  int uclsMulsprc = 0; // 複数売価 ランクS 分類一括売価
  int uclsMulaprc = 0; // 複数売価 ランクA 分類一括売価
  int uclsMulbprc = 0; // 複数売価 ランクB 分類一括売価
  int uclsMulcprc = 0; // 複数売価 ランクC 分類一括売価
  int uclsMuldprc = 0; // 複数売価 ランクD 分類一括売価
  int umulclsDscAmt = 0; // 複数値下一括値下額
  int mulclsDscFlg = 0; // 複数売価フラグ  0:通常商品  1:一括値引  2:一括割引  3:一括売価  4:一括売価値引
  int erefSelrecno = 0; // 検索返品選択商品No.
  int rbtBasicAmt = 0; // 基本ポイント対象金額(商品)
  int itemTtlStlPdamt = 0; // 小計値下案分合計金額
  int itemStlpdscAmt = 0; // 小計割引案分合計金額
}

class TaxFreeBkData {
  int saleAmtBk = 0; // 合計額backup
  int qtyBk = 0; // 商品点数バックアップ
  int conAmtBk = 0; // 消耗品対象額バックアップ
  int genAmtBk = 0; // 一般品対象額バックアップ
  int mbrStsBk = 0;	// 会員登録　0：未登録　1：登録
}

class CalcTtl {
  int stlTaxOutAmt = 0;
  int stlTaxAmt = 0;
  int suspendFlg = 0; //  suspend flag
  int simpleTtlAmt = 0; //  simple total amount
  int btlSaleAmt = 0; //  bottle/out of mdlcls sale amount
  int stldscBaseAmt = 0; //  subtotal discount base amount
  int stldscRestAmt = 0; //  subtotal discount rest amount
  int stlIntaxInAmt = 0; //  subtotal amount(in intax & in out mdlcls amount)
  int crdtCnt1 = 0; //  credit1 count
  int crdtAmt1 = 0; //  credit1 amount
  int crdtCnt2 = 0; //  credit2 count
  int crdtAmt2 = 0; //  credit2 amount
  int noTaxQty = 0; //  no tax item quantity
  int noTaxAmt = 0; //  no tax item amount
  int exTaxblQty = 0; //  extax taxable quantity
  int exTaxbl = 0; //  extax taxable
  int exTaxItemAmt = 0; //  item extax amount
  int inTaxblQty = 0; //  intax taxable quantity
  int inTaxbl = 0; //  intax taxable
  int inTaxItemAmt = 0; //  item intax amount
  int dscpdscQty = 0; //  discount/percent discount count
  int dscpdscAmt = 0; //  discount/percent discount amount
  int stldscpdscCnt = 0; //  subtotal discount/percent discount count
  int stldscpdscAmt = 0; //  subtotal discount/percent discount amount
  int stldscAmt = 0; //  subtotal discount amount 1-5
  int stldscAmt1 = 0; //  subtotal discount amount1
  int stldscAmt2 = 0; //  subtotal discount amount2
  int stldscAmt3 = 0; //  subtotal discount amount3
  int stldscAmt4 = 0; //  subtotal discount amount4
  int stldscAmt5 = 0; //  subtotal discount amount5
  int stlpdscCnt = 0; //  subtotal percent discount count 1-5
  int stlpdscAmt = 0; //  subtotal percent discount amount 1-5
  int stlpdscCnt1 = 0; //  subtotal percent discount count1
  int stlpdscAmt1 = 0; //  subtotal percent discount amount1
  int stlpdscCnt2 = 0; //  subtotal percent discount count2
  int stlpdscAmt2 = 0; //  subtotal percent discount amount2
  int stlpdscCnt3 = 0; //  subtotal percent discount count3
  int stlpdscAmt3 = 0; //  subtotal percent discount amount3
  int stlpdscCnt4 = 0; //  subtotal percent discount count4
  int stlpdscAmt4 = 0; //  subtotal percent discount amount4
  int stlpdscCnt5 = 0; //  subtotal percent discount count5
  int stlpdscAmt5 = 0; //  subtotal percent discount amount5
  int stlpdscFnccd = 0; //  利用小計割引コード
  int stlpdscItmcd = 0; //  利用小計割引アイテムレコード
  int bdlDscAmt = 0; //  bundle discount amount
  int stmDscAmt = 0; //  setmatch discount amount
  int mvoidCnt = 0; //  void mode count
  int mvoidAmt = 0; //  void mode amount
  int mvoidCrdtCnt = 0; //  void mode credit count
  int mvoidCrdtAmt = 0; //  void mode credit amount
  int mvoidDebitCnt = 0; //  void mode debit count
  int mvoidDebitAmt = 0; //  void mode debit amount
  int mscrapCnt = 0; //  scrap mode count
  int mscrapAmt = 0; //  scrap mode amount
  int mtriningCnt = 0; //  training mode count
  int mtriningAmt = 0; //  training mode amount
  int mtriningCrdtCnt = 0; //  training mode credit count
  int mtriningCrdtAmt = 0; //  training mode credit amount
  int mtriningDebitCnt = 0; //  training mode debit count
  int mtriningDebitAmt = 0; //  training mode debit amount
  String tMsppointPrn = ""; //  possible ms point print
  int mbrStlpdscPer = 0; //  member stl percent discount percent
  int dsalTtlpur = 0; //  today sale total purchas(bottle return out/tax out)
  int dwotTtlpur = 0; //  today sale total purchas(bottle return in/tax out)
  int nsalTtlpur = 0; //  no sales amount
  int nsaqTtlpur = 0; //  no sales qty
  int tpptTtlsrv = 0; //  term ms possible point total
  int lpptTtlsrv = 0; //  last ms possible point total
  int duppTtlrv = 0; //  today ms use possible point total
  int nextTtlsrv = 0; //  next ms service point
  int dqtyFsppur = 0; //  today sale qty of fsp member only
  int damtFsppur = 0; //  today sale amount of fsp member only
  int dperFsppdsc = 0; //  today of fsp stl percent discount
  int dqtyFsppdsc = 0; //  today stl percent discounnt qty for fsp
  int dpurFsppdsc = 0; //  today stl percent discounnt purchas for fsp
  int daddFsppnt = 0; //  poinnt add for fsp
  int dtdqMulcls = 0; //  class mulltiple total discount quantity
  int dtdaMulcls = 0; //  class mulltiple total discount amount
  int ddsqMulcls = 0; //  class mulltiple discount quantity
  int ddsaMulcls = 0; //  class mulltiple discount amount
  int dpdqMulcls = 0; //  class mulltiple percent discount quantity
  int dpdaMulcls = 0; //  class mulltiple percent discount amount
  int dsdqMulcls = 0; //  class mulltiple same discount quantity
  int dsdaMulcls = 0; //  class mulltiple same discount amount
  int dspqMulcls = 0; //  class mulltiple same quantity
  int dctrbPoint = 0; //  today contribution point
  int tctrbPoint = 0; //  term contribution point
  int refundLogFlg = 0; //  refund electric log flag 0:normal 1:refund
  int pluPointTtl = 0; //  plu point total
  int stampCustTyp1 = 0; //  stamp cust 1
  int stampPointTyp1 = 0; //  stamp point 1
  int stampCustTyp2 = 0; //  stamp cust 2
  int stampPointTyp2 = 0; //  stamp point 2
  int stampCustTyp3 = 0; //  stamp cust 3
  int stampPointTyp3 = 0; //  stamp point 3
  int stampCustTyp4 = 0; //  stamp cust 4
  int stampPointTyp4 = 0; //  stamp point 4
  int stampCustTyp5 = 0; //  stamp cust 5
  int stampPointTyp5 = 0; //  stamp point 5
  int mbrDiscAmt = 0; //  member birthday price amount
  int mstmDscAmt = 0; //  member setmatch discount amount
  int mbdlDscAmt = 0; //  member mixmatch discount amount
  int stampShopPnt = 0; //  stamp shopinng point
  int mnyTtl = 0; //  money total
  int mnyTodayAmt = 0; //  money today amount
  int mnyTcktCnt1 = 0; //  money ticket count 1
  int mnyTcktAmt1 = 0; //  money ticket amount 1
  int mnyTcktCnt2 = 0; //  money ticket count 1
  int mnyTcktAmt2 = 0; //  money ticket amount 1
  int mnyTcktCnt3 = 0; //  money ticket count 1
  int mnyTcktAmt3 = 0; //  money ticket amount 1
  int promStlpdscPer = 0; //  promotion subtotal discount percent
  int promStldscCnt = 0; //  promotion subtotal discount count
  int promStldscAmt = 0; //  promotion subtotal discount amount
  int promStlpdscCnt = 0; //  promotion subtotal percent discount count
  int promStlpdscAmt = 0; //  promotion subtotal percent discount amount
  int pluPointQty = 0; //  plu point add quantity
  int pluPointAmt = 0; //  plu point add amount
  int stlplusBaseAmt = 0; //  subtotal percent plus base amount
  int stlplusRestAmt = 0; //  subtotal percent plus rest amount
  int stlplusCnt1 = 0; //  subtotal percent plus count1
  int stlplusCnt2 = 0; //  subtotal percent plus count2
  int stlplusCnt3 = 0; //  subtotal percent plus count3
  int stlplusCnt4 = 0; //  subtotal percent plus count4
  int stlplusCnt5 = 0; //  subtotal percent plus count5
  int stlplusAmt = 0; //  subtotal percent plus amount
  int stlplusAmt1 = 0; //  subtotal percent plus amount1
  int stlplusAmt2 = 0; //  subtotal percent plus amount2
  int stlplusAmt3 = 0; //  subtotal percent plus amount3
  int stlplusAmt4 = 0; //  subtotal percent plus amount4
  int stlplusAmt5 = 0; //  subtotal percent plus amount5
  int cardRetCashCnt = 0; //  Card Cash Return Count
  int cardRetCashAmt = 0; //  Card Cash Return Amount
  int cardDepositCnt = 0; //  Card One Time Deposit Count
  int cardDepositAmt = 0; //  Card One Time Deposit Amount
  int card1timeCnt = 0; //  Card One Time Count
  int card1timeAmt = 0; //  Card One Time Amount
  int memMulprcKnd = 0; //
  //          the selection of member multiple price
  //          0:no
  //       1:price
  //      2:class lump
  //
  int nmStlpdscPer = 0; //  no member subtotal pdiscount percent
  int nmStlpdscAmt = 0; //  no member subtotal pdiscount amount
  int nmStlpdscCnt = 0; //  no member subtotal pdiscount count
  int tNetslAmt = 0; //  temporary net sale amount
  int tIntaxItemAmt = 0; //  temporary intax item amount
  int dIntaxAmt = 0; //  temporary different intax amount
  int sspsICust = 0; //  ssps ticket issue cust
  int sspsUCust = 0; //  ssps ticket use cust
  int otherStCust = 0; //  other store member cust
  int otherStAmt = 0; //  other store member amount
  int otherStQty = 0; //  other store member quantity
  int bgPchgAmt = 0; //  bargain price change amount
  int bgPchgQty = 0; //  bargain price change quantity
  int mbgPchgAmt = 0; //  member bargain price change amount
  int mbgPchgQty = 0; //  member bargain price change quantity
  List<int> basicPnt =
      List.filled(PointType.pnttypeMax, 0); // 基本ポイント(倍率計算前のポイント)
  List<int> basicPntamt = List.filled(PointType.pnttypeMax, 0); // 基本ポイント対象金額

  int magnPnt = 0; // 倍率ポイント(下限倍率計算前のポイント - 基本ポイント)
  int magnLvlPnt = 0; // 下限倍率ポイント(下限倍率計算後のポイント - 下限倍率計算前のポイント)
  int lastVisitFlg = 0; // 最終来店日付が1ヶ月以上前だった場合は 1. それ以外は 0.
  int latestMonthAmt = 0; // 直近の月の購入金額
  int ttlStldscAmt = 0; // 各小計値下の合計額
  String prgValue1 = ""; //  program setting value1
  List<int> stldscRestTaxSeparate =
      List.filled(CntList.taxMax, 0); //  subtotal discount rest amount
  List<T100100?> t100100 = List.filled(CntList.sptendMax, null);
  List<T100100Sts?> t100100Sts = List.filled(CntList.sptendMax, null);

  List<T100102?> t100102 = List.filled(CntList.sptendMax, null);

  TaxFreeBkData? taxfreeBk; // 免税バックアップデータ
  int stlpdscRestAmt = 0; //  subtotal discount rest amount
//	int	stlrbtdscBaseAmt = 0;	//  subtotal rebate discount base amount
  int stlrbtdscRestAmt = 0; //  subtotal rebate discount rest amount
  List<int> stlrbtdscRestTaxSeparate =
      List.filled(CntList.taxMax, 0); //  subtotal rebate discount rest amount
  int magnPntAcct = 0; // 倍率ポイントアカウント

  /// ディープコピー用関数
  /// 一部のみ実装
  CalcTtl copyWith() {
    CalcTtl calcTtl = CalcTtl();
    calcTtl.suspendFlg = suspendFlg; //  suspend flag
    calcTtl.crdtAmt1 = crdtAmt1; //  credit1 amount
    return calcTtl;
  }
}

// 対象ポイントカードタイプ
class POINT_TYPE{
  static const int PNTTYPE_NON = -1;	       // -1:対象ポイントなし
  static const int PNTTYPE_HOUSEPOINT = 0;   // 0:自社ポイント
  static const int PNTTYPE_RPOINT = 1;		   // 1:楽天ポイント
  static const int PNTTYPE_TPOINT = 2;		   // 2:Tポイント
  static const int PNTTYPE_DPOINT = 3;		   // 3:dポイント

  int PNTTYPE_MAX = 0;		// 最大値
}
