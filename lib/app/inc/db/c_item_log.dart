/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///  MEMO:validFlg short->bool
///
/// FNo.10000 : 登録商品情報1
/// 関連tprxソース:c_itemlog.h
class T10000 {
  bool validFlg = false;
  String pluCd1_1 = "";
  String pluCd1_2 = "";
  String condPluCd = "";
  String posName = "";
  String eosCd = "";
  int lrgclsCd = 0;
  int lrgclsCust = 0;
  int mdlclsCd = 0;
  int mdlclsCust = 0;
  int smlclsCd = 0;
  int smlclsCust = 0;
  int tnyclsCd = 0;
  int tnyclsCust = 0;
  int pluCust = 0;
  int realQty = 0;
  int itemTtlQty = 0;
  int itemScanQty = 0;
  double prftPrc = 0;
  int actNomiInPrc = 0;
  int taxCd = 0;
  int exTabl = 0;
  int inTabl = 0;
  int noTabl = 0;
  int exTaxAmt = 0;
  int inTaxAmt = 0;
  int periodPrcchgDsc = 0;
  int bcActSht = 0;
  int tActnomiPrc = 0;
  int tIntaxAmt = 0;
  int dIntaxAmt = 0;
  int itemWgt = 0;
  int exTaxBfrAmt = 0;
  int taxTyp = 0;
  double taxPer = 0;
  int oddFlg = 0;
  String orderDate = "";
  String arrivalDate = "";
  String mdlclsName = ""; //中分類名称
  String smlclsName = ""; //小分類名称
}

///  FNo.10001 : 登録商品情報2
class T10001 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String pluCd2_1 = "";
  String pluCd2_2 = "";
  String skuCd2 = "";
  String skuCd = "";
  String casePluCd = "";
  String msgName = "";
  int wgt = 0;
  int caseItemQty = 0;
  int caseDscAmt = 0;
  int exInTabl = 0;
  int skuFreshAmt = 0;
  int cpnQty = 0;
  int cpnAmt = 0;
  int cpnQty2 = 0;
  int cpnAmt2 = 0;
  int prodCd = 0;
  int prodQty = 0;
  int prodAmt = 0;
  int kindCd = 0;
  int divCd = 0;
  int ecFlg = 0;
  int usedpluFlg = 0;
  int ecOfflineFlg = 0;
  int taxFreeAmt = 0;
  int drugFlg = 0;
  int otcFlg = 0;
  int prescriptionFlg = 0;
  int freeItemCnclFlg = 0;
  int depotBtlId = 0;
  int liqrtaxTtlCapa = 0;
  int liqrtaxFreeAmt = 0;
}

///  FNo.10002 : 登録商品情報3
class T10002 {
  bool validFlg = false;
  String pluCd1_2 = "";
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
  bool scrvoidFlg = false;
  int voidObjQty = 0;
  int sub1LrgCd = 0;
  int sub1LrgCust = 0;
  int sub1MdlCd = 0;
  int sub1MdlCust = 0;
  int sub1SmlCd = 0;
  int sub1SmlCust = 0;
  int sub2LrgCd = 0;
  int sub2LrgCust = 0;
  int sub2MdlCd = 0;
  int sub2MdlCust = 0;
  int sub2SmlCd = 0;
  int sub2SmlCust = 0;
  int discCd = 0;
  int discCust = 0;
}

///  FNo.10003 : 登録商品情報4（商品登録時生成）
class T10003 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String largePluCd = "";
  int uusePrc = 0;
  int uInstructPrc = 0;
  int uPrc = 0;
  int ucustPrc = 0;
  int ubrgnPrc = 0;
  int ubrgncustPrc = 0;
  int umalPrc = 0;
  int uclsPrc = 0;
  int uusePrcFlg = 0;
  int actNomiPrc = 0;
  int dscPrc2 = 0;
  int uonePrc = 0;
  int ucMprc = 0;
  int uskuDscPrc = 0;
  int umulSPrc = 0;
  int umulAPrc = 0;
  int umulBPrc = 0;
  int umulCPrc = 0;
  int umulDPrc = 0;
  int stldscPdamt = 0;
  int stlnmdscPdamt = 0;
  int stlcrdtdscAmt = 0;
  int stlplusPdamt = 0;
  int stlmbrdscPdamt = 0;
  int itemTyp = 0;
  int barFormatFlg = 0;
  int itemKind = 0;
  int recMthdFlg = 0;
  double costPrc = 0;
  int realTaxAmt = 0;
}

