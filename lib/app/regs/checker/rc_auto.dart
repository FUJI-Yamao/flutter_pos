/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_key.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_timer.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_clr.dart';
import 'package:flutter_pos/app/regs/checker/rckyloan.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/L_AplLib.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/chkopen.dart';
import '../../lib/apllib/upd_util.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_sys/cm_stf.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/L_rc_auto.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcinoutdsp.dart';
import 'rcsyschk.dart';

/// 自動開閉店の振り分け
/// 関連tprxソース: rc_auto.c
class RcAuto {
  static int autoTranCount = 0;
  static IfWaitSave ifSave = IfWaitSave();
  static int autoMsg = 0;
  static int chgInOutFlg = 0;
  static int autoFnc = 0;

  /// 機能：自動開閉設でエラー発生時、中断するかを判定
  /// 引数：er_code エラーコード
  /// 戻値：
  ///  関連tprxソース: rc_auto.c - rcAuto_ChkDlg
  static int rcAutoChkDlg(TprMID tid, int jnl_up_flg, int er_code) {
    int   ret = 0;
    int	 err_typ = 0;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(er_code == DlgConfirmMsgKind.MSG_DRWCHK_WARNING)
    //   AplLib_CMAuto_Msg_Send(GetTid(), AUTO_MSG_OPERAT);
    // else
    //   AplLib_CMAuto_ErrMsg_Send(tid, er_code);
    // if(rcAuto_PrintErr_Chk(er_code))
    //   err_typ = 1;
    // switch( err_typ ) {
    //   case 1:	//プリンターエラー
    //     if(AplLib_CMAuto_MsgSend_Chk(GetTid())){
    //       switch( AplLib_AutoGetAutoMode( tid ) ){
    //         case AUTOMODE_KY_OVERFLOW_MENTE:   // ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ
    //         case AUTOMODE_KY_DRWCHK:   // 差異チェック
    //         case AUTOMODE_CM_CHGOUT:   //キャッシュマネジメント出金
    //         case AUTOMODE_CM_CHGIN:   //キャッシュマネジメント入金
    //         case AUTOMODE_KY_CHGPICK:  // 釣機回収
    //         case AUTOMODE_KY_PICK   :  /* 売上回収    */
    //           return(0);
    //         default:break;
    //       }
    //     }
    //     if( jnl_up_flg == ON ) {
    //       rc_Inc_RctJnlNo( 0 );
    //     }
    //     else {
    //       switch( AplLib_AutoGetAutoMode( tid ) ) {
    //         case  AUTOMODE_KY_PICK     :  /* 売上回収    */
    //           rc_Inc_RctJnlNo( 0 );
    //           break;
    //
    //         case  AUTOMODE_KY_LOAN     :  /* 釣準備      */
    //         case  AUTOMODE_KY_CHGPICK  :  /* 釣機回収    */
    //           rc_Inc_RctJnlNo( 0 );
    //           break;
    //
    //         default:
    //           break;
    //       }
    //     }
    //     rcAuto_End_Func2(AUTOLIB_EJ_ERROR, er_code);
    //     ret = 1;
    //     break;
    //
    //   default:
    //     break;
    // }

    return( ret );

  }

