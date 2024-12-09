/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/apllib.dart';
import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/lib/cm_str_molding_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/apllib/mm_reptlib.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/pr_sp/cm_str_molding.dart';
import '../../regs/checker/rc_ewdsp.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/store_open/controller/c_store_open_page.dart';
import '../word/aa/l_rmstopncls.dart';


class CharData {
  String str1 = '';
  int posi1 = 0;
  String str2 = '';
  int posi2 = 0;
  String str3 = '';
  int posi3 = 0;
  String str4 = '';
  int posi4 = 0;
  String str5 = '';
  int posi5 = 0;
}

/// 関連tprxソース:rmstcom.c
class Rmstcom {
  /*-----  関数の戻り値  -----*/
  static const RMST_OK = 0;		   /* 正常終了 */
  static const RMST_NODATA = 1;	 /* データ無(正常終了) */
  static const RMST_NG = -1;		 /* 異常終了 */
  static const RMST_RETRY = 2;	 /* 正常 */
  static const RMST_QUIT = 3;    /* スキップ */
  static const RMST_DOWN = 4;    /* ダウン */
  static const MAKE_NG = 5;

  /*gtk_main() から強制的に抜けるためのタイムアウト(ミリ秒) */
  static const NEXT_GO_TIME = 100;
  /* 処理関連 */
  static int rmstEventTimer = 0;
  static int nttTimer = 0;
  static late CharData ejData;

  static const REG_OPEN = 1;
  static const REG_CLOSE = 2;
  static File? ejfp;
  static int Proc = REG_OPEN;

  static int rmstMsgNum = 0;

  // NTTクレジット仕様関連
  static int nttExecFlg = 0;

  // Stera関連
  static int	steraCrdtFailFlg = 0;
  static int	steraNfcCrdtFailFlg = 0;
  static int	steraIdFailFlg = 0;
  static int	steraIcFailFlg = 0;

  // ベスカ関連
  static int vescaExecFlg = 0;

  static const OPENCLOSE_WHERE = " comp_cd = '%i' AND stre_cd = '%i' AND sale_date = '%s'::timestamp";

  static String hSaleDate = ''; //YYYYーMMーDD
  static String saleDate = '';	//YYYYMMDD

  static DateTime timeStOpn = DateTime.now();

