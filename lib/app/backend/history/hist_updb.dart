/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sprintf/sprintf.dart';

import '../../../db_library/src/db_manipulation.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../webapi/bean/hist_log_down_response.dart';
import '../../../webapi/src/webapi.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/db_error.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/apllib/apllib_staffpw.dart';
import '../../lib/apllib/lib_fb_memo.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/fl_rsh/crt_rsh.dart';
import 'hist_main.dart';
import 'hist_proc.dart';

/// 関連tprxソース: hist_updb.c
class HistUpDb{
  static const HIST_SKIP_NUM_SIZ = 11;	/* MAX 10Figure+',' x 50 limit + alpha */
  static const HIST_SKIP_NUM_MAX = 100;
  static const RETRY_MAX = 5;
  static const RETRY_SLEEP = 1000;

  static int histSkipNum = 0;
  static List<int> histSkipNumBuf = List.filled(HIST_SKIP_NUM_MAX, 0);

  static const CHK_NORMAL_HIST_FLG = 0;
  static const CHK_COPY_HIST_FLG = 1;

  static const HIST_STDPROM_TNAME	= "stamp";
  static const HIST_STDPROM_LCL_PATH = "%s/bmp/std_prom/";

  static const HIST_WAITTIME = 100000;

  static int histFtpRet = 0;

  static CHistlogChgCntColumns histLogChgColumuns = CHistlogChgCntColumns();

