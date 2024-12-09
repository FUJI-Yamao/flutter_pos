/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
/// 関連tprxソース:c_itemlog_sts.h

///  商品登録情報１：ステータスデータ
class T10000Sts {
  bool validFlg = false;
  int outMdlclsFlg = 0;
  int btlRet1Flg = 0;
  int inputMthdFlg = 0;
  int urgencyFlg = 0;
  bool corrFlg = false;
  int voidFlg = 0;
  int refundFlg = 0;
  int stldscObjFlg = 0;
  int costFlg = 0;
  double orderCostPrc = 0;
  double brgnCostPrc = 0;
  double clsCostPer = 0;
  double brgnCostPer = 0;
  int fspCd = 0;
  String skuPackDatetime = "";
  String skuSellDatetime = "";
  String skuUseDatetime = "";
  int guaranteeSht = 0;
  int guaranteeNo = 0;
  int prcChgPflg = 0;
  int promCd = 0;
  int promDscFlg = 0;
  int couprnAmt = 0;
  int periodSalePrc = 0;
  int bc1itemQty = 0;
  int clsSaveFlg = 0;
  int exchgIssueObjFlg = 0;
  int clothingFlg = 0;
  int clsdscFlg = 0;
  int promCd1 = 0;
  int promCd2 = 0;
  int promCd3 = 0;
  int opeFlg = 0;
  int itemDscFlg = 0;
  int sepaFlg = 0;
  int beleFlg = 0;
  int maxPrc = 0;
  int minPrc = 0;
  int msgFlg = 0;
  int popMsgFlg = 0;
  int drugSaleFlg = 0;
  int supplyCd = 0;
  int loyPromItemCnt = 0;
  int acntCnt = 0;
  int stlplusObjFlg = 0;
  int pntObjItemFlg = 0;
  int periodObjItemFlg = 0;
  int taxChgBeforeTaxCd = 0;
  int taxChgBeforeTaxTyp = 0;
  double taxChgBeforeTaxPer = 0;
  int taxChgKyCd = 0;
  int detailNoprnFlg = 0;
  int available2 = 0;
  int available3 = 0;
  int available4 = 0;
  int available5 = 0;
  int available6 = 0;
  int available7 = 0;
  int available8 = 0;
  int available9 = 0;
  int available10 = 0;
  int available11 = 0;
  int available12 = 0;
  int liqrTaxfreeFlg = 0;
  double available14 = 0;
  int taxfreeTaxExemptionFlg = 0;
  int dlvFlg = 0;
  int tcpnDscFlg = 0;
  int revenueStampNotCoveredFlg = 0;
  int makerCd = 0;
  int certificateTyp = 0;
  int promRefVal = 0;
  int loyCondItemCnt = 0;
  int cpnCondItemCnt = 0;
  int chgselectitemsMrateFlg = 0;
  int markItemFlg = 0;
  int sagTranSts = 0;
  int sagItemSts = 0;
  int loyLimitOverRegFlg = 0;
  int loyUnvalidFlg = 0;
  int recSplitCnt = 0;
  int nonScrvoidFlg = 0;
  int stpCondItemCnt = 0;
  int rrateFlg = 0;
  int crateFlg = 0;
  String sagPluCd = "";
  int rm38DscPrc = 0;
  int rm38DscAmt = 0;
  String sagItemId = "";
  int alertPluFlg = 0;
  int rm38ItemDscPrc = 0;
  int rm38ItemPrc = 0;
  int cardForgetStreCd = 0;
  int cardForgetMacNo = 0;
  int cardForgetReceiptNo = 0;
  int cardForgetPrintNo = 0;
}

///  商品登録情報２：ステータスデータ
class T10001Sts {
  bool validFlg = false;
  int decPntItem = 0;
  String orgId = "";
  String cpnBarCd = "";
  String kuroganeReservNo = "";

  /// 酒税免税関連
  int liqritemCd = 0;
  String liqritemName = "";
  int liqrtaxCd = 0;
  int liqrtaxRate = 0;
  int btlCapa = 0;
  double alcoholPer = 0;
  int liqrtaxAmt = 0;

  /// 酒税免税関連
  double dpntRbtPer = 0; // dポイント倍率
  int dpntRbtFlg = 0; // dポイント倍率表示対象フラグ
}

