/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/lib/cm_cal/cm_mul.dart';
import 'package:flutter_pos/app/lib/cm_cal/cm_round.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_mbr_com.dart';
import 'package:flutter_pos/app/regs/checker/rc_reserv.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rckycardfee.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/common/rx_log_calc.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/mcd.dart';
import '../../lib/apllib/AplLib_EucAdjust.dart';
import '../../lib/cm_cal/cm_div.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_ext.dart';
import 'rcmbrflrd.dart';

class RcMbrCmSrv{
  static AcMem cMem = SystemFunc.readAcMem();

  /// 共通サービス項目データをトータルレシートバッファ，顧客問い合わせテーブルへ設定．
  /// 関連tprxソース: rcmbrcmsrv.c - rcmbrComCashSet(short pdscchkflg)
  static Future<bool> rcmbrComCashSet(int pdscChkFlg) async {
    bool ret = false;
    RegsMem mem = SystemFunc.readRegsMem();

    // 顧客仕様のチェック
    if(!(await RcMbrCom.rcmbrChkStat() != 0)){
      mem.tTtllog.t100001Sts.fspMbr = 1;
      return false;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 会員データチェック
    //  if (rcmbrChkCust() == FALSE) {
    //    MEM->tTtllog.t100001Sts.fsp_mbr = 1;
    //   return 0;
    // }

    // 会員小計値引
    if(!(mem.tTtllog.t100700.fspLvl != 0)){
      ret = await rcmbrComSubDscSet(pdscChkFlg);
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    //トータルログ更新
    // if (rcmbrChkCust()) {
    //   rcmbrComTtlSet();
    // }

    return ret;
  }

  /// 会員小計値引
  /// 関連tprxソース: rcmbrcmsrv.c - rcmbrComSubDscSet(short pdscchkflg)
  /// 引数：なし
  /// 戻値：true:会員小計割引実行  false:会員小計割引はしていない
  static Future<bool> rcmbrComSubDscSet(int pdscChkFlg) async {
    bool result;

    List<int> ustldscAmt = [];

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    Onetime ot = SystemFunc.readOnetime();

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if DEPARTMENT_STORE
    // short ret;
    // long  p;
    // #endif

    int orgStldscRestAmt = 0;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (   (cm_ds2_godai_system())			/* ゴダイ様特注 */
    //     && (MEM->tTtllog.t100002.quotation_flg) )	/* 見積宣言時は会員小計値下利用不可 */
    // {
    //   return (0);
    // }

    if(!((await RcFncChk.rcCheckERefMode())
        || (await RcFncChk.rcCheckERefSMode())
        || (await RcFncChk.rcCheckERefIMode())
        || (await RcFncChk.rcCheckERefRMode()))){
      if(!((await RcFncChk.rcCheckESVoidMode())
          || (await RcFncChk.rcCheckESVoidSMode())
          || (await RcFncChk.rcCheckESVoidIMode())
          || (await RcFncChk.rcCheckESVoidVMode())
          || (await RcFncChk.rcCheckESVoidCMode())
          || (await RcFncChk.rcCheckESVoidSDMode()))){
        // 会員小計割引(０～９９％)
        if(mem.tTtllog.t100001Sts.qcReadQrReceiptNo != 0){
          if(ot.mbrcalflags.stlpdscRatezeroFlg == 1){
            mem.tTtllog.calcData.mbrStlpdscPer = 0;
          }else{
            mem.tTtllog.calcData.mbrStlpdscPer
            = mem.tTtllog.t100002Sts.prgMbrStldscPer;
          }
        }else{
          //#if RESERV_SYSTEM
          if(!(await RcReserv.rcReservNotUpdate())){
            if(ot.mbrcalflags.stlpdscRatezeroFlg == 1){
              mem.tTtllog.calcData.mbrStlpdscPer = 0;
            }else{
              mem.tTtllog.calcData.mbrStlpdscPer
              = mem.tTtllog.t100002Sts.prgMbrStldscPer;
            }
          }
        }
      }
    }

    // ＦｅｌｉＣａ仕様と従業員証仕様を同時に動作させたときは従業員証は会員小計割引率を０にする
    if((await RcSysChk.rcChkFelicaSystem())
        && (pCom.dbTrm.cardsheetPrn != 0)
        && (mem.tTtllog.t100700.mbrInput
            == MbrInputType.magcardInput.index)){
      mem.tTtllog.calcData.mbrStlpdscPer = 0;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行：433-461

    orgStldscRestAmt = mem.tTtllog.calcData.stldscRestAmt;
    mem.tTtllog.calcData.stldscRestAmt
    += mem.tTtllog.t100702.mbrStlpdscAmt;
    if(RcSysChk.rcChkRefundStlDscSystem()){
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   #if DEPARTMENT_STORE
      //   if(rcChk_Department_System())
      // result = ((MEM->tTtllog.calcData.ddsa_mulcls  != 0) && (MEM->tTtllog.calcData.mbr_stlpdsc_per > 0));
      // else
      // #endif
      result = ((mem.tTtllog.calcData.stldscRestAmt != 0)
          && (mem.tTtllog.calcData.mbrStlpdscPer > 0));
    }else{
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   #if DEPARTMENT_STORE
      //   if(rcChk_Department_System())
      // result = ((MEM->tTtllog.calcData.ddsa_mulcls  > 0) && (MEM->tTtllog.calcData.mbr_stlpdsc_per > 0));
      // else
      // #endif
      result = ((mem.tTtllog.calcData.stldscRestAmt > 0)
          && (mem.tTtllog.calcData.mbrStlpdscPer > 0));
    }
    mem.tTtllog.calcData.stldscRestAmt = orgStldscRestAmt;

    if(CompileFlag.RALSE_MBRSYSTEM){
      result &= await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSCARD, mem);
    }

    if((mem.tTtllog.t100002Sts.prgMbrStldscLowLimit != 0)
        && (ot.mbrcalflags.stlpdscLimitchkFlg != 1)){
      if(!((pdscChkFlg != 0) && (mem.tTtllog.t100702.mbrStlpdscAmt != 0))){
        if(RcSysChk.rcChkRefundStlDscSystem()){
          if(((mem.tTtllog.t100002Sts.prgMbrStldscLowLimit) >
              ((RxLogCalc.rxCalcStlTaxInAmt(mem) + mem.tTtllog.calcData.ttlStldscAmt)
                  - RxLogCalc.rxCalcExTaxAmt(mem)).abs())
              && (pdscChkFlg != 0)){
            result = false;
          }
        }else{
          if(((mem.tTtllog.t100002Sts.prgMbrStldscLowLimit) >
              ((RxLogCalc.rxCalcStlTaxInAmt(mem) + mem.tTtllog.calcData.ttlStldscAmt)
                  - RxLogCalc.rxCalcExTaxAmt(mem)))
              && (pdscChkFlg != 0)){
            result = false;
          }
        }
      }
    }

    if(result){
      // TODO:10121 QUICPay、iD 202404実装対象外
      // 会員小計割引額
      //   #if DEPARTMENT_STORE
      //   if(rcChk_Department_System()) {
      // stlttldsc = rxCalc_Ttl_StlDscAmt( MEM );
      // if(pdscchkflg == 0)
      // MEM->tTtllog.calcData.dtda_mulcls = MEM->tTtllog.calcData.dtda_mulcls - stlttldsc;
      // cm_l_mul(MEM->tTtllog.calcData.dtda_mulcls, (long)MEM->tTtllog.calcData.mbr_stlpdsc_per, ustldsc_amt);
      // }
      // else
      // #endif

      ustldscAmt = CmMul.cmLMul
        (mem.tTtllog.t100001Sts.stldscAutoBfrAmt,
          mem.tTtllog.calcData.mbrStlpdscPer);
      ustldscAmt = CmDiv.cmLDiv(ustldscAmt, 1);

      if(RcSysChk.rcChkStlPDscOneTenth()){
        mem.tTtllog.t100702.mbrStlpdscAmt
        = ((CmRound.cmRound(pCom.dbTrm.rndDscntFlg, ustldscAmt[0], 1000))
            / 1000) as int;
      }else{
        mem.tTtllog.t100702.mbrStlpdscAmt
        = ((CmRound.cmRound(pCom.dbTrm.rndDscntFlg, ustldscAmt[0], 100))
            / 100) as int;
      }

      // TODO:10121 QUICPay、iD 202404実装対象外
      //   #if 0	//@@@V15	VISMACはとりあえず削除
      //   #if VISMAC
      //   if(   (C_BUF->db_cust_trm.vmc_hesokuri)
      // && (rcChk_VMC_System())
      // && (CMEM->custdata.cust.heso_add_mem_typ == 0)
      // && (CMEM->custdata.svs_cls.heso_add_mem_typ == 0) )
      // {
      // MEM->tTtllog.t100702.mbr_stlpdsc_amt = 0;
      // }
      // #endif
      // #endif	//@@@V15

      // 会員小計割引回数
      mem.tTtllog.t100702.mbrStlpdscCnt = 1;
      mem.tTtllog.t100702.mbrStlpdscTrendsTyp
      = mem.tTtllog.t100002Sts.prgMbrStldscTrendsTyp;

      // snprintf(MEM->tTtllog.t100702.mbr_stldsc_plan_cd,
      //     sizeof(MEM->tTtllog.t100702.mbr_stldsc_plan_cd),
      //     "%s", MEM->tTtllog.t100002Sts.prg_mbr_stldsc_plan_cd );
      // snprintf(MEM->tTtllog.t100702.promo_ext_id,
      //     sizeof(MEM->tTtllog.t100702.promo_ext_id),
      //     "%s", MEM->tTtllog.t100002Sts.prg_mbr_stldsc_promo_ext_id );
      mem.tTtllog.t100702.mbrStldscPlanCd
      = mem.tTtllog.t100002Sts.prgMbrStldscPlanCd;
      mem.tTtllog.t100702.promoExtId
      = mem.tTtllog.t100002Sts.prgMbrStldscPromoExtId;
      if(RcSysChk.rcChkMbrRCPdscSystem()
          && (mem.tTtllog.t100700Sts.mbrTyp < 4)){
        mem.tTtllog.t100702.mbrStlpdscAmt = 0;
        mem.tTtllog.t100702.mbrStlpdscCnt = 0;
        mem.tTtllog.t100702.mbrStlpdscTrendsTyp = 0;
        // memset( MEM->tTtllog.t100702.mbr_stldsc_plan_cd, 0x00, sizeof(MEM->tTtllog.t100702.mbr_stldsc_plan_cd) );
        // memset( MEM->tTtllog.t100702.promo_ext_id, 0x00, sizeof(MEM->tTtllog.t100702.promo_ext_id) );
      }
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   #if 0	//@@@V15	VISMACはとりあえず削除
      //   #if VISMAC
      //   if(   (C_BUF->db_cust_trm.vmc_hesokuri)
      // && (rcChk_VMC_System())
      // && (CMEM->custdata.cust.heso_add_mem_typ == 0)
      // && (CMEM->custdata.svs_cls.heso_add_mem_typ == 0) )
      // {
      // MEM->tTtllog.t100702.mbr_stlpdsc_cnt = 0;
      // }
      // #endif
      // #endif	//@@@V15
    }else{
      mem.tTtllog.t100702.mbrStlpdscAmt = 0;
      mem.tTtllog.t100702.mbrStlpdscCnt = 0;
      mem.tTtllog.t100702.mbrStlpdscTrendsTyp = 0;
      // memset( MEM->tTtllog.t100702.mbr_stldsc_plan_cd, 0x00, sizeof(MEM->tTtllog.t100702.mbr_stldsc_plan_cd) );
      // memset( MEM->tTtllog.t100702.promo_ext_id, 0x00, sizeof(MEM->tTtllog.t100702.promo_ext_id) );
    }
    return (mem.tTtllog.t100702.mbrStlpdscCnt != 0);
  }

  /// 関連tprxソース: rcmbrcmsrv.c - rc_SPCardMbr_chk()
  static int rcSPCardMbrChk() {
    int iret = 0;

    iret = rcmbrAnvRvtChk();
    if (iret > 1000000) iret = iret - 1000000;
    if ((iret > 100000) || (iret == 19)) return 1;

    return 0;
  } 

  /// 関連tprxソース: rcmbrcmsrv.c - rcmbr_anv_rvt_chk()
  /// 定義のみ追加
  static int rcmbrAnvRvtChk() {
    return 0;
  }

  /// トータルログ更新
  /// 関連tprxソース: rcmbrcmsrv.c - rcmbrComCustDataSet()
  static Future<void> rcmbrComCustDataSet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    /* 顧客コード１３桁 */
    mem.tHeader.cust_no = cMem.custData.cust.cust_no;

    if( cBuf.dbTrm.seikatsuclubOpe != 0 ) {
      mem.tTtllog.t100700.telno1 = '${cMem.custData.cust.tel_no1!}0000000000000'.substring(0,13);
    }

    /* 記念日表示複数回許可 */
    mem.tTtllog.t100700Sts.mulAnvEnbl = cBuf.dbTrm.anvMnyDsp;

    /* 会員名 漢字 */
    mem.tTtllog.t100700.mbrNameKanji1 = cMem.custData.cust.last_name ?? "";
    mem.tTtllog.t100700.mbrNameKanji2 = cMem.custData.cust.first_name ?? "";

    if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0) && (mem.tTtllog.t100700.mbrInput == MbrInputType.barReceivInput.index)) {
      mem.tTtllog.t100017.creditName = cMem.custData.cust.last_name ?? "";
      await AplLibEucAdjust.aplLibEucCnt(mem.tTtllog.t100017.creditName);
    }

    if (RcSysChk.rcsyschkYunaitoHdSystem() == 0) {
  		/* 会員名 カナ */
      mem.tTtllog.t100700.mbrNameKana1 = cMem.custData.cust.kana_last_name ?? "";
      mem.tTtllog.t100700.mbrNameKana2 = cMem.custData.cust.kana_first_name ?? "";
    }

    if (cBuf.dbTrm.memUseTyp != 0) {
      if (cBuf.dbRegCtrl.streCd != cMem.custData.cust.stre_cd) {
        if (cBuf.dbTrm.cardsheetPrn == 0) {
          mem.tTtllog.t100700.storeZoneCd = 0;
        }
        mem.tTtllog.t100700.areaZoneCd = 0;
      } else {
        /* 本部地区コード */
        mem.tTtllog.t100700.storeZoneCd = cMem.custData.cust.custzone_cd;
      }
    }

    if ((await CmCksys.cmCustrealHpsSystem()) == 0) {
      /* 郵便番号 */
      mem.tTtllog.t100700Sts.postCd = int.parse(cMem.custData.cust.post_no ?? "0");
    }

    /* 住所 */
    if (RcSysChk.rcChkCustrealOPSystem()) {
      mem.tTtllog.t100700.adrs1 = cMem.custData.cust.address1 ?? "";
      mem.tTtllog.t100700.adrs2 = cMem.custData.cust.address2 ?? "";
      mem.tTtllog.t100700.adrs3 = cMem.custData.cust.address3 ?? "";
    }

    /* 割戻ポイント会員／除外会員 */
    if ((await CmCksys.cmPanaMemberSystem()) != 0  && mem.tTtllog.t100700.otherStoreMbr == 1) {
      var (tmpInt, svsPmbr) = (await RcMbrFlrd.rcmbrReadCustSvsCustNo(cMem.custData.cust.cust_no));
      mem.tTtllog.t100001Sts.msRbtMbr = tmpInt != 0 ? 0 : svsPmbr.point_add_mem_typ;
    }
    await rcmbrComCustEnqDataSet();
    mem.tTtllog.t100700.telno1 = cMem.custData.cust.tel_no1 ?? "";

    /* 発行年月日/Issue date */
    mem.tTtllog.t100900.issueDate = "0" * 20;

    if ((await RcSysChk.rcChkMcp200System()) && mem.tTtllog.t100700.mbrInput == MbrInputType.mcp200Input.index) {
      mem.tTtllog.t100900.issueDate = mem.custTtlTbl.d_data1 ?? "";
    }

    if ((await RcSysChk.rcChkAbsV31System()) && mem.tTtllog.t100700.mbrInput == MbrInputType.absV31Input.index) {
      mem.tTtllog.t100900.issueDate = mem.custTtlTbl.d_data1 ?? "";
    }

    /* クーポン利用年月/Coupon use date date */
    mem.tTtllog.t100900.cpnUseDate = "0" * 20;

    if ((await RcSysChk.rcChkMcp200System()) && mem.tTtllog.t100700.mbrInput == MbrInputType.mcp200Input.index) {
      mem.tTtllog.t100900.cpnUseDate = mem.custTtlTbl.d_data2 ?? "";
    }

    if ((await RcSysChk.rcChkAbsV31System()) && mem.tTtllog.t100700.mbrInput == MbrInputType.absV31Input.index) {
      mem.tTtllog.t100900.cpnUseDate = mem.custTtlTbl.d_data2 ?? "";
    }

    /* 最終割戻年月日/Last rebate date */
    mem.tTtllog.t100900.lastRbtDate = "0" * 20;

    if ((await RcSysChk.rcChkMcp200System()) && mem.tTtllog.t100700.mbrInput == MbrInputType.mcp200Input.index) {
      mem.tTtllog.t100900.lastRbtDate = mem.custTtlTbl.d_data3 ?? "";
    }

    if ((await RcSysChk.rcChkAbsV31System()) && mem.tTtllog.t100700.mbrInput == MbrInputType.absV31Input.index) {
      mem.tTtllog.t100900.lastRbtDate = mem.custTtlTbl.d_data3 ?? "";
    }

    if (mem.tTtllog.t100700.mbrInput == MbrInputType.felicaInput.index) {
      mem.tTtllog.t100900.lastRbtDate = mem.custTtlTbl.d_data3 ?? "";
      mem.tTtllog.t100900.lastChgPayout = mem.custTtlTbl.d_data7 ?? "";
      mem.tTtllog.t100900.lastHesoPayout = mem.custTtlTbl.d_data8 ?? "";
    }

    /* 有効期限・年会費 */
    mem.tTtllog.t100001.validDate = mem.custTtlTbl.d_data10 ?? "";

    if ((await RcSysChk.rcChkMcp200System()) && RcMbrCom.rcmbrGetOpeMode() == RcRegs.RG) {
      if (mem.tTtllog.t100700.otherStoreMbr == 0) {
        if (RckyCardFee.rcmbrValiDateUpdate(mem.tTtllog.t100001.validDate) != "") {
          if (cBuf.dbTrm.cardMngFee != 0) {
            mem.tTtllog.t100702.joinFeeCust = 1;
            mem.tTtllog.t100702.joinFeeAmt = cBuf.dbTrm.cardMngFee;
          }
        }
      }
    }

    if (await RcSysChk.rcCheckWatariCardSystem()) {
      if (mem.tTtllog.t100700.mbrInput == MbrInputType.magcardInput.index) {
        var magStartPosi = cBuf.dbTrm.othcmpMagStrtNo - 12 - 1;
        if (magStartPosi < 0) {
          magStartPosi = 0;
        }
        mem.tTtllog.t100010.invoiceNo = mem.tmpbuf.rcarddata.jis2.substring(magStartPosi, magStartPosi + 21);
        mem.tmpbuf.rcarddata.jis2 = '0' * 70;
      }
    }

    if (await RcSysChk.rcChkChargeSlipSystem()) {
      if (await RcExt.rcChkMemberChargeSlipCard()) {
        mem.tTtllog.t100002.custCd = int.parse(cMem.custData.cust.tel_no2 ?? "0");
      }
    }

    // ターミナル設定値などをトータルログにセット
    rcmbrComSpecDataSet( );
  }

