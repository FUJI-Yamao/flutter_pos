/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';
import 'dart:io';

import 'package:flutter_pos/app/inc/sys/tpr_lib.dart';
import 'package:flutter_pos/app/lib/cm_mbr/cmmbrsys.dart';
import 'package:flutter_pos/app/sys/usetup/freq/freq_tbl.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/environment.dart';
import '../../../fb/fb2gtk.dart';
import '../../../inc/apl/compflag.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/apl/rxsys.dart';
import '../../../inc/lib/apllib.dart';
import '../../../inc/lib/cm_sys.dart';
import '../../../inc/lib/db_error.dart';
import '../../../inc/lib/spqc.dart';
import '../../../inc/sys/tpr_def.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apl_db/dbInitTable.dart';
import '../../../lib/apllib/apllib_std_add.dart';
import '../../../lib/apllib/apllib_trm_sys_check.dart';
import '../../../lib/apllib/chgstrecd.dart';
import '../../../lib/apllib/competition_ini.dart';
import '../../../lib/apllib/data_restor_lib.dart';
import '../../../lib/apllib/db_comlib.dart';
import '../../../lib/apllib/lib_fb_memo.dart';
import '../../../lib/apllib/recog.dart';
import '../../../lib/apllib/rm_db_read.dart';
import '../../../lib/apllib/rm_ini_read.dart';

import '../../../lib/apllib/rx_prt_flag_set.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import '../../../ui/page/common/component/w_msgdialog.dart';
import '../../../ui/page/file_request/controller/c_freq.dart';
import '../../word/aa/l_freq.dart';
import 'db_file_req.dart';

// ファイルリクエスト内でのエラー確認タイプ
enum RESULT_LIST_DISP_TYPE {
  RESULT_DISP_FREQ_NG, // NG確認(ファイルリクエストした結果失敗したテーブル情報)
  RESULT_DISP_HIST_ERR, // 履歴失敗(履歴ログで取得失敗したテーブル情報)
}

class Freq {
  static int mItemNum = 0; // 項目数
  static int totalPage = 0; // 合計ページ数
  static int pageNumber = 0;
  static int freqStatus = 0; // （1：ファイルリクエスト/初期化実行中）

  static int freqPtimer = 0;
  static int quickTimer = 0;

  static const TPRMAXPATHLEN_2 = 1024;

  static String macno = "";
  static String comCd = "";
  static String streCd = "";
  static String fghostname = "";
  static String fgusername = "";
  static String fgpassword = "";
  static int mac_no = 0;
  static Object conSR = Null;
  static Object conTPR = Null;

  // static  PGconn  *conSR = NULL;
  // static  PGconn  *conTPR = NULL;
  static int iIdx = 0; // グループ用インデックス
  static int jIdx = 0; // テーブル用インデックス
  static int kIdx = 0;
  static List<int> existFlg = List.filled(128, 0);

  static int freqDlg = 0; // DBアクセスエラーフラグ
  static int freqDlgtimer = 0;
  static int stopDb = 0;
  static int freqDspTimer = -1;

  /* 2002/06/21 */
  static int freqEventFlg = 0;

  /* 2002/06/21 */
  // static	RX_COMMON_BUF	*pCom;			/* 2002/07/22 */
  static int dbRet2 = 0;
  static int dbRet3 = 0;
  static int dataRestorFlg = 0; // spec_bkup戻し時に使用するフラグ
  static int dataRestorExecFlg = 0; // spec_bkup戻し時に使用するフラグ
  static int dataRestorExecFlg1 = 0; // spec_bkup戻し時に使用するフラグ
  static int dataRestorExecFlg2 = 0; // spec_bkup戻し時に使用するフラグ
  static int dataRestorExecFlg3 = 0; // spec_bkup戻し時に使用するフラグ

  static int dataRestorExecno = 0; // spec_bkup戻し時に使用するフラグ
  static String dataRestorFilename = ""; // spec_bkup戻し時に使用するファイル名

  static int specExecFlg = 0;
  static int reginfoExecFlg = 0;

  static int oldSoftKeyb = 0;

  //（個別選択画面）
  static int selBtnNo = 0; //メイン画面で押されたテーブル一覧に対応するボタン番号
  static int selPageBtnNum = 0; //個別選択画面 テーブル選択ボタン数(=カテゴリー内テーブル数)
  static int addedSelTblBtnNum = 0; //個別選択画面 追加済みボタン数
  static int maxPageNum = 0; //個別選択画面 最終ページ番号(=ページ数)
  static int currentPageNo = 1; //個別選択画面 現在ページ番号
  static int prevPageNo = 1; //個別選択画面 ページ移動前のページ番号

  //エラー項目確認画面関連
  static String rFile = ""; //エラー結果保存ファイル

  /*  define  */
  static const PG_MAX_BTN = 7;
  static const PG_MAX_LINE = 18;
  static const FREQ_DBG = false;

  static const BT_WIDTH = (TprDef.TPRWINDOW_W / 13);
  static const BT_HEIGHT = (TprDef.TPRWINDOW_H / 10);
  static const TABLE_WIDTH = TprDef.TPRWINDOW_W;
  static const TABLE_HEIGHT = TprDef.TPRWINDOW_H;
  static const FREQ_LOG = Tpraid.TPRAID_FREQ;
  static const FREQ_TIMER = 100;
  static const FREQ_WAIT = 500;

  /* wait time  */
  static const FREQ_NG = 0; // 異常
  static const FREQ_OK = 1; // 正常
  static const FREQ_ERR_FILE = "%s/log/freq_err.txt"; // エラーファイル

  static const DATA_STEP_SETUP = "5"; // スペック再セットアップ
  static const DATA_STEP_OPEN_PROCESS = "8"; // 開設処理

  static const SIMS2100_NAME = "sims2100";

  //(ファイル初期設定 用)
  static const FINIT_LOG = 0;
  static const FINIT_SPEC_NUM = 7;

  /* TPR-APL-IT-715 */
  static const FINIT_SPEC_JCC_NUM = 2;

  /* TPR-APL-IT-715 */
  static const FINIT_WAIT = FREQ_WAIT;

  /* global */
  static List<btData> crItem = [];

  /* 項目(m_item_num数分確保)				*/

  static int execFlg = 0;
  static int freqEflg = 0; // ファイルリクエストエラーフラグ
  static bool get allselectFlg {
    final FileRequestPageController ctrl = Get.find();
    return ctrl.allSelectFlg.value;
  }

  static set allselectFlg(bool select) {
    final FileRequestPageController ctrl = Get.find();
    ctrl.allSelectFlg.value = select;
  }

  static bool allselectFlgBak = false;
  static bool allselectFlgBakQc = false;
  static bool allselectFlgBakSp = false;
  static int freqDbflg = 0;
  static int afterVupFreqTxtRemoveFlg = 0;

  static int freqCnctSvr = 0;

  /* 接続先のＩＰ 0:サーバー or サブサーバー
                                1:センターサーバー        */
  static ErrRestlistDsp errList = ErrRestlistDsp(); //エラー項目情報

  static int selectedItemTotal = 0;
  static int executeItemIndex = 0;

  static String freqHomeDirp = "";
  static int freqCallMode = 0;
  static int freqCallModeBack = 0;
  static int freqEventTimer = -1;
  static int freqVerChk = 0;
  static int freqIniVerChk = 0;

