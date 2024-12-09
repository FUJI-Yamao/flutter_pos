/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/lib/apl_cnv.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/lib/apllib/prg_lib.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:sprintf/sprintf.dart';

import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

///関連tprxソース: dbBatPrcChgUpd.c
class dbBatPrcChgUpd {

  ///関連tprxソース: dbBatPrcChgUpd.c - dbBatPrcChgUpd_Grp_Delete
  static Future<int> dbBatPrcChgUpdGrpDelete(TprMID tid, Connection localCon, int prcChgCd, int tblMode) async {
    Result res;
    String sql = '';
    String log = '';
    int rtn = 0;

    if (tblMode == 0) {       // PLUデータ
      if (prcChgCd < 100) {
        // BatPrcChgマスタ削除(prcchg_cd + 100)
        sql = sprintf("delete from c_batprcchg_mst where prcchg_cd='%d';",[prcChgCd + 100]);
      }
      else if (prcChgCd < 200) {
        // BatPrcChgマスタ削除(prcchg_cd)
        sql = sprintf("delete from c_batprcchg_mst where prcchg_cd='%d';",[prcChgCd]);
      }
      else {
        // None
      }
    }
    else if (tblMode == 1) {  // BatPrcChgデータ
      if (prcChgCd < 100) {
        // BatPrcChgマスタ削除(prcchg_cd)
        sql = sprintf("delete from c_batprcchg_mst where prcchg_cd='%d';",[prcChgCd]);
      }
      else if (prcChgCd < 200) {
        // None
      }
      else {
        // BatPrcChgマスタ削除(prcchg_cd)
        sql = sprintf("delete from c_batprcchg_mst where prcchg_cd='%d';",[prcChgCd]);
      }
    }
    else if (tblMode == 3) {  // HistLogデータ
      // BatPrcChgマスタ削除(prcchg_cd)
      sql = sprintf("delete from c_batprcchg_mst where prcchg_cd='%d';",[prcChgCd]);
      rtn = await PrgLib.prgHistlogWrite(localCon, sql, sql);
      if (rtn == Typ.NG) {
        log = "dbBatPrcChgUpdGrpDelete : Prg_Histlog_writeU() error\n";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        return Typ.NG;
      }
    }

    res = await localCon.execute(sql);
    if (res.isEmpty) {
      log = "dbBatPrcChgUpdGrpDelete : c_batprcchg_smt() insert error\n";
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return Typ.NG;
    }
    localCon.close();
    return Typ.OK;
  }
}
