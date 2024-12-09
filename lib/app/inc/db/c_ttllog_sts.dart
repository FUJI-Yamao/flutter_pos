/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///関連tprxソース:c_ttllog_sts.h
///  合計
class T100001Sts {
  bool validFlg = false;
  int itemlogCnt = 0;
  int bdllogCnt = 0;
  int stmlogCnt = 0;
  int crdtlogCnt = 0;
  int stldscCnt = 0;
  int rbtCnt = 0;
  int stlplusCnt = 0;
  int stampCnt = 0;
  int sptendCnt = 0;
  int amtCnt = 0;
  int taxcdCnt = 0;
  int taxkindCnt = 0;
  int promCnt = 0;
  int cardCompCd = 0;
  int cardStreCd = 0;
  int creditFlg = 0;
  int debitFlg = 0;
  int receiptFlg = 0;
  int rprFlg = 0;
  int exchgFlg = 0;
  int receiptGpFlg = 0;
  int chrgFlg = 0;
  int mbrcnclFlg = 0;
  int kuroganeNo = 0;
  int alertAlow = 0;
  int receiptNo = 0;
  int amount = 0;
  int guaranteeNo = 0;
  int lastChg = 0;
  int rtnChg = 0;
  int voidMacNo = 0;
  int voidReceiptNo = 0;
  int voidPrintNo = 0;
  int qsEjPrnFlg = 0;
  int cardForgotFlg = 0;
  String qcReadTime = "";
  int restmpAmt = 0;
  int offlineFlg = 0;
  int bsOfflineFlg = 0;
  int preRctfmFlg = 0;
  String marutoOutsmlclsSlipcd = "";
  int qcRfmRcptFlg = 0;
  int qcReadQrReciptFlg = 0;
  int reservTyp = 0;
  String erctfmNowSaleDatetime = "";
  int loyPromTtlCnt = 0;
  int issuePromCnt = 0;
  int acntCnt = 0;
  int noMbrPnt = 0;
  int msRbtMbr = 0;
  int fspMbr = 0;
  int reflectCnt = 0;
  String traningDate = "";
  int cpnTtlCnt = 0;
  int portalConfFlg = 0;
  int ttldscCnt = 0;
  int ttlpdscCnt = 0;
  int qcReadQrMacNo = 0;
  int qcReadQrReceiptNo = 0;
  int qcReadQrPrintNo = 0;
  int cpnErrDlgFlg = 0;
  int stldscBnsBfrAmt = 0;
  int stldscManuBfrAmt = 0;
  int stldscAutoBfrAmt = 0;
  int stldscCrdtBfrAmt = 0;
  int stldscRbtBfrAmt = 0;
  int prcchgDscCnt = 0;
  int stldscPromBfrAmt = 0;
  int certificateNo = 0;
  int loyRegoverFlg = 0;
  int stpTtlCnt = 0;
  int cshrQctcktFlg = 0;
  int pntSelFlg = 0; // ゴダイ様　ポイント選択　0：会員　1：dポイント
  int cardForgetUpdateFlg = 0;
  int cardForgetPlusPoint = 0;
  int cardForgetNewVer = 0;
  String cardForgetCustNo = "";
  int	slipNo = 0;	/*フレスタ様　掛伝票番号*/
  int	zCpnCnt = 0;
  int	qcReadQrSaleAmt = 0;
  int	fgTtlUse = 0;
  String	sp1QrSeqno = "";	// C&P様 伝票番号
  int	taxperCnt = 0;
  int	gcatConnect = 0;		// 決済時端末連動フラグ
  int	loyPromRealCnt = 0;
  int	acntRealCnt = 0;

