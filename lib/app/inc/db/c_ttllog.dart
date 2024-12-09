/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../lib/mcd.dart';

///  MEMO:validFlg short->bool
/// 関連tprxソース:c_ttllog.h

///  FNo.1000 : 従業員
class T1000 {
  bool validFlg = false;
  String cshrName = "";
  String chkrName = '';
  String stf13BcdFlg = "";
  String qcReadQrCshrNo = "";
  int scanTime = 0;
  int kyinTime = 0;
  int chkoutTime = 0;
  int cshrStopTime = 0;
  int chkrScanTime = 0;
  int chkrKyinTime = 0;
  int chkrChkoutTime = 0;
  int chkrStopTime = 0;
  int workTime = 0;
  int chkrWorkTime = 0;
  int opnclsTyp = 0;
  int attendTime = 0;
  String opnTime = "";
  String clsTime = "";
  String chkrOpnTime = "";
  String chkrClsTime = "";
}

///  FNo.100001 : 合計１
class T100001 {
  bool validFlg = false;
  String cardNo = "";
  String mobilePosNo = "";
  String wizNo = "";
  String qcReadQrCshrName = "";
  String reservNo = "";
  int saleAmt = 0;
  int grsslAmt = 0;
  int netslAmt = 0;
  int cust = 0;
  int peopleCnt = 0;
  int qty = 0;
  int wgt = 0;
  double prfAmt = 0;
  int manSht = 0;
  int cancelCnt = 0;
  int cancelAmt = 0;
  int selfgateAmt = 0;
  int selfgateCust = 0;
  int selfgateQty = 0;
  int receiptGpSht = 0;
  int receiptGpAmt = 0;
  int receiptGpRank = 0;
  int creditSaleNo = 0;
  int periodDscAmt = 0;
  int bcUseSht = 0;
  int visitCnt = 0;
  int chgAmt = 0;
  int stlTaxInAmt = 0;

  int stldscBfrAmt = 0;
  String lastChgPayout = "";
  String validDate = "";
  String orgTranDate = "";

  /// ディープコピー用関数
  T100001 copyWith() {
    T100001 t100001 = T100001();
    t100001.validFlg = validFlg;
    t100001.cardNo = cardNo;
    t100001.mobilePosNo = mobilePosNo;
    t100001.wizNo = wizNo;
    t100001.qcReadQrCshrName = qcReadQrCshrName;
    t100001.reservNo = reservNo;
    t100001.saleAmt = saleAmt;
    t100001.grsslAmt = grsslAmt;
    t100001.netslAmt = netslAmt;
    t100001.cust = cust;
    t100001.peopleCnt = peopleCnt;
    t100001.qty = qty;
    t100001.wgt = wgt;
    t100001.prfAmt = prfAmt;
    t100001.manSht = manSht;
    t100001.cancelCnt = cancelCnt;
    t100001.cancelAmt = cancelAmt;
    t100001.selfgateAmt = selfgateAmt;
    t100001.selfgateCust = selfgateCust;
    t100001.selfgateQty = selfgateQty;
    t100001.receiptGpSht = receiptGpSht;
    t100001.receiptGpAmt = receiptGpAmt;
    t100001.receiptGpRank = receiptGpRank;
    t100001.creditSaleNo = creditSaleNo;
    t100001.periodDscAmt = periodDscAmt;
    t100001.bcUseSht = bcUseSht;
    t100001.visitCnt = visitCnt;
    t100001.chgAmt = chgAmt;
    t100001.stlTaxInAmt = stlTaxInAmt;
    t100001.stldscBfrAmt = stldscBfrAmt;
    t100001.lastChgPayout = lastChgPayout;
    t100001.validDate = validDate;
    t100001.orgTranDate = orgTranDate;
    return t100001;
  }
}

///  FNo.100002 : 合計２
class T100002 {
  bool validFlg = false;
  String reservNo = "";
  String kuroCreditNo = "";
  String nmStldscPlanCd = "";
  String promoExtId = "";
  String zipcode1 = "";
  String zipcode2 = "";
  String zipcode3 = "";
  int extraCnt = 0;
  int extraAmt = 0;
  int exTaxBfrAmt = 0;
  int nmStlpdscAmt = 0;
  int nmStlpdscCnt = 0;
  int daiqSht = 0;
  int edyAlarmCnt = 0;
  int edyAlarmAmt = 0;
  int mscrapQty = 0;
  int stlcrdtdscPer = 0;
  int stlcrdtdscCnt = 0;
  int stlcrdtdscAmt = 0;
  int crdtNo = 0;
  int cashOutBfreAmt = 0;
  int reqCd = 0;
  int custCd = 0;
  int deliHandSht = 0;
  int yCnclNo = 0;
  int guaranteeShtQty = 0;
  int receiptCnt = 0;
  int rprCnt = 0;
  int cpnQty = 0;
  int cpnAmt = 0;
  int cpnQty2 = 0;
  int cpnAmt2 = 0;
  int nmStldscTrendsTyp = 0;
  int certificateShtQty = 0;
  int quotationFlg = 0;
}

///  FNo.100003 : 合計3
class T100003 {
  bool validFlg = false;
  String reasonName = "";
  int corrQty = 0;
  int corrAmt = 0;
  int voidQty = 0;
  int voidAmt = 0;
  int scrvoidQty = 0;
  int scrvoidAmt = 0;
  int refundQty = 0;
  int refundAmt = 0;
  int outMdlclsQty = 0;
  int outMdlclsAmt = 0;
  int btlRetQty = 0;
  int btlRetAmt = 0;
  int btlRetTaxbl = 0;
  int btlRetTaxAmt = 0;
  int prfreeQty = 0;
  int refundCnt = 0;
  int voidFlg = 0;
  int prodQty = 0;
  int prodAmt = 0;
  int eatInCust = 0;
  int reasonKindCd = 0;
  int reasonCd = 0;

  T100003 copyWith() {
    T100003 t100003 = T100003();
    t100003.validFlg = validFlg;
    t100003.reasonName = reasonName;
    t100003.corrQty = corrQty;
    t100003.corrAmt = corrAmt;
    t100003.voidQty = voidQty;
    t100003.voidAmt = voidAmt;
    t100003.scrvoidQty = scrvoidQty;
    t100003.scrvoidAmt = scrvoidAmt;
    t100003.refundQty = refundQty;
    t100003.refundAmt = refundAmt;
    t100003.outMdlclsQty = outMdlclsQty;
    t100003.outMdlclsAmt = outMdlclsAmt;
    t100003.btlRetQty = btlRetQty;
    t100003.btlRetAmt = btlRetAmt;
    t100003.btlRetTaxbl = btlRetTaxbl;
    t100003.btlRetTaxAmt = btlRetTaxAmt;
    t100003.prfreeQty = prfreeQty;
    t100003.refundCnt = refundCnt;
    t100003.voidFlg = voidFlg;
    t100003.prodQty = prodQty;
    t100003.prodAmt = prodAmt;
    t100003.eatInCust = eatInCust;
    t100003.reasonKindCd = reasonKindCd;
    t100003.reasonCd = reasonCd;
    return t100003;
  }
}