/// FNo.10004 : 登録商品情報4（仮登録時発生）
class T10004 {
  bool validFlg = false;
  String pluCd1_1 = "";
  String pluCd1_2 = "";
  String posName = "";
  int lrgclsCd = 0;
  int mdlclsCd = 0;
  int smlclsCd = 0;
  int tnyclsCd = 0;
  int uPrc = 0;
  int taxCd = 0;
}

///  FNo.10100 : 特売
class T10100 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String brgnPlanCd = "";
  String promoExtId = "";
  int brgnCd = 0;
  int brgnTyp = 0;
  int trendsTyp = 0;
  int brgnQty = 0;
  int brgnDscAmt = 0;
  int mbrgncustQty = 0;
  int mbrgnDscAmt = 0;
  int bgPchgAmt = 0;
  int bgPchgQty = 0;
}

///  FNo.10200 : 値引
class T10200 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int itemDscCd = 0;
  int itemDscQty = 0;
  int itemDscAmt = 0;
  int itemUdscPrc = 0;
}

///  FNo.10300 : 割引
class T10300 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int itemPdscCd = 0;
  int itemPdscQty = 0;
  int itemPdscAmt = 0;
  int itemUpdscPrc = 0;
  int itemDscPer = 0;
  int exchgQty = 0;
  int exchgPnt = 0;
}

/// 売価変更.
class T10400 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String itemPrcChgReasonName = "";
  int itemPrcChgFlg = 0;
  int itemPrcChgReasonCd = 0;
  int itemPrcChgQty = 0;
  int itemPrcChgAmt = 0;
  int itemUprcChgPrc = 0;
}

///  FNo.10500 : 分類値下
class T10500 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String clsPlanCd = "";
  String promoExtId = "";
  int clsSchcd = 0;
  int trendsTyp = 0;
  int clsDscFlg = 0;
  int clsDscQty = 0;
  int clsDscAmt = 0;
}

///  FNo.10700 : 重量値下
class T10700 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int itemUprcChgQty = 0;
  int itemUprcChgAmt = 0;
  int umalUprc = 0;
}

///  FNo.10800 : ミックスマッチ
class T10800 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String ichiCd1 = "";
  String ichiCd2 = "";
  String ichiCd3 = "";
  String bdlPlanCd = "";
  String promoExtId = "";
  int bdlCd = 0;
  int bdlFlg = 0;
  int trendsTyp = 0;
  int bdlDscQty = 0;
  int bdlDscPdamt = 0;
  int bdlFormCnt = 0;
  int bdlFormQty = 0;
  int bdlFormAmt = 0;
  int bdlDscAmt = 0;
}

///  FNo.10900 : セットマッチ
class T10900 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String stmPlanCd = "";
  String promoExtId = "";
  int stmCd = 0;
  int stmFlg = 0;
  int trendsTyp = 0;
  int stmGrpCd = 0;
  int stmDscQty = 0;
  int stmDscPdamt = 0;
  int stmFormCnt = 0;
  int stmFormQty = 0;
  int stmFormAmt = 0;
  int stmDscAmt = 0;
}

///  FNo.10901 : セットマッチ
class T10901 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String stmPlanCd = "";
  String promoExtId = "";
  int stmCd = 0;
  int stmFlg = 0;
  int trendsTyp = 0;
  int stmGrpCd = 0;
  int stmDscQty = 0;
  int stmDscPdamt = 0;
  int stmFormCnt = 0;
  int stmFormQty = 0;
  int stmFormAmt = 0;
  int stmDscAmt = 0;
}

///  FNo.10902 : セットマッチ
class T10902 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String stmPlanCd = "";
  String promoExtId = "";
  int stmCd = 0;
  int stmFlg = 0;
  int trendsTyp = 0;
  int stmGrpCd = 0;
  int stmDscQty = 0;
  int stmDscPdamt = 0;
  int stmFormCnt = 0;
  int stmFormQty = 0;
  int stmFormAmt = 0;
  int stmDscAmt = 0;
}

