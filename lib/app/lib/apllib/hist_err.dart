/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/lib/apllib.dart';

///関連tprxソース: hist_err.c
class HistErr {
  static const String HIST_ERR_SQL = "log/hist_err.sql";
  static const String HIST_HISTORY = "log/hist_history";
  static const String HQHIST_DOWN_ERR_SQL = "log/hqhist_down_err.sql"; // flag:100
  static const String HQHIST_DOWN_HISTORY = "log/hqhist_down_history"; // flag:101
  static const String HQHIST_UP_ERR_SQL = "log/hqhist_up_err.sql"; // flag:102
  static const String HQHIST_UP_HISTORY = "log/hqhist_up_history"; // flag:103
  static const String HQTMPMST_UP_ERR_SQL = "log/hqtmpmst_up_err.sql"; // flag:104
  static const String HQTMPMST_UP_HISTORY = "log/hqtmpmst_up_history"; // flag:105
  static const String SUM_DL_FNC_ERR_SQL = "log/sum_dl_fnc_err.sql"; // flag:106
  static const int HIST_ERR_SQL_SIZ = 500000;
  static const int HIST_ERR_SQL_CNT = 5;
  static const String HIST_NOTFOUND_FNAME = "tmp/hist_notfound.list";
  static const String HIST_NOTFOUND_CFNAME = "tmp/hist_cnotfound.list";
  static const String HIST_NOTFOUND_MOV_FNAME = "%s/log/hist_notfound.list%04d%02d%02d%02d%02d%02d";
  static const String HIST_NOTFOUND_MOV_CFNAME = "%s/log/hist_cnotfound.list%04d%02d%02d%02d%02d%02d";

  ///関連tprxソース: hist_err.c - hist_NotFound_name
  static String histNotFoundName(int typ) {
    DateTime now = DateTime.now();
    String tprxHome = EnvironmentData.TPRX_HOME;
    String fname;

    switch(typ) {
      case 0:	
        // TPRX_HOME/tmp/hist_notfound.list 
        fname = '$tprxHome/$HIST_NOTFOUND_FNAME'; break;
      case 1: 
        // TPRX_HOME/tmp/hist_cnotfound.list
        fname = '$tprxHome/$HIST_NOTFOUND_CFNAME'; break;
      case 2:
        // TPRX_HOME/log/hist_notfound.listYYYYMMDDHHMMSS
        fname = sprintf(HIST_NOTFOUND_MOV_FNAME, 
                    [tprxHome, now.year, now.month, now.day, now.hour, now.minute, now.second]);
        break;
      case 3:
      default:
        // TPRX_HOME/log/hist_cnotfound.listYYYYMMDDHHMMSS
        fname = sprintf(HIST_NOTFOUND_MOV_CFNAME, 
                    [tprxHome, now.year, now.month, now.day, now.hour, now.minute, now.second]);
        break;
    }
    return fname;
  }

  ///関連tprxソース: hist_err.c - hist_NotFound_stat
  static bool histNotFoundStat(TprMID tid, int typ, String fname) {
    return File(fname).existsSync();
  }


  ///関連tprxソース: hist_err.c - hist_NotFound_Del
  static int histNotFoundDel(TprMID tid, int typ) {

    // typ=0 TPRX_HOME/tmp/hist_notfound.list 
    // typ=1 TPRX_HOME/tmp/hist_cnotfound.list
    var fname = histNotFoundName(typ);
    if (histNotFoundStat(tid, typ, fname) == false) {
      TprLog().logAdd(tid, LogLevelDefine.normal, 'histNotFoundDel not found OK[$fname]');
      return 0;
    }

    // typ=0 TPRX_HOME/log/hist_notfound.listYYYYMMDDHHMMSS
    // typ=1 TPRX_HOME/log/hist_cnotfound.listYYYYMMDDHHMMSS
    var movFname = histNotFoundName(typ + 2);

    try {
      File(fname).renameSync(movFname);
    } catch (e) {
      TprLog().logAdd(tid, LogLevelDefine.error, 'histNotFoundDel remove error[$e] [$fname][$movFname]');
      return -1;
    }
    return 0;
  }

