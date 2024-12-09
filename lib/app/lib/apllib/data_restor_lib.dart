/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'db_comlib.dart';

/// 関連tprxソース: data_restor_lib.c
class DataRestorLib {

  /// 関数名       : SpecBackUp_lib_data_call_ftp
  /// 機能概要     : SPECBKUP送付用のFTPタスク起動
  ///  呼び出し方法 : SpecBackUp_lib_make_data ();
  /// パラメータ   : mode 0:SPECBKUP送付(FTP)
  ///                    1:HWINFO送付(CURL)
  ///  戻り値       : なし
  ///  関連tprxソース: data_restor_lib.c - SpecBackUp_lib_data_call_ftp
  /// TODO:00015 江原 定義のみ追加
  static void	specBackUpLibDataCallFtp (TprTID tid, String mode) {
  }

  /// 機能概要     : DBのCOPY文作成
  /// 関連tprxソース: data_restor_lib.c - SpecBackUp_dbcopyto
  /// TODO:10151 ファイル初期化 定義のみ追加
  static Future<int> specBackUpDbCopyTo (TprTID tid, String fileName, String dbcpyTbl, DbLibCopyParam copyparam) async {
    int ret = 0;

    if (await DbComlib.dbLibCopyToFile(tid, fileName, null, dbcpyTbl, copyparam) != Typ.OK){
      TprLog().logAdd(tid, LogLevelDefine.error, 
        "specBackUpDbCopyTo: Copy to $dbcpyTbl Error!", errId: -1);
      ret = 1;
    }

    return ret;
  }

  /// 機能概要     : DBのCOPY文作成
  /// 関連tprxソース: data_restor_lib.c - SpecBackUp_dbcopyfrom
  static Future<int> specBackUpDbCopyFrom (TprTID tid, String fileName, String dbcpyTbl, SpecBackupDataChange chgData) async {

    DbLibCopyParam	copyparam;
    int		ret = 0;
    int		compStreRet = 0;
    bool chgFlg = false;
    String backupFileName;
    String sql;
    String sqlBuf;
    String sqlWhereBuf;
    String tblBuf;
    DbManipulationPs db = DbManipulationPs();

    backupFileName = '$fileName.bak';
    copyparam = DbLibCopyParam();
    copyparam.withNull = '';
    if( await DbComlib.dbLibCopyToFile(tid, backupFileName, null, dbcpyTbl, copyparam) != Typ.OK)
    {
      TprLog().logAdd(tid, LogLevelDefine.error, 
        "specBackUpDbCopyFrom: Copy to $dbcpyTbl backup Error!"
        , errId: -1);
      ret = 1;
    }

    if (ret == 0) {
      try {
        sql = 'TRUNCATE $dbcpyTbl';
        await db.dbCon.execute(sql);
      } catch(e,s) {
        TprLog().logAdd(tid, LogLevelDefine.error, 
          "specBackUpDbCopyFrom: Truncate $dbcpyTbl Error!\n$e,$s",
          errId: -1);
        ret = 1;
      }
    }

    if (ret == 0) {	
      copyparam = DbLibCopyParam();
      copyparam.withNull = '';
      if (await DbComlib.dbLibCopyFromFile(tid, fileName, dbcpyTbl, copyparam) != Typ.OK) {
        TprLog().logAdd(tid, LogLevelDefine.error, 
          'specBackUpDbCopyFrom: Copy from $dbcpyTbl Error!',
          errId: -1);

        backupFileName = '$fileName.bak';
        copyparam = DbLibCopyParam();

        copyparam.withNull = '';
        if (await DbComlib.dbLibCopyFromFile(tid, backupFileName, dbcpyTbl, copyparam) != Typ.OK)
        {
          TprLog().logAdd(tid, LogLevelDefine.error, 
            'specBackUpDbCopyFrom: Copy from $dbcpyTbl backup Error!',
            errId: -1);
        }
      }
    }
    if (
      chgData.chgFlg == 1
      && (
        chgData.compCd != 0
        || chgData.streCd != 0
        || chgData.macNo != 0
      )
    ) {
      if (chgData.orgTblName.isNotEmpty) {
        tblBuf = chgData.orgTblName;
      } else {
        tblBuf = dbcpyTbl;
      }
      compStreRet = await DbComlib.dbComlibCheckColumnsCompStre(tid, tblBuf);	/* チェックは常に本テーブルの方で行う */
      sql = 'UPDATE $dbcpyTbl SET ';
      sqlWhereBuf = ' WHERE ';

      if (compStreRet != 0) { /* 企業・店舗どちらかはカラムが存在する */
        if (
          (compStreRet == 1 || compStreRet == 3)
          && chgData.compCd != 0
        ) {
          sqlBuf = 'comp_cd=\'${chgData.compCd}\'';
          sql += sqlBuf;
          sqlWhereBuf += 'comp_cd <> \'0\'';
          chgFlg = true;
        }
        if (
          (compStreRet == 2 || compStreRet == 3)
          && chgData.streCd != 0
        ) {
          if (chgFlg) {
            sql += ',';
            sqlWhereBuf += ' AND ';
          }
          sqlBuf = "stre_cd='${chgData.streCd}'";
          sql += sqlBuf;
          sqlWhereBuf += 'stre_cd <> \'0\'';
          chgFlg = true;
        }

      }
      compStreRet = await DbComlib.dbComlibCheckColumnsMac(tid,tblBuf);
      if (compStreRet == 1 /* レジコードカラムが存在する */
        && chgData.macNo != 0) {
        if (chgFlg) {
          sql += ',';
          sqlWhereBuf += ' AND ';
        }
        sqlBuf = 'mac_no=\'${chgData.macNo}\' ';
        sql += sqlBuf;
        sqlWhereBuf += 'mac_no <> \'0\'';
        chgFlg = true;
      }
      if (chgFlg) {
        try {
          sql += sqlWhereBuf;
          TprLog().logAdd(tid, LogLevelDefine.normal, sql);
          await db.dbCon.execute(sql);
        } catch(e,s) {
          TprLog().logAdd(tid, LogLevelDefine.error, 
            'specBackUpDbCopyFrom: Truncate $dbcpyTbl Error!\n$e,$s',
            errId: -1);
          ret = 1;
        }
      }
    }

    return ret;
  }

}