///  FNo.100004 : 合計4（旧オペモード51用）
class T100004 {
  bool validFlg = false;
  int saleAmt = 0;
  int cust = 0;
  int peopleCnt = 0;
  int chgAmt = 0;
  int stlTaxInAmt = 0;
  int btlRetQty = 0;
}

///  FNo.100010 : LDH
class T100010 {
  bool validFlg = false;
  String invoiceNo = "";
  String companyCd = "";
  int approvalNo = 0;
  int payCnt = 0;
  int orgStreCd = 0;
  int orgRegNo = 0;
  int orgReceiptNo = 0;
}

///  FNo.100011 : 北欧
class T100011 {
  bool validFlg = false;
  String errcd = "";
  String cardData = "";
}

///  FNo.100012 : ハピー
class T100012 {
  bool validFlg = false;
}

///  FNo.100013 : TUO
class T100013 {
  bool validFlg = false;
}

///  FNo.100017 : ユナイト
class T100017 {
  String creditNo = "";
  String creditName = "";
  bool validFlg = false;
  int externalPtsUpdFlg = 0;
  int todayPoint = 0;
  int totalPoint = 0;
  int lastTotalPoint = 0;
  int pntachiCnt = 0;
}

///  FNo.100018 : タカラ・エムシー
class T100018 {
  int aplMbrFlg = 0;
  int monthlyRank = 0;
  int annualStatus = 0;
  double rankAddper = 0;
  int settlementPosSelect = 0;
}

///  FNo.100100 : スプリットテンダリング
class T100100 {
  bool validFlg = false;
  String cpnBarCd = "";
  String trafficCardNo = "";
  String mStaffNo = "";
  String edyCd = "";
  String edyTranNumber = "";
  String cardTranNumber = "";
  String posId = "";
  String splitCode = "";
  String divName = "";
  int sptendCd = 0;
  int sptendData = 0;
  int sptendOutAmt = 0;
  int sptendInAmt = 0;
  int sptendChgAmt = 0;
  int sptendSht = 0;
  int sptendFaceAmt = 0;
  int manCnt = 0;
  int cnt = 0;
  int amt = 0;
  int bfreBalance = 0;
  int aftrBalance = 0;
  int splitType = 0;
  int privilegeAmt = 0;
  int privilege8Amt = 0;
  int privilege8Tax = 0;
  int privilege10Amt = 0;
  int privilege10Tax = 0;
  int privilegeothAmt = 0;
  int privilegeothTax = 0;
  int privilegeoutAmt = 0;
  int kindCd = 0;
  int divCd = 0;

  /// ディープコピー用関数
  T100100 copyWith() {
    T100100 t100100 = T100100();
    t100100.validFlg = validFlg;
    t100100.cpnBarCd = cpnBarCd;
    t100100.trafficCardNo = trafficCardNo;
    t100100.mStaffNo = mStaffNo;
    t100100.edyCd = edyCd;
    t100100.edyTranNumber = edyTranNumber;
    t100100.cardTranNumber = cardTranNumber;
    t100100.posId = posId;
    t100100.splitCode = splitCode;
    t100100.divName = divName;
    t100100.sptendCd = sptendCd;
    t100100.sptendData = sptendData;
    t100100.sptendOutAmt = sptendOutAmt;
    t100100.sptendInAmt = sptendInAmt;
    t100100.sptendChgAmt = sptendChgAmt;
    t100100.sptendSht = sptendSht;
    t100100.sptendFaceAmt = sptendFaceAmt;
    t100100.manCnt = manCnt;
    t100100.cnt = cnt;
    t100100.amt = amt;
    t100100.bfreBalance = bfreBalance;
    t100100.aftrBalance = aftrBalance;
    t100100.splitType = splitType;
    t100100.privilegeAmt = privilegeAmt;
    t100100.privilege8Amt = privilege8Amt;
    t100100.privilege8Tax = privilege8Tax;
    t100100.privilege10Amt = privilege10Amt;
    t100100.privilege10Tax = privilege10Tax;
    t100100.privilegeothAmt = privilegeothAmt;
    t100100.privilegeothTax = privilegeothTax;
    t100100.privilegeoutAmt = privilegeoutAmt;
    t100100.kindCd = kindCd;
    t100100.divCd = divCd;
    return t100100;
  }
}

///  FNo.100101 : スプリットテンダリング（旧オペモード51用）
class T100101 {
  bool validFlg = false;
  String edyCd = "";
  int sptendCd = 0;
  int sptendData = 0;
  int sptendOutAmt = 0;
  int sptendInAmt = 0;
  int sptendChgAmt = 0;
  int sptendSht = 0;
  int sptendFaceAmt = 0;
  int manCnt = 0;
  int cnt = 0;
  int amt = 0;
}

///  FNo.100102 : スプリットテンダリング(税別実績)
class T100102 {
  bool validFlg = false;
  int sptendCd = 0;
  int sptendTcd1Blamt = 0;
  int sptendTcd2Blamt = 0;
  int sptendTcd3Blamt = 0;
  int sptendTcd4Blamt = 0;
  int sptendTcd5Blamt = 0;
  int sptendTcd6Blamt = 0;
  int sptendTcd7Blamt = 0;
  int sptendTcd8Blamt = 0;
  int sptendTcd10Blamt = 0;
  int sptendTcd1Amt = 0;
  int sptendTcd2Amt = 0;
  int sptendTcd3Amt = 0;
  int sptendTcd4Amt = 0;
  int sptendTcd5Amt = 0;
  int sptendTcd6Amt = 0;
  int sptendTcd7Amt = 0;
  int sptendTcd8Amt = 0;
  int sptendTcd10Amt = 0;
}

///  FNo.100200 : 在高
class T100200 {
  bool validFlg = false;
  String compCd = "";
  String codepayKind = "";
  int kyCd = 0;
  int cnt = 0;
  int sht = 0;
  int amt = 0;
  int drwAmt = 0;
  int actDrwAmt = 0;
  int residualAmt = 0;
  int chkChgAmt = 0;
  int emoneyKind = 0;
  int expSettleNo = 0;
  int expChgamtSettleNo = 0;
  int slipNo = 0;
  int expSettleTyp = 0;
  int expChgamtSettleTyp = 0;
  int payPts = 0;

