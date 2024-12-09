/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pos/postgres_library/src/regcounter_logs_table_access.dart';
import 'package:postgres/postgres.dart';

//for reading setting file

import '../../app/common/cls_conf/db_libraryJsonFile_ps.dart';
import '../../app/common/cls_conf/mac_infoJsonFile.dart';
import '../../app/inc/sys/tpr_log.dart';
import 'basic_table_access.dart';
import 'customer_table_access.dart';
import 'data_logs_table_access.dart';
import 'ej_logs_table_access.dart';
import 'header_logs_table_access.dart';
import 'non_promotion_table_access.dart';
import 'pos_basic_table_access.dart';
import 'pos_log_table_access.dart';
import 'pos_other_table_access.dart';
import 'pos_sale_performance_table_access.dart';
import 'royalty_promotion_table_access.dart';
import 'sale_table_access.dart';
import 'staff_table_access.dart';
import 'status_logs_table_access.dart';
import 'system_table_access.dart';
import 'flutter_add_table_access.dart';
import 'arcs_add_table_access.dart';

export  'package:postgres/postgres.dart';

class DbManipulationPs {
  /// DBインスタンス openDBにて設定する
  late Connection _dbCon;

  /// DBインスタンス　openDB後に使用可能
  Connection get dbCon => _dbCon;

  ///設定ファイルから取得する
  /// DB名
  late String _dbName;

  /// ホスト名
  late String _host;

  /// ポート番号
  late int _port;

  /// ユーザー名
  late String _username;

  /// パスワード
  late String _password;
  
  /// 接続タイムアウト時間
  late int _connecionTimeout;

  ///エラー文言
  final String loadErrStr = "loadSettings()でエラー発生. ";
  final String psqlErrStr = "pgpassファイルでのパスワード省略設定を見直すと改善される場合があります. ";
  final String initErrStr1 = "initDataSettings()でエラー発生(CREATE TABLE文).";
  final String initErrStr2 = "initDataSettings()でエラー発生(INSERT文1).";
  final String initErrStr3 = "initDataSettings()でエラー発生(INSERT文2).";
  final String initErrStr4 = "initDataSettings()でエラー発生(CREATE FUNCTION文).";
  final String execSqlStr = "execSqlFromAsset()でエラー発生.";
  final String openLocalErrStr = "openDB()でエラー発生. ";
  final String initializeLocalErrStr = "initializeDB()でエラー発生. ";
  final String openExternalErrStr = "openExternalDB()でエラー発生. ";

  /// 内部インスタンス
  /// 機能説明:staticなインスタンスを事前に作成
  static final DbManipulationPs _instance = DbManipulationPs._internal();

  /// 1.Factoryコンストラクタ
  /// 機能説明:staticな内部コンストラクタを返す
  /// (シングルトンパターンの実装のため、この形にしています)
  factory DbManipulationPs() {
    return _instance;
  }

  /// 2.内部で利用する別名コンストラクタ
  /// 機能説明:名前付きコンストラクタとして定義する.中での追加処理はなし.
  /// 補足:設定ファイルから情報を取得して、プロパティに設定するのはopenで行います.
  /// 補足:DBのオープン処理はここでしてはならない(awaitをつけて明示的に呼んでもらわないといけないので)
  DbManipulationPs._internal() {}

  /// 3.設定ファイル情報を取得し、プロパティに設定
  /// 引数:なし
  /// 戻り値:なし
  Future<void> loadSettings(String connectType) async {
    try{
      //設定ファイル取得クラスインスタンス(DB設定)
      Db_libraryJsonFile_Ps db_libraryjson_ps = Db_libraryJsonFile_Ps();
      await db_libraryjson_ps.load();

      //内部接続(local)と外部接続(external)で分岐
      if(connectType == "local") {
        _dbName = db_libraryjson_ps.localdb.dbName;
        _port = int.parse(db_libraryjson_ps.localdb.port);
        _username = db_libraryjson_ps.localdb.username;
        _password = db_libraryjson_ps.localdb.password;
        _host = db_libraryjson_ps.localdb.host;
        _connecionTimeout = int.parse(db_libraryjson_ps.localdb.connectionTimeout);
      }else if(connectType == "external"){
        _dbName = db_libraryjson_ps.externaldb.dbName;
        _port = int.parse(db_libraryjson_ps.externaldb.port);
        _username = db_libraryjson_ps.externaldb.username;
        _password = db_libraryjson_ps.externaldb.password;
        _host = db_libraryjson_ps.externaldb.host;
        _connecionTimeout = int.parse(db_libraryjson_ps.externaldb.connectionTimeout);
      }

    }catch(e){
      String errStr = loadErrStr + e.toString();
      TprLog().logAdd(0, LogLevelDefine.normal, errStr);
      debugPrint(errStr);
      rethrow;
    }

  }

