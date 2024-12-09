/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../postgres_library/src/pos_log_table_access.dart';
import '../../../../../webapi/src/webapi.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../common/dual_cashier_util.dart';
import '../../common/environment.dart';
import '../../drv/ffi/library.dart';
import '../../drv/printer/drv_print_isolate.dart';
import '../../fb/fb_init.dart';
import '../../if/if_drv_control.dart';
import '../../if/rp_print.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_aibox/if_aibox.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../common/rx_log_calc.dart';
import '../common/rxmbrcom.dart';
import '../inc/L_rc_sgdsp.dart';
import '../inc/rc_basket_server.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_custreal2.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_acb_stopdsp.dart';
import 'rc_28dsp.dart';
import 'rc_59dsp.dart';
import 'rc_acracb.dart';
import 'rc_ajs_emoney.dart';
import 'rc_appendix.dart';
import 'rc_assist_mnt.dart';
import 'rc_atct.dart';
import 'rc_atctp.dart';
import 'rc_atre.dart';
import 'rc_barcode_pay.dart';
import 'rc_cashless.dart';
import 'rc_ext.dart';
import 'rc_order.dart';
import 'rc_clscom.dart';
import 'rc_clxos_payment.dart';
import 'rc_cogca.dart';
import 'rc_crdt_fnc.dart';
import 'rc_depo_in_plu.dart';
import 'rc_dpoint.dart';
import 'rc_ewdsp.dart';
import 'rc_felica.dart';
import 'rc_flrda.dart';
import 'rc_gcat.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_cardforget.dart';
import 'rc_key_extkey.dart';
import 'rc_key_norebate.dart';
import 'rc_key_pbchg.dart';
import 'rc_key_qcselect.dart';
import 'rc_key_stf.dart';
import 'rc_key_stf_release.dart';
import 'rc_key_vesca_bal.dart';
import 'rc_key_tab.dart';
import 'rc_key_tab1.dart';
import 'rc_lastcomm.dart';
import 'rc_mbr_com.dart';
import 'rc_mbr_realsvr.dart';
import 'rc_mbrrealsvr_fresta.dart';
import 'rc_mcd.dart';
import 'rc_multi.dart';
import 'rc_multi_suica_com.dart';
import 'rc_post.dart';
import 'rc_point_infinity.dart';
import 'rc_preca.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rc_reserv.dart';
import 'rc_repica.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rc_slip.dart';
import 'rc_spool_in.dart';
import 'rc_suica.dart';
import 'rc_suica_com.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rc_stl_dsp.dart';
import 'rc_tab.dart';
import 'rc_trk_preca.dart';
import 'rc_usbcam1.dart';
import 'rc_value_card.dart';
import 'rc_yumeca.dart';
import 'rcabs_v31.dart';
import 'rccatalina.dart';
import 'rccrwp_com.dart';
import 'rcfncchk.dart';
import 'rchcard_dsp.dart';
import 'rcht2980_com.dart';
import 'rcky_bc.dart';
import 'rcky_cashvoid.dart';
import 'rcky_cha.dart';
import 'rcky_cpnprn.dart';
import 'rcky_esvoid.dart';
import 'rcky_icc.dart';
import 'rcky_omni_channel.dart';
import 'rcky_qctckt.dart';
import 'rcky_rfdopr.dart';
import 'rcky_rfm.dart';
import 'rcky_rpr.dart';
import 'rcky_spbarcode_read.dart';
import 'rcky_sus.dart';
import 'rckyaccount_receivable.dart';
import 'rckyccin.dart';
import 'rckyccin_acb.dart';
import 'rckycncl.dart';
import 'rckyrmod.dart';
import 'rckyworkin.dart';
import 'rcmbr_ZHQflrd.dart';
import 'rcmbr_istyle.dart';
import 'rcmbrcmsrv.dart';
import 'rcmbrflrd.dart';
import 'rcmbrkymbr.dart';
import 'rcmbrpcom.dart';
import 'rcmbrpitmset.dart';
import 'rcmbrpoical.dart';
import 'rcmbrrealsvr2.dart';
import 'rcmbrrecal.dart';
import 'rcmcp200_com.dart';
import 'rcmoneyconf.dart';
import 'rcnewsg_fnc.dart';
import 'rcorc_com.dart';
import 'rcorc_wt.dart';
import 'rcpana_com.dart';
import 'rcprestl.dart';
import 'rcpromotion.dart';
import 'rcpw410_com.dart';
import 'rcqc_com.dart';
import 'rcqr_com.dart';
import 'rcsapporo_pana_com.dart';
import 'rcsg_com.dart';
import 'rcsg_dev.dart';
import 'rcsg_dsp.dart';
import 'rcsg_vfhd_dsp.dart';
import 'rcspj_dsp.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'rctrc_wt.dart';
import 'rcvmc_wt.dart';
import 'rxrwc.dart';


///　「現計」処理.
/// 関連tprxソース:rckycash.c
class RcKeyCash {
  final CEjLogColumns _data = CEjLogColumns();

  // TODO:00011 周 グローバル変数__FUNCTION__の変数名はDart命名規則に反し、あくまで一時的措置
  final String __FUNCTION__ = "";
  bool custrealMbrUpdate = false;
  RxCommonBuf cBuf = RxCommonBuf();
  AcMem cMem = AcMem();
  RegsMem mem = RegsMem();
  IfWaitSave? ifSave;
  RxInputBuf iBuf = RxInputBuf();
  RxTaskStatBuf tsBuf = RxTaskStatBuf();
  AtSingl atSingl = AtSingl();
  static SgMntDsp mntDsp = SgMntDsp();
  TabInfo? tabInfo;

  // AcbInfo acbInfo = AcbInfo(); //【dart化時コメント】AcbInfoの中身のstatic変数化に伴いコメントアウト
  RcKeyCash();

  TendType? eTendType; // ternder type
  QCashierIni? qCashierIni;

  ///TODO:00014 日向 GtkWidget のため一旦定義のみ追加
  var continueRprWin0;
  var continueRprWin1;
  var continueRprEntry;

  static int spjPaydspFlg = 0;
  static int acrErrno = 0;
  static int printErr = 0;
  static int updateErr = 0;
  static int autorprCnt = 0;
  static int popWarn = 0;
  static int qcFncCd = 0;
  static int checkCnt = 0;
  static int nearEndEmptyNo = 0;

  // rckycash.cで使われたすべての条件付きコンパイルシンボル：
  static bool SELF_GATE = false;
  static bool RESERV_SYSTEM = false;
  static bool SMART_SELF = false;
  static bool DEPARTMENT_STORE = false;
  static bool RF1_SYSTEM = false;
  static bool CUSTREALSVR = false;
  static bool IC_CONNECT = false;
  static bool ARCS_MBR = false;
  static bool MC_SYSTEM = false;
  static bool SIMPLE_STAFF = false;
  static bool SIMPLE_2STAFF = false;

  static int nearendEmptyStopNo = 0;
  static int nearendEmptyNo = 0;