///  商品登録情報３：ステータスデータ
class T10002Sts {
  bool validFlg = false;
  bool scrvoidFlg = false;
  int refImgNo = 0;
  int voidImgNo = 0;
  int scrpImgNo = 0;
}

///  特売：ステータスデータ
class T10100Sts {
  bool validFlg = false;
  String brgnName = "";
  String brgnStartDatetime = "";
  String brgnEndDatetime = "";
  int ubrgnDsc = 0;
  int umbrbrgnDsc = 0;
  String prgPlanCd = "";
  int prgPromCd = 0;
  int prgSchTyp = 0;
  String prgPromName = "";
  String prgStartDatetime = "";
  String prgEndDatetime = "";
  String prgPromoExtId = "";
  int prgLowLimit = 0;
  String prgCustPlanCd = "";
  int prgCustPromCd = 0;
  int prgCustSchTyp = 0;
  String prgCustPromName = "";
  String prgCustStartDatetime = "";
  String prgCustEndDatetime = "";
  String prgCustPromoExtId = "";
  int prgCustLowLimit = 0;
}

///  分類値下：ステータスデータ
class T10500Sts {
  bool validFlg = false;
  String clsdscName = "";
  String clsdscStartDatetime = "";
  String clsdscEndDatetime = "";
  int uclsPrgDscAmt = 0;
  double uclsPrgPdscPer = 0;
  int uclsDscAmt = 0;
  int ucMprgDscAmt = 0;
  double ucMprgPdscPer = 0;
  int umcDscAmt = 0;
  String prgPlanCd = "";
  int prgPromCd = 0;
  String prgPromName = "";
  String prgPromoExtId = "";
  String prgCustPlanCd = "";
  int prgCustPromCd = 0;
  String prgCustPromName = "";
  String prgCustPromoExtId = "";
  String prgStartDatetime = "";
  String prgEndDatetime = "";
  int prgLowLimit = 0;
  String prgCustStartDatetime = "";
  String prgCustEndDatetime = "";
  int prgCustLowLimit = 0;
}

///  重量値下：ステータスデータ
class T10700Sts {
  bool validFlg = false;
  int itemUprcChgFlg = 0;
}

///  ミックスマッチ：ステータスデータ
class T10800Sts {
  bool validFlg = false;
  String bdlName = "";
  String bdlStartDatetime = "";
  String bdlEndDatetime = "";
  int bdlTyp = 0;
  int bdlMark = 0;
  int bdlFormAmt1 = 0;
  int bdlFormQty1 = 0;
  int bdlFormCnt1 = 0;
  int bdlFormAmt2 = 0;
  int bdlFormQty2 = 0;
  int bdlFormCnt2 = 0;
  int bdlFormAmt3 = 0;
  int bdlFormQty3 = 0;
  int bdlFormCnt3 = 0;
  int bdlFormAmt4 = 0;
  int bdlFormQty4 = 0;
  int bdlFormCnt4 = 0;
  int bdlFormAmt5 = 0;
  int bdlFormQty5 = 0;
  int bdlFormCnt5 = 0;
  int bdlFormAmtAv = 0;
  int bdlFormQtyAv = 0;
  int bdlFormCntAv = 0;
  int bdlDscAmt1 = 0;
  int bdlDscAmt2 = 0;
  int bdlDscAmt3 = 0;
  int bdlDscAmt4 = 0;
  int bdlDscAmt5 = 0;
  int bdlDscAmtAv = 0;
}

///  セットマッチ：ステータスデータ
class T10900Sts {
  bool validFlg = false;
  String stmName = "";
  String stmStartDatetime = "";
  String stmEndDatetime = "";
  int stmTyp = 0;
  int stmMark = 0;
  int drwCd = 0;
}

///  セットマッチ：ステータスデータ
class T10901Sts {
  bool validFlg = false;
  String stmName = "";
  String stmStartDatetime = "";
  String stmEndDatetime = "";
  int stmTyp = 0;
  int stmMark = 0;
  int drwCd = 0;
}

///  セットマッチ：ステータスデータ
class T10902Sts {
  bool validFlg = false;
  String stmName = "";
  String stmStartDatetime = "";
  String stmEndDatetime = "";
  int stmTyp = 0;
  int stmMark = 0;
  int drwCd = 0;
}