  /// ディープコピー用関数
  T100200 copyWith() {
    T100200 t100200 = T100200();
    t100200.validFlg = validFlg;
    t100200.compCd = compCd;
    t100200.codepayKind = codepayKind;
    t100200.kyCd = kyCd;
    t100200.cnt = cnt;
    t100200.sht = sht;
    t100200.amt = amt;
    t100200.drwAmt = drwAmt;
    t100200.actDrwAmt = actDrwAmt;
    t100200.residualAmt = residualAmt;
    t100200.chkChgAmt = chkChgAmt;
    t100200.emoneyKind = emoneyKind;
    t100200.expSettleNo = expSettleNo;
    t100200.expChgamtSettleNo = expChgamtSettleNo;
    t100200.slipNo = slipNo;
    t100200.expSettleTyp = expSettleTyp;
    t100200.expChgamtSettleTyp = expChgamtSettleTyp;
    t100200.payPts = payPts;
    return t100200;
  }
}

///  FNo.100201 : 在高（旧オペモード51用）
class T100201 {
  bool validFlg = false;
  int kyCd = 0;
  int cnt = 0;
  int sht = 0;
  int amt = 0;
  int drwAmt = 0;
  int actDrwAmt = 0;
  int residualAmt = 0;
  int chkChgAmt = 0;
}

///  FNo.100210 : 在高（区分実績）
class T100210 {
  bool validFlg = false;
  int kyCd = 0;
  int div0Amt = 0;
  int div1Sht = 0;
  int div1Amt = 0;
  int div2Sht = 0;
  int div2Amt = 0;
  int div3Sht = 0;
  int div3Amt = 0;
  int div4Sht = 0;
  int div4Amt = 0;
  int div5Sht = 0;
  int div5Amt = 0;
  int div6Sht = 0;
  int div6Amt = 0;
  int div7Sht = 0;
  int div7Amt = 0;
  int div8Sht = 0;
  int div8Amt = 0;
  int div9Sht = 0;
  int div9Amt = 0;
}

///  FNo.100220 : サブ在高
class T100220 {
  bool validFlg = false;
  String compCd = "";
  String codepayKind = "";
  int kyCd = 0;
  int cnt = 0;
  int sht = 0;
  int amt = 0;
  int drwAmt = 0;
  int actDrwAmt = 0;
  int divCd = 0;
  int residualAmt = 0;
  int chkChgAmt = 0;
}

///  FNo.100300 : 税（税コード）
class T100300 {
  bool validFlg = false;
  int taxCd = 0;
  double taxPer = 0;
  int taxblAmt = 0;
  int taxQty = 0;
  int taxAmt = 0;
  int taxTyp = 0;
  int taxItemAmt = 0;

  int wsTaxblDscAmt = 0;
  int wsTaxDscAmt = 0;
  int wsTaxItemDscAmt = 0;
}

///  FNo.100400 : 税（税種）
class T100400 {
  bool validFlg = false;
  int taxTyp = 0;
  double taxPer = 0;
  int taxblAmt = 0;
  int taxQty = 0;
  int taxAmt = 0;
  int taxItemAmt = 0;
}

///  FNo.100401 : 税別実績1
class T100401 {
  bool validFlg = false;
  int taxCd = 0;
  int stldscBaseTcdAmt = 0;
  int stldscpdscTcdAmt = 0;
  int stldscTcdAmt1 = 0;
  int stldscTcdAmt2 = 0;
  int stldscTcdAmt3 = 0;
  int stldscTcdAmt4 = 0;
  int stldscTcdAmt5 = 0;
  int stlpdscTcdAmt1 = 0;
  int stlpdscTcdAmt2 = 0;
  int stlpdscTcdAmt3 = 0;
  int stlpdscTcdAmt4 = 0;
  int stlpdscTcdAmt5 = 0;
  int stlplusBaseTcdAmt = 0;
  int stlplusTcdTlamt = 0;
  int stlplusTcdAmt1 = 0;
  int stlplusTcdAmt2 = 0;
  int stlplusTcdAmt3 = 0;
  int stlplusTcdAmt4 = 0;
  int stlplusTcdAmt5 = 0;
  int stlcrdtdscTcdTtlAmt = 0;
  int rbtTcdTtlAmt = 0;
  int taxFreeBlamt = 0;
  int taxFreeGenBlamt = 0;
  int taxFreeAmt = 0;
}

///  FNo.100500 : 客層
class T100500 {
  bool validFlg = false;
  int custhCd = 0;
  int lyCust = 0;
  int lySaleAmt = 0;
}

///  FNo.100600 : 釣銭機
class T100600 {
  bool validFlg = false;
  int acb10000Sht = 0;
  int acb5000Sht = 0;
  int acb2000Sht = 0;
  int acb1000Sht = 0;
  int acr500Sht = 0;
  int acr100Sht = 0;
  int acr50Sht = 0;
  int acr10Sht = 0;
  int acr5Sht = 0;
  int acr1Sht = 0;
  int acb10000PolSht = 0;
  int acb5000PolSht = 0;
  int acb2000PolSht = 0;
  int acb1000PolSht = 0;
  int acrOthPolSht = 0;
  int acr500PolSht = 0;
  int acr100PolSht = 0;
  int acr50PolSht = 0;
  int acr10PolSht = 0;
  int acr5PolSht = 0;
  int acr1PolSht = 0;
  int acbFillPolSht = 0;
  int acbRejectCnt = 0;
  String stockDatetime = "";
}

///  FNo.100700 : 顧客
class T100700 {
  bool validFlg = false;
  String magMbrCd = "";
  String mbrNameKanji1 = "";
  String mbrNameKanji2 = "";
  String mbrNameKana1 = "";
  String mbrNameKana2 = "";
  String adrs1 = "";
  String adrs2 = "";
  String adrs3 = "";
  String telno1 = "";
  String popMsg = "";
  int storeZoneCd = 0;
  int areaZoneCd = 0;
  int svsClsCd = 0;
  int mbrVcnt = 0;
  int lastTtlpur = 0;
  int dwitTtlpur = 0;
  int termTtlpur = 0;
  int dcauMspur = 0;
  int dexpMspur = 0;
  int dpntTtlsrv = 0;
  int tpntTtlsrv = 0;
  int lpntTtlsrv = 0;
  int dcutTtlsrv = 0;
  int bonusPnt = 0;
  int divMspur = 0;
  int divPpoint = 0;
  int mbrInput = 0;
  int otherStoreMbr = 0;
  int fspLvl = 0;
  int pntTargetCust = 0;
  int realCustsrvFlg = 0;
  int mbrUnlockFlg = 0;
  int netCustFlg = 0;
  int tsOflFlg = 0;
  String endSaleDate = "";
  String mbrLimitDate = "";
}