  /// ファンクションでエラー発生したので、自動化を中止
  /// 引数：errCode エラーコード
  ///  関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_FuncErrStop
  static Future<void> rcAutoStrOpnClsFuncErrStop(int errCode) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcAutoStrOpnClsFuncErrStop()");
    await rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_ERROR, errCode);
  }

  /// 自動開閉店処理の分岐
  ///  関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_Judg
  static void rcAutoStrOpnClsJudg() {
    // TODO:10146 従業員キー_宣言のみ
  }

  /// 引数:[flg] 自動開閉設の電子ジャーナルパラメタ
  /// 引数:[errCode] エラーコード
  ///  関連tprxソース: rc_auto.c - rcAuto_End_Func2
  static Future<void> rcAutoEndFunc2(AutoLibEj flg, int errCode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcAutoEndFunc2(): rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    int	stopFlg = 0;

    if (cBuf.auto_stropncls_run == 0) {
      return;
    }
    //rcAuto_Timer_Init();

    switch (flg) {
      /*
      case AutoLibEj.AUTOLIB_EJ_STOP:
        stopFlg = 1;
        break;
      case AutoLibEj.AUTOLIB_EJ_SKIP:
        if (cBuf.auto_stropncls_run != AutoRun.AUTORUN_STRCLS2.val) {
          return;
        }
        AplLib_CMAuto_Msg_Send(await RcSysChk.getTid(), AUTO_MSG_SKIP);
        break;
       */
      case AutoLibEj.AUTOLIB_EJ_ERROR:
        await AplLibAuto.aplLibAutoStrOpnClsError(await RcSysChk.getTid(), errCode); /* EJ:自動閉店の中止 */
        stopFlg = 2;
        break;
      /*
      case AutoLibEj.AUTOLIB_EJ_END:
        AplLib_Auto_EJ_Write(await RcSysChk.getTid(), flg, 0, null); /* EJ:自動の終了 */
        AplLib_AutoStrOpnClsStop2(await RcSysChk.getTid(), 0 );
        return;
      case AutoLibEj.AUTOLIB_EJ_NG:	//登録エラー終了
        AplLib_AutoStrOpnClsError(await RcSysChk.getTid(), errCode); /* EJ:自動閉店の中止 */
        return;
        */
      default:
        return;
    }

    /*
    RegsMem mem = SystemFunc.readRegsMem();
    String buf = "";
    String staffCdBuf = "";
    if (flg != AutoLibEj.AUTOLIB_EJ_ERROR) {
      if ((cBuf.auto_stropncls_run == AutoRun.AUTORUN_STRCLS2.val) &&
          (mem.prnrBuf.opeStaffCd != 0)) {
        int tmpNum = 0;
        (staffCdBuf, tmpNum) = await CmStf.apllibStaffCdEdit(
            await RcSysChk.getTid(), 3, mem.prnrBuf.opeStaffCd, 0);
        buf = "${LAplLib.APLLIB_STAFF_INFO}$staffCdBuf  ${mem.prnrBuf.opeStaffName}";
      }
      if (buf.isNotEmpty) {
        AplLib_Auto_EJ_Write(await RcSysChk.getTid(), flg, 0, buf);
      } else {
        AplLib_Auto_EJ_Write(await RcSysChk.getTid(), flg, 0, null);
      }
    }
     */
    if (stopFlg != 0) {
      /*
      if (stopFlg == 1) {
        AplLib_AutoStrOpnClsStop(await RcSysChk.getTid());
      }
       */
      Rcinoutdsp.inOutClose = InOutCloseData();  //従業員精算メモリクリア
    }
  }

  ///  関連tprxソース: rc_auto.c - rcAuto_Result_Send
  static Future<void> rcAutoResultSend() async {
    String buf = "";
    AcMem cMem = SystemFunc.readAcMem();

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) == 0) {
      return;
    }
    if ((RcFncChk.rcChkErr() != 0) ||
        (cMem.ent.errNo != 0) ||
        (TprLibDlg.tprLibDlgCheck2(1) != 0)) {
      if (RcAcracb.rcChkChgStockState() != 0) {
        buf = "1,NG";
      } else {
        buf = "0,NG";
      }
      await AplLibAuto.aplLibCmAutoMsgSend(await RcSysChk.getTid(), buf);
      await rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_STOP, 0);
      return;
    }
    rcAutoOKResultSend();
  }

  /// 処理概要： 自動開閉店の次処理判定
  /// パラメータ：なし
  /// 戻り値：なし
  ///  関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_NextJudg
  static Future<void> rcAutoStrOpnClsNextJudg() async {
    // TODO:10121 QUICPay、iD 202404実装対象外(一旦無視する)
    //if(IF_SAVE->count)
    //{
    //  memset((char *)IF_SAVE, 0, sizeof(IF_SAVE));
    //  TprLibLogWrite( GetTid(), TPRLOG_NORMAL, 1, "rcAuto_StrOpnCls_NextJudg(): IF_SAVE clear!!" );
    //}
    AplLibAuto.aplLibAutoNextAutoMode(await RcSysChk.getTid());
    rcAutoStrOpnClsJudg();
  }

  // TODO:00016　佐藤　定義のみ追加
  ///  関連tprxソース: rc_auto.c - rcAuto_OK_Result_Send
  static void rcAutoOKResultSend() {
  }

  /// 自動閉店：釣機回収
  /// 関連tprxソース: rc_auto.c - rcAuto_StrCls_ChgPick
  static Future<void> rcAutoStrClsChgPick() async {
    String log = '';
    String callFunc = 'rcAutoStrClsChgPick';

    log = '$callFunc()';
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (RcFncChk.rcChkErrNon()) {
      autoTranCount = 0;
      await rcAutoStrClsChgPickYes();
    } else {
      log = "$callFunc(): rcChk_Err_Non ELSE ";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      await rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_STOP, 0);
    }

    return;
  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrCls_ChgPick_Yes
  static Future<void> rcAutoStrClsChgPickYes() async {
  int num = 0;
  int ret = 0;
  int addTimer = 0;
  String log = '';
  String callFunc = 'rcAutoStrClsChgPickYes';

  log = '$callFunc()';
  TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

  await rcGtkTimerRemoveAutoTran();

  /* 未送信実績 wait */
  if(60 > autoTranCount) {
  num = await UpdUtil.updReadRest(await RcSysChk.getTid());
  ret = await ChkOpen.chkSaleSend(await RcSysChk.getTid(), 4); /* 未送信チェック */
  if(ret != 0 || num > 0) {
  if(autoTranCount == 0) {

    rcAutoStrOpnClsDlgClear();
    await rcAutoStrOpnClsDlg(DlgConfirmMsgKind.MSG_UPDATING.dlgId, rcAutoStrClsStop, LTprDlg.BTN_CANCEL, null, null, null, null); /*　"実績アップデート中・・・" */
    addTimer = 10;
  } else {
    addTimer = 1000;  /* 1msec */
  }

  rcGtkTimerAddAutoTran(addTimer, rcAutoStrClsChgPickYes());

  autoTranCount++;
  return;
  }
  }else{
  log = "$callFunc() auto_tran check over";
  TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
  }

  rcAutoStrOpnClsDlgClear();

  await rcAutoStrOpnJudgKySelf();
  await rcAutoStrOpnClsFunction(FuncKey.KY_CHGPICK.keyId); /* 釣機回収 */
  }

  /// 各ファンクションキーを呼び出す
  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_Function
  static Future<void> rcAutoStrOpnClsFunction(int fncCode) async {
    int erCode = 0;
    String log = '';
    String callFunc = 'rcAutoStrOpnClsFunction';
    AcMem cMem = SystemFunc.readAcMem();

    log = "$callFunc($fncCode)";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    cMem.stat.stepWait = 1;
  if(ifSave.count != 0) {
    ifSave = IfWaitSave();
  }

  // 従業員の操作権
    cMem.stat.fncCode = fncCode;
  autoFnc = fncCode;
  if(autoFnc == FuncKey.KY_LOAN.keyId	&&
  AplLibAuto.aplLibAutoGetAutoMode(await RcSysChk.getTid()) == AutoMode.AUTOMODE_KY_LOAN_DATA.val){	//開店自動釣準備
  rcGtkTimerAddAutoTran(10, rcAutoStrOpnClsFunctionYes());
  return;
  }

  erCode = await rcAutoStrOpnClsCheckStaff();
  if(erCode != 0) {
    cMem.stat.stepWait = 0;

    await RcExt.rcErr(callFunc, erCode);
    await RcAuto.rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_ERROR, erCode);
  TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "call AplLib_AutoStrOpnClsStop()");
  return;
  }

    rcGtkTimerAddAutoTran(10, rcAutoStrOpnClsFunctionYes());
  }

  /// 機能: タイマー起動のストップ
  /// 関連tprxソース: rc_auto.c - rcGtkTimerRemoveAutoTran
  static Future<int> rcGtkTimerRemoveAutoTran() async {
    await RcTimer.rcTimerListRemove(RC_TIMER_LISTS.RC_AUTO_TRAN_TIMER.id);
    return Typ.OK;
  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_DlgClear
  static void rcAutoStrOpnClsDlgClear(){
    rcAutoStrOpnClsDlgClear2(0);
  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_DlgClear2
  static Future<void> rcAutoStrOpnClsDlgClear2(int flg) async {
    String callFunc = 'rcAutoStrOpnClsDlgClear2';

    if (TprLibDlg.tprLibDlgCheck2(1) != 0) {
      TprDlg.tprLibDlgClear(callFunc);
    }

    if (flg != 1) {
      if (RcItmDsp.dualTSingleDlgChake() != 0) {
        RcItmDsp.dualTSingleDlgClear();
      }
    }

    await RcSet.cashStatReset2(callFunc);

    if (ifSave.count != 0) {
      ifSave = IfWaitSave();
    }

    autoMsg = 0;
  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_Dlg
  static Future<void> rcAutoStrOpnClsDlg(int erCode, Function? func1,
      String? msg1, Function? func2, String? msg2, Function? func3,
      String? msg3) async {
    tprDlgParam_t param = tprDlgParam_t();
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcAutoStrOpnClsDlg';

    param.erCode = erCode;

    if (erCode == DlgConfirmMsgKind.MSG_AUTOSTROPNCLS_NOTREAD.dlgId) {
      param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
    } else {
      if (func1 != null && func2 != null) {
        param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
      }
      else {
        param.dialogPtn = DlgPattern.TPRDLG_PT2.dlgPtnId;
      }
    }

    if (erCode == DlgConfirmMsgKind.MSG_CASHRECYCLE_COMM.dlgId) {
      if (chgInOutFlg != 0) {
        param.msgBuf = LRcAuto.CM_CHGIN_MSG;
      } else {
        param.msgBuf = LRcAuto.CM_CHGOUT_MSG;
      }
    }

    if (func1 != null) {
      param.func1 = func1;

      if(msg1 == null) {
        param.msg1 = msg1!;
      }
    }

    if (func2 != null) {
      param.func2 = func2;

      if(msg2 == null) {
        param.msg2 = msg2!;
      }
    }

    if (func3 != null) {
      param.func3 = func3;

      if(msg3 == null) {
        param.msg3 = msg3!;
      }
    }

    if (erCode == DlgConfirmMsgKind.MSG_AUTOSTROPNCLS_NOTREAD.dlgId) {
      param.title = LTprDlg.BTN_ERR;
    } else {
      param.title = LTprDlg.BTN_CONF;
    }
    param.userCode = 0;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) {
      if (cMem.stat.dualTSingle == 1) {
        param.dual_dsp = 2;
      }

      if ((AplLibAuto.aplLibChkAutoStrClsError(
          await RcSysChk.getTid()) & 0x01) != 0) {
        /* 精算業務中断の場合(スマイルセルフ、QCJC) */
        if (FbInit.subinitMainSingleSpecialChk() == true) {
          param.dual_dsp = 0;
        }
      }
    }

    TprLibDlg.tprLibDlg2(callFunc, param);

    if (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) {
      if ((AplLibAuto.aplLibChkAutoStrClsError(
          await RcSysChk.getTid()) & 0x01) != 0) {
        /* 精算業務中断の場合(スマイルセルフ、QCJC) */
        if (FbInit.subinitMainSingleSpecialChk() == true) {
          param.dual_dsp = 3;
          TprLibDlg.tprLibDlg2(callFunc, param);
        }
      } else {
        cMem.scrData.msgLcd = '';
        cMem.scrData.msgLcd = LRcAuto.IMG_AUTOCONF;
        RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 0);
      }
    }

    await RcExt.cashStatSet(callFunc);

    autoMsg = 1;
    if (erCode != DlgConfirmMsgKind.MSG_UPDATING.dlgId &&
        erCode != DlgConfirmMsgKind.MSG_CASHRECYCLE_COMM.dlgId &&
        erCode != DlgConfirmMsgKind.MSG_PROCESS_WAITING.dlgId) {
      AplLibAuto.aplLibCMAutoErrMsgSend(await RcSysChk.getTid(), erCode);
    }

    return;
  }

  ///	機能: 引数の関数をタイマー起動
  ///	引数: timer: 起動間隔 (ミリ秒)    func: 実行関数
  /// 関連tprxソース: rc_auto.c - rcGtkTimerAddAutoTran
  static int rcGtkTimerAddAutoTran(int timer, void func) {
    return RcTimer.rcTimerListAdd(
        RC_TIMER_LISTS.RC_AUTO_TRAN_TIMER, timer, func, 0);
  }

  /// 自動開店処理の各処理分岐
  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpn_Judg_KySelf
  static Future<int> rcAutoStrOpnJudgKySelf() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    RxInputBuf iBuf = RxInputBuf();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_CHECKER :
      /* タワー側 */
        atSing.inputbuf.dev = DevIn.D_KEY;
        iBuf.devInf.devId = TprDidDef.TPRDIDMECKEY2;
        cBuf.devId = 1;
        return 1;
      default:
      /* KY_SINGLE DESKTOPTYPE KY_DUALCSHR */
      /* 卓上側のメカキー */
        atSing.inputbuf.dev = DevIn.D_KEY;
        iBuf.devInf.devId = TprDidDef.TPRDIDMECKEY1;
        cBuf.devId = 1;
        break;
    }

    if (FbInit.subinitMainSingleSpecialChk() == true) {
      cMem.stat.dualTSingle = cBuf.devId;
    } else {
      cMem.stat.dualTSingle = 0;
    }

    return 0;
  }

  /// 各ファンクションキーを呼び出す
  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_Function_Yes
  static Future<void> rcAutoStrOpnClsFunctionYes() async {
    String log = '';
    String callFunc = 'rcAutoStrOpnClsFunctionYes';
    AcMem cMem = SystemFunc.readAcMem();

    log = "$callFunc:[${cMem.stat.fncCode}][$autoFnc]";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    await rcGtkTimerRemoveAutoTran();
    if (ifSave.count != 0) {
      ifSave = IfWaitSave();
    }

    //まれのタイミングでイベントが発生した場合CMEM->stat.FncCodeがリセットされる事を防ぐ為
    cMem.stat.fncCode = autoFnc;
    cMem.stat.stepWait = 0;

    if (autoFnc == FuncKey.KY_LOAN.keyId &&
        AplLibAuto.aplLibAutoGetAutoMode(await RcSysChk.getTid()) ==
            AutoMode.AUTOMODE_KY_LOAN_DATA.val) {
      //開店自動釣準備
      RcKyLoan.rcUpdateChgLoanAuto();
      await rcAutoStrOpnClsNextJudg();
    } else {
      // RF1_SYSTEMが0で定義されていたので、この部分はコメントアウトしておく。
      // #if RF1_SYSTEM
      // if (Auto_Fnc == KY_DRWCHK)
      // {
      // if (cm_rf1_hs_System())					// RF様仕様の時
      //     {
      // C_BUF->vtcl_rm5900_amount_on_hand_flg = 1;	// 閉設処理で差異チェックが指定されたときは差異チェック/在高入力フラグを在高入力にする
      // }
      // else
      // {
      // C_BUF->vtcl_rm5900_amount_on_hand_flg = 0;	// 閉設処理で差異チェックが指定されたときは差異チェック/在高入力フラグを\差異チェックにする
      // }
      // }
      // #endif // if RF1_SYSTEM

      KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
      keyCon.rcDKeyByKeyId(cMem.stat.fncCode,
          null); // CMEM->stat.FncCodeはrcAuto_StrOpnCls_Functionでセット
    }
  }

  /// 従業員の操作権を判定する
  /// rcinoutdsp.c rcPickFunc()から、移植
  /// 関連tprxソース: rc_auto.c - rcAuto_StrOpnCls_CheckStaff
  static Future<int> rcAutoStrOpnClsCheckStaff() async {
    int staffNo = 0;
    String clkBuf = '';
    String clkCd = '';
    String log = '';
    String callFunc = 'rcAutoStrOpnClsCheckStaff';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    staffNo = 0; /* FORTIFY */
    log = "$callFunc()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_SINGLE:
      case RcRegs.KY_DUALCSHR:
        staffNo = int.tryParse(cBuf.dbStaffopen.cshr_cd!) ?? 0;
        break;
      case RcRegs.KY_CHECKER:
        staffNo = cBuf.dbStaffopen.chkr_cd!;
        break;
    }

    clkBuf = Ltobcd.cmLltobcd(staffNo, staffNo.toString().length);
    clkCd = clkBuf;

    if (await RcFncChk.rcChkOperation(clkCd) == false) {
      return (DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId);
    }

    return 0;
  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrCls_Stop
  static Future<void> rcAutoStrClsStop() async {
  String log = '';
  String callFunc = 'rcAutoStrClsStop';

  log = "$callFunc()";
  TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

  await rcGtkTimerRemoveAutoTran();

  rcAutoStrOpnClsDlgClear( );

  await rcAutoStrOpnClsDlg(DlgConfirmMsgKind.MSG_STOP_SETTL_BUSI_CONF.dlgId, rcAutoStrClsStopYes, LTprDlg.BTN_YES, rcAutoStrClsStopYes, LTprDlg.BTN_NO, null, null);{
  }
  /* "精算業務を中止します。\nよろしいですか？" */

  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrCls_Stop_Yes
  static Future<void> rcAutoStrClsStopYes() async {
    String log = '';
    String callFunc = 'rcAutoStrClsStopYes';

    log = "callFunc()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (AplLibAuto.strCls(await RcSysChk.getTid()) == 0) {
      AplLibAuto.aplLibAutoEjWrite(
          await RcSysChk.getTid(), AutoLibEj.AUTOLIB_EJ_STOP.value, 0, null);
    }

    rcAutoStrOpnClsDlgClear();

    await RckyClr.rcKyClr();
    await rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_STOP, 0);
  }

  /// 関連tprxソース: rc_auto.c - rcAuto_StrCls_Stop_No
  static Future<void> rcAutoStrClsStopNo() async {
    String log = '';
    String callFunc = 'rcAutoStrClsStopNo';

    log = "$callFunc()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    rcAutoStrOpnClsDlgClear();

    rcAutoStrOpnClsJudg();
  }
}
