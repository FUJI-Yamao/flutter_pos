/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_28dsp.dart';
import 'rc_cogca.dart';
import 'rc_ifevent.dart';
import 'rc_qc_dsp.dart';
import 'rc_repica.dart';
import 'rc_reserv.dart';
import 'rcfncchk.dart';
import 'rcky_cat_cardread.dart';
import 'rcnewsg_dsp.dart';
import 'rcqc_com.dart';
import 'rcsyschk.dart';

class RcQcDsp {
  static int qcSoundOffFlg = 0; // qc_sound_off_flg
  int qcFuncTimer = -1;

  /// 関連tprxソース: rcqc_dsp.c - qc_cash_disp_cnt
  static int qc_cash_disp_cnt = 0;

  /// Constant Values.
  /// 関連tprxソース: rcqc_dsp.h - QC_CASH_CNT_END
  static const int QC_CASH_CNT_END = 99;

  /// 関連tprxソース: rcqc_dsp.c - rcQC_DateTime_Change
  Future<void> rcQCDateTimeChange(int status) async {
    if ((RcRegs.rcInfoMem.rcRecog.recogICCardSystem != 0)
        || (RcSysChk.rcsyschkVescaSystem())
        || (RcSysChk.rcChkPrecaTyp() != 0)
        || (RcSysChk.rcChkQCMultiSuicaSystem() != 0)) {
      if (RcQcCom.qcInqudispCtrl == 1) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "__FUNCTION__ : No action !! because qcInqudispCtrl = [${RcQcCom
                .qcInqudispCtrl}]\n");
        return; // 処理中です画面を表示中なので、表示の更新をしない
      }
    }

    if (RcSysChk.rcChkMultiVegaSystem() != 0) {
      AtSingl atSing = SystemFunc.readAtSingl();
      if (atSing.multiVegaWaitFlg == 2) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "__FUNCTION__ : No action !! because RcRegs.atSing.multiVegaWaitFlg = [${atSing.multiVegaWaitFlg}]\n");
        return; // 処理中です画面を表示中なので、表示の更新をしない
      }
    }

    if (RcSysChk.rcsyschk2800VFHDSystem() != 0) /* 縦型21.5インチ */ {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because vfhd system \n");
      return; // 表示しないので更新をしない
    }

    if ((RcSysChk.rcChkRPointMbrReadTMCQCashier() !=
        0) /* タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ */
        && ((RcFncChk.rcQCCheckRPtsMbrYesNoMode()) /* 精算機での楽天ポイントカード確認画面 */
            || (RcFncChk
                .rcQCCheckRPtsMbrReadMode()))) /* 精算機での楽天ポイントカード読込画面 */ {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because rpoint mbr read TMC QCashier\n");
      return; // 表示しないので更新をしない
    }

    /* タカラ様仕様での精算機またはフルセルフで楽天ポイント利用画面の時動作しない */
    if (((RcSysChk.rcChkRPointMbrReadTMCQCashier() !=
        0) /* タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ */
        || (RcSysChk.rcChkRPointSelfSystem() != 0)) /* 楽天ポイント仕様のフルセルフレジ */
        &&
        (RcFncChk.rcQCCheckRpointPayConfDspMode())) /* 楽天ポイント利用確認画面 */ {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because rpoint pay conf dsp\n");
      return; // 表示しないので更新をしない
    }

    if (await RcSysChk.rcSysChkHappySmile()) {
      if (RxTaskStatBuf().chk.chk_registration == 1) { // 次客登録中
        if (status == 1) { // ャッシャータスクからの更新指示
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "__FUNCTION__ : No action !! because status = [$status]\n");
          return; // キャッシャータスクからの表示の更新をさせない為
        }
      }

      if (RcNewSgDsp.rcCheckClinicMode() != 0) { //クリニックモード
        // C言語のGUI関連処理なので、Dartで実装される新POSでは破棄
        // if((QCCashDsp.greeting_pixmap != NULL)	//あいさつ文言が表示されている場合
        //     || (QCPayDsp.greeting_pixmap != NULL))
        // {
        //   memset(log, 0x0, sizeof(log));
        //   sprintf(log, "%s : No action !! because greeting_pixmap Not NULL\n", __FUNCTION__);
        //   TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
        //   return;	//あいさつ文言に重なってしまうため時刻表示の更新をさせない
      }
    }

    // C言語のGUI関連処理なので、Dartで実装される新POSでは破棄
    // if(RcQcCom.qc_payrfd_msg == 1) {
    //  && (tColorFipItemInfo.payrfd_window != NULL))
    // snprintf(log, sizeof(log), "%s : No action !! because qc_payrfd_msg = [%d]\n", __FUNCTION__, qc_payrfd_msg);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    // return;	// 元取引返金額出金のメッセージ表示中なので、表示の更新をしない
    //}

    if (RcSysChk.rcsyschkTomoIFSystem()) {
      if (await RcSysChk.rcSysChkHappySmile()) {
        AtSingl atSing = SystemFunc.readAtSingl();
        if (atSing.tomonokaiReadingflg != 0) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "__FUNCTION__ : No action !! because RcRegs.atSing.tomonokaiReadingflg ON.n");
          return; // 処理中です画面を表示中なので、表示の更新をしない
        }
      }
    }

    if ((RcFncChk.rcCheckReservMode())
        && (RcReserv.reserv.colorfipPopupChk == 1)
        && (status == 1)) {
      /* 予約中の場合は、描画更新行わない */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because Reserv_Mode\n");
      return;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "__FUNCTION__<happy_smile> : qcFuncTimer[$qcFuncTimer], ScrMode[${AcMem().stat.scrMode}]\n");

    if ((await RcFncChk.rcCheckItmMode())
        || (RcFncChk.rcCheckValueCardMode() || RcFncChk.rcCheckValueCardMIMode())
        || (RcFncChk.rcCheckRepicaMode() && ((RcRepica.repica.fncCode == FuncKey.KY_PRECA_REF.keyId) ||
            RcRepica.rcCheckRepicaDepositItem(1) != 0))
        || (RcFncChk.rcCheckPassportInfoMode() != 0)
        || (Rc28dsp.rc28dspCheckInfoSlct())
        || (RcSysChk.rcChkFIPEmoneyStandardSystem() && RcFncChk.rcCheckAjsEmoneyMode())) {
        if (status == 1) { // 再描画したい為
          await Rc28StlInfo.rcFselfSubttlRedisp();
        }
    }
    else if ((RcCogca.rcCogcaDspFlgChk() != 0)
        || (RcKyCatCardRead.rcCatCardReadDspFlgChk() != 0)
        || (RcFncChk.rcCheckCogcaMode())
        || (RcFncChk.rcCheckRepicaMode() || RcFncChk.rcCheckRepicaTCMode())
        || (await RcFncChk.rcCheckCatCardReadMode())) {
      if ((AcMem().stat.bkScrMode != RcRegs.RG_STL) &&
          (AcMem().stat.bkScrMode != RcRegs.TR_STL)) {
        if (status == 1) { // 再描画したい為
          await Rc28StlInfo.rcFselfSubttlRedisp();
        }
      }
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "QCashier: rcQC_DateTime_Change Start qcFuncTimer[$qcFuncTimer], ScrMode[${AcMem().stat.scrMode}]");
    return;

  }

  /// 処理概要：釣機回収などの画面に入るとメンテナンス画面かどうかを
  ///         rcQC_Check_MenteDsp_Mode()では確認出来無いため, この関数で判断する
  /// 関連tprxソース: rcqc_dsp.c - rcQc_ChkScreenMente
  static Future<bool> rcQcChkScreenMente() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcQcChkScreenMente(): rxMemPtr error");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((RcQcCom.qc_com_screen == QcScreen.QC_SCREEN_MENTE.index) ||
        RcFncChk.rcQCCheckMenteDspMode()) {
      return true;
    }
    if ((await RcFncChk.rcCheckCashRecycleMode()) ||          //キャッシュリサイクル実行中
        RcFncChk.rcCheckCashRecycleReadMode()) {
      return true;
    }
    if ((pCom.auto_stropncls_run != 0) ||  //自動開閉店中
        (RcIfEvent.forceStrClsDlgShow() != 0) ||	    //強制閉設メッセージ表示中
        (AplLibAuto.getForceClsRunMode(await RcSysChk.getTid()) != 0)) {  //強制閉設中
      return true;
    }
    return false;
  }

  // TODO: 松岡 未実装、フロント処理のため、定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_chargeBtn_Hide
  static void rcQCChargeBtnHide() {
  }

  /// 関連tprxソース: rcqc_dsp.c - qc_cash_disp_cnt_end
  static void qcCashDispCntEnd() {
    qc_cash_disp_cnt = QC_CASH_CNT_END;
  }
}
