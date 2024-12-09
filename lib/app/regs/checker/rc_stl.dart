/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_calc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemcard.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/db/c_item_log.dart';
import '../../inc/db/c_itemlog_sts.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_elog.dart';
import 'rc_mbr_com.dart';
import 'rc_mcd.dart';
import 'rc_set.dart';
import 'rc_stl_cal.dart';
import 'rc_vfhd_fself.dart';
import 'rccatalina.dart';
import 'rcfncchk.dart';
import 'rcky_eref.dart';
import 'rcky_spdsp.dart';
import 'rcmbrkymbr.dart';
import 'rcmbrpmanual.dart';
import 'rcpromotion.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

///関連tprxソース:rcstl.h - CLR_TTLRBUF構造体
enum ClrTtlRBuf {
  NCLR_TTLRBUF_ALL,   /* all clear */
  NCLR_TTLRBUF_MBR,   /* all clear remove member */
  NCLR_TTLRBUF_STL;   /* subtotal calculation portion clear */
}

///関連tprxソース:rcstl.h - enum CLR_TTLRBUF_MBR
enum ClrTtlRBufMbr {
  NCLR_TTLRBUF_MBR_ALL,    /* all clear                            */
  NCLR_TTLRBUF_MBR_KIND,    /* clear except MEMBER UPDATE KIND data */
  NCLR_TTLRBUF_MBR_MAN,    /* clear except manual input data       */
  NCLR_TTLRBUF_MBR_STL,    /* clear to calculate subtotal          */
  NCLR_TTLRBUF_MBR_MCD,    /* clear magnetic card input            */
}

class RcStl {
  static const STLCALC_NORMAL = 0x0000;  /* normal                     */
  static const STLCALC_INC_MBRRBT = 0x0001;  /* include Member Auto-Rebate */
  static const STLCALC_EXC_CUST = 0x0002;  /* Exclude Cust               */
  static const STLCALC_INC_CUST = 0x0003;  /* Include Cust(Dept,Mg,Plu)  */

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcstl.c - rcClr_TtlRBuf
  static void rcClrTtlRBuf(ClrTtlRBuf eCtrl) {
    return;
  }

  /// 会員データを消去する
  /// 引数: 消去するデータの範囲
  /// 関連tprxソース:rcstl.c - rcClr_TtlRBuf_Mbr
  static Future<void> rcClrTtlRBufMbr(ClrTtlRBufMbr eCtrl) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcStl.rcClrTtlRBufMbr(): rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    
    // データの退避処理
    TTtlLog bkupTtl = mem.tTtllog;

