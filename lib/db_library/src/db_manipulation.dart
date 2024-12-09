/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart'; // debugPrintを使用するために使用
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//for windows to connect sqlite.
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//for reading setting file
import '../../app/common/cls_conf/db_libraryJsonFile.dart';
import '../../app/common/cls_conf/init_settingsJsonFile.dart';
import '../../app/common/cls_conf/mac_infoJsonFile.dart';
import '../../app/inc/sys/tpr_log.dart';


//DB作成時のテーブル作成と、各テーブルアクセスクラスをファイル分割します
part 'db_onCreate.dart';
part 'init_data.dart';
part 'init_data_mm.dart';
part 'init_data_mm2.dart';
part 'init_data_mm3.dart';
part 'init_data_mm4.dart';
part 'init_data_mm5.dart';
part 'init_data_ms.dart';
part 'basic_table_access.dart';
part 'sale_table_access.dart';
part 'pos_basic_table_access.dart';
part 'pos_other_table_access.dart';
part 'pos_log_table_access.dart';
part 'non_promotion_table_access.dart';
part 'royalty_promotion_table_access.dart';
part 'customer_table_access.dart';
part 'staff_table_access.dart';
part 'system_table_access.dart';
part 'pos_sale_performance_table_access.dart';
part 'data_logs_table_access.dart';
part 'header_logs_table_access.dart';
part 'status_logs_table_access.dart';
part 'ej_logs_table_access.dart';
part 'flutter_add_table_access.dart';
part 'arcs_add_table_access.dart';

class DbManipulation {
  /// DBインスタンス openDBにて設定する
  late Database _database;

  /// DBインスタンス　openDB後に使用可能
  Database get database => _database;

  ///設定ファイルから取得する
  /// DBパス使用可否
  late bool _isDbPathValid;
  /// DBパス
  late String _dbPath;
  /// サブディレクトリ
  late String _subDir;
  /// DB名
  late String _dbName;
  /// バージョン
  late int _version;

  /// 設定ファイル取得クラスインスタンス(DB設定)
  late Db_libraryJsonFile db_libraryjson;

  /// 内部インスタンス
  /// 機能説明:staticなインスタンスを事前に作成
  static final DbManipulation _instance = DbManipulation._internal();

  /// 1.Factoryコンストラクタ
  /// 機能説明:staticな内部コンストラクタを返す
  /// (シングルトンパターンの実装のため、この形にしています)
  factory DbManipulation() {
    return _instance;
  }

  /// 2.内部で利用する別名コンストラクタ
  /// 機能説明:名前付きコンストラクタとして定義する。中での追加処理はなし。
  /// 補足:設定ファイルから情報を取得して、プロパティに設定するのはopenで行います
  /// 補足:DBのオープン処理はここでしてはならない(awaitをつけて明示的に呼んでもらわないといけないので)
  DbManipulation._internal() {
  }

  /// 3.設定ファイル情報を取得し、プロパティに設定
  /// 引数:なし
  /// 戻り値:なし
  Future<void> loadSettings() async{
    db_libraryjson = Db_libraryJsonFile();
    await db_libraryjson.load();
    if (Platform.isWindows){
      _isDbPathValid = db_libraryjson.windows.isDbPathValid == 'false' ? false : true;
      _dbPath = db_libraryjson.windows.dbPath;
      _subDir = db_libraryjson.windows.subDir;
      _dbName = db_libraryjson.windows.dbName;
      _version = int.parse(db_libraryjson.windows.version);
    }else if (Platform.isLinux){
      _isDbPathValid = db_libraryjson.ubuntu.isDbPathValid == 'false' ? false : true;
      _dbPath = db_libraryjson.ubuntu.dbPath;
      _subDir = db_libraryjson.ubuntu.subDir;
      _dbName = db_libraryjson.ubuntu.dbName;
      _version = int.parse(db_libraryjson.ubuntu.version);
    }else if (Platform.isAndroid){
      _isDbPathValid = db_libraryjson.android.isDbPathValid == 'false' ? false : true;
      _dbPath = db_libraryjson.android.dbPath;
      _subDir = db_libraryjson.android.subDir;
      _dbName = db_libraryjson.android.dbName;
      _version = int.parse(db_libraryjson.android.version);
    }
  }

