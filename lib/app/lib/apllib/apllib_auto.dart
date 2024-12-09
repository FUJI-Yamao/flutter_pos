/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/apllib/recog.dart';
import 'package:flutter_pos/app/lib/apllib/rm_db_read.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/L_AplLib.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_ary/cm_ary.dart';
import '../cm_sys/cm_cksys.dart';
import '../cm_sys/cm_stf.dart';
import '../if_acx/acx_com.dart';
import 'mentecall.dart';

/// 自動開閉設仕様関連LIB
/// 関連tprxソース: AplLib_Auto.c
class AplLibAuto {
  /// 戻り値
  static const DRW_OK_B = 1;
  static const DRW_NG_B = 0;

  /// 自動開閉設の動作モードを設定
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoSetAutoMode()
  static Future<bool> aplLibAutoSetAutoMode(TprMID tid, int autoMode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "aplLibAutoSetAutoMode(): rxMemRead error");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    pCom.iniMacInfo.internal_flg.auto_mode = autoMode;
    await pCom.iniMacInfo.save();
    SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);
    return true;
  }

  /// 自動開閉設の実行状態を取得
  /// 引数:[tid] タスクID
  /// 戻値: 0=未実行  1=自動開店処理中  2=自動閉店処理中  -1=異常
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoGetRunMode()
  static int AplLibAutoGetRunMode(TprMID tid)   {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(!AplLib_AutoGetMem(tid))
    //   return (AUTOLIB_ERROR);
    //
    // AplLib_LogWrite( tid );
    //
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return pCom.auto_stropncls_run;
  }

  /// 自動開閉設の実行状態を設定
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoSetRunMode()
  static Future<int> aplLibAutoSetRunMode(TprMID tid, int setFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "aplLibAutoSetRunMode(): rxMemRead error");
      return AplLib.AUTOLIB_ERROR;
    }
    RxCommonBuf pCom = xRet.object;

    if (aplLibAutoGetMem(tid) == 0) {
      return AplLib.AUTOLIB_ERROR;
    }

    int	flg = pCom.auto_stropncls_run;
    AutoRun autoStropnclsRun = AutoRun.getDefine(setFlg);
    switch (autoStropnclsRun) {
      case AutoRun.AUTORUN_STROPN:
        if (await strOpnClsSetChk(tid, StrOpnClsCodeList.STROPN_AUTO) <= 0) {
          autoStropnclsRun = AutoRun.AUTORUN_NON;
        } break;
      case AutoRun.AUTORUN_STRCLS2:
        if (await strOpnClsSetChk( tid, StrOpnClsCodeList.STRCLS_AUTO) <= 0 ) {
          autoStropnclsRun = AutoRun.AUTORUN_NON;
        }
        break;
      default:
        break;
    }

    pCom.auto_stropncls_run = autoStropnclsRun.val;
    if (flg != pCom.auto_stropncls_run)	{
      //変更がなければログ出力しない
      aplLibLogWrite(tid);
    }
    if (autoStropnclsRun == AutoRun.AUTORUN_NON) {
      pCom.manulStrcls = 0;
    }

    return AplLib.AUTOLIB_SUCCESS;
  }

  /// 関連tprxソース: AplLib_Auto.c - AplLib_CMAuto_ErrMsg_Send()
  static void	aplLibCMAutoErrMsgSend(TprMID tid, int errNo){
    String data = '';
    int	step = 0;

    if(aplLibCMAutoMsgSendChk(tid) != 0){
      var (stepVal, stepName) = aplLibCMAutoStepGet(tid, '');
      step = stepVal;
      data = sprintf(AplLib.AUTO_MSG_ERR, [errNo]);
      MenteCall.mentecallStrclsResSend(tid, step, data);
    }
  }

  /// 関連tprxソース: AplLib_Auto.c - AplLib_CMAuto_MsgSend_Chk()
  static int	aplLibCMAutoMsgSendChk(TprMID tid){
    /* アシストモニター承認キーの確認は必要？？？*/
    if(aplLibAutoGetMem(tid) == 0) {
      return 0;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "aplLibCMAutoMsgSendChk(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if(pCom.auto_stropncls_run == AutoRun.AUTORUN_STRCLS2.val) {
      return 1;
    }

    return 0;
  }

  /// 共有メモリポインタの取得
  /// 引数:[tid] タスクID
  /// 戻値: 0=異常  1=正常
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoGetMem()
  static int aplLibAutoGetMem(TprMID tid){
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "rxMemRead error");
      return DRW_NG_B;
    }

    if(xRet.result != RxMem.RXMEM_OK) {
      log = sprintf("%s: rxMemPtr NG!!", [aplLibAutoGetMem(tid)]);
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      autoStrClsLogWrite(tid, log, LogLevelDefine.error);
      return 0;
    }
    return 1;
  }

  /// 関連tprxソース: AplLib_Auto.c - AutoStrCls_Log_Write()
  static void	autoStrClsLogWrite(TprMID tid, String log, int level){
    String erlog = '';

    erlog = sprintf("[tid=%08x] %s", [tid, log]);
    TprLog().logAdd(Tpraid.TPRAID_AUTO_STROPNCLS, level, erlog);
  }

  /// 自動精算中かチェックする
  /// 引数:[tid] タスクID
  /// 戻値:0=オープンなし  1=オープンあり
  ///  関連tprxソース: AplLib_Auto.c - AplLib_Auto_StrCls()
  static int strCls(TprMID tid) {
    if (AplLibAutoGetRunMode(tid) == AutoRun.AUTORUN_STRCLS2.val) {
      return 1;
    }
    return 0;
  }

  /// 自動開閉店設定チェック
  /// 引数:[tid] タスクID
  /// 引数:[chkNum] 設定項目
  /// 戻値:設定値
  ///  関連tprxソース: AplLib_Auto.c - AplLib_AutoStrOpnCls_Set_Chk()
  static Future<int> strOpnClsSetChk(TprMID tid, StrOpnClsCodeList chkNum) async {
    if (aplLibAutoGetMem(tid) == 0) {
      return AplLib.AUTOLIB_ERROR;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "strOpnClsSetChk(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    switch (chkNum) {
      case StrOpnClsCodeList.STROPN_AUTO:		//開店準備自動化
        return pCom.dbStrOpnCls.stropn_auto;
      case StrOpnClsCodeList.STROPN_WAIT_TIME:		//開店処理実行の待ち時間
        return pCom.dbStrOpnCls.stropn_wait_time;
      case StrOpnClsCodeList.STROPN_CHECKER_LOGIN:	//開店時チェッカー従業員のログイン
        return pCom.dbStrOpnCls.stropn_checker_login;
      case StrOpnClsCodeList.STROPN_CASHIER_LOGIN:	//開店時キャッシャー従業員のログイン
        return pCom.dbStrOpnCls.stropn_cashier_login;
      case StrOpnClsCodeList.STROPN_CHGLOAN:		//釣準備
        return pCom.dbStrOpnCls.stropn_chgloan;
      case StrOpnClsCodeList.STROPN_CHGREF:		//釣参照
        return pCom.dbStrOpnCls.stropn_chgref;
      case StrOpnClsCodeList.STROPN_DRWCHK:		//開店差異チェック
        return pCom.dbStrOpnCls.stropn_drwchk;
      case StrOpnClsCodeList.STROPN_DRWCHK_PRINT:	//開店差異チェックレポート印字
        return pCom.dbStrOpnCls.stropn_drwchk_print;
      case StrOpnClsCodeList.STRCLS_AUTO:		//精算業務
        return pCom.dbStrOpnCls.strcls_auto;
      case StrOpnClsCodeList.STRCLS_MANAL:		//精算単体実行
        return pCom.dbStrOpnCls.strcls_manal;
      case StrOpnClsCodeList.STRCLS_PASSWD:		//精算業務ボタン押下時パスワード入力
        return pCom.dbStrOpnCls.strcls_passwd;
      case StrOpnClsCodeList.STRCLS_ACX_RCALC:	//在高確定時の釣機再精査(ECS接続時のみ)
        return pCom.dbStrOpnCls.strcls_acx_rcalc;
      case StrOpnClsCodeList.STRCLS_RECAL_REPO:	//釣機再精査レポート印字
        return pCom.dbStrOpnCls.strcls_recal_repo;
      case StrOpnClsCodeList.STRCLS_ACX_RCALC_G:	//RT-300釣機在高不確定解除処理
        return pCom.dbStrOpnCls.strcls_acx_rcalc_g;
      case StrOpnClsCodeList.STRCLS_REPO:		//精算前予約レポート印字
        return pCom.dbStrOpnCls.strcls_repo;
      case StrOpnClsCodeList.STRCLS_REPO_SEL1:	//精算前出力予約レポート１
        return pCom.dbStrOpnCls.strcls_repo_sel1;
      case StrOpnClsCodeList.STRCLS_REPO_SEL2:	//精算前出力予約レポート2
        return pCom.dbStrOpnCls.strcls_repo_sel2;
      case StrOpnClsCodeList.STRCLS_REPO_SEL3:	//精算前出力予約レポート3
        return pCom.dbStrOpnCls.strcls_repo_sel3;
      case StrOpnClsCodeList.STRCLS_REPO_SEL4:	//精算前出力予約レポート4
        return pCom.dbStrOpnCls.strcls_repo_sel4;
      case StrOpnClsCodeList.STRCLS_REPO_SEL5:	//精算前出力予約レポート5
        return pCom.dbStrOpnCls.strcls_repo_sel5;
      case StrOpnClsCodeList.STRCLS_REPO_SEL6:	//精算前出力予約レポート6
        return pCom.dbStrOpnCls.strcls_repo_sel6;
      case StrOpnClsCodeList.STRCLS_REPO_SEL7:	//精算前出力予約レポート7
        return pCom.dbStrOpnCls.strcls_repo_sel7;
      case StrOpnClsCodeList.STRCLS_REPO_SEL8:	//精算前出力予約レポート8
        return pCom.dbStrOpnCls.strcls_repo_sel8;
      case StrOpnClsCodeList.STRCLS_REPO_SEL9:	//精算前出力予約レポート9
        return pCom.dbStrOpnCls.strcls_repo_sel9;
      case StrOpnClsCodeList.STRCLS_REPO_AUTO:	//精算前予約レポート自動発行
        return pCom.dbStrOpnCls.strcls_repo_auto;
      case StrOpnClsCodeList.STRCLS_CASHIER_LOGIN:	//精算時キャッシャー従業員のログイン
        return pCom.dbStrOpnCls.strcls_cashier_login;
      case StrOpnClsCodeList.STRCLS_OVERFLOW_MENTE:	//ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ自動実行
        return pCom.dbStrOpnCls.strcls_acx_overflow_mente;
      case StrOpnClsCodeList.STRCLS_OVERFLOW_MENTE_PRINT:	//ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ印字
        return pCom.dbStrOpnCls.strcls_acx_overflow_mente_print;
      case StrOpnClsCodeList.STRCLS_OVERFLOW_MENTE_CIN:	//ｵｰﾊﾞｰﾌﾛｰ庫硬貨が釣銭機に収納可能な場合は補充
        return pCom.dbStrOpnCls.strcls_acx_overflow_mente_cin;
      case StrOpnClsCodeList.STRCLS_DRWCHK:		//精算差異チェック
        return pCom.dbStrOpnCls.strcls_drwchk;
      case StrOpnClsCodeList.STRCLS_DRWCHK_PRINT:	//精算差異チェックレポート印字
        return pCom.dbStrOpnCls.strcls_drwchk_print;
      case StrOpnClsCodeList.STRCLS_PICK:		//売上回収
        return pCom.dbStrOpnCls.strcls_pick;
      case StrOpnClsCodeList.STRCLS_PICK_BILL:	//差異チェックから売上回収に引継ぐデータ（ドロア紙幣）
        return pCom.dbStrOpnCls.strcls_pick_bill;
      case StrOpnClsCodeList.STRCLS_PICK_COIN:	//差異チェックから売上回収に引継ぐデータ（ドロア硬貨）
        return pCom.dbStrOpnCls.strcls_pick_coin;
      case StrOpnClsCodeList.STRCLS_PICK_OTHER:	//差異チェックから売上回収に引継ぐデータ（品券／会計）
        return pCom.dbStrOpnCls.strcls_pick_other;
      case StrOpnClsCodeList.STRCLS_PICK_CHGBILL:	//差異チェックから売上回収に引継ぐデータ（釣機紙幣）
        return pCom.dbStrOpnCls.strcls_pick_chgbill;
      case StrOpnClsCodeList.STRCLS_PICK_CHGCOIN:	//差異チェックから売上回収に引継ぐデータ（釣機硬貨）
        return pCom.dbStrOpnCls.strcls_pick_chgcoin;
      case StrOpnClsCodeList.STRCLS_CLOSE_PICK:	//従業員精算処理
        return pCom.dbStrOpnCls.strcls_close_pick;
      case StrOpnClsCodeList.STRCLS_PICK_AUTO:	//差異チェックデータ引継ぐ時売上回収自動実行
        return pCom.dbStrOpnCls.strcls_pick_auto;
      case StrOpnClsCodeList.STRCLS_PICK_PRINT:	//売上回収レポート印字
        return pCom.dbStrOpnCls.strcls_pick_print;
      case StrOpnClsCodeList.STRCLS_CASH_RECYCLE:	//上位サーバー接続時キャッシュリサイクル実行
        if ((pCom.manulStrcls != 0) || (await CmCksys.cmAcxCnct() == 0) ||
            ((await Recog().recogGet(
                tid,
                RecogLists.RECOG_ASSIST_MONITOR,
                RecogTypes.RECOG_GETSYS)).result == RecogValue.RECOG_NO)) {
          return 0;
        }
        return pCom.dbStrOpnCls.strcls_cash_recycle;
      case StrOpnClsCodeList.STRCLS_CPICK:		//釣機回収
        return pCom.dbStrOpnCls.strcls_cpick;
      case StrOpnClsCodeList.STRCLS_CPICK_SKIP:	//釣機回収スキップ操作
        return pCom.dbStrOpnCls.strcls_cpick_skip;
      case StrOpnClsCodeList.STRCLS_CPICK_PRINT:	//釣機回収レポート印字
        return pCom.dbStrOpnCls.strcls_cpick_print;
      case StrOpnClsCodeList.STRCLS_CPICK_COIN_POSITN:	//釣機回収硬貨搬送先
        return pCom.dbStrOpnCls.strcls_cpick_coin_positn;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER:	//精算後予約レポート印字
        return pCom.dbStrOpnCls.strcls_repo_after;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL1:	//精算後出力予約レポート１
        return pCom.dbStrOpnCls.strcls_repo_after_sel1;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL2:	//精算後出力予約レポート２
        return pCom.dbStrOpnCls.strcls_repo_after_sel2;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL3:	//精算後出力予約レポート３
        return pCom.dbStrOpnCls.strcls_repo_after_sel3;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL4:	//精算後出力予約レポート４
        return pCom.dbStrOpnCls.strcls_repo_after_sel4;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL5:	//精算後出力予約レポート５
        return pCom.dbStrOpnCls.strcls_repo_after_sel5;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL6:	//精算後出力予約レポート６
        return pCom.dbStrOpnCls.strcls_repo_after_sel6;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL7:	//精算後出力予約レポート７
        return pCom.dbStrOpnCls.strcls_repo_after_sel7;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL8:	//精算後出力予約レポート８
        return pCom.dbStrOpnCls.strcls_repo_after_sel8;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_SEL9:	//精算後出力予約レポート９
        return pCom.dbStrOpnCls.strcls_repo_after_sel9;
      case StrOpnClsCodeList.STRCLS_REPO_AFTER_AUTO:	//精算後予約レポート自動発行
        return pCom.dbStrOpnCls.strcls_repo_after_auto;
      case StrOpnClsCodeList.STRCLS_END_REPO:	//閉設時精算レポート出力
        return pCom.dbStrOpnCls.strcls_end_repo;
      case StrOpnClsCodeList.STRCLS_WAIT_TIME:	//閉設処理実行の待ち時間（１～10分） 0:手動
        if (pCom.dbStrOpnCls.strcls_time_sel > 0) {
          return 0;
        }
        return pCom.dbStrOpnCls.strcls_wait_time;
      case StrOpnClsCodeList.STRCLS_TIME_SEL:	//閉設処理実行時間 0:待ち時間　1：指定時刻
        return pCom.dbStrOpnCls.strcls_time_sel;
      case StrOpnClsCodeList.STRCLSOPNCLS_MANUAL:	//開閉設手動操作
        return pCom.dbStrOpnCls.stropncls_manual;
      case StrOpnClsCodeList.FORCESTRCLS_WAIT:	//強制閉設ダイアログの表示時間(1〜99分)
        return pCom.dbStrOpnCls.forcestrcls_wait;
      case StrOpnClsCodeList.FORCESTRCLS_LIMIT:	//強制閉設複数回実行
        return pCom.dbStrOpnCls.forcestrcls_limit;
      case StrOpnClsCodeList.STRCLS_CHKDLG_TIME:	//アシストモニター精算業務指示ダイアログの表示時間
        return pCom.dbStrOpnCls.strcls_dlg_time;
      default:
        String log = "strOpnClsSetChk(): Chk_num Error[${chkNum.name}]";
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
        autoStrClsLogWrite(tid, log, -1);
        return AplLib.AUTOLIB_ERROR;
    }
  }

  /// auto.iniの値を返す（精算キャッシャーオープン従業員）
  /// 引数:[tid] タスクID
  /// 戻値:auto.iniの値
  ///  関連tprxソース: AplLib_Auto.c - AplLib_AutoGetIni_staffcls_cshr()
  static Future<int> getIniStaffClsCshr(TprMID tid) async {
    if (aplLibAutoGetMem(tid) == 0) {
      return 0;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "getIniStaffClsCshr(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    int opnClsCd = 0;
    String tmpEntry = "";
    if (getForceClsRunMode(tid) != 0) {
      (tmpEntry, opnClsCd) = await CmStf.apllibStaffCdEdit(tid, 0, 999999, 0);
      return int.parse(tmpEntry);
    }

    if (pCom.dbStrOpnCls.strcls_cashier_login > 0) {
      // 閉店キャッシャーNo.が設定されていない場合は、手動
      return pCom.dbRegCtrl.autoClsCshrCd;
    }
    return pCom.dbStrOpnCls.strcls_cashier_login;  //手動
  }

  /// auto.iniの値を返す（キャッシャーオープン従業員）
  /// 引数:[tid] タスクID
  /// 戻値:auto.iniの値
  ///  関連tprxソース: AplLib_Auto.c - AplLib_AutoGetIni_staffopn_cshr()
  static Future<int> getIniStaffOpnCshr(TprMID tid) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "getIniStaffOpnCshr(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (await strOpnClsSetChk(tid, StrOpnClsCodeList.STROPN_CASHIER_LOGIN) > 0) {
      //自動
      return pCom.dbRegCtrl.autoOpnCshrCd;	//開店キャッシャーNo.が設定されていない場合は、手動
    }
    return 0;  //手動
  }

  /// auto.iniの値を返す（チェッカーオープン従業員）
  /// 引数:[tid] タスクID
  /// 戻値:0=手動  1=自動  -1=使用しない
  ///  関連tprxソース: AplLib_Auto.c - AplLib_AutoGetIni_staffopn_chkr()
  static Future<int> getIniStaffOpnChkr(TprMID tid) async {
    if (aplLibAutoGetMem(tid) == 0) {
      return 0;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "getIniStaffOpnChkr(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    int	ret = await strOpnClsSetChk(tid, StrOpnClsCodeList.STROPN_CHECKER_LOGIN);
    switch (ret) {
      case 2:
        if (pCom.dbRegCtrl.autoOpnChkrCd <= 0) {
          //開店チェッカーNo.が設定されていない場合は＝手動
          return 0;
        }
        return pCom.dbRegCtrl.autoOpnChkrCd;
      default	:	//0:しない 1:自動
        return ret - 1;
    }
  }

  /// 強制閉設中かチェックするの実行状態を取得
  /// 引数:[tid] タスクID
  /// 戻値: 0=閉設中でない  1=閉設中
  ///  関連tprxソース: AplLib_Auto.c - AplLib_AutoGetForceClsRunMode()
  static int getForceClsRunMode(TprMID tid) {
    if (aplLibAutoGetMem(0) == 0) {
      return 0;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "getForceClsRunMode(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if ((pCom.forceStreClsFlg & 0x01) > 0) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal, "getForceClsRunMode(): ON");
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: AplLib_Auto.c - AplLib_CMAuto_Step_Get()
  static (int, String) aplLibCMAutoStepGet(TprMID tid, String stepName) {
    int mode = 0;
    int step = 0;
    String msg = '';
    mode = aplLibAutoGetAutoMode(tid);

    AutoMode def = AutoMode.getDefine(mode);
    switch (def) {
      case AutoMode.AUTOMODE_PASSWORD: // 精算業務(パスワード)
        msg = msg + LAplLib.APLLIB_CMAUTO_START;
        step = AutoStep.AUTOSTEP_STRCLS_START.val;
        break;
      case AutoMode.AUTOMODE_ACXDRWCHK: // 釣機の在高チェック
      case AutoMode.AUTOMODE_RECALC: // 釣機再精査
        if (AcxCom.ifAcbSelect() & CoinChanger.RT_300_X != 0) {
          msg = msg + LAplLib.APLLIB_CMAUTO_RECALC2;
        } else {
          msg = msg + LAplLib.APLLIB_CMAUTO_RECALC;
        }
        step = AutoStep.AUTOSTEP_RECALC.val;
        break;
      case AutoMode.AUTOMODE_BATREPO: // 精算前予約レポート出力
      case AutoMode.AUTOMODE_BATREPO2: // 精算後予約レポート出力２
        msg = msg + LAplLib.APLLIB_CMAUTO_BATREPO;
        step = AutoStep.AUTOSTEP_BATREPO.val;
        break;
      case AutoMode.AUTOMODE_KY_OVERFLOW_MENTE: // ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ
        msg = msg + LAplLib.APLLIB_CMAUTO_OVERFLOW_MENTE;
        step = AutoStep.AUTOSTEP_OVERFLOW_MENTE.val;
        break;
      case AutoMode.AUTOMODE_KY_DRWCHK: // 差異チェック
        msg = msg + LAplLib.APLLIB_CMAUTO_DRWCHK;
        step = AutoStep.AUTOSTEP_DRWCHK.val;
        break;
      case AutoMode.AUTOMODE_KY_PICK: // 売上回収
        msg = msg + LAplLib.APLLIB_CMAUTO_PICK;
        step = AutoStep.AUTOSTEP_PICK.val;
        break;
      case AutoMode.AUTOMODE_KY_CHGPICK: // 釣機回収
        msg = msg + LAplLib.APLLIB_CMAUTO_CHGPICK;
        step = AutoStep.AUTOSTEP_CHGPICK.val;
        break;
      case AutoMode.AUTOMODE_STAFFCLOSE: // 従業員クローズ
      case AutoMode.AUTOMODE_STAFF2CLOSE: // 簡易従業員２人制クローズ
        msg = msg + LAplLib.APLLIB_CMAUTO_STAFFCLS;
        step = AutoStep.AUTOSTEP_STAFFCLS.val;
        break;
      case AutoMode.AUTOMODE_PBCHGUTIL: // 収納業務
        msg = msg + LAplLib.APLLIB_CMAUTO_PBCHGUTIL;
        step = AutoStep.AUTOSTEP_PGCHGUITIL.val;
        break;
      case AutoMode.AUTOMODE_STRCLS: // 閉設処理
        msg = msg + LAplLib.APLLIB_CMAUTO_STRCKS;
        step = AutoStep.AUTOSTEP_STRCLS.val;
        break;
      case AutoMode.AUTOMODE_CM_CHGOUT: //キャッシュマネジメント出金
        msg = msg + LAplLib.APLLIB_CMAUTO_CHGOUT;
        step = AutoStep.AUTOSTEP_RECYCLE_CHGOUT.val;
        break;
      case AutoMode.AUTOMODE_CM_CHGIN: //キャッシュマネジメント入金
        msg = msg + LAplLib.APLLIB_CMAUTO_CHGIN;
        step = AutoStep.AUTOSTEP_RECYCLE_CHGIN.val;
        break;
      case AutoMode.AUTOMODE_SALEINFO_SEND: // 売上情報送信
        msg = msg + LAplLib.APLLIB_CMAUTO_INFO_SEND;
        step = AutoStep.AUTOSTEP_SALEINFO_SEND.val;
        break;
      case AutoMode.AUTOMODE_STRCLS_QCMENTE: // QCashierメンテナンス
      default:
        msg = msg + LAplLib.APLLIB_CMAUTO_START;
        step = AutoStep.AUTOSTEP_NONE.val;
        break;
    }

    msg = '';
    stepName = sprintf("%s", [msg]);

    return (step, stepName);
  }

  /// 機能：自動開閉設の動作モードを取得
  /// 引数：
  /// 戻値：-1　　　異常
  /// -1以外　自動開閉設処理の動作モード
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoGetAutoMode()
  static int aplLibAutoGetAutoMode(TprMID tid){
    if(aplLibAutoGetMem(tid) == 0) {
      return (AplLib.AUTOLIB_ERROR);
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
        "aplLibAutoGetAutoMode(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    aplLibLogWrite(tid);
    if(pCom.auto_stropncls_run != 0) {
      return pCom.iniMacInfo.internal_flg.auto_mode;
    }

    return 0;
  }

  /// 関数：int AplLib_LogWrite
  /// 機能：自動開閉設の動作ログを作成する
  /// 引数：
  /// 戻値：
  /// 関連tprxソース: AplLib_Auto.c - AplLib_LogWrite()
  static void aplLibLogWrite(TprMID tid){
    String erlog = '';
    String runBuf = '';
    String modeBuf = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "aplLibLogWrite(): rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    if(aplLibAutoGetMem(tid) == 0) {
      return;
    }

    runBuf = CmAry.setStringZero(65);
    modeBuf = CmAry.setStringZero(65);

    /* 開店準備/精算業務 */
    AutoRun def1 = AutoRun.getDefine(pCom.auto_stropncls_run);
    switch(def1){
      case AutoRun.AUTORUN_STROPN:
        runBuf = 'STROPN';
        break;
      case AutoRun.AUTORUN_STRCLS2:
        if(pCom.manulStrcls != 0) {
          runBuf = 'STRCLS(MANUAL)';
        }else{
          runBuf = 'STRCLS(CM)';
        }
        break;
      default:
        return;
    }

    /* 動作モード */
    AutoMode def2 = AutoMode.getDefine(pCom.iniMacInfo.internal_flg.auto_mode);
    switch(def2) {
      case AutoMode.AUTOMODE_NON:				// なし(手動)
      //strncat( mode_buf, "NON", sizeof(mode_buf) - 1 );
        modeBuf = 'NON';
        break;

    // 開店動作
      case AutoMode.AUTOMODE_STROPN:			// 開設処理
      //strncat( mode_buf, "STROPN", sizeof(mode_buf) - 1 );
        modeBuf = 'STROPN';
        break;
      case AutoMode.AUTOMODE_STAFFOPEN:		// 従業員オープン
      //strncat( mode_buf, "STAFFOPEN", sizeof(mode_buf) - 1 );
        modeBuf = 'STAFFOPEN';
        break;
      case AutoMode.AUTOMODE_STROPN_QCMENTE:	// QCashierメンテナンス
      //strncat( mode_buf, "STROPN_QCMENTE", sizeof(mode_buf) - 1 );
        modeBuf = 'STROPN_QCMENTE';
        break;
      case AutoMode.AUTOMODE_KY_LOAN:			// 釣準備
      //strncat( mode_buf, "KY_LOAN", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_LOAN';
        break;
      case AutoMode.AUTOMODE_KY_LOAN_DATA:		// 釣準備実績自動作成（フレスタ様)
      //strncat( mode_buf, "KY_LOAN_AUTO", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_LOAN_AUTO';
        break;
      case AutoMode.AUTOMODE_KY_CHGREF:		// 釣機参照
      //strncat( mode_buf, "KY_CHGREF", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_CHGREF';
        break;
      case AutoMode.AUTOMODE_STROPN_QCMNTRET:	// QCashierメンテナンスから戻る
      // strncat( mode_buf, "STROPN_QCMNTRET", sizeof(mode_buf) - 1 );
        modeBuf = 'STROPN_QCMNTRET';
        break;
      case AutoMode.AUTOMODE_KY_2PERSON:		// 簡易従業員　２人制キー
      //strncat( mode_buf, "KY_2PERSON", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_2PERSON';
        break;
      case AutoMode.AUTOMODE_2PERSON_CHKROPEN:	// 簡易従業員　チェッカーオープン
      //strncat( mode_buf, "2PERSON_CHKROPEN", sizeof(mode_buf) - 1 );
        modeBuf = '2PERSON_CHKROPEN';
        break;

    // 閉店動作
      case AutoMode.AUTOMODE_PASSWORD:			// 精算業務(パスワード)
      //strncat( mode_buf, "PASSWORD", sizeof(mode_buf) - 1 );
        modeBuf = 'PASSWORD';
        break;
      case AutoMode.AUTOMODE_ACXDRWCHK:		// 釣機の在高チェック
      //strncat( mode_buf, "ACXDRWCHK", sizeof(mode_buf) - 1 );
        modeBuf = 'ACXDRWCHK';
        break;
      case AutoMode.AUTOMODE_RECALC:			// 釣機再精査
      //strncat( mode_buf, "RECALC", sizeof(mode_buf) - 1 );
        modeBuf = 'RECALC';
        break;
      case AutoMode.AUTOMODE_BATREPO:			// 精算前予約レポート出力
      // strncat( mode_buf, "BATREPO", sizeof(mode_buf) - 1 );
        modeBuf = 'BATREPO';
        break;
      case AutoMode.AUTOMODE_STRCLS_QCMENTE:	// QCashierメンテナンス
      //strncat( mode_buf, "STRCLS_QCMENTE", sizeof(mode_buf) - 1 );
        modeBuf = 'STRCLS_QCMENTE';
        break;
      case AutoMode.AUTOMODE_STAFF2CLOSE:		// 簡易従業員２人制クローズ
      //strncat( mode_buf, "STAFF2CLOSE", sizeof(mode_buf) - 1 );
        modeBuf = 'STAFF2CLOSE';
        break;
      case AutoMode.AUTOMODE_KY_OVERFLOW_MENTE:       // ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ
      //strncat( mode_buf, "KY_OVERFLOW_MENTE", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_OVERFLOW_MENTE';
        break;
      case AutoMode.AUTOMODE_KY_DRWCHK:		// 差異チェック
      //strncat( mode_buf, "KY_DRWCHK", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_DRWCHK';
        break;
      case AutoMode.AUTOMODE_KY_PICK:			// 売上回収
      //strncat( mode_buf, "KY_PICK", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_PICK';
        break;
      case AutoMode.AUTOMODE_CM_CHGOUT:             //キャッシュマネジメント出金
      //strncat( mode_buf, "RECYCLE_CHGOUT", sizeof(mode_buf) - 1 );
        modeBuf = 'RECYCLE_CHGOUT';
        break;
      case AutoMode.AUTOMODE_CM_CHGIN:              //キャッシュマネジメント入金
      //strncat( mode_buf, "RECYCLE_CHGIN", sizeof(mode_buf) - 1 );
        modeBuf = 'RECYCLE_CHGIN';
        break;
      case AutoMode.AUTOMODE_KY_CHGPICK:		// 釣機回収
      //strncat( mode_buf, "KY_CHGPICK", sizeof(mode_buf) - 1 );
        modeBuf = 'KY_CHGPICK';
        break;
      case AutoMode.AUTOMODE_STAFFCLOSE:		// 従業員クローズ
      //strncat( mode_buf, "STAFFCLOSE", sizeof(mode_buf) - 1 );
        modeBuf = 'STAFFCLOSE';
        break;
      case AutoMode.AUTOMODE_PBCHGUTIL:		// 収納業務
      //strncat( mode_buf, "PBCHGUTIL", sizeof(mode_buf) - 1 );
        modeBuf = 'PBCHGUTIL';
        break;
      case AutoMode.AUTOMODE_BATREPO2:			// 精算後予約レポート出力２
      //strncat( mode_buf, "BATREPO2", sizeof(mode_buf) - 1 );
        modeBuf = 'BATREPO2';
        break;
    // #if 0
    // case AutoMode.AUTOMODE_BATREPO3:			// 予約レポート出力
    //   //strncat( mode_buf, "BATREPO3", sizeof(mode_buf) );
    //   modeBuf = 'BATREPO3';
    //   break;
    // #endif
      case AutoMode.AUTOMODE_STRCLS:			// 閉設処理
      //strncat( mode_buf, "STRCLS", sizeof(mode_buf) - 1 );
        modeBuf = 'STRCLS';
        break;
      case AutoMode.AUTOMODE_SALEINFO_SEND:			// 売上情報送信
      //strncat( mode_buf, "INFOSEND", sizeof(mode_buf) - 1 );
        modeBuf = 'INFOSEND';
        break;
      case AutoMode.AUTOMODE_END:			// 終了
      //strncat( mode_buf, "END", sizeof(mode_buf) - 1 );
        modeBuf = 'END';
        break;
      default:
      //snprintf( mode_buf, sizeof(mode_buf), "%d", pCom->ini_macinfo.auto_mode );
        modeBuf = sprintf("%i", [pCom.iniMacInfo.internal_flg.auto_mode]);
        break;
    }

    erlog = sprintf("AUTO STROPNCLS: RUN[%s] MODE[%s]", [runBuf, modeBuf]);
    TprLog().logAdd(tid, LogLevelDefine.normal, erlog);
    autoStrClsLogWrite(tid, erlog, LogLevelDefine.normal);

    return;
  }

  /// 自動閉設のエラー中断フラグを変更する
  /// 引数:[tid] タスクID
  /// 関連tprxソース: AplLib_Auto.c - AplLib_StopMsg_FlgSet()
  static Future<void> aplLibStopMsgFlgSet(TprMID tid) async {
    if (aplLibAutoGetMem(tid) == 0) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "aplLibStopMsgFlgSet(): rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    if ((getForceClsRunMode(tid) != 0) ||
        (pCom.auto_stropncls_run == 0) ||
        (await CmCksys.cmWebType() != CmSys.WEBTYPE_WEB2800)) {
      return;
    }
    if (pCom.iniMacInfo.internal_flg.mode != 1) {
      return;
    }

    if (strCls(tid) != 0) {
      aplLibSetAutoStrClsError(tid, 0x04);	/* 自動閉設のエラー中断フラグをONにする */
    } else {
      aplLibSetAutoStrClsError(tid, 0x02);	/* 自動開設のエラー中断フラグをONにする */
    }
    if ((tid == Tpraid.TPRAID_CASH) &&
        (pCom.iniMacInfo.select_self.qc_mode == 1) &&
        (CmCksys.cmQCashierJCSystem() != 0)) {
      aplLibSetAutoStrClsError(tid, 0x08);	/* チェッカー側で画面表示する為 */
    }
  }

  /// 自動化メッセージを送信する
  /// 引数:[tid] タスクID
  /// 引数:[data] メッセージデータ
  /// 関連tprxソース: AplLib_Auto.c - AplLib_CMAuto_Msg_Send()
  static Future<int> aplLibCmAutoMsgSend(TprMID tid, String data) async {
    int step = 0;
    String str = "";

    if (aplLibCMAutoMsgSendChk(tid) != 0) {
      (step, str) = aplLibCMAutoStepGet(tid, "");
      autoStrClsLogWrite(tid, "Msg Send [$data]", LogLevelDefine.normal);
      return await MenteCall.mentecallStrclsResSend(tid, step, data);
    }
    return -1;
  }

  /// 自動閉設のエラー中断フラグを変更する
  /// 引数:[tid] タスクID
  /// 引数:[flg] 0=OFF  1=ON
  /// 関連tprxソース: AplLib_Auto.c - AplLib_SetAutoStrClsError()
  static void aplLibSetAutoStrClsError(TprMID tid, int flg) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
        "aplLibSetAutoStrClsError(): rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    if (flg == 0) {
      pCom.auto_strcls_errend = flg;
    } else {
      pCom.auto_strcls_errend |= flg;
    }
  }

  /// 自動開閉設中断を電子ジャーナルに記録する
  /// 引数:[tid] タスクID
  /// 引数:[ejFlg] 電子ジャーナル種別
  /// 引数:[errCode] エラーコード
  /// 引数:[ejStr] 電子ジャーナルに書込むデータ
  /// 関連tprxソース: AplLib_Auto.c - AplLib_Auto_EJ_Write()
  static void aplLibAutoEjWrite(TprMID tid, int ejFlg, int errCode, String? ejStr) {
    // TODO:10145 電子ジャーナル
    return;
  }


  /// 自動開閉設のエラー終了
  /// 引数:[tid] タスクID
  /// 引数:[errCode] エラーコード
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoStrOpnClsError()
  static Future<void> aplLibAutoStrOpnClsError(TprMID tid, int errCode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "AplLibAutoStrOpnClsError(): rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    String errLog = "AplLibAutoStrOpnClsError(): err[$errCode]";
    TprLog().logAdd(tid, LogLevelDefine.normal, errLog);
    autoStrClsLogWrite(tid, errLog, LogLevelDefine.error);

    String buf = "";
    String ptr = "";
    if (errCode > 0) {
      // TODO:10075 メッセージデータのテキスト管理
      /*
      ptr = TprLibMsgGet(errCode);
      if (ptr.isNotEmpty) {
        buf = "$ptr";
      } else {
        buf = "   ";
      }
       */
    }

    if (((await CmCksys.cmDesktopCashierSystem() != 0) ||
        ((CmCksys.cmQCashierJCSystem() != 0) &&
         (pCom.iniMacInfo.select_self.qc_mode == 1))) && (strCls(tid) != 0)) {
      aplLibSetAutoStrClsError(tid, 1);	/* 自動閉設のエラー中断フラグをONにする */
    } else if ((await CmCksys.cmHappySelfAllSystem() != 0) &&
        (pCom.iniMacInfo.select_self.hs_start_mode != 0) &&
        (AplLibAutoGetRunMode(tid) == AutoRun.AUTORUN_STROPN.val)) {
      aplLibSetAutoStrClsError(tid, 1);
    }
    await aplLibStopMsgFlgSet(tid);

    aplLibAutoEjWrite(tid, AutoLibEj.AUTOLIB_EJ_ERROR.value, errCode, buf);
    aplLibCMAutoErrMsgSend(tid, errCode);
    await aplLibCmAutoMsgSend(tid, AutoMsg.AUTO_MSG_CNCL);

    await aplLibAutoSetRunMode(tid, AutoMode.AUTOMODE_NON.val);
    await aplLibAutoSetAutoMode(tid, AutoMode.AUTOMODE_NON.val);
    await RmDBRead().rmDbStropnclsRead();
    if ((pCom.forceStreClsFlg & 0x01) != 0) {
      pCom.forceStreClsFlg &= ~0x01;
    }
    if ((pCom.forceStreClsFlg & 0x02) != 0) {
      pCom.forceStreClsFlg &= ~0x02;
    }
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース: AplLib_Auto.c - AplLib_AutoNextAutoMode()
  static int aplLibAutoNextAutoMode(TprMID tid) {
    return 0;
  }

  /// 機能：自動閉設のエラー中断フラグを確認する。
  /// 戻値：0：OFF 1：ON
  /// 関連tprxソース: AplLib_Auto.c - AplLib_ChkAutoStrClsError
  static int aplLibChkAutoStrClsError(TprMID tid) {
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (aplLibAutoGetMem(tid) == 0) {
      return AplLib.AUTOLIB_ERROR;
    }

    ret = pCom.auto_strcls_errend;

    return ret;
  }
}
