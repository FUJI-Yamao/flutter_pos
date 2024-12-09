/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/regs/checker/rc_qc_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/sio_chk.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_ewdsp.dart';
import 'rc_ext.dart';
import 'rcfncchk.dart';
import 'rcqc_com.dart';
import 'rcsyschk.dart';

class RcMasr {
  /// 関連tprxソース:rc_masr.c - masrInfo
  static MasrStat masrInfo = MasrStat();
  static int masrChkTimer = -1;
  static int retry = 0;
  static int regsEnd = 0;

  /// タイマー終了処理
  /// 関連tprxソース:rc_masr.c - rc_Masr_GtkTimerRemove()
  static void rcMasrGtkTimerRemove() {
    if (masrChkTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(masrChkTimer);
      masrChkTimer = -1;
    }
  }

  /// タイマー開始処理
  /// 引数:[timer] タイマー(ms)
  /// 引数:[func] 実行関数名
  /// 関連tprxソース:rc_masr.c - rc_Masr_GtkTimerAdd()
  static void rcMasrGtkTimerAdd(int timer, Function func) {
    if (masrChkTimer == -1) {
      masrChkTimer = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
    }
  }

  /// リーダの起動、終了
  /// 引数:[order] READ START=Enable   CNCL_START=Disable
  /// 引数:[chkFlg] 1=リーダ起動完了待ちする　 0=しない
  /// 戻り値: 1=正常終了  0=異常終了
  /// 関連tprxソース:rc_masr.c -	rcSet_Masr_Order()
  static Future<int> rcSetMasrOrder(MasrOrderCk order, int chkFlg) async {
    if (!RcFncChk.rcCheckMasrSystem()) {
      return 0;
    }
    rcMasrGtkTimerRemove();

    int ret = 1;
    int	wait = 3000;     /* timeout = 3s */
    MasrOrderCk stat = MasrOrderCk.MASR_NONE;
    masrInfo.order = MasrOrderCk.MASR_NONE;

    if (!(await rcCheckMasrNormalMode())) {
      masrInfo.errNo = 0;
    }
    switch (order) {
      case MasrOrderCk.READ_START:
        if (await ifMasrOrderStart(
            await RcSysChk.getTid(), MasrOrder.ORDER_READ_START) == Typ.NG) {
          ret = 0;
          break;
        }
        break;
      case MasrOrderCk.CNCL_START:
        if (await ifMasrOrderStart(
            await RcSysChk.getTid(), MasrOrder.ORDER_CNCL_START) == Typ.NG) {
          ret = 0;
          break;
        }
        break;
      default:
        ret = 0;
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RcMasr.rcSetMasrOrder(): Order Error[$order]");
        break;
    }

    if ((chkFlg != 0) && (ret != 0)) {
      while (wait > 0) {
        sleep(const Duration(microseconds: RcRegs.WARN_EVENT)); // usleep(RcRegs.WARN_EVENT);
        stat = await rcGetMasrInfo();
        if (order == MasrOrderCk.READ_START) {
          if (stat != MasrOrderCk.READ_START) {
            if ((stat != MasrOrderCk.READ_WAITING) && (stat != MasrOrderCk.READ_END)) {
              ret = 0;
            }
            break;
          }
        } else if (order == MasrOrderCk.CNCL_START) {
          if (stat != MasrOrderCk.CNCL_START) {
            if (stat == MasrOrderCk.MASR_ERR) {
              ret = 0;
            }
            break;
          }
        }
        wait--;
      }
      if (wait <= 0) {
        ret = 0;
        if ((order == MasrOrderCk.READ_START) && (stat != MasrOrderCk.MASR_ERR)) {
          await ifMasrOrderStart(
              await RcSysChk.getTid(), MasrOrder.ORDER_CNCL_START);
        }
      }
    }

    if (ret != 0) {
      masrInfo.order = order;
    } else {
      masrInfo.end = 1;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcMasr.rcSetMasrOrder(): Order Set[$order] Error");
    }

    return(ret);
  }

  /// 通常モードの判断
  /// 戻り値: true=通常モード  false=通常モードでない
  /// 関連tprxソース:rc_masr.c - rcCheck_Masr_NormalMode()
  static Future<bool> rcCheckMasrNormalMode() async {
    if (!RcFncChk.rcCheckMasrSystem()) {
      return false;
    }
    if ((await RcSysChk.rcQCChkQcashierSystem()) ||
        (await RcSysChk.rcSGChkSelfGateSystem())) {
      return false;
    }
    return true;
  }

