/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/acx_err_gui.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_bcd/chk_z0.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../acx/rc_acx.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_acracb.dart';
import 'rc_advancein.dart';
import 'rc_assist_mnt.dart';
import 'rc_ext.dart';
import 'rc_fself.dart';
import 'rc_ifevent.dart';
import 'rc_key.dart';
import 'rc_key_cash.dart';
import 'rc_obr.dart';
import 'rc_qc_dsp.dart';
import 'rc_reserv.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rc_timer.dart';
import 'rc_usbcam1.dart';
import 'rcfncchk.dart';
import 'rcky_cha.dart';
import 'rcky_cin.dart';
import 'rcky_clr.dart';
import 'rcky_langchg.dart';
import 'rcky_qctckt.dart';
import 'rcky_rct.dart';
import 'rcky_self_mnt.dart';
import 'rcky_sus.dart';
import 'rckyccin.dart';
import 'rckycncl.dart';
import 'rckycpick.dart';
import 'rckyspcncl.dart';
import 'rcqr_com.dart';
import 'rcsg_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

class RckyccinAcb {
  static int popUpFlg = 0;
  static AcbInfo acbInfo = AcbInfo();
  // rcAcrAcbStopWait2 sleep time (microseconds)
  static const ACX_STOP_WAIT = 400000;

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rckyccin_acb.c - rcAcrAcb_Disp
  static void rcAcrAcbDisp() {
    return;
  }

  ///  関連tprxソース: rckyccin_acb.c - rcAcbData_Reset
  static void rcAcbDataReset() {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxTaskStatBuf tsBuf = RxTaskStatBuf();
    atSing.acbNotdecFlg = 0;
    atSing.acbActFinalFlg = 0;
    atSing.acracbStartFlg = 0; /* 入金確定　開始フラグ */
    cMem.acbData.totalPrice = 0;
    cMem.acbData.ccinPrice = 0;
    cMem.acbData.acbFullPrice = 0;
    cMem.acbData.acbFullStat = 0.toString();
    cMem.acbData.keyChgcinFlg = 0.toString();
    cMem.acbData.inputPrice = 0;
    cMem.acbData.ccinAddPrice = 0;
    cMem.acbData.acbFullNodisp = 0;
    acbInfo = AcbInfo();

    if (tsBuf.acx.initFlg == 3) {
      tsBuf.acx.initFlg = 0;
    }
  }

  ///  関連tprxソース: rckyccin_acb.c - rc_AutoDecision
  static Future<void> rcAutoDecision() async {
    int errNo = 0;
    int acbSelect;
    String log = '';

    RcAcracb.rcGtkTimerRemoveAcb();
    acbSelect = AcxCom.ifAcbSelect();
    AcMem cMem = SystemFunc.readAcMem();
    AcbInfo.stopwaitActFlg = 0;
    if ((!await RcSysChk.rcSGChkSelfGateSystem()) &&
        (!await RcSysChk.rcQCChkQcashierSystem())) {
      if (AcbInfo.fnalRestartFlg == 1) {
        //以下条件の入金監視停止は行わず、１回は釣銭機の状態取得を行う
        log = "rcAutoDecision: fnal_restart_flg -> Retry\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else {
        if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_ACB_START_ERR.dlgId) {
          /* 入金開始処理NG時の終了処理 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcAutoDecision() CinStart Error Retrun");
          await RcExt.rcErr("rcAutoDecision", cMem.ent.errNo);
          await RcKyccin.rcEndKeyChgCinDecision2("rcAutoDecision");
          return;
        }
        if ((rcChkAcrAcbProcEnd()) && (AcbInfo.errRestartFlg == 0)) {
          /* 釣銭機エラーや電源断等による釣銭機停止時のための終了処理 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcAutoDecision() CinEnd Retrun");
          await RcKyccin.rcEndKeyChgCinDecision2("rcAutoDecision");
          return;
        }
      }
    }

    errNo = 0;
    if ((!await RcSysChk.rcSGChkSelfGateSystem()) &&
        (!await RcSysChk.rcQCChkQcashierSystem())) {
      if (!(RcFncChk.rcCheckReservMode() ||
          await RcFncChk.rcCheckBkScrReservMode())) {
        if (!(await RcFncChk.rcCheckBkAdvanceInMode() ||
            await RcFncChk.rcCheckAdvanceInMode())) {
          AcbInfo.autoDecisionFlg = 1;
        }
      }
    }

    if (await RcSysChk.rcChkSQRCTicketSystem()) {
      if ((RcFncChk.rcChkErr() != 0) ||
          (RcFncChk.rcSQRCCheckStaffDspMode()) ||
          (RcFncChk.rcSQRCCheckPassWordDspMode())) {
        cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
        return;
      }
    } else if (await RcStlLcd.rcSGDualSubttlDspChk()) {
      if ((RcFncChk.rcChkErr() != 0) || (RcFncChk.rcSGCheckCheckMode())) {
        cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
        return;
      }
    } else if (await RcSysChk.rcQCChkQcashierSystem()) {
      if ((RcFncChk.rcChkErr() != 0) ||
          (RcFncChk.rcQCCheckStaffDspMode()) ||
          (RcFncChk.rcQCCheckPassWardDspMode())) {
        cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
        return;
      }
    } else if (RcFncChk.rcCheckReservMode() ||
        await RcFncChk.rcCheckBkScrReservMode()) {
      if (RcFncChk.rcChkErr() != 0) {
        cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
        return;
      }
    } else if (await RcFncChk.rcCheckBkAdvanceInMode() ||
        await RcFncChk.rcCheckAdvanceInMode()) {
      if (RcFncChk.rcChkErr() != 0) {
        cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
        return;
      }
    } else if ((await RcFncChk.rcCheckSpBarReadMode()) ||
        (await RcFncChk.rcCheckBkSpBarReadMode() != 0)) {
      cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
      return;
    } else {
      AcbInfo.autoChkCnt++; /* add 03.12.25 */
    }

    if ((acbSelect & CoinChanger.ACB_50_X != 0) &&
        (await RcSysChk.rcChkAutoDecisionSystem()) &&
        (cMem.acbData.acbFullPrice != 0) &&
        (cMem.acbData.acbDeviceStat == AcxStatus.CinEnd.id)) {
      /* AcrAcb Full Stop Restart */
      //DataResetはしないように。入金額引き継ぎ処理続行へ
      if (RcFncChk.rcChkErrNon() != 0) {
        await RcAcracb.rcAcrAcbCinStartDtl(0);
      }
    }
    if ((((acbSelect & CoinChanger.SST1) != 0) ||
            ((acbSelect & CoinChanger.FAL2) != 0)) &&
        (await RcSysChk.rcChkAutoDecisionSystem()) &&
        (AcbInfo.errRestartFlg == 1) &&
        (cMem.acbData.acbFullStat == '0')) {
      /* SST1 Error Restart */
      if ((RcFncChk.rcChkErrNon() != 0) &&
          (TprLibDlg.tprLibDlgCheck2(1) == 0) &&
          (!RcFncChk.rcCheckChgErrMode())) {
        if (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) {
          await RcKyccin.rcAcrAcbCinFinish();
          //DataResetはしないように。入金額引き継ぎ処理続行へ
        }
        cMem.ent.errNo = await RcAcracb.rcAcrAcbCinStartDtl(0);
        if (cMem.ent.errNo == OK) {
          RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId);
          AcbInfo.errRestartFlg = 0;
          log = "Sst Error Restart Set price(${cMem.acbData.acbFullPrice})";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        } else {
          await rcChgCinDialog2("rcAutoDecision");
        }
      }
    }
    rcChgCinManuDecWaitCntInc();
    cMem.ent.errNo = await RcAcracb.rcAcrAcbCinReadDtl();
    if ((cMem.ent.errNo == 0) ||
        (cMem.ent.errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId)) {
      AcbInfo.autoChkCnt = 0; /* add 03.12.25 */
      popUpFlg = 0;

      if (AcbInfo.autoDecisionFlg == 0) {
        rcAutoDecision2();
      }
    } else {
      await rcChgCinDialog2("rcAutoDecision");
      cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcAutoDecision());
    }
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rckyccin_acb.c - rcChkPopWindow_ChgOutWarn
  static int rcChkPopWindowChgOutWarn(int continue_flg) {
    return 0;
  }