  /// 関数：void rmstTimerAdd(int timer, int (*func)())
  /// 機能：イベントタイマーの設定
  /// 引数：int timer タイマー設定値(ミリ秒)
  ///      Function func タイマーイベント関数のポインタ
  /// 戻値：なし
  /// 関連tprxソース:rmstcom.c - rmstTimerAdd()
  static void rmstTimerAdd(int timer, Function func)
  {
    if (rmstEventTimer != -1) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "rmstcom.c:Timer Clash[$rmstEventTimer]");
    }

    rmstEventTimer = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
  }

  /// 関数：void rmstTimerRemove(void)
  /// 機能：イベントタイマーの開放
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース:rmstcom.c - rmstTimerRemove()
  static void rmstTimerRemove() {
    if (rmstEventTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(rmstEventTimer);
      rmstTimerInit();
    }
  }

  /// 関数：void rmstTimerInit(void)
  /// 機能：イベントタイマーの初期化
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース:rmstcom.c - rmstTimerInit()
  static void rmstTimerInit() {
    rmstEventTimer = -1;
  }

  /// 関連tprxソース:rmstcom.c - rmstEjTxtMake_New()
  static int rmstEjTxtMakeNew(CharData ejdata) {
    TImgDataAdd	imgDataAdd = TImgDataAdd();
    TImgDataAddAns ans = TImgDataAddAns();
    int		i,num = 0;
    int		posi2, posi3, posi4, posi5;
    int		cnt1, cnt2, cnt3, cnt4, cnt5;

    rmstEJTxtSet(Proc, 0);
    if (ejfp == null) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "rmstEjTxtMake_New:ej tmpfile not OK");
      return RMST_NG;
    }
    if (ejdata.str1 == '') {
      rmstEJTxtSet(Proc, 1);
      return RMST_NG;
    }
    posi2 = posi3 = posi4 = posi5 = 0;
    cnt1 = cnt2 = cnt3 = cnt4 = cnt5 = 0;
    cnt1 = AplLibStrUtf.aplLibEntCnt(ejdata.str1);
    if(ejdata.str2 != '') {
      cnt2 = AplLibStrUtf.aplLibEntCnt(ejdata.str2);
    }
    if(ejdata.str3 != '') {
      cnt3 = AplLibStrUtf.aplLibEntCnt(ejdata.str3);
    }
    if(ejdata.str4 != '') {
      cnt4 = AplLibStrUtf.aplLibEntCnt(ejdata.str4);
    }
    if(ejdata.str5 != '') {
      cnt5 = AplLibStrUtf.aplLibEntCnt(ejdata.str5);
    }

    if (cnt2 != 0) {
      posi2 = cnt1 + ejdata.posi1;
      if((ejdata.posi2 > 0) && (posi2 < ejdata.posi2)) {
        posi2 = ejdata.posi2;
      }
    }
    if (cnt3 != 0) {
      posi3 = posi2 + cnt2;
      if ((ejdata.posi3 > 0) && (posi3 < ejdata.posi3)) {
        posi3 = ejdata.posi3;
      }
    }
    if(cnt4 != 0) {
      posi4 = posi3 + cnt3;
      if ((ejdata.posi4 > 0) && (posi4 < ejdata.posi4)) {
        posi4 = ejdata.posi4;
      }
    }
    if(cnt5 != 0) {
      posi5 = posi4 + cnt4;
      if ((ejdata.posi5 > 0) && (posi5 < ejdata.posi5)) {
        posi5 = ejdata.posi5;
      }
    }

    CmStrMolding.cmMultiImgDataAddChar(Tpraid.TPRAID_STR, imgDataAdd, num++,
        CmStrMoldingDef.DATA_PTN_NONE, ejdata.posi1, cnt1, ejdata.str1);
    if (posi2 != 0) {
      CmStrMolding.cmMultiImgDataAddChar(Tpraid.TPRAID_STR, imgDataAdd, num++
          , CmStrMoldingDef.DATA_PTN_NONE, posi2, cnt2, ejdata.str2);
    }
    if (posi3 != 0) {
      CmStrMolding.cmMultiImgDataAddChar(Tpraid.TPRAID_STR, imgDataAdd, num++,
          CmStrMoldingDef.DATA_PTN_NONE, posi3, cnt3, ejdata.str3);
    }
    if (posi4 != 0) {
      CmStrMolding.cmMultiImgDataAddChar(Tpraid.TPRAID_STR, imgDataAdd, num++,
          CmStrMoldingDef.DATA_PTN_NONE, posi4, cnt4, ejdata.str4);
    }
    if (posi5 != 0) {
      CmStrMolding.cmMultiImgDataAddChar(Tpraid.TPRAID_STR, imgDataAdd, num++,
          CmStrMoldingDef.DATA_PTN_NONE, posi5, cnt5, ejdata.str5);
    }
    CmStrMolding.cmMultiImgDataAdd(Tpraid.TPRAID_STR, imgDataAdd, ans);
    for(i = 0 ; i < ans.line_num; i ++) {
      // fputs(ans.line[i], ejfp);
      // fputs("\n", ejfp);
      MmReptlib.printStringEj(ejfp!, ans.line[i] );
    }
    rmstEJTxtSet(Proc, 1);

    return RMST_OK;
  }

  /// 関連tprxソース:rmstcom.c - rmstEjTxtMake_New2()
  static int rmstEjTxtMakeNew2(String ejLine, int posi) {
    CharData ejData = CharData();
    ejData.str1 = ejLine;
    ejData.posi1 = posi;
    rmstEjTxtMakeNew(ejData);
    return RMST_OK;
  }

  /// 関連tprxソース:rmstcom.c - rmstEJTxtSet()
  static void rmstEJTxtSet(int proc, int flg) {
    String txtPath = '';
    String log;
    ejfp = null;
    if (flg == 1) {
      return;
    }
    if (proc == REG_OPEN) {
      txtPath = "${EnvironmentData().sysHomeDir}/tmp/${AplLib.EJ_OPEN_TXT}";
    }
    else if (proc == REG_CLOSE) {
      txtPath = "${EnvironmentData().sysHomeDir}/tmp/${AplLib.EJ_CLOSE_TXT}";
    }
    ejfp = File(txtPath);
    if (!ejfp!.existsSync()) {
      ///TODO　errno取得方法
      // log = "rmstEJTxtSet : txtPpath open error[$errno]";
      log = "rmstEJTxtSet : txtPpath open error";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
    }
  }

  /// 関連tprxソース:rmstcom.c - rmstEjTxtMake()
  static int rmstEjTxtMake(String ejLine, int proc) {
    CharData ejdata = CharData();
    ejdata.str1 = ejLine.isNotEmpty ? ejLine : " ";
    ejdata.posi1 = 0;
    rmstEjTxtMakeNew(ejdata);
    return RMST_OK;
  }

  /// 関数：void rmstEjTxtClear(int proc)
  /// 関連tprxソース:rmstcom.c - rmstEjTxtClear()
  static Future<void> rmstEjTxtClear(int proc) async {
    String txtPath = "";

    if(proc == REG_OPEN){
      txtPath = "${EnvironmentData().sysHomeDir}/tmp/${AplLib.EJ_OPEN_TXT}";
    }else if(proc == REG_CLOSE){
      txtPath = "${EnvironmentData().sysHomeDir}/tmp/${AplLib.EJ_CLOSE_TXT}";
    }

    if(File(txtPath).existsSync()){
      await File(txtPath).delete();
    }else{
      // 既存のエラー内容を以下に書き換え："rmstEjTxtClear:rm command ERROR"
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "rmstEjTxtClear:delete command ERROR:file does not exist");
    }
    return;
  }

  /// 関数：bool rmstChkSkipCloseReceipt()
  /// 機能： 閉設レシート無し仕様チェック関数
  /// 引数： なし
  /// 戻値： true: 閉設レシート無し仕様である　false: 閉設レシート無し仕様ではない
  /// 関連tprxソース:rmstcom.c - rmstChkSkipCloseReceipt()
  static bool rmstChkSkipCloseReceipt() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      if (xRet.isInvalid()) {
        TprLog().logAdd(0, LogLevelDefine.error,
            "rmstChkSkipCloseReceipt() rxMemRead error\n");
        return false;
      }
    }
    RxCommonBuf pCom = xRet.object;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if 0
    // if(pCom->db_trm.user_cd45 & 8192)
    // {
    //   return(1);
    // }
    // #endif
    if (CmCksys.cmUnmannedShop() != 0) {
      return true;
    }
    return false;
  }

  /// 機能：メッセージをクリアする
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース:rmstcom.c - rmstMsgClear()
  static int rmstMsgClear(String callFunc){
    rmstMsgNum = 0;
    TprDlg.tprLibDlgClear(callFunc);

    return 0;

  }

  /// 関数：int rmstMsgDisp(int er_code, int dialog_ptn, void (*func1)(), uchar *msg1, void  (*func2)(), uchar *msg2, uchar *title, int user_code)
  /// 機能：メッセージを表示する
  /// 引数：int er_code 表示するメッセージ番号(MSG_xxxxx)
  /// ：int dialog_ptn 動作パターン
  /// ：int *func1 左ボタンのイベント関数
  /// ：char *msg1 左ボタンの文字列
  /// ：int *func2 右ボタンのイベント関数
  /// ：char *msg2 右ボタンの文字列
  /// ：char *title タイトルバーの文字列
  /// ：int user_code 任意の番号
  /// 戻値：0:終了
  /// 関連tprxソース:rmstcom.c - rmstMsgDisp_Main()
  static Future<int> rmstMsgDispMain(int erCode, int dialogPtn, Function? func1, String? msg1,
      Function? func2, String? msg2, Function? func3, String msg3, String title, int userCode,
      String userCode2, String userCode3) async {
    tprDlgParam_t dlgPrm = tprDlgParam_t();
    String steraBuf = '';

    rmstMsgNum = erCode;

    if(await CmCksys.cmSteraTerminalSystem() != 0){
      steraBuf = CmAry.setStringZero(64);
      if (rmstMsgNum == DlgConfirmMsgKind.MSG_OPTERROR_AGAIN.dlgId){
        String callFunc = 'rmstMsgDispMain';
        rmstMsgClear(callFunc);
        switch (userCode){
          case 1:
            steraCrdtFailFlg = 1;
            steraBuf = steraBuf + LRmstopncls.STCLS_STERA_POP1.val;
            dlgPrm.user_code_4 = steraBuf;
            break;
          case 2:
            steraNfcCrdtFailFlg = 1;
            steraBuf = steraBuf + LRmstopncls.STCLS_STERA_POP2.val;
            dlgPrm.user_code_4 = steraBuf;
            break;
          case 3:
            steraIdFailFlg = 1;
            steraBuf = steraBuf + LRmstopncls.STCLS_STERA_POP3.val;
            dlgPrm.user_code_4 = steraBuf;
            break;
          case 4:
            steraIcFailFlg = 1;
            steraBuf = steraBuf + LRmstopncls.STCLS_STERA_POP4.val;
            dlgPrm.user_code_4 = steraBuf;
            break;
          default:
            break;
        }
        userCode = 0;
      }
    }

    dlgPrm.erCode = erCode;
    dlgPrm.dialogPtn = dialogPtn;
    dlgPrm.func1 = func1;
    dlgPrm.msg1 = msg1 ?? '';
    dlgPrm.func2 = func2;
    dlgPrm.msg2 = msg2 ?? '';
    dlgPrm.func3 = func3;
    dlgPrm.msg3 = msg3 ?? '';
    dlgPrm.title = title;
    dlgPrm.userCode = userCode;
    dlgPrm.user_code_2 = userCode2 ?? '';
    dlgPrm.user_code_3 = userCode3 ?? '';

    //TprLibDlg(&DlgPrm);

    if (func1 != null && func2 == null) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: dlgPrm.erCode,
          type: MsgDialogType.info,
          btnTxt: dlgPrm.msg1,
          btnFnc: () {
            dlgPrm.func1!.call();
            Get.back();
          },
        ),
      );
    } else if (func1 != null && func2 != null) {
      MsgDialog.show(
        MsgDialog.twoButtonDlgId(
          dialogId: dlgPrm.erCode,
          type: MsgDialogType.info,
          leftBtnTxt: dlgPrm.msg1,
          leftBtnFnc: () {
            dlgPrm.func1!.call();
            Get.back();
          },
          rightBtnTxt: dlgPrm.msg2,
          rightBtnFnc: () {
            dlgPrm.func2!.call();
            Get.back();
          },
        ),
      );
    }

    rmstAutoStrErrSend();

    return 0;
  }

  /// 関連tprxソース:rmstcom.c - rmstMsgDisp()
  static void rmstMsgDisp(int erCode, int dialogPtn, Function? func1,
      String? msg1, Function? func2, String? msg2, String title, int userCode){
    rmstMsgDispMain(erCode, dialogPtn, func1, msg1, func2, msg2, null, '',
        title, userCode, '', '');
  }

  /// 関連tprxソース:rmstcom.c - rmstMsgDisp3()
  static void rmstMsgDisp3(int dialogPtn, Function func1, String msg1,
      Function func2, String msg2, String title, int userCode, String userCode3){
    rmstMsgDispMain(0, dialogPtn, func1, msg1, func2, msg2, null, '', title,
        userCode, '', userCode3);
  }

  /// 関連tprxソース:rmstcom.c - rmstAutoStrErrSend()
  static void rmstAutoStrErrSend(){
    if((rmstMsgNum != DlgConfirmMsgKind.MSG_WAITRSLTRQST.dlgId)
        && (rmstMsgNum != DlgConfirmMsgKind.MSG_HQ_COMM.dlgId)
        && (rmstMsgNum != DlgConfirmMsgKind.MSG_CSRV_COMM.dlgId)
        && (rmstMsgNum != DlgConfirmMsgKind.MSG_ACTION.dlgId)
        && (rmstMsgNum != DlgConfirmMsgKind.MSG_MCARD_OPENWAIT.dlgId)){
      AplLibAuto.aplLibCMAutoErrMsgSend(Tpraid.TPRAID_STR, rmstMsgNum);
    }
  }

  /// 関連tprxソース:rmstcom.c - rmstDailyClear
  static Future<void> rmstDailyClear(String formattedDate, String saledateDay) async {
    String sql = "";
    String prn = "";

    DbManipulationPs db = DbManipulationPs();

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmstDailyClear: Start");

    // c_*
    for (BkUpDbs type in BkUpDbs.values) {
      String tableName = type.tableName;
      prn = "delete";

      // delete
      switch(type) {
        case BkUpDbs.BKUP_DB_DATALOG:
        case BkUpDbs.BKUP_DB_STATUSLOG:
        case BkUpDbs.BKUP_DB_EJLOG:
          String tableNameDate = "${tableName}_$saledateDay";
          sql = "delete from $tableName where serial_no in (select serial_no from c_header_log_$saledateDay where sale_date < '$formattedDate')";
          await dailyClearSqlProcess(sql, tableNameDate, prn);
          break;
        case BkUpDbs.BKUP_DB_HEADERLOG:
          String tableNameDate = "${tableName}_$saledateDay";
          sql = "delete from $tableName where sale_date < '$formattedDate'";
          await dailyClearSqlProcess(sql, tableNameDate, prn);
          break;
        default:
          break;
      }

      // truncate
      switch(type) {
        case BkUpDbs.BKUP_DB_DATALOG:
        case BkUpDbs.BKUP_DB_STATUSLOG:
        case BkUpDbs.BKUP_DB_HEADERLOG:
        case BkUpDbs.BKUP_DB_EJLOG:
          prn = "truncate";
          sql = "truncate $tableName";
          await dailyClearSqlProcess(sql, tableName, prn);
          break;
        default:
          break;
      }

      // 1秒待機
      await Future.delayed(const Duration(seconds: 1));
    }

    // p_*
    for (SubRmStBkUpDb type in SubRmStBkUpDb.values) {
      String tableName = type.tableName;
      prn = "delete";

      // delete
      switch(type) {
        case SubRmStBkUpDb.cartLog:
          sql = "delete from $tableName";
          break;

        case SubRmStBkUpDb.salesLog:
          sql = "delete from $tableName where sale_date < '$formattedDate'";
          break;
        default:
          break;
      }
      await dailyClearSqlProcess(sql, tableName, prn);

      // 1秒待機
      await Future.delayed(const Duration(seconds: 1));
    }

    // 本日の営業日前のデータを削除
    DateTime saleDateString = DateTime.parse(formattedDate);
    String formattedSaleDate = DateFormat('yyyyMMdd').format(saleDateString);

    String sqlSelect = "select * from wk_que where serial_no < '${formattedSaleDate}00000000000000000000000000000000000'";
    try {
      Result results = await db.dbCon.execute(sqlSelect);
      if (results.isNotEmpty) {
        String sqlDelete = "delete from wk_que where serial_no < '${formattedSaleDate}00000000000000000000000000000000000'";
        try {
          await db.dbCon.execute(sqlDelete);
          debugPrint("rmstDailyClear: delete OK!");
        } catch (e, s) {
          TprLog().logAdd(
              Tpraid.TPRAID_STR, LogLevelDefine.error, "rmstDailyClear: wk_que delete NG! [$sqlDelete]\n$e \n$s");
        }
      } else {
        debugPrint("rmstDailyClear: No records　[$sqlSelect]");
      }
    } catch (e, s) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmstDailyClear: rmstDailyClear: wk_que selecte NG! [$sqlSelect]\n$e \n$s");
    }

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmstDailyClear: End");
  }

  /// SQLの実行・VACUUM処理・REINDEX処理
  static Future<void> dailyClearSqlProcess(String sql, String tableName, String prn) async {
    DbManipulationPs db = DbManipulationPs();

    try {
      await db.dbCon.execute(sql);
      debugPrint("rmstDailyClear: $tableName $prn OK!");

      // Vacuum処理
      String sqlVacuum = "vacuum analyze $tableName";
      debugPrint("rmstDailyClear: $tableName vacuum analyze Start");
      try {
        var resVacuum = await db.dbCon.execute(sqlVacuum);
        if (resVacuum.isEmpty) {
          debugPrint("rmstDailyClear: $tableName vacuum analyze OK!");
        } else {
          debugPrint("rmstDailyClear: $tableName vacuum analyze NG!");
        }
        debugPrint("rmstDailyClear: $tableName vacuum analyze End");
      } catch (e, s) {
        // ＤＢ読込エラー
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstDailyClear: db error [$sqlVacuum]\n$e \n$s");
      }

      // Reindex処理
      String sqlIndex = "reindex table $tableName";
      debugPrint("rmstDailyClear: $tableName reindex Start");
      try {
        var resVacuum = await db.dbCon.execute(sqlIndex);
        if (resVacuum.isEmpty) {
          debugPrint("rmstDailyClear: $tableName reindex OK!");
        } else {
          debugPrint("rmstDailyClear: $tableName reindex NG!");
        }
        debugPrint("rmstDailyClear: $tableName reindex End");
      } catch (e, s) {
        // ＤＢ読込エラー
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstDailyClear: db error [$sqlIndex]\n$e \n$s");
      }

    } catch (e, s) {
      // ＤＢ読込エラー
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmstDailyClear: db error [$sql]\n$e \n$s");
    }

  }

  /// 関連tprxソース:rmstcom.c - rmstDbToBkup
  static Future<bool> rmstDbToBkup() async {
    DbManipulationPs db = DbManipulationPs();
    bool errState = true;

    // counterJson
    late CounterJsonFile counterJson;
    late Mac_infoJsonFile macinfoJson;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      macinfoJson = Mac_infoJsonFile();
      await counterJson.load();
      await macinfoJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
      macinfoJson = pCom.iniMacInfo;
    }

    // 本日営業日
    String saledate = counterJson.tran.last_sale_date;
    DateTime saleDateString = DateTime.parse(saledate);
    String formattedSaleDate = DateFormat('yyyyMMdd').format(saleDateString);
    String saledate00 = '00$formattedSaleDate';

    // dd
    String day = saledate.substring(8, 10);

    // レジ番号
    String macNo = macinfoJson.system.macno.toString();
    String formattedMacNo = macNo.toString().padLeft(6, '0');


    // /pj/tprx/log/へコピー
    String logFolderPath = join(EnvironmentData().sysHomeDir, 'log');
    for (BkUpDbs type in BkUpDbs.values) {
      String tableName = type.tableName;
      switch(type) {
        case BkUpDbs.BKUP_DB_DATALOG:
        case BkUpDbs.BKUP_DB_STATUSLOG:
        case BkUpDbs.BKUP_DB_HEADERLOG:
        case BkUpDbs.BKUP_DB_EJLOG:
          var ret = await copySqlProcess(db, tableName, day, logFolderPath, formattedSaleDate, formattedMacNo);
          if (ret == false) {
            errState = false;
          }
          break;
        default:
          break;
      }
    }

    // /pj/tprx/tran_backup/へコピー
    String tranbackupFolderPath = join(EnvironmentData().sysHomeDir, 'tran_backup');
    for (BkUpDbs type in BkUpDbs.values) {
      String tableName = type.tableName;
      switch(type) {
        case BkUpDbs.BKUP_DB_DATALOG:
        case BkUpDbs.BKUP_DB_STATUSLOG:
        case BkUpDbs.BKUP_DB_HEADERLOG:
        case BkUpDbs.BKUP_DB_EJLOG:
          var ret = await copySqlProcess(db, tableName, day, tranbackupFolderPath, formattedSaleDate, formattedMacNo);
          if (ret == false) {
            errState = false;
          }
          break;
        default:
          break;
      }
    }

    return errState;

  }

  /// テーブルデータを.normalにコピー
  static Future<bool> copySqlProcess(DbManipulationPs db, String tableName, String day, String path, String saledate, String macno) async {
    try {
      final directory = Directory(path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      if (Platform.isWindows) {
        String sql = "copy ${tableName}_$day to '$path/$tableName$saledate.$macno.normal'";
        await db.dbCon.execute(sql);
      } else if (Platform.isLinux) {
        final file = File('$path/$tableName$saledate.$macno.normal');
        final sink = file.openWrite(mode: FileMode.append);
        String sql = "SELECT * FROM ${tableName}_$day";
        final result = await db.dbCon.execute(sql);
        for (final row in result) {
          sink.writeln(row.toString());
        }
        sink.close;
      }
    } catch (e, s) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error,
          "Error exporting data for ${tableName}_$day: $e\n$s");
      return false;
    }
    return true;
  }

}

