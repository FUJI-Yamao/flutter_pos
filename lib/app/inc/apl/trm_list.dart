/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
/// ターミナルファイルリスト
///  関連tprxソース:\inc\apl\trm_list.h
/// 関連tprxソース: trm_list.h - trm_list
class TrmList {
  int wrngMvoidFlg = 0;
  int wrngMtriningFlg = 0;
  int wrngMscrapFlg = 0;
  int drwOpenFlg = 0;
  int urgencyMntFlg = 0;
  int nearendDsp = 0;
  int presetRegFlg = 0;
  int pwcntrlFlg = 0;
  int pwcntrlTime = 0;
  int fddManageFlg = 0;
  int rcptBarPrn = 0;
  int macOffFlg = 0;
  int closePickFlg = 0;
  int closeReportFlg = 0;
  int frcClkFlg = 0;
  int rcvGcatDataFlg = 0;
  int cshrNamePrn = 0;
  int recieptnoPrn = 0;
  int journalnoPrn = 0;
  int datePrn = 0;
  int rctPrcchgFlg = 0;
  int plunoPrn = 0;
  int freeItemPrn = 0;
  int taxMarkPrn = 0;
  int intaxMarkPrn = 0;
  int notaxMarkPrn = 0;
  int promMarkPrn = 0;
  int bdlDscPrn = 0;
  int qtyPrn = 0;
  int debitPrn = 0;
  int clsnoPrn = 0;
  int blnAmtPrn = 0;
  int cnclRctPrn = 0;
  int dscpluStldscFlg = 0;
  int tpuprcStldscFlg = 0;
  int mtcpluStldscFlg = 0;
  int grpprcStldscFlg = 0;
  int rndDscntFlg = 0;
  int uPrcchgDscFlg = 0;
  int grpprcDscFlg = 0;
  int dscpluClsdscFlg = 0;
  int othuprcClsdscFlg = 0;
  int dscShareFlg = 0;
  int wgtbarCalcFlg = 0;
  int bdlAveprisplitFlg = 0;
  int stmAveprisplitFlg = 0;
  int pripluClsdscFlg = 0;
  int brgnPrcFlg = 0;
  int repeatDscFlg = 0;
  int acxN5000 = 0;
  int acxN2000 = 0;
  int acxN1000 = 0;
  int acxN500 = 0;
  int acxN100 = 0;
  int acxN50 = 0;
  int acxN10 = 0;
  int acxN5 = 0;
  int acxN1 = 0;
  int acxS5000 = 0;
  int acxS2000 = 0;
  int acxS1000 = 0;
  int acxS500 = 0;
  int acxS100 = 0;
  int acxS50 = 0;
  int acxS10 = 0;
  int acxS5 = 0;
  int acxS1 = 0;
  int bothAcrClrFlg = 0;
  int acxM5000 = 0;
  int acxM2000 = 0;
  int acxM1000 = 0;
  int acxM500 = 0;
  int acxM100 = 0;
  int acxM50 = 0;
  int acxM10 = 0;
  int acxM5 = 0;
  int acxM1 = 0;
  int bkupRcptAdd = 0;
  int notClsdsc = 0;
  int myselfEvoid = 0;
  int fanfareNoEfect = 0;
  int fanfareEfect = 0;
  int saledatePlus = 0;
  int crdtPrnShare = 0;
  int trainingTimePrn = 0;
  int svstcktTtlpntPrn = 0;
  int notSetPresetMsg = 0;
  int rwCmdChg = 0;
  int vmcNotStldsc = 0;
  int decimalRound = 0;
  int decimalRoundOff = 0;
  int rwCompNoChk = 0;
  int lowPrice1 = 0;
  int taxImgChg = 0;
  int selfCaseSlct = 0;
  int kichenNoPrn = 0;
  int autoInputCust = 0;
  int rwHesoChgPnt = 0;
  int vmcNotDrwcash = 0;
  int custPntNotSet = 0;
  int selfWgtchkOneitem = 0;
  int pntaddZeroInput = 0;
  int tcktTtlpntPrn = 0;
  int allAddpntFlg = 0;
  int custPriceKeyonly = 0;
  int acctrcptAddrPrn = 0;
  int nearendChkCncl = 0;
  int ttlamtSimpleDisp = 0;
  int vmcDrwamtMinus = 0;
  int selfRightFlow = 0;
  int autoBacthRest = 0;
  int childRock200 = 0;
  int selfEndbtnChg = 0;
  int selfRcptCallChecker = 0;
  int selfCardreaderDisp = 0;
  int selfCashcnclCall = 0;
  int selfMsgsendOutscale = 0;
  int rwPossibleEsvoid = 0;
  int multiProm = 0;
  int accruedDisp = 0;
  int acctrcptExceptCha1 = 0;
  int svstcktOneSheet = 0;
  int tcktkeyBeforeCust = 0;
  int bigPntPrn = 0;
  int jpnDatePrn = 0;
  int clsprnNotMark = 0;
  int pntHighLimit = 0;
  int custprcKeyChg = 0;
  int itemvoidDisp = 0;
  int riseprcBlock = 0;
  int priorityStldsc = 0;
  int itemvoidProc = 0;
  int cardsheetPrn = 0;
  int vmcFspstlpdsc = 0;
  int selfInscaleErr = 0;
  int vmcChgHesoPnt = 0;
  int rwReReadcheck = 0;
  int selfAdditemBlock = 0;
  int selfEndbtnWgtchk = 0;
  int selfContPresetdisp = 0;
  int promNamePrn = 0;
  int vmcRprTcktBlock = 0;
  int vmcOutRankPnt = 0;
  int promMsgFew = 0;
  int notSetPresetEnt = 0;
  int dscBarcodeAmt = 0;
  int rfmOnlyIssue = 0;
  int rfmUseStampArea = 0;
  int notUpdCust0sales = 0;
  int useLowPrice1 = 0;
  int prcchkOnly1time = 0;
  int keepInt2person = 0;
  int vmcTpr9000Comb = 0;
  int dispMbrcardExist = 0;
  int notDspLcdBrgnitem = 0;
  int chgCulcMulDiscitem = 0;
  int notPrnPrcchgDiscwd = 0;
  int prnReptRefinfoSml = 0;
  int enableSplprcNpnplu = 0;
  int prn2rcptEatin = 0;
  int sameItem1prcTran = 0;
  int fspStldscTrgSubIntax = 0;
  int chgCulcItemcatDisc = 0;
  int vdEnableBatvoidOnly = 0;
  int enableStldscScanClkcode = 0;
  int bdlSmUseEarlyendSch = 0;
  int gpLimitOffName = 0;
  int useColorOpemsg = 0;
  int rwDisableUsePanaPointMove = 0;
  int enableClsDiscschUntil2359 = 0;
  int trgPrc0UseAllpoint = 0;
  int jackleDispMbrnum16d = 0;
  int notUsePointunitInSaleadd = 0;
  int acrSubstituteRecover = 0;
  int dispMbrnum8dInMbrnumNotPrn = 0;
  int selfSaleprcInclTax = 0;
  int prnQrcodeReceipt = 0;
  int chgErrmsgInBluetip = 0;
  int dispBdlPrcItemscreen = 0;
  int nonPrnStampareaMinussale = 0;
  int autoPointWorkCt3100 = 0;
  int disableEntOpeSimpleOpenclose = 0;
  int disableRecoverFeeSvscls1 = 0;
  int culcCredit1_100times = 0;
  int issueNotePrn = 0;
  int catdnoStartNo = 0;
  int mgnTyp = 0;
  int rwtPrnMbrfile = 0;
  int mulSmlDscUsetyp = 0;
  int refundStldsc = 0;
  int orgIdPrn = 0;
  int tranId = 0;
  int itemCode = 0;
  int goodThruDsp = 0;
  int opeType = 0;
  int crdtTimeOut = 0;
  int selfgateWgtalwLimit = 0;
  int intaxPrn = 0;
  int inTaxPrn = 0;
  int selectPrinterFlg = 0;
  int catdnoDigit = 0;
  int scaleWgt = 0;
  int warrantyNotePrn = 0;
  int catalineKeyCd = 0;
  int offBtnFlg = 0;
  int custSalePrnTyp = 0;
  int retPreset1page = 0;
  int streOpenReport = 0;
  int manualRfmTaxCd = 0;
  int receiptGp1Limit = 0;
  int receiptGp2Limit = 0;
  int receiptGp3Limit = 0;
  int receiptGp4Limit = 0;
  int receiptGp5Limit = 0;
  int receiptGp6Limit = 0;
  int receiptGp1Tax = 0;
  int receiptGp2Tax = 0;
  int receiptGp3Tax = 0;
  int receiptGp4Tax = 0;
  int receiptGp5Tax = 0;
  int receiptGp6Tax = 0;
  int taxCalc = 0;
  int warnMscrapFlg = 0;
  int drawCashChk = 0;
  int warrantyCntPrn = 0;
  int pctrTckt2PrcPrn = 0;
  int pctrTckt3PrcPrn = 0;
  int pctrTcktMsg1 = 0;
  int pctrTcktMsg2 = 0;
  int tagJanPrn = 0;
  int tagAmtImgPrn = 0;
  int tagCustAmtPrn = 0;
  int tagBrgnprcImgPrn = 0;
  int tagClscdPrn = 0;
  int tagTaxamtImgPrn = 0;
  int tagTaxamtPrn = 0;
  int tagFramePrn = 0;
  int tagExtaxPrn = 0;
//	int		nmStlpdscPer = 0 ;	// 削除(スケジュール化のため)
  int mobileposTyp = 0;
  int offmodePasswdTyp = 0;
  int extraAmtFlg = 0;
  int acsNDisp = 0;
  int exItemTtlamtFlg = 0;
  int exBrgnTtlamtFlg = 0;
  int exMmstmTtlamtFlg = 0;
  int taxDivideFlg = 0;
  int poppyTtlamtRound = 0;
  int selfRegflow = 0;
  int selfWgtchkStart = 0;
  int selfAddItem = 0;
  int selfWgtchkEnd = 0;
  int selfPresetEndDisp = 0;
  int acxM10000 = 0;
  int pctrTcktStore = 0;
  int promissueLowlimit = 0;
  int promissueNo = 0;
  int prodNamePrnTyp = 0;
  int offmodePasswd = 0;
  int contQtyPrn = 0;
  int selfNocustUseFlg = 0;
  int selfCustcardDisp = 0;
  int selfCustcardTyp = 0;
  int traningDrawAcxFlg = 0;
  int magazineScanTyp = 0;
  int culayAddFlg = 0;
  int nonpluAmtHighLimit = 0;
  int chgAmt10000Flg = 0;
  int streClsBatreport = 0;
  int prcchgDscFlg = 0;
  int prcchkCostDisp = 0;
  int selfSlctKeyCd = 0;
  int poppyMakerSlct = 0;
  int poppyContQtySlct = 0;
  int selfCrdtKeyCd = 0;
  int reportBkupFormat = 0;
  int mobileposInfoPrn = 0;
  int selfStampKeyCd = 0;
  int outSmlclsNum1 = 0;
  int outSmlclsNum2 = 0;
  int outSmlclsNum3 = 0;
  int outSmlclsNum4 = 0;
  int outSmlclsNum5 = 0;
  int selfEdyKeyCd = 0;
  int intaxCostperCalc = 0;
  int pspMinusAmt = 0;
  int pluInitSmlclsCd = 0;
  int tcktPrnTarget = 0;
  int dishQtyMax = 0;
  int catalinacpnKeyCd = 0;
  int rbtlAddSaleAmt = 0;
  int rbtlMixRefmix = 0;
  int prcVoice = 0;
  int zeroAmtPayFlg = 0;
  int refmixFlg = 0;
  int simpleReceiptPrcchk = 0;
  int disablePrnIntaxPrcRfm = 0;
  int printMarkControl = 0;
  int receiptPrnInRfmNotePrn = 0;
  int ralseMagFmt = 0;
  int ralseDisc2barcode = 0;
  int enableBdlItemRef = 0;
  int continueRefOpe = 0;
  int bdlPrnNonsummary = 0;
  int chgWordColorMbrprc = 0;
  int refBdlItemCulcDiscOpe = 0;
  int useLowPrice3 = 0;
  int enableActsaleTermPrcchg = 0;
  int bdlSmScheduleMethod2 = 0;
  int nonChangeOverAmt = 0;
  int dispRefOpeWord = 0;
  int charSearchRecordConf = 0;
  int stlAutodisc1_10times = 0;
  int disableCashkey1person = 0;
  int disableRfmNoteCut = 0;
  int disableStampCha9key = 0;
  int disablePrnClerkDisc = 0;
  int chgDiscBarcodeFlag = 0;
  int repeatPlukeyOpe = 0;
  int fspLevelBonusPoint = 0;
  int nw7mbrBarcode1 = 0;
  int nw7mbrReal = 0;
  int prnSaleTicket = 0;
  int printMarkControlTypNotstldsc = 0;
  int selfRwPosiLeft = 0;
  int kasumiDiscBarcode = 0;
  int kyumatsuRwProc = 0;
  int seikatsuclubOpe = 0;
  int printShopnameCreditMultiReceipt = 0;
  int printMbrPointP = 0;
  int openOpeDatechg15 = 0;
  int mediaInfoReport = 0;
  int disableDiscflagDisc2barcode = 0;
  int printRfmDetail = 0;
  int dispFipmesSelf = 0;
  int disableSpprcDiscitem = 0;
  int useBdlLowPrice = 0;
  int nonDispHesoMark = 0;
  int disableCardchkRwPana = 0;
  int printAstmarkItfbarcode = 0;
  int rwPrintareaExt = 0;
  int futagamiPntcardFlg = 0;
  int enableSpdscNonplu = 0;
  int enableAcxUseVmc = 0;
  int originalCardOpe = 0;
  int chgCulcProfitWtbar = 0;
  int printPoint1_100times = 0;
  int reservePrepayPostpayActsale = 0;
  int atreCashPointIp3100 = 0;
  int chkLengthMagcard = 0;
  int cpnQtyNonPointItemQty = 0;
  int enableCreditVoidOthermac = 0;
  int dispChgFipSpritOpe = 0;
//	int		disablePaymetActAcx = 0 ;
  int felicaWrBeforeReceipt = 0;
  int ntteastChgHttpHttps = 0;
  int ntteastDisableDelMaster = 0;
  int ntteastReadInternalFolder = 0;
  int ntteastSetSaledataInternalFolder = 0;
  int omcLess30000 = 0;
  int chgDispRebateExclusion = 0;
  int disableEntClsOpe = 0;
  int disableChakeyAcx = 0;
  int chgPrintWarrantyInfo = 0;
  int disableBackupOpenData = 0;
  int opeTimeUse = 0;
  int disableMbrTicketReprint = 0;
  int spcialItemCombine = 0;
  int siberuOpeReport = 0;
  int culcMethodTerminalItemstack = 0;
  int printMarkControlTypPntyen = 0;
  int printRecipe = 0;
  int printTicketEn = 0;
  int dispCustItemUprc = 0;
  int acxAcb50Control1 = 0;
  int bingoCardConnect = 0;
  int hostnameInFtpConnect = 0;
  int rebateFanfareInCashkey = 0;
  int receiptTotalCharBigger = 0;
  int receiptChangeCharBigger = 0;
  int disablePointDispInfox = 0;
  int siberuReportTitleChg = 0;
  int searchVoidPriority1 = 0;
  int searchVoidConfMsg = 0;
  int useClsStldiscFlag = 0;
  int printCls2d = 0;
  int searchVoidDisablePrcover = 0;
  int errorSleepMbr = 0;
  int tranrceiptBarflgEqualJan = 0;
  int delShopbagVoiceSsps = 0;
  int nonPrintUprcEn = 0;
  int useEmptyTotallogTxt = 0;
  int printCashpickamtSalepick = 0;
  int issueTicketEnOver = 0;
  int mbrContactSametime = 0;
  int matsugenMagcard = 0;
  int felicaWrAnotherCard = 0;
  int nonPrintVoidopeNonsummary = 0;
  int selfChgTimingFelicaTouch = 0;
  int enableDispvoidStlItemscreen = 0;
  int joyposCreditChakey = 0;
  int delSuicatradeWord = 0;
  int rechkTenderEdySuica = 0;
  int tuoChgProc = 0;
  int patioMbrpointPanacode = 0;
  int coopYamaguchiGreenStamp = 0;
  int nonPrintRandamItem = 0;
  int enableFixPriceEnt = 0;
  int nonAddStoreCustRetBottle = 0;
  int nw7mbrBarcode2 = 0;
  int selfStlpdscKey = 0;
  int selfAutoPdscLmt = 0;
  int susTypFlg = 0;
  int timePrcTyp = 0;
  int crdtStlpdscOpe = 0;
  int outSmlclsNum6 = 0;
  int outSmlclsNum7 = 0;
  int outSmlclsNum8 = 0;
  int outSmlclsNum9 = 0;
  int outSmlclsNum10 = 0;
  int crdtUserNo = 0;
  int magcardChkLen = 0;
  int jis2Len = 0;
  int acxCinFipdisp = 0;
//	int		acxCinAddTran = 0 ;
  int selfCrdtSlipKeyCd = 0;
  int selfOffcrdtKeyCd = 0;
  int bookSumPluTyp = 0;
  int deskcshrRcptFlg = 0;
  int dutyOutFlg = 0;
  int dutyRestFlg = 0;
  int warningItemFlg = 0;
  int separateChgAmt = 0;
  int selfOtherPay = 0;
  int selfWgtErrchkPer = 0;
  int ordrDaysLater = 0;
  int selfTransIcKeyCd = 0;
  int selfTransIcUnfinishKeyCd = 0;
  int selfTransIcErrmsgKeyCd = 0;
  int selfPresetDisp = 0;
  int selfVisatouchKeyCd = 0;
  int cpnbarDscKeyCd = 0;
  int approvalInputFlg = 0;
  int spCpnCompCd = 0;
  int spCpnDscKeyCd = 0;
  int spCpnPdscKeyCd = 0;
  int selfWgtchkFlg = 0;
  int selfMybackStampKeyCd = 0;
  int autoOffBatreport = 0;
  int exchangeTcktFlg = 0;
  int selfBigItem = 0;
  int tblformatOutput = 0;
  int precaChargeMaxAmt = 0;
  int regsDispRetTime = 0;
  int ordrCostDisp = 0;
  int drugExpKind = 0;
  int bdlAfterManuDisc = 0;
  int disableSrBdlBarPrc = 0;
  int myselfVoidOpe = 0;
  int disableStldiscCreditStldisc = 0;
  int kasumiChkAeonCredit = 0;
  int nonPrintCreditItemDetail = 0;
  int termSpprcDiscOpe = 0;
  int nonPrintReceiptAmt0 = 0;
  int dispPasswordClerkError = 0;
  int dispCallclerkNearendAcx = 0;
  int cutEveryCreditReport = 0;
  int chgWarnWordVdTrSr = 0;
  int chgRegColorVoidRefound = 0;
  int reportCondition1 = 0;
  int dispMsgReleaseAgeconf = 0;
  int disablePreset7pSsps = 0;
  int printMybagWord = 0;
  int autoExecCloseope = 0;
  int chkDiffCashChk3 = 0;
  int acxRecoverEcs07 = 0;
  int acxDischaCreditVoid = 0;
  int chgCulcSplitOmc = 0;
  int chkOffonlineMbr = 0;
  int disableFcfcardChk = 0;
//	int		disableAcxRecoverSales = 0 ;
  int fspTicket = 0;
  int dispCancelItemscan = 0;
  int calcCdKasutamuBridalcard = 0;
  int calcCdRingocard = 0;
  int calcCdOffoncard = 0;
  int chgMealTicket = 0;
  int chgWarrantyTicket = 0;
  int warrantyWithReceipt = 0;
  int enableItemScanSsps = 0;
  int useClerknum1546 = 0;
  int ticketOpeWithoutQs = 0;
  int acxCashInputManual = 0;
  int chgAcxInputDisp = 0;
  int dispStarItemname = 0;
  int printPointOpenope = 0;
  int nontaxCha10 = 0;
  int printMsg2_4_promo = 0;
  int acxRecoverSameButton = 0;
  int acxWarnChangeEcs07 = 0;
//	int		disableAcxInputSales = 0 ;
//	int		disableAcxOutputSales = 0 ;
  int includeDiffChkCash = 0;
  int enableTicketRealrebate = 0;
  int chgKasumicardSelf = 0;
  int acxChgRecoverArea = 0;
  int enableChgprDiscOutcls = 0;
  int disableWt0Wterr = 0;
  int dispPasswordWterror = 0;
  int deliveryDoubleReceipt = 0;
  int chkRainbowcard = 0;
  int acxRecoverLessError = 0;
  int cancelSaleAddAbsolutevalue = 0;
  int chgDiscbacodeFlg = 0;
  int enableDiscvalItemprc = 0;
//	int		acxExchangeInput = 0 ;
//	int		hesoSaleManualPrc = 0 ;
  int nonPrintPleaseStock = 0;
  int disableDispPrepage2_7 = 0;
  int ampmSalesItemBarcodePrint = 0;
  int ampmMasterImport = 0;
  int useBiggerRecommendPoint = 0;
  int chgPresetnameConveniencestore = 0;
  int chkCdOmccard = 0;
  int scanPanelOpe = 0;
  int itemDiscUpperref = 0;
  int ampmAddStldiscvalPrc = 0;
  int trandetailReportIntaxNotprn = 0;
  int trandetailReportExtaxNotprn = 0;
  int trandetailReportTraninExtaxPrn = 0;
  int trandetailReportInExtaxPrn = 0;
  int ampmChgStartupMov = 0;
  int dispSkipItemReg = 0;
  int nalsePanacode = 0;
  int chgPropdiv = 0;
  int masterImportMake = 0;
  int promMbrnameType = 0;
  int specialconvWeekbook = 0;
  int specialconvOthweekbook = 0;
  int loasonMasterImport = 0;
  int saleSaveCloseope = 0;
  int acxLogSaveCloseope = 0;
  int suicaShortReceipt = 0;
  int useExtaxCalc = 0;
  int spprcGetTaxamt = 0;
  int chgUpceUpca = 0;
  int loasonNw7mbr = 0;
  int chgButtonAreaOpenclose = 0;
  int chgMsgBarNotRead = 0;
  int disableMbrprcOthmbr = 0;
  int printSumTax = 0;
  int printInstnumWizpod = 0;
  int prgPresetName = 0;
  int ralsePointInputFnc = 0;
  int combMbrClkdsc = 0;
  int nonSummaryprintTicket = 0;
  int ampmScanFunc1 = 0;
  int ampmScanFunc2 = 0;
  int ampmSeparateBdlSm = 0;
  int addVoidReceiptTtllog = 0;
  int dispPasswordError = 0;
  int useOptionvalSearchvoid = 0;
  int exceptOthcashRecalc = 0;
  int dispNonreceiptPayscreen = 0;
  int selfMbrstlpdscKey = 0;
  int edyAlarmPrn = 0;
  int tabPosition = 0;
  int tabStlSave = 0;
  int cashmgmtOutholdCust = 0;
  int cashmgmtExchg = 0;
  int cashmgmtSheetDisp = 0;
  int cashmgmtCalcCust = 0;
  int cashmgmtCalcBase = 0;
  int behindPickTyp = 0;
  int cashmgmtRcptInfo = 0;
  int cashmgmtInoutUnit = 0;
  int cashmgmtStaffOperation = 0;
  int cashmgmtStaffInput = 0;
  int cashmgmtApplyTyp = 0;
  int cashmgmtIndicateRcpt = 0;
  int cashmgmtInoutRcptInfo = 0;
  int cashmgmtCinpickProc = 0;
  int cashmgmtInfobtnDisp = 0;
  int itemArriveCalc = 0;
  int reservprnNotes = 0;
  int warningdispTyp = 0;
  int crdtSignlessMaxLimit = 0;
  int reserveStrorenoteDouble = 0;
  int coopaizuFunc1 = 0;
  int cashKindSelectReserveope = 0;
  int bunkadoQcDisp = 0;
  int qcDisableSerachReg = 0;
  int qcEnableCancel = 0;
  int vmcDisableSaleupMente = 0;
  int dispNbrnameTabarea = 0;
  int foreignDepositOpe = 0;
  int rcDiscOpe = 0;
  int dispWtuprcCustdisp = 0;
  int chgDispMulItem = 0;
  int nonConnectClkOpen = 0;
  int warnSusRefPrcchkUse = 0;
  int printAftDiscprc = 0;
  int mansoOpe = 0;
  int ikeaOpe = 0;
  int drwchkDispChkdrwAmt = 0;
  int dispStartbottunQcStart = 0;
  int disableSplitQcTicket = 0;
  int qcSameTcketOk = 0;
  int qcDivadjRfmPrc = 0;
  int acxDecisionPass = 0;
  int chgQcSigncolor = 0;
  int disableSaleMenuWiz = 0;
  int chkStlChaSpeeza = 0;
  int qcChgMovPinkReceipt = 0;
  int tacFunc = 0;
  int printShortTicket = 0;
  int chgReceiptCutMode = 0;
  int enableSearchChangeTicket = 0;
  int qcSameTcketStartOk = 0;
  int qcCloseReportFunc = 0;
  int lightOnoffCancelOpe = 0;
  int wizAutoRegIp3d = 0;
  int nonpluReadMstprc = 0;
  int coopsapporoPrintFunc = 0;
  int qcCallClkRfm = 0;
  int qcUseSpeezaTerminal = 0;
  int connectSbsCredit1 = 0;
  int dcmalPrcchgSpecialCalc = 0;
  int printSeparateTicketFunc = 0;
  int nonPrintSignareaCreditNote = 0;
  int connectSbsCredit2 = 0;
  int chgRfmCreditWord = 0;
  int qcCallClkRfmIssue = 0;
  int receiptErrAutoRpr = 0;
  int samePresetPushQty = 0;
  int mbrbarcodeCustbarcode = 0;
  int qcDispReprintDiag = 0;
  int acoopCreditFunc = 0;
  int verticalRfm = 0;
  int qcGetUpdSpeeza = 0;
  int reserveSpareTxtBig = 0;
  int nonPrintManuRepItem = 0;
  int enableBluechipEvoid = 0;
  int printStoreNoteGlorymulti = 0;
  int nonPrintCreditTelno = 0;
  int kanesueNewopeFunc = 0;
  int peintBeforeAfterDiscprc = 0;
  int acxFreeexchangeAcb200Eos07 = 0;
  int printItemnameAreaBig = 0;
  int printIntaxSplitReceipt = 0;
  int enableAcctMbrCall = 0;
  int discBarcode28d = 0;
  int precaChargeNotDrwamt = 0;
  int acoopPrintFunc1 = 0;
  int qcChgPrnOrdr = 0;
  int creditvoidChkFunc = 0;
  int printTerminalCls3d = 0;
  int enableEntCreditOpe = 0;
  int selfSelectItemNonbarkey = 0;
  int assortRandomOrdrPrn = 0;
  int assortRandomSumPrn = 0;
  int assortRandomPrnChg = 0;
  int attendantMbrRead = 0;
  int wataricardOpe = 0;
  int assortRandomRepeat = 0;
  int sanwadoDrwchkChk = 0;
  int custsvrOfflineChk = 0;
  int custsvrCnctOfflineChk = 0;
  int reservNoSetFlg = 0;
  int arksNewCardChk = 0;
  int disableMbrCashkey = 0;
  int disableUseAcxLess10000 = 0;
  int mbrReqTsd7000 = 0;
  int scaleNonuseSpeeza = 0;
  int combineMagmbrCredit = 0;
  int kamadoStldscCha1Func = 0;
  int qcRfmDataDelPrn = 0;
  int enableChakeyCredit = 0;
  int printRestartContinue = 0;
  int ticketManegeSrvFunc = 0;
  int printSlipnumTicket = 0;
  int dailyclrJmups = 0;
  int httpsProxyUse = 0;
  int voidJmups = 0;
  int disableSearchEdyMbrTran = 0;
  int printTitle2timebig = 0;
  int dispErrScheduleRead = 0;
  int chgBusinessCode = 0;
  int printDeliverySheet = 0;
  int promArbitraryBitmap = 0;
  int detailrfmOverRevenue = 0;
  int wgtitemInfoStldisp = 0;
  int rfmCounterFunc = 0;
//	int		disableAcxInoutSale = 0 ;
  int kasumiChgRfm = 0;
  int qcTcktStampPrint = 0;
  int marushimeMbrFunc = 0;
  int qcSaleUseUpd = 0;
  int lostpointOffmbrPrint = 0;
  int opencloseChgRt300 = 0;
  int qcReadNotSaledateChk = 0;
  int chkStlItemscreen = 0;
  int dispBdlQtyLimit1 = 0;
  int sanrikuFunc = 0;
  int qcReadNotInterrupt = 0;
  int clscnclItemFlg = 0;
  int useLowPrice4 = 0;
  int ayahaTicketFunc = 0;
  int bunkadoFspFunc = 0;
  int print2timewideFsp = 0;
  int calcchgDscClsdsc = 0;
  int lotteryOpeFlg = 0;
  int acntPointTyp1 = 0;
  int acntPointTyp2 = 0;
  int acntPointTyp3 = 0;
  int acntPointTyp4 = 0;
  int acntPointTyp5 = 0;
  int acntPointTyp6 = 0;
  int acntPointTyp7 = 0;
  int acntPointTyp8 = 0;
  int acntPointTyp9 = 0;
  int acntPointTyp10 = 0;
  int ticketPointTyp1 = 0;
  int ticketPointTyp2 = 0;
  int ticketPointTyp3 = 0;
  int ticketPointTyp4 = 0;
  int ticketPointTyp5 = 0;
  int salePluPointTyp = 0;
  int subtDcntPointTyp = 0;
  int sbsRbtPointTyp = 0;
  int mpluStldscTyp = 0;
  int smpluStldscTyp = 0;
//	int		memSubtDcntRate = 0 ;	// 削除(スケジュール化のため)
  int tdyTgtmnyPrint = 0;
  int tdyPointPrint = 0;
  int totalPointPrint = 0;
  int posblPointPrint = 0;
  int memNoPrint = 0;
  int memMagnoPrint = 0;
  int memNamePrint = 0;
  int anvPrint = 0;
  int pointAchivPrint = 0;
  int sbsTcktDvidPrint = 0;
  int sbsTcktPrintKind = 0;
  int spclTcktTitle = 0;
  int memAnvDsp = 0;
  int anvMnyDsp = 0;
  int pointFipDsp = 0;
  int rvtBeep = 0;
  int memBcdTyp = 0;
  int magcadKnd = 0;
  int rwcadKnd = 0;
  int memUseTyp = 0;
  int sbsMthd = 0;
  int sbsDspMthd = 0;
  int pointClcUnit = 0;
  int pointClcRnd = 0;
  int ppointMclrTyp = 0;
  int pointSbsClrTyp = 0;
  int nwRvtPointTyp = 0;
  double buyPointAddMagn = 0;
  int buyPointLlmtMny = 0;
  int buyPointRdwn = 0;
  int buyPointCutpstn = 0;
  int pointAmtclcRnd = 0;
  int pluRgsPointCond = 0;
  int rvtSubstMthd = 0;
  int tcktAutoRvtUnit = 0;
  int tgtmnyClcMthd = 0;
  int buyPointLlimt1 = 0;
  double buyPointMagn1 = 0;
  int buyPointLlimt2 = 0;
  double buyPointMagn2 = 0;
  int buyPointLlimt3 = 0;
  double buyPointMagn3 = 0;
  int buyPointLlimt4 = 0;
  double buyPointMagn4 = 0;
  int memAnyprcStet = 0;
  int memAnyprcReduStet = 0;
  int memMulprcKnd = 0;
  int memMulpdscKnd = 0;
  int memMuladdKnd = 0;
  int tdyTermCompPrint = 0;
  int termCompPrint = 0;
  int nxtlvlMnyPrint = 0;
  int nowLvlPrint = 0;
  double anyprcTermAddMagn = 0;
  int anyprcTermLlimt1 = 0;
  double anyprcTermMagn1 = 0;
  int anyprcTermLlimt2 = 0;
  double anyprcTermMagn2 = 0;
  int anyprcTermLlimt3 = 0;
  double anyprcTermMagn3 = 0;
  int anyprcTermLlimt4 = 0;
  double anyprcTermMagn4 = 0;
  int anyprcTermLlmtMny = 0;
  int anyprcTermRdwn = 0;
  int anyprcTrmCutpstn = 0;
  int fspCd = 0;
  int sLowerLimit = 0;
  int aLowerLimit = 0;
  int bLowerLimit = 0;
  int cLowerLimit = 0;
  int dLowerLimit = 0;
  int sSubDcntRate = 0;
  int aSubDcntRate = 0;
  int bSubDcntRate = 0;
  int cSubDcntRate = 0;
  int dSubDcntRate = 0;
  double sLvlAddMagn = 0;
  double aLvlAddMagn = 0;
  double bLvlAddMagn = 0;
  double cLvlAddMagn = 0;
  double dLvlAddMagn = 0;
  int anyprcTrmamtclcRnd = 0;
  int pluRgsAnyprcTrm = 0;
  int anyprcTrmclcMthd = 0;
  int acntAnyprcTyp1 = 0;
  int acntAnyprcTyp2 = 0;
  int acntAnyprcTyp3 = 0;
  int acntAnyprcTyp4 = 0;
  int acntAnyprcTyp5 = 0;
  int acntAnyprcTyp6 = 0;
  int acntAnyprcTyp7 = 0;
  int acntAnyprcTyp8 = 0;
  int acntAnyprcTyp9 = 0;
  int acntAnyprcTyp10 = 0;
  int ticketAnyprcTyp1 = 0;
  int ticketAnyprcTyp2 = 0;
  int ticketAnyprcTyp3 = 0;
  int ticketAnyprcTyp4 = 0;
  int ticketAnyprcTyp5 = 0;
  int spluAnyprcTyp = 0;
  int stldscAnyprcTyp = 0;
  int sbsRbtAnyprcTyp = 0;
  int rbtFlg = 0;
  int issueCustnamePrn = 0;
  int magCardTyp = 0;
  int cardStreCdChk = 0;
  int magEcftTrmChk = 0;
  int othcmpMagStrtNo = 0;
  int othcmpMagEfctNo = 0;
  int rwtCustmstPrn = 0;
  int othSaleAdd = 0;
  int rwtInfo = 0;
  int rwtWindPrn = 0;
  int rwtWindDatePrn = 0;
  int gpnoInplu = 0;
  int smregMthd = 0;
  int lvlChgDLvl = 0;
  double rwtSpRbtPer = 0;
  int lstSLowerLimit = 0;
  int lstALowerLimit = 0;
  int lstBLowerLimit = 0;
  int lstCLowerLimit = 0;
  int lstDLowerLimit = 0;
  int stampPointTyp1 = 0;
  int stampPointTyp2 = 0;
  int stampPointTyp3 = 0;
  int stampPointTyp4 = 0;
  int stampPointTyp5 = 0;
  int shoppingPoint = 0;
  int muprcClsdscFlg = 0;
  int beTotalPntPrn = 0;
  int bePossiblePntPrn = 0;
  int otherStoreMbrDsp = 0;
  int mbrBlankinfoWarn = 0;
  int otherStoreMbrPrn = 0;
  int promTcktPrnMax = 0;
  int birthdayPointPrn = 0;
  int mbrsellkeyCtrl = 0;
  int birthdayPointAdd = 0;
  int dAddPointPrn = 0;
  int dAddPntDetailPrn = 0;
  int addPointPriority = 0;
  int nonMbrPntPrn = 0;
  int buyaddTcktPrn = 0;
  int pointUnit = 0;
  int voidCust = 0;
  int promTcktPrnTyp = 0;
  int tcktIssuAmt = 0;
  int tcktGoodThru = 0;
  int tcktGoodThruPrn = 0;
  int birthBeep = 0;
  int custAddrPrn = 0;
  int cashPointYpe = 0;
  int cashAnyprcTyp = 0;
  int ptBonusLimit1 = 0;
  int ptAddBonus1 = 0;
  int ptBonusLimit2 = 0;
  int ptAddBonus2 = 0;
  int ptBonusLimit3 = 0;
  int ptAddBonus3 = 0;
  int ptBonusLimit4 = 0;
  int ptAddBonus4 = 0;
  int bonusSelect = 0;
  int stlplusPointTyp = 0;
  int stlplusAnyprcTyp = 0;
  int ttlPointGoodThru = 0;
  int outmdlPoint = 0;
  int rebateDiscKey = 0;
//	int		mbrStldscLimit = 0 ;	// 削除(スケジュール化のため)
  int mbrNameDsp = 0;
  int personalData = 0;
  int bonusPntSch = 0;
  int bonusPntLimit = 0;
  int nonPointMark = 0;
  int rcprateSel = 0;
  int dpointAmtLimit = 0;
  int ecoaPntuseSml = 0;
  int ecoaPntuseBig = 0;
  int mbrDetailKeepCnt = 0;
  int mbrDetailKeepMons = 0;
  int couponBarPrn = 0;
  int posMediaNo = 0;
  int validYear = 0;
  int cardMngFee = 0;
  int crdtPtCalcUnit = 0;
  int proratePntPrn = 0;
  int promLimitAmt1 = 0;
  int promLimitAmt2 = 0;
  int promLimitAmt3 = 0;
  int promLimitAmt4 = 0;
  int promLimitAmt5 = 0;
  int cardTyp1Dsc = 0;
  int cardTyp2Dsc = 0;
  int cardTyp3Dsc = 0;
  int promLimitAmt6 = 0;
  int promLimitAmt7 = 0;
  int promLimitAmt8 = 0;
  int cardForgetSkey = 0;
  int promCode1 = 0;
  int promCode2 = 0;
  int promCode3 = 0;
  int promCode4 = 0;
  int promCode5 = 0;
  int promCode6 = 0;
  int promCode7 = 0;
  int promCode8 = 0;
  int addpntSkey = 0;
  int srvnoChgDsp = 0;
  int dmPostPrn = 0;
  int absv31User = 0;
  int lotNum1 = 0;
  int lotNum2 = 0;
  int outpntPrnStart = 0;
  int outpntPrnEnd = 0;
  int prizeNoFrom = 0;
  int prizeNoTo = 0;
  int outmdlPntcalTaxno = 0;
  int rcdscCardNo = 0;
  int staffdscCardNo = 0;
  int prepaidChgpntCalunit = 0;
  int ralseRealCompCd = 0;
  int ptBonusLimit5 = 0;
  int ptAddBonus5 = 0;
  int ptBonusLimit6 = 0;
  int ptAddBonus6 = 0;
  int prnNewblevAchAmt = 0;
  int acntPointTyp11 = 0;
  int acntPointTyp12 = 0;
  int acntPointTyp13 = 0;
  int acntPointTyp14 = 0;
  int acntPointTyp15 = 0;
  int acntPointTyp16 = 0;
  int acntPointTyp17 = 0;
  int acntPointTyp18 = 0;
  int acntPointTyp19 = 0;
  int acntPointTyp20 = 0;
  int acntPointTyp21 = 0;
  int acntPointTyp22 = 0;
  int acntPointTyp23 = 0;
  int acntPointTyp24 = 0;
  int acntPointTyp25 = 0;
  int acntPointTyp26 = 0;
  int acntPointTyp27 = 0;
  int acntPointTyp28 = 0;
  int acntPointTyp29 = 0;
  int acntPointTyp30 = 0;
  int acntAnyprcTyp11 = 0;
  int acntAnyprcTyp12 = 0;
  int acntAnyprcTyp13 = 0;
  int acntAnyprcTyp14 = 0;
  int acntAnyprcTyp15 = 0;
  int acntAnyprcTyp16 = 0;
  int acntAnyprcTyp17 = 0;
  int acntAnyprcTyp18 = 0;
  int acntAnyprcTyp19 = 0;
  int acntAnyprcTyp20 = 0;
  int acntAnyprcTyp21 = 0;
  int acntAnyprcTyp22 = 0;
  int acntAnyprcTyp23 = 0;
  int acntAnyprcTyp24 = 0;
  int acntAnyprcTyp25 = 0;
  int acntAnyprcTyp26 = 0;
  int acntAnyprcTyp27 = 0;
  int acntAnyprcTyp28 = 0;
  int acntAnyprcTyp29 = 0;
  int acntAnyprcTyp30 = 0;
  int connectSbsCredit3 = 0;
  int flightSystemCash = 0;
  int flightSystemCha1 = 0;
  int flightSystemCha2 = 0;
  int flightSystemCha3 = 0;
  int selfgateSystem = 0;
  int revenueStampPayFlg = 0;
  int otherPanaCardFlg = 0;
  int yaoSpEventCd = 0;
  int yaoPreferentialDscper = 0;
  int yaoStaffDscper = 0;
  int selfRfmDispFlg = 0;
  int esvoidBdlstmSaveUse = 0;
  int beTotalAmtPrn = 0;
  int planNameDispPrn = 0;
  int zenLoyaltyPrnDate = 0;
  int zenLoyaltyPrnLimit = 0;
  int streSvsMthdUse = 0;
  int rfmPrnKind = 0;
  int voidLogKeep = 0;
  int yaoHakenDscper = 0;
  int reservDelDate = 0;
  int histDelDate = 0;
  int logDelDate = 0;
  int tranDelDate = 0;
  int srvlogSaveDate = 0;
  int bdlPrcFlg = 0;
  int crmLvlMonth = 0;
  int crmLvl1Limit = 0;
  int crmLvl2Limit = 0;
  int crmLvl3Limit = 0;
  int crmHighUseLowerLimit = 0;
  int crmLowUseUpperLimit = 0;
  int crmIntervalWarnMonth = 0;
  int wizCardScanFlg = 0;
  int beTotalPntDisp = 0;
  int cpmBmpDeleteMonth = 0;
  int crmPortalConfPrn = 0;
  int sameDateOpen = 0;
  int chkPasswordClkOpen = 0;
  int crmDeliveryMonth = 0;
  int taxRatePrn = 0;
  int drawchkCloseSelect = 0;
  int strclsVup = 0;
  int pntUseLimit = 0;
  int coinUnitSht = 0;
  int vupfileGetFlg = 0;
  int custCurlTimeout = 0;
  int acxErrGuiFlg = 0;
  int qcMenteDispKeyAuth = 0;
  int stlScnDisable = 0;
  int autoUpdate = 0;
  int tchBtnBeep = 0;
  int saleLimitTime = 0;
  int taxfreeAmtCsm = 0;
  int taxfreeAmtGnrl = 0;
  int taxfreeTaxNum = 0;
  int taxfreeReceiptCnt = 0;
  int nearendNote = 0;
  int autoForceClsMakeTrn = 0;
  int clstimeUsing = 0;
  int notriBdlSumprn = 0;
  int nonregPopupDisp = 0;
  int specialMultiOpe = 0;
  int prnOutClsQty = 0;
  int histlogChkrAlert = 0;
  int bdlLowLimitChk = 0;
  int schKeepPeriod = 0;
  int rdlyKeepPeriod = 0;
  int rdlyClearDay = 0;
  int memobtnDisp = 0;
  int ejTxtDelDate = 0;
  int csvTxtDelDate = 0;
  int custbkupDelDate = 0;
  int nonusactDelDate = 0;
  int autochkroffTime = 0;
  int automsgstartTime = 0;
  int autoPwDown = 0;
  int useLowPrice = 0;
  int prodStartCd = 0;
  int prodEndCd = 0;
  int itemStartCd = 0;
  int itemEndCd = 0;
  int presetSmall = 0;
  int kitchenNonSummary = 0;
  int kitchenPrtRpr = 0;
  int printStldscDetail = 0;
  int selectItemSumTotalQty = 0;
  int sptendSelectVoidChange = 0;
  int correctedItemChangeNameCollor = 0;
  int tabDisplay = 0;
  int frontSelfDisplay = 0;
  int frontSelfReceipt = 0;
  int prfAmt = 0;
  int chkResult = 0;
  int easyUiMode = 0;
  int extPaymentStldsp = 0;
  int extInitialDispSide = 0;
  int verifonePrintNum = 0;
  int printWmticket = 0;
  int dispAddPointItemname = 0;
  int wizPwrStsBase = 0;
  int extNotuseDisp = 0;
  int colorfip15Display = 0;
  int colorfip15UnitDesign = 0;
  int colorfip15StlDscDsp = 0;
  int colorfip15StlQtyDsp = 0;
  int colorfip15DscDetailDsp = 0;
  int colorfip15MbrDsp = 0;
  int popupSound = 0;
  int salesrepoJmups = 0;
  int stafflistDisp = 0;
  int staffnameFlg = 0;
  int qcSlctDispOtherPay = 0;
  int autochkroffAftersendupdateTime = 0;
  int certificateNotePrn = 0;
  int certificateCntPrn = 0;
  int prcchkCertificateBtn = 0;
  int notePluReg = 0;
  int kyChaDivideKoptCrdt = 0;
  int complaintMessageDisp = 0;
  int tcktissuPoint1_100times = 0;
  int svsTcktPluCd9digit = 0;
  int ds2GodaiItmifoPrn = 0;
  int notePluPrintTyp = 0;
  int taxRatePrnDeal = 0;
  int taxRatePrnCls = 0;
  int rcptvoidBdlstmSaveUse = 0;
  int checkMbrcardmstUse = 0;
  int jmupsWaitTime = 0;
  int ds2PrerankReferTerm = 0;
  int dispMainmenuBtn = 0;
  int rebatePointsPrn = 0;
  int cctStlamtOnly = 0;
  int cctOnceOnly = 0;
  int deletePointsPrn = 0;
  int useSamePntCpn = 0;
  int useSameStldscCpn = 0;
  int receiptSplitChangeSize = 0;
  int voidDateInput = 0;
  int cashlessRestoreRate = 0;
  int cashlessRestoreLimit = 0;
  int realItemTaxSet = 0;
  int rfmTaxInfo = 0;
  int loyLimitOverAlert = 0;
  int changeMessageButton = 0;
  int outMdlclsTaxAmt = 0;
  int outMdlclsOuttaxNo = 0;
  int outMdlclsIntaxNo = 0;
  int loyAmtTax = 0;
  int pluDigit = 0;
  int pastcompfileKeepDate = 0;
  int systRestart = 0;
  int nonMbrRctCctpntChg = 0;
  int ecsOverflowSpace = 0;
  int ecsOverflowpickConf = 0;
  int dpntDualmember = 0;
  int dpntClcUnit = 0;
  int dpntUnit = 0;
  int dpntClcRnd = 0;
  int dpntTax = 0;
  int dpntStamp = 0;
  int dpntUse = 0;
  int dpntUseUnit = 0;
  int dpntLlmtMny = 0;
  double dpntMagn = 0;
  int dpntLlimt1 = 0;
  double dpntMagn1 = 0;
  int dpntLlimt2 = 0;
  double dpntMagn2 = 0;
  int dpntDualmagn = 0;
  int dpntPlupoint = 0;
  int dpntCashPointYpe = 0;
  int dpntAcntPointTyp1 = 0;
  int dpntAcntPointTyp2 = 0;
  int dpntAcntPointTyp3 = 0;
  int dpntAcntPointTyp4 = 0;
  int dpntAcntPointTyp5 = 0;
  int dpntAcntPointTyp6 = 0;
  int dpntAcntPointTyp7 = 0;
  int dpntAcntPointTyp8 = 0;
  int dpntAcntPointTyp9 = 0;
  int dpntAcntPointTyp10 = 0;
  int dpntAcntPointTyp11 = 0;
  int dpntAcntPointTyp12 = 0;
  int dpntAcntPointTyp13 = 0;
  int dpntAcntPointTyp14 = 0;
  int dpntAcntPointTyp15 = 0;
  int dpntAcntPointTyp16 = 0;
  int dpntAcntPointTyp17 = 0;
  int dpntAcntPointTyp18 = 0;
  int dpntAcntPointTyp19 = 0;
  int dpntAcntPointTyp20 = 0;
  int dpntAcntPointTyp21 = 0;
  int dpntAcntPointTyp22 = 0;
  int dpntAcntPointTyp23 = 0;
  int dpntAcntPointTyp24 = 0;
  int dpntAcntPointTyp25 = 0;
  int dpntAcntPointTyp26 = 0;
  int dpntAcntPointTyp27 = 0;
  int dpntAcntPointTyp28 = 0;
  int dpntAcntPointTyp29 = 0;
  int dpntAcntPointTyp30 = 0;
  int dpntTicketPointTyp1 = 0;
  int dpntTicketPointTyp2 = 0;
  int dpntTicketPointTyp3 = 0;
  int dpntTicketPointTyp4 = 0;
  int dpntTicketPointTyp5 = 0;
  int dpntSalePluPointTyp = 0;
  int dpntSubtDcntPointTyp = 0;
  int dpntSbsRbtPointTyp = 0;
  int dpntStlplusPointTyp = 0;
  int tsLgyoumuSend = 0;
  int clsTranoutTimeout = 0;
  int clsTerminalReport = 0;
  int taxfreeAmtCsmMax = 0;
  int barcodepayRfdoprerrToCash = 0;
  int barcodepayReportDivide = 0;
  int printCloseReceiptFlg = 0;
  int allRequestDate = 0;
  int sagSbsMthd = 0;
  int promCustKind = 0;
  int strCloseDay = 0;
  int taxfreeReceiptSave = 0;
  int serverExc = 0; //免税電子化(2021/10/01以降この設定は無効)　0：しない　1：する
  int less20gWarnEnterAmount = 0;
  int mmSmTaxfreePrice = 0; //ミックスマッチ・セットマッチ価格を免税価格変更　0：しない　1：する
  int rpntGroupId = 0;
  int rpntInvestReasonId = 0;
  int rpntBonusReasonId = 0;
  int rpntUseReasonId = 0;
  int rpntServiceId1 = 0;
  int rpntServiceId2 = 0;
  int easyRprDisp = 0;
  int detailNoprnSml1 = 0;
  int detailNoprnSml2 = 0;
  int detailNoprnSml3 = 0;
  int detailNoprnSml4 = 0;
  int detailNoprnSml5 = 0;
  int detailNoprnSml6 = 0;
  int detailNoprnSml7 = 0;
  int detailNoprnSml8 = 0;
  int detailNoprnSml9 = 0;
  int detailNoprnSml10 = 0;
  int detailNoprnSml11 = 0;
  int detailNoprnSml12 = 0;
  int web3800jFselfChg = 0;
  int dealReportExceOrDefiPrn = 0;
  int rpntDualFlg = 0;
  int rpntUseKey = 0;
  int loyHighMagnPriority = 0;
  int scrapModePluSch = 0;
  int tsG3Preset = 0;
  int liqrStaffChk = 0;
  int taxSetOrder = 0;
  int mmSmLiqramtDsc = 0;
  int promCpnPrnOrdr = 0;
  int crdtInfoOrder = 0;
  int ihMbrSelfFlg = 0;
  int tpntSelfFlg = 0;
  int tpntAllianceCd = 0;
  int tpntBizCd = 0;
  int tpntUseKey = 0;
  int easyPrcDispBeep = 0;
  int dpntAmtclcRnd = 0;
  int scalermFroatingMacNo = 0;
  int pluSelectJumpPreset = 0;
  int jumpPresetGrp = 0;
  int jumpPresetPage = 0;
  int scalermFroatingChkTime = 0;
  int scalermFroatingItemMax = 0;
  int scalermStl20gOverRegs = 0;
  int itemDispJancd = 0;
  int multiBtn = 0;
  int strclsReport = 0;
  int takaraRcptLayoutChg = 0;
  int hiTouchMacNo = 0;
  int hiTouchPluDispTime = 0;
  int hiTouchRcvChkTime = 0;
  int wsCouponLimitPrice = 0;
  int wsCouponLimitDisc = 0;
  int wsCouponLimitPointAdd = 0;
  int wsCouponLimitPointMag = 0;
  int tpntSelfCpnDsp = 0;
  int tpntEjIdMsk = 0;
  int otherCompanyQr = 0;
  int bdlpluClsdscFlg = 0;
  int clsregClsdscFlg = 0;
  int dscpluBdlFlg = 0;
  int chgprcpluBdlFlg = 0;
  int scregConttradeFlg = 0;
  int frontSelfMbrscanFlg = 0;
  int wsCouponRefFlg = 0;
  int uniteCouponStaffCallFlg = 0;
  int uniteCouponDspFlg = 0;
  int vendingMachine = 0;
  int useReceiptRefund = 0;
  int taxchgWgtbercode = 0;
  int stlTaxinfoPrn = 0;
  int fselfCashSplit = 0;
  int notaxPrn = 0;
  int barcodePayConfDsp = 0;
  int cssUserProc = 0;
  int nw7StaffFlg = 0;
  int mbrTaxFree = 0;
  int userCd1 = 0;
  int userCd2 = 0;
  int userCd4 = 0;
  int userCd31 = 0;
  int userCd38 = 0;
  int fil92 = 0;
  int userCd36 = 0;
  int userCd15 = 0;
  int userCd22 = 0;
  int webAndRmNetwork = 0;
  int extMbrSvrCom = 0;
  int trmFiller61 = 0;   //termainal filler 61（12Verから移植）
  int arcsCompFlg = 0;  // ラルズ仕様（アークス仕様）

