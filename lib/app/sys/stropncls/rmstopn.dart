/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/drv/printer/drv_print_isolate.dart';
import 'package:flutter_pos/app/if/common/interface_define.dart';
import 'package:flutter_pos/app/if/if_drv_control.dart';
import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import 'package:flutter_pos/app/inc/lib/mm_reptlib_def.dart';
import 'package:flutter_pos/app/lib/apllib/mm_reptlib.dart';
import 'package:flutter_pos/app/lib/apllib/prg_lib.dart';
import 'package:flutter_pos/app/lib/cm_ej/cm_ejlib.dart';

import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/if_th/aa/if_th_prnstr.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_alloc.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_ccut.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_flushb.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_prnline.dart';
import 'package:flutter_pos/app/sys/stropncls/rmstcls.dart';
import 'package:flutter_pos/app/sys/stropncls/rmstclsfcl.dart';
import 'package:flutter_pos/app/sys/stropncls/rmstsuica.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';
import 'package:sprintf/sprintf.dart';

import '../../../db_library/src/db_manipulation.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../backend/history/hist_main.dart';
import '../../backend/history/hist_proc.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/rxmem.dart' as rxMem;
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxsys.dart';
import '../../inc/lib/apl_cnv.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/cm_str_molding_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/db_error.dart';
import '../../inc/lib/dbnumberconfirm.dart';
import '../../inc/lib/dbprcchg.dart';
import '../../inc/lib/taxchg_plan.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apl_db/dbBatPrcChgUpd.dart';
import '../../lib/apllib/AplLib_EucAdjust.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_hqconnect.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/apllib/apllib_std_add.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/apllib/bkupd_lib.dart';
import '../../lib/apllib/closedbchk.dart';
import '../../lib/apllib/cnct.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/apllib/data_restor_lib.dart';
import '../../lib/apllib/recog.dart';
import '../../lib/apllib/rm_db_read.dart';
import '../../lib/apllib/rm_ini_read.dart';
import '../../lib/apllib/sio_chk.dart';
import '../../lib/apllib/taxfree_comlib.dart';
import '../../lib/apllib/timestamp.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../../lib/cm_sys/cm_ckfjss.dart';
import '../../lib/db/db_pqexec.dart';
import '../../lib/if_th/if_th_csnddata.dart';
import '../../lib/if_th/if_th_init.dart';
import '../../lib/pr_sp/cm_str_molding.dart';
import '../../regs/checker/rc_ewdsp.dart';
import '../../set/prg_taxchg_plan.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/menu/register/enum/e_register_page.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/test/p_tmp_store_close_ut1.dart';
import '../tmode/tmode2.dart';
import '../usetup/freq/freq.dart';
import '../word/aa/l_freq.dart';
import '../word/aa/l_rmstopncls.dart';
import 'rmstcom.dart';
import 'rmstcom_define.dart';

/// 関連tprxソース: rmstopn.c
class Rmstopn {
  static int stopenChk = 0;
  static int autoFinish = 0;
  static const PRINT_FLG = 1;
  static int fclType = 0;
  static List<String> printData = List.filled(2, '');
  static int retryCnt = 0;
  static int updErr = 0;
  static bool SEGMENT = false;

  /*
    1:ﾃｷｽﾄ再送信留意事項+再送信方法
    2:ﾃｷｽﾄ再送信方法
    3:JAﾃｷｽﾄ再送信留意事項+再送信方法
    NORMAL_END:開設正常終了
    PRINT_START:印字開始
    PRINT_CNCL:印字中止
  */
  static int uRetry = 0;
  static int uInter = 0;
  static int cRetry = 0;
  static int printTyp = 0;

  static int SuicaStep = 0;
  static int Edy_Step = 0;
  static int Acx_Step = 0;

  // TODO:10121 QUICPay、iD 202404実装対象外
  //#if IC_CONNECT
  // static int ICCon_Step;
  // static int icc_bld;
  //#endif
  static int Edy_FAP_Step = 0;
  static int iD_FAP_Step = 0;
  static int PiTaPa_PFM_Step = 0;
  static int Suica_PFM_Step = 0;
  static int Jmups_Print = 0;
  static int rmstopnWinMod = 0;

  static int dataRestorExecFlg = 0; //クイック再セットアップ実行フラグ 0:未実行  1:実行中
  static int datarestorTimer = -1; //クイック再セットアップ用タイマー

  static int NORMAL_END = 100;
  static int recalChk = 0;

  static const PLUMST_BKUP = "backup_plu_mst.txt";
  static const BATPRCCHG_BKUP = "backup_batprcchg_mst.txt";
  static const CHPRICE_HISTORY = "history.txt";

  static const BATPRCCHG_ODER_MAX = 9999; // 予約売価変更マスタ：順序コードＭＡＸ <2007.03.12>

  static RmStOpenChPriceT rmStOpnChPriceT = RmStOpenChPriceT();
  static const VERIFONE_EJLINE_MAX = 150;

  static const STOPN_MAIN = 1;
  static const STOPN_PASSWD = 2;
  static const STOPN_SUB = 3;
  static const STOPN_PWOFF = 4;
  static const STOPN_END = 5;
  static const STOPN_EVENTHALL = 6;
  static const STOPN_SPINFO = 7;
  static const STOPN_CLOSEDBERR = 8;
  static const STOPN_FREQ = 9;

  static int PROC_STS = 0;

  static const FORCE = 1;

  /* 履歴ログ取得処理件数 */
  static RxInt histLogCnt = 0.obs;

  static int fqresWebapi = -1;

  static int autoErr = 0;
  static int autoOpen = 0;
  static int autoStrOpnTime = 0;

  static int logFlg = 0;

  /* add K.S 2008/02/08 */

  static int autoRunTimer = -1;
  static int autoRunTime = 0;
  static int autoRun = 1;

  static int opnStatFlg = 0;
  static int mOpen = 0;
  static int bsOpen = 0;

  static String whBuf = ''; //c_openclose_mst 条件文

  static const OPN_EXEC = 1;

  static int hostErrAttnFlag = 0; // 0:注意未確認  1:注意確認済

  static int fDate = 0;

  static int chkFlg = 0;

  static const SAME_DATE = 1;

  static const NOT_OPEN = -2;

  static int histLogGetFinishedFlg = 0; // 0: 起動レジからwolをしていない  1: 実行中  -1: 実行完了

  static int mMacNo = 0;
  static int bsMacNo = 0;

  static int storeOpenPlanChkFlag = 0; // 税種予約変更, 及び, 上位予約変更を確認したかのフラグ  0:未確認  1:確認

  static int execFlg = 0; //実行flg　1：未実行　1：実行した

  /* 24H system */
  static List<String> yobi = [
    LRmstopncls.L_SUN.val,
    LRmstopncls.L_MON.val,
    LRmstopncls.L_TUE.val,
    LRmstopncls.L_WED.val,
    LRmstopncls.L_THU.val,
    LRmstopncls.L_FRI.val,
    LRmstopncls.L_SAT.val
  ];

  /// 関連tprxソース: rmstntt.c - PrnLineMake
  static void prnLineMake(String prnMsg) {
    prnLineMake2(0, prnMsg);
  }

  /// 関連tprxソース: rmstntt.c - PrnLineMake2
  static Future<void> prnLineMake2(int posi, String prnMsg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    if ((pCom.dbTrm.streOpenReport == 0)
        && !(await CmCksys.cmSuicaSystem() != 0)
        && !(await chkAutoOpen() != 0)
        && !(await CmCksys.cmDepartmentStoreSystem() != 0)
        && !(await CmCksys.cmSpDepartmentSystem() != 0)
        && !(await CmCksys.cmFclEdySystem() != 0)
        && !(await CmCksys.cmFclIDSystem() != 0)
        && !(await CmCksys.cmPFMPiTaPaSystem() != 0)
        && !(await CmCksys.cmPFMJRICSystem() != 0)
        && !(printTyp != 0)
        && (pCom.dbRegCtrl.setOwnerFlg == 0)
        && (PlgTaxchgPlan.prgPlanUpdateResultLogProc(
            Tpraid.TPRAID_STR, TaxchgPlanLogType.TAXCHG_PLAN_LOG_CHECK) ==
            -1)) {
      return;
    }

    TImgDataAdd imgDataAdd = TImgDataAdd();
    TImgDataAddAns ans = TImgDataAddAns();
    CmStrMolding.cmMultiImgDataAddChar(
        Tpraid.TPRAID_STR,
        imgDataAdd,
        0,
        CmStrMolding.DATA_PTN_NONE,
        posi,
        CmStrMolding.RCPTWIDTH,
        prnMsg);
    CmStrMolding.cmMultiImgDataAdd(Tpraid.TPRAID_STR, imgDataAdd, ans);
    for (int i = 0; i < ans.line_num; i++) {
      IfThAlloc.ifThAllocArea(Tpraid.TPRAID_STR, Tmode2.PRINT_LINE1);
      IfThPrnStr.ifThPrintString(
          Tpraid.TPRAID_STR,
          0,
          i * 30,
          0,
          rxMem.PrnFontIdx.E24_24_1_1.id,
          rxMem.PrnFontIdx.E24_24_1_1.id,
          ans.line[i]);
    }
    IfThFlushB.ifThFlushBuf(Tpraid.TPRAID_STR, 0);
    IfThCCut.ifThCCut(Tpraid.TPRAID_STR, InterfaceDefine.IF_TH_NOLOGO2);
    return;
  }

  /// 関連tprxソース: rmstntt.c - ChkAutoOpen()
  static Future<int> chkAutoOpen() async {
    if ((stopenChk == 1)
        && (await CmCksys.cm24hourSystem() == 0)
        && (autoFinish == 0)) {
      return 1;
    }
    else {
      return 0;
    }
  }


  /// 関連tprxソース:rmstopn.c - rmstOpnEndEJ()
  static Future<void> rmstOpnEndEJ() async {
    String data = "";
    String data2 = "";
    String timeJtype;
    int sndCnt, errCnt;

    if (await CmCksys.cmTaxfreeServerSystem() != 0) {
      errCnt = await TaxfreeComlib.taxFreeReadRest(
          Tpraid.TPRAID_STR, AplLib.GETTYPE_ERR, AplLib.SERVER_BUSINESS);
      if (errCnt != 0) {
        Rmstcom.rmstEjTxtMake(" ", Rmstcom.REG_OPEN);
        Rmstcom.rmstEjTxtMake(
            LRmstopncls.TAXFREE_RES_TXT.val, Rmstcom.REG_OPEN);
        Rmstcom.rmstEjTxtMake(
            LRmstopncls.TAXFREE_RES_TXT2.val, Rmstcom.REG_OPEN);

        sndCnt = await TaxfreeComlib.taxFreeReadRest(
            Tpraid.TPRAID_STR, AplLib.GETTYPE_NOTSEND, AplLib.SERVER_BUSINESS);
        if (sndCnt != 0) {
          data2 = sprintf(LRmstopncls.TAXFREE_SND_CNT.val, sndCnt);
          data = sprintf("%s%s", [RmstcomDef.SPACE4, data2]);
          Rmstcom.rmstEjTxtMake(data, Rmstcom.REG_OPEN);
        }

        data2 = sprintf(LRmstopncls.TAXFREE_ERR_CNT.val, errCnt);
        data = sprintf("%s%s", [RmstcomDef.SPACE4, data2]);
        Rmstcom.rmstEjTxtMake(data, Rmstcom.REG_OPEN);
      }
    }

    Rmstcom.ejData = CharData();
    Rmstcom.ejData.str1 = LRmstopncls.EJ_ASTER.val;
    Rmstcom.ejData.str2 = LRmstopncls.EJ_ASTER2.val;
    Rmstcom.ejData.str3 = LRmstopncls.EJ_ASTER.val;
    Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
    if (PRINT_FLG != 0) {
      prnLineMake(LRmstopncls.PRINT_ASTER.val);
    }
    data = "";
    timeJtype = (await DateUtil.dateTimeChange(
        null, DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM,
        DateTimeFormatKind.FT_YYYYMMDD_KANJI_HHMM,
        DateTimeFormatWay.DATE_TIME_FORMAT_ZERO)).$2;
    Rmstcom.ejData = CharData();
    Rmstcom.ejData.str1 = LRmstopncls.OPN_PROC_END.val;
    Rmstcom.ejData.posi1 = 1;
    Rmstcom.ejData.str2 = timeJtype;
    Rmstcom.ejData.posi2 = Rmstcom.ejData.posi1 +
        AplLibStrUtf.aplLibEntCnt(Rmstcom.ejData.str1); // + 4;
    Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
    if (PRINT_FLG != 0) {
      prnLineMake(LRmstopncls.PRINT_OPNPROCEND.val);
    }
    Rmstcom.rmstEjTxtMake("", Rmstcom.REG_OPEN);
    if (PRINT_FLG != 0) {
      prnLineMake("  ");
    }
    await rmstEjWriteEdit();
  }

  /// 関連tprxソース:rmstopn.c - rmstEjWriteEdit()
  // TODO:00012 平野　日計対応：動作確認まだ
  static Future<void> rmstEjWriteEdit() async {
    File readFile;
    File writeFile;
    String content;
    if ((!(CmCksys.cmUnmannedShop() != 0))
        && (printTyp != NORMAL_END)
        && (printTyp != RmstcomDef.PRINT_START)
        && (printTyp != RmstcomDef.PRINT_CNCL)
        && (printTyp != RmstcomDef.PRINT_END)) {
      printTyp = 0;
    }

    if (printTyp != 0) {
      // snprintf(cmd, sizeof(cmd), "/bin/cat %s/tmp/%s.txt >> %s/tmp/%s", SysHomeDirp, PRN_ATEN_TXT, SysHomeDirp, EJ_OPEN_TXT);
      // system(cmd);
      readFile = File(
          '${EnvironmentData().sysHomeDir}/tmp/${RmstcomDef.PRN_ATEN_TXT}.txt');
      writeFile =
          File('${EnvironmentData().sysHomeDir}/tmp/${AplLib.EJ_OPEN_TXT}.txt');
      content = await readFile.readAsString();
      writeFile.writeAsStringSync(
          content, mode: FileMode.append, encoding: utf8, flush: false);
    }
    if (Jmups_Print != 0) {
      // snprintf(cmd, sizeof(cmd), "/bin/cat %s/conf/%s.txt >> %s/tmp/%s", SysHomeDirp, PRN_JMUPS_ATEN_TXT, SysHomeDirp, EJ_OPEN_TXT);
      // system(cmd);
      readFile = File('${EnvironmentData().sysHomeDir}/conf/${RmstcomDef
          .PRN_JMUPS_ATEN_TXT}');
      writeFile =
          File('${EnvironmentData().sysHomeDir}/tmp/${AplLib.EJ_OPEN_TXT}.txt');
      content = await readFile.readAsString();
      writeFile.writeAsStringSync(
          content, mode: FileMode.append, encoding: utf8, flush: false);
    }

    if (dataRestorExecFlg == 1) { //クイック再セットアップ実行中
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "rmstEjWriteEdit: force delete do nothing");
      Rmstcom.rmstEjTxtClear(RmstcomDef.REG_OPEN);
      Rmstcom.rmstEjTxtClear(RmstcomDef.REG_CLOSE);
      RmstSuica.rmstEjTxtObsClear();
      return;
    }

    if (stopenChk == 0) {
      await BkupdLib.rmstEjWriteProc();
    }

    if (Suica_PFM_Step == 2) {
      rmstEjWritePFMSuicaProc();
    } else if (SuicaStep == 2) {
      rmstEjWriteSuicaObsProc();
    }