/// 関連tprxソース:rmstcom.h - BKUP_FNAMES()
enum BkUpFNames {
  BKUP_FNAME_NORMAL(0),
  BKUP_FNAME_SERIAL(1),
  BKUP_FNAME_OFFLINE(2),
  BKUP_FNAME_OFFSEND(3),
  BKUP_FNAME_NONDIR(4),
  BKUP_FNAME_RECAL(5),
  BKUP_FNAME_MAX(6);

  final int value;

  const BkUpFNames(this.value);
}

enum BkUpDbs {
  BKUP_DB_DATALOG(0, "c_data_log"),
  BKUP_DB_STATUSLOG(1, "c_status_log"),
  BKUP_DB_LINKAGELOG(2, "c_linkage_log"),
  BKUP_DB_HEADERLOG(3, "c_header_log"),
  BKUP_DB_PBCHG(4, "c_pbchg_log"),
  BKUP_DB_EJLOG(5, "c_ej_log"),
  BKUP_DB_VOID(6, "c_void_log"),
  BKUP_DB_MVOID(7, "c_void_log_01"),
  BKUP_DB_MPBCHG(8, "c_pbchg_log_01"),
  BKUP_DB_RESERV_STATUSLOG(9, "c_status_log_reserv_01"),
  BKUP_DB_RESERV_HEADERLOG(10, "c_header_log_reserv_01"),
  BKUP_DB_RESERV_DATALOG(11, "c_data_log_reserv_01"),
  BKUP_DB_MMEJLOG(12, "c_ej_log"),
  BKUP_DB_MAX(13, "");

  /// コンストラクタ
  const BkUpDbs(this.value, this.tableName);

  final int value;
  /// テーブル名
  final String tableName;
}

/// バックアップファイルテーブル(p_*)
enum SubRmStBkUpDb {
  cartLog("p_cart_log"),
  salesLog("p_sales_log");

  /// コンストラクタ
  const SubRmStBkUpDb(this.tableName);

  /// テーブル名
  final String tableName;
}