  /// ディープコピー用関数
  T100001Sts copyWith() {
    T100001Sts t100001Sts = T100001Sts();
    t100001Sts.validFlg = validFlg;
    t100001Sts.itemlogCnt = itemlogCnt;
    t100001Sts.bdllogCnt = bdllogCnt;
    t100001Sts.stmlogCnt = stmlogCnt;
    t100001Sts.crdtlogCnt = crdtlogCnt;
    t100001Sts.stldscCnt = stldscCnt;
    t100001Sts.rbtCnt = rbtCnt;
    t100001Sts.stlplusCnt = stlplusCnt;
    t100001Sts.stampCnt = stampCnt;
    t100001Sts.sptendCnt = sptendCnt;
    t100001Sts.amtCnt = amtCnt;
    t100001Sts.taxcdCnt = taxcdCnt;
    t100001Sts.taxkindCnt = taxkindCnt;
    t100001Sts.promCnt = promCnt;
    t100001Sts.cardCompCd = cardCompCd;
    t100001Sts.cardStreCd = cardStreCd;
    t100001Sts.creditFlg = creditFlg;
    t100001Sts.debitFlg = debitFlg;
    t100001Sts.receiptFlg = receiptFlg;
    t100001Sts.rprFlg = rprFlg;
    t100001Sts.exchgFlg = exchgFlg;
    t100001Sts.receiptGpFlg = receiptGpFlg;
    t100001Sts.chrgFlg = chrgFlg;
    t100001Sts.mbrcnclFlg = mbrcnclFlg;
    t100001Sts.kuroganeNo = kuroganeNo;
    t100001Sts.alertAlow = alertAlow;
    t100001Sts.receiptNo = receiptNo;
    t100001Sts.amount = amount;
    t100001Sts.guaranteeNo = guaranteeNo;
    t100001Sts.lastChg = lastChg;
    t100001Sts.rtnChg = rtnChg;
    t100001Sts.voidMacNo = voidMacNo;
    t100001Sts.voidReceiptNo = voidReceiptNo;
    t100001Sts.voidPrintNo = voidPrintNo;
    t100001Sts.qsEjPrnFlg = qsEjPrnFlg;
    t100001Sts.cardForgotFlg = cardForgotFlg;
    t100001Sts.qcReadTime = qcReadTime;
    t100001Sts.restmpAmt = restmpAmt;
    t100001Sts.offlineFlg = offlineFlg;
    t100001Sts.bsOfflineFlg = bsOfflineFlg;
    t100001Sts.preRctfmFlg = preRctfmFlg;
    t100001Sts.marutoOutsmlclsSlipcd = marutoOutsmlclsSlipcd;
    t100001Sts.qcRfmRcptFlg = qcRfmRcptFlg;
    t100001Sts.qcReadQrReciptFlg = qcReadQrReciptFlg;
    t100001Sts.reservTyp = reservTyp;
    t100001Sts.erctfmNowSaleDatetime = erctfmNowSaleDatetime;
    t100001Sts.loyPromTtlCnt = loyPromTtlCnt;
    t100001Sts.issuePromCnt = issuePromCnt;
    t100001Sts.acntCnt = acntCnt;
    t100001Sts.noMbrPnt = noMbrPnt;
    t100001Sts.msRbtMbr = msRbtMbr;
    t100001Sts.fspMbr = fspMbr;
    t100001Sts.reflectCnt = reflectCnt;
    t100001Sts.traningDate = traningDate;
    t100001Sts.cpnTtlCnt = cpnTtlCnt;
    t100001Sts.portalConfFlg = portalConfFlg;
    t100001Sts.ttldscCnt = ttldscCnt;
    t100001Sts.ttlpdscCnt = ttlpdscCnt;
    t100001Sts.qcReadQrMacNo = qcReadQrMacNo;
    t100001Sts.qcReadQrReceiptNo = qcReadQrReceiptNo;
    t100001Sts.qcReadQrPrintNo = qcReadQrPrintNo;
    t100001Sts.cpnErrDlgFlg = cpnErrDlgFlg;
    t100001Sts.stldscBnsBfrAmt = stldscBnsBfrAmt;
    t100001Sts.stldscManuBfrAmt = stldscManuBfrAmt;
    t100001Sts.stldscAutoBfrAmt = stldscAutoBfrAmt;
    t100001Sts.stldscCrdtBfrAmt = stldscCrdtBfrAmt;
    t100001Sts.stldscRbtBfrAmt = stldscRbtBfrAmt;
    t100001Sts.prcchgDscCnt = prcchgDscCnt;
    t100001Sts.stldscPromBfrAmt = stldscPromBfrAmt;
    t100001Sts.certificateNo = certificateNo;
    t100001Sts.loyRegoverFlg = loyRegoverFlg;
    t100001Sts.stpTtlCnt = stpTtlCnt;
    t100001Sts.cshrQctcktFlg = cshrQctcktFlg;
    t100001Sts.pntSelFlg = pntSelFlg; // ゴダイ様　ポイント選択　0：会員　1：dポイント
    t100001Sts.cardForgetUpdateFlg = cardForgetUpdateFlg;
    t100001Sts.cardForgetPlusPoint = cardForgetPlusPoint;
    t100001Sts.cardForgetNewVer = cardForgetNewVer;
    t100001Sts.cardForgetCustNo = cardForgetCustNo;
    t100001Sts.slipNo = slipNo; /*フレスタ様　掛伝票番号*/
    t100001Sts.zCpnCnt = zCpnCnt;
    t100001Sts.qcReadQrSaleAmt = qcReadQrSaleAmt;
    t100001Sts.fgTtlUse = fgTtlUse;
    t100001Sts.sp1QrSeqno = sp1QrSeqno; // C&P様 伝票番号
    t100001Sts.taxperCnt = taxperCnt;
    t100001Sts.gcatConnect = gcatConnect; // 決済時端末連動フラグ
    t100001Sts.loyPromRealCnt = loyPromRealCnt;
    t100001Sts.acntRealCnt = acntRealCnt;
    return t100001Sts;
  }
}