  /// ファイルリクエスト初期設定
  /// 関連tprxソース: freq.c - freq_main2 (void)
  static Future<void> init() async {
    mItemNum = 0;
    totalPage = 0;
    pageNumber = 0;
    freqStatus = 0;
    freqPtimer = 0;
    allselectFlgBak = false;
    allselectFlgBakQc = false;
    allselectFlgBakSp = false;
    freqDbflg = 0;
    afterVupFreqTxtRemoveFlg = 0;
    freqDlg = 0;
    freqDlgtimer = 0;
    execFlg =0;
    crItem = [];
    oldSoftKeyb = 0;
    freqHomeDirp = EnvironmentData.TPRX_HOME;

    if (CmCksys.cmMmSystem() != 0) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isValid()) {
        RxCommonBuf pCom = xRet.object;
        pCom.csvServerFlg = 99;
      }
    }

    if (await CmCksys.cmMmIniType() == CmSys.MacM1
    || await CmCksys.cmMmIniType() == CmSys.MacM2) {
      if (freqCallMode == Rxsys.RXSYS_MSG_FREQS.id){
        // TODO:10140 MMシステム
        // rxSysSend
      }
    }

    // 関連tprxソース: freq.c - freq_main()より、エラーファイルのパス設定処理を追加
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    if((pCom.rmstInfo.rmstFreq != 0)
        || (pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE)){
      rFile = sprintf(FREQ_ERR_FILE, [freqHomeDirp]);
    }else if (pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_NEW){
      // クイックセットアップは実装対象外
      // rFile = sprintf(FREQ_ERR_QUICK_FILE, [freqHomeDirp]);
    }
  }


  /// ファイル初期設定マスタを読み込み、項目の設定を行う。
  /// 関連tprxソース: freq.c - freq_set
  /// 引数：なし
  /// 戻値：0: 正常終了
  /// 　　　0以外: 1 : Memory allocation for cr_item error
  /// 	         2 : Memory allocation for cr_item[i].data error
  /// 	         3 : Return value from freq_make_page()
  /// 	         4 : Return value fron freq_make_btxt()
  /// 	         5 : Return value from freq_make_btxt()
  /// 	         -1: Other error
  static Future<int> freqSet() async {
    int i, j, k, j2;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxCommonBuf pCom = xRet.object;
    Result dataList1, dataList2;

    try {
      // DBサーバーへの接続
      var db = DbManipulationPs();
      //Query
      // 項目リストを取得.
      String sql = FreqDefine.FREQ_SQL_GET_FINIT_GRP_RECS;
      dataList1 = await db.dbCon.execute(sql);
      if (dataList1.isEmpty) {
        TprLog().logAdd(
            FREQ_LOG,
            LogLevelDefine.error,
            'freqSet(): DB error '
                'c_finit_grp_mst query FREQ_SQL_GET_FINIT_GRP_RECS error \n',
            errId: -1);
        return -1;
      }
      mItemNum = dataList1.length;
      if (mItemNum < 1) {
        String logBuf = "freqSet(): c_finit_grp_mst "
            "query FREQ_SQL_GET_FINIT_GRP_RECS result $mItemNum recs \n";
        TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, logBuf, errId: -1);
        return -1;
      }

      crItem = List<btData>.generate(mItemNum, (index) => btData());
      // 各項目の内容取得
      k = 0;
      for (i = 0; i < mItemNum; i++) {
        Map<String, dynamic> data1 = dataList1[i].toColumnMap();
        int nDspChkNum = 0;

        //Query
        int nFinitGrpCd = int.tryParse(data1['finit_grp_cd']) ?? 0;
        String logBuf = "freqSet(): c_finit_grp_mst "
            "query: FinitGrpCd = $nFinitGrpCd \n";
        TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, logBuf, errId: 0);

        if (freqCallMode == Rxsys.RXSYS_MSG_FINIT.id) {
          // ファイル初期設定 時
          sql = sprintf(FreqDefine.FREQ_SQL_GET_FINIT_RECS, [nFinitGrpCd]);
        } else {
          if (pCom.rmstInfo.rmstFreq != 0) {
            sql =
                sprintf(FreqDefine.FREQ_SQL_GET_RMST_FREQ_RECS, [nFinitGrpCd]);
          } else {
            // ファイルリクエスト／データ吸い上げ 時
            sql = sprintf(FreqDefine.FREQ_SQL_GET_FREQ_RECS, [nFinitGrpCd]);
          }
        }

        try {
          dataList2 = await db.dbCon.execute(sql);
        } catch (e) {
          if (freqCallMode == Rxsys.RXSYS_MSG_FINIT.id) {
            logBuf = "freqSet(): DB error "
                "c_finit_mst query FREQ_SQL_GET_FINIT_RECS error \n";
          } else if (pCom.rmstInfo.rmstFreq != 0) {
            logBuf = "freqSet(): DB error "
                "c_finit_mst query FREQ_SQL_GET_RMST_FREQ_RECS error \n";
          } else {
            logBuf = "freqSet(): DB error "
                "c_finit_mst query FREQ_SQL_GET_FREQ_RECS error \n";
          }
          TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, logBuf, errId: -1);
          return -1;
        }

        int nTblNum = dataList2.length;
        if (nTblNum != 0) {
          logBuf = "freqSet(): c_finit_mst query: "
              "Group ${data1['finit_grp_name']} recs $nTblNum  \n";
          TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, logBuf, errId: 0);

          //このグループの表示／非表示チェック.
          // 一つでも表示対象のテーブルがあれば表示.
          for (j = 0; j < nTblNum; j++) {
            Map<String, dynamic> data2 = dataList2[j].toColumnMap();
            int dspChk = data2['dsp_chk_div'];
            String tblName = "${data2['set_tbl_name']}";
            if ((tblName == "c_passport_info_mst") &&
                (freqCallMode != Rxsys.RXSYS_MSG_FINIT.id)) {
              TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                  "Frec/Finit: Dsp Chk force 999 for passport info",
                  errId: 2);
              dspChk = 999;
            }

            int chkRtn = await freqSetChk(dspChk);
            if (chkRtn != 0) {
              nDspChkNum++;
            }
          }
          logBuf = "freqSet(): c_finit_mst query: "
              "Group ${data1['finit_grp_name']} recs(available) $nDspChkNum  \n";
          TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, logBuf, errId: 0);

          if (nDspChkNum == 0) {
            k++;
            continue;
          }

          //(↓sec_name)
          crItem[i - k].labelName = "${data1['finit_grp_name']}";
        } else {
          logBuf =
          "db_PQntuples() c_finit_mst query: Group ${data1['finit_grp_name']} recs $nTblNum ";
          TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, logBuf, errId: 0);
          k++;
          continue;
        }

        /*------------------------------------------------------------------*/
        /* 項目の？？？設定													*/
        /*------------------------------------------------------------------*/
        crItem[i - k].no = i - k;
        crItem[i - k].aFlg = false;
        /*------------------------------------------------------------------*/
        /* 項目のサブ項目数取得												*/
        /*------------------------------------------------------------------*/
        crItem[i - k].totalTbl = nDspChkNum;
        if (crItem[i - k].totalTbl == 0) {
          return (1);
        }
        crItem[i - k].data = List<tblData>.generate(
            crItem[i - k].totalTbl, (index) => tblData());
        /*------------------------------------------------------------------*/
        /* 項目のサブ項目のテーブル名取得									*/
        /*------------------------------------------------------------------*/
        j2 = 0;
        for (j = 0; j < nTblNum; j++) {
          Map<String, dynamic> data2 = dataList2[j].toColumnMap();
          int dspChk = data2["dsp_chk_div"];
          String tblName = data2["set_tbl_name"];
          if ((freqCallMode == Rxsys.RXSYS_MSG_FINIT.id) &&
              ((pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_9191) ||
                  (pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_NEW) ||
                  (pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_9194)) &&
              tblName == "c_recoginfo_mst") {
            TprLog().logAdd(FINIT_LOG, LogLevelDefine.error,
                "Finit: Dsp Chk force 999 for recog",
                errId: 2);
            dspChk = 999;
          }
          int chkRtn = await freqSetChk(dspChk);
          if (chkRtn == 0) {
            continue;
          }
          String? name = data2["disp_name"];
          if (name != null && name.isNotEmpty) {
            crItem[i - k].data[j2].tableName = name;
          } else {
            crItem[i - k].data[j2].tableName = data2["set_tbl_name"];
          }
          //(↓e_name)
          crItem[i - k].data[j2].eName = data2["set_tbl_name"];

          if ((freqCallMode != Rxsys.RXSYS_MSG_FINIT.id) &&
              (pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_9191)) {
            if (crItem[i - k].data[j2].eName == "c_trm_mst" ||
                (crItem[i - k].data[j2].eName == "c_keyopt_mst")) {
              crItem[i - k].data[j2].selFlg = true;
            }
          }

          //設定テーブル種類
          crItem[i - k].data[j2].setTblTyp = data2["set_tbl_typ"];

          //動作モード
          crItem[i - k].data[j2].freqOpeMode = data2["freq_ope_mode"];

          //オフラインチェックフラグ
          crItem[i - k].data[j2].offlineChkFlg = data2["offline_chk_flg"];

          //シーケンス名
          crItem[i - k].data[j2].seqName = data2["seq_name"];

          //センターサーバ接続時 リクエスト要否
          crItem[i - k].data[j2].freqCsrvCnctSkip =
          data2["freq_csrv_cnct_skip"];

          //センターサーバ接続＋顧客リアル時 リクエスト要否
          crItem[i - k].data[j2].freqCsrcCustRealSkip =
          data2["freq_csrc_cust_real_skip"];

          //センターサーバ接続時 固定キーワード
          crItem[i - k].data[j2].freqCsrvCnctKey = data2["freq_csrv_cnct_key"];

          //センターサーバ接続後 他店舗データ削除
          crItem[i - k].data[j2].freqCsrvDelOthStre =
          data2["freq_csrv_del_oth_stre"];

          //データ取得先サーバ区分
          crItem[i - k].data[j2].svrDiv = data2["svr_div"];

          //初期設定値保持ファイル名
          crItem[i - k].data[j2].defaultFileName = data2["default_file_name"];
          j2++;
        }
      }

      mItemNum -= k;
    } catch (e, s) {
      TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, "freqSet() err $e $s",
          errId: -1);
    }

    freqMakePage();
    return 0;
  }

  /// 表示条件判定。条件番号に応じ、承認・設定等のチェックを行う。
  /// 関連tprxソース: freq.c - freq_set_chk
  /// 引数：条件番号
  /// 戻値：1 表示許可、0 表示不許可
  static Future<int> freqSetChk(int chkNo) async {
    int rtn = 1;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    switch (chkNo) {
      case 1:
      /* クレジット仕様 */
        if (await CmCksys.cmCrdtSystem() == 0) {
          return 0;
        }
        break;
      case 2:
      /* 顧客 */
        rtn = 0; // cm_mbr_system(NULL)の値は必ず0のため
        break;
      case 3:
      /* 顧客ＦＳＰ仕様 */
        if (0 & CmMbrSys.MBR_STAT_FSP != CmMbrSys.MBR_STAT_FSP) {
          rtn = 0;
        }
        break;
      case 4:
      /* 顧客ポイント仕様 */
        if (0 & CmMbrSys.MBR_STAT_POINT != CmMbrSys.MBR_STAT_POINT) {
          rtn = 0;
        }
        break;
      case 5:
      /* 特定ＦＴＰ送信仕様 */ /* 生産者商品自動ﾒﾝﾃﾅﾝｽ仕様 */
        if ((await CmCksys.cmJasaitamaSystem() == 0) &&
            (await CmCksys.cmProdItemAutoSystem() == 0)) {
          rtn = 0;
        }
        break;
      case 6:
      /* ネットワークプリンター仕様 */
        if ((await Recog().recogGet(Tpraid.TPRAID_FREQ,
            RecogLists.RECOG_NETWORK_PRN, RecogTypes.RECOG_GETSYS))
            .result ==
            RecogValue.RECOG_NO) {
          rtn = 0;
        }
        break;
      case 7:
      /* Ｍカード仕様 */
        if ((await Recog().recogGet(Tpraid.TPRAID_FREQ,
            RecogLists.RECOG_MCSYSTEM, RecogTypes.RECOG_GETSYS))
            .result ==
            RecogValue.RECOG_NO) {
          rtn = 0;
        }
        break;
      case 8:
      /* M or BS ﾚｼﾞ(FTP通信/CD関連) */
      // MMシステムは実装対象外のため
      // if(( cm_mm_type() == MacS ) || ( cm_mm_type() == MacMOnly )){
      //   rtn = 0;
      // }
      // if ((rtn) && ((cm_mm_type() == MacM1) || (cm_mm_type() == MacM2))) {
      //   datarestor_rtn =
      //       freq_datarestor_log_chk(FREQ_LOG, data_restor_exec_flg3);
      //   if ((datarestor_rtn == 0) /* クイック再セットアップのファイルリクエスト */
      //       ||
      //       (datarestor_rtn == 2) /* クイック再セットアップのデータ吸い上げで当日のみ */
      //       ||
      //       (datarestor_rtn == 3)) /* クイック再セットアップのデータ吸い上げでなし */ {
      //     rtn = 0;
      //   }
      // }
        break;
      case 9:
      /* メモ */
        break;
      case 10:
      /* M or BS ﾚｼﾞ(Mﾚｼﾞﾊﾞｯｸｱｯﾌﾟ関連) */
      // MMシステムは実装対象外のため
      // if(( cm_mm_type() == MacS ) || ( cm_mm_type() == MacMOnly ) || ( cm_mm_type() == MacERR )){
      //   rtn = 0;
      // }
        if ((dataRestorExecFlg3 == 1) || (dataRestorExecFlg3 == 2)) {
          rtn = 0;
        }
        break;
      case 11:
      /* ＴＳ接続のみ表示 */
      // MMシステムは実装対象外のため
      // if( cm_mm_system( ) == 1 ){
      //   rtn = 0;
      // }
        break;
      case 12:
      /* 顧客（顧客ﾛｺﾞ関連） */
      // cm_mbr_systemの条件式は必ずtrueになるため
      // if( ( cm_mbr_system(NULL) == 0 ) || ( cm_sugi_system( ) != 0 ) ){
        rtn = 0;
        // }
        break;
      case 13:
      /* SSPS時のみ表示 */
        if (!CompileFlag.SSPS_ONLY) {
          rtn = 0;
        } else {
          if (CompileFlag.SEGMENT) {
            if (pCom.dbRegCtrl.setOwnerFlg > 0) {
              /* マルチセグメント 	*/
              if (await CmCksys.cmQcashierSelfSystem() == 0) {
                rtn = 0;
              }
            }
          }
        }
        break;
      case 22:
      /* 顧客（顧客ﾛｺﾞ関連）スギ仕様 */
      // cm_mbr_systemの条件式は必ずtrueになるため
      // if( ( cm_mbr_system(NULL) == 0 ) || ( cm_sugi_system( ) == 0 ) ){
        rtn = 0;
        // }
        break;
      case 23:
      /* Tuoｶｰﾄﾞ仕様 & M/S仕様			*/
        if ((CmCksys.cmMmSystem() == 0) ||
            ((await Recog().recogGet(
                Tpraid.TPRAID_FREQ,
                RecogLists.RECOG_TUOCARDSYSTEM,
                RecogTypes.RECOG_GETSYS))
                .result ==
                RecogValue.RECOG_NO)) {
          rtn = 0;
        }
        break;
      case 24:
      /* マルチセグメント */
        if (CompileFlag.SEGMENT) {
          if (!(pCom.dbRegCtrl.setOwnerFlg > 0)) {
            rtn = 0;
          }
        } else {
          rtn = 0;
        }
        break;
      case 25:
      /* 収納代行仕様 */
        if (await CmCksys.cmPbchgSystem() == 0) {
          rtn = 0;
        }
        break;
      case 26:
      /* ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様 */
        if (await CmMbrSys.cmCustrealNetdoaSystem() == false) {
          rtn = 0;
        }
        break;
      case 27:
      /* 24時間仕様 */
        if (CmCksys.cmMmSystem() == 0) {
          rtn = 0;
        }
        // MMシステムは実装対象外のため
        // else if ( (cm_mm_system( ) != 0) && ( cm_24hour_system( ) == 0)) {
        //   rtn = 0;
        // }
        break;
      case 28:
      /* Tポイント仕様 */
        if (CmCksys.cmCustrealTpointSystem() == 0) {
          rtn = 0;
        }
        break;
    // クイック再セットアップ対応
      case 29:
      /* spec_bkup MS(連鎖) M or BS */
      // クイックセットアップ及びMMシステムは実装対象外のため
      // if ((cm_mm_type () == MacS) || (cm_mm_type () == MacMOnly) || (cm_mm_type() == MacERR))
      // {
      //   rtn = 0;
      // }
      // // spec_bkup保存先IPアドレスが設定されている場合、スペックバックアップ関連を非表示にする
      // memset (bkup_save_ip, 0x00, sizeof (bkup_save_ip));
      // if (AplLib_GetHostsIPAddr(TPRAID_QUICK_RESETUP, "bkup_save" , bkup_save_ip ) == OK)	// spec_bkup保存先IPアドレスが設定されている
      //     {
      //   if (strncmp(bkup_save_ip, "0.0.0.0",7) != 0) 					// spec_bkup保存先IPアドレスが"0.0.0.0"でない
      //       {
      //     rtn = 0;
      //   }
      // }
        break;
    // クイック再セットアップ対応(除外項目)
      case 30:
      /* 自動開閉設関連 */
      // クイックセットアップは実装対象外のため
      // if ((data_restor_exec_flg3 == 1)
      //     || (data_restor_exec_flg3 == 2))
      // {
      //   rtn = 0;
      // }
        break;
      case 33:
      /* dポイント仕様 */
        if (await CmCksys.cmDpointSystem() == 0) {
          rtn = 0;
        }
        break;
      case 34:
      /* 楽天ポイント仕様 */
        if (await CmCksys.cmRpointSystem() == 0) {
          rtn = 0;
        }
        break;
      case 35:
      /* 標準Tポイント仕様 */
        if (await CmCksys.cmTpointSystem() == 0) {
          rtn = 0;
        }
        break;
      case 36:
      /* 顧客リアルダミーシステム */
        if (await CmCksys.cmCustrealDummySystem() == 0) {
          rtn = 0;
        }
        break;
      case 37:
      /* トイザらス様 */
        if (await CmCksys.cmToySystem() == 0) {
          rtn = 0;
        }
        break;
      case 100:
      /* ＴＳ接続 */
        if (CmCksys.cmMmSystem() == 0) {
          rtn = 0;
        }
        break;
      case 104:
      /* ＴＳ接続＋ポイント */
        if ((CmCksys.cmMmSystem() == 0) ||
            ((0 & CmMbrSys.MBR_STAT_POINT) != CmMbrSys.MBR_STAT_POINT)) {
          rtn = 0;
        }
        break;
      case 113:
      /* ＭＳ仕様＋顧客ＦＳＰ仕様 */
        if ((CmCksys.cmMmSystem() == 0) ||
            ((0 & CmMbrSys.MBR_STAT_FSP) != CmMbrSys.MBR_STAT_FSP)) {
          rtn = 0;
        }
        break;
      case 115:
      /* ＴＳ接続 */
        if (CmCksys.cmMmSystem() == 0) {
          rtn = 0;
        }
        // クイックセットアップ及びMMシステムは実装対象外のため
        // #if SEGMENT
        // if( pCom->db_regctrl.set_owner_flg == 0 )
        //   #endif
        // {	/* マルチセグメントではない */
        //   if ((rtn)
        //       && ((cm_mm_type() == MacM1)
        //           || (cm_mm_type() == MacM2)
        //           || (cm_mm_type() == MacS)))
        //   {
        //     datarestor_rtn = freq_datarestor_log_chk(FREQ_LOG,data_restor_exec_flg3);
        //     if ((datarestor_rtn == 0)	/* クイック再セットアップのファイルリクエスト */
        //         || (datarestor_rtn == 3))	/* クイック再セットアップのデータ吸い上げでなし */
        //     {
        //       rtn = 0;
        //     }
        //   }
        // }
        break;
      case 123:
      /* ＴＳ接続＋顧客ＦＳＰ仕様 */
        if ((CmCksys.cmMmSystem() == 1) ||
            (0 & CmMbrSys.MBR_STAT_FSP != CmMbrSys.MBR_STAT_FSP)) {
          rtn = 0;
        }
        break;
      case 200:
      /* 吸い上げ */
        if (CmCksys.cmMmSystem() == 0 ||
            freqCallMode != Rxsys.RXSYS_MSG_FREQS.id) {
          rtn = 0;
        }
        break;
      case 202:
      /* 吸い上げ＋顧客 */
        if (CmCksys.cmMmSystem() == 0 ||
            freqCallMode != Rxsys.RXSYS_MSG_FREQS.id) {
          // || ( cm_mbr_system(NULL) == 0 )){  必ず0になるので除外
          rtn = 0;
        }
        break;
      case 203:
      /* 吸い上げ＋ＦＳＰ */
        if ((CmCksys.cmMmSystem() == 0) ||
            (freqCallMode != Rxsys.RXSYS_MSG_FREQS.id) ||
            ((0 & CmMbrSys.MBR_STAT_FSP) != CmMbrSys.MBR_STAT_FSP)) {
          rtn = 0;
        }
        break;
      case 204:
      /* 吸い上げ＋ポイント */
        if ((CmCksys.cmMmSystem() == 0) ||
            (freqCallMode != Rxsys.RXSYS_MSG_FREQS.id) ||
            ((0 & CmMbrSys.MBR_STAT_POINT) != CmMbrSys.MBR_STAT_POINT)) {
          rtn = 0;
        }
        break;
      case 205:
      /* 吸い上げ＋予約仕様 */
        if (CompileFlag.RESERV_SYSTEM) {
          if ((CmCksys.cmMmSystem() == 0) ||
              (freqCallMode != Rxsys.RXSYS_MSG_FREQS.id) ||
              ((!(await CmCksys.cmReservSystem() == 1)) &&
                  (await CmCksys.cmNetDoAreservSystem() == 0))) {
            rtn = 0;
          }
        } else {
          rtn = 0;
        }
        break;
      case 206:
      /* 吸い上げ＋収納代行仕様 */
        if ((CmCksys.cmMmSystem() == 0) ||
            (freqCallMode != Rxsys.RXSYS_MSG_FREQS.id) ||
            (await CmCksys.cmPbchgSystem() == 0)) {
          rtn = 0;
        }
        break;
      case 207: // SPQC Master or Sub Server System
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // memo: hosts.jsonより、SPQC_SUBSVR_IPADRに該当するIPアドレスが0.0.0.0
      // で指定されているため、判定を実装するまではrtn = 0を設定する。

      // サブのIPアドレスが 0.0.0.0 で無く, かつ, 自レジがMasterかSubの場合に表示
      // if(   (AplLib_HostsCmp(FREQ_LOG, SPQC_SUBSVR_IPADR, ZERO_IPADDR) == 0)
      //     || ((AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_IPADR) != 0) && (AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_SUBSVR_IPADR) != 0)) )
      // {
        rtn = 0;
        // }
        break;

      case 208:
      /* QCashier仕様がON、または自レジがお会計券管理サーバかサブサーバと
                   同IPの場合に表示。ただしサーバとサブが両方自レジと同じ場合は非表示 */
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // memo: hosts.josonよりSPQC_IPADRとSPQC_SUBSVR_IPADRのIPアドレスが0.0.0.0
      // のため自レジとは一致しない。
      // 判定分を正式に実装するまではQCashierシステムか否かで判定する。

        if (await CmCksys.cmQCashierSystem() == 0) // &&
          //     ((AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_IPADR) != 0) &&
          //         (AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_SUBSVR_IPADR) != 0)))
          // ||
          // ((AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_IPADR) == 0) &&
          //     (AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_SUBSVR_IPADR) == 0)))
            {
          rtn = 0;
        }
        // クイックセットアップは実装対象外のため
        //   if(pCom->quick_flg == QUICK_SETUP_TYPE_NEW)
        //   {
        // TprLibLogWrite(
        //     FREQ_LOG, TPRLOG_NORMAL, 0, "quick setup force nodisp 208");
        //     rtn = 0;	// 非表示
        //   }
        //
        //   if ((data_restor_exec_flg3 == 1)
        //       || (data_restor_exec_flg3 == 2))
        //   {
        // TprLibLogWrite(
        //     FREQ_LOG, TPRLOG_NORMAL, 0, "quick data_restor force nodisp 208");
        //     rtn = 0;
        //   }
        break;
      case 209:
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // memo: hosts.jsonより、SPQC_IPADRに該当するIPアドレスが0.0.0.0
      // で指定されているため、判定を実装するまではrtn = 0を設定する。

      /* お会計券管理のIPアドレスが 0.0.0.0 の場合, もしくは,
                   自レジがお会計券管理サーバーでサブのIPアドレスが 0.0.0.0 の場合に
                   非表示(どちらも取得先が存在しないため) */
      // if ((AplLib_HostsCmp(FREQ_LOG, SPQC_IPADR, ZERO_IPADDR) == 0) ||
      //     ((AplLib_ChkOneselfHosts(FREQ_LOG, SPQC_IPADR) == 0) &&
      //         (AplLib_HostsCmp(FREQ_LOG, SPQC_SUBSVR_IPADR, ZERO_IPADDR) == 0)))
      // {
        rtn = 0; // 非表示
        // }

        // クイックセットアップは実装対象外のため
        // if (pCom->quick_flg == QUICK_SETUP_TYPE_NEW) {
        //   TprLibLogWrite(
        //       FREQ_LOG, TPRLOG_NORMAL, 0, "quick setup force nodisp 209");
        //   rtn = 0; // 非表示
        // }
        break;
      case 210:
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // memo: hosts.jsonより、SPQC_IPADR及びSPQC_SUBSVR_IPADRに該当するIPアドレスが
      // 0.0.0.0で指定されているため、判定を実装するまではrtn = 0を設定する。

      // お会計券サーバー・お会計券サブサーバー どちらにも、
      // 自レジのIPが設定されていなければ表示しない (同一の場合0)
      // if ((AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_IPADR) != 0)
      //     &&  (AplLib_ChkOneselfHosts(TPRAID_STR, SPQC_SUBSVR_IPADR) != 0))
      // {
        rtn = 0; // 非表示
        // }
        break;
      case 211:
      /* カラー客表接続でない */
        break;
    // #if SS_CR2
    // //特定CR2接続仕様
    // case 212:
    //   if (cm_CR_NSW_data_system () == 0)
    //   {
    //   rtn = 0;	//非表示
    //   }
    // break;
    // #endif
      case 213:
      /* Shop&Go仕様 */
        if (await CmCksys.cmShopAndGoSystem() == 0) {
          rtn = 0; //非表示
        }
        break;
    // #if SS_CR2
    // //特定CR2接続仕様 かつ QCashier.iniの"支払い機マネージャー経由で取得したレシートロゴを利用=する"
    // case 214:
    //   chk = AplLib_Cr2UpdateReceiptCheck (FREQ_LOG);
    //   if ((chk == -2)		// サンドラッグ様仕様でない
    //       ||  (chk == -1))		// ロゴ更新しない
    //       {
    //     rtn = 0;	//非表示
    //   }
    //   break;
    // #endif

    //クイック再セットアップ対応(除外項目)
    // Ver14ではcase 210:
    // /* 累計実績(“M or BS ﾚｼﾞ”かつ　実績ログ“当日”　かつ　データ吸い上げ) */
      case 215:
      /* 累計実績(“M or BS ﾚｼﾞ”かつ　実績ログ“当日”　かつ　データ吸い上げ) */
        if ((CmCksys.cmMmSystem() == 0) ||
            (freqCallMode != Rxsys.RXSYS_MSG_FREQS.id)) {
          rtn = 0;
        }
        // MMシステムは実装対象外のため
        // if ((rtn)
        //     && ((cm_mm_type() == MacM1)
        //         || (cm_mm_type() == MacM2)))
        // {
        //   datarestor_rtn = freq_datarestor_log_chk(FREQ_LOG,data_restor_exec_flg3);
        //   if ((datarestor_rtn == 0)	/* クイック再セットアップのファイルリクエスト */
        //       || (datarestor_rtn == 2)	/* クイック再セットアップのデータ吸い上げで当日のみ */
        //       || (datarestor_rtn == 3))	/* クイック再セットアップのデータ吸い上げでなし */
        //   {
        //     rtn = 0;
        //   }
        // }
        break;
      case 301:
      /* ファイル初期設定のcase 1 */
      // MMシステムは実装対象外のため
      // if (( cm_mm_type() == MacS )
      //     || ( cm_mm_type() == MacERR ))
      // {
      //   rtn = 0;
      // }
        break;
      case 302:
      /* ファイル初期設定のcase 2 */
        if ((CmCksys.cmMmSystem() == 0) ||
            ((await Recog().recogGet(FINIT_LOG, RecogLists.RECOG_TUOCARDSYSTEM,
                RecogTypes.RECOG_GETSYS))
                .result ==
                RecogValue.RECOG_NO)) {
          rtn = 0;
        }
        break;
      case 303:
      /* ファイル初期設定のcase 3 */
      // #if 0
      // if (!cm_chk_quick_rsv_system())
      // {
      // rtn = 0;
      // }
      // #endif
        break;
      case 304:
      /* ファイル初期設定のcase 4 */
        if (!CompileFlag.RESERV_SYSTEM) {
          rtn = 0;
        }
        break;
      case 305:
      /* ファイル初期設定のcase 5 */
        if (!(CmCksys.cmWeb2800System() == 1)) {
          rtn = 0;
        }
        break;
      case 306:
      /* ファイルリクエストの顧客ENQ関連 */
      // if( cm_mbr_system(NULL) == 0 ){
        rtn = 0;
        // }
        if (!(await CmCksys.cmSm66FrestaSystem() == 1)) {
          /* フレスタ様仕様でない */
          if (rtn == 1) {
            // MMシステムは実装対象外のため
            // if (( cm_mm_type() == MacS )
            //     || ( cm_mm_type() == MacERR ))
            // {
            //   rtn = 0;
            // }
          }
        }
        break;
      case 307:
      /* 酒税免税 */
        if (!(await CmCksys.cmLiqrTaxfreeSystem() == 1)) {
          rtn = 0;
        }
        break;
      case 308:
      /* 区分マスタ２ */
        if (!(await CmCksys.cmSm66FrestaSystem() == 1)) {
          rtn = 0;
        }
        break;
      case 309:
      /* ハッピースケール関連 */
        if (CmCksys.cmRm5900System() == 0) {
          // RM-3800以外は非表示とする
          rtn = 0;
        }
        break;
      case 999:
      /* 非表示 */
        rtn = 0;
        break;
    }
    return 1;
  }

  /// 関連tprxソース: freq.c - freq_previous
  static void freqPrevious() {
    /* check freq status */
    if (freqStatus != 0) {
      return;
    }
    TprLog().logAdd(
        FREQ_LOG, LogLevelDefine.fCall, "Freq: [Previous Page] button clicked");

    final FileRequestPageController ctrl = Get.find();
    int pageNumber = ctrl.dspPage;
    /* clear entry field */
    pageNumber -= 1;
    if (pageNumber == -1) {
      pageNumber = totalPage - 1;
    }
    freqDispPage(pageNumber);
  }

  /// 関連tprxソース: freq.c - freq_next
  static void freqNext() {
    TprLog().logAdd(
        FREQ_LOG, LogLevelDefine.fCall, "Freq: [Next Page] button clicked");

    /* check freq status */
    if (freqStatus != 0) {
      return;
    }
    final FileRequestPageController ctrl = Get.find();
    int pageNumber = ctrl.dspPage;
    pageNumber += 1;
    /* page number back to start */
    if (pageNumber == totalPage) {
      maxPageNum = 0;
    }
    freqDispPage(pageNumber);
  }

  /// 関連tprxソース: freq.c - freq_disp_page
  static void freqDispPage(int pgNo) {
    final FileRequestPageController ctrl = Get.find();
    if (pgNo < 0 || pgNo >= totalPage) {
      pgNo = 0; //
    }

    String title = "";
    if (freqCallMode == Rxsys.RXSYS_MSG_FREQS.id) {
      title = LFreq.TITLE_MM;
    } else if (freqCallMode == Rxsys.RXSYS_MSG_FINIT.id) {
      title = LFreq.TITLE_FINIT;
    } else {
      title = LFreq.TITLE;
    }
    ctrl.pageTitle.value = sprintf("$title %d/%d", [pgNo + 1, totalPage]);
    ctrl.dspPage = pgNo;
    ctrl.dispData.value = ctrl.pageData[ctrl.dspPage].groupList;
    ctrl.dispData.refresh();
  }

  /// 関連tprxソース: freq.c - freq_select_all
  static void freqSelectAll() {
    final FileRequestPageController ctrl = Get.find();
    bool afterSelect = !allselectFlg;
    for (int i = 0; i < mItemNum; i++) {
      freqSelectGroup(crItem[i], afterSelect);
    }
    allselectFlg = afterSelect;
    ctrl.dispData.refresh();
  }

  /// 関連tprxソース: freq.c - freq_select_item
  static void freqSelectGroup(btData btData, bool select,
      {bool allCheck = false}) {
    final FileRequestPageController ctrl = Get.find();
    btData.aFlg = select;
    for (var table in btData.data) {
      // 所属テーブルを無効化.
      table.selFlg = select;
    }
    if (allCheck) {
      bool isAllFlg = true;
      for (int i = 0; i < mItemNum; i++) {
        isAllFlg &= crItem[i].aFlg;
        if (!isAllFlg) {
          break;
        }
      }
      allselectFlg = isAllFlg;
    }

    ctrl.dispData.refresh();
  }

  /// 関連tprxソース: freq.c - btn_tbl_clicked
  static void freqSelectTable(tblData tblData, bool select) {
    final FileRequestPageController ctrl = Get.find();
    tblData.selFlg = select;

    bool isAllTrue = true;
    for (int i = 0; i < mItemNum; i++) {
      bool isGroupAll = true;
      for (var table in crItem[i].data) {
        isGroupAll &= table.selFlg;
        if (!isGroupAll) {
          break;
        }
      }
      crItem[i].aFlg = isGroupAll;
      isAllTrue &= crItem[i].aFlg;
    }
    allselectFlg = isAllTrue;
    ctrl.dispData.refresh();
  }

  /// １pページに表示できるようにデータを分割している
  /// 関連tprxソース: freq.c - freq_make_page
  static void freqMakePage() {
    final FileRequestPageController ctrl = Get.find();
    ctrl.pageData.clear();
    // 1ページは最高14行として、※2行で1行とする.
    // 一旦
    int rowNum = 0;
    // 1ページ目.
    FReqPageData page = FReqPageData();
    for (int i = 0; i < mItemNum; i++) {
      btData itm = crItem[i];
      // グループ.
      if (rowNum > PG_MAX_LINE) {
        ctrl.pageData.add(page);
        page = FReqPageData();
        rowNum = 0;
      }

      FReqGroupData group = FReqGroupData(itm);
      page.groupList.add(group);

      for (var tbl in itm.data) {
        if (rowNum > PG_MAX_LINE) {
          // TODO:単純に17行にしてしまう.
          // 次のページへ.
          ctrl.pageData.add(page);
          page = FReqPageData();

          rowNum = 0;
          group = FReqGroupData(itm);
          page.groupList.add(group);
        }
        group.tableData.add(tbl);
        rowNum++;
      }
    }
    ctrl.pageData.add(page);
    totalPage = ctrl.pageData.length;
  }

  /// ファイルリクエストが実行可能かチェックを行う。
  /// 実行できない場合は必要に応じエラーダイアログを表示して終了する。
  /// 実行できる場合は実行確認ダイアログを表示する。
  /// 関連tprxソース: freq.c - freq_execute
  /// 引数：なし
  /// 戻値：なし
  static void freqExecute() {
    int selectFlg = 0;
    int iLoop;
    int jLoop;

    TprLog().logAdd(
        FREQ_LOG, LogLevelDefine.fCall, "Freq: [Execute] button clicked");

    // check dialog flag
    if (freqDlg == 1 || freqEflg == 1) {
      return;
    }
    // check freq status
    if (freqStatus != 0) {
      return;
    }

    // 選択中の項目が存在しない場合はダイアログ「項目を指定してください」を表示
    // check selected item
    for (iLoop = 0; iLoop < mItemNum; iLoop++) {
      if (crItem[iLoop].aFlg == true) {
        selectFlg = 1;
        break;
      } else {
        for (jLoop = 0; jLoop < crItem[iLoop].totalTbl; jLoop++) {
          if (crItem[iLoop].data[jLoop].selFlg == true) {
            selectFlg = 1;
            break;
          }
        }
      }
    }

    /* return for all item unselected */
    if (selectFlg == 0) {
      MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          title: LFreq.UNSELECT,
          dialogId: DlgConfirmMsgKind.MSG_APPOINT.dlgId));
      return;
    }

    // ダイアログ「実行します。よろしいですか？」を表示
    MsgDialog.show(MsgDialog.twoButtonDlgId(
      dialogId: DlgConfirmMsgKind.MSG_EXECCONF.dlgId,
      type: MsgDialogType.info,
      leftBtnFnc: () {
        freqDlg = 0;
        Get.back();
      },
      leftBtnTxt: "キャンセル",
      rightBtnFnc: () {
        if (freqCallMode == Rxsys.RXSYS_MSG_FINIT.id) {
          // ファイル初期設定実行
          fInitExecConf();
        } else {
          // ファイルリクエスト実行
          freqExecYes();
        }
        Get.back();
      },
      rightBtnTxt: "実行",
    ));

    /* set dialog flag */
    freqDlg = 1;
  }

  /// 関連tprxソース: freq.c - freq_dlg_flg_clr
  static void freqDlgFlgClr() {
    /* remove timer */
    if (freqDlgtimer != 0) {
      Fb2Gtk.gtkTimeoutRemove(freqDlgtimer);
      freqDlgtimer = 0;
    }

    /* set freq_dlg */
    freqDlg = 0;
  }

  /// 関連tprxソース: freq.c - freq_exec_conf
  static Future<void> freqExecConf() async {
    TprLog()
        .logAdd(FREQ_LOG, LogLevelDefine.fCall, "Freq: Enter freq_exec_conf.");

    /*======================================================================*/
    /* タイマー処理廃止														*/
    /*======================================================================*/
    /* remove timer */
    if (freqPtimer != 0) {
      Fb2Gtk.gtkTimeoutRemove(freqPtimer);
      freqPtimer = 0;
    }

    /* Reset freq status to prepare error return */
    freqStatus = 0;

    /* サーバーによる分岐処理は行わず企業、店舗妥当性チェックは実際のファイルリクエスト時に行うため、置き換え不要
    /*======================================================================*/
    /* ＤＢ接続																*/
    /*======================================================================*/
    /* connect TPR_DB (local DB) */
    conTPR = db_TprLogin( FREQ_LOG, DB_ERRLOG );

    /* Local DB access error */
    if( conTPR == NULL ){
      TprLibLogWrite( FREQ_LOG,-1,-1, "Freq: db_TprLogin return error\n");

      memset( &param_er, 0x00, sizeof( tprDlgParam_t ));
      param_er.er_code    = MSG_FILEACCESS;
      param_er.dialog_ptn = TPRDLG_PT4;
      param_er.title      = FREQ_ERR_TITLE;
      param_er.user_code  = 13;
      TprLibDlg( &param_er );

      /* set error flag */
      freq_eflg = 1;

      /* set db access error flag */
      freq_dbflg = 1;

      return;
    }

    MacType = cm_mm_type( );
    memset( freq_target, 0, sizeof(freq_target) );
    switch( MacType ){
      case MacM1 :    strcat( freq_target, "BS" ); break;
      case MacM2 :    strcat( freq_target, "M" ); break;
  #if SEGMENT
      case MacMOnly : strcat( freq_target, "BS" ); break;
  #endif
      default :       strcat( freq_target, "TS" ); break;
    }

    if( cm_CenterServer_system( ) ){ /* center server system */
      if( freq_cnct_svr ) {   /* connect center server */
        memset( freq_target, 0, sizeof(freq_target) );
        strcat( freq_target, "CenterServer" );
      }
    }
    snprintf( erlog, sizeof(erlog), "Freq: Target Server[%s] ", freq_target );
    TprLibLogWrite( FREQ_LOG, TPRLOG_NORMAL, 0, erlog );

  //選択レコードのうち、サブサーバへのリクエスト数／ＳＩＭＳへのリクエスト数を調べる
    for( i = 0 ; i < m_item_num ; i++ )
    {
      for(j = 0; j <= cr_item[i].total_tbl - 1; j++){
        if(cr_item[i].data[j].sel_flg == 1){
          selItmNum_total++;
          if(cr_item[i].data[j].offline_chk_flg == 1){
            selItmNum_Conn_SubSvr++;
          }
          else if(cr_item[i].data[j].offline_chk_flg == 2){
            selItmNum_Conn_SIMS++;
          }
        }
      }
    }
  //printf("selItmNum_total=%d / selItmNum_Conn_SubSvr=%d / selItmNum_Conn_SIMS=%d\n", selItmNum_total, selItmNum_Conn_SubSvr, selItmNum_Conn_SIMS);
    memset( ini_file, 0x00, sizeof(ini_file));
    sprintf( ini_file, "%s/%s", FreqHomeDirp, FTP_INI_FILE );
    if( TprLibGetIni( ini_file, SIMS2100_NAME, "name", l_fqhostname ) != 0 )
    {
      TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0, "Freq : freq_exec_conf() : get SIMS2100_NAME error!!" );
      conn_SIMS_err_flg = 1;
    }

    /* connect SR_DB */
  #if 0
  /* 2002/03/01 H.Sakamoto >>> */
  //  conSR = db_SrLogin( 0, DB_ERRLOG );
    if(cm_mm_system( )){            /* MM System */
        if( cm_CenterServer_system( ) ){ /* center server system */
          if( freq_cnct_svr ) {   /* connect center server */
  #if 0
              memset( ip_addr, 0, sizeof(ip_addr) );
              ret = AplLib_GetHostsIPAddr( FREQ_LOG, CSRV_MST_NAME, ip_addr );
              if( ret == OK ) {
                conSR = db_CSrLogin( FREQ_LOG, DB_ERRLOG, ip_addr );
              }
              else {
                conSR = NULL;
              }
  #endif
              conSR = db_CSrLogin( FREQ_LOG, DB_ERRLOG, pCom->ini_sysparam.csvr_mst_ip );
          }
          else {   /* M/S System */
              if(( MacType == MacM1 )
  #if SEGMENT
                || (MacType == MacMOnly)
  #endif
              ){       /* Master */
                conSR = db_SubLogin( FREQ_LOG, DB_ERRLOG ); /* Sub Server Login */
              }
              else{
                conSR = db_SrLogin( FREQ_LOG, DB_ERRLOG ); /* Master Server Login */
              }
          }
        }
        else {
          if(( MacType == MacM1 )
  #if SEGMENT
              || (MacType == MacMOnly)
  #endif
          ){       /* Master */
              conSR = db_SubLogin( FREQ_LOG, DB_ERRLOG );
                                    /* Sub Server Login */
          }
          else{
              conSR = db_SrLogin( FREQ_LOG, DB_ERRLOG );
                                    /* Master Server Login */
          }
        }
    }
    else{
        conSR = db_SrLogin( FREQ_LOG, DB_ERRLOG );
    }
  /* 2002/03/01 <<< H.Sakamoto */
  #endif
    if(cm_mm_system( )){            /* MM System */
        if( cm_CenterServer_system( ) ){ /* center server system */
          if( freq_cnct_svr ) {   /* connect center server */
              if(selItmNum_Conn_SubSvr > 0){
                conSR = db_CSrLogin( FREQ_LOG, DB_ERRLOG, pCom->ini_sysparam.csvr_mst_ip );
              }
              if(selItmNum_Conn_SIMS > 0 && conn_SIMS_err_flg == 0){
                ret = AplLib_GetHostsIPAddr( FREQ_LOG, l_fqhostname, ip_addr[0] );
                if(ret != OK){
                  conn_SIMS_err_flg =1;
                }
              }
          }
          else {   /* M/S System */
              if(selItmNum_Conn_SubSvr > 0){
                if(( MacType == MacM1 )
  #if SEGMENT
                  || (MacType == MacMOnly)
  #endif
                ){       /* Master */
                  conSR = db_SubLogin( FREQ_LOG, DB_ERRLOG ); /* Sub Server Login */
                }
                else{
                  conSR = db_SrLogin( FREQ_LOG, DB_ERRLOG ); /* Master Server Login */
                }
              }
              if(selItmNum_Conn_SIMS > 0 && conn_SIMS_err_flg == 0){
                ret = AplLib_GetHostsIPAddr( FREQ_LOG, l_fqhostname, ip_addr[0] );
                if(ret != OK){
                  conn_SIMS_err_flg =1;
                }
              }
          }
        }
        else {
        if(selItmNum_Conn_SubSvr > 0){
            if(( MacType == MacM1 )
  #if SEGMENT
              || (MacType == MacMOnly)
  #endif
            ){       /* Master */
              conSR = db_SubLogin( FREQ_LOG, DB_ERRLOG );
                                    /* Sub Server Login */
            }
            else{
              conSR = db_SrLogin( FREQ_LOG, DB_ERRLOG );
                                    /* Master Server Login */
            }
          }
          if(selItmNum_Conn_SIMS > 0 && conn_SIMS_err_flg == 0){
            ret = AplLib_GetHostsIPAddr( FREQ_LOG, l_fqhostname, ip_addr[0] );
            if(ret != OK){
              conn_SIMS_err_flg =1;
            }
          }

        }
    }
    else{
      if(selItmNum_Conn_SubSvr > 0){
        conSR = db_SrLogin( FREQ_LOG, DB_ERRLOG );
      }
      if(selItmNum_Conn_SIMS > 0 && conn_SIMS_err_flg == 0){
        ret = AplLib_GetHostsIPAddr( FREQ_LOG, l_fqhostname, ip_addr[0] );
        if(ret != OK){
          conn_SIMS_err_flg =1;
        }
      }
    }

    /* DB server connection error */
  //  if(conSR == NULL ){
    if( (conSR == NULL && conn_SIMS_err_flg == 1)
        || (selItmNum_Conn_SubSvr != 0 && selItmNum_Conn_SIMS == 0 && conSR == NULL)
        || (selItmNum_Conn_SubSvr == 0 && selItmNum_Conn_SIMS != 0 && conn_SIMS_err_flg == 1) ){
      TprLibLogWrite( FREQ_LOG,-1,-1, "Freq: db_SrLogin return error\n");

      /* disconnect TPR_DB */
      if( conTPR ){
        db_PQfinish( FREQ_LOG, conTPR );
      }

      memset( &param_er, 0x00, sizeof( tprDlgParam_t ));
      param_er.er_code    = MSG_OFFLINE;
      param_er.dialog_ptn = TPRDLG_PT4;
      param_er.title      = FREQ_ERR_TITLE;
      param_er.user_code  = 14;
      if ( pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_NEW ){
        db_ret2 = 1;
        db_ret3 = param_er.er_code;
        quick_timer = gtk_timeout_add( FREQ_TIMER, (GtkFunction)freq_quick_end, NULL );
        return;
      }
    // クイック再セットアップ対応
    if ((data_restor_exec_flg3 == 1)
        || (data_restor_exec_flg3 == 2))
    {
      data_restor_exec_flg = 3;
      data_restor_exec_flg1 = 0;
    }
    else
    {
      TprLibDlg( &param_er );

      /* set error flag */
      freq_eflg = 1;

      /* set db access error flag */
      freq_dbflg = 1;
    }

      return;
    }
  //  else if( (selItmNum_Conn_SubSvr != 0 && conSR == NULL) || (selItmNum_Conn_SIMS != 0 && conn_SIMS_err_flg == 1) ){
    else if( selItmNum_Conn_SubSvr != 0 && selItmNum_Conn_SIMS != 0 && (conSR == NULL || conn_SIMS_err_flg == 1) ){
      memset( &param_er, 0x00, sizeof( tprDlgParam_t ));
      if(conSR == NULL){
        param_er.er_code    = MSG_FREQ_SUBSVR_OFFLINE_CONF;
      }
      else{
        param_er.er_code    = MSG_FREQ_SIMS_OFFLINE_CONF;
      }
      param_er.dialog_ptn = TPRDLG_PT1;
      param_er.title      = FREQ_ERR_TITLE;
      param_er.func1      = (void *)freq_exec_conf2;
      param_er.func2      = (void *)freq_dlg_flg_clr;
      param_er.msg1         = BTN_YES;
      param_er.msg2         = BTN_NO;
      param_er.user_code  = 14;
      if ( pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_NEW ){
        db_ret2 = 1;
        db_ret3 = param_er.er_code;
        quick_timer = gtk_timeout_add( FREQ_TIMER, (GtkFunction)freq_quick_end, NULL );
        return;
      }
      TprLibDlg( &param_er );

      freq_dlg = 1;

      return;

    }


    /* 「メインメニュー関連」のリクエストが指示されている場合
        サーバー側に 該当の企業番号/店舗コード が存在するか確認する

    */
    if (freq_check_exec_available (conSR, pCom->db_regctrl.comp_cd, pCom->db_regctrl.stre_cd) != 0)	/* 0:実行可能 以外 */
    {
        /* disconnect TPR_DB */
        if( conTPR ){
          db_PQfinish( FREQ_LOG, conTPR );
        }

        memset( &param_er, 0x00, sizeof( tprDlgParam_t ));
        param_er.er_code    = MSG_NONEXISTDATA;
        param_er.dialog_ptn = TPRDLG_PT4;
        param_er.title      = FREQ_ERR_TITLE;
        param_er.user_code  = 0;				// 表示なし
        if ( pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_NEW ){
          db_ret2 = 1;
      db_ret3 = param_er.er_code;
          quick_timer = gtk_timeout_add( FREQ_TIMER, (GtkFunction)freq_quick_end, NULL );
          return;
        }
        TprLibDlg( &param_er );

        /* set error flag */
        freq_eflg = 1;

        /* set db access error flag */
        freq_dbflg = 1;

      return;
    }
    */

    /*======================================================================*/
    /* 変数初期化															*/
    /*======================================================================*/
    /* initialize */
    existFlg = [];
    comCd = "";
    streCd = "";

    CompetitionIniRet competitionIniRet = await CompetitionIni.competitionIniGet(
        0,
        CompetitionIniLists.COMPETITION_INI_MAC_NO,
        CompetitionIniType.COMPETITION_INI_GETSYS);
    mac_no = competitionIniRet.value;
    macno = mac_no.toString();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macIni = pCom.iniMacInfo;
    comCd = macIni.system.crpno.toString();
    streCd = macIni.system.shpno.toString();

    /* FTPではなくWebAPI呼び出しに変わるため、ここの情報取得、FTP確認処理は置き換え不要
    if(cm_mm_system( )){
      MacType = cm_mm_type( );
      if(( MacType == MacM1 )
  #if SEGMENT
        || (MacType == MacMOnly)
  #endif
        ){
        if( TprLibGetIni( ftpp, "subserver", "name", fghostname ) != 0 )
        {
          TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                        "Freq: TprLibGetIni-> get machine name from ini file error!" );
          freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 26 );
          return;
        }
      }
      else{
        if( TprLibGetIni( ftpp, "master", "name", fghostname ) != 0 )
        {
          TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                      "Freq: TprLibGetIni-> get machine name from ini file error!" );
          freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 21 );
          return;
        }
      }

        if( cm_CenterServer_system( ) ){ /* center server system */
          if( freq_cnct_svr ) {   /* connect center server */
              memset( fghostname, 0x00, sizeof( fghostname ));
              strcat( fghostname, CSRV_MST_NAME );
          }
        }

    }
    else{
      if( TprLibGetIni( ftpp, "server", "name", fghostname ) != 0 )
      {
        TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                    "Freq: TprLibGetIni-> get machine name from ini file error!" );
        freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 22 );
        return;
      }
    }
  /* 2002/03/01 <<< H.Sakamoto */


    if( TprLibGetIni( ftpp, "server", "loginname", fgusername ) != 0 )
    {
      TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                  "Freq: TprLibGetIni-> get user name from ini file error!" );
      freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 23 );
      return;
    }
    if( TprLibGetIni( ftpp, "server", "password", fgpassword ) != 0 )
    {
      TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                  "Freq: TprLibGetIni-> get password from ini file error!" );
      freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 24 );
      return;
    }

    /* センターサーバー接続 */
    if( cm_CenterServer_system( ) ){ /* center server system */
        if( freq_cnct_svr ) {   /* connect center server */
          memset( fgusername, 0x00, sizeof( fgusername ));
          memset( fgpassword, 0x00, sizeof( fgpassword ));

          if( TprLibGetIni_Direct( ftpp, "server", "loginname", fgusername, 1, 1 ) != 0 )
          {
              TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                  "Freq: TprLibGetIni-> get user name from ini file error!" );
              freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 23 );
              return;
          }

          if( TprLibGetIni_Direct( ftpp, "server", "password", fgpassword, 1, 1 ) != 0 )
          {
              TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
                  "Freq: TprLibGetIni-> get password from ini file error!" );
              freq_exec_conf_err_dlg( MSG_SYS_PARAM_NOTREAD, 24 );
              return;
          }
        }
    }

    freq_ini_ver_chk = 0;
    ret = DB_SUCCESS;
    memset(ip_addr,0,sizeof(ip_addr));
    if( (cm_mm_system( )) &&( !(cm_CenterServer_system()) || ((cm_CenterServer_system()) && !(freq_cnct_svr))) ){ /* center server system */
      ret = dbSelect_hostip(FREQ_LOG, mac_no, ip_addr[0], ip_addr[1]);
    }

    if( ret == DB_SUCCESS ){
      ret = dbFtpFileVerIni_cmp( FREQ_LOG, fghostname, fgusername, fgpassword, &ip_addr[1][0], freq_cnct_svr );
    }
    if( ret != DB_SUCCESS ){
      freq_ini_ver_chk = 0;
      memset( &param_er, 0x00, sizeof( tprDlgParam_t ));
      param_er.er_code    = MSG_FREQ_VERUNMATCH_CONF;
      param_er.dialog_ptn = TPRDLG_PT1;
      param_er.title      = FREQ_ERR_TITLE;
      param_er.func1      = (void *)freq_exec_conf_msg;
      param_er.func2      = (void *)freq_dlg_flg_clr;
      param_er.msg1         = BTN_YES;
      param_er.msg2         = BTN_NO;
      param_er.user_code  = 14;
      if ( pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_NEW ){
        db_ret2 = 1;
        db_ret3 = param_er.er_code;
        quick_timer = gtk_timeout_add( FREQ_TIMER, (GtkFunction)freq_quick_end, NULL );
        return;
      }
      TprLibDlg( &param_er );

      freq_dlg = 1;

      return;
    }
    }
    */
    freqExecExecBefore();
  }

  /// ファイルリクエストの実行確認ダイアログで「はい」が選択された場合の処理を行う。
  /// 関連tprxソース: freq.c - freq_exec_yes
  /// 引数：なし
  /// 戻値：なし
  static void freqExecYes() {
    TprLog()
        .logAdd(FREQ_LOG, LogLevelDefine.fCall, "Freq: [Yes] button clicked");

    // set freq status to avoid mechanical keys
    freqStatus = 1;

    // clear dialog
    TprDlg.tprLibDlgClear("");

    freqDlg = 0;
    // Set timer execution
    freqPtimer = Fb2Gtk.gtkTimeoutAdd(FREQ_TIMER, freqExecConf, 0);
  }

  ///　freq_exec_exec()の前処理
  ///　関連tprxソース: freq.c - freq_exec_exec_before
  /// 引数：なし
  /// 戻り値：なし
  static Future<void> freqExecExecBefore() async {
    int ret = 0;

    if (freqPtimer != 0) {
      Fb2Gtk.gtkTimeoutRemove(freqPtimer);
      freqPtimer = 0;
    }

    // COPY文で時間がかかる為、トリガー削除
    if ((await CmCksys.cmWizCnctSystem() != 0) ||
        (await CmCksys.cmWizAbjSystem() != 0)) {
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // db_trigger_drop(FREQ_LOG, conTPR);
    }

    // reset error flag
    freqEflg = 0;

    iIdx = 0;
    jIdx = 0;

    // set freq status
    freqStatus = 1;
    final FileRequestPageController ctrl = Get.find();
    // EXECUTE mesages
    if (freqCallMode == Rxsys.RXSYS_MSG_FREQS.id) {
      ctrl.execStatus.value = LFreq.EXECUTE_MM;
    } else {
      ctrl.execStatus.value = LFreq.EXECUTE;
    }

    allselectFlgBak = false;
    allselectFlgBakQc = false;
    allselectFlgBakSp = false;

    if (allselectFlg == true) {
      allselectFlgBak = true;
      allselectFlgBakQc = true;
      allselectFlgBakSp = true;
    }

    // reset select all flg
/*
  if(( allselect_flg == 1 )
#if SEGMENT
     && !( cm_mm_ini_type() == MacMOnly )
#endif
     ){
#if SS_CR2
    ret = dbFileReq_dtl( FREQ_LOG, macno, com_cd, stre_cd, "c_histlog_chg_cnt",
                           fghostname, fgusername, fgpassword, conSR, conTPR, freq_cnct_svr,
                           3, "", 1, 1, "", 0, 0, NULL );
#else
    ret = dbFileReq_dtl( FREQ_LOG, macno, com_cd, stre_cd, "c_histlog_chg_cnt",
                           fghostname, fgusername, fgpassword, conSR, conTPR, freq_cnct_svr,
                           3, "", 1, 1, "", 0, 0 );
#endif
    TprLibLogWrite( FREQ_LOG, TPRLOG_NORMAL, ret,
                       "Freq: Insert c_histlog_chg_cnt for dbFileReq " );
	AfterVupFreqTxt_RemoveFlg = 1;
  }
 */
    if (allselectFlg == true) {
      if (CompileFlag.SEGMENT) {
        if (await CmCksys.cmMmIniType() != CmSys.MacMOnly) {
          if (CompileFlag.SS_CR2) {
            ret = await DbFileReq.dbFileReqDtl(
                FREQ_LOG,
                macno,
                comCd,
                streCd,
                'c_histlog_chg_cnt',
                fghostname,
                fgusername,
                fgpassword,
                conSR,
                conTPR,
                freqCnctSvr,
                3,
                '',
                1,
                1,
                '',
                0,
                0);
          } else {
            ret = await DbFileReq.dbFileReqDtl(
                FREQ_LOG,
                macno,
                comCd,
                streCd,
                'c_histlog_chg_cnt',
                fghostname,
                fgusername,
                fgpassword,
                conSR,
                conTPR,
                freqCnctSvr,
                3,
                '',
                1,
                1,
                '',
                0,
                0);
          }
          TprLog().logAdd(FREQ_LOG, LogLevelDefine.normal,
              'Freq: Insert c_histlog_chg_cnt for dbFileReq');
          afterVupFreqTxtRemoveFlg = 1;
        }
      }
    }
    allselectFlg = false;

    // 選択されている項目総数と実行インデックスを初期化
    selectedItemTotal = getSelectedTotalCount();
    executeItemIndex = 0;

    // 関数呼び出しではなく、タイマー起動により実行する（画面描画のため）
    // TODO:10136 実装対象外（update_ExecuteStatus）
    //update_ExecuteStatus ();	// 実行状況の更新
    freqPtimer = Fb2Gtk.gtkTimeoutAdd(FREQ_TIMER, freqExecExec, 0);
  }

  ///　ファイル初期設定 主処理
  ///　ファイル初期化またはファイルリクエスト開始時に、選択されている項目数を取得する
  ///　関連tprxソース: freq.c - getSelectelTotalCount
  /// 引数：なし
  /// 戻り値：選択されているアイテムの総数
  static int getSelectedTotalCount() {
    int selectedTotal = 0;

    // 処理対象の総数を取得する
    for (int iLoop = 0; iLoop < mItemNum; iLoop++) {
      for (int jLoop = 0; jLoop < crItem[iLoop].totalTbl; jLoop++) {
        if (crItem[iLoop].data[jLoop].selFlg == true) {
          selectedTotal++;
        }
      }
    }
    if (FREQ_DBG) {
      print("\n[[ getSelectedTotalCount ]] selectedTotal is $selectedTotal\n");
    }
    return selectedTotal;
  }

  /// freq_exec_exec	ファイルリクエスト 前半処理
  /// 関連tprxソース: freq.c - freq_exec_exec
  /// 引数：なし
  /// 戻り値：なし
  static Future<void> freqExecExec() async {
    int dbRet = 0;
    int libRet = 0;
    String status;
    int i, j = 0;
    String freqUname;
    String ftpp;
/* 2002/03/01 H.Sakamoto >>> */
    int SeqCnt, SeqFlg;
    String fName;
    String buf;
    String log;
/* 2002/03/01 <<< H.Sakamoto */
    String endMsg;

    String spqcUserName = "web2100"; // 相手はレジ固定
    String spqcPassword = "web2100"; // 相手はレジ固定

    String infoBuf;
    String buf2;

    // #if SS_CR2
    int fqcount = 0; /* 取得したファイル数 */
    String dispCntOk; /* fqcountの"OK(n)"表示 */
    // #endif

    final FileRequestPageController ctrl = Get.find();

    // タイマー削除
    if (freqPtimer != 0) {
      Fb2Gtk.gtkTimeoutRemove(freqPtimer);
      freqPtimer = 0;
    }

    // 以下コメントアウト部分はクイックセットアップ関連処理
    // クイックセットアップは実装対象外

    //   /* make sys_param.ini path */
    //   sprintf( ftpp, "%s/conf/sys_param.ini", FreqHomeDirp );
    //
    //   if( TprLibGetIni( ftpp, "server", "loginname", freq_uname ) != 0 )
    //   {
    //     TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
    //         "Freq: TprLibGetIni-> get user name from ini file error!" );
    //     return;
    //   }
    //
    //   /* センターサーバー接続 */
    //   if( cm_CenterServer_system( ) ){ /* center server system */
    //     if( freq_cnct_svr ) {   /* connect center server */
    //       memset( fgusername, 0x00, sizeof( fgusername ));
    //
    //       if( TprLibGetIni_Direct( ftpp, "server", "loginname", freq_uname, 1, 1 ) != 0 )
    //       {
    //         TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0,
    //             "Freq: TprLibGetIni-> get user name from ini file error!" );
    //         return;
    //       }
    //     }
    //   }
    //
    //   if ( pCom->quick_flg == QUICK_SETUP_TYPE_9191 ){
    //     #if SS_CR2
    //     //db_ret = dbFileReq( FREQ_LOG, macno, com_cd, stre_cd, "c_trm_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr, &fqcount );
    //     db_ret = dbFileReq_dtl( FREQ_LOG, macno, com_cd, stre_cd, "c_trm_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr,
    //     0, "", 1, 1, "", 0, 0, &fqcount  );
    //     #else
    //     //db_ret = dbFileReq( FREQ_LOG, macno, com_cd, stre_cd, "c_trm_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr );
    //     db_ret = dbFileReq_dtl( FREQ_LOG, macno, com_cd, stre_cd, "c_trm_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr,
    //         0, "", 1, 1, "", 0, 0  );
    //   #endif
    //   if ( db_ret != 0 ){
    //     sprintf( log, "c_trm_mst ret = %d", db_ret );
    //     TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0, log );
    //     db_ret2 = 2;
    //   }
    //   #if SS_CR2
    //   //db_ret = dbFileReq( FREQ_LOG, macno, com_cd, stre_cd, "c_kopttran_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr, &fqcount );
    //   #else
    //   //db_ret = dbFileReq( FREQ_LOG, macno, com_cd, stre_cd, "c_kopttran_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr );
    //   #endif
    //   //if ( db_ret != 0 ){
    //   //  sprintf( log, "c_kopttran_mst ret = %d", db_ret );
    //   //  TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0, log );
    //   //  db_ret2 = 2;
    //   //}
    //   #if SS_CR2
    //   db_ret = dbFileReq_dtl( FREQ_LOG, macno, com_cd, stre_cd, "c_keyopt_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr,
    //   0, "", 1, 1, "", 0, 0, &fqcount   );
    //   #else
    //   db_ret = dbFileReq_dtl( FREQ_LOG, macno, com_cd, stre_cd, "c_keyopt_mst", fghostname, freq_uname, fgpassword, conSR, conTPR, freq_cnct_svr,
    //   0, "", 1, 1, "", 0, 0   );
    //   #endif
    //   if ( db_ret != 0 ){
    //   sprintf( log, "c_keyopt_mst ret = %d", db_ret );
    //   TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, 0, log );
    //   db_ret2 = 2;
    //   }
    //   if(( cm_wiz_cnct_system( ) ) || ( cm_wiz_abj_system( ) ))	/* トリガー作成 */
    //   db_trigger_create( FREQ_LOG, conTPR );
    //
    //   quick_timer = gtk_timeout_add( FREQ_TIMER, (GtkFunction)freq_quick_end, NULL );
    //   return;
    // }

    // 選択されたテーブルを対象にファイルリクエスト処理を行う
    if ((crItem[iIdx].aFlg == true) ||
        (crItem[iIdx].data[jIdx].selFlg == true)) {
      /* set execute flag */
      execFlg = 1;

      //取得先==お会計券サーバ？
      if (crItem[iIdx].data[jIdx].svrDiv == 1) {
        // お会計券サーバーのアドレスを設定
        fghostname = SPQC_IPADR;
        freqUname = spqcUserName;
        fgpassword = spqcPassword;
      }

      if (freqCallMode == Rxsys.RXSYS_MSG_FREQS.id) {
        if (CmCksys.cmMmSystem() == 1) {
          // MMシステム仕様は実装対象外
        } else {
          if (CompileFlag.SS_CR2) {
            dbRet = await DbFileReq.dbFileReqDtl(
                FREQ_LOG,
                macno,
                comCd,
                streCd,
                crItem[iIdx].data[jIdx].eName,
                fghostname,
                fgusername,
                fgpassword,
                conSR,
                conTPR,
                freqCnctSvr,
                crItem[iIdx].data[jIdx].freqOpeMode,
                crItem[iIdx].data[jIdx].seqName,
                crItem[iIdx].data[jIdx].freqCsrvCnctSkip,
                crItem[iIdx].data[jIdx].freqCsrcCustRealSkip,
                crItem[iIdx].data[jIdx].freqCsrvCnctKey,
                crItem[iIdx].data[jIdx].freqCsrvDelOthStre,
                crItem[iIdx].data[jIdx].setTblTyp,
                fqcount: fqcount);
          } else {
            dbRet = await DbFileReq.dbFileReqDtl(
                FREQ_LOG,
                macno,
                comCd,
                streCd,
                crItem[iIdx].data[jIdx].eName,
                fghostname,
                fgusername,
                fgpassword,
                conSR,
                conTPR,
                freqCnctSvr,
                crItem[iIdx].data[jIdx].freqOpeMode,
                crItem[iIdx].data[jIdx].seqName,
                crItem[iIdx].data[jIdx].freqCsrvCnctSkip,
                crItem[iIdx].data[jIdx].freqCsrcCustRealSkip,
                crItem[iIdx].data[jIdx].freqCsrvCnctKey,
                crItem[iIdx].data[jIdx].freqCsrvDelOthStre,
                crItem[iIdx].data[jIdx].setTblTyp);
          }
          crItem[iIdx].data[jIdx].result = dbRet;
        }
      } else {
        if (CompileFlag.SS_CR2) {
          dbRet = await DbFileReq.dbFileReqDtl(
              FREQ_LOG,
              macno,
              comCd,
              streCd,
              crItem[iIdx].data[jIdx].eName,
              fghostname,
              fgusername,
              fgpassword,
              conSR,
              conTPR,
              freqCnctSvr,
              crItem[iIdx].data[jIdx].freqOpeMode,
              crItem[iIdx].data[jIdx].seqName,
              crItem[iIdx].data[jIdx].freqCsrvCnctSkip,
              crItem[iIdx].data[jIdx].freqCsrcCustRealSkip,
              crItem[iIdx].data[jIdx].freqCsrvCnctKey,
              crItem[iIdx].data[jIdx].freqCsrvDelOthStre,
              crItem[iIdx].data[jIdx].setTblTyp,
              fqcount: fqcount);
        } else {
          dbRet = await DbFileReq.dbFileReqDtl(
              FREQ_LOG,
              macno,
              comCd,
              streCd,
              crItem[iIdx].data[jIdx].eName,
              fghostname,
              fgusername,
              fgpassword,
              conSR,
              conTPR,
              freqCnctSvr,
              crItem[iIdx].data[jIdx].freqOpeMode,
              crItem[iIdx].data[jIdx].seqName,
              crItem[iIdx].data[jIdx].freqCsrvCnctSkip,
              crItem[iIdx].data[jIdx].freqCsrcCustRealSkip,
              crItem[iIdx].data[jIdx].freqCsrvCnctKey,
              crItem[iIdx].data[jIdx].freqCsrvDelOthStre,
              crItem[iIdx].data[jIdx].setTblTyp);
        }
        crItem[iIdx].data[jIdx].result = dbRet;
      }
      crItem[iIdx].data[jIdx].execFlg = 1;

      // dbFileReqDtl()の実行結果を判定
      if (dbRet == DbError.DB_SUCCESS) {
        if (CompileFlag.SS_CR2) {
          // TODO:10134 ファイルリクエスト 202405実装対象外
          // if (fqcount != 0)
          // {
          //   /* 負数は0件とする */
          //   if (fqcount < 0)
          //   {
          //     fqcount = 0;
          //   }
          //
          //   /* 結果欄に取得したファイル数を「OK(n件)」で表示する */
          //   memset (disp_cnt_ok, 0x00, sizeof (disp_cnt_ok));
          //   snprintf (disp_cnt_ok, sizeof (disp_cnt_ok), DISP_OK_NO_CNT, fqcount);
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL, NULL, disp_cnt_ok, strlen(disp_cnt_ok));
          // }
          // else
          // {
          // gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
//          //            NULL, "OK", strlen("OK"));
          //     NULL, DISP_OK, strlen(DISP_OK));
          // #if SS_CR2
          // }
          // #endif
        } else {
          // グラフィクス処理実装対象外
          // gtk_text_insert( GTK_TEXT(
          //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //     NULL, DISP_OK, strlen(DISP_OK));
        }

        // グラフィクス処理実装対象外
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }
        //
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //     NULL, " ", strlen(" "));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }

        // クイックセットアップは実装対象外
        // // クイック再セットアップ対応
        // if ((data_restor_exec_flg3 == 1)		// クイック再セットアップのファイルリクエスト
        //     || (data_restor_exec_flg3 == 2))
        // {
        //   if ((fp_write = fopen (data_restor_filename, "a")) != NULL)	// 項目名、テーブル名を出力する。
        //       {
        //     memset (buf2, 0x00, sizeof (buf2));
        //     snprintf (buf2, sizeof (buf2), "%s\t%s\tOK\t%d\t\n", btn_wr[r_page[i_idx].btn_no[j_idx]].label_name, r_page[i_idx].name[j_idx], db_ret);
        //     fputs (buf2, fp_write);
        //     fclose (fp_write);
        //   }
        // }
      } else if (dbRet == DbError.DB_SKIP) {
        // グラフィクス処理実装対象外
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //     NULL, DISP_SKIP, strlen(DISP_SKIP));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }
        //
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //     NULL, MSG_SKIP, strlen(MSG_SKIP));
        // cr_item[r_page[i_idx].btn_no[j_idx]].data[k_idx].status = MSG_SKIP;
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }

        //　クイックセットアップは実装対象外
        // // クイック再セットアップ対応
        // if ((data_restor_exec_flg3 == 1)		// クイック再セットアップのファイルリクエスト
        //     || (data_restor_exec_flg3 == 2))
        // {
        //   if ((fp_write = fopen (data_restor_filename, "a")) != NULL)	// 項目名、テーブル名を出力する。
        //       {
        //     memset (buf2, 0x00, sizeof (buf2));
        //     snprintf (buf2, sizeof (buf2), "%s\t%s\tSKIP\t%d\t\n", btn_wr[r_page[i_idx].btn_no[j_idx]].label_name, r_page[i_idx].name[j_idx], db_ret);
        //     fputs (buf2, fp_write);
        //     fclose (fp_write);
        //   }
        // }
      } else if ((CompileFlag.SS_CR2) &&
          (dbRet == DbError.DB_RECEIPTLOGO_FILENONE)) {
        // TODO:10134 ファイルリクエスト 202405実装対象外
        // 特定CR2用 ロゴ更新 対象なし
      } else if ((CompileFlag.SS_CR2) &&
          (dbRet == DbError.DB_RECEIPTLOGO_FILENONE)) {
        // TODO:10134 ファイルリクエスト 202405実装対象外
        // 特定CR2用 ロゴ更新 失敗
      } else if (dbRet == DbError.DB_TSLNKWEBERR) {
        buf = sprintf(LFreq.DISP_NG_NO, [DbFileReq.tslnk_err]);

        // グラフィクス処理実装対象外
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //     NULL, buf, strlen(buf));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }
        //
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //     NULL, MSG_COMMANDERR, strlen(MSG_COMMANDERR));
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }
        crItem[iIdx].data[jIdx].status = LFreq.MSG_COMMANDERR;

        // クイックセットアップは実装対象外
        // // クイック再セットアップ対応
        // if ((data_restor_exec_flg3 == 1)		// クイック再セットアップのファイルリクエスト
        //     || (data_restor_exec_flg3 == 2))
        // {
        //   data_restor_exec_flg = 1;
        //   if ((fp_write = fopen (data_restor_filename, "a")) != NULL)	// 項目名、テーブル名、ステータスを出力する。
        //       {
        //     memset (buf2, 0x00, sizeof (buf2));
        //     snprintf (buf2, sizeof (buf2), "%s\t%s\ttsLnkWeb_ERROR\t%d\t\n", btn_wr[r_page[i_idx].btn_no[j_idx]].label_name, r_page[i_idx].name[j_idx], db_ret);
        //     fputs (buf2, fp_write);
        //     fclose (fp_write);
        //   }
        // }
      } else if (dbRet == DbError.DB_SKIP2) {
        // グラフィクス処理実装対象外
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //     NULL, DISP_SKIP, strlen(DISP_SKIP));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //     NULL, MSG_SKIP2, strlen(MSG_SKIP2));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }

        // クイックセットアップは実装対象外
        // // クイック再セットアップ対応
        // if ((data_restor_exec_flg3 == 1)		// クイック再セットアップのファイルリクエスト
        //     || (data_restor_exec_flg3 == 2))
        // {
        //   if ((fp_write = fopen (data_restor_filename, "a")) != NULL)	// 項目名、テーブル名を出力する。
        //       {
        //     memset (buf2, 0x00, sizeof (buf2));
        //     snprintf (buf2, sizeof (buf2), "%s\t%s\tSKIP2\t%d\t\n", btn_wr[r_page[i_idx].btn_no[j_idx]].label_name, r_page[i_idx].name[j_idx], db_ret);
        //     fputs (buf2, fp_write);
        //     fclose (fp_write);
        //   }
        // }
      } else {
        // グラフィクス処理実装対象外
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //     NULL, DISP_NG, strlen(DISP_NG));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }

        /* set status message */
        switch (dbRet) {
          case DbError.DB_ARGERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Error in parameter for dbFileReq ",
                errId: DbError.DB_ARGERR);
            status = LFreq.MSG_ARGERR;
            break;
          case DbError.DB_QUERYERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Query error in dbFileReq ",
                errId: DbError.DB_QUERYERR);
            status = FreqDefine.MSG_QUERYERR;
            break;
          case DbError.DB_COPYREQUESTERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Copy request error in dbFileReq ",
                errId: DbError.DB_COPYREQUESTERR);
            status = FreqDefine.MSG_COPYREQUESTERR;
            break;
          case DbError.DB_CONNECTIONERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Connection error in dbFileReq ",
                errId: DbError.DB_CONNECTIONERR);
            status = FreqDefine.MSG_CONNECTIONERR;
            break;
          case DbError.DB_COPYGETLINEERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Copy get line error in dbFileReq ",
                errId: DbError.DB_COPYGETLINEERR);
            status = LFreq.MSG_COPYGETLINEERR;
            break;
          case DbError.DB_COPYPUTLINEERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Copy put line error in dbFileReq ",
                errId: DbError.DB_COPYPUTLINEERR);
            status = LFreq.MSG_COPYPUTLINEERR;
            break;
          case DbError.DB_ENDCOPYERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: End copy error in dbFileReq ",
                errId: DbError.DB_ENDCOPYERR);
            status = FreqDefine.MSG_ENDCOPYERR;
            break;
          case DbError.DB_DATAGETERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Data get error in dbFileReq ",
                errId: DbError.DB_DATAGETERR);
            status = FreqDefine.MSG_DATAGETERR;
            break;
          case DbError.DB_FTPOPENERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Ftp open error in dbFileReq ",
                errId: DbError.DB_FTPOPENERR);
            status = FreqDefine.MSG_FTPOPENERR;
            break;
          case DbError.DB_FTPGETERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Ftp get error in dbFileReq ",
                errId: DbError.DB_FTPGETERR);
            status = FreqDefine.MSG_FTPGETERR;
            break;
          case DbError.DB_RENAMEERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Rename error in dbFileReq ",
                errId: DbError.DB_RENAMEERR);

            status = FreqDefine.MSG_RENAMEERR;
            break;
          case DbError.DB_PARAMERR:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Parameter error in dbFileReq ",
                errId: DbError.DB_PARAMERR);
            status = FreqDefine.MSG_PARAMERR;
            break;

          case DbError.DB_FTPFILENOTEXIST:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Ftp file not exist in dbFileReq ",
                errId: DbError.DB_PARAMERR);
            status = LFreq.MSG_FILENOTEXISTERR;

            // クーポン画像の取得時に「ファイル無し」の場合は、結果正常とする
            if (crItem[iIdx].data[jIdx].freqOpeMode == 37) {
              // 処理結果を正常に
              crItem[iIdx].data[jIdx].result = DbError.DB_SUCCESS;

              // 結果エリア "正常表示"
              // グラフィクス処理実装対象外
              // gtk_editable_delete_text( GTK_EDITABLE(
              //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), 0, -1 );
              // gtk_text_insert( GTK_TEXT(
              //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
              //     NULL, DISP_OK, strlen(DISP_OK));
              //
              // /* insert return code */
              // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] )
              // {
              //   gtk_text_insert( GTK_TEXT(
              //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
              //       NULL, "\n", strlen("\n"));
              // }
            }
            break;
          default:
            TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
                "Freq: Other error in dbFileReq ",
                errId: DbError.DB_PARAMERR);
            status = FreqDefine.MSG_PARAMERR;
            break;
        }
        // クイックセットアップは実装対象外
        // // クイック再セットアップ対応
        // if ((data_restor_exec_flg3 == 1)		// クイック再セットアップのファイルリクエスト
        //     || (data_restor_exec_flg3 == 2))
        // {
        //   data_restor_exec_flg = 1;
        //   if ((fp_write = fopen (data_restor_filename, "a")) != NULL)	// 項目名、テーブル名、ステータスを出力する。
        //       {
        //     memset (buf2, 0x00, sizeof (buf2));
        //     snprintf (buf2, sizeof (buf2), "%s\t%s\t%s\t%d\t\n", btn_wr[r_page[i_idx].btn_no[j_idx]].label_name, r_page[i_idx].name[j_idx], status, db_ret);
        //     fputs (buf2, fp_write);
        //     fclose (fp_write);
        //   }
        // }

        crItem[iIdx].data[jIdx].status = status;
        // グラフィクス処理実装対象外
        // gtk_text_insert( GTK_TEXT(
        //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //     NULL, status, strlen(status));
        //
        // /* insert return code */
        // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
        //   gtk_text_insert( GTK_TEXT(
        //       text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
        //       NULL, "\n", strlen("\n"));
        // }
      }

      // 選択項目の実行数を更新
      executeItemIndex++;
    } else {
      //未選択行：結果欄はブランクとし次の行へ
      // if(existFlg[rPage.txtNo] != 1){
      //   // グラフィクス処理実装対象外
      //   /* delete text in text field */
      //   // gtk_editable_delete_text( GTK_EDITABLE(
      //   //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ),
      //   //     0, -1 );
      //   // gtk_editable_delete_text( GTK_EDITABLE(
      //   //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ),
      //   //     0, -1 );
      //   //
      //   // existFlg[rPage.txtNo] = 1;
      // }

      // グラフィクス処理実装対象外
      // gtk_text_insert( GTK_TEXT(
      //     text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
      //     NULL, " ", strlen(" "));
      //
      // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
      //   gtk_text_insert( GTK_TEXT(
      //       text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
      //       NULL, "\n", strlen("\n"));
      // }
      //
      // gtk_text_insert( GTK_TEXT(
      //     text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
      //     NULL, " ", strlen(" "));
      //
      // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
      //   gtk_text_insert( GTK_TEXT(
      //       text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
      //       NULL, "\n", strlen("\n"));
      // }
    }

    /* increment i_idx and j_idx */
    if (iIdx < mItemNum) {
      if (jIdx < crItem[iIdx].totalTbl - 1) {
        jIdx++;
      } else {
        jIdx = 0;
        iIdx++;
      }
    }

    // 画面データ更新
    ctrl.dispData.refresh();

    if (iIdx < mItemNum) {
      freqPtimer = Fb2Gtk.gtkTimeoutAdd(FREQ_TIMER, freqExecExec, 0);
    } else {
      // ファイルリクエスト 後半処理へ
      freqPtimer = Fb2Gtk.gtkTimeoutAdd(FREQ_TIMER, freqExecExec2, 0);
    }
  }

  /// freq_exec_exec2	ファイルリクエスト 後半処理
  /// ファイルリクエストの全項目について処理した後の後半処理を実行する
  /// (freq_exec_exec()を2つの関数に分割した)
  /// 関連tprxソース: freq.c - freq_exec_exec2
  /// 引数：なし
  /// 戻り値：なし
  static Future<void> freqExecExec2() async {
    int libRet;
    int i, j;
    String endMsg;
    RmIniRead iniRead = RmIniRead();
    RmDBRead dbRead = RmDBRead();

    // タイマー削除
    if (freqPtimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(freqPtimer);
      freqPtimer = -1;
    }

    if (freqCallMode == Rxsys.RXSYS_MSG_FREQS.id) {
      /* 2002/08/22 */
      // MMシステムは実装対象外のため
      // if( cm_mm_type( ) == MacM2 ){		/* 2002/08/22 */
      //   freq_exec_exec_end( );			/* 2002/08/22 */
      // }									/* 2002/08/22 */
    }
    /* 2002/08/22 */
    if ((await CmCksys.cmWizCnctSystem() != 0) ||
        (await CmCksys.cmWizAbjSystem() != 0)) {
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // db_trigger_create( FREQ_LOG, conTPR );
    }

    /* Modify common(shared) memory */
    if ((libRet = (await iniRead.rmIniReadMain()).dlgId) != 0) {
      TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
          "Freq: An error from rmIniReadMain function",
          errId: libRet);
    }
    if ((libRet = (await dbRead.rmDbReadMain()).dlgId) != 0) {
      TprLog().logAdd(FREQ_LOG, LogLevelDefine.error,
          "Freq: An error from rmDbReadMain function",
          errId: libRet);
    }

    for (i = 0; i < mItemNum; i++) {
      if (crItem[i].aFlg == true) {
        crItem[i].aFlg = false;
      }

      for (j = 0; j < crItem[i].totalTbl; j++) {
        crItem[i].data[j].selFlg = false;
      }
      // 実装対象外のため
      // UpdateTableList(i);
    }
    /* reset freq status */
    freqStatus = 0;

    freqDlg = 0;

    /* finishing execute */
    if (freqCallMode == Rxsys.RXSYS_MSG_FREQS.id) {
      endMsg = LFreq.FINISH_MM;
    } else {
      endMsg = LFreq.FINISH;
    }
    if (await rmstFreqErrSet() != 0) {
      //エラー項目あり
      endMsg += LFreq.FINISH_ERROR;
    } else {
      endMsg += LFreq.FINISH_OK;
    }
    final FileRequestPageController ctrl = Get.find();
    ctrl.execStatus.value = endMsg;

    // クイックセットアップは実装対象外のため
    // if ( pCom->quick_flg == QUICK_SETUP_TYPE_NEW ){
    //   pCom->quick_proc = 0;
    //   quick_timer = gtk_timeout_add( FREQ_TIMER,
    //                   (GtkFunction)freq_quick_end, NULL );
    //   return;
    // }


    ctrl.dispData.refresh();

    freqExecVerMsg();
  }

  ///　関連tprxソース: freq.c - rmst_freq_err_set
  /// 引数：なし
  /// 戻り値：0:NG, 1:OK
  static Future<int> rmstFreqErrSet() async {
    int result;
    int flg = FREQ_OK;
    int flg2 = FREQ_OK; // Vup後開設時自動ファイルリクエスト指示ファイル削除するか判断するため
    String label = "";
    final buf = StringBuffer("");

    // 共有メモリ呼び出し
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (rFile.isEmpty) {
      return 0;
    }

    try {
      final File fp = File(rFile);
      if ((execFlg == 0) && (pCom.rmstInfo.rmstFreq != 0)) {
        //オフラインなどで実行していない
        flg = FREQ_NG;
        flg2 = FREQ_NG;
        buf.write("${LFreq.DISP_SELECTED}${LFreq.ALL_NO_EXEC}");
      } else {
        for (int i = 0; i < mItemNum; i++) {
          for (int j = 0; j < crItem[i].totalTbl; j++) {
            result = crItem[i].data[j].result;
            if (((result != DbError.DB_SUCCESS) &&
                (result != DbError.DB_SKIP)) ||
                (crItem[i].data[j].execFlg == 0)) {
              if ((pCom.rmstInfo.rmstFreq == 0) &&
                  (pCom.quickFlg.no ==
                      QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE.no) &&
                  (crItem[i].data[j].execFlg == 0)) {
                // 手動ファイルリクエスト未選択項目対象外
                continue;
              }
              if (!((pCom.rmstInfo.rmstFreq != 0) &&
                  (result == DbError.DB_FTPFILENOTEXIST))) {
                flg = FREQ_NG;
              }
              if (result != DbError.DB_FTPFILENOTEXIST) {
                flg2 = FREQ_NG;
              }

              if (label.isEmpty ||
                  (label.compareTo(crItem[i].labelName) != 0)) {
                label = crItem[i].labelName;
                buf.write("${LFreq.DISP_SELECTED}$label\n");
              }

              if (pCom.quickFlg.no !=
                  QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE.no) {
                if (result == DbError.DB_FTPFILENOTEXIST) {
                  buf.write(
                      "${crItem[i].data[j].tableName}(${LFreq
                          .MSG_FILENOTEXISTERR})\n");
                } else if (result == DbError.DB_SKIP2) {
                  buf.write(
                      "${crItem[i].data[j].tableName}(${LFreq.MSG_SKIP2})\n");
                } else {
                  buf.write("${crItem[i].data[j].tableName}\n");
                }
              } else if (result == DbError.DB_SKIP2) {
                buf.write(
                    "${crItem[i].data[j].tableName}(${LFreq.MSG_SKIP2})\n");
              } else if (crItem[i].data[j].execFlg == 0) {
                buf.write("${crItem[i].data[j].tableName}(${LFreq.NO_EXEC})\n");
              } else if (crItem[i].data[j].status.isNotEmpty) {
                buf.write(
                    "${crItem[i].data[j].tableName}(${crItem[i].data[j]
                        .status})\n");
              } else {
                buf.write("${crItem[i].data[j].tableName}\n");
              }
            }
          }
        }
      }
      fp.writeAsStringSync(buf.toString());

      if (mItemNum <= 0) {
        flg = FREQ_NG;
        flg2 = FREQ_NG;
      }
      if (pCom.rmstInfo.rmstFreq != 0) {
        pCom.rmstInfo.freqRes = flg;
      }

      File afterVupFreqFile = TprxPlatform.getFile(AplLib.AFTER_VUP_FREQ_FILE);
      FileStat stat = afterVupFreqFile.statSync();
      if ((flg2 == FREQ_OK) &&
          (afterVupFreqTxtRemoveFlg == 1) && // 全リクした
          (stat.type != FileSystemEntityType.notFound)) {
        // ファイルが存在する
        if (AplLibStdAdd.aplLibRemove(FREQ_LOG, AplLib.AFTER_VUP_FREQ_FILE) !=
            false) {
          TprLog().logAdd(FREQ_LOG, LogLevelDefine.normal,
              "__FUNCTION__ : remove ${AplLib.AFTER_VUP_FREQ_FILE} OK. ",
              errId: 0);
        }
      }

      if (flg == FREQ_OK) {
        fp.deleteSync(recursive: true);
        return 0;
      }
    } catch (e) {
      return 0;
    }
    return 1;
  }

  ///　ファイルリクエストバージョンチェックメッセージ表示
  ///　バージョン情報をダイアログ表示する
  ///　関連tprxソース: freq.c - freq_exec_ver_msg
  /// 引数：なし
  /// 戻り値：なし
  static void freqExecVerMsg() {
    if (freqVerChk == 1) {
      if (dataRestorExecFlg3 == 1 || dataRestorExecFlg3 == 2) {
        dataRestorExecFlg = 5;
        freqVerStatusReset();
      } else {
        // バージョン不一致メッセージ表示
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
              type: MsgDialogType.error,
              dialogId: DlgConfirmMsgKind.MSG_FREQ_MREG_VERUNMATCH.dlgId,
              btnFnc: () {
                freqVerStatusReset();
              }),
        );
      }
    } else {
      freqVerStatusReset();
    }

    // 共有メモリ呼び出し
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    if (freqVerChk == 0 && freqIniVerChk == 0 && pCom.rmstInfo.rmstFreq != 0) {
      if (pCom.rmstInfo.freqRes == FREQ_NG) {
        freqExitConf();
      }
    }
  }

  ///　ファイルリクエストバージョンステータスリセット処理
  ///　ステータスをリセットして結果を表示する。
  ///　関連tprxソース: freq.c - freq_ver_status_reset
  /// 引数：なし
  /// 戻り値：なし
  static void freqVerStatusReset() {
    if (freqIniVerChk != 0) {
      if (freqDspTimer != -1) {
        Fb2Gtk.gtkTimeoutRemove(freqDspTimer);
        freqDspTimer = -1;
      }
      freqDspTimer = Fb2Gtk.gtkTimeoutAdd(300, freqExecIniVerMsg, 0);
      return;
    }

    freqResultShow(RESULT_LIST_DISP_TYPE.RESULT_DISP_FREQ_NG );

    // TODO:10122 グラフィクス処理（gtk_*）
    // HistErr_conf_buttonがGtkWidgetのためTODO
    //if ( HistErr_conf_button != NULL )
    //{
    // AplLib_Proc_HistLog_ResultFile =>履歴ログ取得で登録画面で共有メモリ更新,
    // または, エラーで登録制限したい状態になったファイルをチェック or 作成 or 削除する関数
    //  if ( AplLib_Proc_HistLog_ResultFile(FREQ_LOG, APLLIB_HISTLOG_RES_ERR_CHECK, NULL) == 0 )
    //  {
    //    gtk_widget_destroy( HistErr_conf_button );
    //    HistErr_conf_button = NULL;
    //  }
    //}
  }

  ///　ファイルリクエスト終了処理
  ///　使用した変数の初期化、解放
  ///　関連tprxソース: freq.c - freq_exit_conf
  /// 引数：なし
  /// 戻り値：なし
  static void freqExitConf() {
    if (execFlg == 1) {
      freqEflg = 0;
      freqDlg = 0;
    }

    // パラメータ初期化
    mItemNum = 0;
    totalPage = 0;
    pageNumber = 0;
    freqStatus = 0;
    Fb2Gtk.gtkTimeoutAdd(FREQ_WAIT, freqExitConf2, 0);
  }
  ///　ファイルリクエスト終了処理
  ///　使用した変数の初期化、解放
  ///　関連tprxソース: freq.c - freq_exit_conf2
  /// 引数：なし
  /// 戻り値：なし
  static void freqExitConf2() {

    if (CmCksys.cmMmSystem() != 0) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isValid()) {
        RxCommonBuf pCom = xRet.object;
        pCom.csvServerFlg = 0;
      }
    }
  }

  ///　iniファイルバージョンチェック結果表示
  ///　iniファイルのバージョンが不一致の場合にエラーダイアログの表示
  ///　関連tprxソース: freq.c - freq_exec_ini_ver_msg
  /// 引数：なし
  /// 戻り値：なし
  static void freqExecIniVerMsg() {
    if (freqDspTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(freqDspTimer);
      freqDspTimer = -1;
    }

    if (freqIniVerChk == 1) {
      // iniファイルバージョン不一致メッセージ表示
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_FREQ_INI_VERUNMATCH.dlgId,
            btnFnc: () {
              freqVerStatusReset();
            }),
      );
    }
  }

  ///　関連tprxソース: freq.c - freq_result_show
  static void freqResultShow(RESULT_LIST_DISP_TYPE data){
    int ret = 0;
    int dispType; // ボタンによって異なる

    if(freqCallMode == Rxsys.RXSYS_MSG_FINIT.id){
      return;
    }

    // クイックセットアップは実装対象外のため
    // if(pCom->quick_flg)
    //   return;

    // if((err_list.Window != NULL) || (err_list.BKWindow != NULL))
    //   return;

    dispType = RESULT_LIST_DISP_TYPE.RESULT_DISP_FREQ_NG.index;

    if ((freqDlg == 1) || (freqEflg == 1) || (freqStatus != 0))
      // || (TprLibDlgCheck()))
    {
      TprLog().logAdd(FREQ_LOG, LogLevelDefine.normal,
          "freqResultShow: return [$dispType]", errId: 1);
      return;
    }

    TprLog().logAdd(FREQ_LOG, LogLevelDefine.normal,
        "freqResultShow: Clicked [$dispType]", errId: 1);

    // cm_clr((char *)&err_list, sizeof(err_list));

    if(dispType == RESULT_LIST_DISP_TYPE.RESULT_DISP_HIST_ERR.index){
      // TODO:10134 ファイルリクエスト 202405実装対象外
      // // 履歴(ログ)失敗処理
      // snprintf( errListFile, sizeof(errListFile), "%s/log/tmp_freq_histerr_list.txt", getenv("TPRX_HOME") );
      // snprintf( errListPath, sizeof(errListPath), "%s/tmp/ctrl_file/", getenv("TPRX_HOME") );
      //
      // fp = AplLibFileOpen( FREQ_LOG, errListFile, "w" );
      // if (fp == NULL)
      // {
      //   return;
      // }
      //
      // ret = AplLibProcScanDirBeta( FREQ_LOG, errListPath, (void *)fp, freq_histerr_file_write );
      // if ( ret <= 0 )
      // {
      //   snprintf(log, sizeof(log), "%s: file is not [%d]", __FUNCTION__, ret);
      //   TprLibLogWrite( FREQ_LOG, TPRLOG_ERROR, -1, log );
      //
      //   AplLibFileClose( FREQ_LOG, fp );
      //   AplLibRemove( FREQ_LOG, errListFile );
      //   return;
      // }
      // AplLibFileClose( FREQ_LOG, fp );
      //
      // ret = freq_result_dataset( errListFile );
      // AplLibRemove( FREQ_LOG, errListFile );
      // err_list.titleStr = MSG_HIST_ERR_TITLE;
    }else{
      // ファイルリクエストNG確認処理
      ret = freqResultDataset(rFile);
      // err_list.titleStr = MSG_RESULT_TITLE;
    }

    // NGがなければ
    if(ret != 0){
      return;
    }

    // TODO : エラーリストダイアログを表示する処理をここに書けば以下関数はいらないかも
    // freq_result_list_pageshow(0);

    TprLog().logAdd(FREQ_LOG, LogLevelDefine.normal,
        "freqResultShow:  end", errId: 1);
  }

  // TODO:00012 平野　ファイルリクエスト対応：実装途中
  ///　関連tprxソース: freq.c - freq_result_dataset
  static int freqResultDataset(String filePath){
    int fileSize = 0;
    String log = "";

    try{
      final File fp = File(filePath);
      if (!fp.existsSync()) {
        TprLog().logAdd(FREQ_LOG, LogLevelDefine.normal,
            "freqResultDataset: No File", errId: 1);
        return -1;
      }
      fileSize = fp.lengthSync();
      if(fileSize < 0){
        log = "freqResultDataset: no data";
      }
      if(log != ""){
        TprLog().logAdd(FREQ_LOG, LogLevelDefine.error, log, errId: -1);
        return -1;
      }


    }catch(e){
      return -1;
    }
    return 0;
  }

  /// ファイル初期設定 開始処理
  /// 関連tprxソース: freq.c - finit_exec_conf
  static Future<void> fInitExecConf() async {
    String fname;
    String sql = "";

    TprLog().logAdd(FINIT_LOG, LogLevelDefine.fCall,"Finit: [Execute] button clicked");

    // 共有メモリ呼び出し
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    /* Clear dialog */
    if ( pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE ){
      TprDlg.tprLibDlgClear("fInitExecConf");
      // gtk_grab_add(freq_window1);
    } else {
      fname = "${freqHomeDirp}log/c_recoginfo_mst.quick_bak"; 
      AplLibStdAdd.aplLibRemove( FINIT_LOG, fname );
      /* 戻り値はみない 承認キー設定値の保存 */

      DbLibCopyParam copyparam = DbLibCopyParam();
      copyparam.withNull = "";
      sql = "(select * from c_recoginfo_mst where comp_cd ='${pCom.iniMacInfo.system.crpno}' and stre_cd='${pCom.iniMacInfo.system.shpno}' and mac_no='${pCom.iniMacInfo.system.macno}')";
      copyparam.selSql = sql;
      await DataRestorLib.specBackUpDbCopyTo(FINIT_LOG, fname, "c_recoginfo_mst", copyparam);

      try {
        // データベース初期化
        await DbManipulationPs().initializeDB();
      } catch (e) {
        TprLog().logAdd(FINIT_LOG, LogLevelDefine.error,
            "fInitExecConf: DB initialize error", errId: 0);
        return;
      }

      SpecBackupDataChange cngSetData = SpecBackupDataChange();
      cngSetData.chgFlg = 1;           
      cngSetData.compCd = 1;
      cngSetData.streCd = 1;
      cngSetData.macNo = 1;
      await DataRestorLib.specBackUpDbCopyFrom (FINIT_LOG, fname, "c_recoginfo_mst", cngSetData);
    }
    // fInitExecConfQuick(); クイックセットアップは実装対象外


    final FileRequestPageController ctrl = Get.find();
    ctrl.execStatus.value = LFreq.EXECUTE_FINIT;
    /* reset error flag */
    freqEflg = 0;     

    iIdx = 0;
    jIdx = 0;
    kIdx = 0;

    /* initialize */
    existFlg = [];
    
    /* ファイル初期化 実行項目確認用フラグのクリア */
    specExecFlg		= 0;
    reginfoExecFlg	= 0;
      
    /* 現在の mac_info.ini から、企業コード・店舗コード を取得し保存する*/
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();
    DbInitTable.oldcompcd = macInfo.system.crpno;
    DbInitTable.oldstrecd = macInfo.system.shpno;

    TprLog().logAdd(FINIT_LOG, LogLevelDefine.normal,"freq: FINIT : mac_info(before) crpno[${DbInitTable.oldcompcd}] shpno[${DbInitTable.oldstrecd}]");

    // 選択されている項目総数と実行インデックスを初期化
    selectedItemTotal = getSelectedTotalCount();
    executeItemIndex = 0;

    
    /* ファイル初期化実行 */
    fInitExecExec ();
  }

  /// 機能概要     : ファイル初期設定 主処理
  /// 関連tprxソース: freq.c - finit_exec_exec
  static Future<void> fInitExecExec() async {
    int dbRet = 0;
    int specFlg = 0;
    int specJccFlg = 0;
    int cashRecycleFlg = 0;
    String status = "";

    final FileRequestPageController ctrl = Get.find();

    // 共有メモリ呼び出し
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    /* stop timer and timer-ID initialize */
    if (freqPtimer != 0) {
      Fb2Gtk.gtkTimeoutRemove(freqPtimer);
      freqPtimer = 0;
    }

    /* set finit status */
    freqStatus = 1 ;

    /** 画面上の１項目に対しての処理を行う **/

    /* check active flag and ename */
    if (crItem[iIdx].aFlg || crItem[iIdx].data[jIdx].selFlg) {

      /* set execute flag */
      execFlg = 1;

      // if(( existFlg[iIdx] != 1 )){
      //   /* delete text in text field */
      //   gtk_editable_delete_text( GTK_EDITABLE(text_wr[r_page[i_idx].txt_no[j_idx]].text2 ),
      //                       0, -1 );
      //   gtk_editable_delete_text( GTK_EDITABLE(text_wr[r_page[i_idx].txt_no[j_idx]].text3 ),
      //                       0, -1 );
      //   exist_flg[r_page[i_idx].txt_no[j_idx]] = 1;
      // }

      if (crItem[iIdx].data[kIdx].eName == "m_reserv_log") {
        fInitExecReservFl();
      }

      /* レジ機能関連->レジ情報マスタ(c_reginfo_mst)の指定が有った場合、フラグ保持 */
      if (crItem[iIdx].data[kIdx].eName == "c_reginfo_mst") {
        reginfoExecFlg = 1;
      }

      /* スペック関連 */
      if (crItem[iIdx].data[kIdx].eName == "spec") {
        specExecFlg = 1; // スペック関連の更新があったことをセット
      }

      /* execute db initializing library */
      if (specFlg != 1 && specJccFlg != 1  && cashRecycleFlg != 1) {

        if (allselectFlg	// 全部選択
            && (crItem[iIdx].data[jIdx].eName == "p_recog_mst")) {
          dbRet = DbError.DB_SKIP;
        } else {
          /* テーブル初期化 */
          dbRet = await DbInitTable().dbInitTable( 0, crItem[iIdx].data[jIdx].eName);
        }
        crItem[iIdx].data[jIdx].result = dbRet;

        /* set 1 to exist flag   */
        crItem[iIdx].data[jIdx].execFlg = 1;

        if (crItem[iIdx].data[jIdx].eName == "memo") {
          LibFbMemo.tmemoReadFlgSet( FINIT_LOG, null, pCom );	// 連絡メモ未読フラグセット
        }
        if (crItem[iIdx].data[jIdx].eName == "c_memo_mst") {
          LibFbMemo.memoReadFlgSet( FINIT_LOG, null, pCom );	// 常駐メモ未読フラグセット
        }

        /* normal return value */
        if (dbRet == DbError.DB_SUCCESS
          || dbRet == DbError.DB_SKIP)
        {
          // if(db_ret == DB_SKIP)
          // {
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //       NULL, MSG_SKIP, strlen(MSG_SKIP));
          // }
          // else
          // {
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //       NULL, SPEC_OK, strlen(SPEC_OK));
          // }
          // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //               NULL, "\n", strlen("\n"));
          // }
          // gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
          //             NULL, " ", strlen(" "));
          // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
          //               NULL, "\n", strlen("\n"));
          // }
        }

        /* error return value */
        else{
          // if( db_ret == DbError.DB_FILENOTEXISTERR ) {
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //                     NULL, SPEC_OK, strlen(SPEC_OK));
          // } else {
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //                     NULL, SPEC_NG, strlen(SPEC_NG));
          // }
          // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
          //               NULL, "\n", strlen("\n"));
          // }

          /* set status message */
          switch( dbRet ){
            case  DbError.DB_ARGERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Error in parameter for dbInitTable ", 
                errId: DbError.DB_ARGERR);
              status = LFreq.MSG_ARGERR;
              break;
            case  DbError.DB_FILEDELERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Error in deleting file ", 
                errId: DbError.DB_FILEDELERR);
              status = LFreq.MSG_FILEDELERR;
              break;
            case  DbError.DB_FILECPYERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Error in coping file ", 
                errId: DbError.DB_FILECPYERR);
              status = LFreq.MSG_FILECPYERR;
              break;
            case  DbError.DB_CONNECTIONERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Error in connecting DB ", 
                errId: DbError.DB_CONNECTIONERR);
              status = FreqDefine.MSG_CONNECTIONERR;
              break;
            case  DbError.DB_TABLENOTFOUND:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Error by [table not found] ", 
                errId: DbError.DB_TABLENOTFOUND);
              status = LFreq.MSG_TABLENOTFOUND;
              break;
            case  DbError.DB_FILENOTEXISTERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: File not exist error ", 
                errId: DbError.DB_TBLDELETEERR);
              status = LFreq.MSG_FILENOTEXISTERR;
              break;
            case  DbError.DB_TBLDELETEERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Table delete error ", 
                errId: DbError.DB_TBLDELETEERR);
              status = LFreq.MSG_TBLDELERR;
              break;
            case  DbError.DB_OTHERERR:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Other error ", 
                errId: DbError.DB_TBLDELETEERR);
              status = " ";
              break;
            default:
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Other error in DB library ", 
                errId: -1);
              status = LFreq.MSG_TBLDELERR;
              break;
          }

          // gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
          //                   NULL, status, strlen(status));
          // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
          //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
          //                   NULL, "\n", strlen("\n"));
          // }
        }
        crItem[iIdx].data[jIdx].status = status;
      }

      // 選択項目の実行数を更新
      executeItemIndex ++;
    } else {
      //未選択行：結果欄はブランクとし次の行へ

      // if( exist_flg[r_page[i_idx].txt_no[j_idx]] != 1 ){

      //   /* delete text in text field */
      //   gtk_editable_delete_text( GTK_EDITABLE(text_wr[r_page[i_idx].txt_no[j_idx]].text2 ),
      //                   0, -1 );
      //   gtk_editable_delete_text( GTK_EDITABLE(text_wr[r_page[i_idx].txt_no[j_idx]].text3 ),
      //                   0, -1 );

      //   exist_flg[r_page[i_idx].txt_no[j_idx]] = 1;
      // }

      // gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
      //                 NULL, " ", strlen(" "));
      // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
      //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text2 ), NULL, NULL,
      //                   NULL, "\n", strlen("\n"));
      // }
      // gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
      //                 NULL, " ", strlen(" "));
      // if( r_page[i_idx].txt_no[j_idx] == r_page[i_idx].txt_no[j_idx+1] ){
      //   gtk_text_insert( GTK_TEXT( text_wr[r_page[i_idx].txt_no[j_idx]].text3 ), NULL, NULL,
      //                   NULL, "\n", strlen("\n"));
      // }
      crItem[iIdx].data[jIdx].result = 0;
      crItem[iIdx].data[jIdx].status = "";
      crItem[iIdx].data[jIdx].execFlg = 0;
    }

    /** 次の項目へインデックスを更新 **/

    /* increment i_idx and j_idx */
    if (iIdx < mItemNum) {
      if (jIdx < crItem[iIdx].totalTbl - 1) {
        jIdx++;
      } else {
        jIdx = 0;
        iIdx++;
      }
    }

    // 画面データ更新
    ctrl.dispData.refresh();

    /** 次の項目があれば、再度呼び出し **/
    if (iIdx < mItemNum) {
      freqPtimer = Fb2Gtk.gtkTimeoutAdd( 20, fInitExecExec, 0 );
      return;
    } else {
      /** すべての項目に対しての処理が完了したら、以下の処理へ **/
      // 画面再描画し、ファイル初期化 後半処理へ
      freqPtimer = Fb2Gtk.gtkTimeoutAdd ( FREQ_WAIT, fInitExecExec2, 0 );
    }
  }

  /// 機能概要     : ファイル初期設定(予約ファイル関連)処理
  /// 関連tprxソース: freq.c - finit_exec_reserv_fl
  static void fInitExecReservFl() {
    File rsvFile = TprxPlatform.getFile("/web21ftp/rsv/RsvReGet.txt");
    if (rsvFile.existsSync()) {
      rsvFile.deleteSync();
    }
  }

  /// 機能概要     : ファイル初期設定 後半処理
  /// 関連tprxソース: freq.c - finit_exec_exec2
  static Future<void> fInitExecExec2() async {
    int i = 0;
    int libRet;
    int newstrecd;
    int newcompcd;
    int newmacno;

    int j = 0;
    int	grp;
    int	tbl;

    // タイマー削除
    if( freqPtimer != -1 )
    {
      Fb2Gtk.gtkTimeoutRemove(freqPtimer);
      freqPtimer = -1;
    }

    /* 処理後の mac_info.ini から、企業コード・店舗コード・端末番号 を取得し保存する*/
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();
    newcompcd = macInfo.system.crpno;
    newstrecd = macInfo.system.shpno;
    newmacno = macInfo.system.macno;

    TprLog().logAdd(FINIT_LOG, LogLevelDefine.normal,
      "freq: FINIT: mac_info(after) crpno[$newcompcd] shpno[$newstrecd] macno[$newmacno]");

    /* レジ機能関連->レジ情報マスタ(c_reginfo_mst) または スペック関連->マシン環境(mac_info.ini) の更新があった */
    if (reginfoExecFlg != 0 || specExecFlg != 0) {
      TprLog().logAdd(FINIT_LOG, LogLevelDefine.normal,
        "freq: FINIT : update compcd and strecd on tables : flgs[reginf:$reginfoExecFlg spec:$specExecFlg]");

      /* 各テーブルの企業コードを更新する */
      if (await ChgStreCd.chgCorpCd (FINIT_LOG, false, DbInitTable.oldcompcd, newcompcd) != 0)
      {
        TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: chgcorpcd ERROR.", errId: -1);
      }

      /* 各テーブルの店舗コードを更新する */
      if (await ChgStreCd.chgStreCd (FINIT_LOG, false, DbInitTable.oldstrecd, newstrecd) != 0)
      {
        TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: chgstrecd ERROR.", errId: -1);
      }
    }

    // #if 0
    //   /* create_mm を実行する */
    //   memset ( system_cmd,0,sizeof(system_cmd) );
    //   sprintf ( system_cmd, CMD_CREATE_MM, SysHomeDirp, newcompcd, newstrecd, newmacno );
    // //	system ( system_cmd );  下のAplLibSystemCmd() で実行しているので不要

    //   snprintf ( erlog, sizeof(erlog), __FILE__": FINIT : exec. (%s)", system_cmd );
    //   TprLibLogWrite ( FINIT_LOG, TPRLOG_NORMAL, 0, erlog );
    //   AplLibSystemCmd(FINIT_LOG, system_cmd);	// エラーでも処理継続
    // #else
    /* 初期化したテーブルに対応するMM*.outファイルを適用する */
    await finitReadMmoutfiles (newcompcd, newstrecd, newmacno);

    /* 初期化したテーブルに対応する ユーザー毎設定ファイルを適用する */
    finitReadFilesForUsers (newcompcd, newstrecd, newmacno);
    // #endif


    /* M/S仕様 ms_xxxxx.out の初期データ挿入を追加 */
    await finitReadInitDataMmSystem (newcompcd, newstrecd);

    // グループコード０を作成する. 該当テーブルが選択された場合のみ. 
    for( grp = 0 ; grp < mItemNum ; grp++ )
    {
      for( tbl = 0; tbl < crItem[grp].totalTbl; tbl++ )
      {
        if (crItem[grp].data[tbl].selFlg)
        {
          if(crItem[grp].data[tbl].eName == "c_trm_mst") {
            await AplLibTrmSysCheck.setReferenceData( FINIT_LOG, newcompcd, newstrecd, "trm_grp_cd" );
          }
          else if(crItem[grp].data[tbl].eName == "c_stropncls_mst") {
            await AplLibTrmSysCheck.setReferenceData( FINIT_LOG, newcompcd, newstrecd, "stropncls_grp" );
          }
          else if(crItem[grp].data[tbl].eName == "c_cashrecycle_mst") {
            await AplLibTrmSysCheck.setReferenceData( FINIT_LOG, newcompcd, newstrecd, "cashrecycle_grp" );
          }
        }
      }
    }

    // 承認キーの情報をp_recog_mstに展開
    await RxPrtFlagSet.rcSetDBToSysiniRecog (FINIT_LOG);	// 本関数内で、p_recog_mstテーブルに反映を行っている

    for( i = 0 ; i < mItemNum ; i++ ){
      if( crItem[i].aFlg){
        // #ifdef  CUSTOM_WID
        //   gtk_round_button_set_color( GTK_ROUND_BUTTON (
        //                   btn_wr[i].button), TPR_CL_TB);
        // #else
        //   memcpy( &bg, sysGetColorIdx("TB"),sizeof(GdkColor));
        //   memcpy( &fg, sysGetColorIdx("BG"),sizeof(GdkColor));
        //   memcpy( &text, sysGetColorIdx("BG"),sizeof(GdkColor));

        //   style = sysChangeButtonStyle( btn_wr[i].button, fg, text, bg );
        //   SetStyleRecursively( btn_wr[i].button, (gpointer)style );
        // #endif

        crItem[i].aFlg = false;
      }

      for(j = 0; j < crItem[i].totalTbl; j++){
        crItem[i].data[j].selFlg = false;
      }
      // UpdateTableList(i);
    }

    /* set [all select] button color */
    // #ifdef  CUSTOM_WID
    //     gtk_round_button_set_color (GTK_ROUND_BUTTON (freq_button3),
    //                         TPR_CL_TB);
    // #else
    //     memcpy( &bg, sysGetColorIdx("TB"),sizeof(GdkColor));
    //     memcpy( &fg, sysGetColorIdx("BG"),sizeof(GdkColor));
    //     memcpy( &text, sysGetColorIdx("BG"),sizeof(GdkColor));

    //     style = sysChangeButtonStyle( freq_button3, fg, text, bg );
    //     SetStyleRecursively( freq_button3, (gpointer)style );
    // #endif

    /* copy ini file to shared memory */
    libRet = (await RmIniRead().rmIniReadMain()).dlgId;
    if (libRet != 0) {
      TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: An error from rmIniReadMain function", errId: libRet);
    }

    /* copy DB to shared memory */
    libRet = (await RmDBRead().rmDbReadMain()).dlgId;
    if (libRet != 0) {
      TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: An error from rmDbReadMain function", errId: libRet);
    }
    
    final FileRequestPageController ctrl = Get.find();
    ctrl.execStatus.value = LFreq.FINISH_FINIT;

    /* reset finit status */
    freqStatus = 0 ;

    /* reset select all flag */
    allselectFlg = false;
    freqDlg = 0;


    /* error dialog for disk full */
    if(DbInitTable.finitDiskFull == 1 ){
      /* write error to log file */
      TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "Finit: Hard Disk full error");

      /* set structure for Error dialog */
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        title: LFreq.FREQ_ERR_TITLE,
        dialogId: DlgConfirmMsgKind.MSG_DISKFULL.dlgId));
      
      freqDlgtimer = Fb2Gtk.gtkTimeoutAdd( 1000, freqDlgFlgClr, 0 );
      freqDlg = 1;
      DbInitTable.finitDiskFull = 0;
    }

    ctrl.dispData.refresh();

    // クイックセットアップは実装対象外
