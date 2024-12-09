/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/sys/tpr_log.dart';

class DbVacuumProgress {

  /// VACUUM処理・REINDEX処理
  Future<bool> dbvacuum() async {
    bool errState = true;

    // Vacuum実行
    var vacuumResult  = await procVacuumAnalyze();
    if (vacuumResult == false) {
      errState = false;
    }
    // Reindex実行
    var reindexResult  = await procReindexTable();
    if (reindexResult == false) {
      errState = false;
    }
    return errState;
  }

  /// データベースのインデックスを再構築
  Future<bool> procReindexTable() async {
    int tuples = 0;
    bool errState = true;

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "ProcReindexTable: Start");

    DbManipulationPs db = DbManipulationPs();
    String sqlSelect = "select tablename from pg_tables where tablename not like 'pg_%%' and tablename not like 'sql_%%' order by tablename";

    try {
      var resSelect = await db.dbCon.execute(sqlSelect);
      if (resSelect.isEmpty) {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error, "ProcReindexTable: Select Error");
        errState = false;
      } else {
        tuples = resSelect.length;
        if (tuples == 0) {
          TprLog().logAdd(
              Tpraid.TPRAID_STR, LogLevelDefine.error, "ProcReindexTable: No tuples");
          errState = false;
        } else {
          for (var i = 0; i < tuples; i++) {
            String tableName = resSelect[i][0] as String;
            String sqlReindex = "reindex table $tableName";
            try {
              var resReindex = await db.dbCon.execute(sqlReindex);
              if (resReindex.isEmpty) {
                debugPrint("ProcReindexTable: Reindex Success [$tableName]");
              } else {
                debugPrint("ProcReindexTable: Reindex Error [$tableName]");
                errState = false;
              }
            } catch (e, s) {
              // ＤＢ読込エラー
              TprLog().logAdd(
                  Tpraid.TPRAID_STR, LogLevelDefine.error, "db error [$sqlSelect]\n$e \n$s");
              errState = false;
            }
          }
        }
      }
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "ProcReindexTable: End");
    } catch (e, s) {
      // ＤＢ読込エラー
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "db error [$sqlSelect]\n$e \n$s");
      errState = false;
    }
    return errState;
  }

  /// データベース全体をバキューム
  Future<bool> procVacuumAnalyze() async {
    bool errState = true;

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "ProcVacuumAnalyze: Start");

    DbManipulationPs db = DbManipulationPs();
    String sqlVacuum = "vacuum analyze";

    try {
      var resVacuum = await db.dbCon.execute(sqlVacuum);
      if (resVacuum.isEmpty) {
        debugPrint("ProcVacuumAnalyze: Success");
      } else {
        debugPrint("ProcVacuumAnalyze: Error");
        errState = false;
      }
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "ProcVacuumAnalyze: End");
    } catch (e, s) {
      // ＤＢ読込エラー
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "db error [$sqlVacuum]\n$e \n$s");
      errState = false;
    }
    return errState;
  }

}