    if (Rmstcom.rmstChkSkipCloseReceipt()) {
      if (await CmCksys.cmVescaSystem() != 0) {
        // TODO:00012 平野 他の人が作成中なので保留
        // rmstEjWriteVerifone();
      }
    }
  }

  ///  関連tprxソース: rmstopn.c - rmstProciDEnd
  static int rmstProciDEnd() {
    String log = '';
    String cmdName = '';
    String msg = '';
    String msg2 = '';
    CharData prnData1 = CharData();
    CharData prnData2 = CharData();
    StclsFclInfo stclsFclInfo = StclsFclInfo();
    String callFunc = 'rmstProciDEnd';
    Rmstclsfcl rmstclsfcl = Rmstclsfcl();

    Rmstcom.rmstTimerRemove();

    if ((stclsFclInfo.keyReq != 0) && (stclsFclInfo.negaReq != 0)) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "rmstProciDEnd: Normal End");
      Rmstcom.rmstMsgClear(callFunc);
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_OPENTRAN.dlgId,
          DlgPattern.TPRDLG_PT2.dlgPtnId,
          null,
          null,
          null,
          null,
          "",
          0);
      //#if PRINT_FLG
      prnLineMake(LRmstopncls.ITEM_FAP_ID_TXT2.val);
      //#endif
      prnData1.str1 = LRmstopncls.FCL_KEY_REQ.val;
      prnData1.posi1 = 6;
      prnData1.str2 = LRmstopncls.ENTRY_NORMAL.val;
      Rmstcom.rmstEjTxtMakeNew(prnData1);
      //#if PRINT_FLG
      prnData2.str1 = LRmstopncls.FCL_KEY_REQ.val;
      prnData2.posi1 = 4;
      prnData2.str2 = LRmstopncls.ENTRY_NORMAL.val;
      rmstPrnlineDataSet(prnData2);
      //#endif
      prnData1 = CharData();
      prnData1.str1 = LRmstopncls.FCL_NEGA_REQ.val;
      prnData1.posi1 = 6;
      prnData1.str2 = LRmstopncls.ENTRY_NORMAL.val;
      Rmstcom.rmstEjTxtMakeNew(prnData1);
      //#if PRINT_FLG
      prnData2 = CharData();
      prnData2.str1 = LRmstopncls.FCL_NEGA_REQ.val;
      prnData2.posi1 = 4;
      prnData2.str2 = LRmstopncls.ENTRY_NORMAL.val;
      rmstPrnlineDataSet(prnData2);
      //#endif

      // TODO:00013 三浦 rmstOpenWaitProcが未実装
      //Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, rmstOpenWaitProc);
      return Rmstcom.RMST_OK;
    }

    prnData1.str1 = LRmstopncls.FCL_KEY_REQ.val;
    prnData1.posi1 = 6;
    prnData1.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
    Rmstcom.rmstEjTxtMakeNew(prnData1);
    prnData1.str1 = LRmstopncls.FCL_NEGA_REQ.val;
    Rmstcom.rmstEjTxtMakeNew(prnData1);

    log = sprintf("rmstProciDEnd: Error End key_req[%i], nega_req[%d]\n",
        [stclsFclInfo.keyReq, stclsFclInfo.negaReq]);
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
    for (int i = 0; i < printData.length; i++) {
      printData[i] = CmAry.setStringZero(128);
    }
    cmdName = CmAry.setStringZero(128);
    msg = CmAry.setStringZero(128);
    msg2 = CmAry.setStringZero(128);
    rmstclsfcl.fclGetCmdMsg(stclsFclInfo.order);
    rmstclsfcl.fclGetMsg();
    Rmstcom.rmstEjTxtMakeNew2(cmdName, 6);
    Rmstcom.rmstEjTxtMakeNew2(msg, 6);
    printData[0] = sprintf("%s%s", [cmdName]);
    printData[1] = sprintf("%s%s", [msg]);

    msg2 = sprintf("%s\n%s", [msg]);
    Rmstcom.rmstMsgClear(callFunc);
    Rmstcom.rmstMsgDisp3(
        DlgPattern.TPRDLG_PT11.dlgPtnId,
        rmstProcFclRetry,
        LTprDlg.BTN_RETRY,
        rmstProcFclSkip,
        LTprDlg.BTN_FORCE,
        LRmstopncls.FCL_ID_TITLE2.val,
        0,
        msg2);
    return Rmstcom.RMST_NG;
  }

  ///  関連tprxソース: rmstopn.c - rmstPrnlineDataSet
  static void rmstPrnlineDataSet(CharData prndata) {
    TImgDataAdd imgDataAdd = TImgDataAdd();
    TImgDataAddAns ans = TImgDataAddAns();
    int num = 0;
    int cnt1 = 0;
    int cnt2 = 0;
    int cnt = 0;
    String str = '';
    String dStr = '';

    str = sprintf("%s", [prndata.str1]);
    cnt1 = AplLibStrUtf.aplLibEntCnt(str);
    str = '';
    str = sprintf("%s", [prndata.str2]);
    cnt2 = AplLibStrUtf.aplLibEntCnt(str);
    cnt = CmStrMolding.RCPTWIDTH - cnt1 - cnt2 - prndata.posi1;
    str = '';
    str = sprintf("%s", [LRmstOpnCls.SUM_POINT]);
    AplLibStrUtf.aplLibEucCopy(str, cnt);

    CmStrMolding.cmMultiImgDataAddChar(
        Tpraid.TPRAID_STR,
        imgDataAdd,
        num++,
        CmStrMolding.DATA_PTN_NONE,
        prndata.posi1,
        cnt1,
        prndata.str1);
    CmStrMolding.cmMultiImgDataAddChar(
        Tpraid.TPRAID_STR,
        imgDataAdd,
        num++,
        CmStrMolding.DATA_PTN_NONE,
        prndata.posi1 + cnt1,
        cnt,
        dStr);
    CmStrMolding.cmMultiImgDataAddChar(
        Tpraid.TPRAID_STR,
        imgDataAdd,
        num++,
        CmStrMolding.DATA_PTN_NONE,
        CmStrMolding.RCPTWIDTH - cnt2,
        cnt2,
        prndata.str2);
    // TODO:00013 三浦 cmMultiImgDataAdd未実装
    //CmStrMolding.cmMultiImgDataAdd(Tpraid.TPRAID_STR, imgDataAdd, ans);

    if (ans.line_num != 0) {
      prnLineMake(ans.line[0]);
    }
    if (ans.line_num > 1) {
      prnLineMake(ans.line[1]);
    }
  }

  ///  関連tprxソース: rmstopn.c - rmstProcFclRetry
  static int rmstProcFclRetry() {
    String log = '';
    String callFunc = 'rmstProcFclRetry';

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);

    retryCnt++;
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.PROC5_RETRY.val, 20);
    switch (fclType) {
      case 1:
      /* Edy */
        log = sprintf("rmstProcFclRetry: Edy[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // TODO:00013 三浦 ExecProcEdyStart 実装対象外
        //rmstTimerAdd(1000, (GtkFunction)ExecProcEdyStart);
        return 0;
      case 3:
      /* iD */
        log = sprintf("rmstProcFclRetry: iD[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        Rmstcom.rmstTimerAdd(1000, ExecProciDStart);
        return 0;
      case 4:
      /* Suica */
        log = sprintf("%s: Suica[%i]", [callFunc, retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        Rmstcom.rmstMsgClear(callFunc);
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_NOWWAIT.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            null,
            null,
            null,
            null,
            LRmstopncls.SUICA_TITLE.val,
            0);
        Rmstcom.rmstTimerAdd(1000, ExecProcPiTaPaStart);
        return 0;
      case 5:
      /* PiTaPa */
        log = sprintf("%s: PiTaPa[%i]", [callFunc, retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        Rmstcom.rmstMsgClear(callFunc);
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_NOWWAIT.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            null,
            null,
            null,
            null,
            LRmstopncls.PITAPA_TITLE.val,
            0);
        Rmstcom.rmstTimerAdd(1000, ExecProcPiTaPaStart);
        return 0;
      default:
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_OPENTRAN.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            null,
            null,
            null,
            null,
            "",
            0);
        log = sprintf("rmstProcFclRetry: type error[%i]", [fclType]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
        break;
    }

    // TODO:00013 三浦 rmstOpenWaitProc 未実装
    //rmstTimerAdd(Rmstcom.NEXT_GO_TIME, rmstOpenWaitProc);
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - rmstProcFclSkip
  static int rmstProcFclSkip() {
    String log = '';
    CharData prnData = CharData();
    String callFunc = 'rmstProcFclSkip';
    StclsFclInfo stclsFclInfo = StclsFclInfo();

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);
    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_OPENTRAN.dlgId,
        DlgPattern.TPRDLG_PT2.dlgPtnId,
        null,
        null,
        null,
        null,
        "",
        0);

    switch (fclType) {
      case 1:
      /* Edy */
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstProcFclSkip: Edy Force End!");
        //#if PRINT_FLG
        prnLineMake(LRmstopncls.EDY_DATESET.val);
        //#endif
        //#if PRINT_FLG
        prnData.str1 = LRmstopncls.PROC_EDY_RSLT.val;
        prnData.posi1 = 4;
        prnData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
        rmstPrnlineDataSet(prnData);
        prnLineMake(printData[0]);
        prnLineMake(printData[1]);
        //#endif
        break;

      case 3:
      /* iD */
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstProciDSkip: iD Force End!");
        // #if PRINT_FLG
        prnLineMake(LRmstopncls.ITEM_FAP_ID_TXT2.val);
        //memset(prnData, 0, sizeof(CHARDATA));
        prnData.str1 = LRmstopncls.FCL_KEY_REQ.val;
        prnData.posi1 = 4;
        if (stclsFclInfo.keyReq != 0) {
          prnData.str2 = LRmstopncls.ENTRY_NORMAL.val;
        } else {
          prnData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
        }
        rmstPrnlineDataSet(prnData);

        //memset(prnData, 0, sizeof(CHARDATA));
        prnData.str1 = LRmstopncls.FCL_NEGA_REQ.val;
        prnData.posi1 = 4;
        if (stclsFclInfo.negaReq != 0) {
          prnData.str2 = LRmstopncls.ENTRY_NORMAL.val;
        } else {
          prnData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
        }
        rmstPrnlineDataSet(prnData);

        prnLineMake(printData[0]);
        prnLineMake(printData[1]);
        //#endif

        break;
      case 4:
      /* Suica(PFM) */
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstProcPFMSkip: Suica Force End!");
        //#if PRINT_FLG
        prnLineMake(LRmstopncls.ITEM_PFM_SUICA_TXT.val);
        //memset(prnData, 0, sizeof(CHARDATA));
        prnData.str1 = LRmstopncls.PROC_EDY_RSLT.val;
        prnData.posi1 = 4;
        prnData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
        rmstPrnlineDataSet(prnData);
        if (printData[0].isNotEmpty) {
          prnLineMake(printData[0]);
        }
        //#endif
        break;
      case 5:
      /* PiTaPa(PFM) */
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstProcPFMSkip: PiTaPa Force End!");
        //#if PRINT_FLG
        prnLineMake(LRmstopncls.ITEM_PFM_PITAPA_TXT.val);
        //memset(prnData, 0, sizeof(CHARDATA));
        prnData.str1 = LRmstopncls.PROC_EDY_RSLT.val;
        prnData.posi1 = 4;
        prnData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
        rmstPrnlineDataSet(prnData);
        if (printData[0].isNotEmpty) {
          prnLineMake(printData[0]);
        }
        //#endif
        break;
      default:
        log = sprintf("rmstProcFclSkip: type error[%d]", [fclType]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
        break;
    }
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.FORCE_OPEN.val, 20);

    // TODO:00013 三浦 rmstOpenWaitProc 未実装
    //Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, rmstOpenWaitProc);
    return Rmstcom.RMST_OK;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  ///  関連tprxソース: rmstopn.c - rmstEjWritePFMSuicaProc()
  static int rmstEjWritePFMSuicaProc() {
    return 0;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  ///  関連tprxソース: rmstopn.c - rmstEjWriteSuicaObsProc
  static int rmstEjWriteSuicaObsProc() {
    return 0;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  ///  関連tprxソース: rmstopn.c - ExecProcEdyStart
  static int ExecProcEdyStart() {
    return 0;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  ///  関連tprxソース: rmstopn.c - ExecProcPiTaPaStart
  static int ExecProcPiTaPaStart() {
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - ExecPrintInit
  ///  印字初期処理（戻値が0:終了）
  static int ExecPrintInit() {
    // int	ret;
    // String logmsg = "";
    // //char	*vflibcap = NULL;
    //
    // TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "ExecPrintInit Start");
    // Rmstcom.rmstTimerRemove();
    //
    // if (CmCksys.cmMmType() != CmSys.MacERR) {
    //   Rmstcom.rmstMsgClear(null);
    // }
    //
    // font_e  = PrnFontIdx.E24_24_1_1.id;
    // font_e2 = PrnFontIdx.E24_24_1_2.id;
    // font_j  = PrnFontIdx.E24_24_1_1.id;
    // font_j2 = PrnFontIdx.E24_24_1_2.id;
    //
    // // stopncls_printError = 0;
    // // stopncls_printStep = 0;
    //
    // /* プリンター初期化 */
    // ;
    // if ((ret = IfThInit();  if_th_Init(TPRAID_STR)) < 0 ) {
    //   memset( logmsg, 0x00, sizeof(logmsg) );
    //   sprintf( logmsg, "Error on if_th_Init. ret(%d)\n", ret );
    //   TprLibLogWrite( TPRAID_STR, TPRLOG_ERROR, -1, logmsg );
    // }
    //
    // rmstPrnTimerInit( ); /* 2007/03/29 */
    //
    // /* プリンターチェックへ */
    // rmstTimerAdd( NEXT_GO_TIME, (GtkFunction)ExecPrintChk );
    // TprLibLogWrite( TPRAID_STR, TPRLOG_NORMAL, 0, "ExecPrintInit End" );

    return 0;
  }

  ///  関連tprxソース: rmstopn.c - ExecProciDStart
  static int ExecProciDStart() {
    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear('ExecProciDStart');
    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_NOWWAIT.dlgId,
        DlgPattern.TPRDLG_PT2.dlgPtnId,
        null,
        null,
        null,
        null,
        LRmstopncls.FCL_ID_TITLE2.val,
        0);

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "ExecProciD  Start!!");

    // TODO:00012 平野　日計対応：[暫定対応]StclsFclInfoの扱いを確認する
    StclsFclInfo().sKind = FclService.FCL_ID;
    Rmstclsfcl().stclsFclProc();

    return 0;
  }

  ///  関連tprxソース: rmstopn.c - rmstOpenWaitProc
  static Future<int> rmstOpenWaitProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    String filename;
    // char  time_jtype[32]; 

    Rmstcom.rmstTimerRemove();

    if (updErr == 0) {
      fclType = 0;

      // IC_CONNECTが0で定義されていたので、この部分はコメントアウトしておく
      // #if IC_CONNECT
      //   icc_bld = rmstIccBlandNum();
      //   if(cm_JREM_Multisystem() && (icc_bld != 0) && (ICCon_Step == 0)){
      //     ICCon_Step = 1;
      //     rmstTimerAdd( NEXT_GO_TIME, (GtkFunction)ExecProcIccStart);
      //     return 0;
      //   }
      // #endif

      if (await CmCksys.cmFclEdySystem() != 0 &&
          (SioChk.sioCheck(Sio.SIO_FCL) == Typ.YES) && (Edy_FAP_Step == 0)) {
        Edy_FAP_Step = 1;
        fclType = 1;
        retryCnt = 0;
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, ExecProcEdyStart);
        return 0;
      }

      if (await CmCksys.cmFclIDSystem() != 0 &&
          (SioChk.sioCheck(Sio.SIO_FCL) == Typ.YES) && (iD_FAP_Step == 0)) {
        iD_FAP_Step = 1;
        fclType = 3;
        retryCnt = 0;
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, ExecProciDStart);
        return 0;
      }
      if (await CmCksys.cmPFMJRICSystem() != 0 && (Suica_PFM_Step == 0)) {
        Suica_PFM_Step = 1;
        fclType = 4;
        retryCnt = 0;
        Rmstcom.rmstMsgClear("rmstOpenWaitProc");
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_NOWWAIT.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            null,
            null,
            null,
            null,
            LRmstopncls.SUICA_TITLE.val,
            0);
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, ExecProcPiTaPaStart);
        return 0;
      }
      if (await CmCksys.cmPFMPiTaPaSystem() != 0 && (PiTaPa_PFM_Step == 0)) {
        PiTaPa_PFM_Step = 1;
        fclType = 5;
        retryCnt = 0;
        Rmstcom.rmstMsgClear("rmstOpenWaitProc");
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_NOWWAIT.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            null,
            null,
            null,
            null,
            LRmstopncls.PITAPA_TITLE.val,
            0);
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, ExecProcPiTaPaStart);
        return 0;
      }
    }

    // PRINT_FLGが1で定義されていたので、この部分はコメントアウトしておく
    // #if !PRINT_FLG
    //     if(cm_mm_type() != MacERR){
    //       rmstMsgClear();
    //       gtk_grab_add( winstopn );
    //     }
    // #endif

    // #if PRINT_FLG
    // #if FJSS
    if (await CmCkFjss.cmFjssSystem() != 0) {
      opnFtpSend();
    }
    // #endif
    // #endif

    /* 2008/01/25 >>> */
    if (((CmCksys.cmMmType() == CmSys.MacMOnly) ||
        (CmCksys.cmMmType() == CmSys.MacM1) ||
        (CmCksys.cmMmType() == CmSys.MacM2)) &&
        (pCom.dbTrm.loasonMasterImport != 0)) {
      // rmstOpen_LS_Mst_Read( ); TODO:00015 江原 森さんコミット待ち
    }
    /* <<< 2008/01/25 */

    /* 2004/08/18 >>> */
    // #if 1 //V15@@@@
    if (((CmCksys.cmMmType() == CmSys.MacMOnly) ||
        (CmCksys.cmMmType() == CmSys.MacM1)) ||
        ((CmCksys.cmMmType() != CmSys.MacERR) &&
            (PlgTaxchgPlan.prgPlanUpdateResultLogProc(
                Tpraid.TPRAID_STR, TaxchgPlanLogType.TAXCHG_PLAN_LOG_CHECK) ==
                0) && (await CmCksys.cm24hourSystem() != 0))
    ) {
      /* M/BS/S 税種予約変更実行中 24時間仕様 である  */
      // TODO:00015 江原 DB書き込み処理
      RmStOpenChPriceT();
    }
    // #endif

    rmstOpenPointReteSet();

    /* <<< 2004/08/18 */

    // #if 0
    // //#if CUSTREALSVR && SAPPORO
    //     if(RsvFlg == 1 || RsvFlg == -1){
    //         rmstOpenRsvExecData_Printmain( );
    //     }
    // //#endif
    // #endif
    if (recalChk != 0) {
      Rmstcom.rmstEjTxtMake(" ", Rmstcom.REG_OPEN);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.BS_REQUEST6_TXT.val, 4);
      Rmstcom.rmstEjTxtMake(" ", Rmstcom.REG_OPEN);
      // PRINT_FLGが1で定義されていたので、この部分はコメントアウトしておく
      // #if PRINT_FLG
      prnLineMake(LRmstopncls.BS_REQUEST6_TXT.val);
      // #endif
    }

    // コンパイルスイッチオフ
    /*
    #if 0
        cm_clr((char *)&ej_data, sizeof(ej_data));
        ej_data.str1 = EJ_ASTER; 
        ej_data.str2 = EJ_ASTER2; 
        ej_data.str3 = EJ_ASTER; 
        rmstEjTxtMake_New(&ej_data);
    #if PRINT_FLG
        PrnLineMake(PRINT_ASTER);
    #endif
      memset(time_jtype,0,sizeof(time_jtype));
    //    rmstGetDateTimeJtype(time_jtype);
      datetime_change( NULL, time_jtype, 1, FT_YYYYMMDD_KANJI_HHMM, 1 );
      cm_clr((char *)&ej_data, sizeof(ej_data));
      ej_data.str1 = OPN_PROC_END; 
      ej_data.str2 = time_jtype; 
      ej_data.posi1 = 1; 
      ej_data.posi2 = ej_data.posi1 + AplLib_EucCnt(ej_data.str1) +4;
      rmstEjTxtMake_New(&ej_data);
      #if PRINT_FLG
          PrnLineMake(PRINT_OPNPROCEND);
      #endif
          rmstEjTxtMake_New2(" ", 0);
      #if PRINT_FLG
          PrnLineMake(" ");
      #endif
          rmstEjWriteEdit(); 
      #endif
    */
    await rmstOpnEndEJ();

    // #if QUICK_0_AND_4_MERGE
    filename = sprintf(
        AplLib.SPEC_BKUP_TAR_NG_TXT_DATE_NONE, [EnvironmentData().sysHomeDir]);
    if (File(filename).existsSync()) /* SPEC_BKUP NGファイルが存在しない */ {
      /* SPEC_BKUP作成成功時のみSPEC_BKUP用FTPタスクを起動する */
      DataRestorLib.specBackUpLibDataCallFtp(Tpraid.TPRAID_STR, "0");
    }
    // #endif

    DataRestorLib.specBackUpLibDataCallFtp(Tpraid.TPRAID_STR, "1");

    scrDestroy();
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "ST_OPEN END!!");
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - OpnFtpSend
  static void opnFtpSend() {
    // #if 0	// @@@V15	送信タスクにまかせるようにする
    /*
    FILE *fp;
    char fname[256];
    char getbuf[256];
    char cmd[256];
    char macini[256];
    char data_knd[4];
    char data[256];
    char TarFile[256];
    int  kind;
    int  FtpSts = 0;

    if (( cm_mm_type() != MacMOnly ) &&
        ( cm_mm_type() != MacM1    )    ) {
      return;
    }

    sprintf( macini, "%s/conf/mac_info.ini", SysHomeDirp );

    memset( data_knd, 0x00, sizeof( data_knd ));	
    TprLibGetIni( macini, "csv_bkup", "data_knd", data_knd );
    kind = atoi( data_knd );

    memset( fname, 0x00, sizeof( fname ));
    sprintf( fname, "%s/tmp/%s", SysHomeDirp, OPN_FTP_CMD );
    if ( access( fname, 0 ) != 0 ) {
      return;
    }

    cm_clr((char *)&ej_data, sizeof(ej_data));
    ej_data.str1 = PRINT_STAR; 
    ej_data.str2 = CSVTXT_CSVBKUP; 
    ej_data.posi1 = 4; 
    rmstEjTxtMake_New(&ej_data);
          PrnLineMake( data );
    memset( data, 0, sizeof( data ));

    if ((fp = fopen( fname, "r" )) != NULL ) {

      fgets( getbuf, sizeof( getbuf ) - 1, fp );
      printf("|%s|\n", getbuf);
      memset( TarFile, 0x00, sizeof( TarFile ));
      sprintf( TarFile, "%s/hqftp/backup/%s", SysHomeDirp, getbuf);
      memset( cmd, 0x00, sizeof( cmd ));
      if ( kind == 2 ) {
        sprintf(cmd, "/bin/tar xzCf %s/hqftp %s", SysHomeDirp, TarFile ); 
      }
      else {
        sprintf(cmd, "/bin/cp %s %s/hqftp", TarFile, SysHomeDirp); 
      }
      printf("|%s|\n", cmd);
      system( cmd );
      FtpSts = rcFtp_send_to_HQ_main( TPRAID_STR, 0 );
      if ( FtpSts ) {
        memset( cmd, 0x00, sizeof( cmd ));
        sprintf(cmd, "/bin/mv %s %s_NG", getbuf, getbuf); 
        system( cmd );
      }
    }
    if ( fp != NULL ) fclose( fp );

    memset( cmd, 0x00, sizeof( cmd ));
    sprintf(cmd, "/bin/rm -f %s", fname ); 
    system( cmd );
    cm_clr((char *)&ej_data, sizeof(ej_data));
    ej_data.str1 = CSVTXT_ACTFTP; 
    if(FtpSts)
      ej_data.str2 = ENTRY_TXT_NG; 
    else
      ej_data.str2 = ENTRY_TXT_OK; 
    rmstEjTxtMake_New(&ej_data);
    PrnLineMake2( 8, data );

    return;
    */
    // #endif
  }

  ///  関連tprxソース: rmstopn.c - rmstOpenPointReteSet
  static void rmstOpenPointReteSet() {
    String data = '';
    String ejdata = '';
    int buyFlg = 0;
    CmEditCtrl fCtrl = CmEditCtrl();
    TImgDataAdd imgDataAdd = TImgDataAdd();
    TImgDataAddAns ans = TImgDataAddAns();
    int i = 0;
    int limit = 0;
    double magn = 0.0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.printPointOpenope == 0) {
      return;
    }

    if (SEGMENT && pCom.dbRegCtrl.setOwnerFlg > 0) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // RmDBRead.rmDbReadTrm();
    }

    data = sprintf(LRmstopncls.BASPNT_MAGN.val, [pCom.dbTrm.buyPointAddMagn]);

    Rmstcom.rmstEjTxtMakeNew2(ejdata, 6);
    if (PRINT_FLG != 0) {
      prnLineMake(data.toString());
    }

    for (i = 0; i < 4; i ++) {
      switch (i) {
        case 0:
          limit = pCom.dbTrm.buyPointLlimt1;
          magn = pCom.dbTrm.buyPointMagn1;
          break;
        case 1:
          limit = pCom.dbTrm.buyPointLlimt2;
          magn = pCom.dbTrm.buyPointMagn2;
          break;
        case 2:
          limit = pCom.dbTrm.buyPointLlimt3;
          magn = pCom.dbTrm.buyPointMagn3;
          break;
        case 3:
          limit = pCom.dbTrm.buyPointLlimt4;
          magn = pCom.dbTrm.buyPointMagn4;
          break;
      }
      if ((limit == 0) && (magn == 0.00)) {
        continue;
      }
      if (buyFlg == 0) {
        Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.BUYPNT_MAGN.val, 6);
        if (PRINT_FLG != 0) {
          prnLineMake(LRmstopncls.BUYPNT_MAGN.val);
        }
        buyFlg = 1;
      }
      int num = 0;

      data = sprintf(LRmstopncls.BUYPNT_MAGN1.val, [magn]);

      CmStrMolding.cmMultiImgDataAddChar(
          Tpraid.TPRAID_STR,
          imgDataAdd,
          num++,
          CmStrMolding.DATA_PTN_NONE,
          6,
          data.length,
          data);
      CmStrMolding.cmMultiImgDataAddUnitPrice(
          Tpraid.TPRAID_STR,
          imgDataAdd,
          num++,
          0,
          CmStrMolding.RCPTWIDTH - 12,
          EditCtrlTyps.EDITCTRL_TYP_1.id,
          fCtrl,
          12,
          limit.toDouble());
      CmStrMolding.cmMultiImgDataAdd(Tpraid.TPRAID_STR, imgDataAdd, ans);
      Rmstcom.rmstEjTxtMakeNew2(ans.line[0], 4);
      if (PRINT_FLG != 0) {
        prnLineMake(ans.line[0]);
      }
    }
  }

  /// 機能：画面終了(メインメニューへ)
  /// 引数：なし
  /// 戻値：0:終了
  ///  関連tprxソース: rmstopn.c - ScrDestroy
  static int scrDestroy() {
    int orgMod;
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, 'scrDestroy Start');
    // TODO:10121 QUICPay、iD 202404実装対象外
    orgMod = rmstopnWinMod;
    rmstopnWinMod = STOPN_END;

    /* /* データベース開放 */
    if(rm_srx_con != NULL) {
      db_PQfinish(TPRAID_STR, rm_srx_con);
      rm_srx_con = NULL;
    }
    if(rm_sub_con != NULL) {
      db_PQfinish(TPRAID_STR, rm_sub_con);
      rm_sub_con = NULL;
    }
    if(rm_tpr_con != NULL) {
      db_PQfinish(TPRAID_STR, rm_tpr_con);
      rm_tpr_con = NULL;
    }
    if(prnfp != NULL){
      fclose(prnfp);
      prnfp = NULL;
    }

    if(abs(cnct_mem_get(TPRAID_STR, CNCT_MULTI_CNCT))) {
      fcl_auto_no_start(TPRAID_STR, 0);
    } */

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (((pCom.dbTrm.streOpenReport == 1)
        // TODO:10121 QUICPay、iD 202404実装対象外
        // || (cm_Suica_system()) || (cm_DepartmentStore_system()) || (ChkAutoOpen())
        // #if IC_CONNECT
        // || (cm_JREM_Multisystem())
        // #endif
        //  ||(cm_sp_department_system())
        //  ||((cm_Fcl_Edy_system()) && (sio_check(SIO_FCL) == YES))
        || ((CmCksys.cmFclIDSystem() != 0) &&
            (SioChk.sioCheck(Sio.SIO_FCL) == Typ.YES))
        // TODO:10121 QUICPay、iD 202404実装対象外
        //  ||(cm_PFM_PiTaPa_system())
        //  ||(cm_PFM_JR_IC_system())
        || (printTyp == NORMAL_END)
        || (Jmups_Print == NORMAL_END)
        // TODO:10121 QUICPay、iD 202404実装対象外
        //  || (rmstopnHostCopyErrFileChk(HOST_COPY_ERR_FILE) == TRUE)
        //  || (prgPlanUpdateResultLogProc(Tpraid.TPRAID_STR, TAXCHG_PLAN_LOG_CHECK) == 0)
    ) && (orgMod != STOPN_PWOFF) && (orgMod != 0)) {
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, ExecPrintInit);
    } else {
      if (((CmCksys.cmMmType() == CmSys.MacMOnly) ||
          (CmCksys.cmMmType() == CmSys.MacM1) ||
          (CmCksys.cmMmType() == CmSys.MacM2)) &&
          (pCom.dbTrm.loasonMasterImport != 0)) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if (stopen_chk == 0) {
        //   rmstOpenLSMstReadSendEJ();
        // }
      }

      if (((CmCksys.cmMmType() == CmSys.MacMOnly) ||
          (CmCksys.cmMmType() == CmSys.MacM1)) ||
          ((CmCksys.cmMmType() != CmSys.MacERR) &&
              (PlgTaxchgPlan.prgPlanUpdateResultLogProc(
                  Tpraid.TPRAID_STR, TaxchgPlanLogType.TAXCHG_PLAN_LOG_CHECK) ==
                  0)
              && (CmCksys.cm24hourSystem() != 0))) {
        /* M/BS/S 税種予約変更実行中 24時間仕様 である  */
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if (stopen_chk == 0) {
        //   rmstOpenChpriceSendEj();
        // }
      }
      rmstOpenEndMsgChk();
    }
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, 'scrDestroy End');

    return 0;
  }

  /// 再送信等の警告メッセージ表示
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - rmstOpen_EndMsg_Chk
  static int rmstOpenEndMsgChk() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  /// 関数：int rmstOpenChprice(void)
  /// 機能：売価変更
  /// 引数：RmstopnChpriceT rmstOpenChPrice
  /// 戻値：0:終了
  ///  関連tprxソース: rmstopn.c - rmstOpenChprice
  static int rmStOpnChPrice() {
    int batprcchgNo = 0;

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmstOpenChprice Start");
// HGC仕様 100 -9999 <2007.03.12>mn
    rmStOpnChPriceT.dbBatprcchg = CBatprcchgMstColumns();
    rmStOpnChPriceT.dbBatprcchgPlu = CBatprcchgMstColumns();
    rmStOpnChPriceT.dbPlu = ChPricePluMst();
    rmStOpnChPriceT.paramChprice = ChgParam();
    rmStOpnChPriceT.batprcchgNum = 0;
    rmStOpnChPriceT.errCnt = 0;
    rmStOpnChPriceT.procNum = 0;
    rmStOpnChPriceT.runFlg = 0;
    rmStOpnChPriceT.stepStatus = 0;
    rmStOpnChPriceT.prnHead = 1;

    /* make backup */
    rmStOpenChPriceBackup();
    for (batprcchgNo = 1; batprcchgNo <= 8; batprcchgNo++) {
      rmStOpnChPriceT.prcchgCd = batprcchgNo;
      /* pickup c_batprcchg_mst */
      rmStOpenChPricePickupBatPrcChg();
      if (rmStOpnChPriceT.stepStatus == 1) {
        /* read c_batprcchg_mst */
        rmStOpenChPriceReadBatPrcChg();
      }
      if (rmStOpnChPriceT.stepStatus == 2) {
        /* read c_plu_mst */
        // TODO:00013 三浦 rmStOpnChPriceTBackup未実装
        //rmStOpenChPrice_read_plu( );
      }
      if (rmStOpnChPriceT.stepStatus == 3) {
        /* write c_prcchg_mst*/
        // TODO:00013 三浦 rmStOpnChPriceTBackup未実装
        //rmStOpenChPrice_write( );
      }
      if (rmStOpnChPriceT.stepStatus == 4) {
        /* EJ-LOG */
        // TODO:00013 三浦 rmStOpnChPriceTBackup未実装
        //rmStOpenChPrice_make_ej( );
      }
      if (rmStOpnChPriceT.stepStatus == 5) {
        /* make history */
        // TODO:00013 三浦 rmStOpnChPriceTBackup未実装
        //rmStOpenChPrice_make_history( );
      }
    }
    /* delete backup */
    // TODO:00013 三浦 rmStOpnChPriceTBackup未実装
    //rmStOpenChPrice_delete_backup( );

    // free( rmStOpnChPriceT.db_batprcchg );
    // free( rmStOpnChPriceT.db_batprcchg_plu );

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmStOpnChPriceT End");

    return 0;
  }

  /// 関数名       : rmstOpenChprice_backup
  /// 機能概要     : テーブル:c_plu_mstとc_batprcchg_mstのバックアップを作成する。
  /// 呼び出し方法 :
  /// パラメータ   : なし
  /// 戻り値      : なし
  ///  関連tprxソース: rmstopn.c - rmstOpenChprice_backup
  static Future<void> rmStOpenChPriceBackup() async {
    String tmpFile = '';
    String backupFile = '';
    String cmd = '';
    Result localRes;
    String sql = '';

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "rmstOpen_chprice_backup Start");

    // バックアップ作成
    tmpFile = sprintf("/tmp/%s", [PLUMST_BKUP]);
    backupFile =
        sprintf("%s/tmp/%s", [EnvironmentData().sysHomeDir, PLUMST_BKUP]);

    if (TprxPlatform.getFile(backupFile).existsSync()) {
      AplLibStdAdd.aplLibRemove(Tpraid.TPRAID_SYSINI, backupFile);
    }
    // c_plu_mstのバックアップ
    DbManipulationPs db = DbManipulationPs();
    sql = sprintf("COPY c_plu_mst TO '%s' with null as '';", [tmpFile]);
    try {
      localRes = await db.dbCon.execute(Sql.named(sql));
      if (localRes.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstOpen_chprice_backup DB backup ERROR\n");
        rmStOpnChPriceT.stepStatus = -1;
        return;
      }
      cmd = sprintf("mv %s %s", [tmpFile, backupFile]);
      ProcessResult procResult = await Process.run(cmd, []);
      if (procResult.stdout.length > 0) {
        return;
      }
      //db_PQclear( TPRAID_STR, local_res );
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmstOpenChPriceBackup(): db.dbCon.execute() $e,$s");
      return;
    }
    tmpFile = sprintf("/tmp/%s", [BATPRCCHG_BKUP]);
    backupFile =
        sprintf("%s/tmp/%s", [EnvironmentData().sysHomeDir, BATPRCCHG_BKUP]);
    if (TprxPlatform.getFile(backupFile).existsSync()) {
      AplLibStdAdd.aplLibRemove(Tpraid.TPRAID_SYSINI, backupFile);
    }
    // c_batprcchg_mstのバックアップ
    sql = sprintf("COPY c_batprcchg_mst TO '%s' with null as '';", [tmpFile]);
    try {
      localRes = await db.dbCon.execute(Sql.named(sql));
      if (localRes.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstOpen_chprice_backup DB backup ERROR\n");
        rmStOpnChPriceT.stepStatus = -1;
        return;
      }
      cmd = sprintf("mv %s %s", [tmpFile, backupFile]);
      ProcessResult procResult = await Process.run(cmd, []);
      if (procResult.stdout.length > 0) {
        return;
      }
      //db_PQclear( TPRAID_STR, local_res );
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmstOpenChPriceBackup(): db.dbCon.execute() $e,$s");
      return;
    }
  }

  ///  関連tprxソース: rmstopn.c - rmstOpenChprice_pickup_batprcchg
  static Future<void> rmStOpenChPricePickupBatPrcChg() async {
    Result localRes;
    int nTuples = 0;
    String sql = '';
    String saleDate = '';
    DateTime dTime;
    String yy = '';
    String mm = '';
    String dd = '';
    String weekBuf = '';
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    rmStOpnChPriceT.batprcchgNum = 0;
    rmStOpnChPriceT.procNum = 0;

    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        Tpraid.TPRAID_STR,
        CompetitionIniLists.COMPETITION_INI_SALE_DATE,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    saleDate = ret.value.substring(0, 10);
    /* get sale date */

    log = sprintf(
        "rmstOpenChprice_pickup_batprcchg( ) sale_date[%10s]\n", [saleDate]);
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

    yy = CmAry.setStringZero(4);
    mm = CmAry.setStringZero(2);
    dd = CmAry.setStringZero(2);
    yy = saleDate.substring(0, 4);
    mm = saleDate.substring(5, 7);
    dd = saleDate.substring(8, 10);

    dTime = DateTime(int.parse(yy), int.parse(mm), int.parse(dd));

    switch (dTime.weekday) {
      case 0:
        weekBuf = "${weekBuf}sun_flg";
        break;
      case 1:
        weekBuf = "${weekBuf}mon_flg";
        break;
      case 2:
        weekBuf = "${weekBuf}tue_flg";
        break;
      case 3:
        weekBuf = "${weekBuf}wed_flg";
        break;
      case 4:
        weekBuf = "${weekBuf}thu_flg";
        break;
      case 5:
        weekBuf = "${weekBuf}fri_flg";
        break;
      case 6:
        weekBuf = "${weekBuf}sat_flg";
        break;
      default:
    }

    DbManipulationPs db = DbManipulationPs();
    if (rmStOpnChPriceT.runFlg == 0) {
      /* run */
      weekBuf = "$weekBuf='1'";
      sql = sprintf(
          "select prcchg_cd from c_batprcchg_mst where stre_cd='%i' and prcchg_cd='%i' and start_datetime<='%s' and %s and stop_flg='0' group by prcchg_cd;",
          [pCom.dbRegCtrl.streCd, rmStOpnChPriceT.prcchgCd, saleDate, weekBuf]);
    }
//	else if( rmstOpen_chprice.run_flg == 1 ){	/* restore */
//		strcat( week_buf, "='0'" );
//		sprintf( sql
//			   , "select prcchg_cd from c_batprcchg_mst where stre_cd='%ld' and ( prcchg_cd>='201' and prcchg_cd<='208' ) and ( start_datetime<='%s' and end_datetime>='%s') and %s and stop_flg='0' and timesch_flg='1' group by prcchg_cd;"
//			   , pCom->db_regctrl.stre_cd, sale_date, sale_date, week_buf );
//	}
//	else{										/* last restore */
//		sprintf( sql
//			   , "select prcchg_cd from c_batprcchg_mst where stre_cd='%ld' and ( prcchg_cd>='201' and prcchg_cd<='208' ) and end_datetime<'%s' and stop_flg='0' and timesch_flg='1' group by prcchg_cd;"
//			   , pCom->db_regctrl.stre_cd, sale_date );
//	}

    try {
      localRes = await db.dbCon.execute(Sql.named(sql));
      if (localRes.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "c_batprcchg_mst get error\n");
        rmStOpnChPriceT.stepStatus = -1;
        return;
      }
      //db_PQclear( TPRAID_STR, local_res );
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmStOpenChPricePickupBatPrcChg(): db.dbCon.execute() $e,$s");
      return;
    }

    nTuples = localRes.length;
    if (nTuples != 0) {
      rmStOpnChPriceT.stepStatus = 1; /* NEXT : read c_batprcchg_mst */
    } else {
      rmStOpnChPriceT.stepStatus = -1;
    }
  }

  ///  関連tprxソース:rmstopn.c - rmstEjWriteVerifone()
  static Future<void> rmstEjWriteVerifone() async {
    String filename;
    int lineCnt = 0;

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "rmstEjWriteVerifone START!!");

    filename = sprintf("%s%s", [
      EnvironmentData().sysHomeDir, "/tmp/Vesca_last_dly/Vesca_dly_last.txt"]);
    var fpTxt = File(filename);
    if (!await fpTxt.exists()) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "no DATA");
      return;
    }

    // 日計処理結果ファイルは既に印字用に編集されているので、最大行に分割するだけ
    filename = '';
    filename = sprintf("%s%s", [
      EnvironmentData().sysHomeDir, "/tmp/Vesca_last_dly/Vesca_dly_last.tmp"]);
    var fpTmp = File(filename);

    var lines = fpTxt.readAsLinesSync();
    IOSink? sink;
    for (var line in lines) {
      if (lineCnt == 0) {
        if (sink != null) {
          await sink.close();
        }
        sink = fpTmp.openWrite();
      }
      sink!.write(line);
      await sink.flush();
      lineCnt++;

      // 最大行に達したら、DBに書込みする
      if (lineCnt >= VERIFONE_EJLINE_MAX) {
        await sink.close();
        if (await fpTmp.exists()) {
          rmstEjWriteVerifoneWriteEj(filename);
          lineCnt = 0;
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
              "rmstEjWriteVerifone next record");
        }
      }
    }
    // DBに書込みする
    if (await fpTmp.exists()) {
      rmstEjWriteVerifoneWriteEj(filename);
    }
    if (await fpTxt.exists()) {
      fpTxt.writeAsString('');
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "DELL!! Vesca_dly_last.txt");
    }
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "rmstEjWriteVerifone END!!");
  }

  /// 関連tprxソース:rmstopn.c - rmstEjWriteVerifoneWriteEj()
  static void rmstEjWriteVerifoneWriteEj(String filename) {
    MmReptlib().headprintEj(5, ReptNumber.MMREPT189.index);
    MmReptlib().addEjDataText(
        Tpraid.TPRAID_STR, filename, 5, ReptNumber.MMREPT189.index);
    EjLib().cmEjOther();
    MmReptlib.countUp();
  }

  /// 関連tprxソース:rmstopn.c - rmstOpenChprice_read_batprcchg()
  static Future<void> rmStOpenChPriceReadBatPrcChg() async {
    Result localRes;
    String sql = '';
    int revision = 0;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    log = sprintf(
        "rmstOpenChprice_read_batprcchg( ) prcchg_cd[%i] run_flg[%i] batprcchg_num[%i] \n",
        [
          rmStOpnChPriceT.prcchgCd,
          rmStOpnChPriceT.runFlg,
          rmStOpnChPriceT.batprcchgNum
        ]);
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

    DbManipulationPs db = DbManipulationPs();
    sql = sprintf(
        "select * from c_batprcchg_mst where stre_cd='%i' and prcchg_cd='%i' order by plu_cd;",
        [pCom.dbRegCtrl.streCd, rmStOpnChPriceT.prcchgCd]);

    try {
      localRes = await db.dbCon.execute(Sql.named(sql));
      if (localRes.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "c_batprcchg_mst get error\n");
        rmStOpnChPriceT.stepStatus = -1;
        return;
      }
      //db_PQclear( TPRAID_STR, local_res );
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmStOpenChPriceReadBatPrcChg(): db.dbCon.execute() $e,$s");
      return;
    }

    rmStOpnChPriceT.batprcchgNum = localRes.length;
    rmStOpnChPriceT.errCnt = 0;
    rmStOpnChPriceT.procNum = 0;
    if (rmStOpnChPriceT.batprcchgNum != 0) {
      // HGC仕様 100 -> 9999 <2007.03.12>mn
      rmStOpnChPriceT.dbBatprcchg = CBatprcchgMstColumns();
      rmStOpnChPriceT.dbBatprcchgPlu = CBatprcchgMstColumns();

      for (int cnt = 0; cnt < rmStOpnChPriceT.batprcchgNum; cnt++) {
        if (cnt >= BATPRCCHG_ODER_MAX) {
          break;
        }

        Map<String, dynamic> data = localRes.elementAt(cnt).toColumnMap();

        rmStOpnChPriceT.dbBatprcchg.prcchg_cd =
            data["prcchg_cd"] ?? 0 - revision;
        rmStOpnChPriceT.dbBatprcchg.order_cd = data["order_cd"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.stre_cd =
            int.tryParse(data["stre_cd"]) ?? 0;
        rmStOpnChPriceT.dbBatprcchg.plu_cd = data["plu_cd"] ?? '';
        rmStOpnChPriceT.dbBatprcchg.flg = data["flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.pos_prc =
            int.tryParse(data["pos_prc"]) ?? 0;
        rmStOpnChPriceT.dbBatprcchg.cust_prc =
            int.tryParse(data["cust_prc"]) ?? 0;
        rmStOpnChPriceT.dbBatprcchg.start_datetime =
            (data["start_datetime"] ?? '').toString();
        rmStOpnChPriceT.dbBatprcchg.end_datetime =
            (data["end_datetime"] ?? '').toString();
        rmStOpnChPriceT.dbBatprcchg.timesch_flg = data["timesch_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.sun_flg = data["sun_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.mon_flg = data["mon_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.tue_flg = data["tue_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.wed_flg = data["wed_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.thu_flg = data["thu_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.fri_flg = data["fri_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.sat_flg = data["sat_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchg.stop_flg = data["stop_flg"] ?? 0;
        rmStOpnChPriceT.dbBatprcchgPlu = rmStOpnChPriceT.dbBatprcchg;
        if (rmStOpnChPriceT.dbBatprcchg.prcchg_cd != null) {
          rmStOpnChPriceT.dbBatprcchgPlu.prcchg_cd =
              rmStOpnChPriceT.dbBatprcchg.prcchg_cd! + 100;
        }
      }
      rmStOpnChPriceT.stepStatus = 2; /* NEXT : read c_plu_mst */
    } else {
      rmStOpnChPriceT.stepStatus = -1;
    }

    //db_PQclear( TPRAID_STR, local_res );
  }

  /// 関連tprxソース:rmstopn.c - rmstOpenChprice_make_history()
  /// 機能概要     : 売価変更完了時に作成した履歴ログファイルを作成する。
  /// パラメータ　　: なし
  /// 戻り値　　　　: なし
  static Future<void> rmstOpenChpriceMakeHistory() async {
    String historyFile = '';
    String sql = '';
    int ret = 0;
    RxMemRet retC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (retC.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = retC.object;

    if (pCom.offline == 1) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmstOpen_chprice_make_history M offline\n");
      rmStOpnChPriceT.stepStatus = -1; /* NEXT  : EXIT */
      return;
    }

    // 予約
    /* BatPrcChg(100) Delete */
    dbBatPrcChgUpd.dbBatPrcChgUpdGrpDelete(Tpraid.TPRAID_STR,
        rmStOpnChPriceT.localCon, rmStOpnChPriceT.prcchgCd + 100, 3);
    /* BatPrcChg(200) Delete */
    dbBatPrcChgUpd.dbBatPrcChgUpdGrpDelete(Tpraid.TPRAID_STR,
        rmStOpnChPriceT.localCon, rmStOpnChPriceT.prcchgCd + 200, 3);

    for (int i = 0; i < rmStOpnChPriceT.batprcchgNum; i++) {
      // 予約
      /* BatPrcChg(100) Insert */
      sql = sprintf("insert into c_batprcchg_mst (prcchg_cd, order_cd,"
          " stre_cd, plu_cd, flg, pos_prc, cust_prc, start_datetime, timesch_flg,"
          " sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, stop_flg) "
          "values('%d', '%d', '%ld', '%s', '%d', '%ld', '%ld', '%s', '%d', '%d',"
          " '%d', '%d', '%d', '%d', '%d', '%d', '%d'", [
        rmStOpnChPriceT.prcchgCd + 100,
        rmStOpnChPriceT.dbBatprcchg.order_cd,
        rmStOpnChPriceT.dbBatprcchg.stre_cd,
        rmStOpnChPriceT.dbBatprcchg.plu_cd,
        rmStOpnChPriceT.dbBatprcchg.flg,
        rmStOpnChPriceT.dbPlu.posPrc,
        rmStOpnChPriceT.dbPlu.custPrc,
        rmStOpnChPriceT.dbBatprcchg.start_datetime,
        rmStOpnChPriceT.dbBatprcchg.timesch_flg,
        rmStOpnChPriceT.dbBatprcchg.sun_flg,
        rmStOpnChPriceT.dbBatprcchg.mon_flg,
        rmStOpnChPriceT.dbBatprcchg.tue_flg,
        rmStOpnChPriceT.dbBatprcchg.wed_flg,
        rmStOpnChPriceT.dbBatprcchg.thu_flg,
        rmStOpnChPriceT.dbBatprcchg.fri_flg,
        rmStOpnChPriceT.dbBatprcchg.sat_flg,
        rmStOpnChPriceT.dbBatprcchg.stop_flg
      ]);
      ret = await PrgLib.prgHistlogWrite(rmStOpnChPriceT.localCon, sql, sql);
      if (ret == Typ.NG) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstOpenChpriceMakeHistory : Prg_Histlog_writeU() error\n");
        return;
      }
      // 予約
      /* BatPrcChg(200) Insert */
      sql = sprintf("insert into c_batprcchg_mst (prcchg_cd, order_cd,"
          " stre_cd, plu_cd, flg, pos_prc, cust_prc, start_datetime, timesch_flg,"
          " sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, stop_flg) "
          "values('%d', '%d', '%ld', '%s', '%d', '%ld', '%ld', '%s', '%d', '%d',"
          " '%d', '%d', '%d', '%d', '%d', '%d', '%d'", [
        rmStOpnChPriceT.prcchgCd + 200,
        rmStOpnChPriceT.dbBatprcchg.order_cd,
        rmStOpnChPriceT.dbBatprcchg.stre_cd,
        rmStOpnChPriceT.dbBatprcchg.plu_cd,
        rmStOpnChPriceT.dbBatprcchg.flg,
        rmStOpnChPriceT.dbPlu.posPrc,
        rmStOpnChPriceT.dbPlu.custPrc,
        rmStOpnChPriceT.dbBatprcchg.start_datetime,
        rmStOpnChPriceT.dbBatprcchg.timesch_flg,
        rmStOpnChPriceT.dbBatprcchg.sun_flg,
        rmStOpnChPriceT.dbBatprcchg.mon_flg,
        rmStOpnChPriceT.dbBatprcchg.tue_flg,
        rmStOpnChPriceT.dbBatprcchg.wed_flg,
        rmStOpnChPriceT.dbBatprcchg.thu_flg,
        rmStOpnChPriceT.dbBatprcchg.fri_flg,
        rmStOpnChPriceT.dbBatprcchg.sat_flg,
        rmStOpnChPriceT.dbBatprcchg.stop_flg
      ]);
      ret = await PrgLib.prgHistlogWrite(rmStOpnChPriceT.localCon, sql, sql);
      if (ret == Typ.NG) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstOpenChpriceMakeHistory : Prg_Histlog_writeU() error\n");
        return;
      }
    }
    // 履歴ログ作成
    // 予約
    /* BatPrcChg(0) Delete */
    dbBatPrcChgUpd.dbBatPrcChgUpdGrpDelete(Tpraid.TPRAID_STR,
        rmStOpnChPriceT.localCon, rmStOpnChPriceT.prcchgCd, 3); // HistLog
    /* PrcChg Insert */
    dbBatPrcChgUpd.dbBatPrcChgUpdGrpDelete(Tpraid.TPRAID_STR,
        rmStOpnChPriceT.localCon, rmStOpnChPriceT.prcchgCd, 2); // PrcChg

    historyFile = sprintf("%s/log/%s", [EnvironmentData().sysHomeDir,
      CHPRICE_HISTORY]);

    var file = File(historyFile);
    if (file.existsSync()) {
      file.openSync(mode: FileMode.append);
      String getBuf = "Step 5 : End of PrcChg Update\n";
      file.writeAsString(getBuf);
    }
    else {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "rmstOpen_chprice_write history log failed \n");
      return;
    }
    file.deleteSync();
    rmStOpnChPriceT.stepStatus = -1; /* NEXT : EXIT */
  }

  /// 機能：開設処理強制終了
  /// 関連tprxソース:rmstopn.c - rmstopn_PreUpdateWait()
  static Future<void> rmstOpnPreUpdateWait() async {
    if (await AplLibHqConnect.aplLibHqConnectHqHistRecvCheckSystem(
        Tpraid.TPRAID_STR) != 0) {
      // 上位システム接続の場合, 上位システムからの取得を先に行う.
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId,
          DlgPattern.TPRDLG_PT2.dlgPtnId,
          updateStop,
          LTprDlg.BTN_INTERRUPT,
          null,
          null,
          "",
          0);
      AplLibHqConnect.aplLibHqConnectHqHistRequestStart(
          Tpraid.TPRAID_STR, HqHistRequestTyp.HQHIST_REQ_OPN.type);
    }
    // 上位からのマスタ更新待ち開始. その他のシステムは更新待ちしない
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "rmstopn_PreUpdateWait End.\n");
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, hqaspHqhistWait);
    return;
  }

  /// 機能：履歴ログ処理取得中断メッセージの表示
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース:rmstopn.c - UpdateStop()
  static int updateStop() {
    String callFunc = 'updateStop';
    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );
    PROC_STS = FORCE;

    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_NOWUPDATINGSTOP.dlgId,
        DlgPattern.TPRDLG_PT1.dlgPtnId,
        updateStopYes,
        LTprDlg.BTN_YES,
        updateStopNo,
        LTprDlg.BTN_NO,
        "",
        0);

    return 0;
  }

  /// 関連tprxソース:rmstopn.c - UpdateStop_yes()
  static Future<int> updateStopYes() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }

    RxTaskStatBuf pStat = xRet.object;
    Rmstopn.prnLineMake2(2, LRmstopncls.GET_HISTLOG_STOP.val);

    if (CmCksys.cmMmType() == CmSys.MacM1 ||
        CmCksys.cmMmType() == CmSys.MacMOnly) {
      if ((await Recog().recogGet(
          Tpraid.TPRAID_STR, RecogLists.RECOG_TUOCARDSYSTEM,
          RecogTypes.RECOG_GETMEM)).keyCheckResult != 0) {
        pStat.hqhist.countC1 = Rmstcom.RMST_NG;
        await hqaspEditPrint();
      }
    }

    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateEnd);
    return 0;
  }

  /// 機能：CSSから受信したSGYOUMUファイルのトラン件数印字編集
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース:rmstopn.c - HQASP_EditPrint()
  static Future<int> hqaspEditPrint() async {
    String wData = '';
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf pStat = xRetS.object;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRetC.object;
    if ((await Recog().recogGet(Tpraid.TPRAID_STR,
        RecogLists.RECOG_TUOCARDSYSTEM, RecogTypes.RECOG_GETMEM))
        .result !=
        RecogValue.RECOG_NO) {
      Rmstopn.prnLineMake(LRmstopncls.TUO_TRN_HEADER.val);
      wData = sprintf("%s      %s", [
        LRmstopncls.TUO_TRN_NEG.val,
        pStat.hqhist.countC1 == 0 || pStat.hqhist.countC1 == 2 ? "OK" : "NG"
      ]);
      Rmstopn.prnLineMake(wData);
      if ((pCom.dbTrm.tuoChgProc) == 0) {
        /* Not kanagawa univ */
        wData = sprintf("%s      %s", [
          LRmstopncls.TUO_TRN_TAN.val,
          pStat.hqhist.countC1 == 0 || pStat.hqhist.countC1 == 1 ? "OK" : "NG"
        ]);
        Rmstopn.prnLineMake(wData);
        wData = sprintf("%s%6i%s", [
          LRmstopncls.TUO_TRN_OK.val,
          pStat.hqhist.countOK,
          LRmstopncls.L_CNT.val
        ]);
        Rmstopn.prnLineMake(wData);
        wData = sprintf("%s%6i%s", [
          LRmstopncls.TUO_TRN_NG.val,
          pStat.hqhist.countNG,
          LRmstopncls.L_CNT.val
        ]);
        Rmstopn.prnLineMake(wData);
        wData = sprintf("%s%6d%s", [
          LRmstopncls.TUO_TRN_TOTAL.val,
          pStat.hqhist.countOK + pStat.hqhist.countNG,
          LRmstopncls.L_CNT.val
        ]);
        Rmstopn.prnLineMake(wData);
      }
    }
    return 0;
  }

  /// 関数：int UpdateEnd(void)
  /// 機能：履歴ログ処理終了
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース:rmstopn.c - UpdateEnd()
  static Future<int> updateEnd() async {
    int ret = 0;
    String log = ''; /* 追加01/09/18 m.n */
    String data = '';
    String item = '';
    int errFlg = 0;
    String data2 = '';
    File? fp;
    String histFreqResult = '';
    String buf = '';
    String tblName = '';
    String tableNameTmp = '';
    int histFreqNum = 0;
    int idx = 0;
    int i = 0;
    List<NcSetting> ncParam = List.empty(growable: true);
    CharData prnData = CharData();
    String callFunc = 'updateEnd';

    Rmstcom.rmstTimerRemove();

    Rmstcom.rmstMsgClear(callFunc);

    // TODO:10152 履歴ログ ダイアログを閉じる
    /// 表示しているダイアログを全て閉じる
    _closeDialogAll();
    // gtk_grab_add( winstopn );

    // TODO:10152 履歴ログ いらないかも
    // if(CmCksys.cmMmType() == CmSys.MacERR || CmCksys.cmMmType() == CmSys.MacS){
    // ret = db_MainStart(TPRAID_STR);
    // if(ret != OK) {
    // TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "db_MainStart error\n");
    // }
    // }

    if (PROC_STS == FORCE) {
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.GET_HISTLOG_STOP.val, 10);
    }

    /* 追加01/09/18 m.n */
    log = "STOPN: ${histLogCnt.value} c_histlog_mst exist on TS.\n";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
    /* 追加01/09/18 m.n */
    data = sprintf("%6i", [histLogCnt.value]);
    Rmstcom.ejData = CharData();
    Rmstcom.ejData.str1 = LRmstopncls.GET_HISTLOG.val;
    Rmstcom.ejData.posi1 = 4;
    Rmstcom.ejData.str2 = data;
    Rmstcom.ejData.str3 = LRmstopncls.L_CNT.val;
    Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);

    item = '${histLogCnt.value}${LRmstopncls.L_CNT.val}';
    prnData.str1 = LRmstopncls.GET_HISTLOG_PRN.val;
    prnData.str2 = item;
    rmstPrnlineDataSet(prnData);

    /* FTP接続エラー */
    histFreqResult =
    "${EnvironmentData().sysHomeDir}/tmp/hist_ftp_notc_cnct.txt";
    fp = TprxPlatform.getFile(histFreqResult);
    if (fp.existsSync()) {
      Rmstcom.ejData = CharData();
      Rmstcom.ejData.str1 = LRmstopncls.HIST_FREQ_ERR.val;
      Rmstcom.ejData.str2 = LRmstopncls.HIST_FTP_ERR.val;
      Rmstcom.ejData.posi1 = 6;
      Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);

      TImgDataAdd imgDataAdd = TImgDataAdd();
      TImgDataAddAns ans = TImgDataAddAns();
      int num = 0;
      CmStrMolding.cmMultiImgDataAddChar(
          Tpraid.TPRAID_STR,
          imgDataAdd,
          num++,
          CmStrMoldingDef.DATA_PTN_NONE,
          2,
          await AplLibEucAdjust.aplLibEucCnt(LRmstopncls.HIST_FREQ_ERR.val),
          LRmstopncls.HIST_FREQ_ERR.val);
      CmStrMolding.cmMultiImgDataAddChar(
          Tpraid.TPRAID_STR,
          imgDataAdd,
          num++,
          CmStrMoldingDef.DATA_PTN_NONE,
          await AplLibEucAdjust.aplLibEucCnt(LRmstopncls.HIST_FREQ_ERR.val) + 3,
          await AplLibEucAdjust.aplLibEucCnt(LRmstopncls.HIST_FTP_ERR.val),
          LRmstopncls.HIST_FTP_ERR.val);
      CmStrMolding.cmMultiImgDataAdd(Tpraid.TPRAID_STR, imgDataAdd, ans);
      Rmstopn.prnLineMake(ans.line[0]);
      if (ans.line_num == 2) {
        Rmstopn.prnLineMake(ans.line[1]);
      }

      if (fp
          .readAsStringSync()
          .isNotEmpty) {
        // 取得失敗履歴ログのhist_cdをEJに記載
        List<String> lines = fp.readAsLinesSync();
        for (String line in lines) {
          if (line.isEmpty) {
            break;
          }

          buf = line;

          data2 =
              sprintf("%s[err_hist_cd]   %10s", [LRmstopncls.FTP_GET_NG, buf]);

          Rmstcom.ejData = CharData();
          Rmstcom.ejData.str1 = data2;
          Rmstcom.ejData.posi1 = 8;
          Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
        }
      }
      Rmstopn.prnLineMake("  ");

      fp.deleteSync();

      // gtk_widget_show (err_label);
    }

    errFlg = 0;
    if (CmCksys.cmMmType() == CmSys.MacERR) {
      ncParam = DbNumberConfirm.ncParam0();
    } else {
      ncParam = DbNumberConfirm.ncParam1123();
    }

    histFreqResult = "${EnvironmentData().sysHomeDir}/log/hist_freq_result.txt";
    fp = TprxPlatform.getFile(histFreqResult);
    if (fp.existsSync()) {
      List<String> lines = fp.readAsLinesSync();
      for (String line in lines) {
        if (line.isNotEmpty) {
          idx = buf.indexOf("\t");
          tblName = buf.substring(0, idx);
          // TODO:10152 履歴ログ 確認
          histFreqNum = idx + 1;

          if (tblName.compareTo("preset_img_xpm.tar.gz") == 0) {
            tblName = tblName + LRmstopncls.PRESET_IMG_XPM.val;
          } else if (tblName.compareTo("KCSRCVMK") == 0) {
            tblName = tblName + LRmstopncls.TUO_NEGA.val;
          } else {
            for (i = 0;; i++) {
              if (ncParam[i].tableName == null) {
                tableNameTmp = tableNameTmp + tblName;
                break;
              }

              if (tblName.compareTo(ncParam[i].tableName!) == 0) {
                tableNameTmp = tableNameTmp + ncParam[i].jName!;
                break;
              }
            }
          }

          Rmstcom.ejData = CharData();
          Rmstcom.ejData.str1 = tableNameTmp;
          if (histFreqNum != 0) {
            Rmstcom.ejData.str3 = LRmstopncls.ENTRY_TXT_NG.val;
          } else {
            Rmstcom.ejData.str3 = LRmstopncls.ENTRY_TXT_OK.val;
          }
          Rmstcom.ejData.posi3 =
              46 - AplLibStrUtf.aplLibEntCnt(Rmstcom.ejData.str3);
          AplLibStrUtf.aplLibEucCopy(
              data2,
              (Rmstcom.ejData.posi3 -
                  AplLibStrUtf.aplLibEntCnt(Rmstcom.ejData.str1)));
          Rmstcom.ejData.str3 = data2;
          Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);

          TImgDataAdd imgDataAdd = TImgDataAdd();
          TImgDataAddAns ans = TImgDataAddAns();
          int num = 0;
          int cnt = 0;
          CharData prnData = CharData();

          CmStrMolding.cmMultiImgDataAddChar(
              Tpraid.TPRAID_STR,
              imgDataAdd,
              num++,
              CmStrMolding.DATA_PTN_NONE,
              2,
              cnt,
              tableNameTmp);
          CmStrMolding.cmMultiImgDataAdd(Tpraid.TPRAID_STR, imgDataAdd, ans);
          Rmstopn.prnLineMake(ans.line[0]);
          if (ans.line_num > 1) {
            Rmstopn.prnLineMake(ans.line[1]);
            for (int i = 0; i < CmStrMoldingDef.RCPTWIDTH / 2; i++) {
              data2 += ' ';
            }
          }

          if (data2.isNotEmpty) {
            prnData.str1 = data2;
          } else {
            prnData.str1 = tableNameTmp;
            prnData.posi1 = 2;
          }
          if (histFreqNum != 0) {
            prnData.str2 = LRmstopncls.ENTRY_TXT_NG.val;
          } else {
            prnData.str2 = LRmstopncls.ENTRY_TXT_OK.val;
          }
          rmstPrnlineDataSet(prnData);

          if (histFreqNum != 0) {
            errFlg = 1;
          }
        } else {
          break;
        }
      }
      for (int i = 0; i < 54; i++) {
        data2 += ' ';
      }
      Rmstopn.prnLineMake(data2);

      fp.deleteSync();

      if (errFlg != 0) {
        // gtk_widget_show (err_label);
      }
    }

    if (await CmCksys.cmShopAndGoSystem() != 0) {
      if (await CmCksys.cmMmIniType() == CmSys.MacM1 ||
          await CmCksys.cmMmIniType() == CmSys.MacMOnly) {
        ; /* 上位の無いMレジまたはSTレジの場合、実施しない */
      } else {
        if (fqresWebapi == DbError.DB_SUCCESS) {
          /* 取得OK */
          data2 = LRmstopncls.SAG_GET_WEBAPI_PRN_OK.val;
          Rmstopn.prnLineMake(data2);
          Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.SAG_GET_WEBAPI_EJ_OK.val, 0);
        } else if (fqresWebapi == DbError.DB_SKIP) {
          /* 取得SKIP */
          data2 = LRmstopncls.SAG_GET_WEBAPI_PRN_SKIP.val;
          Rmstopn.prnLineMake(data2);
          Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.SAG_GET_WEBAPI_EJ_SKIP.val, 0);
        } else {
          data2 = LRmstopncls.SAG_GET_WEBAPI_PRN_NG.val;
          Rmstopn.prnLineMake(data2);
          Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.SAG_GET_WEBAPI_EJ_NG.val, 0);
        }
      }
    }

    await updateEndAfter();
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateEnd !!");
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - UpdateEnd_After
  static Future<void> updateEndAfter() async {
    int result = 0;
    int addTimer = 0;
    String log = '';
    RmIniRead iniRead = RmIniRead();
    RmDBRead dbRead = RmDBRead();
    String callFunc = 'updateEndAfter';

    result = (await iniRead.rmIniReadMain()).dlgId; /* append T.K 02/06/21 */
    if (result == 0) {
      await dbRead.rmDbReadMain(); /* append T.K 02/06/21 */
    }

    rmstopnWinMod = STOPN_SUB;

    if (autoErr != 0) {
      /* エラーあり */
      Rmstcom.rmstMsgDisp(
          autoErr,
          DlgPattern.TPRDLG_PT4.dlgPtnId,
          rmstOpnDlgClr,
          LTprDlg.BTN_CONF,
          null,
          null,
          LTprDlg.BTN_ERR,
          0);
      await AplLibAuto.aplLibAutoStrOpnClsError(
          Tpraid.TPRAID_STR, Rmstcom.rmstMsgNum); /* 自動開閉設：自動化中止 */
    } else {
      logFlg = 1;
      if (await chkAutoOpen() != 0) {
        Rmstcom.rmstTimerAdd(
            Rmstcom.NEXT_GO_TIME, rmstOpnHostCopyErrAttnDlgForce);
      } else if (rcStOpnAutoRunCheck() != 0) {
        addTimer = 60000; /* 60sec */

        if (autoRunTime > 0) {
          // gtk_widget_show(AutoRun_Label);
        }
        autoRunTimer = -1;
        autoRunTimer = Fb2Gtk.gtkTimeoutAdd(
          /*60000*/
            addTimer,
            rcStOpnAutoRunTimeCheck,
            0);
        log = "ST_OPEN Automatic Run time[$autoRunTime]\n";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // AutoRun_End_Label = gtk_label_line_new( OPEN_AUTORUN_LABEL_END, DarkBlue, White, White, LABEL_LINE_NONE, FONTSZ_16 );
        // gtk_fixed_put( GTK_FIXED( fixedstopn ), AutoRun_End_Label, 170, 4 );
      }
    }
    RxSys.rxSysSend(Tpraid.TPRAID_STR, Rxsys.RXSYS_MSG_OPNST_ST);

    /// 履歴ログ最新情報取得強制フラグOFF
    PROC_STS = Rmstcom.RMST_OK;
  }

  ///  関連tprxソース: rmstopn.c - rmstopn_dlg_clr
  static int rmstOpnDlgClr() {
    String callFunc = 'rmstOpnDlgClr';
    return TprDlg.tprLibDlgClear(callFunc);
  }

  /// 機能：自動実行監視
  /// 引数：未使用
  /// 戻値：0:終了
  ///  関連tprxソース: rmstopn.c - rcstopn_auto_run_time_check
  static int rcStOpnAutoRunTimeCheck() {
    String buf = '';

    if (autoRunTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(autoRunTimer);
      autoRunTimer = -1;
    }

    if (rmstopnWinMod != STOPN_SUB || opnStatFlg != 0) {
      autoRun = 0;
      // if(AutoRun_Label != NULL) {
      //   gtk_widget_hide(AutoRun_Label);
      // }
      return 0;
    }

    autoRunTime--;
    if (autoRunTime <= 0) {
      // if(AutoRun_Label != NULL) {
      //   gtk_widget_hide(AutoRun_Label);
      // }
      Rmstcom.rmstTimerRemove();
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, rcStOpnAutoRunStart);
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "ST_OPEN Automatic Action Start");
    } else {
      buf = sprintf(LRmstopncls.AUTORUN_LABEL2.val, [autoRunTime]);
      // gtk_label_line_set_name( AutoRun_Label, buf );
      autoRunTimer = Fb2Gtk.gtkTimeoutAdd(60000, rcStOpnAutoRunTimeCheck, 0);
      buf = "ST_OPEN Automatic Run time[$autoRunTime]";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, buf);
    }

    return 0;
  }

  ///  関連tprxソース: rmstopn.c - rcstopn_auto_run_start
  static Future<int> rcStOpnAutoRunStart() async {
    if (autoOpen == 1) {
      await AplLibAuto.aplLibAutoSetRunMode(
          Tpraid.TPRAID_STR, AutoRun.AUTORUN_STROPN.val); /* 自動開閉設仕様の開店処理開始	*/
      await AplLibAuto.aplLibAutoSetAutoMode(
          Tpraid.TPRAID_STR, AutoMode.AUTOMODE_STROPN.val); /* 自動開閉設：開設処理			*/
      rcStOpnAutoRunStop(0);
    } else {
      rcStOpnAutoRunStop(1);
    }

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, quitBtnClickedMain);
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - rcstopn_auto_run_stop
  static int rcStOpnAutoRunStop(int start) {
    if (rcStOpnAutoRunCheck() == 0) {
      return 0;
    }

    if (start != 0) {
      autoRun = 2;
    } else if (autoRun != 2) {
      autoRun = 0;
    }

    if (autoRunTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(autoRunTimer);
      autoRunTimer = -1;
      // if( AutoRun_Label != NULL ) {
      //   gtk_widget_hide(AutoRun_Label);
      // }
    }

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "ST_OPEN Automatic Run STOP\n");
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - rcstopn_auto_run_check
  static int rcStOpnAutoRunCheck() {
    if (autoOpen == 1 && autoStrOpnTime > 0 && autoRun == 1) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - quit_btn_clicked_main
  static Future<int> quitBtnClickedMain() async {
    recalChk = 0;
    String callFunc = 'quitBtnClickedMain';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    Rmstcom.rmstMsgClear(callFunc);
    Rmstcom.rmstTimerRemove();
    rcStOpnAutoRunStop(0);

    if (CloseDbChk.rmStoreCloseDBAnsChk() != 0) {
      rmstopnWinMod = STOPN_CLOSEDBERR;
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_CLOSEDBERR.dlgId,
          DlgPattern.TPRDLG_PT4.dlgPtnId,
          null,
          null,
          null,
          null,
          "",
          0);
      return 0;
    }
    rmStGetOpenTime();
    whBuf = sprintf(Rmstcom.OPENCLOSE_WHERE,
        [pCom.dbRegCtrl.compCd, pCom.dbRegCtrl.streCd, Rmstcom.hSaleDate]);

    if (await chkLastOpen(0) == NOT_OPEN) {
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_OPEN_NGDATE.dlgId,
          DlgPattern.TPRDLG_PT4.dlgPtnId,
          null,
          null,
          null,
          null,
          "",
          0);
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "quit_btn_clicked_main: NOT OPEN this sale_date!!");
      return 0;
    }

    opnStatFlg = OPN_EXEC;

    if (Cnct.cnctMemGet(Tpraid.TPRAID_STR, CnctLists.CNCT_MULTI_CNCT).abs() !=
        0) {
      if (IfFcl.fclAutoActionChk(Tpraid.TPRAID_STR) == true) {
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_BUSY_FCLDLL.dlgId,
            DlgPattern.TPRDLG_PT1.dlgPtnId,
            Rmstcls.noBtnProc,
            LTprDlg.BTN_END,
            null,
            null,
            LTprDlg.BTN_CONF,
            0);
        opnStatFlg = 0;
        return 0;
      }
      IfFcl.fclAutoNoStart(Tpraid.TPRAID_STR, 1);
    }

    // コピー処理中の場合、注意ダイアログを表示
    if (pCom.sims_mente_copy == rxMem.CopyHostLockStatus.COPY_SIMS_LOCK_ON.value &&
        hostErrAttnFlag == 0) {
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_HOST_COPY_RUNNING.dlgId,
          DlgPattern.TPRDLG_PT1.dlgPtnId,
          rmstOpnHostCopyErrAttnDlgForce,
          LTprDlg.BTN_FORCE,
          Rmstcls.noBtnProc,
          LTprDlg.BTN_RETURN,
          "",
          0);
      return 0;
    }

    /* 自動開閉設仕様：自動開設するでも待ち時間がない場合 */
    if (autoOpen == 1) {
      await AplLibAuto.aplLibAutoSetRunMode(
          Tpraid.TPRAID_STR, AutoRun.AUTORUN_STROPN.val); /* 自動開閉設仕様の開店処理開始 */
      await AplLibAuto.aplLibAutoSetAutoMode(
          Tpraid.TPRAID_STR, AutoMode.AUTOMODE_STROPN.val); /* 自動開閉設：開設処理 */
    }

    if (autoErr != 0) {
      await AplLibAuto.aplLibAutoStrOpnClsError(
          Tpraid.TPRAID_STR, autoErr); /* 自動開閉設：自動化中止 */
    }