//     if ( pCom->quick_flg == QUICK_SETUP_TYPE_9191 || (pCom->quick_flg == QUICK_SETUP_TYPE_NEW) || (pCom->quick_flg == QUICK_SETUP_TYPE_9194)){
//       if( pCom->quick_flg != QUICK_SETUP_TYPE_NEW ){
//       pCom->quick_proc = 0;
//       pCom->quick_btn = 1;
//       }
//       else{
//         pCom->quick_proc = 0;
//       }
//       pCom->quick_proc = 0;
//       pCom->quick_btn = 1;
//       memset( ini_path,0,sizeof(ini_path));
//       sprintf( ini_path, "%s/conf/sys.ini", SysHomeDirp );
//       if( TprLibSetIni( ini_path, "type", "webplus", pCom->sys_webplus ) != 0 ){
//         TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->webplus" ); 
//       }
//       if( TprLibSetIni( ini_path, "type", "web2300", pCom->sys_web2300 ) != 0 ){
//         TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->web2300" ); 
//       }
//       if( TprLibSetIni( ini_path, "type", "dual", pCom->sys_dual ) != 0 ){
//         TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->dual" ); 
//       }
//       if( TprLibSetIni( ini_path, "type", "webjr", pCom->sys_webjr ) != 0 ){
//         TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->webjr" ); 
//       }
//       if( TprLibSetIni( ini_path, "type", "tower", pCom->sys_tower ) != 0 ){
//         TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->tower" ); 
//       }