///  FNo.100701 : 顧客ポイント利用
class T100701 {
  bool validFlg = false;
  String promoExtId = "";
  int duptTtlrv = 0;
  int dtiqTtlsrv = 0;
  int dtipTtlsrv = 0;
  int dmqTtlsrv = 0;
  int dmpTtlsrv = 0;
  int tcktIssueAmt = 0;
  int tcktIssueCust = 0;
  int rebateFlg = 0;
  int rbtRchCnt = 0;
}

///  FNo.100702 : 顧客その他
class T100702 {
  bool validFlg = false;
  String anvkindName1 = "";
  String anvkindName2 = "";
  String anvkindName3 = "";
  String mbrStldscPlanCd = "";
  String promoExtId = "";
  String rankPromoExtId = "";
  int dtuqTtlsrv = 0;
  int dtupTtlsrv = 0;
  int mdayDpntTtlsrv = 0;
  int joinFeeCust = 0;
  int joinFeeAmt = 0;
  int selfRwPnt = 0;
  int offerId = 0;
  int tcktPickCust = 0;
  int mbrStlpdscCnt = 0;
  int mbrStlpdscAmt = 0;
  int mbrStlpdscTrendsTyp = 0;
  int bnsdscAmt = 0;

  /// ディープコピー用関数
  T100702 copyWith() {
    T100702 t100702 = T100702();
    t100702.validFlg = validFlg;
    t100702.anvkindName1 = anvkindName1;
    t100702.anvkindName2 = anvkindName2;
    t100702.anvkindName3 = anvkindName3;
    t100702.mbrStldscPlanCd = mbrStldscPlanCd;
    t100702.promoExtId = promoExtId;
    t100702.rankPromoExtId = rankPromoExtId;
    t100702.dtuqTtlsrv = dtuqTtlsrv;
    t100702.dtupTtlsrv = dtupTtlsrv;
    t100702.mdayDpntTtlsrv = mdayDpntTtlsrv;
    t100702.joinFeeCust = joinFeeCust;
    t100702.joinFeeAmt = joinFeeAmt;
    t100702.selfRwPnt = selfRwPnt;
    t100702.offerId = offerId;
    t100702.tcktPickCust = tcktPickCust;
    t100702.mbrStlpdscCnt = mbrStlpdscCnt;
    t100702.mbrStlpdscAmt = mbrStlpdscAmt;
    t100702.mbrStlpdscTrendsTyp = mbrStlpdscTrendsTyp;
    t100702.bnsdscAmt = bnsdscAmt;
    return t100702;
  }
}

///  FNo.100710 : Tポイント
class T100710 {
  bool validFlg = false;
  String serialNo = "";
  int ptsDataType = 0;
  int cancelType = 0;
  int ptsSubjQty = 0;
  int tcardDigitType = 0;
  int tPtsFlg = 0;
  int tcpnDscAmt = 0;
  int retCdEnq = 0;
  int batchFlg = 0;
}

///  FNo.100711 : Tポイント加減算失敗
class T100711 {
  bool validFlg = false;
  String kaiinId = "";
  String serialNo = "";
  String motoSerialNo = "";
  int gyotaiCd = 0;
  int registerNo = 0;
  int denpyoNo = 0;
  int retryKbn = 0;
  int pointKbn = 0;
  int kangenPoint = 0;
  int uriageKin = 0;
  String shoriTime = "";
  String motoDate = "";
}

///  FNo.100712 : Tクーポン発券
class T100712 {
  bool validFlg = false;
  String memberId = "";
  String promNo = "";
  String janCd = "";
  String mngNo = "";
  int prnType = 0;
  int cpnNo = 0;
  int allianceCd = 0;
}

///  FNo.100713 : Tマネー
class T100713 {
  bool validFlg = false;
  String serialNo = "";
  int chrgAmt = 0;
  int chrgCnt = 0;
  int tranAmt = 0;
  String date = "";
}

///  FNo.100714 : Tマネー加減算失敗
class T100714 {
  bool validFlg = false;
  String memberId = "";
  String serialNo = "";
  String cnclSerialNo = "";
  int opType = 0;
  int cnclMoney = 0;
  String dateTime = "";
  String cnclDate = "";
}

///  FNo.100715 : Tポイント
class T100715 {
  bool validFlg = false;
  String memberId = "";
  String serialNo = "";
  int mbrInput = 0;
  int mbrIdLen = 0;
  int retCd = 0;
  int offlineFlg = 0;
  int usePts = 0;
  int ptsEnq = 0;
  int ptsUpd = 0;
  int allianceCd = 0;
  int bizCd = 0;
  String useDate = "";
}

///  FNo.100720 : アヤハディオ顧客
class T100720 {
  bool validFlg = false;
  String tcktPrnBcd = "";
  String crdtRcptCd = "";
  int prizeNoPrev = 0;
  int prizeNoNext = 0;
  int prizeNoFrom = 0;
  int prizeNoTo = 0;
  int prizeNoPrev2 = 0;
  int prizeNoNext2 = 0;
}

///  FNo.100730 : ナンバ顧客
class T100730 {
  bool validFlg = false;
  String tcktPrnBcd = "";
  String crdtRcptCd = "";
  int crdtNo = 0;
}

///  FNo.100740 : タイヨークーポン発券
class T100740 {
  bool validFlg = false;
  String cpnCd = "";
  int printQty = 0;
}

///  FNo.100750 : 顧客リアルPT仕様
class T100750 {
  bool validFlg = false;
  String tranNoExc = "";
  String tranNoAdd = "";
  String tranNoExcCncl = "";
  String tranNoExcVd = "";
  String tranNoAddVd = "";
  int offlFlg = 0;
  int rcvPtsExc = 0;
  int rcvPtsExcVd = 0;
  int mbrStatFlg = 0;
  String dateExc = "";
  String dateAdd = "";
}

