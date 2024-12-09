/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/apllib/TmnDaily_Trn.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/sys/usetup/fcl_setup/fcl_setup.dart';
import 'package:flutter_pos/app/sys/usetup/fcl_setup/fcl_setup_main.dart';
import 'package:flutter_pos/app/sys/usetup/fcl_setup/fcl_setup_sub.dart';
import 'package:flutter_pos/app/sys/usetup/fcl_setup/ut1_setup_sub.dart';
import 'package:get/get.dart';

import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/lib/if_fcl.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../regs/checker/rc_ewdsp.dart';
import '../../../ui/page/common/component/w_msgdialog.dart';
import '../../../ui/page/test/controller/c_fcl_setup_controller.dart';
import '../../../ui/page/test/controller/c_fcl_setup_download_controller.dart';
import '../../word/aa/l_fcl_setup.dart';

class FclSetupFrsComm{
  static int rtryCnt = 0;
  static int errorFlg = 0;
  /*-------------------------------------------------------------------------*
 * グローバル変数
 *-------------------------------------------------------------------------*/
  // extern FCLS_WID  fcls_wid;
  // RX_TASKSTAT_BUF       *pStat;
  // RX_COMMON_BUF         *pCom;

  /// 機能: 実行しますか「はい」タッチ処理。
  /// 引数: なし
  /// 戻値: なし
  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_yes
  static Future<void> utYes() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "utYes() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf pStat = xRet.object;

    // TprLibDlgClear();
    // gtk_grab_add( fcls_wid.Dsp.Window );

    TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "utYes Btn Click");
    switch(TmnDailyTrn.fclsInfo.state){
      case FclsSts.FCLS_STS_1_1_1:
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
            "utYes Btn Click => FCLS_STS_1_1_1");
        pStat.multi.fclData.tKind = 2;
        pStat.multi.order = FclProcNo.OCX_U_START.index;
        await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
        break;
      case FclsSts.FCLS_STS_1_1_2:
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
            "ut_yes Btn Click => FCLS_STS_1_1_2");
        pStat.multi.fclData.tKind = 3;
        pStat.multi.order = FclProcNo.OCX_U_START.index;
        await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
        break;
      //
      // case    FCLS_STS_1_1_3:
      // TprLibLogWrite( FCLS_LOG, TPRLOG_NORMAL, 0, "ut_yes Btn Click => FCLS_STS_1_1_3" );
      // pStat->multi.fcl_data.t_kind = 4;
      // pStat->multi.order = OCX_U_START;
      // break;
      //
      case FclsSts.FCLS_STS_1_1_4:
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
            "ut_yes Btn Click => FCLS_STS_1_1_4");
        pStat.multi.fclData.tKind = 5;
        pStat.multi.order = FclProcNo.OCX_U_START.index;
        await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
        break;

      // case    FCLS_STS_1_4_2:
      // TprLibLogWrite( FCLS_LOG, TPRLOG_NORMAL, 0, "ut_yes Btn Click => FCLS_STS_1_4_2" );
      // pStat->multi.fcl_data.t_kind = 10;
      // pStat->multi.fcl_data.s_kind = FCL_EDY;
      // pStat->multi.order = OCX_U_START;
      // break;
      //
      // case    FCLS_STS_1_4_3:
      // TprLibLogWrite( FCLS_LOG, TPRLOG_NORMAL, 0, "ut_yes Btn Click => FCLS_STS_1_4_3" );
      // pStat->multi.fcl_data.t_kind = 11;
      // pStat->multi.fcl_data.s_kind = FCL_EDY;
      // pStat->multi.order = OCX_U_START;
      // break;
      default:
        break;
    }

    // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), FCLS_MSG33 );
    // fcls_lbl_cmd_set_text( FCLS_OD_NONE );

    // TODO:10150 端末セットアップ、ダウンロード コントローラーが変わる為「||」を使用しない
    // if(pStat.multi.fclData.tKind == 3 || pStat.multi.fclData.tKind == 5){
    if(pStat.multi.fclData.tKind == 3){
      final FclSetupDownloadController dCtrl = Get.find();
      dCtrl.execStatus.value = LFclSetup.FCLS_MSG33;
      utProcDownLoad();
    }else{
      final FclSetupController sCtrl = Get.find();
      sCtrl.execStatus.value = LFclSetup.FCLS_MSG33;
      utProcSetup();
    }
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_setup
  static void utProcSetup(){
    FclSetupMain.utTimerInit();
    rtryCnt = 0;
    errorFlg = 0;
    FclSetupMain.utTimerAdd(FclSetup.NETX_GO_TIME, utProcSetupChk);
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_setup_chk
  static Future<void> utProcSetupChk() async {
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rxMemRead error");
      return;
    }
    RxTaskStatBuf pStat = xRet.object;
    FclSetupMain.utTimerRemove();

    rtryCnt++;

    if (rtryCnt > FclSetup.RETRY_TIME) {
      TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut_proc_setup_chk TimeOut");
      rtryCnt = 0;
      errorFlg = 1;
      errNo = FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcSetupEnd);
    }
    else {
      if (pStat.multi.errCd == 0) {
        if (pStat.multi.order == FclProcNo.OCX_U_END.index) {  /* 成功 */
          TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut_proc_setup_chk Success");
          errNo = FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcSetupEnd);
          pStat.multi.order = FclProcNo.FCL_NOT_ORDER.index;
          await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
          rtryCnt = 0;
        }
        else {  /* 処理中 */
          errNo = FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcSetupChk);
        }
      }
      else {  /* 失敗 */
        if (pStat.multi.order == FclProcNo.FCL_NOT_ORDER.index) {
          TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut_proc_setup_chk Error");
          rtryCnt = 0;
          errNo = FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcSetupEnd);
        }
        else {
          TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "pStat.multi.order != FCL_NOT_ORDER");
          errNo = FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcSetupChk);
        }
      }
    }
    return;
  }

  /// 機能: 終了ボタンタッチ処理。
  /// 戻値: 0
  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_quit_btn
  static int utQuitBtn() {
    if (TmnDailyTrn.fclsInfo.procAct != 0) {
      return 0;
    }

    TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut1: quit");

    // TODO ウィジェット関連処理
    // gtk_widget_destroy( fcls_wid.Dsp.Window );

    switch( TmnDailyTrn.fclsInfo.state ) {
      case    FclsSts.FCLS_STS_1_1_1:
      case    FclsSts.FCLS_STS_1_1_2:
      case    FclsSts.FCLS_STS_1_1_3:
      case    FclsSts.FCLS_STS_1_1_4:
        TmnDailyTrn.fclsInfo.state = FclsSts.FCLS_STS_1_1;
        break;
      case    FclsSts.FCLS_STS_1_4_2:
      case    FclsSts.FCLS_STS_1_4_3:
        TmnDailyTrn.fclsInfo.state = FclsSts.FCLS_STS_1_4;
        break;
      default : break;
    }

    return 0;
  }

  /// 機能: 実行ボタンタッチ処理。
  /// 戻値：0 = Normal End
  ///      -1 = Error
  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_set_btn
  static Future<int> utSetBtn() async {
    if (TmnDailyTrn.fclsInfo.procAct != 0) {
      return 0;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "utSetBtn() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf pStat = xRet.object;

    if (pStat.multi.flg & 0x08 != 0) {     /* マルチタスク起動中 */
      if(pStat.multi.order != FclProcNo.FCL_NOT_ORDER.index) {
        // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), FCLS_MSG24 );
        // TODO:10150 端末セットアップ、ダウンロード 突貫対応
        if(TmnDailyTrn.fclsInfo.state == FclsSts.FCLS_STS_1_1_1) {
          final FclSetupController sCtrl = Get.find();
          sCtrl.execStatus.value = LFclSetup.FCLS_MSG24;
        }else if(TmnDailyTrn.fclsInfo.state == FclsSts.FCLS_STS_1_1_2){
          final FclSetupDownloadController dCtrl = Get.find();
          dCtrl.execStatus.value = LFclSetup.FCLS_MSG24;
        }
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut_set_btn => RxTaskStatBuf.multi.order != FCL_NOT_ORDER" );
        return 0;
      }
    }
    else {
      // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), FCLS_MSG24 );
      // TODO:10150 端末セットアップ、ダウンロード 突貫対応
      if(TmnDailyTrn.fclsInfo.state == FclsSts.FCLS_STS_1_1_1) {
        final FclSetupController sCtrl = Get.find();
        sCtrl.execStatus.value = LFclSetup.FCLS_MSG24;
      }else if(TmnDailyTrn.fclsInfo.state == FclsSts.FCLS_STS_1_1_2){
        final FclSetupDownloadController dCtrl = Get.find();
        dCtrl.execStatus.value = LFclSetup.FCLS_MSG24;
      }
      TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut_set_btn => RxTaskStatBuf.multi.flg != 0x08" );
      return 0;
    }


    pStat.multi = RxTaskstatMulti();
    pStat.multi.flg |= 0x08; /* マルチタスクが起動中なので常にセット */
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");

    TmnDailyTrn.fclsInfo.procAct = 1;

    // fcls_dlg( MSG_EXECCONF, TPRDLG_PT1, (void *)ut_yes, (void *)fcls_no, 0);
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_EXECCONF.dlgId,
        type: MsgDialogType.info,
        rightBtnFnc: () {
          utYes();
          Get.back();
        },
        leftBtnFnc: () {
          fclsNo();
          Get.back();
        },
      ),
    );

    return 0;
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_setup_end
  static Future<void> utProcSetupEnd() async {
    String ret = "";
    String msg = "";
    String buf = "";
    int errNo;
    String errMsg = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "utYes() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf pStat = xRet.object;
    final FclSetupController ctrl = Get.find();

    FclSetupMain.utTimerRemove();
    // gtk_grab_add( fcls_wid.Dsp.Window );

    errNo = 0;
    // memset( &msg[0], '\0', sizeof(msg) );
    // memset( &ret[0], '\0', sizeof(ret) );
    // memset(err_msg, 0, sizeof(err_msg));
    // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), msg );
    ctrl.execStatus.value = msg;

    TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "utProcSetupEnd!");

    if(!(pStat.multi.errCd != 0)){
      /* user_cd11 & 16 の時、QP-TIDとiD-TIDをPOSTIDと比較する */
      if(errorFlg != 0){
        errorFlg = 0;
        ret = LFclSetup.FCLS_RESULT_ERR;
        Ut1SetupSub.ut1EjheadMake(1);
      }else{
        if(await CmCksys.cmMultiVegaSystem() != 0){
          // TODO:10132 端末セットアップ 202404実装対象外
          // switch( fcls_info.state )
          // {
          //   case FCLS_STS_1_1_1:    /* 端末セットアップ通信 */
          //   // OCXにて書き込まれたTidを取得
          //     err_no = rmIniReadMain();
          //     if(!err_no)
          //     {
          //       err_no = ut_proc_Chk_Ralse_TID();
          //     }
          //     break;
          //   default:
          //     break;
          // }
        }else{
          errNo = utProcChkRalseTID();
        }
        ret = LFclSetup.FCLS_RESULT_NORM;
        if(errNo != 0){
          // ut1_dlg( err_no, TPRDLG_PT2, (void *)ut1_no, NULL);
          MsgDialog.show(
            MsgDialog.singleButtonDlgId(
              dialogId: errNo,
              type: MsgDialogType.error,
              btnFnc: () {
                ut1No();
                Get.back();
              },
            ),
          );
        }
        Ut1SetupSub.ut1EjheadMake(0);
      }
    }else{
      if((await CmCksys.cmMultiVegaSystem() != 0)
          && ((pStat.multi.errCd == Fcl.FCL_INITCOMM)
              || (pStat.multi.errCd == Fcl.FCL_NONINITCOMM))){
        ret = LFclSetup.FCLS_RESULT_NORM;
        Ut1SetupSub.ut1EjheadMake(0);
      }else{
        ret = LFclSetup.FCLS_RESULT_ERR;
        Ut1SetupSub.ut1EjheadMake(1);
      }
      errNo = TmnDailyTrn.ut1ErrChk(FclSetup.FCLS_LOG);
      errMsg = Ut1SetupSub.rcUt1Msg();
      // ut1_dlg( err_no, TPRDLG_PT2, (void *)fcls_no, err_msg);
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: errNo,
          type: MsgDialogType.error,
          footerMessage: errMsg,
          btnFnc: () {
            fclsNo();
            Get.back();
          },
        ),
      );
    }
    // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), ret );
    ctrl.execStatus.value = ret;

    pStat.multi.order = FclProcNo.FCL_NOT_ORDER.index;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");

    TmnDailyTrn.fclsInfo.procAct = 0;
    await FclSetupSub.fclsEjTxtMake(buf, 1);
    rtryCnt = 0;

    return;
  }

  // TODO:00012 平野　端末セットアップ対応: 定義のみ追加、要実装
  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_Chk_Ralse_TID
  static int utProcChkRalseTID(){
    return 0;
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - fcls_no
  static void fclsNo() {
    TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "fcls: exe no");
    TmnDailyTrn.fclsInfo.procAct = 0;
    // TprLibDlgClear();
    // gtk_grab_add(fcls_wid.Dsp.Window);
  }

  /// 機能: 実行しますか「いいえ」タッチ処理。
  /// 引数: なし
  /// 戻値: なし
  /// 関連tprxソース: fcl_setup_frs_comm.c - ut1_no
  static void ut1No(){
    String buf = "";
    TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut1: exe no");

    // memset(buf, 0, sizeof(buf));
    // TID_msg = Prg_StdDrawLbl_F( LightGray, LightGray, buf, WIN_W(15), WIN_H(4) );
    // gtk_fixed_put( GTK_FIXED(fcls_wid.Dsp.FixWin), TID_msg, WIN_W(7), WIN_H(14) );
    TmnDailyTrn.fclsInfo.procAct = 0;
    // TprLibDlgClear();
    // gtk_grab_add( fcls_wid.Dsp.Window );
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_download
  static void utProcDownLoad() {
    FclSetupMain.utTimerInit();
    rtryCnt = 0;
    errorFlg = 0;
    FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcDownloadChk);
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_download_chk
  static Future<void> utProcDownloadChk() async {
    int errNo = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    FclSetupMain.utTimerRemove();

    rtryCnt++;

    if (rtryCnt > FclSetup.RETRY_TIME) {
      TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
          "ut_proc_download_chk TimeOut");
      rtryCnt = 0;
      errorFlg = 1;
      errNo =
          FclSetupMain.utTimerAdd(FclSetup.EVENT_TO_TIME, utProcDownloadEnd);
    } else {
      if (tsBuf.multi.errCd == 0) {
        if (tsBuf.multi.order == FclProcNo.OCX_U_END.index) /* 成功 */ {
          TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
              "ut_proc_download_chk Success");
          errNo = FclSetupMain.utTimerAdd(
              FclSetup.EVENT_TO_TIME, utProcDownloadEnd);
          tsBuf.multi.order = FclProcNo.FCL_NOT_ORDER.index;
          await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");
          rtryCnt = 0;
        } else {
          /* 処理中 */
          errNo = FclSetupMain.utTimerAdd(
              FclSetup.EVENT_TO_TIME, utProcDownloadChk);
        }
      } else {
        /* 失敗 */
        if (tsBuf.multi.order == FclProcNo.FCL_NOT_ORDER.index) {
          TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
              "ut_proc_download_chk Error");
          rtryCnt = 0;
          errNo = FclSetupMain.utTimerAdd(
              FclSetup.EVENT_TO_TIME, utProcDownloadEnd);
        } else {
          TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.normal,
              "pStat->multi.order != FCL_NOT_ORDER");
          errNo = FclSetupMain.utTimerAdd(
              FclSetup.EVENT_TO_TIME, utProcDownloadChk);
        }
      }
    }
    return;
  }

  /// 関連tprxソース: fcl_setup_frs_comm.c - ut_proc_download_end
  static Future<void> utProcDownloadEnd() async {
    String ret = '';
    String msg = '';
    String buf = '';
    int errNo = 0;
    String errMsg = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    final FclSetupDownloadController dCtrl = Get.find();

    FclSetupMain.utTimerRemove();
    // gtk_grab_add( fcls_wid.Dsp.Window );

    // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), msg );
    dCtrl.execStatus.value = msg;

    TprLog().logAdd(
        FclSetup.FCLS_LOG, LogLevelDefine.normal, "ut_proc_download_end!");

    if (tsBuf.multi.errCd == 0) {
      if (errorFlg != 0) {
        errorFlg = 0;
        ret = LFclSetup.FCLS_RESULT_ERR;
        await Ut1SetupSub.ut1EjheadMake(1);
      } else {
        ret = LFclSetup.FCLS_RESULT_NORM;
        await Ut1SetupSub.ut1EjheadMake(0);
      }
    } else {
      ret = LFclSetup.FCLS_RESULT_ERR;
      await Ut1SetupSub.ut1EjheadMake(1);
      errNo = TmnDailyTrn.ut1ErrChk(FclSetup.FCLS_LOG);
      errMsg = Ut1SetupSub.rcUt1Msg();
      //ut1_dlg( err_no, TPRDLG_PT2, (void *)fcls_no, err_msg);
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: errNo,
          type: MsgDialogType.error,
          footerMessage: errMsg,
          btnFnc: () {
            fclsNo();
            Get.back();
          },
        ),
      );
    }

    // gtk_round_entry_set_text( GTK_ROUND_ENTRY(fcls_wid.Ent_msg), ret );
    dCtrl.execStatus.value = ret;

    tsBuf.multi.order = FclProcNo.FCL_NOT_ORDER.index;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");

    TmnDailyTrn.fclsInfo.procAct = 0;
    await FclSetupSub.fclsEjTxtMake(buf, 1);
    rtryCnt = 0;

    return;
  }
}