  /// 4.DBオープン
  /// 引数:なし
  /// 戻り値:なし
  /// awaitで呼んでもらう必要があるので、Futureをつけています
  Future openDB() async {
    await loadSettings();
    //何も入っていないのでnullになる。
    //debugPrint('openDB()最初に呼ばれるdatabaseの中身は${database?.toString()}');
    // ②プラットフォームごとに、違うpackageを使ってdbインスタンスを作成する
    late String path;
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      //PC
      if(_isDbPathValid){
        path = join(_dbPath, _subDir, _dbName);
      }else{
        path = join(Directory.current.path, _subDir, _dbName);
      }
      //debugPrint('pathの中身は${path.toString()}');
      TprLog().logAdd(0, LogLevelDefine.normal, 'pathの中身は${path.toString()}');

      sqfliteFfiInit();
      final options = OpenDatabaseOptions(
        version: _version,
        onCreate: (db, version) => _onCreate(db, version),
      );
      _database = await databaseFactoryFfi.openDatabase(path, options: options);
    } else {
      //Mobile
      if(_isDbPathValid){
        Directory dir = await getApplicationDocumentsDirectory();
        path = join(_dbPath, _subDir, _dbName);
      }else{
        Directory dir = await getApplicationDocumentsDirectory();
        path = join(dir.path, _subDir, _dbName);
      }
      TprLog().logAdd(0, LogLevelDefine.normal, 'pathの中身は${path.toString()}');

      _database = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) => _onCreate(db, version),
      );
    }
  }

  /// 5.DBクローズ
  /// 引数:なし
  /// 戻り値:なし
  Future<void> closeDB() async {
    await _database.close();
  }

  /// 6.トランザクション処理
  /// 引数:トランザクション変数
  /// 戻り値:なし
  /// 使い方例：正しい使い方
  ///   dbAccess1.makeTransaction((txn) async{
  ///     await dbAccess1.insert(comp,txn:txn);
  ///     await dbAccess1.insert(ejLog,txn:txn);
  ///   });
  /// 使い方例：誤った使い方
  ///   dbAccess1.makeTransaction((txn) async{
  ///     await dbAccess1.insert(comp);
  ///     await dbAccess1.insert(ejLog);
  ///   });
  /// トランザクションメソッド内でアクセスクラスのメソッドを使用する際にオプション引数のtxnを引数につけないとdeadlockを起こします
  Future<void> makeTransaction<T>(Future<T> Function(Transaction) action) async{
    try {
      await _database.transaction((txn) async => action(txn));
    }catch(e){
      if(e.toString() == 'Exception: rollback'){
        //debugPrint(e.toString());
        TprLog().logAdd(0, LogLevelDefine.normal, 'Rollbackを実行しました');
      }else{
        rethrow;
      }
    }
  }

  /// 7.名称：insert文実行
  /// 説明：テーブルクラスのインスタンスに設定した値を、そのテーブルへinsertする
  /// 引数：各テーブルクラスのインスタンス、{Transaction変数}
  /// 戻り値：なし
  /// トランザクションメソッドで使用する場合は、Transaction変数を指定すること！
  Future<void> insert(TableColumns tc,{Transaction? txn}) async {
    Map<String, Object?> map = tc._toMap();
    //debugPrint('insert()で挿入対象のCAST後データは${map.toString()}');
    TprLog().logAdd(0, LogLevelDefine.normal, 'insert()で挿入対象のCAST後データは${map.toString()}');
    if(txn != null){
      await txn.insert(tc._getTableName(), map);
      //debugPrint('txnを使用した');
      //TprLog().logAdd(0, LogLevelDefine.normal, 'txnを使用した');
    }else{
      await _database.insert(tc._getTableName(), map);
    }
  }

  /// 8.名称：update文実行
  /// 説明：テーブル名と更新される項目、Transaction変数(オプション)、Where句(オプション)、whereArgs(オプション)を指定して１つのテーブルからデータを削除するメソッド
  /// 引数：各テーブルクラスのインスタンス,{Transaction変数,where句,whereArgs}
  /// 戻り値:なし
  /// トランザクションメソッドで使用する場合は、Transaction変数を指定すること！
  Future<void> update(TableColumns tc, Map<String, Object?> map,
      {Transaction? txn,String? whereClause, List? whereArgs}) async {
    //debugPrint('update()で更新対象のデータは${map.toString()}');
    TprLog().logAdd(0, LogLevelDefine.normal, 'update()で更新対象のデータは${map.toString()}');
    if(txn != null){
      if (whereClause != null) {
        if (whereArgs != null) {
          await txn.update(tc._getTableName(), map,
              where: whereClause, whereArgs: whereArgs);
        } else {
          await txn.update(tc._getTableName(), map, where: whereClause);
        }
      } else {
        await txn.update(tc._getTableName(), map);
      }
    }else{
      if (whereClause != null) {
        if (whereArgs != null) {
          await _database.update(tc._getTableName(), map,
              where: whereClause, whereArgs: whereArgs);
        } else {
          await _database.update(tc._getTableName(), map, where: whereClause);
        }
      } else {
        await _database.update(tc._getTableName(), map);
      }
    }
  }

  /// 9.名称：delete文実行
  /// 説明：テーブル名とTransaction変数(オプション)、Where句(オプション)、whereArgs(オプション)を指定して１つのテーブルからデータを削除するメソッド
  /// 引数：各テーブルクラスのインスタンス,{Transaction変数,where句,whereArgs}
  /// 戻り値:なし
  /// トランザクションメソッドで使用する場合は、Transaction変数を指定すること！
  Future<void> delete(TableColumns tc,
      {Transaction? txn,String? whereClause, List? whereArgs}) async {
    if(txn != null){
      if (whereClause != null) {
        if (whereArgs != null) {
          await txn.delete(tc._getTableName(),
              where: whereClause, whereArgs: whereArgs);
        } else {
          await txn.delete(tc._getTableName(), where: whereClause);
        }
      } else {
        await txn.delete(tc._getTableName());
      }
    }else{
      if (whereClause != null) {
        if (whereArgs != null) {
          await _database.delete(tc._getTableName(),
              where: whereClause, whereArgs: whereArgs);
        } else {
          await _database.delete(tc._getTableName(), where: whereClause);
        }
      } else {
        await _database.delete(tc._getTableName());
      }
    }
  }

  /// 10.rollback文実行
  /// 引数:なし
  /// 戻り値:なし
  /// トランザクション内でのみ使用すること
  void rollback() {
    throw Exception('rollback');
  }

  /// 11.1レコード入ったテーブルクラスのクローン(Deep Copy)
  /// 引数:テーブルクラスのインスタンス
  /// 戻り値:テーブルクラスのインスタンス
  T cloneRecord<T extends TableColumns>(T tc) {
    // 戻り値T rnを準備
    T rn;
    // ①引数のテーブルクラスの_toMapを使ってテーブルクラスのインスタンスをMapに変換する
    Map<String, dynamic> originalMap = tc._toMap();
    // ②MapのListを用意し、①で変換したMapをaddする
    List<Map<String, dynamic>> originalMapList = <Map<String, dynamic>>[];
    originalMapList.add(originalMap);

    // ③②のMapのListのDeep Copyをする
    List<Map<String, dynamic>> cloneMapList = [...originalMapList];

    // ④③でDeep CopyしたMapのListを引数のテーブルクラスの_toTableを使って、
    // テーブルクラスのインスタンスに変換する
    // その際に型キャストをしてT型としてrnに代入する
    rn = tc._toTable(cloneMapList) as T;
    // rn を戻り値として返す
    return rn;
  }

  /// 12.複数レコード入ったテーブルクラスのリストのクローン(Deep Copy)
  /// 引数:テーブルクラスのインスタンスのリスト
  /// 戻り値:テーブルクラスのインスタンスのリスト
  List<T> cloneRecordList<T extends TableColumns>(List<T> ltc) {
    // ①MapのListを用意する
    List<Map<String, dynamic>> originalMapList = <Map<String, dynamic>>[];
    // ②引数のテーブルクラスのインスタンスのリストのlengthの数forループする
    for (int i = 0; i < ltc.length; i++) {
      // ③引数のテーブルクラスのリストのi番目のテーブルクラスの_toMapを使って
      // テーブルクラスのインスタンスをMapに変換する
      Map<String, dynamic> originalMap = ltc[i]._toMap();
      // ④①で用意したMapのListに③に変換したMapをaddする
      originalMapList.add(originalMap);
    }
    // ⑤ループさせて作成したMapのListのDeep Copyをする
    List<Map<String, dynamic>> cloneMapList = [...originalMapList];
    // ⑥⑤でDeep CopyしたMapのListを引数のListの0番目であるテーブルクラスの_toTableListを使って、
    // テーブルクラスのインスタンスのリストに変換する
    List<TableColumns> rn = ltc[0]._toTableList(cloneMapList);
    // ⑦⑥をTのListに型キャストして戻り値として返す
    return rn.cast<T>();
  }

  /// 13.名称：データ取得(プライマリーキー)
  /// 説明：キー項目を設定したテーブルクラスとTransaction変数(オプション)を指定して１レコードを取得する関数
  /// 引数：各テーブルクラスのインスタンス,{Transaction変数}
  /// 戻り値：Selectしたデータの入ったFuture<T?>
  /// トランザクションメソッドで使用する場合は、Transaction変数を指定すること！
  Future<T?> selectDataByPrimaryKey<T extends TableColumns>(T tc,{Transaction? txn}) async {
    List<Map<String, dynamic>> maps;
    if(txn != null){
      maps = await txn.query(
          tc._getTableName(),
          where: tc._getKeyCondition(),
          whereArgs: tc._getKeyValue());
    }else{
      maps = await _database.query(
          tc._getTableName(),
          where: tc._getKeyCondition(),
          whereArgs: tc._getKeyValue());
    }

    T? rn;
    if (maps.isEmpty) {
      rn = null;
    } else {
      rn = tc._toTable(maps) as T;
    }
    return rn;
  }

  /// 14.名称：全データ取得
  /// 説明：テーブルクラスとTransaction変数(オプション)を指定して一つのテーブルすべてのデータを取得する関数
  /// 引数：各テーブルクラスのインスタンス,{Transaction変数}
  /// 戻り値：Selectしたデータの入ったFuture<List<T>>
  /// トランザクションメソッドで使用する場合は、Transaction変数を指定すること！
  Future<List<T>> selectAllData<T extends TableColumns>(T tc,{Transaction? txn}) async {
    List<Map<String, dynamic>> maps;
    if(txn != null){
      maps = await txn.query(tc._getTableName());
    }else{
      maps = await _database.query(tc._getTableName());
    }
    List<T> rn;
    rn = tc._toTableList(maps).cast<T>();
    return rn;
  }

  /// 15.名称：データ取得(Where句)
  /// 説明：Where句を指定して１つのテーブルからデータを取得する関数
  /// 引数：各テーブルクラスのインスタンス,where句,{Transaction変数,whereArgs}
  /// 戻り値：Selectしたデータの入ったFuture<List<T>>
  /// トランザクションメソッドで使用する場合は、Transaction変数を指定すること！
  Future<List<T>> selectDataWithWhereClause<T extends TableColumns>(
      T tc, String whereClause,
      {Transaction? txn,List? whereArgs}) async {
    List<Map<String, dynamic>> maps;

    if(txn != null){
      if (whereArgs != null) {
        maps = await txn.query(tc._getTableName(),
            where: whereClause, whereArgs: whereArgs);
      } else {
        maps = await txn.query(tc._getTableName(), where: whereClause);
      }
    }else{
      if (whereArgs != null) {
        maps = await _database.query(tc._getTableName(),
            where: whereClause, whereArgs: whereArgs);
      } else {
        maps = await _database.query(tc._getTableName(), where: whereClause);
      }
    }

    List<T> rn;
    rn = tc._toTableList(maps).cast<T>();
    return rn;
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