///  合計2
class T100002Sts {
  bool validFlg = false;
  int clsCnclFlg = 0;
  int warikanFlg = 0;
  int sepaFlg = 0;
  String elogDate = "";
  int revenueExclusionflg = 0;
  int revenueExclusionflg2 = 0;
  int orderSendResult = 0;
  int carryOn = 0;
  int purchaseTcktCnt = 0;
  int prizeTcktCnt = 0;
  int stlpdscPer = 0;
  int sptendCnclCnt = 0;
  int stlplusPer1 = 0;
  int stlplusPer2 = 0;
  int stlplusPer3 = 0;
  int stlplusPer4 = 0;
  int stlplusPer5 = 0;
  int prgNmStldscPer = 0;
  int prgMbrStldscPer = 0;
  int prgNmStldscTrendsTyp = 0;
  int prgMbrStldscTrendsTyp = 0;
  String prgNmStldscPlanCd = "";
  String prgMbrStldscPlanCd = "";
  String prgNmStldscPromoExtId = "";
  String prgMbrStldscPromoExtId = "";
  int prgNmStldscLowLimit = 0;
  int prgMbrStldscLowLimit = 0;
  int prgNmStldscDivCd = 0;
  int prgMbrStldscDivCd = 0;
  String prgNmStldscPromoName = "";
  String prgMbrStldscPromoName = "";
  int eatInNo = 0;
  int payKind = 0;
  int rcptCashPay = 0;
  int rcptCashStatus = 0;
  int rcptvoidQuotationInOrgtran = 0;
  int rcptvoidLoadOrgtran = 0;
  int cashlessOffFlg = 0;
  int cashlessSus = 0;
  int businessReasonCd = 0;
  int businessOrderNo = 0;
  String businessSlipCd = "";
  int	rcptCashMan = 0;
  int	rcptCashReturncash =0;

  /// ディープコピー用関数
  T100002Sts copyWith() {
    T100002Sts t100002Sts = T100002Sts();
    t100002Sts.validFlg = validFlg;
    t100002Sts.clsCnclFlg = clsCnclFlg;
    t100002Sts.warikanFlg = warikanFlg;
    t100002Sts.sepaFlg = sepaFlg;
    t100002Sts.elogDate = elogDate;
    t100002Sts.revenueExclusionflg = revenueExclusionflg;
    t100002Sts.revenueExclusionflg2 = revenueExclusionflg2;
    t100002Sts.orderSendResult = orderSendResult;
    t100002Sts.carryOn = carryOn;
    t100002Sts.purchaseTcktCnt = purchaseTcktCnt;
    t100002Sts.prizeTcktCnt = prizeTcktCnt;
    t100002Sts.stlpdscPer = stlpdscPer;
    t100002Sts.sptendCnclCnt = sptendCnclCnt;
    t100002Sts.stlplusPer1 = stlplusPer1;
    t100002Sts.stlplusPer2 = stlplusPer2;
    t100002Sts.stlplusPer3 = stlplusPer3;
    t100002Sts.stlplusPer4 = stlplusPer4;
    t100002Sts.stlplusPer5 = stlplusPer5;
    t100002Sts.prgNmStldscPer = prgNmStldscPer;
    t100002Sts.prgMbrStldscPer = prgMbrStldscPer;
    t100002Sts.prgNmStldscTrendsTyp = prgNmStldscTrendsTyp;
    t100002Sts.prgMbrStldscTrendsTyp = prgMbrStldscTrendsTyp;
    t100002Sts.prgNmStldscPlanCd = prgNmStldscPlanCd;
    t100002Sts.prgMbrStldscPlanCd = prgMbrStldscPlanCd;
    t100002Sts.prgNmStldscPromoExtId = prgNmStldscPromoExtId;
    t100002Sts.prgMbrStldscPromoExtId = prgMbrStldscPromoExtId;
    t100002Sts.prgNmStldscLowLimit = prgNmStldscLowLimit;
    t100002Sts.prgMbrStldscLowLimit = prgMbrStldscLowLimit;
    t100002Sts.prgNmStldscDivCd = prgNmStldscDivCd;
    t100002Sts.prgMbrStldscDivCd = prgMbrStldscDivCd;
    t100002Sts.prgNmStldscPromoName = prgNmStldscPromoName;
    t100002Sts.prgMbrStldscPromoName = prgMbrStldscPromoName;
    t100002Sts.eatInNo = eatInNo;
    t100002Sts.payKind = payKind;
    t100002Sts.rcptCashPay = rcptCashPay;
    t100002Sts.rcptCashStatus = rcptCashStatus;
    t100002Sts.rcptvoidQuotationInOrgtran = rcptvoidQuotationInOrgtran;
    t100002Sts.rcptvoidLoadOrgtran = rcptvoidLoadOrgtran;
    t100002Sts.cashlessOffFlg = cashlessOffFlg;
    t100002Sts.cashlessSus = cashlessSus;
    t100002Sts.businessReasonCd = businessReasonCd;
    t100002Sts.businessOrderNo = businessOrderNo;
    t100002Sts.businessSlipCd = businessSlipCd;
    t100002Sts.rcptCashMan = rcptCashMan;
    t100002Sts.rcptCashReturncash = rcptCashReturncash;
    return t100002Sts;
  }
}