//	if((!mly_ttl_clr_dlg) &&
    if (await chkAutoOpen() == 0 &&
        (CmCksys.cmMmType() == CmSys.MacM1 ||
            CmCksys.cmMmType() == CmSys.MacM2 ||
            CmCksys.cmMmType() == CmSys.MacMOnly)) {
      // if(rmTpr_con == NULL) {
      //   if(( rm_tpr_con = db_TprLogin(TPRAID_STR, 1) ) == NULL) {
      //     TprLibLogWrite(TPRAID_STR, TPRLOG_ERROR, -1, "DB_Open:TPR-X Connect faild!!");
      //     rmstMsgDisp(MSG_FILEACCESS, TPRDLG_PT7, NULL, NULL, NULL, NULL, "", 0);
      //     AplLib_AutoStrOpnClsError( TPRAID_STR, rmstMsgNum ); /* 自動開閉設：自動化中止 */
      //     opn_stat_flg = 0;
      //     return 0;
      //   }
      // }
    }

    chkDateMessage();

    if ((fDate != 0 ||
        (chkFlg == 1 &&
            (await CmCksys.cm24hourSystem() == 0 &&
                await chkAutoOpen() == 0 &&
                pCom.dbTrm.saledatePlus == 0)) &&
            dataRestorExecFlg != 1)) {
      // TODO:10152 履歴ログ UI系
      // PasswdEntDisp();
    } else {
      /* End */
//	fClear = TRUE;

//	if (BkupChk(BKUP_FNAME_NORMAL, FALSE) == TRUE)
      if (await chkLastOpen(0) == SAME_DATE) {
        if (await chkAutoOpen() != 0 || rcStOpnAutoStartCheck()) {
          Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.EQUALDATE.val, 0);
          prnLineMake(LRmstopncls.EQUALDATE.val);
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
              "quit_btn_clicked : EQUALDATE 1");
          Rmstcom.rmstTimerRemove();
          Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, bkUpDel);
          return 0;
        } else {
          if (dataRestorExecFlg != 1) {
            Rmstcom.rmstMsgDisp(
                DlgConfirmMsgKind.MSG_EQUALDATE.dlgId,
                DlgPattern.TPRDLG_PT1.dlgPtnId,
                bkUpDel,
                LTprDlg.BTN_YES,
                Rmstcls.noBtnProc,
                LTprDlg.BTN_NO,
                "",
                0);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
                "quit_btn_clicked : EQUALDATE 2");
            return 0;
          } else {
            Rmstcom.rmstTimerRemove();
            Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, bkUpDel);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
                "quit_btn_clicked : EQUALDATE 3");
            return 0;
          }
        }
      }
      if (dataRestorExecFlg != 1) {
        await chkDateMessageDsp();
        return 0;
      } else {
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, openDlg);
      }
    }
    /* passwd window T.K */
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "quit_btn_clicked End");
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - rmstGetOpenTime
  static void rmStGetOpenTime() {
    DateTime sysDate = Rmstcom.timeStOpn;

    Rmstcom.saleDate =
        sprintf("%04i%02i%02i", [sysDate.year, sysDate.month, sysDate.day]);
    Rmstcom.hSaleDate =
        sprintf("%04i-%02i-%02i", [sysDate.year, sysDate.month, sysDate.day]);
  }

  /// 関連tprxソース: rmstopn.c - ChkLastOpen
  static Future<int> chkLastOpen(int ejWrite) async {
    DateTime sysDate;
    String lastDate = '';
    String buf = '';
    String wLastDate = '';
    String nowDate = '';
    String log = '';
    CharData ejData = CharData();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    CompetitionIniRet iniRet = await CompetitionIni.competitionIniGet(
        Tpraid.TPRAID_STR,
        CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE,
        CompetitionIniType.COMPETITION_INI_GETSYS);
    lastDate = iniRet.value;

    sysDate = Rmstcom.timeStOpn;
    buf = sprintf("%04i-%02i-%02i", [sysDate.year, sysDate.month, sysDate.day]);

    if (ejWrite != 0) {
      var (int error, wLastDate) = await DateUtil.dateTimeChange(
          lastDate,
          DateTimeChangeType.DATE_TIME_CHANGE,
          DateTimeFormatKind.FT_YYYYMMDD_KANJI_WEEK_KANJI,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
      var (int error2, nowDate) = await DateUtil.dateTimeChange(
          buf,
          DateTimeChangeType.DATE_TIME_CHANGE,
          DateTimeFormatKind.FT_YYYYMMDD_KANJI_WEEK_KANJI,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);

      Rmstcom.ejData = CharData();
      Rmstcom.ejData.str1 = LRmstopncls.NOW_SALE_DATE.val;
      Rmstcom.ejData.posi1 = 10;
      Rmstcom.ejData.str2 = nowDate;
      Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);

      Rmstcom.ejData = CharData();
      Rmstcom.ejData.str1 = LRmstopncls.LAST_SALE_DATE.val;
      Rmstcom.ejData.posi1 = 10;
      Rmstcom.ejData.str2 = wLastDate;
      Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
    }

    log = "ChkLastOpen: LAST_SDATE[$lastDate] NOW_SDATE[$buf]";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

    if (lastDate.compareTo(buf) != 0) {
      return NOT_OPEN;
    }

    if (lastDate.compareTo(buf) == 0 ||
        bkUpChk(BkUpFNames.BKUP_FNAME_NORMAL) == true) {
      if (pCom.dbTrm.sameDateOpen != 0) {
        //同じ営業日開設禁止
        return NOT_OPEN;
      }
      return SAME_DATE;
    }

    return 0;
  }

  /// 機能：バックアップファイル存在チェック＆削除
  /// 引数： BKUP_FNAMES name チェックするファイル名種別のインデックス
  /// ：int del ファイル削除フラグ
  /// ：    TRUE:削除し、続行する
  /// ：    FALSE:削除しないで抜ける
  /// 戻値：TRUE:ファイルあり / FALSE:ファイルなし
  /// 関連tprxソース: rmstopn.c - BkupChk
  static bool bkUpChk(BkUpFNames name) {
    int db = 0;
    String tprName = '';
    for (db = 0; db < BkUpDbs.BKUP_DB_MMEJLOG.value; db++) {
      makeBkUpName(tprName, name, db);
      File file = TprxPlatform.getFile(tprName);
      if (file.existsSync()) {
        return true;
      }
    }

    return false;
  }

  /// 機能：実績バックアップファイル名を返す
  /// 引数：char *str ファイルを名格納するポインタ(戻り値)
  /// ：BKUP_FNAMES name 作成するファイル名種別のインデックス
  /// ：  BKUP_FNAME_NORMAL:tran_backup/???YYYYMMDD.normal
  /// ：  BKUP_FNAME_OFFLINE:tran_backup/offline/???YYYYMMDD.off
  /// ：  BKUP_FNAME_OFFSEND:tran_backup/offline/sended/???YYYYMMDD.off
  /// ：  BKUP_FNAME_NONDIR:???YYYYMMDD.off (ファイル名のみ)
  /// ：MKUP_DBS    db   作成するファイル名DBのインデックス
  /// ：  BKUP_DB_MAX はディレクトリ名のみ
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - MakeBkupName
  static int makeBkUpName(String str, BkUpFNames name, int db) {
    String date = '';
    String macNo = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (name.value != BkUpFNames.BKUP_FNAME_NONDIR.value) {
      str = IfThCSenddata.SysHomeDirp;
      str = "$str/tran_backup";
      if (name.value >= BkUpFNames.BKUP_FNAME_OFFLINE.value) {
        str = "$str/offline";
      }
      if (name.value >= BkUpFNames.BKUP_FNAME_OFFSEND.value) {
        str = "$str/sended";
      }
    }

    if (db == BkUpDbs.BKUP_DB_MAX.value) {
      return 0;
    }

    str = "$str/";

    str = str + BkUpDbs.values[db].tableName;
    if (CmCksys.cmMmType() == CmSys.MacERR) {
      date = "${Rmstcom.saleDate}.";
    } else {
      date = "00${Rmstcom.saleDate}.";
    }

    str = str + date;

    macNo = sprintf("%06ld.", [pCom.dbRegCtrl.macNo]);
    str = str + macNo;

    switch (name) {
      case BkUpFNames.BKUP_FNAME_NORMAL:
        str = "${str}normal";
        break;
      case BkUpFNames.BKUP_FNAME_OFFLINE:
      case BkUpFNames.BKUP_FNAME_OFFSEND:
      case BkUpFNames.BKUP_FNAME_NONDIR:
        str = "${str}off";
        break;
      case BkUpFNames.BKUP_FNAME_SERIAL:
        str = "${str}serial";
        break;
      default:
        break;
    }

    return 0;
  }

  // マスタ受信中に強制を押下した時の処理
  /// 関連tprxソース: rmstopn.c - rmstopnHostCopyErrAttnDlgForce
  static int rmstOpnHostCopyErrAttnDlgForce() {
    String callFunc = 'rmstOpnHostCopyErrAttnDlgForce';
    Rmstcom.rmstMsgClear(callFunc);
    Rmstopn.hostErrAttnFlag = 1; // 注意確認済フラグをセット
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, quitBtnClickedMain);
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - ChkDateMessage
  static void chkDateMessage() {
    DateTime nowDateTime = DateTime.now();
    DateTime sysdateWork = DateTime.now();
    int workYear = 0;
    int workMon = 0;
    int workMDay = 0;
    int week = 0;
    String nowDate = '';

    nowDate =
    "${LRmstopncls.NOW_DATETIME.val}\n     ${nowDateTime.year}年${nowDateTime
        .month}月${nowDateTime.day}日(${nowDateTime.weekday})${nowDateTime
        .hour}:${nowDateTime.minute}";
    // gtk_label_set_text(GTK_LABEL(label_nowdate), nowdate);

    workYear = sysdateWork.year;
    workMon = sysdateWork.month;
    workMDay = sysdateWork.day;
    sysdateWork = Rmstcom.timeStOpn;
    week = sysdateWork.weekday;

    if (week > 6) {
      week = 0;
    }

    if (sysdateWork.year != workYear || sysdateWork.month != workMon ||
        sysdateWork.day != workMDay) {
      if (chkFlg == 0) {
        // gtk_widget_show(caution_text2);
      }
      chkFlg = 1;
    } else {
      if (chkFlg == 1) {
        // gtk_widget_hide(caution_text2);
      }
      chkFlg = 0;
    }
    return;
  }

  ///  関連tprxソース: rmstopn.c - rcstopn_auto_start_check
  static bool rcStOpnAutoStartCheck() {
    return autoRun == 2;
  }

  /// 関数：int TotalRemakeInit(void)
  /// 機能：バックアップファイル削除処理
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - BkupDel
  static int bkUpDel() {
    String callFunc = 'bkUpDel';

    Rmstcom.rmstTimerRemove();
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "bkUpDel Start");
    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