  /// 関連tprxソース:rckycash.c - Prom_Alert_Cash()
  Future<void> promAlertCash() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "Prom_Alert_Cash Push\n");
    TprLibDlg.tprLibDlgClear2("promAlertCash");
    RcExt.rcClearErrStat("promAlertCash");
    rcCashAmount1_Sub();
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_Sub()
  Future<void> rcCashAmount1_Sub() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    KopttranBuff kopttran = KopttranBuff();
    await RcFlrda.rcReadKopttran(FuncKey.KY_CASH.keyId, kopttran);

    Rcprestl.rcPrestlSetDateManualVoidRef(); // 訂正日付の入力

    if (await CmCksys.cmOrderModeSystem() != 0 && RcSysChk.rcODOpeModeChk()) {
      /* 業務モード仕様  & 発注 */
      RcOrder.rcOrderDisplay(); /* OD (OrderMode) */
      return;
    }
    if (await CmCksys.cmBusinessModeSystem() != 0 &&
        (RcSysChk.rcSROpeModeChk() ||
            RcSysChk.rcIVOpeModeChk() ||
            RcSysChk.rcPDOpeModeChk())) {
      RcSlip.rcSlipDisplay(); /* SR,IV,PD (BusinessMode) */
      return;
    }

    if (!(await CmCksys.cmSpDepartmentSystem() != 0 &&
        RcHcardDsp.rcYaoStWorkTyp() == 7001)) {
      if (CompileFlag.DEPARTMENT_STORE) {
        if (!(await RcSysChk.rcCheckIndividChange() &&
            RcSysChk.rcChkDepartmentSystem() &&
            RcAtct.rcChkDrwOpenDepartment(kopttran))) {
          if (!RcSysChk.rcSROpeModeChk()) {
            if (kopttran.stlOverFlg == 2 ||
                await RcSysChk.rcCheckIndividChange()) {
              if (!(await RcFncChk.rcCheckESVoidIMode()) &&
                  !(await RcFncChk.rcCheckERefIMode()) &&
                  !(await RcFncChk.rcCheckERefSMode())) {
                if (await RcSysChk.rcCheckIndividChange()) {
                  RcMoneyConf.rcMoneyConfDsp(1, kopttran);
                } else {
                  RcMoneyConf.rcMoneyConfDsp(0, kopttran);
                }
                return;
              }
            }
          }
        } else {
          if (!RcSysChk.rcSROpeModeChk()) {
            if (kopttran.stlOverFlg == 2 ||
                await RcSysChk.rcCheckIndividChange()) {
              if (!(await RcFncChk.rcCheckESVoidIMode()) &&
                  !(await RcFncChk.rcCheckERefIMode()) &&
                  !(await RcFncChk.rcCheckERefSMode())) {
                if (await RcSysChk.rcCheckIndividChange()) {
                  RcMoneyConf.rcMoneyConfDsp(1, kopttran);
                } else {
                  RcMoneyConf.rcMoneyConfDsp(0, kopttran);
                }
                return;
              }
            }
          }
        }
      }
    }
    if (cBuf.dbTrm.atreCashPointIp3100 != 0 &&
        (await RcFncChk.rcCheckStlMode() || await RcFncChk.rcCheckItmMode())) {
      atSingl.fscaAutoFlg = 0;
      if (RcAtre.rcAtreProc() != Typ.OK) {
        return;
      }
    }
    if (CompileFlag.IC_CONNECT) {
      if (RcSysChk.rcChkICCSystem() &&
          RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_BRND_CIN.keyId])) {
        RckyIcc.rcICCCashDeposit();
        return;
      }
    }
    if (!(await CmCksys.cmSpDepartmentSystem() != 0 &&
        RcHcardDsp.rcYaoStWorkTyp() == 7001)) {
      RcHcardDsp.rcYaoUpdateStart(0, FuncKey.KY_CASH.keyId);
      return;
    }
    if (RcSysChk.rcChkCustrealOPSystem() &&
        mem.tTtllog.t100700.realCustsrvFlg == 0 &&
        mem.tTtllog.t100701.duptTtlrv != 0 &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
      Rcmbrrealsvr2.rcCustRealOPUpdate(cMem.stat.fncCode);
      return;
    }

    rcCashAmount1_1();
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_1()
  Future<void> rcCashAmount1_1() async {
    int errNo = 0;
    PIREQPARAM_ECUPDATE requestParam = PIREQPARAM_ECUPDATE();
    PIREQPARAM_MBRUSE requestParamUse = PIREQPARAM_MBRUSE();
    int nRequestCommand = 0;

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA ||
        eTendType == TendType.TEND_TYPE_TEND_AMOUNT) {
      if (RcGcat.rcGcatCashchaConfDlgAndSound(FuncKey.KY_CASH.keyId) < 0) {
        RcQcDsp.rcQCStaffUseNowDsp();
        return;
      }
      if (await RcSysChk.rcChkCashierQRPrint()) {
        cMem.stat.cashintFlag = 0;
        RcTrkPreca.rcSusRegEtcRedisp();
      }
    }

    if (await CmCksys.cmIchiyamaMartSystem() != 0 &&
        mem.tTtllog.t100700.mbrInput == MbrInputType.mbrKeyInput.index &&
        (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA ||
            eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
      mem.tHeader.cust_no = "";
      mem.tTtllog.t100700.magMbrCd = "";
      mem.tTtllog.t100700.mbrNameKanji1 = "";
      mem.tTtllog.t100011.errcd = "";
      if (mem.tTtllog.t100700.realCustsrvFlg == 2) {
        mem.tTtllog.t100700.realCustsrvFlg = 0;
      }
    }

    if (await CmCksys.cmIchiyamaMartSystem() != 0 &&
        !(await RcSysChk.rcQCChkQcashierSystem()) &&
        await RckyBc.rcSplitChkATCTBefore() != 0 &&
        RckyCashVoid.rcCheckCashVoidDsp() &&
        await RcFncChk.rcCheckESVoidIMode() &&
        await RcFncChk.rcCheckESVoidSMode()) {
      if (mem.tTtllog.t100001.periodDscAmt != 0) {
        rcCashAmount1_BC_Before();
      } else if (mem.tTtllog.t100002.custCd != 0 ||
          mem.tTtllog.t100701.dtiqTtlsrv != 0) {
        rcCashAmount1_dsp_Before();
      } else {
        await rcCashAmount1_2_0();
      }
    } else if (RcSysChk.rcChkTpointSystem() != 0 &&
        mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
      if (RcSysChk.rcRGOpeModeChk() ||
          RcSysChk.rcTROpeModeChk() &&
              mem.tTtllog.t100701.duptTtlrv != 0 &&
              mem.tTtllog.t100710.retCdEnq == 0 &&
              mem.tTtllog.t100710.tPtsFlg == 0 &&
              !(await RcSysChk.rcQCChkQcashierSystem())) {
        cMem.ent.errNo = Rcmbrrealsvr2.rcRealsvr2TpointUse(0, mem.tTtllog);

        if (cMem.ent.errNo != Typ.OK) {
          Rcmbrrealsvr2.rcrealsvr2TpointErrSpCncl();
          mem.tTtllog.t100710.tPtsFlg = 2;
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcChk_Tpoint_System Add error \n");
          return;
        } else {
          mem.tTtllog.t100710.tPtsFlg = 1;
        }
      }
      if (RcSysChk.rcRGOpeModeChk()) {
        Rcmbrrealsvr2.rcrealsvr2TpointBatCpnUse();
      }
      if (RcSysChk.rcRGOpeModeChk() &&
          !(await RcSysChk.rcQCChkQcashierSystem())) {
        if (Rcmbrrealsvr2.rcrealsvr2TpointCouponIssue(0) != 0) {
          Rcmbrrealsvr2.rcrealsvr2TpointCpnMsg();
        } else {
          await rcCashAmount1_2_0();
        }
      } else {
        await rcCashAmount1_2_0();
      }
    } else if (await CmCksys.cmPointartistConect() == CmSys.PARTIST_SOCKET &&
        await RcMbrCom.rcmbrChkStat() != 0 &&
        RcMbrCom.rcmbrChkCust()) {
      mem.tTtllog.t100700Sts.d1DcauMspur = 0;
      for (int p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
        mem.tTtllog.t100700Sts.d1DcauMspur +=
            RcMbrPItmSet.rcmbrPItmSetrbtpuramt(p, 1);
      }
      if (mem.tTtllog.t100700.realCustsrvFlg == 0) {
        switch (eTendType) {
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_TEND_AMOUNT:
          case TendType.TEND_TYPE_POST_TEND_END:

            ///TODO:00014 日向 定義されていない関数
            //cMem.ent.errNo = rcmbrReMbrCal(KY_CASH + MAX_FKEY, RCMBR_WAIT);
            RcMbrCmSrv.rcmbrComCashSet(1);

            if (cMem.ent.errNo != 0) {
              Rcmbrrealsvr2.rcPointartistSocketErr(
                  FuncKey.KY_CASH.keyId, cMem.ent.errNo);
            } else {
              Rcmbrkymbr.anvFlgSet();
              RcMbrPoiCal.rcmbrTodayPoint(1);
              RcMbrPoiCal.rcmbrPTtlSet();
              if (mem.tTtllog.t100701.dtipTtlsrv > 0 &&
                  mem.tTtllog.t100700Sts.webrealsrvExpPoint > 0) {
                mem.tTtllog.t100700Sts.webrealsrvExpPointPrn = 0;
                mem.tTtllog.t100700Sts.webrealsrvExpPoint -=
                    mem.tTtllog.t100701.dtipTtlsrv;
                if (mem.tTtllog.t100700Sts.webrealsrvExpPoint <= 0) {
                  mem.tTtllog.t100700Sts.webrealsrvExpPoint = 0;
                }
                if (mem.tTtllog.t100700Sts.webrealsrvExpPoint != 0) {
                  mem.tTtllog.t100700Sts.webrealsrvExpPointPrn = 1;
                }
                await rcCashAmount1_2_0();
              }
            }
            break;
          default:
            await rcCashAmount1_2_0();
            break;
        }
      } else {
        if (await RcFncChk.rcCheckESVoidIMode()) {
          ///TODO:00014 日向 定義されていない関数
          //cMem.ent.errNo = rcmbrReMbrCal(KY_CASH + MAX_FKEY, RCMBR_WAIT);
          RcMbrCmSrv.rcmbrComCashSet(1);
          RcMbrPoiCal.rcmbrTodayPoint(1);
          RcMbrPoiCal.rcmbrPTtlSet();
        }
        await rcCashAmount1_2_0();
      }
    } else if (RcSysChk.rcChkCustrealOPSystem() &&
        mem.tTtllog.t100700.realCustsrvFlg == 0 &&
        mem.tTtllog.t100701.duptTtlrv != 0 &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
      Rcmbrrealsvr2.rcCustRealOPUpdate(cMem.stat.fncCode);
    } else if (await CmCksys.cmZHQSystem() != 0 &&
        (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA ||
            eTendType == TendType.TEND_TYPE_TEND_AMOUNT) &&
        (RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()) &&
        await RcSysChk.rcQCChkQcashierSystem() &&
        mem.tTtllog.t100001Sts.cpnErrDlgFlg == 0 &&
        atSingl.zhqCpnErrFlg == 0 &&
        RcqrCom.qrTxtPrintFlg != 1 &&
        RcKyCpnprn.rccpnprnPrintResCheck() == 1) {
      rcCashAmount1CpnNGMsg(TendType.TEND_TYPE_ERROR);
    } else if (RcSysChk.rcChkCustrealPointTactixSystem() != 0 &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND &&
        RcMbrCom.rcmbrChkCust() &&
        (RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()) &&
        await RcSysChk.rcQCChkQcashierSystem() &&
        Rcmbrrealsvr2.rcCustReal2PTactixProcChk(0) != 0 &&
        mem.tTtllog.t100701.duptTtlrv > 0) {
      errNo = Rcmbrrealsvr2.rcCustReal2PTactixUpdate(mem, 1, 0);
      if (errNo != 0) {
        Rcmbrrealsvr2.rcCustReal2PTactixDispErrPopup("rcCashAmount1_1", errNo);
        return;
      }
      await rcCashAmount1_2_0();
    } else if (RcSysChk.rcChkCustrealPointInfinitySystem() /* 顧客リアル[PI]仕様が有効かチェック*/
        && await RcMbrCom.rcmbrChkStat() != 0 /* 顧客の承認キーが有効かチェック */
        && RcMbrCom.rcmbrChkCust() /* 会員登録済みかチェック */
        && mem.tTtllog.t100700.mbrInput != MbrInputType.mbrprcKeyInput.index /* 会員売価キーは除く */) {
      if (await CmCksys.cmWsSystem() != 0) {
        switch (eTendType) {
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_TEND_AMOUNT:
          case TendType.TEND_TYPE_POST_TEND_END:
            // 会員情報更新を実行
            // 現状はエラーが発生しても先へ進む
            errNo = RcPointInfinity.rcPointInfinityMbrInfoChenge();
            break;
          default:
            break;
        }
        // ポイント利用処理
        // ※チェック処理は呼び出し先で実行
        errNo = RcPointInfinity.rcPointInfinityPointUseProc(eTendType);
        if ((mem.tTtllog.t100700.realCustsrvFlg == 0 /* オフラインフラグが無効かチェック */
                ||
                mem.tTtllog.t100700.realCustsrvFlg != 0) /* オフラインフラグが有効状態でも */
            &&
            errNo != 0) {
          /* 直近のポイント利用で異常発生時はポイント付与も実行する */
          switch (eTendType) {
            case TendType.TEND_TYPE_NO_ENTRY_DATA:
            case TendType.TEND_TYPE_TEND_AMOUNT:
            case TendType.TEND_TYPE_POST_TEND_END:
              if (RcSysChk.rcVDOpeModeChk() ||
                  RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
                nRequestCommand = CustReal2Hi.CUSTREAL2_HI_MBR_USE.index;
                requestParamUse.nUsePoint = mem.tTtllog.t100700.divPpoint.abs();
              } else {
                nRequestCommand = CustReal2Hi.CUSTREAL2_HI_MBR_ADD.index;
                requestParamUse.nUsePoint = mem.tTtllog.t100700.dpntTtlsrv;
                if (await CmCksys.cmWsSystem() != 0 &&
                    mem.tTtllog.t100001.saleAmt == 0) {
                  requestParamUse.nUsePoint = 0;
                  mem.tTtllog.t100700.dpntTtlsrv = 0;
                  RcMbrPoiCal.rcmbrWsSaleAmtZEROPReSet(mem.tTtllog);
                  requestParamUse.nUsePoint = mem.tTtllog.t100700.dpntTtlsrv;
                }
              }
              /* ポイント付与を実行 */
              errNo = RcPointInfinity.rcPointInfinityRequest(
                  nRequestCommand, requestParamUse.nUsePoint);
              if (errNo != 0) {
                // オフライン扱い
                mem.tTtllog.t100700.realCustsrvFlg = 1;
              } else {
                // 付与として実績を更新する。
                RcPointInfinity.rcPointInfinityUpdateTran(
                    CustReal2Hi.CUSTREAL2_HI_MBR_ADD.index,
                    requestParamUse.nUsePoint);
              }
              break;
            default:
              break;
          }
        } else {
          switch (eTendType) {
            case TendType.TEND_TYPE_NO_ENTRY_DATA:
            case TendType.TEND_TYPE_TEND_AMOUNT:
            case TendType.TEND_TYPE_POST_TEND_END:
              if (RcSysChk.rcVDOpeModeChk() ||
                  RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
                nRequestCommand = CustReal2Hi.CUSTREAL2_HI_MBR_USE_ERROR.index;
                requestParamUse.nUsePoint = mem.tTtllog.t100700.divPpoint.abs();
              } else {
                nRequestCommand = CustReal2Hi.CUSTREAL2_HI_MBR_ADD_ERROR.index;
                requestParamUse.nUsePoint = mem.tTtllog.t100700.dpntTtlsrv;
                if (await CmCksys.cmWsSystem() != 0 &&
                    mem.tTtllog.t100001.saleAmt == 0) {
                  requestParamUse.nUsePoint = 0;
                  mem.tTtllog.t100700.dpntTtlsrv = 0;
                  RcMbrPoiCal.rcmbrWsSaleAmtZEROPReSet(mem.tTtllog);
                  requestParamUse.nUsePoint = mem.tTtllog.t100700.dpntTtlsrv;
                }
              }
              /* ポイント付与を実行 */
              errNo = RcPointInfinity.rcPointInfinityRequest(
                  nRequestCommand, requestParamUse.nUsePoint);
              // 実績は何も更新しない
              break;
            default:
              break;
          }
        }
        if (await CmCksys.cmWsSystem() != 0 &&
            mem.tTtllog.t100015.ecTrade != 0) {
          if (mem.tTtllog.t100015.offFlg == 0) {
            /* オフラインフラグが無効かチェック */
            switch (eTendType) {
              case TendType.TEND_TYPE_NO_ENTRY_DATA:
              case TendType.TEND_TYPE_TEND_AMOUNT:
              case TendType.TEND_TYPE_POST_TEND_END:
                requestParam.pManagementNumber = mem.tTtllog.t100015.knrno;
                errNo = RcPointInfinity.rcPointInfinityRequest(
                    CustReal2Hi.CUSTREAL2_HI_EC_UPD.index,
                    int.parse(requestParam.pManagementNumber));

                if (errNo != 0) {
                  if (errNo == DlgConfirmMsgKind.MSG_NONEREC.dlgId) {
                    // 受取更新の対象データがありませんでした
                    errNo = DlgConfirmMsgKind.MSG_EC_NON_ORDER_ERR.dlgId;
                  } else {
                    // 通信障害の為、受取更新が行えません
                    errNo = DlgConfirmMsgKind.MSG_EC_COMM_RECV_ERR.dlgId;
                  }
                  mem.tTtllog.t100015.offFlg = 1; // オフライン状態を設定
                  RcPointInfinity.rcPointInfinityErrMsgDlg(
                      errNo,
                      rckyCashPiChashAmount,
                      LTprDlg.BTN_CONTINUE,
                      null,
                      "",
                      LTprDlg.BTN_ERR);
                  return;
                }
              default:
                break;
            }
          } else {
            RckyOmniCh.rckyOmniChannelUpdateHeaderOffLine();
          }
          await rcCashAmount1_2_0();
        }
      } else if (await CmCksys.cmWsSystem() != 0 &&
          mem.tTtllog.t100015.ecTrade != 0) {
        if (mem.tTtllog.t100015.offFlg == 0) {
          /* オフラインフラグが無効かチェック */
          switch (eTendType) {
            case TendType.TEND_TYPE_NO_ENTRY_DATA:
            case TendType.TEND_TYPE_TEND_AMOUNT:
            case TendType.TEND_TYPE_POST_TEND_END:
              requestParam.pManagementNumber = mem.tTtllog.t100015.knrno;
              errNo = RcPointInfinity.rcPointInfinityRequest(
                  CustReal2Hi.CUSTREAL2_HI_EC_UPD.index,
                  int.parse(requestParam.pManagementNumber));

              if (errNo != 0) {
                if (errNo == DlgConfirmMsgKind.MSG_NONEREC.dlgId) {
                  // 受取更新の対象データがありませんでした
                  errNo = DlgConfirmMsgKind.MSG_EC_NON_ORDER_ERR.dlgId;
                } else {
                  // 通信障害の為、受取更新が行えません
                  errNo = DlgConfirmMsgKind.MSG_EC_COMM_RECV_ERR.dlgId;
                }
                mem.tTtllog.t100015.offFlg = 1; // オフライン状態を設定
                RcPointInfinity.rcPointInfinityErrMsgDlg(
                    errNo,
                    rckyCashPiChashAmount,
                    LTprDlg.BTN_CONTINUE,
                    null,
                    "",
                    LTprDlg.BTN_ERR);
                return;
              }
            default:
              break;
          }
        } else {
          RckyOmniCh.rckyOmniChannelUpdateHeaderOffLine();
        }
        await rcCashAmount1_2_0();
      } else if (RcSysChk.rcsyschkSm66FrestaSystem() &&
          eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
        if (RcSysChk.rcChkCustrealFrestaSystem() &&
            mem.tTtllog.t100700.realCustsrvFlg == 0 &&
            mem.tTtllog.t100700.mbrInput != MbrInputType.mbrprcKeyInput.index &&
            RcMbrCom.rcmbrChkCust() &&
            (RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
          // 顧客ポイント付与通信
          RcMbrrealsvrFresta.rcrealsvrFrestaFlWt(0);
        }
        if ((RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()) &&
            mem.tTtllog.t100001Sts.fgTtlUse != 0) {
          cMem.ent.errNo = RcMbrrealsvrFresta.rcrealsvrFrestaFGTcktUseFlRd();
          if (cMem.ent.errNo != Typ.OK) {
            RckySpbarcodeRead.rcSpBarCodeSvrErrDlg(
                FuncKey.KY_CASH.keyId, cMem.ent.errNo);
            return;
          }
        }
        await rcCashAmount1_2_0();
      } else if (RcSysChk.rcChkCosme1IstyleSystem()) {
        switch (eTendType) {
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_TEND_AMOUNT:
          case TendType.TEND_TYPE_POST_TEND_END:
            errNo = RcMbrIstyle.rcmbrIstyleExecCommPayment();
            break;
          default:
            break;
        }
        await rcCashAmount1_2_0();
      } else if (RcMbrFlrd.rcmbrChkDataTranSysExtSvr() != 0 &&
          await RcMbrCom.rcmbrChkStat() != 0 &&
          RcMbrCom.rcmbrChkCust() &&
          eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
        RcMbrZHQFlrd.rcmbrZHQUpdatePoints();
        await rcCashAmount1_2_0();
      } else {
        await rcCashAmount1_2_0();
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_2_0()
  Future<void> rcCashAmount1_2_0() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if (RcSysChk.rcsyschkRepicaPointSystem() &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND &&
        mem.tmpbuf.workInType == 1 &&
        mem.prnrBuf.repicaPntErr.repicaTargetPrice != 0 &&
        mem.tmpbuf.repica.rxData.cardType == "M") {
      // レピカポイント仕様時、ポイント加算1(付与)を実施
      RcRepica.rcRepicaPointStartCalc(
          REPICA_BIZ_TYPE.REPICA_POINT_ADD1.repicaBizTypeCd);
      return; // dポイントは併用可能で、通信終了後dポイント処理を実行する
    }
    if (RcSysChk.rcChkDPointSystem() &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
      RcDpoint.rcDPointUpdate();
    } else {
      await rcCashAmount1_2();
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_2()
  Future<void> rcCashAmount1_2() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    int prnErrNo = 0;
    String log = '';
    int ret = 0;

    RcGtkTimer.rcGtkTimerRemove();
    RcSet.cashIntStatReset();

    if (CompileFlag.CATALINA_SYSTEM) {
      if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER ||
              await RcSysChk.rcCheckQCJCSystem()) &&
          (RcCatalina.cmCatalinaSystem(1) || RcSysChk.cmRealItmSendSystem())) {
        switch (eTendType) {
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_TEND_AMOUNT:
          case TendType.TEND_TYPE_POST_TEND_END:
            RcCatalina.rcCatalinaAllSend2(0);
            break;
          default:
            break;
        }
      }
    }
    if (!(await RcFncChk.rcCheckESVoidIMode()) &&
        !(await RcFncChk.rcCheckESVoidSMode())) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        ///TODO:00014 日向　実装対象外？　一旦保留
        // if(rcCheck_SpritMode())
        //   rcATCT_Display(eTendType);
        // else if (rcSG_Dual_SubttlDsp_Chk()) {
        //   if (Subttl.sg_stlframe != NULL)
        //     gtk_widget_destroy(Subttl.sg_stlframe);
        //   Subttl.sg_stlframe = NULL;
        //   if (Subttl.sg_pixmap != NULL)
        //     gtk_widget_destroy(Subttl.sg_pixmap);
        //   Subttl.sg_pixmap = NULL;
        //   DualDsp.chgprc_dsp_flg = 1;
        //   rcSG_AcbPixmap_Disp();
        //   rcStlLcd_TendChange(TDC_SPDATA, &Subttl);
        //   rcStlLcd_Change(CT_CLEAR, &Subttl);
        //   if (rcChk_SQRC_Ticket_System())
        //     rcSQRC_Send_Data(SQRC_NORMAL_PRINT);
        // }
      } else if (await RcSysChk.rcQCChkQcashierSystem()) {
        qcFncCd = cMem.stat.fncCode;
        switch (eTendType) {
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_TEND_AMOUNT:
            if (RcSysChk.rcChkUsePointSelfSystem() &&
                RcFncChk.rcQCCheckCogcaPointMode() &&
                RcMbrPcom.rcmbrGetManualRbtKeyCdForPointUse() !=
                    FuncKey.KY_MEMSRV.keyId) {
              RcQcDsp.rcQCPayEndDisp();
            } else {
              RcQcDsp.rcQCCashEndDisp2(0);
            }
            break;
          case TendType.TEND_TYPE_SPRIT_TEND:
            RcQcDsp.rcQCMenteSpritInfoCreate();
            break;
          default:
            break;
        }
      } else {
        //   rcATCT_Display(eTendType);
      }
    } else {
      //   rcATCT_Display(eTendType);
    }

    if (!await RcFncChk.rcCheckESVoidIMode() &&
        !await RcFncChk.rcCheckESVoidSMode()) {
      if (!RcAtct.rcATCTChkTendType(eTendType!)) {
        if (CompileFlag.IWAI) {
          if (await RcSysChk.rcChkORCSystem() && atSingl.useRwcRw == 1) {
            RcOrcCom.rcOrcDisableProc();
          }
        }
        RcClsCom.clsComAcxCoinBillOut(eTendType, acrErrno);
        RcAtct.rcATCTEnd(eTendType!, cMem.stat.fncCode);
        cMem.stat.eventMode = 0;
        RcIfEvent.rxChkTimerAdd();
        return;
      }
    }

    if (mem.tTtllog.t100900Sts.rwcWriteFlg == 1) {
      mem.tTtllog.t100900Sts.rwcWriteFlg = 0;
    } else if (CompileFlag.DEPARTMENT_STORE &&
        await CmCksys.cmDepartmentStoreSystem() != 0 &&
        (mem.tTtllog.calcData.card1timeAmt != 0 ||
            mem.tmpbuf.opeModeFlgBak != 0)) {
      switch (eTendType) {
        case TendType.TEND_TYPE_NO_ENTRY_DATA:
        case TendType.TEND_TYPE_TEND_AMOUNT:
        case TendType.TEND_TYPE_POST_TEND_END:
          RcItmDsp.rcDualConfDestroy();
        default:
          break;
      }
    }
    // 返品操作時は結果ダイアログを表示
    if (RcAtct.rcATCTChkTendType(eTendType!)) {
      RckyRfdopr.rcRfdOprDispResultDlg();
    }
    if (RcSysChk.rcChkShopAndGoDeskTopSystem() && mem.qcSaGDataSetflg != 0) {
      ret = RcqrCom.rcSaGBasketServerUpload(
          RcBascketServer.SHOP_A_GO_CART_STS_POS_PAY);
      RcqrCom.rcSaGCR50SNDApiFixedSalseSetCartID();
      if (ret == Typ.OK) {
        RcqrCom.rcSaGCR50SNDApiFixedSalesGet();
        log = "rc_SaG_CR50_SNDApiFixedSales_Get() executed.";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else {
        tsBuf.basketServer.rcv_api_fixed_sales.result = -1;
        log = sprintf(
            "rc_SaG_CR50_SNDApiFixedSales_Get() not executed. rc_SaG_BasketServer_Upload() ret = [%d]",
            [ret]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
      mem.qcSaGDataSetflg = 0; // 卓上機にてShop&Go商品読込フラグをリセットする。
    }
    RcIfEvent.rxTimerAdd();

    if (CompileFlag.SAPPORO) {
      if (await CmCksys.cmPanaMemberSystem() != 0 &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0 &&
          atSingl.useRwcRw == 1) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount14);
      } else if (await CmCksys.cmRainbowCardSystem() != 0 &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0 &&
          atSingl.useRwcRw == 1) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount14);
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount1_2", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount1_2");
        }
      }
    }
    if (await RcSysChk.rcChkFelicaSystem() &&
        cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount15);
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcCashAmount1_2", cMem.ent.errNo);
        cMem.stat.eventMode = 0;
        await RcExt.rxChkModeReset("rcCashAmount1_2");
      }
    }
    if (CompileFlag.MC_SYSTEM) {
      if (RcSysChk.rcChkMcSystem() && atSingl.useRwcRw == 1) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount12);
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount1_2", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount1_2");
        }
      }
    }
    if (await CmCksys.cmOrderModeSystem() != 0 && RcSysChk.rcODOpeModeChk()) {
      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5);
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcCashAmount1_2", cMem.ent.errNo);
        cMem.stat.eventMode = 0;
        await RcExt.rxChkModeReset("rcCashAmount1_2");
      }
    }
    if (CompileFlag.POINT_CARD) {
      if (await RcSysChk.rcChkPointCardSystem() && atSingl.useRwcRw == 1) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount11);
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount1_2", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount1_2");
        }
      }
    }
    if (CompileFlag.REWRITE_CARD) {
      if (await RcSysChk.rcChkMcp200System() &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount16);
      } else if (await RcSysChk.rcChkVMCSystem() &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount17);
      } else if (await RcSysChk.rcChkHt2980System() &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0 &&
          atSingl.useRwcRw == 1) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount18);
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount1_2", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount1_2");
        }
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount5()
  Future<void> rcCashAmount5() async {
    int webrealFlg = 0;
    RcGtkTimer.rcGtkTimerRemove();
    // FELICA_SMT常時0のため、下記処理の実装は割愛
    // if(! rcChk_Felica_System()) {
    if (CUSTREALSVR &&
        (RcSysChk.rcChkCustrealsvrSystem() ||
            await RcSysChk.rcChkCustrealNecSystem(0) ||
            RcSysChk.rcChkCustrealUIDSystem() != 0 ||
            RcSysChk.rcChkCustrealOPSystem() ||
            (atSingl.webrealData.addStat == 2) ||
            (RcSysChk.rcChkCustrealPointartistSystem() != 0) ||
            (RcSysChk.rcChkCustrealPointTactixSystem() != 0) ||
            (RcSysChk.rcChkCustrealPointInfinitySystem())) &&
        custrealMbrUpdate) {
      custrealMbrUpdate = false;
    } else if (CUSTREALSVR &&
        (await CmCksys.cmNimocaPointSystem() != 0) &&
        custrealMbrUpdate) {
      custrealMbrUpdate = false;
    } else if (CUSTREALSVR &&
        RcSysChk.rcChkTpointSystem() != 0 &&
        (custrealMbrUpdate)) {
      custrealMbrUpdate = false;
    } else {
      if ((RcSysChk.rcChkCustrealWebserSystem()) &&
          (mem.tTtllog.t100700.mbrInput == MbrInputType.magcardInput.index) &&
          (atSingl.webrealData.addStat == 1)) {
        webrealFlg = 1;
        atSingl.webrealData.func = rcCashAmount5_1;
        atSingl.webrealData.addErr = 0;
      }
      await RcClsCom.clsComMbrUpdate(eTendType);
      if ((webrealFlg != 0) && (atSingl.webrealData.addStat != 0)) {
        return;
      }
    }
    await rcCashAmount5_1();
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount5_1()
  Future<void> rcCashAmount5_1() async {
    if (CompileFlag.REWRITE_CARD &&
        CompileFlag.IWAI &&
        (await RcSysChk.rcChkTRCSystem() || await RcSysChk.rcChkORCSystem()) &&
        (atSingl.useRwcRw == 1)) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount10);
    } else if (CompileFlag.REWRITE_CARD &&
        !CompileFlag.IWAI &&
        (await RcSysChk.rcChkTRCSystem()) &&
        (atSingl.useRwcRw == 1)) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount10);
    } else if (CompileFlag.REWRITE_CARD && await RcSysChk.rcChkFelicaSystem()) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount10);
    } else if (CompileFlag.REWRITE_CARD &&
        (await RcSysChk.rcChkMcp200System()) &&
        (cBuf.dbTrm.felicaWrBeforeReceipt == 0)) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount16);
    } else if (CompileFlag.VISMAC &&
        (await RcSysChk.rcChkVMCSystem()) &&
        (atSingl.useRwcRw == 1)) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount10);
    } else if (CompileFlag.SAPPORO &&
        (await RcSysChk.rcChkSapporoPanaSystem() ||
            await RcSysChk.rcChkJklPanaSystem() ||
            (await CmCksys.cmRainbowCardSystem() != 0 &&
                (cBuf.dbTrm.felicaWrBeforeReceipt == 0)) ||
            (await CmCksys.cmPanaMemberSystem() != 0 &&
                (cBuf.dbTrm.felicaWrBeforeReceipt == 0)) ||
            await CmCksys.cmMoriyaMemberSystem() != 0) &&
        (atSingl.useRwcRw == 1)) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount14);
    } else if (CompileFlag.PW410_SYSTEM && RcSysChk.rcChkPW410System()) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount10);
    } else if ((await RcSysChk.rcChkAbsV31System()) &&
        (atSingl.useRwcRw == 1)) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount19);
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
    }

    if (cMem.ent.errNo != 0) {
      cMem.stat.eventMode = 0;
      await RcExt.rcErr('rcCashAmount5_1', cMem.ent.errNo);
      await RcExt.rxChkModeReset('rcCashAmount5_1');
    }

    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_BC_Before()
  Future<void> rcCashAmount1_BC_Before() async {
    // TODO:00011 周 便宜上、一時的rcCashAmount1_2_0()に固定
    await rcCashAmount1_2_0();
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_dsp_Before()
  Future<void> rcCashAmount1_dsp_Before() async {
    // TODO:00011 周 便宜上、一時的rcCashAmount1_2_0()に固定
    await rcCashAmount1_2_0();
  }

  /// 関連tprxソース:rckycash.c - rcCash_Department()
  Future<int> rcCashDepartment() async {
    if (CompileFlag.DEPARTMENT_STORE) {
      int fncCode = 0;
      String log = '';
      RegsMem mem = SystemFunc.readRegsMem();
      AcMem cMem = SystemFunc.readAcMem();
      if (!(ReptEjConf.rcCheckRegistration())) {
        return 0;
      }
      fncCode = 0;
      if (!(RcSysChk.rcCheckCrdtStat())) {
        /* 未決（不足状態で置数なしの現計で精算完了） */
        final result = RckyWorkin.rcWorkinChkWorkType(mem.tTtllog);
        switch (WkTyp.getDefine(result)) {
          case WkTyp.WK_ORDER:
          case WkTyp.WK_SCREDIT:
          case WkTyp.WK_CASHDELIVERY:
            if (!RcFncChk.rcChkTenOn()) {
              fncCode = FuncKey.KY_CHA9.keyId;
            }
            break;
          case WkTyp.WK_PLUMVST:
            if (!RcFncChk.rcChkTenOn()) {
              fncCode = FuncKey.KY_CHA10.keyId;
            }
            break;
          default:
            break;
        }
      } else {
        /* クレジット宣言中 */
        if (cMem.stat.departFlg & 0x01 != 0) {
          fncCode = FuncKey.KY_CHA1.keyId;
        } else {
          fncCode = FuncKey.KY_CHA2.keyId;
        }
      }

      if (fncCode != 0) {
        cMem.stat.fncCode = fncCode;
        log = sprintf("FncCode->%d\n", [cMem.stat.fncCode]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        await RckyCha.rcKyCharge();
        return 1;
      }
    }
    return 0;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount6()
  Future<void> rcCashAmount6() async {
    String log;
    int warnNoChk;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    RcGtkTimer.rcGtkTimerRemove();
    if (popWarn == 1) {
      warnNoChk = TprLibDlg.tprLibDlgNoCheck();

      log =
          "__FUNCTION__ : warnNoChk[$warnNoChk] ent.warn_no[${cMem.ent.warnNo}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      if (cMem.ent.warnNo == warnNoChk) {
        // エラーダイアログ表示を消去してしまう為、表示指示したWarn表示と、実際に表示されているWarn表示が同じ場合のみに動作させるようにする
        RcExt.rcWarnPopDownLcd(__FUNCTION__);
      }
    }
    popWarn = 0;
    if ((RcSysChk.rcsyschkRepicaPointSystem()) &&
        (mem.tmpbuf.workInType == 1) &&
        (mem.prnrBuf.repicaPntErr.repicaTargetPrice != 0) &&
        (mem.prnrBuf.repicaPntErr.repicaErrFlg == 1) &&
        (mem.prnrBuf.repicaPntErr.cardType == "M")) {
      await RcExt.rcErr("", DlgConfirmMsgKind.MSG_PLEASE_POINTCORRECT.dlgId);
    }

    if (await CmCksys.cmOrderModeSystem() != 0 &&
        RcSysChk.rcODOpeModeChk() == true) {
      /* 発注モード仕様  & 発注 */
      RcOrder.rcOrderSend(rcCashAmount2);
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount7);
    }
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      await RcIfEvent.rxChkModeReset2(__FUNCTION__);
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount7()
  Future<void> rcCashAmount7() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RcGtkTimer.rcGtkTimerRemove();
    if ((printErr != 0) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      cMem.ent.errNo = printErr;
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      printErr = 0;
      mem.prnrBuf.rprFlg = 1;
    }
    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount8);
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      await RcIfEvent.rxChkModeReset2(__FUNCTION__);
    }
    return;
  }

  // TODO:10128 現計クラウドPOSへ置き換え
  /// 関連tprxソース:rckycash.c - rcCashAmount8()
  Future<void> rcCashAmount8() async {
    // RxCommonBuf cBuf = SystemFunc.readRxCommonBuf();
    // RegsMem mem = SystemFunc.readRegsMem();
    // RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();
    // String log = '';
    // int	printErrSts = 0;
    // int	print1ErrSts = 0;
    // int	print2ErrSts = 0;
    // int	printStep = 0;
    // int	print1Step = 0;
    // int	print2Step = 0;
    //
    //
    // RcGtkTimer.rcGtkTimerRemove();
    // if(continueRprStart(printErr, (void *)rcCashAmount8, (void *)rcCashAmount8) > 0) {
    //   return;
    // }
    // printStep  = (((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->StepCnt);
    // if ((RcRegs.rcInfoMem.rcRecog.recogKitchenPrint != RecogValue.RECOG_NO.index)
    //     || (RcRegs.rcInfoMem.rcRecog.recogKitchenPrintRecipt != RecogValue.RECOG_NO.index)) {
    //   if (cBuf.kitchen_prn1_run != 0) {
    //     print1Step = (((RX_TASKSTAT_PRN *)STAT_print_get_did(TS_BUF,TprDidDef.TPRDIDRECEIPT5))->StepCnt);
    //   }
    //   if (cBuf.kitchen_prn2_run != 0) {
    //     print2Step = (((RX_TASKSTAT_PRN *)STAT_print_get_did(TS_BUF,TprDidDef.TPRDIDRECEIPT6))->StepCnt);
    //   }
    //
    //   if (printStep < print1Step) {
    //     printStep = print1Step;
    //   }
    //   if (printStep < print2Step) {
    //     printStep = print2Step;
    //   }
    // }
    //
    // if ((prnendCnt*RcRegs.PRINT_WAIT_TIME) > ((printStep*1000)/1+10000)) {
    //   log = "rcCashAmount8 time out err. StepCnt=$printStep\n";
    //   TprLog().logAdd(CmCksys.cmQCJCCPrintAid(Tpraid.TPRAID_PRN), LogLevelDefine.error, log);
    //   ((RX_TASKSTAT_PRN *)STAT_print_get(tsBuf))->ErrCode = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
    //   cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
    //   if((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
    //     RcKyesVoid.eSVoidDialogClear();
    //   }
    //   await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
    //   mem.prnrBuf.rprFlg = 1;
    //   if (mem.tTtllog.t100900Sts.rwcWriteFlg == 1 && printErr == 0) {
    //     mem.tTtllog.t100900Sts.rwcWriteFlg = 0;
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.WARN_EVENT, rcCashAmount10_1);
    //   }
    //   else if (((tsBuf.mp1.errCode != 0) || (tsBuf.mp1.mp1Stat > 0)) && (printErr == 0)) {
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9_MP1_Before);
    //   }
    //   else {
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9);
    //   }
    //   if(cMem.ent.errNo != 0) {
    //     if((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
    //       RcKyesVoid.eSVoidDialogClear();
    //     }
    //     await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
    //     RcIfEvent.rxChkModeReset2(__FUNCTION__);
    //   }
    //   return;
    // }
    //
    // printErrSts = ((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->ErrCode;
    // if ((RcRegs.rcInfoMem.rcRecog.recogKitchenPrint != RecogValue.RECOG_NO.index)
    //     || (RcRegs.rcInfoMem.rcRecog.recogKitchenPrintRecipt != RecogValue.RECOG_NO.index)) {
    //   if (cBuf.kitchen_prn1_run != 0) {
    //     print1ErrSts = ((RX_TASKSTAT_PRN *)STAT_print_get_did(TS_BUF,TPRDIDRECEIPT5))->ErrCode;
    //   }
    //   if (cBuf.kitchen_prn2_run != 0) {
    //     print2ErrSts = ((RX_TASKSTAT_PRN *)STAT_print_get_did(TS_BUF,TPRDIDRECEIPT6))->ErrCode;
    //   }
    // }
    //
    // if ((printErrSts != -1)&&(print1ErrSts != -1)&&(print2ErrSts != -1)) {
    //   if ((await RckyRpr.rcCheckAutoRpr(0) != 0) && (printErr != 0)) {
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.PRINT_WAIT_TIME, rcCashAmount8_AutoRpr_PrnChk);
    //     return;
    //   }
    //
    //   printErr = ((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->ErrCode;
    //   if ((RcRegs.rcInfoMem.rcRecog.recogKitchenPrint != RecogValue.RECOG_NO.index)
    //     || (RcRegs.rcInfoMem.rcRecog.recogKitchenPrintRecipt != RecogValue.RECOG_NO.index)) {
    //     if (cBuf.kitchen_prn1_run != 0) {
    //       print1ErrSts = ((RX_TASKSTAT_PRN *)STAT_print_get_did(TS_BUF,TPRDIDRECEIPT5))->ErrCode;
    //     }
    //     if (cBuf.kitchen_prn2_run != 0) {
    //       print2ErrSts = ((RX_TASKSTAT_PRN *)STAT_print_get_did(TS_BUF,TPRDIDRECEIPT6)).ErrCode;
    //     }
    //   }
    //
    //   if ((printErr != 0)||(print1ErrSts != 0)||(print2ErrSts != 0)) {
    //     if (printErr != 0){
    //       cMem.ent.errNo = printErr;
    //     }
    //     else if (print1ErrSts != 0) {
    //       cMem.ent.errNo = print1ErrSts;
    //     }
    //     else if (print2ErrSts != 0) {
    //       cMem.ent.errNo = print2ErrSts;
    //     }
    //
    //     if ((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
    //       RcKyesVoid.eSVoidDialogClear();
    //     }
    //
    //     await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
    //     mem.prnrBuf.rprFlg = 1;
    //   }
    //   else {
    //     if ((acrErrno != 0) &&
    //        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
    //          || (await RcSysChk.rcCheckQCJCSystem()))) {
    //       cMem.ent.errNo = acrErrno;
    //       if ((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
    //         RcKyesVoid.eSVoidDialogClear();
    //       }
    //       if (!((await RcSysChk.rcSGChkSelfGateSystem()) && (mntDsp.sgCashkyFlg == 1))) {
    //         RcKyccin.ccinErrDialog2(__FUNCTION__, cMem.ent.errNo, 0);
    //       }
    //     }
    //   }
    //   if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL)
    //      && (! await RcSysChk.rcSGChkSelfGateSystem())
    //      && (! await RcSysChk.rcQCChkQcashierSystem())) {
    //     if (acbInfo.coinBillOutErr == 1) {
    //       log = "ClsCom_Acx_Result() Error -> rc_drwopen\n";
    //       TprLog().logAdd(RcSysChk.getTid(), LogLevelDefine.normal, log);
    //       acbInfo.coinBillOutErr = 0;
    //       await RcIfPrint.rcDrwopen(); /* drawer open */
    //       cMem.stat.clkStatus |= RcIf.OPEN_DRW;
    //       ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= RcIf.OPEN_DRW;
    //     }
    //   }
    //   if ((await RckyRpr.rcCheckAutoRpr(0) != 0) && (printErr != 0)) {
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.PRINT_WAIT_TIME, rcCashAmount8_AutoRpr_PrnChk);
    //   }
    //   else if (mem.tTtllog.t100900Sts.rwcWriteFlg == 1 && printErr == 0) {
    //     mem.tTtllog.t100900Sts.rwcWriteFlg = 0;
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.WARN_EVENT, rcCashAmount10_1);
    //   }
    //   else if (((tsBuf.mp1.errCode != 0) || (tsBuf.mp1.mp1Stat > 0)) && (printErr == 0)) {
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9_MP1_Before);
    //   }
    //   else {
    //     cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9);
    //   }
    //   if (cMem.ent.errNo != 0) {
    //     if ((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
    //       RcKyesVoid.eSVoidDialogClear();
    //     }
    //     await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
    //     RcIfEvent.rxChkModeReset2(__FUNCTION__);
    //   }
    //   return;
    // }
    // prnendCnt++;
    // cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(RcRegs.PRINT_WAIT_TIME, rcCashAmount8);
    // if (cMem.ent.errNo != 0) {
    //   if ((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
    //     RcKyesVoid.eSVoidDialogClear();
    //   }
    //   await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
    //   RcIfEvent.rxChkModeReset2(__FUNCTION__);
    // }
  }

  // TODO:10128 現計クラウドPOSへ置き換え
  /// 関連tprxソース:rckycash.c - ContinueRprStart()
  int continueRprStart(int err, void funcYes, void funcNo) {
    return 0;
  }

  ///TODO:00014 日向 上の関連ソースと一致するが rcCashAmount2 も存在するのでこちらでは _2 を実装します
  /// 関連tprxソース:rckycash.c - rcCashAmount_2()
  Future<void> rcCashAmount_2() async {
    int custRealSrvFlg = 0;
    int webRealFlg = 0;
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    RcGtkTimer.rcGtkTimerRemove();

    if (CompileFlag.MC_SYSTEM) {
      if (RcSysChk.rcChkMcSystem()) {
        RcPanaCom.rcPanaWriteAfterProc(eTendType);

        ///TODO:00014 日向 定義なし
        // rcIncMCSeqNo(1);
        RcAtct.mcATCTMakeActualLog(eTendType);
      }
    }
    if (CompileFlag.DEPARTMENT_STORE) {
      if (await CmCksys.cmDepartmentStoreSystem() != 0) {
        if (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA ||
            eTendType == TendType.TEND_TYPE_TEND_AMOUNT) {
          RckyWorkin.rcWorkinAfterProc();
        }
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c rcCashAmount_2_sub()
  Future<void> rcCashAmount_2_sub() async {
    if (RF1_SYSTEM && cBuf.vtclRm5900RegsOnFlg) {
      // 百貨店レジ打ち替えバーコード印字チェック
      RckyCha.rcChargeChkStoreRegBarcode();
    }

    mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
    if (RckyRfm.rcChkRfmRcptPrint()) {
      RckyRfm.rcProcRfmAutoSetAmount(1);
      RckyRfm.rcSetPrintDataRfmTaxfree();
    }
    if ((await RcSysChk.rcQCChkQcashierSystem()) &&
        (await RcAcracb.rcCheckAcrAcbON(1) != 0)) {
      if ((mem.tTtllog.t100001.chgAmt == 0) &&
          (!((mem.tTtllog.t100003.refundAmt != 0) &&
              (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0))) &&
          (!((mem.tTtllog.t100003.btlRetAmt != 0) &&
              (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0))) &&
          (!((mem.tmpbuf.notepluTtlamt != 0) &&
              (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)))) {
        printErr = await RcAtctp.rcATCTPrint(eTendType!);
        RcFncChk.rcOpeTime(OpeTimeFlgs.OPETIME_END.index);
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
        RcAssistMnt.rcPayInfoMsgSend(1, 40004, 0);
      }
    } else if (((await RcSysChk.rcChk2800System()) &&
            (await RcSysChk.rcNewSGChkNewSelfGateSystem())) &&
        (await RcAcracb.rcCheckAcrAcbON(1) != 0)) {
      spjPaydspFlg = 0;
      if ((mem.tTtllog.t100001.chgAmt == 0) &&
          (mem.tTtllog.t100003.refundAmt == 0) &&
          (mem.tTtllog.t100003.btlRetAmt == 0)) {
        printErr = await RcAtctp.rcATCTPrint(eTendType!);
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
        RcSpjDsp.rcSPJEndRcptDisp(0);
      }
    } else if ((RcSysChk.rcChkChangeAfterReceipt()) &&
        (await RcAcracb.rcCheckAcrAcbON(1) != 0)) {
//    if((MEM->tTtllog.t100001.chg_amt == 0) && (MEM->tTtllog.t100003.refund_amt == 0) && (MEM->tTtllog.t100003.btl_ret_amt == 0)) {
      if (RxLogCalc.rxCalcStlTaxAmt(mem) >= 0) {
        if (mem.tTtllog.t100001.chgAmt == 0) {
          printErr = await RcAtctp.rcATCTPrint(eTendType!);
          RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
          RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
          RcAssistMnt.rcPayInfoMsgSend(1, 40004, 0);

          if (await RcSysChk.rcChkFselfMain()) {
            RcSet.cashStatReset2(__FUNCTION__);
          }
        }
      }
    } else {
      printErr = await RcAtctp.rcATCTPrint(eTendType!);
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        RcFncChk.rcOpeTime(OpeTimeFlgs.OPETIME_END.index);
      }
      RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
      RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
      RcAssistMnt.rcPayInfoMsgSend(1, 40004, 0);
    }
    // マクロMC_SYSTEMが常に0のため割愛
    // 特殊機種Ht2980の処理も割愛

    if ((await CmCksys.cmOrderModeSystem() != 0) && RcSysChk.rcODOpeModeChk()) {
      /* 発注モード仕様  & 発注 */
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount7);
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5);
    }
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      cMem.stat.eventMode = 0;
      RcIfEvent.rxChkModeReset2(__FUNCTION__);
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount2()
  Future<void> rcCashAmount2() async {
    AcMem cMem = SystemFunc.readAcMem();

    RcGtkTimer.rcGtkTimerRemove();
    RcClsCom.clsComAcxResult(acrErrno);
    switch (RcClsCom.clsComAcxChkStock(acrErrno)) {
      case 0:
        checkCnt = 0;
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.WARN_EVENT, rcCashPopWindow);
        break;
      case 1:
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
        break;
      case 2:
        nearEndEmptyNo = cMem.ent.warnNo;
        cMem.ent.warnNo = 0;
        if (cMem.stat.eventMode == 100) {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.ITMSTL_EVENT, rcCashAmount3);
        } else {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount3);
        }
        break;
      case 3:
        if (cMem.stat.eventMode == 100) {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.ITMSTL_EVENT, rcCashAmount3);
        } else {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount3);
        }
        break;
      case 5:
        if (cMem.stat.eventMode == 100) {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.ITMSTL_EVENT, rcCashAmount5_3);
        } else {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_3);
        }
        break;
      default:
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
    }
    cMem.stat.eventMode = 0;
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcCashAmount2", cMem.ent.errNo);
      await RcExt.rxChkModeReset("rcCashAmount2");
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount9()
  Future<void> rcCashAmount9() async {
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    SgMem selfMem = SgMem();
    StartDsp startDsp = StartDsp();
    SgMntDsp mntDsp = SgMntDsp();

    RcGtkTimer.rcGtkTimerRemove();
    if ((updateErr != 0) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      cMem.ent.errNo = updateErr;
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
    }
    RcAtct.rcATCTEnd(eTendType!, cMem.stat.fncCode);
    if (await RcSysChk.rcSGChkSelfGateSystem() &&
        (await RcSysChk.rcChkRwcSystem()) &&
        (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index) &&
        (selfMem.Staff_Call == 0) &&
        (RcFncChk.rcChkErrNon())) {
      if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
        popWarn = 1;
        cMem.ent.warnNo = DlgConfirmMsgKind.MSG_TEXT88.dlgId;
        RcEwdsp.rcWarn(cMem.ent.warnNo);
        if (mem.tTtllog.t100701.dtipTtlsrv > 0) {
          // TODO:00011 周 音声案内用処理
          // rcSound(SND_0091);
        }
      } else if (!(await RcSysChk.rcChkQuickSelfSystem())) {
        // TODO:00011 周 音声案内用処理
        // rcSound(SND_0093);
      }
    }
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      startDsp.sg_start = 1;
      cMem.acbData.totalPrice = 0; /* add 03.10.07 */
      if ((await RcStlLcd.rcSGDualSubttlDspChk()) &&
          ((await RcSysChk.rcNewSGChkNewSelfGateSystem()) ||
              (await RcSysChk.rcChkQuickSelfSystem()))) {
        if (RcFncChk.rcChkErr() != 0) {
          if (mntDsp.sgCashkyFlg != 1) {
            RcsgDsp.rcSGEndDispBackBtn();
          }
        }
      } else {
        if ((mntDsp.sgCashkyFlg == 1) && (acrErrno == 0)) {
          RcSgCom.rcSGReStartDsp(2000);
        } else if (mntDsp.sgCashkyFlg != 1) {
          RcsgDsp.rcSGEndDispBackBtn();
        }
      }
      if ((RcFncChk.rcChkErrNon()) &&
          (cMem.ent.errNo == 0) &&
          (acrErrno == 0)) {
        if (await RcStlLcd.rcSGDualSubttlDspChk()) {
          if ((await RcSysChk.rcNewSGChkNewSelfGateSystem()) ||
              (await RcSysChk.rcChkQuickSelfSystem())) {
            // TODO:00011 周 gtk処理
            // if (Subttl.newsg_pixcom != null) {
            //   Fb2Gtk.gtkWidgetDestroy(Subttl.newsg_pixcom);
            // }
            // Subttl.newsg_pixcom = null;
            // if (Subttl.newsg_pixmap != null) {
            //   Fb2Gtk.gtkWidgetDestroy(Subttl.newsg_pixmap);
            // }
            // Subttl.newsg_pixmap = null;
            RcAssistMnt.rcAssistSend(31103);

            if ((mem.tTtllog.t100701.dtipTtlsrv > 0) &&
                await CmCksys.cmDcmpointSystem() != 0) {
              log = "Ticket issue [${mem.tTtllog.t100701.dtipTtlsrv}]";
              TprLog()
                  .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
              RcsgDev.rcSGSndGtkTimerAdd(
                  3000, RcNewSgFnc.rcNewSGComTimerGifDsp);
            } else {
              if (!await RcSysChk.rcChkSQRCTicketSystem()) {
                RcNewSgFnc.rcNewSGComTimerGifDsp();
              }
            }
            if (mntDsp.sgCashkyFlg != 1) {
              if (!await RcSysChk.rcChkSQRCTicketSystem()) {
                RcsgDsp.rcSGEndDispBackBtn();
              }
            }
          } else {
            if ((cBuf.iniMacInfo.internal_flg.mode == 4) &&
                (selfMem.sg_trng_lbl != 0)) {
              RcItmDsp.rcDualConfDestroy();
              selfMem.sg_trng_lbl = 1;
            }
            if ((await RcSysChk.rcChkRwcSystem()) &&
                (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
              RcItmDsp.rcDualConf(LRcScdsp.SG_THANKS_MSG_RWDUAL); //メッセージ処理
            } else {
              RcItmDsp.rcDualConf(LRcScdsp.SG_THANKS_MSG_DUAL);
            }
          }
        }

        if (!await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
          if (mntDsp.sgCashkyFlg == 1) {
            RcSgCom.rcSGReStartDsp(2000);
          } else {
            if (!((await RcSysChk.rcChkRwcSystem()) &&
                (mem.tTtllog.t100700.mbrInput !=
                    MbrInputType.nonInput.index))) {
              // TODO:00011 周 音声案内用処理
              // rcSound(SND_0014);
            }
            RcsgDev.rcSGSndGtkTimerRemove();
            // TODO:00011 周 音声案内用処理
            // selfMem.sound_num = (char *)SND_0015;
            if ((await RcSysChk.rcChkRwcSystem()) &&
                (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
              RcsgDev.rcSGSndGtkTimerAdd(5000, RcsgDsp.rcSGThankYouSoundProc);
            } else {
              RcsgDev.rcSGSndGtkTimerAdd(3000, RcsgDsp.rcSGThankYouSoundProc);
            }
          }
        }
      } else {
        if ((mntDsp.mntDsp == 1) &&
            ((mntDsp.sgCashkyFlg == 1) || (acrErrno != 0))) {
          RcKyCncl.rcSGMntEndBtnDelete();
          if (acrErrno != 0) {
            RcSgCom.rcSGReStartDsp(2000);
          }
          mntDsp.sgCashkyFlg = 0;
        }
      }
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      RcQcDsp.rcQCCheckChangeInfo();
    }
    if ((await RcSysChk.rcQCChkQcashierSystem()) &&
        (RcFncChk.rcQCCheckMenteDspMode())) {
      if (RcSysChk.rcsyschkVescaSystem()) {
        if (await RckySus.rcCheckSuspend() == 0) {
          RcQcDsp.rcQCMenteMainBtnEndDisp(4);
        } else {
          RcQcDsp.rcQCMenteMainBtnEndDisp(1);
        }
      } else {
        RcQcDsp.rcQCMenteMainBtnEndDisp(1);
      }
      // TODO:00011 周 gtk処理
      // gtk_widget_show(QC_MenteDsp.end_btn);
      // gtk_widget_show(QC_MenteDsp.endbtn_pixmap);
      RcAssistMnt.rcAssistSend(24008);

      /* AIBOX(商品登録終了) */
      if ((CmCksys.cmAiboxMode() == 1) &&
          (RcsgVfhdDsp.aibox_prog_start_flg == 1)) {
        IfAibox.ifAiboxTotalSend(107, RcsgVfhdDsp.total_scan_cnt);
        IfAibox.ifAiboxSend(106);
        /* AIBOX フラグ・カウンタ リセット */
        RcsgVfhdDsp.total_scan_cnt = 0;
        RcsgVfhdDsp.aibox_prog_stop_flg = 0; // AIBOX 検知プログラムSTOP中(2重通知防止)
        RcsgVfhdDsp.aibox_prog_start_flg = 0;
      }

      if (await RcSysChk.rcChkPrecaTyp() == PRECA_TYPE.PRECA_COGCA.precaTypeCd) {
        if ((RcQcCom.qc_preca_charge_limit_amt > 0) &&
            (await RckySus.rcCheckSuspend() == 0)) {
          //割込みチャージ取引をメンテナンス画面で現金締めした場合
          RcQcDsp.qc_suspend_preca_balance = int.parse(mem
              .tTtllog.t100902Sts.aftTotalBalance); /* チャージ後の残高(再印字用の値)を退避する */
        }
      }
      if (await RcSysChk.rcChkPrecaTyp() == PRECA_TYPE.PRECA_REPICA.precaTypeCd) {
        if ((RcQcCom.qc_preca_charge_limit_amt > 0) &&
            (await RckySus.rcCheckSuspend() == 0)) {
          //割込みチャージ取引をメンテナンス画面で現金締めした場合
          RcQcDsp.qc_suspend_preca_balance =
              mem.tCrdtLog[0].t400000Sts.chaCnt2; /* チャージ後の残高(再印字用の値)を退避する */
        }
      } else if (await RcSysChk.rcChkPrecaTyp() ==
          PRECA_TYPE.PRECA_VALUE.precaTypeCd) {
        if ((RcQcCom.qc_preca_charge_limit_amt > 0) &&
            (await RckySus.rcCheckSuspend() == 0)) {
          //割込みチャージ取引をメンテナンス画面で現金締めした場合
          RcQcDsp.qc_suspend_preca_balance =
              mem.tCrdtLog[0].t400000Sts.chaAmt6; /* チャージ後の残高(再印字用の値)を退避する	*/
        }
      } else if (await CmCksys.cmFipEmoneyStandardSystem() != 0) {
        // FIP標準仕様
        if ((RcQcCom.qc_preca_charge_limit_amt > 0) &&
            (await RckySus.rcCheckSuspend() == 0)) {
          //割込みチャージ取引をメンテナンス画面で現金締めした場合
          RcQcDsp.qc_suspend_preca_balance = int.parse(mem.prnrBuf.ajsEmoneyPrn
              .aftTotalBalance); /* チャージ後の残高(再印字用の値)を退避する */
        }
      }
      if ((RcQcCom.qc_preca_charge_limit_amt > 0) &&
          (await RckySus.rcCheckSuspend() == 0)) {
        //割込みチャージ取引をメンテナンス画面で現金締めした場合
        if (RcQcDsp.qc_fullself_suspend_charge_flg == 1) {
          RcQcDsp.qc_fullself_suspend_charge_flg = 2; // MenteEndでのスタート画面遷移を回避する
        }
      }
    }
    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9_1);
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      await RcIfEvent.rxChkModeReset2(__FUNCTION__);
    }
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount9_1()
  Future<void> rcCashAmount9_1() async {
    int result;
    int popTimer;
    List<int> msg_no_bill = [
      DlgConfirmMsgKind.MSG_ACRBILLFULL.dlgId,
      DlgConfirmMsgKind.MSG_ACRBILLFULL2.dlgId
    ];
    List<int> msg_no_coin = [
      DlgConfirmMsgKind.MSG_ACRCOINFULL.dlgId,
      DlgConfirmMsgKind.MSG_ACRCOINFULL2.dlgId
    ];
    List<int> msg_no_cbill = [
      DlgConfirmMsgKind.MSG_ACRCBILLFULL.dlgId,
      DlgConfirmMsgKind.MSG_ACRCBILLFULL2.dlgId
    ];
    int msgNo = 0;
    int fullFlg = 0;
    RegsMem mem = SystemFunc.readRegsMem();
    RxCommonBuf cBuf = SystemFunc.readRxCommonBuf();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = AtSingl();

    RcGtkTimer.rcGtkTimerRemove();

    if ((await CmCksys.cmReservSystem() != 0 ||
            await CmCksys.cmNetDoAreservSystem() != 0) &&
        RcReserv.rcReservReceiptCall() &&
        !RcFncChk.rcCheckReservMode()) {
      if ((eTendType == TendType.TEND_TYPE_TEND_AMOUNT) ||
          (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA)) {
        RcReserv.rcReservCallUpdate(1);
      }
    } else if (RcFncChk.rcCheckReservMode()) {
      if (RcReserv.rcReservPrnSkipChk()) {
        RcReserv.rcReservPrnEnd(0);
      }
    }

    if (await RcSysChk.rcSGChkSelfGateSystem() &&
        await RcSysChk.rcChkRwcSystem() &&
        (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
      if (popWarn == 1) {
        TprMacro.usleep(2500000);
        RcExt.rcWarnPopDownLcd(__FUNCTION__);
        popWarn = 0;
      }
    }

    if ((await RcAcracb.rcCheckAcrAcbON(1) != 0) &&
        (await RcSysChk.rcChkAcrAcbForgetChange())) {
      if ((result = RckyccinAcb.rcChkPopWindowChgOutWarn(0)) != 0) {
        cBuf.kymenuUpFlg = 2;
        popTimer = await RcAcracb.rcAcrAcbPopTimerCalc(result);
        cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(popTimer, rcCashAmount9_1);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
          await RcIfEvent.rxChkModeReset2(__FUNCTION__);
          cBuf.kymenuUpFlg = 0;

          if (await RcSysChk.rcChkFselfMain()) {
            RcSet.cashStatReset2(__FUNCTION__);
          }
        }
        return;
      }

      if (await RcSysChk.rcChkFselfMain()) {
        RcSet.cashStatReset2(__FUNCTION__);
      }
    }
    msgNo = 1;

    RcIfEvent.rxChkModeReset2(__FUNCTION__);
    cBuf.kymenuUpFlg = 0;
    RckyRfdopr.rcRfdOprDlgBtnUse();

    // RM-3800の場合、印字OFF状態でクレジット伝票を印字することがある。その為、伝票印字後に印字状態を戻す。
    if (cBuf.vtclRm5900RegsOnFlg) {
      Rc59dsp.rc59RctOnOffReset(); // レシート印字条件を戻す
    }

    if ((await RcMbrCom.rcmbrChkStat() != 0) &&
        (RcMbrCom.rcmbrChkCust())) {
      Rcmbrkymbr.rcmbrEndFanfare();
    }
    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin != 0) &&
        (!((await RcSysChk.rcQCChkQcashierSystem()) &&
            (QCashierIni().chg_info ==
                1))) && //QCashierでのに亜エンドによる休止する場合、フルダイアログ表示せずに休止画面に任せる
        (cMem.ent.errNo == 0)) {
      fullFlg = RcAcracb.rcAcrAcbChkNearFull();
      if (fullFlg != AcxDataType.ACX_DATA_NON.id) {
        TprMacro.usleep(50000);
        if (ifSave!.count != 0) {
          // memset((char *)IF_SAVE, 0, sizeof(IF_SAVE)); /*　クリアキーがsaveされていてエラー表示と同時に確認せずに消去されるのを回避 */
        }
        if (fullFlg == AcxDataType.ACX_DATA_COINBILL.id) {
          await RcExt.rcErr(__FUNCTION__, msg_no_cbill[msgNo]);
        } else if (fullFlg == AcxDataType.ACX_DATA_BILL.id) {
          await RcExt.rcErr(__FUNCTION__, msg_no_bill[msgNo]);
        } else {
          await RcExt.rcErr(__FUNCTION__, msg_no_coin[msgNo]);
        }
      }
    }
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      nearendEmptyStopNo = 0;
      if (await RcFncChk.rcCheckAcbStopDsp()) {
        /* 釣銭機指定枚数未満停止仕様 */
        if ((nearendEmptyStopNo = await RcAcracb.rcAcrAcbStopWindowCheck()) !=
            0) {
          nearendEmptyNo = 0;
        }
      }
      if (nearendEmptyNo != 0) {
        TprMacro.usleep(50000);
        if (ifSave!.count != 0) {
          // memset((char *)IF_SAVE, 0, sizeof(IF_SAVE)); /*　クリアキーがsaveされていてエラー表示と同時に確認せずに消去されるのを回避 */
        }
        await RcExt.rcErr(__FUNCTION__, nearendEmptyNo);
        nearendEmptyNo = 0;
      }
      if (nearendEmptyStopNo != 0) {
        TprMacro.usleep(50000);
        if (ifSave!.count != 0) {
          // memset((char *)IF_SAVE, 0, sizeof(IF_SAVE)); /*　クリアキーがsaveされていてエラー表示と同時に確認せずに消去されるのを回避 */
        }
        nearendEmptyStopNo = 0;
        RcAcbStopDsp.rcAcbStopdspDraw();
      }
    }
    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        (await RcSysChk.rcChkAcxDecisionSystem())) {
      cMem.acbData.splitPrice = 0;
    }

    if ((await RcSysChk.rcQCChkQcashierSystem()) &&
        (mem.tTtllog.t100001Sts.qcRfmRcptFlg == 1) &&
        (cBuf.dbTrm.rfmCounterFunc == 0)) {
      RckyRfm.rcQCRfmDataSet();
    }
    if ((RcSysChk.rcSGCheckRfmPrnSystem()) &&
        (tsBuf.chk.sg_rfm_flg == 1) &&
        (cBuf.dbTrm.rfmCounterFunc == 0)) {
      RckyRfm.rcQCRfmDataSet();
    }
    if ((await RcSysChk.rcChkFselfSystem()) &&
        (mem.tTtllog.t100001Sts.qcRfmRcptFlg == 1)) {
      RckyRfm.rcQCRfmDataSet();
      mem.tTtllog.t100001Sts.qcRfmRcptFlg = 0;
    }
    if ((cBuf.dbTrm.qcGetUpdSpeeza != 0) && (mem.prnrBuf.rprServFlg != 0)) {
      RckyRpr.rcKyRpr();
    }

    if ((cBuf.dbTrm.ticketOpeWithoutQs != 0) &&
        (await RcSysChk.rcCheckIndividChange() == false)) {
      RcKyRmod.rcKyRmod();
    }
    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      rcCashBModeEndProc();
    }

    // #if ARCS_MBR
    if (CompileFlag.ARCS_MBR) {
      if (await RcSysChk.rcChkNTTDPrecaSystem() &&
          await RcSysChk.rcQCChkQcashierSystem()) {
        if ((cBuf.dbTrm.qcDispReprintDiag != 0) &&
            (RcQcCom.qc_err_2nderr != DlgConfirmMsgKind.MSG_SETPAPER.dlgId) &&
            (RcQcCom.qc_err_2nderr != DlgConfirmMsgKind.MSG_PAPEREND.dlgId) &&
            (RcQcCom.qc_err_2nderr != DlgConfirmMsgKind.MSG_CUTTERERR.dlgId) &&
            (RcQcCom.qc_err_2nderr != DlgConfirmMsgKind.MSG_CUTTERERR2.dlgId) &&
            (RcQcCom.qc_err_2nderr != DlgConfirmMsgKind.MSG_SETCASETTE.dlgId) &&
            (RcQcCom.qc_err_2nderr != DlgConfirmMsgKind.MSG_PRINTERERR.dlgId)) {
          if (mem.prnrBuf.rprServFlg == 0) {
            if (mem.tmpbuf.autoCallReceiptNo != 0 &&
                mem.tmpbuf.autoCallMacNo != 0) {
              TprDlg.tprLibDlgClear(__FUNCTION__);
              cMem.ent.warnNo = DlgConfirmMsgKind.MSG_WAIT.dlgId;
              RcEwdsp.rcWarnPopUpLcd(cMem.ent.warnNo);
              cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(
                  RcRegs.NORMAL_EVENT, rcCashAmount9_2);
              if (cMem.ent.errNo != 0) {
                await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
                await RcIfEvent.rxChkModeReset2(__FUNCTION__);
              }
              return;
            }
          }
        }
      }
    }
    //endif
    if ((RcSysChk.rcChkTRKPrecaSystem() ||
            RcSysChk.rcChkRepicaSystem() /* Repica_SS */
            ||
            RcSysChk.rcChkValueCardSystem() ||
            RcSysChk.rcChkAjsEmoneySystem() ||
            RcSysChk.rcChkCogcaSystem()) &&
        await RcSysChk.rcQCChkQcashierSystem()) {
      if ((cBuf.dbTrm.qcDispReprintDiag != 0) &&
          ((RcQcCom.qc_err_2nderr == DlgConfirmMsgKind.MSG_SETPAPER.dlgId) ||
              (RcQcCom.qc_err_2nderr == DlgConfirmMsgKind.MSG_PAPEREND.dlgId) ||
              (RcQcCom.qc_err_2nderr ==
                  DlgConfirmMsgKind.MSG_CUTTERERR.dlgId) ||
              (RcQcCom.qc_err_2nderr ==
                  DlgConfirmMsgKind.MSG_SETCASETTE.dlgId) ||
              (RcQcCom.qc_err_2nderr ==
                  DlgConfirmMsgKind.MSG_PRINTERERR.dlgId))) {
        if (ifSave!.count != 0) {
          // スキャンイベントが溜まっている可能性があるので一旦破棄する
          // memset((char *)IF_SAVE, 0, sizeof(IF_SAVE));
        }
        if ((RcQcCom.qc_err_2nderr == DlgConfirmMsgKind.MSG_PRINTERERR.dlgId) ||
            (RcQcCom.qc_err_2nderr == DlgConfirmMsgKind.MSG_SETCASETTE.dlgId)) {
          /* 再発行を促す仕様で上記エラー発生時は自動で次のステップへ進む */
          RcQcDsp.qc_auto_reprint_diag_flg = 1;
          RcEwdsp.rcQCClrKeyProc();
        }
        return;
      }

      if (mem.prnrBuf.rprServFlg == 0) {
        if (mem.tmpbuf.autoCallReceiptNo != 0 &&
            mem.tmpbuf.autoCallMacNo != 0) {
          TprDlg.tprLibDlgClear(__FUNCTION__);
          cMem.ent.warnNo = DlgConfirmMsgKind.MSG_WAIT.dlgId;
          RcEwdsp.rcWarnPopUpLcd(cMem.ent.warnNo);
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9_2);
          if (cMem.ent.errNo != 0) {
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkModeReset2(__FUNCTION__);
          }
          return;
        }
      }
    }
    if ((RcSysChk.rcChkAjsEmoneySystem()) &&
        (RcAjsEmoney.rcAjsEmoneyAutoSusChk() != 0)) {
      if (atSingl.limitAmount != 0) {
        RcKyQcSelect.rcCallSusAjsEmoney(cMem.stat.fncCode);
      }
    }

    if (eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
      RcKyQcSelect.rcScanDlgShow2(__FUNCTION__, 0);
    }

    if ((await CmCksys.cmWsSystem() != 0) &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND) &&
        (await RcMbrCom.rcmbrChkStat() != 0)) {
      RcPromotion.rcpromotionCpnOutputDialog();
      mem.tmpbuf.cpnPrnQty = 0;
      mem.tmpbuf.lotPrnQty = 0;
    }
    Rcmbrrealsvr2.rcCustReal2PTactixErrorCode();

    if (RcSysChk.rcChkVescaCenterConnect(
            VerifoneCencntTyp.VERIFONE_CENCNT_2.idx) !=
        0) {
      if (RcFncChk.rcfncchkCctChargeSystem()) {
        if (!((TprLibDlg.tprLibDlgCheck2(1) != 0) ||
            (RcFncChk.rcChkErr() != 0))) {
          /* チャージ時 */
          if ((tsBuf.jpo.vesca_currentservice == 2) // Edy
                  ||
                  (tsBuf.jpo.vesca_currentservice == 4) // 交通系
                  ||
                  (tsBuf.jpo.vesca_currentservice == 7) // waon
                  ||
                  (tsBuf.jpo.vesca_currentservice == 8) // nanaco
              ) {
            switch (eTendType) {
              case TendType.TEND_TYPE_NO_ENTRY_DATA:
              case TendType.TEND_TYPE_TEND_AMOUNT:
                if ((await RcSysChk.rcCheckQCJCCashier()) ||
                    (await RcSysChk.rcQCChkQcashierSystem()) ||
                    ((await RcSysChk.rcChkSmartSelfSystem()) &&
                        (!await RcSysChk.rcSysChkHappySmile()))) {
                  /* QC画面 */
                  ;
                } else {
                  RcEwdsp.rcErrNoBz(
                      DlgConfirmMsgKind.MSG_VESCA_CHARGE_FINISH.dlgId);
                }
                break;
              default:
                break;
            }
          }
        }
      }
    }
    if (RcSysChk.rcsyschkVescaSystem()) {
      /* チャージ終了後、クリア */
      tsBuf.jpo.vesca_currentservice = 0;
    }

    if ((cBuf.dbTrm.qcDispReprintDiag != 0) &&
        ((RcQcCom.qc_err_2nderr == DlgConfirmMsgKind.MSG_PRINTERERR.dlgId) ||
            (RcQcCom.qc_err_2nderr ==
                DlgConfirmMsgKind.MSG_SETCASETTE.dlgId))) {
      /* 再発行を促す仕様で上記エラー発生時は自動で次のステップへ進む */
      RcQcDsp.qc_auto_reprint_diag_flg = 1;
      RcEwdsp.rcQCClrKeyProc();
    }
    return;
  }

  //TODO 長田 置き換え予定
  /// 関連tprxソース:rckycash.c - rcCashAmount9_2()
  static Future<void> rcCashAmount9_2() async {
    RegsMem mem = SystemFunc.readRegsMem();
    RcGtkTimer.rcGtkTimerRemove();
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "rcCashAmount9_2()\n");

    if (CompileFlag.ARCS_MBR) {
      if (await RcSysChk.rcChkNTTDPrecaSystem() &&
          await RcSysChk.rcQCChkQcashierSystem()) {
        RcKyQcSelect.rcQCAutoCallPreca(
            mem.tmpbuf.autoCallReceiptNo, mem.tmpbuf.autoCallMacNo);
      }
    }
    if (RcSysChk.rcChkTRKPrecaSystem() &&
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcKyQcSelect.rcQCAutoCallTRKPreca(
          mem.tmpbuf.autoCallReceiptNo, mem.tmpbuf.autoCallMacNo);
    }
    if (RcSysChk.rcChkRepicaSystem() &&
        await RcSysChk.rcQCChkQcashierSystem()) {
      /* Repica_SS */
      RcKyQcSelect.rcQCAutoCallRepica(
          mem.tmpbuf.autoCallReceiptNo, mem.tmpbuf.autoCallMacNo);
    }
    if (RcSysChk.rcChkCogcaSystem() && await RcSysChk.rcQCChkQcashierSystem()) {
      RcKyQcSelect.rcQCAutoCallCogca(
          mem.tmpbuf.autoCallReceiptNo, mem.tmpbuf.autoCallMacNo);
    }
    if (RcSysChk.rcChkValueCardSystem() &&
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcKyQcSelect.rcQCAutoCallValueCard(
          mem.tmpbuf.autoCallReceiptNo, mem.tmpbuf.autoCallMacNo);
    }
    if (RcSysChk.rcChkAjsEmoneySystem() &&
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcKyQcSelect.rcQCAutoCallAjsEmoney(
          mem.tmpbuf.autoCallReceiptNo, mem.tmpbuf.autoCallMacNo);
    }
    return;
  }

  /// 関連tprxソース:rckycash.c rcCashAmount3()
  Future<void> rcCashAmount3() async {
    RcGtkTimer.rcGtkTimerRemove();
    if (popWarn == 1) {
      RcExt.rcWarnPopDownLcd(__FUNCTION__);
    }
    popWarn = 0;

    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        (await RcSysChk.rcChkManuDecisionSystem()) &&
        (acrErrno == Typ.OK)) {
      if (!(await RcSysChk.rcSGChkSelfGateSystem())) {
        cMem.acbData.totalPrice = 0;
      }
      if (await RcSysChk.rcChkAutoDecisionSystem()) {
        cMem.acbData.ccinPrice = 0;
      }
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount4);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr('rcCashAmount3', cMem.ent.errNo);
        await RcExt.rxChkModeReset('rcCashAmount3');
      }
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount4);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr('rcCashAmount3', cMem.ent.errNo);
        await RcExt.rxChkModeReset('rcCashAmount3');
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c rcCashAmount4()
  Future<void> rcCashAmount4() async {
    RcGtkTimer.rcGtkTimerRemove();

    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_3);
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr('rcCashAmount3', cMem.ent.errNo);
      await RcExt.rxChkModeReset('rcCashAmount4');
    }
    return;
  }

  /// 関連tprxソース:rckycash.c rcCashAmount4_deccin()
  Future<void> rcCashAmount4Deccin() async {
    if ((RcAcracb.rcAcbInhale()) != Typ.OK) {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_3);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr('rcCashAmount4Deccin', cMem.ent.errNo);
        await RcExt.rxChkModeReset('rcCashAmount4Deccin');
      }
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount4);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr('rcCashAmount4Deccin', cMem.ent.errNo);
        await RcExt.rxChkModeReset('rcCashAmount4Deccin');
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c rcCashAmount4_deccin2()
  Future<void> rcCashAmount4Deccin2() async {
    RcGtkTimer.rcGtkTimerRemove();
    if ((acrErrno = await RcAcracb.rcAcrAcbAnswerReadDtl()) != Typ.OK) {
      if (acrErrno == DlgConfirmMsgKind.MSG_CHARGING.dlgId) {
        RcAcracb.rcResetAcrOdr();
        RcGtkTimer.rcGtkTimerAdd(1, rcCashAmount4Deccin2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr('rcCashAmount4Deccin2', cMem.ent.errNo);
          await RcExt.rxChkModeReset('rcCashAmount4Deccin2');
        }
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_3);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr('rcCashAmount4Deccin2', cMem.ent.errNo);
          await RcExt.rxChkModeReset('rcCashAmount4Deccin2');
        }
      }
    } else {
      cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(1, rcCashAmount4);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr('rcCashAmount4Deccin2', cMem.ent.errNo);
        await RcExt.rxChkModeReset('rcCashAmount4Deccin2');
      }
    }
  }

  /// 関連tprxソース:rckycash.c rcCashPopWindow()
  Future<void> rcCashPopWindow() async {
    ///TODO:00014 日向 定義のみ先行追加
    return;
  }

  /// 関連tprxソース:rckycash.c rcCashAmount10()
  Future<void> rcCashAmount10() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    RcGtkTimer.rcGtkTimerRemove();

    if (await RcSysChk.rcChkTRCSystem() && atSingl.useRwcRw == 1) {
      RcTrcWt.rcTrcWriteMainProc(eTendType);
      atSingl.kAmount = cMem.stat.fncCode;
    } else if (CompileFlag.IWAI) {
      if (await RcSysChk.rcChkORCSystem() &&
          atSingl.useRwcRw == 1 &&
          tsBuf.rwc.order != OrcProcNo.ORC_NOT_ORDER.index &&
          tsBuf.rwc.order != OrcProcNo.ORC_NOT_REST_RCAN_REQ.index &&
          tsBuf.rwc.order != OrcProcNo.ORC_NOT_REST_RCAN_GET.index &&
          tsBuf.rwc.order != OrcProcNo.ORC_NOT_REST_REQ.index &&
          tsBuf.rwc.order != OrcProcNo.ORC_NOT_REST_GET.index) {
        RcOrcWt.rcOrcWriteMainProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      }
    } else if (CompileFlag.VISMAC) {
      if (await RcSysChk.rcChkVMCSystem() &&
          atSingl.useRwcRw == 1 &&
          mem.tTtllog.t100700.mbrInput == MbrInputType.vismacCardInput.index &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
        RcVmcWt.rcVmcWriteMainProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      }
    } else if (CompileFlag.PW410_SYSTEM) {
      if (RcSysChk.rcChkPW410System() &&
          tsBuf.rwc.order == PwProcNo.PW_NOT_ORDER.index) {
        RcPW410Com.rcPW410WriteProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      }
    } else if (await RcSysChk.rcChkFelicaSystem() &&
        (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA ||
            eTendType == TendType.TEND_TYPE_TEND_AMOUNT) &&
        mem.tTtllog.t100700.mbrInput == MbrInputType.felicaInput.index &&
        !(cBuf.dbTrm.felicaWrBeforeReceipt != 0)) {
      RcFeliCa.rcFeliCaWriteProc();
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcCashAmount10", cMem.ent.errNo);
        cMem.stat.eventMode = 0;
        await RcExt.rxChkModeReset("rcCashAmount10");
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmountRwc()
  Future<void> rcCashAmountRwc() async {
    int webRealFlg = 0;
    RcGtkTimer.rcGtkTimerRemoveTrc();
    RcGtkTimer.rcGtkTimerRemove();

    if (CompileFlag.FELICA_SMT) {
      AtSingl atSingl = SystemFunc.readAtSingl();
      RegsMem mem = SystemFunc.readRegsMem();
      if (await RcSysChk.rcChkFelicaSystem() &&
          atSingl.felica_tbl.write_flg == 1) {
        if (RcSysChk.rcChkCustrealWebserSystem() &&
            mem.tTtllog.t100700.mbrInput == MbrInputType.magcardInput.index &&
            atSingl.webrealData.addStat == 1) {
          webRealFlg = 1;
          atSingl.webrealData.func = rcCashAmountRwc_1;
          atSingl.webrealData.addErr = 0;
        }
        await RcClsCom.clsComMbrUpdate(eTendType);
        atSingl.kAmount = 0;
        if (webRealFlg != 0 && atSingl.webrealData.addErr != 0) {
          return;
        }
      }
    }
    await rcCashAmountRwc_1();
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmountRwc_1()
  Future<void> rcCashAmountRwc_1() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    atSingl.kAmount = 0;
    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcCashAmountRwc_1", cMem.ent.errNo);
      cMem.stat.eventMode = 0;
      await RcExt.rxChkModeReset("rcCashAmountRwc_1");
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount14()
  Future<void> rcCashAmount14() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    RcGtkTimer.rcGtkTimerRemove();
    if ((await RcSysChk.rcChkSapporoPanaSystem() ||
            await RcSysChk.rcChkJklPanaSystem() ||
            await CmCksys.cmRainbowCardSystem() != 0 ||
            await CmCksys.cmPanaMemberSystem() != 0 ||
            await CmCksys.cmMoriyaMemberSystem() != 0) &&
        atSingl.useRwcRw == 1 &&
        tsBuf.rwc.order != SapporoPanaProcNo.SAPPORO_PANA_NOT_ORDER.index &&
        tsBuf.rwc.order != SapporoPanaProcNo.SAPPORO_PANA_RESET_CL_REQ.index &&
        tsBuf.rwc.order != SapporoPanaProcNo.SAPPORO_PANA_RESET_CL_GET.index &&
        tsBuf.rwc.order != SapporoPanaProcNo.SAPPORO_PANA_RESET_OT_REQ.index &&
        tsBuf.rwc.order != SapporoPanaProcNo.SAPPORO_PANA_RESET_OT_GET.index &&
        tsBuf.rwc.order != SapporoPanaProcNo.SAPPORO_PANA_RESET_FINISH.index) {
      RcSapporoPanaCom.rcSapporoPanaWriteProc(eTendType);
      atSingl.kAmount = cMem.stat.fncCode;
    } else {
      if (cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
      }
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcCashAmount14", cMem.ent.errNo);
        cMem.stat.eventMode = 0;
        await RcExt.rxChkModeReset("rcCashAmount14");
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount11()
  Future<void> rcCashAmount11() async {
    if (CompileFlag.POINT_CARD) {
      AtSingl atSingl = SystemFunc.readAtSingl();
      AcMem cMem = SystemFunc.readAcMem();
      RegsMem mem = SystemFunc.readRegsMem();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRet.object;

      RcGtkTimer.rcGtkTimerRemove();
      if (await RcSysChk.rcChkPointCardSystem() &&
          atSingl.useRwcRw == 1 &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_NOT_ORDER.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_ERRSTART_STAT_REQ.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_ERRSTART_STAT_GET.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_ERRSTART_REQ.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_ERRSTART_GET.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_STOP_STAT_REQ.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_STOP_STAT_GET.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_STOP_REQ.index &&
          tsBuf.rwc.order != CrwpProcNo.CRWP_RESET_STOP_GET.index) {
        RcCrwpCom.rcCrwpWriteMainProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      } else {
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount11", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount11");
        }
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmountRwc2()
  Future<void> rcCashAmountRwc2() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    RcGtkTimer.rcGtkTimerRemoveTrc();
    RcGtkTimer.rcGtkTimerRemove();

    atSingl.kAmount = 0;
    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcCashAmountRwc2", cMem.ent.errNo);
      cMem.stat.eventMode = 0;
      await RcExt.rxChkModeReset("rcCashAmountRwc2");
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount12()
  Future<void> rcCashAmount12() async {
    if (CompileFlag.MC_SYSTEM) {
      AtSingl atSingl = SystemFunc.readAtSingl();
      AcMem cMem = SystemFunc.readAcMem();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRet.object;

      RcGtkTimer.rcGtkTimerRemove();

      if (RcSysChk.rcChkMcSystem() &&
          atSingl.useRwcRw == 1 &&
          tsBuf.rwc.order != PanaProcNo.PANA_NOT_ORDER.index &&
          tsBuf.rwc.order != PanaProcNo.PANA_RESET_CL_REQ.index &&
          tsBuf.rwc.order != PanaProcNo.PANA_RESET_CL_GET.index &&
          tsBuf.rwc.order != PanaProcNo.PANA_RESET_OT_REQ.index &&
          tsBuf.rwc.order != PanaProcNo.PANA_RESET_OT_GET.index &&
          tsBuf.rwc.order != PanaProcNo.PANA_RESET_FINISH.index) {
        RcPanaCom.rcPanaWriteProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount12", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount12");
        }
      }
      return;
    }
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount10_1()
  Future<void> rcCashAmount10_1() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if (CompileFlag.REWRITE_CARD) {
      RcGtkTimer.rcGtkTimerRemoveTrc();
    }
    RcGtkTimer.rcGtkTimerRemove();

    mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_VMCERR.index;
    printErr = await RcAtctp.rcATCTPrint(eTendType!);
    RcIfEvent.rxTimerAdd();

    if (CompileFlag.VISMAC) {
      atSingl.kAmount = 0;
    }

    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount9);
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcCashAmount10_1", cMem.ent.errNo);
      cMem.stat.eventMode = 0;
      await RcExt.rxChkModeReset("rcCashAmount10_1");
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount15()
  Future<void> rcCashAmount15() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    RcGtkTimer.rcGtkTimerRemove();

    if (await RcSysChk.rcChkFelicaSystem() &&
        cBuf.dbTrm.felicaWrBeforeReceipt != 0 &&
        (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA ||
            eTendType == TendType.TEND_TYPE_TEND_AMOUNT) &&
        mem.tTtllog.t100700.mbrInput == MbrInputType.felicaInput.index) {
      RcFeliCa.rcFeliCaWriteProc();
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcCashAmount15", cMem.ent.errNo);
        cMem.stat.eventMode = 0;
        await RcExt.rxChkModeReset("rcCashAmount15");
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount16()
  Future<void> rcCashAmount16() async {
    if (CompileFlag.REWRITE_CARD) {
      AtSingl atSingl = SystemFunc.readAtSingl();
      AcMem cMem = SystemFunc.readAcMem();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRet.object;

      RcGtkTimer.rcGtkTimerRemove();

      if (await RcSysChk.rcChkMcp200System() &&
          atSingl.useRwcRw == 1 &&
          tsBuf.rwc.order != Mcp200ProcNo.MCP200_NOT_ORDER.index &&
          tsBuf.rwc.order != Mcp200ProcNo.MCP200_RESET_CL_REQ.index &&
          tsBuf.rwc.order != Mcp200ProcNo.MCP200_RESET_CL_GET.index &&
          tsBuf.rwc.order != Mcp200ProcNo.MCP200_EJECT_REQ.index &&
          tsBuf.rwc.order != Mcp200ProcNo.MCP200_EJECT_GET.index &&
          tsBuf.rwc.order != Mcp200ProcNo.MCP200_RESET_FINISH.index) {
        RcMcp200Com.rcMcp200WriteProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      } else {
        if (cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        } else {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount5_2);
        }
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount16", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount16");
        }
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount17()
  Future<void> rcCashAmount17() async {
    if (CompileFlag.REWRITE_CARD) {
      AtSingl atSingl = SystemFunc.readAtSingl();
      AcMem cMem = SystemFunc.readAcMem();
      RegsMem mem = SystemFunc.readRegsMem();

      RcGtkTimer.rcGtkTimerRemove();

      if (await RcSysChk.rcChkVMCSystem() &&
          atSingl.useRwcRw == 1 &&
          mem.tTtllog.t100700.mbrInput == MbrInputType.vismacCardInput.index &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
        RcVmcWt.rcVmcWriteMainProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount17", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount17");
        }
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount18()
  Future<void> rcCashAmount18() async {
    if (CompileFlag.REWRITE_CARD) {
      AtSingl atSingl = SystemFunc.readAtSingl();
      AcMem cMem = SystemFunc.readAcMem();
      RegsMem mem = SystemFunc.readRegsMem();

      RcGtkTimer.rcGtkTimerRemove();

      if (await RcSysChk.rcChkHt2980System() &&
          atSingl.useRwcRw == 1 &&
          mem.tTtllog.t100700.mbrInput == MbrInputType.hitachiInput.index &&
          cBuf.dbTrm.felicaWrBeforeReceipt != 0) {
        RcHt2980Com.rcHt2980WriteProc(eTendType);
        atSingl.kAmount = cMem.stat.fncCode;
      } else {
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
        if (cMem.ent.errNo != 0) {
          await RcExt.rcErr("rcCashAmount18", cMem.ent.errNo);
          cMem.stat.eventMode = 0;
          await RcExt.rxChkModeReset("rcCashAmount18");
        }
      }
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount19()
  Future<void> rcCashAmount19() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    RcGtkTimer.rcGtkTimerRemove();

    if (await RcSysChk.rcChkAbsV31System() &&
        atSingl.useRwcRw == 1 &&
        tsBuf.rwc.order != AbsV31ProcNo.ABS_V31_NOT_ORDER.index &&
        tsBuf.rwc.order != AbsV31ProcNo.ABS_V31_RESET_CL_REQ.index &&
        tsBuf.rwc.order != AbsV31ProcNo.ABS_V31_RESET_CL_GET.index &&
        tsBuf.rwc.order != AbsV31ProcNo.ABS_V31_RESET_FINISH.index) {
      RcAbsV31.rcAbsV31WriteProc(eTendType);
      atSingl.kAmount = cMem.stat.fncCode;
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount_2);
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcCashAmount19", cMem.ent.errNo);
        cMem.stat.eventMode = 0;
        await RcExt.rxChkModeReset("rcCashAmount19");
      }
    }
    return;
  }

  /// 機能: 業務モード仕様の締め終了処理を行う。
  /// 引数: なし
  /// 戻値: なし
  /// 関連tprxソース:rckycash.c - rcCash_BMode_End_Proc()
  Future<void> rcCashBModeEndProc() async {
    if (await CmCksys.cmBusinessModeSystem() != 0 ||
        await CmCksys.cmOrderModeSystem() != 0) {
      RcOrder.rcBModeInitFlgClrPlu();
    }
  }

  /// 機能: 発注、棚卸の現計処理時の個数に関してチェック  個数 0商品は認める
  /// 引数: なし
  /// 戻値: TRUE で処理可能  FALSEでNG
  /// 関連tprxソース:rckycash.c - rcCashChkZeroQtyItem()
  bool rcCashChkZeroQtyItem() {
    int zeroRecord = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    if (mem.tTtllog.t100001.qty != 0) {
      return true; // 個数が 0個ではないのでOK
    }
    for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (mem.tItemLog[i].t10000.itemTtlQty != 0 ||
          mem.tItemLog[i].t10002.scrvoidFlg) {
        continue;
      } else if (mem.tItemLog[i].t10000Sts.corrFlg) {
        zeroRecord--;
        continue;
      }
      zeroRecord++;
    }
    if (zeroRecord > 0) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース:rckycash.c - rcCash_CustRealSvrOffL_DlgClr()
  int rcCashCustRealSvrOffLDlgClr() {
    /// TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
    //TprLibDlg.tprLibDlgClear2("rcCashCustRealSvrOffLDlgClr");
    //rcClearErr_Stat();
    //svr_offline_flg = 0;
    //svr_offline_chkflg = 0;

    /* After ClsCom_Mbr_Update in rcCashAmount_2 */
    rcCashAmount_2_sub();
    return 0;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount20()
  Future<void> rcCashAmount20() async {
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    if ((await CmCksys.cmSuicaSystem() != 0 ||
        await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC) &&
            mem.tTtllog.t100700.mbrInput == MbrInputType.mbrKeyInput.index)) {
      RcIfEvent.rxTimerAdd();
      RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_SUICAREF.keyId);
      if (await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)) {
        atSingl.spvtData.fncCode = cMem.stat.fncCode;
        RcMultiSuicaCom.rcMultiNimocaReadMainProc();
      } else {
        RcSuicaCom.rcSuicaReadMainProc();
      }
    } else {
      rcCashAmount1_1();
    }
    return;
  }

  Future<void> rcCashAmountNimoca() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();

    RcGtkTimer.rcGtkTimerRemoveSuica();
    atSingl.kAmount = 0;
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcCashAmountNimoca", cMem.ent.errNo);
      cMem.stat.eventMode = 0;
      await RcExt.rxChkModeReset("rcCashAmountNimoca");
    }
    return;
  }

  /// 機能：顧客リアル「Ｐアーティスト」仕様時の顧客再読込時のエラー処理後の
  ///　　 　締め処理関数
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース:rckycash.c - rc_partist_err_ChashAmount()
  Future<void> rcPartistErrCashAmount() async {
    TprLibDlg.tprLibDlgClear2("rcPartistErrCashAmount");
    if (await RcFncChk.rcCheckESVoidIMode()) {
      RcKyesVoid.esVoidDialogErr(DlgConfirmMsgKind.MSG_ACTION.dlgId, 2, "");
    }
    await rcCashAmount1_2_0();
    if (await RcFncChk.rcCheckESVoidIMode()) {
      RcKyesVoid.rckyESVEndConfMsg();
    }
    return;
  }

  /// 機能：客層コードセット
  ///　　 　(スマイルセルフの客層キー押下時にはスプールIN前にコードセットを行う)
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース:rckycash.c - rcCash_Set_CustLayer_Code()
  Future<void> rcCashSetCustLayerCode() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY1.keyId])) {
      mem.tTtllog.t100500.custhCd = 1;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY2.keyId])) {
      mem.tTtllog.t100500.custhCd = 2;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY3.keyId])) {
      mem.tTtllog.t100500.custhCd = 3;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY4.keyId])) {
      mem.tTtllog.t100500.custhCd = 4;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY5.keyId])) {
      mem.tTtllog.t100500.custhCd = 5;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY6.keyId])) {
      mem.tTtllog.t100500.custhCd = 6;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY7.keyId])) {
      mem.tTtllog.t100500.custhCd = 7;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY8.keyId])) {
      mem.tTtllog.t100500.custhCd = 8;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY9.keyId])) {
      mem.tTtllog.t100500.custhCd = 9;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CULAY10.keyId])) {
      mem.tTtllog.t100500.custhCd = 10;
    }
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_CpnNGMsg()
  Future<void> rcCashAmount1CpnNGMsg(TendType eTendType) async {
    DlgParam param = DlgParam();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSingl = SystemFunc.readAtSingl();

    mem.tTtllog.t100001Sts.cpnErrDlgFlg = 1;
    atSingl.zhqCpnErrFlg = 1;
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCashAmount1_CpnNGMsgConf : Dlg Disp");

    param.erCode = DlgConfirmMsgKind.MSG_CPN_GIVE_NG.dlgId;
    param.dialogPtn = DlgPattern.TPRDLG_PT2.dlgPtnId;
    param.func1 = rcCashAmount1CpnNGMsg;
    param.msg1 = LTprDlg.BTN_CONF;
    // param.title = LTprDlg.BTN_CONF;
    param.userCode = 0;

    // TODO:10121 QUICPay、iD 202404実装対象外(一旦無視する)
    // TprLibDlg(param);

    if (FbInit.subinitMainSingleSpecialChk()) {
      //param.dualDsp = 3;
      // TprLibDlg(param);
    }
    return;
  }

  /// 関連tprxソース:rckycash.c - rcCashAmount1_CpnNGMsgConf()
  Future<void> rcCashAmount1CpnNGMsgConf() async {
    TprLibDlg.tprLibDlgClear2("rcCashAmount1CpnNGMsgConf");
    await rcCashAmount1_2_0();
    await RcIfEvent.rcWaitSave();

    // TODO:10121 QUICPay、iD 202404実装対象外(一旦無視する)
    // if(IF_SAVE->count)
    // {
    //   memset((char *)IF_SAVE, 0, sizeof(IF_SAVE));
    // }
  }

  /// 関連tprxソース:rckycash.c - rcChk_rcKyCash_MechaKeysCheck()
  Future<int> rcChkrcKyCashMechaKeysCheck() async {
    int errNo = 0;
    if (errNo == 0) {
      errNo = await rcKyCashError(1);
    }
    if (errNo == 0) {
      errNo = await RcAtct.rcAtctProcError2(1);
    }
    return errNo;
  }

  /// 機能: 顧客リアル「PI」仕様のポイント付与時のエラー処理後の
  ///      締め処理関数
  /// 引数: なし
  /// 戻値: なし
  /// 関連tprxソース:rckycash.c - rckycash_PiChashAmount()
  Future<void> rckyCashPiChashAmount() async {
    // TODO:10121 QUICPay、iD 202404実装対象外(一旦無視する)
    /* ダイアログ表示をクリア */
    TprLibDlg.tprLibDlgClear2("rckyCashPiChashAmount");
    /* キー操作のイベントが保持されているかチェック */
    // if ( IF_SAVE->count )
    // {
    //   /* 保持されたイベントの削除 */
    //   memset ((char *)IF_SAVE, 0, sizeof (IF_SAVE));
    // }

    await rcCashAmount1_2_0();
    return;
  }

  /// 関連tprxソース:rckycash.c - rcKyCash_Error()
  Future<int> rcKyCashError(int chkCtrlFlg) async {
    // 初期設定
    int msgNo;
    int errNo;
    int ret;

    if (await RcFncChk.rcCheckERefIMode()) {
      return 0;
    }
    if (await RcFncChk.rcCheckESVoidIMode()) {
      return 0;
    }
    if (await RcFncChk.rcCheckCrdtVoidIMode()) {
      return 0;
    }
    if (await RcFncChk.rcCheckPrecaVoidIMode()) {
      return 0;
    }
    if (RESERV_SYSTEM && RcFncChk.rcCheckReservMode()) {
      return 0;
    }
    // 通番訂正再売ボタン実行中は設定みない
    if (atSingl.rcptCash.status == 2) {
      return (0);
    }
    cMem.keyChkb = List.filled(FuncKey.keyMax + 1, 0xFF);
    if (MC_SYSTEM) {
      RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_MCFEE.keyId);
    }
    if (DEPARTMENT_STORE) {
      RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_WORKIN.keyId);
    }
    if (IC_CONNECT) {
      RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_BRND_CIN.keyId);
    }
    if (chkCtrlFlg != 0) {
      RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_SCRVOID.keyId);
    }
    await RcAtct.rcAtctKyStR(cMem.keyChkb);

    ret = RcFncChk.rcKyStatus(
        cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO2 + RcRegs.MACRO3);
    if (ret != 0) {
      return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) {
      /* CHECK_MULTI */
      return DlgConfirmMsgKind
          .MSG_OPEERR.dlgId; /* CHECK_MULTI : OPERATION ERROR */
    }
    if ((errNo = RcFncChk.rcChkSaleAmtZero()) != 0) {
      return errNo;
    }

    if (chkCtrlFlg == 0) {
      if (RcFncChk.rcCheckChgCinMode()) {
        errNo = RcKyccin.rcCheckAcbFnal();
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if ((await RcSysChk.rcChkAssortSystem()) && (cMem.assort.flg != 0)) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if ((await CmCksys.cmZHQSystem() != 0) &&
        (RcKyCpnprn.rccpnprnPrintResCheck() == -1)) {
      return DlgConfirmMsgKind.MSG_PRINT_WAITING.dlgId;
      //return (MSG_OPEERR);
    }

    if (chkCtrlFlg == 0) {
      if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        if (((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
                (await RcSysChk.rcCheckQCJCSystem())) &&
            (await RcMbrCom.rcmbrChkStat() != 0) &&
            (RcMbrCom.rcmbrChkCust())) {
          msgNo =
              Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_CASH.keyId, RcMbr.RCMBR_WAIT);
          if (msgNo != 0) {
            return msgNo;
          }
        }
      }
    }

    if (MC_SYSTEM) {
      if (RcSysChk.rcChkMcSystem()) {
        // if((rcKy_Self() != KY_CHECKER) && (! Ky_St_C3(CMEM->key_stat[KY_FNAL]))) {
        if (((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
                (await RcSysChk.rcCheckQCJCSystem())) &&
            (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
          errNo = await RcAtct.rcAtctProcError2(1);
          if (errNo != 0) {
            return errNo;
          }
        }
      }
    }

    if (RcSysChk.rcChkCustrealWebserSystem()) {
      // if((rcKy_Self() != KY_CHECKER) && (! Ky_St_C3(CMEM->key_stat[KY_FNAL]))) {
      if (((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
              (await RcSysChk.rcCheckQCJCSystem())) &&
          (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (SIMPLE_2STAFF) {
      if ((cBuf.dbTrm.frcClkFlg == 2) &&
          (await RcSysChk.rcKySelf() == MachineType.kyDualCshr.value) &&
          (!await RcSysChk.rcCheckQCJCFrcClkSystem())) {
        if (cBuf.dbStaffopen.cshr_status == 0) {
          return DlgConfirmMsgKind.MSG_CSHRCLOSE.dlgId;
        }
        if (cBuf.dbStaffopen.chkr_status == 0) {
          return DlgConfirmMsgKind.MSG_CHKRCLOSE.dlgId;
        }
      }
    }

    if ((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
        (await RcSysChk.rcCheckQCJCSystem())) {
      if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
          ((RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 3) ||
              (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 4)) &&
          ((cMem.acbData.totalPrice == 0) && (AcbInfo.recalcPrc == 0)) &&
          ((RxLogCalc.rxCalcStlTaxAmt(mem) > 0) ||
              (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])))) {
        if (RcFncChk.rcChkCCINOperation() == true) {
          if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
            //カスミ仕様
            return DlgConfirmMsgKind.MSG_OPEERR.dlgId; //カスミ要望(2018/08/31)
          } else {
            return DlgConfirmMsgKind.MSG_DECCIN_STAFF_INPUT_ERR.dlgId;
          }
        }
      }
    }

    if (((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
            (await RcSysChk.rcCheckQCJCSystem())) &&
        (cBuf.dbTrm.seikatsuclubOpe != 0) &&
        (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index) &&
        (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      if (mem.tTtllog.t100700Sts.ctrbutionTyp == 1) {
        return DlgConfirmMsgKind.MSG_CHA_UNION.dlgId;
      }
    }

    if (CUSTREALSVR) {
      if ((RcSysChk.rcChkCustrealsvrSystem()) ||
          (await RcSysChk.rcChkCustrealNecSystem(0))) {
        if ((RcMbrRealsvr.custRealSvrWaitChk() != 0) ||
            (RcMcd.rcMcdMbrWaitChk() != 0)) {
          return DlgConfirmMsgKind.MSG_MBRINQUIR.dlgId;
        }
      }
    }

    if ((await RcSysChk.rcChkAssortSystem()) && (cMem.assort.flg != 0)) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if ((await CmCksys.cmOrderModeSystem() != 0) &&
        (RcSysChk.rcODOpeModeChk() == true) &&
        (rcCashChkZeroQtyItem() == false)) {
      /* 業務モード仕様 & 発注 */
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if ((cBuf.dbTrm.disableSplitQcTicket != 0) &&
        (mem.prnrBuf.speezaQrPrintFlg == 1) &&
        (await CmCksys.cmReceiptQrSystem() != 0)) {
      return DlgConfirmMsgKind.MSG_QR_NOTUSE_SPLIT.dlgId;
    }

    if ((await CmCksys.cmSpDepartmentSystem() != 0) &&
        (RcHcardDsp.rcYaoStWorkTyp() == 7001)) {
      errNo = await RcAtct.rcAtctProcError2(1);
      if (errNo != 0) {
        return errNo;
      }
    }

    if (ARCS_MBR) {
      if (await RcSysChk.rcChkNTTDPrecaSystem()) {
        if ((mem.tmpbuf.workInType != 1) &&
            (RcPreca.rcCheckPrecaDepositItem() != 0)) {
          return DlgConfirmMsgKind.MSG_PLS_SLCT_BIZ_TYPE.dlgId;
        }
        if (mem.tmpbuf.workInType == 1) {
          if (RxLogCalc.rxCalcStlTaxAmt(mem) < 0) {
            return DlgConfirmMsgKind.MSG_NOMINUSERR.dlgId;
          }
          errNo = await RcAtct.rcAtctProcError2(1);
          if (errNo != 0) {
            return errNo;
          }
        }
      }
    }

    if (RcSysChk.rcChkTRKPrecaSystem()) {
      if ((mem.tmpbuf.workInType != 1) &&
          (RcTrkPreca.rcCheckTRKPrecaDepositItem(1) != 0)) {
        return DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId;
      }
      if (mem.tmpbuf.workInType == 1) {
        if (RxLogCalc.rxCalcStlTaxAmt(mem) < 0) {
          return DlgConfirmMsgKind.MSG_NOMINUSERR.dlgId;
        }
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (RcSysChk.rcChkRepicaSystem()) {
      if ((mem.tmpbuf.workInType != 1) &&
          (RcRepica.rcCheckRepicaDepositItem(1) != 0)) {
        return DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId;
      }
      if (mem.tmpbuf.workInType == 1) {
        if (RxLogCalc.rxCalcStlTaxAmt(mem) < 0) {
          return DlgConfirmMsgKind.MSG_NOMINUSERR.dlgId;
        }
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (RcSysChk.rcChkCogcaSystem()) {
      if ((mem.tmpbuf.workInType != 1) &&
          (RcCogca.rcCheckCogcaDepositItem(1) != 0)) {
        return DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId;
      }
      if (mem.tmpbuf.workInType == 1) {
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (RcSysChk.rcChkValueCardSystem()) {
      if ((mem.tmpbuf.workInType != 1) &&
          (RcValueCard.rcCheckValueCardDepositItem(1) != 0)) {
        return DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId;
      }
      if (mem.tmpbuf.workInType == 1) {
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (RcSysChk.rcChkAjsEmoneySystem()) {
      if (mem.tmpbuf.workInType != 1 &&
          RcAjsEmoney.rcCheckAjsEmoneyDepositItem(1) != 0) {
        if ((await CmCksys.cmDs2GodaiSystem() != 0) &&
            (RcMbrCom.rcmbrChkCust())) {
          return DlgConfirmMsgKind.MSG_PRECA_IN_ERR_RETRY.dlgId;
        } else {
          return DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId;
        }
      }
      if (mem.tmpbuf.workInType == 1) {
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (await CmCksys.cmBarcodePayChargeSystem() != 0) {
      if ((mem.bcdpay.bar.type == 0) &&
          (RcBarcodePay.rcChkBarcodePayDepositItem(1) != 0)) {
        return DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId;
      }
      if (mem.bcdpay.bar.type != 0) {
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    if (((await CmCksys.cmPfmJrIcChargeSystem() != 0) ||
        (await CmCksys.cmSuicaChargeSystem() != 0))
        && (await RcFncChk.rcChkRegMultiChargeItem(FclService.FCL_SUIC.value, 1) > 0)
        && ((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
        (await RcSysChk.rcCheckQCJCSystem()))) {
      errNo = await RcAtct.rcAtctProcError2(1);
      if (errNo != 0) {
        return errNo;
      }
      if (mem.tmpbuf.multiTimeout != 0) {
        return DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
      }
    } else if (await CmCksys.cmNimocaPointSystem() != 0 &&
        (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index) &&
        ((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      errNo = await RcAtct.rcAtctProcError2(1);
      if (errNo != 0) {
        return errNo;
      } else if (tsBuf.suica.order != SuicaProcNo.SUICA_NOT_ORDER.index) {
        if ((tsBuf.suica.transFlg == 1) || (tsBuf.suica.transFlg == 2)) {
          return DlgConfirmMsgKind.MSG_BUSY_FCLDLL.dlgId;
        } else {
          return DlgConfirmMsgKind.MSG_TEXT14.dlgId;
        }
      }
    }

    if ((RcSysChk.rcChkYtrmSystem()) &&
        (RcFncChk.rcChkRegYumecaChargeItem(1) > 0)) {
      errNo = await RcAtct.rcAtctProcError2(1);
      if (errNo != 0) {
        return errNo;
      }
    }

    if (RcFncChk.rcfncchkCctChargeSystem()) {
      if ((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
          (await RcSysChk.rcCheckQCJCSystem())) {
        errNo = await RcAtct.rcAtctProcError2(1);
        if (errNo != 0) {
          return errNo;
        }
      }
    }

    errNo = RcCashless.rcCashlessKeyChk(cMem.stat.fncCode);
    if (errNo != 0) {
      return errNo;
    }

    if (RcSysChk.rcChkMultiEdySystem() == MultiEdyTerminal.EDY_VEGA_USE.index) {
      if (cBuf.edySeterrFlg == 3) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "cBuf.edySeterrFlg == 3 !!\n");
        return DlgConfirmMsgKind.MSG_CANNOT_PAY_EDY.dlgId;
      }
    }

    // VEGA交通系の処理未了発生時は、特定会計キーでしか決済不可
    if ((await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)) &&
        (mem.tmpbuf.multiTimeout == 2) &&
        (mem.mltsuicaAlarmPayprc != 0)) {
      return DlgConfirmMsgKind.MSG_TEXT99.dlgId;
    }

    if ((RcSysChk.rcsyschkRpointSystem() != 0) &&
        (Rxmbrcom.rxmbrcomChkRpointRead(mem)) &&
        ((await RcSysChk.rcKySelf() != MachineType.kyChecker.value) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      errNo = await RcAtct.rcAtctProcError2(1);
      if (errNo != 0) {
        return errNo;
      }
    }

    return 0;
  }

  Future<void> rcCashAmount5_2() async {
    RcGtkTimer.rcGtkTimerRemove();
    cMem.ent.errNo =
        RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount2);
    if (cMem.ent.errNo != 0) {
      cMem.stat.eventMode = 0;
      await RcExt.rcErr('rcCashAmount5_2', cMem.ent.errNo);
      await RcExt.rxChkModeReset('rcCashAmount5_2');
    }
  }

  Future<void> rcCashAmount5_3() async {
    int result = 0;
    int errorCtrlFlg = 0;
    int popTimer;

    RcGtkTimer.rcGtkTimerRemove();

    if (await RcSysChk.rcQCChkQcashierSystem()) {
    } else if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
      if (!await RcSysChk.rcChk2800System()) {
        rcCashAmount5_4();
        return;
      }
    } else {
      if (!RcSysChk.rcChkChangeAfterReceipt()) {
        rcCashAmount5_4();
        return;
      }
    }

    if (((mem.tTtllog.t100001.chgAmt != 0) ||
            (((mem.tTtllog.t100003.refundAmt != 0) ||
                    (mem.tTtllog.t100003.btlRetAmt != 0)) &&
                (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)) ||
            ((mem.tmpbuf.notepluTtlamt != 0) &&
                (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0))) &&
        (await RcAcracb.rcCheckAcrAcbON(1) != 0)) {
      // 返品、返瓶混在時且つ、合計金額０円の場合、レシートが２枚印字されてしまう（rcCashAmount_2_subで先に印字が動作しているから）
      if (await RcSysChk.rcChkFselfMain()) {
        // 元々のプログラムの意図が掴めないので、スマイルセルフの場合のみケアする
        if (((mem.tTtllog.t100003.refundAmt != 0) ||
                (mem.tTtllog.t100003.btlRetAmt != 0) ||
                (mem.tmpbuf.notepluTtlamt != 0)) &&
            (RxLogCalc.rxCalcStlTaxAmt(mem) == 0)) {
          rcCashAmount5_4();
          return;
        }
      }

      // 取り忘れのチェック前に釣銭機のエラーが発生していないか確認する
      if (acrErrno != 0) {
        // 釣銭機でエラーが発生している
        if (!(RcSysChk.rcChkChangeAfterReceipt())) {
          // この仕様の場合はエラーを表示しない
          if ((await RcSysChk.rcQCChkQcashierSystem())
              && ((acrErrno == DlgConfirmMsgKind.MSG_TEXT126.dlgId)
                  || (acrErrno == DlgConfirmMsgKind.MSG_TEXT127.dlgId)
                  || (acrErrno == DlgConfirmMsgKind.MSG_TEXT141.dlgId)
                  || (acrErrno == DlgConfirmMsgKind.MSG_TEXT143.dlgId)
                  || (acrErrno == DlgConfirmMsgKind.MSG_TEXT144.dlgId))) {
            // リジェクト関係のエラーの場合
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "$__FUNCTION__ : Err Change acrErrno[$acrErrno]->[$DlgConfirmMsgKind.MSG_TEXT250.dlgId]\n");
            acrErrno = DlgConfirmMsgKind.MSG_TEXT250.dlgId; // お釣りが正常に出ているかわからないため、精算機の場合メッセージを変更する
          }
          cMem.ent.errNo = acrErrno;
          RcKyccin.ccinErrDialog2(__FUNCTION__, cMem.ent.errNo, 0); // エラーを表示のため、QCのrcChkPopWindow_ChgOutWarnのresultは｢1｣になる
          await RcIfEvent.rxChkModeReset2(__FUNCTION__);
          cBuf.kymenuUpFlg = 0;
          acrErrno = 0;
        }
      }

      if (((result = RckyccinAcb.rcChkPopWindowChgOutWarn(0)) != 0)
          || (acrErrno != 0)
          || ((CmCksys.cmAcxErrGuiSystem() != 0) && (RcFncChk.rcCheckChgErrMode()))
          || ((await RcSysChk.rcQCChkQcashierSystem()) && (RcQcDsp.rcQCChkErr() != 0))
          || (RcFncChk.rcChkErr() != 0)) {
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          cBuf.kymenuUpFlg = 2;
          popTimer = await RcAcracb.rcAcrAcbPopTimerCalc(result);
          cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(popTimer, rcCashAmount5_3);
        } else if ((await RcSysChk.rcChk2800System()) &&
            (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {
          RcSpjDsp.rcSPJEndRcptDisp(1);
          if (spjPaydspFlg == 0) {
            RcNewSgFnc.rcNewSGComTimerGifDsp();
          }
          spjPaydspFlg = 1;
          cBuf.kymenuUpFlg = 2;
          cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(1000, rcCashAmount5_3);
//			  cMem.ent.errNo = rcGtkTimerAdd(6000, rcCashAmount5_3);
        } else {
          if (RcSysChk.rcChkChangeAfterReceipt()) {
            if (acrErrno != 0) {
              cBuf.kymenuUpFlg = 0;
              errorCtrlFlg = 1;
            } else {
              cBuf.kymenuUpFlg = 2;
              if (await RcSysChk.rcChkFselfMain()) {
//						  cMem.ent.errNo = rcGtkTimerAdd(500, rcCashAmount5_3); // レシート印字が遅いと言われるのでチューニング
                if (qCashierIni!.chgWarnTimerUse == 1) {
                  if (qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 == 0) {
                    qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 = 2;
                  }
                  else if (qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 > 10) {
                    qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 = 10;
                  }
                  cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(
                      qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 * 200, rcCashAmount5_3);
                } else {
                  cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(100, rcCashAmount5_3); // 再度、チューニング
                }
              } else {
                cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(1000, rcCashAmount5_3);
              }
            }
          }
        }

        if (errorCtrlFlg == 0) {
          if (cMem.ent.errNo != 0) {
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkModeReset2(__FUNCTION__);
            cBuf.kymenuUpFlg = 0;
          }
          return;
        }
      }
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        cMem.stat.fncCode = RcQcDsp.qcFncCd;
        mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
        printErr = await RcAtctp.rcATCTPrint(eTendType!);
        RcFncChk.rcOpeTime(OpeTimeFlgs.OPETIME_END.index);
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
        RcQcDsp.rcQCCashEndDisp2(1);
      }
      else if ((await RcSysChk.rcChk2800System()) &&
          (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {
        RcNewSgFnc.rcNewSGDspGtkTimerRemove();
        RcsgDev.rcSGSndGtkTimerRemove();
        mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
        printErr = await RcAtctp.rcATCTPrint(eTendType!);
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
        RcSpjDsp.rcSPJEndRcptDisp(0);
        spjPaydspFlg = 0;
      } else {
        if (RcSysChk.rcChkChangeAfterReceipt()) {
          mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
          printErr = await RcAtctp.rcATCTPrint(eTendType!);
          RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
          if (errorCtrlFlg == 1) {
            await RcExt.rcErr(__FUNCTION__, acrErrno);
// 締め処理終了後にキー入力が有効になるので、この処理は不要<この処理があると、タイミングでキー入力が有効になるのでバグが発生してしまう>
//               rxChkModeReset();
          }
          if (await RcSysChk.rcChkFselfMain()) {
            await RcSet.cashStatReset2(__FUNCTION__); //Cash_Stat_Reset()
          }
        }
      }

      cBuf.kymenuUpFlg = 0;
      autorprCnt = 0;
      RcAssistMnt.rcPayInfoMsgSend(1, 40004, 0);

      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT * 4, rcCashAmount5_4);
    } else {
      rcCashAmount5_4();
    }
  }

  Future<void> rcCashAmount5_4() async {
    RcGtkTimer.rcGtkTimerRemove();
    if (CompileFlag.MBR_SPEC) {
      // TODO:00011 周 下記C言語のソースコードの文法、解読できませんでした
      // FNC(ATCT_FinalI)();
    }
    if (CompileFlag.TW_2S_PRINTER) {
      if (RcSysChk.rcCheckS2Print() != 0) {
        //if(rcCheck_S2Print() == TRUE)
        cMem.ent.errNo =
            RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount6);
      } else {
        updateErr = await RcAtct.rcATCTUpdate(eTendType!);
        if (cMem.ent.warnNo != 0) {
          popWarn = 1;
          RcEwdsp.rcWarn(cMem.ent.warnNo);
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.WARN_EVENT, rcCashAmount6);
        } else {
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount6);
        }
      }
    } else {
      if (RcqrCom.qrReadSptendCnt > 0) {
        if ((RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_INIT.index) &&
            (await CmCksys.cmMarutoSystem() != 0) &&
            (mem.tTtllog.t100001.chgAmt != 0)) {
          mem.tTtllog.calcData.cardDepositAmt = 1;
        }
        updateErr = RckyQctckt.rcQCDataUpdate(eTendType!);
      }
      updateErr = await RcAtct.rcATCTUpdate(eTendType!);
      if (await RcSysChk.rcCheckWizAdjUpdate() == true) {
        RcqrCom.qrReadSptendCnt = 0;
      }
    }

    RcqrCom.qrReadSptendCnt = 0;

    /* 釣銭釣札機ON & 通番訂正差額設定 */
    if (RcFncChk.rcFncchkRcptAcracbCheck()) {
      /* 釣銭機ON 釣札機ON */
      RcRegs.rcInfoMem.rcCnct.cnctRcptCnct = 0;
    }

    if (cMem.ent.errNo != 0) {
      popWarn = 1;
      RcEwdsp.rcWarn(cMem.ent.errNo);
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.WARN_EVENT, rcCashAmount6);
    } else {
      cMem.ent.errNo =
          RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcCashAmount6);
    }

    if (cMem.ent.errNo != 0) {
      if (popWarn == 1) {
        RcEwdsp.rcWarnPopDownLcd2(__FUNCTION__);
      }
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      await RcIfEvent.rxChkModeReset2(__FUNCTION__);
    }
    return;
  }

  // 「現計」ボタンが押されたときの処理.
  /// 関連tprxソース:rckycash.c rcKyCash()
  Future<(bool, String)> rcKeyCash() async {
    int errNo;
    int lEntry;
    int result = 0;
    int flgCtrl = 0;
    int errCd = 0;
    int p;
    RxInputBuf rxInputBuffer;
    KopttranBuff? kopttran;

    // RM-5900の場合は、計量エリアをクリアする
    if (cBuf.vtclRm5900Flg) {
      // TODO:00011 周 クラスをこのように作るべきかどうかわからない…
      Rc59dsp.rc59ScaleRmScaleAreaClear();
    }

    // ワールドスポーツ様特注機能
    // 電話番号検索の番号入力後の決定操作を「預/現計」でも可能とする。
    if ((await CmCksys.cmWsSystem() != 0)
        && (cMem.stat.fncCode == FuncKey.KY_CASH.keyId)) {
      if ((!RcFncChk.rcCheckTelListMode()) // 電話番号検索結果画面ではない
          && RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId]) // 電話番号キー入力後
          && (RcFncChk.rcChkTenOn())) { // テンキー入力状態
        ifSave = IfWaitSave();
        rxInputBuffer = iBuf;
        rxInputBuffer.funcCode = FuncKey.KY_TEL.keyId;
        await RcIfEvent.rxIfSave(rxInputBuffer, 0);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "$__FUNCTION__ : ws system convert [KY_CASH] >> [KY_TEL]");
        // TODO:00011 周 エラーメッセージの内容が暫定
        return (false, "$__FUNCTION__ : ws system convert [KY_CASH] >> [KY_TEL]");
      }
    }

    if ((await RcMbrCom.rcmbrChkStat() != 0) &&
        (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)) {
      for (p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
        if (RcDepoInPlu.rcChkDepoMbrInPlu(1, p) != 0) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_READ_MBRCARD.dlgId;
          await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, __FUNCTION__);
        }
      }
    }

    /* 同一瓶管理番号チェック */
    if (RcDepoInPlu.rcChkDepoBtlIdChk() == 0) {
      // TODO:00011 周 エラーメッセージの内容が暫定
      return (false, "同一瓶管理番号チェック");
    }

    if (await RcSysChk.rcKySelf() == MachineType.kyDualCshr.value) {
      if (SMART_SELF) {
        if (await RcSysChk.rcChkDesktopCashier()) {
          await RcSet.rcSetCheckerUpdctrlFlg(0); // 初期化＜精算＞
          result = RcFncChk.rcfncchkCheckerUpdctrlFlg();
          if (result == 1) {
            // チェッカータスクでQC指定キーを使用中
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "$__FUNCTION__ : rcfncchkCheckerUpdctrlFlg[$result]\n");
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (
              false,
              "$__FUNCTION__ : rcfncchkCheckerUpdctrlFlg[$result]\n"
            );
          } else {
            flgCtrl = 1;
            await RcSet.rcSetCheckerUpdctrlFlg(1); // セット＜精算＞
          }
        }
      }
      if (tsBuf.cash.int_stat == 1) {
        tsBuf.cash.int_stat = 2;
      }
    }

    /* 予約呼出時の締め操作で、予約情報の再確認 */
    errNo = RcReserv.reservFinishChk(mem.tHeader.reserv_cd);
    if (errNo != 0) {
      cMem.ent.errNo = errNo;
      await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
      // TODO:00011 周 エラーメッセージの内容が暫定
      return (false, "予約情報の再確認NG");
    }

    if (DEPARTMENT_STORE) {
      if (RcSysChk.rcChkDepartmentSystem()) {
        if (await rcCashDepartment() != 0) {
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "rcCashDepartment() NG");
        }
      }
    }

    if (await RcSysChk.rcKySelf() != MachineType.kyChecker.value) {
      int ret = 0;
      if ((ret = RckyAccountReceivable.rcRyuboAccountReceivaleCashChk()) != 0) {
        await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo = ret);
        // TODO:00011 周 エラーメッセージの内容が暫定
        return (false, "rcRyuboAccountReceivaleCashChk() NG");
      }
    }

    if (RF1_SYSTEM) {
      if (1 == await CmCksys.cmRf1HsSystem()) {
        // 特定惣菜仕様(RF様仕様)が「あり」の場合
        if (0 != RcAppendix.rcAppendixChkConfYet()) {
          /* 別添確認済みでない商品が存在する場合 */
          /* 「別添確認未完了の商品があります」 */
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_APPENDIX_ERR.dlgId;
          await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "cmRf1HsSystem() NG");
        }
      }
    }

    RcIfEvent.rxChkTimerRemove();

    if (0 != RcClsCom.clsComAcxAutoDecisionStop()) {
      await RcIfEvent.rxChkTimerAdd();
      // TODO:00011 周 エラーメッセージの内容が暫定
      return (false, "clsComAcxAutoDecisionStop() NG");
    }

    if (RESERV_SYSTEM) {
      if (RcReserv.rcReservItmAddChk()) {
        if ((cMem.ent.errNo = await rcKyCashError(0)) != 0) {
          if (CUSTREALSVR) {
            if ((RcSysChk.rcChkCustrealsvrSystem()) &&
                (cMem.ent.errNo == DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId)) {
              RcMbrRealsvr.rcCustRealOthUseMsgDsp();
            } else {
              await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            }
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "RESERV_SYSTEM CUSTREALSVR ERROR1");
          } else {
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "RESERV_SYSTEM CUSTREALSVR ERROR2");
          }
        }
        RcReserv.rcReserv(mem.tHeader.reserv_flg);
        await RcIfEvent.rxChkTimerAdd();
        // TODO:00011 周 エラーメッセージの内容が暫定
        return (false, "RESERV_SYSTEM rcKyCashError() NG");
      }
    }

    if ((cBuf.dbTrm.disableCashkey1person != 0) &&
        (!(await RcSysChk.rcSGChkSelfGateSystem()))) {
      if ((!await RcFncChk.rcCheckERefIMode()) &&
          (!await RcFncChk.rcCheckESVoidIMode())) {
        if ((cBuf.devId == 2) &&
            (await RcSysChk.rcKySelf() == MachineType.kySingle.value)) {
          /* 「通番訂正」返金ボタン押下時現計動作を行う */
          if (atSingl.rcptCash.status != 2) {
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "「通番訂正」返金ボタン押下");
          }
        }
      }
    }

    cMem.ent.errNo = await rcKyCashError(0);

    if (cMem.ent.errNo != 0) {
      if (CUSTREALSVR &&
          (RcSysChk.rcChkCustrealsvrSystem()) &&
          (cMem.ent.errNo == DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId)) {
        RcMbrRealsvr.rcCustRealOthUseMsgDsp();
        await RcIfEvent.rxChkTimerAdd();
      } else {
        await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
        await RcIfEvent.rxChkTimerAdd();
      }

      mntDsp.sgCashkyFlg = 0;
      if (SMART_SELF) {
        if (flgCtrl == 1) {
          await RcSet.rcSetCheckerUpdctrlFlg(0); // リセット＜精算エラー＞
        }
      }
      // TODO:00011 周 エラーメッセージの内容が暫定
      return (false, "rcKyCashError() NG");
    }

    errCd = RcMbrCom.rcMbrPrcSet(cMem.stat.fncCode, 1);
    if (errCd != 0) {
      if (errCd == DlgConfirmMsgKind.MSG_KANESUE_CANT_PAYMENT.dlgId) {
        // キー入力が許可されなかったので、このエラーの場合だけ処理を分ける
        // else側の処理はオリジナルなので、そのままにしておく
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "$__FUNCTION__: <kanesue> err_cd [$errCd]\n");
        await RcExt.rcErr(__FUNCTION__, errCd);
        await RcIfEvent.rxChkTimerAdd();
      } else {
        RcIfEvent.rxTimerAdd();
      }
      // TODO:00011 周 エラーメッセージの内容が暫定
      return (false, "rcMbrPrcSet() NG");
    }

    if (await RcFncChk.rcCheckERefIMode()) {
      return rcCashAmount();
    }
    if (await RcFncChk.rcCheckESVoidIMode()) {
      return rcCashAmount();
    }

    if (RESERV_SYSTEM && RcFncChk.rcCheckReservMode()) {
      return rcCashAmount();
    }

    if (CUSTREALSVR) {
      if ((RcSysChk.rcChkCustrealsvrSystem()) ||
          (await RcSysChk.rcChkCustrealNecSystem(0)) ||
          (RcSysChk.rcChkCustrealUIDSystem() != 0) ||
          (RcSysChk.rcChkCustrealOPSystem()) ||
          (RcSysChk.rcChkCustrealPointartistSystem() != 0) ||
          (RcSysChk.rcChkTpointSystem() != 0) ||
          (RcSysChk.rcChkCustrealPointTactixSystem() != 0) ||
          (RcSysChk.rcChkCustrealPointInfinitySystem())) {
        /* 顧客リアル[PI]仕様の承認キーが有効かチェック */
        custrealMbrUpdate = false;
      }
    }

    if (await CmCksys.cmNimocaPointSystem() != 0) {
      custrealMbrUpdate = false;
    }

    if ((await RcSysChk.rcKySelf() == MachineType.kyChecker.value) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      if (await RcSysChk.rcChkDesktopCashier()) {
        if (tsBuf.chk.stlkey_retn_function == 0) {
          await RcIfEvent.rxChkTimerAdd();
          if (tsBuf.chk.kycash_redy_flg == 1) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                "KY_CASH : kycash_start_flg Set!!\n");
            RcItmDsp.rcHalfMsgDestroy(0);
            tsBuf.cash.kycash_start_flg = 1;
            tsBuf.chk.kycash_redy_flg = 0;
          }
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "KY_CASH Return Because rcChkDesktopCashier\n");
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "KY_CASH Return Because rcChkDesktopCashier\n");
        } else {
          if (RcSysChk.rcChkAcrAcbAnyTimeCinStart()) {
            // 入金額の表示を０へ更新したい
            cMem.acbData.totalPrice = 0;
            Rc28dsp.rcTabDataDisplay(tabInfo!.dspTab);
          }
        }
      }
      RcKyExtKey.rcKyExtKeyEnd(); /* 2006/10/03 */
      if ((await RcSysChk.rcChkDesktopCashier()) &&
          (await RcSysChk.rcKySelf() == MachineType.kyChecker.value)) {
        rcCashSetCustLayerCode();
      }
      await RcSpoolIn.rcSpoolIn();
      if (!(await RcSysChk.rcChkSmartSelfSystem())) {
        RcKyStfRelease.rcPrgStfReleaseRestore();
        RcKyStfRelease.rcPrgStfReleaseClear();
      }

      if (IC_CONNECT && (cMem.ent.errNo == 0)) {
        RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_BRND_CIN.keyId);
      }

      if ((await CmCksys.cmRainbowCardSystem() != 0) &&
          (cMem.stat.disburseFlg != 0)) {
        cMem.stat.disburseFlg = 0;
        RcItmDsp.rcDualConfDestroy();
      } else if (await CmCksys.cmDepartmentStoreSystem() != 0 &&
          (mem.tTtllog.calcData.card1timeAmt != 0 ||
              mem.tmpbuf.opeModeFlgBak != 0)) {
        RcItmDsp.rcDualConfDestroy();
        if (mem.tmpbuf.opeModeFlgBak != 0) {
          RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);
        }
      }

      if (ARCS_MBR && RcSysChk.rcChkRalseCardSystem()) {
        await RcMcd.rcRalseMcdCrdtRegClr();
      }
      rcCashBModeEndProc();

      if (cMem.ent.errNo == 0) {
        RcKyTab.rcCounterDataChange();
        // todo tabInfo!.dspTab!でnull check errorのため一旦コメントアウト
        //Rc28dsp.rcTabCounterDataSet(tabInfo!.dspTab!);
        //Rc28dsp.rcTabDataDisplay(tabInfo!.nextDspTab);
      }

      if (MC_SYSTEM && (cMem.ent.errNo == 0)) {
        RcKyNorebate.rcNorebateDlgLcd();
      }
      await RcIfEvent.rxChkTimerAdd();

      if (cMem.ent.errNo == 0) {
        if (await RcSysChk.rcChkDesktopCashier()) {
          TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
              "$__FUNCTION__ : call rcKy_Tab1\n");
          RcKyTab1.rcKyTab1();
        }
      }

      if ((cMem.ent.errNo == 0) && RcSysChk.rcChkAjsEmoneySystem()) {
        if (atSingl.limitAmount != 0) {
          //２人制レジ：チャージ後処理
          RcKyQcSelect.rcCallSusAjsEmoney(cMem.stat.fncCode);
        }
      }
    } else if (RcRegs.kyStC3(cMem.keyStat[FuncKey.KY_2.keyId])) {
      /* end of SALES ? */
      await RcFlrda.rcReadKopttran(FuncKey.KY_CASH.keyId, kopttran!);
      if (RcKyPbchg.rckyPbchgRecChk() != 0) {
        kopttran.splitEnbleFlg = 0;
      }
      if ((kopttran.crdtEnbleFlg != 0) &&
          ((!RcSysChk.rcCheckCalcTend()) &&
              (!RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId])))) {
        await RcExt.rcErr(__FUNCTION__, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        await RcIfEvent.rxChkTimerAdd();
        // TODO:00011 周 エラーメッセージの内容が暫定
        return (false, "SALES関連ERROR1");
      } else {
        if (SIMPLE_STAFF &&
            RcKyStf.rcStfPostTend() &&
            (!((CmCksys.cmCoopAIZUSystem() != 0) &&
                (RcSysChk.rcCheckCalcTend())))) {
          await RcExt.rcErr(__FUNCTION__, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          await RcIfEvent.rxChkTimerAdd();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "SALES関連ERROR2");
        }

        if (RESERV_SYSTEM &&
            await CmCksys.cmReservSystem() != 0 &&
            (mem.tmpbuf.reservTyp != 0) &&
            (mem.tmpbuf.reservTyp != RcRegs.RESERV_CALL)) {
          /* 予約呼出以外の操作中の締め操作はエラー */
          await RcExt.rcErr(__FUNCTION__, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          await RcIfEvent.rxChkTimerAdd();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "予約呼出以外の操作中の締め操作");
        }

        if (await RcSysChk.rcSysChkHappySmile() &&
            (atSingl.happyDisplayCalcPostGuidance == 0)) {
          atSingl.happyDisplayCalcPostGuidance = 1;
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "$__FUNCTION__ atSingl.happyDisplayCalcPostGuidance[1]");
        }

        /* 04.02.13 T.habara */
        if (!RcSysChk.rcCheckCalcTend() && (await RcFncChk.rcCheckStlMode())) {
          RcStlDsp.rcStlReTtlLcd(0);
        }
        RcPost.rcPostTend();
      }
    } else {
      if (SIMPLE_STAFF) {
        cBuf.saveStaffCd = int.tryParse(cBuf.dbStaffopen.cshr_cd ?? "") ?? 0;
      }
      if (await RcSysChk.rcChkCOOPSystem() &&
          mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index &&
          cBuf.dbTrm.autoInputCust != 0) {
        RcKyCardForget.rcProcKyCardFgt();
      }
      if (atSingl.webrealData.addStat != 2) {
        atSingl.webrealData.addStat = 0;
        atSingl.webrealData.addErr = 0;
        atSingl.webrealData.func = null;
      }
      if (RcSysChk.rcChkCustrealWebserSystem() &&
          (mem.tTtllog.t100700.mbrInput == MbrInputType.magcardInput.index)) {
        lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);
        if ((((lEntry >= RxLogCalc.rxCalcStlTaxAmt(mem)) || (lEntry == 0))) &&
            (atSingl.webrealData.step != 4)) {
          atSingl.webrealData.addStat = 1;
          atSingl.webrealData.key = cMem.stat.fncCode;
        }
      }

      if (ARCS_MBR &&
          await RcSysChk.rcChkNTTDPrecaSystem() &&
          (mem.tmpbuf.workInType == 1) &&
          (mem.tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCARD)) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          if (!RcFncChk.rcCheckPrecaCharge()) {
            await RcIfEvent.rxChkTimerAdd();
            RcPreca.rcKyPrecaDeposit();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (true, "");
          }
        }
      }

      if (RcSysChk.rcChkTRKPrecaSystem() &&
          (mem.tmpbuf.workInType == 1) &&
          RcCrdtFnc.rcChkSptendCrdtEnbleFlg() == 0) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          await RcIfEvent.rxChkTimerAdd();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (true, "");
        }
      }

      if (RcSysChk.rcChkRepicaSystem() &&
          (mem.tmpbuf.workInType == 1) &&
          RcCrdtFnc.rcChkSptendCrdtEnbleFlg() == 0) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          if (!RcFncChk.rcCheckPrecaCharge()) {
            await RcIfEvent.rxChkTimerAdd();
            RcRepica.rcKyRepicaDeposit();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (true, "");
          }
        }
      }

      if (RcSysChk.rcChkCogcaSystem() &&
          (mem.tmpbuf.workInType == 1) &&
          RcCrdtFnc.rcChkSptendCrdtEnbleFlg() == 0) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          if (!RcFncChk.rcCheckPrecaCharge()) {
            await RcIfEvent.rxChkTimerAdd();
            RcCogca.rcKyCogcaDeposit();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (true, "");
          }
        }
      }

      if (RcSysChk.rcChkValueCardSystem() &&
          (mem.tmpbuf.workInType == 1) &&
          RcCrdtFnc.rcChkSptendCrdtEnbleFlg() == 0) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          if (!RcFncChk.rcCheckPrecaCharge()) {
            await RcIfEvent.rxChkTimerAdd();
            RcValueCard.rcKyValueCardDeposit();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (true, "");
          }
        }
      }

      if (RcSysChk.rcChkAjsEmoneySystem() &&
          (mem.tmpbuf.workInType == 1) &&
          RcCrdtFnc.rcChkSptendCrdtEnbleFlg() == 0 &&
          RcAjsEmoney.rcCheckAjsEmoneyDepositItem(1) != 0) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          if (!RcFncChk.rcCheckPrecaCharge()) {
            await RcIfEvent.rxChkTimerAdd();
            RcAjsEmoney.rcKyAjsEmoneyDeposit();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (true, "");
          }
        }
      }

      if (await CmCksys.cmBarcodePayChargeSystem() != 0 &&
          RcCrdtFnc.rcChkSptendCrdtEnbleFlg() == 0 &&
          RcBarcodePay.rcChkBarcodePayDepositItem(1) != 0) {
        if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_NONE.dlgId;
          await RcIfEvent.rxChkTimerAdd();
          RcBarcodePay.rcKyBarcodePayIn();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (true, "");
        }
        if (mem.bcdpay.bar.type != 0) {
          /* スキャン済 */
          if (!(await RcFncChk.rcCheckESVoidIMode()) &&
              !(await RcFncChk.rcCheckERefIMode()) &&
              !(await RcFncChk.rcCheckERefSMode())) {
            if (!RcFncChk.rcCheckPrecaCharge()) {
              await RcIfEvent.rxChkTimerAdd();
              RcBarcodePay.rcKyBarcodePayDeposit();
              // TODO:00011 周 エラーメッセージの内容が暫定
              return (true, "");
            }
          }
        }
      }

      if ((await CmCksys.cmPfmJrIcChargeSystem() != 0 ||
              await CmCksys.cmSuicaChargeSystem() != 0) &&
          await RcFncChk.rcChkRegMultiChargeItem(FclService.FCL_SUIC.value, 1) > 0) {
        if ((await CmCksys.cmBusinessModeSystem() != 0 &&
                (RcSysChk.rcSROpeModeChk() ||
                    RcSysChk.rcIVOpeModeChk() ||
                    RcSysChk.rcPDOpeModeChk())) ||
            (await CmCksys.cmOrderModeSystem() != 0 &&
                RcSysChk.rcODOpeModeChk())) {
          await RcExt.rcErr(__FUNCTION__, DlgConfirmMsgKind.MSG_OPEMERR.dlgId);
          await RcIfEvent.rxChkTimerAdd();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (true, "");
        } else if (await RcSysChk.rcChkMultiSuicaSystem() ==
            MultiSuicaTerminal.SUICA_PFM_USE.index) {
          atSingl.spvtData.fncCode = cMem.stat.fncCode;
          RcIfEvent.rxTimerAdd();
          RcMultiSuicaCom.rcMultiSuicaMainProc(cMem.stat.fncCode);
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (true, "");
        } else if (await RcSysChk.rcChkSuicaSystem()) {
          if (mem.tTtllog.t100700.mbrInput ==
              MbrInputType.mbrprcKeyInput.index) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "エラーID：2178");
          }
          if ((tsBuf.suica.transFlg == 1) || (tsBuf.suica.transFlg == 2)) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_BUSY_FCLDLL.dlgId;
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "エラーID：2490");
          } else if (tsBuf.suica.order != SuicaProcNo.SUICA_NOT_ORDER.index) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT14.dlgId;
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "エラーID：7044");
          } else if ((await CmCksys.cmTb1System() != 0) &&
              (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
            await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
            await RcIfEvent.rxChkTimerAdd();
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (false, "エラーID：2492");
          }
          atSingl.spvtData.fncCode = cMem.stat.fncCode;
          RcIfEvent.rxTimerAdd();
          RcSuicaCom.rcSuicaReadMainProc();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (true, "");
        } else {
          await RcExt.rcErr(__FUNCTION__, DlgConfirmMsgKind.MSG_OPEMERR.dlgId);
          await RcIfEvent.rxChkTimerAdd();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "エラーID：1150");
        }
      }

      if (!await RcSysChk.rcQCChkQcashierSystem()) {
        // Qcashierの場合は、カードを読み込むタイミングが違う為
        if ((await CmCksys.cmNimocaPointSystem() != 0) &&
            ((await CmCksys.cmSuicaSystem()) != 0 ||
                (await RcSysChk.rcChkMultiVegaPayMethod(
                    FclService.FCL_SUIC)))) {
          lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);
          if (((lEntry >= RxLogCalc.rxCalcStlTaxAmt(mem)) || (lEntry == 0))) {
            if (await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)) {
              if ((mem.tTtllog.t100700.mbrInput ==
                      MbrInputType.mbrprcKeyInput.index) &&
                  (RxLogCalc.rxCalcSuicaAmt(mem) == 0)) {
                if (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT14.dlgId;
                  await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
                  await RcIfEvent.rxChkTimerAdd();
                  // TODO:00011 周 エラーメッセージの内容が暫定
                  return (false, "エラーID：7044");
                }
                rcCashAmount20();
                // TODO:00011 周 rcCashAmount20()の戻り値及び、中身のすべてのreturn処理が改修必要
                return (true, "");
              }
            } else {
              if (await CmCksys.cmNimocaPointSystem() != 0 &&
                  (mem.tTtllog.t100700.mbrInput ==
                      MbrInputType.mbrprcKeyInput.index) &&
                  (mem.tmpbuf.nimocaPointOut == 0) &&
                  (RxLogCalc.rxCalcSuicaAmt(mem) == 0)) {
                if ((tsBuf.suica.transFlg == 1) ||
                    (tsBuf.suica.transFlg == 2) ||
                    ((tsBuf.suica.timeFlg == 1) &&
                        (!(await RcSysChk.rcQCChkQcashierSystem())))) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_BUSY_FCLDLL.dlgId;
                  await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
                  await RcIfEvent.rxChkTimerAdd();
                  // TODO:00011 周 エラーメッセージの内容が暫定
                  return (false, "エラーID：2490");
                } else if (tsBuf.suica.order !=
                    SuicaProcNo.SUICA_NOT_ORDER.index) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT14.dlgId;
                  await RcExt.rcErr(__FUNCTION__, cMem.ent.errNo);
                  await RcIfEvent.rxChkTimerAdd();
                  // TODO:00011 周 エラーメッセージの内容が暫定
                  return (false, "エラーID：7044");
                }
                rcCashAmount20();
                // TODO:00011 周 rcCashAmount20()の戻り値及び、中身のすべてのreturn処理が改修必要
                return (true, "");
              }
            }
          }
        }
      }

      if (RcSysChk.rcChkYtrmSystem() &&
          (RcFncChk.rcChkRegYumecaChargeItem(1) > 0)) {
        if (!(await RcFncChk.rcCheckESVoidIMode()) &&
            !(await RcFncChk.rcCheckERefIMode()) &&
            !(await RcFncChk.rcCheckERefSMode())) {
          RcYumeca.rcYumecaReadMainProc(cMem.stat.fncCode);
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (true, "");
        }
      }

      if (RcFncChk.rcfncchkCctChargeSystem()) {
        if ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk())) {
          if ((!await RcFncChk.rcCheckESVoidIMode()) &&
              !(await RcFncChk.rcCheckERefIMode()) &&
              (!(await RcFncChk.rcCheckERefSMode()))) {
            if (RcSysChk.rcsyschkVescaSystem()) {
              if (await RcSysChk.rcQCChkQcashierSystem()) {
                // 種別指定チャージに対応する為
                RcQcDsp.rcQCDspDestroy();
                RcGcat.rcJmupsMainProc(
                    FuncKey.KY_CASH.keyId, atSingl.cctSettleTyp);
              } else {
                RcKyVescaBal.rckyVescaChargeDialog();
              }
            } else {
              // TODO:00011 周 ここのelseの中の処理はver20230901時点未実装、既存c言語ソースコードには下記のようなコメントが確認できた：
              // JET-Meのチャージ処理を後日追加する
            }
            // TODO:00011 周 エラーメッセージの内容が暫定
            return (true, "");
          }
        } else {
          await RcExt.rcErr(__FUNCTION__, DlgConfirmMsgKind.MSG_OPEMERR.dlgId);
          await RcIfEvent.rxChkTimerAdd();
          // TODO:00011 周 エラーメッセージの内容が暫定
          return (false, "エラーID：1150");
        }
      }

      return await rcCashAmount();
    }

    // 2人制処理中はtrueで返す
    if (await DualCashierUtil.is2Person()) {
      return (true, "");
    }

    // TODO:00011 周 エラーメッセージの内容が暫定
    return (false, "想定外エラー");
  }

  ///  Cash amount 現金での精算処理
  /// 関連tprxソース:rckycash.c rcCashAmount()
  Future<(bool, String)> rcCashAmount() async {
    if (RegsMem().tTtllog.getItemLogCount() <= 0) {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.normal, "CASH:no ttllog item.");
      return (false, "None Ttllog Item Error");
    }
    String callFunc = 'rcCashAmount';

    eTendType = await RcAtct.rcATCTProc(); /* to Common function */

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "RcKeyCash rxMemRead error");
      return (false, "rxMemRead error");
    }
    RxCommonBuf pCom = xRet.object;

    if (RegsMem().lastRequestData == null) {
      // uuidを取得.
      var uuidC = const Uuid();
      // TODO:00001 日向 バージョンは適当.要検討.
      String uuid = uuidC.v4();
      RegsMem().lastRequestData = CalcRequestParaItem(
          compCd: pCom.dbRegCtrl.compCd,
          streCd: pCom.dbRegCtrl.streCd,
          uuid: uuid);
    }

    CalcResultPay retData = await RcClxosPayment.payment(pCom);

    if (0 != retData.retSts) {
      TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error,
          "RcKeyCash ${retData.errMsg}");
      return (false, retData.errMsg ?? "");
    } else {
      // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
      await IfTh.printReceipt(Tpraid.TPRAID_CASH, retData.digitalReceipt, callFunc);
    }

    // memo:プロトタイプ向けに現在の小計額とまったく同じ額を支払うことにする.
    // 小計を再計算する.
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
    // 現金でちょうどお支払い.
    // int payAmount = RegsMem().tTtllog.getSubTtlTaxInAmt();

    CounterJsonFile counterJson = pCom.iniCounter;

    await setData(counterJson, RegsMem().tTtllog.getSubTtlTaxInAmt());

    // ドロアを開く処理.
    IfDrvControl().drwIsolateCtrl.openDrw();

    // TODO:10138 再発行、領収書対応 の為
    await RcAtct.rcATCTEnd(eTendType!, cMem.stat.fncCode);

    // ejへの登録.
    // updateEjLog();
    //
    // counterJson.tran.print_no++;
    // counterJson.tran.receipt_no++;
    // var save = counterJson.save();
    // WebAPIを投げる.実績上げ.

    // レシートの印刷
    // rcSendPrintMain();

    // jsonのsaveが完了するまで待つ.
    //await save;
    return (true, "");
  }

  void rcCashAmount1() async {
    // 後通信処理済みの場合、確認画面はスキップ
    if (await RcLastcomm.rcLastCommChkCommEnd()) {
      rcCashAmount1_1();
      return;
    }

    if (SELF_GATE &&
        (RcSysChk.rcSGCheckRfmPrnSystem()) &&
        (RcsgDsp.mntDsp.mntDsp == 1)) {
      if ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
          (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
        // 画面系の関数で実装は後回し
        // rcSGRfmPrintMsg();
      } else {
        rcCashAmount1_Sub();
      }
    } else if (await RcSysChk.rcChkPromAlert()) {
      if ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
          (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
        RcMbrCom.rcPromAlertMsg(FuncKey.KY_CASH.keyId);
      } else {
        rcCashAmount1_Sub();
      }
    } else {
      rcCashAmount1_Sub();
    }

    return;
  }

  /// データをセットする
  /// MEMO:元ソースではヘッダーログに詰めるが、プロトタイプ向けは直接ejlogにつめる
  /// 関連tprxソース: AplLib_LogCmn_HeaderSet
  Future<void> setData(CounterJsonFile counterJson, int payAmount) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    _data.comp_cd = pCom.dbRegCtrl.compCd;
    _data.stre_cd = pCom.dbRegCtrl.streCd;
    _data.mac_no = pCom.dbRegCtrl.macNo;

    // 元ソースは設定ファイルからメモリに移してそちらを参照している.
    {
      // まだ開設処理がなく、営業日時が取れないので、仮に今の日付を入れておく.
      _data.sale_date = DateUtil.getNowStr(DateUtil.formatDate);
      _data.print_no = counterJson.tran.print_no;
      _data.receipt_no = counterJson.tran.receipt_no;
    }

    // データを入れ終わった後に設定.
    _data.serial_no = await getSerialNo(); //primary
    _data.seq_no = 1;
  }

  Future<String> getPrintMessageData() async {
    bool isWin = Platform.isWindows && !isLinuxDebugByWin();
    String newLine = isWin ? "\x1b|N" : "";
    String lastLine = isWin ? "\x1b|600uF" : "\x1b\x4a\x1E";
    String leftPaddingSpace = "  ";
    String rowStart = newLine + leftPaddingSpace;
    String fontDefault = isWin ? "" : "\x1b\x21\x46\x1c\x21\x72";

    return '''$fontDefault$rowStart営業時間のご案内$rowStart毎日 9:00～21:45まで営業$rowStart平日の特売は10:00から販売$lastLine''';
  }

  Future<String> getSerialNo() async {
    String dateStr = DateFormat('yyyyMMdd')
        .format(DateFormat(DateUtil.formatDate).parse(_data.sale_date!));
    String compStr = _data.comp_cd.toString().padLeft(9, '0');
    String streStr = _data.stre_cd.toString().padLeft(9, '0');
    String macStr = _data.mac_no.toString().padLeft(9, '0');
    String rcptStr = _data.receipt_no.toString().padLeft(4, '0');
    String prtStr = _data.print_no.toString().padLeft(4, '0');
    return dateStr + compStr + streStr + macStr + rcptStr + prtStr;
  }

  /// 電子ジャーナルに保存.
  /// 関連tprxソース:rul_EjEtcKeySet()
  void updateEjLog() {
    if (EnvironmentData().isUseWebAPI) {
      WebAPI webAPI = WebAPI();
      var now = DateTime.now();
      List<CEjLogColumns> postList = <CEjLogColumns>[_data];
      webAPI
          .postEjLog(postList, now.day)
          .then((value) => {
                //成功した.
                TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
                    "CASH:[webApi]EjLog send to WebAPI Success. serialNo:${_data.serial_no}")
              })
          .catchError((e) => {
                TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
                    "CASH:[webApi]EjLog send to WebAPI Failed. serialNo:${_data.serial_no}  ${e.toString()}")
              });
    } else {
      // この後このDBへの処理はないのでawaitしない.
      var db = DbManipulationPs();
      String sql1 =
          "INSERT INTO c_ej_log VALUES(@serial_no,@comp_cd,@stre_cd,@mac_no,@print_no,@seq_no,@receipt_no,@end_rec_flg,@only_ejlog_flg,@cshr_no,@chkr_no,@now_sale_datetime,@sale_date,@ope_mode_flg,@print_data,@sub_only_ejlog_flg,@trankey_search,@etckey_search)";
      Map<String, dynamic>? subValues = {
        "serial_no": _data.serial_no,
        "comp_cd": _data.comp_cd,
        "stre_cd": _data.stre_cd,
        "mac_no": _data.mac_no,
        "print_no": _data.print_no,
        "seq_no": _data.seq_no,
        "receipt_no": _data.receipt_no,
        "end_rec_flg": _data.end_rec_flg,
        "only_ejlog_flg": _data.only_ejlog_flg,
        "cshr_no": _data.cshr_no,
        "chkr_no": _data.chkr_no,
        "now_sale_datetime": _data.now_sale_datetime,
        "sale_date": _data.sale_date,
        "ope_mode_flg": _data.ope_mode_flg,
        "print_data": _data.print_data,
        "sub_only_ejlog_flg": _data.sub_only_ejlog_flg,
        "trankey_search": _data.trankey_search,
        "etckey_search": _data.etckey_search
      };
      db.dbCon.execute(Sql.named(sql1), parameters: subValues);
    }
  }

  /// レシート出力.
  /// 関連tprxソース:rc_Send_Print_Main
  Future<void> rcSendPrintMain() async {
    RegsPrint print = RegsPrint(Tpraid.TPRAID_PRN);
    // 元ソースでは情報をメモリに入れて別プロセスを呼び出し.
    // レシート印字は、レシートロゴ（bmp）＋timestamp（JST）＋レシートNo.＋　合計額（横２倍印字） ＋　バーコード印字（固定のCODE128）。
    // 　印字タイプの確認
    // ロゴ:receipt.bmp
    // バーコード.

    // プロトタイプ向け簡易処理. 印刷するデータをまとめて送信する
    PrintOutputInfo info = PrintOutputInfo();
    info.logo1 = "receipt.bmp";
    info.barcode = print.getBarLineCode(_data);
    info.body = _data.print_data ?? "";
    info.message = await getPrintMessageData();

    IfDrvControl().printIsolateCtrl.printReceiptData(info);

    // 既存POSに合わせた処理.１行１行プリンタに送信する ▼▼
    // // 元ソースでは情報をメモリに入れて別プロセスを呼び出し.
    //     // レシート印字は、レシートロゴ（bmp）＋timestamp（JST）＋レシートNo.＋　合計額（横２倍印字） ＋　バーコード印字（固定のCODE128）。
    //
    //     // ロゴ:if_th_csndlogo.c if_th_cSendLogo_type( TPRTID src, int wLogoNo, char *sLogoFileName, TPRDID did)
    //     // ロゴ:LOGO_LOCAL_FULLNAME = receipt.bmpを渡す.
    //     // ret = if_th_cSendLogo_type (tid, 1, LOGO_LOCAL_FULLNAME, 0);
    //     print.rpPrintLogo(1);
    //     // if_th_HeaderCommonPrint() L1809 if_th_GridString(tid, IF_TH_FW12, 1, 1, 0, 0, 0, headParam->iAFontId, headParam->iKFontId, sLine[num])
    //     // if_th_PrintString (ret = if_th_PrintString(CallAid, wXpos, wYpos, TEST_CHAR_WATTR, font16_e, font16_j, print_buf)
    //     print.rpPrintHeaderLine(
    //         DateUtil.getNowStr(DateUtil.formatForEjJst)); // timestamp
    //     print.rpPrintHeaderLine("レシート番号${_data.receipt_no.toString()}"); // レシートNo
    //     print.rpPrintHeaderLine("　");
    //     print.rpPrintHeaderLine("合計金額 \\${payAmount.toTwoByteString()}");
    //
    //     // バーコード: rp_print.c ;
    //     // rp_Print_BarLine()
    //     // AplLib_BarCodePrn2(cm_QCJC_C_print_aid(TPRAID_PRN), 0, wYpos, IF_TH_PRNATTR_BITMAP, fd12_24_e, fd24_24_j, &BI, MEM->tHeader.prn_typ)// バーコードを生成する数値を決める
    //     // AplLib_BarPrn.c BarCode128C(src, wXpos, wYpos, wAttr, iAFontId, iKFontId, Bi, prn_type);
    //     // ビットマップ式(if_th_Cmd)とそうでない場合ある
    //     // そうでない場合はif_th_PrintLineで左から線を書いていく.
    //     print.rpPrintBarLine(_data);
    //
    //     // レシートカット命令.
    //     //if_th_cCut( tid, 0 )

    return;
  }
}