// #if CENTOS
// 			memset (file_path, 0x0, sizeof(file_path));
// 			snprintf (file_path, sizeof(file_path), "%s/conf/finit_quick_merge.ini", SysHomeDirp);
// 			memset( get_buf, 0x0, sizeof(get_buf));
// 			ret = TprLibGetIni( file_path, "system", "serialno", get_buf);
// 			if (ret == 0)
// 			{
// 				memset (erlog, 0x0, sizeof(erlog));
// 				snprintf (erlog, sizeof(erlog), "get finit_quick_merge.ini serial set mac_info.ini[%s]\n", get_buf);
// 				memset (file_path, 0x0, sizeof(file_path));
// 				snprintf (file_path, sizeof(file_path), "%s/conf/mac_info.ini", SysHomeDirp);
// 				ret = TprLibSetIni( file_path, "system", "serialno", get_buf );
// 			}
// #endif

//       /* 2009/12/09 >>> */
//       switch( cm_WebType( ) ) {
//         case WEBTYPE_WEB2800 :
//           if( TprLibSetIni( ini_path, "type", "web2800", "yes" ) != 0 ){
//             TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->web2800" ); 
//           }
//           // Speezaの初期設定
//           if( cm_webspeeza_system() == 1 ){
//             char mac_ini_path[256];
//             // タブの表示方法は [追加表示] となる
// #if 0
//             snprintf( mac_ini_path, sizeof(mac_ini_path), "%s/conf/sys.ini", (char *)SysHomeDirp );
//             if( TprLibSetIni( mac_ini_path, "system", "tab_display", "1" ) != 0 ){
//                TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->tab_display" ); 
//             }
// #else
// 		// ターミナル設定マスタの値を設定する
// 		pgCon = db_TprLogin( FREQ_LOG, DB_ERRLOG );
// 		if (pgCon)
// 		{
// 			snprintf (&cmd_buf, sizeof(cmd_buf),
// 				  "UPDATE c_trm_mst SET trm_data='1', upd_datetime='now', upd_user='%lld', upd_system='2' "\
// 				  "WHERE comp_cd='%ld' AND stre_cd='%ld' AND trm_cd='%d';", 
// 				  cm_login_no (), pCom->db_regctrl.comp_cd, pCom->db_regctrl.stre_cd, TRMNO_TAB_DISPLAY);
// 			if ((res = db_PQexec (0, DB_ERRLOG, pgCon, cmd_buf)) == NULL)
// 			{
// 				TprLibLogWrite ( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: set tab_display to c_trm_mst. db_PQexec Error" ); 
// 			}
// 			db_PQclear (0,res);
// 			db_PQfinish( 0, pgCon );
// 		}
// 		else
// 		{
// 			TprLibLogWrite ( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: set tab_display to c_trm_mst. db_TprLogin Error" ); 
// 		}
// #endif
//           }
// 				if ( (pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_9194 || pCom->quick_flg == QUICK_SETUP_TYPE_NEW) && (old_soft_keyb == 1))
// 				{
// 					char mac_ini_path[256];
// 					memset (mac_ini_path, 0x0, sizeof(mac_ini_path));
// 					snprintf( mac_ini_path, sizeof(mac_ini_path), "%s/conf/mac_info.ini", (char *)SysHomeDirp );
// 					if( TprLibSetIni( mac_ini_path, "internal_flg", "soft_keyb", "1" ) != 0 )
// 					{
// 						TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->old_soft_keyb" ); 
// 					}
// 				}
// 				break;

