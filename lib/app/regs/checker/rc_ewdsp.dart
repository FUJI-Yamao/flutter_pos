/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_barcode_pay.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_aibox/if_aibox.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/menu/register/m_menu.dart';
import '../../ui/page/charge_collect/p_charge_collect.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/full_self/page/p_full_self_callstaff_page.dart';
import '../inc/L_rccrdt.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_59dsp.dart';
import 'rc_auto.dart';
import 'rc_elog.dart';
import 'rc_ext.dart';
import 'rc_ifevent.dart';
import 'rc_key_cash.dart';
import 'rc_netreserv.dart';
import 'rc_qc_dsp.dart';
import 'rc_set.dart';
import 'rcdishcalc.dart';
import 'rcfncchk.dart';
import 'rc_reserv.dart';
import 'rcky_clr.dart';
import 'rcky_eref.dart';
import 'rcky_esvoid.dart';
import 'rcky_evoid.dart';
import 'rcky_qctckt.dart';
import 'rcky_rfm.dart';
import 'rcky_rpr.dart';
import 'rckycpick.dart';
import 'rckycrdtvoid.dart';
import 'rckyprecavoid.dart';
import 'rcmbrkymbr.dart';
import 'rcnewsg_fnc.dart';
import 'rcqc_com.dart';
import 'rcscncarddsp.dart';
import 'rcsg_dev.dart';
import 'rcsg_vfhd_dsp.dart';
import 'rcsyschk.dart';

/// 関連tprxソース:rc_ewdsp.c
class RcEwdsp {

  static const int OFF = 0;
  static const int ON = 1;
  static String errorCd = '';
  static String ut1Err = '';

  static String error_cd = ""; //[4+1];
  static String error_cd2 = ""; // [13+1];
  static String ut1_err = ""; // [32];

  static int qc_2nd_err_flg = 0;
  static int qc_3nd_err_flg = 0;
  static int QCCnclNo = 0; // QCashier仕様時、2ndエラーダイアログまでエラー情報を保つためのもの
  static String qr_txt_err_barcode = ""; // [PBCHG_CD_MAX+1];

  static int qr_tckt_chg_prn = 0;
  static int err_no_2nd = 0;
  static int self_cpn_err_flg = 0;
  static int tomonokai_sag_dispSts = 0;
  static String buf_for_saving_subject_id = ""; // [16];