  /// 関連tprxソース: rcmbrcmsrv.c - rcmbrComCustEnqDataSet
  static Future<void> rcmbrComCustEnqDataSet() async {
    RegsMem mem = SystemFunc.readRegsMem();

    /* 前回累計買上金額(税抜) */
    mem.tTtllog.t100700.lastTtlpur = mem.custTtlTbl.n_data1;
    /* 前回累計ポイント */
    mem.tTtllog.t100700.lpntTtlsrv = 0;
    if ((await RcSysChk.rcChkPharmacySystem()) &&
        !(await RcSysChk.rcChkSapporoRealSystem())) {
      if (mem.tTtllog.t100700.lpntTtlsrv < 0) {
        mem.tTtllog.t100700.lpntTtlsrv = 0;
      }
    }
    if (await RcSysChk.rcChkOneToOnePromSystem()) {
      for (int num = 0; num < mem.tTtllog.t100001Sts.acntCnt; num++) {
        if (mem.tTtllog.t107000[num].acntId ==
            AcctFixCodeList.ACCT_CODE_TODAY_PNT.value) {
          mem.tTtllog.t100700.lpntTtlsrv = mem.tTtllog.t107000[num].lastAcntPnt;
          break;
        }
      }
    }
    if (await CmCksys.cmSm74OzekiSystem() != 0) {
      for (int num = 0; num < mem.tTtllog.t100001Sts.acntCnt; num++) {
        if (mem.tTtllog.t107000[num].acntId ==
            AcctFixCodeList.ACCT_CODE_TODAY_PNT.value) {
          mem.tTtllog.t107000[num].lastAcntPnt = cMem.custData.enq!.n_data2;
          mem.tTtllog.t100700.lpntTtlsrv = mem.tTtllog.t107000[num].lastAcntPnt;
          break;
        }
      }
    }
    /* 前回累計可能ポイント */
    mem.tTtllog.calcData.lpptTtlsrv = mem.custTtlTbl.n_data5;

  }

  // 関連tprxソース: rcmbrcmsrv.c - rcmbrComSpecDataSet
  static	void	rcmbrComSpecDataSet() {}
}