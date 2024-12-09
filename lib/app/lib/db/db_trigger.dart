/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: db_trigger.c
class DbTrigger {
  static List<TrigInf> tTrigInf = List.filled(
      TriggerLists.TRIGGER_MAX.value, TrigInf());

  static const List<String> table = [
    "c_plu_mst"
    , "c_bdlsch_mst"
    , "c_bdlitem_mst"
    , "c_brgnsch_mst"
    , "c_brgnitem_mst"
    , "c_smlcls_mst"
    , "c_stresml_mst"
    , "c_tax_mst"
  ];

  static const List<String> name = [
    "c_plu_mst_chg",
    "c_bdlsch_mst_chg",
    "c_bdlitem_mst_chg",
    "c_brgnsch_mst_chg",
    "c_brgnitem_mst_chg",
    "c_smlcls_mst_chg",
    "c_stresml_mst_chg",
    "c_tax_mst_chg"
  ];

  /// 関連tprxソース: db_trigger.c - db_trigger_create
  static Future<int> dbTriggerCreate(TprMID tid) async {
    String sql = '';
    String erLog = '';
    int i = -1;
    int ret = -1;
    int dbFlg = 0;
    Result res;
    DbManipulationPs db = DbManipulationPs();
    String callFunc = 'dbTriggerCreate';

    await dbTriggerDrop(tid);

    try {
      for (i = 0; i < TriggerLists.TRIGGER_MAX.value; i++) {
        sql =
            "create function ${tTrigInf[i].name}() returns opaque as '${EnvironmentData().sysHomeDir}/apl/db/${tTrigInf[i].name}.so' language 'C';\n";
        try {
          res = await db.dbCon.execute(sql);
        } catch (e) {
          //Cソース「db_PQexec() == NULL」時に相当
          erLog = "$callFunc $sql error\n";
          return 0;
        }

        TprLog().logAdd(tid, LogLevelDefine.normal, sql);

        sql =
            "create trigger ${tTrigInf[i].name}_after after insert or update or delete on ${tTrigInf[i].table} for each row execute procedure ${tTrigInf[i].name}();\n";
        try {
          res = await db.dbCon.execute(sql);
        } catch (e) {
          //Cソース「db_PQexec() == NULL」時に相当
          erLog = "$callFunc $sql error\n";
          return 0;
        }
        TprLog().logAdd(tid, LogLevelDefine.normal, sql);
      }
      ret = 0;
    } catch (e) {
      // 元ソースのgoto文の置き換えのためcatchしない
    } finally {
      if (ret == -1) {
        await dbTriggerDrop(tid);
      }
      if (erLog.isNotEmpty) {
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      } else {
        erLog = "$callFunc ok\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, erLog);
      }
    }
    return ret;
  }

  /// 関連tprxソース: db_trigger.c - db_trigger_drop
  static Future<int> dbTriggerDrop(TprMID tid) async {
    String sql = '';
    String erLog = '';
    int i = 0;
    int ret = -1;
    int dbFlg = 0;
    DbManipulationPs db = DbManipulationPs();
    Result res;
    String callFunc = 'dbTriggerDrop';

    for (i = 0; i < TriggerLists.TRIGGER_MAX.value; i++) {
      tTrigInf[i].table = table[i];
      tTrigInf[i].name = name[i];
      sql = "drop trigger ${tTrigInf[i].name}_after on ${tTrigInf[i].table};\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, sql);

      try {
        res = await db.dbCon.execute(sql);
      } catch (e) {
        //Cソース「db_PQexec() == NULL」時に相当
        // TODO:10152 履歴ログ エラー内容後回し
        // if((strstr(PQerrorMessage(lcon), "does not exist") == NULL) ||
        //     (strstr(PQerrorMessage(lcon), "there is no trigger") == NULL)) {
        // snprintf(erlog, sizeof(erlog), "%s error[%s]\n", __FUNCTION__, PQerrorMessage(lcon));
        erLog = "$callFunc error[$e]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        // }
        // else {
        //   snprintf(erlog, sizeof(erlog), "%s ok not exist[%s]\n", __FUNCTION__, PQerrorMessage(lcon));
        //   TprLibLogWrite(tid, TPRLOG_NORMAL, 0, erlog);
        // }
      }

      sql = "drop function ${tTrigInf[i].name}();\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, sql);

      try {
        res = await db.dbCon.execute(sql);
      } catch (e) {
        //Cソース「db_PQexec() == NULL」時に相当
        // TODO:10152 履歴ログ エラー内容後回し
        // if((strstr(PQerrorMessage(lcon), "does not exist") == NULL) ||
        //     (strstr(PQerrorMessage(lcon), "there is no trigger") == NULL)) {
        // snprintf(erlog, sizeof(erlog), "%s error[%s]\n", __FUNCTION__, PQerrorMessage(lcon));
        erLog = "$callFunc error[$e]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        // }
        // else {
        //   snprintf(erlog, sizeof(erlog), "%s ok not exist[%s]\n", __FUNCTION__, PQerrorMessage(lcon));
        //   TprLibLogWrite(tid, TPRLOG_NORMAL, 0, erlog);
        // }
      }
    }
    ret = 0;
    return ret;
  }
}

/// 関連tprxソース: db_trigger.c - TRIGGER_LISTS
enum TriggerLists {
  PLU(0),
  BDLSCH(1),
  BDLITEM(2),
  BRGNSCH(3),
  BRGNITEM(4),
  SMLCLS(5),
  STRESML(6),
  TAX(7),
  TRIGGER_MAX(8);

  final int value;

  const TriggerLists(this.value);
}

/// 関連tprxソース: db_trigger.c - TrigInf
class TrigInf {
  String table = '';
  String name = '';
}