  void setValueFromTrmData(TrmCdList def, dynamic trmData) {
    switch (def) {
      case TrmCdList.TRMNO_WRNG_MVOID_FLG:
        wrngMvoidFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WRNG_MTRINING_FLG:
        wrngMtriningFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WRNG_MSCRAP_FLG:
        wrngMscrapFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DRW_OPEN_FLG:
        drwOpenFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_URGENCY_MNT_FLG:
        urgencyMntFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NEAREND_DSP:
        nearendDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRESET_REG_FLG:
        presetRegFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PWCNTRL_FLG:
        pwcntrlFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PWCNTRL_TIME:
        pwcntrlTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FDD_MANAGE_FLG:
        fddManageFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RCPT_BAR_PRN:
        rcptBarPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MAC_OFF_FLG:
        macOffFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLOSE_PICK_FLG:
        closePickFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLOSE_REPORT_FLG:
        closeReportFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FRC_CLK_FLG:
        frcClkFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RCV_GCAT_DATA_FLG:
        rcvGcatDataFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CSHR_NAME_PRN:
        cshrNamePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECIEPTNO_PRN:
        recieptnoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JOURNALNO_PRN:
        journalnoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DATE_PRN:
        datePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RCT_PRCCHG_FLG:
        rctPrcchgFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLUNO_PRN:
        plunoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FREE_ITEM_PRN:
        freeItemPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_MARK_PRN:
        taxMarkPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_INTAX_MARK_PRN:
        intaxMarkPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOTAX_MARK_PRN:
        notaxMarkPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_MARK_PRN:
        promMarkPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_DSC_PRN:
        bdlDscPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QTY_PRN:
        qtyPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DEBIT_PRN:
        debitPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLSNO_PRN:
        clsnoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BLN_AMT_PRN:
        blnAmtPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CNCL_RCT_PRN:
        cnclRctPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DSCPLU_STLDSC_FLG:
        dscpluStldscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPUPRC_STLDSC_FLG:
        tpuprcStldscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MTCPLU_STLDSC_FLG:
        mtcpluStldscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_GRPPRC_STLDSC_FLG:
        grpprcStldscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RND_DSCNT_FLG:
        rndDscntFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_U_PRCCHG_DSC_FLG:
        uPrcchgDscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_GRPPRC_DSC_FLG:
        grpprcDscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DSCPLU_CLSDSC_FLG:
        dscpluClsdscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHUPRC_CLSDSC_FLG:
        othuprcClsdscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DSC_SHARE_FLG:
        dscShareFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WGTBAR_CALC_FLG:
        wgtbarCalcFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_AVEPRISPLIT_FLG:
        bdlAveprisplitFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STM_AVEPRISPLIT_FLG:
        stmAveprisplitFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRIPLU_CLSDSC_FLG:
        pripluClsdscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BRGN_PRC_FLG:
        brgnPrcFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REPEAT_DSC_FLG:
        repeatDscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_5000:
        acxN5000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_2000:
        acxN2000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_1000:
        acxN1000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_500:
        acxN500 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_100:
        acxN100 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_50:
        acxN50 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_10:
        acxN10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_5:
        acxN5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_N_1:
        acxN1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_5000:
        acxS5000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_2000:
        acxS2000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_1000:
        acxS1000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_500:
        acxS500 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_100:
        acxS100 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_50:
        acxS50 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_10:
        acxS10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_5:
        acxS5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_S_1:
        acxS1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BOTH_ACR_CLR_FLG:
        bothAcrClrFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_5000:
        acxM5000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_2000:
        acxM2000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_1000:
        acxM1000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_500:
        acxM500 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_100:
        acxM100 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_50:
        acxM50 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_10:
        acxM10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_5:
        acxM5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_1:
        acxM1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BKUP_RCPT_ADD:
        bkupRcptAdd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_CLSDSC:
        notClsdsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MYSELF_EVOID:
        myselfEvoid = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FANFARE_NO_EFECT:
        fanfareNoEfect = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FANFARE_EFECT:
        fanfareEfect = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SALEDATE_PLUS:
        saledatePlus = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_PRN_SHARE:
        crdtPrnShare = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRAINING_TIME_PRN:
        trainingTimePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SVSTCKT_TTLPNT_PRN:
        svstcktTtlpntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_SET_PRESET_MSG:
        notSetPresetMsg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_CMD_CHG:
        rwCmdChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_NOT_STLDSC:
        vmcNotStldsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DECIMAL_ROUND:
        decimalRound = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DECIMAL_ROUND_OFF:
        decimalRoundOff = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_COMP_NO_CHK:
        rwCompNoChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOW_PRICE_1:
        lowPrice1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_IMG_CHG:
        taxImgChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CASE_SLCT:
        selfCaseSlct = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KICHEN_NO_PRN:
        kichenNoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_INPUT_CUST:
        autoInputCust = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_HESO_CHG_PNT:
        rwHesoChgPnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_NOT_DRWCASH:
        vmcNotDrwcash = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUST_PNT_NOT_SET:
        custPntNotSet = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_WGTCHK_ONEITEM:
        selfWgtchkOneitem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PNTADD_ZERO_INPUT:
        pntaddZeroInput = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKT_TTLPNT_PRN:
        tcktTtlpntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ALL_ADDPNT_FLG:
        allAddpntFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUST_PRICE_KEYONLY:
        custPriceKeyonly = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACCTRCPT_ADDR_PRN:
        acctrcptAddrPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NEAREND_CHK_CNCL:
        nearendChkCncl = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TTLAMT_SIMPLE_DISP:
        ttlamtSimpleDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_DRWAMT_MINUS:
        vmcDrwamtMinus = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_RIGHT_FLOW:
        selfRightFlow = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_BACTH_REST:
        autoBacthRest = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHILD_ROCK_200:
        childRock200 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_ENDBTN_CHG:
        selfEndbtnChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_RCPT_CALL_CHECKER:
        selfRcptCallChecker = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CARDREADER_DISP:
        selfCardreaderDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CASHCNCL_CALL:
        selfCashcnclCall = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_MSGSEND_OUTSCALE:
        selfMsgsendOutscale = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_POSSIBLE_ESVOID:
        rwPossibleEsvoid = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MULTI_PROM:
        multiProm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACCRUED_DISP:
        accruedDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACCTRCPT_EXCEPT_CHA1:
        acctrcptExceptCha1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SVSTCKT_ONE_SHEET:
        svstcktOneSheet = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKTKEY_BEFORE_CUST:
        tcktkeyBeforeCust = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BIG_PNT_PRN:
        bigPntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JPN_DATE_PRN:
        jpnDatePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLSPRN_NOT_MARK:
        clsprnNotMark = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PNT_HIGH_LIMIT:
        pntHighLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUSTPRC_KEY_CHG:
        custprcKeyChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEMVOID_DISP:
        itemvoidDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RISEPRC_BLOCK:
        riseprcBlock = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRIORITY_STLDSC:
        priorityStldsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEMVOID_PROC:
        itemvoidProc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARDSHEET_PRN:
        cardsheetPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_FSPSTLPDSC:
        vmcFspstlpdsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_INSCALE_ERR:
        selfInscaleErr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_CHG_HESO_PNT:
        vmcChgHesoPnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_RE_READCHECK:
        rwReReadcheck = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_ADDITEM_BLOCK:
        selfAdditemBlock = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_ENDBTN_WGTCHK:
        selfEndbtnWgtchk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CONT_PRESETDISP:
        selfContPresetdisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_NAME_PRN:
        promNamePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_RPR_TCKT_BLOCK:
        vmcRprTcktBlock = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_OUT_RANK_PNT:
        vmcOutRankPnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_MSG_FEW:
        promMsgFew = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_SET_PRESET_ENT:
        notSetPresetEnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DSC_BARCODE_AMT:
        dscBarcodeAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RFM_ONLY_ISSUE:
        rfmOnlyIssue = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RFM_USE_STAMP_AREA:
        rfmUseStampArea = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_UPD_CUST_0SALES:
        notUpdCust0sales = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_LOW_PRICE_1:
        useLowPrice1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRCCHK_ONLY_1TIME:
        prcchkOnly1time = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KEEP_INT_2PERSON:
        keepInt2person = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_TPR9000_COMB:
        vmcTpr9000Comb = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_MBRCARD_EXIST:
        dispMbrcardExist = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_DSP_LCD_BRGNITEM:
        notDspLcdBrgnitem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_CULC_MUL_DISCITEM:
        chgCulcMulDiscitem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_PRN_PRCCHG_DISCWD:
        notPrnPrcchgDiscwd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRN_REPT_REFINFO_SML:
        prnReptRefinfoSml = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_SPLPRC_NPNPLU:
        enableSplprcNpnplu = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRN_2RCPT_EATIN:
        prn2rcptEatin = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SAME_ITEM_1PRC_TRAN:
        sameItem1prcTran = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSP_STLDSC_TRG_SUB_INTAX:
        fspStldscTrgSubIntax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_CULC_ITEMCAT_DISC:
        chgCulcItemcatDisc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VD_ENABLE_BATVOID_ONLY:
        vdEnableBatvoidOnly = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_STLDSC_SCAN_CLKCODE:
        enableStldscScanClkcode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_SM_USE_EARLYEND_SCH:
        bdlSmUseEarlyendSch = trmData.toInt();
        break;
      case TrmCdList.TRMNO_GP_LIMIT_OFF_NAME:
        gpLimitOffName = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_COLOR_OPEMSG:
        useColorOpemsg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_DISABLE_USE_PANA_POINT_MOVE:
        rwDisableUsePanaPointMove = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_CLS_DISCSCH_UNTIL_2359:
        enableClsDiscschUntil2359 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRG_PRC0_USE_ALLPOINT:
        trgPrc0UseAllpoint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JACKLE_DISP_MBRNUM_16D:
        jackleDispMbrnum16d = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOT_USE_POINTUNIT_IN_SALEADD:
        notUsePointunitInSaleadd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACR_SUBSTITUTE_RECOVER:
        acrSubstituteRecover = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_MBRNUM_8D_IN_MBRNUM_NOT_PRN:
        dispMbrnum8dInMbrnumNotPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_SALEPRC_INCL_TAX:
        selfSaleprcInclTax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRN_QRCODE_RECEIPT:
        prnQrcodeReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_ERRMSG_IN_BLUETIP:
        chgErrmsgInBluetip = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_BDL_PRC_ITEMSCREEN:
        dispBdlPrcItemscreen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRN_STAMPAREA_MINUSSALE:
        nonPrnStampareaMinussale = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_POINT_WORK_CT3100:
        autoPointWorkCt3100 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_ENT_OPE_SIMPLE_OPENCLOSE:
        disableEntOpeSimpleOpenclose = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_RECOVER_FEE_SVSCLS1:
        disableRecoverFeeSvscls1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CULC_CREDIT_1_100TIMES:
        culcCredit1_100times = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ISSUE_NOTE_PRN:
        issueNotePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CATDNO_START_NO:
        catdnoStartNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MGN_TYP:
        mgnTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWT_PRN_MBRFILE:
        rwtPrnMbrfile = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MUL_SML_DSC_USETYP:
        mulSmlDscUsetyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REFUND_STLDSC:
        refundStldsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ORG_ID_PRN:
        orgIdPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRAN_ID:
        tranId = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEM_CODE:
        itemCode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_GOOD_THRU_DSP:
        goodThruDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OPE_TYPE:
        opeType = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_TIME_OUT:
        crdtTimeOut = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELFGATE_WGTALW_LIMIT:
        selfgateWgtalwLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_INTAX_PRN:
        intaxPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_IN_TAX_PRN:
        inTaxPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CATDNO_DIGIT:
        catdnoDigit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCALE_WGT:
        scaleWgt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WARRANTY_NOTE_PRN:
        warrantyNotePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CATALINE_KEY_CD:
        catalineKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OFF_BTN_FLG:
        offBtnFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUST_SALE_PRN_TYP:
        custSalePrnTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RET_PRESET_1PAGE:
        retPreset1page = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STRE_OPEN_REPORT:
        streOpenReport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MANUAL_RFM_TAX_CD:
        manualRfmTaxCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP1_LIMIT:
        receiptGp1Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP2_LIMIT:
        receiptGp2Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP3_LIMIT:
        receiptGp3Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP4_LIMIT:
        receiptGp4Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP5_LIMIT:
        receiptGp5Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP6_LIMIT:
        receiptGp6Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP1_TAX:
        receiptGp1Tax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP2_TAX:
        receiptGp2Tax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP3_TAX:
        receiptGp3Tax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP4_TAX:
        receiptGp4Tax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP5_TAX:
        receiptGp5Tax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_GP6_TAX:
        receiptGp6Tax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_CALC:
        taxCalc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WARN_MSCRAP_FLG:
        warnMscrapFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DRAW_CASH_CHK:
        drawCashChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WARRANTY_CNT_PRN:
        warrantyCntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PCTR_TCKT2_PRC_PRN:
        pctrTckt2PrcPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PCTR_TCKT3_PRC_PRN:
        pctrTckt3PrcPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PCTR_TCKT_MSG1:
        pctrTcktMsg1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PCTR_TCKT_MSG2:
        pctrTcktMsg2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_JAN_PRN:
        tagJanPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_AMT_IMG_PRN:
        tagAmtImgPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_CUST_AMT_PRN:
        tagCustAmtPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_BRGNPRC_IMG_PRN:
        tagBrgnprcImgPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_CLSCD_PRN:
        tagClscdPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_TAXAMT_IMG_PRN:
        tagTaxamtImgPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_TAXAMT_PRN:
        tagTaxamtPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_FRAME_PRN:
        tagFramePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAG_EXTAX_PRN:
        tagExtaxPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MOBILEPOS_TYP:
        mobileposTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OFFMODE_PASSWD_TYP:
        offmodePasswdTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXTRA_AMT_FLG:
        extraAmtFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACS_N_DISP:
        acsNDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EX_ITEM_TTLAMT_FLG:
        exItemTtlamtFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EX_BRGN_TTLAMT_FLG:
        exBrgnTtlamtFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EX_MMSTM_TTLAMT_FLG:
        exMmstmTtlamtFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_DIVIDE_FLG:
        taxDivideFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POPPY_TTLAMT_ROUND:
        poppyTtlamtRound = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_REGFLOW:
        selfRegflow = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_WGTCHK_START:
        selfWgtchkStart = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_ADD_ITEM:
        selfAddItem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_WGTCHK_END:
        selfWgtchkEnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_PRESET_END_DISP:
        selfPresetEndDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_M_10000:
        acxM10000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PCTR_TCKT_STORE:
        pctrTcktStore = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROMISSUE_LOWLIMIT:
        promissueLowlimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROMISSUE_NO:
        promissueNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROD_NAME_PRN_TYP:
        prodNamePrnTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OFFMODE_PASSWD:
        offmodePasswd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CONT_QTY_PRN:
        contQtyPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_NOCUST_USE_FLG:
        selfNocustUseFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CUSTCARD_DISP:
        selfCustcardDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CUSTCARD_TYP:
        selfCustcardTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRANING_DRAW_ACX_FLG:
        traningDrawAcxFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MAGAZINE_SCAN_TYP:
        magazineScanTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CULAY_ADD_FLG:
        culayAddFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NONPLU_AMT_HIGH_LIMIT:
        nonpluAmtHighLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_AMT_10000_FLG:
        chgAmt10000Flg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STRE_CLS_BATREPORT:
        streClsBatreport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRCCHG_DSC_FLG:
        prcchgDscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRCCHK_COST_DISP:
        prcchkCostDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_SLCT_KEY_CD:
        selfSlctKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POPPY_MAKER_SLCT:
        poppyMakerSlct = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POPPY_CONT_QTY_SLCT:
        poppyContQtySlct = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CRDT_KEY_CD:
        selfCrdtKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REPORT_BKUP_FORMAT:
        reportBkupFormat = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MOBILEPOS_INFO_PRN:
        mobileposInfoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_STAMP_KEY_CD:
        selfStampKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM1:
        outSmlclsNum1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM2:
        outSmlclsNum2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM3:
        outSmlclsNum3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM4:
        outSmlclsNum4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM5:
        outSmlclsNum5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_EDY_KEY_CD:
        selfEdyKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_INTAX_COSTPER_CALC:
        intaxCostperCalc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PSP_MINUS_AMT:
        pspMinusAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLU_INIT_SMLCLS_CD:
        pluInitSmlclsCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKT_PRN_TARGET:
        tcktPrnTarget = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISH_QTY_MAX:
        dishQtyMax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CATALINACPN_KEY_CD:
        catalinacpnKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RBTL_ADD_SALE_AMT:
        rbtlAddSaleAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RBTL_MIX_REFMIX:
        rbtlMixRefmix = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRC_VOICE:
        prcVoice = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ZERO_AMT_PAY_FLG:
        zeroAmtPayFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REFMIX_FLG:
        refmixFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SIMPLE_RECEIPT_PRCCHK:
        simpleReceiptPrcchk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_PRN_INTAX_PRC_RFM:
        disablePrnIntaxPrcRfm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_MARK_CONTROL:
        printMarkControl = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_PRN_IN_RFM_NOTE_PRN:
        receiptPrnInRfmNotePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RALSE_MAG_FMT:
        ralseMagFmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RALSE_DISC_2BARCODE:
        ralseDisc2barcode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_BDL_ITEM_REF:
        enableBdlItemRef = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CONTINUE_REF_OPE:
        continueRefOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_PRN_NONSUMMARY:
        bdlPrnNonsummary = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_WORD_COLOR_MBRPRC:
        chgWordColorMbrprc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REF_BDL_ITEM_CULC_DISC_OPE:
        refBdlItemCulcDiscOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_LOW_PRICE_3:
        useLowPrice3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_ACTSALE_TERM_PRCCHG:
        enableActsaleTermPrcchg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_SM_SCHEDULE_METHOD_2:
        bdlSmScheduleMethod2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_CHANGE_OVER_AMT:
        nonChangeOverAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_REF_OPE_WORD:
        dispRefOpeWord = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHAR_SEARCH_RECORD_CONF:
        charSearchRecordConf = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STL_AUTODISC_1_10TIMES:
        stlAutodisc1_10times = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_CASHKEY_1PERSON:
        disableCashkey1person = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_RFM_NOTE_CUT:
        disableRfmNoteCut = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_STAMP_CHA9KEY:
        disableStampCha9key = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_PRN_CLERK_DISC:
        disablePrnClerkDisc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_DISC_BARCODE_FLAG:
        chgDiscBarcodeFlag = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REPEAT_PLUKEY_OPE:
        repeatPlukeyOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSP_LEVEL_BONUS_POINT:
        fspLevelBonusPoint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NW7MBR_BARCODE_1:
        nw7mbrBarcode1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NW7MBR_REAL:
        nw7mbrReal = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRN_SALE_TICKET:
        prnSaleTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_MARK_CONTROL_TYP_NOTSTLDSC:
        printMarkControlTypNotstldsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_RW_POSI_LEFT:
        selfRwPosiLeft = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KASUMI_DISC_BARCODE:
        kasumiDiscBarcode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KYUMATSU_RW_PROC:
        kyumatsuRwProc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SEIKATSUCLUB_OPE:
        seikatsuclubOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_SHOPNAME_CREDIT_MULTI_RECEIPT:
        printShopnameCreditMultiReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_MBR_POINT_P:
        printMbrPointP = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OPEN_OPE_DATECHG_15:
        openOpeDatechg15 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEDIA_INFO_REPORT:
        mediaInfoReport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_DISCFLAG_DISC2BARCODE:
        disableDiscflagDisc2barcode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_RFM_DETAIL:
        printRfmDetail = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_FIPMES_SELF:
        dispFipmesSelf = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_SPPRC_DISCITEM:
        disableSpprcDiscitem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_BDL_LOW_PRICE:
        useBdlLowPrice = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_DISP_HESO_MARK:
        nonDispHesoMark = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_CARDCHK_RW_PANA:
        disableCardchkRwPana = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_ASTMARK_ITFBARCODE:
        printAstmarkItfbarcode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RW_PRINTAREA_EXT:
        rwPrintareaExt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FUTAGAMI_PNTCARD_FLG:
        futagamiPntcardFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_SPDSC_NONPLU:
        enableSpdscNonplu = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_ACX_USE_VMC:
        enableAcxUseVmc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ORIGINAL_CARD_OPE:
        originalCardOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_CULC_PROFIT_WTBAR:
        chgCulcProfitWtbar = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_POINT_1_100TIMES:
        printPoint1_100times = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RESERVE_PREPAY_POSTPAY_ACTSALE:
        reservePrepayPostpayActsale = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ATRE_CASH_POINT_IP3100:
        atreCashPointIp3100 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_LENGTH_MAGCARD:
        chkLengthMagcard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CPN_QTY_NON_POINT_ITEM_QTY:
        cpnQtyNonPointItemQty = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_CREDIT_VOID_OTHERMAC:
        enableCreditVoidOthermac = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_CHG_FIP_SPRIT_OPE:
        dispChgFipSpritOpe = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_DISABLE_PAYMET_ACT_ACX: 	_disablePaymetActAcx  = trmData.toInt(); break;
      case TrmCdList.TRMNO_FELICA_WR_BEFORE_RECEIPT:
        felicaWrBeforeReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NTTEAST_CHG_HTTP_HTTPS:
        ntteastChgHttpHttps = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NTTEAST_DISABLE_DEL_MASTER:
        ntteastDisableDelMaster = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NTTEAST_READ_INTERNAL_FOLDER:
        ntteastReadInternalFolder = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NTTEAST_SET_SALEDATA_INTERNAL_FOLDER:
        ntteastSetSaledataInternalFolder = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OMC_LESS_30000:
        omcLess30000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_DISP_REBATE_EXCLUSION:
        chgDispRebateExclusion = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_ENT_CLS_OPE:
        disableEntClsOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_CHAKEY_ACX:
        disableChakeyAcx = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_PRINT_WARRANTY_INFO:
        chgPrintWarrantyInfo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_BACKUP_OPEN_DATA:
        disableBackupOpenData = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OPE_TIME_USE:
        opeTimeUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_MBR_TICKET_REPRINT:
        disableMbrTicketReprint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPCIAL_ITEM_COMBINE:
        spcialItemCombine = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SIBERU_OPE_REPORT:
        siberuOpeReport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CULC_METHOD_TERMINAL_ITEMSTACK:
        culcMethodTerminalItemstack = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_MARK_CONTROL_TYP_PNTYEN:
        printMarkControlTypPntyen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_RECIPE:
        printRecipe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_TICKET_EN:
        printTicketEn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_CUST_ITEM_UPRC:
        dispCustItemUprc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_ACB50_CONTROL_1:
        acxAcb50Control1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BINGO_CARD_CONNECT:
        bingoCardConnect = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HOSTNAME_IN_FTP_CONNECT:
        hostnameInFtpConnect = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REBATE_FANFARE_IN_CASHKEY:
        rebateFanfareInCashkey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_TOTAL_CHAR_BIGGER:
        receiptTotalCharBigger = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_CHANGE_CHAR_BIGGER:
        receiptChangeCharBigger = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_POINT_DISP_INFOX:
        disablePointDispInfox = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SIBERU_REPORT_TITLE_CHG:
        siberuReportTitleChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SEARCH_VOID_PRIORITY_1:
        searchVoidPriority1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SEARCH_VOID_CONF_MSG:
        searchVoidConfMsg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_CLS_STLDISC_FLAG:
        useClsStldiscFlag = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_CLS_2D:
        printCls2d = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SEARCH_VOID_DISABLE_PRCOVER:
        searchVoidDisablePrcover = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ERROR_SLEEP_MBR:
        errorSleepMbr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRANRCEIPT_BARFLG_EQUAL_JAN:
        tranrceiptBarflgEqualJan = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DEL_SHOPBAG_VOICE_SSPS:
        delShopbagVoiceSsps = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_UPRC_EN:
        nonPrintUprcEn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_EMPTY_TOTALLOG_TXT:
        useEmptyTotallogTxt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_CASHPICKAMT_SALEPICK:
        printCashpickamtSalepick = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ISSUE_TICKET_EN_OVER:
        issueTicketEnOver = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBR_CONTACT_SAMETIME:
        mbrContactSametime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MATSUGEN_MAGCARD:
        matsugenMagcard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FELICA_WR_ANOTHER_CARD:
        felicaWrAnotherCard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_VOIDOPE_NONSUMMARY:
        nonPrintVoidopeNonsummary = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_CHG_TIMING_FELICA_TOUCH:
        selfChgTimingFelicaTouch = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_DISPVOID_STL_ITEMSCREEN:
        enableDispvoidStlItemscreen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JOYPOS_CREDIT_CHAKEY:
        joyposCreditChakey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DEL_SUICATRADE_WORD:
        delSuicatradeWord = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECHK_TENDER_EDY_SUICA:
        rechkTenderEdySuica = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TUO_CHG_PROC:
        tuoChgProc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PATIO_MBRPOINT_PANACODE:
        patioMbrpointPanacode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COOP_YAMAGUCHI_GREEN_STAMP:
        coopYamaguchiGreenStamp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_RANDAM_ITEM:
        nonPrintRandamItem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_FIX_PRICE_ENT:
        enableFixPriceEnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_ADD_STORE_CUST_RET_BOTTLE:
        nonAddStoreCustRetBottle = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NW7MBR_BARCODE_2:
        nw7mbrBarcode2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_STLPDSC_KEY:
        selfStlpdscKey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_AUTO_PDSC_LMT:
        selfAutoPdscLmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SUS_TYP_FLG:
        susTypFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TIME_PRC_TYP:
        timePrcTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_STLPDSC_OPE:
        crdtStlpdscOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM6:
        outSmlclsNum6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM7:
        outSmlclsNum7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM8:
        outSmlclsNum8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM9:
        outSmlclsNum9 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_SMLCLS_NUM10:
        outSmlclsNum10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_USER_NO:
        crdtUserNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MAGCARD_CHK_LEN:
        magcardChkLen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JIS2_LEN:
        jis2Len = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_CIN_FIPDISP:
        acxCinFipdisp = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_ACX_CIN_ADD_TRAN: 	_acxCinAddTran  = trmData.toInt(); break;
      case TrmCdList.TRMNO_SELF_CRDT_SLIP_KEY_CD:
        selfCrdtSlipKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_OFFCRDT_KEY_CD:
        selfOffcrdtKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BOOK_SUM_PLU_TYP:
        bookSumPluTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DESKCSHR_RCPT_FLG:
        deskcshrRcptFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DUTY_OUT_FLG:
        dutyOutFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DUTY_REST_FLG:
        dutyRestFlg = trmData.toInt();
        break;
//			case TrmCdList.TRMNO_WARNING_ITEM_FLG: 	_warningItemFlg  = trmData.toInt(); break;
      case TrmCdList.TRMNO_WARNING_ITEM_FLG:
        warningItemFlg = 0;
        break; //フルセルフの警告商品登録時は店員呼出固定
      case TrmCdList.TRMNO_SEPARATE_CHG_AMT:
        separateChgAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_OTHER_PAY:
        selfOtherPay = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_WGT_ERRCHK_PER:
        selfWgtErrchkPer = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ORDR_DAYS_LATER:
        ordrDaysLater = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_TRANS_IC_KEY_CD:
        selfTransIcKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_TRANS_IC_UNFINISH_KEY_CD:
        selfTransIcUnfinishKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_TRANS_IC_ERRMSG_KEY_CD:
        selfTransIcErrmsgKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_PRESET_DISP:
        selfPresetDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_VISATOUCH_KEY_CD:
        selfVisatouchKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CPNBAR_DSC_KEY_CD:
        cpnbarDscKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_APPROVAL_INPUT_FLG:
        approvalInputFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SP_CPN_COMP_CD:
        spCpnCompCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SP_CPN_DSC_KEY_CD:
        spCpnDscKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SP_CPN_PDSC_KEY_CD:
        spCpnPdscKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_WGTCHK_FLG:
        selfWgtchkFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_MYBACK_STAMP_KEY_CD:
        selfMybackStampKeyCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_OFF_BATREPORT:
        autoOffBatreport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXCHANGE_TCKT_FLG:
        exchangeTcktFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_BIG_ITEM:
        selfBigItem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TBLFORMAT_OUTPUT:
        tblformatOutput = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRECA_CHARGE_MAX_AMT:
        precaChargeMaxAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REGS_DISP_RET_TIME:
        regsDispRetTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ORDR_COST_DISP:
        ordrCostDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DRUG_EXP_KIND:
        drugExpKind = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_AFTER_MANU_DISC:
        bdlAfterManuDisc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_SR_BDL_BAR_PRC:
        disableSrBdlBarPrc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MYSELF_VOID_OPE:
        myselfVoidOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_STLDISC_CREDIT_STLDISC:
        disableStldiscCreditStldisc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KASUMI_CHK_AEON_CREDIT:
        kasumiChkAeonCredit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_CREDIT_ITEM_DETAIL:
        nonPrintCreditItemDetail = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TERM_SPPRC_DISC_OPE:
        termSpprcDiscOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_RECEIPT_AMT0:
        nonPrintReceiptAmt0 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_PASSWORD_CLERK_ERROR:
        dispPasswordClerkError = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_CALLCLERK_NEAREND_ACX:
        dispCallclerkNearendAcx = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUT_EVERY_CREDIT_REPORT:
        cutEveryCreditReport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_WARN_WORD_VD_TR_SR:
        chgWarnWordVdTrSr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_REG_COLOR_VOID_REFOUND:
        chgRegColorVoidRefound = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REPORT_CONDITION_1:
        reportCondition1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_MSG_RELEASE_AGECONF:
        dispMsgReleaseAgeconf = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_PRESET_7P_SSPS:
        disablePreset7pSsps = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_MYBAG_WORD:
        printMybagWord = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_EXEC_CLOSEOPE:
        autoExecCloseope = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_DIFF_CASH_CHK3:
        chkDiffCashChk3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_RECOVER_ECS07:
        acxRecoverEcs07 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_DISCHA_CREDIT_VOID:
        acxDischaCreditVoid = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_CULC_SPLIT_OMC:
        chgCulcSplitOmc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_OFFONLINE_MBR:
        chkOffonlineMbr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_FCFCARD_CHK:
        disableFcfcardChk = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_DISABLE_ACX_RECOVER_SALES: 	_disableAcxRecoverSales  = trmData.toInt(); break;
      case TrmCdList.TRMNO_FSP_TICKET:
        fspTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_CANCEL_ITEMSCAN:
        dispCancelItemscan = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CALC_CD_KASUTAMU_BRIDALCARD:
        calcCdKasutamuBridalcard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CALC_CD_RINGOCARD:
        calcCdRingocard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CALC_CD_OFFONCARD:
        calcCdOffoncard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_MEAL_TICKET:
        chgMealTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_WARRANTY_TICKET:
        chgWarrantyTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WARRANTY_WITH_RECEIPT:
        warrantyWithReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_ITEM_SCAN_SSPS:
        enableItemScanSsps = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_CLERKNUM_1546:
        useClerknum1546 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_OPE_WITHOUT_QS:
        ticketOpeWithoutQs = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_CASH_INPUT_MANUAL:
        acxCashInputManual = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_ACX_INPUT_DISP:
        chgAcxInputDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_STAR_ITEMNAME:
        dispStarItemname = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_POINT_OPENOPE:
        printPointOpenope = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NONTAX_CHA10:
        nontaxCha10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_MSG2_4_PROMO:
        printMsg2_4_promo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_RECOVER_SAME_BUTTON:
        acxRecoverSameButton = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_WARN_CHANGE_ECS07:
        acxWarnChangeEcs07 = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_DISABLE_ACX_INPUT_SALES: 	_disableAcxInputSales  = trmData.toInt(); break;
      //case TrmCdList.TRMNO_DISABLE_ACX_OUTPUT_SALES: 	_disableAcxOutputSales  = trmData.toInt(); break;
      case TrmCdList.TRMNO_INCLUDE_DIFF_CHK_CASH:
        includeDiffChkCash = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_TICKET_REALREBATE:
        enableTicketRealrebate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_KASUMICARD_SELF:
        chgKasumicardSelf = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_CHG_RECOVER_AREA:
        acxChgRecoverArea = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_CHGPR_DISC_OUTCLS:
        enableChgprDiscOutcls = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_WT0_WTERR:
        disableWt0Wterr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_PASSWORD_WTERROR:
        dispPasswordWterror = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DELIVERY_DOUBLE_RECEIPT:
        deliveryDoubleReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_RAINBOWCARD:
        chkRainbowcard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_RECOVER_LESS_ERROR:
        acxRecoverLessError = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CANCEL_SALE_ADD_ABSOLUTEVALUE:
        cancelSaleAddAbsolutevalue = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_DISCBACODE_FLG:
        chgDiscbacodeFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_DISCVAL_ITEMPRC:
        enableDiscvalItemprc = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_ACX_EXCHANGE_INPUT: 	_acxExchangeInput  = trmData.toInt(); break;
      //case TrmCdList.TRMNO_HESO_SALE_MANUAL_PRC: 	_hesoSaleManualPrc  = trmData.toInt(); break;
      case TrmCdList.TRMNO_NON_PRINT_PLEASE_STOCK:
        nonPrintPleaseStock = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_DISP_PREPAGE2_7:
        disableDispPrepage2_7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_SALES_ITEM_BARCODE_PRINT:
        ampmSalesItemBarcodePrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_MASTER_IMPORT:
        ampmMasterImport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_BIGGER_RECOMMEND_POINT:
        useBiggerRecommendPoint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_PRESETNAME_CONVENIENCESTORE:
        chgPresetnameConveniencestore = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_CD_OMCCARD:
        chkCdOmccard = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCAN_PANEL_OPE:
        scanPanelOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEM_DISC_UPPERREF:
        itemDiscUpperref = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_ADD_STLDISCVAL_PRC:
        ampmAddStldiscvalPrc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRANDETAIL_REPORT_INTAX_NOTPRN:
        trandetailReportIntaxNotprn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRANDETAIL_REPORT_EXTAX_NOTPRN:
        trandetailReportExtaxNotprn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRANDETAIL_REPORT_TRANIN_EXTAX_PRN:
        trandetailReportTraninExtaxPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRANDETAIL_REPORT_IN_EXTAX_PRN:
        trandetailReportInExtaxPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_CHG_STARTUP_MOV:
        ampmChgStartupMov = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_SKIP_ITEM_REG:
        dispSkipItemReg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NALSE_PANACODE:
        nalsePanacode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_PROPDIV:
        chgPropdiv = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MASTER_IMPORT_MAKE:
        masterImportMake = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_MBRNAME_TYPE:
        promMbrnameType = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPECIALCONV_WEEKBOOK:
        specialconvWeekbook = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPECIALCONV_OTHWEEKBOOK:
        specialconvOthweekbook = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOASON_MASTER_IMPORT:
        loasonMasterImport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SALE_SAVE_CLOSEOPE:
        saleSaveCloseope = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_LOG_SAVE_CLOSEOPE:
        acxLogSaveCloseope = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SUICA_SHORT_RECEIPT:
        suicaShortReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_EXTAX_CALC:
        useExtaxCalc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPPRC_GET_TAXAMT:
        spprcGetTaxamt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_UPCE_UPCA:
        chgUpceUpca = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOASON_NW7MBR:
        loasonNw7mbr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_BUTTON_AREA_OPENCLOSE:
        chgButtonAreaOpenclose = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_MSG_BAR_NOT_READ:
        chgMsgBarNotRead = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_MBRPRC_OTHMBR:
        disableMbrprcOthmbr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_SUM_TAX:
        printSumTax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_INSTNUM_WIZPOD:
        printInstnumWizpod = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRG_PRESET_NAME:
        prgPresetName = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RALSE_POINT_INPUT_FNC:
        ralsePointInputFnc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COMB_MBR_CLKDSC:
        combMbrClkdsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_SUMMARYPRINT_TICKET:
        nonSummaryprintTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_SCAN_FUNC_1:
        ampmScanFunc1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_SCAN_FUNC_2:
        ampmScanFunc2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AMPM_SEPARATE_BDL_SM:
        ampmSeparateBdlSm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ADD_VOID_RECEIPT_TTLLOG:
        addVoidReceiptTtllog = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_PASSWORD_ERROR:
        dispPasswordError = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_OPTIONVAL_SEARCHVOID:
        useOptionvalSearchvoid = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXCEPT_OTHCASH_RECALC:
        exceptOthcashRecalc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_NONRECEIPT_PAYSCREEN:
        dispNonreceiptPayscreen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_MBRSTLPDSC_KEY:
        selfMbrstlpdscKey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EDY_ALARM_PRN:
        edyAlarmPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAB_POSITION:
        tabPosition = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAB_STL_SAVE:
        tabStlSave = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_OUTHOLD_CUST:
        cashmgmtOutholdCust = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_EXCHG:
        cashmgmtExchg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_SHEET_DISP:
        cashmgmtSheetDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_CALC_CUST:
        cashmgmtCalcCust = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_CALC_BASE:
        cashmgmtCalcBase = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BEHIND_PICK_TYP:
        behindPickTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_RCPT_INFO:
        cashmgmtRcptInfo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_INOUT_UNIT:
        cashmgmtInoutUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_STAFF_OPERATION:
        cashmgmtStaffOperation = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_STAFF_INPUT:
        cashmgmtStaffInput = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_APPLY_TYP:
        cashmgmtApplyTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_INDICATE_RCPT:
        cashmgmtIndicateRcpt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_INOUT_RCPT_INFO:
        cashmgmtInoutRcptInfo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_CINPICK_PROC:
        cashmgmtCinpickProc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHMGMT_INFOBTN_DISP:
        cashmgmtInfobtnDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEM_ARRIVE_CALC:
        itemArriveCalc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RESERVPRN_NOTES:
        reservprnNotes = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WARNINGDISP_TYP:
        warningdispTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_SIGNLESS_MAX_LIMIT:
        crdtSignlessMaxLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RESERVE_STRORENOTE_DOUBLE:
        reserveStrorenoteDouble = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COOPAIZU_FUNC_1:
        coopaizuFunc1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASH_KIND_SELECT_RESERVEOPE:
        cashKindSelectReserveope = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUNKADO_QC_DISP:
        bunkadoQcDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_DISABLE_SERACH_REG:
        qcDisableSerachReg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_ENABLE_CANCEL:
        qcEnableCancel = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VMC_DISABLE_SALEUP_MENTE:
        vmcDisableSaleupMente = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_NBRNAME_TABAREA:
        dispNbrnameTabarea = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FOREIGN_DEPOSIT_OPE:
        foreignDepositOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RC_DISC_OPE:
        rcDiscOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_WTUPRC_CUSTDISP:
        dispWtuprcCustdisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_DISP_MUL_ITEM:
        chgDispMulItem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_CONNECT_CLK_OPEN:
        nonConnectClkOpen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WARN_SUS_REF_PRCCHK_USE:
        warnSusRefPrcchkUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_AFT_DISCPRC:
        printAftDiscprc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MANSO_OPE:
        mansoOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_IKEA_OPE:
        ikeaOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DRWCHK_DISP_CHKDRW_AMT:
        drwchkDispChkdrwAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_STARTBOTTUN_QC_START:
        dispStartbottunQcStart = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_SPLIT_QC_TICKET:
        disableSplitQcTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_SAME_TCKET_OK:
        qcSameTcketOk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_DIVADJ_RFM_PRC:
        qcDivadjRfmPrc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_DECISION_PASS:
        acxDecisionPass = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_QC_SIGNCOLOR:
        chgQcSigncolor = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_SALE_MENU_WIZ:
        disableSaleMenuWiz = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_STL_CHA_SPEEZA:
        chkStlChaSpeeza = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_CHG_MOV_PINK_RECEIPT:
        qcChgMovPinkReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAC_FUNC:
        tacFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_SHORT_TICKET:
        printShortTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_RECEIPT_CUT_MODE:
        chgReceiptCutMode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_SEARCH_CHANGE_TICKET:
        enableSearchChangeTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_SAME_TCKET_START_OK:
        qcSameTcketStartOk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_CLOSE_REPORT_FUNC:
        qcCloseReportFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LIGHT_ONOFF_CANCEL_OPE:
        lightOnoffCancelOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WIZ_AUTO_REG_IP3D:
        wizAutoRegIp3d = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NONPLU_READ_MSTPRC:
        nonpluReadMstprc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COOPSAPPORO_PRINT_FUNC:
        coopsapporoPrintFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_CALL_CLK_RFM:
        qcCallClkRfm = trmData.toInt();
        break;
//			case TrmCdList.TRMNO_QC_USE_SPEEZA_TERMINAL: 	_qcUseSpeezaTerminal  = trmData.toInt(); break;
      case TrmCdList.TRMNO_QC_USE_SPEEZA_TERMINAL:
        qcUseSpeezaTerminal = 0;
        break;
      case TrmCdList.TRMNO_CONNECT_SBS_CREDIT_1:
        connectSbsCredit1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DCMAL_PRCCHG_SPECIAL_CALC:
        dcmalPrcchgSpecialCalc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_SEPARATE_TICKET_FUNC:
        printSeparateTicketFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_SIGNAREA_CREDIT_NOTE:
        nonPrintSignareaCreditNote = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CONNECT_SBS_CREDIT_2:
        connectSbsCredit2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_RFM_CREDIT_WORD:
        chgRfmCreditWord = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_CALL_CLK_RFM_ISSUE:
        qcCallClkRfmIssue = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_ERR_AUTO_RPR:
        receiptErrAutoRpr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SAME_PRESET_PUSH_QTY:
        samePresetPushQty = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBRBARCODE_CUSTBARCODE:
        mbrbarcodeCustbarcode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_DISP_REPRINT_DIAG:
        qcDispReprintDiag = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACOOP_CREDIT_FUNC:
        acoopCreditFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VERTICAL_RFM:
        verticalRfm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_GET_UPD_SPEEZA:
        qcGetUpdSpeeza = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RESERVE_SPARE_TXT_BIG:
        reserveSpareTxtBig = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_MANU_REP_ITEM:
        nonPrintManuRepItem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_BLUECHIP_EVOID:
        enableBluechipEvoid = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_STORE_NOTE_GLORYMULTI:
        printStoreNoteGlorymulti = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_PRINT_CREDIT_TELNO:
        nonPrintCreditTelno = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KANESUE_NEWOPE_FUNC:
        kanesueNewopeFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PEINT_BEFORE_AFTER_DISCPRC:
        peintBeforeAfterDiscprc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_FREEEXCHANGE_ACB200_EOS07:
        acxFreeexchangeAcb200Eos07 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_ITEMNAME_AREA_BIG:
        printItemnameAreaBig = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_INTAX_SPLIT_RECEIPT:
        printIntaxSplitReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_ACCT_MBR_CALL:
        enableAcctMbrCall = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISC_BARCODE_28D:
        discBarcode28d = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRECA_CHARGE_NOT_DRWAMT:
        precaChargeNotDrwamt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACOOP_PRINT_FUNC_1:
        acoopPrintFunc1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_CHG_PRN_ORDR:
        qcChgPrnOrdr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CREDITVOID_CHK_FUNC:
        creditvoidChkFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_TERMINAL_CLS3D:
        printTerminalCls3d = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_ENT_CREDIT_OPE:
        enableEntCreditOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_SELECT_ITEM_NONBARKEY:
        selfSelectItemNonbarkey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ASSORT_RANDOM_ORDR_PRN:
        assortRandomOrdrPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ASSORT_RANDOM_SUM_PRN:
        assortRandomSumPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ASSORT_RANDOM_PRN_CHG:
        assortRandomPrnChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ATTENDANT_MBR_READ:
        attendantMbrRead = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WATARICARD_OPE:
        wataricardOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ASSORT_RANDOM_REPEAT:
        assortRandomRepeat = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SANWADO_DRWCHK_CHK:
        sanwadoDrwchkChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUSTSVR_OFFLINE_CHK:
        custsvrOfflineChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUSTSVR_CNCT_OFFLINE_CHK:
        custsvrCnctOfflineChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RESERV_NO_SET_FLG:
        reservNoSetFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ARKS_NEW_CARD_CHK:
        arksNewCardChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_MBR_CASHKEY:
        disableMbrCashkey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_USE_ACX_LESS10000:
        disableUseAcxLess10000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBR_REQ_TSD7000:
        mbrReqTsd7000 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCALE_NONUSE_SPEEZA:
        scaleNonuseSpeeza = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COMBINE_MAGMBR_CREDIT:
        combineMagmbrCredit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KAMADO_STLDSC_CHA1_FUNC:
        kamadoStldscCha1Func = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_RFM_DATA_DEL_PRN:
        qcRfmDataDelPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ENABLE_CHAKEY_CREDIT:
        enableChakeyCredit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_RESTART_CONTINUE:
        printRestartContinue = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_MANEGE_SRV_FUNC:
        ticketManegeSrvFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_SLIPNUM_TICKET:
        printSlipnumTicket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DAILYCLR_JMUPS:
        dailyclrJmups = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HTTPS_PROXY_USE:
        httpsProxyUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VOID_JMUPS:
        voidJmups = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISABLE_SEARCH_EDY_MBR_TRAN:
        disableSearchEdyMbrTran = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_TITLE_2TIMEBIG:
        printTitle2timebig = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_ERR_SCHEDULE_READ:
        dispErrScheduleRead = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHG_BUSINESS_CODE:
        chgBusinessCode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_DELIVERY_SHEET:
        printDeliverySheet = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_ARBITRARY_BITMAP:
        promArbitraryBitmap = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAILRFM_OVER_REVENUE:
        detailrfmOverRevenue = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WGTITEM_INFO_STLDISP:
        wgtitemInfoStldisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RFM_COUNTER_FUNC:
        rfmCounterFunc = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_DISABLE_ACX_INOUT_SALE: 	_disableAcxInoutSale  = trmData.toInt(); break;
      case TrmCdList.TRMNO_KASUMI_CHG_RFM:
        kasumiChgRfm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_TCKT_STAMP_PRINT:
        qcTcktStampPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MARUSHIME_MBR_FUNC:
        marushimeMbrFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_SALE_USE_UPD:
        qcSaleUseUpd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOSTPOINT_OFFMBR_PRINT:
        lostpointOffmbrPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OPENCLOSE_CHG_RT300:
        opencloseChgRt300 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_READ_NOT_SALEDATE_CHK:
        qcReadNotSaledateChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_STL_ITEMSCREEN:
        chkStlItemscreen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_BDL_QTY_LIMIT1:
        dispBdlQtyLimit1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SANRIKU_FUNC:
        sanrikuFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_READ_NOT_INTERRUPT:
        qcReadNotInterrupt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLSCNCL_ITEM_FLG:
        clscnclItemFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_LOW_PRICE_4:
        useLowPrice4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AYAHA_TICKET_FUNC:
        ayahaTicketFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUNKADO_FSP_FUNC:
        bunkadoFspFunc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_2TIMEWIDE_FSP:
        print2timewideFsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CALCCHG_DSC_CLSDSC:
        calcchgDscClsdsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOTTERY_OPE_FLG:
        lotteryOpeFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP1:
        acntPointTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP2:
        acntPointTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP3:
        acntPointTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP4:
        acntPointTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP5:
        acntPointTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP6:
        acntPointTyp6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP7:
        acntPointTyp7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP8:
        acntPointTyp8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP9:
        acntPointTyp9 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP10:
        acntPointTyp10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_POINT_TYP1:
        ticketPointTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_POINT_TYP2:
        ticketPointTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_POINT_TYP3:
        ticketPointTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_POINT_TYP4:
        ticketPointTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_POINT_TYP5:
        ticketPointTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SALE_PLU_POINT_TYP:
        salePluPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SUBT_DCNT_POINT_TYP:
        subtDcntPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SBS_RBT_POINT_TYP:
        sbsRbtPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MPLU_STLDSC_TYP:
        mpluStldscTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SMPLU_STLDSC_TYP:
        smpluStldscTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TDY_TGTMNY_PRINT:
        tdyTgtmnyPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TDY_POINT_PRINT:
        tdyPointPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TOTAL_POINT_PRINT:
        totalPointPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POSBL_POINT_PRINT:
        posblPointPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_NO_PRINT:
        memNoPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_MAGNO_PRINT:
        memMagnoPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_NAME_PRINT:
        memNamePrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANV_PRINT:
        anvPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_ACHIV_PRINT:
        pointAchivPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SBS_TCKT_DVID_PRINT:
        sbsTcktDvidPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SBS_TCKT_PRINT_KIND:
        sbsTcktPrintKind = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPCL_TCKT_TITLE:
        spclTcktTitle = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_ANV_DSP:
        memAnvDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANV_MNY_DSP:
        anvMnyDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_FIP_DSP:
        pointFipDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RVT_BEEP:
        rvtBeep = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_BCD_TYP:
        memBcdTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MAGCAD_KND:
        magcadKnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWCAD_KND:
        rwcadKnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_USE_TYP:
        memUseTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SBS_MTHD:
        sbsMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SBS_DSP_MTHD:
        sbsDspMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_CLC_UNIT:
        pointClcUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_CLC_RND:
        pointClcRnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PPOINT_MCLR_TYP:
        ppointMclrTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_SBS_CLR_TYP:
        pointSbsClrTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NW_RVT_POINT_TYP:
        nwRvtPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_ADD_MAGN:
        buyPointAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_BUY_POINT_LLMT_MNY:
        buyPointLlmtMny = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_RDWN:
        buyPointRdwn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_CUTPSTN:
        buyPointCutpstn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_AMTCLC_RND:
        pointAmtclcRnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLU_RGS_POINT_COND:
        pluRgsPointCond = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RVT_SUBST_MTHD:
        rvtSubstMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKT_AUTO_RVT_UNIT:
        tcktAutoRvtUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TGTMNY_CLC_MTHD:
        tgtmnyClcMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_LLIMT1:
        buyPointLlimt1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_MAGN1:
        buyPointMagn1 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_BUY_POINT_LLIMT2:
        buyPointLlimt2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_MAGN2:
        buyPointMagn2 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_BUY_POINT_LLIMT3:
        buyPointLlimt3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_MAGN3:
        buyPointMagn3 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_BUY_POINT_LLIMT4:
        buyPointLlimt4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUY_POINT_MAGN4:
        buyPointMagn4 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_MEM_ANYPRC_STET:
        memAnyprcStet = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_ANYPRC_REDU_STET:
        memAnyprcReduStet = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_MULPRC_KND:
        memMulprcKnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_MULPDSC_KND:
        memMulpdscKnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEM_MULADD_KND:
        memMuladdKnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TDY_TERM_COMP_PRINT:
        tdyTermCompPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TERM_COMP_PRINT:
        termCompPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NXTLVL_MNY_PRINT:
        nxtlvlMnyPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOW_LVL_PRINT:
        nowLvlPrint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_ADD_MAGN:
        anyprcTermAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_LLIMT1:
        anyprcTermLlimt1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_MAGN1:
        anyprcTermMagn1 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_LLIMT2:
        anyprcTermLlimt2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_MAGN2:
        anyprcTermMagn2 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_LLIMT3:
        anyprcTermLlimt3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_MAGN3:
        anyprcTermMagn3 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_LLIMT4:
        anyprcTermLlimt4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_MAGN4:
        anyprcTermMagn4 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_LLMT_MNY:
        anyprcTermLlmtMny = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TERM_RDWN:
        anyprcTermRdwn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TRM_CUTPSTN:
        anyprcTrmCutpstn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSP_CD:
        fspCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_S_LOWER_LIMIT:
        sLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_A_LOWER_LIMIT:
        aLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_B_LOWER_LIMIT:
        bLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_C_LOWER_LIMIT:
        cLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_D_LOWER_LIMIT:
        dLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_S_SUB_DCNT_RATE:
        sSubDcntRate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_A_SUB_DCNT_RATE:
        aSubDcntRate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_B_SUB_DCNT_RATE:
        bSubDcntRate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_C_SUB_DCNT_RATE:
        cSubDcntRate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_D_SUB_DCNT_RATE:
        dSubDcntRate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_S_LVL_ADD_MAGN:
        sLvlAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_A_LVL_ADD_MAGN:
        aLvlAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_B_LVL_ADD_MAGN:
        bLvlAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_C_LVL_ADD_MAGN:
        cLvlAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_D_LVL_ADD_MAGN:
        dLvlAddMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_ANYPRC_TRMAMTCLC_RND:
        anyprcTrmamtclcRnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLU_RGS_ANYPRC_TRM:
        pluRgsAnyprcTrm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ANYPRC_TRMCLC_MTHD:
        anyprcTrmclcMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP1:
        acntAnyprcTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP2:
        acntAnyprcTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP3:
        acntAnyprcTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP4:
        acntAnyprcTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP5:
        acntAnyprcTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP6:
        acntAnyprcTyp6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP7:
        acntAnyprcTyp7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP8:
        acntAnyprcTyp8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP9:
        acntAnyprcTyp9 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP10:
        acntAnyprcTyp10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_ANYPRC_TYP1:
        ticketAnyprcTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_ANYPRC_TYP2:
        ticketAnyprcTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_ANYPRC_TYP3:
        ticketAnyprcTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_ANYPRC_TYP4:
        ticketAnyprcTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TICKET_ANYPRC_TYP5:
        ticketAnyprcTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPLU_ANYPRC_TYP:
        spluAnyprcTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STLDSC_ANYPRC_TYP:
        stldscAnyprcTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SBS_RBT_ANYPRC_TYP:
        sbsRbtAnyprcTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RBT_FLG:
        rbtFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ISSUE_CUSTNAME_PRN:
        issueCustnamePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MAG_CARD_TYP:
        magCardTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARD_STRE_CD_CHK:
        cardStreCdChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MAG_ECFT_TRM_CHK:
        magEcftTrmChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHCMP_MAG_STRT_NO:
        othcmpMagStrtNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHCMP_MAG_EFCT_NO:
        othcmpMagEfctNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWT_CUSTMST_PRN:
        rwtCustmstPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTH_SALE_ADD:
        othSaleAdd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWT_INFO:
        rwtInfo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWT_WIND_PRN:
        rwtWindPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWT_WIND_DATE_PRN:
        rwtWindDatePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_GPNO_INPLU:
        gpnoInplu = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SMREG_MTHD:
        smregMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LVL_CHG_D_LVL:
        lvlChgDLvl = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RWT_SP_RBT_PER:
        rwtSpRbtPer = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_LST_S_LOWER_LIMIT:
        lstSLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LST_A_LOWER_LIMIT:
        lstALowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LST_B_LOWER_LIMIT:
        lstBLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LST_C_LOWER_LIMIT:
        lstCLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LST_D_LOWER_LIMIT:
        lstDLowerLimit = trmData.toInt();
        break;
      //case TrmCdList.TRMNO_PLU_ADD_PRINT: 	_pluAddPrint  = trmData.toInt(); break;
      case TrmCdList.TRMNO_STAMP_POINT_TYP1:
        stampPointTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAMP_POINT_TYP2:
        stampPointTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAMP_POINT_TYP3:
        stampPointTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAMP_POINT_TYP4:
        stampPointTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAMP_POINT_TYP5:
        stampPointTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SHOPPING_POINT:
        shoppingPoint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MUPRC_CLSDSC_FLG:
        muprcClsdscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BE_TOTAL_PNT_PRN:
        beTotalPntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BE_POSSIBLE_PNT_PRN:
        bePossiblePntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHER_STORE_MBR_DSP:
        otherStoreMbrDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBR_BLANKINFO_WARN:
        mbrBlankinfoWarn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHER_STORE_MBR_PRN:
        otherStoreMbrPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_TCKT_PRN_MAX:
        promTcktPrnMax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BIRTHDAY_POINT_PRN:
        birthdayPointPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBRSELLKEY_CTRL:
        mbrsellkeyCtrl = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BIRTHDAY_POINT_ADD:
        birthdayPointAdd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_D_ADD_POINT_PRN:
        dAddPointPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_D_ADD_PNT_DETAIL_PRN:
        dAddPntDetailPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ADD_POINT_PRIORITY:
        addPointPriority = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_MBR_PNT_PRN:
        nonMbrPntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BUYADD_TCKT_PRN:
        buyaddTcktPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POINT_UNIT:
        pointUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VOID_CUST:
        voidCust = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_TCKT_PRN_TYP:
        promTcktPrnTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKT_ISSU_AMT:
        tcktIssuAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKT_GOOD_THRU:
        tcktGoodThru = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKT_GOOD_THRU_PRN:
        tcktGoodThruPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BIRTH_BEEP:
        birthBeep = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUST_ADDR_PRN:
        custAddrPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASH_POINT_YPE:
        cashPointYpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASH_ANYPRC_TYP:
        cashAnyprcTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_BONUS_LIMIT1:
        ptBonusLimit1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_ADD_BONUS1:
        ptAddBonus1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_BONUS_LIMIT2:
        ptBonusLimit2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_ADD_BONUS2:
        ptAddBonus2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_BONUS_LIMIT3:
        ptBonusLimit3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_ADD_BONUS3:
        ptAddBonus3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_BONUS_LIMIT4:
        ptBonusLimit4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_ADD_BONUS4:
        ptAddBonus4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BONUS_SELECT:
        bonusSelect = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STLPLUS_POINT_TYP:
        stlplusPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STLPLUS_ANYPRC_TYP:
        stlplusAnyprcTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TTL_POINT_GOOD_THRU:
        ttlPointGoodThru = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUTMDL_POINT:
        outmdlPoint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REBATE_DISC_KEY:
        rebateDiscKey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBR_NAME_DSP:
        mbrNameDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PERSONAL_DATA:
        personalData = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BONUS_PNT_SCH:
        bonusPntSch = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BONUS_PNT_LIMIT:
        bonusPntLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_POINT_MARK:
        nonPointMark = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RCPRATE_SEL:
        rcprateSel = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPOINT_AMT_LIMIT:
        dpointAmtLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ECOA_PNTUSE_SML:
        ecoaPntuseSml = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ECOA_PNTUSE_BIG:
        ecoaPntuseBig = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBR_DETAIL_KEEP_CNT:
        mbrDetailKeepCnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MBR_DETAIL_KEEP_MONS:
        mbrDetailKeepMons = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COUPON_BAR_PRN:
        couponBarPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POS_MEDIA_NO:
        posMediaNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VALID_YEAR:
        validYear = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARD_MNG_FEE:
        cardMngFee = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_PT_CALC_UNIT:
        crdtPtCalcUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRORATE_PNT_PRN:
        proratePntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT1:
        promLimitAmt1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT2:
        promLimitAmt2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT3:
        promLimitAmt3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT4:
        promLimitAmt4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT5:
        promLimitAmt5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARD_TYP1_DSC:
        cardTyp1Dsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARD_TYP2_DSC:
        cardTyp2Dsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARD_TYP3_DSC:
        cardTyp3Dsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT6:
        promLimitAmt6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT7:
        promLimitAmt7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_LIMIT_AMT8:
        promLimitAmt8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CARD_FORGET_SKEY:
        cardForgetSkey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE1:
        promCode1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE2:
        promCode2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE3:
        promCode3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE4:
        promCode4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE5:
        promCode5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE6:
        promCode6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE7:
        promCode7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CODE8:
        promCode8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ADDPNT_SKEY:
        addpntSkey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SRVNO_CHG_DSP:
        srvnoChgDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DM_POST_PRN:
        dmPostPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ABSV31_USER:
        absv31User = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOT_NUM1:
        lotNum1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOT_NUM2:
        lotNum2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUTPNT_PRN_START:
        outpntPrnStart = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUTPNT_PRN_END:
        outpntPrnEnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRIZE_NO_FROM:
        prizeNoFrom = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRIZE_NO_TO:
        prizeNoTo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUTMDL_PNTCAL_TAXNO:
        outmdlPntcalTaxno = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RCDSC_CARD_NO:
        rcdscCardNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAFFDSC_CARD_NO:
        staffdscCardNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PREPAID_CHGPNT_CALUNIT:
        prepaidChgpntCalunit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RALSE_REAL_COMP_CD:
        ralseRealCompCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_BONUS_LIMIT5:
        ptBonusLimit5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_ADD_BONUS5:
        ptAddBonus5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_BONUS_LIMIT6:
        ptBonusLimit6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PT_ADD_BONUS6:
        ptAddBonus6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRN_NEWBLEV_ACH_AMT:
        prnNewblevAchAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP11:
        acntPointTyp11 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP12:
        acntPointTyp12 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP13:
        acntPointTyp13 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP14:
        acntPointTyp14 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP15:
        acntPointTyp15 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP16:
        acntPointTyp16 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP17:
        acntPointTyp17 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP18:
        acntPointTyp18 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP19:
        acntPointTyp19 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP20:
        acntPointTyp20 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP21:
        acntPointTyp21 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP22:
        acntPointTyp22 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP23:
        acntPointTyp23 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP24:
        acntPointTyp24 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP25:
        acntPointTyp25 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP26:
        acntPointTyp26 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP27:
        acntPointTyp27 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP28:
        acntPointTyp28 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP29:
        acntPointTyp29 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_POINT_TYP30:
        acntPointTyp30 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP11:
        acntAnyprcTyp11 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP12:
        acntAnyprcTyp12 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP13:
        acntAnyprcTyp13 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP14:
        acntAnyprcTyp14 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP15:
        acntAnyprcTyp15 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP16:
        acntAnyprcTyp16 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP17:
        acntAnyprcTyp17 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP18:
        acntAnyprcTyp18 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP19:
        acntAnyprcTyp19 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP20:
        acntAnyprcTyp20 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP21:
        acntAnyprcTyp21 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP22:
        acntAnyprcTyp22 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP23:
        acntAnyprcTyp23 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP24:
        acntAnyprcTyp24 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP25:
        acntAnyprcTyp25 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP26:
        acntAnyprcTyp26 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP27:
        acntAnyprcTyp27 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP28:
        acntAnyprcTyp28 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP29:
        acntAnyprcTyp29 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACNT_ANYPRC_TYP30:
        acntAnyprcTyp30 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CONNECT_SBS_CREDIT_3:
        connectSbsCredit1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FLIGHT_SYSTEM_CASH:
        flightSystemCash = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FLIGHT_SYSTEM_CHA1:
        flightSystemCha1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FLIGHT_SYSTEM_CHA2:
        flightSystemCha2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FLIGHT_SYSTEM_CHA3:
        flightSystemCha3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELFGATE_SYSTEM:
        selfgateSystem = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REVENUE_STAMP_PAY_FLG:
        revenueStampPayFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHER_PANA_CARD_FLG:
        otherPanaCardFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_YAO_SP_EVENT_CD:
        yaoSpEventCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_YAO_PREFERENTIAL_DSCPER:
        yaoPreferentialDscper = trmData.toInt();
        break;
      case TrmCdList.TRMNO_YAO_STAFF_DSCPER:
        yaoStaffDscper = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELF_RFM_DISP_FLG:
        selfRfmDispFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ESVOID_BDLSTM_SAVE_USE:
        esvoidBdlstmSaveUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BE_TOTAL_AMT_PRN:
        beTotalAmtPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLAN_NAME_DISP_PRN:
        planNameDispPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ZEN_LOYALTY_PRN_DATE:
        zenLoyaltyPrnDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ZEN_LOYALTY_PRN_LIMIT:
        zenLoyaltyPrnLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STRE_SVS_MTHD_USE:
        streSvsMthdUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RFM_PRN_KIND:
        rfmPrnKind = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VOID_LOG_KEEP:
        voidLogKeep = trmData.toInt();
        break;
      case TrmCdList.TRMNO_YAO_HAKEN_DSCPER:
        yaoHakenDscper = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RESERV_DEL_DATE:
        reservDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HIST_DEL_DATE:
        histDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOG_DEL_DATE:
        logDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TRAN_DEL_DATE:
        tranDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SRVLOG_SAVE_DATE:
        srvlogSaveDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_PRC_FLG:
        bdlPrcFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_LVL_MONTH:
        crmLvlMonth = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_LVL_1_LIMIT:
        crmLvl1Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_LVL_2_LIMIT:
        crmLvl2Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_LVL_3_LIMIT:
        crmLvl3Limit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_HIGH_USE_LOWER_LIMIT:
        crmHighUseLowerLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_LOW_USE_UPPER_LIMIT:
        crmLowUseUpperLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_INTERVAL_WARN_MONTH:
        crmIntervalWarnMonth = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WIZ_CARD_SCAN_FLG:
        wizCardScanFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BE_TOTAL_PNT_DISP:
        beTotalPntDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CPN_BMP_DELETE_MONTH:
        cpmBmpDeleteMonth = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_PORTAL_CONF_PRN:
        crmPortalConfPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SAME_DATE_OPEN:
        sameDateOpen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_PASSWORD_CLK_OPEN:
        chkPasswordClkOpen = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRM_DELIVERY_MONTH:
        crmDeliveryMonth = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_RATE_PRN:
        taxRatePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DRAWCHK_CLOSE_SELECT:
        drawchkCloseSelect = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STRCLS_VUP:
        strclsVup = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PNT_USE_LIMIT:
        pntUseLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COIN_UNIT_SHT:
        coinUnitSht = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VUPFILE_GET_FLG:
        vupfileGetFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUST_CURL_TIMEOUT:
        custCurlTimeout = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ACX_ERR_GUI_FLG:
        acxErrGuiFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_MENTE_DISP_KEY_AUTH:
        qcMenteDispKeyAuth = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STL_SCN_DISABLE:
        stlScnDisable = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_UPDATE:
        autoUpdate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCH_BTN_BEEP:
        tchBtnBeep = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SALE_LIMIT_TIME:
        saleLimitTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXFREE_AMT_CSM:
        taxfreeAmtCsm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXFREE_AMT_GNRL:
        taxfreeAmtGnrl = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXFREE_TAX_NUM:
        taxfreeTaxNum = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXFREE_RECEIPTCNT:
        taxfreeReceiptCnt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NEAREND_NOTE:
        nearendNote = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_FORCE_CLS_MAKE_TRN:
        autoForceClsMakeTrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLSTIME_USING:
        clstimeUsing = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOTRI_BDL_SUMPRN:
        notriBdlSumprn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NONREG_POPUP_DISP:
        nonregPopupDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPECIAL_MULTI_OPE:
        specialMultiOpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRN_OUT_CLS_QTY:
        prnOutClsQty = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HISTLOG_CHKR_ALERT:
        histlogChkrAlert = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDL_LOW_LIMIT_CHK:
        bdlLowLimitChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCH_KEEP_PERIOD:
        schKeepPeriod = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RDLY_KEEP_PERIOD:
        rdlyKeepPeriod = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RDLY_CLEAR_DAY:
        rdlyClearDay = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MEMOBTN_NON_DISP:
        memobtnDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EJ_TXT_DEL_DATE:
        ejTxtDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CSV_TXT_DEL_DATE:
        csvTxtDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CUSTBKUP_DEL_DATE:
        custbkupDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NONUSACT_DEL_DATE:
        nonusactDelDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTOCHKROFF_TIME:
        autochkroffTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTOMSGSTART_TIME:
        automsgstartTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTO_PW_DOWN:
        autoPwDown = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_LOW_PRICE:
        useLowPrice = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROD_START_CD:
        prodStartCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROD_END_CD:
        prodEndCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEM_START_CD:
        itemStartCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEM_END_CD:
        itemEndCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRESET_SMALL:
        presetSmall = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KITCHEN_NON_SUMMARY:
        kitchenNonSummary = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KITCHEN_PRT_RPR:
        kitchenPrtRpr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_STLDSC_DETAIL:
        printStldscDetail = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SELECT_ITEM_SUM_TOTAL_QTY:
        selectItemSumTotalQty = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SPTEND_SELECT_VOID_CHANGE:
        sptendSelectVoidChange = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CORRECTED_ITEM_CHANGE_NAME_COLLOR:
        correctedItemChangeNameCollor = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAB_DISPLAY:
        tabDisplay = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FRONT_SELF_DISPLAY:
        frontSelfDisplay = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FRONT_SELF_RECEIPT:
        frontSelfReceipt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRF_AMT:
        prfAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHK_RESULT:
        chkResult = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EASY_UI_MODE:
        easyUiMode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXT_PAYMENT_STLDSP:
        extPaymentStldsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXT_INITIAL_DISP_SIDE:
        extInitialDispSide = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VERIFONE_PRINT_NUM:
        verifonePrintNum = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_WMTICKET:
        printWmticket = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_ADD_POINT_ITEMNAME:
        dispAddPointItemname = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WIZ_PWR_STS_BASE:
        wizPwrStsBase = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXT_NOTUSE_DISP:
        extNotuseDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COLORFIP15_DISPLAY:
        colorfip15Display = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COLORFIP15_UNIT_DESIGN:
        colorfip15UnitDesign = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COLORFIP15_STL_DSC_DSP:
        colorfip15StlDscDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COLORFIP15_STL_QTY_DSP:
        colorfip15StlQtyDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COLORFIP15_DSC_DETAIL_DSP:
        colorfip15DscDetailDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COLORFIP15_MBR_DSP:
        colorfip15MbrDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_POPUP_SOUND:
        popupSound = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SALESREPO_JMUPS:
        salesrepoJmups = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAFFLIST_DISP:
        stafflistDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STAFFNAME_FLG:
        staffnameFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_QC_SLCT_DISP_OTHER_PAY:
        qcSlctDispOtherPay = trmData.toInt();
        break;
      case TrmCdList.TRMNO_AUTOCHKROFF_AFTERSENDUPDATE_TIME:
        autochkroffAftersendupdateTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CERTIFICATE_NOTE_PRN:
        certificateNotePrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CERTIFICATE_CNT_PRN:
        certificateCntPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRCCHK_CERTIFICATE_BTN:
        prcchkCertificateBtn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOTE_PLU_REG:
        notePluReg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_KY_CHA_DIVIDE_KOPT_CRDT:
        kyChaDivideKoptCrdt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_COMPLAINT_MESSAGE_DISP:
        complaintMessageDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TCKTISSU_POINT_1_100TIMES:
        tcktissuPoint1_100times = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SVS_TCKT_PLU_CD_9DIGIT:
        svsTcktPluCd9digit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DS2_GODAI_ITMIFO_PRN:
        ds2GodaiItmifoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NOTE_PLU_PRINT_TYP:
        notePluPrintTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_RATE_PRN_DEAL:
        taxRatePrnDeal = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_RATE_PRN_CLS:
        taxRatePrnCls = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RCPTVOID_BDLSTM_SAVE_USE:
        rcptvoidBdlstmSaveUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHECK_MBRCARDMST_USE:
        checkMbrcardmstUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JMUPS_WAIT_TIME:
        jmupsWaitTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DS2_PRERANK_REFER_TERM:
        ds2PrerankReferTerm = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DISP_MAINMENU_BTN:
        dispMainmenuBtn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REBATE_POINTS_PRN:
        rebatePointsPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CCT_STLAMT_ONLY:
        cctStlamtOnly = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CCT_ONCE_ONLY:
        cctOnceOnly = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DELETE_POINTS_PRN:
        deletePointsPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_SAME_PNT_CPN:
        useSamePntCpn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_SAME_STLDSC_CPN:
        useSameStldscCpn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RECEIPT_SPLIT_CHANGE_SIZE:
        receiptSplitChangeSize = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VOID_DATE_INPUT:
        voidDateInput = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHLESS_RESTORE_RATE:
        cashlessRestoreRate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CASHLESS_RESTORE_LIMIT:
        cashlessRestoreLimit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_REAL_ITEM_TAX_SET:
        realItemTaxSet = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RFM_TAX_INFO:
        rfmTaxInfo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOY_LIMIT_OVER_ALERT:
        loyLimitOverAlert = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHANGE_MESSAGE_BUTTON:
        changeMessageButton = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_MDLCLS_TAX_AMT:
        outMdlclsTaxAmt = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_MDLCLS_OUTTAX_NO:
        outMdlclsOuttaxNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OUT_MDLCLS_INTAX_NO:
        outMdlclsIntaxNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOY_AMT_TAX:
        loyAmtTax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLU_DIGIT:
        pluDigit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PASTCOMPFILE_KEEP_DATE:
        pastcompfileKeepDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SYST_RESTART:
        systRestart = trmData.toInt();
        break;
      case TrmCdList.TRMNO_NON_MBR_RCT_CCTPNT_CHG:
        nonMbrRctCctpntChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ECS_OVERFLOW_SPACE:
        ecsOverflowSpace = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ECS_OVERFLOWPICK_CONF:
        ecsOverflowpickConf = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_DUALMEMBER:
        dpntDualmember = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_CLC_UNIT:
        dpntClcUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_UNIT:
        dpntUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_CLC_RND:
        dpntClcRnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_TAX:
        dpntTax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_STAMP:
        dpntStamp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_USE:
        dpntUse = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_USE_UNIT:
        dpntUseUnit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_LLMT_MNY:
        dpntLlmtMny = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_MAGN:
        dpntMagn = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_DPNT_LLIMT1:
        dpntLlimt1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_MAGN1:
        dpntMagn1 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_DPNT_LLIMT2:
        dpntLlimt2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_MAGN2:
        dpntMagn2 = trmData.toDouble();
        break;
      case TrmCdList.TRMNO_DPNT_DUALMAGN:
        dpntDualmagn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_PLUPOINT:
        dpntPlupoint = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_CASH_POINT_YPE:
        dpntCashPointYpe = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP1:
        dpntAcntPointTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP2:
        dpntAcntPointTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP3:
        dpntAcntPointTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP4:
        dpntAcntPointTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP5:
        dpntAcntPointTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP6:
        dpntAcntPointTyp6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP7:
        dpntAcntPointTyp7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP8:
        dpntAcntPointTyp8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP9:
        dpntAcntPointTyp9 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP10:
        dpntAcntPointTyp10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP11:
        dpntAcntPointTyp11 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP12:
        dpntAcntPointTyp12 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP13:
        dpntAcntPointTyp13 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP14:
        dpntAcntPointTyp14 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP15:
        dpntAcntPointTyp15 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP16:
        dpntAcntPointTyp16 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP17:
        dpntAcntPointTyp17 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP18:
        dpntAcntPointTyp18 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP19:
        dpntAcntPointTyp19 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP20:
        dpntAcntPointTyp20 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP21:
        dpntAcntPointTyp21 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP22:
        dpntAcntPointTyp22 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP23:
        dpntAcntPointTyp23 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP24:
        dpntAcntPointTyp24 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP25:
        dpntAcntPointTyp25 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP26:
        dpntAcntPointTyp26 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP27:
        dpntAcntPointTyp27 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP28:
        dpntAcntPointTyp28 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP29:
        dpntAcntPointTyp29 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_ACNT_POINT_TYP30:
        dpntAcntPointTyp30 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_TICKET_POINT_TYP1:
        dpntTicketPointTyp1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_TICKET_POINT_TYP2:
        dpntTicketPointTyp2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_TICKET_POINT_TYP3:
        dpntTicketPointTyp3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_TICKET_POINT_TYP4:
        dpntTicketPointTyp4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_TICKET_POINT_TYP5:
        dpntTicketPointTyp5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_SALE_PLU_POINT_TYP:
        dpntSalePluPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_SUBT_DCNT_POINT_TYP:
        dpntSubtDcntPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_SBS_RBT_POINT_TYP:
        dpntSbsRbtPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_STLPLUS_POINT_TYP:
        dpntStlplusPointTyp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TS_LGYOUMU_SEND:
        tsLgyoumuSend = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLS_TRANOUT_TIMEOUT:
        clsTranoutTimeout = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLS_TERMINAL_REPORT:
        clsTerminalReport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXFREE_AMT_CSM_MAX:
        taxfreeAmtCsmMax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BARCODEPAY_RFDOPRERR_TO_CASH:
        barcodepayRfdoprerrToCash = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BARCODEPAY_REPORT_DIVIDE:
        barcodepayReportDivide = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PRINT_CLOSE_RECEIPT_FLG:
        printCloseReceiptFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ALL_REQUEST_DATE:
        allRequestDate = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SAG_SBS_MTHD:
        sagSbsMthd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CUST_KIND:
        promCustKind = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STR_CLOSE_DAY:
        strCloseDay = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXFREE_RECEIPT_SAVE:
        taxfreeReceiptSave = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SERVER_EXC:
        serverExc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LESS_20G_WARN_ENTER_AMOUNT:
        less20gWarnEnterAmount = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MM_SM_TAXFREE_PRICE:
        mmSmTaxfreePrice = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_GROUP_ID:
        rpntGroupId = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_INVEST_REASON_ID:
        rpntInvestReasonId = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_BONUS_REASON_ID:
        rpntBonusReasonId = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_USE_REASON_ID:
        rpntUseReasonId = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_SERVICE_ID1:
        rpntServiceId1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_SERVICE_ID2:
        rpntServiceId2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EASY_RPR_DISP:
        easyRprDisp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML1:
        detailNoprnSml1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML2:
        detailNoprnSml2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML3:
        detailNoprnSml3 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML4:
        detailNoprnSml4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML5:
        detailNoprnSml5 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML6:
        detailNoprnSml6 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML7:
        detailNoprnSml7 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML8:
        detailNoprnSml8 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML9:
        detailNoprnSml9 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML10:
        detailNoprnSml10 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML11:
        detailNoprnSml11 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DETAIL_NOPRN_SML12:
        detailNoprnSml12 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WEB3800J_FSELF_CHG:
        web3800jFselfChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DEAL_REPORT_EXCE_OR_DEFI_PRN:
        dealReportExceOrDefiPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_DUAL_FLG:
        rpntDualFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_RPNT_USE_KEY:
        rpntUseKey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LOY_HIGH_MAGN_PRIORITY:
        loyHighMagnPriority = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCRAP_MODE_PLU_SCH:
        scrapModePluSch = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TS_G3_PRESET:
        tsG3Preset = trmData.toInt();
        break;
      case TrmCdList.TRMNO_LIQR_STAFF_CHK:
        liqrStaffChk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAX_SET_ORDER:
        taxSetOrder = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MM_SM_LIQRAMT_DSC:
        mmSmLiqramtDsc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PROM_CPN_PRN_ORDR:
        promCpnPrnOrdr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CRDT_INFO_ORDER:
        crdtInfoOrder = trmData.toInt();
        break;
      case TrmCdList.TRMNO_IH_MBR_SELF_FLG:
        ihMbrSelfFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPNT_SELF_FLG:
        tpntSelfFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPNT_ALLIANCE_CD:
        tpntAllianceCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPNT_BIZ_CD:
        tpntBizCd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPNT_USE_KEY:
        tpntUseKey = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EASY_PRC_DISP_BEEP:
        easyPrcDispBeep = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DPNT_AMTCLC_RND:
        dpntAmtclcRnd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCALERM_FROATING_MAC_NO:
        scalermFroatingMacNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_PLU_SELECT_JUMP_PRESET:
        pluSelectJumpPreset = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JUMP_PRESET_GRP:
        jumpPresetGrp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_JUMP_PRESET_PAGE:
        jumpPresetPage = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCALERM_FROATING_CHK_TIME:
        scalermFroatingChkTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCALERM_FROATING_ITEM_MAX:
        scalermFroatingItemMax = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCALERM_STL_20G_OVER_REGS:
        scalermStl20gOverRegs = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ITEM_DISP_JANCD:
        itemDispJancd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_MULTI_BTN:
        multiBtn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STRCLS_REPORT:
        strclsReport = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAKARA_RCPT_LAYOUT_CHG:
        takaraRcptLayoutChg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HI_TOUCH_MAC_NO:
        hiTouchMacNo = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HI_TOUCH_PLU_DISP_TIME:
        hiTouchPluDispTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_HI_TOUCH_RCV_CHK_TIME:
        hiTouchRcvChkTime = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WSCPN_LIMIT_PRICE:
        wsCouponLimitPrice = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WSCPN_LIMIT_DISC:
        wsCouponLimitDisc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WSCPN_LIMIT_POINT_ADD:
        wsCouponLimitPointAdd = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WSCPN_LIMIT_POINT_MAG:
        wsCouponLimitPointMag = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPNT_SELF_CPN_DSP:
        tpntSelfCpnDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TPNT_EJ_ID_MSK:
        tpntEjIdMsk = trmData.toInt();
        break;
      case TrmCdList.TRMNO_OTHER_COMPANY_QR:
        otherCompanyQr = trmData.toInt();
        break;
      case TrmCdList.TRMNO_BDLPLU_CLSDSC_FLG:
        bdlpluClsdscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CLSREG_CLSDSC_FLG:
        clsregClsdscFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_DSCPLU_BDL_FLG:
        dscpluBdlFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_CHGPRCPLU_BDL_FLG:
        chgprcpluBdlFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_SCREG_CONTTRADE_FLG:
        scregConttradeFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WSCPN_REF_FLG:
        wsCouponRefFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FRONT_SELF_MBRSCAN_FLG:
        frontSelfMbrscanFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_UNITECPN_STAFF_CALL_FLG:
        uniteCouponStaffCallFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_UNITECPN_DSP_FLG:
        uniteCouponDspFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_VENDING_MACHINE:
        vendingMachine = trmData.toInt();
        break;
      case TrmCdList.TRMNO_TAXCHG_WGTBERCODE:
        taxchgWgtbercode = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USE_RECEIPT_REFUND:
        useReceiptRefund = trmData.toInt();
        break;
      case TrmCdList.TRMNO_STL_TAXINFO_PRN:
        stlTaxinfoPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSELF_CASH_SPLIT:
        fselfCashSplit = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSELF_NOTAX_PRN:
        notaxPrn = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSELF_BARCODE_PAY_CONF_DSP:
        barcodePayConfDsp = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSELF_CSS_USER_PROC:
        cssUserProc = trmData.toInt();
        break;
      case TrmCdList.TRMNO_FSELF_NW7_STAFF_FLG:
        nw7StaffFlg = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USER_CD1:
        userCd1 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USER_CD2:
        userCd2 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USER_CD4:
        userCd4 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USER_CD31:
        userCd31 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USER_CD38:
        userCd38 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_fil92:
        fil92 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_USER_CD36:
        userCd36 = trmData.toInt();
        break;
      case TrmCdList.TRMNO_EXT_MBR_SVR_COM:
        extMbrSvrCom = trmData.toInt();
        break;
      case TrmCdList.TRMNO_WEB_AND_RM_NETWORK:
        webAndRmNetwork = trmData.toInt();
        break;
      case TrmCdList.TRMNO_ARCS_COMP_FLG:
        arcsCompFlg = trmData.toInt();
        break;
      default:
        break;
    }
  }
}

