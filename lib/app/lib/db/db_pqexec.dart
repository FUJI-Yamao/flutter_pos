/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/environment.dart';

import '../../inc/lib/db_error.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: db_PQexec.c
class DbPqExec {
  /// 関連tprxソース: db_PQexec.c - DBERR_TXT_Name
  static String dbErrTxtName() {
    return DbError.DBERR_TXT + EnvironmentData().sysHomeDir;
  }

  /// 関連tprxソース: db_PQexec.c - DBERR_TXT_found
  static int dbErrTxtFound(TprMID tid) {
    String txtName = '';
    File file;

    txtName = dbErrTxtName();
    file = TprxPlatform.getFile(txtName);

    if (!file.existsSync()) {
//		TprLibLogWrite(tid, TPRLOG_NORMAL, 0, "DBERR_TXT not found");
      return 0;
    }

    TprLog().logAdd(tid, LogLevelDefine.error, "DBERR_TXT found !!!!!");
    return 1;
  }

  /// 関連tprxソース: db_PQexec.c - DBERR_TXT_found_search
  static (int, String) dbErrTxtFoundSearch(TprMID tid) {
    String txtName = '';
    File? errFp;
    String buf = '';
    int pdEst = 0;
    String log = '';

    if (dbErrTxtFound(tid) != 0) {
      txtName = dbErrTxtName();
      errFp = TprxPlatform.getFile(txtName);
      if (!errFp.existsSync()) {
        TprLog().logAdd(
            tid, LogLevelDefine.error, "Error DBERR_TXT fopen(\"r\") error!!");
        return (0, log);
      }

      try {
        errFp.readAsLinesSync();
      } catch (e) {
        TprLog()
            .logAdd(tid, LogLevelDefine.error, "Error DBERR_TXT fgets error!!");
        return (0, log);
      }

      pdEst = buf.indexOf("relation");
      if (pdEst == -1) {
        log = buf;
      } else {
        log = buf.substring(0, pdEst - buf.length);
      }

      return (1, log);
    }

    return (0, log);
  }
}