//	fClear = FALSE;
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, openDlg);

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "bkUpDel End");
    return 0;
  }

  /// 機能：終了処理
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース: rmstopn.c - OpenDlg
  static Future<int> openDlg() async {
    int result = 0;

    Rmstcom.rmstTimerRemove();

    if (CmCksys.cmMmType() != CmSys.MacERR) {
      if (await CmCksys.cm24hourSystem() != 0) {
        result = await regOpenChk();
        if (result == NOT_OPEN) {
          Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.MOPENDIFF.val, 4);
          Rmstcom.rmstMsgDisp(
              DlgConfirmMsgKind.MSG_MOPENDIFF.dlgId,
              DlgPattern.TPRDLG_PT11.dlgPtnId,
              regOpenChkCancel,
              LTprDlg.BTN_INTERRUPT,
              regOpenChkSkip,
              LTprDlg.BTN_FORCE,
              "",
              0);
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
              "openDlg: this sale_date is different from M !!");
          return 0;
        } else if (result == Rmstcom.RMST_NG) {
          Rmstcom.rmstMsgDisp(
              DlgConfirmMsgKind.MSG_REGCTR_FAIL.dlgId,
              DlgPattern.TPRDLG_PT2.dlgPtnId,
              forceEndProc,
              LTprDlg.BTN_END,
              null,
              null,
              "",
              0);
          await AplLibAuto.aplLibAutoStrOpnClsError(
              Tpraid.TPRAID_STR, Rmstcom.rmstMsgNum); /* 自動開閉設：自動化中止 */
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
              "openDlg: reg control failed!!");
          return 0;
        }
      }
    }
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, openDlg2);
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - RegOpenChk
  static Future<int> regOpenChk() async {
    String log = '';
    String sql = '';
    String workMacNo = '';
    int regCnt = 0;
    int ctr = 0;
    String addSql = '';
    Result localRes;
    String callFunc = 'regOpenChk';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    DbManipulationPs db = DbManipulationPs();

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "RegOpenChk Start");
    if (CmCksys.cmMmType() != CmSys.MacM1 &&
        CmCksys.cmMmType() != CmSys.MacM2) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "RegOpenChk No Check");
      return 0;
    }

    if (CmCksys.cmMmType() == CmSys.MacM1 && mMacNo == 0) {
      log = "$callFunc: no m pos";
    } else
    if ((CmCksys.cmMmType() == CmSys.MacM2) && mMacNo == 0 && bsMacNo == 0) {
      log = "$callFunc: no M BS pos";
    }

    if (log.isNotEmpty) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
      return Rmstcom.RMST_NG;
    }

    if (CmCksys.cmMmType() == CmSys.MacM1) {
      addSql = "mac_no NOT IN ('$mMacNo')";
    } else {
      addSql = "mac_no NOT IN ('$mMacNo', '$bsMacNo')";
    }

    sql = "SELECT mac_no FROM c_reginfo_mst WHERE comp_cd = '${pCom.dbRegCtrl
        .compCd}' AND stre_cd = '${pCom.dbRegCtrl.streCd}' AND $addSql;";

    try {
      localRes = await db.dbCon.execute(sql);
    } catch (e) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "RegOpenChk REGCTR_FAIL");
      return Rmstcom.RMST_NG;
    }

    regCnt = localRes.length;
    if (regCnt == 0) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "RegOpenChk REGCTR_NODATA");
      if (CmCksys.cmMmType() == CmSys.MacM1) {
        return Rmstcom.RMST_NG;
      } else {
        return Rmstcom.RMST_OK;
      }
    }

    for (ctr = 0; ctr < regCnt; ctr++) {
      Map<String, dynamic> data = localRes.elementAt(ctr).toColumnMap();
      workMacNo = data['mac_no'].toString();

      sql =
      "SELECT mac_no FROM c_openclose_mst WHERE $whBuf AND mac_no = $workMacNo  AND close_flg='0'\n";

      try {
        localRes = await db.dbCon.execute(sql);
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "regOpenChk(): db.dbCon.execute() $e,$s");
        return Rmstcom.RMST_NG;
      }

      if (localRes.isEmpty) {
        log = "RegOpenChk:NOT OPEN REG_NO IS $workMacNo";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        return NOT_OPEN;
      }
    }

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "RegOpenChk normal End");
    return 0;
  }

  /// Input  : Void
  /// Output : 0:End
  /// 関連tprxソース: rmstopn.c - RegOpenChkCancel
  static int regOpenChkCancel() {
    String callFunc = 'regOpenChkCancel';

    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.INTERRUPT.val, 20);

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "RegOpenChk Cancel End");
    opnStatFlg = 0;
    return 0;
  }


  /// Input  : Void
  /// Output : 0:End
  /// 関連tprxソース: rmstopn.c - RegOpenChkSkip
  static int regOpenChkSkip() {
    String callFunc = 'regOpenChkSkip';

    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.FORCE_OPEN.val, 20);

    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, openDlg2);

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "RegOpenChk Skip End");
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - OpenDlg2
  static int openDlg2() {
    opnStatFlg = OPN_EXEC;

    Rmstcom.rmstTimerRemove();

    if (storeOpenPlanChkFlag == 0 && dataRestorExecFlg == 0) {
      /* クイック再セットアップ中はツールを動かさない  */
      TaxChgPlanStruct taxChgPlan = TaxChgPlanStruct();

      storeOpenPlanChkFlag = 1;

      taxChgPlan.date = Rmstcom.saleDate;
      taxChgPlan.tid = Tpraid.TPRAID_STR;
      // TODO:10152 履歴ログ 確認
      taxChgPlan.afterFunc = afterTaxChgPlan(taxChgPlan);

      // 予約変更の画面
      // TODO:10152 履歴ログ UI系
      // prgPlanUpdateDisplay( &taxChgPlan );

      return 0;
    }

    RxSys.rxSysSend(Tpraid.TPRAID_STR, Rxsys.RXSYS_MSG_OPNST);
    rmstopnWinMod = STOPN_MAIN;
    // if(autoRun_End_Label != NULL) {
    // gtk_widget_destroy(AutoRun_End_Label);
    // AutoRun_End_Label = NULL;
    // }

    //クイック再セットアップ対応
    if (dataRestorExecFlg == 1) {
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_DATARESTORATION_KEIKA8.dlgId,
          DlgPattern.TPRDLG_PT10.dlgPtnId,
          null,
          null,
          null,
          null,
          LTprDlg.BTN_EXEC,
          0);
    } else {
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_OPENTRAN.dlgId,
          DlgPattern.TPRDLG_PT2.dlgPtnId,
          null,
          null,
          null,
          null,
          "",
          0);
    }

    Rmstcom.rmstTimerAdd(5000, quitProc);
    return 0;
  }

  /// 予約変更のチェック終了後の戻り関数
  /// 関連tprxソース: rmstopn.c - AfterTaxChgPlan
  static int afterTaxChgPlan(TaxChgPlanStruct taxChgPlan) {
    if (taxChgPlan.logPath.isNotEmpty) {
      File? fp;
      String buf = '';
      int? pnt = 0;

      // 実行結果を電子ジャーナルに追記
      fp = AplLibStdAdd.aplLibFileOpen(
          Tpraid.TPRAID_STR, taxChgPlan.logPath, "r");
      if (fp != null) {
        buf = utf8.decode(fp.readAsBytesSync());

        while (buf.isNotEmpty) {
          pnt = buf.indexOf('\n');

          if (pnt != -1) {
            pnt = 0x00;
          }

          Rmstcom.rmstEjTxtMakeNew2(buf, 4);
        }

        Rmstcom.rmstEjTxtMake(" ", Rmstcom.REG_OPEN);
        // AplLibFileClose( TPRAID_STR, fp );
      }
    }

    openDlg2();
    return 0;
  }

  /// 関数：int QuitProc(void)
  /// 機能：終了処理
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - QuitProc
  static Future<int> quitProc() async {
    return 0;
//   int ret = 0;
//   int retChkDate = 0;
//   String timeJType = '';
//   String buf = '';
//   String wkBuf = '';
//   CharData prnData = CharData();
//   int	clrFlg = 0;
//   int	usbRet = 0;
//   String data = '';
//   String sysParamIni = '';
//   String generationData = '';
//   String lastSaleDate = '';
//   int error = 0;
//   String callFunc = 'quitProc';
//   RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
//   if (xRetS.isInvalid()) {
//     return 0;
//   }
//   RxTaskStatBuf pStat = xRetS.object;
//   RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
//   if (xRetC.isInvalid()) {
//     return 0;
//   }
//   RxCommonBuf pCom = xRetC.object;
//
//   Rmstcom.rmstTimerRemove();
//
//   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "QuitProc Start");
//   execFlg = 1;
//   opnStatFlg = OPN_EXEC;
//     (error, timeJType) = await DateUtil.dateTimeChange(null, DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM, DateTimeFormatKind.FT_YYYYMMDD_KANJI_SPACE_HHMMSS_COLON, DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
//   Rmstcom.ejData = CharData();
//   Rmstcom.ejData.posi1 = 8;
//   Rmstcom.ejData.str1 = LJmupsSales.START_TIME;
//   Rmstcom.ejData.str2 = timeJType;
//   Rmstcom.ejData.str3 = LJmupsSales.OPEN_EXC;
//   Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
//
//   PBchg_Data_Download();
//
//   if(CmCksys.cmMmType() == CmSys.MacM1 && await CmCksys.cm24hourSystem() == 0) {
//     WolProc(); /* MM System Wake Up On LAN */
//   }else if(histLogGetFinishedFlg == 0
//   || histLogGetFinishedFlg == 1) {
//   rmstopn_wol_start(1);
//   }
//
// //@@@v1
//     if (Cnct.cnctMemGet(Tpraid.TPRAID_STR, CnctLists.CNCT_MOBILE_CNCT) != 0) {
//       ret = rcMblOpn_Delete(NULL);
//       if (ret == 0) {
//         TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "rcMblOpn_Delete OK !!");
//       } else {
//         TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "rcMblOpn_Delete Error!!");
//       }
//     }
//
//   retChkDate = await chkLastOpen(1);
// //@@@v1
//   usbRet = usb_first_chk(TPRAID_STR, ret_chkdate, SaleDate);
//     UsbMemValues def = UsbMemValues.getDefine(usbRet);
//   switch(def) {
//   case UsbMemValues.USBMEM_NG:
//   case UsbMemValues.USBMEM_FND_MEMNG:
//   case UsbMemValues.USBMEM_NOTFND_MEMOK:
//   data = "      USB Memory NG";
//   break;
//   case UsbMemValues.USBMEM_SPT_WEBTYP1:
//   case UsbMemValues.USBMEM_SPT_WEBTYP2:
//   case UsbMemValues.USBMEM_SPT_WEBTYP3:
//   data = "      USB Memory OK";
//   break;
//   default: break;
//   }
//
//   if(data.isNotEmpty) {
//     Rmstcom.rmstEjTxtMakeNew2(data, 0);
//   }
//
//
//   clrFlg = Rmstcom.RMST_OK;
//   /* 日計クリア処理 */
//   if(retChkDate != SAME_DATE){
//   Rmstcom.ejData = CharData();
//   Rmstcom.ejData.str1 = LRmstopncls.REG_DAILYLOG_CLR.val;
//   Rmstcom.ejData.posi1 = 4;
//
//   prnData.str1 = LRmstopncls.REG_DAILYLOG_CLR_PRN.val;
//
//   if(await CmCksys.cmUsbCamSystem() == 1) {
//     pStat.movSend.delFlg = 1;
//     }
//
//   Rmstcls.execProcDbClose();
//
//   // if((db_LocalStart(TPRAID_STR) != OK) ||
//   // ((rm_tpr_con = db_TprLogin(TPRAID_STR, DB_ERRLOG)) == NULL)){
//   // rmstEjTxtMake_New2(PSQL_START_NG, 8);
//   // clr_flg = RMST_NG;
//   // TprLibLogWrite(TPRAID_STR, TPRLOG_ERROR, -1, "DlyClr:db_LocalStart error\n");
//   // }
//
//   if(clrFlg == Rmstcom.RMST_OK) {
//     clrFlg = rmstDailyClear();
//   }
//
//   if(clrFlg == Rmstcom.RMST_OK){	//ローカル実績クリアOK
//   Rmstcom.ejData.str2 = LRmstopncls.ENTRY_TXT_OK.val;
//   Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
//   prnData.str2 = LRmstopncls.ENTRY_TXT_OK.val;
//   rmstPrnlineDataSet(prnData);
//   MM_DailyLogClr();
//   }else{
//   Rmstcom.ejData.str2 = LRmstopncls.ENTRY_TXT_NG.val;
//   Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
//   prnData.str2 = LRmstopncls.ENTRY_TXT_NG.val;
//   rmstPrnlineDataSet(prnData);
//   }
//
//   Rmstcls.execProcDbClose();
//
//   // if(db_MainStart(TPRAID_STR) != OK){
//   // rmstEjTxtMake_New2(PSQL_START_NG, 8);
//   // TprLibLogWrite(TPRAID_STR, TPRLOG_ERROR, -1, "DlyClr:db_MainStart error\n");
//   // clr_flg = RMST_NG;
//   // }
//
//   if(clrFlg != Rmstcom.RMST_OK) {
//     goto OpenError;
//   }
//
//   AplLib_IniFile(TPRAID_STR, INI_SET, 0, "counter.ini", "tran", "stropn_counter", "1");
//   AplLib_IniFile(TPRAID_STR, INI_SET, 0, "counter.ini", "tran", "strcls_counter", "1");
//   rmstOpn_ClearData();
//   } else {
//   buf = '';
//   AplLib_IniFile(TPRAID_STR, INI_GET, 0, "counter.ini", "tran", "stropn_counter", buf);
//   wkBuf = "${int.tryParse(buf) ?? 0 + 1}";
//   AplLib_IniFile(TPRAID_STR, INI_SET, 0, "counter.ini", "tran", "stropn_counter", wk_buf);
// //@@@v1
//   QuitProc_bkupplay_set( 0 );
//   NoSendDataDel();
//     Rmstcls.reCalTranDel(0);	//本日営業日の実績再集計バックアップデータ削除
//   AplLib_IniFile(TPRAID_STR, INI_SET, 0, "auto_strcls_tran.ini", "autostrl_info", "cls_resv_amt", "0");
//   }
//
//   // 世代管理データ取込み(sys_param.ini)
//   sysParamIni = "${IfThCSenddata.SysHomeDirp}/conf/sys_param.ini";
//   if (TprLibGetIni ((uchar *) sysparamini, "spec_bkup", GENERATION, (uchar *) generation_data) != 0) {
//   // 読み込めないときは、デフォルト値３をセットする。
//   generationData = "3";
//   }
//
//   // 前回営業日取込み(counter.ini)
//     CompetitionIniRet comRet = await CompetitionIni.competitionIni (Tpraid.TPRAID_STR, CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE, CompetitionIniType.COMPETITION_INI_GETSYS);
//     lastSaleDate = comRet.value;
//   if (comRet.value != CompetitionIniRetEnums.COMPETITION_INI_OK.keyId) {
//   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "TprLibGetIni last_sale_date error\n");
//   lastSaleDate = "0000-00-00";
//   }
//
//   /* SSD容量不足の為 */
//   rmstDiskFree( );	/* ディスク容量 */
//
//   if(CmCksys.cmMmType() == CmSys.MacMOnly){
//   if(await CmCksys.cmChkDocCnctIni(Tpraid.TPRAID_STR) != 2){
// //V15@@@@
//   // rmstChkDOCtoDB();
//   }
//   }
//
//   /* レジ番号の取得 */
// //v１必要ない？
// //	MakeSIMSLogTxt();
//   if(MakeLocalOpenClose() != RMST_OK){
//   updErr = 1;
//   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,  "MakeLocalOpenClose End (NG)");
//   goto	OpenError;
//   }
//
//   Wiz_Data_Clear();
//   MakeLocalCounter();
//
//   if(await chkAutoOpen() != 0) {
//     pCom.qsAtFlg = 1;
//     }
//
//   CounterNo_Reset();
//   /* <<< 2008/12/22 */
//
//   if(printTyp != 0 && CmCksys.cmUnmannedShop() == 0) {
//     printTyp = NORMAL_END;
//   }
//
//   //JMUPS,Verifone本日営業日の売上報告データを削除
//   if(await CmCksys.cmJmupsSystem() != 0 || await CmCksys.cmVescaSystem() != 0) {
//   jmups_sales_file_delete(TPRAID_STR, pCom->db_openclose.sale_date);
//   if(jmups_sales_report_num_get(TPRAID_STR) > 0) {
//   Jmups_Print = NORMAL_END;
//   if(CmCksys.cmUnmannedShop() != 0) { //印字、メッセージ表示しないため
//     Jmups_Print = 1;
//   }
//   }
//   }
//
//   //Verifone日計印字データを削除
//   if (await CmCksys.cmVescaSystem() != 0) {
//   rmstcls_vesca_daily_report_remove();
//   }
//
//   // お会計券用ファイル削除 (営業日確定後に行う)
//   rmopn_Del_DateFile();
//
//   // 過去実績圧縮ファイル削除(保持期間を過ぎたﾌｧｲﾙを削除)
//   // 動作条件は関数内でチェック
//   AplLib_PastCompFile_TarFileDel (TPRAID_STR, APLLIB_PASTCOMP_FILE_DEL);
//
//   /* dPoint/とdPoint/bak/内の対象ファイルを削除 */
//   DeldPointFile ();
//
//   // Shop&Go実績送信のファイル等を削除
//   DelBasketServerFile();
//
//   // 電子メールファイル削除
//   DelMailSenderFile();
//
//   // 電子レシート管理フォルダのファイル削除
//   DelNetReceiptFile();
//
//   //免税ファイル削除
//   DelTaxfreeFile();
//
//   // フレスタ機仕様のログファイル等を削除
//   DelFrestaFile();
//
//   // 世代管理数が０の時 または 前回営業日が初期値の時は、バックアップを行わない
//   if (generationData.substring(0, 1).compareTo('0') != 0 && dataRestorExecFlg != 1){
//   rmSpecBackUp ();	// スペックバックアップ処理(毎開設時にバックアップ)
//   }
//
//   if(search_errlog(TPRAID_STR) != 0)
//   {
//   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "HWInf_action : search_errlog error ");
//   }
//
//
//   // フローティング用のテーブルを削除する
//   Floating_Clear ();
//
//   rmstopn_reindex_table();
//
//   /*<----*/
//   QuitProc2nd();
//
//   OpenError:
//   if(clrFlg != Rmstcom.RMST_OK || updErr == 1){
//     updErr = 1;
//     Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.STOPENFAILED.val, 10);
//     prnLineMake("  ");
//     prnLineMake(LRmstopncls.STOPENFAILED.val);
//     Rmstcom.rmstMsgClear(callFunc);
//   // gtk_grab_add( winstopn );
//     Rmstcom.rmstMsgDisp(DlgConfirmMsgKind.MSG_SYSERR_RETRY.dlgId, DlgPattern.TPRDLG_PT1.dlgPtnId,
//   ForceEndProc, LTprDlg.BTN_YES, null, null, "", 0);
//     await AplLibAuto.aplLibAutoStrOpnClsError(Tpraid.TPRAID_STR, Rmstcom.rmstMsgNum); /* 自動開閉設：自動化中止 */
//   }
//
//   return 0;
//   }
  }

  /// 機能：開設処理強制終了
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - ForceEndProc
  static Future<int> forceEndProc() async {
    String callFunc = 'forceEndProc';

    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "ForeceEndProc Start");
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.FORCE_OPEN.val, 20);