  /// 4.初期データ導入処理
  /// 引数:なし
  /// 戻り値:なし
  /// awaitで呼んでもらう必要があるので、Futureをつけています
  /// openDB()内でDB接続後に実行する
  Future<void> initDataSettings() async {
    debugPrint ("----DB セットアップ開始 アプリを止めずにお待ちください,アプリを止めるとDBが中途半端になる可能性があります----");
    // 設定ファイル取得クラスインスタンス(MACINFO)
    Mac_infoJsonFile mac_infojson = Mac_infoJsonFile();
    await mac_infojson.load();

    int comp_init = mac_infojson.system.crpno;
    int stre_init = mac_infojson.system.shpno;
    int macno_init = mac_infojson.system.macno;
    int grp_init = 1;

    String _crt_sql = "assets/sql/crt_sql";
    String _ins_sql = "assets/sql/ins_sql_demo";
    String _func_sql = "assets/sql/func_sql";
    String _copy_sql = "assets/sql/copy_insert_sql";
    String COMP = "COMP=$comp_init";
    String STRE = "STRE=$stre_init";
    String MACNO = "MACNO=$macno_init";
    String GRP = "GRP=$grp_init";

    // 初期データ導入
    // CREATE TABLE, CREATE INDEX実行
    debugPrint ("DB 初期データ導入開始----");
    var create_process = await Process.run('psql', [
      '-U', _username,
      '-h', _host,
      '-d', _dbName,
      '-f', _crt_sql,
      '-w'
    ]);
   
 
    debugPrint ("DB 初期データ導入終了----");

    // コマンド実行結果が空なら実行失敗のためエラーログを出力.
    // stderrで判定しない理由は、SQL実行の際に問題のないNOTICEの文言がstderrに入ってしまうため.
    // NOTICEの例："NOTICE:  table "c_recoginfo_mst" does not exist, skipping"
    if(create_process.stdout == ""){
      String errStr = initErrStr1 + psqlErrStr + create_process.stderr;
      TprLog().logAdd(0, LogLevelDefine.normal, errStr);
      debugPrint(errStr);
      // 'initDataError'はinitDataSettings()のエラーを示す.
      // openDB()で二重にエラーを出力しないように、ケース分けしてエラー処理を実行する.
      throw Exception('initDataError');
    }

    // COPYファイルのinsert実行（INSERT文1）
    // memo: アークス様向けのデータを先に挿入する
    debugPrint ("DB COPYファイルのinsert開始----");
    var insert_process2 = await Process.run('psql', [
      '-U', _username,
      '-h', _host,
      '-d', _dbName,
      '-f', _copy_sql,
      '-v', COMP,
      '-v', STRE,
      '-w'
    ]);
      debugPrint ("DB COPYファイルのinsert終了----");

    //コマンド実行結果が空なら実行失敗のためエラーログを出力
    if(insert_process2.stdout == ""){
      String errStr = initErrStr3 + psqlErrStr + insert_process2.stderr;
      TprLog().logAdd(0, LogLevelDefine.normal, errStr);
      debugPrint(errStr);
      // 'initDataError'はinitDataSettings()のエラーを示す.
      // openDB()で二重にエラーを出力しないように、ケース分けしてエラー処理を実行する.
      throw Exception('initDataError');
    }
    // INSERT 実行（INSERT文1）
    // memo: 共通のデータ挿入文
      debugPrint ("DB 共通のデータinsert開始----");
    var insert_process1 = await Process.run('psql', [
      '-U', _username,
      '-h', _host,
      '-d', _dbName,
      '-f', _ins_sql,
      '-v', COMP,
      '-v', STRE,
      '-v', MACNO,
      '-v', GRP,
      '-w'
    ]);
     debugPrint ("DB 共通のデータinsert終了----");

    //コマンド実行結果が空なら実行失敗のためエラーログを出力
    if(insert_process1.stdout == ""){
      String errStr = initErrStr2 + psqlErrStr + insert_process1.stderr;
      TprLog().logAdd(0, LogLevelDefine.normal, errStr);
      debugPrint(errStr);
      // 'initDataError'はinitDataSettings()のエラーを示す.
      // openDB()で二重にエラーを出力しないように、ケース分けしてエラー処理を実行する.
      throw Exception('initDataError');
    }
    // CREATE FUNCTION 実行
     debugPrint ("DB CREATE FUNCTION開始----");

    var func_process = await Process.run('psql', [
        '-U', _username,
        '-h', _host,
        '-d', _dbName,
        '-f', _func_sql,
        '-w'
      ]);
     debugPrint ("DB CREATE FUNCTION終了----");
    //コマンド実行結果が空なら実行失敗のためエラーログを出力
    if(func_process.stdout == ""){
      String errStr = initErrStr4 + psqlErrStr + func_process.stderr;
      TprLog().logAdd(0, LogLevelDefine.normal, errStr);
      debugPrint(errStr);
      // 'initDataError'はinitDataSettings()のエラーを示す.
      // openDB()で二重にエラーを出力しないように、ケース分けしてエラー処理を実行する.
      throw Exception('initDataError');
    }

    debugPrint ("----DB セットアップ完了----");
  }

