/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../cls_conf/unitTestParts.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';


Future<void> main() async{
  await sql_test();
}

Future<void> sql_test() async
{
  TestWidgetsFlutterBinding.ensureInitialized();
  var db = DbManipulationPs();
  var _dbcon;

  group('sql_query',()
  {
    setUpAll(() async {
      PathProviderPlatform.instance = MockPathProviderPlatform();
      _dbcon = await db.openDB();
    });
    setUp(() async {});

    // 各テストの事後処理
    tearDown(() async {});

    // ********************************************************
    // テスト1 :
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブル(c_acct_mst)の任意の列データが取得できること
    // 　　　　　②対象テーブルへのinsertを実行し、insertしたデータを取得することができること
    //         ③1つのtransaction内で複数SQLを実行できること
    // ********************************************************
    test('sql_select', () async {
      print('\n********** テスト実行：select文 **********');
      String sql1 = "select acct_cd,mthr_acct_cd,acct_name from c_acct_mst";
      List<List<dynamic>> results1 = await _dbcon.query(sql1);

      for (final row in results1) {
        var acct_cd = row[0];
        var mthr_acct_cd = row[1];
        var acct_name = row[2];

        print("acct_cd:" + acct_cd + ", mthr_acct_cd:" + mthr_acct_cd +
            ", acct_name:" + acct_name);
      }
      print('********** テスト終了：select文 **********\n\n');
    });

    test('sql_insert', () async {
      print('\n********** テスト実行：insert文 **********');
      String sql2_1 = "insert into c_acct_mst (acct_cd,mthr_acct_cd,acct_name,comp_cd,stre_cd) values (111,111,'test1',111,111)";
      String sql2_2 = "select acct_cd,mthr_acct_cd,acct_name,comp_cd,comp_cd,stre_cd from c_acct_mst where acct_name = 'test1'";
      await _dbcon.query(sql2_1);
      List<List<dynamic>> results2 = await _dbcon.query(sql2_2);

      for (final row in results2) {
        var acct_cd = row[0];
        var mthr_acct_cd = row[1];
        var acct_name = row[2];
        var comp_cd = row[3];
        var stre_cd = row[4];

        print("acct_cd:" + acct_cd + ", mthr_acct_cd:" + mthr_acct_cd +
            ", acct_name:" + acct_name + ", comp_cd:" + comp_cd + ", stre_cd:" +
            stre_cd);
      }
      //後片付け
      String sql2_3 = "delete from c_acct_mst where acct_name = 'test1'";
      await _dbcon.query(sql2_3);

      print('********** テスト終了：insert文 **********\n\n');
    });

    test('sql_transaction', () async {
      print('\n********** テスト実行：transaction **********');
      await _dbcon.transaction((ctx) async {
        //以下にtransactionに入れ込みたいSQL文を記載する
        //queryを実行するときは、上記のtransaction引数に入れたctxを使用する
        String sql3_1 = "insert into c_acct_mst (acct_cd,mthr_acct_cd,acct_name,comp_cd,stre_cd) values (222,222,'test2',222,222)";
        String sql3_2 = "select acct_cd,mthr_acct_cd,acct_name,comp_cd,comp_cd,stre_cd from c_acct_mst where acct_name = 'test2'";
        await ctx.query(sql3_1);

        List<List<dynamic>> results3 = await ctx.query(sql3_2);
        for (final row in results3) {
          var acct_cd = row[0];
          var mthr_acct_cd = row[1];
          var acct_name = row[2];
          var comp_cd = row[3];
          var stre_cd = row[4];

          print("acct_cd:" + acct_cd + ", mthr_acct_cd:" + mthr_acct_cd +
              ", acct_name:" + acct_name + ", comp_cd:" + comp_cd + ", stre_cd:" +
              stre_cd);
        }
        //後片付け
        String sql3_3 = "delete from c_acct_mst where acct_name = 'test2'";
        await ctx.query(sql3_3);
      });

      print('********** テスト終了：transaction **********\n\n');
    });
  });
}