//@@@
    if (await CmCkFjss.cmFjssSystem() != 0) {
      opnFtpSend();
    }

    if (recalChk != 0) {
      Rmstcom.rmstEjTxtMake(" ", Rmstcom.REG_OPEN);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.BS_REQUEST6_TXT.val, 4);
      Rmstcom.rmstEjTxtMake(" ", RmstcomDef.REG_OPEN);
      prnLineMake(LRmstopncls.BS_REQUEST6_TXT.val);
    }

    rmstOpenPointReteSet();

    rmstOpnEndEJ();

    scrDestroy();

    TprLog()
        .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "ForeceEndProc End");
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - ChkDateMessageDsp
  static Future<void> chkDateMessageDsp() async {
    DateTime nowDateTime = DateTime.now();
    DateTime sysDateWork = DateTime.now();
    tprDlgParam_t param = tprDlgParam_t();
    String dateCmt = '';
    int workYear = 0;
    int workMon = 0;
    int workMDay = 0;
    int week = 0;
    String nowDate = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    Rmstcom.rmstTimerRemove();

    nowDate =
    "${LRmstopncls.NOW_DATETIME.val}\n     ${nowDateTime.year}年${nowDateTime
        .month}月${nowDateTime.day}日(${nowDateTime.weekday})${nowDateTime
        .hour}:${nowDateTime.minute}";
    // gtk_label_set_text(GTK_LABEL(label_nowdate), nowdate);

    workYear = sysDateWork.year;
    workMon = sysDateWork.month;
    workMDay = sysDateWork.day;
    sysDateWork = Rmstcom.timeStOpn;
    week = sysDateWork.weekday;

    if (week > 6) {
      week = 0;
    }

    if (pCom.dbTrm.debitPrn == 1 ||
        (chkFlg == 1 && !(pCom.dbTrm.saledatePlus != 0 && fDate == 0))) {
      if (await chkAutoOpen() != 0 || rcStOpnAutoStartCheck()) {
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, chkDateYes);
        return;
      }

      param = tprDlgParam_t();
      dateCmt = sprintf('%s%4d%s%2d%s%2d%s(%s)\n  %s%s%s\n     %s', [
        LRmstopncls.SALE_DATE.val,
        sysDateWork.year,
        LRmstopncls.L_YEAR.val,
        sysDateWork.month,
        LRmstopncls.L_MONTH.val,
        sysDateWork.day,
        LRmstopncls.L_DAY.val,
        yobi[week],
        LRmstopncls.TODAY_DATE.val,
        '${nowDateTime.year}年${nowDateTime.month}月${nowDateTime.day}日',
        '(${nowDateTime.weekday})',
        LRmstopncls.OPEN_OK.val
      ]);

      // TODO:10152 履歴ログ 確認
      param.msgBuf = dateCmt;
      param.erCode = DlgConfirmMsgKind.MSG_FREE_MESSAGE.dlgId;

      param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
      param.msg1 = LTprDlg.BTN_YES;
      param.msg2 = LTprDlg.BTN_NO;
      param.func1 = chkDateYes;
      param.func2 = Rmstcls.noBtnProc;

      // TODO:10152 履歴ログ ダイアログ表示確認
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: param.dialogPtn,
        ),
      );
    } else {
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, openDlg);
    }

    return;
  }

  /// 関連tprxソース: rmstopn.c - ChkDateYES
  static int chkDateYes() {
    String callFunc = 'chkDateYes';

    Rmstcom.rmstTimerRemove();
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "ChkDateYES!!");
    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