///  LDH
class T100010Sts {
  bool validFlg = false;
  int payKind = 0;
}

///  北欧
class T100011Sts {
  bool validFlg = false;
  int cardKind = 0;
  int tranTyp = 0;
  String addLimitDate = "";
  String useLimitDate = "";
  int beforeYearPoint = 0;
}

///  ハピー
class T100012Sts {
  bool validFlg = false;
  int outsideRbtprnflg = 0;
  int hycardTtlamt = 0;
}

///  TUO
class T100013Sts {
  bool validFlg = false;
  int tuoImgNo = 0;
  int tuoImgNo1 = 0;
  int tuoImgNo2 = 0;
  int tuoImgNo3 = 0;
  int tuoImgNo4 = 0;
  int tuoImgNo5 = 0;
  int tuoImgNo6 = 0;
  int tuoImgNo7 = 0;
  int tuoImgNo8 = 0;
  int tuoImgNo9 = 0;
  int tuoImgNo10 = 0;
  int tuoSignFlg = 0;
  int hycardTtlamt = 0;
}

///  ユナイト
class T100017Sts {
  bool validFlg = false;
  int externalPoints = 0;
  int externalPtsPrnFlg = 0;
  int nonmbrPtsAmt = 0;
  int nonmbrPts = 0;
}

///  スプリットテンド
class T100100Sts {
  bool validFlg = false;
  int sptendFlg = 0;
  int rbtPurFlg = 0;
  int sptendPayStatus = 0;
  int sptendInputData = 0;
  int sptendPayKind = 0;
  int sptendPayGpType = 0;
  String suicaNumber = "";
  String suicaDatetime = "";
  String suicaSeqno = "";
  String suicaId = "";
  String suicaRwid = "";
  int suicaIcNo = 0;
  int unread10000Sht = 0;
  int unread5000Sht = 0;
  int unread2000Sht = 0;
  int unread1000Sht = 0;
  int unread500Sht = 0;
  int unread100Sht = 0;
  int unread50Sht = 0;
  int unread10Sht = 0;
  int unread5Sht = 0;
  int unread1Sht = 0;
}

///  在高
class T100200Sts {
  bool validFlg = false;
  int mny10000Sht = 0;
  int mny5000Sht = 0;
  int mny2000Sht = 0;
  int mny1000Sht = 0;
  int mny500Sht = 0;
  int mny100Sht = 0;
  int mny50Sht = 0;
  int mny10Sht = 0;
  int mny5Sht = 0;
  int mny1Sht = 0;
  int amtData = 0;
}

///  釣銭機
class T100600Sts {
  bool validFlg = false;
  int acrCoinSlot = 0;
  int coinRjct = 0;
  int billRjct = 0;
  int chgptnOutPrice = 0;
  int chgStockStateErr = 0;
  int bfreStockSht10000 = 0;
  int bfreStockSht5000 = 0;
  int bfreStockSht2000 = 0;
  int bfreStockSht1000 = 0;
  int bfreStockSht500 = 0;
  int bfreStockSht100 = 0;
  int bfreStockSht50 = 0;
  int bfreStockSht10 = 0;
  int bfreStockSht5 = 0;
  int bfreStockSht1 = 0;
  int bfreStockPolSht10000 = 0;
  int bfreStockPolSht5000 = 0;
  int bfreStockPolSht2000 = 0;
  int bfreStockPolSht1000 = 0;
  int bfreStockPolSht500 = 0;
  int bfreStockPolSht100 = 0;
  int bfreStockPolSht50 = 0;
  int bfreStockPolSht10 = 0;
  int bfreStockPolSht5 = 0;
  int bfreStockPolSht1 = 0;
  int chgInoutAmt = 0;
}