//         case WEBTYPE_WEB2500 :
//           if( TprLibSetIni( ini_path, "type", "web2500", "yes" ) != 0 ){
//             TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->web2500" ); 
//           }

// 				  if ( (pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_9194 || pCom->quick_flg == QUICK_SETUP_TYPE_NEW))
// 				  {
//             if ( cm_rm5900_system ( ) )	// RM-5900の場合、ソフトテンキーを有効にしないと「9191」が続けられない
//             {
//               TprLibLogWrite( TPRAID_QUICK, TPRLOG_NORMAL, 1, "Finit: RM-5900" ); 

//               pCom->ini_macinfo.soft_keyb = 1;

//               char mac_ini_path[256];
//               memset (mac_ini_path, 0x0, sizeof(mac_ini_path));
//               snprintf( mac_ini_path, sizeof(mac_ini_path), "%s/conf/mac_info.ini", (char *)SysHomeDirp );
//               if( TprLibSetIni( mac_ini_path, "internal_flg", "soft_keyb", "1" ) != 0 )
//               {
//                 TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->old_soft_keyb" ); 
//               }
//             }
//           }
//           break;

//         case WEBTYPE_WEB2350 :
//           if( TprLibSetIni( ini_path, "type", "web2350", "yes" ) != 0 ){
//             TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->web2350" ); 
//           }
//           break;