///  FNo.100770 : dポイント
class T100770 {
  bool validFlg = false;
  String dpntMbrCd = "";
  String dpntCd1 = "";
  String dpntCd2 = "";
  int dpntProcKind = 0;
  int dpntInMethod = 0;
  int dpntAddTerminalId = 0;
  int dpntUseTerminalId = 0;
  int dpntAddProcNo = 0;
  int dpntUseProcNo = 0;
  int orgDpntAddTerminalId = 0;
  int orgDpntUseTerminalId = 0;
  int orgDpntAddProcNo = 0;
  int orgDpntUseProcNo = 0;
  int dpntSaleQty = 0;
  int dpntSaleAmt = 0;
  int dpntNotsaleAmt = 0;
  int dpntAddpurAmt = 0;
  int dpntSalePnt = 0;
  int dpntMbrVpnt = 0;
  int dpntCmpPnt = 0;
  int dpntBalancePnt = 0;
  int dpntAddPoint = 0;
  int dpntUsePoint = 0;
  double dpntAddPer = 0;
  int dpntItemAddpnt = 0;
  int dpntReceiptNo = 0;
  int orgDpntReceiptNo = 0;
  int dpntSalePntCnt = 0;
  int dpntMbrVpntCnt = 0;
  int dpntCmpPntCnt = 0;
  int dpntAddPntCnt = 0;
  int dpntUsePntCnt = 0;
  String dpntAddDatetime = "";
  String dpntUseDatetime = "";
  String orgDpntAddDatetime = "";
  String orgDpntUseDatetime = "";
}

///  FNo.100780 : レピカポイント
class T100780 {
  int cardAuthType = 0; // カードデータ種別
  int inputPoint = 0; // 入力ポイント数
  int targetAmount = 0; // ポイント対象額
  int cardNo1 = 0; // カード番号上8桁
  int cardNo2 = 0; // カード番号下8桁
  int receiptNo1 = 0; // レシート番号
  int receiptNo2 = 0; // レシート番号
  int receiptNo3 = 0; // レシート番号
  int nrmlAuthNo1 = 0; // 承認番号1(通常使用)
  int nrmlAuthNo2 = 0; // 承認番号2(通常使用)
  int nrmlAuthNo3 = 0; // 承認番号3(通常使用)
  int useAuthNo1 = 0; // 承認番号1(ポイント支払使用)
  int useAuthNo2 = 0; // 承認番号2(ポイント支払使用)
  int useAuthNo3 = 0; // 承認番号3(ポイント支払使用)
}

///  FNo.100790 : 楽天ポイント
class T100790 {
  String memberId = "";
  String readingId = "";
  String orderCd = "";
  int inputTyp = 0;
  int lastTotalPoint = 0;
  int lastAvailablePoint = 0;
  int rbtTargetAmt = 0;
  int normalPoint = 0;
  int campaignPoint = 0;
  int todayPoint = 0;
  int usePoint = 0;
  int totalPoint = 0;
  int availablePoint = 0;
  int offlineFlg = 0;
  int voidSkipFlg = 0;
  String tranDatetime = "";
  String cancelDatetime = "";
}

///  FNo.100800 : FSP
class T100800 {
  bool validFlg = false;
  int fspCd = 0;
  int dcauFsppur = 0;
  int dexpFsppur = 0;
  int lcauFsppur = 0;
  int tcauFsppur = 0;
  int mnyReAmt = 0;
}

///  FNo.100900 : リライト
class T100900 {
  bool validFlg = false;
  int termChgAmt = 0;
  int nrmlPointCust = 0;
  int nrmlPoint = 0;
  int spPointCust = 0;
  int spPoint = 0;
  int cardIssueSht = 0;
  int thisSvsNo = 0;
  int vmcStkacv = 0;
  int vmcStkhesoacv = 0;
  int vmcChgtcktCnt = 0;
  int vmcChgAmt = 0;
  int todayChgamt = 0;
  int totalChgamt = 0;
  int lastChgamt = 0;
  int vmcChgCnt = 0;
  int vmcHesotcktCnt = 0;
  int vmcHesoAmt = 0;
  int todayHesoamt = 0;
  int totalHesoamt = 0;
  int lastHesoamt = 0;
  int vmcHesoCnt = 0;
  String issueDate = "";
  String cpnUseDate = "";
  String lastRbtDate = "";
  String lastChgPayout = "";
  String lastHesoPayout = "";
}

///  FNo.100901 : 日立ブルーチップ
class T100901 {
  bool validFlg = false;
  String ht2980Msg1 = "";
  String ht2980Msg2 = "";
  String ht2980Msg3 = "";
  String ht2980Msg4 = "";
  String ht2980Msg5 = "";
  String ht2980Msg6 = "";
  String ht2980Msg7 = "";
  int ht2980TodayPoint = 0;
  int ht2980TotalPoint = 0;
  int ht2980MsgCnt = 0;
}

///  FNo.100902 : プリカ
class T100902 {
  bool validFlg = false;
}

///  FNo.101000 : プロモーション
class T101000 {
  bool validFlg = false;
  String couponCd = "";
  int promCd = 0;
  int promTicketNo = 0;
  int promTicketQty = 0;
  int promDscCd = 0;
  int promDscPrc = 0;
  int promUseQty = 0;
  int promDscFlg = 0;
}

///  FNo.101001 : 発行プロモーション
class T101001 {
  bool validFlg = false;
  String name = "";
  String dscCode = "";
  String ttlData = "";
  String msgData1 = "";
  String msgData2 = "";
  String msgData3 = "";
  String msgData4 = "";
  int promCd = 0;
  int dscFlg = 0;
  int dscPrc = 0;
  int ttlSize = 0;
  int msgSize = 0;
  int effPrn = 0;
  int barPrn = 0;
  String useStartDatetime = "";
  String useEndDatetime = "";
}

///  FNo.101100 : 買上追加
class T101100 {
  bool validFlg = false;
  int dsltAddpnt = 0;
  int dslgAddpnt = 0;
  int dsptAddpnt = 0;
  int dpurAddpnt = 0;
  int dptqAddpnt = 0;
  int dpurAddmul = 0;
  int ptransQty = 0;
  int ptransAmt = 0;
  String ptransDate = "";
}

///  FNo.102000 : 特売
class T102000 {
  bool validFlg = false;
  int brgncustQty = 0;
  int brgnDscAmt = 0;
  int mbrgncustQty = 0;
  int mbrgnDscAmt = 0;
}

///  FNo.102001 : 値引
class T102001 {
  bool validFlg = false;
  int dscCd = 0;
  int dscQty = 0;
  int dscAmt = 0;
}

///  FNo.102002 : 割引
class T102002 {
  bool validFlg = false;
  int pdscCd = 0;
  int pdscQty = 0;
  int pdscAmt = 0;
}