/// 関連tprxソース: trm_list.h - TRM_CD_LIST
enum TrmCdList {
  TRMNO_WRNG_NONE(-1), // 無効値.
  TRMNO_WRNG_MVOID_FLG(29),
  TRMNO_WRNG_MTRINING_FLG(30),
  TRMNO_WRNG_MSCRAP_FLG(31),
  TRMNO_DRW_OPEN_FLG(32),
  TRMNO_URGENCY_MNT_FLG(33),
  TRMNO_NEAREND_DSP(34),
  TRMNO_PRESET_REG_FLG(35),
  TRMNO_PWCNTRL_FLG(36),
  TRMNO_PWCNTRL_TIME(37),
  TRMNO_FDD_MANAGE_FLG(38),
  TRMNO_RCPT_BAR_PRN(39),
  TRMNO_MAC_OFF_FLG(41),
  TRMNO_CLOSE_PICK_FLG(42),
  TRMNO_CLOSE_REPORT_FLG(43),
  TRMNO_FRC_CLK_FLG(44),
  TRMNO_CLK_EVERY_CLOSE_FLG(45),
  TRMNO_RCV_GCAT_DATA_FLG(46),
  TRMNO_CSHR_NAME_PRN(47),
  TRMNO_RECIEPTNO_PRN(48),
  TRMNO_JOURNALNO_PRN(49),
  TRMNO_DATE_PRN(50),
  TRMNO_RCT_PRCCHG_FLG(51),
  TRMNO_PLUNO_PRN(52),
  TRMNO_FREE_ITEM_PRN(53),
  TRMNO_TAX_MARK_PRN(54),
  TRMNO_INTAX_MARK_PRN(55),
  TRMNO_NOTAX_MARK_PRN(56),
  TRMNO_PROM_MARK_PRN(58),
  TRMNO_BDL_DSC_PRN(59),
  TRMNO_QTY_PRN(61),
  TRMNO_DEBIT_PRN(62),
  TRMNO_CLSNO_PRN(63),
  TRMNO_BLN_AMT_PRN(64),
  TRMNO_CNCL_RCT_PRN(65),
  TRMNO_DSCPLU_STLDSC_FLG(66),
  TRMNO_TPUPRC_STLDSC_FLG(67),
  TRMNO_MTCPLU_STLDSC_FLG(68),
  TRMNO_GRPPRC_STLDSC_FLG(69),
  TRMNO_RND_DSCNT_FLG(70),
  TRMNO_U_PRCCHG_DSC_FLG(71),
  TRMNO_GRPPRC_DSC_FLG(72),
  TRMNO_DSCPLU_CLSDSC_FLG(73),
  TRMNO_OTHUPRC_CLSDSC_FLG(74),
  TRMNO_DSC_SHARE_FLG(75),
  TRMNO_WGTBAR_CALC_FLG(76),
  TRMNO_BDL_AVEPRISPLIT_FLG(77),
  TRMNO_STM_AVEPRISPLIT_FLG(78),
  TRMNO_PRIPLU_CLSDSC_FLG(79),
  TRMNO_BRGN_PRC_FLG(80),
  TRMNO_REPEAT_DSC_FLG(81),
  TRMNO_ACX_N_5000(82),
  TRMNO_ACX_N_2000(83),
  TRMNO_ACX_N_1000(84),
  TRMNO_ACX_N_500(85),
  TRMNO_ACX_N_100(86),
  TRMNO_ACX_N_50(87),
  TRMNO_ACX_N_10(88),
  TRMNO_ACX_N_5(89),
  TRMNO_ACX_N_1(90),
  TRMNO_ACX_S_5000(91),
  TRMNO_ACX_S_2000(92),
  TRMNO_ACX_S_1000(93),
  TRMNO_ACX_S_500(94),
  TRMNO_ACX_S_100(95),
  TRMNO_ACX_S_50(96),
  TRMNO_ACX_S_10(97),
  TRMNO_ACX_S_5(98),
  TRMNO_ACX_S_1(99),
  TRMNO_BOTH_ACR_CLR_FLG(100),
  TRMNO_ACX_M_5000(101),
  TRMNO_ACX_M_2000(102),
  TRMNO_ACX_M_1000(103),
  TRMNO_ACX_M_500(104),
  TRMNO_ACX_M_100(105),
  TRMNO_ACX_M_50(106),
  TRMNO_ACX_M_10(107),
  TRMNO_ACX_M_5(108),
  TRMNO_ACX_M_1(109),
  TRMNO_BKUP_RCPT_ADD(110),
  TRMNO_NOT_CLSDSC(111),
  TRMNO_MYSELF_EVOID(112),
  TRMNO_FANFARE_NO_EFECT(113),
  TRMNO_FANFARE_EFECT(114),
  TRMNO_SALEDATE_PLUS(115),
  TRMNO_CRDT_PRN_SHARE(116),
  TRMNO_TRAINING_TIME_PRN(117),
  TRMNO_SVSTCKT_TTLPNT_PRN(118),
  TRMNO_NOT_SET_PRESET_MSG(119),
  TRMNO_RW_CMD_CHG(120),
  TRMNO_VMC_NOT_STLDSC(122),
  TRMNO_DECIMAL_ROUND(123),
  TRMNO_DECIMAL_ROUND_OFF(124),
  TRMNO_RW_COMP_NO_CHK(125),
  TRMNO_LOW_PRICE_1(126),
  TRMNO_TAX_IMG_CHG(127),
  TRMNO_SELF_CASE_SLCT(128),
  TRMNO_KICHEN_NO_PRN(129),
  TRMNO_AUTO_INPUT_CUST(130),
  TRMNO_RW_HESO_CHG_PNT(131),
  TRMNO_VMC_NOT_DRWCASH(132),
  TRMNO_CUST_PNT_NOT_SET(133),
  TRMNO_SELF_WGTCHK_ONEITEM(135),
  TRMNO_PNTADD_ZERO_INPUT(136),
  TRMNO_TCKT_TTLPNT_PRN(137),
  TRMNO_ALL_ADDPNT_FLG(138),
  TRMNO_CUST_PRICE_KEYONLY(139),
  TRMNO_ACCTRCPT_ADDR_PRN(140),
  TRMNO_NEAREND_CHK_CNCL(141),
  TRMNO_TTLAMT_SIMPLE_DISP(142),
  TRMNO_VMC_DRWAMT_MINUS(143),
  TRMNO_SELF_RIGHT_FLOW(144),
  TRMNO_AUTO_BACTH_REST(145),
  TRMNO_CHILD_ROCK_200(147),
  TRMNO_SELF_ENDBTN_CHG(148),
  TRMNO_SELF_RCPT_CALL_CHECKER(149),
  TRMNO_SELF_CARDREADER_DISP(150),
  TRMNO_SELF_CASHCNCL_CALL(151),
  TRMNO_SELF_MSGSEND_OUTSCALE(152),
  TRMNO_RW_POSSIBLE_ESVOID(153),
  TRMNO_MULTI_PROM(154),
  TRMNO_ACCRUED_DISP(155),
  TRMNO_ACCTRCPT_EXCEPT_CHA1(156),
  TRMNO_SVSTCKT_ONE_SHEET(157),
  TRMNO_TCKTKEY_BEFORE_CUST(158),
  TRMNO_BIG_PNT_PRN(159),
  TRMNO_JPN_DATE_PRN(160),
  TRMNO_CLSPRN_NOT_MARK(161),
  TRMNO_PNT_HIGH_LIMIT(162),
  TRMNO_CUSTPRC_KEY_CHG(163),
  TRMNO_ITEMVOID_DISP(164),
  TRMNO_RISEPRC_BLOCK(165),
  TRMNO_PRIORITY_STLDSC(166),
  TRMNO_ITEMVOID_PROC(167),
  TRMNO_CARDSHEET_PRN(168),
  TRMNO_VMC_FSPSTLPDSC(169),
  TRMNO_SELF_INSCALE_ERR(170),
  TRMNO_VMC_CHG_HESO_PNT(171),
  TRMNO_RW_RE_READCHECK(172),
  TRMNO_SELF_ADDITEM_BLOCK(173),
  TRMNO_SELF_ENDBTN_WGTCHK(174),
  TRMNO_SELF_CONT_PRESETDISP(175),
  TRMNO_PROM_NAME_PRN(176),
  TRMNO_VMC_RPR_TCKT_BLOCK(177),
  TRMNO_VMC_OUT_RANK_PNT(178),
  TRMNO_PROM_MSG_FEW(179),
  TRMNO_NOT_SET_PRESET_ENT(180),
  TRMNO_DSC_BARCODE_AMT(181),
  TRMNO_RFM_ONLY_ISSUE(182),
  TRMNO_RFM_USE_STAMP_AREA(183),
  TRMNO_NOT_UPD_CUST_0SALES(184),
  TRMNO_USE_LOW_PRICE_1(187),
  TRMNO_PRCCHK_ONLY_1TIME(188),
  TRMNO_KEEP_INT_2PERSON(189),
  TRMNO_VMC_TPR9000_COMB(190),
  TRMNO_DISP_MBRCARD_EXIST(191),
  TRMNO_NOT_DSP_LCD_BRGNITEM(192),
  TRMNO_CHG_CULC_MUL_DISCITEM(193),
  TRMNO_NOT_PRN_PRCCHG_DISCWD(194),
  TRMNO_PRN_REPT_REFINFO_SML(195),
  TRMNO_ENABLE_SPLPRC_NPNPLU(197),
  TRMNO_PRN_2RCPT_EATIN(198),
  TRMNO_SAME_ITEM_1PRC_TRAN(199),
  TRMNO_FSP_STLDSC_TRG_SUB_INTAX(200),
  TRMNO_CHG_CULC_ITEMCAT_DISC(202),
  TRMNO_VD_ENABLE_BATVOID_ONLY(203),
  TRMNO_ENABLE_STLDSC_SCAN_CLKCODE(205),
  TRMNO_BDL_SM_USE_EARLYEND_SCH(206),
  TRMNO_GP_LIMIT_OFF_NAME(207),
  TRMNO_USE_COLOR_OPEMSG(208),
  TRMNO_RW_DISABLE_USE_PANA_POINT_MOVE(209),
  TRMNO_ENABLE_CLS_DISCSCH_UNTIL_2359(210),
  TRMNO_TRG_PRC0_USE_ALLPOINT(211),
  TRMNO_JACKLE_DISP_MBRNUM_16D(212),
  TRMNO_NOT_USE_POINTUNIT_IN_SALEADD(214),
  TRMNO_ACR_SUBSTITUTE_RECOVER(215),
  TRMNO_DISP_MBRNUM_8D_IN_MBRNUM_NOT_PRN(216),
  TRMNO_SELF_SALEPRC_INCL_TAX(218),
  TRMNO_PRN_QRCODE_RECEIPT(219),
  TRMNO_CHG_ERRMSG_IN_BLUETIP(220),
  TRMNO_DISP_BDL_PRC_ITEMSCREEN(221),
  TRMNO_NON_PRN_STAMPAREA_MINUSSALE(222),
  TRMNO_AUTO_POINT_WORK_CT3100(223),
  TRMNO_DISABLE_ENT_OPE_SIMPLE_OPENCLOSE(224),
  TRMNO_DISABLE_RECOVER_FEE_SVSCLS1(225),
  TRMNO_CULC_CREDIT_1_100TIMES(226),
  TRMNO_ISSUE_NOTE_PRN(227),
  TRMNO_CATDNO_START_NO(228),
  TRMNO_MGN_TYP(229),
  TRMNO_RWT_PRN_MBRFILE(230),
  TRMNO_MUL_SML_DSC_USETYP(231),
  TRMNO_REFUND_STLDSC(232),
  TRMNO_ORG_ID_PRN(233),
  TRMNO_TRAN_ID(234),
  TRMNO_ITEM_CODE(235),
  TRMNO_GOOD_THRU_DSP(236),
  TRMNO_OPE_TYPE(237),
  TRMNO_CRDT_TIME_OUT(238),
  TRMNO_SELFGATE_WGTALW_LIMIT(239),
  TRMNO_INTAX_PRN(240),
  TRMNO_IN_TAX_PRN(241),
  TRMNO_CATDNO_DIGIT(242),
  TRMNO_SCALE_WGT(243),
  TRMNO_WARRANTY_NOTE_PRN(244),
  TRMNO_CATALINE_KEY_CD(245),
  TRMNO_OFF_BTN_FLG(246),
  TRMNO_CUST_SALE_PRN_TYP(247),
  TRMNO_RET_PRESET_1PAGE(248),
  TRMNO_STRE_OPEN_REPORT(249),
  TRMNO_MANUAL_RFM_TAX_CD(251),
  TRMNO_RECEIPT_GP1_LIMIT(252),
  TRMNO_RECEIPT_GP2_LIMIT(253),
  TRMNO_RECEIPT_GP3_LIMIT(254),
  TRMNO_RECEIPT_GP4_LIMIT(255),
  TRMNO_RECEIPT_GP5_LIMIT(256),
  TRMNO_RECEIPT_GP6_LIMIT(257),
  TRMNO_RECEIPT_GP1_TAX(258),
  TRMNO_RECEIPT_GP2_TAX(259),
  TRMNO_RECEIPT_GP3_TAX(260),
  TRMNO_RECEIPT_GP4_TAX(261),
  TRMNO_RECEIPT_GP5_TAX(262),
  TRMNO_RECEIPT_GP6_TAX(263),
  TRMNO_TAX_CALC(264),
  TRMNO_WARN_MSCRAP_FLG(265),
  TRMNO_DRAW_CASH_CHK(266),
  TRMNO_WARRANTY_CNT_PRN(267),
  TRMNO_PCTR_TCKT2_PRC_PRN(268),
  TRMNO_PCTR_TCKT3_PRC_PRN(269),
  TRMNO_PCTR_TCKT_MSG1(270),
  TRMNO_PCTR_TCKT_MSG2(271),
  TRMNO_TAG_JAN_PRN(272),
  TRMNO_TAG_AMT_IMG_PRN(273),
  TRMNO_TAG_CUST_AMT_PRN(274),
  TRMNO_TAG_BRGNPRC_IMG_PRN(275),
  TRMNO_TAG_CLSCD_PRN(276),
  TRMNO_TAG_TAXAMT_IMG_PRN(277),
  TRMNO_TAG_TAXAMT_PRN(278),
  TRMNO_TAG_FRAME_PRN(279),
  TRMNO_TAG_EXTAX_PRN(280),
  TRMNO_MOBILEPOS_TYP(282),
  TRMNO_OFFMODE_PASSWD_TYP(283),
  TRMNO_EXTRA_AMT_FLG(284),
  TRMNO_ACS_N_DISP(285),
  TRMNO_EX_ITEM_TTLAMT_FLG(286),
  TRMNO_EX_BRGN_TTLAMT_FLG(287),
  TRMNO_EX_MMSTM_TTLAMT_FLG(288),
  TRMNO_TAX_DIVIDE_FLG(289),
  TRMNO_POPPY_TTLAMT_ROUND(290),
  TRMNO_SELF_REGFLOW(291),
  TRMNO_SELF_WGTCHK_START(292),
  TRMNO_SELF_ADD_ITEM(293),
  TRMNO_SELF_WGTCHK_END(294),
  TRMNO_SELF_PRESET_END_DISP(295),
  TRMNO_ACX_M_10000(296),
  TRMNO_PCTR_TCKT_STORE(297),
  TRMNO_PROMISSUE_LOWLIMIT(298),
  TRMNO_PROMISSUE_NO(299),
  TRMNO_PROD_NAME_PRN_TYP(300),
  TRMNO_OFFMODE_PASSWD(301),
  TRMNO_CONT_QTY_PRN(302),
  TRMNO_SELF_NOCUST_USE_FLG(303),
  TRMNO_SELF_CUSTCARD_DISP(304),
  TRMNO_SELF_CUSTCARD_TYP(305),
  TRMNO_TRANING_DRAW_ACX_FLG(306),
  TRMNO_MAGAZINE_SCAN_TYP(308),
  TRMNO_CULAY_ADD_FLG(309),
  TRMNO_NONPLU_AMT_HIGH_LIMIT(310),
  TRMNO_CHG_AMT_10000_FLG(311),
  TRMNO_STRE_CLS_BATREPORT(312),
  TRMNO_PRCCHG_DSC_FLG(313),
  TRMNO_PRCCHK_COST_DISP(314),
  TRMNO_SELF_SLCT_KEY_CD(315),
  TRMNO_POPPY_MAKER_SLCT(316),
  TRMNO_POPPY_CONT_QTY_SLCT(317),
  TRMNO_SELF_CRDT_KEY_CD(318),
  TRMNO_REPORT_BKUP_FORMAT(319),
  TRMNO_MOBILEPOS_INFO_PRN(320),
  TRMNO_SELF_STAMP_KEY_CD(321),
  TRMNO_OUT_SMLCLS_NUM1(322),
  TRMNO_OUT_SMLCLS_NUM2(323),
  TRMNO_OUT_SMLCLS_NUM3(324),
  TRMNO_OUT_SMLCLS_NUM4(325),
  TRMNO_OUT_SMLCLS_NUM5(326),
  TRMNO_SELF_EDY_KEY_CD(327),
  TRMNO_INTAX_COSTPER_CALC(328),
  TRMNO_PSP_MINUS_AMT(329),
  TRMNO_PLU_INIT_SMLCLS_CD(330),
  TRMNO_TCKT_PRN_TARGET(331),
  TRMNO_DISH_QTY_MAX(332),
  TRMNO_CATALINACPN_KEY_CD(333),
  TRMNO_RBTL_ADD_SALE_AMT(334),
  TRMNO_RBTL_MIX_REFMIX(335),
  TRMNO_PRC_VOICE(337),
  TRMNO_ZERO_AMT_PAY_FLG(338),
  TRMNO_REFMIX_FLG(339),
  TRMNO_SIMPLE_RECEIPT_PRCCHK(340),
  TRMNO_DISABLE_PRN_INTAX_PRC_RFM(341),
  TRMNO_PRINT_MARK_CONTROL(342),
  TRMNO_RECEIPT_PRN_IN_RFM_NOTE_PRN(343),
  TRMNO_RALSE_MAG_FMT(344),
  TRMNO_RALSE_DISC_2BARCODE(345),
  TRMNO_ENABLE_BDL_ITEM_REF(346),
  TRMNO_CONTINUE_REF_OPE(347),
  TRMNO_BDL_PRN_NONSUMMARY(348),
  TRMNO_CHG_WORD_COLOR_MBRPRC(350),
  TRMNO_REF_BDL_ITEM_CULC_DISC_OPE(351),
  TRMNO_USE_LOW_PRICE_3(352),
  TRMNO_ENABLE_ACTSALE_TERM_PRCCHG(353),
  TRMNO_BDL_SM_SCHEDULE_METHOD_2(354),
  TRMNO_NON_CHANGE_OVER_AMT(355),
  TRMNO_DISP_REF_OPE_WORD(356),
  TRMNO_CHAR_SEARCH_RECORD_CONF(358),
  TRMNO_STL_AUTODISC_1_10TIMES(359),
  TRMNO_DISABLE_CASHKEY_1PERSON(360),
  TRMNO_DISABLE_RFM_NOTE_CUT(361),
  TRMNO_DISABLE_STAMP_CHA9KEY(362),
  TRMNO_DISABLE_PRN_CLERK_DISC(363),
  TRMNO_CHG_DISC_BARCODE_FLAG(364),
  TRMNO_REPEAT_PLUKEY_OPE(365),
  TRMNO_FSP_LEVEL_BONUS_POINT(366),
  TRMNO_NW7MBR_BARCODE_1(367),
  TRMNO_NW7MBR_REAL(368),
  TRMNO_PRN_SALE_TICKET(369),
  TRMNO_PRINT_MARK_CONTROL_TYP_NOTSTLDSC(370),
  TRMNO_SELF_RW_POSI_LEFT(371),
  TRMNO_KASUMI_DISC_BARCODE(373),
  TRMNO_KYUMATSU_RW_PROC(374),
  TRMNO_SEIKATSUCLUB_OPE(376),
  TRMNO_PRINT_SHOPNAME_CREDIT_MULTI_RECEIPT(377),
  TRMNO_PRINT_MBR_POINT_P(378),
  TRMNO_OPEN_OPE_DATECHG_15(379),
  TRMNO_MEDIA_INFO_REPORT(380),
  TRMNO_DISABLE_DISCFLAG_DISC2BARCODE(381),
  TRMNO_PRINT_RFM_DETAIL(382),
  TRMNO_DISP_FIPMES_SELF(383),
  TRMNO_DISABLE_SPPRC_DISCITEM(384),
  TRMNO_USE_BDL_LOW_PRICE(385),
  TRMNO_NON_DISP_HESO_MARK(386),
  TRMNO_DISABLE_CARDCHK_RW_PANA(387),
  TRMNO_PRINT_ASTMARK_ITFBARCODE(388),
  TRMNO_RW_PRINTAREA_EXT(389),
  TRMNO_FUTAGAMI_PNTCARD_FLG(390),
  TRMNO_ENABLE_SPDSC_NONPLU(391),
  TRMNO_ENABLE_ACX_USE_VMC(392),
  TRMNO_ORIGINAL_CARD_OPE(393),
  TRMNO_CHG_CULC_PROFIT_WTBAR(394),
  TRMNO_PRINT_POINT_1_100TIMES(395),
  TRMNO_RESERVE_PREPAY_POSTPAY_ACTSALE(396),
  TRMNO_ATRE_CASH_POINT_IP3100(398),
  TRMNO_CHK_LENGTH_MAGCARD(399),
  TRMNO_CPN_QTY_NON_POINT_ITEM_QTY(400),
  TRMNO_ENABLE_CREDIT_VOID_OTHERMAC(401),
  TRMNO_DISP_CHG_FIP_SPRIT_OPE(402),
//	TRMNO_DISABLE_PAYMET_ACT_ACX(403),
  TRMNO_FELICA_WR_BEFORE_RECEIPT(404),
  TRMNO_NTTEAST_CHG_HTTP_HTTPS(405),
  TRMNO_NTTEAST_DISABLE_DEL_MASTER(406),
  TRMNO_NTTEAST_READ_INTERNAL_FOLDER(407),
  TRMNO_NTTEAST_SET_SALEDATA_INTERNAL_FOLDER(408),
  TRMNO_OMC_LESS_30000(409),
  TRMNO_CHG_DISP_REBATE_EXCLUSION(410),
  TRMNO_DISABLE_ENT_CLS_OPE(411),
  TRMNO_DISABLE_CHAKEY_ACX(412),
  TRMNO_CHG_PRINT_WARRANTY_INFO(413),
  TRMNO_DISABLE_BACKUP_OPEN_DATA(414),
  TRMNO_OPE_TIME_USE(415),
  TRMNO_DISABLE_MBR_TICKET_REPRINT(416),
  TRMNO_SPCIAL_ITEM_COMBINE(418),
  TRMNO_SIBERU_OPE_REPORT(419),
  TRMNO_CULC_METHOD_TERMINAL_ITEMSTACK(420),
  TRMNO_PRINT_MARK_CONTROL_TYP_PNTYEN(421),
  TRMNO_PRINT_RECIPE(422),
  TRMNO_PRINT_TICKET_EN(423),
  TRMNO_DISP_CUST_ITEM_UPRC(424),
  TRMNO_ACX_ACB50_CONTROL_1(425),
  TRMNO_BINGO_CARD_CONNECT(426),
  TRMNO_HOSTNAME_IN_FTP_CONNECT(427),
  TRMNO_REBATE_FANFARE_IN_CASHKEY(428),
  TRMNO_RECEIPT_TOTAL_CHAR_BIGGER(430),
  TRMNO_RECEIPT_CHANGE_CHAR_BIGGER(432),
  TRMNO_DISABLE_POINT_DISP_INFOX(436),
  TRMNO_SIBERU_REPORT_TITLE_CHG(437),
  TRMNO_SEARCH_VOID_PRIORITY_1(438),
  TRMNO_SEARCH_VOID_CONF_MSG(439),
  TRMNO_USE_CLS_STLDISC_FLAG(440),
  TRMNO_PRINT_CLS_2D(442),
  TRMNO_SEARCH_VOID_DISABLE_PRCOVER(443),
  TRMNO_ERROR_SLEEP_MBR(447),
  TRMNO_TRANRCEIPT_BARFLG_EQUAL_JAN(449),
  TRMNO_DEL_SHOPBAG_VOICE_SSPS(450),
  TRMNO_NON_PRINT_UPRC_EN(451),
  TRMNO_USE_EMPTY_TOTALLOG_TXT(452),
  TRMNO_PRINT_CASHPICKAMT_SALEPICK(453),
  TRMNO_ISSUE_TICKET_EN_OVER(455),
  TRMNO_MBR_CONTACT_SAMETIME(456),
  TRMNO_MATSUGEN_MAGCARD(457),
  TRMNO_FELICA_WR_ANOTHER_CARD(458),
  TRMNO_NON_PRINT_VOIDOPE_NONSUMMARY(459),
  TRMNO_SELF_CHG_TIMING_FELICA_TOUCH(460),
  TRMNO_ENABLE_DISPVOID_STL_ITEMSCREEN(461),
  TRMNO_JOYPOS_CREDIT_CHAKEY(462),
  TRMNO_DEL_SUICATRADE_WORD(463),
  TRMNO_RECHK_TENDER_EDY_SUICA(464),
  TRMNO_TUO_CHG_PROC(465),
  TRMNO_PATIO_MBRPOINT_PANACODE(466),
  TRMNO_COOP_YAMAGUCHI_GREEN_STAMP(467),
  TRMNO_NON_PRINT_RANDAM_ITEM(469),
  TRMNO_ENABLE_FIX_PRICE_ENT(470),
  TRMNO_NON_ADD_STORE_CUST_RET_BOTTLE(471),
  TRMNO_NW7MBR_BARCODE_2(472),
  TRMNO_SELF_STLPDSC_KEY(473),
  TRMNO_SELF_AUTO_PDSC_LMT(474),
  TRMNO_SUS_TYP_FLG(475),
  TRMNO_TIME_PRC_TYP(476),
  TRMNO_CRDT_STLPDSC_OPE(477),
  TRMNO_OUT_SMLCLS_NUM6(478),
  TRMNO_OUT_SMLCLS_NUM7(479),
  TRMNO_OUT_SMLCLS_NUM8(480),
  TRMNO_OUT_SMLCLS_NUM9(481),
  TRMNO_OUT_SMLCLS_NUM10(482),
  TRMNO_CRDT_USER_NO(483),
  TRMNO_MAGCARD_CHK_LEN(484),
  TRMNO_JIS2_LEN(485),
  TRMNO_ACX_CIN_FIPDISP(486),
//	TRMNO_ACX_CIN_ADD_TRAN(487),
  TRMNO_SELF_CRDT_SLIP_KEY_CD(488),
  TRMNO_SELF_OFFCRDT_KEY_CD(489),
  TRMNO_BOOK_SUM_PLU_TYP(490),
  TRMNO_DESKCSHR_RCPT_FLG(491),
  TRMNO_DUTY_OUT_FLG(492),
  TRMNO_DUTY_REST_FLG(493),
  TRMNO_WARNING_ITEM_FLG(494),
  TRMNO_SEPARATE_CHG_AMT(495),
  TRMNO_SELF_OTHER_PAY(496),
  TRMNO_SELF_WGT_ERRCHK_PER(497),
  TRMNO_ORDR_DAYS_LATER(498),
  TRMNO_SELF_TRANS_IC_KEY_CD(499),
  TRMNO_SELF_TRANS_IC_UNFINISH_KEY_CD(500),
  TRMNO_SELF_TRANS_IC_ERRMSG_KEY_CD(501),
  TRMNO_SELF_PRESET_DISP(502),
  TRMNO_SELF_VISATOUCH_KEY_CD(503),
  TRMNO_CPNBAR_DSC_KEY_CD(504),
  TRMNO_APPROVAL_INPUT_FLG(505),
  TRMNO_SP_CPN_COMP_CD(506),
  TRMNO_SP_CPN_DSC_KEY_CD(507),
  TRMNO_SP_CPN_PDSC_KEY_CD(508),
  TRMNO_SELF_WGTCHK_FLG(509),
  TRMNO_SELF_MYBACK_STAMP_KEY_CD(510),
  TRMNO_AUTO_OFF_BATREPORT(511),
  TRMNO_EXCHANGE_TCKT_FLG(512),
  TRMNO_SELF_BIG_ITEM(513),
  TRMNO_TBLFORMAT_OUTPUT(514),
  TRMNO_PRECA_CHARGE_MAX_AMT(515),
  TRMNO_REGS_DISP_RET_TIME(516),
  TRMNO_ORDR_COST_DISP(517),
  TRMNO_DRUG_EXP_KIND(518),
  TRMNO_BDL_AFTER_MANU_DISC(519),
  TRMNO_DISABLE_SR_BDL_BAR_PRC(521),
  TRMNO_MYSELF_VOID_OPE(522),
  TRMNO_DISABLE_STLDISC_CREDIT_STLDISC(523),
  TRMNO_KASUMI_CHK_AEON_CREDIT(524),
  TRMNO_NON_PRINT_CREDIT_ITEM_DETAIL(525),
  TRMNO_TERM_SPPRC_DISC_OPE(526),
  TRMNO_NON_PRINT_RECEIPT_AMT0(527),
  TRMNO_DISP_PASSWORD_CLERK_ERROR(528),
  TRMNO_DISP_CALLCLERK_NEAREND_ACX(529),
  TRMNO_CUT_EVERY_CREDIT_REPORT(530),
  TRMNO_CHG_WARN_WORD_VD_TR_SR(531),
  TRMNO_CHG_REG_COLOR_VOID_REFOUND(532),
  TRMNO_REPORT_CONDITION_1(533),
  TRMNO_DISP_MSG_RELEASE_AGECONF(536),
  TRMNO_DISABLE_PRESET_7P_SSPS(540),
  TRMNO_PRINT_MYBAG_WORD(541),
  TRMNO_AUTO_EXEC_CLOSEOPE(543),
  TRMNO_CHK_DIFF_CASH_CHK3(544),
  TRMNO_ACX_RECOVER_ECS07(545),
  TRMNO_ACX_DISCHA_CREDIT_VOID(546),
  TRMNO_CHG_CULC_SPLIT_OMC(547),
  TRMNO_CHK_OFFONLINE_MBR(548),
  TRMNO_DISABLE_FCFCARD_CHK(549),
//	TRMNO_DISABLE_ACX_RECOVER_SALES(550),
  TRMNO_FSP_TICKET(551),
  TRMNO_DISP_CANCEL_ITEMSCAN(552),
  TRMNO_CALC_CD_KASUTAMU_BRIDALCARD(553),
  TRMNO_CALC_CD_RINGOCARD(554),
  TRMNO_CALC_CD_OFFONCARD(555),
  TRMNO_CHG_MEAL_TICKET(556),
  TRMNO_CHG_WARRANTY_TICKET(557),
  TRMNO_WARRANTY_WITH_RECEIPT(558),
  TRMNO_ENABLE_ITEM_SCAN_SSPS(559),
  TRMNO_USE_CLERKNUM_1546(560),
  TRMNO_TICKET_OPE_WITHOUT_QS(561),
  TRMNO_ACX_CASH_INPUT_MANUAL(562),
  TRMNO_CHG_ACX_INPUT_DISP(563),
  TRMNO_DISP_STAR_ITEMNAME(564),
  TRMNO_PRINT_POINT_OPENOPE(565),
  TRMNO_NONTAX_CHA10(567),
  TRMNO_PRINT_MSG2_4_PROMO(568),
  TRMNO_ACX_RECOVER_SAME_BUTTON(570),
  TRMNO_ACX_WARN_CHANGE_ECS07(571),
//	TRMNO_DISABLE_ACX_INPUT_SALES(572),
//	TRMNO_DISABLE_ACX_OUTPUT_SALES(573),
  TRMNO_INCLUDE_DIFF_CHK_CASH(574),
  TRMNO_ENABLE_TICKET_REALREBATE(575),
  TRMNO_CHG_KASUMICARD_SELF(576),
  TRMNO_ACX_CHG_RECOVER_AREA(577),
  TRMNO_ENABLE_CHGPR_DISC_OUTCLS(578),
  TRMNO_DISABLE_WT0_WTERR(579),
  TRMNO_DISP_PASSWORD_WTERROR(580),
  TRMNO_DELIVERY_DOUBLE_RECEIPT(581),
  TRMNO_CHK_RAINBOWCARD(582),
  TRMNO_ACX_RECOVER_LESS_ERROR(583),
  TRMNO_CANCEL_SALE_ADD_ABSOLUTEVALUE(584),
  TRMNO_CHG_DISCBACODE_FLG(585),
  TRMNO_ENABLE_DISCVAL_ITEMPRC(586),
  //TRMNO_ACX_EXCHANGE_INPUT(588),
  //TRMNO_HESO_SALE_MANUAL_PRC(590),
  TRMNO_NON_PRINT_PLEASE_STOCK(591),
  TRMNO_DISABLE_DISP_PREPAGE2_7(592),
  TRMNO_AMPM_SALES_ITEM_BARCODE_PRINT(593),
  TRMNO_AMPM_MASTER_IMPORT(594),
  TRMNO_USE_BIGGER_RECOMMEND_POINT(595),
  TRMNO_CHG_PRESETNAME_CONVENIENCESTORE(596),
  TRMNO_CHK_CD_OMCCARD(597),
  TRMNO_SCAN_PANEL_OPE(599),
  TRMNO_ITEM_DISC_UPPERREF(600),
  TRMNO_AMPM_ADD_STLDISCVAL_PRC(601),
  TRMNO_TRANDETAIL_REPORT_INTAX_NOTPRN(602),
  TRMNO_TRANDETAIL_REPORT_EXTAX_NOTPRN(603),
  TRMNO_TRANDETAIL_REPORT_TRANIN_EXTAX_PRN(604),
  TRMNO_TRANDETAIL_REPORT_IN_EXTAX_PRN(605),
  TRMNO_AMPM_CHG_STARTUP_MOV(606),
  TRMNO_DISP_SKIP_ITEM_REG(607),
  TRMNO_NALSE_PANACODE(609),
  TRMNO_CHG_PROPDIV(610),
  TRMNO_MASTER_IMPORT_MAKE(611),
  TRMNO_PROM_MBRNAME_TYPE(612),
  TRMNO_SPECIALCONV_WEEKBOOK(613),
  TRMNO_SPECIALCONV_OTHWEEKBOOK(614),
  TRMNO_LOASON_MASTER_IMPORT(615),
  TRMNO_SALE_SAVE_CLOSEOPE(616),
  TRMNO_ACX_LOG_SAVE_CLOSEOPE(617),
  TRMNO_SUICA_SHORT_RECEIPT(618),
  TRMNO_USE_EXTAX_CALC(619),
  TRMNO_SPPRC_GET_TAXAMT(620),
  TRMNO_CHG_UPCE_UPCA(621),
  TRMNO_LOASON_NW7MBR(622),
  TRMNO_CHG_BUTTON_AREA_OPENCLOSE(623),
  TRMNO_CHG_MSG_BAR_NOT_READ(624),
  TRMNO_DISABLE_MBRPRC_OTHMBR(625),
  TRMNO_PRINT_SUM_TAX(626),
  TRMNO_PRINT_INSTNUM_WIZPOD(627),
  TRMNO_PRG_PRESET_NAME(628),
  TRMNO_RALSE_POINT_INPUT_FNC(629),
  TRMNO_COMB_MBR_CLKDSC(630),
  TRMNO_NON_SUMMARYPRINT_TICKET(631),
  TRMNO_AMPM_SCAN_FUNC_1(632),
  TRMNO_AMPM_SCAN_FUNC_2(633),
  TRMNO_AMPM_SEPARATE_BDL_SM(634),
  TRMNO_ADD_VOID_RECEIPT_TTLLOG(635),
  TRMNO_DISP_PASSWORD_ERROR(636),
  TRMNO_USE_OPTIONVAL_SEARCHVOID(637),
  TRMNO_EXCEPT_OTHCASH_RECALC(638),
  TRMNO_DISP_NONRECEIPT_PAYSCREEN(639),
  TRMNO_SELF_MBRSTLPDSC_KEY(641),
  TRMNO_EDY_ALARM_PRN(643),
  TRMNO_TAB_POSITION(644),
  TRMNO_TAB_STL_SAVE(645),
  TRMNO_CASHMGMT_OUTHOLD_CUST(646),
  TRMNO_CASHMGMT_EXCHG(647),
  TRMNO_CASHMGMT_SHEET_DISP(648),
  TRMNO_CASHMGMT_CALC_CUST(649),
  TRMNO_CASHMGMT_CALC_BASE(650),
  TRMNO_BEHIND_PICK_TYP(651),
  TRMNO_CASHMGMT_RCPT_INFO(652),
  TRMNO_CASHMGMT_INOUT_UNIT(653),
  TRMNO_CASHMGMT_STAFF_OPERATION(654),
  TRMNO_CASHMGMT_STAFF_INPUT(655),
  TRMNO_CASHMGMT_APPLY_TYP(656),
  TRMNO_CASHMGMT_INDICATE_RCPT(657),
  TRMNO_CASHMGMT_INOUT_RCPT_INFO(658),
  TRMNO_CASHMGMT_CINPICK_PROC(659),
  TRMNO_CASHMGMT_INFOBTN_DISP(660),
  TRMNO_ITEM_ARRIVE_CALC(661),
  TRMNO_RESERVPRN_NOTES(662),
  TRMNO_WARNINGDISP_TYP(663),
  TRMNO_CRDT_SIGNLESS_MAX_LIMIT(664),
  TRMNO_RESERVE_STRORENOTE_DOUBLE(665),
  TRMNO_COOPAIZU_FUNC_1(666),
  TRMNO_CASH_KIND_SELECT_RESERVEOPE(667),
  TRMNO_BUNKADO_QC_DISP(669),
  TRMNO_QC_DISABLE_SERACH_REG(670),
  TRMNO_QC_ENABLE_CANCEL(671),
  TRMNO_VMC_DISABLE_SALEUP_MENTE(672),
  TRMNO_DISP_NBRNAME_TABAREA(673),
  TRMNO_FOREIGN_DEPOSIT_OPE(674),
  TRMNO_RC_DISC_OPE(675),
  TRMNO_DISP_WTUPRC_CUSTDISP(676),
  TRMNO_CHG_DISP_MUL_ITEM(677),
  TRMNO_NON_CONNECT_CLK_OPEN(679),
  TRMNO_WARN_SUS_REF_PRCCHK_USE(680),
  TRMNO_PRINT_AFT_DISCPRC(681),
  TRMNO_MANSO_OPE(682),
  TRMNO_IKEA_OPE(683),
  TRMNO_DRWCHK_DISP_CHKDRW_AMT(684),
  TRMNO_DISP_STARTBOTTUN_QC_START(685),
  TRMNO_DISABLE_SPLIT_QC_TICKET(686),
  TRMNO_QC_SAME_TCKET_OK(687),
  TRMNO_QC_DIVADJ_RFM_PRC(688),
  TRMNO_ACX_DECISION_PASS(689),
  TRMNO_CHG_QC_SIGNCOLOR(690),
  TRMNO_DISABLE_SALE_MENU_WIZ(692),
  TRMNO_CHK_STL_CHA_SPEEZA(693),
  TRMNO_QC_CHG_MOV_PINK_RECEIPT(694),
  TRMNO_TAC_FUNC(695),
  TRMNO_PRINT_SHORT_TICKET(696),
  TRMNO_CHG_RECEIPT_CUT_MODE(697),
  TRMNO_ENABLE_SEARCH_CHANGE_TICKET(698),
  TRMNO_QC_SAME_TCKET_START_OK(699),
  TRMNO_QC_CLOSE_REPORT_FUNC(700),
  TRMNO_LIGHT_ONOFF_CANCEL_OPE(701),
  TRMNO_WIZ_AUTO_REG_IP3D(702),
  TRMNO_NONPLU_READ_MSTPRC(703),
  TRMNO_COOPSAPPORO_PRINT_FUNC(704),
  TRMNO_QC_CALL_CLK_RFM(705),
  TRMNO_QC_USE_SPEEZA_TERMINAL(706),
  TRMNO_CONNECT_SBS_CREDIT_1(707),
  TRMNO_DCMAL_PRCCHG_SPECIAL_CALC(708),
  TRMNO_PRINT_SEPARATE_TICKET_FUNC(709),
  TRMNO_NON_PRINT_SIGNAREA_CREDIT_NOTE(710),
  TRMNO_CONNECT_SBS_CREDIT_2(712),
  TRMNO_CHG_RFM_CREDIT_WORD(713),
  TRMNO_QC_CALL_CLK_RFM_ISSUE(714),
  TRMNO_RECEIPT_ERR_AUTO_RPR(716),
  TRMNO_SAME_PRESET_PUSH_QTY(718),
  TRMNO_MBRBARCODE_CUSTBARCODE(719),
  TRMNO_QC_DISP_REPRINT_DIAG(722),
  TRMNO_ACOOP_CREDIT_FUNC(724),
  TRMNO_VERTICAL_RFM(725),
  TRMNO_QC_GET_UPD_SPEEZA(726),
  TRMNO_RESERVE_SPARE_TXT_BIG(727),
  TRMNO_NON_PRINT_MANU_REP_ITEM(728),
  TRMNO_ENABLE_BLUECHIP_EVOID(729),
  TRMNO_PRINT_STORE_NOTE_GLORYMULTI(730),
  TRMNO_NON_PRINT_CREDIT_TELNO(731),
  TRMNO_KANESUE_NEWOPE_FUNC(732),
  TRMNO_PEINT_BEFORE_AFTER_DISCPRC(733),
  TRMNO_ACX_FREEEXCHANGE_ACB200_EOS07(734),
  TRMNO_PRINT_ITEMNAME_AREA_BIG(736),
  TRMNO_PRINT_INTAX_SPLIT_RECEIPT(737),
  TRMNO_ENABLE_ACCT_MBR_CALL(738),
  TRMNO_DISC_BARCODE_28D(739),
  TRMNO_PRECA_CHARGE_NOT_DRWAMT(740),
  TRMNO_ACOOP_PRINT_FUNC_1(742),
  TRMNO_QC_CHG_PRN_ORDR(743),
  TRMNO_CREDITVOID_CHK_FUNC(745),
  TRMNO_PRINT_TERMINAL_CLS3D(746),
  TRMNO_ENABLE_ENT_CREDIT_OPE(747),
  TRMNO_SELF_SELECT_ITEM_NONBARKEY(748),
  TRMNO_ASSORT_RANDOM_ORDR_PRN(749),
  TRMNO_ASSORT_RANDOM_SUM_PRN(750),
  TRMNO_ASSORT_RANDOM_PRN_CHG(751),
  TRMNO_ATTENDANT_MBR_READ(752),
  TRMNO_WATARICARD_OPE(753),
  TRMNO_ASSORT_RANDOM_REPEAT(754),
  TRMNO_SANWADO_DRWCHK_CHK(755),
  TRMNO_CUSTSVR_OFFLINE_CHK(757),
  TRMNO_CUSTSVR_CNCT_OFFLINE_CHK(758),
  TRMNO_RESERV_NO_SET_FLG(759),
  TRMNO_ARKS_NEW_CARD_CHK(760),
  TRMNO_DISABLE_MBR_CASHKEY(761),
  TRMNO_DISABLE_USE_ACX_LESS10000(762),
  TRMNO_MBR_REQ_TSD7000(763),
  TRMNO_SCALE_NONUSE_SPEEZA(764),
  TRMNO_COMBINE_MAGMBR_CREDIT(765),
  TRMNO_KAMADO_STLDSC_CHA1_FUNC(766),
  TRMNO_QC_RFM_DATA_DEL_PRN(767),
  TRMNO_ENABLE_CHAKEY_CREDIT(768),
  TRMNO_PRINT_RESTART_CONTINUE(769),
  TRMNO_TICKET_MANEGE_SRV_FUNC(770),
  TRMNO_PRINT_SLIPNUM_TICKET(771),
  TRMNO_DAILYCLR_JMUPS(772),
  TRMNO_HTTPS_PROXY_USE(773),
  TRMNO_VOID_JMUPS(774),
  TRMNO_DISABLE_SEARCH_EDY_MBR_TRAN(775),
  TRMNO_PRINT_TITLE_2TIMEBIG(776),
  TRMNO_DISP_ERR_SCHEDULE_READ(777),
  TRMNO_CHG_BUSINESS_CODE(778),
  TRMNO_PRINT_DELIVERY_SHEET(779),
  TRMNO_PROM_ARBITRARY_BITMAP(780),
  TRMNO_DETAILRFM_OVER_REVENUE(781),
  TRMNO_WGTITEM_INFO_STLDISP(782),
  TRMNO_RFM_COUNTER_FUNC(783),
//	TRMNO_DISABLE_ACX_INOUT_SALE(785),
  TRMNO_KASUMI_CHG_RFM(786),
  TRMNO_QC_TCKT_STAMP_PRINT(788),
  TRMNO_MARUSHIME_MBR_FUNC(789),
  TRMNO_QC_SALE_USE_UPD(790),
  TRMNO_LOSTPOINT_OFFMBR_PRINT(791),
  TRMNO_OPENCLOSE_CHG_RT300(792),
  TRMNO_QC_READ_NOT_SALEDATE_CHK(793),
  TRMNO_CHK_STL_ITEMSCREEN(794),
  TRMNO_DISP_BDL_QTY_LIMIT1(795),
  TRMNO_SANRIKU_FUNC(796),
  TRMNO_QC_READ_NOT_INTERRUPT(797),
  TRMNO_CLSCNCL_ITEM_FLG(798),
  TRMNO_USE_LOW_PRICE_4(799),
  TRMNO_AYAHA_TICKET_FUNC(800),
  TRMNO_BUNKADO_FSP_FUNC(801),
  TRMNO_PRINT_2TIMEWIDE_FSP(802),
  TRMNO_CALCCHG_DSC_CLSDSC(803),
  TRMNO_LOTTERY_OPE_FLG(804),
  TRMNO_ACNT_POINT_TYP1(805),
  TRMNO_ACNT_POINT_TYP2(806),
  TRMNO_ACNT_POINT_TYP3(807),
  TRMNO_ACNT_POINT_TYP4(808),
  TRMNO_ACNT_POINT_TYP5(809),
  TRMNO_ACNT_POINT_TYP6(810),
  TRMNO_ACNT_POINT_TYP7(811),
  TRMNO_ACNT_POINT_TYP8(812),
  TRMNO_ACNT_POINT_TYP9(813),
  TRMNO_ACNT_POINT_TYP10(814),
  TRMNO_TICKET_POINT_TYP1(815),
  TRMNO_TICKET_POINT_TYP2(816),
  TRMNO_TICKET_POINT_TYP3(817),
  TRMNO_TICKET_POINT_TYP4(818),
  TRMNO_TICKET_POINT_TYP5(819),
  TRMNO_SALE_PLU_POINT_TYP(820),
  TRMNO_SUBT_DCNT_POINT_TYP(821),
  TRMNO_SBS_RBT_POINT_TYP(822),
  TRMNO_MPLU_STLDSC_TYP(823),
  TRMNO_SMPLU_STLDSC_TYP(824),
  TRMNO_TDY_TGTMNY_PRINT(826),
  TRMNO_TDY_POINT_PRINT(827),
  TRMNO_TOTAL_POINT_PRINT(828),
  TRMNO_POSBL_POINT_PRINT(829),
  TRMNO_MEM_NO_PRINT(830),
  TRMNO_MEM_MAGNO_PRINT(831),
  TRMNO_MEM_NAME_PRINT(832),
  TRMNO_ANV_PRINT(833),
  TRMNO_POINT_ACHIV_PRINT(834),
  TRMNO_SBS_TCKT_DVID_PRINT(835),
  TRMNO_SBS_TCKT_PRINT_KIND(836),
  TRMNO_SPCL_TCKT_TITLE(837),
  TRMNO_MEM_ANV_DSP(838),
  TRMNO_ANV_MNY_DSP(839),
  TRMNO_POINT_FIP_DSP(840),
  TRMNO_RVT_BEEP(841),
  TRMNO_MEM_BCD_TYP(842),
  TRMNO_MAGCAD_KND(843),
  TRMNO_RWCAD_KND(844),
  TRMNO_MEM_USE_TYP(845),
  TRMNO_SBS_MTHD(846),
  TRMNO_SBS_DSP_MTHD(847),
  TRMNO_POINT_CLC_UNIT(848),
  TRMNO_POINT_CLC_RND(849),
  TRMNO_PPOINT_MCLR_TYP(850),
  TRMNO_POINT_SBS_CLR_TYP(851),
  TRMNO_NW_RVT_POINT_TYP(852),
  TRMNO_BUY_POINT_ADD_MAGN(853),
  TRMNO_BUY_POINT_LLMT_MNY(854),
  TRMNO_BUY_POINT_RDWN(855),
  TRMNO_BUY_POINT_CUTPSTN(856),
  TRMNO_POINT_AMTCLC_RND(857),
  TRMNO_PLU_RGS_POINT_COND(858),
  TRMNO_RVT_SUBST_MTHD(859),
  TRMNO_TCKT_AUTO_RVT_UNIT(860),
  TRMNO_TGTMNY_CLC_MTHD(861),
  TRMNO_BUY_POINT_LLIMT1(862),
  TRMNO_BUY_POINT_MAGN1(863),
  TRMNO_BUY_POINT_LLIMT2(864),
  TRMNO_BUY_POINT_MAGN2(865),
  TRMNO_BUY_POINT_LLIMT3(866),
  TRMNO_BUY_POINT_MAGN3(867),
  TRMNO_BUY_POINT_LLIMT4(868),
  TRMNO_BUY_POINT_MAGN4(869),
  TRMNO_MEM_ANYPRC_STET(870),
  TRMNO_MEM_ANYPRC_REDU_STET(871),
  TRMNO_MEM_MULPRC_KND(872),
  TRMNO_MEM_MULPDSC_KND(873),
  TRMNO_MEM_MULADD_KND(874),
  TRMNO_TDY_TERM_COMP_PRINT(875),
  TRMNO_TERM_COMP_PRINT(876),
  TRMNO_NXTLVL_MNY_PRINT(877),
  TRMNO_NOW_LVL_PRINT(878),
  TRMNO_ANYPRC_TERM_ADD_MAGN(879),
  TRMNO_ANYPRC_TERM_LLIMT1(880),
  TRMNO_ANYPRC_TERM_MAGN1(881),
  TRMNO_ANYPRC_TERM_LLIMT2(882),
  TRMNO_ANYPRC_TERM_MAGN2(883),
  TRMNO_ANYPRC_TERM_LLIMT3(884),
  TRMNO_ANYPRC_TERM_MAGN3(885),
  TRMNO_ANYPRC_TERM_LLIMT4(886),
  TRMNO_ANYPRC_TERM_MAGN4(887),
  TRMNO_ANYPRC_TERM_LLMT_MNY(888),
  TRMNO_ANYPRC_TERM_RDWN(889),
  TRMNO_ANYPRC_TRM_CUTPSTN(890),
  TRMNO_FSP_CD(891),
  TRMNO_S_LOWER_LIMIT(892),
  TRMNO_A_LOWER_LIMIT(893),
  TRMNO_B_LOWER_LIMIT(894),
  TRMNO_C_LOWER_LIMIT(895),
  TRMNO_D_LOWER_LIMIT(896),
  TRMNO_S_SUB_DCNT_RATE(897),
  TRMNO_A_SUB_DCNT_RATE(898),
  TRMNO_B_SUB_DCNT_RATE(899),
  TRMNO_C_SUB_DCNT_RATE(900),
  TRMNO_D_SUB_DCNT_RATE(901),
  TRMNO_S_LVL_ADD_MAGN(902),
  TRMNO_A_LVL_ADD_MAGN(903),
  TRMNO_B_LVL_ADD_MAGN(904),
  TRMNO_C_LVL_ADD_MAGN(905),
  TRMNO_D_LVL_ADD_MAGN(906),
  TRMNO_ANYPRC_TRMAMTCLC_RND(907),
  TRMNO_PLU_RGS_ANYPRC_TRM(908),
  TRMNO_ANYPRC_TRMCLC_MTHD(909),
  TRMNO_ACNT_ANYPRC_TYP1(910),
  TRMNO_ACNT_ANYPRC_TYP2(911),
  TRMNO_ACNT_ANYPRC_TYP3(912),
  TRMNO_ACNT_ANYPRC_TYP4(913),
  TRMNO_ACNT_ANYPRC_TYP5(914),
  TRMNO_ACNT_ANYPRC_TYP6(915),
  TRMNO_ACNT_ANYPRC_TYP7(916),
  TRMNO_ACNT_ANYPRC_TYP8(917),
  TRMNO_ACNT_ANYPRC_TYP9(918),
  TRMNO_ACNT_ANYPRC_TYP10(919),
  TRMNO_TICKET_ANYPRC_TYP1(920),
  TRMNO_TICKET_ANYPRC_TYP2(921),
  TRMNO_TICKET_ANYPRC_TYP3(922),
  TRMNO_TICKET_ANYPRC_TYP4(923),
  TRMNO_TICKET_ANYPRC_TYP5(924),
  TRMNO_SPLU_ANYPRC_TYP(925),
  TRMNO_STLDSC_ANYPRC_TYP(926),
  TRMNO_SBS_RBT_ANYPRC_TYP(927),
  TRMNO_RBT_FLG(928),
  TRMNO_ISSUE_CUSTNAME_PRN(929),
  TRMNO_MAG_CARD_TYP(930),
  TRMNO_CARD_STRE_CD_CHK(931),
  TRMNO_MAG_ECFT_TRM_CHK(932),
  TRMNO_OTHCMP_MAG_STRT_NO(933),
  TRMNO_OTHCMP_MAG_EFCT_NO(934),
  TRMNO_RWT_CUSTMST_PRN(935),
  TRMNO_OTH_SALE_ADD(936),
  TRMNO_RWT_INFO(937),
  TRMNO_RWT_WIND_PRN(938),
  TRMNO_RWT_WIND_DATE_PRN(939),
  TRMNO_GPNO_INPLU(940),
  TRMNO_SMREG_MTHD(941),
  TRMNO_LVL_CHG_D_LVL(942),
  TRMNO_RWT_SP_RBT_PER(943),
  TRMNO_LST_S_LOWER_LIMIT(944),
  TRMNO_LST_A_LOWER_LIMIT(945),
  TRMNO_LST_B_LOWER_LIMIT(946),
  TRMNO_LST_C_LOWER_LIMIT(947),
  TRMNO_LST_D_LOWER_LIMIT(948),
  //TRMNO_PLU_ADD_PRINT(949),	// 削除
  TRMNO_STAMP_POINT_TYP1(950),
  TRMNO_STAMP_POINT_TYP2(951),
  TRMNO_STAMP_POINT_TYP3(952),
  TRMNO_STAMP_POINT_TYP4(953),
  TRMNO_STAMP_POINT_TYP5(954),
  TRMNO_SHOPPING_POINT(955),
  TRMNO_MUPRC_CLSDSC_FLG(956),
  TRMNO_BE_TOTAL_PNT_PRN(957),
  TRMNO_BE_POSSIBLE_PNT_PRN(958),
  TRMNO_OTHER_STORE_MBR_DSP(959),
  TRMNO_MBR_BLANKINFO_WARN(960),
  TRMNO_OTHER_STORE_MBR_PRN(961),
  TRMNO_PROM_TCKT_PRN_MAX(962),
  TRMNO_BIRTHDAY_POINT_PRN(963),
  TRMNO_MBRSELLKEY_CTRL(964),
  TRMNO_BIRTHDAY_POINT_ADD(965),
  TRMNO_D_ADD_POINT_PRN(966),
  TRMNO_D_ADD_PNT_DETAIL_PRN(967),
  TRMNO_ADD_POINT_PRIORITY(969),
  TRMNO_NON_MBR_PNT_PRN(970),
  TRMNO_BUYADD_TCKT_PRN(971),
  TRMNO_POINT_UNIT(972),
  TRMNO_VOID_CUST(973),
  TRMNO_PROM_TCKT_PRN_TYP(974),
  TRMNO_TCKT_ISSU_AMT(975),
  TRMNO_TCKT_GOOD_THRU(976),
  TRMNO_TCKT_GOOD_THRU_PRN(977),
  TRMNO_BIRTH_BEEP(978),
  TRMNO_CUST_ADDR_PRN(979),
  TRMNO_CASH_POINT_YPE(980),
  TRMNO_CASH_ANYPRC_TYP(981),
  TRMNO_PT_BONUS_LIMIT1(982),
  TRMNO_PT_ADD_BONUS1(983),
  TRMNO_PT_BONUS_LIMIT2(984),
  TRMNO_PT_ADD_BONUS2(985),
  TRMNO_PT_BONUS_LIMIT3(986),
  TRMNO_PT_ADD_BONUS3(987),
  TRMNO_PT_BONUS_LIMIT4(988),
  TRMNO_PT_ADD_BONUS4(989),
  TRMNO_BONUS_SELECT(990),
  TRMNO_STLPLUS_POINT_TYP(991),
  TRMNO_STLPLUS_ANYPRC_TYP(992),
  TRMNO_TTL_POINT_GOOD_THRU(994),
  TRMNO_OUTMDL_POINT(995),
  TRMNO_REBATE_DISC_KEY(996),
  TRMNO_MBR_NAME_DSP(998),
  TRMNO_PERSONAL_DATA(999),
  TRMNO_BONUS_PNT_SCH(1000),
  TRMNO_BONUS_PNT_LIMIT(1001),
  TRMNO_NON_POINT_MARK(1002),
  TRMNO_RCPRATE_SEL(1003),
  TRMNO_DPOINT_AMT_LIMIT(1004),
  TRMNO_ECOA_PNTUSE_SML(1005),
  TRMNO_ECOA_PNTUSE_BIG(1006),
  TRMNO_MBR_DETAIL_KEEP_CNT(1007),
  TRMNO_MBR_DETAIL_KEEP_MONS(1008),
  TRMNO_COUPON_BAR_PRN(1009),
  TRMNO_POS_MEDIA_NO(1010),
  TRMNO_VALID_YEAR(1011),
  TRMNO_CARD_MNG_FEE(1012),
  TRMNO_CRDT_PT_CALC_UNIT(1013),
  TRMNO_PRORATE_PNT_PRN(1014),
  TRMNO_PROM_LIMIT_AMT1(1015),
  TRMNO_PROM_LIMIT_AMT2(1016),
  TRMNO_PROM_LIMIT_AMT3(1017),
  TRMNO_PROM_LIMIT_AMT4(1018),
  TRMNO_PROM_LIMIT_AMT5(1019),
  TRMNO_CARD_TYP1_DSC(1020),
  TRMNO_CARD_TYP2_DSC(1021),
  TRMNO_CARD_TYP3_DSC(1022),
  TRMNO_PROM_LIMIT_AMT6(1023),
  TRMNO_PROM_LIMIT_AMT7(1024),
  TRMNO_PROM_LIMIT_AMT8(1025),
  TRMNO_CARD_FORGET_SKEY(1026),
  TRMNO_PROM_CODE1(1027),
  TRMNO_PROM_CODE2(1028),
  TRMNO_PROM_CODE3(1029),
  TRMNO_PROM_CODE4(1030),
  TRMNO_PROM_CODE5(1031),
  TRMNO_PROM_CODE6(1032),
  TRMNO_PROM_CODE7(1033),
  TRMNO_PROM_CODE8(1034),
  TRMNO_ADDPNT_SKEY(1035),
  TRMNO_SRVNO_CHG_DSP(1036),
  TRMNO_DM_POST_PRN(1037),
  TRMNO_ABSV31_USER(1038),
  TRMNO_LOT_NUM1(1039),
  TRMNO_LOT_NUM2(1040),
  TRMNO_OUTPNT_PRN_START(1041),
  TRMNO_OUTPNT_PRN_END(1042),
  TRMNO_PRIZE_NO_FROM(1043),
  TRMNO_PRIZE_NO_TO(1044),
  TRMNO_OUTMDL_PNTCAL_TAXNO(1045),
  TRMNO_RCDSC_CARD_NO(1046),
  TRMNO_STAFFDSC_CARD_NO(1047),
  TRMNO_PREPAID_CHGPNT_CALUNIT(1048),
  TRMNO_RALSE_REAL_COMP_CD(1049),
  TRMNO_PT_BONUS_LIMIT5(1050),
  TRMNO_PT_ADD_BONUS5(1051),
  TRMNO_PT_BONUS_LIMIT6(1052),
  TRMNO_PT_ADD_BONUS6(1053),
  TRMNO_PRN_NEWBLEV_ACH_AMT(1054),
  TRMNO_ACNT_POINT_TYP11(1055),
  TRMNO_ACNT_POINT_TYP12(1056),
  TRMNO_ACNT_POINT_TYP13(1057),
  TRMNO_ACNT_POINT_TYP14(1058),
  TRMNO_ACNT_POINT_TYP15(1059),
  TRMNO_ACNT_POINT_TYP16(1060),
  TRMNO_ACNT_POINT_TYP17(1061),
  TRMNO_ACNT_POINT_TYP18(1062),
  TRMNO_ACNT_POINT_TYP19(1063),
  TRMNO_ACNT_POINT_TYP20(1064),
  TRMNO_ACNT_POINT_TYP21(1065),
  TRMNO_ACNT_POINT_TYP22(1066),
  TRMNO_ACNT_POINT_TYP23(1067),
  TRMNO_ACNT_POINT_TYP24(1068),
  TRMNO_ACNT_POINT_TYP25(1069),
  TRMNO_ACNT_POINT_TYP26(1070),
  TRMNO_ACNT_POINT_TYP27(1071),
  TRMNO_ACNT_POINT_TYP28(1072),
  TRMNO_ACNT_POINT_TYP29(1073),
  TRMNO_ACNT_POINT_TYP30(1074),
  TRMNO_ACNT_ANYPRC_TYP11(1075),
  TRMNO_ACNT_ANYPRC_TYP12(1076),
  TRMNO_ACNT_ANYPRC_TYP13(1077),
  TRMNO_ACNT_ANYPRC_TYP14(1078),
  TRMNO_ACNT_ANYPRC_TYP15(1079),
  TRMNO_ACNT_ANYPRC_TYP16(1080),
  TRMNO_ACNT_ANYPRC_TYP17(1081),
  TRMNO_ACNT_ANYPRC_TYP18(1082),
  TRMNO_ACNT_ANYPRC_TYP19(1083),
  TRMNO_ACNT_ANYPRC_TYP20(1084),
  TRMNO_ACNT_ANYPRC_TYP21(1085),
  TRMNO_ACNT_ANYPRC_TYP22(1086),
  TRMNO_ACNT_ANYPRC_TYP23(1087),
  TRMNO_ACNT_ANYPRC_TYP24(1088),
  TRMNO_ACNT_ANYPRC_TYP25(1089),
  TRMNO_ACNT_ANYPRC_TYP26(1090),
  TRMNO_ACNT_ANYPRC_TYP27(1091),
  TRMNO_ACNT_ANYPRC_TYP28(1092),
  TRMNO_ACNT_ANYPRC_TYP29(1093),
  TRMNO_ACNT_ANYPRC_TYP30(1094),
  TRMNO_CONNECT_SBS_CREDIT_3(1095),
  TRMNO_FLIGHT_SYSTEM_CASH(1096),
  TRMNO_FLIGHT_SYSTEM_CHA1(1097),
  TRMNO_FLIGHT_SYSTEM_CHA2(1098),
  TRMNO_FLIGHT_SYSTEM_CHA3(1099),
  TRMNO_SELFGATE_SYSTEM(1100),
  TRMNO_REVENUE_STAMP_PAY_FLG(1101),
  TRMNO_OTHER_PANA_CARD_FLG(1102),
  TRMNO_YAO_SP_EVENT_CD(1103),
  TRMNO_YAO_PREFERENTIAL_DSCPER(1104),
  TRMNO_YAO_STAFF_DSCPER(1105),
  TRMNO_SELF_RFM_DISP_FLG(1106),
  TRMNO_ESVOID_BDLSTM_SAVE_USE(1107),
  TRMNO_BE_TOTAL_AMT_PRN(1108),
  TRMNO_PLAN_NAME_DISP_PRN(1109),
  TRMNO_ZEN_LOYALTY_PRN_DATE(1110),
  TRMNO_ZEN_LOYALTY_PRN_LIMIT(1111),
  TRMNO_STRE_SVS_MTHD_USE(1112),
  TRMNO_RFM_PRN_KIND(1113),
  TRMNO_VOID_LOG_KEEP(1114),
  TRMNO_YAO_HAKEN_DSCPER(1115),
  TRMNO_RESERV_DEL_DATE(1125),
  TRMNO_HIST_DEL_DATE(1126),
  TRMNO_LOG_DEL_DATE(1127),
  TRMNO_TRAN_DEL_DATE(1128),
  TRMNO_SRVLOG_SAVE_DATE(1129),
  TRMNO_BDL_PRC_FLG(1130),
  TRMNO_CRM_LVL_MONTH(1131),
  TRMNO_CRM_LVL_1_LIMIT(1132),
  TRMNO_CRM_LVL_2_LIMIT(1133),
  TRMNO_CRM_LVL_3_LIMIT(1134),
  TRMNO_CRM_HIGH_USE_LOWER_LIMIT(1135),
  TRMNO_CRM_LOW_USE_UPPER_LIMIT(1136),
  TRMNO_CRM_INTERVAL_WARN_MONTH(1137),
  TRMNO_WIZ_CARD_SCAN_FLG(1138),
  TRMNO_BE_TOTAL_PNT_DISP(1139),
  TRMNO_CPN_BMP_DELETE_MONTH(1140),
  TRMNO_CRM_PORTAL_CONF_PRN(1141),
  TRMNO_SAME_DATE_OPEN(1142),
  TRMNO_CHK_PASSWORD_CLK_OPEN(1143),
  TRMNO_CRM_DELIVERY_MONTH(1144),
  TRMNO_TAX_RATE_PRN(1145),
  TRMNO_DRAWCHK_CLOSE_SELECT(1146),
  TRMNO_STRCLS_VUP(1147),
  TRMNO_PNT_USE_LIMIT(1148),
  TRMNO_COIN_UNIT_SHT(1149),
  TRMNO_VUPFILE_GET_FLG(1150),
  TRMNO_CUST_CURL_TIMEOUT(1151),
  TRMNO_ACX_ERR_GUI_FLG(1152),
  TRMNO_QC_MENTE_DISP_KEY_AUTH(1153),
  TRMNO_STL_SCN_DISABLE(1154),
  TRMNO_AUTO_UPDATE(1155),
  TRMNO_TCH_BTN_BEEP(1156),
  TRMNO_SALE_LIMIT_TIME(1157),
  TRMNO_TAXFREE_AMT_CSM(1158),
  TRMNO_TAXFREE_AMT_GNRL(1159),
  TRMNO_TAXFREE_TAX_NUM(1160),
  TRMNO_TAXFREE_RECEIPTCNT(1161),
  TRMNO_NEAREND_NOTE(1162),
  TRMNO_AUTO_FORCE_CLS_MAKE_TRN(1163),
  TRMNO_CLSTIME_USING(1164),
  TRMNO_NOTRI_BDL_SUMPRN(1165),
  TRMNO_NONREG_POPUP_DISP(1166),
  TRMNO_SPECIAL_MULTI_OPE(1167),
  TRMNO_PRN_OUT_CLS_QTY(1168),
  TRMNO_HISTLOG_CHKR_ALERT(1169),
  TRMNO_BDL_LOW_LIMIT_CHK(1170),
  TRMNO_SCH_KEEP_PERIOD(1171),
  TRMNO_RDLY_KEEP_PERIOD(1172),
  TRMNO_RDLY_CLEAR_DAY(1173),
  TRMNO_MEMOBTN_NON_DISP(1174),
  TRMNO_EJ_TXT_DEL_DATE(1175),
  TRMNO_CSV_TXT_DEL_DATE(1176),
  TRMNO_CUSTBKUP_DEL_DATE(1177),
  TRMNO_NONUSACT_DEL_DATE(1178),
  TRMNO_AUTOCHKROFF_TIME(1179),
  TRMNO_AUTOMSGSTART_TIME(1180),
  TRMNO_AUTO_PW_DOWN(1181),
  TRMNO_USE_LOW_PRICE(1182),
  TRMNO_PROD_START_CD(1183),
  TRMNO_PROD_END_CD(1184),
  TRMNO_ITEM_START_CD(1185),
  TRMNO_ITEM_END_CD(1186),
  TRMNO_PRESET_SMALL(1187),
  TRMNO_KITCHEN_NON_SUMMARY(1188),
  TRMNO_KITCHEN_PRT_RPR(1189),
  TRMNO_PRINT_STLDSC_DETAIL(1190),
  TRMNO_SELECT_ITEM_SUM_TOTAL_QTY(1191),
  TRMNO_SPTEND_SELECT_VOID_CHANGE(1192),
  TRMNO_CORRECTED_ITEM_CHANGE_NAME_COLLOR(1193),
  TRMNO_TAB_DISPLAY(1194),
  TRMNO_FRONT_SELF_DISPLAY(1195),
  TRMNO_FRONT_SELF_RECEIPT(1196),
  TRMNO_PRF_AMT(1197),
  TRMNO_CHK_RESULT(1198),
  TRMNO_EASY_UI_MODE(1199),
  TRMNO_EXT_PAYMENT_STLDSP(1200),
  TRMNO_EXT_INITIAL_DISP_SIDE(1201),
  TRMNO_VERIFONE_PRINT_NUM(1202),
  TRMNO_PRINT_WMTICKET(1203),
  TRMNO_DISP_ADD_POINT_ITEMNAME(1204),
  TRMNO_WIZ_PWR_STS_BASE(1205),
  TRMNO_EXT_NOTUSE_DISP(1206),
  TRMNO_COLORFIP15_DISPLAY(1207),
  TRMNO_COLORFIP15_UNIT_DESIGN(1208),
  TRMNO_COLORFIP15_STL_DSC_DSP(1209),
  TRMNO_COLORFIP15_STL_QTY_DSP(1210),
  TRMNO_COLORFIP15_DSC_DETAIL_DSP(1211),
  TRMNO_COLORFIP15_MBR_DSP(1212),
  TRMNO_POPUP_SOUND(1213),
  TRMNO_SALESREPO_JMUPS(1214),
  TRMNO_STAFFLIST_DISP(1215),
  TRMNO_STAFFNAME_FLG(1216),
  TRMNO_QC_SLCT_DISP_OTHER_PAY(1217),
  TRMNO_AUTOCHKROFF_AFTERSENDUPDATE_TIME(1218),
  TRMNO_CERTIFICATE_NOTE_PRN(1219),
  TRMNO_CERTIFICATE_CNT_PRN(1220),
  TRMNO_PRCCHK_CERTIFICATE_BTN(1221),
  TRMNO_NOTE_PLU_REG(1222),
  TRMNO_KY_CHA_DIVIDE_KOPT_CRDT(1223),
  TRMNO_COMPLAINT_MESSAGE_DISP(1224),
  TRMNO_TCKTISSU_POINT_1_100TIMES(1225),
  TRMNO_SVS_TCKT_PLU_CD_9DIGIT(1226),
  TRMNO_DS2_GODAI_ITMIFO_PRN(1227),
  TRMNO_NOTE_PLU_PRINT_TYP(1228),
  TRMNO_TAX_RATE_PRN_DEAL(1229),
  TRMNO_TAX_RATE_PRN_CLS(1230),
  TRMNO_RCPTVOID_BDLSTM_SAVE_USE(1231),
  TRMNO_CHECK_MBRCARDMST_USE(1232),
  TRMNO_JMUPS_WAIT_TIME(1233),
  TRMNO_DS2_PRERANK_REFER_TERM(1234),
  TRMNO_DISP_MAINMENU_BTN(1235),
  TRMNO_REBATE_POINTS_PRN(1236),
  TRMNO_CCT_STLAMT_ONLY(1237),
  TRMNO_CCT_ONCE_ONLY(1238),
  TRMNO_DELETE_POINTS_PRN(1239),
  TRMNO_USE_SAME_PNT_CPN(1240),
  TRMNO_USE_SAME_STLDSC_CPN(1241),
  TRMNO_RECEIPT_SPLIT_CHANGE_SIZE(1242),
  TRMNO_VOID_DATE_INPUT(1243),
  TRMNO_CASHLESS_RESTORE_RATE(1244),
  TRMNO_CASHLESS_RESTORE_LIMIT(1245),
  TRMNO_REAL_ITEM_TAX_SET(1246),
  TRMNO_RFM_TAX_INFO(1247),
  TRMNO_LOY_LIMIT_OVER_ALERT(1248),
  TRMNO_CHANGE_MESSAGE_BUTTON(1249),
  TRMNO_OUT_MDLCLS_TAX_AMT(1250),
  TRMNO_OUT_MDLCLS_OUTTAX_NO(1251),
  TRMNO_OUT_MDLCLS_INTAX_NO(1252),
  TRMNO_LOY_AMT_TAX(1253),
  TRMNO_PLU_DIGIT(1254),
  TRMNO_PASTCOMPFILE_KEEP_DATE(1255),
  TRMNO_SYST_RESTART(1256),
  TRMNO_NON_MBR_RCT_CCTPNT_CHG(1257),
  TRMNO_ECS_OVERFLOW_SPACE(1258),
  TRMNO_ECS_OVERFLOWPICK_CONF(1259),
  TRMNO_DPNT_DUALMEMBER(1260),
  TRMNO_DPNT_CLC_UNIT(1261),
  TRMNO_DPNT_UNIT(1262),
  TRMNO_DPNT_CLC_RND(1263),
  TRMNO_DPNT_TAX(1264),
  TRMNO_DPNT_STAMP(1265),
  TRMNO_DPNT_USE(1266),
  TRMNO_DPNT_USE_UNIT(1267),
  TRMNO_DPNT_LLMT_MNY(1268),
  TRMNO_DPNT_MAGN(1269),
  TRMNO_DPNT_LLIMT1(1270),
  TRMNO_DPNT_MAGN1(1271),
  TRMNO_DPNT_LLIMT2(1272),
  TRMNO_DPNT_MAGN2(1273),
  TRMNO_DPNT_DUALMAGN(1274),
  TRMNO_DPNT_PLUPOINT(1275),
  TRMNO_DPNT_CASH_POINT_YPE(1276),
  TRMNO_DPNT_ACNT_POINT_TYP1(1277),
  TRMNO_DPNT_ACNT_POINT_TYP2(1278),
  TRMNO_DPNT_ACNT_POINT_TYP3(1279),
  TRMNO_DPNT_ACNT_POINT_TYP4(1280),
  TRMNO_DPNT_ACNT_POINT_TYP5(1281),
  TRMNO_DPNT_ACNT_POINT_TYP6(1282),
  TRMNO_DPNT_ACNT_POINT_TYP7(1283),
  TRMNO_DPNT_ACNT_POINT_TYP8(1284),
  TRMNO_DPNT_ACNT_POINT_TYP9(1285),
  TRMNO_DPNT_ACNT_POINT_TYP10(1286),
  TRMNO_DPNT_ACNT_POINT_TYP11(1287),
  TRMNO_DPNT_ACNT_POINT_TYP12(1288),
  TRMNO_DPNT_ACNT_POINT_TYP13(1289),
  TRMNO_DPNT_ACNT_POINT_TYP14(1290),
  TRMNO_DPNT_ACNT_POINT_TYP15(1291),
  TRMNO_DPNT_ACNT_POINT_TYP16(1292),
  TRMNO_DPNT_ACNT_POINT_TYP17(1293),
  TRMNO_DPNT_ACNT_POINT_TYP18(1294),
  TRMNO_DPNT_ACNT_POINT_TYP19(1295),
  TRMNO_DPNT_ACNT_POINT_TYP20(1296),
  TRMNO_DPNT_ACNT_POINT_TYP21(1297),
  TRMNO_DPNT_ACNT_POINT_TYP22(1298),
  TRMNO_DPNT_ACNT_POINT_TYP23(1299),
  TRMNO_DPNT_ACNT_POINT_TYP24(1300),
  TRMNO_DPNT_ACNT_POINT_TYP25(1301),
  TRMNO_DPNT_ACNT_POINT_TYP26(1302),
  TRMNO_DPNT_ACNT_POINT_TYP27(1303),
  TRMNO_DPNT_ACNT_POINT_TYP28(1304),
  TRMNO_DPNT_ACNT_POINT_TYP29(1305),
  TRMNO_DPNT_ACNT_POINT_TYP30(1306),
  TRMNO_DPNT_TICKET_POINT_TYP1(1307),
  TRMNO_DPNT_TICKET_POINT_TYP2(1308),
  TRMNO_DPNT_TICKET_POINT_TYP3(1309),
  TRMNO_DPNT_TICKET_POINT_TYP4(1310),
  TRMNO_DPNT_TICKET_POINT_TYP5(1311),
  TRMNO_DPNT_SALE_PLU_POINT_TYP(1312),
  TRMNO_DPNT_SUBT_DCNT_POINT_TYP(1313),
  TRMNO_DPNT_SBS_RBT_POINT_TYP(1314),
  TRMNO_DPNT_STLPLUS_POINT_TYP(1315),
  TRMNO_TS_LGYOUMU_SEND(1316),
  TRMNO_CLS_TRANOUT_TIMEOUT(1319),
  TRMNO_CLS_TERMINAL_REPORT(1320),
  TRMNO_TAXFREE_AMT_CSM_MAX(1321),
  TRMNO_BARCODEPAY_RFDOPRERR_TO_CASH(1322),
  TRMNO_BARCODEPAY_REPORT_DIVIDE(1323),
  TRMNO_PRINT_CLOSE_RECEIPT_FLG(1326),
  TRMNO_ALL_REQUEST_DATE(1327),
  TRMNO_SAG_SBS_MTHD(1328),
  TRMNO_PROM_CUST_KIND(1329),
  TRMNO_STR_CLOSE_DAY(1330),
  TRMNO_TAXFREE_RECEIPT_SAVE(1331),
  TRMNO_SERVER_EXC(1332),
  TRMNO_LESS_20G_WARN_ENTER_AMOUNT(1333),
  TRMNO_MM_SM_TAXFREE_PRICE(1334),
  TRMNO_RPNT_GROUP_ID(1335),
  TRMNO_RPNT_INVEST_REASON_ID(1336),
  TRMNO_RPNT_BONUS_REASON_ID(1337),
  TRMNO_RPNT_USE_REASON_ID(1338),
  TRMNO_RPNT_SERVICE_ID1(1339),
  TRMNO_RPNT_SERVICE_ID2(1340),
  TRMNO_EASY_RPR_DISP(1341),
  TRMNO_DETAIL_NOPRN_SML1(1342),
  TRMNO_DETAIL_NOPRN_SML2(1343),
  TRMNO_DETAIL_NOPRN_SML3(1344),
  TRMNO_DETAIL_NOPRN_SML4(1345),
  TRMNO_DETAIL_NOPRN_SML5(1346),
  TRMNO_DETAIL_NOPRN_SML6(1347),
  TRMNO_DETAIL_NOPRN_SML7(1348),
  TRMNO_DETAIL_NOPRN_SML8(1349),
  TRMNO_DETAIL_NOPRN_SML9(1350),
  TRMNO_DETAIL_NOPRN_SML10(1351),
  TRMNO_DETAIL_NOPRN_SML11(1352),
  TRMNO_DETAIL_NOPRN_SML12(1353),
  TRMNO_WEB3800J_FSELF_CHG(1354),
  TRMNO_DEAL_REPORT_EXCE_OR_DEFI_PRN(1355),
  TRMNO_RPNT_DUAL_FLG(1356),
  TRMNO_RPNT_USE_KEY(1357),
  TRMNO_LOY_HIGH_MAGN_PRIORITY(1358),
  TRMNO_SCRAP_MODE_PLU_SCH(1359),
  TRMNO_TS_G3_PRESET(1360),
  TRMNO_LIQR_STAFF_CHK(1361),
  TRMNO_TAX_SET_ORDER(1362),
  TRMNO_MM_SM_LIQRAMT_DSC(1363),
  TRMNO_PROM_CPN_PRN_ORDR(1364),
  TRMNO_CRDT_INFO_ORDER(1365),
  TRMNO_IH_MBR_SELF_FLG(1366),
  TRMNO_TPNT_SELF_FLG(1367),
  TRMNO_TPNT_ALLIANCE_CD(1368),
  TRMNO_TPNT_BIZ_CD(1369),
  TRMNO_TPNT_USE_KEY(1370),
  TRMNO_EASY_PRC_DISP_BEEP(1371),
  TRMNO_DPNT_AMTCLC_RND(1372),
  TRMNO_SCALERM_FROATING_MAC_NO(1373),
  TRMNO_PLU_SELECT_JUMP_PRESET(1374),
  TRMNO_JUMP_PRESET_GRP(1375),
  TRMNO_JUMP_PRESET_PAGE(1376),
  TRMNO_SCALERM_FROATING_CHK_TIME(1377),
  TRMNO_SCALERM_FROATING_ITEM_MAX(1378),
  TRMNO_SCALERM_STL_20G_OVER_REGS(1379),
  TRMNO_ITEM_DISP_JANCD(1380),
  TRMNO_MULTI_BTN(1381),
  TRMNO_STRCLS_REPORT(1382),
  TRMNO_TAKARA_RCPT_LAYOUT_CHG(1383),
  TRMNO_HI_TOUCH_MAC_NO(1384),
  TRMNO_HI_TOUCH_PLU_DISP_TIME(1385),
  TRMNO_HI_TOUCH_RCV_CHK_TIME(1386),
  TRMNO_WSCPN_LIMIT_PRICE(1387),
  TRMNO_WSCPN_LIMIT_DISC(1388),
  TRMNO_WSCPN_LIMIT_POINT_ADD(1389),
  TRMNO_WSCPN_LIMIT_POINT_MAG(1390),
  TRMNO_TPNT_SELF_CPN_DSP(1391),
  TRMNO_TPNT_EJ_ID_MSK(1392),
  TRMNO_OTHER_COMPANY_QR(1393),
  TRMNO_BDLPLU_CLSDSC_FLG(1394),
  TRMNO_CLSREG_CLSDSC_FLG(1395),
  TRMNO_DSCPLU_BDL_FLG(1396),
  TRMNO_CHGPRCPLU_BDL_FLG(1397),
  TRMNO_SCREG_CONTTRADE_FLG(1398),
  TRMNO_FRONT_SELF_MBRSCAN_FLG(1399),
  TRMNO_WSCPN_REF_FLG(1400),
  TRMNO_UNITECPN_STAFF_CALL_FLG(1407),
  TRMNO_UNITECPN_DSP_FLG(1408),
  TRMNO_VENDING_MACHINE(1411),
  TRMNO_USE_RECEIPT_REFUND(1412),
  TRMNO_TAXCHG_WGTBERCODE(1413),
  TRMNO_STL_TAXINFO_PRN(1416),
  TRMNO_FSELF_CASH_SPLIT(1417),
  TRMNO_FSELF_NOTAX_PRN(1418),
  TRMNO_FSELF_BARCODE_PAY_CONF_DSP(1419),
  TRMNO_FSELF_CSS_USER_PROC(1420),
  TRMNO_FSELF_NW7_STAFF_FLG(1421),
  TRMNO_USER_CD1(1422),
  TRMNO_USER_CD2(1423),
  TRMNO_USER_CD4(1424),
  TRMNO_USER_CD31(1425),
  TRMNO_USER_CD38(1426),
  TRMNO_fil92(1427),
  TRMNO_USER_CD36(1428),
  TRMNO_EXT_MBR_SVR_COM(1431),
  TRMNO_WEB_AND_RM_NETWORK(1436),
  TRMNO_ARCS_COMP_FLG(1324);

  final int trmCd;
  const TrmCdList(this.trmCd);

  static TrmCdList getDefine(int cd) {
    TrmCdList def = TrmCdList.values.firstWhere((element) {
      return element.trmCd == cd;
    }, orElse: () => TrmCdList.TRMNO_WRNG_NONE);
    return def;
  }
}
