/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/sys/tpr_type.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_controladj.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/inc/lib/apllib.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/db_library/src/db_manipulation.dart';
import 'package:postgres/postgres.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';

/// 関連tprxソース:prg_lib.c
class PrgLib {

  /// 関連tprxソース:prg_lib.c - Prg_Histlog_write
  /// 関数： 履歴ログコード書込
  /// 機能： 履歴ログファイルを書き込む
  /// 引数： [con]     DBconn
  ///       [inSql]   InsertのSQL文
  ///       [upSql]   UpdateのSQL文
  static Future<int> prgHistlogWrite(Connection con, String inSql, String upSql) async {
    RxMemRet ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (ret.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = ret.object;
    return await prgHistlogWrite2(con, inSql, upSql, pCom.dbRegCtrl.streCd);
  }

  static Future<int> prgHistlogWrite2(Connection con, String inSql, String upSql, int streCd) async {
    return await prgHistlogWrite3(-1, con, inSql, upSql, streCd, null);
  }

  static Future<int> prgHistlogWrite3(TprTID tid, Connection con, String inSql, String upSql, int streCd, String? cmdId) async {
    CHistlogMst hstLog = CHistlogMst();
    CtrlAdj hsyAdj = CtrlAdj();
    String hst = '';
    TprTID histTid;
    RxMemRet ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (ret.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = ret.object;

    if (tid == -1) {
      histTid = Tpraid.TPRAID_PMOD;
    }
    else {
      histTid = tid;
    }

    if (CmCksys.cmMmSystem() != 0) {
      TprLog().logAdd(histTid, LogLevelDefine.error,
                      "prg_lib.c:Prg_Histlog_Write cm_mm_system\n");
      return Typ.OK;
    }

    /// 履歴ログ作成
    /// 新規
    if (inSql.isNotEmpty) {
      /// SQL文編集
      hsyAdj = AplLibControlAdj.aplLibControlAdj(inSql, 4000);
      if (hsyAdj.res != -1) {
        /// エラー
        hstLog.data1 = hsyAdj.pChar[0];
      }
      else {
        hstLog.data1 = inSql;
      }
    }
    /// 変更
    if (upSql.isNotEmpty) {
      /// SQL文編集
      hsyAdj = AplLibControlAdj.aplLibControlAdj(upSql, 4000);
      if (hsyAdj.res != -1) {
        /// エラー
        hstLog.data2 = hsyAdj.pChar[0];
      }
      else {
        hstLog.data2 = upSql;
      }

      /// 履歴ログコード取得
      hstLog.hist_cd = await prgGetHistCode(con);
      if (hstLog.hist_cd == -1) {
        hstLog.hist_cd = 1;
      }
    }

    if (cmdId == null) {
      hstLog.mode = 2;    /* DATA SQL EXECUTE */
    }

    hst = sprintf("INSERT INTO c_histlog_mst(ins_datetime, comp_cd, stre_cd, "
                  "table_name, mode, mac_flg, data1, data2) "
                  "VALUES ('now', '%ld', '%ld', '%s', '%d', '1', '%s', '%s');",
                  [ pCom.dbRegCtrl.compCd,
                    pCom.dbRegCtrl.streCd,
                    hstLog.table_name,
                    hstLog.mode,
                    hstLog.data1,
                    hstLog.data2
                  ]);
    final Result res = await con.execute(hst);
    if (res.isEmpty) {
      TprLog().logAdd(histTid, LogLevelDefine.error,
          "prg_lib.dart:prgHistlogWrite db.execute\n");
      return Typ.NG;
    }
    else {
      con.close();
    }
    return Typ.OK;
  }

  /// 関連tprxソース:prg_lib.c - Prg_GetHistCode
  /// 関数：履歴ログコード取得
  /// 機能：履歴ログから履歴ログコードを取得し、それを＋１し、その結果を返す
  /// 引数：[db]
  /// 戻値：-1:エラー　それ以外は、使用可能履歴ログコード
  static Future<int> prgGetHistCode(Connection dbCon) async {
    String sql = '';    /* SQL Buffer 				*/
    int tuple = 0;      /* 件数 					*/
    int histCd = 0;     /* 履歴ログコード 			*/
    Result res;

    sql = "select * from c_histlog_mst order by hist_cd desc limit 1;";
    res = await dbCon.execute(Sql.named(sql));
    if (res.isEmpty) {
      TprLog().logAdd(Tpraid.TPRAID_PMOD, LogLevelDefine.error,
          "prg_lib.dart:prgGetHistCode dbCon.execute\n");
      dbCon.close();
      return -1;
    }
    else {
      final data = res.first.toColumnMap();
      histCd = int.parse(data['hist_cd']);
      dbCon.close();
      return histCd;
    }
  }

}