///  顧客ステータスフラグ
class T100700Sts {
  bool validFlg = false;
  int rebateFlg = 0;
  int msMbrSys = 0;
  int magMbrSys = 0;
  int dMspurPrn = 0;
  int dMspointPrn = 0;
  int tMspointPrn = 0;
  int anv1Prn = 0;
  int anv2Prn = 0;
  int anv3Prn = 0;
  int mulAnvEnbl = 0;
  int serPointSound = 0;
  int postCd = 0;
  int anvFlg = 0;
  int uanvDate1 = 0;
  int uanvDate2 = 0;
  int uanvDate3 = 0;
  int anvkind1 = 0;
  int anvkind2 = 0;
  int anvkind3 = 0;
  int anvDate1 = 0;
  int anvDate2 = 0;
  int anvDate3 = 0;
  double pointAddPer = 0;
  double fspAddPer = 0;
  int nextFspLvl = 0;
  double addperFsppnt = 0;
  int mbrPrcFlg = 0;
  int mbrProfitPrc = 0;
  int mbrTyp = 0;
  int msgFlg = 0;
  int popMsgFlg = 0;
  int buyPointLlimt1 = 0;
  double buyPointMagn1 = 0;
  int buyPointLlimt2 = 0;
  double buyPointMagn2 = 0;
  int buyPointLlimt3 = 0;
  double buyPointMagn3 = 0;
  int buyPointLlimt4 = 0;
  double buyPointMagn4 = 0;
  int anyprcTermLlimt1 = 0;
  double anyprcTermMagn1 = 0;
  int anyprcTermLlimt2 = 0;
  double anyprcTermMagn2 = 0;
  int anyprcTermLlimt3 = 0;
  double anyprcTermMagn3 = 0;
  int anyprcTermLlimt4 = 0;
  double anyprcTermMagn4 = 0;
  int anyprcTermRdwn = 0;
  int ptBonusLimit1 = 0;
  int ptAddBonus1 = 0;
  int ptBonusLimit2 = 0;
  int ptAddBonus2 = 0;
  int ptBonusLimit3 = 0;
  int ptAddBonus3 = 0;
  int ptBonusLimit4 = 0;
  int ptAddBonus4 = 0;
  int custStldscObjLimit = 0;
  int tdyPntLimit = 0;
  int custStldscLimit1 = 0;
  int custStldscLimit2 = 0;
  int custStldscLimit3 = 0;
  int custStldscLimit4 = 0;
  int custStldscLimit5 = 0;
  double custStldscRate1 = 0;
  double custStldscRate2 = 0;
  double custStldscRate3 = 0;
  double custStldscRate4 = 0;
  double custStldscRate5 = 0;
  int prom1Limit = 0;
  int prom2Limit = 0;
  int prom3Limit = 0;
  int prom4Limit = 0;
  int prom5Limit = 0;
  int prom6Limit = 0;
  int prom7Limit = 0;
  int prom8Limit = 0;
  int promCd1 = 0;
  int promCd2 = 0;
  int promCd3 = 0;
  int promCd4 = 0;
  int promCd5 = 0;
  int promCd6 = 0;
  int promCd7 = 0;
  int promCd8 = 0;
  int ptBonusLimit5 = 0;
  int ptAddBonus5 = 0;
  int ptBonusLimit6 = 0;
  int ptAddBonus6 = 0;
  int pntCalcUnit = 0;
  int pntUnit = 0;
  int crdtUnit = 0;
  int precaCalcUnit = 0;
  int selfAddpntObjLimit = 0;
  int promIssueLimit = 0;
  int promIssueNo = 0;
  int selfAutoPdscLimit = 0;
  int unionCnt = 0;
  int custStatus = 0;
  int ctrbutionTyp = 0;
  int outsideRbt = 0;
  int mbrprcFlg = 0;
  String lastVisitDate = "";
  String srchTelno = "";
  int custOfflineFlg = 0;
  int otherPoint = 0;
  int issueTcktNo = 0;
  int nombrmsgNo = 0;
  int mulrbtPrnAmt = 0;
  int mulrbtPnt = 0;
  String webrealsrvKangen = "";
  String webrealsrvFuyo = "";
  int clrttlpnt = 0;
  int mbrPrnFlg = 0;
  int mbrPrnName = 0;
  int mbrPrnAddr = 0;
  int mbrPrnTel = 0;
  int prizeWonFlg = 0;
  int webrealsrvExpPointPrn = 0;
  int webrealsrvExpPoint = 0;
  String webrealsrvExpDate = "";
  String webrealsrvOfflineCustno = "";
  int achievedFlg = 0;
  int achievedAmt = 0;
  int spzRwcWritePnt = 0;
  int partistBirthFlg = 0;
  int partistRealsvrSts = 0;
  int d1DcauMspur = 0;
  String nimocaNumber = "";
  int nimocaCardType = 0;
  int nimocaRctId = 0;
  int nimocaActCd = 0;
  int nimocaFlg = 0;
  int voidIccnclMsgFlg = 0;
  int usePntMagnLvl = 0;
  int deliveryHistFlg = 0;
  int crmFreqFlg = 0;
  int privatePntSvsTyp = 0;
  int privatePntSvsLimit = 0;
  int deletePoints = 0;
  int voidAcntPnt = 0;
  double rratePntPer = 0;
  int mbrPrcFlgBk = 0;
  int pointsBackup = 0;
  String orgNw7Code = "";
}

