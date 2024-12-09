/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/regs/checker/rc_acbstopdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_qc_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_plu.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin_acb.dart';
import 'package:flutter_pos/app/regs/checker/rckydisburse.dart';
import 'package:flutter_pos/app/regs/checker/rcqc_com.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'package:get/get.dart';

import '../../ui/page/change_coin/p_changecoinin_page.dart';
import 'rc_28dsp.dart';
import 'rc_acracb.dart';
import 'rc_advancein.dart';
import 'rc_cash_recycle.dart';
import 'rc_ext.dart';
import 'rc_fself.dart';
import 'rc_ifevent.dart';
import 'rc_itm_dsp.dart';
import 'rc_mbr_com.dart';
import 'rc_reserv.dart';
import 'rc_usbcam1.dart';
import 'rcinoutdsp.dart';
import 'rcky_self_mnt.dart';
import 'rcky_stl.dart';
import 'rcky_tab.dart';
import 'rckycptn.dart';
import 'rcstlfip.dart';

class RcKyccin {
  static AcbMem acbMem = AcbMem();
  static AcbInfo acbInfo = AcbInfo();

  static Object? QC_MenteDspWindows;

  static const String CCIN_ERR_RESET = '解除完了';
  static const String CCIN_END = '強制\n終了';
  static const int ACX_ERR_GUI_RETRY = 1;