///  FNo.102003 : 売価変更
class T102003 {
  bool validFlg = false;
  int prcChgFlg = 0;
  int prcChgQty = 0;
  int prcChgAmt = 0;
}

///  FNo.102004 : 分類一括
class T102004 {
  bool validFlg = false;
  int clsDscQty = 0;
  int clsDscAmt = 0;
  int clsPdscQty = 0;
  int clsPdscAmt = 0;
  int clsSamedscQty = 0;
  int clsSamedscAmt = 0;
  int cMdscQty = 0;
  int cMdscAmt = 0;
  int cMpdscQty = 0;
  int cMpdscAmt = 0;
  int cMsdscQty = 0;
  int cMsdscAmt = 0;
}

///  FNo.102005 : バーコード値下
class T102005 {
  bool validFlg = false;
  int skuDscAmt = 0;
  int skuPdscAmt = 0;
  int skuSamedscAmt = 0;
}

///  FNo.102500 : スケジュール反映
class T102500 {
  bool validFlg = false;
  String promoExtId = "";
  int rfTyp = 0;
  int rfSchCd = 0;
  int rfCd = 0;
  double rfVal = 0;
  int acntCd = 0;
  int lowLim = 0;
}

///  FNo.102501 : サービス分類
class T102501 {
  bool validFlg = false;
  String planCd = "";
  String svsClsCd = "";
  int pointAddMemTyp = 0;
  int svsClsSchCd = 0;
  double pointAddMagn = 0;
  int acctCd = 0;
}

///  FNo.102600 : 販売期限バーコード
class T102600 {
  int salelimitCnt = 0;
  int salelimitAmt = 0;
}

///  FNo.103000 : 会員売価
class T103000 {
  bool validFlg = false;
  int mpricustQty = 0;
  int mpriDscAmt = 0;
  int iMdscAmt = 0;
  int iMpdscAmt = 0;
}

///  FNo.105000 : 釣準備
class T105000 {
  bool validFlg = false;
  int loanCd = 0;
  int loanCnt = 0;
  int loanAmt = 0;
  int sht10000 = 0;
  int sht5000 = 0;
  int sht2000 = 0;
  int sht1000 = 0;
  int sht500 = 0;
  int sht100 = 0;
  int sht50 = 0;
  int sht10 = 0;
  int sht5 = 0;
  int sht1 = 0;
}

///  FNo.105100 : 売上回収
class T105100 {
  bool validFlg = false;
  int pickCd = 0;
  int pickCnt = 0;
  int pickAmt = 0;
  int sht10000 = 0;
  int sht5000 = 0;
  int sht2000 = 0;
  int sht1000 = 0;
  int sht500 = 0;
  int sht100 = 0;
  int sht50 = 0;
  int sht10 = 0;
  int sht5 = 0;
  int sht1 = 0;
  int closeFlg = 0;
  int	pickTyp = 0;		//回収タイプ　0：日中　1：精算
  String opeStaffCd = '';		//操作従業員番号
}

///  FNo.105200 : 入金
class T105200 {
  bool validFlg = false;
  int inCd = 0;
  int inCnt = 0;
  int inAmt = 0;
  int sht10000 = 0;
  int sht5000 = 0;
  int sht2000 = 0;
  int sht1000 = 0;
  int sht500 = 0;
  int sht100 = 0;
  int sht50 = 0;
  int sht10 = 0;
  int sht5 = 0;
  int sht1 = 0;
  // 以下は元ソースで#if 0
  // int officeSht10000 = 0;
  // int officeSht5000 = 0;
  // int officeSht2000 = 0;
  // int officeSht1000 = 0;
  // int officeSht500 = 0;
  // int officeSht100 = 0;
  // int officeSht50 = 0;
  // int officeSht10 = 0;
  // int officeSht5 = 0;
  // int officeSht1 = 0;
  // int recycleNo = 0;
  int divCd = 0;

  /// ディープコピー用関数
  T105200 copyWith() {
    T105200 t105200 = T105200();
    t105200.validFlg = validFlg;
    t105200.inCd = inCd;
    t105200.inCnt = inCnt;
    t105200.inAmt = inAmt;
    t105200.sht10000 = sht10000;
    t105200.sht5000 = sht5000;
    t105200.sht2000 = sht2000;
    t105200.sht1000 = sht1000;
    t105200.sht500 = sht500;
    t105200.sht100 = sht100;
    t105200.sht50 = sht50;
    t105200.sht10 = sht10;
    t105200.sht5 = sht5;
    t105200.sht1 = sht1;
    t105200.divCd = divCd;
    return t105200;
  }
}

///  FNo.105300 : 支払
class T105300 {
  bool validFlg = false;
  int outCd = 0;
  int outCnt = 0;
  int outAmt = 0;
  int sht10000 = 0;
  int sht5000 = 0;
  int sht2000 = 0;
  int sht1000 = 0;
  int sht500 = 0;
  int sht100 = 0;
  int sht50 = 0;
  int sht10 = 0;
  int sht5 = 0;
  int sht1 = 0;
  // 以下は元ソースで#if 0
  // int officeSht10000 = 0;
  // int officeSht5000 = 0;
  // int officeSht2000 = 0;
  // int officeSht1000 = 0;
  // int officeSht500 = 0;
  // int officeSht100 = 0;
  // int officeSht50 = 0;
  // int officeSht10 = 0;
  // int officeSht5 = 0;
  // int officeSht1 = 0;
  // int recycleNo = 0;
  int divCd = 0;

  /// ディープコピー用関数
  T105300 copyWith() {
    T105300 t105300 = T105300();
    t105300.validFlg = validFlg;
    t105300.outCd = outCd;
    t105300.outCnt = outCnt;
    t105300.outAmt = outAmt;
    t105300.sht10000 = sht10000;
    t105300.sht5000 = sht5000;
    t105300.sht2000 = sht2000;
    t105300.sht1000 = sht1000;
    t105300.sht500 = sht500;
    t105300.sht100 = sht100;
    t105300.sht50 = sht50;
    t105300.sht10 = sht10;
    t105300.sht5 = sht5;
    t105300.sht1 = sht1;
    t105300.divCd = divCd;
    return t105300;
  }
}

///  FNo.105400 : 両替
class T105400 {
  bool validFlg = false;
  int exchgCnt = 0;
  int exchgAmt = 0;
}