  /// 機能：アセットの中のsqlファイルを実行する.
  /// 引数：アセット内のsqlファイル, psqlコマンドに設定する引数リスト
  /// 戻り値：Process.runで実行したコマンドのエラー内容（String型）
  /// 補足：[assetPath] 例:assets/sql/insert/mm_recoginfomst.out
  Future<String> execSqlFromAsset(String assetPath ,List<String> variableList ) async {
    List<String> vCommandList = [];
    for(var data in variableList){
      vCommandList.add('-v');
      vCommandList.add(data);
    }
    // sqlファイル 実行
    var process = await Process.run('psql', [
      '-U', _username,
      '-h', _host,
      '-d', _dbName,
      '-f', assetPath,
      '-w',
      ...vCommandList
    ]);

    return process.stderr;
  }

  /// 5.DBオープン
  /// 引数:なし
  /// 戻り値:PostgreSQLConnectionのインスタンス
  /// awaitで呼んでもらう必要があるので、Futureをつけています
  Future<Connection> openDB() async {
    // 呼び出し元が精算機の場合は外部接続用のパスを設定する
    // 精算機情報を取得する部分でエラーが発生するため、解消するまで保留中。該当処理はコメントアウトで残すことにする。
    String connectType;
    // AppUniqueObj uniqueObj = AppUniqueObj();

    // if(uniqueObj.varScreenKind == ScreenKind.adjustmentMachine.name){
    //   connectType = "external";
    // }else {
    connectType = "local";
    // }
    await loadSettings(connectType);
    try{
      _dbCon = await Connection.open(
          Endpoint(host: _host,
            port:_port,
            database: _dbName,
            username: _username,
            password: _password,
          ),
          settings: ConnectionSettings(connectTimeout: Duration(seconds: _connecionTimeout),sslMode:SslMode.disable));

    }catch(e){
      String errStr = openLocalErrStr + e.toString();
      TprLog().logAdd(0, LogLevelDefine.normal, errStr);
      debugPrint(errStr);
      rethrow;
    }

    //初回のみinitDataSettings()を実行する
    String tblsearch =
        "select tablename from pg_tables where schemaname = 'public' and tableowner = 'postgres'";
    try {
      List<List<dynamic>> sql_results = await _dbCon.execute(tblsearch);
      if (sql_results.toString() == "[]") {
          await initDataSettings();
      }
      return _dbCon;
    }catch(e){
      switch(e){
        // 'initDataError'はinitDataSettings()のエラーを示す.
        // openDB()で二重にエラーを出力しないように、ケース分けしてエラー処理を実行する.
        case 'initDataError':
          rethrow;
        default:
          String errStr = openLocalErrStr + e.toString();
          TprLog().logAdd(0, LogLevelDefine.normal, errStr);
          debugPrint(errStr);
          rethrow;
      }
    }
  }