//         case WEBTYPE_WEBPLUS2 :
//           if( TprLibSetIni( ini_path, "type", "webplus2", "yes" ) != 0 ){
//             TprLibLogWrite( TPRAID_QUICK, TPRLOG_ERROR, -1, "Finit: TprLibSetIni->webplus2" ); 
//           }
//           break;

//         default :
//           TprLibLogWrite( TPRAID_QUICK, TPRLOG_NORMAL, 1, "Finit: TprLibSetIni->web[2100/Prime/2200/2300/Plus]" ); 
//           break;
//       }
//       if ( pCom->quick_flg == QUICK_SETUP_TYPE_NEW || pCom->quick_flg == QUICK_SETUP_TYPE_9191 || pCom->quick_flg == QUICK_SETUP_TYPE_9194 ){
//         pCom->quick_proc = 0;
//       quickTimer = Fb2Gtk.gtkTimeoutAdd( FREQ_TIMER, freq_quick_end, 0 );
//       return;
//       } 
//     }
  }

  /// 機能概要     : 初期化したテーブルに対応するMM*.outファイルを適用する
  /// パラメータ   : int compCd : 企業コード
  ///             : int streCd : 店舗コード
  ///             : int macNo : レジ番号
  /// 関連tprxソース: freq.c - finit_read_mmoutfiles
  static Future<void> finitReadMmoutfiles (int compCd, int streCd, int macNo) async {
    int		  i;
    int		  h;
    String erlog = "";
    String filePathName = ""; // xxxx.outファイル フルパス名
    DbManipulationPs db = DbManipulationPs();

    // OUTファイル適用テーブル(各テーブルに対応する.outファイルの対応付け)
    List<FInitOutFilesTbl> outFilesTable = [
      FInitOutFilesTbl("c_reginfo_grp_mst",	"mm_reginfogrpmst.out"),
      FInitOutFilesTbl("c_stre_mst",		"mm_stre.out"),
      FInitOutFilesTbl("c_comp_mst",		"mm_stre.out"),
      FInitOutFilesTbl("c_regcnct_sio_mst",	"mm_regcnct_sio.out"),
      FInitOutFilesTbl("c_sio_mst",		"mm_siomst.out"),
      FInitOutFilesTbl("c_tax_mst",		"mm_tax.out"),
      FInitOutFilesTbl("c_staff_mst",		"mm_staff.out"),
      FInitOutFilesTbl("c_staffauth_mst",	"mm_auth.out"),
      FInitOutFilesTbl("c_img_mst",		"mm_imgmst.out"),
      FInitOutFilesTbl("c_keyopt_mst",	"mm_kopt.out"),

      FInitOutFilesTbl("c_keyfnc_mst",	"mm_keyfncmst.out"),
      FInitOutFilesTbl("c_msglayout_mst",	"mm_msglayoutmst.out"),
      FInitOutFilesTbl("c_keykind_mst",	"mm_set_keykind.out"),
      FInitOutFilesTbl("c_keykind_grp_mst",	"mm_set_keykind.out"),
      FInitOutFilesTbl("c_keyopt_set_mst",	"mm_set_keyopt.out"),
      FInitOutFilesTbl("c_keyopt_sub_mst",	"mm_set_keyopt.out"),
      FInitOutFilesTbl("c_msglayout_set_mst",	"mm_msglayout_set_mst.out"),
      FInitOutFilesTbl("c_preset_mst",	"mm_preset.out"),
      FInitOutFilesTbl("c_trm_mst",		"mm_trm.out"),
      FInitOutFilesTbl("c_trm_set_mst",	"mm_set_trm.out"),

      FInitOutFilesTbl("c_trm_sub_mst",	"mm_set_trm.out"),
      FInitOutFilesTbl("c_trm_menu_mst",	"mm_set_trm_menu.out"),
      FInitOutFilesTbl("c_trm_tag_grp_mst",	"mm_set_trm_tag.out"),
      FInitOutFilesTbl("c_dialog_mst",	"mm_dialog.out"),
      FInitOutFilesTbl("c_dialog_ex_mst",	"mm_dialog.out"),
      FInitOutFilesTbl("c_fmttyp_mst",	"mm_fmttyp.out"),
      FInitOutFilesTbl("c_barfmt_mst",	"mm_barfmt.out"),
      FInitOutFilesTbl("c_ctrl_mst",		"mm_ctrl.out"),
      FInitOutFilesTbl("c_ctrl_set_mst",	"mm_set_ctrl.out"),
      FInitOutFilesTbl("c_ctrl_sub_mst",	"mm_set_ctrl.out"),

      FInitOutFilesTbl("c_trm_chk_mst",	"mm_trm_chk.out"),
      FInitOutFilesTbl("c_stropncls_mst",	"mm_stropncls.out"),
      FInitOutFilesTbl("c_stropncls_set_mst",	"mm_set_stropncls.out"),
      FInitOutFilesTbl("c_stropncls_sub_mst",	"mm_set_stropncls.out"),
      FInitOutFilesTbl("c_operation_mst",	"mm_operation.out"),
      FInitOutFilesTbl("c_menu_obj_mst",	"mm_menuobj.out"),
      FInitOutFilesTbl("p_trigger_key_mst",	"mm_triggerkey.out"),
      FInitOutFilesTbl("c_appl_grp_mst",	"mm_appgrpmst.out"),
      FInitOutFilesTbl("p_appl_mst",		"mm_appmst.out"),
      FInitOutFilesTbl("c_recog_grp_mst",	"mm_recoggrpmst.out"),

      FInitOutFilesTbl("p_recog_mst",		"mm_recogmst.out"),
      FInitOutFilesTbl("c_recoginfo_mst",	"mm_recoginfomst.out"),
      FInitOutFilesTbl("c_acct_mst",		"mm_acctmst.out"),
      FInitOutFilesTbl("c_tcount_mst",	"mm_tcountmst.out"),
      FInitOutFilesTbl("c_report_mst",	"mm_report.out"),
      FInitOutFilesTbl("c_report_cond_mst",	"mm_report.out"),
      FInitOutFilesTbl("c_report_attr_mst",	"mm_report.out"),
      FInitOutFilesTbl("c_report_attr_sub_mst",	"mm_report.out"),
      FInitOutFilesTbl("c_report_sql_mst",	"mm_report.out"),
      FInitOutFilesTbl("c_finit_mst",		"mm_finitmst.out"),

      FInitOutFilesTbl("c_finit_grp_mst",	"mm_finitgrpmst.out"),
      FInitOutFilesTbl("c_set_tbl_name_mst",	"mm_settblnmmst.out"),
      FInitOutFilesTbl("c_cashrecycle_mst",	"mm_cashrecycle.out"),
      FInitOutFilesTbl("c_cashrecycle_set_mst",	"mm_set_cashrecycle.out"),
      FInitOutFilesTbl("c_cashrecycle_sub_mst",	"mm_set_cashrecycle.out"),
      FInitOutFilesTbl("c_passport_info_mst",	"mm_passport_info.out"),
      FInitOutFilesTbl("c_payoperator_mst",	"mm_payoperatemst.out"),
      FInitOutFilesTbl("c_liqritem_mst",	"mm_liqritem.out"),
      FInitOutFilesTbl("c_liqrtax_mst",	"mm_liqrtax.out")
    ];

    /* ファイル初期化モードでない */
    if (freqCallMode != Rxsys.RXSYS_MSG_FINIT.id)
    {
      TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "freq: finitReadMmoutfiles : illegalMode.", errId: -1);
      return;
    }

    // ファイル初期化 グループ分確認する
    for (i=0; i<mItemNum; i++)
    {
      // グループ内のテーブル数分
      for (h=0; h<crItem[i].totalTbl; h++) 
      {
        // テーブルがファイル初期化対象に選択されていない
        if (!crItem[i].data[h].selFlg)
        {
          continue;
        }

        // 対象テーブルに対応する.OUTファイルを取得してpsqlコマンド実行
        for (FInitOutFilesTbl item in outFilesTable.where((element) => element.tableName == crItem[i].data[h].eName)) {
          // 初期設定値保持ファイル名 のフルパス名を作成
          // assets/sql/insert/mm_*.out
          filePathName = "assets/sql/insert/${item.outFileName}";

          // 初期設定値保持ファイル名 のサイズを取得する
          final File outFile = TprxPlatform.getFile(filePathName);

          if (outFile.existsSync()) { // 成功
            if (outFile.lengthSync() == 0 || outFile.statSync().type != FileSystemEntityType.file) {
              erlog = "freq: finitReadMmoutfiles : size zero. [$filePathName]";
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, erlog, errId: -1);
            } else {
              erlog = "freq: finitReadMmoutfiles : target[${crItem[i].data[h].eName}]";
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.normal, erlog);

              // コマンド実行 (エラー発生でも処理継続)
              await db.execSqlFromAsset(filePathName, ["COMP='$compCd'", "STRE='$streCd'", "MACNO='$macNo'", 'GRP=1']);
            }
          } else { // 失敗
            // ファイル情報取得エラー
            erlog = "freq: finitReadMmoutfiles : stat error. [$filePathName]";
            TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, erlog, errId: -1);
          }
        }
      }
    }
  }
  
  /// 機能概要     : 初期化したテーブルに対応する ユーザー毎の初期化ファイルを実行する
  /// パラメータ   : int compcd : 企業コード
  ///             : int strecd : 店舗コード
  ///             : int macno : レジ番号
  /// 関連tprxソース: freq.c - finit_read_filesForUsers
  static void finitReadFilesForUsers (int compcd, int strecd, int macno) {
    // 既存から関数内定義処理なし
  }

  /// 機能概要     : MS仕様用の初期データの挿入を実行する
  /// パラメータ   : int compcd : 企業コード
  ///             : int strecd : 店舗コード
  /// 関連tprxソース: freq.c - finit_read_initdata_mmsystem
  static Future<void> finitReadInitDataMmSystem(int compCd, int streCd) async {
    int		i;
    int		h;
    String erlog = "";
    String filepathname = ""; // ms_xxxx.outファイル フルパス名
    DbManipulationPs db = DbManipulationPs();


    /* ファイル初期化モードでない */
    if (freqCallMode != Rxsys.RXSYS_MSG_FINIT.id) {
      TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, "freq: finitReadInitDataMmSystem : illegalMode.", errId: -1);
      return;
    }

    if (allselectFlg 	/* 全初期化 */		/* 全初期したときは、TS仕様かMS仕様か判断がつかないため、必ず実行する */
    || CmCksys.cmMmSystem() == 1)	/* M/S仕様 */
    {
      // ファイル初期化 グループ分確認する
      for (i=0; i<mItemNum; i++)
      {
        // グループ内のテーブル数分
        for (h=0; h<crItem[i].totalTbl; h++) 
        {
          // テーブルがファイル初期化対象に選択されていない
          if (!crItem[i].data[h].selFlg)
          {
            continue;
          }
          
          // 初期設定値保持ファイル名(default_file_name) が指定されている
          if (crItem[i].data[h].defaultFileName.isNotEmpty)
          {
            // 初期設定値保持ファイル名 のフルパス名を作成
            // assets/sql/insert/ms_*.out
            filepathname = "assets/sql/insert/${crItem[i].data[h].defaultFileName}";

            // 初期設定値保持ファイル名 のサイズを取得する
            final File outFile = TprxPlatform.getFile(filepathname);

            if (outFile.existsSync()) { // 成功
              if (outFile.lengthSync() == 0 || outFile.statSync().type != FileSystemEntityType.file) {
                erlog = "freq: finitReadInitDataMmSystem : size zero. [$filepathname]";
                TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, erlog, errId: -1);
              } else {
                /* ms_xxxx.out ファイルから、初期データを取込む */

                erlog = "freq: finitReadInitDataMmSystem :target[$filepathname]";
                TprLog().logAdd(FINIT_LOG, LogLevelDefine.normal, erlog);

                // コマンド実行 (エラー発生でも処理継続)
                // #define CMD_TBLINIT_MMSYSTEM	"/usr/local/pgsql/bin/psql -U postgres tpr_db -f %s -v COMP='%ld' -v STRE='%ld';"
                db.execSqlFromAsset(filepathname, ["COMP='$compCd'", "STRE='$streCd'"]);
              }
            }
            else
            { // 失敗
              // ファイル情報取得エラー
              erlog = "freq: finitReadInitDataMmSystem : stat error. [$filepathname]";
              TprLog().logAdd(FINIT_LOG, LogLevelDefine.error, erlog, errId: -1);
            }
          }
        }
      }
    }    
  }

}
/// 関連tprxソース: freq.h
class FreqDefine {
  static const MSG_QUERYERR	= LFreq.MSG_ARGERR;
  static const MSG_CONNECTIONERR = LFreq.MSG_ARGERR;
  static const MSG_COPYREQUESTERR	= LFreq.MSG_ARGERR;
  static const MSG_FTPOPENERR	= LFreq.MSG_ARGERR;
  static const MSG_PARAMERR	= LFreq.MSG_ARGERR;
  static const MSG_DATAGETERR	= LFreq.MSG_COPYGETLINEERR;
  static const MSG_FTPGETERR = LFreq.MSG_COPYGETLINEERR;
  static const MSG_ENDCOPYERR = LFreq.MSG_COPYPUTLINEERR;
  static const MSG_RENAMEERR = LFreq.MSG_COPYPUTLINEERR;