///  顧客ポイント利用
class T100701Sts {
  bool validFlg = false;
  int rvtMscFlg = 0;
  int tcktPrnAbFlg = 0;
}

///  顧客その他
class T100702Sts {
  bool validFlg = false;
  int tbamtRankCd = 0;
  int tbamtRewardTyp = 0;
  String tbamtRankName = "";
  int tbamtRankReward = 0;
  int tbamtNextRank = 0;
  String tbamtPromoExtId = "";
  int tbamtAcntId = 0;
  int tbamtJudgeAmt = 0;
}

///  Tクーポン発券
class T100712Sts {
  bool validFlg = false;
  int mbrFlg = 0;
  int shopFlg = 0;
  String text = "";
  int lowLim = 0;
}

///  Tポイント
class T100715Sts {
  bool validFlg = false;
  int couponCount = 0;
}

///  dポイント
class T100770Sts {
  bool validFlg = false;
  int dpntTranType = 0;
}

///  楽天ポイント
class T100790Sts {
  int investableFlg = 0;
  int useableFlg = 0;
  int investcancelableFlg = 0;
  int usecancelableFlg = 0;
  String inqResultcd = "";
  int cardStatus = 0;
  String msgText1 = "";
  String msgText2 = "";
  int pointHideFlg = 0;
  int commEndFlg = 0;
}

///  FSP
class T100800Sts {
  bool validFlg = false;
  int fspInfo = 0;
  int fspLvlTicket = 0;
  int custrealFspFirstRd = 0;
}

///  リライト
class T100900Sts {
  bool validFlg = false;
  int hesoFlg = 0;
  int pointSrvNo = 0;
  int rwTyp = 0;
  int rwcWriteFlg = 0;
  int wresTodayPoint = 0;
  int wresTotalPoint = 0;
  int wresRbtPoint = 0;
  int qcReadDcauMspur = 0;
  int qcReadDpntTtlsrv = 0;
  int qcReadDcauFsppur = 0;
}

///  日立ブルーチップ
class T100901Sts {
  bool validFlg = false;
  int qcReadBluechipFlg = 0;
}

///  プリカ
class T100902Sts {
  bool validFlg = false;
  int type = 0;
  int bizType = 0;
  String origCardNumber = "";
  String targetCardNumber = "";
  int targetCardValueBalance = 0;
  int targetCardChargeValueBalance = 0;
  int targetCardPremiumValueBalance = 0;
  int targetCardPresentValueBalance = 0;
  String expireYmd = "";
  String authNo = "";
  int cardNumMaskFg = 0;
  int cardNumMaskDigit = 0;
  String s1adjValue = "";
  int s1adjClass = 0;
  String s1bfrBalance = "";
  String s1aftBalance = "";
  String s1limitDate = "";
  String s2adjValue = "";
  int s2adjClass = 0;
  String s2bfrBalance = "";
  String s2aftBalance = "";
  String s2limitDate = "";
  String s3adjValue = "";
  int s3adjClass = 0;
  String s3bfrBalance = "";
  String s3aftBalance = "";
  String s3limitDate = "";
  String s4adjValue = "";
  int s4adjClass = 0;
  String s4bfrBalance = "";
  String s4aftBalance = "";
  String s4limitDate = "";
  String s5adjValue = "";
  int s5adjClass = 0;
  String s5bfrBalance = "";
  String s5aftBalance = "";
  String s5limitDate = "";
  String basicValuePremium = "";
  String thisAddPoint = "";
  String useBasicValue = "";
  String useBonusValue = "";
  String useCouponValue = "";
  String bfrTotalBalance = "";
  String useTotalValue = "";
  String aftTotalBalance = "";
  String lastTotalPoint = "";
  String thisTotalPoint = "";
  String sumTotalPoint = "";
  String issueBasicValue = "";
  String issueBonusValue = "";
  String issueCouponValue = "";
  String issueBonusPoint = "";
  String thisMonthValue = "";
  String saleMsg1 = "";
  String saleMsg2 = "";
  String saleMsg3 = "";
  String saleMsg4 = "";
}

///  プロモーション
class T101000Sts {
  bool validFlg = false;
  int promNo = 0;
}

///  発行プロモーション
class T101001Sts {
  bool validFlg = false;
  String dscName = "";
  String priShortName = "";
  String useShortName = "";
}

///  買上追加
class T101100Sts {
  bool validFlg = false;
  int bonuspoint = 0;
}

///  スケジュール反映
class T102500Sts {
  bool validFlg = false;
  int reflectTyp = 0;
  int reflectSchCd = 0;
  int reflectCd = 0;
  double reflectVal = 0;
  double acntCd = 0;
  String promoExtId = "";
  int lowLim = 0;
}

///  サービス分類
class T102501Sts {
  bool validFlg = false;
  double pointAddMagn = 0;
  int pointAddMemTyp = 0;
  int acctCd = 0;
}