//  fClear = TRUE;

    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, openDlg);

    return 0;
  }

  /// 機能：履歴ログ処理取得中断メッセージ「いいえ」の処理
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - UpdateStop_no
  static int updateStopNo() {
    String callFunc = 'updateStopNo';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf pStat = xRet.object;

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateStop_NO");
    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

    PROC_STS = Rmstcom.RMST_OK;

    Rmstcom.rmstTimerRemove();

    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId,
        DlgPattern.TPRDLG_PT2.dlgPtnId,
        updateStop,
        LTprDlg.BTN_INTERRUPT,
        null,
        null,
        "",
        0);

    if (pStat.hqhist.hqHistEnd == 0 || pStat.hqhist.running == 1) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "UpdateStop_NO : next HQASP_hqhist_wait ");
      Rmstcom.rmstTimerAdd(100, hqaspHqhistWait);
    } else {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "UpdateStop_NO : next UpdateHistLog ");
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateHistLog);
    }

    return 0;
  }

  /// 機能：履歴ログ取得メイン処理
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - UpdateHistLog
  static int updateHistLog() {
    int ret = 0;
    String callFunc = 'updateHistLog';

    Rmstcom.rmstTimerRemove();

    if (Rmstcom.rmstMsgNum != DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId) {
      Rmstcom.rmstMsgClear(callFunc);
      Rmstcom.rmstMsgDisp(
          DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId,
          DlgPattern.TPRDLG_PT2.dlgPtnId,
          updateStop,
          LTprDlg.BTN_INTERRUPT,
          null,
          null,
          "",
          0);
    }

    if (CmCksys.cmMmType() == CmSys.MacERR ||
        CmCksys.cmMmType() == CmSys.MacS) {
      // if(rm_tpr_con != NULL){
      // db_PQfinish(TPRAID_STR, rm_tpr_con);
      // rm_tpr_con = NULL;
      // }

      // if(rm_srx_con != NULL){
      // db_PQfinish(TPRAID_STR, rm_srx_con);
      // rm_srx_con = NULL;
      // }

      // TODO:10152 履歴ログ 必要？
      // ret = db_NotNormalStart(TPRAID_STR);
      // if(ret != Typ.OK) {
      // TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "db_NotNormalStart error\n");
      // }
    }

    cntDisp();
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateHistLogMain);

    return 0;
  }

  /// 機能：履歴ログ処理件数の表示
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - CntDisp
  static int cntDisp() {
    String msg = '';

    msg = "${LRmstopncls.HIST_CNT}${Rmstopn.histLogCnt.value}";

    // gtk_entry_set_text(GTK_ENTRY(entry_cnt), msg);

    return 0;
  }

  /// 関連tprxソース: rmstopn.c - UpdateHistLogMain
  static Future<int> updateHistLogMain() async {
    int ret = 0;
    int errFnd = 0;
    int tuples = 0;
    String errLog = '';
    String log = '';
    String path = '';
    String callFunc = 'updateHistLogMain';
    File file;

    Rmstcom.rmstTimerRemove();

    if (uRetry <= 0) {
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateEnd);
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateHistLog End");
      return 0;
    }

    tuples = 0;
    cntDisp();
    (ret, tuples) = await HistProc.histLogGet(
        Tpraid.TPRAID_STR, tuples, HistMain.HIST_MAX_CNT);
    (errFnd, errLog) = DbPqExec.dbErrTxtFoundSearch(Tpraid.TPRAID_STR);
    histLogCnt.value += tuples;
    if ((ret == HistMain.HIST_NO_TUPLE && errFnd == Rmstcom.RMST_OK)) {
      cntDisp();
      path = "${EnvironmentData().sysHomeDir}/tmp/histlog_task_err";
      file = TprxPlatform.getFile(path);

      if (file.existsSync()) {
        log = "$callFunc : Remove task err file ";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        AplLibStdAdd.aplLibRemove(Tpraid.TPRAID_STR, path);
      }

      if (await CmCksys.cmShopAndGoSystem() != 0) {
        // TODO:10152 履歴ログ AplLib_GetWebApi未実装
        // fqresWebapi = AplLib_GetWebApi (TPRAID_STR);
      }
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateEnd);
      return 0;
    }

    if (ret != HistMain.HIST_OK || errFnd != Rmstcom.RMST_OK) {
      uRetry--;
      if (uRetry % 10 == 0) {
        log = "UpdateHistLogMain retry[$uRetry]";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
      }

      if (uRetry <= 0 && errFnd != Rmstcom.RMST_OK) {
        updateErrEnd(errLog);
        return 0;
      }

      if (uRetry <= 0 && ret == HistMain.HIST_DBFILE_NG) {
        updateErrEnd(LRmstopncls.HIST_TASK_ERR.val);
        return 0;
      }
      await Future.delayed(Duration(seconds: uInter));
    }

    if (PROC_STS == FORCE) {
      return 0;
    }

    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateHistLogMain);

    return 0;
  }

  /// 機能：履歴ログ処理異常終了
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - UpdateErrEnd
  static Future<int> updateErrEnd(String? errLog) async {
    tprDlgParam_t dlgPrm = tprDlgParam_t();
    int erCode = 0;
    String path = '';
    File? fp;
    String log = '';
    String callFunc = 'updateErrEnd';

    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

    PROC_STS = FORCE;

    if (errLog != null &&
        errLog.compareTo(LRmstopncls.HIST_TASK_ERR.val) == 0) {
      path = "${EnvironmentData.TPRX_HOME}/tmp/histlog_task_err";
      fp = TprxPlatform.getFile(path);

      if (fp.existsSync()) {
        erCode = DlgConfirmMsgKind.MSG_STROPN_HIST_TASK_NG_CALL.dlgId;
      } else {
        erCode = DlgConfirmMsgKind.MSG_STROPN_HIST_TASK_NG_REBOOT.dlgId;
        fp = AplLibStdAdd.aplLibFileOpen(Tpraid.TPRAID_STR, path, "w");
        if (fp != null) {
          // AplLibFileClose( TPRAID_STR, fp );
        }
      }

      log = "$callFunc : history task err ";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
      errLog = "";
    } else if (await chkAutoOpen() != 0) {
      erCode = 0;
    } else {
      erCode = DlgConfirmMsgKind.MSG_GETHISTLOG_NG.dlgId;
    }

    if (erCode == 0) {
      Rmstcom.rmstTimerRemove();
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "UpdateErrEnd : Update failed !!");
      Rmstcom.rmstEjTxtMake(LRmstopncls.GET_HISTLOG_FAIL.val, Rmstcom.REG_OPEN);
      Rmstopn.prnLineMake(LRmstopncls.GET_HISTLOG_FAIL.val);
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateEnd);
    } else {
      Rmstcom.rmstMsgNum = erCode;

      dlgPrm.erCode = erCode;
      dlgPrm.dialogPtn = DlgPattern.TPRDLG_PT2.dlgPtnId;
      dlgPrm.func1 = updateEnd;
      dlgPrm.msg1 = LTprDlg.BTN_CONF;
      dlgPrm.user_code_2 = errLog!;

      // TODO:10152 履歴ログ ダイアログ確認
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: dlgPrm.erCode,
          footerMessage: await RcEwdsp.rcMakeUt1Msg(dlgPrm.erCode),
        ),
      );
    }
    return 0;
  }

  /// 機能：ASPからの履歴ログ処理件数の表示
  /// 引数：なし
  /// 戻値：0:終了
  ///  関連tprxソース: rmstopn.c - HQASP_CntDisp
  static int hqaspCntDisp() {
    String msg = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf pStat = xRet.object;

    msg = "${LRmstopncls.HQ_HIST_CNT.val}${pStat.hqhist.requestCount}";

    // gtk_entry_set_text(GTK_ENTRY(entry_cnt), msg);

    return 0;
  }

  /// 機能：HQASP仕様時、ASPへの履歴ログ送受信の完了待ち
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - HQASP_hqhist_wait
  static Future<int> hqaspHqhistWait() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf pStat = xRet.object;

    Rmstcom.rmstTimerRemove();

    if (await AplLibHqConnect.aplLibHqConnectHqHistRecvCheckSystem(
            Tpraid.TPRAID_STR) !=
        0) {
      if (pStat.hqhist.hqHistEnd == 0 || pStat.hqhist.running == 1) {
        // hqhistが取得中なので件数表示後に再帰. その他のシステムはここに入らない
        Rmstopn.hqaspCntDisp();
        Rmstcom.rmstTimerAdd(100, hqaspHqhistWait);
        return 0;
      }
    }

    // NGファイルの再送信開始
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "HQASP_hqhist_wait End.\n");
    Rmstcom.rmstTimerAdd(100, rmstOpnHqSendNGFileWait);

    return 0;
  }

  /// 機能：これまでに送信NGだったファイルがあれば再送信する.
  /// 再送信中, 1回でもNGがあったらそこで終了する.
  /// 引数：なし
  /// 戻値：0:終了
  ///  関連tprxソース: rmstopn.c - rmstopn_HQ_Send_NGFile_Wait
  static Future<int> rmstOpnHqSendNGFileWait() async {
    int ret = 0;
    String ngFile = '';
    String bkDirName = '';
    String log = '';
    String callFunc = 'rmstOpnHqSendNGFileWait';

    Rmstcom.rmstTimerRemove();

    ret = await AplLibHqConnect.aplLibHqConnectChkNGResend(
        Tpraid.TPRAID_STR); // NGファイルを再送するか確認
    if (ret == 1) {
      // NGファイルの確認
      bkDirName =
          "${EnvironmentData().sysHomeDir}${AplLib.HQCONNECT_BKUP_DIRNAME}";
      ret = AplLibStdAdd.aplLibProcScanDirBeta(Tpraid.TPRAID_STR, bkDirName,
          ngFile, AplLibHqConnect.aplLibHqConnectGetNGFile);
      if (ret == 1) {
        // 存在したので送信
        ret = await AplLibHqConnect.aplLibHqConnectHqftpRequestStart(
            Tpraid.TPRAID_STR, rxMem.HqftpRequestTyp.HQFTP_REQ_RESEND.type, ngFile);
        if (ret == 0) {
          // 成功した場合は再度確認
          Rmstcom.rmstTimerAdd(3000, rmstOpnHqSendNGFileWait);
          return 0;
        }
      }
    }

    // 送信の有無に関わらず、ここでNGファイルの確認を行い、NGファイルがあれば、画面にメッセージを表示する
    bkDirName =
        "${EnvironmentData().sysHomeDir}${AplLib.HQCONNECT_BKUP_DIRNAME}";
    ret = AplLibStdAdd.aplLibProcScanDirBeta(Tpraid.TPRAID_STR, bkDirName,
        ngFile, AplLibHqConnect.aplLibHqConnectGetNGFile);
    if (ret == 1) {
      // NGファイルがある
      // OpnScrMainDisp()を参考
      int xPosi = 140;

      // label = gtk_label_new (TEXT_SENDERR3);
      // ChgStyle(label, &ColorSelect[Red], &ColorSelect[Red], &ColorSelect[Red], KANJI16);
      // gtk_widget_show (label);
      // gtk_fixed_put (GTK_FIXED(fixedstopn), label, x_posi, 428);
      // gtk_widget_set_uposition (label, x_posi, 428);
      // gtk_widget_set_usize(label, 350, 48);
      // gtk_label_set_line_wrap(GTK_LABEL (label), TRUE);

      log = "$callFunc : NG File [$ngFile]. SendErr Message display.";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

      // EJに再送信方法を残す
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR1.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR2.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR_SPC.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR3.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR4.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR5.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR_SPC.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR6.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR7.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR8.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR9.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR10.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR11.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR12.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR13.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR14.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR_DIV.val, 0);
      Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NGFILE_SENDERR_SPC.val, 0);
    }

    // 通常の履歴ログ取得を開始
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "rmstopn_HQ_Send_NGFile_Wait End.\n");
    Rmstcom.rmstMsgClear(callFunc);
    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId,
        DlgPattern.TPRDLG_PT2.dlgPtnId,
        updateStop,
        LTprDlg.BTN_INTERRUPT,
        null,
        null,
        "",
        0);
    Rmstcom.rmstTimerAdd(100, updateStart);

    return 0;
  }

  /// 機能：初期画面表示後の初期処理(強制イベント)
  /// 引数：なし
  /// 戻値：0:終了
  ///  関連tprxソース: rmstopn.c - UpdateStart
  static Future<int> updateStart() async {
    int errNo = 0;
    String callFunc = 'updateStart';

    Rmstcom.rmstTimerRemove();
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateStart Start");

    if (CmCksys.cmMmType() == CmSys.MacM1 &&
        await CmCksys.cm24hourSystem() != 0) {
      // WolProc(); /* MM System Wake Up On LAN */
    }

//	MBSNoGet(pCom->db_regctrl.comp_cd, pCom->db_regctrl.stre_cd);
    if (await chkAutoOpen() != 0 && (CmCksys.cmMmType() == CmSys.MacM2 ||
        CmCksys.cmMmType() == CmSys.MacS)) {
      errNo = await mOpenChk();
      if (errNo != 0) {
        Rmstcom.rmstMsgClear(callFunc);
        Rmstcom.rmstMsgDisp(
            errNo,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            forceStart,
            LTprDlg.BTN_FORCESTART,
            null,
            null,
            "",
            0);
        Rmstcom.rmstTimerAdd(7000, mOpenChkRetry);
      } else {
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateWait);
      }
    } else {
      if (srxOpen() != Rmstcom.RMST_OK) {
        if (CmCksys.cmMmType() == CmSys.MacM1 &&
            await CmCksys.cm24hourSystem() != 0) {
          Rmstcom.rmstMsgClear(callFunc);
          // gtk_grab_add( winstopn );
        }

        if (CmCksys.cmMmType() != CmSys.MacERR) {
          Rmstcom.rmstMsgClear(callFunc);
          Rmstcom.rmstMsgDisp(
              DlgConfirmMsgKind.MSG_MWAITOPEN.dlgId,
              DlgPattern.TPRDLG_PT2.dlgPtnId,
              forceStart,
              LTprDlg.BTN_FORCESTART,
              null,
              null,
              "",
              0);
        } else {
          Rmstcom.rmstMsgClear(callFunc);
          Rmstcom.rmstMsgDisp(
              DlgConfirmMsgKind.MSG_FORCESTART.dlgId,
              DlgPattern.TPRDLG_PT2.dlgPtnId,
              forceStart,
              LTprDlg.BTN_FORCESTART,
              null,
              null,
              "",
              0);
        }
        Rmstcom.rmstTimerAdd(5000, openRetry);
      } else {
        if (CmCksys.cmMmType() == CmSys.MacM1 &&
            await CmCksys.cm24hourSystem() != 0) {
          Rmstcom.rmstMsgClear(callFunc);
          // gtk_grab_add( winstopn );
        }
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateWait);
      }
    }

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateStart End");
    return 0;
  }

  ///  関連tprxソース: rmstopn.c - MOpenChk
  static Future<int> mOpenChk() async {
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "MOpenChk Start");

    mOpen = 0;
    if (CmCksys.cmMmType() == CmSys.MacM2) {
      bsOpen = 1;
    } else {
      bsOpen = 0;
    }

    return await mStatGet();
  }

  ///  関連tprxソース: rmstopn.c - MStatGet
  static Future<int> mStatGet() async {
    String sql = '';
    String log = '';
    int errNo = 0;
    String mstName = '';
    DbManipulationPs db = DbManipulationPs();
    Result res;

    // if(rm_srx_con != NULL) {
    // db_PQfinish(TPRAID_STR, rm_srx_con);
    // rm_srx_con = NULL;
    // }

    // rm_srx_con = db_SrLogin(TPRAID_STR,DB_NOERRLOG);

    // if(rm_srx_con == NULL) {
    // TprLibLogWrite(TPRAID_STR, TPRLOG_ERROR, -1, "MStatGet: SrLogin error!!\n");
    // } else {

    if (mOpen == 0) {
      if (mMacNo != 0) {
        AplLibOther.aplLibGetMstName("c_openclose_mst", mstName, "",
            PartitionType.PART_TYPE_NORMAL.type);
        sql =
        "SELECT sale_date FROM $mstName WHERE $whBuf AND mac_no='$mMacNo' AND open_flg='1' AND close_flg= '0'\n";

        try {
          res = await db.dbCon.execute(sql);

          if (res.isNotEmpty) {
            mOpen = 1;
          } else {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "MStatGet M is not open");
          }
        } catch (e) {
          // Cソース「db_PQexec() == NULL」時に相当
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
              "MStatGet REGCTR_FAIL(M)");
        }
      }
    }

    if (bsOpen == 0) {
      if (bsMacNo != 0) {
        AplLibOther.aplLibGetMstName("c_openclose_mst", mstName, "",
            PartitionType.PART_TYPE_NORMAL.type);
        sql =
        "SELECT sale_date FROM $mstName WHERE $whBuf AND mac_no='$bsMacNo' AND open_flg='1' AND close_flg= '0'\n";

        try {
          res = await db.dbCon.execute(sql);

          if (res.isNotEmpty) {
            bsOpen = 1;
          } else {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "MStatGet BS is not open");
          }
        } catch (e) {
          // Cソース「db_PQexec() == NULL」時に相当
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
              "MStatGet REGCTR_FAIL(BS)");
        }
      }
    }
    // }

    if (mOpen != 0 && bsOpen != 0) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "MOpenChk Normal end!!");
      return 0;
    }

    log = "MOpenChk M_open[$mOpen], BS_open[$bsOpen]";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);

    if (mOpen == 0 && bsOpen == 0) {
      errNo = DlgConfirmMsgKind.MSG_MBSWAITOPEN.dlgId;
    } else if (mOpen == 0) {
      errNo = DlgConfirmMsgKind.MSG_MWAITOPEN.dlgId;
    } else {
      errNo = DlgConfirmMsgKind.MSG_BSWAITOPEN.dlgId;
    }

    return errNo;
  }

  /// 機能：強制起動ボタンのイベント
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - ForceStart
  static int forceStart() {
    String callFunc = 'forceStart';

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);

    // gtk_grab_add( winstopn );

    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, forceStartNext);

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "Update Start: ForceStart");
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - ForceStartNext
  static int forceStartNext() {
    Rmstcom.rmstTimerRemove();

    PROC_STS = FORCE;
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.GET_NEW_INFO.val, 4);
    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_FORCESTARTCONF.dlgId,
        DlgPattern.TPRDLG_PT1.dlgPtnId,
        Rmstcls.noBtnProc,
        LTprDlg.BTN_YES,
        forceStartNo,
        LTprDlg.BTN_NO,
        "",
        0);

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "Update Start: ForceStartNext");
    return 0;
  }

  /// 機能：強制起動メッセージ「いいえ」ボタンのイベント
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - ForceStart_no
  static int forceStartNo() {
    String callFunc = 'forceStartNo';

    Rmstcom.rmstMsgClear(callFunc);
    // gtk_grab_add( winstopn );

    PROC_STS = Rmstcom.RMST_OK;
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.NOBTN_PROC.val, 10);
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateStart);

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "Update Start: ForceStart_no");
    return 0;
  }

  /// 機能：接続失敗時の定期イベント
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース: rmstopn.c - MOpenChkRetry
  static Future<int> mOpenChkRetry() async {
    int errNo = 0;
    String callFunc = 'mOpenChkRetry';

    Rmstcom.rmstTimerRemove();

    errNo = await mStatGet();

    if (errNo == 0) {
      Rmstcom.rmstMsgClear(callFunc);
      // gtk_grab_add( winstopn );
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateWait);
      TprLog()
          .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "MOpenChkRetry OK");
      return 0;
    }

    if (Rmstcom.rmstMsgNum != errNo) {
      Rmstcom.rmstMsgClear(callFunc);
      Rmstcom.rmstMsgDisp(errNo, DlgPattern.TPRDLG_PT2.dlgPtnId, forceStart,
          LTprDlg.BTN_FORCESTART, null, null, "", 0);
    }

    Rmstcom.rmstTimerAdd(7000, mOpenChkRetry);
    return 0;
  }

  /// 機能：履歴ログ取得中メッセージの表示(初期処理)
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - UpdateWait
  static Future<int> updateWait() async {
    int ret = 0;

    Rmstcom.rmstTimerRemove();

    TprLog()
        .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateWait Start");

    if (CmCksys.cmMmType() == CmSys.MacERR) {
      // TODO:10152 履歴ログ 保留
      // StatUpload();
    }

    if (CmCksys.cmMmType() == CmSys.MacM1 ||
        CmCksys.cmMmType() == CmSys.MacMOnly) {
      // TODO:10152 履歴ログ 保留
      // rmstSchCtrlDel();
    }

    Rmstopn.histLogCnt.value = 0;

    ret = await chkAllRequest(0);
    if (ret > 0) {
      /* 全件リクエスト */
      rmstopnWinMod = STOPN_FREQ;
      opnStatFlg = OPN_EXEC;
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, rmstFreqStart);
      return 0;
    } else {
      if (await chkAutoOpen() != 0) {
        Rmstcom.rmstMsgDisp(DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId, null, null, null, null, "", 0);
      } else {
        Rmstcom.rmstMsgDisp(
            DlgConfirmMsgKind.MSG_NOWUPDATING.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId,
            updateStop,
            LTprDlg.BTN_INTERRUPT,
            null,
            null,
            "",
            0);
      }

      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateHistLog);
    }
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "UpdateWait End");
    return 0;
  }

  /// 機能：全件リクエストを行う必要があるかチェックする
  /// 引数：1:Vup後ファイルリクエストのチェック 0:通常
  /// 戻り値：	0:全件リクエストを行わない
  /// 1:全件リクエストを行う
  /// 2:全件リクエストを行う (税種変更用)
  /// 関連tprxソース: rmstopn.c - ChkAllRequest
  static Future<int> chkAllRequest(int chkFlg) async {
    int macNo = 0;
    int flg = 0;
    int addDays = 0;
    String sql = '';
    String date = '';
    String chkDate = '';
    String sysDate = '';
    String log = '';
    bool taxChgChk = false;
    String callFunc = 'chkAllRequest';
    File file;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    DbManipulationPs db = DbManipulationPs();
    Result res;

//SIMS等上位からリクエストが必要時別途対応して下さい
    if (CmCksys.cmMmType() == CmSys.MacM1 ||
        CmCksys.cmMmType() == CmSys.MacMOnly) {
      return 0;
    }

    // クイック再セットアップ中の場合、表示させない
    if (dataRestorExecFlg == 1) {
      return 0;
    }

    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        Tpraid.TPRAID_STR,
        CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE,
        CompetitionIniType.COMPETITION_INI_GETSYS);
    date = ret.value;

    // TODO:10152 履歴ログ 確認
    if (ret.isSuccess == true) {
      if (date.compareTo("0000-00-00") == 0) {
        log = "$callFunc: after setup and no check!";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        return 0;
      }
    }

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "ChkAllRequest Start");

    file = TprxPlatform.getFile(AplLib.AFTER_VUP_FREQ_FILE);

    // Vup後の最初の開設時.ファイルリクエスト指示ファイル存在する場合
    if (file.existsSync()) {
      log = "$callFunc: [${AplLib.AFTER_VUP_FREQ_FILE}] exist!";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
      return 1;
    }

    if (chkFlg == 1) {
      return 0;
    }

    /* レジ番号の取得 */
    macNo = pCom.dbRegCtrl.macNo;

    sql =
        "SELECT sale_date FROM c_openclose_mst WHERE comp_cd = '${pCom.dbRegCtrl.compCd}' AND stre_cd = '${pCom.dbRegCtrl.streCd}' AND mac_no = '$macNo'\n";

    try {
      res = await db.dbCon.execute(sql);
      if (res.isEmpty) {
        log = "No DATA db-mac#[$macNo] !!!";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
        return 1; /* DB ERROR */
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      return 1;
    }

    sql =
        "SELECT max(sale_date) as sale_date FROM c_openclose_mst WHERE comp_cd = '${pCom.dbRegCtrl.compCd}' AND stre_cd = '${pCom.dbRegCtrl.streCd}' AND mac_no = '$macNo'\n";

    try {
      res = await db.dbCon.execute(sql);
      if (res.isNotEmpty) {
        Map<String, dynamic> data = res.elementAt(0).toColumnMap();
        date = data['sale_date'].toString();
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      return 1;
    }

    addDays = pCom.dbTrm.allRequestDate; //全件リクエスト電源断日数
    // TODO:10152 履歴ログ確認
    chkDate = getAddDate(date, addDays);

    final dateFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    sysDate = dateFormatter.format(DateTime.now());

    flg = sysDate.compareTo(chkDate);

    if (flg >= 0 && addDays != 0) {
      flg = 1;
    } else {
      flg = 0;
    }

    // 税種予約変更で24時間仕様のとき
    // TODO:10152 履歴ログ ファイルリクエスト系保留
    // taxChgChk = prgPlanUpdate_24HourNotM_FileChk(TPRAID_STR);
    if (flg == 0) {
      if (taxChgChk == true) {
        flg = 2;
      }
    }

    log = "ChkAllRequest End : return($flg)";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
    return flg;
  }

  /// 機能：加算した日付を返す
  /// 関連tprxソース: rmstopn.c - GetAddDate
  static String getAddDate(String src, int aDays) {
    String strDate = '';
    DateTime date;

    final dateFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");

    try {
      date = dateFormatter.parseStrict(src);
      date.add(Duration(days: aDays));
      strDate = dateFormatter.format(date);
    } catch (e) {
      // 変換に失敗した場合の処理
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, 'getAddDate : error');
      return strDate;
    }

    return strDate;
  }

  /// 関連tprxソース: rmstopn.c - rmst_freq_start
  static Future<int> rmstFreqStart() async {
    String log = '';
    String callFunc = 'rmstFreqStart';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);
    log = callFunc;
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
    retryCnt = 0;
    pCom.rmstInfo.rmstFreq = 1;
    pCom.rmstInfo.freqRes = Freq.FREQ_OK;
    await rmstFreqTaskCtrl(0);
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, rmstFreqEndChk);
    return 0;
  }

  /// 関連tprxソース: rmstopn.c - rmstFreqTaskCtrl
  static Future<void> rmstFreqTaskCtrl(int flg) async {
    RxInputBuf inpBuf = RxInputBuf();
    int i = 0;

    if (flg == 0) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "rmstFreqTaskCtrl Start !!");
      inpBuf.inst = RxRegsinst.RX_ANOTHER2_START;
    } else {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmstFreqTaskCtrl Stop !!");
      inpBuf.inst = RxRegsinst.RX_ANOTHER2_STOP;
    }

    for (i = 0; i < 20; i++) {
      RxMemRet xRetM = SystemFunc.rxMemRead(RxMemIndex.RXMEM_MNTCLT);
      if (xRetM.isInvalid()) {
        return;
      }

      inpBuf.ctrl.ctrl = true;
      inpBuf.devInf.data = rxMem.RxMem.ANOTHER_FREQ;
      if (xRetM.result == RxMem.RXMEM_OK) {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.normal, "SEND RXQUEUE OK");
      } else {
        TprLog()
            .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "WRITE RXMEM NG");
      }
      break;
    }

    if (i >= 20) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "RETRY OVER");
    }

    return;
  }

  /// 関連tprxソース: rmstopn.c - rmst_freq_end_chk
  static Future<int> rmstFreqEndChk() async {
  String log = '';
  String callFunc = '';
  RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
  if (xRet.isInvalid()) {
    return 0;
  }
  RxCommonBuf pCom = xRet.object;

  Rmstcom.rmstTimerRemove();
  if(pCom.rmstInfo.rmstFreq != 3){
  if(pCom.rmstInfo.rmstFreq == 1){
  if(retryCnt > 60){	//freqタスク起動失敗時（通常ありえないが、念の為）
  log = "$callFunc : Freq Task Start Failed!!";
  TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
  retryCnt = 0;
  await rmstFreqTaskCtrl(1);
  Rmstcom.rmstMsgDisp(DlgConfirmMsgKind.MSG_FREQ_FAIL.dlgId, DlgPattern.TPRDLG_PT1.dlgPtnId, rmstFreqStart, LTprDlg.BTN_RETRY, rmstFreqEnd, LTprDlg.BTN_FORCE, " ", 0);
  return 0;
  }
  retryCnt ++;
  }
  Rmstcom.rmstTimerAdd(5000, rmstFreqEndChk);
  return 0;
  }

  TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmst_freq_end_chk OK");
  await rmstFreqEnd();

  return 0;
  }

  ///  関連tprxソース: rmstopn.c - rmst_freq_end
  static Future<int> rmstFreqEnd() async {
    CharData prnData = CharData();
    File fp;
    String file = '';
    String buf = '';
    String callFunc = 'rmstFreqEnd';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);

    Rmstcom.ejData = CharData();
    Rmstcom.ejData.str1 = LRmstopncls.FREQ_MSG.val;
    Rmstcom.ejData.posi1 = 4;
    if (pCom.rmstInfo.rmstFreq == 3 && pCom.rmstInfo.freqRes == Freq.FREQ_OK) {
      TprLog()
          .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmst_freq_end OK");
      Rmstcom.ejData.str2 = LRmstopncls.ENTRY_TXT_OK.val;
      // gtk_widget_hide (err_label);
    } else if (pCom.rmstInfo.rmstFreq == 1) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmst_freq_end Force End");
      // gtk_widget_show (err_label);
      Rmstcom.ejData.str2 = LRmstopncls.FORCE_END.val;
    } else {
      TprLog()
          .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmst_freq_end NG");
      // gtk_widget_show (err_label);
      Rmstcom.ejData.str2 = LRmstopncls.ENTRY_TXT_NG.val;
    }
    Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);

    prnData.str1 = LRmstopncls.FREQ_MSG_PRN.val;
    if (pCom.rmstInfo.rmstFreq == 3 && pCom.rmstInfo.freqRes == Freq.FREQ_OK) {
      prnData.str2 = LRmstopncls.ENTRY_TXT_OK.val;
    } else {
      prnData.str2 = LRmstopncls.ENTRY_TXT_NG.val;
    }
    rmstPrnlineDataSet(prnData);
    if (pCom.rmstInfo.freqRes == Freq.FREQ_NG) {
      file = sprintf(Freq.FREQ_ERR_FILE, [EnvironmentData().sysHomeDir]);
      fp = TprxPlatform.getFile(file);
      if (fp.existsSync()) {
        Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.FREQ_ERR_ITEM.val, 6);

        while (true) {
          if (fp.readAsLinesSync().isNotEmpty) {
            if (buf.contains(LFreq.DISP_SELECTED)) {
              /* 項目名	*/
              Rmstcom.rmstEjTxtMakeNew2(buf, 9);
            }
          } else {
            break;
          }
        }
      }
    }

    pCom.rmstInfo.rmstFreq = 0;
    pCom.rmstInfo.rmstFreqRetry = 0; // 再実行フラグ
    // gtk_grab_add( winstopn );

    if (await chkAllRequest(1) != 0 && autoErr == 0) {
      autoErr = DlgConfirmMsgKind.MSG_FREQNG_AUTOSTROPN_STOP.dlgId;
    }

    await updateEndAfter();
    opnStatFlg = 0;

    return 0;
  }

  /// 関数：int SrxOpen(void)
  /// 機能：SR-X接続処理
  /// 引数：なし
  /// 戻値：RMST_OK:正常終了 / RMST_NG:異常終了
  ///  関連tprxソース: rmstopn.c - RMSTOPEN_CHPRICE_T
  static int srxOpen() {
    // if((rm_srx_con = db_SrLogin(TPRAID_STR,DB_ERRLOG)) == NULL) {
    //   TprLibLogWrite(TPRAID_STR, TPRLOG_ERROR, -1, "SrxOpen: Srx Connect Error!!");
    //   return RMST_NG;
    // }
    return Rmstcom.RMST_OK;
  }

  /// 関数：int OpenRetry(void)
  /// 機能：SR-X接続失敗時の定期イベント
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース: rmstopn.c - RMSTOPEN_CHPRICE_T
  static void openRetry() {
    String callFunc = '';
    if (srxOpen() == Rmstcom.RMST_OK) {
      Rmstcom.rmstMsgClear(callFunc);
      // gtk_grab_add( winstopn );
      Rmstcom.rmstTimerRemove();
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, updateWait);
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "OpenRetry OK");
    }
  }

  ///  関連tprxソース: rmstopn.c - Update_RetryGet
  static Future<void> updateRetryGet() async {
    int buf = 0;
    String log = '';

    Mac_infoJsonFile macIni = Mac_infoJsonFile();
    await macIni.load();
    buf = macIni.stopn_retry.retry_cnt;
    JsonRet ret =
        await macIni.setValueWithName('stopn_retry', 'retry_cnt', buf);

    if (ret.result == true) {
      uRetry = 1;
    } else {
      uRetry = buf;
    }

    buf = macIni.stopn_retry.retry_inter;
    ret = await macIni.setValueWithName('stopn_retry', 'retry_inter', buf);

    if (ret.result == true) {
      uInter = 5;
    } else {
      uInter = buf;
    }

    uRetry = (uRetry == 0) ? 1 : uRetry;
    uInter = (uInter == 0) ? 1 : uInter;
    cRetry = uRetry;

    log = "Update_RetryGet: time[$uRetry], inter[$uInter]";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

    return;
  }


  /// 関数：int MacNoChk(void)
  /// 機能：マシン番号のチェック(異なる場合は開設処理強制終了)
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstopn.c - MacNoChk
  static Future<int> macNoChk() async {
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    Rmstcom.rmstTimerRemove();

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "MacNoChk Start");

    int macNo =
        (await CompetitionIni.competitionIniGetMacNo(Tpraid.TPRAID_STR)).value;

    /* マシン番号のチェック */
    log =
        "ini-mac#[$macNo] db-mac#[${pCom.dbRegCtrl.macNo}] mm_onoff[${pCom.iniMacInfo.mm_system.mm_onoff}] mm_type[${pCom.iniMacInfo.mm_system.mm_type}]";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
    if (macNo == pCom.dbRegCtrl.macNo) {
      if (CmCksys.cmMmType() == CmSys.MacM1 &&
          await CmCksys.cm24hourSystem() != 0) {
        Rmstcom.rmstMsgDisp(DlgConfirmMsgKind.MSG_WAKEUPONLAN.dlgId,
            DlgPattern.TPRDLG_PT2.dlgPtnId, null, null, null, null, "", 0);
      }
//V1 @@@
      await Rmstopn.rmstOpnPreUpdateWait(); // 履歴ログ取得開始実行

      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "MacNoChk End");
      return 0;
    }

    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.REGCTR_FAIL.val, 4);
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.REGCTR_FAIL2.val, 8);

    /* 開設処理強制終了 */
    Rmstcom.rmstMsgDisp(
        DlgConfirmMsgKind.MSG_REGCTR_FAIL.dlgId,
        DlgPattern.TPRDLG_PT2.dlgPtnId,
        forceEndProc,
        LTprDlg.BTN_END,
        null,
        null,
        "",
        0);
    await AplLibAuto.aplLibAutoStrOpnClsError(
        Tpraid.TPRAID_STR, Rmstcom.rmstMsgNum); /* 自動開閉設：自動化中止 */

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "MacNoChk REGCTR_FAIL");
    return 0;
  }

  /// 表示しているダイアログを全て閉じる
  static void _closeDialogAll() {
    while (Get.isDialogOpen == true) {
      Get.until((route) =>  route.settings.name == RegisterPage.storeOpen.routeName);
    }
  }
}