///  FNo.10903 : セットマッチ
class T10903 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String stmPlanCd = "";
  String promoExtId = "";
  int stmCd = 0;
  int stmFlg = 0;
  int trendsTyp = 0;
  int stmGrpCd = 0;
  int stmDscQty = 0;
  int stmDscPdamt = 0;
  int stmFormCnt = 0;
  int stmFormQty = 0;
  int stmFormAmt = 0;
  int stmDscAmt = 0;
}

///  FNo.10904 : セットマッチ
class T10904 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String stmPlanCd = "";
  String promoExtId = "";
  int stmCd = 0;
  int stmFlg = 0;
  int trendsTyp = 0;
  int stmGrpCd = 0;
  int stmDscQty = 0;
  int stmDscPdamt = 0;
  int stmFormCnt = 0;
  int stmFormQty = 0;
  int stmFormAmt = 0;
  int stmDscAmt = 0;
}

///  FNo.10905 : セットマッチ
class T10905 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String stmPlanCd = "";
  String promoExtId = "";
  int stmCd = 0;
  int stmFlg = 0;
  int trendsTyp = 0;
  int stmGrpCd = 0;
  int stmDscQty = 0;
  int stmDscPdamt = 0;
  int stmFormCnt = 0;
  int stmFormQty = 0;
  int stmFormAmt = 0;
  int stmDscAmt = 0;
}

///  FNo.11000 : 会員売価
class T11000 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int mpriQty = 0;
  int mpriDscAmt = 0;
}

///  FNo.11100 : 顧客
class T11100 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String pluAddPlanCd = "";
  String promoExtId = "";
  int iSchcd = 0;
  int trendsTyp = 0;
  int iMDscFlg = 0;
  int iMdscQty = 0;
  int iMdscAmt = 0;
  int acntId = 0;
  int rbtPurAmt = 0;
  int mulRbtPurAmt = 0;
  int rbtAmt = 0;
  int pluPointTtl = 0;
  int divPpoint = 0;
  int bnsdscPdamt = 0;
  int oneDscFlg = 0;
  int oneDscAmt = 0;
}

///  FNo.11101 : 商品倍率ポイント
class T11101 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String pluPerPlanCd = "";
  String promoExtId = "";
  int iPerSchcd = 0;
  int acntId = 0;
  int pluMulPts = 0;
}

///  FNo.11200 : One to Oneプロモーション
class T11200 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String cpnId = "";
  String loyPlanCd = "";
  String promoExtId = "";
  int loyCnt = 0;
  int acntId = 0;
  int loyAmt = 0;
  int loyDscAmt = 0;
  int loyPdscAmt = 0;
  int loyPrcdscAmt = 0;
  int loyPnt = 0;
  int loyCpnKind = 0;
  int loySvsKind = 0;
  double loyPtsRate = 0;
  int custCardKind = 0;
}

///  FNo.11300 : ポイントアカウント
class T11300 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String promoExtId = "";
  int acntId = 0;
  int mthrAcntId = 0;
  int acntPnt = 0;
  int acntAmt = 0;
  int acntQty = 0;
}

///  FNo.11400 : 小計値下案分額
class T11400 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int stldscpdCd = 0;
  int trendsTyp = 0;
  int stldscPddtlAmt = 0;
}

///  FNo.11500 : 小計値上案分額
class T11500 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int stlpluspdCd = 0;
  int trendsTyp = 0;
  int stlplusPddtlAmt = 0;
}

///  FNo.11600 : Tクーポン値下
class T11600 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int pctDscAmt = 0;
  int fixedDscAmt = 0;
}

///  FNo.11700 : プロモーション小計値下案分額
class T11700 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String cpnId = "";
  String loyPlanCd = "";
  String promoExtId = "";
  int svsTyp = 0;
  int stldscAmt = 0;
}

///  FNo.12100 : dポイント
class T12100 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int dpntPurAddamt = 0;
  int dpntOneitemAddpnt = 0;
  int dpntPluaddPnt = 0;
  int dpntPurUseamt = 0;
  int dpntRbttargetFlg = 0;
  int dpntUsetargetFlg = 0;
}

///  FNo.12200 : 楽天ポイント
class T12200 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int rbtTargetAmt = 0;
}

///  FNo.12300 : Tポイント
class T12300 {
  bool validFlg = false;
  String pluCd1_2 = "";
  int rbtTargetAmt = 0;
}