///  釣準備
class T105000Sts {
  bool validFlg = false;
  int mny10000Sht = 0;
  int mny5000Sht = 0;
  int mny2000Sht = 0;
  int mny1000Sht = 0;
  int mny500Sht = 0;
  int mny100Sht = 0;
  int mny50Sht = 0;
  int mny10Sht = 0;
  int mny5Sht = 0;
  int mny1Sht = 0;
  int chgInoutAmt = 0;
}

///  売上回収
class T105100Sts {
  bool validFlg = false;
  int short10000Sht = 0;
  int short5000Sht = 0;
  int short2000Sht = 0;
  int short1000Sht = 0;
  int short500Sht = 0;
  int short100Sht = 0;
  int short50Sht = 0;
  int short10Sht = 0;
  int short5Sht = 0;
  int short1Sht = 0;
  int cpickAmt = 0;
  int cpickCassette = 0;
  int cpickErrno = 0;
  int drwchkPickFlg = 0;
  int cpickType = 0;
  int kindoutPrnFlg = 0;
  int kindoutPrnStat1 = 0;
  int kindoutPrnStat2 = 0;
  int kindoutPrnStat3 = 0;
  int kindoutPrnStat4 = 0;
  int kindoutPrnStat5 = 0;
  int kindoutPrnStat6 = 0;
  int kindoutPrnStat7 = 0;
  int kindoutPrnStat8 = 0;
  int kindoutPrnStat9 = 0;
  int kindoutPrnStat10 = 0;
  int kindoutPrnErrno1 = 0;
  int kindoutPrnErrno2 = 0;
  int kindoutPrnErrno3 = 0;
  int kindoutPrnErrno4 = 0;
  int kindoutPrnErrno5 = 0;
  int kindoutPrnErrno6 = 0;
  int kindoutPrnErrno7 = 0;
  int kindoutPrnErrno8 = 0;
  int kindoutPrnErrno9 = 0;
  int kindoutPrnErrno10 = 0;
  int resv10000Sht = 0;
  int resv5000Sht = 0;
  int resv2000Sht = 0;
  int resv1000Sht = 0;
  int resv500Sht = 0;
  int resv100Sht = 0;
  int resv50Sht = 0;
  int resv10Sht = 0;
  int resv5Sht = 0;
  int resv1Sht = 0;
  int resvDrw500Sht = 0;
  int resvDrw100Sht = 0;
  int resvDrw50Sht = 0;
  int resvDrw10Sht = 0;
  int resvDrw5Sht = 0;
  int resvDrw1Sht = 0;
  int mny10000Sht = 0;
  int mny5000Sht = 0;
  int mny2000Sht = 0;
  int mny1000Sht = 0;
  int mny500Sht = 0;
  int mny100Sht = 0;
  int mny50Sht = 0;
  int mny10Sht = 0;
  int mny5Sht = 0;
  int mny1Sht = 0;
  int chgInoutAmt = 0;
}

///  入金
class T105200Sts {
  bool validFlg = false;
// #if 0
// int	recycleFlg = 0;
// String	recycleNo = "";
//
  int mny10000Sht = 0;
  int mny5000Sht = 0;
  int mny2000Sht = 0;
  int mny1000Sht = 0;
  int mny500Sht = 0;
  int mny100Sht = 0;
  int mny50Sht = 0;
  int mny10Sht = 0;
  int mny5Sht = 0;
  int mny1Sht = 0;
  int chgInoutAmt = 0;
// #if 0
// int	cashRecycleMacNo1 = 0;
// int	cashRecycleMacNo2 = 0;
// int	cashRecycleMacNo3 = 0;
// int	cashRecycleDiff = 0;
// int	cashRecycle10000Sht = 0;
// int	cashRecycle5000Sht = 0;
// int	cashRecycle2000Sht = 0;
// int	cashRecycle1000Sht = 0;
// int	cashRecycle500Sht = 0;
// int	cashRecycle100Sht = 0;
// int	cashRecycle50Sht = 0;
// int	cashRecycle10Sht = 0;
// int	cashRecycle5Sht = 0;
// int	cashRecycle1Sht = 0;
//
  String divName = "";
  int tendData = 0;
  int chgData = 0;
}