  /// error create text file
  /// 関連tprxソース: hist_updb.c - hist_DBERR_TXT_delete
  static void histDBERRTXTDelete(TprMID tid) {
    String txtName = sprintf(DbError.DBERR_TXT, [EnvironmentData().sysHomeDir]);
    File fp = TprxPlatform.getFile(txtName);

    if (fp.existsSync()) {
      try {
        fp.deleteSync();
        TprLog().logAdd(tid, LogLevelDefine.normal, "DBERR_TXT delete ok");
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "histDBERRTXTDelete : DBERR_TXT delete error,$e,$s");
      }
    }
  }

  /// 関連tprxソース: hist_updb.c - hist_UpTableFromSrx
  static Future<(int, int)> histUpTableFromSrx(
      TprMID tid, int pTuples, int limitCnt) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (0, 0);
    }
    RxCommonBuf pCom = xRet.object;
    String sql = '';
    int tuples = 0;
    int i = HistMain.HIST_NG;
    int j = HistMain.HIST_NG;
    int result = HistMain.HIST_NG;
    int counterCd = 0;
    String tmpBuf = '';
    String saveHistDate = '';
    int histCd = 0;
    String erLog = '';
    String histLogName = '';
    CHistlogMstColumns tHistLogMst = CHistlogMstColumns();
    TableInfo tTblInf = TableInfo();
    TableInfo pTblInf = TableInfo();
    int memoFlg = 0;
    String txtName = '${EnvironmentData().sysHomeDir}/log/dberr.txt';
    File file = TprxPlatform.getFile(txtName);
    String callFunc = 'histUpTableFromSrx';
    DbManipulationPs db = DbManipulationPs();
    Result res;

    pTblInf = tTblInf;
    pTblInf.next = null;

    AplLibOther.aplLibGetMstName("c_histlog_mst", histLogName, "",
        PartitionType.PART_TYPE_NORMAL.type); // パーティショニング取得

    pTuples = 0;
    counterCd = 1;

    await histSkipNumRead(tid);

    try {
      sql =
          "select hist_cd, TO_CHAR(ins_datetime, 'YYYY-MM-DD HH24:MI:SS') as ins_datetime from c_histlog_chg_cnt where counter_cd='$counterCd';\n";

      try {
        res = await db.dbCon.execute(sql);
        if (res.length != 1) {
          //Cソース「db_PQntuples() != 1」時に相当
          erLog =
              "Can't read local c_histlog_chg_cnt[$counterCd] tuples[${res.length}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
          return (0, 0);
        }

        Map<String, dynamic> data = res.elementAt(0).toColumnMap();

        histLogChgColumuns.hist_cd = int.tryParse(data["hist_cd"]) ?? 0;
        histLogChgColumuns.counter_cd = counterCd;
        histLogChgColumuns.ins_datetime = data["ins_datetime"].toString();
      } catch (e) {
        //Cソース「db_PQexec() == NULL」時に相当
        erLog = "Can't read local c_histlog_chg_cnt[%$counterCd]\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
        return (0, 0);
      }

      // 履歴ログ取得
      List<CHistlogMstColumns> histRes = await callGetHistLogAPI(pCom, limitCnt);
      tuples = histRes.length;

      for (i = 0; i < tuples; i++) {
        // テーブル更新 実行確認
        if (CmCksys.cmMmType() == CmSys.MacS) {
          // Sレジ の場合
          // 履歴ログの対象テーブルが "s_cust_xxxx_tbl" の場合 テーブル更新しない
          if (histRes[i].table_name != null) {
            if (histRes[i].table_name?.compareTo("s_cust_ttl_tbl") == 0 ||
                histRes[i].table_name?.compareTo("s_cust_loy_tbl") == 0 ||
                histRes[i].table_name?.compareTo("s_cust_cpn_tbl") == 0) {
              histRes[i].mode = -1; // switch文で処理をスキップさせる
            }
          } else {
            histRes[i].mode = -1; // switch文で処理をスキップさせる
          }
        }

        switch (histRes[i].mode) {
          case 0:
            /* INSERT or UPDATE */
            var (
              int histFlg,
              CHistlogMstColumns tHistLogMst,
              List<TableInfo> tInfoSt
            ) = await histTblInfo(tid, histRes[i], pTblInf,
                pCom.iniMacInfo.system.crpno, pCom.iniMacInfo.system.shpno);
            if (histFlg == HistMain.HIST_OK) {
              if (await updSqlCreate(tid, tHistLogMst, tInfoSt) <= 0) {
                await insSqlCreate(tid, tHistLogMst, tInfoSt);
              }
            }
            pTblInf = TableInfo();
            break;
          case 1:
            /* DELETE */
            var (
              int histFlg,
              CHistlogMstColumns tHistLogMst,
            List<TableInfo> tInfoSt
            ) = await histTblInfo(tid, histRes[i], pTblInf,
                pCom.iniMacInfo.system.crpno, pCom.iniMacInfo.system.shpno);
            if (histFlg == HistMain.HIST_OK) {
              await delSqlCreate(tid, tHistLogMst, tInfoSt);
            }
            pTblInf = TableInfo();
            break;
          case 2:
            /* DATA SQL EXECUTE */
            await histDataSqlExec(tid, histRes[i]);
            break;
          case 3:
            /* TRUNCATE */
            sql = "truncate ${histRes[i].table_name};\n";
            for (j = 0; j < RETRY_MAX; j++) {
              try {
                HistProc.histTprRes = await db.dbCon.execute(sql);
                // db_PQclear(tid, hist_tpr_res);
                HistProc.histTprRes = null;
                break;
              } catch (e) {
                //Cソース「db_PQexec() == NULL」時に相当
                // TODO:10152 履歴ログ 既存ソースにてコンパイルスイッチが0のためコメントアウト
                // hist_Err_Sql_Create(tid, 0, sql);
                erLog = "[$sql] error[$j]\n";
                TprLog().logAdd(tid, LogLevelDefine.error, erLog);

                txtName = '${EnvironmentData().sysHomeDir}/log/dberr.txt';
                file = TprxPlatform.getFile(txtName);
                if (file.existsSync()) {
                  erLog = "DBERR_TXT_found break";
                  TprLog().logAdd(tid, LogLevelDefine.error, erLog);
                  break;
                }
              }
            }
            break;
          case 4:
            /* COPY */
            histRequest(tid, i, "copy", histRes[i]);
            break;
          case 5:
            /* TAR COPY */
            histRequest(tid, i, "tar_copy", histRes[i]);
            break;
          case 6:
          /* cmd_id */
          case 7:
          case 8: // cmd_id
          case 9:
          case 10: // ini get
            if (histRes[i].table_name?.compareTo("") != 0) {
              /* cmd_id is NULL */
              erLog = "$callFunc mode[${histRes[i].mode}] cmd_id is NULL\n";
              TprLog().logAdd(tid, LogLevelDefine.error, erLog);
            } else {
              if (histRes[i].mode == 9) {
                // 画像削除
                // TODO:10152 履歴ログ 後回し
                // hist_ImgDifDelete(tid, &histRes[i]);
              } else {
                histRequest(tid, i, histRes[i].table_name!, histRes[i]);
              }
            }
            break;
          case 11:
            /* COPY(M,ST以外) */
            histRequest(tid, i, "copy_notM", histRes[i]);
            break;
          default:
            erLog =
                "$callFunc illegal mode[${histRes[i].mode}]. table_name[${histRes[i].table_name}] hist_cd[${histRes[i].hist_cd}]\n";
            TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
            break;
        }

        txtName = '${EnvironmentData().sysHomeDir}/log/dberr.txt';
        file = TprxPlatform.getFile(txtName);

        if (file.existsSync()) {
          erLog = "DBERR_TXT_found return";
          return (0, 0);
        }

        if (histFtpRet != 0) {
          erLog = "hist_ftp_ret return";
          return (0, 0);
        }

        if (histRes[i].hist_cd != null) {
          if (histRes[i].hist_cd! < histCd) {
            sql =
                "skip update count : $tid : cd[${histRes[i].hist_cd}] date[${histRes[i].ins_datetime}] counter[$counterCd]";
            TprLog().logAdd(tid, LogLevelDefine.normal, sql);
          } else {
            sql =
                "update count : $tid : cd[${histRes[i].hist_cd}] date[${histRes[i].ins_datetime}] counter[$counterCd]";
            TprLog().logAdd(tid, LogLevelDefine.normal, sql);
            sql =
                "update c_histlog_chg_cnt set hist_cd='${histRes[i].hist_cd}',ins_datetime='${histRes[i].ins_datetime}' where counter_cd='$counterCd'\n";

            try {
              HistProc.histTprRes = await db.dbCon.execute(sql);
            } catch (e) {
              erLog = "[$sql] error\n";
              return (0, 0);
            }

            HistProc.histTprRes = null;
          }
        }

        pTuples += 1;
        if (tid == Tpraid.TPRAID_HIST) {
          if (await HistProc.histPipeChk(tid) == HistMain.HIST_NG) {
            erLog = "hist_PipeChk Error[$sql]\n";
            return (0, 0);
          }
          await Future.delayed(const Duration(microseconds: HIST_WAITTIME));
        }

        if (histRes[i].table_name != null) {
          if ((memoFlg != 1) &&
              (histRes[i].table_name?.compareTo("c_memo_mst") == 0)) {
            memoFlg = 1;
          }
        }
      }
    } catch (e) {
      // 元ソースのgoto文の置き換えのためcatchしない
    } finally {

      result = HistMain.HIST_OK;

      if(tuples == 0){
        erLog = "$callFunc $histLogName no tuple  hist_cd[$histCd] date[$saveHistDate] skipnum[$histSkipNum]\n";
        result = HistMain.HIST_NO_TUPLE;
      }

      if (memoFlg == 1) {
        // LibFbMemo.memoReadFlgSet( tid, hist_tpr_con, pCom);	// 常駐メモ未読フラグセット
        LibFbMemo.memoReadFlgSet(tid, null, pCom); // 常駐メモ未読フラグセット
      }

      if (HistProc.histSrxResSave != null) {
        // db_PQclear(tid, hist_srx_res_save);
      }

      HistProc.histSrxResSave = null;

      if (HistProc.histTprRes != null) {
        // db_PQclear(tid, hist_tpr_res);
      }

      HistProc.histTprRes = null;

      if (erLog.isNotEmpty) {
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      }
    }

    return (result, pTuples);
  }

  /// 関連tprxソース: hist_updb.c - UpdSqlCreate
  static Future<int> updSqlCreate(
      TprMID tid, CHistlogMstColumns tHistLogMst, List<TableInfo> tInfoSt) async {
    TableInfo? tInfoWp = TableInfo();
    String sql = '';
    String query = '';
    String where = '';
    int delimitFlg = 0;
    int whereFlg = 0;
    String erLog = '';
    HistTableLogData dataLog = HistTableLogData();
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    tInfoWp = null;
    delimitFlg = whereFlg = 0;

    dataLog.type = 0;

    if (tHistLogMst.table_name != null) {
      query = 'UPDATE ';
      query += tHistLogMst.table_name!;
      query += ' SET ';

      for (int i = 0; i < tInfoSt.length; i++) {
        if (delimitFlg == 1) {
          query += ',';
        }
        tInfoWp = tInfoSt[i];

        query += tInfoWp.colName;
        query += '=';
        query += controlAdj(tInfoWp.data);
        delimitFlg = 1;

        if (tInfoWp.key != 0) {
          if (whereFlg == 1) {
            where += ' AND ';
          } else {
            where += ' WHERE ';
          }

          where += tInfoWp.colName;
          where += "=";
          where += controlAdj(tInfoWp.data);
          whereFlg = 1;
        }

        (dataLog, tInfoWp) = histTableLog(dataLog, tInfoWp);
      }

      sql = query;
      sql += where;
      ret = await histDBExec(tid, sql);
      if (dataLog.keyLog.isNotEmpty) {
        if (ret <= 0) {
          erLog = "INS($ret) ${dataLog.keyLog}";
        } else {
          histChkAlertTable(
              tid, ret, tHistLogMst.table_name!, CHK_NORMAL_HIST_FLG);
          erLog = "UPD ${dataLog.keyLog}";
        }
        TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
      }
    }

    /* スペックチェンジファイル作成機能 */
    if (pCom.specChgCrtSts == 1 && ret > 0) {
      // TODO:10152 履歴ログ 後回し
      // dbLib_crtSql(sql);
    }

    return ret;
  }

  /// 関連tprxソース: hist_updb.c - ControlAdj
  static String controlAdj(String? data) {
    String value = '';
    String valueBuf = '';

    if (data == null || data.isEmpty) {
      value = 'NULL';
    } else {
      // TODO:00013 三浦 該当する関数がないため、エスケープする関数実装する？
      // PQescapeString(valueBuf, data, data.length);
      valueBuf = data;
      value = "'$valueBuf'";
    }
    return value;
  }

  /// 機能:	特定テーブルへの反映がエラーだった場合, その結果をファイルに残す.
  /// 引数:	ret: テーブルへの反映結果
  ///	tblCopyFlg = CHK_NORMAL_HIST_FLG の場合  1以上: 成功  0: 未反映(updateやdeleteで対象レコードが存在しないなど)  -1以下: 失敗
  ///	tblCopyFlg = CHK_COPY_HIST_FLG の場合  1: SKIP  0: 成功(COPY反映)  -1以下: 失敗
  ///	tableName: テーブル名称
  ///	tblCopyFlg: CHK_NORMAL_HIST_FLG:COPY取得ではない  CHK_COPY_HIST_FLG:COPY取得
  /// 関連tprxソース: hist_updb.c - hist_chk_alert_table
  // TODO:00013 三浦 保留
  static void	histChkAlertTable(TprMID tid, int ret, String tableName, int tblCopyFlg) {
    return;
  }

  /// 機能:	mode = 0 or 1 の時に主キーや重要な項目(売価など)を引数のdataLogにセットしていく
  /// 引数:	dataLog: ログ格納先
  /// tInfoWp: テーブル情報
  /// 関連tprxソース: hist_updb.c - hist_tableLog
  static (HistTableLogData, TableInfo) histTableLog(HistTableLogData dataLog, TableInfo tInfoWp) {
    String tempLog = '';

    if (tInfoWp.colName.compareTo("comp_cd") != 0 &&
        tInfoWp.colName.compareTo("stre_cd") != 0) {
      if (tInfoWp.key == 0 && dataLog.type == 1) { // delete の時はpkeyだけ
        return (dataLog, tInfoWp);
      }

      if (tInfoWp.key != 0
          || tInfoWp.colName.compareTo("pos_prc") == 0
          || tInfoWp.colName.compareTo("brgn_prc") == 0
          || tInfoWp.colName.compareTo("trm_data") == 0
          || tInfoWp.colName.compareTo("kopt_data") == 0
          || tInfoWp.colName.compareTo("start_datetime") == 0
          || tInfoWp.colName.compareTo("end_datetime") == 0
          || tInfoWp.colName.compareTo("stop_flg") == 0
      ) {
        tempLog = "${tInfoWp.colName}=${tInfoWp.data} ";
        dataLog.keyLog += tempLog;
      }
    }
    return (dataLog, tInfoWp);
  }

  /// 関連tprxソース: hist_updb.c - hist_DBexec
  static Future<int> histDBExec(TprMID tid, String query) async {
    int i = 0;
    int cmdTuples = 0;
    String erLog = '';
    Result res;
    String chkBuf = '';
    String callFunc = 'histDBExec';
    DbManipulationPs db = DbManipulationPs();

    if (query.isEmpty) {
      TprLog().logAdd(tid, LogLevelDefine.warning, "$callFunc : query is empty");
      return -1;
    }
    for (i = 0; i < RETRY_MAX; i++) {
      try {
        res = await db.dbCon.execute('$query;');

        if (res.affectedRows == 0) {
          return 0;
        }

        cmdTuples = res.affectedRows;

        if (cmdTuples == 0) {
          chkBuf = query;
          chkBuf.toLowerCase(); // 全て小文字に変換

          if (chkBuf.contains("insert ") == true) {
            erLog = "$callFunc : insert is 0. retry";
            TprLog().logAdd(tid, LogLevelDefine.error, erLog);
            continue;
          }
        }
      } catch (e) {
        // Cソース「db_PQexec() == NULL」時に相当
        erLog = "[$query] error[$i]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);

        String txtName = '${EnvironmentData().sysHomeDir}/log/dberr.txt';
        File fp = TprxPlatform.getFile(txtName);

        if (fp.existsSync()) {
          erLog = "DBERR_TXT_found break";
          TprLog().logAdd(tid, LogLevelDefine.error, erLog);
          return -2;
        }
      }
      return cmdTuples;
    }
    return -1;
  }

  /// 関連tprxソース: hist_updb.c - InsSqlCreate
  static Future<void> insSqlCreate(
      TprMID tid, CHistlogMstColumns tHistLogMst, List<TableInfo> tInfoSt) async {
    TableInfo? tInfoWp = TableInfo();
    String sql = '';
    String colName = '';
    String colValue = '';
    int delimitFlg = 0;
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    tInfoWp = null;

    if (tHistLogMst.table_name != null) {
      colName = "INSERT INTO ";
      colName += tHistLogMst.table_name!;
      colName += " (";
      colValue = ") VALUES (";

      for (int i = 0; i < tInfoSt.length; i++) {
        if (delimitFlg == 1) {
          colName += ",";
          colValue += ",";
        }
        tInfoWp = tInfoSt[i];
        colName += tInfoWp.colName;
        colValue += controlAdj(tInfoWp.data);
        delimitFlg = 1;
      }
      colValue += ")";

      sql = colName;
      sql += colValue;
      ret = await histDBExec(tid, sql);
      histChkAlertTable(tid, ret, tHistLogMst.table_name!, CHK_NORMAL_HIST_FLG);
    }

    /* スペックチェンジファイル作成機能 */
    if ((pCom.specChgCrtSts == 1) && (ret > 0)) {
      // TODO:10152 履歴ログ 後回し
      // dbLib_crtSql(sql);
    }
  }

  /// 関連tprxソース: hist_updb.c - DelSqlCreate
  static Future<void> delSqlCreate(TprMID tid, CHistlogMstColumns tHistLogMst,
      List<TableInfo> tInfoSt) async {
    TableInfo? tInfoWp = TableInfo();
    String query = '';
    int whereFlg = 0;
    String erLog = '';
    HistTableLogData dataLog = HistTableLogData();
    int ret;

    tInfoWp = null;
    whereFlg = 0;

    dataLog.type = 1;

    query = "DELETE FROM ";
    query += tHistLogMst.table_name!;

    for (int i = 0; i < tInfoSt.length; i++) {
      tInfoWp = tInfoSt[i];

      if (tInfoWp.key != 0) {
        if (whereFlg == 1) {
          query += " AND ";
        } else {
          query += " WHERE ";
        }
        query += tInfoWp.colName;
        query += " = ";
        query += controlAdj(tInfoWp.data);
        whereFlg = 1;
      }

      (dataLog, tInfoWp) = histTableLog(dataLog, tInfoWp);
    }

    if (dataLog.keyLog.isNotEmpty) {
      erLog = "DEL ${dataLog.keyLog}";
      TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
    }
    ret = await histDBExec(tid, query);
    histChkAlertTable(tid, ret, tHistLogMst.table_name!, CHK_NORMAL_HIST_FLG);
  }

  /// SQL文モードの実行. data1 -> (data1が空振りしたら)data2の順で実行する.
  /// 関連tprxソース: hist_updb.c - hist_DataSqlExec
  static Future<void> histDataSqlExec(TprMID tid,
      CHistlogMstColumns tHistLogMst) async {
    String erLog = '';
    String callFunc = 'histDataSqlExec';

    if (tHistLogMst.data1 != null) {
      TprLog().logAdd(tid, LogLevelDefine.normal, tHistLogMst.data1!);
      if (await histDBExec(tid, tHistLogMst.data1!) <= 0) {
        if (tHistLogMst.data2 != null) {
          TprLog().logAdd(tid, LogLevelDefine.normal, tHistLogMst.data2!);
          await histDBExec(tid, tHistLogMst.data2!);
        } else {
          erLog = "$callFunc data2 length 0\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
        }
      }

      histChkAlertTable(
          tid, 0, tHistLogMst.table_name!, CHK_NORMAL_HIST_FLG); // 共有メモリ更新指示

      if (tHistLogMst.table_name!.contains("c_reginfo_mst") == true) {
        //CreateRHost.createRhosts(tid, RSH_ROOT);
        CreateRHost.createRhosts();
      }
      return;
    } else {
      erLog = "$callFunc data1 length 0\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
    }
    if (tHistLogMst.data2 != null) {
      TprLog().logAdd(tid, LogLevelDefine.normal, tHistLogMst.data2!);
      await histDBExec(tid, tHistLogMst.data2!);
      histChkAlertTable(
          tid, 0, tHistLogMst.table_name!, CHK_NORMAL_HIST_FLG); // 共有メモリ更新指示
      if (tHistLogMst.table_name!.contains("c_reginfo_mst") == true) {
        // create_rhosts(tid, RSH_ROOT);
        CreateRHost.createRhosts();
      }
    }
  }

  /// request from histlog
  /// 関連tprxソース: hist_updb.c - hist_Request
  static void histRequest(TprMID tid, int tupleNum, String cmdId,
      CHistlogMstColumns tHistLogMst) {
    String log = '';
    int cmdLen; // cmd_idの文字列長さ
    String tmpbuf = '';
    int flg = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.normal,
          "histlog hist_Request() rxMemPtr pointer get error");
      flg = 0;
    }
    RxCommonBuf cBuf = xRet.object;
    String iniName = ''; //カラー客表接続する／しない判定時用
    String callFunc = 'histRequest';

    flg = 1;

    cmdLen = cmdId.length;

    log = "$callFunc() cmd_id[$cmdId] tuple_num[$tupleNum]\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    if (cmdId.compareTo("reclogo") == 0) {
      // TODO:10152 履歴ログ ファイルリクエスト？の為後回し
      // if(rxLogoRequest() != RXFTP_OK) {
      // TprLibLogWrite(tid, TPRLOG_ERROR, -1, "rxLogoRequest() Error\n");
      // }
    } else if (cmdId.compareTo("time") == 0) {
      if ((tid == Tpraid.TPRAID_HIST) || (tid == Tpraid.TPRAID_HISTORY)) {
        // TODO:10152 履歴ログ 後回し
        // cm_ntpdate(tid);
      }
    } else
    if (cmdId.compareTo("tran55") == 0 || cmdId.compareTo("tran73") == 0) {
      /* for CSS */

    } else if (cmdId.compareTo("copy") == 0
        || cmdId.compareTo("tar_copy") == 0
        || cmdId.compareTo("ini") == 0) {
      // TODO:10152 履歴ログ ファイルリクエスト？の為コメントアウト
      // hist_FIleRequest(tid, tHistlogMst);
    } else if (cmdId.compareTo("xpm") == 0) {
      // TODO:10152 履歴ログ ファイルリクエスト？の為コメントアウト
      // hist_FIleRequestXpm(tid, tuple_num);
    } else if (cmdId.compareTo("cpn") == 0
        || cmdId.compareTo("preset") == 0
        || cmdId.compareTo("cmlogo") == 0
        || cmdId.compareTo("tar_cpn") == 0
        || cmdId.compareTo("tar_preset") == 0
        || cmdId.compareTo("tar_cmlogo") == 0
        || cmdId.compareTo(HIST_STDPROM_TNAME) == 0
    ) {
      // TODO:10152 履歴ログ ファイルリクエスト？の為コメントアウト
      // hist_FIleRequest(tid, tHistlogMst);
    } else if (cmdId.compareTo("colordsp") == 0 ||
        cmdId.compareTo("tar_colordsp") == 0) {
      // iniName = "${EnvironmentData().sysHomeDir}/conf/mac_info.ini";
      cBuf.iniMacInfo;

      // TODO:10152 履歴ログ 後回し
      // if(TprLibGetIni(ini_name, "internal_flg", "colordsp_cnct", tmpbuf) == 0) {
      // if((memcmp(tmpbuf,"1",1) == 0) //カラー客表接続するのときだけ取得する
      // || (cm_mm_type() == MacM1)	// Mレジは必ず取得する（他レジが取得できないため）
      // || (cm_mm_type() == MacM2)){	// BSレジは必ず取得する（Mレジがファイルリクエストしたときのため）
      // hist_FIleRequest(tid, tHistlogMst);
      // } else {
      // memset( log, 0x0, sizeof(log) );
      // snprintf( log, sizeof(log), "%s() cmd_id[%s] but colordsp not connect !! \n",__FUNCTION__, cmd_id );
      // TprLibLogWrite(tid, TPRLOG_ERROR, 0, log);
      // }
      // }
    }
    /*----------------------------------------------------------------------*/
    /* "copy_notM"の場合、COPY FROMの処理で、ST,Mは行わない					*/
    /*----------------------------------------------------------------------*/
    else if (cmdId.compareTo("copy_notM") == 0) {
      if (CmCksys.cmMmType() != CmSys.MacM1 &&
          CmCksys.cmMmType() != CmSys.MacMOnly) {
        // TODO:10152 履歴ログ ファイルリクエスト？の為コメントアウト
        // hist_FIleRequest(tid, tHistlogMst );
      }
    } else if (cmdId.substring(0, 10).compareTo("bmp_cmlogo") == 0) {
      /* 任意に作成されたＣＭロゴBMPファイルをTSから取得 */
      // TODO:10152 履歴ログ 後回し
      // histFtpGet_CM_Logo_Bmp(tid, tuple_num);
    } else if (cmdId.compareTo("memo") == 0) { // 連絡メモを作成する
      // TODO:10152 履歴ログ 後回し
      // hist_TMemoCreate(tid, tHistlogMst);
    } else {
      log = "$callFunc() Not Support cmd_id[$cmdId] \n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
    }
  }

  /// 関連tprxソース: hist_updb.c - hist_TblInfo
  static Future<(int, CHistlogMstColumns, List<TableInfo>)> histTblInfo(
      TprMID tid,
      CHistlogMstColumns tHistLogMst,
      TableInfo tInfoSt,
      int compCd,
      int streCd) async {
    TableInfo? tInfoWkDt = TableInfo();
    TableInfo? tInfoWp = TableInfo();
    String fName = '';
    String tmpBuf = '';
    String erLog = '';
    File? fp;
    String? p = '';
    int? q = 0;
    String? r = '';
    int? s = 0;
    String typeBuf = '';
    int chgTarget = 0; // チェック対象のテーブルか
    int chgByRtrId = 0; // 書き換え 有無
    tInfoWkDt = null;
    tInfoWp = null;
    String callFunc = 'histTblInfo';
    int fRow = 0; // fpの行数
    List<TableInfo> tableInfoList = [];

    // #if ZHQ_TS_COOPERATE	// TS側との連携タイミングを計る為のフラグ
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      erLog = "$callFunc rxMemPtr get error!!\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return (HistMain.HIST_NG, tHistLogMst, tableInfoList);
    }
    RxCommonBuf pCom = xRet.object;
    // comp_cdがc_comp_mst.rtr_idであった場合の書き換える対象かチェック

    if (tHistLogMst.table_name != null) {
      chgTarget =
          await AplLibOther.dbChkComPcdEqRtrId(tid, tHistLogMst.table_name!);
      // #endif
      p = null;
      q = null;
      r = null;
      s = null;

      fName = sprintf(HistMain.TEMP_TBL_FNAME, [tHistLogMst.table_name]);

      try {
        fp = TprxPlatform.getFile(fName);
        if (!fp.existsSync()) {
          erLog = "$callFunc fopen($fName)\n";
          TprLog().logAdd(tid, LogLevelDefine.error, erLog);
          return (HistMain.HIST_NG, tHistLogMst, tableInfoList);
        }
      } catch (e) {
        erLog = "$callFunc fopen($fName) error[$e]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        return (HistMain.HIST_NG, tHistLogMst, tableInfoList);
      }
    }

    p = tHistLogMst.data1;
    while (true) {
      if (fName.isEmpty) {
        break;
      }

      try {
        if (fp!.readAsLinesSync()[fRow].isEmpty) {
          break;
        }
      } catch (e) {
        break;
      }

      tmpBuf = fp.readAsLinesSync()[fRow];

      fRow += 1;

      tInfoWkDt = TableInfo();

      try {
        // TODO:00013 三浦 ポインタ演算
        r = tmpBuf;
        s = r.indexOf(',');
      } catch (e) {
        erLog = "$callFunc 1fgets($fName) buffer error[$tmpBuf]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        // fclose(fp);
        return (HistMain.HIST_NG, tHistLogMst, tableInfoList);
      }

      tInfoWkDt.colName = r.substring(0, s);

      try {
        r = r.substring(s + 1);
        s = r.indexOf(',');
      } catch (e) {
        erLog = "$callFunc 2fgets($fName) buffer error[$tmpBuf]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        return (HistMain.HIST_NG, tHistLogMst, tableInfoList);
      }

      typeBuf = r.substring(0, s);

      try {
        // TODO:00013 三浦 ポインタ演算
        r = r.substring(s + 1);
        s = r.indexOf(',');
      } catch (e) {
        erLog = "$callFunc 3fgets($fName) buffer error[$tmpBuf]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        return (HistMain.HIST_NG, tHistLogMst, tableInfoList);
      }

      tInfoWkDt.key = int.tryParse(r.substring(0, s)) ?? 0;

      q = p!.indexOf("\t");

      if (q == -1) {
        q = null;
      }

      if (q != null) {
        tInfoWkDt.data = p.substring(0, q);
      }

      if (tInfoWkDt.data == null || tInfoWkDt.data.isEmpty) {
        if (tInfoWkDt.key != 0) {
          if (0 == tInfoWkDt.colName.compareTo("comp_cd")) {
            tmpBuf = "$compCd";
            tInfoWkDt.data = tmpBuf;
          } else if (0 == tInfoWkDt.colName.compareTo("stre_cd")) {
            tmpBuf = "$streCd";
            tInfoWkDt.data = tmpBuf;
          } else {
            tInfoWkDt.data = "0";
          }
        } else if (0 == typeBuf.compareTo("int2") ||
            0 == typeBuf.compareTo("numeric")) {
          tInfoWkDt.data = "0";
        }
      }

      //#if ZHQ_TS_COOPERATE	// TS側との連携タイミングを計る為のフラグ

      else {
        // カラムデータあり
        // 書き換えチェック対象
        if (chgTarget != 0) {
          if (tInfoWkDt.key != 0) {
            if (0 == tInfoWkDt.colName.compareTo("comp_cd") // 企業コードがリテイラーIDと同一値
                &&
                int.tryParse(tInfoWkDt.data) == pCom.dbComp.rtr_id) {
              erLog =
                  "$callFunc change [${tHistLogMst.table_name}] comp_cd [${tInfoWkDt.data}->$compCd]\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, erLog);

              tmpBuf = "$compCd"; // 自企業コードに書き換え
              tInfoWkDt.data = tmpBuf;
              chgByRtrId = 1; //書き換え済に
            }

            if ((0 == tInfoWkDt.colName.compareTo("stre_cd")) // 店舗コードが"０"
                &&
                (int.tryParse(tInfoWkDt.data) == 0) &&
                (chgByRtrId == 1)) {
              // 企業コードの書き換え済
              erLog =
                  "$callFunc change [${tHistLogMst.table_name}] stre_cd [${tInfoWkDt.data}->$streCd]\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, erLog);

              tmpBuf = "$streCd"; // 自店舗コードに書き換え
              tInfoWkDt.data = tmpBuf;
            }
          }
        }
      }

      if (q != null) {
        p = p.substring(q + 1);
      } else {
        p = "";
      }

      tInfoWp = tInfoSt;

      for (tInfoWp; tInfoWp?.next != null; tInfoWp = tInfoWp!.next) {}

      tInfoWkDt.next = null;
      tInfoSt.next = tInfoWkDt;
      tableInfoList.add(tInfoWkDt);
    }

    return (HistMain.HIST_OK, tHistLogMst, tableInfoList);
  }

  /// WebAPI：履歴ログ検索
  /// 引数:[pCom] 共有クラス（RxCommonBuf）
  /// 戻り値: WebAPIのレスポンスデータ
  static Future<List<CHistlogMstColumns>> callGetHistLogAPI(
      RxCommonBuf pCom, int limitCnt) async {
    // WebAPIからレスポンスデータを取得する
    HistLogDownResponse strRes = await WebAPI().getHistlog(
      histLogChgColumuns.hist_cd!,
      pCom.dbRegCtrl.compCd,
      pCom.dbRegCtrl.streCd,
      limitCnt,
    );

    // レスポンスデータを戻り値に格納する
    List<CHistlogMstColumns> res = List<CHistlogMstColumns>.empty(growable: true);
    for (int i = 0; i < strRes.histLog.length; i++) {
      CHistlogMstColumns columns = CHistlogMstColumns();
      columns.hist_cd = strRes.histLog[i].histCd;
      columns.ins_datetime = strRes.histLog[i].insDatetime;
      columns.comp_cd = strRes.histLog[i].compCd;
      columns.stre_cd = strRes.histLog[i].streCd;
      columns.table_name = strRes.histLog[i].tableName;
      columns.mode = strRes.histLog[i].mode;
      columns.mac_flg = strRes.histLog[i].macFlg;
      columns.data1 = strRes.histLog[i].data1;
      columns.data2 = strRes.histLog[i].data2;
      res.add(columns);
    }

    return res;
  }

  /// 関連tprxソース: hist_updb.c - hist_skip_num_read
  static Future<void> histSkipNumRead(TprMID tid) async {
    String sql = '';
    String erLog = '';
    int i = 0;
    Result res;
    DbManipulationPs db = DbManipulationPs();
    String callFunc = 'histSkipNumRead';

    histSkipNum = 0;
    histSkipNumBuf = List.filled(HIST_SKIP_NUM_MAX, 0);
    sql = "select hist_cd from histlog_skip_num order by hist_cd";

    try {
      res = await db.dbCon.execute(sql);
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      erLog = "$callFunc [$sql] error\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return;
    }

    histSkipNum = res.length;
    if (histSkipNum == 0) {
      return;
    }

    if (histSkipNum > HIST_SKIP_NUM_MAX) {
      erLog =
          "$callFunc hist_skip_num[$histSkipNum] > HIST_SKIP_NUM_MAX[${HistUpDb.HIST_SKIP_NUM_MAX}] system error but exec\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      histSkipNum = HIST_SKIP_NUM_MAX;
    }

    for (i = 0; i < histSkipNum; i++) {
      Map<String, dynamic> data = res.elementAt(i).toColumnMap();
      int histCd = data["hist_cd"] ?? 0;
      histSkipNumBuf[i] = histCd;
      erLog = "$callFunc skip number[${histSkipNumBuf[i]}] retry read\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
    }
  }
}

/// 関連tprxソース: hist_updb.c - table_info
class TableInfo {
  String colName = '';
  String data = '';
  int key = 0;
  TableInfo? next;
}

/// 関連tprxソース: hist_updb.c - hist_tablelog_data
// 履歴ログの内容を格納するための構造体
class HistTableLogData {
  int type = 0; // 0: update or insert  1: delete
  String keyLog = '';
}