  /// 関連tprxソース:rc_masr.c - if_masr_order_start()
  static Future<int> ifMasrOrderStart(TprTID tid, MasrOrder order) async {
    if ((CmCksys.cmMasrSystem() == 0) ||
        (SioChk.sioCheck(Sio.SIO_MASR) == Typ.NO)) {
      return Typ.NG;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcMasr.ifMasrOrderStart(): rxMemPtr error");
      return Typ.NG;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (tsBuf.masr.order == 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcMasr.ifMasrOrderStart(): MASR Task Not Ready!");
      return Typ.NG;
    }

    switch (order) {
      case MasrOrder.ORDER_READ_START:
        if ((tsBuf.masr.order != MasrOrder.ORDER_READ_START.index) &&
            (tsBuf.masr.order != MasrOrder.ORDER_READ_WAITING.index)) {
          tsBuf.masr.order = order.index;
        }
        break;
      case MasrOrder.ORDER_CNCL_START:
        if ((tsBuf.masr.order != MasrOrder.ORDER_CNCL_START.index) &&
            (tsBuf.masr.order != MasrOrder.ORDER_CNCL_END.index) &&
            (tsBuf.masr.order != MasrOrder.ORDER_NOT_ORDER.index)) {
          tsBuf.masr.order = order.index;
        }
        break;
      default:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RcMasr.ifMasrOrderStart(): order error[$order]");
        return Typ.NG;
    }

    return Typ.OK;
  }

  /// リーダの状態取得
  /// 戻り値:リーダの状態
  /// 関連tprxソース:rc_masr.c - rc_Get_Masr_Info()
  static Future<MasrOrderCk> rcGetMasrInfo() async {
    MasrOrderCk stat = MasrOrderCk.MASR_NONE;

    if (!RcFncChk.rcCheckMasrSystem()) {
      return MasrOrderCk.MASR_NONE;
    }

    if (!(await rcCheckMasrNormalMode())) {
      masrInfo.errNo = 0;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return MasrOrderCk.MASR_NONE;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    switch (tsBuf.masr.order) {
      case 2:  //MasrOrder.ORDER_READ_START.index
        stat = MasrOrderCk.READ_START;
        break;
      case 3:  //MasrOrder.ORDER_READ_WAITING.index
        stat = MasrOrderCk.READ_WAITING;
        break;
      case 4:  //MasrOrder.ORDER_READ_END.index
        stat = MasrOrderCk.READ_END;
        break;
      case 5:  //MasrOrder.ORDER_CNCL_START.index
        stat = MasrOrderCk.CNCL_START;
        break;
      case 6:  //MasrOrder.ORDER_CNCL_END.index
        stat = MasrOrderCk.CNCL_END;
        break;
      case 8:  //MasrOrder.ORDER_RETREEP_END.index
        stat = MasrOrderCk.RETREEP_END;
        break;
      case 1:  //MasrOrder.ORDER_NOT_ORDER.index
        stat = MasrOrderCk.MASR_IDOL;
        break;
      default:
        stat = MasrOrderCk.MASR_ERR;
        break;
    }
    switch (tsBuf.masr.cardStat) {
      case 1:  //MasrRes.MASR_RES_CARD_NONE.value
        masrInfo.cardStat = MasrCardStat.CARD_NONE;
        break;
      case 2:  //MasrRes.MASR_RES_CARD_GATE.value
        masrInfo.cardStat = MasrCardStat.GATE_IN;
        break;
      case 3:  //MasrRes.MASR_RES_CARD_IN.value
        masrInfo.cardStat = MasrCardStat.CARD_IN;
        break;
      default:
        break;
    }

    if (await rcCheckMasrNormalMode()) {
      if (await rcMasrNoCallErrChk(tsBuf.masr.errCd) != 0) {
        tsBuf.masr.errCd = 0;
        masrInfo.errNo = 0;
      } else if (masrInfo.order == MasrOrderCk.READ_START) {
        if (stat != MasrOrderCk.READ_START) {
          masrInfo.errNo = tsBuf.masr.errCd;
        }
       } else {
        masrInfo.errNo = tsBuf.masr.errCd;
      }
    } else {
      masrInfo.errNo = tsBuf.masr.errCd;
    }
    if ((stat == MasrOrderCk.MASR_ERR) && (masrInfo.errNo == 0)) {
      masrInfo.errNo = DlgConfirmMsgKind.MSG_MASR_ERR.dlgId;
    }

    return stat;
  }

  /// QCashier店員コールしないエラーかチェックする
  /// 引数: エラー番号
  /// 戻り値: 1=上記エラー  1以外=上記エラーでない
  /// 関連tprxソース:rc_masr.c - rc_Masr_NoCall_ErrChk()
  static Future<int> rcMasrNoCallErrChk(int errNo) async {
    if (!RcFncChk.rcCheckMasrSystem()) {
      return 0;
    }
    if (!(await RcSysChk.rcQCChkQcashierSystem())
        && !(await rcCheckMasrNormalMode())
        && !RcFncChk.rcQCCheckEMnyPrecaEndMode()) {
      return 0;
    }

    if (errNo == DlgConfirmMsgKind.MSG_MASR_CARDRETRY.dlgId)	{
      if ((await RcSysChk.rcQCChkQcashierSystem()) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT)) {
        /* カスミQCashierの場合は店員コールする */
        return 0;
      } else {
        return 1;
      }
    }
    if ((errNo == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_MASR_CARD_ERR.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_MASR_CARDCONF.dlgId)) {
      return 2;
    }

    return 0;
  }

  /// エラーまたは終了監視
  /// 関連tprxソース:rc_masr.c - rc_Masr_Chk
  static Future<void> rcMasrChk() async {
    rcMasrGtkTimerRemove();

    if (!RcFncChk.rcCheckMasrSystem() || (regsEnd == 1)) {
      return;
    }
    if (!(await rcCheckMasrNormalMode())) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMasr.rcMasrChk(): Start");
    }
    
    if ((masrInfo.order != MasrOrderCk.READ_START) && (masrInfo.order != MasrOrderCk.CNCL_START)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcMasrChk(): Order Error[${masrInfo.order}]");
      return;
    }

    if (masrInfo.end != 0){
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcMasrChk(): Chk End!");
      return;
    }

    if ((await RcSysChk.rcChk2800System())
        && (await RcSysChk.rcNewSGChkNewSelfGateSystem())
        && (!(await RcSysChk.rcChkHappySelfMasrSystem())) ) {
      /* Speeza-J */
      if (TprLibDlg.tprLibDlgCheck2(1) != 0) {
        rcMasrGtkTimerAdd(RcRegs.WARN_EVENT, rcMasrChk);
        return;
      }
    }
    else if (await rcCheckMasrQCReturn()) {
      rcMasrGtkTimerAdd(RcRegs.WARN_EVENT, rcMasrChk);
      return;
    }

    if (await RcSysChk.rcChkHappySelfMasrCtrl()) {
      //保険の処理
      if ((await rcCheckMasrNormalMode()) &&
          (!((await RcFncChk.rcCheckCatCardReadMode() || (await RcFncChk.rcCheckPrecaVoidMode()))))) {
        await rcCheckMasrNormalSet("RcMasr.rcMasrChk()", MasrOrderCk.CNCL_START);
        return;
      }
    }

    MasrOrderCk stat = await rcGetMasrInfo();
    int card = masrInfo.cardStat.index;
    int order = masrInfo.order.index;
    int err = 0;
    bool end = false;

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMasr.rcMasrChk(): stat[${stat.index}] card[$card] order[${masrInfo.order}]");
    switch (order) {
      case 3:  //MasrOrderCk.READ_START.index
        if ((stat == MasrOrderCk.READ_END) || (stat == MasrOrderCk.MASR_ERR)) {
          if (masrInfo.errNo != 0){
            err = masrInfo.errNo;
          }
        }
        break;
      case 6:  //MasrOrderCk.CNCL_START.index
        if (await rcCheckMasrNormalMode()) {
          end = true;	/* 通常モードは状態チェック行わないが、念の為追加 */
        }
        else if (stat == MasrOrderCk.MASR_IDOL) {
          end = true;
        }
        else if (stat == MasrOrderCk.MASR_ERR) {
          if (card == MasrCardStat.CARD_NONE.index) {
            end = true;
          } else {
            err = DlgConfirmMsgKind.MSG_MASR_CARD_ERR.dlgId;
          }
        }
        else if (stat == MasrOrderCk.CNCL_END) {
          if (card == MasrCardStat.CARD_NONE.index) {
            end = true;
          } else {
            if ((await RcSysChk.rcChk2800System())
                && (await RcSysChk.rcNewSGChkNewSelfGateSystem())
                && !(await RcSysChk.rcChkHappySelfMasrSystem())) {
              end = true;   /* Speeza-Jは、エラーにしない */
            } else {
              err = DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId;
            }
          }
        }
        else if ((stat == MasrOrderCk.CNCL_START)
            && (RcFncChk.rcQCCheckPrePaidBalanceShortMode())) {
          // ハウスプリカ残高不足画面では即座にポップアップを表示させるため、タイマー間隔を短くする
          retry = 0;
          rcMasrGtkTimerAdd(RcRegs.WARN_EVENT1, rcMasrChk);
          return;
        }
        break;
      default:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcMasrChk(): MASR Order Error[$order]!");
        return;
    }

    if (end) {
      retry = 0;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMasr.rcMasrChk(): MASR Is OK order[$order] stat[${stat.index}] cardinf[$card] err[${masrInfo.errNo}]!");
      await rcMasrChkEnd();
      masrInfo.end = 1;
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        if ((RcFncChk.rcQCCheckCrdtUseMode() ||
            RcFncChk.rcQCCheckChargeItemSelectScrMode())
            && (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId)) {
          RcEwdsp.rcQCClrKeyProc();
        }
        else if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
          RcEwdsp.rcQCClrKeyProc();
        }
        else if ( (RcFncChk.rcQCCheckPrePaidPayDspMode()
            || RcFncChk.rcQCCheckPrePaidEntryDspMode()
            || RcFncChk.rcQCCheckPrePaidBalanceShortMode()
            || RcFncChk.rcQCCheckEMnyPrecaEndMode())
            && (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) ) {
          RcEwdsp.rcQCClrKeyProc();
        }
      }
      else if ((await RcSysChk.rcChkHappySelfMasrSystem())
          && (RcFncChk.rcSGCheckMbrScnMode() || (await RcFncChk.rcCheckStlMode())) ) {
        if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
          RcEwdsp.rcSGClrKeyProc();
        }
      }
      else if ((await RcSysChk.rcNewSGChkNewSelfGateSystem()) &&
          RcFncChk.rcQCCheckEMnyPrecaEndMode()) {
        if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
          RcEwdsp.rcSGClrKeyProc();
        }
      }
      return;
    }
    if (err == 0) {
      retry = 0;
      rcMasrGtkTimerAdd(RcRegs.WARN_EVENT, rcMasrChk);
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (!(await rcCheckMasrNormalMode())) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcMasrChk(): Masr Error order[$order] stat[${stat.index}] err[$err]");
      tsBuf.masr.ejectFlg = 0;
      if (RcFncChk.rcQCCheckEMnyPrecaDspMode()) {
        // QCashierハウスプリカ残高照会のカード読込画面
        await RcExt.rcErr("RcMasr.rcMasrChk()", err);
      }
    }

    AcMem cMem = SystemFunc.readAcMem();
    int ret = 0;
    if (await rcCheckMasrNormalMode()) {
      await rcSetMasrOrder(MasrOrderCk.READ_START, 0);
      if (retry > 10000) {					/* 30s */
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcMasrChk(): Masr Error Retry");
        retry = 0;
      }
      else {
        retry++;
      }
      rcMasrGtkTimerAdd(RcRegs.WARN_EVENT, rcMasrChk);
    }
    else if (RcFncChk.rcQCCheckCrdtDspMode()
        || RcFncChk.rcQCCheckPrePaidReadDspMode()
        || RcFncChk.rcQCCheckRepicaPntReadDspMode()) {
      if (await rcMasrNoCallErrChk(err) == 0) {
        ret = RcQcDsp.rcQCBackBtnFunc2(1);
        if (ret == 0) {
          masrInfo.end = 1;
        }
        else {  //戻る処理失敗
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcMasrChk(): Return Error");
          rcMasrGtkTimerAdd(RcRegs.WARN_EVENT, rcMasrChk);
          return;
        }
        TprMacro.usleep(RcQcDsp.QC_MOVIE_WAIT);  //sound stop－＞startの指示が早すぎるとstopできない現象を回避する為
      }
      else {
        await rcMasrChkEnd();
      }
      await RcExt.rcErr("RcMasr.rcMasrChk()", err);
    }
    else if (RcFncChk.rcQCCheckCrdtUseMode()
        || RcFncChk.rcQCCheckPrePaidPayDspMode()
        || RcFncChk.rcQCCheckPrePaidEntryDspMode()
        || RcFncChk.rcQCCheckPrePaidBalanceShortMode()
        || RcFncChk.rcQCCheckEMnyPrecaEndMode() ) {
      if (err == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
        if (TprLibDlg.tprLibDlgCheck2(1) == 0) {
          await RcExt.rcErr("RcMasr.rcMasrChk()", err);
        }
        rcMasrGtkTimerAdd(RcRegs.WARN_EVENT1, rcMasrChk);
        return;
      }
      else {
        await rcMasrChkEnd();
        masrInfo.end = 1;
       if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
         RcEwdsp.rcQCClrKeyProc();
       }
        await RcExt.rcErr("RcMasr.rcMasrChk()", err);
      }
    }
    else if ( (await RcSysChk.rcChkHappySelfMasrSystem())
        && (RcFncChk.rcSGCheckMbrScnMode() ||
            (await RcFncChk.rcCheckStlMode()) ||
            (await RcFncChk.rcChkQcashierMemberReadEntryMode())) ) {
      if (err == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
        if (TprLibDlg.tprLibDlgCheck2(1) == 0) {
          await RcExt.rcErr("RcMasr.rcMasrChk()", err);
        }
        rcMasrGtkTimerAdd(RcRegs.WARN_EVENT1, rcMasrChk);
        return;
      }
      else {
        await rcMasrChkEnd();
        masrInfo.end = 1;
        if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
          RcEwdsp.rcSGClrKeyProc();
        }
        if (err == DlgConfirmMsgKind.MSG_MASR_OFFLINE.dlgId) {
          /* リーダーオフラインの場合は店員呼出する */
          RcSgDsp.selfMem.Staff_Call = 1;
        }
        await RcExt.rcErr("RcMasr.rcMasrChk()", err);
      }
    }
    else if ((await RcSysChk.rcChk2800System())
        && (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {    /* Speeza-J */
      if (TprLibDlg.tprLibDlgCheck2(1) != 0) {  /* 念の為、ここでもチェックする */
        rcMasrGtkTimerAdd(RcRegs.WARN_EVENT, rcMasrChk);
        return;
      }
      else {
        if (!CompileFlag.MC_SYSTEM) {
          if ((await CmCksys.cmNttaspSystem() == 0) &&
              (await CmCksys.cmCapsCafisSystem() == 0) &&
              (await CmCksys.cmCapsPqvicSystem() == 0) &&
              (await CmCksys.cmCAPSCAFISStandardSystem() == 0)) {
            if ((await CmCksys.cmCrdtSystem() != 0)
                && (RcSysChk.rcCheckCrdtStat())) {
              /* 自走式磁気リーダーのエラーは、カード問い合わせエラーとして扱う【CardCrew】 */
              cMem.working.crdtReg.stat |= 0x0200;
            }
          }
        }
        await rcMasrChkEnd();
        masrInfo.end = 1;
        await RcExt.rcErr("RcMasr.rcMasrChk()", err);
      }
    }
    else if (RcFncChk.rcQCCheckAnyCustCardReadDspMode()) {
      await rcMasrChkEnd();
      masrInfo.end = 1;
      await RcExt.rcErr("RcMasr.rcMasrChk()", err);
    }
    else if (RcFncChk.rcQCCheckChargeItemSelectScrMode()) {
      if (err == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
        if ((TprLibDlg.tprLibDlgCheck2(1) == 0) &&
            (RcQcDsp.qc_charge_item_dsp_flg == 0)) {
          await RcExt.rcErr("RcMasr.rcMasrChk()", err);
        }
        rcMasrGtkTimerAdd(RcRegs.WARN_EVENT1, rcMasrChk);
        return;
      }
      else {
        await rcMasrChkEnd();
        masrInfo.end = 1;
        if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId) {
          RcEwdsp.rcQCClrKeyProc();
        }
        await RcExt.rcErr("RcMasr.rcMasrChk()", err);
      }
    }
    else {
      await rcMasrChkEnd();
      masrInfo.end = 1;
    }
  }

  /// 関連tprxソース:rc_masr.c - rcCheck_masr_QC_return
  static Future<bool> rcCheckMasrQCReturn() async {
    if (!(await RcSysChk.rcQCChkQcashierSystem())) {
      return false;
    }

    if ((RcQcCom.qc_err_2nderr != 0) || (RcQcCom.qc_err_3nderr != 0)) {
      return true;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.dspEventMode == 100) {
      return true;
    }

    if ((TprLibDlg.tprLibDlgCheck2(1) != 0)
        && !( (RcFncChk.rcQCCheckCrdtUseMode()
              || RcFncChk.rcQCCheckPrePaidPayDspMode()
              || RcFncChk.rcQCCheckPrePaidEntryDspMode()
              || RcFncChk.rcQCCheckPrePaidBalanceShortMode()
              || RcFncChk.rcQCCheckChargeItemSelectScrMode()
              || RcFncChk.rcQCCheckEMnyPrecaEndMode())
            && (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId)) ) {
      return true;
    }

    if (RcFncChk.rcQCCheckCrdtDspMode() &&
        ((cMem.working.crdtReg.jis1flg == 1) || (cMem.working.crdtReg.jis2flg == 1))) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcCheckMasrQCReturn(): Crdt is Dealing");
      return true;
    }

    if ((RcQcDsp.qcCallDsp.qcCallDsp != 0) || (RcQcDsp.qcPayInfo.exeFlg != 0)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcCheckMasrQCReturn(): return qc_call_dsp[${RcQcDsp.qcCallDsp.qcCallDsp}] exe_flg[${RcQcDsp.qcPayInfo.exeFlg}]");
      return true;
    }

    return false;
  }

  /// 状態チェック、disableセット
  /// 関連tprxソース:rc_masr.c - rc_Masr_Chk_End()
  static Future<void> rcMasrChkEnd() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (!RcFncChk.rcCheckMasrSystem()) {
      rcMasrGtkTimerRemove();
      return ;
    }
    if (tsBuf.masr.ejectFlg == 3) {
      //リトリープ中
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMasr.rcMasrChkEnd(): Now RETREEP");
      rcMasrGtkTimerRemove();
      return;
    } else if ((tsBuf.masr.ejectFlg == 1) &&
        (masrInfo.cardStat != MasrCardStat.CARD_NONE)) {
      //カードリード中
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMasr.rcMasrChkEnd(): Now Card Read");
      return;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMasr.rcMasrChkEnd(): Start");
    if ((await RcSysChk.rcChk2800System()) &&
        (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {    /* Speeza-J */
      if (masrInfo.end == 0) {
        await rcSetMasrOrder(MasrOrderCk.CNCL_START, 0);
      }
      rcMasrGtkTimerRemove();
    } else {
      if (masrInfo.end == 0) {
        await rcSetMasrOrder(MasrOrderCk.CNCL_START, 0);
      }
      rcMasrGtkTimerRemove();
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMasr.rcMasrChkEnd(): End");
  }

  /// 通常モード磁気リーダを起動、停止する
  /// 引数:[callFunc] 呼出元ファンクション名
  /// 引数:[actTyp] MasrOrderCkクラス
  /// 関連tprxソース:rc_masr.c - rcCheck_Masr_NormalSet, rcCheck_Masr_NormalSet2
  static Future<void> rcCheckMasrNormalSet(String callFunc, MasrOrderCk actTyp) async {
    if (await rcCheckMasrNormalMode()) {
      String logMsg = "";
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.KY_CHECKER:
          if (!(await RcSysChk.rcCheckQCJCSystem())) {
            return;
          }
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_DUALCSHR:
        case RcRegs.KY_SINGLE:
          if (actTyp == MasrOrderCk.READ_START) {
            logMsg = "Masr Start !!($callFunc)";
          }
          else if (actTyp == MasrOrderCk.CNCL_START) {
            logMsg = "Masr Stop !!($callFunc)";
          }
          else {
            logMsg = "Masr Order Error[${actTyp.index}] !!($callFunc)";
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMasr.rcCheckMasrNormalSet(): $logMsg");
            return;
          }
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMasr.rcCheckMasrNormalSet(): $logMsg");
          await rcMasrActCtrl(actTyp);
          break;
        default:
          return;
      }
    }
  }

  /// Enableセット【Speeza-J用】
  /// 引数: 開始(READ_START) or 終了(CNCL_START)
  /// 関連tprxソース:rc_masr.c - rc_Masr_ActCtrl
  static Future<void> rcMasrActCtrl(MasrOrderCk actTyp) async {
    if (!RcFncChk.rcCheckMasrSystem()) {
      return;
    }

    if (actTyp == MasrOrderCk.READ_START) {
      rcSetMasrInfoClr();
    }
    if (masrInfo.end != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMasr.rcMasrActCtrl(): Masr Stop !!");
      await rcMasrChkEnd();
    }
    else {
      int ret = await rcSetMasrOrder(actTyp, 0);
      if (ret != 0) {
        if (actTyp == MasrOrderCk.READ_START) {
          await rcMasrChk();
        }
        else {
          await rcMasrChkEnd();
        }
      }
    }
  }

  /// 関連tprxソース:rc_masr.c - rcSet_MasrInfo_Clr()
	static Future<void> rcSetMasrInfoClr() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcSetMasrInfoClr");

    masrInfo = MasrStat();
  }

  /// 関連tprxソース:rc_masr.c - rc_Masr_Start_Set()
  static Future<void> rcMasrStartSet() async {

    if(!RcFncChk.rcCheckMasrSystem()) {
      return;
    }

    if (await RcSysChk.rcSysChkHappySmile()) {
    } else if ((await CmCksys.rcsyschkPontaSelfSystem()) != 0) {
    } else if ((await RcSysChk.rcChkSmartSelfSystem())		      	/* HappySelf仕様 */
        &&  (! (await RcSysChk.rcSysChkHappySmile()))				      /* HappySelf対面モードでない */
        &&  (! (await RcSysChk.rcChkHappySelfQCashier())) )    {	/* QC切替を行っていない */
    } else {
      if(! (await RcSysChk.rcQCChkQcashierSystem())) {
        return;
      }
    }

    if(masrInfo.end != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rc_Masr_Start_Set : Masr Stop");
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet : Masr Stop");
      await rcMasrChkEnd();
    } else {

      AcMem cMem = SystemFunc.readAcMem();
      int ret = 0;
      if (await RcSysChk.rcSysChkHappySmile()) {
        if (cMem.stat.happySmileScrmode == RcRegs.RG_QC_CRDT) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet<happy_smile> : READ_START");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);
        } else if(await RcFncChk.rcCheckCatCardReadMode()) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet<happy_smile> : READ_START");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);
        } else if (cMem.stat.happySmileScrmode == RcRegs.RG_QC_NEC_EMONEY) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet<happy_smile> : READ_START");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);
        } else {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet<happy_smile> : CNCL_START");
          ret = await rcSetMasrOrder(MasrOrderCk.CNCL_START, 0);
        }

        if (ret != 0) {
          if (cMem.stat.happySmileScrmode == RcRegs.RG_QC_CRDT) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet<happy_smile> : rcMasrChk");
            rcMasrChk();
          } else if(await RcFncChk.rcCheckCatCardReadMode()) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet call rcMasrChk\n");
            rcMasrChk();
          } else if (cMem.stat.happySmileScrmode == RcRegs.RG_QC_NEC_EMONEY) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet call rcMasrChk\n");
            rcMasrChk();
          } else {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet call rcMasrChk_End\n");
            await rcMasrChkEnd();
          }
        }
      } else {
        if ( RcFncChk.rcQCCheckCrdtDspMode() || RcFncChk.rcQCCheckNecEmoneyDspMode()) {
          if (RcQcDsp.qCashierIni.crdtcard_gettimer != 0) {
            RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
            RxTaskStatBuf tsBUF = xRet.object;
            tsBUF.masr.ejectFlg = 1;
          }
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet : READ_START\n");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);

        } else if(RcFncChk.rcQCCheckPrePaidReadDspMode()) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet : READ_START\n");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);

        }
        else if( ((await CmCksys.rcsyschkPontaSelfSystem()) != 0) && (RcFncChk.rcSGCheckMbrScnMode()) ) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet : READ_START\n");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);

        } else if( ((await RcSysChk.rcsyschkHappyselfMasrSystem()) != 0) && (RcFncChk.rcSGCheckMbrScnMode()) ) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet : READ_START\n");
          ret = await rcSetMasrOrder(MasrOrderCk.READ_START, 0);

        } else {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcMasrStartSet : CNCL_START\n"); 
          ret = await rcSetMasrOrder(MasrOrderCk.CNCL_START, 0);

        }

        if(ret != 0) {
          if(    RcFncChk.rcQCCheckCrdtDspMode()
              || RcFncChk.rcQCCheckCrdtUseMode()
              || RcFncChk.rcQCCheckNecEmoneyDspMode()
              || RcFncChk.rcQCCheckNecEmoneyUseMode()
              || RcFncChk.rcQCCheckPrePaidReadDspMode()
              || RcFncChk.rcQCCheckPrePaidPayDspMode()
              || RcFncChk.rcQCCheckPrePaidEntryDspMode()
              || RcFncChk.rcQCCheckPrePaidBalanceShortMode()
              || ( (((await CmCksys.rcsyschkPontaSelfSystem()) != 0)
                ||  ((await RcSysChk.rcsyschkHappyselfMasrSystem()) != 0) )
              && ( RcFncChk.rcSGCheckMbrScnMode() || (await RcFncChk.rcCheckStlMode()))) ) {
            rcMasrChk();

          } else {
            await rcMasrChkEnd();

          }
        }
      }
    }
  }

  /// 関連tprxソース:rc_masr.c - rcCheck_masr_Err
  static Future<int> rcCheckMasrErr() async {
    int errNo;
    String log;

    AcMem cMem = SystemFunc.readAcMem();

    errNo = Typ.FALSE;
    if (await rcCheckMasrNormalMode()) {
      if (!(cMem.stat.masrErrFlg != 0)) {
        /*本取引中エラー表示済 */
        if (masrInfo.errNo != 0) {
          errNo = masrInfo.errNo;
          cMem.stat.masrErrFlg = 1;
          log = "rcCheckMasrErr() : Masr Error[$errNo] !! \n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log,
              errId: -1);
        }
      }
    }
    return (errNo);
  }


  /// 関連tprxソース:rc_masr.c - rcCheck_masr_QC_retrun()
  static Future<int> rcCheckMasrQcRetrun() async {
    if (!(await RcSysChk.rcQCChkQcashierSystem())) {
      return (0);
    }

    if ((RcQcCom.qc_err_2nderr != 0) || (RcQcCom.qc_err_3nderr != 0)) {
      return (1);
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.dspEventMode == 100) {
      return (1);
    }

    if ((TprLibDlg.tprLibDlgCheck() != 0)
        && !((RcFncChk.rcQCCheckCrdtUseMode()
            || RcFncChk.rcQCCheckNecEmoneyUseMode()
            || RcFncChk.rcQCCheckPrePaidPayDspMode()
            || RcFncChk.rcQCCheckPrePaidEntryDspMode()
            || RcFncChk.rcQCCheckPrePaidBalanceShortMode())
            && (TprLibDlg.tprLibDlgNoCheck() ==
                DlgConfirmMsgKind.MSG_TAKE_CARD.dlgId))) {
      return (1);
    }

    if ((RcFncChk.rcQCCheckCrdtDspMode()) &&
        ((cMem.working.crdtReg.jis1flg == 1) ||
            (cMem.working.crdtReg.jis2flg == 1))) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "Crdt is Dealing");
      return (1);
    }

    if ((RcQcDsp.qCCallDsp.qcCallDsp != 0) || (RcQcDsp.qCPayInfo.exeFlg != 0)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "return qc_call_dsp[${RcQcDsp.qCCallDsp.qcCallDsp}] exe_flg[${RcQcDsp.qCPayInfo.exeFlg}]");
      return (1);
    }

    return (0);
  }

  /// 関連tprxソース:rc_ext.h - rcCheck_Masr_NormalSet
  static void c(String fncName, MasrOrderCk actTyp) {
    rcCheckMasrNormalSet2(fncName, actTyp);
  }

  /// 関連tprxソース:rc_masr.c - rcCheck_Masr_NormalSet2
  static Future<void> rcCheckMasrNormalSet2(
      String fncName, MasrOrderCk actTyp) async {
    if (await rcCheckMasrNormalMode()) {

      int kySelf = await RcSysChk.rcKySelf();
      // AcMem cMem = SystemFunc.readAcMem();

      switch (kySelf) {
        case RcRegs.KY_CHECKER:
          if ((!(await RcSysChk.rcChkTwoCnctChecker())) &&
              (!(await RcSysChk.rcCheckQCJCSystem()))) {
            return;
          }

        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_DUALCSHR:
        case RcRegs.KY_SINGLE:
          if (actTyp == MasrOrderCk.READ_START) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "$fncName : Masr Start !!($actTyp)");
          } else if (actTyp == MasrOrderCk.CNCL_START) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "$fncName : Masr Stop !!($actTyp)");
          } else {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                "$fncName : Masr Order Error[$actTyp] !!");
            return;
          }
          rcMasrActCtrl(actTyp);
          break;
        default:
          return;
      }
    }
  }

  /// 関連tprxソース:rc_masr.c - rc_Masr_happysmile_errshow
  static Future<int> rcMasrHappysmileErrshow() async {
    if ((await RcSysChk.rcsyschkHappyselfMasrCtrl()) == 0) {
      return (0);
    }

    AcMem cMem = SystemFunc.readAcMem();
    if ((cMem.stat.happySmileScrmode != RcRegs.RG_QC_CRDT) &&
        (!await RcFncChk.rcCheckCatCardReadMode()) &&
        (cMem.stat.happySmileScrmode != RcRegs.RG_QC_NEC_EMONEY)) {
      return (0);
    }

    if (cMem.working.crdtReg.kasumiInpflg != 0) {
      return (0);
    }

    if ((cMem.working.crdtReg.jis1flg == 1) ||
        (cMem.working.crdtReg.jis2flg == 1)) {
      return (0);
    }

    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    if ((cMem.stat.dspEventMode != 0) || (ifSave.count != 0)) {
      return (0);
    }

    if (cMem.stat.crdtDealFlg) {
      return (0);
    }

    if (masrInfo.order != MasrOrderCk.READ_START) {
      return (0);
    }

    if (cMem.working.crdtReg.step >= KyCrdtInStep.RECEIT_NO.cd) {
      return (0);
    }

    if ((TprLibDlg.tprLibDlgCheck() != 0) &&
        (!await RcFncChk.rcCheckCatCardReadMode())) {
      return (0);
    }

    if ((RcFncChk.rcChkErr() != 0) ||
        (cMem.ent.errNo != 0) ||
        (cMem.ent.warnNo != 0)) {
      return (0);
    }

    return (1);
  }

  // TODO:定義のみ追加
  /// 関連tprxソース:rc_masr.c - rc_Masr_happysmile_err
  static void rcMasrHappysmileErr(int errNo) {}

}

/// 関連tprxソース:rc_masr.c - struct MASR_STAT
class MasrStat {
  MasrOrderCk order = MasrOrderCk.MASR_NONE;
  MasrCardStat cardStat = MasrCardStat.CARD_NONE;
  int errNo = 0;
  int end = 0;
}

/// 関連tprxソース:rc_masr.c - enum MASR_CARD_STAT
enum MasrCardStat {
  CARD_NONE,
  GATE_IN,
  CARD_IN
}

/// 関連tprxソース:rc_masr.h - enum MASR_ORDER
enum MasrOrder {
  ORDER_NOT_ORDER(1),
  ORDER_READ_START(2),
  ORDER_READ_WAITING(3),
  ORDER_READ_END(4),
  ORDER_CNCL_START(5),
  ORDER_CNCL_END(6),
  ORDER_ERR_END(7),
  ORDER_RETREEP_START(8),
  ORDER_RETREEP_END(9);

  final int value;
  const MasrOrder(this.value);
}