///  支払
class T105300Sts {
  bool validFlg = false;
// #if 0
// int	recycleFlg = 0;
// String	recycleNo = "";
//
  int mny10000Sht = 0;
  int mny5000Sht = 0;
  int mny2000Sht = 0;
  int mny1000Sht = 0;
  int mny500Sht = 0;
  int mny100Sht = 0;
  int mny50Sht = 0;
  int mny10Sht = 0;
  int mny5Sht = 0;
  int mny1Sht = 0;
  int chgInoutAmt = 0;
//#if 0
// int	cashRecycleMacNo1 = 0;
// int	cashRecycleMacNo2 = 0;
// int	cashRecycleMacNo3 = 0;
// int	cashRecycle10000Sht = 0;
// int	cashRecycle5000Sht = 0;
// int	cashRecycle2000Sht = 0;
// int	cashRecycle1000Sht = 0;
// int	cashRecycle500Sht = 0;
// int	cashRecycle100Sht = 0;
// int	cashRecycle50Sht = 0;
// int	cashRecycle10Sht = 0;
// int	cashRecycle5Sht = 0;
// int	cashRecycle1Sht = 0;
//
  String divName = "";
}

///  両替
class T105400Sts {
  bool validFlg = false;
  int bfreSht10000 = 0;
  int bfreSht5000 = 0;
  int bfreSht2000 = 0;
  int bfreSht1000 = 0;
  int bfreSht500 = 0;
  int bfreSht100 = 0;
  int bfreSht50 = 0;
  int bfreSht10 = 0;
  int bfreSht5 = 0;
  int bfreSht1 = 0;
  int aftrSht10000 = 0;
  int aftrSht5000 = 0;
  int aftrSht2000 = 0;
  int aftrSht1000 = 0;
  int aftrSht500 = 0;
  int aftrSht100 = 0;
  int aftrSht50 = 0;
  int aftrSht10 = 0;
  int aftrSht5 = 0;
  int aftrSht1 = 0;
}

///  One to One プロモーション
class T106000Sts {
  bool validFlg = false;
  int schTyp = 0;
  int rewardVal = 0;
  int dscVal = 0;
  int svsTyp = 0;
  int lowLimit = 0;
  int recLimit = 0;
  int dayLimit = 0;
  int maxLimit = 0;
  int recBuyLimit = 0;
  int tdayCnt = 0;
  int totalCnt = 0;
  int allCustFlg = 0;
  String templateId = "";
  String prnTgtMsg1 = "";
  String prnTgtMsg2 = "";
  String prnTgtMsg3 = "";
  String prnTgtMsg4 = "";
  String prnTgtMsg5 = "";
  int prnSeqNo = 0;
  int prnFlg = 0;
  int stopReadFlg = 0;
  double mulVal = 0;
  int rewardFlg = 0;
  String loyBcd = "";
  int lowLim = 0;
  int uppLim = 0;
  int valFlg = 0;
  int refTyp = 0;
  int bcdEffFlg = 0;
  int stpAcctCd = 0;
  int stpRedAmt = 0;
  int invalidFlg = 0;
  String stpCpnId = "";
  int readBcdQty = 0;
  String custKindTrgt = "";
  int schTyp2 = 0;
  int payKeyCd = 0;
}

///  スタンプカード
class T106100Sts {
  bool validFlg = false;
  int allCustFlg = 0;
  String prnTime = "";
  String cData1 = "";
  String cData2 = "";
  String cData4 = "";
  int refUnitFlg = 0;
  int condClassFlg = 0;
  int tdayAccAmt = 0;
  int totalAccAmt = 0;
  int totalRedAmt = 0;
  int lowLim = 0;
  int uppLim = 0;
  int recLimit = 0;
  int dayLimit = 0;
  int maxLimit = 0;
  String rcptName = ""; //  企画名称
  String cpnId = ""; //  クーポンＩＤ
  int formatFlg = 0;
}

///  お得情報発行
class T106500Sts {
  bool validFlg = false;
  int cpnPrnRes = 0;
}

///  プロモーションクーポン発行
class T106501Sts {
  bool validFlg = false;
  int allCustFlg = 0;
  int valFlg = 0;
  int prnLowLim = 0;
  int prnUppLim = 0;
  int prnQty = 0;
  int tranQty = 0;
  int dayQty = 0;
  int ttlQty = 0;
  int tdayCnt = 0;
  int totalCnt = 0;
  int refTyp = 0;
  int bcdEffFlg = 0;
  int stpAcctCd = 0;
  int stpRedAmt = 0;
  int sngPrnFlg = 0;
  String stpCpnId = "";
  String recSrchId = "";
}

///  ポイントアカウント
class T107000Sts {
  bool validFlg = false;
  String acntName = "";
  String acntStartDatetime = "";
  String acntEndDatetime = "";
  String acntPlusEndDatetime = "";
  int prnSeqNo = 0;
  int rcptPrntFlg = 0;
  int acntTyp = 0;
  int linkNum = 0;
  int link2Id = 0;
  int link3Id = 0;
  int link4Id = 0;
  int link5Id = 0;
  int acntLastReward = 0;
  int acntItemTtlpnt = 0;
  int acntCalTyp = 0;
}

///  免税
class T109000Sts {
  bool validFlg = false;
  int taxfreeFlg = 0;
  int taxfreeRecordFlg = 0; //記録票・誓約書印字フラグ
}
