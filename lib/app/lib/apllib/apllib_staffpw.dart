/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../webapi/src/webapi.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/operation_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/ean.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/lib/L_AplLib_StaffPW.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/checker/rc_clxos.dart';
import '../../regs/checker/rc_key_stf.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../cm_jan/clk_jan.dart';
import '../cm_jan/set_jinf.dart';
import '../cm_jan/set_zero.dart';
import '../cm_sys/cm_cksys.dart';
import '../cm_sys/cm_stf.dart';
import '../if_scan/if_scan.dart';
import 'apllib_auto.dart';
import 'opncls_lib.dart';
import 'rm_db_read.dart';
import 'staff_auth.dart';

/// 従業員パラメタ
///  関連tprxソース: staffpw.h - staff_data
class StaffData {
  /// 従業員番号
  int staffCd = 0;
  /// 従業員名
  String staffName = "";
  /// パスワード
  String passwd = "";
  /// 個人情報保護法案仕様（0:使用でない  1:仕様）
  //int custclrSystem = 0;
  /// 従業員パスワード画面表示中フラグ
  int staffPwFlg = 0;
  /// 従業員パスワード設定済みフラグ
  //int	staffCdFlg = 0;
  /// 電子ジャーナルヘッダー用のmode
  /// （5:メンテナンス  6:ファイル確認  7:売上点検  8:売上精算  9:設定  13:ユーザーセットアップ  15:売上速報）
  //int reptMode = 0;
  /// DUAL仕様フラグ
  int dualTSingle = 0;
  /// 印字する顧客No（0:印字なし）
  //String ejCustNo = "";
  /// 設定従業員番号（従業員マスタ設定のみ使用。 0:印字なし）
  //int ejSetStaffCd = 0;
  /// 電話番号（会員番号変更設定使用。 0:印字なし）
  //String ejTelNo = "";
  /// 顧客件数（0:印字なし）
  ///  [reptMode = 6] 顧客全件件数（顧客マスタファイル確認）
  ///  [reptMode = 7,8,15] 顧客出力件数（CDバックアップ時は顧客マスタの全件数）
  //int ejAllCnt = 0;
  /// 機能モード（0:印字なし）
  ///  [reptMode = 9] 1:新規  2:変更  3:削除（従業員マスタ設定使用）
  ///  [reptMode = 7,8,15] 1:レシート出力  2:ネットワークプリンター出力  3:CDバックアップ
  ///  [reptMode = 5] 1:通信  2:CD
  //int ejMode = 0;
  /// 中断印字（顧客マスタファイル確認、レポート使用。 0:印字なし）
  //int ejStopFlg = 0;
  /// 権限チェックキー
  int chkLvl = 0;
  /// 従業員番号判別
  int chkMax = 0;
  /// 権限チェックキー
  int chkLvl2 = 0;
  /// 従業員番号判別
  int chkMax2 = 0;
  /// 従業員レベル
  int staffLvl = 0;
  /// オープン処理実行フラグ（0:実行しない＝オープン中  1:実行する＝クローズ中）
  int staffOpen = 1;
  /// 自動で従業員番号をセットするフラグ
  int staffCdInput = 0;
  /// 特定調査権限チェック（0:する　 1:しない）
  int chkOperate = 0;
  /// 登録モード従業員入力処理中チェック（0:しない　 1:する）
  int regsExeFlgChk = 0;
  /// 手入力フラグ（0:する　 1:しない）
  int manuInput = 0;
  /// スキャン時パスワード入力フラグ（0:する　 1:しない）
  //int scanPwChk = 0;
  /// イベントデータタイプ
  //int eventTyp = 0;
  /// スキャンフラグ（0:手入力  1:スキャニング）
  int scanFlg = 0;
}

/// 従業員パラメタ（AplLibStaffPwクラス用）
///  関連tprxソース: AplLib_StaffPW.c - STAFFPASS
class StaffPass {
  /// タスクID
  int tid = 0;
  /// 従業員入力桁数
  int beam = 0;
  /// 入力種別フラグ（0:従業員番号  1:パスワード）
  int	inpFlg = 0;
  /// 入力開始フラグ
  int inpStart = 0;
  /// ダイアログ出力フラグ
  int msgFlg = 0;
  /// 入力文字列（20文字）
  String inpCode = "";
  /// スキャン読取データ（24+1文字）
  String scanBuf = "";
  /// 従業員パラメタ
  StaffData staffData = StaffData();
  /// 実行フラグ
  int exeFlg = 0;
  /// 同時オープン可能フラグ
  int noChkOverlap = 0;
  /// 従業員一覧表示フラグ
  int flgStaffList = 0;
  /// レジ番号
  int macNo = 0;
}