  static const TBL_MAX = 256;
  static const CHAR_NUM	= 16;
  static const MAXCHAR = 256*6;
  static const PG_MAX_BTN	= 7;
  static const PG_MAX_LINE = 14;

  static const PSQL_CMD_PATH = "apl/db";			/* TPR-APL-IT-678 */

/* SQL Strings */
  static const FREQ_SQL_GET_FINIT_GRP_RECS =
      "select * from c_finit_grp_mst order by finit_grp_cd asc;";

  static const FREQ_SQL_GET_FINIT_RECS = "select "
      "ini_mst.set_tbl_name as set_tbl_name, tbl_nm_mst.disp_name as disp_name, "
      "ini_mst.set_tbl_typ, ini_mst.finit_dsp_chk_div as dsp_chk_div, "
      "ini_mst.freq_ope_mode, ini_mst.offline_chk_flg, ini_mst.seq_name, "
      "ini_mst.freq_csrv_cnct_skip, ini_mst.freq_csrc_cust_real_skip, "
      "ini_mst.freq_csrv_cnct_key, ini_mst.freq_csrv_del_oth_stre, "
      "ini_mst.svr_div, ini_mst.default_file_name "
      "from c_finit_mst ini_mst "
      "left outer join c_set_tbl_name_mst tbl_nm_mst "
      "on (tbl_nm_mst.set_tbl_name = ini_mst.set_tbl_name) "
      "where ini_mst.finit_grp_cd = '%d' and ini_mst.finit_dsp_chk_div <> 999 "
      "order by ini_mst.finit_cd asc;";

