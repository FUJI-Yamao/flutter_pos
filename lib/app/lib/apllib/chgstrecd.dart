/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: chgstrecd.c
class ChgStreCd {

  /// 関連tprxソース: chgstrecd.c - chgcorpcd
  static Future<int> chgCorpCd(TprMID tid, bool createflg, int oldcorpcd, int newcorpcd) async {
    DbManipulationPs db = DbManipulationPs();
    Result result;
    Result result2;
    String sql = "";
    String logMsg = "";

    sql = "select table_name from information_schema.columns where column_name='comp_cd';";
    try {
      result = await db.dbCon.execute(sql);
    } catch(e) {
      TprLog().logAdd(tid, LogLevelDefine.error, "chgCorpCd(): sql error ($sql)", errId: -1);
      return -1;
    }

    for (ResultRow row in result) {
      if(createflg) {
        sql = "delete from ${row[0]} where comp_cd = $newcorpcd;";
        try {
          result2 = await db.dbCon.execute(sql);
        } catch(e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error, "chgCorpCd(): sql error ($sql) $e, $s", errId: -1);
          return -1;
        }
      }

      sql = "update ${row[0]} set comp_cd = $newcorpcd where comp_cd = $oldcorpcd;";
      logMsg = "chgCorpCd(): ${row[0]} old = $oldcorpcd -> New = $newcorpcd(";
      try {
        result2 = await db.dbCon.execute(sql);
        if(result2.affectedRows == 0)
        {
          logMsg += "NoRecod) \n";
        }
        else
        {
          logMsg += "OK) \n";
        }
      } catch(e, s) {
        TprLog().logAdd(tid, LogLevelDefine.error, "chgCorpCd(): sql error ($sql) $e, $s", errId: -1);
        logMsg += "NG) \n";
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, logMsg);
    }

    return 0;
  }

  /// 関連tprxソース: chgstrecd.c - chgstrecd
  static Future<int> chgStreCd(TprMID tid, bool createFlg, int oldStreCd, int newStreCd) async {
    DbManipulationPs db = DbManipulationPs();
    Result result;
    Result result2;
    String sql = "";
    String logMsg = "";

    sql = "select table_name from information_schema.columns where column_name='stre_cd';";
    try {
      result = await db.dbCon.execute(sql);
    } catch(e, s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "chgStreCd(): sql error ($sql) $e, $s", errId: -1);
      return -1;
    }

    for (ResultRow row in result) {
      if(createFlg) {
        sql = "delete from ${row[0]} where stre_cd = $newStreCd;";
        try {
          result2 = await db.dbCon.execute(sql);
        } catch(e) {
          TprLog().logAdd(tid, LogLevelDefine.error, "chgStreCd(): sql error ($sql)", errId: -1);
          return -1;
        }
      }

      sql = "update ${row[0]} set stre_cd = $newStreCd where stre_cd = $oldStreCd;";
      logMsg = "chgStreCd(): ${row[0]} old = $oldStreCd -> New = $newStreCd(";

      try {
        result2 = await db.dbCon.execute(sql);
        if(result2.affectedRows == 0)
        {
          logMsg += "NoRecod) \n";
        }
        else
        {
          logMsg += "OK) \n";
        }
      } catch(e, s) {
        TprLog().logAdd(tid, LogLevelDefine.error, "chgStreCd(): sql error ($sql) $e, $s", errId: -1);
        logMsg += "NG) \n";
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, logMsg);
    }

    return 0;
  }

}