/// WebAPI「従業員オープンクローズの状態確認」のレスポンス
class ApiCheckRes {
  /// 返答ステータス（0=エラーなし  1=エラー発生）
  int retSts = 0;
  /// エラーメッセージ（エラーなしの時はセットしない）
  String errMsg = "";
  /// チェッカーの状態（0=クローズ  1=オープン  2=オフ）
  int chkrStatus = 0;
  /// キャッシャーの状態（0=クローズ  1=オープン  2=オフ）
  int cshrStatus = 0;
}

/// WebAPI「従業員オープンクローズの更新」のレスポンス
class ApiUpdateRes {
  /// 返答ステータス（0=エラーなし  1=エラー発生）
  int retSts = 0;
  /// エラーメッセージ（エラーなしの時はセットしない）
  String errMsg = "";
}

///  関連tprxソース: AplLib_StaffPW.c
class AplLibStaffPw {
  static const ENDTYPE_NORMAL = 0;
  static const ENDTYPE_DECISION = 1;
  static const ENDTYPE_STRCLS = 2;
  static const ENDTYPE_STROPN = 3;
  static const ENDTYPE_REGSEND = 4;
  static const STAFFPW_DEBUG_LOG = 1;

  static StaffPass staffPw = StaffPass();

  /// 「確定」ボタン押下時の処理（従業員番号またはパスワードの入力チェック）
  /// 引数:[data] 画面終了フラグ
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_input_button()
  static Future<void> staffPwInputButton(int data) async {
    // ダイアログ出力中＆実行中かチェック
    if ((staffPw.msgFlg == Typ.ON) || (staffPw.exeFlg != 0)) {
      return;
    }

    debugPrint("***** staffPwInputButton():push");
    staffPw.flgStaffList = Typ.OFF;

    // 各種フラグ＆従業員番号を設定
    exeFlgSet(1);
    if (staffPw.inpStart == 0) {
      if (staffPw.inpFlg == 0) {
        String strRet = "";
        int tmpRet = 0;   //関数戻り値用
        (strRet, tmpRet) = await CmStf.apllibStaffCdEdit(staffPw.tid, 3, staffPw.staffData.staffCd, 0);
        staffPw.inpCode = strRet;
      }
      staffPw.inpStart = 1;
    }

    int ret = 0;
    int scanTyp = 0;
    String scanBuf = "";
    JANInf ji = JANInf();
    if (staffPw.inpFlg == 0) {
      staffPw.beam = await CmStf.apllibStaffCDInputLimit(2);
      // スキャンデータの確認
      if (staffPw.scanBuf.isNotEmpty) {
        ji.code = SetZero.cmPluSetZero(staffPw.scanBuf);
        scanBuf = staffPw.scanBuf;
        staffPw.scanBuf = "";
        await SetJinf.cmSetJanInf(ji, 0, 1);
        if ((ji.type != JANInfConsts.JANtypeClerk) &&
            (ji.type != JANInfConsts.JANtypeClerk2) &&
            (ji.type != JANInfConsts.JANtypeClerk3)) {
          // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
          /*
          apllib_StaffPW_ChgStyle(0);
           */
          //バーコードフォーマットエラー
          staffPwMessage(DlgConfirmMsgKind.MSG_BARFMTERR.dlgId, 1, Typ.ON);
          exeFlgSet(0);
          return;
        }
        if (ji.type == JANInfConsts.JANtypeClerk3) {
          int stfLen = await CmStf.apllibStaffCDInputLimit(2);
          int stfBgn = Ean.ASC_EAN_13 - stfLen - 1;
          int inData = int.parse(ji.code.substring(stfBgn, stfBgn + stfLen));
          if (inData == 0) {
            TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
                "staffPwInputButton(): ji.type=JANtype_CLERK_3 zero err");
            // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
            /*
            apllib_StaffPW_ChgStyle(0);
             */
            staffPwMessage(DlgConfirmMsgKind.MSG_INPUTERR.dlgId, 1, Typ.ON);
            exeFlgSet(0);
            return;
          }
        }
        scanTyp = 1;
      }
      // DBから従業員コードを読み取る
      ret = await readCheckStaff(scanTyp);
      if (ret > 0) {
        // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
        /*
        apllib_StaffPW_ChgStyle(0);
         */
        staffPwMessage(ret, 1, Typ.ON);
        exeFlgSet(0);
        return;
      }
      if ((data == 1) &&
          ((checkPassword(scanTyp) == 0)	|| (checkAutoOpen() != 0))) {
        // パスワード強制従業員かチェック
        if (staffPw.staffData.staffOpen != 0) {
          // 従業員オープンする
          ret = await staffPwOpen();	// 他オープンチェック＆従業員オープン
          if (ret != 0) {
            // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
            /*
            apllib_StaffPW_ChgStyle(0);
             */
            staffPwMessage(ret, 1, Typ.ON);
            exeFlgSet(0);
            return;
          }
        }
        staffPwEndButtonMain(ENDTYPE_DECISION);
        exeFlgSet(0);
        if (await CmCksys.cmFSelfMbrScan2ndScannerUse() != 0) {
          IfScan.happy2ndScannerEnable();
        }
        return;
      }
      // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
      //apllib_StaffPW_ChgStyle(1);
    } else {
      // TODO:10122 グラフィックス処理（画面構成パーツ_ボタン種類を判定）
      /*
      if ((widget == staffPw.staffPwPassBtn) || (widget == dualStaffPw.staffPwPassBtn)) {
        //「パスワード」ボタンでは従業員オープンできないため、return
        exeFlgSet(0);
        return;
      }
       */
      // 入力パスワードとDB登録パスワードを確認する
      if (readCheckPw(staffPw.inpCode) != 0) {
        // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
        /*
        apllib_StaffPW_ChgStyle(1);
         */
        //パスワードが違います
        staffPwMessage(DlgConfirmMsgKind.MSG_PWDDIFFER.dlgId, 1, Typ.ON);
        exeFlgSet(0);
        return;
      }
      if (staffPw.staffData.staffOpen != 0) {
        // 従業員オープンする
        ret = await staffPwOpen();	// 他オープンチェック＆従業員オープン
        if (ret != 0) {
          // TODO:10122 グラフィックス処理（画面構成パーツの表示パラメタを更新）
          /*
          apllib_StaffPW_ChgStyle(1);
           */
          staffPwMessage(ret, 1, Typ.ON);
          exeFlgSet(0);
          return;
        }
      }
      staffPwEndButtonMain(ENDTYPE_DECISION);
      if (await CmCksys.cmFSelfMbrScan2ndScannerUse() != 0) {
        await IfScan.happy2ndScannerEnable();
      }
    }
    exeFlgSet(0);
  }

  /// 終了ボタンを表示する
  /// 引数:[data] 画面終了フラグ
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_end_button_main()
  static void staffPwEndButtonMain(int data) {
    switch (data) {
      case 0:
        staffPw.staffData.staffCd = Typ.OFF;
        break;
      case 1:
        staffPw.staffData.staffCd = Typ.ON;
        break;
      case 2:
        staffPwDlg(DlgConfirmMsgKind.MSG_STOP_SETTL_BUSI_CONF.dlgId);
        break;
      default:
        break;
    }
    staffPw.staffData.staffPwFlg = 0;
  }

  /// 確認ダイアログを表示する
  /// 引数:[errCode] 表示するエラーコード
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_Dlg()
  static void staffPwDlg(int errCode) {
    tprDlgParam_t param = tprDlgParam_t();

    param.erCode = errCode;
    param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
    param.title = LTprDlg.BTN_CONF;

    MsgDialog.show(MsgDialog.twoButtonDlgId(
      dialogId: errCode,
      type: MsgDialogType.info,
      leftBtnFnc: (){
        Get.back();
      },
      leftBtnTxt: "はい",
      rightBtnFnc: (){
        Get.back();
      },
      rightBtnTxt: "いいえ",
    ));
  }

  /// エラーダイアログを表示する
  /// 引数:[errCode] 表示するエラーコード
  /// 引数:[userCode] ユーザーコード
  /// 引数:[bz] ブザー鳴動フラグ
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_message()
  static void staffPwMessage(int errCode, int userCode, int bz) {
    if (staffPw.macNo != 0) {
      TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
          "staffPwMessage(): errCode:$errCode userCode:$userCode macNo:${staffPw.macNo}");
    } else {
      TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
          "staffPwMessage(): errCode:$errCode userCode:$userCode");
    }

    tprDlgParam_t param = tprDlgParam_t();
    param.erCode = errCode;
    param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
    param.title = LAplLibStaffPw.STAFFPW_ERR;
    param.userCode = userCode;
    if (staffPw.macNo != 0) {
      param.msgBuf = "${staffPw.macNo}".padLeft(6, "0");
      staffPw.macNo = 0;
    }

    if (CompileFlag.FB2GTK) {
      if (staffPw.tid == Tpraid.TPRAID_CASH) {
        //param.dualDev = 1;
      } else if (staffPw.tid == Tpraid.TPRAID_CHK) {
        if (staffPw.staffData.dualTSingle == 1) {
          //param.dualDsp = 2;
          //param.dualDev = 1;
        }
      }
    }
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errCode,
      ),
    );
    staffPw.msgFlg = Typ.ON;
  }


  /// DBから従業員コードを読み取る
  /// 引数:[scanTyp] スキャンタイプ
  /// 戻値:エラーコード（0:エラーなし = DBに指定の従業員番号がある）
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_read_staff()
  static Future<int> readCheckStaff(int scanTyp) async {
    debugPrint("***** readCheckStaff(): call scan_typ[$scanTyp]");
    TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
        "readCheckStaff(): call staff[${staffPw.inpCode}]");

    // 従業員番号を編集
    String strStaffNo = "";
    String strStaffNo2 = "";
    int tmpRet = 0;   //関数戻り値用
    if (scanTyp == 0) {
      (strStaffNo, tmpRet) = await CmStf.apllibStaffCdEdit(staffPw.tid, 0, int.parse(staffPw.inpCode), 0);
    } else {
      (strStaffNo, tmpRet) = await CmStf.apllibStaffCdEdit(staffPw.tid, 3, int.parse(staffPw.inpCode), 0);
      (strStaffNo2, tmpRet) = await CmStf.apllibStaffCdEdit(staffPw.tid, 1, int.parse(staffPw.inpCode), 0);
      // TODO:10122 グラフィックス処理（従業員番号とパスワード表示時、先頭にスペースを入れる）
      /*
      apllib_StaffPW_set_text(GTK_ROUND_ENTRY(staffPw.staffPwStaffEnt), strStaffNo2);
      if( Dual_StaffPW.StaffPWWin != NULL) {
        apllib_StaffPW_set_text(GTK_ROUND_ENTRY(dualStaffPw.staffPwStaffEnt), strStaffNo2);
      }
       */
    }
    TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
        "readCheckStaff(): search_staff[$strStaffNo]");

    // DBから従業員番号とパスワードを取得＆取得した従業員番号が無効であるかチェック
    int staffNo = int.parse(strStaffNo);
    staffPw.staffData.staffName = "";
    staffPw.staffData.passwd = "";
    OpnClsLibRet ret1 = await OpnClsLib.cmOpnClsReadStaff(staffPw.tid, staffNo);
    if (!ret1.isSuccess) {
      TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
          "readCheckStaff(): c_staff_mst tuples == 0");
      if (ret1.errMsgId == DlgConfirmMsgKind.MSG_NONEREC.dlgId) {
        return DlgConfirmMsgKind.MSG_CLKNONFILE.dlgId;
      } else {
        return ret1.errMsgId;
      }
    }

    // 権限レベルのチェック：従業員
    int ret2 = 0;
    if (staffPw.staffData.staffLvl != 0) {
      ret2 = await StaffAuth.menuAuthChk(staffPw.tid, staffPw.staffData.staffLvl, staffNo);
      if (ret2 > 0) {
        debugPrint("***** readCheckStaff(): StaffAuth.menuAuthChk() ret[$ret2]");
        return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
      }
    }

    // 権限レベルのチェック：権限キー
    int lvl = 0;
    if (staffPw.staffData.chkLvl != 0) {
      lvl = await StaffAuth.keyAuthChk(staffPw.tid, staffNo, staffPw.staffData.chkLvl);
      TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
          "readCheckStaff(): check level[${staffPw.staffData.chkLvl} = $lvl]");
      if (lvl > 0) {
        TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
            "readCheckStaff(): check level error");
        return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
      }
    }
    if (staffPw.staffData.chkLvl2 != 0) {
      lvl = await StaffAuth.keyAuthChk(staffPw.tid, staffNo, staffPw.staffData.chkLvl2);
      TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
          "readCheckStaff(): check level2[${staffPw.staffData.chkLvl2} = $lvl]");
      if (lvl > 0) {
        TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
            "readCheckStaff(): check level2 error");
        return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
      }
    }

    // 特定捜査権限チェック
    if ((staffPw.staffData.chkOperate > 0) &&
        (staffPw.staffData.chkOperate != OperationLists.OPE_CHECK_PASSWORD.id)) {
      if (await checkOpe(staffNo, staffPw.staffData.chkOperate) > 0) {
        return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
      }
    }

    staffPw.staffData.staffCd = staffNo;
    staffPw.staffData.passwd = ret1.passwd;
    staffPw.noChkOverlap = ret1.noChkOverlap;
    debugPrint("***** readCheckStaff(): normal end");
    return 0;
  }

  /// DBから従業員コードを読み取る（12ver）
  /// 引数:[inStr] 入力した従業員番号
  /// 戻値:エラーコード（0:エラーなし = DBに指定の従業員番号がある）
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_read_staff()
  static Future<int> readCheckStaff12ver(String inStr) async {
    DbManipulationPs db = DbManipulationPs();
    Result res;
    // 共有メモリの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    String sql = "SELECT * FROM c_staff_mst WHERE staff_cd='$inStr' AND comp_cd='${pCom
        .dbRegCtrl.compCd}';";
    TprLog().logAdd(staffPw.tid, LogLevelDefine.normal, sql);
    try {
      res = await db.dbCon.execute(sql);
      //「従業員が存在しない or 異常状態」かチェック
      if ((res.isEmpty) || (res.affectedRows > 1)) {
        TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
            "AplLibStaffPw.staffPwReadStaff():c_staff_mst record 0");
        return DlgConfirmMsgKind.MSG_NONEREC.dlgId;
      }
      // DBから各カラムパラメタを読み取り
      int staffNo = 0;
      String name = "";
      String passwd = "";
      int authLvl = 0;
      int authLvl2 = 0;
      int status = 0;
      int noChkOverlap = 0;
      for (var result in res) {
        Map<String, dynamic> data = result.toColumnMap();
        staffNo = int.parse(data["staff_cd"] ?? 0);
        name = data["name"] ?? "";
        passwd = data["passwd"] ?? "";
        authLvl = data["auth_lvl"];
        authLvl2 = data["svr_auth_lvl"];
        status = data["status"];
        noChkOverlap = data["nochk_overlap"];
        break;
      }
      // 削除従業員かチェック
      if (status == 2) {
        TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
            "AplLibStaffPw.staffPwReadStaff():c_staff_mst status=2");
        return DlgConfirmMsgKind.MSG_NONEREC.dlgId;
      }
      // 権限チェック（既存ソースから流用）
      int tmpNo = ((staffNo / 1000) % 10).toInt();
      if (staffPw.staffData.chkLvl != 0) {
        TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
            "AplLibStaffPw.staffPwReadStaff():c_staff_mst auth_lvl=$authLvl");
        switch (authLvl) {
          case 0:
            if (tmpNo < staffPw.staffData.chkMax) {
              TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
                  "AplLibStaffPw.staffPwReadStaff():auth_lvl Error");
              return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
            }
            break;
          case 2:
            TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
                "AplLibStaffPw.staffPwReadStaff():auth_lvl Error");
            return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
          default:
            break;
        }
      }
      if (staffPw.staffData.chkLvl2 != 0) {
        TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
            "AplLibStaffPw.staffPwReadStaff():c_staff_mst srv_auth_lvl=$authLvl2");
        switch (authLvl2) {
          case 0:
            if (tmpNo < staffPw.staffData.chkMax2) {
              TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
                  "AplLibStaffPw.staffPwReadStaff():srv_auth_lvl Error");
              return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
            }
            break;
          case 2:
            TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
                "AplLibStaffPw.staffPwReadStaff():srv_auth_lvl Error");
            return DlgConfirmMsgKind.MSG_EMPLOYEE_FORBIDDEN.dlgId;
          default:
            break;
        }
      }
      // パラメタを格納
      staffPw.staffData.staffCd = staffNo;
      staffPw.staffData.staffName = name;
      staffPw.staffData.passwd = passwd;
      staffPw.noChkOverlap = noChkOverlap;
      debugPrint(
          "***** staffPw.StaffData:{staffCd:$staffNo, staffName:$name, passwd:$passwd}, noChkOverlap:$noChkOverlap");
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
          "AplLibStaffPw.staffPwReadStaff():c_staff_mst read is NULL");
      return DlgConfirmMsgKind.MSG_FILEACCESS.dlgId;
    }
    return 0;
  }

  /// 入力したパスワードがDBに登録されたものかチェックする
  /// （前提条件：当関数の前に、readCheckStaff()を実行すること）
  /// 引数:[inStr] 入力したパスワード
  /// 戻値:エラーコード（0:エラーなし = パスワードがDBに登録されたものと一致）
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_input_button()
  static int readCheckPw(String inStr) {
    if (staffPw.staffData.passwd != inStr) {
      return DlgConfirmMsgKind.MSG_PWDDIFFER.dlgId;
    }
    return 0;
  }

  /// 他レジでの従業員オープン処理確認とデータベース更新処理
  /// 戻値:エラーコード（0:エラーなし = パスワードがDBに登録されたものと一致）
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_Open()
  static Future<int> staffPwOpen({int? checkerFlag}) async {
    //TODO: 10144 WebAPI無効化
    /*
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "staffPwOpen(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    // 従業員オープン確認
    ApiCheckRes getRes = ApiCheckRes();
    if (staffPw.noChkOverlap == 0) {
      getRes = await callGetOpenStaffAPI(pCom);
      if (getRes.retSts != 0) {
        return getRes.retSts;
      }
    } else {
      getRes.chkrStatus = 0;
      getRes.cshrStatus = 0;
    }

    // 従業員オープン更新
    ApiUpdateRes setRes = await callSetOpenStaffAPI(pCom, getRes);
    if (setRes.retSts != 0) {
      return setRes.retSts;
    }
     */

    // DBテーブル c_staffopen_mst を更新し、状態をオープン中に設定する
    await callOpenStaffAPI(checkerFlag);

    return 0;
  }

  /// WebAPI：従業員オープンクローズ状態確認
  /// 引数:[pCom] 共有クラス（RxCommonBuf）
  /// 戻り値: WebAPIのレスポンスデータ
  static Future<ApiCheckRes> callGetOpenStaffAPI(RxCommonBuf pCom) async {
    // WebAPIからレスポンスデータを取得する
    ApiCheckRes res = ApiCheckRes();
    String strRes = await WebAPI().getStaffOpencloseStatus(
        pCom.dbRegCtrl.compCd,
        pCom.dbRegCtrl.streCd,
        staffPw.staffData.staffCd
    );
    debugPrint("***** callGetOpenStaffAPI(): strRes = $strRes");

    // レスポンスデータを戻り値に格納する
    Map<String, dynamic> resMap = jsonDecode(strRes);
    res.retSts = int.parse(resMap["RetSts"]);
    res.errMsg = resMap["ErrMsg"];
    res.chkrStatus = int.tryParse(resMap["ChkrStatus"]) ?? 0;
    res.cshrStatus = int.tryParse(resMap["CshrStatus"]) ?? 0;

    return res;
  }

  /// WebAPI：従業員オープンクローズ更新
  /// 引数:[pCom] 共有クラス（RxCommonBuf）
  /// 引数:[chkRes] WebAPI「従業員オープンクローズ状態確認」のレスポンスデータ
  /// 戻り値: WebAPIのレスポンスデータ
  static Future<ApiUpdateRes> callSetOpenStaffAPI(
      RxCommonBuf pCom, ApiCheckRes chkRes) async {
    // WebAPIからレスポンスデータを取得する
    ApiUpdateRes res = ApiUpdateRes();
    String strRes = await WebAPI().setStaffOpenclose(
        pCom.dbRegCtrl.compCd,
        pCom.dbRegCtrl.streCd,
        pCom.dbRegCtrl.macNo,
        0,
        chkRes.chkrStatus,
        staffPw.staffData.staffCd,
        chkRes.cshrStatus
    );
    debugPrint("***** callSetOpenStaffAPI(): strRes = $strRes");

    // レスポンスデータを戻り値に格納する
    Map<String, dynamic> resMap = jsonDecode(strRes);
    res.retSts = int.parse(resMap["RetSts"]);
    res.errMsg = resMap["ErrMsg"];

    return res;
  }

  /// クラウドPOS：従業員オープンAPIのコール
  static Future<void> callOpenStaffAPI(int? checkerFlag) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "callOpenStaffAPI(): rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    // 従業員オープンフラグを実行しない＝オープン中の状態にする
    AplLibStaffPw.staffPw.staffData.staffOpen = 0;


    SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);

    CalcRequestStaff reqData = CalcRequestStaff(compCd: pCom.dbRegCtrl.compCd,
        streCd: pCom.dbRegCtrl.streCd,
        macNo: pCom.dbRegCtrl.macNo,
        staffCd: staffPw.staffData.staffCd.toString(),
        passwd: staffPw.staffData.passwd,
        scanFlag: staffPw.staffData.scanFlg,
        checkerFlag: checkerFlag);

    CalcResultStaff retData = await CalcApi.openStaff(reqData);
    if (0 != retData.retSts) {
      TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
          "AplLibStaffPw.callOpenStaffAPI() Error: ${retData.errMsg}");
      // TODO:WebAPIが正常動作したら生かす
      // return;
    }
    if (!RcClxosCommon.validClxos) {
        pCom.dbStaffopen.cshr_status = 1;
    } else {
      // DBを読みこみ直す
      await RmDBRead().rmDbStaffopenRead();
      debugPrint('pCom.dbStaffopen.chkr_status='+pCom.dbStaffopen.chkr_status.toString());
    }
  }

  /// クラウドPOS：従業員クローズAPIのコール
  static Future<void> callCloseStaffAPI({int? checkerFlag = null}) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "callCloseStaffAPI(): rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    // 従業員オープンフラグを実行する＝未オープンの状態にする
    AplLibStaffPw.staffPw.staffData.staffOpen = 1;

 
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);

    CalcRequestStaff reqData = CalcRequestStaff(compCd: pCom.dbRegCtrl.compCd,
        streCd: pCom.dbRegCtrl.streCd,
        macNo: pCom.dbRegCtrl.macNo,
        staffCd: staffPw.staffData.staffCd.toString(),
        checkerFlag: checkerFlag);

    CalcResultStaff retData = await CalcApi.closeStaff(reqData);
    if (0 != retData.retSts) {
      TprLog().logAdd(staffPw.tid, LogLevelDefine.error,
          "AplLibStaffPw.callCloseStaffAPI() Error: ${retData.errMsg}");
      // TODO:WebAPIが正常動作したら生かす
      // return;
    }
      if (!RcClxosCommon.validClxos) {
        pCom.dbStaffopen.cshr_status = 0;
    }else{
      // DBを読みこみ直す
      await RmDBRead().rmDbStaffopenRead();
      debugPrint('pCom.dbStaffopen.chkr_status='+pCom.dbStaffopen.chkr_status.toString());
    }
  }

  /// 画面表示前にセットされた従業員を自動でオープンする条件かチェック
  /// 戻値:0=オープンなし  1=オープンあり
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_Check_AutoOpen()
  static Future<int> checkAutoOpen() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "checkAutoOpen(): rxMemRead(stat) error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    RxMemRet xRetCmn = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCmn.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "checkAutoOpen(): rxMemRead(common) error");
      return 0;
    }
    RxCommonBuf pCom = xRetCmn.object;

    if (staffPw.staffData.staffOpen != 0) {
      // 従業員オープンする
      if ((AplLibAuto.strCls(staffPw.tid) != 0) &&
          (await AplLibAuto.getIniStaffClsCshr(staffPw.tid) != 0)) {
        // 自動精算中 & 精算時キャッシャー従業員自動入力設定中
        return 1;
      }
      if ((AplLibAuto.AplLibAutoGetRunMode(staffPw.tid) == AutoRun.AUTORUN_STROPN.val) &&
          (await AplLibAuto.getIniStaffOpnCshr(staffPw.tid) != 0)) {
        // 開店準備中 & 開店時キャッシャー従業員自動入力設定中
        return 1;
      }
      if ((AplLibAuto.aplLibAutoGetAutoMode(staffPw.tid) == AutoMode.AUTOMODE_2PERSON_CHKROPEN.val) &&
          (await AplLibAuto.getIniStaffOpnChkr(staffPw.tid) != 0)) {
        // 開店準備２人制チェッカー中 & 開店時チェッカー従業員自動入力設定中
        return 1;
      }
      if ((AplLibAuto.AplLibAutoGetRunMode(staffPw.tid) == AutoRun.AUTORUN_NON.val) &&
          (staffPw.staffData.staffCdInput == 2) &&
          (pCom.dbTrm.chkPasswordClkOpen != 2)) {
        // パスワード確認無（スキャナ）
        return 1;
      }
      if ((AplLibAuto.AplLibAutoGetRunMode(staffPw.tid) == AutoRun.AUTORUN_NON.val) &&
          (staffPw.staffData.staffCdInput == 1) &&
          (pCom.dbTrm.chkPasswordClkOpen == 0)) {
        // パスワード確認無（置数入力、プリセット入力）
        return 1;
      }
      if (tsBuf.chk.qcjc_frcclk_flg == 1) {
        // QCJC返信中
        return 1;
      }
    }
    return 0;
  }

  /// 特定操作権限をチェック
  /// 引数:[staffNo] 従業員番号
  /// 引数:[chkOpe] 特定操作コード
  /// 戻値:0=操作OK  1=操作禁止
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_Staff_CheckOpe()
  static Future<int> checkOpe(int staffNo, int chkOpe) async {
    int ret = await StaffAuth.operationAuthChk(staffPw.tid, staffNo, chkOpe);
    if (ret != 0) {
      TprLog().logAdd(staffPw.tid, LogLevelDefine.normal,
          "checkOpe(): operation NG");
      return (ret);
    }
    return ret;
  }

  /// 特定操作権限マスタの「ﾊﾟｽﾜｰﾄﾞ確認」が設定済みで、パスワード確認を強制する従業員かチェック
  /// 戻値:0=操作OK  1=操作禁止
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_CheckPassword()
  static Future<int> checkPassword(scanTyp) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "checkPassword(): rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.chkPasswordClkOpen == 2)	{
      // オープン時に従業員パスワード入力「する」
      return Typ.OK;
    }

    String strRet = "";
    int tmpRet = 0;   //関数戻り値用
    if (scanTyp == 0) {
      (strRet, tmpRet) = await CmStf.apllibStaffCdEdit(staffPw.tid, 0, int.parse(staffPw.inpCode), 0);
    } else {
      (strRet, tmpRet) = await CmStf.apllibStaffCdEdit(staffPw.tid, 3, int.parse(staffPw.inpCode), 0);
    }
    int staffNo = int.parse(strRet);
    int ret = await checkOpe(staffNo, OperationLists.OPE_CHECK_PASSWORD.id);

    return ret;
  }

  /// 実行フラグセット
  /// 引数:[flg] 実行フラグ
  ///  関連tprxソース: AplLib_StaffPW.c - apllib_Staff_Exeflg_Set()
  static void exeFlgSet(int flg) {
    staffPw.exeFlg = flg;
    if ((staffPw.tid == Tpraid.TPRAID_CHK) ||
        (staffPw.tid == Tpraid.TPRAID_CASH)) {
      if (staffPw.staffData.regsExeFlgChk != 0) {
        RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRetStat.isInvalid()) {
          TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
              "exeFlgSet(): rxMemRead(stat) error");
          return;
        }
        RxTaskStatBuf tsBuf = xRetStat.object;
        if (staffPw.tid == Tpraid.TPRAID_CASH) {
          if (flg != 0) {
            tsBuf.cash.staff_pw |= 0x02;
          } else {
            if ((tsBuf.cash.staff_pw & 0x02) > 0) {
              tsBuf.cash.staff_pw &= ~0x02;
            }
          }
        } else {
          if (flg != 0) {
            tsBuf.chk.staff_pw |= 0x02;
          } else {
            if ((tsBuf.chk.staff_pw & 0x02) > 0) {
              tsBuf.chk.staff_pw &= ~0x02;
            }
          }
        }
      }
    }
  }

  /// 従業員キー押下時の処理
  /// 戻値: エラーコード（0:エラーなし)
  static Future<int> staffKeyPressed() async {
    int ret = await RcKyStf.rcChkKyStaff(0);
    if (ret == 0) {
      await callCloseStaffAPI();
    }
    return ret;
  }

  /// 関連tprxソース: AplLib_StaffPW.c - apllib_InputBuf_Get()
  static Future<String> inputBufGet(int typ, int staffCd) async {
    String wkBuf = "";
    String buf = "";
    int	len = 0;
    JANInf ji = JANInf();
    int	idx = 0;
    int	nw7StfLen = 0;

    if(typ == 1)
    {
      staffPw.beam = await CmStf.apllibStaffCDInputLimit(2);
      if (staffPw.scanBuf.length >= Ean.ASC_EAN_13) {
        ji.code = staffPw.scanBuf.substring(0, Ean.ASC_EAN_13);
      } else {
        ji.code = staffPw.scanBuf.padLeft(Ean.ASC_EAN_13, "0");
      }
      await SetJinf.cmSetJanInf( ji, 0, 0 );

      nw7StfLen = (await ClkJan.cmStaffNw7 (staffPw.scanBuf, idx)).$1;

      if( ji.type == JANInfConsts.JANtypeClerk ){
        if( nw7StfLen > 0)
        {
          await ClkJan.cmStaffNw7Get(ji, staffPw.inpCode, nw7StfLen);
          buf = staffPw.inpCode.substring(staffPw.beam);
        }
        else{

          if(await CmCksys.cmTb1System() != 0){
            staffPw.scanBuf = ji.code;
          }
          if (staffPw.scanBuf.length == 12) {
            buf = staffPw.scanBuf.substring(5, 11);
          } else {
            buf = staffPw.scanBuf.substring(6, 12);
          }
        }
      }
      else if(ji.type == JANInfConsts.JANtypeClerk2){
        buf = staffPw.scanBuf.substring(4, 10);
      }
      else if(ji.type == JANInfConsts.JANtypeClerk3 || ji.type == JANInfConsts.JANtypeJan13){
        buf = staffPw.scanBuf.substring(2, 12);
      }
      staffPw.inpCode = "";
      len = buf.length;
      if(len < staffPw.beam){
        staffPw.inpCode = buf.padLeft(staffPw.beam, "0");
      }	
      else{
        staffPw.inpCode = buf.substring(len - staffPw.beam);
      }
    }
    else{
      if(staffPw.beam != 0){
        buf = (await CmStf.apllibStaffCdEdit(staffPw.tid, 3, staffCd, 0)).$1;
        wkBuf = buf.substring(buf.length - staffPw.beam);
      }
    }
    return wkBuf;
  }

}