/// FNo.105500 : フレスタ様　釣銭情報
class T105500 {
  int validFlg = 0;
  int drawAmt = 0;
  int sht10000 = 0;
  int sht5000 = 0;
  int sht2000 = 0;
  int sht1000 = 0;
  int sht500 = 0;
  int sht100 = 0;
  int sht50 = 0;
  int sht10 = 0;
  int sht5 = 0;
  int sht1 = 0;
  int autoFlg = 0; //在高０の場合でも実績作成する為
}

///  FNo.106000 : One to Oneプロモーション
class T106000 {
  bool validFlg = false;
  String promName = "";
  String loyBcd = "";
  String cpnId = "";
  String loyPlanCd = "";
  String promoExtId = "";
  int loyCnt = 0;
  int totalLoyCnt = 0;
  int acntId = 0;
  int loyAmt = 0;
  int loyDscAmt = 0;
  int loyPdscAmt = 0;
  int loyPnt = 0;
  int loyCpnKind = 0;
  int loySvsKind = 0;
  int custCardKind = 0;
  int extFlg = 0;
  int cpnNo = 0;
  String loyStartDatetime = "";
  String loyEndDatetime = "";
}

///  FNo.106100 : スタンプカード
class T106100 {
  bool validFlg = false;
  String rcptName = ""; //  企画名称
  String cpnId = ""; //  クーポンＩＤ
  String planCd = ""; //  企画コード
  int stpCnt = 0; //  今回付与回数
  int ttlStpCnt = 0; //  累計付与回数
  int rdmCnt = 0; //  今回利用回数
  int ttlRdmCnt = 0; //  累計利用回数
  String stpStartDatetime = ""; //  開始日時
  String stpEndDatetime = ""; //  終了日時
  String svsStartDatetime = ""; //  特典サービス開始日時
  String svsEndDatetime = ""; //  特典サービス終了日時
}

///  FNo.106500 : お得情報発行
class T106500 {
  bool validFlg = false;
  String cpnCshrNo = "";
  String cpnId = "";
  String lstSellday = "";
  String cpnStartDatetime = "";
  String cpnEndDatetime = "";
}

///  FNo.106501 : プロモーションクーポン発行
class T106501 {
  bool validFlg = false;
  String cpnId = "";
  int prnCnt = 0;
  int custCardKind = 0;
}

///  FNo.107000 : ポイントアカウント
class T107000 {
  bool validFlg = false;
  int acntId = 0;
  int mthrAcntId = 0;
  int acntPnt = 0;
  int lastAcntPnt = 0;
  int duttlAcntPnt = 0;
  int acntAmt = 0;
  int acntQty = 0;
  int lastAcntAmt = 0;
  int lastAcntQty = 0;
  String lstSellday = "";
}

///  FNo.108000 : 配達
class T108000 {
  bool validFlg = false;
  int deliveryCnt = 0;
}

///  FNo.109000 : 免税
class T109000 {
  bool validFlg = false;
  int taxExemptAmt = 0;
  int taxExemptAmtGnrl = 0;
  int taxExemptCust = 0;
  String voucherNumber = "";
  String cnceledVoucherNumber = "";
  String number = "";
  int liqrtaxFreeAmt = 0;
}

///  FNo.110000 : 自動精算情報
class T110000 {
  bool validFlg = false;
  String strclsErr = "";
  int stropnCnt = 0;
  int cashAmt = 0;
  int cashCnt = 0;
  int beforeDrawAmt = 0;
  int beforeInAmt = 0;
  int beforeOutAmt = 0;
  int loanAmt = 0;
  int actDrawAmt = 0;
  int clsPickAmt = 0;
  int clsCinAmt = 0;
  int clsOutAmt = 0;
  int afterDrawAmt = 0;
  int clsCinDiff10000 = 0;
  int clsCinDiff5000 = 0;
  int clsCinDiff2000 = 0;
  int clsCinDiff1000 = 0;
  int clsCinDiff500 = 0;
  int clsCinDiff100 = 0;
  int clsCinDiff50 = 0;
  int clsCinDiff10 = 0;
  int clsCinDiff5 = 0;
  int clsCinDiff1 = 0;
  int interuptFlg = 0;
  String clsStartTime = "";
  String clsEndTime = "";
  int cpickErrorCnt = 0;
  int cpickRecoverCnt = 0;
}

///  FNo.111000 : キャッシュリサイクル入出金
class T111000 {
  String recycleNo = ""; //発行番号
  String staffNo = ""; //操作従業員番号
  int inMacNo = 0; //入金レジ
  int outMacNo = 0; //出金レジ
  int inoutTyp = 0; //入出金フラグ 0:入金　１：出金
  int exchgFlg = 0; //両替フラグ
  int rein = 0; //再入金フラグ
  int inDiff = 0; //入金差異フラグ
  int chgoutAmt = 0; //両替出金額
  int ttlAmt = 0; //入出金額
  int officeSht10000 = 0; //事務所指示１００００円枚数
  int officeSht5000 = 0;
  int officeSht2000 = 0;
  int officeSht1000 = 0;
  int officeSht500 = 0;
  int officeSht100 = 0;
  int officeSht50 = 0;
  int officeSht10 = 0;
  int officeSht5 = 0;
  int officeSht1 = 0; //事務所指示１円枚数
  int sht10000 = 0; //入出金１００００円枚数
  int sht5000 = 0;
  int sht2000 = 0;
  int sht1000 = 0;
  int sht500 = 0;
  int sht100 = 0;
  int sht50 = 0;
  int sht10 = 0;
  int sht5 = 0;
  int sht1 = 0; //入出金１円枚数
  int inoutCnt = 0; //入出金回数
}

///  FNo.120000 : Ｖｅｓｃａ
class T120000 {
//	String	termId = "";		// 端末番号   (cData7)
  int cashlressBfAmt = 0; // 適用前金額 (nData3)
}

///  FNo.100904 : 友の会
class T100904 {
  String memberNo = ""; // cData1 カード番号

// カード利用データ
  int flg = 0; // nData1 処理フラグ　※現在未使用
  int bfreBalance = 0; // nData2 取引前残高(当日利用可能残高合計)
  int aftrBalance = 0; // nData3 取引後残高
  int savingFlg = 0; // nData4 積立継続中フラグ
  int useAmt = 0; // nData5 利用額
  int useMacNo = 0; // nData7 利用時のレジ番号
  int useReceiptNo = 0; // nData8 利用時のレシート番号
  int useJournalNo = 0; // nData9 利用時のジャーナル番号
}

///  FNo.6000000 : 予約情報
class T600000 {
  int reservStreCd = 0; //  予約店舗
  int delivStreCd = 0; //  受け渡し店舗
  int advanceMoney = 0; //  前金（内金）
  String receptDate = ""; //  予約日(受付日時)
  String ferryDate = ""; //  お渡し日
  String arrivalDate = ""; //  商品入荷日
  String memo1 = ""; //  メモ1
  String memo2 = ""; //  メモ2