  ///  関連tprxソース: rckyccin_acb.c - rc_AutoDecision2
  static Future<int> rcAutoDecision2() async {
    int err_no = 0;
    int AutoDec_Timer = 0;
    tprDlgParam_t param;

    AcMem CMEM = SystemFunc.readAcMem();
    RcAcracb.rcGtkTimerRemoveAcb();
    if (AcbInfo.tempErrNo != 0) {
      //タイマー処理を挟んだ等の理由によりクリアされている。退避したerr_noを戻す
      if (CMEM.ent.errNo == 0) {
        CMEM.ent.errNo = AcbInfo.tempErrNo;
      }
      AcbInfo.tempErrNo = 0;
    }
    if ((!await RcSysChk.rcSGChkSelfGateSystem()) &&
        (!await RcSysChk.rcQCChkQcashierSystem())) {
      if (AcbInfo.fnalRestartFlg == 1) {
        //以下条件の入金監視停止は行わず、１回は釣銭機の状態取得を行う
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcAutoDecision2: fnal_restart_flg -> Retry\n");
        AcbInfo.fnalRestartFlg = 0; //ここまで来れば１回は状態取得が行われているのでフラグはリセットする
      } else {
        if (CMEM.ent.errNo == DlgConfirmMsgKind.MSG_ACB_START_ERR.dlgId) {
          /* 入金開始処理NG時の終了処理 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rc_AutoDecision2() CinStart Error Retrun");
          await RcExt.rcErr("rcAutoDecision2", CMEM.ent.errNo);
          await RcKyccin.rcEndKeyChgCinDecision2("rcAutoDecision2");
          return 0;
        }
        if ((rcChkAcrAcbProcEnd()) && (AcbInfo.errRestartFlg == 0)) {
          /* 釣銭機エラーや電源断等による釣銭機停止時のための終了処理 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rc_AutoDecision2() CinEnd Retrun");
          await RcKyccin.rcEndKeyChgCinDecision2("rcAutoDecision2");
          return 0;
        }
      }
    }
    if ((RcFncChk.rcCheckLangChgDspMode()) /* 店員側言語切替選択画面表示中の場合 */
        &&
        (CMEM.acbData.ccinPrice != 0) /* 入金されている場合 */
        &&
        ((CMEM.stat.bkScrMode == RcRegs.RG_STL) /* 小計画面から表示していた場合 */
            ||
            (CMEM.stat.bkScrMode == RcRegs.TR_STL))) {
      RckyLangChg.rckyLangChgEndProc(); /* 店員側言語切替選択画面を閉じる */
    }

    rcAcrAcbDisp();
    // #if 0
    //   if((rcChk_AutoDecision_System()   ) &&
    //       (! rcSG_Chk_SelfGate_System()  ) &&
    //       (rcChk_Acb_FncCode()           ) &&
    //       (! rcChk_Ccin_Dialog()         ) &&
    //       (! rcCheck_ChgErr_Mode()       ) && /* エラー復旧ガイダンス画面でない */
    //       (rcChk_ChgCin_CanDisp()        ) &&
    //       (CMEM.stat.DspEventMode == 100) )
    //   {
    //       TprLibLogWrite(GetTid(),TPRLOG_NORMAL, 0, "rc_AutoDecision2 Key Perimission");
    //       rxChkModeReset();
    //   }
    // #endif

    if (RcAcracb.rcChkAcrAcbRjctErr(CMEM.ent.errNo)) {
      await rcChgCinDialog2("rcAutoDecision2");
      await RcExt.rxChkModeReset("rcAutoDecision2");
    } else if (RcAcracb.rcChkAcrAcbFullErr(CMEM.ent.errNo)) {
      CMEM.acbData.ccinPrice = 0;
      await RcKyccin.ccinErrDialog2("rcAutoDecision2", CMEM.ent.errNo, 0);
      await RcExt.rxChkModeReset("rcAutoDecision2");
    } else if (CMEM.ent.errNo != 0) {
      if (CMEM.ent.errNo == DlgConfirmMsgKind.MSG_ACBACT.dlgId) {
        await RcExt.rcErr("rcAutoDecision2", CMEM.ent.errNo);
        await RcExt.rxChkModeReset("rcAutoDecision2");
      } else {
        if (await RcSysChk.rcSGChkSelfGateSystem()) {
          CMEM.ent.errNo = await RcKyccin.rcAcbCinErrCode();
          if (CMEM.ent.errNo == DlgConfirmMsgKind.MSG_TAKE_MONEY.dlgId) {
            if (AcbInfo.autoChkCnt > 5) {
              await RcKyccin.ccinErrDialog2("rcAutoDecision2", CMEM.ent.errNo, 1);
              await RcExt.rxChkModeReset("rcAutoDecision2");
            } else {
              param = tprDlgParam_t();
              param.erCode = DlgConfirmMsgKind.MSG_TAKE_MONEY.dlgId;
              param.dialogPtn = DlgPattern.TPRDLG_PT9.dlgPtnId;
              if (CompileFlag.SELF_GATE) {
                if (await RcStlLcd.rcSGDualSubttlDspChk()) {
                  param.dialogPtn = DlgPattern.TPRDLG_PT8.dlgPtnId;
                  // if (! await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
                  //   param.dualdsp = 2;
                  // }
                  if (popUpFlg == 0) {
                    MsgDialog.show(
                      MsgDialog.singleButtonDlgId(
                        type: MsgDialogType.error,
                        dialogId: param.erCode,
                      ),
                    );
                    RcSet.rcErrStatSet2("rcAutoDecision2");
                    popUpFlg = 1;
                    RcTimer.rcTimerListAdd(RC_TIMER_LISTS.RC_SG_POP_DOWN_TIMER,
                        1500, rcSGPopDownProc, 0);
                  }
                }
              }
            }
          } else {
            await RcKyccin.ccinErrDialog2("rcAutoDecision2", CMEM.ent.errNo, 1);
            await  RcExt.rxChkModeReset("rcAutoDecision2");
          }
        } else {
          await rcChgCinDialog2("rcAutoDecision2");
        }
      }
    } else if ((CMEM.ent.errNo == 0) && (TprLibDlg.tprLibDlgCheck2(1) == 0)) {
      await RcKyccin.rcChgCinAutoDecErrCntReset();
    }
    if ((AcxCom.ifAcbSelect() != 0 & CoinChanger.SST1) &&
        (AcbInfo.errRestartFlg == 1)) {
      CMEM.ent.errNo = RcAcracb.rcGtkTimerAddAcb(1000, rcAutoDecision());
    } else if (await RcSysChk.rcQCChkQcashierSystem()) {
      RcQcDsp.rcQCCashDspPayFishPixmap();
      CMEM.ent.errNo = RcAcracb.rcGtkTimerAddAcb(1000, rcAutoDecision());
      await rcChkFnalFlg();
    } else if (!await RcSysChk.rcSGChkSelfGateSystem()) {
      if (await RcSysChk.rcChkManuDecisionSystem()) {
        if (CMEM.acbData.acbFullStat.isNotEmpty) {
          return 0;
        }
      }
      if (CMEM.acbData.acbDeviceStat == AcxStatus.CinWait.id) {
        if (await RcSysChk.rcChkManuDecisionSystem()) {
          if ((RcFncChk.rcChkErrNon() != 0) && (!rcChkCcinDialog())) {
            if (RcAcrAcbDef.ECS_MANUAL_SUSPEND != 0) {
              if (AcxCom.ifAcbSelect() != 0 & CoinChanger.ECS_X) {
                if ((!RcFncChk.rcCheckChgCinMode()) &&
                    (CMEM.acbData.totalPrice == 0) &&
                    (AcbInfo.manuDecWaitCnt > 3)) {
                  //入金確定：貨幣投入なし->入金受付停止処理 (ECS_MANUAL_SUSPENDは、ワンモーターで停止するのでCntを多くすると何もしていない待機時間が長くなるので注意)
                  err_no = await RcKyccin.rcAcrAcbCinFinish();
                  if (err_no != Typ.OK) {
                    await RcKyccin.ccinErrDialog2("rcAutoDecision2", err_no, 0);
                    await RcExt.rxChkModeReset("rcAutoDecision2");
                  } else {
                    await RcAcracb.rcAcrAcbCinReadDtl();
                    rcAcrAcbDisp();
                    if (CMEM.stat.dspEventMode == 100) {
                      await RcExt.rxChkModeReset("rcAutoDecision2");
                    }
                    await rcChkFnalFlg();
                    return 0;
                  }
                }
                rcAcrAcbDisp();
                if (RcFncChk.rcCheckChgCinMode()) {
                  if (CMEM.stat.dspEventMode == 100) {
                    await RcExt.rxChkModeReset("rcAutoDecision2");
                  }
                }
              }
            } else {
              if ((!RcFncChk.rcCheckChgCinMode()) &&
                  (CMEM.acbData.totalPrice == 0) &&
                  (AcbInfo.manuDecWaitCnt <= 3)) {
                //入金確定：貨幣投入なし->規定回数まで入金受付停止処理を待機
                CMEM.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500,
                    rcAutoDecision()); /*  Manual Decision System Error or Auto Decision System */
                return 0;
              }
              err_no = await RcKyccin.rcAcrAcbCinFinish();
              if (err_no != Typ.OK) {
                RcKyccin.ccinErrDialog2("rcAutoDecision2", err_no, 0);
                await RcExt.rxChkModeReset("rcAutoDecision2");
              } else {
                await RcAcracb.rcAcrAcbCinReadDtl();
                rcAcrAcbDisp();
                if (CMEM.stat.dspEventMode == 100) {
                  await RcExt.rxChkModeReset("rcAutoDecision2");
                }
                await rcChkFnalFlg();
                return 0;
              }
            }
          }
        }
      } else if (CMEM.acbData.acbDeviceStat == AcxStatus.CinStop.id) {
        if (RcFncChk.rcChkErrNon() != 0) {
          err_no = await RcAcracb.rcAcrAcbCinEndDtl();
          if (err_no == Typ.OK) {
            await RcAcracb.rcAcrAcbCinReadDtl();
            rcAcrAcbDisp();
            if (CMEM.stat.dspEventMode == 100) {
              await RcExt.rxChkModeReset("rcAutoDecision2");
            }
            await rcChkFnalFlg();
            return 0;
          }
        }
      }

      if ((RcFncChk.rcCheckChgCinMode()) &&
          await RcKyccin.rcChkAcbCinAct() != 0 &&
          (TprLibDlg.tprLibDlgCheck2(1) == 0)) {
        AutoDec_Timer = 100; /* モーター停止を早く認識できるよう条件にてtimer変更 */
      } else {
        AutoDec_Timer = 500;
      }
      CMEM.ent.errNo = RcAcracb.rcGtkTimerAddAcb(AutoDec_Timer,
          rcAutoDecision()); /*  Manual Decision System Error or Auto Decision System */
      await rcChkFnalFlg();
    } else {
      /* Self System */
      CMEM.ent.errNo = RcAcracb.rcGtkTimerAddAcb(1000, rcAutoDecision());
      await rcChkFnalFlg();
    }
    return 0;
  }

  ///  関連tprxソース: rckyccin_acb.c - rcChk_AcrAcb_ProcEnd
  static bool rcChkAcrAcbProcEnd() {
    AcMem cMem = SystemFunc.readAcMem();
    /* 釣銭機エラーや電源断等による釣銭機停止時のための終了処理 */
    return ((!RckyccinAcb.rcChkCcinDialog()) &&
        (!RcFncChk.rcCheckChgCinMode()) &&
        (cMem.acbData.acbFullStat == "0") &&
        (cMem.acbData.acbDeviceStat == AcxStatus.CinEnd.id));
  }

  ///  関連tprxソース: rckyccin_acb.c - rcChk_Ccin_Dialog
  static bool rcChkCcinDialog() {
    /* 強制終了フラグ */
    return (AcbInfo.ccinDialog == 1);
  }

  /// 関連tprxソース: rckyccin_acb.c - rcChgCin_Dialog2
  static Future<void> rcChgCinDialog2(String callFunc) async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    String log = '';
    int errChkCnt = 0;
    int errDlgNo = 0;

    if (RcSysChk.rcsyschkVescaSystem()) {
      if (RcFncChk.rcAplDlgCheck() != 0) {
        // アプリダイアログが消去されてからエラーを表示させたい為
        log = "rcChgCinDialog2 : no draw! apldlg now!!\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }
    }

    if ((!rcChkCcinDialog()) && (!RcFncChk.rcCheckChgErrMode())) {
      if ((TprLibDlg.tprLibDlgCheck2(1) == 0) ||
          (AcbInfo.autoDecErrcnt < 10) ||
          ((AcbInfo.autoDecErrcnt % 10) == 0)) {
        //ログ出力調整
        log =
            "rcChgCinDialog2( call_func : $callFunc ) err[${cMem.ent.errNo} cnt[${AcbInfo.autoDecErrcnt}] clr[${AcbInfo.autoDecClrcnt}]\n";
        if (RcFncChk.rcCheckPassportInfoMode() == 0) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        }
      }
    }

    errDlgNo = TprLibDlg.tprLibDlgNoCheck();

    if (!RckyccinAcb.rcChkCcinDialog()) {
      if (((TprLibDlg.tprLibDlgCheck2(1) != 0) &&
              (cMem.ent.errNo == errDlgNo)) ||
          (RcFncChk.rcCheckChgErrMode())) {
        //連続で同じダイアログ表示を継続中 or 復旧ガイダンス表示中
        if (AcbInfo.autoDecErrcnt < RcAcrAcbDef.FORCE_ERRCHKCNT) {
          if ((!await RcSysChk.rcSGChkSelfGateSystem()) &&
              (!await RcSysChk.rcQCChkQcashierSystem())) {
            AcbInfo.autoDecErrcnt++;
          }
        }
      }

      errChkCnt = 30;
      if ((AcbInfo.autoDecErrcnt > errChkCnt) || (AcbInfo.autoDecClrcnt > 0)) {
        //強制終了条件を判定し表示
        if (TprLibDlg.tprLibDlgCheck2(1) != 0) {
          if (RcAcracb.rcChkAcrAcbRjctErr(errDlgNo)) {
            //リジェクトエラーを表示している場合は強制終了選択へ進まない
            AcbInfo.autoDecErrcnt = 0;
          }
          return;
        }
        if (RcFncChk.rcCheckChgErrMode()) {
          return;
        }
        if (rcChgErrNonShowChk() != 0) {
          return;
        }

        //エラー表示なし -> 消去されたのでカウント
        if (AcbInfo.autoDecClrcnt < 0) {
          AcbInfo.autoDecClrcnt = 0;
        }
        AcbInfo.autoDecClrcnt++;

        //何回かエラーを消去を繰り返すまでは通常のエラー表示
        if ((AcbInfo.autoDecClrcnt >= 0) &&
            (AcbInfo.autoDecClrcnt < RcAcrAcbDef.FORCE_CLRCNT)) {
          RcKyccin.ccinErrDialog2("rcChgCinDialog2", cMem.ent.errNo, 0);
          await RcExt.rxChkModeReset("rcChgCinDialog2");
          return;
        }

        //リジェクトエラーは通常のエラー表示
        if (RcAcracb.rcChkAcrAcbRjctErr(cMem.ent.errNo)) {
          RcKyccin.ccinErrDialog2("rcChgCinDialog2", cMem.ent.errNo, 0);
          await RcExt.rxChkModeReset("rcChgCinDialog2");
          return;
        }

        //強制終了選択画面
        errDlgNo = TprLibDlg.tprLibDlgNoCheck();
        if (errDlgNo != DlgConfirmMsgKind.MSG_KEY_POSI_MENTE.dlgId) {
          log =
              "rcChgCinDialog2( call_func : $callFunc ) err[${cMem.ent.errNo}] cnt[${AcbInfo.autoDecErrcnt}] clr[${AcbInfo.autoDecClrcnt}] -> ForceEnd Disp\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          if (await RcSysChk.rcChkSmartSelfSystem()) {
            if (atSing.rckySelfMnt == 0) {
              RcKySelfMnt.rcKySelfMnt(0);
              await RcfSelf.rcFselfMovieStop();
            }
          }
          RckyClr.rcClearPopDisplay();
          RcKyccin.ccinDialog(cMem.ent.errNo); //強制終了選択ダイアログに進む
        }
      } else {
        //通常エラー
        if ((TprLibDlg.tprLibDlgCheck2(1) == 0) //ダイアログ表示していない
            ||
            (CmCksys.cmAcxErrGuiSystem() != 0)) {
          //エラー復旧ガイダンス仕様時はダイアログがっても消して表示する
          if (rcChgErrNonShowChk() == 0) {
            RcKyccin.ccinErrDialog2("rcChgCinDialog2", cMem.ent.errNo, 0);
            await RcExt.rxChkModeReset("rcChgCinDialog2");
          }
        }
      }
    }
  }

  ///  関連tprxソース: rckyccin_acb.c - rcCinReadGet_Wait2
  static Future<int> rcCinReadGetWait2(String callFunc) async {
    int errNo = 0;
    int i;
    String log;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (AcbInfo.stepCnt != 0) {
      log = 'CinReadGet( call_func : rcCinReadGetWait2 ) retry';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      if (AcbInfo.autoDecisionFlg == 1) {
        AcbInfo.autoDecisionFlg = 0;
      }
      for (i = 0; i < RcAcrAcbDef.ACX_CREADGET_CNT; i++) {
        await RcAcx.rcAcxMain();
        if(tsBuf.acx.stat != 0){
          errNo = await RcAcracb.rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_CIN_GET.no) {
          errNo = await RcAcracb.rcAcrAcbCinReadGet();
          AcbInfo.stepCnt = 0;
          break;
        } else {
          if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
            errNo = IfAcxDef.MSG_ACRLINEOFF;
          } else {
            errNo = 0;
          }
          await Future.delayed(
              const Duration(microseconds: RcAcrAcbDef.ACX_CREADGET_WAIT));
        }
        if (i == RcAcrAcbDef.ACX_CREADGET_CNT) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              'CinReadGet_Wait Retry Over');
          errNo = DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId;
        }
        AcbInfo.stepCnt = 0;
        if (errNo != 0) {
          RcAcracb.rcResetAcrOdr();
          log = "rcCinReadGetWait2: err_no[$errNo]";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        }
      }
    }
    return errNo;
  }

  ///  関連tprxソース: rckyccin_acb.c - rcChk_Fnal_Flg
  static Future<int> rcChkFnalFlg() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    if (RcFncChk.rcChkErr() != 0) {
      return 0;
    }

    if ((atSing.acbActFinalFlg == AcbActFinalFlg.End_Flg.flgId) &&
        (await RcKyccin.rcChkAcbCinAct() == 0)) {
      atSing.acbActFinalFlg = 0;
      RcKyccin.rcChgCinEndFnc();
      return 1;
    } else if ((atSing.acbActFinalFlg == AcbActFinalFlg.Cash_Flg.flgId) &&
        (await RcKyccin.rcChkAcbCinAct() == 0)) {
      rcAcbCinDspEntry();
      return 1;
    } else if ((atSing.acbActFinalFlg == AcbActFinalFlg.Exec_Flg.flgId) &&
        (await RcKyccin.rcChkAcbCinAct() == 0)) {
      atSing.acbActFinalFlg = 0;
      await rcChgCinExecFnc();
      return 1;
    }
    // TODO:10154 釣銭機UI関連
    // else if (EndDsp.back_end_flg == 1) {
    //   rcSG_BackFnc(EndDsp.window, 0);
    //   return 1;
    // }
    // else if (DualDsp.back_end_flg == 1) {
    //   rcSG_Subttl_RetenProc(Subttl.window, 0);
    //   return 1;
    // }
    else if (atSing.acbActFinalFlg == AcbActFinalFlg.ReStart_Flg.flgId) {
      atSing.acbActFinalFlg = 0;
      rcSGCnclReStartProc();
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcSG_PopDown_Proc
  /// TODO:00015 江原 定義のみ先行追加
  static void rcSGPopDownProc() {}

  /// 関連tprxソース: rckyccin_acb.c - rcPrc_Key_ChgCin3
  static Future<void> rcPrcKeyChgCin3() async {
    int errNo;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    RcAcracb.rcGtkTimerRemoveAcb();
    if ((TprLibDlg.tprLibDlgCheck2(1) == 0) &&
        (!RcFncChk.rcCheckChgCinMode()) &&
        (!RcFncChk.rcCheckChgErrMode())) {
      chgUpdateActDialog(); /* エラー等にて消去されたダイアログの再表示 */
    }
    if (rcChkAcrAcbProcEnd()) {
      /* 釣銭機エラーや電源断等による釣銭機停止時のための終了処理 */
      if (rcChkCcinDialogNon()) {
        /* 強制終了以外のダイアログ表示中 */
        TprDlg.tprLibDlgClear("rcPrcKeyChgCin3");
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcPrcKeyChgCin3() CinEnd Retrun");
      await RcKyccin.rcEndKeyChgCinDecision2("rcPrcKeyChgCin3");
      await RcExt.rxChkModeReset("rcPrcKeyChgCin3");
      return;
    }
    AcbInfo.autoChkCnt++;
    cMem.ent.errNo = await RcAcracb.rcAcrAcbCinReadDtl();
    if ((cMem.ent.errNo != 0) &&
        (cMem.ent.errNo != DlgConfirmMsgKind.MSG_ACRACT.dlgId)) {
      if (rcChkCcinDialogNon()) {
        /* 強制終了以外のダイアログ表示中 */
        TprDlg.tprLibDlgClear("rcPrcKeyChgCin3");
      }
      await rcChgCinDialog2("rcPrcKeyChgCin3");
      cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcPrcKeyChgCin3());
      return;
    }

    if ((cMem.acbData.ccinPrice != 0) || (RcFncChk.rcCheckChgCinMode())) {
      /* 入金額があるか or 入金画面表示中は画面(total_price)更新 */
      if (rcChkCcinDialogNon()) {
        /* 強制終了以外のダイアログ表示中 */
        TprDlg.tprLibDlgClear("rcPrcKeyChgCin3");
      }
      rcAcrAcbDisp();
    }

    if (AcbInfo.autoChkCnt > 6) {
      if (await RcKyccin.rcChkAcbCinAct() == 0) {
        if (cMem.stat.dspEventMode == 100) {
          await RcExt.rxChkModeReset("rcPrcKeyChgCin3");
        }
        if ((RcFncChk.rcChkErrNon() != 0) &&
            (!rcChkCcinDialog()) &&
            (cMem.acbData.totalPrice == 0)) {
          errNo = await RcKyccin.rcAcrAcbCinFinish();
          if (errNo != OK) {
            await RcKyccin.ccinErrDialog2("rcPrcKeyChgCin3", errNo, 0);
            await RcExt.rxChkModeReset("rcPrcKeyChgCin3");
          } else {
            if (rcChkCcinDialogNon()) {
              /* 強制終了以外のダイアログ表示中 */
              TprDlg.tprLibDlgClear("rcPrcKeyChgCin3");
            }
            await RcAcracb.rcAcrAcbCinReadDtl();
            rcAcrAcbDisp();
            if (cMem.stat.dspEventMode == 100) {
              await RcExt.rxChkModeReset("rcPrcKeyChgCin3");
            }
            /* add 04.02.22 */
            if (!RcFncChk.rcCheckChgCinMode()) {
              RcKyCpick.rcSstBillMoveProc();
              if (cBuf.iniMacInfo.acx_flg.acr50_ssw14_7 == 1) {
                RcAcracb.rcAcbSsw14Set(0);
              }
              await RcKyccin.rcEndKeyChgCinDecision2("rcPrcKeyChgCin3");
            }
            return;
          }
        }
      }
    }
    cMem.ent.errNo = RcAcracb.rcGtkTimerAddAcb(500, rcPrcKeyChgCin3());
    await rcChkFnalFlg();
    return;
  }

  /// 入金額更新（各釣銭機画面共通）
  /// 関連tprxソース: rckyccin_acb.c - rcDisp_KeyAcbCin2
  /// TODO:00010 長田 定義のみ追加
  static void rcDispKeyAcbCin2() {
    return;
  }

  /// 釣機エラー表示しないチェック
  /// 関連tprxソース: rckyccin_acb.c - rcChgErr_NonShow_Chk
  /// TODO:00010 長田 定義のみ追加
  static int rcChgErrNonShowChk() {
    // if ((RcFncChk.rcCheckPassportInfoMode() != 0) ||
    //     (rcCheck_ChgSelectItemsMode()) ||
    //     (rcCheck_RegAssist_KyReg_Mode()) ||
    //     (rcCheck_RegAssist_PChg_Mode()) ||
    //     (rcCheck_SpBarRead_Mode()) ||
    //     (rcCheck_BkSpBarRead_Mode()) ||
    //     (Rc28dsp.rc28dspCheckInfoSlct())) {
    //   return 1;
    // }
    return 0;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcChgCin_ManuDec_WaitCntInc
  static void rcChgCinManuDecWaitCntInc() {
    if (AcbInfo.manuDecWaitCnt < 1000) {
      //入金確定で入金待ちするCntなので、実際には数秒分しかカウントする必要はない
      AcbInfo.manuDecWaitCnt++;
    }
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcSG_CnclReStart_Proc
  static void rcSGCnclReStartProc() {}

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - ChgUpdateAct_Dialog
  static int chgUpdateActDialog() {
    return 0;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcChk_Ccin_Dialog_Non
  static bool rcChkCcinDialogNon() {
    /* 強制終了以外のダイアログ表示中 */
    return ((RcFncChk.rcChkErrNon() != 0) &&
        (!rcChkCcinDialog()) &&
        (TprLibDlg.tprLibDlgCheck2(1) != 0));
  }

  /// 関連tprxソース: rckyccin_acb.c - rcAcbCinDsp_Entry
  static Future<void> rcAcbCinDspEntry() async {
    String log;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (rcChkCcinDialog()) {
      return;
    }
    if (cMem.acbData.keyChgcinFlg == '1') {
      /* 釣機入金(補充処理)？ */
      if ((cMem.stat.fncCode != FuncKey.KY_RCT.keyId) &&
          (cMem.stat.fncCode != FuncKey.KY_CLR.keyId) &&
          (iBuf.hardKey != 0x408)) {
        return;
      }
    }

    if (AcbInfo.stepCnt != 0) {
      await RcExt.rcCinReadGetWait('rcAcbCinDspEntry');
    }
    RcKyccin.rcAcbPriceDataSet();
    log = "rcAcbCinDspEntry totalPrice(${cMem.acbData.totalPrice})\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    atSing.acbActFinalFlg = 0;
    if ((TprLibDlg.tprLibDlgCheck2(1) == 0) &&
        (!rcChkCcinDialog()) &&
        (!RcFncChk.rcCheckChgErrMode())) {
      //エラー表示中でなければ
      if (cMem.acbData.acbDeviceStat == AcxStatus.CinReset.id) {
        await RcExt.rcErr(
            "rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_ACB_RESETSTATUS.dlgId);
        return;
      }
    }

    if ((RcFncChk.rcCheckChgCinMode()) ||
        (await RcSysChk.rcSGChkSelfGateSystem()) ||
        (await RcSysChk.rcQCChkQcashierSystem()) ||
        ((RcFncChk.rcCheckReservMode() ||
            await RcFncChk.rcCheckBkScrReservMode())) ||
        (await RcFncChk.rcCheckBkAdvanceInMode() ||
            await RcFncChk.rcCheckAdvanceInMode())) {
      if (RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        /* Post Tendering ? */
        Ltobcd.cmLtobcd(AcbInfo.recalcPrc, cMem.ent.entry.length);
        cMem.ent.tencnt =
            ChkZ0.cmChkZero0(cMem.ent.entry);
      } else {
        Ltobcd.cmLtobcd(cMem.acbData.totalPrice, cMem.ent.entry.length);
        cMem.ent.tencnt =
            ChkZ0.cmChkZero0(cMem.ent.entry);
      }
    }

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      if (await RcKyccin.rcChkAcbCinAct() != 0) {
        atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
        await rcAutoDecision();
        return;
      }
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      await RcKeyCash().rcKeyCash();
      return;
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      if (await RcKyccin.rcChkAcbCinAct() != 0) {
        atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
        await rcAutoDecision();
        return;
      }
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      await RcKeyCash().rcKeyCash();
      return;
    }

    if ((RcFncChk.rcCheckReservMode() ||
        await RcFncChk.rcCheckBkScrReservMode())) {
      if (await RcKyccin.rcChkAcbCinAct() != 0 && RcFncChk.rcChkErrNon() != 0) {
        atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
        await rcAutoDecision();
        return;
      }
      RcReserv.rcReservEntry();
      return;
    }
    if (await RcFncChk.rcCheckBkAdvanceInMode() ||
        await RcFncChk.rcCheckAdvanceInMode()) {
      if (await RcKyccin.rcChkAcbCinAct() != 0 && RcFncChk.rcChkErrNon() != 0) {
        atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
        await rcAutoDecision();
        return;
      }
      RcAdvanceIn.rcAdvanceInEntry();
      return;
    }

    log = "Key in rcAcbCinDsp_Entry:${cMem.stat.fncCode}\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    switch (FuncKey.getKeyDefine(cMem.stat.fncCode)) {
      case FuncKey.KY_CLR:
        if (RcFncChk.rcChkErr() != 0) {
          RckyClr.rcClearPopDisplay();
          RcExt.rcClearErrStat("rcAcbCinDspEntry");
          if (RcFncChk.rcCheckChgCinMode()) {
            // TODO:10122 グラフィクス処理（gtk_*）
            // gtk_grab_add(AcbDspInfo.win_ccin);
            if (FbInit.subinitMainSingleSpecialChk() == true) {
              // gtk_grab_add(AcbDualInfo.win_ccin);
            }
          }
        }
        if (AcbInfo.inpFirstFlg == 1) {
          rcInputPayAmtClr();
        } else if (AcbInfo.inpFirstFlg == 2) {
          rcInputCCinAddClr();
        }
        break;
      case FuncKey.KY_CASH:
        if (RcFncChk.rcCheckChgCinMode()) {
          if ((await RcSysChk.rcChkAutoDecisionSystem()) &&
              ((AcbInfo.errRestartFlg == 1) &&
                  (cMem.acbData.acbFullStat == '0'))) {
            await RcExt.rcErr("rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_ACRACT.dlgId);
            return;
          }
          if (AcbInfo.inpFirstFlg != 0) {
            await RcExt.rcErr(
                "rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_INPUTNUM.dlgId);
            return;
          }
          /* HappySelf[対面]釣機入金後、客表が支払選択から現金画面へ遷移するまで現計キー押下不可 */
          if ((await RcSysChk.rcSysChkHappySmile()) &&
              (cMem.stat.happySmileScrmode == RcRegs.RG_QC_SLCT)) {
            await RcExt.rcErr("rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_ACRACT.dlgId);
            return;
          }

//            if(( C_BUF->db_trm.separate_chg_amt                ) && /* 個別釣銭？ */
          if ((await RcSysChk.rcCheckIndividChange() == true) &&
              (!RcRegs.kyStC3(cMem.keyStat[FuncKey.KY_CHGPOST.keyId]))) {
            if (AcbInfo.totalPrice <= cMem.acbData.inputPrice) {
              cMem.acbData.inputPrice = cMem.acbData.totalPrice;
            }
            if (cMem.acbData.totalPrice == cMem.acbData.inputPrice) {
              Ltobcd.cmLtobcd(cMem.acbData.totalPrice, cMem.ent.entry.length);
            } else {
              Ltobcd.cmLtobcd(cMem.acbData.inputPrice, cMem.ent.entry.length);
            }
            cMem.ent.tencnt =
                ChkZ0.cmChkZero0(cMem.ent.entry);
          }
        }

        if (await RcKyccin.rcChkAcbCinAct() != 0) {
          atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
          await rcAutoDecision();
          return;
        }
        if (RcFncChk.rcChkErrNon() != 0) {
          await RcKeyCash().rcKeyCash();
        }
        break;
      case FuncKey.KY_CHA1:
      case FuncKey.KY_CHA2:
      case FuncKey.KY_CHA3:
      case FuncKey.KY_CHA4:
      case FuncKey.KY_CHA5:
      case FuncKey.KY_CHA6:
      case FuncKey.KY_CHA7:
      case FuncKey.KY_CHA8:
      case FuncKey.KY_CHA9:
      case FuncKey.KY_CHA10:
      case FuncKey.KY_CHA11:
      case FuncKey.KY_CHA12:
      case FuncKey.KY_CHA13:
      case FuncKey.KY_CHA14:
      case FuncKey.KY_CHA15:
      case FuncKey.KY_CHA16:
      case FuncKey.KY_CHA17:
      case FuncKey.KY_CHA18:
      case FuncKey.KY_CHA19:
      case FuncKey.KY_CHA20:
      case FuncKey.KY_CHA21:
      case FuncKey.KY_CHA22:
      case FuncKey.KY_CHA23:
      case FuncKey.KY_CHA24:
      case FuncKey.KY_CHA25:
      case FuncKey.KY_CHA26:
      case FuncKey.KY_CHA27:
      case FuncKey.KY_CHA28:
      case FuncKey.KY_CHA29:
      case FuncKey.KY_CHA30:
      case FuncKey.KY_CHK1:
      case FuncKey.KY_CHK2:
      case FuncKey.KY_CHK3:
      case FuncKey.KY_CHK4:
      case FuncKey.KY_CHK5:
        if (RcFncChk.rcCheckChgCinMode()) {
          if ((await RcSysChk.rcChkAutoDecisionSystem()) &&
              ((AcbInfo.errRestartFlg == 1) &&
                  (cMem.acbData.acbFullStat == '0'))) {
            await RcExt.rcErr("rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_ACRACT.dlgId);
            return;
          }
          if (AcbInfo.inpFirstFlg != 0) {
            await RcExt.rcErr(
                "rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_INPUTNUM.dlgId);
            return;
          }

          //            if( C_BUF->db_trm.separate_chg_amt ) { /* 個別釣銭？ */
          if (await RcSysChk.rcCheckIndividChange() == true) {
            if (AcbInfo.totalPrice <= cMem.acbData.inputPrice) {
              cMem.acbData.inputPrice = cMem.acbData.totalPrice;
            }
            if (cMem.acbData.totalPrice == cMem.acbData.inputPrice) {
              Ltobcd.cmLtobcd(cMem.acbData.totalPrice, cMem.ent.entry.length);
            } else {
              Ltobcd.cmLtobcd(cMem.acbData.inputPrice, cMem.ent.entry.length);
            }
            cMem.ent.tencnt =
                ChkZ0.cmChkZero0(cMem.ent.entry);
          }
          if (cBuf.dbTrm.disableChakeyAcx != 0) {
            await RcExt.rcErr("rcAcbCinDspEntry",
                DlgConfirmMsgKind.MSG_ACX_DECCIN_KEY_ERR.dlgId);
            return;
          }
        }

        if (await RcKyccin.rcChkAcbCinAct() != 0) {
          atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
          await rcAutoDecision();
          return;
        }
        if (RcFncChk.rcChkErrNon() != 0) {
          await RckyCha.rcKyCharge();
          if (await CmCksys.cmReceiptQrSystem() != 0) {
            if (RcqrCom.qrTxtPrintFlg == 1) {
              RckyQctckt.rcKyQCTckt();
            }
            if (RcqrCom.qrTxtPrintFlg != 2) {
              RcqrCom.qrTxtPrintFlg = 0;
            }
          }
        }
        break;
      case FuncKey.KY_RCT:
        if (RcFncChk.rcChkErrNon() != 0) {
          RcKyRct.rcKyRct();
        }
        break;
      case FuncKey.KY_SUS:
        if ((await RcSysChk.rcChkAutoDecisionSystem()) &&
            ((AcbInfo.errRestartFlg == 1) &&
                (cMem.acbData.acbFullStat == '0'))) {
          await RcExt.rcErr("rcAcbCinDspEntry", DlgConfirmMsgKind.MSG_ACRACT.dlgId);
          return;
        }
        if (await RcKyccin.rcChkAcbCinAct() != 0) {
          atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
          await rcAutoDecision();
          return;
        }
        if (RcFncChk.rcChkErrNon() != 0) {
          RckySus.rcKySus();
        }
        break;
      case FuncKey.KY_CNCL:
      case FuncKey.KY_SPCNCL:
        if (RcFncChk.rcCheckChgCinMode()) {
          return;
        }

        if (await RcKyccin.rcChkAcbCinAct() != 0) {
          atSing.acbActFinalFlg = AcbActFinalFlg.Cash_Flg.flgId;
          await rcAutoDecision();
          return;
        }
        if (RcFncChk.rcChkErrNon() != 0) {
          if (cMem.stat.fncCode == FuncKey.KY_SPCNCL.keyId) {
            RcKySpcncl.rcKySPCncl();
          } else {
            RcKyCncl.rcKyCncl();
          }
        }
        break;
      case FuncKey.KY_1:
      case FuncKey.KY_2:
      case FuncKey.KY_3:
      case FuncKey.KY_4:
      case FuncKey.KY_5:
      case FuncKey.KY_6:
      case FuncKey.KY_7:
      case FuncKey.KY_8:
      case FuncKey.KY_9:
      case FuncKey.KY_0:
      case FuncKey.KY_00:
      case FuncKey.KY_000:
        rcInputPayAmtDsp(cMem.stat.fncCode);
        break;
      case FuncKey.KY_PLU:
        rcChgCinInpFnc();
        break;
      default:
        break;
    }
    KeyDispatch.rcScannerCommandProc(cMem.stat.fncCode);
    return;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcChgCin_execFnc
  static Future<void> rcChgCinExecFnc() async {
    String log;
    int type = 0;
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    AcbMem acbMem = AcbMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (atSingl.acbActFinalFlg != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "ChgCinExecFnc cancel");
      return;
    }
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCinExecFnc");
    RcAcracb.rcGtkTimerRemoveAcb();

    // 実行ボタンを押下してもボタンが凹まないと指摘があった為
    // Parts_Show_Event(1);

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      atSingl.acbActFinalFlg = AcbActFinalFlg.Exec_Flg.flgId;
      if (cMem.acbData.keyChgcinFlg == '1') {
        /* 釣機入金(補充処理)？ */
        await rcPrcKeyChgCin3();
      } else {
        await rcAutoDecision();
      }
      return;
    }
    await RcExt.rxChkModeSet("rcChgCinExecFnc");
    if ((cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) &&
        (cMem.acbData.acbFullStat == '0')) {
      cMem.ent.errNo = await RcKyccin.rcAcrAcbCinFinish();
      if (cMem.ent.errNo != 0) {
        await RcExt.rxChkModeReset("rcChgCinExecFnc");
        atSingl.acbActFinalFlg = AcbActFinalFlg.Exec_Flg.flgId;
        if (cMem.acbData.keyChgcinFlg == '1') {
          /* 釣機入金(補充処理)？ */
          await rcPrcKeyChgCin3();
        } else {
          await rcAutoDecision();
        }
        return;
      }
    }

    if (AcbInfo.autoDecisionFlg == 1) {
      AcbInfo.autoDecisionFlg = 0;
    }
    cMem.ent.errNo = await RcAcracb.rcAcrAcbCinReadDtl(); /* add 04.01.26 */
    RcKyccin.rcAcbPriceDataSet();

    if (RcFncChk.rcCheckChgCinMode()) {
      await RcKyccin.rcChgCinScrModeReset();
      await RcKyccin.rcChgCinDispDestroy();
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        await RcObr.rcScanEnable();
        log = "実行";
        RcSgCom.mngPcLog = RcSgCom.mngPcLog + log;
        RcSgCom.rcSGManageLogButton();
        RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);
        RcAssistMnt.rcAssistSend(23062);
      }
    }
    switch (FuncKey.getKeyDefine(acbMem.FncCode)) {
      /* CMEM->stat.FncCodeの場合、書き換えられてしまうため */
      case FuncKey.KY_CIN1:
      case FuncKey.KY_CIN2:
      case FuncKey.KY_CIN3:
      case FuncKey.KY_CIN4:
      case FuncKey.KY_CIN5:
      case FuncKey.KY_CIN6:
      case FuncKey.KY_CIN7:
      case FuncKey.KY_CIN8:
      case FuncKey.KY_CIN9:
      case FuncKey.KY_CIN10:
      case FuncKey.KY_CIN11:
      case FuncKey.KY_CIN12:
      case FuncKey.KY_CIN13:
      case FuncKey.KY_CIN14:
      case FuncKey.KY_CIN15:
      case FuncKey.KY_CIN16:
        cMem.stat.fncCode = acbMem.FncCode;
        type = PrnterControlTypeIdx.TYPE_CIN.index;
        break;
      default:
        type = 0;
    }
    if (type == 0) {
      rcPrcKeyChgCinUpdate(0);
      RcKyccin.rcPrcKeyChgCinDisp();
    } else if (type == PrnterControlTypeIdx.TYPE_CIN.index) {
      RckyCin.rcPrcLumpCin(1);
      RckyCin.rcEndLumpCin();
    }
    if (cBuf.iniMacInfo.acx_flg.acr50_ssw14_7 == 1) {
      RcAcracb.rcAcbSsw14Set(0);
    }

    if (await RcSysChk.rcChkSmartSelfSystem()) {
      if (atSingl.rckySelfMnt == 1) {
        if ((RcSysChk.rcSysChkHappySelfAutoStrClsChk() == 0) &&
            (!(AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) ==
                AutoRun.AUTORUN_STROPN.val))) {
          RcKySelfMnt.rcKySelfMnt(0);
        }
      }
    }
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcPrc_Key_ChgCin_Update
  static void rcPrcKeyChgCinUpdate(int type) {
    return;
  }

  /// 関連tprxソース: rckyccin_acb.c - rc_AcrAcb_StopWait, rc_AcrAcb_StopWait2
  static Future<int> rcAcrAcbStopWait2(int end_flg) async {
    int err_no = 0;
    int i = 0;
    String  log = "";
    int stat_data = 0;
    StateFal2 stateFal2 = StateFal2();
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
      return Typ.OK;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return Typ.OK;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    final stopWatch = Stopwatch();
    stopWatch.start();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "AcrAcb StopWait");
    for(i = 0; i < 100; i++) {
       if(AcbInfo.autoDecisionFlg == 1) {
          AcbInfo.autoDecisionFlg = 0;
       }
       err_no = await RcAcracb.rcAcrAcbCinReadDtl();
       if((err_no == Typ.OK) && (await RcKyccin.rcChkAcbCinAct() != 0)) {
          if((! RcFncChk.rcCheckChgCinMode()) &&                 //入金額での締め処理であれば入金額の変動しても許可する
             (! await RcSysChk.rcChkManuDecisionSystem()) ) {    //入金確定時の入金額なし->停止処理の場合不正入金でない
             AcbInfo.stopwaitActFlg = 1;          //締め処理途中での不正入金の可能性あり。返金->締め処理やり直しへ
          }
          await Future.delayed(const Duration(microseconds: ACX_STOP_WAIT));
       } else if(err_no == DlgConfirmMsgKind.MSG_ACRACT.dlgId) {
          //Stop受信済->Stop遷移待ち
          if((await RcKyccin.rcChkAcbCinAct() != 0) &&          //モーター動作中の時のみ(上記ACRACTはモーターは非動作でステータスだけの問題)
             ((! RcFncChk.rcCheckChgCinMode()) &&               //入金額での締め処理であれば入金額の変動しても許可する
              (! await RcSysChk.rcChkManuDecisionSystem()))) {  //入金確定時の入金額なし->停止処理の場合不正入金でない
             AcbInfo.stopwaitActFlg = 1;               //締め処理途中での不正入金の可能性あり。返金->締め処理やり直しへ
          }
          await Future.delayed(const Duration(microseconds: ACX_STOP_WAIT));
       } else if(((AcxCom.ifAcbSelect() & CoinChanger.FAL2) != 0) && (end_flg == 1)) {
          // 釣銭機 FAL2 は使用しないため未実装
       } else {
         break;
       }
    }
    log = "rc_AcrAcb_StopWait() stopwaitActFlg[${AcbInfo.stopwaitActFlg}] notdec_flg[${atSing.acbNotdecFlg}]";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    if((err_no == Typ.OK) || (err_no == DlgConfirmMsgKind.MSG_ACRACT.dlgId) || (RcAcracb.rcChkAcrAcbRjctErr(err_no))) {
       RcKyccin.rcAcbPriceDataSet();
       if(cMem.acbData.totalPrice > 0) {
          if((atSing.acbNotdecFlg != 1) && (atSing.acracbStartFlg == 1)) {
             log = "rc_AcrAcb_StopWait() -> total_price(${cMem.acbData.totalPrice})";
             TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

             Ltobcd.cmLtobcd(cMem.acbData.totalPrice, cMem.ent.entry.length);
             cMem.ent.tencnt =
                 ChkZ0.cmChkZero0(cMem.ent.entry);

          } else {
             //補充処理や入金開始NGの理由により入金額データからエントリデータを作成しない
             log = "rc_AcrAcb_StopWait() notdec_flg[${atSing.acbNotdecFlg}] start_flg[${atSing.acracbStartFlg}] -> total_price(${cMem.acbData.totalPrice}) entry_data not make";
             TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          }
       }
    } else {
       log = "rc_AcrAcb_StopWait() -> err_no(${err_no})";
       TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    stopWatch.stop();
    debugPrint('rcAcrAcbStopWait2()  ${stopWatch.elapsedMilliseconds}[ms]');
    return(err_no);
  }

  /// 関連tprxソース: rckyccin_acb.c - rcDecision_CinStart
  static Future<int> rcDecisionCinStart() async {
    int errNo = 0;
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
      if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
        errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();
      }
    }
    if (errNo == 0) {
      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
        if ((await RcSysChk.rcChkManuDecisionSystem()) &&
            (RcFncChk.rcCheckChgCinMode())) {
          errNo = RcAcracb.rcAcrAcbCoinInsertDtl();
        } else {
          errNo = await RcAcracb.rcEcsCinStartDtl(1, 1, null);
        }
      } else {
        errNo = await RcAcracb.rcAcrAcbCinStartDtl(0);
      }
    }
    return errNo;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcKyAcbCin
  static Future<void> rcKyAcbCin() async {
    int statusCheckCtrl = 0;
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    AcbMem acbMem = AcbMem();
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

    // TODO:00004 小出 釣銭機通信開始フラグがOFFされてしまう。暫定処置としてコメントアウトする
    //rcAcbDataReset();

    if (await RcFncChk.rcChkAcrAcbAfterRegCinStart()) {
      if (await RcFncChk.rcCheckItmMode()) {
        if ((RcSysChk.rcChkAcrAcbAnyTimeCinStart()) //常時入金（商品登録前）
            &&
            (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]))) {
          if (RcFncChk.rcChkErrNon() != 0) {
            if ((cMem.stat.fncCode != FuncKey.KY_CHGCIN.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN1.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN2.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN3.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN4.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN5.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN6.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN7.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN8.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN9.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN10.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN11.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN12.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN13.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN14.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN15.keyId) &&
                (cMem.stat.fncCode != FuncKey.KY_CIN16.keyId)) {
              statusCheckCtrl = 1;
            }
          }
        } else {
          if (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
            statusCheckCtrl = 1;
          }
        }
      } else {
        if (await RcFncChk.rcCheckStlMode()) {
          if (cBuf.dbTrm.timePrcTyp == 2) {
            if (tsBuf.chk.chk_registration == 1) {
              if ((RcSysChk.rcChkAcrAcbAnyTimeCinStart()) //常時入金（商品登録前）
                  &&
                  (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]))) {
                if (RcFncChk.rcChkErrNon() != 0) {
                  if ((cMem.stat.fncCode != FuncKey.KY_CHGCIN.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN1.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN2.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN3.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN4.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN5.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN6.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN7.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN8.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN9.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN10.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN11.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN12.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN13.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN14.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN15.keyId) &&
                      (cMem.stat.fncCode != FuncKey.KY_CIN16.keyId)) {
                    statusCheckCtrl = 1;
                  }
                }
              }
            }
          }
        }
      }
    }

    acbMem.FncCode = 0; /* 初期化 */
    cMem.ent.errNo = RcKyccin.rcCheckKyChgCin();
    if (cMem.ent.errNo == 0) {
      await RcExt.cashStatSet("rcKyAcbCin");
      // 釣機入金を行った場合のＵＳＢカメラのスタート
      if (cMem.stat.fncCode == FuncKey.KY_CHGCIN.keyId) {
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
          RcUsbCam1.rcUsbcamStartStop(UsbCamStat.QC_CAM_START.index, 0);
        }
      }

      if (((RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) ||
              (RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId]))) &&
          (statusCheckCtrl == 0) &&
          (!RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) &&
          (!RcRegs.kyStC3(cMem.keyStat[FuncKey.KY_CHGPOST.keyId]))) {
        //現金補充 1verでは通らない　->　入金キーに統合された
        if ((ifSave.count != 0) &&
            (cMem.stat.fncCode == FuncKey.KY_CHGCIN.keyId)) {
          if (RcSysChk.rcCheckRegFnal()) {
            RcSet.cashStatReset2("rcKyAcbCin");
          }
          return;
        }
        await RcExt.rxChkModeSet("rcKyAcbCin");
        if (await RcFncChk.rcCheckBkAdvanceInMode() ||
            await RcFncChk.rcCheckAdvanceInMode()) {
          await rcPrcKeyAcbCinDecision();
        } else {
          rcPrcKeyChgCin2();
        }
      } else if (await RcSysChk.rcChkManuDecisionSystem()) {
        //入金確定
        if ((ifSave.count != 0) &&
            (cMem.stat.fncCode == FuncKey.KY_CHGCIN.keyId)) {
          if (RcSysChk.rcCheckRegFnal()) {
            RcSet.cashStatReset2("rcKyAcbCin");
          }
          return;
        }
        await RcExt.rxChkModeSet("rcKyAcbCin");
        await rcPrcKeyAcbCinDecision();
      } else {
        //自動確定
        await rcPrcKeyAcbCinDecision();
      }
    } else {
      if (CmCksys.cmAcxErrGuiSystem() != 0) {
        RcKyccin.ccinErrDialog2("rcKyAcbCin", cMem.ent.errNo, 0);
      } else {
        await RcExt.rcErr("rcKyAcbCin", cMem.ent.errNo);
      }
    }
  }

  /// 関連tprxソース: rckyccin_acb.c - rcPrc_Key_AcbCin_Decision
  static Future<void> rcPrcKeyAcbCinDecision() async {
    AcMem cMem = SystemFunc.readAcMem();

    RcAcracb.rcGtkTimerRemoveAcb();

    // TODO:00004 小出 釣銭機通信開始フラグがOFFされてしまう。暫定処置としてコメントアウトする
    //rcAcbDataReset();
    cMem.ent.errNo = RcKyccin.rcChkKyChgCinDec();
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcPrcKeyAcbCinDecision", cMem.ent.errNo);
      await RcExt.rxChkModeReset("rcPrcKeyAcbCinDecision");
      await RcKyccin.rcEndKeyChgCinDecision2("rcPrcKeyAcbCinDecision");
      return;
    } else {
      await rcDispKeyAcbCinStart();
    }
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcPrc_Key_ChgCin2
  static void rcPrcKeyChgCin2() {
    return;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcDisp_Key_AcbCinStart
  static Future<void> rcDispKeyAcbCinStart() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    RcAcracb.rcGtkTimerRemoveAcb();

    if (await RcSysChk.rcChkAutoDecisionSystem()) {
      if (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId])) {
        if (cMem.acbData.totalPrice == 0 && cMem.acbData.ccinPrice == 0) {
          atSing.acbNotdecFlg = 1; //下記CinFinishにてentryを作成しないように
          await RcKyccin.rcAcrAcbCinFinish();
          atSing.acbNotdecFlg = 0; //CinFinishが終了したのでクリア
          if (cMem.acbData.totalPrice > 0) {
            //上記終了処理で入金額があった場合、
            rcAcbDataReset(); //前入金額を取得してしまっているためクリア
          }
        }
        cMem.ent.errNo = await RcAcracb.rcAcrAcbCinStartDtl(0);
      }
      if (cMem.ent.errNo != 0) {
        if (RcFncChk.rcCheckChgCinMode()) {
          await RcKyccin.rcChgCinScrModeReset();
          await RcKyccin.rcChgCinDispDestroy();
        }
        RcKyccin.ccinErrDialog2("rcDispKeyAcbCinStart", cMem.ent.errNo, 0);
        await RcExt.rxChkModeReset("rcDispKeyAcbCinStart");
        return;
      } else {
        cMem.ent.errNo =
            RcAcracb.rcGtkTimerAddAcb(500, RckyccinAcb.rcAutoDecision());
        RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId);
      }
    } else {
      cMem.ent.errNo = await rcDecisionCinStart();
      if (cMem.ent.errNo != 0) {
        RcKyccin.ccinErrDialog2("rcDispKeyAcbCinStart", cMem.ent.errNo, 0);
        await RcExt.rxChkModeReset("rcDispKeyAcbCinStart");
        return;
      } else {
        cMem.ent.errNo =
            RcAcracb.rcGtkTimerAddAcb(500, RckyccinAcb.rcAutoDecision());
        RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId);
      }
    }
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcInputPayAmtClr
  static void rcInputPayAmtClr() {
    // CMEM->acbdata.input_price = AcbInfo.oldinp_prc;
    // AcbInfo.inpfirst_flg = 1;
    // AcbInfo.input_cnt = 0;
    // rcPayAmtDsp( CMEM->acbdata.input_price );
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcInputCCinAddClr
  static void rcInputCCinAddClr() {
    // CMEM->acbdata.ccin_add_price = 0;
    // AcbInfo.input_cnt = 0;
    // rcCcinAddDsp( CMEM->acbdata.ccin_add_price );
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcInputPayAmtDsp
  static void rcInputPayAmtDsp(int fnc_cd) {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcChgCin_InpFnc
  static int rcChgCinInpFnc() {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcChk_ChgCin_CanDisp
  static bool rcChkChgCinCanDisp() {
    return false;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcSst_DetailErrGet
  static Future<int> rcSstDetailErrGet() async {
    StateSst1 stateSst1 = StateSst1();
    int errNo = await RcAcracb.rcSstState80ReadDtl(stateSst1);
    if (errNo == OK) {
      AplLib.acxErrData.errCode = stateSst1.detailErrCode;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcSstDetailErrGet() errCode[${AplLib.acxErrData.errCode}]");
    }
    return errNo;
  }

  /// 関連tprxソース: rckyccin_acb.c - rcChk_ChgCin_ErrRecover
  static Future<int> rcChkChgCinErrRecover() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcChk_ChgCin_ErrRecover()");
    int ret = await AcxErrGui.acxErrGuiGuiDataChk(await RcSysChk.getTid());
    if ((ret != 0) &&
        (CmCksys.cmAcxErrGuiSystem() != 0) &&
        await RcSysChk.rcQCChkQcashierSystem()) {
      // Assist Monitorへ送信
      RcAssistMnt.asstPcLog = AplLib.acxErrData.errTitle;
      RcAssistMnt.asstPcLog += " Start";
      RcAssistMnt.rcAssistSend(AcbInfo.acxErrCode);
    }
    return ret;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rckyccin_acb.c - rcChgCin_DispErrorRecover
  static void rcChgCinDispErrorRecover() {}

  /// 関連tprxソース: rckyccin_acb.c - rcEcs_DetailErrGet
  static Future<int> rcEcsDetailErrGet() async {
    int errNo = 0;
    StateEcs stateEcs = StateEcs();

    errNo = await RcAcracb.rcEcsStateReadDtl(stateEcs);
    if (errNo == OK) {
      AcxErrGui.acxErrGuiStateEcsSet(await RcSysChk.getTid(), stateEcs);
    }
    return errNo;
  }
}