///  関連tprxソース: rmstopn.c - RMSTOPEN_CHPRICE_T
class RmStOpenChPriceT {
  late Connection localCon;
  CBatprcchgMstColumns dbBatprcchg = CBatprcchgMstColumns();
  CBatprcchgMstColumns dbBatprcchgPlu = CBatprcchgMstColumns();
  ChPricePluMst dbPlu = ChPricePluMst();
  ChgParam paramChprice = ChgParam();
  int batprcchgNum = 0;
  int errCnt = 0;
  int procNum = 0;
  int prcchgCd = 0;
  int runFlg = 0;

  /* Run or Restore
										0:run
										1:restore
									*/
  int stepStatus = 0;

  /* step
										-1:end
										 0:pickup c_batprcchg_mst
										 1:read c_batprcchg_mst
										 2:read c_plu_mst
										 3:write
										 4:ej
									*/
  int prnHead = 0;
}

///  関連tprxソース: rmstopn.c - chprice_plu_mst
class ChPricePluMst {
  String pluCd = '';

  /* plu code */
  int smlclsCd = 0;

  /* small class code */
  int catDscCd = 0;

  /* category discount code */
  String posName = '';

  /* pos kanji name */
  int posPrc = 0;

  /* pos_price */
  int custPrc = 0;

  /* customer price */
  int taxCd = 0;

  /* tax code */
  int mkrCd = 0;
/* maker code */
}