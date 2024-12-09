/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/environment.dart';
import '../../inc/lib/cm_bkup.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

///関連tprxソース: bkup.c - cm_bkup
class Bkup {

  static String sysHomeDirp = EnvironmentData().sysHomeDir;
  static List<String> dbtbl_filename = [];

  /// 関連tprxソース: bkup.c - cm_bkup_cust
  static Future<bool> cmBkupCust(TprMID tid, DbManipulationPs con, BkupKind kind) async {

    Process.run('chmod', ['a+w', '$sysHomeDirp${CmBkup.WORKDIR}']);

    var nowdate = getNowDate();
    var ckind = '';
    switch (kind) {
      case BkupKind.BU_RECOVER:
        ckind = 'a';
        break;
      case BkupKind.BU_INIT:
        ckind = 'b';
        break;
      case BkupKind.BU_CLOSE:
        ckind = 'c';
        break;
      case BkupKind.BU_CLR:
        ckind = 'd';
        break;
      case BkupKind.BU_LEVEL:
        ckind = 'e';
        break;
      case BkupKind.BU_POINT:
        ckind = 'f';
        break;
      case BkupKind.BU_SELECT:
        ckind = 'g';
        break;
      case BkupKind.BU_CUSTCLR:
        ckind = 'h';
        break;
      case BkupKind.BU_P_CLR:
        ckind = 'i';
        break;
      default:
        return false;
    }

    for(var element in DbtblNo.values) {
      var filepath = '$sysHomeDirp${CmBkup.WORKDIR}${element.name}${nowdate.substring(2)}$ckind.txt';
      if (! await cmCopyTable(tid, con, element.name, filepath)) {
        return false;
      } else if (kind == BkupKind.BU_P_CLR){
        dbtbl_filename[element.idx] = filepath;
      }
    }

    return true;
  }

  /// 関連tprxソース: bkup.c - GetNowDate
  static String getNowDate() {

    return DateFormat('yyyyMMddHHmm').format(DateTime.now());

  }

  /// 関連tprxソース: bkup.c - cm_copy_table
  static Future<bool> cmCopyTable(TprMID tid, DbManipulationPs con, String table, String file) async {

    // copy table to 'file' delimiters ',' WITH NULL AS '';
    String query = sprintf(CmBkup.Q_BACKUP, [table, file]);
    
    try {
      await con.dbCon.run((conn) async {
        conn.execute(query);
      });
    } catch (e) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'COPY PQEXEC ERROR');
      return false;
    }

    return true;
  }
}