  /// ディープコピー用関数
  T600000 copyWith() {
    T600000 t600000 = T600000();
    t600000.reservStreCd = reservStreCd; //  予約店舗
    t600000.delivStreCd = delivStreCd; //  受け渡し店舗
    t600000.advanceMoney = advanceMoney; //  前金（内金）
    t600000.receptDate = receptDate; //  予約日(受付日時)
    t600000.ferryDate = ferryDate; //  お渡し日
    t600000.arrivalDate = arrivalDate; //  商品入荷日
    t600000.memo1 = memo1; //  メモ1
    t600000.memo2 = memo2; //  メモ2
    return t600000;
  }
}

///  FNo.100014 : ワールドスポーツ情報
class T100014 {
  String agencyCd = ""; //  代理店コード
  String bonusMonth = ""; //  ボーナス月
  int loyStldscAmt = 0; //  ロイヤリティ小計値引額
  int loyStlpdscAmt = 0; //  ロイヤリティ小計割引額
  double basePointPer = 0; //  基底倍率
  double loyPointPer = 0; //  施策ポイント倍率
  int crdtCorpCd = 0; //  会社コード
  int paymentDiv = 0; //  支払区分コード
  int bonusCnt = 0; //  ボーナス回数
  int startMonth = 0; //  開始月
  int divisionCnt = 0; //  分割回数
  int firstNumberCnt = 0; //  初回回数
  int bonusAmt = 0; //  ボーナス金額
  int royaltyMemberDiv = 0; //  施策会員区分フラグ
}

///  FNo.100015 : ワールドスポーツ情報（EC関連）
class T100015 {
  String knrno = ""; //  管理番号
  String ordno = ""; //  注文番号
  String ordnm = ""; //  注文者氏名
  String kaiinno = ""; //  会員番号
  String shrhoucd = ""; //  支払方法コード

  int subtotal = 0; //  小計
  int zeikn = 0; //  消費税
  int soryo = 0; //  送料
  int dbkryo = 0; //  代引料
  int tesuryo1 = 0; //  手数料１
  int tesuryo2 = 0; //  手数料２
  int riyopnt = 0; //  利用ポイント
  int riyocpn = 0; //  利用クーポン
  int total = 0; //  合計
  int pointuse = 0; //  ポイント使用
  int pointadd = 0; //  ポイント付与
  int tenukeflg = 0; //  店舗受取フラグ
  int offFlg = 0; //  オフラインフラグ
  int ecTrade = 0; //  EC取引フラグ
  String orddt = ""; //  注文日付
  String ordtm = ""; //  注文時刻
}

///  FNo.100016 : ワールドスポーツ情報（中古関連）
class T100016 {
  int yobi = 0;
}

///  FNo.100760 : リアル顧客PI仕様
class T100760 {
  String fuyoDenpyoNo = ""; //  取引番号
  String fuyoUriageNo = ""; //  売上No
  String riyoDenpyoNo = ""; //  取引番号
  String riyoUriageNo = ""; //  売上No
  int pointFlg = 0; //  ポイント種別
  int kikanZndk = 0; //  現在期間限定ポイント残高
  int kaiinCategory = 0; //  会員分類
  int kaiinClub = 0; //  倶楽部会員
  int kaiinList = 0; //  リスト会員
  int pointUseAmt = 0; //  ポイント値引額
  int normalPoint = 0; //  基本ポイント
  String ptYukoKigen = ""; //  ポイント有効期限
  int pointUse = 0; //  利用ポイント数
  int pointAdd = 0; //  付与ポイント数
  int pointUseKikan = 0; //  有償利用ポイント数
  int pointUseNormal = 0; //  無償利用ポイント数
  int resultKikanZndk = 0; //  期間限定ポイント残高（取引結果）
  int resultMsKikanZndk = 0; //  直近失効期間限定ポイント残高（取引結果）
  int cancelPoint = 0; //  キャンセルポイント数
  int cancelKikanPoint = 0; //  キャンセル期間限定ポイント数
  String resultPtYukoKigen = ""; //  ポイント有効期限（取引結果）
  String resultMsKikanYukoKigen = ""; //  直近失効ポイント有効期限（取引結果）
}

///  FNo.121000 : CodePay
class T121000 {
  String transSerial1 = ""; // トランザクションシリアル1 (cData6)
  String transSerial2 = ""; // トランザクションシリアル2 (cData7)
  String orgTransSerial2 = ""; // 元トランザクションシリアル2 (cData8)
  String token = ""; // トークン (cData9)
  String orgToken = ""; // 元トークン (cData10)
  int transKind = 0; // 取引種別 (nData1)
  int serverKind = 0; // サーバー種類 (nData2)
  int barcodeAmt = 0; // バーコード値 (nData3)
  String transTimestamp = ""; // 取引タイムスタンプ (dData1)

  T121000 copyWith() {
    T121000 t121000 = T121000();
    t121000.transSerial1 = transSerial1; // トランザクションシリアル1 (cData6)
    t121000.transSerial2 = transSerial2; // トランザクションシリアル2 (cData7)
    t121000.orgTransSerial2 = orgTransSerial2; // 元トランザクションシリアル2 (cData8)
    t121000.token = token; // トークン (cData9)
    t121000.orgToken = orgToken; // 元トークン (cData10)
    t121000.transKind = transKind; // 取引種別 (nData1)
    t121000.serverKind = serverKind; // サーバー種類 (nData2)
    t121000.barcodeAmt = barcodeAmt; // バーコード値 (nData3)
    t121000.transTimestamp = transTimestamp; // 取引タイムスタンプ (dData1)
    return t121000;
  }
}

///  FNo.100903 : PCT関連
class T100903 {
  int busiKnd = 0; // 業務種別(nData1)
  int allPrice = 0; // 買上総額(nData2)
}

///  FNo.100019 :リウボウ
class T100019 {
  String accountReceivableCd = ""; //  売掛コード
  String stlpdscStaffCd = ""; //  社員割引社員（従業員）コード
  double stlpdscStaffPer = 0; //  社員割引率（会計２の売価）
  int accountReceivableFlg = 0; //  売掛の種類 0:社員 1:一般
}

/* FNo.100906 : フレスタFG券 */
class T100906 {
    String serialNo = ""; // 照会時に使用したコード
    int useAmt = 0; // 利用金額
    int status = 0; // 結果
}
