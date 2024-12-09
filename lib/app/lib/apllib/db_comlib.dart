/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/environment.dart';
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../sys/usetup/freq/db_file_req.dart';
import '../../sys/usetup/freq/db_file_req_define.dart';
import '../cm_sys/cm_cksys.dart';

/// 関連tprxソース: db_comlib.c
class DbComlib {
  /* 指定テーブルの存在 */
  static const FREQ_SQL_TBL_EXIST = "SELECT tablename FROM pg_tables WHERE tablename='%s';";

  /* 指定Ｔから、フィールド名を取得 */
  static const FREQ_SQL_FIELD = "SELECT a.attname FROM pg_class c, pg_attribute a, pg_type t WHERE c.relname = '%s' AND a.attnum > 0 AND a.attrelid = c.oid AND a.atttypid = t.oid ORDER BY a.attnum;";

  /* ＴＳバージョン管理が、「11ﾊﾞｰｼﾞｮﾝ」場合に、フィールド数が同じでも削除したくないテーブル */
  static List<FreqSetting> dbParam_tsmrg_nodel = [
    FreqSetting(null, null, DbFileReqDefine.FQEND)
  ];

  /// 引数: srFieldNum リモートテーブルカラム数
  ///       copyfrom コピー元テーブル名
  ///       コピー先テーブル名 copyto
  /// 関連tprxソース: db_comlib.c - db_comlib_chk_tsver_mrg
  static Future<int> dbComlibChkTsverMrg(TprMID tid, int srFieldNum, String? copyfrom, String? copyto, int csrvCnct) async {
    int tprFieldNum;		/* 自分のフィールド数 */

    int mmSystem = 0;				/* MM System */

    int tsverMrg = 0;
  /**********************************************************************/

    /***** argument check *****/
    if(srFieldNum <= 0 ||
      copyfrom == null || copyfrom.isEmpty ||
      copyto == null || copyto.isEmpty)
    {
      TprLog().logAdd(tid, LogLevelDefine.error, "db_comlib: dbComlibChkTsverMrg() Param Error $copyto", errId: -1);
      /***** argument error *****/
      return -1;
    }

    /***** Connectio to Remote-DB *****/
    mmSystem = CmCksys.cmMmSystem();
    if(( mmSystem == 0 ) ||	/* TS接続 */
      ((await CmCksys.cmCenterServerSystem() != 0 ) && csrvCnct != 0)) /* 又は、TSD7000接続 */
    {
      /* ＴＳバージョン管理 */
      tsverMrg = await CmCksys.cmChkTsverMrg();
    }

    if( tsverMrg > 0 )
    {
      /** フィールド数が同一か **/
      /* サーバ */
      // SrFieldNum  = db_comlib_get_db_field_name( tid, copyfrom, NULL, 0, conSR );

      /* レジ */
      tprFieldNum = (await dbComlibGetDbFieldName( tid, copyto, false)).$1;

      if(( srFieldNum <= 0 ) || ( tprFieldNum <= 0 )) {
        TprLog().logAdd(tid, LogLevelDefine.error, "db_comlib: db_comlib_chk_tsver_mrg() No Table Error $copyto", errId: -1);
        return -1;
      }

      if( srFieldNum == tprFieldNum )
      {
        /* データクリア対象外テーブルか？ */
        for (int i = 0; i < dbParam_tsmrg_nodel.length; i++) {
          if (dbParam_tsmrg_nodel[i].tablename == null) {
            tsverMrg = 0;	/* フィールド数が同じで、削除対象 */
            break;
          }
          if (dbParam_tsmrg_nodel[i].tablename == copyfrom) {
            break;
          }

        }
      }
    }
    else if( tsverMrg < 0 ) {
      TprLog().logAdd(tid, LogLevelDefine.error, "db_comlib: db_comlib_chk_tsver_mrg() ts_ver_mrg Error $copyto", errId: -1);
    }

    TprLog().logAdd(tid, LogLevelDefine.normal, "db_comlib: RET [mac_info.ini][system][ts_ver_mrg]=[$tsverMrg]");

    return tsverMrg;
  }