  /// エラーダイアログを表示する
  /// 引数:[call_func] ログに出力する呼出元関数
  /// 引数:[err_no] エラーダイアログNo
  /// 引数:[toPageFunc] 遷移先画面を表示する関数（SetMenu1クラス）
  /// 関連tprxソース:rc_ewdsp.c - rcErr2
  static Future<void> rcErr2(final String call_func, int err_no, final void Function() toPageFunc) async {
    String log = ""; //[128];
    BackUpDlg dispDlg = BackUpDlg();

    AcMem acMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf c_buf = xRet.object;
    AtSingl atSingle = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    EVoid eVoid = EVoid();
    EsVoid esVoid = SystemFunc.readEsVoid();

    log = " rcErr(${err_no})   call_func : ${call_func}";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    /* AIBOX(AIBOX 検知プログラム一時停止) */
    if ((await CmCksys.cmAiboxSystem() == 1)
        && (RcsgVfhdDsp.aibox_prog_stop_flg == 1) &&
        (RcQcDsp.aiboxSwingErrChkFlg == 0)) {
      IfAibox.ifAiboxSend(108);
    }

    if (await RcSysChk.rcChkSmartSelfSystem()) {
      //#if 1
      if ((RcSysChk.rcChkMultiEdySystem() != 0)
          && (RcFncChk.rcQCCheckEMnyEdyDspMode()
              || RcFncChk.rcQCCheckEMnySlctDspMode())) {
        if ((acMem.stat.bkScrMode == RcRegs.RG_NEWSG_STRBTN)
            || (acMem.stat.bkScrMode == RcRegs.TR_NEWSG_STRBTN)) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              ">>> FAP-10 Edy : ReturnTo FullSelf from rcErr");
          c_buf.iniMacInfo.select_self.qc_mode = 0;
          c_buf.iniMacInfo.select_self.self_mode = 1;
          RcQcCom.qcSlctBtnFlg = 0;
        }
      } else if ((RcSysChk.rcChkQCMultiSuicaSystem() != 0)
          && (RcFncChk.rcQCCheckSuicaChkMode() ||
              RcFncChk.rcQCCheckEMnySlctDspMode()))
        // #else
        //   if ((RcSysChk.rcChkQCMultiSuicaSystem() != 0)
        //   && (RcFncChk.rcQCCheckSuicaChkMode()))
        // #endif
          {
        if ((acMem.stat.bkScrMode == RcRegs.RG_NEWSG_STRBTN)
            || (acMem.stat.bkScrMode == RcRegs.TR_NEWSG_STRBTN)) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              ">>> MultiSuica : ReturnTo FullSelf from rcErr");
          c_buf.iniMacInfo.select_self.qc_mode = 0;
          c_buf.iniMacInfo.select_self.self_mode = 1;
          RcQcCom.qcSlctBtnFlg = 0;
        }
      }

      if (((await RcSysChk.rcChkCogcaSystem())
          || (RcSysChk.rcChkRepicaSystem())
          || (RcSysChk.rcChkValueCardSystem())
          || (await RcSysChk.rcChkAjsEmoneySystem()))
          && (RcFncChk.rcQCCheckEMnyPrecaDspMode() ||
              RcFncChk.rcQCCheckEMnySlctDspMode())) {
        if ((acMem.stat.bkScrMode == RcRegs.RG_NEWSG_STRBTN) ||
            (acMem.stat.bkScrMode == RcRegs.TR_NEWSG_STRBTN)) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              ">>> Preca : ReturnTo FullSelf from rcErr");
          c_buf.iniMacInfo.select_self.qc_mode = 0;
          c_buf.iniMacInfo.select_self.self_mode = 1;
          RcQcCom.qcSlctBtnFlg = 0;
        }
      }
    }

    // RM-3800 フローティング仕様の場合にエラーが発生した場合は、商品加算中状態を解除する。
    if ((c_buf.vtclRm5900RegsOnFlg)
        || (CmCksys.cmChkRm5900FloatingSystem() != 0)) {
      Rc59dsp.rc59FloatingAddItemSet(0);
    }

    if (CompileFlag.COLORFIP) {
      if (RcSysChk.rcCheckCrdtStat()) {
        Rc28StlInfo.rcColorFipDestroyHalfMsg();
      }
    }

    if (await RcSysChk.rcCheckCustomerCardInq()) {
      atSingle.customercardFlg = 0;
    }

    if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
      RcAuto.rcAutoChkDlg(await RcSysChk.getTid(), OFF, err_no);
    }

    if (await RcSysChk.rcCheckOutSider()) {
      if (await RcSysChk.rcCheckWizAdjUpdate() != 0) {
        log = "call[WizAdj] rcErr(${err_no})";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        mem.prnrBuf.wizQrData.tranErr = err_no;
      }
      return;
    }

    if (await RcDishCalc.rcCheckDishMode()) {
      return;
    }

    // if (TprLibDlg.TprLibDlgGetDlgParam(dispDlg) == 1) {
    //   if (dispDlg.ttl_cnt > 0) {
    //     log = "${FUNCTION} : multi dialog. other err end";
    //     TprLog().logAdd(RcSysChk.getTid(), LogLevelDefine.normal, log);
    //     RcIfEvent.rxChkModeSaveReset(); // 保存イベントを初期化
    //     Rcmbrkymbr.rcMbrProcEndTargetMsg();
    //   }
    // }

    // if (CompileFlag.GRAMX) {
    //   if (RcSysChk.rcCheck_GramXEnt()) {
    //     return;
    //   }
    // }

    if (CompileFlag.RESERV_ACX) {
      if (((await CmCksys.cmReservSystem() != 0)
          || (await CmCksys.cmNetDoAreservSystem() != 0)) &&
          (RcReserv.rcReservReceiptCall())) {
        if (err_no == DlgConfirmMsgKind.MSG_ACB_DEC_NOT.dlgId) {
          log = "call[Reserv Receipt] rcErr(${err_no}) -> "
              "(${DlgConfirmMsgKind.MSG_ACB_DEC_NOT_RESERV.dlgId})";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          err_no = DlgConfirmMsgKind.MSG_ACB_DEC_NOT_RESERV.dlgId;
          //        return;
        }
      }
    }

    if ((await RcFncChk.rcCheckERefSMode()) ||
        (await RcFncChk.rcCheckERefIMode())) {
      RckyEref.eRefPopUp(err_no);
      return;
    }
    if (CompileFlag.RALSE_CREDIT) {
      if (EVoid().scndspFlg == RcElog.SCNCARDDSP) {
        RcScnCardDsp.scanCardPopUp(err_no);
        return;
      }
      if (esVoid.scndspFlg == RcElog.SCNCARDDSP) {
        RcScnCardDsp.scanCardPopUp(err_no);
        return;
      }
      if (CrdtVoid().scndspFlg == RcElog.SCNCARDDSP) {
        RcScnCardDsp.scanCardPopUp(err_no);
        return;
      }
    }
    if ((await RcFncChk.rcCheckESVoidSMode())
        || (await RcFncChk.rcCheckBkESVoidMode())
        || (await RcFncChk.rcCheckESVoidIMode())) {
      /* 04.Apr.08 */
// #if TW & 0
//     if((MEM->tHeader.prn_typ != TYPE_RCPT) || (RC_INFO_MEM->RC_CNCT.CNCT_S2PR_CNCT != 1)){
// #endif
// #if RALSE_CREDIT & 0
//       if (ESVoid.scndsp_flg == SCNCARDDSP)
//         RcScnCardDsp.scanCardPopUp(err_no);
//       else
// #endif
      RcKyesVoid.eSVoidPopUp(err_no);
      return;
// #if TW & 0
//     }
// #endif
    }
    if ((await RcFncChk.rcCheckCrdtVoidSMode())
        || (await RcFncChk.rcCheckBkCrdtVoidMode())
        || (await RcFncChk.rcCheckCrdtVoidIMode())
        || (await RcFncChk.rcCheckCrdtVoidAMode())) {
      RcKyCrdtVoid.crdtVoidPopUp(err_no);
      return;
    }
    if ((await RcFncChk.rcCheckPrecaVoidSMode()) ||
        (await RcFncChk.rcCheckPrecaVoidIMode())) {
      RcKyPrecaVoid.precaVoidPopUp(err_no);
      return;
    }
    if (CompileFlag.RALSE_CREDIT || CompileFlag.SMARTPLUS) {
      if ((await RcFncChk.rcCheckEVoidMode())
          || (await RcFncChk.rcCheckBkEVoidMode())) {
        RckyEVoid.rcEVoidPopUp(err_no);
        return;
      }
    }
    if (CompileFlag.RESERV_SYSTEM) {
      if (await RcFncChk.rcCheckReservMode()) {
        await RcReserv.rcReservPopUp(err_no);
        return;
      }
      else if (await RcFncChk.rcCheckNetReservMode()) {
        await RcNetReserv.rcNetReservPopUp(err_no);
        return;
      }
    }
    if ((Rc59dsp.intrc59_InputStatusGet() != 0)
        && (CmCksys.cmRm5900System() != 0)) {
      Rc59dsp.rc59InputErrDlgDsp(err_no, null);
      return;
    }

    if (CompileFlag.SELF_GATE) {
      if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
          (RcFncChk.rcChkErr() != 0)) {
        // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
        // if ((rcNewSG_Dual_Edy_SubttlDsp_Chk()) &&
        //     (((SelfMem.sg_password_flg == 0) &&
        //         (err_no == DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR)) ||
        //         (err_no == DlgConfirmMsgKind.MSG_EDY_BILLACK) ||
        //         (err_no == DlgConfirmMsgKind.MSG_EDY_CARDZERO) ||
        //         (err_no == DlgConfirmMsgKind.MSG_EDY_CARDBAD))) {
        //   rcSG_ClrKey_Proc();
        //   if (NpwDsp.pass_wd_flg != 0) {
        //     err_no_2nd = 0;
        //     SelfMem.sg_err_no_2nd = 0;
        //     rcSG_NdpswdMode_ChangeDsp();
        //     TprLibDlgClear();
        //     rcClearErr_Stat();
        //     SelfMem.call_btn = 0;
        //   }
        // }
        // else
        //   return;
      }

      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if (cm_unmanned_shop()) //無人店舗仕様
      //     {
      //   if ((err_no == MSG_SALELIMITOVER) //販売期限超過エラー
      //       || (err_no == MSG_SALELIMITOVER2)) {
      //     //無人店舗は店員呼出しない
      //     SelfMem.Staff_Call = 0;
      //     SelfMem.QC_Staff_Call = 0;
      //   }
      // }

      if ((await RcSysChk.rcChkSmartSelfSystem())
          && (await RcSysChk.rcSGChkSelfGateSystem())
          // && (SelfMem.QC_Staff_Call == 1)
          && ((err_no == DlgConfirmMsgKind.MSG_BARCODE_CHECK_OPE)
              || (err_no == DlgConfirmMsgKind.MSG_CANT_SCAN_OPE)
              || (err_no == DlgConfirmMsgKind.MSG_PLU_CD_SCAN)
              || (err_no == DlgConfirmMsgKind.MSG_CONF_AGE_CHECK)
              || (err_no == DlgConfirmMsgKind.MSG_GOAWAY_OPE)
              // || (err_no == DlgConfirmMsgKind.MSG_CONF_SENIOR_MBR)
              // || (err_no == DlgConfirmMsgKind.MSG_CONF_PARENT_SPRT_MBR)
              || (err_no == DlgConfirmMsgKind.MSG_SALELIMITOVER)
              || (err_no == DlgConfirmMsgKind.MSG_SALELIMITOVER2)
              || (RcQcDsp.qc_staffcall_from_sg_flg == 1))) {
        // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
        // c_buf.iniMacInfo.select_self.qc_mode = 1; //QCモードにする
        // c_buf.iniMacInfo.select_self.self_mode = 0;
        // RcQcCom.qc_err_staffcall = 1;
        // qc_2nd_err_flg = 0;
        // RcQcCom.qc_err_3nderr = 0;
        // RcQcCom.qc_err_2nderr = err_no;
        // rcQC_Staff_Dsp_AutoSelect();
        // RcExt.rcClearErrStat();
        // RcNewSgFnc.rcNewSGDspGtkTimerRemove();
        // RcsgDev.rcSGSndGtkTimerRemove();
        // return;
      }
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      //   rcQC_Movie_Stop();
      //   rcQC_Sound_Stop();
      //
      //   if (RC_INFO_MEM->RC_RECOG.RECOG_ICCARDSYSTEM)
      //   {
      //     if (err_no == MSG_TEXT30)
      //     { // 店員コールボタンの動作を許可させたい為
      //       sprintf(log, "%s : detect enable because err_no = [%d]\n", __FUNCTION__, err_no);
      //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 1, log);
      //
      //       if_detect_enable();
      //     }
      //
      //     if (TS_BUF->qcconnect.MyStatus.e_money_data == 1)
      //     {
      //       sprintf(log, "%s : e_money_data ReSet !!\n", __FUNCTION__);
      //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 1, log);
      //
      //       TS_BUF->qcconnect.MyStatus.e_money_data = 0;
      //     }
      //   }
      //
      //   if (rcChk_Shop_and_Go_System ())
      //   {
      //     if( QCStrDsp.half_window != NULL )
      //     {	/* QR読込時のPOPUPを削除 */
      //       gtk_widget_destroy(QCStrDsp.pop_pixmap);
      //       QCStrDsp.pop_pixmap = NULL;
      //       gtk_widget_destroy(QCStrDsp.half_window);
      //       QCStrDsp.half_window = NULL;
      //     }
      //   }
      //
      //   if(rcChk_Err())
      //   {
      //     if(rcQC_Check_Crdt_Mode())
      //     {
      //       return;
      //     }
      //   }
      //
      //   if(rcQC_Check_CrdtEnd_Mode())
      //   {
      //     rcQC_Err_Restar(0);
      //   }
      //   if(rcQC_Check_EdyEnd_Mode())
      //   {
      //     rcQC_Err_Restar(0);
      //   }
      //   if(rcQC_Check_SuicaTch_Mode())
      //   {
      //     rcQC_Err_Restar(0);
      //   }
      //
      //   if(( QCCallDsp.qc_call_dsp == 1 ) || ( QCCallDsp.qc_call_dsp == 2 ))
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //   else if( qc_err_2nderr == 0 )
      //   {
      //     qc_err_staffcall = 1;
      //     qc_2nd_err_flg = 0;
      //   }
      //   else if( (qc_err_2nderr) && (qc_2nd_err_flg==0) && (qc_3nd_err_flg==0)  )
      //   {
      //     if( (rcQC_Check_StaffDsp_Mode()) || (rcQC_Check_PassWardDsp_Mode()) )
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //     else if( (AT_SING->inputbuf.dev == D_OBR) || (AT_SING->inputbuf.dev == D_TCH) )
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //     else
      //     {
      //       qc_err_3nderr = err_no;
      //       qc_3nd_err_flg = 1;
      //       return;
      //     }
      //   }
      //   else if(qc_3nd_err_flg)
      //   {
      //     return;
      //   }
      //   else
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //   if (qc_start_flg == 1)
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //   if (qc_err_staffcall_no_flg == 1){	//店員操作時等のため、店員コールを挟まずエラー表示をする
      //     qc_err_staffcall = 0;
      //     qc_err_staffcall_no_flg = 0;
      //   }
      //
      //   if ((err_no == DlgConfirmMsgKind.MSG_TEXT131)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT132)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT133)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT135)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT136)
      //    || (err_no == DlgConfirmMsgKind.MSG_PLSREAD_MENTBAR2)
      //    || (err_no == DlgConfirmMsgKind.MSG_ALREADYDATA)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT141)
      //    || (err_no == DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR)
      //    || (err_no == DlgConfirmMsgKind.MSG_EDY_BILLACK)
      //    || (err_no == DlgConfirmMsgKind.MSG_EDY_CARDZERO)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT143)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT144)
      //    || (err_no == DlgConfirmMsgKind.MSG_TEXT207)
      //    || (err_no == DlgConfirmMsgKind.MSG_ANOTHER_DATE_TCKT)
      //    || (err_no == DlgConfirmMsgKind.MSG_QR_TIMELIMIT)
      //    || (err_no == DlgConfirmMsgKind.MSG_READ_FIRST_QR)
      //    || (err_no == DlgConfirmMsgKind.MSG_READ_ANOTHER_QR)
      //    || (err_no == DlgConfirmMsgKind.MSG_QR_ALREADY_PAID)
      //    || (err_no == DlgConfirmMsgKind.MSG_QR_ALREADY_READ)) {
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if ((((rcQC_Check_SlctDsp_Mode())
      //     || (rcQC_Check_StartDsp_Mode()) || (rcQCCheckEMnySlctDspMode())) &&
      //     ((err_no == DlgConfirmMsgKind.MSG_TEXT27)     || (err_no == DlgConfirmMsgKind.MSG_TEXT33) || (err_no == DlgConfirmMsgKind.MSG_TEXT34) ||
      //     (err_no == DlgConfirmMsgKind.MSG_NOTUSECARD) || (err_no == DlgConfirmMsgKind.MSG_TEXT83) || (err_no == DlgConfirmMsgKind.MSG_TEXT86) )  ) ||
      //     ((self_suica_timeout_flg == 0) && (err_no == DlgConfirmMsgKind.MSG_TIMEOVER))                          )
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //   if( (rcQC_Check_PassWardDsp_Mode()) || (rcQC_Check_MenteDsp_Mode()) || ((rcQC_Check_SusDsp_Mode()) && (! rcQC_Check_SusDsp_OverFlow_Type())) )
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //   if(rcCheck_ChgTran_Mode())
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if((rcCheck_CashRecycle_Mode())	||
      //   (rcCheck_CashRecycle_Read_Mode()))
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if( QC_MenteDsp.window != NULL )
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //
      // //     if((rcQC_Check_CrdtDsp_Mode()) || (rcQC_Check_CrdtUse_Mode())){
      //   if(rc_Masr_NoCall_ErrChk(err_no))
      //   {
      //     qc_err_staffcall = 0;
      //   }
      // //     }
      //
      //   if (CompileFlag.SS_CR2) {
      //     if (rcChk_CR2_NSW_Data_System())
      //     {
      //       if((err_no == DlgConfirmMsgKind.MSG_TEXT228) || (err_no == DlgConfirmMsgKind.MSG_TEXT229) )
      //       {
      //         QCCnclNo = err_no;
      //         qc_err_staffcall = 0;
      //       }
      //       else if(err_no == DlgConfirmMsgKind.MSG_TEXT230)
      //       {
      //         qc_err_staffcall = 0;
      //       }
      //     }
      //   }
      //   if(rcQC_Check_PrePaid_EntryDsp_Mode())
      //   {
      //     /* プリペイド置数支払操作エラーは店員呼出しない */
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if ((rcChk_Shop_and_Go_System())
      //     && ((rcSG_Check_Pre_Mode())
      //     || (qc_sag_item_mente_flg != 0)))
      //   {
      //     /* プリセットモードの場合は店員呼出しない */
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if(rcCheck_QC_Mbr_N_ReadDsp_Mode())
      //   {
      //     if ((!rcsyschk_Tpoint_System())	// Tカードの読込時も店員呼出する
      //     || ((QCMbrReadDsp.mbrcard_readtyp != MS_READ) && (QCMbrReadDsp.mbrcard_readtyp != TMOBILE_READ))
      //     || (!rc_Tpoint_Check_SelfErr_StaffCall(err_no)))
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //   }
      //
      //   if((rcQC_Check_dPtsEntDsp_Mode())
      //   && ((err_no == DlgConfirmMsgKind.MSG_ENTER_POINTS)
      //   || (err_no == DlgConfirmMsgKind.MSG_NOOVERKEEP)
      //   || (err_no == DlgConfirmMsgKind.MSG_ENTPNT_OVER)
      //   || (err_no ==DlgConfirmMsgKind. MSG_NOT_POINTUSE_TARGET)
      //   || (err_no == DlgConfirmMsgKind.MSG_POINTUSE_UNIT)))
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if (rcChk_Shop_and_Go_System())
      //   {
      //     if ((err_no == DlgConfirmMsgKind.MSG_SPTEND_OPEERR)	/* 店員操作中に発生するエラーのため店員呼出しない */
      //     ||  (err_no == DlgConfirmMsgKind.MSG_OPEMISS))		// エラー追加 (割戻利用額を下回る商品取消 など)
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //   }
      //
      //   if (rcChk_UsePoint_System()				// ポイント利用仕様のレジか
      //     &&  rcQC_Check_CogcaPoint_Mode())		// "ポイント利用"で、ユーザー側画面操作中
      //   {
      //     /* 店員呼出しない */
      //     if ((err_no == DlgConfirmMsgKind.MSG_ENTPNT_OVER)
      //     ||  (err_no == DlgConfirmMsgKind.MSG_TTLAMT_OVER)
      //     ||  (err_no == DlgConfirmMsgKind.MSG_PRCTGTSHORT)		// 値下対象が不足しています
      //     ||  (err_no == DlgConfirmMsgKind.MSG_ENTER_POINTS))
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //   }
      //
      //   if(rcChk_MultiVega_PayMethod(FCL_SUIC))
      //   {
      //     if((err_no == DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH)
      //       || (err_no == DlgConfirmMsgKind.MSG_TEXT34)
      //       || (err_no == DlgConfirmMsgKind.MSG_CARD_NOT_SAME))
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //   }
      //
      //   if(rcChk_Custreal_Fresta_System()) // フレスタ様仕様
      //   {
      //     if(err_no == DlgConfirmMsgKind.MSG_CUST_OFFLINE)	// 顧客オフラインメッセージ
      //     {
      //       qc_err_staffcall = 0;
      //     }
      //   }
      //
      //   if (rcsyschk_yunaito_hd_system())	// ユナイト仕様
      //   {
      //     if (rcCheck_StdCpn_ReadDsp_Mode())	// クーポン読込画面表示中
      //     {
      //       if (C_BUF->db_trm.unite_coupon_staff_call_flg == 2) // 店員呼出しない
      //       {
      //         qc_err_staffcall = 0;
      //       }
      //     }
      //   }
      //
      //   if((rcChk_RPointMbr_Read_TMC_QCashier ())		// タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ
      //     && (rcQC_Check_RPtsMbr_Read_Mode())			// 精算機での楽天ポイントカードの読込画面
      //     && (rcQR_RpointReadErr_After_FlgChk(__FUNCTION__))	// 楽天ポイントカード照会結果継続不可エラー時の後処理フラグが有効
      //     && ( (err_no == DlgConfirmMsgKind.MSG_BARCD_EXPIRED)			// ワンタイムバーコード有効期限切れ
      //       || (err_no == DlgConfirmMsgKind.MSG_READ_RPNT)			// 楽天ポイントカード以外のバーコード
      //       || (err_no == DlgConfirmMsgKind.MSG_RPOINT_NOTCARD_SCAN)		// 楽天ポイントカードではない、読み直し
      //       || (err_no == DlgConfirmMsgKind.MSG_RPOINT_DELETE_CARD)		// 削除済みカード
      //       || (err_no == DlgConfirmMsgKind.MSG_RPOINT_CANCEL_CARD)		// 退会済みカード
      //       || (err_no == DlgConfirmMsgKind.MSG_RPOINT_NOUSE_CARD)))		// その他停止カード
      //   {
      //     qc_err_staffcall = 0;
      //   }
      //
      //   if ((rcfncchk_Qcashier_Member_Read_System())			// 精算機で会員カード読取可能なレジ
      //     && (rcfncchk_Check_Qcashier_Member_Read_Entry_Mode()) )	// 精算機での会員カード読取画面
      //   {
      //     if (rcqc_dsp_Qcashier_Member_Read_ReadErr_After_FlgChk(__FUNCTION__))	// 精算機での会員読取結果継続不可エラー時の後処理フラグが有効
      //     {
      //       if (rcqc_dsp_Check_Qcashier_Member_Read_Entry_Card() == QC_ANYCUSTCARD_TYPE_RPOINT)	// 精算機での楽天ポイントカード読取画面の場合
      //       {
      //         if ( (err_no == DlgConfirmMsgKind.MSG_BARCD_EXPIRED)			// ワンタイムバーコード有効期限切れ
      //           || (err_no == DlgConfirmMsgKind.MSG_READ_RPNT)				// 楽天ポイントカード以外のバーコード
      //           || (err_no == DlgConfirmMsgKind.MSG_RPOINT_NOTCARD_SCAN)		// 楽天ポイントカードではない、読み直し
      //           || (err_no == DlgConfirmMsgKind.MSG_RPOINT_DELETE_CARD)			// 削除済みカード
      //           || (err_no == DlgConfirmMsgKind.MSG_RPOINT_CANCEL_CARD)			// 退会済みカード
      //           || (err_no == DlgConfirmMsgKind.MSG_RPOINT_NOUSE_CARD) )		// その他停止カード
      //         {
      //           qc_err_staffcall = 0;					// 店員呼出しない
      //         }
      //       }
      //       else
      //       {
      //         qc_err_staffcall = 0;				// 店員呼出しない
      //       }
      //     }
      //   }
      //
      //   if( qc_err_staffcall ) {
      //     //if( (err_no == MSG_BARFMTERR) || (err_no == MSG_PLUNONFILE) || (err_no == MSG_QRDATAERR) ) {
      //     if( (err_no == MSG_BARFMTERR) || (err_no == MSG_PLUNONFILE) || (err_no == MSG_CNCL_AND_GO_COUNTER) ) {
      //       memset( qr_txt_err_barcode, 0x00, sizeof(qr_txt_err_barcode) );
      //       memcpy( qr_txt_err_barcode, CMEM->working.jan_inf.Code, sizeof(qr_txt_err_barcode) );
      //     }
      //     qc_err_3nderr = 0;
      //     qc_err_2nderr = err_no;
      //     if (TS_BUF->masr.eject_flg == 1)	//カードリード中
      //     {
      //       TS_BUF->masr.eject_flg = 0;
      //     }
      //     rcQC_Staff_Dsp_AutoSelect();
      //     rcClearErr_Stat();
      //     return;
      //   }
      //   if(rcQC_Check_SlctDsp_Mode())
      //   {
      //     rcQC_Select_Btn_Return_Com();
      //   }
      // }
      // else if (rcsyschk_VFHD_self_system ())	/* 15.6インチフルセルフ */
      // {
      //   RcQcCom.rcQCMovieStop();
      //   RcQcCom.rcQC_Sound_Stop();
    }

    if ((await RcSysChk.rcChkSQRCTicketSystem()) &&
        (!RcFncChk.rcSGCheckMntMode()) && (RcKeyCash.mntDsp.mntDsp == 0)) {
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // rcSGSnd_GtkTimerRemove();
      // if (err_no_2nd == 0)
      // {
      //   sqrc_err_staffcall = 1;
      // }
      // if ((rcSQRC_Check_StaffDsp_Mode()) || (rcSQRC_Check_PassWordDsp_Mode()))
      // {
      //   sqrc_err_staffcall = 0;
      // }
      // if (StartDsp.sg_start == 0)
      // {
      //   sqrc_err_staffcall = 0;
      // }
      // if (sqrc_err_staffcall == 1) {
      //   err_no_2nd = err_no;
      //   SelfMem.Staff_Call = 1;
      //   SelfMem.call_btn = 3;
      //   rcNewSG_ComTimer_GifDsp();
      //   rcSGSnd_GtkTimerAdd(1000, (GtkFunction)rcSG_SoundTimer_Proc);
      //   SelfMem.bz_timer_end = 2;
      //   rcSG_CallBuzzer_Proc();
      //   rcSQRC_Staff_Dsp();
      //   rcClearErr_Stat();
      //   return;
      // }
    }

    if ((RcFncChk.rcChkErr() == 0) || (err_no == 0)) {
      if (RcSysChk.rcCheckKyIntIn(false)) {
        // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
        // if ((C_BUF->db_trm.keep_int_2person ) &&
        // (rcKy_Self() == KY_CHECKER   )   )
        // {
        //   rcClear_Int_Flag(1);
        //   OT->flags.clk_mode = KY_CHECKER;         /* Set Clerk Mode */
        //   C_BUF->int_flag = (char)2;
        // }
      }

//#if SELF_GATE
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        await rcErrBzPopUpLcd(err_no, toPageFunc);
//       // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
//       SubDsp.subdsp_err = 0;
//       if( rcQS_Check_Start_Movie() ) {
//         rcQS_Start_Movie_Stop();
//       }
//       if( (rcSG_Chk_Suica_Direct()) && (quick_ini_page == 3) )
//       {
//         TprLibDlgClear();
//       }
//       if( (rcSG_Chk_Edy_Direct()) && (CMEM->stat.FncCode == KY_EDYREF) && (qs_non_card_start_flg != 0) )
//       {
//         TprLibDlgClear();
//         if( self_balance_chk_flg == 1) {
//           SelfMem.Staff_Call = 1;
//           self_balance_chk_flg = 2;
//         }
//       }
//
//       if( rcChk_SmartSelf_System() && C_BUF->ini_macinfo.apbf_cnct == 1 && rcQC_Mente_Apbf_Status_Check() == 0)
//       {
//         if(C_BUF->apbf_dlg_flg == 1)
//         {
//           if(TprLibDlgNoCheck() == MSG_CONF_REGBAG_REG)
//           {
//             TprLibDlgClear();
//             C_BUF->apbf_dlg_flg = 0;
//           }
//         }
//       }
// //#if SELF_S_STAFF
//     if(SelfStaffDsp.staff_disp != 1)
// //#endif
//     {
//       if(!((cm_dcmpoint_system()) && (rcCheck_SpritMode()) &&
//       ((err_no == MSG_PRCTGTSHORT)||(err_no == MSG_LACK_SUBTOTAL_TO_DISCOUNT)||(err_no == MSG_NOT_DISCOUNT_TARGET))))
//       {
//         /* HappySelf仕様で個数入力画面時、個数入力画面の戻るボタン表示しない設定の場合のみスキャナを止めない */
//         if( !((rcChk_SmartSelf_System()) && (QCashierIni.cancel_btn_dsp == 0) && (rcSG_Check_MulItem_Mode())) )
//         {
//           rcScan_Disable();
//         }
//       }
//       if ((rcSG_Check_End_Mode()) &&
//       (cm_fb_dual_system() != 2      ) &&
//       (rcChk_Quick_Self_System() != 1) &&
//       (! rcNewSG_Chk_NewSelfGate_System()) &&
//       (SubDsp.sub_disp != SUB_NOTHING) ) {
//         if (SelfMem.bz_timer_end == 0)
//           SelfMem.Staff_Call = 1;
//         }
//         else if(rcCheck_SpritMode()) {
//           SelfMem.Staff_Call = 0;
//           rcErrBz_PopUpLcd(err_no);
//         }
//         else {
//           if ( ((rcSG_Dual_SubttlDsp_Chk()) || (rcSG_Dual_Crdt_SubttlDsp_Chk()) || (rcNewSG_Dual_Edy_SubttlDsp_Chk()) || (rcSG_Dual_Suica_SubttlDsp_Chk()) ||
//           ((SelfMCReadDsp.MC_Read_disp == 1) && (CompileFlag.MC_SYSTEM)) ||
//           (rcSG_Check_Ndpswd_Mode()) ||
//           (((rcSG_Check_Mcp200_System()) || (err_no == MSG_ACB_START_ERR)) && (rcSG_Check_End_Mode())) ||
//           ((rcChk_VEGA_Process()) && (rcSG_Check_MbrScn_Mode())) || /* VEGA接続時のカード読取 */
//           ((rcSG_Check_PanaMbr_System()) && (SelfRWReadDsp.RW_Read_disp == 1)) ) &&
//           (SelfMem.Staff_Call == 0) &&
//           (SelfMem.bz_timer_end == 0) ) {
//             SelfMem.Staff_Call = 1;
//           }
//           if( (rcNewSG_Dual_Edy_SubttlDsp_Chk()) && (((SelfMem.sg_password_flg==0) && (err_no == MSG_MI_TIMEOUT_ERROR)) ||
//           (err_no == MSG_EDY_BILLACK) || (err_no == MSG_EDY_CARDZERO) ) ) {
//             SelfMem.Staff_Call = 0;
//           }
//           if( (rcNewSG_Dual_Edy_SubttlDsp_Chk()) && (rcSG_Check_Ndpswd_Mode()) && (err_no != MSG_MI_TIMEOUT_ERROR)) {
//             SelfMem.Staff_Call = 0;
//           }
//           if (rcSG_Check_Check_Mode()) {
//             SelfMem.Staff_Call = 0;
//           }
//           if (err_no == MSG_TEXT88 || err_no == MSG_TEXT89){
//             SelfMem.Staff_Call = 0;
//           }
//           if( (C_BUF->db_trm.self_slct_key_cd == 9) && (rcSG_Check_Slct_Mode()) && (err_no == MSG_TIMEOVER) ){
//             SelfMem.Staff_Call = 0;
//           }
//           if( (rcSG_Check_Inst_Mode()) && (err_no == MSG_EDY_CARDZERO) ){
//             SelfMem.Staff_Call = 0;
//           }
//           if( (rcSG_Chk_Ampm_System()) && ((quick_ini_page != 0) || (quick_ini_page != 1) || (quick_ini_page != QS_DSP_STARTSLCT_40)) ) {
//             TprLibDlgClear();
//             if(err_no == MSG_RETRYERR) {
//               err_no = MSG_TEXT44;
//             }
//           }
//           if( (rcSG_Chk_Ampm_System()) && (err_no == MSG_JUST_MOMENT) ){
//             err_no = MSG_TEXT45;
//           }
//           if( (rcSG_Chk_Ampm_System()) && (C_BUF->db_trm.loason_nw7mbr) && (err_no == MSG_PLUNONFILE) ){
//             err_no = MSG_TEXT90;
//           }
//           if( (rcSG_Chk_Ampm_System()) && (C_BUF->db_trm.disp_password_error) && (rcSGChk_StaffCall()) ){
//             SelfMem.sg_password_flg = 1;
//           }
//           if( (rcSG_QS_StartDsp_ScanEnable_Check()) && (qs_non_card_start_flg != 0) && (edy_balance_amt != 999999) ) {
//             if( (err_no == MSG_EDY_BILLACK) || (err_no == MSG_EDY_CARDZERO) ) {
//            // err_no = MSG_TEXT85;
//               err_no = MSG_BALANCE_SHORT;
//               quick_ini_page_old = quick_ini_page;
//               quick_ini_page = 4;
//               rcSG_IniSound_Proc();
//             }
//           }
//           else if( (rcSG_QS_StartDsp_ScanEnable_Check()) && (qs_non_card_start_flg == 0) && (edy_balance_amt != 999999) ) {
//             if( (err_no == MSG_EDY_BILLACK) || (err_no == MSG_EDY_CARDZERO) ) {
//             //err_no = MSG_TEXT85;
//               err_no = MSG_BALANCE_SHORT;
//               quick_ini_page_old = quick_ini_page;
//               quick_ini_page = 4;
//               rcSG_IniSound_Proc();
//             }
//           }
//           if ( (rcChk_Quick_Self_System()) && (rcSG_Chk_Edy_Direct()) &&
//           (quick_ini_page == 3) && (CMEM->stat.FncCode != KY_EDYREF) && (EndDsp.regs_end_flg == 1) ){
//             TprLibDlgClear();
//           }
//           rcErrBz_PopUpLcd(err_no);
//           if( (rcSG_Chk_Ampm_System()) && ((quick_ini_page == 0) || (quick_ini_page == 1)) && (err_no == MSG_TEXT44) ){
//             err_no = MSG_RETRYERR;
//           }
//         }
      }
      else {
// //#endif
        if (TprLibDlg.tprLibDlgCheck2(1) != 0) {
          // // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
          // sprintf(log, "%s TprLibDlgCheck Found!!\n", __FUNCTION__);
          // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
          // TprLibDlgClear();
        }

        // // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
        // // 削除し忘れが発生しないように追加
        // if ( rc_chkr_Chk_ScanErrDlg() )
        // {
        //   rc_chkr_ScanErrDlg_Clear();
        // }

        log = " rcErr rcKy_Self (${(await RcSysChk.rcKySelf()).toString()})\n"; //, rcKy_Self());
        TprLog().logAdd(0, LogLevelDefine.normal, log);
        switch (await RcSysChk.rcKySelf()) {
          case RcRegs.DESKTOPTYPE:
          case RcRegs.KY_CHECKER:
            await rcErrBzPopUpLcd(err_no, toPageFunc);
            break;
          case RcRegs.KY_DUALCSHR:
          // // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
            await rcErrBzPopUpLcd(err_no, toPageFunc);
          //   if (await RcSysChk.rcChkDesktopCashier()) {
          //     Cash_Notice_Set(err_no);
          //   }
            break;
          case RcRegs.KY_SINGLE:
          // // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
            await rcErrBzPopUpLcd(err_no, toPageFunc);
          //  if ((RcSysChk.rcCheckSegment()) && (RcSysChk.rcCheck_Prime_Stat() == RcRegs.PRIMETOWER)) {
          //    rcErrDataSet_SegmentLine(err_no);
          //    rcSegment_Flush1(FIP_NO1);
          //  }
            break;
        }
      }
    }

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
    // // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
    //     if (SubDsp.sub_disp == SUB_NOTHING){
    //       rcErr_Stat_Set();
    //     }
    //     if (cm_fb_dual_system() == 2){
    //       rcErr_Stat_Set();
    //     }
    //     if (rcChk_Quick_Self_System() == 1){
    //       rcErr_Stat_Set();
    //     }
    //     if ((rcChk_2800_System()) && (rcNewSG_Chk_NewSelfGate_System())){
    //       rcErr_Stat_Set();
    //     }
    //     if (rcSGChk_StaffCall()){
    //       return;
    //     }
    //     else {
    //       if (rcNewSG_Chk_NewSelfGate_System()) {
    //         if ((err_no == MSG_BARCODE_NOTREAD) || (err_no == MSG_NOT_CONFIRM) || (SelfMem.call_btn == 2) || (err_no == MSG_NOT_CONFIRM2)){
    //           rcNewSG_ComTimer_GifDsp();
    //         }
    //       }
    //     }
      }
      else {
        await RcSet.rcErrStatSet2("rcErr");
      }
    } else {
      await RcSet.rcErrStatSet2("rcErr");
    }

    // AcbMem.acx_error_num = 0;
    // AcbMem.acx_err_gui_end_func = null;
    log = "call rcErr(${err_no})\n";
    TprLog().logAdd(0, LogLevelDefine.normal, log);

    // // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
    // if (CompileFlag.CENTOS_G3) {
    //   if( (rcsyschk_yunaito_hd_system())
    //   && (rcSG_Chk_SelfGate_System())
    //   && (TrashBagScnDsp.trashbagscn_disp == 0)
    //   && (err_no == MSG_PLU_CD_SCAN) )
    //   {
    //     if( (rcNewSG_Chk_NewSelfGate_System())
    //     && ( (rcCheck_Stl_Mode())
    //     || (rcSG_Check_Pre_Mode()) ) )
    //     {
    //       TprLibDlgClear();
    //       rcClearErr_Stat();
    //       rcScan_Enable();
    //       rcSG_Disp_TrashBagScanWindow();
    //       rcSG_SignP_SignOn(GREEN_COLOR);
    //     }
    //   }
    // }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_ewdsp.c - rcSet_DlgAddData_KeyStatus_Result
  static int rcSetDlgAddDataKeyStatusResult(int result) {
    return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_ewdsp.c - rcWarn_PopDownLcd2
  static void rcWarnPopDownLcd2(String callFunc) {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_ewdsp.c - rcWarn
  static void rcWarn(int warnNo) {
    return;
  }

  ///  関連tprxソース: rc_ewdsp.c - rcErrNoBz
  // TODO:00013 三浦 保留
  static void rcErrNoBz(msg_nowwait) {
    return;
  }

  ///  関連tprxソース: rc_ewdsp.c - rcErrNoBz_PopUpLcd
  // TODO:00013 三浦 保留
  static Future<void> rcErrNoBzPopUpLcd(int wCode) async {
    return;
  }

  /// エラーダイアログをブザー音付きで出力する
  /// 引数:[wCode] エラーダイアログID
  /// 引数:[func] 遷移先画面を表示する関数（SetMenu1クラス）
  ///  関連tprxソース: rc_ewdsp.c - rcErrBz_PopUpLcd
  static Future<void> rcErrBzPopUpLcd(int wCode, final void Function() toPageFunc) async {
    tprDlgParam_t param = tprDlgParam_t();
    int titlClrflg = 0;
    // String money_buf[32 * 2 + 1];
    // int len, cnt, kana_cnt, kana_cnt2;
    // char buf[256],tmp[256];
    // char tmp_code[DLG_MSG_CNT_MAX+1];
    // char yamato_buf[128];
    // char ut1_msg[128];
    // char qr_rpr_buf[32];
    // char precain_buf[DB_IMG_DATASIZE+1];
    // char vesca_ew_code[32];
    // char errmsg_buf[DB_IMG_DATASIZE+1];
    // char vesca_add_msg[256];
    // char vesca_add_msg1[64];
    // char vesca_add_msg2[64];
    // int buzzerSkip = 0;
    // int errNo = 0;
    // char dpoint_ew_title[15];
    // char vega_errdisp_msg[256];
    // char rpoint_ew_code[14];
    // char vesca_msg_buf[128];
    // char vesca_add_title[128];

    wCode = await rcErrMsgChg (wCode, titlClrflg);
    param.erCode = wCode;
    // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
//     if(rcChk_AcrAcb_FullErr(param.er_code)){
//     rcAcrAcb_SetFullErrMsg(&money_buf, sizeof(money_buf));
//     }
//     else if(rcChk_AcrAcb_RjctErr(param.er_code)){
//     rcAcrAcb_SetRjctErrMsg(&money_buf, sizeof(money_buf));
//     }
//
//
//     if(cm_yamato_system()) {
//     if((wCode == MSG_CANNOT_SPTEND_CANCEL   ) ||
//     (wCode == MSG_ETARMINAL_BALANCE_SHORT) ||
//     (wCode == MSG_ETARMINAL_CASHRETURN   )) {
//     memset(yamato_buf, 0, sizeof(yamato_buf));
//     rcEdit_Yamato_Msg(wCode, yamato_buf, sizeof(yamato_buf));
//     param.msg_buf = yamato_buf;
//     }
//     }
//     else if((rcChk_MultiVega_PayMethod(FCL_SUIC))
//     && ((((rcCheck_Suica_Mode()) || (rcQC_Check_SuicaTch_Mode()))
//     && (TS_BUF->multi.fcl_data.snd_data.ttl_amt != 0))
//     || (rcQC_Check_SuicaChk_Mode())))
//     {
//     if(rcQC_Check_SuicaChk_Mode())
//     {
//     rcMultiVega_AddErrMsg(1, vega_errdisp_msg, sizeof(vega_errdisp_msg));
//     }
//     else
//     {
//     rcMultiVega_AddErrMsg(0, vega_errdisp_msg, sizeof(vega_errdisp_msg));
//     }
//     param.user_code_4 = vega_errdisp_msg;
//     }
//     else if (rcsyschk_vesca_system())
//     {
//     if (rcsyschk_TFPS_msg_chg())
//     {
//     err_no = rc_gcat_TFPS_change_err_msg(wCode);
//     param.er_code = err_no;
//     if (wCode != err_no)
//     {
//     wCode = err_no;
//     if (rcQC_Chk_Qcashier_System())
//     {
//     if (qc_err_2nderr != wCode)
//     {
//     qc_err_2nderr = wCode;
//     }
//     }
//     }
//     }
//
//     if(wCode == MSG_VESCA_BALANCE_INFO)
//     {
//     if (wCode == MSG_VESCA_BALANCE_INFO)
//     {
//     if (TS_BUF->jpo.currentservice == VESCA_PITAPA_TRAN)
//     { // PiTaPaは累計照会なのでメッセージを変更する
// //				wCode = MSG_TFPS_MSG26;
//     param.er_code = MSG_TFPS_MSG26;
//
//     if (strlen(AT_SING->vesca_ew_code))
//     { // エラーコードが残っていた場合はクリアする
//     memset(AT_SING->vesca_ew_code, 0x00, sizeof(AT_SING->vesca_ew_code));
//     }
//     }
//     }
//
//     if (rcChk_ZHQ_system())
//     titl_clrflg = 3;
//     else
//     titl_clrflg = 2;
//
//     // RM-3800の場合、メカキーが無いので「クリアキー」で閉じるが扱えないので「とじる」ボタンを表示
//     if ( C_BUF->vtcl_rm5900_regs_on_flg )
//     {
//     titl_clrflg = 3;
//     }
//     memset(vesca_msg_buf, 0, sizeof(vesca_msg_buf));
//     rc_ewdsp_edit_vesca_msg(wCode, vesca_msg_buf, sizeof(vesca_msg_buf));
//     param.msg_buf = vesca_msg_buf;
//     }
//     else if(wCode == MSG_VESCA_BALANCE_SHORT)
//     {
//     /* 残高不足時にも残高を表示するよう変更 */
//     if( rcChk_vesca_center_connect(VERIFONE_CENCNT_2) )
//     {
//     /* メッセージの末尾で改行して、金額/残高表示 */
//     param.title	= IMG_VESCA_BALANCE_SHORT_TITLE;
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     rc_ewdsp_edit_vesca_msg2(wCode, vesca_add_msg, sizeof(vesca_add_msg));
//     param.user_code_3 = vesca_add_msg;
//     }
//     else if( rcsyschk_TFPS_msg_chg() )
//     {
//     // QP：TF04-401の検定設定時対応の為
//     memset(vesca_add_title, 0, sizeof(vesca_add_title));
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     if( rc_ewdsp_edit_vesca_msg3(TS_BUF->jpo.vesca_errdetail, vesca_add_title, sizeof(vesca_add_title), vesca_add_msg, sizeof(vesca_add_msg)) )
//     {
//     if( (strlen(vesca_add_title) > 0) )
//     {
//     param.title	= vesca_add_title;
//     }
//     else if( param.title == NULL )
//     {
//     param.title = ERR_TITLE;
//     }
//     param.user_code_3 = vesca_add_msg;
//     }
//
//     memset(yamato_buf, 0, sizeof(yamato_buf));
//     rc_ewdsp_edit_vesca_msg(wCode, yamato_buf, sizeof(yamato_buf));
//     param.user_code_4 = yamato_buf;
//     }
//     else
//     {
//     memset(yamato_buf, 0, sizeof(yamato_buf));
//     rc_ewdsp_edit_vesca_msg(wCode, yamato_buf, sizeof(yamato_buf));
//     param.user_code_4 = yamato_buf;
//     }
//     }
//     else if(wCode == MSG_CHK_VESCA_CARDBAL)
//     {
//     /* 処理未了時にも残高を表示するよう変更 */
//     if( rcChk_vesca_center_connect(VERIFONE_CENCNT_2) )
//     {
//     if ( (memcmp(TS_BUF->jpo.vesca_errdetail, "TF01", 4) == 0)	// nanaco
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF02", 4) == 0)	// Edy
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF05", 4) == 0)	// 交通系
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF06", 4) == 0)	// WAON
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF07", 4) == 0) )	// nanaco2
//         {
//     /* メッセージの末尾で改行して、金額/残高表示 */
//     param.title	= IMG_VESCA_CARDBAL_TITLE;
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     rc_ewdsp_edit_vesca_msg2(wCode, vesca_add_msg, sizeof(vesca_add_msg));
//     param.user_code_3 = vesca_add_msg;
//     }
//     else if ( (memcmp(TS_BUF->jpo.vesca_errdetail, "TF03", 4) == 0)		// iD
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF04", 4) == 0)  )	// QP
//         {
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     snprintf(vesca_add_msg, sizeof(vesca_add_msg)-1, IMG_VESCA_TFPS_MSG25);
//     param.user_code_3 = vesca_add_msg;
//     }
//
//     }
//     else
//     {
//     if( (rcsyschk_vesca_change_ui()) )
//     {
//     if( ( (memcmp(TS_BUF->jpo.vesca_errdetail, "TF01", 4) == 0)	// nanaco
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF02", 4) == 0)	// Edy
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF05", 4) == 0)	// 交通系
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF06", 4) == 0)	// WAON
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF07", 4) == 0) ) )	// nanaco2
//         {
//     /* Verifone UI変更仕様が有効 */
//     /* ダイアログ内のメッセージのみ置き換える */
//     param.title = ERR_TITLE;
//     /* エラーメッセージ */
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     snprintf(vesca_add_msg, sizeof(vesca_add_msg)-1, MSG_CONFIRM_VESCA_BALANCE);
//     strcat(vesca_add_msg, "\n");
//
//     if( rcsyschk_TFPS_msg_chg() )
//     {
//     memset(vesca_add_title, 0, sizeof(vesca_add_title));
//     if( rc_ewdsp_edit_vesca_msg3(TS_BUF->jpo.vesca_errdetail, vesca_add_title, sizeof(vesca_add_title), vesca_add_msg, sizeof(vesca_add_msg)) )
//     {
//     if( (strlen(vesca_add_title) > 0) )
//     {
//     param.title	= vesca_add_title;
//     }
//     else if( param.title == NULL )
//     {
//     param.title = ERR_TITLE;
//     }
//     strcat(vesca_add_msg, "\n");
//     }
//     }
//
//     /* 決済金額 */
//     memset(vesca_add_msg1, 0, sizeof(vesca_add_msg1));
//     snprintf(vesca_add_msg1, sizeof(vesca_add_msg1)-1, IMG_VESCA_SETTLEDAMT, TS_BUF->jpo.settledamount);
//     strncat(vesca_add_msg,  vesca_add_msg1, strlen(vesca_add_msg1));
//     param.user_code_3 = vesca_add_msg;
//
//     /* 決済前残高 */
//     memset(vesca_add_msg2, 0, sizeof(vesca_add_msg2));
//     snprintf(vesca_add_msg2, sizeof(vesca_add_msg2)-1, IMG_VESCA_BEFOREBAL, TS_BUF->jpo.beforebalance);
//     param.user_code_4 = vesca_add_msg2;
//     }
//     else if( ( (memcmp(TS_BUF->jpo.vesca_errdetail, "TF03", 4) == 0)	// iD
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF04", 4) == 0) ) )	// QP
//         {
//     param.title = ERR_TITLE;
//
//     if( rcsyschk_TFPS_msg_chg() )
//     {
//     /* 取引が不明な状態で終了しました。所定の運用にて、取引状況をご確認下さい。 */
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     snprintf(vesca_add_msg, sizeof(vesca_add_msg)-1, IMG_VESCA_TFPS_MSG25);
//
//     memset(vesca_add_title, 0, sizeof(vesca_add_title));
//     if( rc_ewdsp_edit_vesca_msg3(TS_BUF->jpo.vesca_errdetail, vesca_add_title, sizeof(vesca_add_title), vesca_add_msg, sizeof(vesca_add_msg)) )
//     {
//     if( (strlen(vesca_add_title) > 0) )
//     {
//     param.title	= vesca_add_title;
//     }
//     else if( param.title == NULL )
//     {
//     param.title = ERR_TITLE;
//     }
//     }
//     param.user_code_3 = vesca_add_msg;
//     }
//     else
//     {
//     /* 取引が不明な状態で終了しました。所定の運用にて、取引状況をご確認下さい。 */
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     snprintf(vesca_add_msg, sizeof(vesca_add_msg)-1, IMG_VESCA_TFPS_MSG25);
//     param.user_code_3 = vesca_add_msg;
//     }
//     }
//     }
//     }
//     }
//     else if( wCode == MSG_JMUPS_NOTUSE )
//     {
//     /* 決済中止（エラー）時にも残高を表示するよう変更 */
//     if( rcChk_vesca_center_connect(VERIFONE_CENCNT_2) )
//     {
//     if (memcmp(TS_BUF->jpo.vesca_errdetail, "TF02-310", 8) == 0)	// Edy強制残高照会NG
//         { // メッセージ変更なし
//         ;
//     }
//     else
//     {
//     if ( (TS_BUF->jpo.vesca_error_order == JMUPS_REDUCE_RES)	// 支払/チャージ取引時
//     && ((memcmp(TS_BUF->jpo.vesca_errdetail, "TF01", 4) == 0)	// nanaco
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF02", 4) == 0)	// Edy
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF05", 4) == 0)	// 交通系
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF06", 4) == 0)	// WAON
//     || (memcmp(TS_BUF->jpo.vesca_errdetail, "TF07", 4) == 0)) )	// nanaco2
//         {
//     /* メッセージの末尾で改行して、金額/残高表示 */
//     param.title = ERR_TITLE;
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     rc_ewdsp_edit_vesca_msg2(wCode, vesca_add_msg, sizeof(vesca_add_msg));
//     param.user_code_3 = vesca_add_msg;
//     }
//     }
//     }
//     else if( rcsyschk_TFPS_msg_chg() )
//     {
//     memset(vesca_add_title, 0, sizeof(vesca_add_title));
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     if( rc_ewdsp_edit_vesca_msg3(TS_BUF->jpo.vesca_errdetail, vesca_add_title, sizeof(vesca_add_title), vesca_add_msg, sizeof(vesca_add_msg)) )
//     {
//     if( (strlen(vesca_add_title) > 0) )
//     {
//     param.title	= vesca_add_title;
//     }
//     else if( param.title == NULL )
//     {
//     param.title = ERR_TITLE;
//     }
//     param.user_code_3 = vesca_add_msg;
//     }
//     }
//     }
//     else if(   (wCode == MSG_TFPS_MSG1)
//     || (wCode == MSG_TFPS_MSG2)
//     || (wCode == MSG_TFPS_MSG3)
//     || (wCode == MSG_TFPS_MSG4)
//     || (wCode == MSG_TFPS_MSG5)
//     || (wCode == MSG_TFPS_MSG6)
//     || (wCode == MSG_TFPS_MSG8)
//     || (wCode == MSG_TFPS_MSG9)
//     || (wCode == MSG_TFPS_MSG11)
//     || (wCode == MSG_TFPS_MSG12)
//     || (wCode == MSG_TFPS_MSG13)
//     || (wCode == MSG_TFPS_MSG14)
//     || (wCode == MSG_TFPS_MSG15)
//     || (wCode == MSG_TFPS_MSG16)
//     || (wCode == MSG_TFPS_MSG19)
//     || (wCode == MSG_TFPS_MSG20)
//     || (wCode == MSG_TFPS_MSG21)
//     || (wCode == MSG_TFPS_MSG22)
//     || (wCode == MSG_TFPS_MSG23)
//     || (wCode == MSG_TFPS_MSG24)
//     || (wCode == MSG_TFPS_MSG25)
//     )
//     {
//     if( rcsyschk_TFPS_msg_chg() )
//     {
//     memset(vesca_add_title, 0, sizeof(vesca_add_title));
//     memset(vesca_add_msg, 0, sizeof(vesca_add_msg));
//     if( rc_ewdsp_edit_vesca_msg3(TS_BUF->jpo.vesca_errdetail, vesca_add_title, sizeof(vesca_add_title), vesca_add_msg, sizeof(vesca_add_msg)) )
//     {
//     if( (strlen(vesca_add_title) > 0) )
//     {
//     param.title	= vesca_add_title;
//     }
//     else if( param.title == NULL )
//     {
//     param.title = ERR_TITLE;
//     }
//     param.user_code_3 = vesca_add_msg;
//     }
//     }
//     }
//
//     if(strlen(AT_SING->vesca_ew_code))
//     {
//     /* エラーコードがあれば、エラー表示する */
//     if(rcQC_Chk_Qcashier_System())
//     {
//     /* QCashierでは店員コールしない時、又は、店員コールが解除された時に印字する */
//     if((qc_err_2nderr == 0)
//     || (qc_err_2nderr == wCode))
//     {
//     snprintf(vesca_ew_code, sizeof(vesca_ew_code), "%s", AT_SING->vesca_ew_code);
//     param.user_code_2 = vesca_ew_code;
//     /* Verifone処理未了時に使用するため、ここではクリアしない */
// //				memset(AT_SING->vesca_ew_code, 0x00, sizeof(AT_SING->vesca_ew_code));
//     }
//     }
//     else
//     {
//     snprintf(vesca_ew_code, sizeof(vesca_ew_code), "%s", AT_SING->vesca_ew_code);
//     param.user_code_2 = vesca_ew_code;
//     memset(AT_SING->vesca_ew_code, 0x00, sizeof(AT_SING->vesca_ew_code));
//     }
//     }
//     }
//
//     if (cm_cct_codepay_system())
//     {
//     if(wCode == MSG_CANNOT_SPTEND_CANCEL)
//     {
//     memset(yamato_buf, 0, sizeof(yamato_buf));
//     strcpy (yamato_buf, IMG_CCT_CODEPAY);
//     param.msg_buf = yamato_buf;
//     }
//     }

    if ((await CmCksys.cmUt1QUICPaySystem() != 0)
        || (await CmCksys.cmUt1IDSystem() != 0)
        || (await CmCksys.cmMultiVegaSystem() != 0)) {
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if((wCode == MSG_TID_NOGOOD1) || (wCode == MSG_TID_NOGOOD2)) {
      // memset(ut1_msg, 0, sizeof(ut1_msg));
      // rcMake_Ut1_Msg(wCode, ut1_msg, sizeof(ut1_msg));
      // wCode             = MSG_TID_NOGOOD1;
      // param.er_code     = wCode;
      // param.user_code_4 = ut1_msg;
      // }
    }

    if ((await RcSysChk.rcQRChkPrintSystem())) {
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if( wCode == MSG_SPEEZA_QRRPR_NOTUSE ) {
      // memset(qr_rpr_buf, 0, sizeof(qr_rpr_buf));
      // rcEdit_QR_Rpr_Msg(wCode, qr_rpr_buf, sizeof(qr_rpr_buf));
      // param.user_code_4 = qr_rpr_buf;
      // }
      // else if( wCode == MSG_SPQC_SELECT_OFFLINE_QR ) {
      // param.func1      = (void *)qc_slct_send_err_yes_clicked;
      // param.msg1       = (uchar *)BTN_QR_PRN;
      // param.func2      = (void *)qc_slct_send_err_no_clicked;
      // param.msg2       = (uchar *)BTN_RETURN;
      // }
    }
    // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
    // if (wCode == MSG_PRECA_IN_ERR) {
    // memset(precain_buf, 0x00, sizeof(precain_buf));
    // if (cm_ds2_godai_system())
    // AplLib_ImgRead((long)KY_HCARDIN, precain_buf, 16);
    // else
    // AplLib_ImgRead((long)KY_PRECA_IN, precain_buf, 16);
    // param.msg_buf = precain_buf;
    // }
    //
    // if( cm_precacard_multi_use() ){
    // if(wCode == MSG_MULPRECACARD_VOID_ERR){
    // memset(precain_buf, 0x00, sizeof(precain_buf));
    // AplLib_ImgRead((long)KY_RCPT_VOID, precain_buf, 16);
    // param.msg_buf = precain_buf;
    // }
    // }
    //
    // if(wCode == MSG_AJS_EMONEY_ERR_G65_EXPIRE){
    // memset(errmsg_buf, 0x00, sizeof(errmsg_buf));
    // AplLib_ImgRead((long)KY_HCARDIN, errmsg_buf, 16);
    // param.msg_buf = errmsg_buf;
    // }
    //
    // if (( rcChk_WS_System() )
    // && ( wCode == MSG_USED_COMM_ERR )){
    // // 中古品エラーの場合は、エラー解除後に中分類選択画面を表示する。
    // param.func1 = (void *)rc_PointInfinity_UsedItemErrorProc;
    // param.msg1  = BTN_CONF;
    // }
    //
    // if( rcsyschk_public_barcode_pay3_system() ){
    // if (wCode == MSG_PLUNONFILE){
    // if(cm_public_barcode_pay4_system() && !SelfMem.Staff_Call && rcCheck_FullSelf_Tran_Code128()){
    // //SelfMem.Staff_Callで2ndエラーか判断している
    // //2ndエラーのMSG_PLUNONFILEメッセージを上書きしている
    // memset(buf, 0x00, sizeof(buf));
    // snprintf(buf, sizeof(buf), IMG_PUBLIC_BAR1_PLUNONFILE_MSG, buf_for_saving_subject_id);
    // param.user_code_3 = buf;
    //
    // memset(buf_for_saving_subject_id, 0x00, sizeof(buf_for_saving_subject_id));
    // rcTurnOff_FullSelf_Tran_Code128();
    // }
    // else if( (Ky_St_C0(CMEM->key_stat[KY_READ_MONEY]))
    // && (strlen(CMEM->ent.AddMsgBuf) != 0) ){
    // // 金額読込キー押下時でメッセージが設定されている場合
    // cm_clr(buf, sizeof(buf));
    // memcpy(buf, CMEM->ent.AddMsgBuf, sizeof(CMEM->ent.AddMsgBuf));
    // param.user_code_3 = buf;
    // }
    // }
    // }

    // ダイアログへの追加データをセットする
    // await rcSetDlgAddData(param.msgBuf, wCode);

    // 友の会関連のエラーコードを設定
//     if (rcsyschk_tomoIF_system()
//     &&  ((wCode == MSG_TM_CARDCONF_ERR) || (wCode == MSG_TM_CARDUSE_ERR))){
//     param.msg_buf = &AT_SING->tomonokai_ErrDefail[0];
//     }
//
//
//     if(cm_Barcode_Pay_system()
//     && ((wCode == MSG_FREE_MESSAGE)||(wCode == MSG_ERR_FREE_MESSAGES)||(wCode == MSG_CONTACT_CPS)||(wCode == MSG_CONTACT_PROVIDER)||(wCode == MSG_CONTACT_FROM_CUSTOMER)
//     ||(wCode == MSG_CHECK_PAYMENT_APL)||(wCode == MSG_CONTACT_PAYMENT_BU)||(wCode == MSG_CONTACT_HEADQUARTERS)||(wCode == MSG_CONTACT_CALLCENTER)
//     ||(wCode == MSG_SHOW_AGAIN)||(wCode == MSG_ANOTHER_PAY_AGAIN)
//     ||(wCode == MSG_QUIZ_CONTACT_SUPPORT)
//     ||(wCode == MSG_QUIZ_UNKNOWN_RESULT)
//     ||(wCode == MSG_QUIZ_UNKNOWN_CONTACT)
//     ||(wCode == MSG_QUIZ_PAYMENT_FAILURE)
//     ||(wCode == MSG_QUIZ_VOID_FAILURE) )
//     && (MEM->bcdpay.rx_data.orderResult == BCDPAY_ODR_ERR_END)
//     && strlen(MEM->bcdpay.rx_data.errMessage)){
//     memcpy(buf, MEM->bcdpay.rx_data.errMessage, sizeof(MEM->bcdpay.rx_data.errMessage));
//     param.msg_buf = buf;
//     memset(MEM->bcdpay.rx_data.errMessage, 0x00, sizeof(MEM->bcdpay.rx_data.errMessage));
//     }
//
//     if((rcChk_Custreal_Webser_System()) && ((MEM->tTtllog.t100700.mbr_input == NON_INPUT) || (!rcCheck_Registration())) && (TS_BUF->custreal2.data.webser.rec.err_cd[0] != '0') && (TS_BUF->custreal2.order == 2)){
//     len = strlen(TS_BUF->custreal2.data.webser.rec.err_msg);
//     param.er_code = MSG_FREE_MESSAGE;
//     AplLib_EucCopy(tmp, TS_BUF->custreal2.data.webser.rec.err_msg, 32);
//     kana_cnt = strlen(tmp);
//
//     memset( buf, 0, sizeof(buf) );
//     strncat( buf, (char *)&TS_BUF->custreal2.data.webser.rec.err_msg[0], kana_cnt);
//
//     if(len > 32){
//     strcat( buf, "\n" );
//     AplLib_EucCopy(tmp, (char *)&TS_BUF->custreal2.data.webser.rec.err_msg[kana_cnt], 32);
//     kana_cnt2 = strlen(tmp);
//     cnt = 32 - kana_cnt;
//     strncat( buf, (char *)&TS_BUF->custreal2.data.webser.rec.err_msg[kana_cnt] ,kana_cnt2);
//     }
//     if(len > 64){
//     strcat( buf, "\n" );
//     strncat( buf, (char *)&TS_BUF->custreal2.data.webser.rec.err_msg[32+kana_cnt2-cnt] ,32);
//     }
//     param.msg_buf    = buf;
//     }
//     else if(rcChk_Custreal_UID_System() && ((MEM->tTtllog.t100700.mbr_input == NON_INPUT) || (!rcCheck_Registration())) && (wCode == MSG_MBRNOLIST)){
//     param.er_code = MSG_FREE_MESSAGE;
//     memset( tmp, 0, sizeof(tmp) );
//     AplLib_EucCopy(tmp, TS_BUF->custreal2.data.uid.rec.err_msg, 32);
//     kana_cnt = strlen(tmp);
//     memset( buf, 0, sizeof(buf) );
//     strncat( buf, (char *)&TS_BUF->custreal2.data.uid.rec.err_msg[0], kana_cnt);
//     if((char *)&TS_BUF->custreal2.data.uid.rec.err_msg[kana_cnt] != '\0'){
//     strcat( buf, "\n" );
//     memset( tmp, 0, sizeof(tmp) );
//     AplLib_EucCopy(tmp, (char *)&TS_BUF->custreal2.data.uid.rec.err_msg[kana_cnt], 32);
//     kana_cnt2 = strlen(tmp);
//     strncat( buf, (char *)&TS_BUF->custreal2.data.uid.rec.err_msg[kana_cnt] ,kana_cnt2);
//     }
//     if((char *)&TS_BUF->custreal2.data.uid.rec.err_msg[kana_cnt2+kana_cnt] != '\0'){
//     strcat( buf, "\n" );
//     strncat( buf, (char *)&TS_BUF->custreal2.data.uid.rec.err_msg[kana_cnt2+kana_cnt], 32);
//     }
//     param.msg_buf    = buf;
//     }
//     else if( (qr_txt_status != QR_TXT_STATUS_INIT) &&
//     ((wCode == MSG_BARFMTERR) || (wCode == MSG_PLUNONFILE) || (wCode == MSG_CNCL_AND_GO_COUNTER)) ) {
//     //((wCode == MSG_BARFMTERR) || (wCode == MSG_PLUNONFILE) || (wCode == MSG_QRDATAERR)) ) {
//     memset( buf, 0, sizeof(buf) );
//     memset( tmp_code, 0, sizeof(tmp_code) );
//
//     if( rcQC_Chk_Qcashier_System() ) {
//     len = strlen(qr_txt_err_barcode);
//     if( len > DLG_MSG_CNT_MAX )
//     strncat( tmp_code, (char *)&qr_txt_err_barcode[0], DLG_MSG_CNT_MAX);
//     else
//     strncat( tmp_code, (char *)&qr_txt_err_barcode[0], len);
//     }
//     else {
//     len = strlen(CMEM->working.jan_inf.Code);
//     if( len > DLG_MSG_CNT_MAX )
//     strncat( tmp_code, (char *)&CMEM->working.jan_inf.Code[0], DLG_MSG_CNT_MAX);
//     else
//     strncat( tmp_code, (char *)&CMEM->working.jan_inf.Code[0], len);
//     }
//
//     if( wCode == MSG_BARFMTERR ) {
//     param.er_code = MSG_QRBARFMTERR;
//     sprintf( buf, ER_MSG_QRBARFMTERR, tmp_code);
//     }
//     else if( wCode == MSG_PLUNONFILE ) {
//     param.er_code = MSG_QRPLUNONFILE;
//     sprintf( buf, ER_MSG_QRPLUNONFILE, tmp_code);
//     }
// //     else if( wCode == MSG_QRDATAERR ) {
// //        param.er_code = MSG_QRDATAERR;
// //        sprintf( buf, ER_MSG_QRDATAERR, tmp_code);
// //     }
//     else if( wCode == MSG_CNCL_AND_GO_COUNTER ) {
//     param.er_code = MSG_CNCL_AND_GO_COUNTER;
//     sprintf( buf, ER_MSG_CNCL_AND_GO_COUNTER, tmp_code);
//     }
//
//     param.user_code_3    = buf;
//
//     sprintf(tmp, "%s Err(%d) Code[%s]\n", __FUNCTION__, param.er_code, tmp_code);
//     TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 1, tmp);
//     }
//     else if( (rcQC_Chk_Qcashier_System()) && (wCode == MSG_BARFMTERR) && ((rcQC_Check_StaffDsp_Mode()) || (rcQC_Check_PassWardDsp_Mode()) || (rcQC_Check_SusDsp_Mode())) ) {
//     //param.er_code = MSG_PLSREAD_STAFFBAR;
//     if( rcsyschk_sm65_ryubo_system() ){
//     param.er_code = MSG_PLSREAD_MENTBAR2;
//     }else{
//     param.er_code = MSG_NOT_EMPLOYEEBAR;
//     }
//     sprintf(tmp, "%s Change ErrCode(%d)\n", __FUNCTION__, param.er_code);
//     TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, tmp);
//     }
//     else if((rcChk_Custreal_OP_System()) && ((MEM->tTtllog.t100700.mbr_input == NON_INPUT) || (!rcCheck_Registration())) && (TS_BUF->custreal2.data.op.rec.err_cd[2] != '0') && (TS_BUF->custreal2.data.op.rec.err_cd[2] != '\0')){
//     len = strlen(TS_BUF->custreal2.data.op.rec.err_msg);
//     param.er_code = MSG_FREE_MESSAGE;
//     AplLib_EucCopy(tmp, TS_BUF->custreal2.data.op.rec.err_msg, 72);
//     kana_cnt = strlen(tmp);
//
//     memset( buf, 0, sizeof(buf) );
//     strncat( buf, (char *)&TS_BUF->custreal2.data.op.rec.err_msg[0], kana_cnt);
//
//     if(len > 32){
//     strcat( buf, "\n" );
//     AplLib_EucCopy(tmp, (char *)&TS_BUF->custreal2.data.op.rec.err_msg[kana_cnt], 32);
//     kana_cnt2 = strlen(tmp);
//     cnt = 32 - kana_cnt;
//     strncat( buf, (char *)&TS_BUF->custreal2.data.op.rec.err_msg[kana_cnt] ,kana_cnt2);
//     }
//     if(len > 64){
//     strcat( buf, "\n" );
//     strncat( buf, (char *)&TS_BUF->custreal2.data.op.rec.err_msg[32+kana_cnt2-cnt] ,32);
//     }
//     param.msg_buf    = buf;
//     }
//     else if ((rcChk_Custreal_PointTactix_System())
//     && (rcCustReal2_PTactix_ChkErrorDsp(wCode))){
//     memset(buf, 0, sizeof(buf));
//     if (rcCustReal2_PTactix_GetDspCode(buf, sizeof(buf)) > 0){
//     param.user_code_4 = buf;
//     }
//     }
//
//     if (rcsyschk_yunaito_hd_system()) {	// ユナイト仕様
//     if (rcCheck_StdCpn_ReadDsp_Mode()) {	// クーポン読込画面表示中
//     // ユナイト仕様のクーポン読込画面時のエラー音を変更
//     param.beepData.File="err_2.wav";
//     param.beepData.Count=1;
//     buzzer_skip=1;
//     }
//     }

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      // param.dual_dev = 1;
    }
    if (await RcSysChk.rcSGChkSelfGateSystem()
        && !await RcFncChk.rcCheckRfmMode()) {
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if (rcNewSG_Chk_NewSelfGate_System())
      // rcNewSGDsp_GtkTimerRemove();
      // if( (rcSG_Dual_SubttlDsp_Chk()) || (rcSG_Dual_Crdt_SubttlDsp_Chk()) || (self_acbacr_err_flg == 1) ||
      // (((rcSG_Check_Mcp200_System()) || (wCode == MSG_ACB_START_ERR)) && (rcSG_Check_End_Mode())) )
      // DualDsp.dualdsp_err = wCode;
      // else
      // CMEM->ent.err_no = wCode;
      // if (rcSG_Chk_Ampm_System()) {
      // rcSound_Stop();
      // rcSG_Dsp_GtkTimerRemove();
      // rcSG_Cncl_GtkTimerRemove();
      // }
      // if (rcSGChk_StaffCall()) {
      // rcSGSnd_GtkTimerRemove();
      // if (rcNewSG_Chk_NewSelfGate_System()) {
      // SelfMem.call_btn = 3;
      // rcNewSG_ComTimer_GifDsp();
      // rcSGSnd_GtkTimerAdd(1000, (GtkFunction)rcSG_SoundTimer_Proc);
      // }
      // else if (rcSG_Chk_Ampm_System())
      // rcSound_Stop();
      // else {
      // SelfMem.sound_num = (char *)SND_0017;
      // rcSGSnd_GtkTimerAdd(1000, (GtkFunction)rcSG_SoundTimer_Proc);
      // }
      // SelfMem.bz_timer_end = 2;
      // rcSG_CallBuzzer_Proc();
      // if (rcSG_Chk_Ampm_System()) {
      // if ( wCode == MSG_TEXT92 )
      // param.er_code = MSG_TEXT91;
      // else
      // param.er_code = MSG_TEXT45;
      // }
      // else
      // param.er_code = MSG_JUST_MOMENT;
      // if (!rcSG_Check_Mnt_Mode())
      // rcSG_SignP_SignBlink(ALL_COLOR);
      // }
      // else {
      // if (param.er_code == MSG_OPEERR) {
      // rcSGSnd_GtkTimerRemove();
      // if (rcNewSG_Chk_NewSelfGate_System())
      // SelfMem.sound_num = (char *)SND_1004;
      // else
      // SelfMem.sound_num = (char *)SND_0018;
      // rcSGSnd_GtkTimerAdd(1000, (GtkFunction)rcSG_SoundTimer_Proc);
      // param.er_code = MSG_OPEMISS;
      // }
      // else if(cm_ZHQ_system()
      // && (CMEM->ent.err_no == MSG_ANOTHER_STORE_CARD)) {	// 他店カード
      // rcQC_CallBuzzer_Proc();
      // }
      // if ((!rcSG_Check_Mnt_Mode()) && (CMEM->stat.FncCode != KY_STAFFCALL) &&
      // (all_blink == 0) && (MntDsp.mnt_dsp == 0) && (! rcSG_Check_Check_Mode())) {
      // if((! rcSG_Check_Ndpswd_Mode()) && (! rcCheck_SpritMode()))
      // rcSG_SignP_SignBlink(RED_COLOR);
      // }
      // }
      //
      // if (StartDsp.sg_start == 0) {
      // param.dialog_ptn = TPRDLG_PT5;
      // param.msg1       = BTN_END;
      // #if 0
      // if( titl_clrflg == 0 )
      // param.title      = ERR_TITLE;
      // else if( titl_clrflg == 2 )
      // param.title = BTN_CONF;
      // #endif
      // rcNtt_SetErrCode(&param);
      // }
      // else {
      // if(C_BUF->db_trm.loason_nw7mbr)
      // param.dialog_ptn = TPRDLG_PT15;
      // else if ((rcChk_SQRC_Ticket_System()) && (sqrc_callbtn_flg == 1))
      // param.dialog_ptn = TPRDLG_PT12;
      // else if ((rcSG_Chk_Callbuzzer_Select()) && (wCode == MSG_JUST_MOMENT))
      // param.dialog_ptn = TPRDLG_PT12;
      // else if ((rcSG_Chk_Callbuzzer_Select()) && (wCode == MSG_AGE_CHECK_JUST_MOMENT))
      // {
      // param.dialog_ptn = TPRDLG_PT12;
      // }
      // else if(cm_ZHQ_system()
      // && (CMEM->ent.err_no == MSG_ANOTHER_STORE_CARD))	// 他店カード
      //     {
      // param.dialog_ptn = TPRDLG_PT12;
      // }
      // else if ((rcSG_Chk_SelfGate_System()) && ((param.er_code == MSG_AGE_CHECK_ERR) || (param.er_code == MSG_AGE_CHECK_OK)))
      // {
      // param.dialog_ptn = TPRDLG_PT8;
      // }
      // else
      // param.dialog_ptn = TPRDLG_PT13;
      // if((rcSG_Chk_SelfGate_System()) && ((param.er_code == MSG_AGE_CHECK_ERR)|| (param.er_code == MSG_AGE_CHECK_OK)))
      // {
      // //確認ボタンを非表示
      // param.msg1 = NULL;
      // }
      // else
      // {
      // param.msg1       = BTN_CONF;
      // }
      // if( (rcSG_Dual_Crdt_SubttlDsp_Chk()) && (SelfMem.Staff_Call == 0) && (CMEM->stat.FncCode != KY_STAFFCALL) ){
      // rcNtt_SetErrCode(&param);
      // }
      // else if( (cm_Suica_system()) && (SelfMem.Staff_Call == 0) ){
      // rcNtt_SetErrCode(&param);
      // }
      // }
      // if ((rcSG_Dual_SubttlDsp_Chk()) || (rcSG_Dual_Crdt_SubttlDsp_Chk()) ||
      // #if MC_SYSTEM
      // (SelfMCReadDsp.MC_Read_disp == 1) ||
      // #endif
      // (rcNewSG_Dual_Edy_SubttlDsp_Chk()) || (rcSG_Check_Ndpswd_Mode()) || (rcSG_Dual_Suica_SubttlDsp_Chk()) ||
      // (rcCheck_SpritMode()) || (ChkDsp.pass_wd_flg == 3) ) {
      // if( rcChk_Quick_Self_System() ) {
      // param.dual_dsp = 1;
      // param.dual_dev = 1;
      // }
      // else if (! rcNewSG_Chk_NewSelfGate_System()) {
      // if( DualDsp.dualdsp_err != MSG_OPEACNTERR ) {
      // param.dual_dsp = 2;
      // param.dual_dev = 1;
      // }
      // }
      // }
      // if (rcSG_GuidancePresetDsp_Check()) {
      // if ((rcSG_Check_MulItem_Mode()) && (ItmDsp.scan_muldisp == 0)) {
      // param.dual_dsp = 2;
      // param.dual_dev = 1;
      // }
      // if (rcSG_Check_Pre_Mode()) {
      // if (SelfMem.exp_disp == 1)
      // rcNewSG_Explain_ScrMode();
      // else
      // rcStlLcd_ScrMode();
      // }
      // }
      // if (rcChk_SQRC_Ticket_System())
      // param.func1      = (void *) rcSQRC_ClrKey_Proc;
      // else
      // param.func1      = (void *) rcSG_ClrKey_Proc;
      // if (! rcSGChk_StaffCall()) {
      // if(strlen(money_buf))
      // {
      // param.user_code_2 = money_buf;
      // if(rcChk_AcrAcb_RjctErr(param.er_code))
      // {
      // param.user_code_4 = ACX_FULL_MSG;
      // }
      // }
      // }
      //
      // if((rcChk_dPoint_SelfSystem())
      // && (strlen(AT_SING->dpoint_ew_code))
      // && ((param.er_code == MSG_DPNT_UNREGI_MBR)
      // || (param.er_code == MSG_DPNT_CANTUSEPNT_MBR)
      // || (param.er_code == MSG_DPNT_GIVEPNT_LATER)
      // || (param.er_code == MSG_DPNT_GIVEPNT_LATER2)
      // || (param.er_code == MSG_DPNT_CARD_ABSENCE)
      // || (param.er_code == MSG_DPNT_INVALID_CARD)
      // || (param.er_code == MSG_DPNT_USEPNT_SHORT)
      // || (param.er_code == MSG_DPNT_CANTUSEPNT)))
      // {
      // cm_clr(dpoint_ew_title, sizeof(dpoint_ew_title));
      // snprintf(dpoint_ew_title, sizeof(dpoint_ew_title), "[ %s ]", AT_SING->dpoint_ew_code);
      // param.user_code_2 = dpoint_ew_title;
      // cm_clr(AT_SING->dpoint_ew_code, sizeof(AT_SING->dpoint_ew_code));
      // param.dialog_ptn = TPRDLG_PT15;
      // }
      //
      // if ((rcChk_RPoint_SelfSystem())			/* 楽天ポイント仕様のフルセルフレジ */
      // && (!rcSGChk_StaffCall())				/* 店員呼出中以外 */
      // && (rcSG_Check_MbrScn_Mode())			/* 会員読込画面 */
      // && (strlen(AT_SING->rpoint_ew_code)))
      // {
      // cm_clr(rpoint_ew_code, sizeof(rpoint_ew_code));
      // snprintf(rpoint_ew_code, sizeof(rpoint_ew_code), "[%s]", AT_SING->rpoint_ew_code);
      // param.user_code_2 = rpoint_ew_code;
      // cm_clr(AT_SING->rpoint_ew_code, sizeof(AT_SING->rpoint_ew_code));
      // }
      //
      // if(param.er_code == MSG_CONF_AGE_CHECK)
      // {
      // param.dialog_ptn = TPRDLG_PT1;
      // param.func1      = (void *)rcSG_AgeCheck_Dlg_Yes;
      // param.msg1       = (uchar *)BTN_YES;
      // param.func2      = (void *)rcSG_AgeCheck_Dlg_No;
      // param.msg2       = (uchar *)BTN_NO;
      // }
      //
      //
      // rc_cashless_add_dlgmsg ( &param );	// キャッシュレス還元メッセージ追加
      // TprLibDlg(&param);
      // if (ChkDsp.pass_wd_flg == 0)
      // rcSG_Make_LogData(param.er_code);
      // else {
      // strcat(asst_pc_log, TS_BUF->managepc.msglog_buf);
      // rc_Assist_Send(param.er_code);
      // }
      await rcNttSetErrCode(param);
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        //　フルセルフ
        if (RckyRpr.rprBtnFlg == 1 || RckyRfm.rfmBtnFlg == 1) { // 領収書,再発行ボタン押下時
          MsgDialog.show(MsgDialog.singleButtonDlgId(
              dialogId: wCode,
              type: MsgDialogType.error,
              footerMessage: await rcMakeUt1Msg(wCode),
              btnFnc: () async {
                await RckyClr.rcKyClr();
                Get.back();
              }));
        }
        else {
          MsgDialog dialog = MsgDialog.singleButtonDlgId(
              dialogId: wCode, type: MsgDialogType.error,
              footerMessage: await rcMakeUt1Msg(wCode),
              btnFnc: () async {
                await RckyClr.rcKyClr();
                toPageFunc();  //登録or小計画面へ戻す
              });
          //  店員呼び出し画面表示後にダイアログを表示する
          Get.to(() => FullSelfCallStaffPage(msgDialog: dialog));
        }
      }
    }
    else if (await RcSysChk.rcQCChkQcashierSystem()) {
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // CMEM->ent.err_no = wCode;
      // rcQC_Change_ErrMsg(param.er_code);
      // if( !(rcQC_Check_MenteDsp_Mode()) && !(rcQC_SignP_Chk()) && !(rc_Masr_NoCall_ErrChk(param.er_code)) ) {
      // if(rcChk_SmartSelf_System() && !rcChk_HappySelf_QCashier()) //HappySelfフルセルフの会計時
      //     {
      // if(param.er_code == MSG_GOAWAY_OPE) { //立ち去り
      // rcQC_SignP_SignBlink(YELLOW_RED_COLOR);
      // if(C_BUF->psensor_away_sound){
      // buzzer_skip = 1;
      // }
      // }
      // else{
      // rcQC_SignP_SignBlink(GREEN_COLOR);
      // }
      //
      // }else{
      // rcQC_SignP_SignBlink(GREEN_COLOR);
      // }
      //
      // if((rcChk_Shop_and_Go_System()) && ((param.er_code == MSG_AGE_CHECK_ERR)|| (param.er_code == MSG_AGE_CHECK_OK))){
      // buzzer_skip = 1;
      // }
      //
      // if(buzzer_skip != 1){
      //
      // rcQC_CallBuzzer_Proc();
      // }
      // }
      //
      // //if( (param.er_code == MSG_QRBARFMTERR) || (param.er_code == MSG_QRPLUNONFILE) || (param.er_code == MSG_QRDATAERR)
      // if( (param.er_code == MSG_QRBARFMTERR) || (param.er_code == MSG_QRPLUNONFILE) || (param.er_code == MSG_CNCL_AND_GO_COUNTER)
      // || (param.er_code == MSG_MASR_CARD_ERR) || (param.er_code == MSG_MASR_CARDCONF) || (param.er_code == MSG_VESCA_BALANCE_SHORT)){
      // param.dialog_ptn = TPRDLG_PT15;
      // }
      // else if(rc_Masr_NoCall_ErrChk(param.er_code)){
      // param.dialog_ptn = TPRDLG_PT12;
      // }
      // else if	((rcChk_Shop_and_Go_System()) && ((param.er_code == MSG_AGE_CHECK_ERR)|| (param.er_code == MSG_AGE_CHECK_OK))){
      // param.dialog_ptn = TPRDLG_PT8;
      // }else{
      // if (rc_gcat_vesca_err_music () == TRUE){
      // /* エラー音がエコーしてしまう場合があるため、音がないダイアログへ変更 */
      // param.dialog_ptn = TPRDLG_PT12;
      // }else{
      // param.dialog_ptn = TPRDLG_PT13;
      // }
      // }
      // if(!(rcQC_Check_CrdtUse_Mode()  && (param.er_code == MSG_TAKE_CARD))) {
      // if((rcChk_Shop_and_Go_System()) && ((param.er_code == MSG_AGE_CHECK_ERR)|| (param.er_code == MSG_AGE_CHECK_OK))){
      // //確認ボタンを非表示
      // param.msg1 = NULL;
      // param.func1 = NULL;
      // }else{
      // param.msg1 = BTN_CONF;
      // param.func1 = (void *)rcQC_ClrKey_Proc;
      // }
      // }
      //
      // if(rcQC_Check_CrdtUse_Mode() ||
      // rcQC_Check_CrdtEnd_Mode() ||
      // rcQC_Check_CrdtDsp_Mode() ||
      // rcQC_Check_Edy_Mode()     )
      // rcNtt_SetErrCode(&param);
      //
      // #if ARCS_MBR
      // if( rcChk_NTTD_Preca_System() && (AT_SING->add_error_cd[0] == 'U') )
      // rcNtt_SetErrCode(&param);
      // #endif
      //
      // if( rcChk_TRK_Preca_System() && atoi((char *)AT_SING->add_error_cd) )
      // rcNtt_SetErrCode(&param);
      //
      // if ( rcChk_Repica_System() && (AT_SING->add_error_cd[0]) ){
      // rcNtt_SetErrCode(&param);
      // }
      //
      // if( rcChk_Cogca_System() && (AT_SING->add_error_cd[0] == 'S')){
      // rcNtt_SetErrCode(&param);
      // }
      //
      // if( rcChk_ValueCard_System() && atoi((char *)AT_SING->add_error_cd) ){
      // rcNtt_SetErrCode(&param);
      // }
      //
      // if( (rcChk_Ajs_Emoney_System())
      // && (   (AT_SING->add_error_cd[0] == 'G')
      // || (AT_SING->add_error_cd[0] == 'C')
      // || (AT_SING->add_error_cd[0] == 'S')
      // || (AT_SING->add_error_cd[0] == 'W')) ){
      // rcNtt_SetErrCode(&param);
      // }
      //
      // if((rcChk_dPoint_System())
      // && (strlen(AT_SING->dpoint_ew_code))
      // && ((param.er_code == MSG_DPNT_GIVEPNT_LATER)
      // || (param.er_code == MSG_DPNT_GIVEPNT_LATER2)
      // || (param.er_code == MSG_DPNT_CARD_ABSENCE)
      // || (param.er_code == MSG_DPNT_INVALID_CARD))){
      // cm_clr(dpoint_ew_title, sizeof(dpoint_ew_title));
      // snprintf(dpoint_ew_title, sizeof(dpoint_ew_title), "[ %s ]", AT_SING->dpoint_ew_code);
      // param.user_code_2 = dpoint_ew_title;
      // cm_clr(AT_SING->dpoint_ew_code, sizeof(AT_SING->dpoint_ew_code));
      // param.dialog_ptn = TPRDLG_PT15;
      // }
      //
      // if ((rcChk_RPointMbr_Read_TMC_QCashier ())			/* タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ */
      // && (!rcQC_Check_StaffDsp_Mode())					/* 店員呼出中以外 */
      // && (rcQC_Check_RPtsMbr_Read_Mode())				/* 精算機での楽天ポイントカードの読込画面 */
      // && (rcQR_RpointReadErr_After_FlgChk(__FUNCTION__))	/* 楽天ポイントカード照会結果継続不可エラー時の後処理フラグが有効 */
      // && (strlen(AT_SING->rpoint_ew_code))){
      // cm_clr(rpoint_ew_code, sizeof(rpoint_ew_code));
      // snprintf(rpoint_ew_code, sizeof(rpoint_ew_code), "[%s]", AT_SING->rpoint_ew_code);
      // param.user_code_2 = rpoint_ew_code;
      // cm_clr(AT_SING->rpoint_ew_code, sizeof(AT_SING->rpoint_ew_code));
      // }
      //
      // if ( (rcfncchk_Qcashier_Member_Read_System())				/* 精算機で会員カード読取可能なレジ */
      // && (!rcQC_Check_StaffDsp_Mode())					/* 店員呼出中以外 */
      // && (rcfncchk_Check_Qcashier_Member_Read_Entry_Mode())			/* 精算機での会員カード読取画面 */
      // && (rcqc_dsp_Qcashier_Member_Read_ReadErr_After_FlgChk(__FUNCTION__))	/* 精算機での会員カード読取結果継続不可エラー時の後処理フラグが有効 */
      // && (strlen(AT_SING->rpoint_ew_code)) ){
      // cm_clr(rpoint_ew_code, sizeof(rpoint_ew_code));
      // snprintf(rpoint_ew_code, sizeof(rpoint_ew_code), "[%s]", AT_SING->rpoint_ew_code);
      // param.user_code_2 = rpoint_ew_code;
      // cm_clr(AT_SING->rpoint_ew_code, sizeof(AT_SING->rpoint_ew_code));
      // }
      //
      // if((rcChk_MultiVega_PayMethod(FCL_SUIC))
      // && (((rcQC_Check_SuicaTch_Mode())
      // && (TS_BUF->multi.fcl_data.snd_data.ttl_amt != 0)))
      // || (rcQC_Check_SuicaChk_Mode())){
      // param.dialog_ptn = TPRDLG_PT15;
      // }
      //
      // if (cm_multi_vega_system()){
      // if (TS_BUF->multi.fcl_data.s_kind == FCL_ID){       // 検定通す為まずはiDに限定
      // rcNtt_SetErrCode(&param);
      // }
      // }
      //
      // if(strlen(money_buf)){
      // param.user_code_2 = money_buf;
      // if(rcChk_AcrAcb_RjctErr(param.er_code)){
      // param.user_code_4 = ACX_FULL_MSG;
      // }
      // }
      //
      // if(param.er_code == MSG_CONF_AGE_CHECK){
      // param.dialog_ptn = TPRDLG_PT1;
      // param.func1      = (void *)rcSG_AgeCheck_Dlg_Yes;
      // param.msg1       = (uchar *)BTN_YES;
      // param.func2      = (void *)rcSG_AgeCheck_Dlg_No;
      // param.msg2       = (uchar *)BTN_NO;
      // }
      //
      // rc_cashless_add_dlgmsg ( &param );	// キャッシュレス還元メッセージ追加
      // TprLibDlg(&param);
      // strcat(asst_pc_log, TS_BUF->managepc.msglog_buf);
      // rc_Assist_Send(param.er_code);
    } else {
      param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if(cogcaStat.ic_read_flg
      // || rcCogca_ICCard_Chk()) {  /* ICカードの場合音無し */
      // param.dialog_ptn = TPRDLG_PT32;
      // cogcaStat.ic_read_flg = 0;
      // cogcaStat.ic_tran_flg = 0;
      // }

      if (titlClrflg == 0) {
//     param.title      = ERR_TITLE;
      }
      else if (titlClrflg == 2) {
        param.dialogPtn = DlgPattern.TPRDLG_PT8.dlgPtnId;
//        param.title = BTN_CONF;
      }
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if((rcChk_Custreal_Webser_System()) && ((MEM->tTtllog.t100700.mbr_input == NON_INPUT) || (!rcCheck_Registration())) &&
      // (((TS_BUF->custreal2.data.webser.rec.err_cd[0] != '0') && (TS_BUF->custreal2.order == 2)) || (TS_BUF->custreal2.stat == 5))){
      // memset(error_cd2, 0x0, sizeof(error_cd2));
      // strncat(error_cd2, BTN_ERR, sizeof(BTN_ERR));
      // memset((char *)&error_cd2[6], '[', 1);
      // memcpy((char *)&error_cd2[7], TS_BUF->custreal2.data.webser.rec.err_cd, 5);
      // memset((char *)&error_cd2[12], ']', 1);
      // param.title       = error_cd2;
      // cm_clr((char *)&TS_BUF->custreal2.data.webser.rec.err_cd[0], sizeof(TS_BUF->custreal2.data.webser.rec.err_cd));
      // TS_BUF->custreal2.order = 0;
      // TS_BUF->custreal2.sub = 0;
      // TS_BUF->custreal2.stat = 0;
      // }
      await rcNttSetErrCode(param);
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
//     if((rcChk_Custreal_OP_System()) && ((MEM->tTtllog.t100700.mbr_input == NON_INPUT) || (!rcCheck_Registration())) && (TS_BUF->custreal2.data.op.rec.err_cd[2] != '0') && (TS_BUF->custreal2.data.op.rec.err_cd[2] != '\0')){
//     memset(error_cd2, 0x0, sizeof(error_cd2));
//     strncat(error_cd2, BTN_ERR, sizeof(BTN_ERR));
//     memset((char *)&error_cd2[6], '[', 1);
//     memcpy((char *)&error_cd2[7], TS_BUF->custreal2.data.op.rec.err_cd, 3);
//     memset((char *)&error_cd2[10], ']', 1);
//     param.title       = error_cd2;
// //        cm_clr((char *)&TS_BUF->custreal2.data.op.rec.err_cd[0], sizeof(TS_BUF->custreal2.data.webser.rec.err_cd));
//     TS_BUF->custreal2.order = 0;
//     TS_BUF->custreal2.sub = 0;
//     TS_BUF->custreal2.stat = 0;
//     cm_clr((char *)&TS_BUF->custreal2.data.op.rec, sizeof(TS_BUF->custreal2.data.op.rec));
//     }
//
//     if((rcChk_dPoint_System())
//     && (strlen(AT_SING->dpoint_ew_code)))
//     {
//     cm_clr(dpoint_ew_title, sizeof(dpoint_ew_title));
//     snprintf(dpoint_ew_title, sizeof(dpoint_ew_title), "[ %s ]", AT_SING->dpoint_ew_code);
//     param.user_code_2 = dpoint_ew_title;
//     cm_clr(AT_SING->dpoint_ew_code, sizeof(AT_SING->dpoint_ew_code));
//     }
//
//     if((rcsyschk_Rpoint_System())
//     && strlen(AT_SING->rpoint_ew_code))
//     {
//     cm_clr(rpoint_ew_code, sizeof(rpoint_ew_code));
//     snprintf(rpoint_ew_code, sizeof(rpoint_ew_code), "[%s]", AT_SING->rpoint_ew_code);
//     param.user_code_2 = rpoint_ew_code;
//     cm_clr(AT_SING->rpoint_ew_code, sizeof(AT_SING->rpoint_ew_code));
//     }
//
//     if(strlen(money_buf))
//     {
//     param.user_code_2 = money_buf;
//     if(rcChk_AcrAcb_RjctErr(param.er_code))
//     {
//     param.user_code_4 = ACX_FULL_MSG;
//     }
//     }
//     rc_cashless_add_dlgmsg ( &param );	// キャッシュレス還元メッセージ追加
//       TprLibDlg(&param);
      // TODO:10121 QUICPay、iD 202404実装対象外　エラーメッセージの設定をする
      AcMem cMem = SystemFunc.readAcMem();
      if ((cMem.stat.scrMode == RcRegs.VD_QP)
          || (cMem.stat.scrMode == RcRegs.VD_ID)) {
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
              dialogId: wCode, type: MsgDialogType.error,
              footerMessage: await rcMakeUt1Msg(wCode),
              btnFnc: () async {
                await RckyClr.rcKyClr();
                Get.until((route) =>
                route.settings.name == '/receiptinputpage');
              }),
        );
      }
      else if(Get.currentRoute == '/ChargeCollectScreen') {
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
              dialogId: wCode,
              type: MsgDialogType.error,
              footerMessage: await rcMakeUt1Msg(wCode),
              btnFnc: () async {
                await RckyClr.rcKyClr();
                String title = 'つり機回収';
                Get.until((route) =>
                route.settings.name == '/ChargeCollectScreen');
              }),
        );
      }
      else {
        MsgDialog dialog = MsgDialog.singleButtonDlgId(
            dialogId: wCode, type: MsgDialogType.error,
            footerMessage: await rcMakeUt1Msg(wCode),
            btnFnc: () async {
              await RckyClr.rcKyClr();
              toPageFunc();  //登録or小計画面へ戻す
            });
        if (await RcSysChk.rcSGChkSelfGateSystem()) {
          //  店員呼び出し画面表示後にダイアログを表示する
          Get.to(() => FullSelfCallStaffPage(msgDialog: dialog));
        } else {
          MsgDialog.show(dialog);
        }
      }
      // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
      // if(subinit_Main_single_Special_Chk() == TRUE) {
      // param.dual_dsp = 3;
      // TprLibDlg(&param);
      // }
    }
    // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
//     #else
//     param.dialog_ptn = TPRDLG_PT4;
//     if( titl_clrflg == 0 )
//     {
// //  param.title      = ERR_TITLE;
//     }
//     else if( titl_clrflg == 2 )
//     {
//     param.dialog_ptn = TPRDLG_PT8;
// //     param.title = BTN_CONF;
//     }
//     rcNtt_SetErrCode(&param);
//     if(strlen(money_buf))
//     {
//     param.user_code_2 = money_buf;
//     if(rcChk_AcrAcb_RjctErr(param.er_code))
//     {
//     param.user_code_4 = ACX_FULL_MSG;
//     }
//     }
//     rc_cashless_add_dlgmsg ( &param );	// キャッシュレス還元メッセージ追加
//     TprLibDlg(&param);
//     if(subinit_Main_single_Special_Chk() == TRUE) {
//     param.dual_dsp = 3;
//     TprLibDlg(&param);
//     }
//     #endif

    rcResetDlgAddData(); // ダイアログ追加データ初期化
    // TODO:10121 QUICPay、iD 202404実装対象外(トレースログより、いったん後回し)
    // if( (rcChk_VEGA_Process()) && (rcSG_Check_MbrScn_Mode()) && (SelfMem.Staff_Call == 1) )
    // {
    // /* 店員呼出ダイアログ表示でエラーコードがクリアされるので、再セットする */
    // rc_Vega_ErrChk();
    // }
  }

  ///  関連tprxソース: rc_ewdsp.c - rcErrMsgChg
  static Future<int> rcErrMsgChg(int wCode, int titlClrflg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if(CompileFlag.RESERV_ACX){
      if((await CmCksys.cmReservSystem() != 0 || await CmCksys.cmNetDoAreservSystem() != 0)
          && RcReserv.rcReservReceiptCall()){
        if (wCode == DlgConfirmMsgKind.MSG_ACB_DEC_NOT_RESERV.dlgId){
          titlClrflg = 2;
        }
      }
    }

    if(await RcSysChk.rcChkZHQsystem()){
      if(wCode == DlgConfirmMsgKind.MSG_MST_CONF.dlgId){
        titlClrflg = 3;
      }
    }

    // ダイアログタイトルをエラーではなく確認としたいため
    DlgConfirmMsgKind define = DlgConfirmMsgKind.getDefine(wCode);
    switch(define){
      case DlgConfirmMsgKind.MSG_VDMODE:
      case DlgConfirmMsgKind.MSG_TRMODE:
      case DlgConfirmMsgKind.MSG_SRMODE:
      case DlgConfirmMsgKind.MSG_ODMODE:
      case DlgConfirmMsgKind.MSG_IVMODE:
      case DlgConfirmMsgKind.MSG_PDMODE:
        titlClrflg = 2;
        break;
      default: break;
    }

    if(cBuf.dbTrm.chgWarnWordVdTrSr != 0){
      switch(define){
//        case MSG_TRMODE: wCode = MSG_TRMODEING; *titl_clrflg = 1; break;
        case DlgConfirmMsgKind.MSG_TRMODE:
          wCode = DlgConfirmMsgKind.MSG_PRACTIC.dlgId;
          titlClrflg = 1;
          break;
        case DlgConfirmMsgKind.MSG_VDMODE:
          wCode = DlgConfirmMsgKind.MSG_VDMODEING.dlgId;
          titlClrflg = 1;
          break;
        case DlgConfirmMsgKind.MSG_SRMODE:
          wCode = DlgConfirmMsgKind.MSG_SRMODEING.dlgId;
          titlClrflg = 1;
          break;
        default: break;
      }
    }

    if(await CmCksys.cmMarutoSystem() != 0){
      switch(define){
        case DlgConfirmMsgKind.MSG_MBRNOLIST:
          wCode = DlgConfirmMsgKind.MSG_MARUTO_DISABLECARD.dlgId;		/* 無効カード */
          titlClrflg = 1;
          break;
        default: break;
      }
    }
    return wCode;
  }

  ///  関連tprxソース: rc_ewdsp.c - rcEdit_Jmups_Msg
  // static String rcEditJmupsMsg(int wCode, String yamatoBuf, int size){
  static String rcEditJmupsMsg(int wCode){
    String buf = '';

    if (wCode == DlgConfirmMsgKind.MSG_INQUIRE_SETTLE.dlgId) {
      //strncat(buf, ER_MSG_TEXT11, 4);
      buf = LRccrdt.CCT_PAYMENT;
    }
    return buf;
  }

  ///  関連tprxソース: rc_ewdsp.c - rcEdit_Yamato_Msg
  // static String rcEditYamatoMsg(int wCode, String yamato_buf, int size){
  static String rcEditYamatoMsg(int wCode){
    String buf = '';
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return buf;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((wCode == DlgConfirmMsgKind.MSG_CANNOT_SPTEND_CANCEL.dlgId)
        || (wCode == DlgConfirmMsgKind.MSG_INQUIRE_SETTLE.dlgId)
        || (wCode == DlgConfirmMsgKind.MSG_ETARMINAL_CASHRETURN.dlgId)) {
      switch (atSing.yamatoSettleTyp) {
        case 2:
          buf = buf + LRccrdt.IMG_YAMATO_EDY;
          break;
        case 7:
          buf = buf + LRccrdt.IMG_YAMATO_SUICA;
          break;
        case 21:
          buf = buf + LRccrdt.IMG_YAMATO_WAON;
          break;
        case 22:
          buf = buf + LRccrdt.IMG_YAMATO_NANACO;
          break;
        default:
          buf = buf + LRccrdt.IMG_YAMATO_EMONEY;
          break;
      }
    } else if (wCode == DlgConfirmMsgKind.MSG_ETARMINAL_BALANCE_SHORT.dlgId) {
      switch (atSing.yamatoSettleTyp) {
        case 2:
          buf = sprintf(LRccrdt.IMG_YAMATO_BAL_EDY, [tsBuf.jpo.price]);
          break;
        case 7:
          buf = sprintf(LRccrdt.IMG_YAMATO_BAL_SUICA, [tsBuf.jpo.price]);
          break;
        case 21:
          buf = sprintf(LRccrdt.IMG_YAMATO_BAL_WAON, [tsBuf.jpo.price]);
          break;
        case 22:
          buf = sprintf(LRccrdt.IMG_YAMATO_BAL_NANACO, [tsBuf.jpo.price]);
          break;
        default:
          buf = sprintf(LRccrdt.IMG_YAMATO_BAL_EMONEY, [tsBuf.jpo.price]);
          break;
      }
    }
    return buf;
  }

  /// 機能概要     : 決済端末に対してキャンセル通知を実施するためのフラグをセットする
  /// 呼び出し方法 : rcVega_Inq_Cncl(void);
  /// パラメータ   : なし
  /// 戻り値       : なし
  /// ///  関連tprxソース: rc_ewdsp.c - rcVega_Inq_Cncl
  static Future<void> rcVegaInqCncl() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcVega_Inq_Cncl : Yes Touch");

    /* 中止ボタンが押された場合、フラグをセットして
	   * クレジットタスクからの応答を待つ */
    cBuf.vega3000Conf.vega3000CancelFlg = 1;
    return;
  }

  /// 関連tprxソース: rc_ewdsp.c - rcResetDlgAddData
  static void rcResetDlgAddData() {
    AcMem cMem = SystemFunc.readAcMem();
    // ダイアログへの追加データを初期化する
    cMem.ent.addMsgBuf = '';
    return;
  }

  ///  関連tprxソース: rc_ewdsp.c - rcNtt_SetErrCode
  static Future<void> rcNttSetErrCode(tprDlgParam_t param) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    String suikaErr = '';
    NttAspRcvSoct nrcv = NttAspRcvSoct();

    RegsMem regsMem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    ut1Err = String.fromCharCode(0x0);
    if (await CmCksys.cmSpDepartmentSystem() != 0 && atSing.addErrorCd != '0') {
      param.user_code_2 = atSing.addErrorCd;
      param.userCode = 0;
    }

    if (CompileFlag.ARCS_MBR) {
      if (await CmCksys.cmNttdPrecaSystem() != 0 && atSing.addErrorCd == 'U') {
        errorCd = String.fromCharCode(0x0);
        errorCd = atSing.addErrorCd;
        param.user_code_2 = errorCd;
        param.userCode = 0;
        atSing.addErrorCd = String.fromCharCode(0x00);
      }
    }
    if (RcRegs.rcInfoMem.rcRecog.recogTrkPreca != 0
        && int.tryParse(atSing.addErrorCd) != 0) {
      errorCd = String.fromCharCode(0x0);
      errorCd = atSing.addErrorCd;
      param.user_code_2 = errorCd;
      param.userCode = 0;
      atSing.addErrorCd = String.fromCharCode(0x00);
    }
    if (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0
        && atSing.addErrorCd != '') {
      errorCd = String.fromCharCode(0x0);
      errorCd = atSing.addErrorCd;
      param.user_code_2 = errorCd;
      param.userCode = 0;
      atSing.addErrorCd = String.fromCharCode(0x00);
    }
    if (RcRegs.rcInfoMem.rcRecog.recogCogcaSystem != 0
        && atSing.addErrorCd == 'S') {
      errorCd = String.fromCharCode(0x0);
      errorCd = atSing.addErrorCd;
      param.user_code_2 = errorCd;
      param.userCode = 0;
      atSing.addErrorCd = String.fromCharCode(0x00);
    }
    if (RcRegs.rcInfoMem.rcRecog.recogValuecardSystem != 0
        && int.tryParse(atSing.addErrorCd) != 0) {
      errorCd = String.fromCharCode(0x0);
      errorCd = atSing.addErrorCd;
      param.user_code_2 = errorCd;
      param.userCode = 0;
      atSing.addErrorCd = String.fromCharCode(0x00);
    }
    if (RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0
        && (atSing.addErrorCd == 'G'
            || atSing.addErrorCd == 'C'
            || atSing.addErrorCd == 'S'
            || atSing.addErrorCd == 'W') ) {
      errorCd = String.fromCharCode(0x0);
      errorCd = atSing.addErrorCd;
      param.user_code_2 = errorCd;
      param.userCode = 0;
      atSing.addErrorCd = String.fromCharCode(0x00);
    }
    if (await CmCksys.cmBarcodePaysystem() != 0
        && await RcSysChk.rcChkNetstarsCodepaySystem()
        && regsMem.bcdpay.rxData.orderResult == BCDPAY_ORDER.BCDPAY_ODR_ERR_END.index
        && regsMem.bcdpay.rxData.errCode.isNotEmpty) {
      ut1Err = regsMem.bcdpay.rxData.errCode;
      param.user_code_2 = ut1Err;
      param.userCode = 0;
      regsMem.bcdpay.rxData.errCode = String.fromCharCode(0x00);
    }
    if (await CmCksys.cmZHQSystem() != 0
        && int.tryParse(atSing.addErrorCd) != 0
        && (await RcSysChk.rcChkMstProcess()
            && RcSysChk.rcChkINFOXProcess()) ) {
      errorCd = String.fromCharCode(0x0);
      errorCd = atSing.addErrorCd;
      param.user_code_2 = errorCd;
      param.userCode = 0;
      atSing.addErrorCd = String.fromCharCode(0x00);
    }

    if (await CmCksys.cmNttaspSystem() != 0) {
      if (nrcv.nwhd.errorCd == 'G'
          || nrcv.nwhd.errorCd == 'C'
          || nrcv.nwhd.errorCd == 'E') {
        errorCd = String.fromCharCode(0x0);
        errorCd = nrcv.nwhd.errorCd;
        param.user_code_2 = errorCd;
        param.userCode = 0;
      }
      else if (await CmCksys.cmTuoSystem() != 0 && atSing.tuoErr != '') {
        param.user_code_2 = atSing.tuoErr;
        param.userCode = 0;
      }
      else if ( (await CmCksys.cmUt1QUICPaySystem() != 0
          || await CmCksys.cmUt1IDSystem() != 0
          || await CmCksys.cmMultiVegaSystem() != 0)
          && tsBuf.multi.fclData.resultCode != 0) {
        ut1Err = await rcMakeUt1Msg(0);
        param.user_code_2 = ut1Err;
        param.userCode = 0;
      }
      else if (RcRegs.rcInfoMem.rcCnct.cnctMultiCnct == 4) {
        if (await RcFncChk.rcCheckPiTaPaMode() && await RcFncChk.rcCheckSuicaMode()) {
          param.user_code_2 = atSing.multiPfmOcxErrmsg;
          param.userCode = 0;
        }
      }
      else if (await CmCksys.cmSuicaSystem() != 0
          && atSing.suicaData.endCd != 0) {
        suikaErr = String.fromCharCode(0x0);
        suikaErr = atSing.suicaData.endCd.toRadixString(16);
        errorCd = String.fromCharCode(0x0);

        errorCd = '[$suikaErr]';
        param.user_code_2 = errorCd;
        param.userCode = 0;
        atSing.suicaData.endCd = 0;
      }
    }
  }

  ///  関連tprxソース: rc_ewdsp.c - rcMake_Ut1_Msg
  static Future<String> rcMakeUt1Msg(int wCode) async {
    String buf = '';
    String tidNo = '';
    String compCd = '';
    String strCd = '';
    String macNo = '';

    RxMemRet xRetCmn = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCmn.isInvalid()) {
      return '';
    }
    RxCommonBuf cBuf = xRetCmn.object;
    if (wCode == DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId
        || wCode == DlgConfirmMsgKind.MSG_TID_NOGOOD2.dlgId) {
      tidNo = String.fromCharCode(0x0);
      strCd = String.fromCharCode(0x0);
      macNo = String.fromCharCode(0x0);
      compCd = (cBuf.dbRegCtrl.cardCompCd % 100000).toString().padLeft(5, '0');
      strCd = (cBuf.iniMacInfo.system.shpno % 100000).toString().padLeft(5, '0');
      macNo = (cBuf.dbRegCtrl.macNo % 1000).toString().padLeft(3, '0');
      tidNo += compCd.substring(0, 5);
      tidNo += strCd.substring(0, 5);
      tidNo += macNo.substring(0, 5);
    }

    if (wCode == DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId) {
      buf = sprintf("POSTID[%s]\nQP-TID[%s]", [tidNo, cBuf.ini_multi.QP_tid]);
    }
    else if (wCode == DlgConfirmMsgKind.MSG_TID_NOGOOD2.dlgId) {
      buf = sprintf("POSTID[%s]\niD-TID[%s]", [tidNo, cBuf.ini_multi.iD_tid]);
    }
    else {
      if ( !await RcFncChk.rcCheckQPMode()
          && !await RcFncChk.rcCheckiDMode()
          && !await RcFncChk.rcCheckEdyMode()
          && !await RcFncChk.rcCheckSuicaMode()
          && !(await CmCksys.cmMultiVegaSystem() != 0 && await RcFncChk.rcQCCheckIDModeAll())) {
        return '';
      }
      RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetStat.isInvalid()) {
        return '';
      }
      RxTaskStatBuf tsBuf = xRetStat.object;
      if (tsBuf.multi.fclData.resultCode != 0) {
        if (tsBuf.multi.fclData.centerResultCode.isNotEmpty && tsBuf.multi.fclData.centerResultCode[0] != String.fromCharCode(0x0)) {
          buf = sprintf("(%i-%i-%s)", [
            tsBuf.multi.fclData.resultCode,
            tsBuf.multi.fclData.resultCodeExtended,
            tsBuf.multi.fclData.centerResultCode
          ]);
        }
        else {
          if (tsBuf.multi.fclData.resultCodeExtended != 0) {
            buf = sprintf("(%i-%i)",[
              tsBuf.multi.fclData.resultCode,
              tsBuf.multi.fclData.resultCodeExtended
            ]);
          }
          else {
            buf = sprintf("(%i)" ,[tsBuf.multi.fclData.resultCode]);
          }
        }
      }
      else {
        return '';
      }
    }
    return buf;
  }

  /// 関連tprxソース: rc_ewdsp.c - rcWarn_PopUpLcd
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static void rcWarnPopUpLcd(int wCode) {
    return ;
  }

  /// 関連tprxソース: rc_ewdsp.c - rcQC_ClrKey_Proc
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static void rcQCClrKeyProc() {
    return ;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_ewdsp.c - rcSG_ClrKey_Proc
  static void rcSGClrKeyProc() {}
}