///  FNo.50100 : 小計値下
class T50100 {
  bool validFlg = false;
  String stldscPlanCd = "";
  String promoExtId = "";
  int stldscCd = 0;
  int trendsTyp = 0;
  int stldscCnt = 0;
  int stldscObjAmt = 0;
  int stlPdscPer = 0;
  int stldscAmt = 0;
}

///  FNo.50200 : 顧客値下
class T50200 {
  bool validFlg = false;
  int rbtInputAmt = 0;
}

///  FNo.50300 : 小計値上
class T50300 {
  bool validFlg = false;
  String stldscPlanCd = "";
  String promoExtId = "";
  int stlplusCd = 0;
  int trendsTyp = 0;
  int stlplusCnt = 0;
  int stlplusPer = 0;
  int stlplusPrc = 0;
}

///  FNo.50400 : スタンプ
class T50400 {
  bool validFlg = false;
  String pluCd1_2 = "";
  String promoExtId = "";
  int stampCd = 0;
  int stampCust = 0;
  int stampPnt = 0;
  int acntId = 0;
  int reptExceptFlg = 0;
}

///  FNo.50500 : One to One バーコード
class T50500 {
  bool validFlg = false;
  String barcode = "";
  String promName = "";
  String cpnId = "";
  String loyPlanCd = "";
  int validCpnCnt = 0;
  int custCardKind = 0;
  int extFlg = 0;
  int cpnNo = 0;
}

///  FNo.50600 : Tクーポン
class T50600 {
  bool validFlg = false;
  String promNo = "";
  String janCd = "";
  int retType = 0;
  int cpnNo = 0;
  int cpnTypeVal = 0;
  int tcpnLowLimit = 0;
  int tcpnClass = 0;
  int tcpnType = 0;
  int acctCd = 0;
  int pts = 0;
  int dscAmt = 0;
}

///  FNo.11800 : ワールドスポーツ1
class T11800 {
  String pluCd1_2 = "";
  int royaltyMemberDiv = 0; //  施策会員区分フラグ
  int loyDscAmt = 0; //  単品値引額
  int loyPdscAmt = 0; //  単品割引額
  double basePointPer = 0; //  基底倍率
  double loyPointPer = 0; //  施策ポイント倍率
  int pointUseAmt = 0; //  ポイント値引額
  int exDscAmt = 0; //  外税商品の値引額
  int exTaxDscAmt = 0; //  外税商品の小計税値引額
  int exRbtDscAmt = 0; //  外税商品の割戻税値引額
}

///  FNo.11900 : ワールドスポーツ（EC関連）
class T11900 {
  String jancd = ""; //  janコード
  String hinkj = ""; //  品名
  String kbnzks1 = ""; //  区分属性１
  String kbnzks2 = ""; //  区分属性２
  String usdjancd = ""; //  中古品インストアコード
  int suryo = 0; //  数量
  int tanka = 0; //  単価
  int kingaku = 0; //  金額
  int urigaiflg = 0; //  売上外フラグ
  int syubcd = 0; //  種別コード
  int kbncd = 0; //  区分コード
  int zerit = 0; //  消費税率
}

///  FNo.12000 : ワールドスポーツ（中古関連）
class T12000 {
  String jancd = ""; //  janコード
  String hinak = ""; //  品名(カナ)
  String kikak = ""; //  規格（カナ）
  String hinkj = ""; //  品名（漢字）
  String kikkj = ""; //  規格（漢字）
  int bmncd = 0; //  部門コード
  int daicd = 0; //  大分類コード
  int chucd = 0; //  中分類コード
  int shocd = 0; //  小分類コード
  int bkazei = 0; //  売価課税区分
  int zerit = 0; //  消費税率
  int baika = 0; //  売単価
}

class T10005{
  int	validFlg = 0;
  String	pluCd1_2 = "";
  int	tare = 0;			// 風袋
  String	appendix = "";		// 別添名称
  int	appendixFlg = 0;		// 別添フラグ　0:非対称／1:対象／2:対象確認済み
  int	eatPrintFlg = 0;		// お召し上がり方印字フラグ 0:印字未、1:印字済
  int	daySellpriFlg = 0;	// 当日価格フラグ
  int	catcod = 0;			// カテゴリーコード
  String	barbuf = "";		// バーコードデータ
}