  /// 指定されたテーブルのカラム数とカラム名を返す
  /// 引数: tableName テーブル名
  ///       isGetField カラム名を返すか
  /// 関連tprxソース: db_comlib.c - db_comlib_get_db_field_name
  static Future<(int, List<String>)> dbComlibGetDbFieldName(TprMID tid, String? tableName, bool isGetField) async {
	  String sql = "";
    int		ntuples = 0 ;
    List<String> fields = [];
  /**********************************************************************/

  //	TprLibLogWrite( tid, TPRLOG_NORMAL, 0, __FILE__": db_comlib_get_db_field_name() [START]" );

    /***** argument check *****/
    if (tableName == null || tableName.isEmpty) {
      return (-1, fields);
    }

    DbManipulationPs db = DbManipulationPs();
    Result result;
    /* 該当テーブルから、フィールドを取得 */
    try {
      sql = sprintf(FREQ_SQL_TBL_EXIST, [tableName]);
      result = await db.dbCon.execute(sql);
      if(result.isEmpty)
      {
        TprLog().logAdd(tid, LogLevelDefine.error, "db_comlib: db_comlib_get_db_field_name() [$tableName] Not Exist !!",
          errId: -1);
        return (-1, fields);	/* teble create error */
      }

      /* 該当テーブルから、フィールドを取得 */
      sql = sprintf(FREQ_SQL_FIELD, [tableName]);
      result = await db.dbCon.execute(sql);
      if(result.isEmpty)
      {
        TprLog().logAdd(tid, LogLevelDefine.error, "db_comlib: db_comlib_get_db_field_name() [$tableName] No Feild !!", 
          errId: -1);
        return (-1, fields);
      }
      ntuples = result.length;
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "db_comlib: db_comlib_get_db_field_name() $tableName\n$e,$s", errId: -1);
      return (-1, fields);
    }