  /// 6.rollback文実行
  /// 引数:トランザクション変数
  /// 戻り値:なし
  /// トランザクション内でのみ使用すること
  void rollback(TxSession txn) {
    txn.rollback();
  }

  /// DBを再作成して初期データを投入する
  Future<void> initializeDB() async {
    // }
    await loadSettings("local");
    try{
      final Connection dbCon = await Connection.open(
        Endpoint(host: _host,
          port:_port,
          database: "postgres",
          username: _username,
          password: _password,
        ),
        settings: ConnectionSettings(connectTimeout: Duration(seconds: _connecionTimeout),sslMode:SslMode.disable)
      );

      // 接続済みのセッションを切断してDBを再作成
      await dbCon.execute('drop database if exists "tpr.db" with (FORCE);');
      await dbCon.execute('create database "tpr.db";');
      await dbCon.close();

      // コネクションを張り直し、テーブル作成から初期データ投入まで行う
      await openDB();
    }catch(e){
      String errStr = initializeLocalErrStr + e.toString();
      TprLog().logAdd(0, LogLevelDefine.error, errStr);
      debugPrint(errStr);
      rethrow;
    }
  }

}

//region typedef アクセスクラス
typedef CCompMst = CCompMstColumns;
typedef CStreMst = CStreMstColumns;
typedef CConnectMst = CConnectMstColumns;
typedef CClsMst = CClsMstColumns;
typedef CGrpMst = CGrpMstColumns;
typedef CZipcodeMst = CZipcodeMstColumns;
typedef CTaxMst = CTaxMstColumns;
typedef CCaldrMst = CCaldrMstColumns;
typedef SNathldyMst = SNathldyMstColumns;
typedef CSub1ClsMst = CSub1ClsMstColumns;
typedef CSub2ClsMst = CSub2ClsMstColumns;
typedef CCustMst = CCustMstColumns;
typedef SDaybookSppluTbl = SDaybookSppluTblColumns;
typedef CCustJdgMst = CCustJdgMstColumns;
typedef CMbrcardMst = CMbrcardMstColumns;
typedef CMbrcardSvsMst = CMbrcardSvsMstColumns;
typedef CDataLog01 = CDataLog01Columns;
typedef CDataLog02 = CDataLog02Columns;
typedef CDataLog03 = CDataLog03Columns;
typedef CDataLog04 = CDataLog04Columns;
typedef CDataLog05 = CDataLog05Columns;
typedef CDataLog06 = CDataLog06Columns;
typedef CDataLog07 = CDataLog07Columns;
typedef CDataLog08 = CDataLog08Columns;
typedef CDataLog09 = CDataLog09Columns;
typedef CDataLog10 = CDataLog10Columns;
typedef CDataLog11 = CDataLog11Columns;
typedef CDataLog12 = CDataLog12Columns;
typedef CDataLog13 = CDataLog13Columns;
typedef CDataLog14 = CDataLog14Columns;
typedef CDataLog15 = CDataLog15Columns;
typedef CDataLog16 = CDataLog16Columns;
typedef CDataLog17 = CDataLog17Columns;
typedef CDataLog18 = CDataLog18Columns;
typedef CDataLog19 = CDataLog19Columns;
typedef CDataLog20 = CDataLog20Columns;
typedef CDataLog21 = CDataLog21Columns;
typedef CDataLog22 = CDataLog22Columns;
typedef CDataLog23 = CDataLog23Columns;
typedef CDataLog24 = CDataLog24Columns;
typedef CDataLog25 = CDataLog25Columns;
typedef CDataLog26 = CDataLog26Columns;
typedef CDataLog27 = CDataLog27Columns;
typedef CDataLog28 = CDataLog28Columns;
typedef CDataLog29 = CDataLog29Columns;
typedef CDataLog30 = CDataLog30Columns;
typedef CDataLog31 = CDataLog31Columns;
typedef CDataLogReserv = CDataLogReservColumns;
typedef CDataLogReserv01 = CDataLogReserv01Columns;
typedef CEjLog01 = CEjLog01Columns;
typedef CEjLog02 = CEjLog02Columns;
typedef CEjLog03 = CEjLog03Columns;
typedef CEjLog04 = CEjLog04Columns;
typedef CEjLog05 = CEjLog05Columns;
typedef CEjLog06 = CEjLog06Columns;
typedef CEjLog07 = CEjLog07Columns;
typedef CEjLog08 = CEjLog08Columns;
typedef CEjLog09 = CEjLog09Columns;
typedef CEjLog10 = CEjLog10Columns;
typedef CEjLog11 = CEjLog11Columns;
typedef CEjLog12 = CEjLog12Columns;
typedef CEjLog13 = CEjLog13Columns;
typedef CEjLog14 = CEjLog14Columns;
typedef CEjLog15 = CEjLog15Columns;
typedef CEjLog16 = CEjLog16Columns;
typedef CEjLog17 = CEjLog17Columns;
typedef CEjLog18 = CEjLog18Columns;
typedef CEjLog19 = CEjLog19Columns;
typedef CEjLog20 = CEjLog20Columns;
typedef CEjLog21 = CEjLog21Columns;
typedef CEjLog22 = CEjLog22Columns;
typedef CEjLog23 = CEjLog23Columns;
typedef CEjLog24 = CEjLog24Columns;
typedef CEjLog25 = CEjLog25Columns;
typedef CEjLog26 = CEjLog26Columns;
typedef CEjLog27 = CEjLog27Columns;
typedef CEjLog28 = CEjLog28Columns;
typedef CEjLog29 = CEjLog29Columns;
typedef CEjLog30 = CEjLog30Columns;
typedef CEjLog31 = CEjLog31Columns;
typedef CHeaderLog01 = CHeaderLog01Columns;
typedef CHeaderLog02 = CHeaderLog02Columns;
typedef CHeaderLog03 = CHeaderLog03Columns;
typedef CHeaderLog04 = CHeaderLog04Columns;
typedef CHeaderLog05 = CHeaderLog05Columns;
typedef CHeaderLog06 = CHeaderLog06Columns;
typedef CHeaderLog07 = CHeaderLog07Columns;
typedef CHeaderLog08 = CHeaderLog08Columns;
typedef CHeaderLog09 = CHeaderLog09Columns;
typedef CHeaderLog10 = CHeaderLog10Columns;
typedef CHeaderLog11 = CHeaderLog11Columns;
typedef CHeaderLog12 = CHeaderLog12Columns;
typedef CHeaderLog13 = CHeaderLog13Columns;
typedef CHeaderLog14 = CHeaderLog14Columns;
typedef CHeaderLog15 = CHeaderLog15Columns;
typedef CHeaderLog16 = CHeaderLog16Columns;
typedef CHeaderLog17 = CHeaderLog17Columns;
typedef CHeaderLog18 = CHeaderLog18Columns;
typedef CHeaderLog19 = CHeaderLog19Columns;
typedef CHeaderLog20 = CHeaderLog20Columns;
typedef CHeaderLog21 = CHeaderLog21Columns;
typedef CHeaderLog22 = CHeaderLog22Columns;
typedef CHeaderLog23 = CHeaderLog23Columns;
typedef CHeaderLog24 = CHeaderLog24Columns;
typedef CHeaderLog25 = CHeaderLog25Columns;
typedef CHeaderLog26 = CHeaderLog26Columns;
typedef CHeaderLog27 = CHeaderLog27Columns;
typedef CHeaderLog28 = CHeaderLog28Columns;
typedef CHeaderLog29 = CHeaderLog29Columns;
typedef CHeaderLog30 = CHeaderLog30Columns;
typedef CHeaderLog31 = CHeaderLog31Columns;
typedef CHeaderLogReserv = CHeaderLogReservColumns;
typedef CHeaderLogReserv01 = CHeaderLogReserv01Columns;
typedef CPlanMst = CPlanMstColumns;
typedef SBrgnMst = SBrgnMstColumns;
typedef SBdlschMst = SBdlschMstColumns;
typedef SBdlitemMst = SBdlitemMstColumns;
typedef SStmschMst = SStmschMstColumns;
typedef SStmitemMst = SStmitemMstColumns;
typedef SPluPointMst = SPluPointMstColumns;
typedef SSubtschMst = SSubtschMstColumns;
typedef SClsschMst = SClsschMstColumns;
typedef SSvsSchMst = SSvsSchMstColumns;
typedef CReginfoMst = CReginfoMstColumns;
typedef COpencloseMst = COpencloseMstColumns;
typedef CRegcnctSioMst = CRegcnctSioMstColumns;
typedef CSioMst = CSioMstColumns;
typedef CReginfoGrpMst = CReginfoGrpMstColumns;
typedef CImgMst = CImgMstColumns;
typedef CPresetMst = CPresetMstColumns;
typedef CPresetImgMst = CPresetImgMstColumns;
typedef CCtrlMst = CCtrlMstColumns;
typedef CCtrlSetMst = CCtrlSetMstColumns;
typedef CCtrlSubMst = CCtrlSubMstColumns;
typedef CTrmMst = CTrmMstColumns;
typedef CTrmSetMst = CTrmSetMstColumns;
typedef CTrmSubMst = CTrmSubMstColumns;
typedef CTrmMenuMst = CTrmMenuMstColumns;
typedef CTrmTagGrpMst = CTrmTagGrpMstColumns;
typedef CKeyfncMst = CKeyfncMstColumns;
typedef CKeyoptMst = CKeyoptMstColumns;
typedef CKeykindMst = CKeykindMstColumns;
typedef CKeykindGrpMst = CKeykindGrpMstColumns;
typedef CKeyoptSetMst = CKeyoptSetMstColumns;
typedef CKeyoptSubMst = CKeyoptSubMstColumns;
typedef CDivideMst = CDivideMstColumns;
typedef CTmpLog = CTmpLogColumns;
typedef CPrcchgMst = CPrcchgMstColumns;
typedef CBatrepoMst = CBatrepoMstColumns;
typedef CReportCnt = CReportCntColumns;
typedef CMemoMst = CMemoMstColumns;
typedef CMemosndMst = CMemosndMstColumns;
typedef CRecogGrpMst = CRecogGrpMstColumns;
typedef PRecogMst = PRecogMstColumns;
typedef CRecoginfoMst = CRecoginfoMstColumns;
typedef CReportMst = CReportMstColumns;
typedef CMenuObjMst = CMenuObjMstColumns;
typedef PTriggerKeyMst = PTriggerKeyMstColumns;
typedef CFinitMst = CFinitMstColumns;
typedef CFinitGrpMst = CFinitGrpMstColumns;
typedef CSetTblNameMst = CSetTblNameMstColumns;
typedef CApplGrpMst = CApplGrpMstColumns;
typedef PApplMst = PApplMstColumns;
typedef CDialogMst = CDialogMstColumns;
typedef CDialogExMst = CDialogExMstColumns;
typedef PPromschMst = PPromschMstColumns;
typedef PPromitemMst = PPromitemMstColumns;
typedef CInstreMst = CInstreMstColumns;
typedef CFmttypMst = CFmttypMstColumns;
typedef CBarfmtMst = CBarfmtMstColumns;
typedef CMsgMst = CMsgMstColumns;
typedef CMsglayoutMst = CMsglayoutMstColumns;
typedef CMsgschMst = CMsgschMstColumns;
typedef CMsgschLayoutMst = CMsgschLayoutMstColumns;
typedef CTrmChkMst = CTrmChkMstColumns;
typedef CReportCondMst = CReportCondMstColumns;
typedef CReportAttrMst = CReportAttrMstColumns;
typedef CReportAttrSubMst = CReportAttrSubMstColumns;
typedef CReportSqlMst = CReportSqlMstColumns;
typedef CTcountMst = CTcountMstColumns;
typedef CStropnclsMst = CStropnclsMstColumns;
typedef CStropnclsSetMst = CStropnclsSetMstColumns;
typedef CStropnclsSubMst = CStropnclsSubMstColumns;
typedef CCashrecycleMst = CCashrecycleMstColumns;
typedef CCashrecycleSetMst = CCashrecycleSetMstColumns;
typedef CCashrecycleSubMst = CCashrecycleSubMstColumns;
typedef CCashrecycleInfoMst = CCashrecycleInfoMstColumns;
typedef CMsglayoutSetMst = CMsglayoutSetMstColumns;
typedef CPayoperatorMst = CPayoperatorMstColumns;
typedef CHeaderLog = CHeaderLogColumns;
typedef CDataLog = CDataLogColumns;
typedef CStatusLog = CStatusLogColumns;
typedef CEjLog = CEjLogColumns;
typedef CVoidLog01 = CVoidLog01Columns;
typedef CPbchgLog = CPbchgLogColumns;
typedef CReservLog = CReservLogColumns;
typedef CRecoverTbl = CRecoverTblColumns;
typedef CPbchgLog01 = CPbchgLog01Columns;
typedef CReservLog01 = CReservLog01Columns;
typedef CReservTbl = CReservTblColumns;
typedef PPbchgBalanceTbl = PPbchgBalanceTblColumns;
typedef PPbchgStreTbl = PPbchgStreTblColumns;
typedef PPbchgCorpTbl = PPbchgCorpTblColumns;
typedef PPbchgNcorpTbl = PPbchgNcorpTblColumns;
typedef PPbchgNtteTbl = PPbchgNtteTblColumns;
typedef CCrdtDemandTbl = CCrdtDemandTblColumns;
typedef PPrcchgSchMst = PPrcchgSchMstColumns;
typedef PPrcchgItemMst = PPrcchgItemMstColumns;
typedef PPrcchgMst = PPrcchgMstColumns;
typedef SBackyardGrpMst = SBackyardGrpMstColumns;
typedef CWizInfTbl = CWizInfTblColumns;
typedef CPassportInfoMst = CPassportInfoMstColumns;
typedef PNotfpluOffTbl = PNotfpluOffTblColumns;
typedef RdlyDeal = RdlyDealColumns;
typedef RdlyDealHour = RdlyDealHourColumns;
typedef RdlyFlow = RdlyFlowColumns;
typedef RdlyAcr = RdlyAcrColumns;
typedef RdlyClass = RdlyClassColumns;
typedef RdlyClassHour = RdlyClassHourColumns;
typedef RdlyPlu = RdlyPluColumns;
typedef RdlyPluHour = RdlyPluHourColumns;
typedef RdlyDsc = RdlyDscColumns;
typedef RdlyProm = RdlyPromColumns;
typedef RdlyCust = RdlyCustColumns;
typedef RdlySvs = RdlySvsColumns;
typedef RdlyCdpayflow = RdlyCdpayflowColumns;
typedef RdlyTaxDeal = RdlyTaxDealColumns;
typedef RdlyTaxDealHour = RdlyTaxDealHourColumns;
typedef WkQue = WkQueColumns;
typedef CAcctMst = CAcctMstColumns;
typedef CCpnhdrMst = CCpnhdrMstColumns;
typedef CCpnbdyMst = CCpnbdyMstColumns;
typedef SCustCpnTbl = SCustCpnTblColumns;
typedef CCpnCtrlMst = CCpnCtrlMstColumns;
typedef CLoystreMst = CLoystreMstColumns;
typedef CLoyplnMst = CLoyplnMstColumns;
typedef CLoypluMst = CLoypluMstColumns;
typedef CLoytgtMst = CLoytgtMstColumns;
typedef SCustLoyTbl = SCustLoyTblColumns;
typedef SCustTtlTbl = SCustTtlTblColumns;
typedef CRankMst = CRankMstColumns;
typedef CTrmRsrvMst = CTrmRsrvMstColumns;
typedef CPntschMst = CPntschMstColumns;
typedef CPntschgrpMst = CPntschgrpMstColumns;
typedef CTrmPlanMst = CTrmPlanMstColumns;
typedef SCustStpTbl = SCustStpTblColumns;
typedef CStpplnMst = CStpplnMstColumns;
typedef CPluMst = CPluMstColumns;
typedef CScanpluMst = CScanpluMstColumns;
typedef CSetitemMst = CSetitemMstColumns;
typedef CCaseitemMst = CCaseitemMstColumns;
typedef CAttribMst = CAttribMstColumns;
typedef CAttribitemMst = CAttribitemMstColumns;
typedef CLiqrclsMst = CLiqrclsMstColumns;
typedef CMakerMst = CMakerMstColumns;
typedef CProducerMst = CProducerMstColumns;
typedef CStaffMst = CStaffMstColumns;
typedef CStaffauthMst = CStaffauthMstColumns;
typedef SSvrStaffauthMst = SSvrStaffauthMstColumns;
typedef CKeyauthMst = CKeyauthMstColumns;
typedef CMenuauthMst = CMenuauthMstColumns;
typedef CStaffopenMst = CStaffopenMstColumns;
typedef COperationMst = COperationMstColumns;
typedef COperationauthMst = COperationauthMstColumns;
typedef CStatusLog01 = CStatusLog01Columns;
typedef CStatusLog02 = CStatusLog02Columns;
typedef CStatusLog03 = CStatusLog03Columns;
typedef CStatusLog04 = CStatusLog04Columns;
typedef CStatusLog05 = CStatusLog05Columns;
typedef CStatusLog06 = CStatusLog06Columns;
typedef CStatusLog07 = CStatusLog07Columns;
typedef CStatusLog08 = CStatusLog08Columns;
typedef CStatusLog09 = CStatusLog09Columns;
typedef CStatusLog10 = CStatusLog10Columns;
typedef CStatusLog11 = CStatusLog11Columns;
typedef CStatusLog12 = CStatusLog12Columns;
typedef CStatusLog13 = CStatusLog13Columns;
typedef CStatusLog14 = CStatusLog14Columns;
typedef CStatusLog15 = CStatusLog15Columns;
typedef CStatusLog16 = CStatusLog16Columns;
typedef CStatusLog17 = CStatusLog17Columns;
typedef CStatusLog18 = CStatusLog18Columns;
typedef CStatusLog19 = CStatusLog19Columns;
typedef CStatusLog20 = CStatusLog20Columns;
typedef CStatusLog21 = CStatusLog21Columns;
typedef CStatusLog22 = CStatusLog22Columns;
typedef CStatusLog23 = CStatusLog23Columns;
typedef CStatusLog24 = CStatusLog24Columns;
typedef CStatusLog25 = CStatusLog25Columns;
typedef CStatusLog26 = CStatusLog26Columns;
typedef CStatusLog27 = CStatusLog27Columns;
typedef CStatusLog28 = CStatusLog28Columns;
typedef CStatusLog29 = CStatusLog29Columns;
typedef CStatusLog30 = CStatusLog30Columns;
typedef CStatusLog31 = CStatusLog31Columns;
typedef CStatusLogReserv = CStatusLogReservColumns;
typedef CStatusLogReserv01 = CStatusLogReserv01Columns;
typedef CHistlogMst = CHistlogMstColumns;
typedef CHistlogChgCnt = CHistlogChgCntColumns;
typedef HistCtrlMst = HistCtrlMstColumns;
typedef HistlogSkipNum = HistlogSkipNumColumns;
typedef CHeaderLogFloating = CHeaderLogFloatingColumns;
typedef CDataLogFloating = CDataLogFloatingColumns;
typedef CStatusLogFloating = CStatusLogFloatingColumns;
typedef CLiqritemMst = CLiqritemMstColumns;
typedef CLiqrtaxMst = CLiqrtaxMstColumns;
typedef CBatprcchgMst = CBatprcchgMstColumns;
typedef CDivide2Mst = CDivide2MstColumns;
typedef CHitouchRcvLog = CHitouchRcvLogColumns;
typedef LanguagesMst = LanguagesMstColumns;
typedef CSmlschMst = CSmlschMstColumns;
typedef CSmlitemMst = CSmlitemMstColumns;
typedef CBrgnschMst = CBrgnschMstColumns;
typedef CBrgnitemMst = CBrgnitemMstColumns;
typedef CBdlschMst = CBdlschMstColumns;
typedef CBdlitemMst = CBdlitemMstColumns;
typedef CPluschMst = CPluschMstColumns;
typedef CPluitemMst = CPluitemMstColumns;
typedef CCrdtActualLog = CCrdtActualLogColumns;
typedef PRecogCounterLog = PRecogCounterLogColumns;
//endregion

/// テーブルクラスのスーパークラス
class TableColumns {
  String _getTableName() => 'superClass';

  String? _getKeyCondition() => '';

  List _getKeyValue() {
    List rn = [];
    return rn;
  }

  Map<String, dynamic> _toMap() {
    return {'superClass': 'superClass'};
  }

  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    TableColumns rn = TableColumns();
    return rn;
  }

  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      TableColumns rn = TableColumns();
      return rn;
    });
  }
}