///  セットマッチ：ステータスデータ
class T10903Sts {
  bool validFlg = false;
  String stmName = "";
  String stmStartDatetime = "";
  String stmEndDatetime = "";
  int stmTyp = 0;
  int stmMark = 0;
  int drwCd = 0;
}

///  セットマッチ：ステータスデータ
class T10904Sts {
  bool validFlg = false;
  String stmName = "";
  String stmStartDatetime = "";
  String stmEndDatetime = "";
  int stmTyp = 0;
  int stmMark = 0;
  int drwCd = 0;
}

///  セットマッチ：ステータスデータ
class T10905Sts {
  bool validFlg = false;
  String stmName = "";
  String stmStartDatetime = "";
  String stmEndDatetime = "";
  int stmTyp = 0;
  int stmMark = 0;
  int drwCd = 0;
}

///  顧客：ステータスデータ
class T11100Sts {
  bool validFlg = false;
  double rbtPer = 0;
  int fspLvl = 0;
  int upluPoint = 0;
  int mbrInput = 0;
  int uiMprgDscAmt = 0;
  int uiMprgPdscPer = 0;
  int uiMdscAmt = 0;
  int mCancel = 0;
  int mbrcnclDscflg = 0;
  int custDtlFlg = 0;
  int uonePdscPer = 0;
  String pntAddName = "";
  String pntAddPromoExtId = "";
  double subRbtPer = 0;
}

///  商品倍率ポイント：ステータスデータ
class T11101Sts {
  bool validFlg = false;
  double pluPtsRate = 0;
  int pluClsFlg = 0;
}

///  One to Oneプロモーション：ステータスデータ
class T11200Sts {
  bool validFlg = false;
  int schTyp = 0;
  int rewardVal = 0;
  int svsTyp = 0;
  int lowLimit = 0;
  int recLimit = 0;
  int dayLimit = 0;
  int maxLimit = 0;
  int recBuyLimit = 0;
  int tdayCnt = 0;
  int totalCnt = 0;
  int allCustFlg = 0;
  int prnLoyCnt = 0;
  double val = 0;
  int promAplFlg = 0;
  int subLoyCnt = 0;
}

///  One to One プロモーション条件：ステータスデータ
class T11210Sts {
  bool validFlg = false;
  String cpnId = "";
  int promRefFlg = 0;
  int excludeFlg = 0;
}

///  クーポンプロモーション条件：ステータスデータ
class T11211Sts {
  bool validFlg = false;
  String cpnId = "";
  int promRefFlg = 0;
}

///  スタンプカード条件：ステータスデータ
class T11212Sts {
  bool validFlg = false;
  String cpnId = "";
  int promRefFlg = 0;
}

///  ポイントアカウント：ステータスデータ
class T11300Sts {
  bool validFlg = false;
  int acntTyp = 0;
}

///  小計値下：ステータスデータ
class T50100Sts {
  bool validFlg = false;
  int stldscFlg = 0;
  int nonEffectFlg = 0;
  int stldscCnclAmt = 0;
}

///  One to One バーコード：ステータスデータ
class T50500Sts {
  bool validFlg = false;
  int schTyp = 0;
  int svsTyp = 0;
  int recLimit = 0;
  int dayLimit = 0;
  int maxLimit = 0;
  int allCustFlg = 0;
  int lowLim = 0;
  int uppLim = 0;
  int valFlg = 0;
  int refTyp = 0;
}

///  免税情報：ステータスデータ
class T90000Sts {
  bool validFlg = false;
  int taxfreeOrgFlg = 0;
  int taxfreeOrgUusePrc = 0;
  int taxfreeOrgUPrc = 0;
  int taxfreeOrgUcustPrc = 0;
  int taxfreeOrgUbrgnPrc = 0;
  int taxfreeOrgUbrgncustPrc = 0;
  int taxfreeOrgUmalPrc = 0;
  int taxfreeOrgUclsPrc = 0;
  int taxfreeOrgExTabl = 0;
  int taxfreeOrgInTabl = 0;
  int taxfreeOrgExTaxAmt = 0;
  int taxfreeOrgInTaxAmt = 0;
  int taxfreeOrgTaxCd = 0;
  int taxfreeOrgTaxTyp = 0;
  double taxfreeOrgTaxPer = 0;
}