    if( ntuples > 0 )
    {
      if (isGetField) {
        fields = result.map((row) => row.toColumnMap()["attname"].toString()).toList();
      }
    }
    return (ntuples, fields);
  }

  /// 機能概要	: テーブル中の各カラムのnotnullフラグのリストを作る
  /// 引数: table テーブル名
  /// 戻り値: テーブルカラム数
  ///      : -1: エラー
  /// 関連tprxソース: db_comlib.c - db_comlib_get_db_notnull_flg
  static Future<(int, List<String>)>	dbComlibGetDbNotnullFlg(TprMID tid, String? table) async {
    int		fieldNum = 0;
    String sql = "";
    List<String> fields = [];

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbComlibGetDbNotnullFlg start [$table]");

    // 引数チェック
    if (table == null || table.isEmpty) {
      // 引数エラー
      TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibGetDbNotnullFlg argument error", errId: -1);
      return (-1, fields);
    }

    DbManipulationPs db = DbManipulationPs();
    Result result;

    try {
      sql = sprintf(FREQ_SQL_TBL_EXIST, [table]);
      result = await db.dbCon.execute(sql);
      if(result.isEmpty)
      {
        TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibGetDbNotnullFlg [$table] does not exist", errId: -1);
        return (-1, fields);	/* teble create error */
      }

      // テーブルからフィールドを取得
      sql = sprintf("SELECT a.attnotnull FROM pg_class c, pg_attribute a, pg_type t WHERE c.relname = '%s' AND a.attnum > 0 AND a.attrelid = c.oid AND a.atttypid = t.oid ORDER BY a.attnum;", [table]);
      result = await db.dbCon.execute(sql);
      if(result.isEmpty)
      {
        TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibGetDbNotnullFlg [$table] has no fields", errId: -1);
        return (-1, fields);
      }
      fieldNum = result.length;
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibGetDbNotnullFlg $table\n$e,$s", errId: -1);
      return (-1, fields);
    }

    if (fieldNum <= 0)
    {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibGetDbNotnullFlg [$table] has no data", errId: -1);
      return (-1, fields);
    }

    fields = result.map((row) => row.toColumnMap()["attnotnull"].toString()).toList();

    return (fieldNum, fields);
  }

  /// 関数:	接続先DBの対象のテーブルを対象のテキストへコピーする
  /// 引数:	file: コピー後のファイル名. 絶対パス or 相対パスで記述
  ///       table: コピーしたいテーブル名
  ///       cpyParam: コピーのオプションを切り換えるための構造体. メンバにセットする値によってカンマ区切になったりする
  /// 戻値:	コピーが成功したらOK. 失敗したらNGを返す
  /// 仕様:	コピー後のファイルへは追記.
  /// 関連tprxソース: db_comlib.c - dbLibCopyToFile
  static Future<int> dbLibCopyToFile(TprMID tid, String? file, String? file2, String? table, DbLibCopyParam cpyParam) async {
    String sql = "";	// COPY文の文字列
    String sqlAdd = "";	// 上記に追加していくオプション文字列
    IOSink? fp1, fp2;
    File appendFile; // COPYの結果を一時保存するファイル
    String appendFileName;
    DbManipulationPs db = DbManipulationPs();

    // 引数チェック
    if (file == null || table == null) {
      TprLog().logAdd(tid, LogLevelDefine.error, 
        "dbLibCopyToFile: Error argument", errId: -1);
      return Typ.NG;
    }
    TprLog().logAdd(tid, LogLevelDefine.normal, "dbLibCopyToFile: Start table[$table] -> file[$file]");

    appendFile = TprxPlatform.getFile("$file.appenddata");
    appendFileName = appendFile.path;

    // COPYのSQL文を作成する (引数によりオプションを追加していく)
    if (cpyParam.selSql != null) {
      sql = "COPY ${cpyParam.selSql} TO '$appendFileName'";
    } else {
      sql = "COPY $table TO '$appendFileName'";
    }

    if (cpyParam.withNull != null) {
      // NULL文字を変化
      sqlAdd = " WITH NULL AS '${cpyParam.withNull}'";
      sql += sqlAdd;
    }
    if (cpyParam.delimiter != null) {
      // 区切文字を変化 (ver 8.0～)
      sqlAdd = " DELIMITER AS E'${cpyParam.delimiter}'";
      sql += sqlAdd;
    }
    if (cpyParam.csvType == Typ.ON) {
      // CSV形式で出力 (ver 8.0～)
      sql += " CSV";
    }

    // sql実行
    try {
      await db.dbCon.execute(sql);
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbLibCopyToFile: $sql\n$e,$s", errId: -1);
      return Typ.NG;
    }
    
    try {
      if (!appendFile.existsSync()) {
        return Typ.NG;
      }
      // COPYクエリ出力結果をファイルに書き込む
      fp1 = TprxPlatform.getFile(file).openWrite(mode: cpyParam.isAppend ? FileMode.append : FileMode.write);
      await fp1.addStream(appendFile.openRead());
      if (file2 != null) {
        fp2 = TprxPlatform.getFile(file2).openWrite(mode: FileMode.append);
        await fp2.addStream(appendFile.openRead());
      }

    } on FileSystemException catch(e) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbLibCopyToFile: $file\n$e", errId: -1);
      return Typ.NG;
    } finally {
      fp1?.close();
      fp2?.close();
      try {
        appendFile.deleteSync();
      } on FileSystemException catch(e) {
        TprLog().logAdd(tid, LogLevelDefine.error, "dbLibCopyToFile: appendDataFile delete failed\n$e", errId: -1);
        return Typ.NG;
      }
    }

    return	Typ.OK;
  }

  /// 関数:	接続先DBの対象のテーブルへ対象のテキストをコピーする
  /// 引数:	file: テーブルへコピーするファイル名. 絶対パス or 相対パスで記述
  ///       table: コピーさせたいテーブル名
  ///       CpyParam: コピーのオプションを切り換えるための構造体. メンバにセットする値によってカンマ区切になったりする
  /// 戻値:	コピーが成功したらOK. 失敗したらNGを返す
  /// 関連tprxソース: db_comlib.c - dbLibCopyFromFile
  static Future<int> dbLibCopyFromFile(TprMID tid, String? file, String? table, DbLibCopyParam cpyParam ) async {
    String sql; // COPY文の文字列
    String sqlAdd; // 上記に追加していくオプション文字列
    DbManipulationPs db = DbManipulationPs();

    // 引数チェック
    if( (file == null) || (table == null) )
    {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbLibCopyFromFile: Error argument ", errId: -1);
      return	Typ.NG;
    }

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbLibCopyFromFile: Start file[$file] -> table[$table]");

    // ファイルが存在しない場合はエラー
    if(!TprxPlatform.getFile(file).existsSync()) {
      return	Typ.NG;
    }

    // COPYのSQL文を作成する (引数によりオプションを追加していく)
    sql = "COPY $table FROM '${TprxPlatform.getFile(file).path}'";

    if( cpyParam.withNull != null ) {
      // NULL文字を変化
      sqlAdd = " WITH NULL AS '${cpyParam.withNull}'";
      sql += sqlAdd;
    }

    if( cpyParam.delimiter != null) {
      // 区切文字を変化 (ver 8.0～)
      sqlAdd = " DELIMITER AS '${cpyParam.delimiter}'";
      sql += sqlAdd;
    }
    
    // sql実行
    try {
      await db.dbCon.execute(sql);
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbLibCopyFromFile: $sql\n$e,$s", errId: -1);
      return Typ.NG;
    }

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbLibCopyFromFile: End");

    return	Typ.OK;
  }

  /// 機能概要	: テーブルに企業コード・店舗コードフィールドが存在するか確認する
  /// パラメータ	: table_name	: チェック対象のテーブル名
  /// 戻り値	: -1:失敗
  ///         :  0:企業コード、店舗コード　どちらもなし
  ///         :  1:企業コード のみあり
  ///         :  2:店舗コード のみあり
  ///         :  3:企業コード、店舗コード　どちらもあり
  /// 関連tprxソース: db_comlib.c - db_comlib_CheckColumnsCompStre
  static Future<int>	dbComlibCheckColumnsCompStre(TprMID tid, String? table_name) async {
    int ntuples = 0;
    int ret = 0;
    String sql = "";
    String buf = "";
    DbManipulationPs db = DbManipulationPs();
    Result result;

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbComlibCheckColumnsCompStre start [$table_name]");

    // 引数チェック
    if (table_name == null) {
      TprLog().logAdd(tid, LogLevelDefine.normal, "dbComlibCheckColumnsCompStre argument error", 
        errId: -1);
      return -1;
    }

    // sql実行
    try {
      // 企業コード・店舗コードのカラムが存在するかチェックする
      sql = "SELECT atr.attname FROM pg_attribute atr, pg_class cls, pg_constraint cst WHERE cls.relname = '$table_name' AND atr.attrelid = cls.oid AND atr.attnum > 0 AND cst.conrelid = cls.oid AND cst.contype='p' AND atr.attnum = ANY(cst.conkey) AND atr.attname IN ('comp_cd', 'stre_cd');";
      result = await db.dbCon.execute(sql);
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, 
        "dbComlibCheckColumnsCompStre db_PQexec failed! sql [$sql]\n$e,$s",
        errId: -1);
      return -1;
    }

    // 取得した行数
    ntuples = result.length;

    if (ntuples > 0) {
      // フィールド名の取得
      for (ResultRow row in result) {
        buf = row.toColumnMap()["attname"].toString();
        // 取得した行が 企業コード
        if (buf == "comp_cd") {
          ret += 1;
        }
        // 取得した行が 店舗コード
        else if (buf == "stre_cd") {
          ret += 2;
        }
      }
    }

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbComlibCheckColumnsCompStre end [$ret]");

    return ret;
  }

  /// 機能概要	: テーブルにプライマリーキーのレジコードフィールドが存在するか確認する
  /// パラメータ	: table_name	: チェック対象のテーブル名
  /// 戻り値	: -1:失敗
  ///         :  0:レジコードなし
  ///         :  1:レジコードあり
  /// 関連tprxソース: db_comlib.c - db_comlib_CheckColumnsMac
  static Future<int> dbComlibCheckColumnsMac(TprMID tid, String? tableName) async {
    int ntuples = 0;
    int ret = 0;
    String sql = "";
    String buf = "";
    DbManipulationPs db = DbManipulationPs();
    Result result;

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbComlibCheckColumnsMac start [$tableName]");

    // 引数チェック
    if (tableName == null) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibCheckColumnsMac argument error", errId: -1);
      return -1;
    }

    // sql実行
    try {
      // レジ番号のカラムが存在するかチェックする
      sql = "SELECT atr.attname FROM pg_attribute atr, pg_class cls, pg_constraint cst WHERE cls.relname = 'table_name' AND atr.attrelid = cls.oid AND atr.attnum > 0 AND cst.conrelid = cls.oid AND cst.contype='p' AND atr.attnum = ANY(cst.conkey) AND atr.attname = 'mac_no';";
      result = await db.dbCon.execute(sql);
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbComlibCheckColumnsMac db_PQexec failed! sql [$sql]\n$e,$s", errId: -1);
      return -1;
    }

    // 取得した行数
    ntuples = result.length;

    if (ntuples > 0) {
      // フィールド名の取得
      for (ResultRow row in result) {
        buf = row.toColumnMap()["attname"].toString();
        // 取得した行が レジコード
        if (buf == "mac_no") {
          ret = 1;
          break;
        }
      }
    }

    TprLog().logAdd(tid, LogLevelDefine.normal, "dbComlibCheckColumnsMac end [$ret]");

    return ret;
  }

  /// c_reginfo_mstよりマシン番号からIPアドレスを取得する
  /// 引数:[tid] タスクID
  /// 引数:[macNo] IPアドレスを取得したいマシン番号
  /// 引数:[size] ipAddrのサイズ(byte)
  /// 戻値:[int] OK=取得成功  NG=取得失敗
  /// 戻値:[String] IPアドレス格納ポインタ
  /// 関連tprxソース: db_comlib.c - db_comlib_CheckColumnsMac
  static Future<(int, String)> dbLibGetIpAddrFromMacAddr(TprMID tid, int macNo) async {
    String ipAddr = "";

    // 引数チェック
    if (macNo == 0) {
      TprLog().logAdd(tid, LogLevelDefine.error,"DbComlib.dbLibGetIpAddrFromMacAddr(): Error argument");
      return (Typ.NG, ipAddr);
    }

    int ret = Typ.OK;
    RegInfoBuff	regInfo = RegInfoBuff();

    // c_reginfo_mstよりIPアドレス取得
    (ret, regInfo) = await dbLibGetRegInfo(tid, macNo, null);
    if (ret == Typ.NG) {
      TprLog().logAdd(tid, LogLevelDefine.error,"DbComlib.dbLibGetIpAddrFromMacAddr(): Error dbLibGetRegInfo");
      return (Typ.NG, ipAddr);
    }

    ipAddr = regInfo.ipAddr;
    return (Typ.OK, ipAddr);
  }

  /// c_reginfo_mstより対象のマシン番号(もしくはIPアドレス)のレコードを取得する
  /// 引数:[tid] タスクID
  /// 引数:[macNo] レコードを取得したいマシン番号 (0の場合 ipAddrが優先される)
  /// 引数:[ipAddr] IPアドレス格納ポインタ
  /// 戻値:[int] OK=取得成功  NG=取得失敗
  /// 戻値:[RegInfoBuff] 取得レコード
  /// 関連tprxソース: db_comlib.c - dbLibGetRegInfo
  static Future<(int, RegInfoBuff)> dbLibGetRegInfo(TprMID tid, int macNo, String? ipAddr) async {
    String callFunc = "DbComlib.dbLibGetRegInfo()";
    RegInfoBuff regInfo = RegInfoBuff();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: rxMemRead error");
      return (Typ.NG, regInfo);
    }
    RxCommonBuf cBuf = xRet.object;

    List<String> ip = ["", "", "", ""];
    String sqlAdd = "";
    if ((macNo == 0) && (ipAddr != null) && (ipAddr != "")) {
      ip = ipAddr.split('.');
      sqlAdd = "     split_part(ip_addr, '.', 1)::int = '${ip[0]}' AND split_part(ip_addr, '.', 2)::int = '${ip[1]}' AND split_part(ip_addr, '.', 3)::int = '${ip[2]}' AND split_part(ip_addr, '.', 4)::int = '${ip[3]}' and mac_typ < 1000;";
    }
    else {
      sqlAdd = " mac_no = '$macNo';";
    }
    String sql = "SELECT * FROM c_reginfo_mst WHERE comp_cd = '${cBuf.dbRegCtrl.compCd}' AND stre_cd = '${cBuf.dbRegCtrl.streCd}' AND $sqlAdd";

    DbManipulationPs db = DbManipulationPs();
    try {
      Result dbRes = await db.dbCon.execute(sql);
      if (dbRes.affectedRows == 0) {
        TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: no record (sql: $sql)");
        return (Typ.NG, regInfo);
      }
      Map<String, dynamic> data = dbRes.first.toColumnMap();
      // TODO:
      // regInfo.macTyp = data["mac_typ"];
      //regInfo.macNo = int.tryParse(data["mac_no"]) ?? 0;
      regInfo.macAddr = data["mac_addr"] ?? "";
      regInfo.ipAddr = data["ip_addr"] ?? "";
      regInfo.brdcastAddr = data["brdcast_addr"] ?? "";
      // regInfo.insDatetime = DateTime.tryParse(data["ins_datetime"]);
      // regInfo.updDatetime = DateTime.tryParse(data["upd_datetime"]);
      // regInfo.setOwnerFlg = int.parse(data["set_owner_flg"]);
      // regInfo.macRole1 = int.parse(data["mac_role1"]);
      // regInfo.macRole2 = int.parse(data["mac_role2"]);
      // regInfo.macRole3 = int.parse(data["mac_role3"]);
      // regInfo.pbchgFlg = int.parse(data["pbchg_flg"]);
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: db_PQexec failed!!");
      return (Typ.NG, regInfo);
    }

    return (Typ.OK, regInfo);
  }
}

/// テーブルからファイルへコピーする時のオプション用設定値
/// 関連tprxソース: db_comlib.h - dbLibCopyParam
class DbLibCopyParam {
  String? withNull;	// NULL変換用 (NULLで非動作. それ以外でNULLを任意に変換)
  String? delimiter;	// 区切り文字指定 (NULLで非動作. それ以外でタブ区切りを任意に変換)
  int csvType = 0;	// CSV形式 (OFFで非動作, ONで動作)
  int tranFlg = 0;	// トランザクションの動作を関数内で行うかのフラグ  0: しない 1: する
  // String? mode;		// fopenのモード	NULL時'+a' 
  bool isAppend = true;  // 追記モードかどうか(modeはfopen引数のため追記かどうかはこちらで判定する)
  String? selSql;	// COPYデータ
  String compCd = "";	// 取得対象の企業コード
  String streCd = "";	// 取得対象の店舗コード
}