  /// 釣機入金画面を開く
  static void openCinPage(String title, FuncKey key) {
    if (RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId,
          type: MsgDialogType.error,
        ),
      );
    } else {
      Get.to(() => ChangeCoinInScreen(title: title, funcKey: key));
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rckyccin.c - rcCheck_AcbFnal
  static int rcCheckAcbFnal() {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rckyccin.c - Ccin_ErrDialog, Ccin_ErrDialog2
  static Future<int> ccinErrDialog2(
      String callFunc, int erCode, int errchkFlg) async {
    String functionName = 'ccinErrDialog2';
    int tId = await RcSysChk.getTid();
    AtSingl atSing = SystemFunc.readAtSingl();
    SgMem selfMem = SgMem();
    int errorNo = Typ.OK;

    if ((TprLibDlg.tprLibDlgCheck2(1) == 0) &&
        (!RckyccinAcb.rcChkCcinDialog()) &&
        (!RcFncChk.rcCheckChgErrMode())) {
      TprLog().logAdd(tId, LogLevelDefine.normal,
          '$functionName( call_func : $callFunc )\n');
    }

    if ((await RcSysChk.rcQCChkQcashierSystem()) &&
        (RcQcCom.qc_2nd_err_wait == 1)) {
      //rcQC_2ndErr_DspProc() Timer待ち -> rcQC_2ndErr_DspProcに任せる
      TprLog().logAdd(
          tId, LogLevelDefine.normal, '$functionName : qc_2nd_err_wait');
      return 0;
    }

    if (await RcSysChk.rcSysChkHappySmile()) {
      if (atSing.rckySelfMnt == 0) {
        RcfSelf.rcFselfQcCashDispRemake();
      }
    }

    AcbInfo.acxErrCode = erCode; //エラー表示開始時のコードを保存。アシストモニタログに載せるため
    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {
      if (CompileFlag.SELF_GATE) {
        if (await RcSysChk.rcSGChkSelfGateSystem()) {
          if (selfMem.Staff_Call == 2) {
            selfMem.Staff_Call = 0; //店員呼出を経由しているので、エラー表示へ
          }
        }
      }
      await RcExt.rcErr(functionName, erCode);
      return (0);
    }
    if ((CmCksys.cmAcxErrGuiSystem() != 0) &&
        (!RcFncChk.rcCheckChgErrMode()) &&
        (acbMem.acx_error_num != erCode)) {
      //釣銭機から取得したerrorNoとエラー表示をしようとしているerrorNoが異なる -> 釣銭機エラーでない？
      TprLog().logAdd(tId, LogLevelDefine.normal,
          '$functionName : acx_error_num[$acbMem.acx_error_num] != errorNo[$erCode] -> Normal Error\n');

      if (CompileFlag.SELF_GATE) {
        if (await RcSysChk.rcSGChkSelfGateSystem()) {
          if (selfMem.Staff_Call == 2) {
            selfMem.Staff_Call = 0; //店員呼出を経由しているので、エラー表示へ
          }
        }
      }
      await RcExt.rcErr(functionName, erCode);
      return (0);
    }

    if (!await RcSysChk.rcSGChkSelfGateSystem()) {
      atSing.acbActFinalFlg = 0; //フラグリセットしないとパスワード入力できない。
    }

    //フラグを残して処理を継続させないとセルフの画面が次画面に遷移しておりボタンが表示されていないので何もできない。
    if (CmCksys.cmAcxErrGuiSystem() != 0) {
      if (!RcFncChk.rcCheckChgErrMode()) {
        if (CompileFlag.SELF_GATE) {
          if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
              (!RcFncChk.rcSGCheckMntMode()) &&
              (selfMem.Staff_Call == 0)) {
            selfMem.Staff_Call = 2; //店員呼出(rcErr) -> 2nd error(エラー復旧GUIへ)
            await RcExt.rcErr(functionName, erCode);
          } else if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
              (selfMem.Staff_Call != 0) &&
              (TprLibDlg.tprLibDlgCheck2(1) != 0)) {
            /* 店員お呼びくださいダイアログが自動で消えないように */
          } else if ((await RcSysChk.rcQCChkQcashierSystem()) &&
              !((RcFncChk.rcQCCheckStaffDspMode()) ||
                  (RcFncChk.rcQCCheckPassWardDspMode()) ||
                  (RcFncChk.rcQCCheckMenteDspMode()) ||
                  (QC_MenteDspWindows != null)) &&
              (RcQcCom.qc_err_recover_flg == 0)) {
            RcQcCom.rcQCErrRecoverSet(
                functionName); //店員呼出(rcErr) -> 2nd error(エラー復旧GUIへ)
            await RcExt.rcErr(functionName, erCode);
          } else if ((await RcSysChk.rcChkSQRCTicketSystem()) &&
              ((RcFncChk.rcSQRCCheckStaffDspMode()) ||
                  (RcFncChk.rcSQRCCheckPassWordDspMode()))) {
            /* 店員お呼びくださいダイアログが自動で消えないように */
          } else {
            selfMem.Staff_Call = 0;
            acbMem.acx_error_num = 0;
            var ifSelectSst1 = AcxCom.ifAcbSelect() & CoinChanger.SST1;
            var ifSelectEcsX = AcxCom.ifAcbSelect() & CoinChanger.ECS_X;
            if (ifSelectSst1 != 0) {
              errorNo = await rcChgCinDispErrorSst(erCode);
            } else if (ifSelectEcsX != 0) {
              errorNo = await rcChgCinDispErrorEcs(erCode);
            }
            if (errorNo != -1) {
              if (errorNo != Typ.OK) {
                await RcExt.rcErr(functionName, erCode);
              } else if (erCode != Typ.OK) {
                await RcExt.rcErr(functionName, erCode);
              }
            }
          }
        } else {
          acbMem.acx_error_num = 0;
          var ifSelectSst1 = AcxCom.ifAcbSelect() & CoinChanger.SST1;
          var ifSelectEcsX = AcxCom.ifAcbSelect() & CoinChanger.ECS_X;
          if (ifSelectSst1 != 0) {
            errorNo = await rcChgCinDispErrorSst(erCode);
          } else if (ifSelectEcsX != 0) {
            errorNo = await rcChgCinDispErrorEcs(erCode);
          }
          if (errorNo != -1) {
            if (errorNo != Typ.OK) {
              await RcExt.rcErr(functionName, erCode);
            } else if (erCode != Typ.OK) {
              await RcExt.rcErr(functionName, erCode);
            }
          }
        }
      }
    } else {
      await rcSstErrFinish(erCode);
      var ifSelectEcsX = AcxCom.ifAcbSelect() & CoinChanger.ECS_X;
      if ((ifSelectEcsX == 0) && (errchkFlg == 1)) {
        errorNo = await rcAcbCinErrCode();
      }
      if (AcbInfo.reStartCnt > 5) {
        errorNo = DlgConfirmMsgKind.MSG_TAKE_MONEY.dlgId;
      }
      if (errorNo == Typ.OK) {
        errorNo = erCode;
      }
      if (CompileFlag.SELF_GATE) {
        if (await RcSysChk.rcSGChkSelfGateSystem()) {
          if (selfMem.Staff_Call == 2) {
            selfMem.Staff_Call = 0; //店員呼出を経由しているので、エラー表示へ
          }
        }
      }
      await RcExt.rcErr(functionName, errorNo);
    }
    return (0);
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rckyccin.c - rcChgCin_DispError_Ecs
  static Future<int> rcChgCinDispErrorEcs(int erCode) async {
    String functionName = 'rcChgCinDispErrorEcs';
    int	errNo;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return Typ.NG;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    for(int i = 0; i <= ACX_ERR_GUI_RETRY; i++){
      errNo = await RckyccinAcb.rcEcsDetailErrGet();
      if(errNo == Typ.OK){
        //エラーコード取得OK
        if(AplLib.acxErrData.unit.compareTo('00') < 0){
          //エラーコードなし
          if((tsBuf.acx.stateEcs.actMode - 0) != 1){
            //異常でない -> リトライしてもエラーコードとれない
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                '$functionName : act_mode[$tsBuf.acx.stateEcs.actMode] not error return\n');
            return errNo;
          }
          else{
            if(i >= ACX_ERR_GUI_RETRY){
              //リトライオーバー
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  '$functionName : retry[$i] over\n');
              return errNo;
            }
            else{
              //リトライしてエラーコード再取得
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  '$functionName : %s : retry\n');
              await Future.delayed( const Duration(milliseconds: 500));
              continue;
            }
          }
        }
        else{
          //エラーコードあり
          break;
        }
      }
      else{
        //エラーコード取得NG
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            '$functionName : rcEcs_DetailErrGet NG errNo[$errNo]\n');
        return errNo;
      }
    }

    int ret = await RckyccinAcb.rcChkChgCinErrRecover();
    if(ret != 0){
      RckyccinAcb.rcChgCinDispErrorRecover();
      rcChgCinDispErrorRecoverBz();
      return(-1);
    }
    else{
      return erCode;
    }
  }

  ///  関連tprxソース: rckyccin.c - rcOthConnect_AcrAcbStop
  static Future<int> rcOthConnectAcrAcbStop() async {
    String log;
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcOthConnectAcrAcbStop");
    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        (await RcSysChk.rcChkAutoDecisionSystem()) &&
        (!RcFncChk.rcCheckChgCinMode()) &&
        (!await RcSysChk.rcSGChkSelfGateSystem()) &&
        (!await RcSysChk.rcQCChkQcashierSystem()) &&
        ((await rcChkAcbCinAct() != 0) ||
            (cMem.acbData.acbDeviceStat == AcxStatus.CinWait.id))) {
      AcbInfo.othConnectAcbStopFlg = 1;
      errNo = await rcAcrAcbForceEnd(0);
      if (await RcSysChk.rcSysChkHappySmile()) {
        FuncKey fncCode = FuncKey.values
            .firstWhere((element) => element.keyId == cMem.stat.fncCode);
        switch (fncCode) {
          case FuncKey.KY_OFF: /* 「休止」 */
          case FuncKey.KY_WORKIN: /* 「業務宣言」 */
            /* HappySelf仕様[対面セルフ]で出金後客側とタブのお預り額を更新 */
            await rckyccinFselfCinamtDraw();
            break;
          case FuncKey.KY_STL: /* 「小計」 */
            if (await RckyStl.rcStlCinDspWaitChk()) {
              /* QCashierIni 「小計押下時、対面入金動作(しない)設定で会計方法選択を表示する場合 */
              await rckyccinFselfCinamtDraw();
            }
            break;
          default:
            /* 何もしない */
            break;
        }
      }
    }

    if (errNo != Typ.OK) {
      log = "rcOthConnectAcrAcbStop: err_no($errNo)\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rckyccin.c - rc_AcrAcb_CinFinish
  static Future<int> rcAcrAcbCinFinish() async {
    int errNo = 0;
    int tmpNo = 0;
    String log;
    int i = 0;
    int savDecisionFlg = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.acbData.acbDeviceStat == AcxStatus.CinStart.id) {
      //釣銭機の状態がまだ確定していない中途半端な状態なのでCinStartから状態が変わるまで念のため待機
      savDecisionFlg = AcbInfo.autoDecisionFlg;
      for (i = 0; i < 10; i++) {
        if (AcbInfo.autoDecisionFlg == 1) {
          AcbInfo.autoDecisionFlg = 0;
        }
        errNo = await RcAcracb.rcAcrAcbCinReadDtl();
        if (cMem.acbData.acbDeviceStat == AcxStatus.CinStart.id) {
          //エラーでも短時間の監視なので監視続行
          log = "rcAcrAcbCinFinish: device[START] wait[$i] errNo[$errNo]\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          TprMacro.usleep(100000);
        } else {
          if (errNo != 0) {
            //エラーでもログ出力だけで何もしない。ここは状態の監視のみで処理継続させ実際の終了処理での結果に従う
            log = "rcAcrAcbCinFinish: device[START] wait errNo($errNo)\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          }
          break;
        }
      }
      AcbInfo.autoDecisionFlg = savDecisionFlg;
    }

    if ((cMem.acbData.acbDeviceStat != AcxStatus.CinStop.id) &&
        (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id)) {
      errNo = await RcAcracb.rcAcrAcbCinStopDtl();
      if (errNo == 0) {
        errNo = await RckyccinAcb.rcAcrAcbStopWait2(0);
      }
      if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
          (RcAcracb.rcChkAcrAcbRjctErr(errNo))) {
        errNo = 0;
      }
      if (RcAcracb.rcChkAcrAcbFullErr(errNo)) {
        tmpNo = errNo;
        errNo = 0;
      }
    }
    if (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) {
      if ((AcxCom.ifAcbSelect() & CoinChanger.FAL2) != 0) {
        errNo = 0; //FAL2はStopWaitの結果に関わらずEndへ。エラー発生時にEndしないと釣銭機エラー解除できない。
      }
      if (errNo == 0) {
        errNo = await RcAcracb.rcAcrAcbCinEndDtl();
      }
      if (errNo == 0) {
        errNo = await RckyccinAcb.rcAcrAcbStopWait2(1);
      }
      if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
          (RcAcracb.rcChkAcrAcbRjctErr(errNo))) {
        errNo = 0;
      }
    }
    if ((errNo == 0) && (tmpNo != 0)) {
      errNo = tmpNo;
    }
    return errNo;
  }

  ///  関連tprxソース: rckyccin.c - rcEnd_Key_ChgCin_Decision2
  /// 引数   : callFuncName 呼び出し元メソッド名
  static Future<void> rcEndKeyChgCinDecision(String callFuncName) async {
    await rcEndKeyChgCinDecision2(callFuncName);
  }

  ///  関連tprxソース: rckyccin.c - rcEnd_Key_ChgCin_Decision2
  static Future<void> rcEndKeyChgCinDecision2(String callFuncName) async {
    AcMem cMem = SystemFunc.readAcMem();
    SgMntDsp mntDsp = SgMntDsp();
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcbMem acbMem = SystemFunc.readAcbMem();
    if ((RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!(await RcSysChk.rcCheckQCJCSystem()))) {
      return;
    }
    String message =
        'rcEndKeyChgCinDecision2( callFuncName : $callFuncName )\n';
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, message);

    switch (FuncKey.values[acbMem.FncCode]) {
      case FuncKey.KY_CHGCIN:
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
        SystemFunc.readAtSingl().fselfInoutChk = 1;
        /* 商品登録後/常時入金仕様時、このタイミングで釣銭機をIN状態にさせない為 */
        break;
      default:
        break;
    }
    AcbInfo.totalPrice = 0;
    if (AcbInfo.forceEndFlg != 1) {
      cMem.acbData.acbDeviceStat = 0;
    }
    acbMem.FncCode = 0; /* 初期化 */

    if (CompileFlag.TW) {
      if (!await RcSysChk.rcSGChkSelfGateSystem()) {
        if ((cMem.acbData.totalPrice > 0) || (AcbInfo.recalcPrc > 0)) {
          RcSet.rcClearEntry();
        }
      }
    } else {
      if (((!await RcSysChk.rcSGChkSelfGateSystem()) &&
              (!await RcSysChk.rcQCChkQcashierSystem())) ||
          (mntDsp.mntDsp == 1)) {
        if ((cMem.acbData.totalPrice > 0) || (AcbInfo.recalcPrc > 0)) {
          RcSet.rcClearEntry();
        }
      }
    }
    RckyccinAcb.rcAcbDataReset();
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId);
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CHGPOST.keyId])) {
      RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_CHGPOST.keyId);
    }
    if (RcRegs.kyStC3(cMem.keyStat[FuncKey.KY_CHGPOST.keyId])) {
      RcRegs.kyStR3(cMem.keyStat, FuncKey.KY_CHGPOST.keyId);
    }

    await RckyDisBurse.rcSetChangerItemAcrON(); /* 特定商品釣銭機無効仕様（コープさっぽろ仕様） */

    if (RcSysChk.rcCheckRegFnal()) {
      await RcSet.cashStatReset2('rcEndKeyChgCinDecision2');
    }

    if ((await RcSysChk.rcQCChkQcashierSystem()) &&
        (RcFncChk.rcQCCheckMenteDspMode())) {
      RcQcDsp.rcQCMenteTotalInfoCreate();
      RcSet.rcClearEntry();
    }

    if (atSingl.chgstopCtrlFlg == 2) {
      await RcKyPlu.rcAnyTimeCinStartProc();
      atSingl.chgstopCtrlFlg = 0;
    }

    if (RcAcbStopdsp.rcAcbStopdsp != -1) {
      Fb2Gtk.gtkTimeoutRemove(RcAcbStopdsp.rcAcbStopdsp);
      RcAcbStopdsp.rcAcbStopdsp = -1;
    }
    return;
  }

  ///  関連tprxソース: rckyccin.c - rc_Acb_CinErrCode
  static Future<int> rcAcbCinErrCode() async {
    int i; /* Answer Request Counter */
    int erCode;
    int acbSelect;
    int flg;
    AcMem CMEM = SystemFunc.readAcMem();
    RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();

    i = 0;
    erCode = Typ.OK;
    acbSelect = AcxCom.ifAcbSelect();
    if ((acbSelect & CoinChanger.ECS_X != 0) ||
        (acbSelect & CoinChanger.FAL2 != 0)) {
      return (erCode);
    }
    CMEM.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
      flg = CoinChanger.ACR_COINBILL;
      /* TODO:00015 江原 関数呼び出し追加され次第解除
        if((er_code = if_acx_CinRead(Tpraid.TPRAID_ACX, flg)) == Typ.OK) {
          CMEM.stat.acrMode |= RcRegs.GET_MODE;
          tsBuf.acx.order = AcxProcNo.ACX_ANS_READ.no;
        }
        else{
          RcAcracb.rcResetAcrOdr();
          return(er_code);
        }
        */
    }
    if (CMEM.stat.acrMode & RcRegs.GET_MODE != 0) {
      /* Answer Get Mode ? */
      for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
        if (tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) {
          // er_code = rcAcb_CinErrCode(tsBuf.acx.devAck); TODO:00015 関数呼び出し追加
          break;
        }
        // usleep(30000);
      }
    }
    return (erCode);
  }

  ///  関連tprxソース: rckyccin.c - rcChgCin_AutoDec_ErrCntReset
  static Future<void> rcChgCinAutoDecErrCntReset() async {
    if (AcbInfo.autoDecErrcnt != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "AcbInfo.AutoDec_errcnt (${AcbInfo.autoDecErrcnt} -> 0) reset\n");
    }
    AcbInfo.autoDecErrcnt = 0;
    AcbInfo.autoDecClrcnt = 0;
  }

  ///  関連tprxソース: rckyccin.c - rcChk_Acb_CinAct
  static Future<int> rcChkAcbCinAct() async {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem())) &&
        (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        (await RcSysChk.rcChkAutoDecisionSystem())) {
      errNo = await RckyccinAcb.rcCinReadGetWait2('rcChkAcbCinAct');
    }
    if ((cMem.acbData.acbDeviceStat == AcxStatus.CinAct.id) ||
        (cMem.acbData.acbDeviceStat == AcxStatus.CinStart.id)) {
      return 1;
    } else {
      return 0;
    }
  }

  ///  関連tprxソース: rckyccin.c - rcChgCin_endFnc
  static Future<int> rcChgCinEndFnc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return Typ.Error;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    String log;
    CBillKind ccinSht = CBillKind();

    if (AcbInfo.inpFirstFlg != 0) {
      await RcExt.rcErr("rcChgCinEndFnc", DlgConfirmMsgKind.MSG_INPUTNUM.dlgId);
      await RcExt.rxChkModeReset("rcChgCinEndFnc");
      return 0;
    }
    if (await RcSysChk.rcChkAutoDecisionSystem() &&
        ((AcbInfo.errRestartFlg == 1) && (cMem.acbData.acbFullStat == "0"))) {
      await RcExt.rcErr("rcChgCinEndFnc", DlgConfirmMsgKind.MSG_ACRACT.dlgId);
      return 0;
    }
    if (cMem.acbData.acbDeviceStat == AcxStatus.CinReset.id) {
      await RcExt.rcErr(
          "rcChgCinEndFnc", DlgConfirmMsgKind.MSG_ACB_RESETSTATUS.dlgId);
      return 0;
    }
    if (atSing.acbActFinalFlg != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "ChgCin_endFnc cancel");
      return 0;
    }
    if (cMem.acbData.keyChgcinFlg == "1") {
      /* 釣機入金(補充処理)？ */
      return 0;
    }

    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCin_endFnc");
    RcAcracb.rcGtkTimerRemoveAcb();

    // 実行ボタンを押下してもボタンが凹まないと指摘があった為
    // Parts_Show_Event(1);
    if (await RcSysChk.rcSysChkHappySmile()) {
      atSing.happySmileCashCncl = 1;
    }

    if (await rcChkAcbCinAct() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "CinAct endFnc Retry");
      atSing.acbActFinalFlg = AcbActFinalFlg.End_Flg.flgId;
      if (cMem.acbData.keyChgcinFlg == "1") {
        /* 釣機入金(補充処理)？ */
        await RckyccinAcb.rcPrcKeyChgCin3();
      } else {
        RckyccinAcb.rcAutoDecision();
      }
      return 0;
    }

    await RcExt.rxChkModeSet("rcChgCinEndFnc");
    if ((cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) &&
        (((AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) &&
                (((!await RcSysChk.rcQCChkQcashierSystem()) &&
                        (!await RcSysChk.rcNewSGChkNewSelfGateSystem())) ||
                    (cMem.acbData.acbFullPrice == 0))) ||
            ((AcxCom.ifAcbSelect() & CoinChanger.SST1 != 0) &&
                (await RcSysChk.rcChkAutoDecisionSystem()) &&
                (!rcChkSstErrRestart())))) {
      cMem.ent.errNo = await RcAcracb.rcChgCinCancelDtl();
      if (cMem.ent.errNo != 0) {
        log = "rcChgCinEndFnc() ChgCinCancelDtl errorNo(${cMem.ent.errNo})\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        ccinErrDialog2("rcChgCinEndFnc", cMem.ent.errNo, 0);
        RcIfEvent.rxChkModeReset2("rcChgCinEndFnc");
      }
    } else {
      if ((cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) &&
          (cMem.acbData.acbFullStat == "0")) {
        cMem.ent.errNo = await rcAcrAcbCinFinish();
        if (cMem.ent.errNo != 0) {
          RcIfEvent.rxChkModeReset2("rcChgCinEndFnc");
          atSing.acbActFinalFlg = AcbActFinalFlg.End_Flg.flgId;
          RckyccinAcb.rcAutoDecision();
          return 0;
        }
      }

      if (AcbInfo.autoDecisionFlg == 1) {
        AcbInfo.autoDecisionFlg = 0;
      }
      cMem.ent.errNo = await RcAcracb.rcAcrAcbCinReadDtl(); /* add 04.01.26 */
      rcAcbPriceDataSet();

      if (cMem.acbData.totalPrice != 0) {
        if ((AcxCom.ifAcbSelect() & CoinChanger.ACB_50_X != 0) &&
            ((cBuf.dbTrm.acxAcb50Control1 != 0) ||
                ((cMem.acbData.totalPrice >
                        99999) && //金額6桁出金ができないので枚数指定出金を行ったほうが払い出せる可能性があるため
                    (cBuf.iniMacInfo.acx_flg.acb50_ssw24_0 ==
                        0)) || //金額6桁出金ができないので枚数指定出金を行ったほうが払い出せる可能性があるため
                ((cMem.acbData.totalPrice > 999999) &&
                    (cBuf.iniMacInfo.acx_flg.acb50_ssw24_0 == 1)))) {
          rcAcrAcbCcinShtSet(ccinSht);
          cMem.ent.errNo = await RcAcracb.rcAcrAcbShtSpecifyOut(ccinSht, 1, 0);
        } else {
          if (cBuf.dbTrm.acxCashInputManual != 0) {
            cMem.ent.errNo = await RcAcracb.rcAcrAcbChangeOut(
                cMem.acbData.totalPrice - cMem.acbData.ccinAddPrice);
          } else {
            cMem.ent.errNo =
                await RcAcracb.rcAcrAcbChangeOut(cMem.acbData.totalPrice);
          }
        }
        if (cMem.ent.errNo == 0) {
          cMem.ent.errNo = await RcAcracb.rcPrgAcrAcbResultGet();
        }
        if (cMem.ent.errNo != 0) {
          log = "rcChgCinEndFnc() ChangeOut errNo(${cMem.ent.errNo})\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          await ccinErrDialog2("rcChgCinEndFnc", cMem.ent.errNo, 0);
          await RcExt.rxChkModeReset("rcChgCinEndFnc");
        }
      }
    }
    //   rxChkModeReset();
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      await rcEndKeyChgCinDecision2("rcChgCinEndFnc");
      AcbInfo.reStartCnt = 0; /* add 03.12.25 */
      RckyccinAcb.rcSGCnclReStartProc();
      await RcExt.rxChkModeReset("rcChgCinEndFnc");
      return 0;
    }
    if (RcFncChk.rcCheckChgCinMode()) {
      await rcChgCinScrModeReset();
      await rcChgCinDispDestroy();
      if (!await RcSysChk.rcQCChkQcashierSystem()) {
        RcMbrCom.rcMbrPrcSet(-1, 0);
      }
      // TODO:10154 釣銭機UI関連
      // #if COLORFIP  画面描画の部分なので恐らく不要
      //       if(rcChk_fself_system()) {
      // //         rc_fself_subttl_redisp();
      //     if (rcsyschk_happy_smile())
      //     { // 表示内容が違うので、ここでは処理しない
      //       if(atSing->rcky_self_mnt == 1)
      //       {
      //         rcky_self_mnt(0);
      //       }
      //       else
      //       {
      //         ;
      //       }
      //
      //       if(QCCashDsp.pay_btn != NULL)
      //       {
      //         gtk_widget_hide(QCCashDsp.pay_btn);
      //       }
      //       if(QCCashDsp.no_receipt_pay_btn != NULL)
      //       {
      //         gtk_widget_hide(QCCashDsp.no_receipt_pay_btn);
      //       }
      //       if(QCCashDsp.rfm_pay_btn != NULL)
      //       {
      //         gtk_widget_hide(QCCashDsp.rfm_pay_btn);
      //       }
      //     }
      //     else
      //     {
      //       rc_fself_subttl_redisp();
      //     }
      //       }
      // #endif
    }
    if (cMem.acbData.keyChgcinFlg == '1') {
      /* 釣機入金(補充処理)？ */
      if (cBuf.iniMacInfo.acx_flg.acr50_ssw14_7 == 1) {
        RcAcracb.rcAcbSsw14Set(0);
      }
    }

    // TODO:10154 釣銭機UI関連
    // #if COLORFIP 画面描画の部分なので恐らく不要
    //   if ( C_BUF->vtcl_rm5900_regs_on_flg )
    //   {
    //     rm59_ColorFipTtl_cin_amt ( 0 );    // RM-3800 客表の釣機入金額削除
    //   }
    //   if (rcChk_fself_system())
    //   {
    //     if((rxChkKoptCmn_LangChg_NoYes(C_BUF) != FSELF_LANGCHG_NO_USE)		/* 言語切替を行う場合 */
    //       && (rcky_Get_Lang_Typ() != FSELF_LANG_JPN))		/* 日本語以外の場合 */
    //     {
    //       memset(sound_fself_lang_name, 0x0, sizeof(sound_fself_lang_name));
    //       rcky_Edit_Sound_File(SND_6707, sound_fself_lang_name, sizeof(sound_fself_lang_name));	/* 音声ファイル名の編集 */
    // //			atSing.fself_sound_no = sound_fself_lang_name; //お金をお取りください
    //       snprintf(atSing->fself_sound_no, sizeof(atSing->fself_sound_no), "%s", sound_fself_lang_name);
    //     }
    //     else
    //     {
    // //			atSing.fself_sound_no = (char *)SND_6707; //お金をお取りください
    //       snprintf(atSing->fself_sound_no, sizeof(atSing->fself_sound_no), "%s", SND_6707); //お金をお取りください
    //     }
    //   }
    // #endif

    await rcChgCinEndFnc2();
    return 0;
  }

  ///  関連tprxソース: rckyccin.c - rcChgCin_endFnc2
  static Future<void> rcChgCinEndFnc2() async {
    int result;
    int popTimer;
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    await RcAcracb.rcGtkTimerRemoveCcin();
    if ((await RcAcracb.rcCheckAcrAcbON(1) != 0) &&
        ((await RcSysChk.rcChkAcrAcbForgetChange()) ||
            (await RcSysChk.rcQCChkQcashierSystem()) ||
            (await RcSysChk.rcChkFselfSystem()))) {
      if ((result = RckyccinAcb.rcChkPopWindowChgOutWarn(0)) != 0) {
        cBuf.kymenuUpFlg = 2;
        popTimer = await RcAcracb.rcAcrAcbPopTimerCalc(result);
        errNo = RcAcracb.rcGtkTimerAddCcin(popTimer, rcChgCinEndFnc2());
        if (errNo != 0) {
          await RcExt.rcErr("rcChgCinEndFnc2", errNo);
          await RcKyccin.rcEndKeyChgCinDecision2("rcChgCinEndFnc2");
          await RcExt.rxChkModeReset("rcChgCinEndFnc2");
          cBuf.kymenuUpFlg = 0;
        }
        return;
      }
    }
    await RcKyccin.rcEndKeyChgCinDecision2("rcChgCinEndFnc2");
    await RcExt.rxChkModeReset("rcChgCinEndFnc2");
    cBuf.kymenuUpFlg = 0;

    if (await CmCksys.cmDrugStoreSystem() != 0) {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_DUALCSHR:
          RcStFip.rcStlFip(RcRegs.FIP_NO1);
          break;
        case RcRegs.KY_SINGLE:
          RcStFip.rcStlFip(RcRegs.FIP_NO1);
          RcStFip.rcStlFip(RcRegs.FIP_NO2);
          break;
        case RcRegs.KY_CHECKER:
          RcStFip.rcStlFip(RcRegs.FIP_NO2);
          break;
        default:
          break;
      }
    }

    if (await RcSysChk.rcChkFselfSystem()) {
      if (await RcSysChk.rcSysChkHappySmile()) {
        await Rc28StlInfo.rcFselfSubttlRedisp();
      }
    }
    return;
  }

  // TODO:00016 佐藤 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rckyccin.c - rcAcbFullPrice_Set
  static void rcAcbFullPriceSet() {
    return;
  }

  // TODO:00016 佐藤 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rckyccin.c - rcAcrAcb_ReinShtSet
  static void rcAcrAcbReinShtSet() {
    return;
  }

  /// 関連tprxソース: rckyccin.c - rcChk_SstErrRestart
  static bool rcChkSstErrRestart() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((AcbInfo.errRestartFlg == 1) || (cMem.acbData.acbFullPrice != 0));
  }

  /// 関連tprxソース: rckyccin.c - chkdlg1_clicked
  static Future<void> chkdlg1Clicked() async {
    StateEcs stateEcs = StateEcs();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    await RcAcracb.rcEcsStateReadDtl(stateEcs);
    if (stateEcs.key.coinKey == 50) {
      //硬貨ユニットが保守キーの場合
      TprDlg.tprLibDlgClear("chkdlg1Clicked");
      await RcExt.rcClearErrStat("chkdlg1Clicked");
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_KEY_POSI_MENTE.dlgId;
      await RcExt.rcErr("chkdlg1Clicked", cMem.ent.errNo);
      AcbInfo.ccinDialog = 0;
      return;
    }
    TprLog()
        .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "Yes_clicked");
    TprDlg.tprLibDlgClear("chkdlg1Clicked");
    await RcExt.rcClearErrStat("chkdlg1Clicked");
    AcbInfo.ccinDialog = 0;
    if (await RcFncChk.rcCheckBkAdvanceInMode() ||
        await RcFncChk.rcCheckAdvanceInMode()) {
      RcAdvanceIn.rcAdvanceInCinMsgClr();
    } else if (RcFncChk.rcCheckReservMode() ||
        await RcFncChk.rcCheckBkScrReservMode()) {
      await rcAcrAcbForceEnd(1);
      RcReserv.rcReservCindsp(1);
    } else {
      await rcAcrAcbForceEnd(1);
    }

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      if (await RcSysChk.rcChkDesktopCashier()) {
        RcSet.cashNoticeReset();
      }
    }
    if (await RcSysChk.rcChkSmartSelfSystem()) {
      if (atSing.rckySelfMnt == 1) {
        if ((RcSysChk.rcSysChkHappySelfAutoStrClsChk() == 0) &&
            (!(AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) ==
                AutoRun.AUTORUN_STROPN.val))) {
          if ((await RcFncChk.rcCheckItmMode()) ||
              (await RcFncChk.rcCheckStlMode()) ||
              (await RcFncChk.rcChkFselfPayMode() &&
                  cMem.acbData.keyChgcinFlg == '0')) {
            RcKySelfMnt.rcKySelfMnt(0);
            await RcfSelf.rcFselfQcCashDispRemake();
          }
        }
      }
    }
    return;
  }

  /// 関連tprxソース: rckyccin.c - chkdlg2_clicked
  static Future<void> chkdlg2Clicked() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    TprLog()
        .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "No_clicked");
    TprDlg.tprLibDlgClear("chkdlg2Clicked");
    await RcExt.rcClearErrStat("chkdlg2Clicked");
    AcbInfo.ccinDialog = 0;
    if (RcFncChk.rcCheckReservMode() ||
        await RcFncChk.rcCheckBkScrReservMode()) {
      await RcKyccin.rcChgCinAutoDecErrCntReset();
      RcReserv.rcReservCindsp(0);
    }
    await RcKyccin.rcChgCinAutoDecErrCntReset();

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      if (await RcSysChk.rcChkDesktopCashier()) {
        RcSet.cashNoticeReset();
      }
    }
    if (await RcSysChk.rcChkSmartSelfSystem()) {
      if (atSing.rckySelfMnt == 1) {
        if ((RcSysChk.rcSysChkHappySelfAutoStrClsChk() == 0) &&
            (!(AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) ==
                AutoRun.AUTORUN_STROPN.val))) {
          if ((await RcFncChk.rcCheckItmMode()) ||
              (await RcFncChk.rcCheckStlMode()) ||
              (await RcFncChk.rcChkFselfPayMode() &&
                  cMem.acbData.keyChgcinFlg == '0')) {
            RcKySelfMnt.rcKySelfMnt(0);
            await RcfSelf.rcFselfQcCashDispRemake();
          }
        }
      }
    }
    return;
  }

  ///  関連tprxソース: rckyccin.c - rcAcrAcb_ForceEnd
  static Future<int> rcAcrAcbForceEnd(int flg) async {
    String log = '';
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    log = 'rcAcrAcbForceEnd($flg)\n';
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    AcbInfo.forceEndFlg = flg;
    errNo = await rcAcrAcbForceEndChangeOut();
    if ((errNo != 0) && (AcbInfo.othConnectAcbStopFlg != 1)) {
      if (flg == 1) {
        //強制終了選択時、メッセージ変更
        var tid = await RcSysChk.getTid();
        if (AplLibAuto.aplLibCMAutoMsgSendChk(tid) != 0) {
          await RcExt.rcErr('rcAcrAcbForceEnd', DlgConfirmMsgKind.MSG_TEXT95.dlgId);
        } else {
          await RcExt.rcErr('rcAcrAcbForceEnd', DlgConfirmMsgKind.MSG_TEXT195.dlgId);
        }
        await RcExt.rxChkModeReset('rcAcrAcbForceEnd');
      } else {
        await RcExt.rcErr('rcAcrAcbForceEnd', errNo);
        await RcExt.rxChkModeReset('rcAcrAcbForceEnd');
      }
    }

    if ((errNo != 0) && (cMem.acbData.totalPrice != 0)) {
      if (atSing.othcntEjecterrChk == 1) {
        rcDispKeyChgCin();
        await rcChgCinScrModeSet();
        RckyccinAcb.rcDispKeyAcbCin2();
        cMem.ent.errNo =
            RcAcracb.rcGtkTimerAddAcb(500, RckyccinAcb.rcAutoDecision());
      } else {
        await rcEndKeyChgCinDecision2('rcAcrAcbForceEnd');
      }
    } else {
      await rcEndKeyChgCinDecision2('rcAcrAcbForceEnd');
    }
    atSing.othcntEjecterrChk = 0;
    AcbInfo.forceEndFlg = 0;
    return errNo;
  }

  ///  関連tprxソース: rckyccin.c - rcAcrAcb_ForceEnd_ChangeOut
  static Future<int> rcAcrAcbForceEndChangeOut() async {
    AcMem cMem = SystemFunc.readAcMem();

    String log = '';
    int errNo = 0;
    int errNoFinish = 0;
    int errNoRead = 0;
    int errNoOut = 0;
    RxCommonBuf cBuf = SystemFunc.readRxCommonBuf();

    if (AcbInfo.autoDecisionFlg == 1) {
      AcbInfo.autoDecisionFlg = 0;
    }
    RcAcracb.rcGtkTimerRemoveAcb();
    if (AcbInfo.stepCnt != 0) {
      if ((!await RcSysChk.rcSGChkSelfGateSystem()) &&
          (!await RcSysChk.rcQCChkQcashierSystem())) {
        await RcExt.rcCinReadGetWait('rcAcrAcbForceEndChangeOut');
      }
    }
    errNoFinish = await rcAcrAcbCinFinish();
    if (cMem.acbData.keyChgcinFlg == '1') {
      /* 釣機入金(補充処理)？ */
      if (cBuf.iniMacInfo.acx_flg.acr50_ssw14_7 == 1) {
        RcAcracb.rcAcbSsw14Set(0);
      }
    }
    errNoRead = await RcAcracb.rcAcrAcbCinReadDtl();
    rcAcbPriceDataSet();

    if ((errNoRead == 0) && (cMem.acbData.totalPrice != 0)) {
      errNoOut = await RcAcracb.rcAcrAcbChangeOut(cMem.acbData.totalPrice);
      if (errNoOut == 0) {
        errNoOut = await RcAcracb.rcPrgAcrAcbResultGet();
      }
    }

    if (RcFncChk.rcCheckChgCinMode()) {
      await rcChgCinScrModeReset();
      await rcChgCinDispDestroy();
    } else if (await RcFncChk.rcCheckChgLoanMode()) {
      Rcinoutdsp.rcForceExitChgCinLoan();
    } else if (await RcFncChk.rcCheckChgPtnCoopMode()) {
      //QC仕様ではないとき録画を停止,強制終了押下時
      if (await RcSysChk.rcQCChkQcashierSystem() == false) {
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
      }
      RcKyCptn.rcChgPtnQuitMainCoop();
    } else if (AcbInfo.forceEndAft != null) {
      AcbInfo.forceEndAft;
    }

    // 最終的な戻り値を他の処理でerrorNoがセットされていなければセット
    // コマンドに対するerr優先度は特に考慮していないので、何かあれば検討が必要かもしれません
    if (errNo == 0) {
      if (errNoOut != 0) {
        errNo = errNoOut;
      } else if (errNoRead != 0) {
        errNo = errNoRead;
      } else if (errNoFinish != 0) {
        errNo = errNoFinish;
      }
    }
    // 戻り値と釣銭機のコマンド毎のエラーをログ出力
    if ((errNo != 0) ||
        (errNoFinish != 0) ||
        (errNoRead != 0) ||
        (errNoOut != 0)) {
      log =
          "rcAcrAcbForceEndChangeOut() finish($errNoFinish) read($errNoRead) out($errNoOut) -> errNo($errNo)\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rckyccin.c - rcCheck_AcbChange_Over_errno
  static int rcCheckAcbChangeOverErrno(int errNo) {
    if ((errNo == DlgConfirmMsgKind.MSG_MAX_CHANGEAMT_OVER.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_OVERCHANGE.dlgId)) {
      return 1;
    }
    return 0;
  }

  ///  関連tprxソース: rckyccin.c - rcAcrAcb_CcinShtSet
  static void rcAcrAcbCcinShtSet(CBillKind ccinSht) {
    //枚数=退避データ（停止->開始の度に）+現在の入金データ
    ccinSht.bill10000 = AcbInfo.reindata.bill10000 + AcbInfo.cindata.bill10000;
    ccinSht.bill5000 = AcbInfo.reindata.bill5000 + AcbInfo.cindata.bill5000;
    ccinSht.bill2000 = AcbInfo.reindata.bill2000 + AcbInfo.cindata.bill2000;
    ccinSht.bill1000 = AcbInfo.reindata.bill1000 + AcbInfo.cindata.bill1000;
    ccinSht.coin500 = AcbInfo.reindata.coin500 + AcbInfo.cindata.coin500;
    ccinSht.coin100 = AcbInfo.reindata.coin100 + AcbInfo.cindata.coin100;
    ccinSht.coin50 = AcbInfo.reindata.coin50 + AcbInfo.cindata.coin50;
    ccinSht.coin10 = AcbInfo.reindata.coin10 + AcbInfo.cindata.coin10;
    ccinSht.coin5 = AcbInfo.reindata.coin5 + AcbInfo.cindata.coin5;
    ccinSht.coin1 = AcbInfo.reindata.coin1 + AcbInfo.cindata.coin1;
  }

  ///  関連tprxソース: rckyccin.c - rcAcbPriceData_Set
  /// TODO:00010 長田 定義のみ追加
  static void rcAcbPriceDataSet() {
    return;
  }

  ///  関連tprxソース: rckyccin.c - rcChgCin_ScrMode_Reset
  static Future<void> rcChgCinScrModeReset() async {
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCinMode_Reset");
    RcSet.rcReMovScrMode();
  }

  ///  関連tprxソース: rckyccin.c - rcChgCin_Disp_Destroy
  static Future<void> rcChgCinDispDestroy() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        destFnc();
        break;
      case RcRegs.KY_SINGLE:
        destFnc();
        break;
    }
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CHGPOST.keyId])) {
      RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_CHGPOST.keyId);
    }
    if (RcRegs.kyStC3(cMem.keyStat[FuncKey.KY_CHGPOST.keyId])) {
      RcRegs.kyStR3(cMem.keyStat, FuncKey.KY_CHGPOST.keyId);
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
          (await RcFncChk.rcCheckStlMode())) {
        RcItmDsp.rcDualConfDestroy();
        RcItmDsp.rcDualhalfDefault();
      }
    }
  }

  ///  関連tprxソース: rckyccin.c - destFnc
  /// TODO:00010 長田 定義のみ追加
  static void destFnc() {
    // if (AcbDspInfo.win_ccin != NULL) {
    //   gtk_widget_destroy(AcbDspInfo.win_ccin);
    //   AcbDspInfo.win_ccin = NULL;
    //   rc28MainWindow_SizeChange(0);
    // }
    // if (subinit_Main_single_Special_Chk() == TRUE) {
    //   if (AcbDualInfo.win_ccin != NULL) {
    //     gtk_widget_destroy(AcbDualInfo.win_ccin);
    //     AcbDualInfo.win_ccin = NULL;
    //     rc28MainWindow_SizeChange(0);
    //   }
    // }
  }

  ///  関連tprxソース: rckyccin.c - rcDisp_Key_ChgCin
  /// TODO:00010 長田 定義のみ追加
  static int rcDispKeyChgCin() {
    return 0;
  }

  ///  関連tprxソース: rckyccin.c - rcChgCin_ScrMode_Set
  static Future<void> rcChgCinScrModeSet() async {
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCinMode_Set");
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_CHECKER:
        RcSet.rcChgCinScrMode();
        break;
      case RcRegs.KY_SINGLE:
        RcSet.rcChgCinScrMode();
        break;
    }
  }

  /// 関連tprxソース: rckyccin.c - Ccin_Dialog
  static Future<int> ccinDialog(int erCode) async {
    tprDlgParam_t param = tprDlgParam_t();
    AtSingl atSing = SystemFunc.readAtSingl();

    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "Acb Ccin_Dialog");

    AcbInfo.ccinDialog = 1;
    atSing.acbActFinalFlg = 0;
    AcbInfo.autoDecClrcnt = 0;
    erCode = DlgConfirmMsgKind.MSG_TEXT194.dlgId;

    if (await RcFncChk.rcCheckCashRecycleMode()) {
      RcCashRecycle.rcCashRecycleForceEndAplDlg();
    } else {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_CHECKER:
        case RcRegs.KY_DUALCSHR:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            if (await RcSysChk.rcChkDesktopCashier()) {
              await RcSet.cashNoticeSet(erCode);
            }
          }
          param.erCode = erCode;
          param.dialogPtn = DlgPattern.TPRDLG_PT20.dlgPtnId;
          MsgDialog.show(MsgDialog.twoButtonMsg(
            message: '',
            type: MsgDialogType.info,
            leftBtnFnc: () {
              RcKyccin.chkdlg2Clicked();
            },
            leftBtnTxt: RcKyccin.CCIN_ERR_RESET,
            rightBtnFnc: () {
              RcKyccin.chkdlg1Clicked();
            },
            rightBtnTxt: RcKyccin.CCIN_END,
          ));
          break;
        case RcRegs.KY_SINGLE:
          if (FbInit.subinitMainSingleSpecialChk()) {
            param.erCode = erCode;
            param.dialogPtn = DlgPattern.TPRDLG_PT20.dlgPtnId;
            MsgDialog.show(MsgDialog.twoButtonMsg(
              message: '',
              type: MsgDialogType.info,
              leftBtnFnc: () {
                RcKyccin.chkdlg2Clicked();
              },
              leftBtnTxt: RcKyccin.CCIN_ERR_RESET,
              rightBtnFnc: () {
                RcKyccin.chkdlg1Clicked();
              },
              rightBtnTxt: RcKyccin.CCIN_END,
            ));
          }
          break;
      }
    }
    RcSet.rcErrStatSet2("ccinDialog");
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin.c - rcPrc_Key_ChgCin_Disp
  static void rcPrcKeyChgCinDisp() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin.c - rcCheck_AcbCnange_Over
  static int rcCheckAcbCnangeOver(KopttranBuff koptTran) {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin.c - rcCheck_Ky_ChgCin
  static int rcCheckKyChgCin() {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckyccin.c - rcChk_KyChgCin_Dec
  static int rcChkKyChgCinDec() {
    return 0;
  }

  /// 関連tprxソース: rckyccin.c - rcKyChgCin
  static Future<void> rcKyChgCin() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
        (RcFncChk.rcSGCheckMntMode())) {
      Rcinoutdsp.rcSGKeyImageTextMake(FuncKey.KY_CHGCIN.keyId);
      if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        RcExt.rcErr("rcKyChgCin", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        return;
      }
    }
    if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId])) {
      return;
    }

    if ((cBuf.dbTrm.ticketOpeWithoutQs != 0) &&
        (!await RcSysChk.rcCheckIndividChange())) {
      if (((RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) ||
              (RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId]))) &&
          (!RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) &&
          (!RcRegs.kyStC3(cMem.keyStat[FuncKey.KY_CHGPOST.keyId]))) {
        RcExt.rcErr("rcKyChgCin", DlgConfirmMsgKind.MSG_BEFORSCNPLU.dlgId);
        return;
      }
    }
    await RckyccinAcb.rcKyAcbCin();
  }

  /// 関連tprxソース: rckyccin.c - rcChgCinDsp_Entry
  static void rcChgCinDspEntry() {
    RckyccinAcb.rcAcbCinDspEntry();
  }

  /// 関連tprxソース: rckyccin.c - rcChgCin_DispError_Sst
  static Future<int> rcChgCinDispErrorSst(int erCode) async {
    int errNo = await RckyccinAcb.rcSstDetailErrGet();
    int ret = Typ.OK;
    if (errNo == Typ.OK) {
      if (AplLib.acxErrData.errCode != "000000000000") {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcSstDetailErrGet() retry");
        await Future.delayed(const Duration(microseconds: 500000));
        errNo = await RckyccinAcb.rcSstDetailErrGet();
        if (errNo == Typ.OK) {
          if (AplLib.acxErrData.errCode != "000000000000") {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "AplLib.acxErrData.errCode = 0 in CcinErrDialog");
            rcSstErrFinish(erCode);
            return erCode;
          }
        } else {
          rcSstErrFinish(errNo);
          return errNo;
        }
      }

      ret = await RckyccinAcb.rcChkChgCinErrRecover();
      if (ret != 0) {
        RckyccinAcb.rcChgCinDispErrorRecover();
        rcChgCinDispErrorRecoverBz();
        rcSstErrFinish(erCode);
        return -1;
      } else {
        rcSstErrFinish(erCode);
        return erCode;
      }
    } else {
      rcSstErrFinish(errNo);
      return errNo;
    }
  }

  /// 関連tprxソース: rckyccin.c - rcSst_ErrFinish
  static Future<void> rcSstErrFinish(int errNo) async {
    int acbSelect = AcxCom.ifAcbSelect();
    AcMem cMem = SystemFunc.readAcMem();

    if (((acbSelect & CoinChanger.SST1) != 0) ||
        ((acbSelect & CoinChanger.FAL2) != 0)) {
      if (AcbInfo.errRestartFlg == 1) {
        return;
      }
      if (((acbSelect & CoinChanger.FAL2) != 0) &&
          (RcAcracb.rcChkAcrAcbRjctErr(errNo))) {
        return;
      }
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.normal, "Sst_ErrFinish");
      cMem.ent.errNo = await RcKyccin.rcAcrAcbCinFinish();
      if (await RcSysChk.rcChkAutoDecisionSystem() ||
          await RcSysChk.rcSGChkSelfGateSystem() ||
          await RcSysChk.rcQCChkQcashierSystem()) {
        AcbInfo.errRestartFlg = 1;
      }
    }
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rckyccin.c - rcChgCin_DispErrorRecoverBz
  static void rcChgCinDispErrorRecoverBz() {}

  /// 対面セルフの預り額表示<カラー客表>を０円へ更新する
  /// 関連tprxソース: rckyccin.c - rckyccin_fself_cinamt_draw
  static Future<void> rckyccinFselfCinamtDraw() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (await RcFncChk.rcCheckItmMode()) {
      if (cMem.acbData.totalPrice == 0) {
        if (CompileFlag.COLORFIP && Rc28StlInfo.colorFipChk() == 1) {
          RcfSelf.rcFselfStltendCreate(null, 1, null, 0, 0);
        }
        Rc28dsp.rcTabDataDisplay(RckyTab.tabInfo.dspTab);
      }
    }
  }
}