  // ///関連tprxソース: hist_err.c - hist_Err_Sql_Create
  // static void histErrSqlCreate(TprMID tid, int flag, String buf){    /* flag 0->error 1->history */
  // String txtName = '';
  // String txtNew = '';
  // String txtOld = '';
  // File? outFp;
  // int t = 0;
  // int	mvNo = 0;
  // String mode = "w";
  //
  // if(flag == 0) {
  //   txtName = sprintf("%s/%s", EnvironmentData().sysHomeDir, HIST_ERR_SQL);
  // }else if(flag == 100) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"), HQHIST_DOWN_ERR_SQL);
  // }else if(flag == 101) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"), HQHIST_DOWN_HISTORY);
  // }else if(flag == 102) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"), HQHIST_UP_ERR_SQL);
  // }else if(flag == 103) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"), HQHIST_UP_HISTORY);
  // }else if(flag == 104) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"), HQTMPMST_UP_ERR_SQL);
  // }else if(flag == 105) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"), HQTMPMST_UP_HISTORY);
  // }else if(flag == 106) {
  //   sprintf(txtName, "%s/%s", getenv("TPRX_HOME"),
  //       SUM_DL_FNC_ERR_SQL); /* 一括ダウンロード */
  // }else {
  //   sprintf(txtname, "%s/%s", getenv("TPRX_HOME"), HIST_HISTORY);
  // }
  //
  // if(stat(txtname, &st) == 0) {
  // if(st.st_size > HIST_ERR_SQL_SIZ) {
  // for( mv_no = HIST_ERR_SQL_CNT; mv_no != 1; mv_no-- ) {
  // sprintf( txtnew, "%s.%d", txtname, mv_no );
  // sprintf( txtold, "%s.%d", txtname, mv_no - 1);
  // rename( txtold, txtnew );
  // }
  // sprintf( txtnew, "%s.1", txtname );
  // rename( txtname, txtnew );
  // } else {
  // mode = "a";
  // }
  // }
  // if(( out_fp = fopen( txtname, mode )) == NULL) {
  // TprLibLogWrite(tid, TPRLOG_NORMAL, -1, "Error Sql text fopen() error\n");
  // return;
  // }
  // if(flag == 0) {
  // t = time(0);
  // l_time = localtime((time_t *)&t);
  // if(fprintf( out_fp, "%d/%d/%d %02d:%02d:%02d\n",
  // l_time->tm_year + 1900,
  // l_time->tm_mon  + 1,
  // l_time->tm_mday,
  // l_time->tm_hour,
  // l_time->tm_min,
  // l_time->tm_sec ) == -1) {
  // fclose( out_fp );
  // TprLibLogWrite(tid, TPRLOG_NORMAL, -1, "Error Sql text fprintf() error1-1\n");
  // return;
  // }
  // }
  // else {
  // t = time(0);
  // l_time = localtime((time_t *)&t);
  // if(fprintf( out_fp, "%d/%d/%d %02d:%02d:%02d - ",
  // l_time->tm_year + 1900,
  // l_time->tm_mon  + 1,
  // l_time->tm_mday,
  // l_time->tm_hour,
  // l_time->tm_min,
  // l_time->tm_sec ) == -1) {
  // fclose( out_fp );
  // TprLibLogWrite(tid, TPRLOG_NORMAL, -1, "Error Sql text fprintf() error1-2\n");
  // return;
  // }
  // }
  // if(fprintf( out_fp, "%s\n", buf ) == -1) {
  // fclose( out_fp );
  // TprLibLogWrite(tid, TPRLOG_NORMAL, -1, "Error Sql text fprintf() error2\n");
  // return;
  // }
  // fclose( out_fp );
  // return;
  // }
}