  static const FREQ_SQL_GET_FREQ_RECS = "select "
      "ini_mst.set_tbl_name as set_tbl_name, tbl_nm_mst.disp_name as disp_name, "
      "ini_mst.set_tbl_typ, ini_mst.freq_dsp_chk_div as dsp_chk_div, "
      "ini_mst.freq_ope_mode, ini_mst.offline_chk_flg, ini_mst.seq_name, "
      "ini_mst.freq_csrv_cnct_skip, ini_mst.freq_csrc_cust_real_skip, "
      "ini_mst.freq_csrv_cnct_key, ini_mst.freq_csrv_del_oth_stre, "
      "ini_mst.svr_div, ini_mst.default_file_name "
      "from c_finit_mst ini_mst "
      "left outer join c_set_tbl_name_mst tbl_nm_mst "
      "on (tbl_nm_mst.set_tbl_name = ini_mst.set_tbl_name) "
      "where ini_mst.finit_grp_cd = '%d' and ini_mst.freq_dsp_chk_div <> 999 "
      "order by ini_mst.finit_cd asc;";

  static const FREQ_SQL_GET_RMST_FREQ_RECS = "select "
      "ini_mst.set_tbl_name as set_tbl_name, tbl_nm_mst.disp_name as disp_name, "
      "ini_mst.set_tbl_typ, ini_mst.rmst_freq_dsp_chk_div as dsp_chk_div, "
      "ini_mst.freq_ope_mode, ini_mst.offline_chk_flg, ini_mst.seq_name, "
      "ini_mst.freq_csrv_cnct_skip, ini_mst.freq_csrc_cust_real_skip, "
      "ini_mst.freq_csrv_cnct_key, ini_mst.freq_csrv_del_oth_stre, "
      "ini_mst.svr_div, ini_mst.default_file_name "
      "from c_finit_mst ini_mst "
      "left outer join c_set_tbl_name_mst tbl_nm_mst "
      "on (tbl_nm_mst.set_tbl_name = ini_mst.set_tbl_name) "
      "where ini_mst.finit_grp_cd = '%d' and ini_mst.freq_dsp_chk_div <> 999 "
      "order by ini_mst.finit_cd asc;";
}

/// 関連tprxソース: freq.c - FINIT_OUTFILESTBL
class FInitOutFilesTbl {
  final String tableName;       // 初期化テーブル名
  final String outFileName;     // 対応する OUTファイル名(ファイル名のみ)
  FInitOutFilesTbl(this.tableName, this.outFileName);
}