    int i = 0;
    switch (eCtrl) {
      case ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_ALL:   /* all clear */
        cMem.custData = CustData();
        mem.tTtllog.t102000.mbrgncustQty = 0;
        mem.tTtllog.t102000.mbrgnDscAmt = 0;
        if (cBuf.dbTrm.spprcGetTaxamt != 0) {
          mem.tTtllog.calcData.bgPchgQty = 0;
        }
        mem.tTtllog.t103000.mpricustQty = 0;
        mem.tTtllog.t103000.mpriDscAmt = 0;
        mem.tHeader.cust_no = "";
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem() &&
              (mem.tTtllog.t100700.mbrInput != MbrInputType.mbrprcKeyInput.index)) {
            await RcMcd.rcRalseMcdCrdtRegClr();
          }
        }
        mem.tTtllog.calcData.tMsppointPrn = "";
        mem.tTtllog.t100011.errcd = "";
        mem.tTtllog.t100011.cardData = "";
        mem.tTtllog.t100800.fspCd = 0;
        mem.tTtllog.t100001Sts.msRbtMbr = 0;
        mem.tTtllog.t100001Sts.fspMbr = 0;
        mem.tTtllog.calcData.dsalTtlpur = 0;
        mem.tTtllog.calcData.dwotTtlpur = 0;
        mem.tTtllog.calcData.nsalTtlpur = 0;
        mem.tTtllog.calcData.nsaqTtlpur = 0;
        mem.tTtllog.calcData.tpptTtlsrv = 0;
        mem.tTtllog.calcData.lpptTtlsrv = 0;
        mem.tTtllog.calcData.duppTtlrv = 0;
        mem.tTtllog.calcData.nextTtlsrv = 0;
        mem.tTtllog.t100800.lcauFsppur = 0;
        mem.tTtllog.t100800.tcauFsppur = 0;
        mem.tTtllog.calcData.dqtyFsppur = 0;
        mem.tTtllog.calcData.damtFsppur = 0;
        mem.tTtllog.calcData.dperFsppdsc = 0;
        mem.tTtllog.calcData.dqtyFsppdsc = 0;
        mem.tTtllog.calcData.dpurFsppdsc = 0;
        mem.tTtllog.calcData.daddFsppnt = 0;
        mem.tTtllog.calcData.dtdqMulcls = 0;
        mem.tTtllog.calcData.dtdaMulcls = 0;
        mem.tTtllog.calcData.ddsqMulcls = 0;
        mem.tTtllog.calcData.ddsaMulcls = 0;
        mem.tTtllog.calcData.dpdqMulcls = 0;
        mem.tTtllog.calcData.dpdaMulcls = 0;
        mem.tTtllog.calcData.dsdqMulcls = 0;
        mem.tTtllog.calcData.dsdaMulcls = 0;
        mem.tTtllog.calcData.dspqMulcls = 0;
        mem.tTtllog.t101100.dsltAddpnt = 0;
        mem.tTtllog.t101100.dslgAddpnt = 0;
        mem.tTtllog.t101100.dsptAddpnt = 0;
        mem.tTtllog.t101100.dpurAddpnt = 0;
        mem.tTtllog.t101100.dptqAddpnt = 0;
        mem.tTtllog.t101100.dpurAddmul = 0;
        mem.tTtllog.calcData.dctrbPoint = 0;
        mem.tTtllog.calcData.tctrbPoint = 0;
        mem.tTtllog.t100900.issueDate = "";
        mem.tTtllog.t100900.cpnUseDate = "";
        mem.tTtllog.t100900.termChgAmt = 0;
        mem.tTtllog.t100900.lastRbtDate = "";
        mem.tTtllog.calcData.pluPointTtl = 0;
        mem.tTtllog.t100900.nrmlPointCust = 0;
        mem.tTtllog.t100900.nrmlPoint = 0;
        mem.tTtllog.t100900.spPointCust = 0;
        mem.tTtllog.t100900.spPoint = 0;
        mem.tTtllog.t100900.cardIssueSht = 0;
        mem.tTtllog.calcData.stampCustTyp1 = 0;
        mem.tTtllog.calcData.stampPointTyp1 = 0;
        mem.tTtllog.calcData.stampCustTyp2 = 0;
        mem.tTtllog.calcData.stampPointTyp2 = 0;
        mem.tTtllog.calcData.stampCustTyp3 = 0;
        mem.tTtllog.calcData.stampPointTyp3 = 0;
        mem.tTtllog.calcData.stampCustTyp4 = 0;
        mem.tTtllog.calcData.stampPointTyp4 = 0;
        mem.tTtllog.calcData.stampCustTyp5 = 0;
        mem.tTtllog.calcData.stampPointTyp5 = 0;
        mem.tTtllog.t100900.thisSvsNo = 0;
        mem.tTtllog.t100900.lastChgPayout = "";
        mem.tTtllog.t100900.lastHesoPayout = "";
        mem.tTtllog.t100900.vmcStkacv = 0;
        mem.tTtllog.calcData.mbrDiscAmt = 0;
        mem.tTtllog.t100900Sts.rwTyp = 0;
        mem.tTtllog.t100900.vmcChgAmt = 0;
        mem.tTtllog.t100900.todayChgamt = 0;
        mem.tTtllog.t100900.totalChgamt = 0;
        if (!RcSysChk.rcChkIntaxDscSystem()) {
          mem.tTtllog.t100900.lastChgamt = 0;
        }
        mem.tTtllog.t100900.vmcChgCnt = 0;
        mem.tTtllog.t100900.vmcHesotcktCnt = 0;
        mem.tTtllog.t100900.vmcHesoCnt = 0;
        for (i=0; i < CntList.promMax; i++) {
          mem.tTtllog.t101000[i].promTicketNo = 0;
        }
        mem.tTtllog.t101000[0].promTicketQty = 0;
        mem.tTtllog.calcData.pluPointQty = 0;
        mem.tTtllog.calcData.pluPointAmt = 0;
        if (!(CompileFlag.DEPARTMENT_STORE &&
            (await CmCksys.cmDepartmentStoreSystem() != 0))) {
          mem.tTtllog.t100800.dcauFsppur = 0;
          mem.tTtllog.t100800.dexpFsppur = 0;
          mem.tTtllog.calcData.dqtyFsppur = 0;
          mem.tTtllog.t100001Sts.chrgFlg = 0;
          mem.tTtllog.t100900.vmcStkhesoacv = 0;
          mem.tTtllog.t100900.vmcChgtcktCnt = 0;
          mem.tTtllog.t100900.vmcHesoAmt = 0;
          mem.tTtllog.t100900.todayHesoamt = 0;
          mem.tTtllog.t100900.totalHesoamt = 0;
          mem.tTtllog.t100900.lastHesoamt = 0;
        }
        if (CompileFlag.SAPPORO) {
          if (!(await RcSysChk.rcChkEdySystem())
              && (RcSysChk.rcChkMultiEdySystem() == 0)
              && (await RcSysChk.rcChkJklPanaSystem())) {
            mem.tTtllog.t100100[0].edyCd = "";
          }
          if (await CmCksys.cmRainbowCardSystem() != 0) {
            mem.tTtllog.t100002.custCd = 0;
          }
        }
        if (CompileFlag.RALSE_CREDIT) {
          mem.tmpbuf.rcarddata = RxMemCard();
        }
        if (await CmCksys.cmSpDepartmentSystem() != 0) {
          mem.tTtllog.t101000[4].promDscFlg = 0;
        }
        if (!CompileFlag.MC_SYSTEM) {
          if (await RcSysChk.rcChkCardFeeSystem()) {
            mem.tTtllog.t100001.validDate = "";
          }
        }
        for (i=0; i < AmtKind.amtMax.index; i++) {
          mem.tTtllog.t100200[i].kyCd = 0;
          mem.tTtllog.t100200[i].residualAmt = 0;
        }
        mem.tTtllog.calcData.otherStCust = 0;
        mem.tTtllog.calcData.otherStAmt = 0;
        mem.tTtllog.calcData.otherStQty = 0;
        mem.tTtllog.t100800Sts.fspLvlTicket = 0;
        mem.tTtllog.t100001Sts.offlineFlg = 0;
        mem.tTtllog.t100001Sts.bsOfflineFlg = 0;
        if (await CmCksys.cmDcmpointSystem() != 0) {
          cMem.working.crdtReg = CrdtReg();
        }
        await rcClrStampProm();
        if (RcSysChk.rcChkMbrRCPdscSystem()) {
          RcMbrCom.rcMbrMemberClsPDscSet();
        }
        if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
          tsBuf.custreal2 = RxTaskstatCustreal2();
          atSing.beforeStlAmt = 0;
          mem.prnrBuf.cardStopKind = 0;
        }
        if (RcSysChk.rcChkCustrealOPSystem()) {
          tsBuf.custreal2 = RxTaskstatCustreal2();
          mem.tTtllog.t100011Sts.beforeYearPoint = 0;
          mem.tTtllog.t100011Sts.addLimitDate = "";
          mem.tTtllog.t100011Sts.useLimitDate = "";
        }
        if ((await RcSysChk.rcCheckWatariCardSystem())
            || (await CmCksys.cmNimocaPointSystem() != 0)) {
          mem.tTtllog.t100010.invoiceNo = "";
        }
        if (RcSysChk.rcChkTpointSystem() != 0) {
          mem.tTtllog.t100002.cpnAmt2 = 0;	// TBD-TPOINT-V1StdCust
        }
        if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
          mem.tTtllog.t100750 = T100750();
        }
        if (RcSysChk.rcChkCustrealFrestaSystem()) {
          /* 顧客リアル[フレスタ]仕様チェック */
          // TODO:10155 顧客呼出 実装対象外（仕様対象外）
          /*
          tsBuf.fresta = Fresta();
          mem.tTtllog.t100905 = T100905();
          mem.frestaCpn = "";
          mem.frestaLoy = "";
          rcrealsvr_Fresta_MbrData_Flag_Reset();
           */
        }
        if (RcSysChk.rcsyschkYunaitoHdSystem() != 0) {
          mem.tTtllog.t100017.externalPtsUpdFlg = 0;
          mem.tTtllog.t100017Sts.externalPoints = 0;
          mem.tTtllog.t100017Sts.externalPtsPrnFlg = 0;
        }
        if (RcSysChk.rcsyschkSm55TakayanagiSystem != 0) {
          mem.tTtllog.t100017.pntachiCnt = 0;
        }
        if (RcSysChk.rcChkReceivBarcodeTyp() == 1) {
          mem.tTtllog.t100017.creditNo = "";
          mem.tTtllog.t100017.creditName = "";
        }
        int joinFeeAmtBak = 0;
        if (RcSysChk.rcChkIntaxDscSystem()) {
          joinFeeAmtBak = mem.tTtllog.t100702.joinFeeAmt - mem.tTtllog.t100702.joinFeeCust;
        }
        if (RcSysChk.rcChkCosme1IstyleSystem()) {
          // アイスタイルリテイル様[特定コスメ1仕様]
          // TODO:10155 顧客呼出 - 仕様対象外
          /*
          mem.tTtllog.t100700.realCustsrvFlg = 0;
          mem.tTtllog.t100765 = T100765();
          mem.tTtllog.t100766 = T100766();
          mem.tTtllog.t100765Sts = T100765Sts();
          mem.tTtllog.t100766Sts = T100766Sts();
           */
        }
        mem.tTtllog.t100001Sts.reflectCnt = 0;
        mem.tTtllog.t100001Sts.acntCnt = 0;
        mem.tTtllog.t100001Sts.zCpnCnt = 0;
        mem.tTtllog.t100700 = T100700();
        mem.tTtllog.t100700Sts = T100700Sts();
        mem.tTtllog.t100701 = T100701();
        mem.tTtllog.t100701Sts = T100701Sts();
        mem.tTtllog.t100702 = T100702();
        mem.tTtllog.t100702Sts = T100702Sts();
        mem.tTtllog.t106500 = List.generate(CntList.othPromMax, (_) => T106500());
        mem.tTtllog.t106500Sts = List.generate(CntList.othPromMax, (_) => T106500Sts());
        mem.tTtllog.t107000 = List.generate(CntList.acntMax, (_) => T107000());
        mem.tTtllog.t107000Sts = List.generate(CntList.acntMax, (_) => T107000Sts());
        mem.tTtllog.t102500Sts = List.generate(CntList.promMax, (_) => T102500Sts());
        mem.tTtllog.t102501 = T102501();
        mem.tTtllog.t102501Sts = T102501Sts();
        mem.tTtllog.calcData.lastVisitFlg = 0;
        for (i=0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
          mem.tItemLog[i].t11300 = List.generate(CntList.acntMax, (_) => T11300());
          mem.tItemLog[i].t11300Sts = List.generate(CntList.acntMax, (_) => T11300Sts());
        }
        if (mem.tTtllog.t100001Sts.itemlogCnt == 0) {
          mem.tTtllog.t100001Sts.loyPromTtlCnt = 0;
          mem.tTtllog.t100001Sts.cpnTtlCnt = 0;
          mem.tTtllog.t106000 = List.generate(CntList.loyPromTtlMax, (_) => T106000());
          mem.tTtllog.t106000Sts = List.generate(CntList.loyPromTtlMax, (_) => T106000Sts());
          mem.tTtllog.t106501 = List.generate(CntList.othPromMax, (_) => T106501());
          mem.tTtllog.t106501Sts = List.generate(CntList.othPromMax, (_) => T106501Sts());
          for (i=0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
            mem.tItemLog[i].t10000Sts.loyPromItemCnt = 0;
             mem.tItemLog[i].t10000Sts.loyCondItemCnt = 0;
             mem.tItemLog[i].t10000Sts.cpnCondItemCnt = 0;
             mem.tItemLog[i].t11200 = List.generate(CntList.loyPromItmMax, (_) => T11200());
             mem.tItemLog[i].t11200Sts = List.generate(CntList.loyPromItmMax, (_) => T11200Sts());
             mem.tItemLog[i].t11210Sts = List.generate(CntList.loyPromItmMax, (_) => T11210Sts());
             mem.tItemLog[i].t11211Sts = List.generate(CntList.othPromMax, (_) => T11211Sts());
          }
        }
        else if (await CmCksys.cmWsSystem() != 0) {
          // TODO:10155 顧客呼出 - 仕様対象外
          /*
          RcPromotion.rcClrLoyCpnMem();	// ロイヤリティとクーポンのメモリクリア
          rcNoMbrRead_OneToOnePromotion();	// 全員向けロイヤリティ読込(非会員という会員対象のプロモーションがあるため)
          rcmbrRead_OneToOnePromotion_PLU(PROMREAD_ALL_ITEM);	// 登録済みアイテムに対してプロモーション適用
           */
        }
        else {
          await RcPromotion.rcClrOneToOneMbrData(POINT_TYPE.PNTTYPE_HOUSEPOINT);
        }
        // 会員取消が実行された時スタンプカード関連のクリア処理を実行
        mem.tTtllog.t100001Sts.stpTtlCnt = 0;  // スタンプカード段数をクリア
        mem.tTtllog.t106100 = List.generate(CntList.othPromMax, (_) => T106100());
        mem.tTtllog.t106100Sts = List.generate(CntList.othPromMax, (_) => T106100Sts());
        for (i=0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
          mem.tItemLog[i].t10000Sts.stpCondItemCnt = 0;  //スタンプカード条件段数をクリア
          mem.tItemLog[i].t11212Sts = List.generate(CntList.othPromMax, (_) => T11212Sts());
        }
        if (( (await RcSysChk.rcChkPointCardSystem()) ||
            (await RcSysChk.rcChkPharmacySystem()) ||
            (cBuf.dbTrm.custprcKeyChg != 0) )
            && (cBuf.dbTrm.custPriceKeyonly != 0) ) {
          mem.tTtllog.t100700Sts.mbrPrcFlg  = bkupTtl.t100700Sts.mbrPrcFlg;
        }
        mem.tTtllog.t100700Sts.mbrPrcFlgBk = bkupTtl.t100700Sts.mbrPrcFlgBk;
        // 会員呼出時に割戻チケット印字対応
        mem.prnrBuf.mbrCallSvctk.mbrcallSvctkFlg = 0;
        mem.prnrBuf.mbrCallSvctk.dtipTtlsrv = 0;
        if (RcSysChk.rcChkIntaxDscSystem()) {
          mem.tTtllog.t100702.joinFeeAmt = joinFeeAmtBak;
        }
        if (RcSysChk.rcsyschkFselfMbrscan2ndScannerUse() != 0) {
          // 対面スキャナ会員読取関連のメモリをクリア
          RcVfhdFself.rcVFHDFselfMbrScanStatusClear(0, 0);
        }
        if (cBuf.dbTrm.otherCompanyQr == 1) {
          mem.tTtllog.t100900.vmcHesoCnt = bkupTtl.t100900.vmcHesoCnt;
        }
        if (Rcmbrkymbr.rcAfterPrecaOnceMbrTypeChk() != 0) {
          await Rcmbrkymbr.rcAfterPrecaOnceMbrReset();
        }
        if (RcSysChk.rcChkSm74OzekiSystem()) {
          // TODO:10155 顧客呼出 - 仕様対象外
          /*
          mem.ozekiCustRank = "";
           */
        }
        break;
      case ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_KIND:  /* clear except MEMBER UPDATE KIND data */
      case ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_MAN:   /* clear except NCLR_MBR_KIND & manual input data */
      case ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_STL:   /* clear to calculate subtotal */
      case ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_MCD:   /* Mcd Name clear */
        break;
      default:
        break;
    }
  }

  /// PROMデータを消去する
  /// 関連tprxソース:rcstl.c - rcClr_Stamp_Prom
  static Future<void> rcClrStampProm() async {
    if (CompileFlag.PROM && !(await RcSysChk.rcChkPromSystem())) {
      return;
    }

    int i = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    if (mem.tTtllog.calcData.stampPointTyp1 == 0) {
      for (i=0; i < CntList.promMax; i++) {
        if (mem.tTtllog.t101000[i].promDscFlg == 14) {
          mem.tTtllog.t101000[i].promCd = 0;
          mem.tTtllog.t101000[i].promDscFlg = 0;
          mem.tTtllog.t101000[i].promDscCd = 0;
          mem.tTtllog.t101000[i].promDscPrc = 0;
        }
      }
    }
    if (mem.tTtllog.calcData.stampPointTyp2 == 0) {
      for (i=0; i < CntList.promMax; i++) {
        if (mem.tTtllog.t101000[i].promDscFlg == 54) {
          mem.tTtllog.t101000[i].promCd = 0;
          mem.tTtllog.t101000[i].promDscFlg = 0;
          mem.tTtllog.t101000[i].promDscCd = 0;
          mem.tTtllog.t101000[i].promDscPrc = 0;
        }
      }
    }
    if (mem.tTtllog.calcData.stampPointTyp3 == 0) {
      for (i=0; i < CntList.promMax; i++) {
        if (mem.tTtllog.t101000[i].promDscFlg == 64) {
          mem.tTtllog.t101000[i].promCd = 0;
          mem.tTtllog.t101000[i].promDscFlg = 0;
          mem.tTtllog.t101000[i].promDscCd = 0;
          mem.tTtllog.t101000[i].promDscPrc = 0;
        }
      }
    }
    if (mem.tTtllog.calcData.stampPointTyp4 == 0) {
      for (i=0; i < CntList.promMax; i++) {
        if (mem.tTtllog.t101000[i].promDscFlg == 74) {
          mem.tTtllog.t101000[i].promCd = 0;
          mem.tTtllog.t101000[i].promDscFlg = 0;
          mem.tTtllog.t101000[i].promDscCd = 0;
          mem.tTtllog.t101000[i].promDscPrc = 0;
        }
      }
    }
    if (mem.tTtllog.calcData.stampPointTyp5 == 0) {
      for (i=0; i < CntList.promMax; i++) {
        if (mem.tTtllog.t101000[i].promDscFlg == 84) {
          mem.tTtllog.t101000[i].promCd = 0;
          mem.tTtllog.t101000[i].promDscFlg = 0;
          mem.tTtllog.t101000[i].promDscCd = 0;
          mem.tTtllog.t101000[i].promDscPrc = 0;
        }
      }
    }
  }


  /// 期間売変もしくはマークダウンか判定する
  /// 関連tprxソース:rcstl.c - rcChk_ItmRBuf_TermBrgnTyp(long p)
  static bool rcChkItmRBufTermBrgnTyp(int p) {
    if (p < 0) {
      return false;
    }
    return ((RegsMem().tItemLog[p].t10100.brgnTyp == 1) ||	//期間売変
        (RegsMem().tItemLog[p].t10100.brgnTyp == 2));	//マークダウン
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_Void(long p)
  static bool rcChkItmRBufVoid(int p){
    RegsMem regsMem = SystemFunc.readRegsMem();
    if(p < 0){
      return false;
    }
    return (regsMem.tItemLog[p].t10000Sts.voidFlg != 0);
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_ScrVoid(long p)
  static bool rcChkItmRBufScrVoid(int p){
    RegsMem regsMem = SystemFunc.readRegsMem();
    if(p < 0){
      return false;
    }
    return (regsMem.tItemLog[p].t10002Sts.scrvoidFlg);
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_Dsc(long p)
  static bool rcChkItmRBufDsc(int p) {
    RegsMem regsMem = SystemFunc.readRegsMem();
    if(p < 0){
      return false;
    }
    return (regsMem.tItemLog[p].t10200.itemDscCd != 0);
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_Pm(long p)
  static bool rcChkItmRBufPm(int p) {
    RegsMem regsMem = SystemFunc.readRegsMem();
    if(p < 0){
      return false;
    }
    return (regsMem.tItemLog[p].t10300.itemPdscCd != 0);
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_StlDsc(long p)
  static bool rcChkItmRBufStlDsc(int p){
    if(p < 0){
      return false;
    }
    return ((RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_DSC1.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_DSC2.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_DSC3.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_DSC4.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_DSC5.keyId));
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_StlPm(long p)
  static bool rcChkItmRBufStlPm(int p){
    if(p < 0){
      return false;
    }
    return ((RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_PM1.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_PM2.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_PM3.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_PM4.keyId)
        || (RegsMem().tItemLog[p].t50100.stldscCd == FuncKey.KY_PM5.keyId));
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_NotePlu(long p)
  static bool rcChkItmRBufNotePlu(int p) {
    if(p < 0){
      return false;
    }
    return (((RegsMem().tItemLog[p].t10003.recMthdFlg >= REC_MTHD_FLG_LIST.NOTE_REC_CHA1.typeCd)
        && (RegsMem().tItemLog[p].t10003.recMthdFlg <= REC_MTHD_FLG_LIST.NOTE_REC_CHK5.typeCd))
        || ((RegsMem().tItemLog[p].t10003.recMthdFlg >= REC_MTHD_FLG_LIST.NOTE_REC_CHA11.typeCd)
            && (RegsMem().tItemLog[p].t10003.recMthdFlg <= REC_MTHD_FLG_LIST.NOTE_REC_CHA30.typeCd)));
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_StlPlus(long p)
  static bool rcChkItmRBufStlPlus(int p) {
    if(p < 0){
      return false;
    }
    return (RegsMem().tItemLog[p].t50300.stlplusCd != 0);
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_Catalina(long p)
  static bool rcChkItmRBufCatalina(int p) {
    if(p < 0){
      return false;
    }
    return ((RcCatalina.cmCatalinaSystem(0))&&
        (RegsMem().tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.CATALINA_REC.typeCd));
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_CatalinaStlDsc(long p)
  static bool rcChkItmRBufCatalinaStlDsc(int p) {
    if(p < 0){
      return false;
    }
    return ((RcCatalina.cmCatalinaSystem(0))&&
        (RegsMem().tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.CATALINA_STLDSC_REC.typeCd));
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_CatalinaStlPm(long p)
  static bool rcChkItmRBufCatalinaStlPm(int p) {
    if(p < 0){
      return false;
    }
    return ((RcCatalina.cmCatalinaSystem(0))&&
        (RegsMem().tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.CATALINA_STLPDSC_REC.typeCd));
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_BarStlDsc(long p)
  static bool rcChkItmRBufBarStlDsc(int p) {
    if(p < 0){
      return false;
    }
    return (RegsMem().tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.BARCODE_STLDSC_REC.typeCd);
  }

  ///関連tprxソース:rcstl.c - rcChk_ItmRBuf_BarStlPm(long p)
  static bool rcChkItmRBufBarStlPm(int p) {
    if(p < 0){
      return false;
    }
    return ((RegsMem().tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.BARCODE_STLPDSC_REC.typeCd)
        || (RegsMem().tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.BARCODE_MEMBER_STLPDSC_REC.typeCd));
  }

  /// 明細レコードが生鮮ZFSPバーコード情報であるかチェックする
  /// 引数:[p] 商品リストの対象インデックスNo
  /// 戻値: false=上記データでない  true=上記データ
  ///  関連tprxソース: rcstfip.c - rcChk_ItmRBuf_ZFSP_point_Rec
  static bool rcChkItmRBufZFSPPointRec(int p) {
    if (p < 0) {
      return false;
    }
    RegsMem mem = SystemFunc.readRegsMem();
    return (mem.tItemLog[p].t10003.recMthdFlg ==
        REC_MTHD_FLG_LIST.ZFSP_POINT_REC.typeCd);
  }

  ///  関連tprxソース: rcstfip.c - rcNotDeptTaxCalCheck
  static bool rcNotDeptTaxCalCheck() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return ((cBuf.dbTrm.outMdlclsTaxAmt != 0) &&
        (cBuf.dbTrm.outMdlclsOuttaxNo != 0) &&
        (cBuf.dbTrm.outMdlclsIntaxNo != 0));
  }

  /// スタンプ＆リベートアイテムログをクリアする
  /// 引数: スタンプ＆リベートレコード更新フラグ
  /// 関連tprxソース:rcstl.c - rcClrItem_MbrData
  static void rcClrItmMbrData(int flg) {
    RegsMem mem = SystemFunc.readRegsMem();

    for (int p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
      if (RcPromotion.rcClrPromBarcodeRec(p, POINT_TYPE.PNTTYPE_HOUSEPOINT) ==
          0) {
        continue;
      }
      if (RcMbrpManual.rcmbrChkItmRBufRbt(p) ||
          ((flg == 0) && CalcMMSTMSchDBRd.rcManualStampCodeCheck(p))) {
        mem.tItemLog[p].t11100Sts.mCancel =
        1; /* Flag Set for Stamp & Rbt record */
        mem.tItemLog[p].t50400?.stampCust = 0; /* Stamp cust Clr */
      }
      if ((flg == 0) && rcChkItmRBufZFSPPointRec(p)) {
        mem.tItemLog[p].t11100Sts.mCancel = 1;
        mem.tItemLog[p].t10002.scrvoidFlg = true;
      }
      if (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 0) {
        if ((mem.tItemLog[p].t10400.itemPrcChgFlg == 0) ||
            ((mem.tItemLog[p].t10400.itemPrcChgFlg != 0) &&
                (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 3) &&
                (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 4) &&
                (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 7) &&
                (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 8) &&
                (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 103) &&
                (mem.tItemLog[p].t11100Sts.mbrcnclDscflg != 104))) {
          mem.tItemLog[p].t10500.clsDscFlg =
              mem.tItemLog[p].t11100Sts.mbrcnclDscflg;
        }
        mem.tItemLog[p].t11100Sts.mbrcnclDscflg = 0; /* keep flg Reset */
      }
      if (mem.tItemLog[p].t11100Sts.mbrInput != MbrInputType.nonInput.index) {
        /* itemlog mbr_input Clr */
        mem.tItemLog[p].t11100Sts.mbrInput = MbrInputType.nonInput.index;
      }
      if ((mem.tItemLog[p].t10400.itemPrcChgFlg != 0) &&
          RcFncChk.rcCheckPriceChangeDisc()) {
        if (mem.tItemLog[p].t10400.itemPrcChgFlg == 2) {
          /* itemlog mbr_input Clr */
          mem.tItemLog[p].t10400.itemPrcChgFlg = 1;
        }
        if (CompileFlag.DISC_BARCODE) {
          if (mem.tItemLog[p].t10400.itemPrcChgFlg == 4) {
            /* itemlog mbr_input Clr */
            mem.tItemLog[p].t10400.itemPrcChgFlg = 3;
          }
        }
      }
    }
    /* ttl_log set */
    mem.tTtllog.t100001Sts.mbrcnclFlg = 1; /* Mbrcncl flg Set */
  }

  /// 明細レコードがプロモーションバーコード情報だったら 真を返す
  /// 引数: アイテムログ段数
  /// 戻り値: true=上記情報  false=上記情報でない
  /// 関連tprxソース:rcstl.c - rcChk_ItmRBuf_PromBarcode_Rec
  static bool rcChkItmRBufPromBarcodeRec(int p) {
    if (p < 0) {
      return false;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    return (mem.tItemLog[p].t10003.recMthdFlg ==
        REC_MTHD_FLG_LIST.ONETOONE_BARCODE_REC.typeCd);
  }

  /// 引数: 画面コード
  /// 関連tprxソース:rcstl.c - rcSprit_Cncl
  static Future<void> rcSpritCncl(int imgCd) async {
    AcMem cMem = SystemFunc.readAcMem();
    if ((RcSysChk.rcChkCustrealUIDSystem() != 0) &&
        (cMem.stat.fncCode != FuncKey.KY_MBRCLR.keyId) &&
        (imgCd == ImageDefinitions.IMG_CNCLCONF_MBR2)) {
      return;
    }
    if (RcSysChk.rcChkCustrealOPSystem()) {
      if ((cMem.stat.fncCode != FuncKey.KY_CNCL.keyId) &&
          (imgCd == ImageDefinitions.IMG_CNCLEND)) {
        return;
      } else if ((cMem.stat.fncCode != FuncKey.KY_MBRCLR.keyId) &&
          (imgCd == ImageDefinitions.IMG_CNCLCONF_MBR2)) {
        return;
      }
    }
    if ((RcSysChk.rcChkCustrealPointartistSystem() != 0) &&
        (cMem.stat.fncCode != FuncKey.KY_MBRCLR.keyId) &&
        (imgCd == ImageDefinitions.IMG_CNCLCONF_MBR2)) {
      return;
    }
    if (RcSysChk.rcChkReceivBarcodeTyp() == 1) {
      if (imgCd == ImageDefinitions.IMG_CNCLCONF_MBR2) {
        imgCd = ImageDefinitions.IMG_CNCLCONF_RECEIV;
      }
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        if (RcFncChk.rcCheckSpritMode() &&
            ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
                (await RcSysChk.rcCheckQCJCSystem()))) {
          RckySpDsp.rcSPCncelDspPrg(imgCd);
          return;
        }
        RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.subttl);
        break;
      case RcRegs.KY_SINGLE:
        if (FbInit.subinitMainSingleSpecialChk()) {
          if (RcFncChk.rcCheckSpritMode()) {
            RckySpDsp.rcSPCncelDspPrg(imgCd);
            return;
          }
        }
        if ((await RcFncChk.rcCheckERefSMode()) ||
            (await RcFncChk.rcCheckERefIMode())) {
          if (RckyEref.eRef.nowDisplay == RcElog.EREF_LCDDISP) {
            if (FbInit.subinitMainSingleSpecialChk() &&
                (cMem.stat.dualTSingle == 1)) {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.dualSubttl);
            } else {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.subttl);
            }
            return;
          } else {
            if (await RcFncChk.rcCheckERefSMode()) {
              RcSet.rcERefISubScrMode();
              RckyEref.loadItemToTotalDisp();
              StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
            }
            return;
          }
        } else if ((await RcFncChk.rcCheckESVoidSMode()) ||
            (await RcFncChk.rcCheckESVoidIMode())) {
          if (EsVoid().nowDisplay == RcElog.ESVOID_LCDDISP) {
            if (FbInit.subinitMainSingleSpecialChk() &&
                (cMem.stat.dualTSingle == 1)) {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.dualSubttl);
            } else {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.subttl);
            }
            return;
          } else {
            if (await RcFncChk.rcCheckESVoidSMode()) {
              RcSet.rcESVoidISubScrMode();
              StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
            }
            return;
          }
        } else if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
            (await RcFncChk.rcCheckCrdtVoidIMode())) {
          if (CrdtVoid().nowDisplay == RcElog.CRDTVOID_LCDDISP) {
            if (FbInit.subinitMainSingleSpecialChk() &&
                (cMem.stat.dualTSingle == 1)) {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.dualSubttl);
            } else {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.subttl);
            }
            return;
          } else {
            if (await RcFncChk.rcCheckCrdtVoidSMode()) {
              RcSet.rcCrdtVoidISubScrMode();
              StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
            }
            return;
          }
        } else if ((await RcFncChk.rcCheckPrecaVoidSMode()) ||
            (await RcFncChk.rcCheckPrecaVoidIMode())) {
          if (PrecaVoid().nowDisplay == RcElog.PRECAVOID_LCDDISP) {
            if (FbInit.subinitMainSingleSpecialChk() &&
                (cMem.stat.dualTSingle == 1)) {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.dualSubttl);
            } else {
              RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.subttl);
            }
            return;
          } else {
            if (await RcFncChk.rcCheckPrecaVoidSMode()) {
              RcSet.rcPrecaVoidISubScrMode();
              StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
            }
            return;
          }
        }
        RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.subttl);
        if (FbInit.subinitMainSingleSpecialChk()) {
          RcStlLcd.rcStlLcdSpritCncl(imgCd, RegsDef.dualSubttl);
        }
        break;
    }
  }

  /// 機能概要     : 紅屋商事様の品券バーコードかの確認を行う
  /// 戻り値       : 1=正常, 0=異常
  /// 関連tprxソース:rcstl.c - rcChk_ItmRBuf_Beniya
  static bool rcChkItmRBufBeniya(int p) {
    if (p < 0) {
      return false;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    return (mem.tItemLog[p].t10003.recMthdFlg ==
        REC_MTHD_FLG_LIST.HINKEN_BAR_REC.typeCd);
  }
}
