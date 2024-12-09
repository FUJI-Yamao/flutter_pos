/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import '../cls_conf/unitTestParts.dart';
import 'package:flutter_pos/db_library/src/db_manipulation.dart';

/*
本テストでは、以下の66tableを対象にする
data_logs_table_access.dart 実績データログ 日付別 33tables
header_logs_table_access.dart 実績ヘッダログ 日付別 33tables
 */
Future<void> main() async{
  await other_table_test();
}

Future<void> other_table_test() async
{
  TestWidgetsFlutterBinding.ensureInitialized();

  var db = DbManipulation();

  group('other_table',()
  {
    setUpAll(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      await db.openDB();
    });
    setUp(() async{
    });

    // 各テストの事後処理
    tearDown(() async{
    });

    tearDownAll(() async{
      await db.closeDB();
    });

    // ********************************************************
    // テストlog001 : CDataLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log001_CDataLog01_01', () async {
      print('\n********** テスト実行：log001_CDataLog01_01 **********');
      CDataLog01 Testlog001_1 = CDataLog01();
      Testlog001_1.serial_no = 'abc12';
      Testlog001_1.seq_no = 9913;
      Testlog001_1.cnct_seq_no = 9914;
      Testlog001_1.func_cd = 9915;
      Testlog001_1.func_seq_no = 9916;
      Testlog001_1.c_data1 = 'abc17';
      Testlog001_1.c_data2 = 'abc18';
      Testlog001_1.c_data3 = 'abc19';
      Testlog001_1.c_data4 = 'abc20';
      Testlog001_1.c_data5 = 'abc21';
      Testlog001_1.c_data6 = 'abc22';
      Testlog001_1.c_data7 = 'abc23';
      Testlog001_1.c_data8 = 'abc24';
      Testlog001_1.c_data9 = 'abc25';
      Testlog001_1.c_data10 = 'abc26';
      Testlog001_1.n_data1 = 1.227;
      Testlog001_1.n_data2 = 1.228;
      Testlog001_1.n_data3 = 1.229;
      Testlog001_1.n_data4 = 1.230;
      Testlog001_1.n_data5 = 1.231;
      Testlog001_1.n_data6 = 1.232;
      Testlog001_1.n_data7 = 1.233;
      Testlog001_1.n_data8 = 1.234;
      Testlog001_1.n_data9 = 1.235;
      Testlog001_1.n_data10 = 1.236;
      Testlog001_1.n_data11 = 1.237;
      Testlog001_1.n_data12 = 1.238;
      Testlog001_1.n_data13 = 1.239;
      Testlog001_1.n_data14 = 1.240;
      Testlog001_1.n_data15 = 1.241;
      Testlog001_1.n_data16 = 1.242;
      Testlog001_1.n_data17 = 1.243;
      Testlog001_1.n_data18 = 1.244;
      Testlog001_1.n_data19 = 1.245;
      Testlog001_1.n_data20 = 1.246;
      Testlog001_1.n_data21 = 1.247;
      Testlog001_1.n_data22 = 1.248;
      Testlog001_1.n_data23 = 1.249;
      Testlog001_1.n_data24 = 1.250;
      Testlog001_1.n_data25 = 1.251;
      Testlog001_1.n_data26 = 1.252;
      Testlog001_1.n_data27 = 1.253;
      Testlog001_1.n_data28 = 1.254;
      Testlog001_1.n_data29 = 1.255;
      Testlog001_1.n_data30 = 1.256;
      Testlog001_1.d_data1 = 'abc57';
      Testlog001_1.d_data2 = 'abc58';
      Testlog001_1.d_data3 = 'abc59';
      Testlog001_1.d_data4 = 'abc60';
      Testlog001_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog01> Testlog001_AllRtn = await db.selectAllData(Testlog001_1);
      int count = Testlog001_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog001_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog01 Testlog001_2 = CDataLog01();
      //Keyの値を設定する
      Testlog001_2.serial_no = 'abc12';
      Testlog001_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog01? Testlog001_Rtn = await db.selectDataByPrimaryKey(Testlog001_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog001_Rtn == null) {
        print('\n********** 異常発生：log001_CDataLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog001_Rtn?.serial_no,'abc12');
        expect(Testlog001_Rtn?.seq_no,9913);
        expect(Testlog001_Rtn?.cnct_seq_no,9914);
        expect(Testlog001_Rtn?.func_cd,9915);
        expect(Testlog001_Rtn?.func_seq_no,9916);
        expect(Testlog001_Rtn?.c_data1,'abc17');
        expect(Testlog001_Rtn?.c_data2,'abc18');
        expect(Testlog001_Rtn?.c_data3,'abc19');
        expect(Testlog001_Rtn?.c_data4,'abc20');
        expect(Testlog001_Rtn?.c_data5,'abc21');
        expect(Testlog001_Rtn?.c_data6,'abc22');
        expect(Testlog001_Rtn?.c_data7,'abc23');
        expect(Testlog001_Rtn?.c_data8,'abc24');
        expect(Testlog001_Rtn?.c_data9,'abc25');
        expect(Testlog001_Rtn?.c_data10,'abc26');
        expect(Testlog001_Rtn?.n_data1,1.227);
        expect(Testlog001_Rtn?.n_data2,1.228);
        expect(Testlog001_Rtn?.n_data3,1.229);
        expect(Testlog001_Rtn?.n_data4,1.230);
        expect(Testlog001_Rtn?.n_data5,1.231);
        expect(Testlog001_Rtn?.n_data6,1.232);
        expect(Testlog001_Rtn?.n_data7,1.233);
        expect(Testlog001_Rtn?.n_data8,1.234);
        expect(Testlog001_Rtn?.n_data9,1.235);
        expect(Testlog001_Rtn?.n_data10,1.236);
        expect(Testlog001_Rtn?.n_data11,1.237);
        expect(Testlog001_Rtn?.n_data12,1.238);
        expect(Testlog001_Rtn?.n_data13,1.239);
        expect(Testlog001_Rtn?.n_data14,1.240);
        expect(Testlog001_Rtn?.n_data15,1.241);
        expect(Testlog001_Rtn?.n_data16,1.242);
        expect(Testlog001_Rtn?.n_data17,1.243);
        expect(Testlog001_Rtn?.n_data18,1.244);
        expect(Testlog001_Rtn?.n_data19,1.245);
        expect(Testlog001_Rtn?.n_data20,1.246);
        expect(Testlog001_Rtn?.n_data21,1.247);
        expect(Testlog001_Rtn?.n_data22,1.248);
        expect(Testlog001_Rtn?.n_data23,1.249);
        expect(Testlog001_Rtn?.n_data24,1.250);
        expect(Testlog001_Rtn?.n_data25,1.251);
        expect(Testlog001_Rtn?.n_data26,1.252);
        expect(Testlog001_Rtn?.n_data27,1.253);
        expect(Testlog001_Rtn?.n_data28,1.254);
        expect(Testlog001_Rtn?.n_data29,1.255);
        expect(Testlog001_Rtn?.n_data30,1.256);
        expect(Testlog001_Rtn?.d_data1,'abc57');
        expect(Testlog001_Rtn?.d_data2,'abc58');
        expect(Testlog001_Rtn?.d_data3,'abc59');
        expect(Testlog001_Rtn?.d_data4,'abc60');
        expect(Testlog001_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog01> Testlog001_AllRtn2 = await db.selectAllData(Testlog001_1);
      int count2 = Testlog001_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog001_1);
      print('********** テスト終了：log001_CDataLog01_01 **********\n\n');
    });

    // ********************************************************
    // テストlog002 : CDataLog02
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log002_CDataLog02_01', () async {
      print('\n********** テスト実行：log002_CDataLog02_01 **********');
      CDataLog02 Testlog002_1 = CDataLog02();
      Testlog002_1.serial_no = 'abc12';
      Testlog002_1.seq_no = 9913;
      Testlog002_1.cnct_seq_no = 9914;
      Testlog002_1.func_cd = 9915;
      Testlog002_1.func_seq_no = 9916;
      Testlog002_1.c_data1 = 'abc17';
      Testlog002_1.c_data2 = 'abc18';
      Testlog002_1.c_data3 = 'abc19';
      Testlog002_1.c_data4 = 'abc20';
      Testlog002_1.c_data5 = 'abc21';
      Testlog002_1.c_data6 = 'abc22';
      Testlog002_1.c_data7 = 'abc23';
      Testlog002_1.c_data8 = 'abc24';
      Testlog002_1.c_data9 = 'abc25';
      Testlog002_1.c_data10 = 'abc26';
      Testlog002_1.n_data1 = 1.227;
      Testlog002_1.n_data2 = 1.228;
      Testlog002_1.n_data3 = 1.229;
      Testlog002_1.n_data4 = 1.230;
      Testlog002_1.n_data5 = 1.231;
      Testlog002_1.n_data6 = 1.232;
      Testlog002_1.n_data7 = 1.233;
      Testlog002_1.n_data8 = 1.234;
      Testlog002_1.n_data9 = 1.235;
      Testlog002_1.n_data10 = 1.236;
      Testlog002_1.n_data11 = 1.237;
      Testlog002_1.n_data12 = 1.238;
      Testlog002_1.n_data13 = 1.239;
      Testlog002_1.n_data14 = 1.240;
      Testlog002_1.n_data15 = 1.241;
      Testlog002_1.n_data16 = 1.242;
      Testlog002_1.n_data17 = 1.243;
      Testlog002_1.n_data18 = 1.244;
      Testlog002_1.n_data19 = 1.245;
      Testlog002_1.n_data20 = 1.246;
      Testlog002_1.n_data21 = 1.247;
      Testlog002_1.n_data22 = 1.248;
      Testlog002_1.n_data23 = 1.249;
      Testlog002_1.n_data24 = 1.250;
      Testlog002_1.n_data25 = 1.251;
      Testlog002_1.n_data26 = 1.252;
      Testlog002_1.n_data27 = 1.253;
      Testlog002_1.n_data28 = 1.254;
      Testlog002_1.n_data29 = 1.255;
      Testlog002_1.n_data30 = 1.256;
      Testlog002_1.d_data1 = 'abc57';
      Testlog002_1.d_data2 = 'abc58';
      Testlog002_1.d_data3 = 'abc59';
      Testlog002_1.d_data4 = 'abc60';
      Testlog002_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog02> Testlog002_AllRtn = await db.selectAllData(Testlog002_1);
      int count = Testlog002_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog002_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog02 Testlog002_2 = CDataLog02();
      //Keyの値を設定する
      Testlog002_2.serial_no = 'abc12';
      Testlog002_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog02? Testlog002_Rtn = await db.selectDataByPrimaryKey(Testlog002_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog002_Rtn == null) {
        print('\n********** 異常発生：log002_CDataLog02_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog002_Rtn?.serial_no,'abc12');
        expect(Testlog002_Rtn?.seq_no,9913);
        expect(Testlog002_Rtn?.cnct_seq_no,9914);
        expect(Testlog002_Rtn?.func_cd,9915);
        expect(Testlog002_Rtn?.func_seq_no,9916);
        expect(Testlog002_Rtn?.c_data1,'abc17');
        expect(Testlog002_Rtn?.c_data2,'abc18');
        expect(Testlog002_Rtn?.c_data3,'abc19');
        expect(Testlog002_Rtn?.c_data4,'abc20');
        expect(Testlog002_Rtn?.c_data5,'abc21');
        expect(Testlog002_Rtn?.c_data6,'abc22');
        expect(Testlog002_Rtn?.c_data7,'abc23');
        expect(Testlog002_Rtn?.c_data8,'abc24');
        expect(Testlog002_Rtn?.c_data9,'abc25');
        expect(Testlog002_Rtn?.c_data10,'abc26');
        expect(Testlog002_Rtn?.n_data1,1.227);
        expect(Testlog002_Rtn?.n_data2,1.228);
        expect(Testlog002_Rtn?.n_data3,1.229);
        expect(Testlog002_Rtn?.n_data4,1.230);
        expect(Testlog002_Rtn?.n_data5,1.231);
        expect(Testlog002_Rtn?.n_data6,1.232);
        expect(Testlog002_Rtn?.n_data7,1.233);
        expect(Testlog002_Rtn?.n_data8,1.234);
        expect(Testlog002_Rtn?.n_data9,1.235);
        expect(Testlog002_Rtn?.n_data10,1.236);
        expect(Testlog002_Rtn?.n_data11,1.237);
        expect(Testlog002_Rtn?.n_data12,1.238);
        expect(Testlog002_Rtn?.n_data13,1.239);
        expect(Testlog002_Rtn?.n_data14,1.240);
        expect(Testlog002_Rtn?.n_data15,1.241);
        expect(Testlog002_Rtn?.n_data16,1.242);
        expect(Testlog002_Rtn?.n_data17,1.243);
        expect(Testlog002_Rtn?.n_data18,1.244);
        expect(Testlog002_Rtn?.n_data19,1.245);
        expect(Testlog002_Rtn?.n_data20,1.246);
        expect(Testlog002_Rtn?.n_data21,1.247);
        expect(Testlog002_Rtn?.n_data22,1.248);
        expect(Testlog002_Rtn?.n_data23,1.249);
        expect(Testlog002_Rtn?.n_data24,1.250);
        expect(Testlog002_Rtn?.n_data25,1.251);
        expect(Testlog002_Rtn?.n_data26,1.252);
        expect(Testlog002_Rtn?.n_data27,1.253);
        expect(Testlog002_Rtn?.n_data28,1.254);
        expect(Testlog002_Rtn?.n_data29,1.255);
        expect(Testlog002_Rtn?.n_data30,1.256);
        expect(Testlog002_Rtn?.d_data1,'abc57');
        expect(Testlog002_Rtn?.d_data2,'abc58');
        expect(Testlog002_Rtn?.d_data3,'abc59');
        expect(Testlog002_Rtn?.d_data4,'abc60');
        expect(Testlog002_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog02> Testlog002_AllRtn2 = await db.selectAllData(Testlog002_1);
      int count2 = Testlog002_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog002_1);
      print('********** テスト終了：log002_CDataLog02_01 **********\n\n');
    });

    // ********************************************************
    // テストlog003 : CDataLog03
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log003_CDataLog03_01', () async {
      print('\n********** テスト実行：log003_CDataLog03_01 **********');
      CDataLog03 Testlog003_1 = CDataLog03();
      Testlog003_1.serial_no = 'abc12';
      Testlog003_1.seq_no = 9913;
      Testlog003_1.cnct_seq_no = 9914;
      Testlog003_1.func_cd = 9915;
      Testlog003_1.func_seq_no = 9916;
      Testlog003_1.c_data1 = 'abc17';
      Testlog003_1.c_data2 = 'abc18';
      Testlog003_1.c_data3 = 'abc19';
      Testlog003_1.c_data4 = 'abc20';
      Testlog003_1.c_data5 = 'abc21';
      Testlog003_1.c_data6 = 'abc22';
      Testlog003_1.c_data7 = 'abc23';
      Testlog003_1.c_data8 = 'abc24';
      Testlog003_1.c_data9 = 'abc25';
      Testlog003_1.c_data10 = 'abc26';
      Testlog003_1.n_data1 = 1.227;
      Testlog003_1.n_data2 = 1.228;
      Testlog003_1.n_data3 = 1.229;
      Testlog003_1.n_data4 = 1.230;
      Testlog003_1.n_data5 = 1.231;
      Testlog003_1.n_data6 = 1.232;
      Testlog003_1.n_data7 = 1.233;
      Testlog003_1.n_data8 = 1.234;
      Testlog003_1.n_data9 = 1.235;
      Testlog003_1.n_data10 = 1.236;
      Testlog003_1.n_data11 = 1.237;
      Testlog003_1.n_data12 = 1.238;
      Testlog003_1.n_data13 = 1.239;
      Testlog003_1.n_data14 = 1.240;
      Testlog003_1.n_data15 = 1.241;
      Testlog003_1.n_data16 = 1.242;
      Testlog003_1.n_data17 = 1.243;
      Testlog003_1.n_data18 = 1.244;
      Testlog003_1.n_data19 = 1.245;
      Testlog003_1.n_data20 = 1.246;
      Testlog003_1.n_data21 = 1.247;
      Testlog003_1.n_data22 = 1.248;
      Testlog003_1.n_data23 = 1.249;
      Testlog003_1.n_data24 = 1.250;
      Testlog003_1.n_data25 = 1.251;
      Testlog003_1.n_data26 = 1.252;
      Testlog003_1.n_data27 = 1.253;
      Testlog003_1.n_data28 = 1.254;
      Testlog003_1.n_data29 = 1.255;
      Testlog003_1.n_data30 = 1.256;
      Testlog003_1.d_data1 = 'abc57';
      Testlog003_1.d_data2 = 'abc58';
      Testlog003_1.d_data3 = 'abc59';
      Testlog003_1.d_data4 = 'abc60';
      Testlog003_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog03> Testlog003_AllRtn = await db.selectAllData(Testlog003_1);
      int count = Testlog003_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog003_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog03 Testlog003_2 = CDataLog03();
      //Keyの値を設定する
      Testlog003_2.serial_no = 'abc12';
      Testlog003_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog03? Testlog003_Rtn = await db.selectDataByPrimaryKey(Testlog003_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog003_Rtn == null) {
        print('\n********** 異常発生：log003_CDataLog03_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog003_Rtn?.serial_no,'abc12');
        expect(Testlog003_Rtn?.seq_no,9913);
        expect(Testlog003_Rtn?.cnct_seq_no,9914);
        expect(Testlog003_Rtn?.func_cd,9915);
        expect(Testlog003_Rtn?.func_seq_no,9916);
        expect(Testlog003_Rtn?.c_data1,'abc17');
        expect(Testlog003_Rtn?.c_data2,'abc18');
        expect(Testlog003_Rtn?.c_data3,'abc19');
        expect(Testlog003_Rtn?.c_data4,'abc20');
        expect(Testlog003_Rtn?.c_data5,'abc21');
        expect(Testlog003_Rtn?.c_data6,'abc22');
        expect(Testlog003_Rtn?.c_data7,'abc23');
        expect(Testlog003_Rtn?.c_data8,'abc24');
        expect(Testlog003_Rtn?.c_data9,'abc25');
        expect(Testlog003_Rtn?.c_data10,'abc26');
        expect(Testlog003_Rtn?.n_data1,1.227);
        expect(Testlog003_Rtn?.n_data2,1.228);
        expect(Testlog003_Rtn?.n_data3,1.229);
        expect(Testlog003_Rtn?.n_data4,1.230);
        expect(Testlog003_Rtn?.n_data5,1.231);
        expect(Testlog003_Rtn?.n_data6,1.232);
        expect(Testlog003_Rtn?.n_data7,1.233);
        expect(Testlog003_Rtn?.n_data8,1.234);
        expect(Testlog003_Rtn?.n_data9,1.235);
        expect(Testlog003_Rtn?.n_data10,1.236);
        expect(Testlog003_Rtn?.n_data11,1.237);
        expect(Testlog003_Rtn?.n_data12,1.238);
        expect(Testlog003_Rtn?.n_data13,1.239);
        expect(Testlog003_Rtn?.n_data14,1.240);
        expect(Testlog003_Rtn?.n_data15,1.241);
        expect(Testlog003_Rtn?.n_data16,1.242);
        expect(Testlog003_Rtn?.n_data17,1.243);
        expect(Testlog003_Rtn?.n_data18,1.244);
        expect(Testlog003_Rtn?.n_data19,1.245);
        expect(Testlog003_Rtn?.n_data20,1.246);
        expect(Testlog003_Rtn?.n_data21,1.247);
        expect(Testlog003_Rtn?.n_data22,1.248);
        expect(Testlog003_Rtn?.n_data23,1.249);
        expect(Testlog003_Rtn?.n_data24,1.250);
        expect(Testlog003_Rtn?.n_data25,1.251);
        expect(Testlog003_Rtn?.n_data26,1.252);
        expect(Testlog003_Rtn?.n_data27,1.253);
        expect(Testlog003_Rtn?.n_data28,1.254);
        expect(Testlog003_Rtn?.n_data29,1.255);
        expect(Testlog003_Rtn?.n_data30,1.256);
        expect(Testlog003_Rtn?.d_data1,'abc57');
        expect(Testlog003_Rtn?.d_data2,'abc58');
        expect(Testlog003_Rtn?.d_data3,'abc59');
        expect(Testlog003_Rtn?.d_data4,'abc60');
        expect(Testlog003_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog03> Testlog003_AllRtn2 = await db.selectAllData(Testlog003_1);
      int count2 = Testlog003_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog003_1);
      print('********** テスト終了：log003_CDataLog03_01 **********\n\n');
    });

    // ********************************************************
    // テストlog004 : CDataLog04
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log004_CDataLog04_01', () async {
      print('\n********** テスト実行：log004_CDataLog04_01 **********');
      CDataLog04 Testlog004_1 = CDataLog04();
      Testlog004_1.serial_no = 'abc12';
      Testlog004_1.seq_no = 9913;
      Testlog004_1.cnct_seq_no = 9914;
      Testlog004_1.func_cd = 9915;
      Testlog004_1.func_seq_no = 9916;
      Testlog004_1.c_data1 = 'abc17';
      Testlog004_1.c_data2 = 'abc18';
      Testlog004_1.c_data3 = 'abc19';
      Testlog004_1.c_data4 = 'abc20';
      Testlog004_1.c_data5 = 'abc21';
      Testlog004_1.c_data6 = 'abc22';
      Testlog004_1.c_data7 = 'abc23';
      Testlog004_1.c_data8 = 'abc24';
      Testlog004_1.c_data9 = 'abc25';
      Testlog004_1.c_data10 = 'abc26';
      Testlog004_1.n_data1 = 1.227;
      Testlog004_1.n_data2 = 1.228;
      Testlog004_1.n_data3 = 1.229;
      Testlog004_1.n_data4 = 1.230;
      Testlog004_1.n_data5 = 1.231;
      Testlog004_1.n_data6 = 1.232;
      Testlog004_1.n_data7 = 1.233;
      Testlog004_1.n_data8 = 1.234;
      Testlog004_1.n_data9 = 1.235;
      Testlog004_1.n_data10 = 1.236;
      Testlog004_1.n_data11 = 1.237;
      Testlog004_1.n_data12 = 1.238;
      Testlog004_1.n_data13 = 1.239;
      Testlog004_1.n_data14 = 1.240;
      Testlog004_1.n_data15 = 1.241;
      Testlog004_1.n_data16 = 1.242;
      Testlog004_1.n_data17 = 1.243;
      Testlog004_1.n_data18 = 1.244;
      Testlog004_1.n_data19 = 1.245;
      Testlog004_1.n_data20 = 1.246;
      Testlog004_1.n_data21 = 1.247;
      Testlog004_1.n_data22 = 1.248;
      Testlog004_1.n_data23 = 1.249;
      Testlog004_1.n_data24 = 1.250;
      Testlog004_1.n_data25 = 1.251;
      Testlog004_1.n_data26 = 1.252;
      Testlog004_1.n_data27 = 1.253;
      Testlog004_1.n_data28 = 1.254;
      Testlog004_1.n_data29 = 1.255;
      Testlog004_1.n_data30 = 1.256;
      Testlog004_1.d_data1 = 'abc57';
      Testlog004_1.d_data2 = 'abc58';
      Testlog004_1.d_data3 = 'abc59';
      Testlog004_1.d_data4 = 'abc60';
      Testlog004_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog04> Testlog004_AllRtn = await db.selectAllData(Testlog004_1);
      int count = Testlog004_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog004_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog04 Testlog004_2 = CDataLog04();
      //Keyの値を設定する
      Testlog004_2.serial_no = 'abc12';
      Testlog004_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog04? Testlog004_Rtn = await db.selectDataByPrimaryKey(Testlog004_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog004_Rtn == null) {
        print('\n********** 異常発生：log004_CDataLog04_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog004_Rtn?.serial_no,'abc12');
        expect(Testlog004_Rtn?.seq_no,9913);
        expect(Testlog004_Rtn?.cnct_seq_no,9914);
        expect(Testlog004_Rtn?.func_cd,9915);
        expect(Testlog004_Rtn?.func_seq_no,9916);
        expect(Testlog004_Rtn?.c_data1,'abc17');
        expect(Testlog004_Rtn?.c_data2,'abc18');
        expect(Testlog004_Rtn?.c_data3,'abc19');
        expect(Testlog004_Rtn?.c_data4,'abc20');
        expect(Testlog004_Rtn?.c_data5,'abc21');
        expect(Testlog004_Rtn?.c_data6,'abc22');
        expect(Testlog004_Rtn?.c_data7,'abc23');
        expect(Testlog004_Rtn?.c_data8,'abc24');
        expect(Testlog004_Rtn?.c_data9,'abc25');
        expect(Testlog004_Rtn?.c_data10,'abc26');
        expect(Testlog004_Rtn?.n_data1,1.227);
        expect(Testlog004_Rtn?.n_data2,1.228);
        expect(Testlog004_Rtn?.n_data3,1.229);
        expect(Testlog004_Rtn?.n_data4,1.230);
        expect(Testlog004_Rtn?.n_data5,1.231);
        expect(Testlog004_Rtn?.n_data6,1.232);
        expect(Testlog004_Rtn?.n_data7,1.233);
        expect(Testlog004_Rtn?.n_data8,1.234);
        expect(Testlog004_Rtn?.n_data9,1.235);
        expect(Testlog004_Rtn?.n_data10,1.236);
        expect(Testlog004_Rtn?.n_data11,1.237);
        expect(Testlog004_Rtn?.n_data12,1.238);
        expect(Testlog004_Rtn?.n_data13,1.239);
        expect(Testlog004_Rtn?.n_data14,1.240);
        expect(Testlog004_Rtn?.n_data15,1.241);
        expect(Testlog004_Rtn?.n_data16,1.242);
        expect(Testlog004_Rtn?.n_data17,1.243);
        expect(Testlog004_Rtn?.n_data18,1.244);
        expect(Testlog004_Rtn?.n_data19,1.245);
        expect(Testlog004_Rtn?.n_data20,1.246);
        expect(Testlog004_Rtn?.n_data21,1.247);
        expect(Testlog004_Rtn?.n_data22,1.248);
        expect(Testlog004_Rtn?.n_data23,1.249);
        expect(Testlog004_Rtn?.n_data24,1.250);
        expect(Testlog004_Rtn?.n_data25,1.251);
        expect(Testlog004_Rtn?.n_data26,1.252);
        expect(Testlog004_Rtn?.n_data27,1.253);
        expect(Testlog004_Rtn?.n_data28,1.254);
        expect(Testlog004_Rtn?.n_data29,1.255);
        expect(Testlog004_Rtn?.n_data30,1.256);
        expect(Testlog004_Rtn?.d_data1,'abc57');
        expect(Testlog004_Rtn?.d_data2,'abc58');
        expect(Testlog004_Rtn?.d_data3,'abc59');
        expect(Testlog004_Rtn?.d_data4,'abc60');
        expect(Testlog004_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog04> Testlog004_AllRtn2 = await db.selectAllData(Testlog004_1);
      int count2 = Testlog004_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog004_1);
      print('********** テスト終了：log004_CDataLog04_01 **********\n\n');
    });

    // ********************************************************
    // テストlog005 : CDataLog05
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log005_CDataLog05_01', () async {
      print('\n********** テスト実行：log005_CDataLog05_01 **********');
      CDataLog05 Testlog005_1 = CDataLog05();
      Testlog005_1.serial_no = 'abc12';
      Testlog005_1.seq_no = 9913;
      Testlog005_1.cnct_seq_no = 9914;
      Testlog005_1.func_cd = 9915;
      Testlog005_1.func_seq_no = 9916;
      Testlog005_1.c_data1 = 'abc17';
      Testlog005_1.c_data2 = 'abc18';
      Testlog005_1.c_data3 = 'abc19';
      Testlog005_1.c_data4 = 'abc20';
      Testlog005_1.c_data5 = 'abc21';
      Testlog005_1.c_data6 = 'abc22';
      Testlog005_1.c_data7 = 'abc23';
      Testlog005_1.c_data8 = 'abc24';
      Testlog005_1.c_data9 = 'abc25';
      Testlog005_1.c_data10 = 'abc26';
      Testlog005_1.n_data1 = 1.227;
      Testlog005_1.n_data2 = 1.228;
      Testlog005_1.n_data3 = 1.229;
      Testlog005_1.n_data4 = 1.230;
      Testlog005_1.n_data5 = 1.231;
      Testlog005_1.n_data6 = 1.232;
      Testlog005_1.n_data7 = 1.233;
      Testlog005_1.n_data8 = 1.234;
      Testlog005_1.n_data9 = 1.235;
      Testlog005_1.n_data10 = 1.236;
      Testlog005_1.n_data11 = 1.237;
      Testlog005_1.n_data12 = 1.238;
      Testlog005_1.n_data13 = 1.239;
      Testlog005_1.n_data14 = 1.240;
      Testlog005_1.n_data15 = 1.241;
      Testlog005_1.n_data16 = 1.242;
      Testlog005_1.n_data17 = 1.243;
      Testlog005_1.n_data18 = 1.244;
      Testlog005_1.n_data19 = 1.245;
      Testlog005_1.n_data20 = 1.246;
      Testlog005_1.n_data21 = 1.247;
      Testlog005_1.n_data22 = 1.248;
      Testlog005_1.n_data23 = 1.249;
      Testlog005_1.n_data24 = 1.250;
      Testlog005_1.n_data25 = 1.251;
      Testlog005_1.n_data26 = 1.252;
      Testlog005_1.n_data27 = 1.253;
      Testlog005_1.n_data28 = 1.254;
      Testlog005_1.n_data29 = 1.255;
      Testlog005_1.n_data30 = 1.256;
      Testlog005_1.d_data1 = 'abc57';
      Testlog005_1.d_data2 = 'abc58';
      Testlog005_1.d_data3 = 'abc59';
      Testlog005_1.d_data4 = 'abc60';
      Testlog005_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog05> Testlog005_AllRtn = await db.selectAllData(Testlog005_1);
      int count = Testlog005_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog005_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog05 Testlog005_2 = CDataLog05();
      //Keyの値を設定する
      Testlog005_2.serial_no = 'abc12';
      Testlog005_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog05? Testlog005_Rtn = await db.selectDataByPrimaryKey(Testlog005_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog005_Rtn == null) {
        print('\n********** 異常発生：log005_CDataLog05_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog005_Rtn?.serial_no,'abc12');
        expect(Testlog005_Rtn?.seq_no,9913);
        expect(Testlog005_Rtn?.cnct_seq_no,9914);
        expect(Testlog005_Rtn?.func_cd,9915);
        expect(Testlog005_Rtn?.func_seq_no,9916);
        expect(Testlog005_Rtn?.c_data1,'abc17');
        expect(Testlog005_Rtn?.c_data2,'abc18');
        expect(Testlog005_Rtn?.c_data3,'abc19');
        expect(Testlog005_Rtn?.c_data4,'abc20');
        expect(Testlog005_Rtn?.c_data5,'abc21');
        expect(Testlog005_Rtn?.c_data6,'abc22');
        expect(Testlog005_Rtn?.c_data7,'abc23');
        expect(Testlog005_Rtn?.c_data8,'abc24');
        expect(Testlog005_Rtn?.c_data9,'abc25');
        expect(Testlog005_Rtn?.c_data10,'abc26');
        expect(Testlog005_Rtn?.n_data1,1.227);
        expect(Testlog005_Rtn?.n_data2,1.228);
        expect(Testlog005_Rtn?.n_data3,1.229);
        expect(Testlog005_Rtn?.n_data4,1.230);
        expect(Testlog005_Rtn?.n_data5,1.231);
        expect(Testlog005_Rtn?.n_data6,1.232);
        expect(Testlog005_Rtn?.n_data7,1.233);
        expect(Testlog005_Rtn?.n_data8,1.234);
        expect(Testlog005_Rtn?.n_data9,1.235);
        expect(Testlog005_Rtn?.n_data10,1.236);
        expect(Testlog005_Rtn?.n_data11,1.237);
        expect(Testlog005_Rtn?.n_data12,1.238);
        expect(Testlog005_Rtn?.n_data13,1.239);
        expect(Testlog005_Rtn?.n_data14,1.240);
        expect(Testlog005_Rtn?.n_data15,1.241);
        expect(Testlog005_Rtn?.n_data16,1.242);
        expect(Testlog005_Rtn?.n_data17,1.243);
        expect(Testlog005_Rtn?.n_data18,1.244);
        expect(Testlog005_Rtn?.n_data19,1.245);
        expect(Testlog005_Rtn?.n_data20,1.246);
        expect(Testlog005_Rtn?.n_data21,1.247);
        expect(Testlog005_Rtn?.n_data22,1.248);
        expect(Testlog005_Rtn?.n_data23,1.249);
        expect(Testlog005_Rtn?.n_data24,1.250);
        expect(Testlog005_Rtn?.n_data25,1.251);
        expect(Testlog005_Rtn?.n_data26,1.252);
        expect(Testlog005_Rtn?.n_data27,1.253);
        expect(Testlog005_Rtn?.n_data28,1.254);
        expect(Testlog005_Rtn?.n_data29,1.255);
        expect(Testlog005_Rtn?.n_data30,1.256);
        expect(Testlog005_Rtn?.d_data1,'abc57');
        expect(Testlog005_Rtn?.d_data2,'abc58');
        expect(Testlog005_Rtn?.d_data3,'abc59');
        expect(Testlog005_Rtn?.d_data4,'abc60');
        expect(Testlog005_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog05> Testlog005_AllRtn2 = await db.selectAllData(Testlog005_1);
      int count2 = Testlog005_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog005_1);
      print('********** テスト終了：log005_CDataLog05_01 **********\n\n');
    });

    // ********************************************************
    // テストlog006 : CDataLog06
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log006_CDataLog06_01', () async {
      print('\n********** テスト実行：log006_CDataLog06_01 **********');
      CDataLog06 Testlog006_1 = CDataLog06();
      Testlog006_1.serial_no = 'abc12';
      Testlog006_1.seq_no = 9913;
      Testlog006_1.cnct_seq_no = 9914;
      Testlog006_1.func_cd = 9915;
      Testlog006_1.func_seq_no = 9916;
      Testlog006_1.c_data1 = 'abc17';
      Testlog006_1.c_data2 = 'abc18';
      Testlog006_1.c_data3 = 'abc19';
      Testlog006_1.c_data4 = 'abc20';
      Testlog006_1.c_data5 = 'abc21';
      Testlog006_1.c_data6 = 'abc22';
      Testlog006_1.c_data7 = 'abc23';
      Testlog006_1.c_data8 = 'abc24';
      Testlog006_1.c_data9 = 'abc25';
      Testlog006_1.c_data10 = 'abc26';
      Testlog006_1.n_data1 = 1.227;
      Testlog006_1.n_data2 = 1.228;
      Testlog006_1.n_data3 = 1.229;
      Testlog006_1.n_data4 = 1.230;
      Testlog006_1.n_data5 = 1.231;
      Testlog006_1.n_data6 = 1.232;
      Testlog006_1.n_data7 = 1.233;
      Testlog006_1.n_data8 = 1.234;
      Testlog006_1.n_data9 = 1.235;
      Testlog006_1.n_data10 = 1.236;
      Testlog006_1.n_data11 = 1.237;
      Testlog006_1.n_data12 = 1.238;
      Testlog006_1.n_data13 = 1.239;
      Testlog006_1.n_data14 = 1.240;
      Testlog006_1.n_data15 = 1.241;
      Testlog006_1.n_data16 = 1.242;
      Testlog006_1.n_data17 = 1.243;
      Testlog006_1.n_data18 = 1.244;
      Testlog006_1.n_data19 = 1.245;
      Testlog006_1.n_data20 = 1.246;
      Testlog006_1.n_data21 = 1.247;
      Testlog006_1.n_data22 = 1.248;
      Testlog006_1.n_data23 = 1.249;
      Testlog006_1.n_data24 = 1.250;
      Testlog006_1.n_data25 = 1.251;
      Testlog006_1.n_data26 = 1.252;
      Testlog006_1.n_data27 = 1.253;
      Testlog006_1.n_data28 = 1.254;
      Testlog006_1.n_data29 = 1.255;
      Testlog006_1.n_data30 = 1.256;
      Testlog006_1.d_data1 = 'abc57';
      Testlog006_1.d_data2 = 'abc58';
      Testlog006_1.d_data3 = 'abc59';
      Testlog006_1.d_data4 = 'abc60';
      Testlog006_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog06> Testlog006_AllRtn = await db.selectAllData(Testlog006_1);
      int count = Testlog006_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog006_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog06 Testlog006_2 = CDataLog06();
      //Keyの値を設定する
      Testlog006_2.serial_no = 'abc12';
      Testlog006_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog06? Testlog006_Rtn = await db.selectDataByPrimaryKey(Testlog006_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog006_Rtn == null) {
        print('\n********** 異常発生：log006_CDataLog06_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog006_Rtn?.serial_no,'abc12');
        expect(Testlog006_Rtn?.seq_no,9913);
        expect(Testlog006_Rtn?.cnct_seq_no,9914);
        expect(Testlog006_Rtn?.func_cd,9915);
        expect(Testlog006_Rtn?.func_seq_no,9916);
        expect(Testlog006_Rtn?.c_data1,'abc17');
        expect(Testlog006_Rtn?.c_data2,'abc18');
        expect(Testlog006_Rtn?.c_data3,'abc19');
        expect(Testlog006_Rtn?.c_data4,'abc20');
        expect(Testlog006_Rtn?.c_data5,'abc21');
        expect(Testlog006_Rtn?.c_data6,'abc22');
        expect(Testlog006_Rtn?.c_data7,'abc23');
        expect(Testlog006_Rtn?.c_data8,'abc24');
        expect(Testlog006_Rtn?.c_data9,'abc25');
        expect(Testlog006_Rtn?.c_data10,'abc26');
        expect(Testlog006_Rtn?.n_data1,1.227);
        expect(Testlog006_Rtn?.n_data2,1.228);
        expect(Testlog006_Rtn?.n_data3,1.229);
        expect(Testlog006_Rtn?.n_data4,1.230);
        expect(Testlog006_Rtn?.n_data5,1.231);
        expect(Testlog006_Rtn?.n_data6,1.232);
        expect(Testlog006_Rtn?.n_data7,1.233);
        expect(Testlog006_Rtn?.n_data8,1.234);
        expect(Testlog006_Rtn?.n_data9,1.235);
        expect(Testlog006_Rtn?.n_data10,1.236);
        expect(Testlog006_Rtn?.n_data11,1.237);
        expect(Testlog006_Rtn?.n_data12,1.238);
        expect(Testlog006_Rtn?.n_data13,1.239);
        expect(Testlog006_Rtn?.n_data14,1.240);
        expect(Testlog006_Rtn?.n_data15,1.241);
        expect(Testlog006_Rtn?.n_data16,1.242);
        expect(Testlog006_Rtn?.n_data17,1.243);
        expect(Testlog006_Rtn?.n_data18,1.244);
        expect(Testlog006_Rtn?.n_data19,1.245);
        expect(Testlog006_Rtn?.n_data20,1.246);
        expect(Testlog006_Rtn?.n_data21,1.247);
        expect(Testlog006_Rtn?.n_data22,1.248);
        expect(Testlog006_Rtn?.n_data23,1.249);
        expect(Testlog006_Rtn?.n_data24,1.250);
        expect(Testlog006_Rtn?.n_data25,1.251);
        expect(Testlog006_Rtn?.n_data26,1.252);
        expect(Testlog006_Rtn?.n_data27,1.253);
        expect(Testlog006_Rtn?.n_data28,1.254);
        expect(Testlog006_Rtn?.n_data29,1.255);
        expect(Testlog006_Rtn?.n_data30,1.256);
        expect(Testlog006_Rtn?.d_data1,'abc57');
        expect(Testlog006_Rtn?.d_data2,'abc58');
        expect(Testlog006_Rtn?.d_data3,'abc59');
        expect(Testlog006_Rtn?.d_data4,'abc60');
        expect(Testlog006_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog06> Testlog006_AllRtn2 = await db.selectAllData(Testlog006_1);
      int count2 = Testlog006_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog006_1);
      print('********** テスト終了：log006_CDataLog06_01 **********\n\n');
    });

    // ********************************************************
    // テストlog007 : CDataLog07
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log007_CDataLog07_01', () async {
      print('\n********** テスト実行：log007_CDataLog07_01 **********');
      CDataLog07 Testlog007_1 = CDataLog07();
      Testlog007_1.serial_no = 'abc12';
      Testlog007_1.seq_no = 9913;
      Testlog007_1.cnct_seq_no = 9914;
      Testlog007_1.func_cd = 9915;
      Testlog007_1.func_seq_no = 9916;
      Testlog007_1.c_data1 = 'abc17';
      Testlog007_1.c_data2 = 'abc18';
      Testlog007_1.c_data3 = 'abc19';
      Testlog007_1.c_data4 = 'abc20';
      Testlog007_1.c_data5 = 'abc21';
      Testlog007_1.c_data6 = 'abc22';
      Testlog007_1.c_data7 = 'abc23';
      Testlog007_1.c_data8 = 'abc24';
      Testlog007_1.c_data9 = 'abc25';
      Testlog007_1.c_data10 = 'abc26';
      Testlog007_1.n_data1 = 1.227;
      Testlog007_1.n_data2 = 1.228;
      Testlog007_1.n_data3 = 1.229;
      Testlog007_1.n_data4 = 1.230;
      Testlog007_1.n_data5 = 1.231;
      Testlog007_1.n_data6 = 1.232;
      Testlog007_1.n_data7 = 1.233;
      Testlog007_1.n_data8 = 1.234;
      Testlog007_1.n_data9 = 1.235;
      Testlog007_1.n_data10 = 1.236;
      Testlog007_1.n_data11 = 1.237;
      Testlog007_1.n_data12 = 1.238;
      Testlog007_1.n_data13 = 1.239;
      Testlog007_1.n_data14 = 1.240;
      Testlog007_1.n_data15 = 1.241;
      Testlog007_1.n_data16 = 1.242;
      Testlog007_1.n_data17 = 1.243;
      Testlog007_1.n_data18 = 1.244;
      Testlog007_1.n_data19 = 1.245;
      Testlog007_1.n_data20 = 1.246;
      Testlog007_1.n_data21 = 1.247;
      Testlog007_1.n_data22 = 1.248;
      Testlog007_1.n_data23 = 1.249;
      Testlog007_1.n_data24 = 1.250;
      Testlog007_1.n_data25 = 1.251;
      Testlog007_1.n_data26 = 1.252;
      Testlog007_1.n_data27 = 1.253;
      Testlog007_1.n_data28 = 1.254;
      Testlog007_1.n_data29 = 1.255;
      Testlog007_1.n_data30 = 1.256;
      Testlog007_1.d_data1 = 'abc57';
      Testlog007_1.d_data2 = 'abc58';
      Testlog007_1.d_data3 = 'abc59';
      Testlog007_1.d_data4 = 'abc60';
      Testlog007_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog07> Testlog007_AllRtn = await db.selectAllData(Testlog007_1);
      int count = Testlog007_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog007_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog07 Testlog007_2 = CDataLog07();
      //Keyの値を設定する
      Testlog007_2.serial_no = 'abc12';
      Testlog007_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog07? Testlog007_Rtn = await db.selectDataByPrimaryKey(Testlog007_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog007_Rtn == null) {
        print('\n********** 異常発生：log007_CDataLog07_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog007_Rtn?.serial_no,'abc12');
        expect(Testlog007_Rtn?.seq_no,9913);
        expect(Testlog007_Rtn?.cnct_seq_no,9914);
        expect(Testlog007_Rtn?.func_cd,9915);
        expect(Testlog007_Rtn?.func_seq_no,9916);
        expect(Testlog007_Rtn?.c_data1,'abc17');
        expect(Testlog007_Rtn?.c_data2,'abc18');
        expect(Testlog007_Rtn?.c_data3,'abc19');
        expect(Testlog007_Rtn?.c_data4,'abc20');
        expect(Testlog007_Rtn?.c_data5,'abc21');
        expect(Testlog007_Rtn?.c_data6,'abc22');
        expect(Testlog007_Rtn?.c_data7,'abc23');
        expect(Testlog007_Rtn?.c_data8,'abc24');
        expect(Testlog007_Rtn?.c_data9,'abc25');
        expect(Testlog007_Rtn?.c_data10,'abc26');
        expect(Testlog007_Rtn?.n_data1,1.227);
        expect(Testlog007_Rtn?.n_data2,1.228);
        expect(Testlog007_Rtn?.n_data3,1.229);
        expect(Testlog007_Rtn?.n_data4,1.230);
        expect(Testlog007_Rtn?.n_data5,1.231);
        expect(Testlog007_Rtn?.n_data6,1.232);
        expect(Testlog007_Rtn?.n_data7,1.233);
        expect(Testlog007_Rtn?.n_data8,1.234);
        expect(Testlog007_Rtn?.n_data9,1.235);
        expect(Testlog007_Rtn?.n_data10,1.236);
        expect(Testlog007_Rtn?.n_data11,1.237);
        expect(Testlog007_Rtn?.n_data12,1.238);
        expect(Testlog007_Rtn?.n_data13,1.239);
        expect(Testlog007_Rtn?.n_data14,1.240);
        expect(Testlog007_Rtn?.n_data15,1.241);
        expect(Testlog007_Rtn?.n_data16,1.242);
        expect(Testlog007_Rtn?.n_data17,1.243);
        expect(Testlog007_Rtn?.n_data18,1.244);
        expect(Testlog007_Rtn?.n_data19,1.245);
        expect(Testlog007_Rtn?.n_data20,1.246);
        expect(Testlog007_Rtn?.n_data21,1.247);
        expect(Testlog007_Rtn?.n_data22,1.248);
        expect(Testlog007_Rtn?.n_data23,1.249);
        expect(Testlog007_Rtn?.n_data24,1.250);
        expect(Testlog007_Rtn?.n_data25,1.251);
        expect(Testlog007_Rtn?.n_data26,1.252);
        expect(Testlog007_Rtn?.n_data27,1.253);
        expect(Testlog007_Rtn?.n_data28,1.254);
        expect(Testlog007_Rtn?.n_data29,1.255);
        expect(Testlog007_Rtn?.n_data30,1.256);
        expect(Testlog007_Rtn?.d_data1,'abc57');
        expect(Testlog007_Rtn?.d_data2,'abc58');
        expect(Testlog007_Rtn?.d_data3,'abc59');
        expect(Testlog007_Rtn?.d_data4,'abc60');
        expect(Testlog007_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog07> Testlog007_AllRtn2 = await db.selectAllData(Testlog007_1);
      int count2 = Testlog007_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog007_1);
      print('********** テスト終了：log007_CDataLog07_01 **********\n\n');
    });

    // ********************************************************
    // テストlog007 : CDataLog07
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log007_CDataLog07_01', () async {
      print('\n********** テスト実行：log007_CDataLog07_01 **********');
      CDataLog07 Testlog007_1 = CDataLog07();
      Testlog007_1.serial_no = 'abc12';
      Testlog007_1.seq_no = 9913;
      Testlog007_1.cnct_seq_no = 9914;
      Testlog007_1.func_cd = 9915;
      Testlog007_1.func_seq_no = 9916;
      Testlog007_1.c_data1 = 'abc17';
      Testlog007_1.c_data2 = 'abc18';
      Testlog007_1.c_data3 = 'abc19';
      Testlog007_1.c_data4 = 'abc20';
      Testlog007_1.c_data5 = 'abc21';
      Testlog007_1.c_data6 = 'abc22';
      Testlog007_1.c_data7 = 'abc23';
      Testlog007_1.c_data8 = 'abc24';
      Testlog007_1.c_data9 = 'abc25';
      Testlog007_1.c_data10 = 'abc26';
      Testlog007_1.n_data1 = 1.227;
      Testlog007_1.n_data2 = 1.228;
      Testlog007_1.n_data3 = 1.229;
      Testlog007_1.n_data4 = 1.230;
      Testlog007_1.n_data5 = 1.231;
      Testlog007_1.n_data6 = 1.232;
      Testlog007_1.n_data7 = 1.233;
      Testlog007_1.n_data8 = 1.234;
      Testlog007_1.n_data9 = 1.235;
      Testlog007_1.n_data10 = 1.236;
      Testlog007_1.n_data11 = 1.237;
      Testlog007_1.n_data12 = 1.238;
      Testlog007_1.n_data13 = 1.239;
      Testlog007_1.n_data14 = 1.240;
      Testlog007_1.n_data15 = 1.241;
      Testlog007_1.n_data16 = 1.242;
      Testlog007_1.n_data17 = 1.243;
      Testlog007_1.n_data18 = 1.244;
      Testlog007_1.n_data19 = 1.245;
      Testlog007_1.n_data20 = 1.246;
      Testlog007_1.n_data21 = 1.247;
      Testlog007_1.n_data22 = 1.248;
      Testlog007_1.n_data23 = 1.249;
      Testlog007_1.n_data24 = 1.250;
      Testlog007_1.n_data25 = 1.251;
      Testlog007_1.n_data26 = 1.252;
      Testlog007_1.n_data27 = 1.253;
      Testlog007_1.n_data28 = 1.254;
      Testlog007_1.n_data29 = 1.255;
      Testlog007_1.n_data30 = 1.256;
      Testlog007_1.d_data1 = 'abc57';
      Testlog007_1.d_data2 = 'abc58';
      Testlog007_1.d_data3 = 'abc59';
      Testlog007_1.d_data4 = 'abc60';
      Testlog007_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog07> Testlog007_AllRtn = await db.selectAllData(Testlog007_1);
      int count = Testlog007_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog007_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog07 Testlog007_2 = CDataLog07();
      //Keyの値を設定する
      Testlog007_2.serial_no = 'abc12';
      Testlog007_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog07? Testlog007_Rtn = await db.selectDataByPrimaryKey(Testlog007_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog007_Rtn == null) {
        print('\n********** 異常発生：log007_CDataLog07_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog007_Rtn?.serial_no,'abc12');
        expect(Testlog007_Rtn?.seq_no,9913);
        expect(Testlog007_Rtn?.cnct_seq_no,9914);
        expect(Testlog007_Rtn?.func_cd,9915);
        expect(Testlog007_Rtn?.func_seq_no,9916);
        expect(Testlog007_Rtn?.c_data1,'abc17');
        expect(Testlog007_Rtn?.c_data2,'abc18');
        expect(Testlog007_Rtn?.c_data3,'abc19');
        expect(Testlog007_Rtn?.c_data4,'abc20');
        expect(Testlog007_Rtn?.c_data5,'abc21');
        expect(Testlog007_Rtn?.c_data6,'abc22');
        expect(Testlog007_Rtn?.c_data7,'abc23');
        expect(Testlog007_Rtn?.c_data8,'abc24');
        expect(Testlog007_Rtn?.c_data9,'abc25');
        expect(Testlog007_Rtn?.c_data10,'abc26');
        expect(Testlog007_Rtn?.n_data1,1.227);
        expect(Testlog007_Rtn?.n_data2,1.228);
        expect(Testlog007_Rtn?.n_data3,1.229);
        expect(Testlog007_Rtn?.n_data4,1.230);
        expect(Testlog007_Rtn?.n_data5,1.231);
        expect(Testlog007_Rtn?.n_data6,1.232);
        expect(Testlog007_Rtn?.n_data7,1.233);
        expect(Testlog007_Rtn?.n_data8,1.234);
        expect(Testlog007_Rtn?.n_data9,1.235);
        expect(Testlog007_Rtn?.n_data10,1.236);
        expect(Testlog007_Rtn?.n_data11,1.237);
        expect(Testlog007_Rtn?.n_data12,1.238);
        expect(Testlog007_Rtn?.n_data13,1.239);
        expect(Testlog007_Rtn?.n_data14,1.240);
        expect(Testlog007_Rtn?.n_data15,1.241);
        expect(Testlog007_Rtn?.n_data16,1.242);
        expect(Testlog007_Rtn?.n_data17,1.243);
        expect(Testlog007_Rtn?.n_data18,1.244);
        expect(Testlog007_Rtn?.n_data19,1.245);
        expect(Testlog007_Rtn?.n_data20,1.246);
        expect(Testlog007_Rtn?.n_data21,1.247);
        expect(Testlog007_Rtn?.n_data22,1.248);
        expect(Testlog007_Rtn?.n_data23,1.249);
        expect(Testlog007_Rtn?.n_data24,1.250);
        expect(Testlog007_Rtn?.n_data25,1.251);
        expect(Testlog007_Rtn?.n_data26,1.252);
        expect(Testlog007_Rtn?.n_data27,1.253);
        expect(Testlog007_Rtn?.n_data28,1.254);
        expect(Testlog007_Rtn?.n_data29,1.255);
        expect(Testlog007_Rtn?.n_data30,1.256);
        expect(Testlog007_Rtn?.d_data1,'abc57');
        expect(Testlog007_Rtn?.d_data2,'abc58');
        expect(Testlog007_Rtn?.d_data3,'abc59');
        expect(Testlog007_Rtn?.d_data4,'abc60');
        expect(Testlog007_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog07> Testlog007_AllRtn2 = await db.selectAllData(Testlog007_1);
      int count2 = Testlog007_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog007_1);
      print('********** テスト終了：log007_CDataLog07_01 **********\n\n');
    });


    // ********************************************************
    // テストlog009 : CDataLog09
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log009_CDataLog09_01', () async {
      print('\n********** テスト実行：log009_CDataLog09_01 **********');
      CDataLog09 Testlog009_1 = CDataLog09();
      Testlog009_1.serial_no = 'abc12';
      Testlog009_1.seq_no = 9913;
      Testlog009_1.cnct_seq_no = 9914;
      Testlog009_1.func_cd = 9915;
      Testlog009_1.func_seq_no = 9916;
      Testlog009_1.c_data1 = 'abc17';
      Testlog009_1.c_data2 = 'abc18';
      Testlog009_1.c_data3 = 'abc19';
      Testlog009_1.c_data4 = 'abc20';
      Testlog009_1.c_data5 = 'abc21';
      Testlog009_1.c_data6 = 'abc22';
      Testlog009_1.c_data7 = 'abc23';
      Testlog009_1.c_data8 = 'abc24';
      Testlog009_1.c_data9 = 'abc25';
      Testlog009_1.c_data10 = 'abc26';
      Testlog009_1.n_data1 = 1.227;
      Testlog009_1.n_data2 = 1.228;
      Testlog009_1.n_data3 = 1.229;
      Testlog009_1.n_data4 = 1.230;
      Testlog009_1.n_data5 = 1.231;
      Testlog009_1.n_data6 = 1.232;
      Testlog009_1.n_data7 = 1.233;
      Testlog009_1.n_data8 = 1.234;
      Testlog009_1.n_data9 = 1.235;
      Testlog009_1.n_data10 = 1.236;
      Testlog009_1.n_data11 = 1.237;
      Testlog009_1.n_data12 = 1.238;
      Testlog009_1.n_data13 = 1.239;
      Testlog009_1.n_data14 = 1.240;
      Testlog009_1.n_data15 = 1.241;
      Testlog009_1.n_data16 = 1.242;
      Testlog009_1.n_data17 = 1.243;
      Testlog009_1.n_data18 = 1.244;
      Testlog009_1.n_data19 = 1.245;
      Testlog009_1.n_data20 = 1.246;
      Testlog009_1.n_data21 = 1.247;
      Testlog009_1.n_data22 = 1.248;
      Testlog009_1.n_data23 = 1.249;
      Testlog009_1.n_data24 = 1.250;
      Testlog009_1.n_data25 = 1.251;
      Testlog009_1.n_data26 = 1.252;
      Testlog009_1.n_data27 = 1.253;
      Testlog009_1.n_data28 = 1.254;
      Testlog009_1.n_data29 = 1.255;
      Testlog009_1.n_data30 = 1.256;
      Testlog009_1.d_data1 = 'abc57';
      Testlog009_1.d_data2 = 'abc58';
      Testlog009_1.d_data3 = 'abc59';
      Testlog009_1.d_data4 = 'abc60';
      Testlog009_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog09> Testlog009_AllRtn = await db.selectAllData(Testlog009_1);
      int count = Testlog009_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog009_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog09 Testlog009_2 = CDataLog09();
      //Keyの値を設定する
      Testlog009_2.serial_no = 'abc12';
      Testlog009_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog09? Testlog009_Rtn = await db.selectDataByPrimaryKey(Testlog009_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog009_Rtn == null) {
        print('\n********** 異常発生：log009_CDataLog09_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog009_Rtn?.serial_no,'abc12');
        expect(Testlog009_Rtn?.seq_no,9913);
        expect(Testlog009_Rtn?.cnct_seq_no,9914);
        expect(Testlog009_Rtn?.func_cd,9915);
        expect(Testlog009_Rtn?.func_seq_no,9916);
        expect(Testlog009_Rtn?.c_data1,'abc17');
        expect(Testlog009_Rtn?.c_data2,'abc18');
        expect(Testlog009_Rtn?.c_data3,'abc19');
        expect(Testlog009_Rtn?.c_data4,'abc20');
        expect(Testlog009_Rtn?.c_data5,'abc21');
        expect(Testlog009_Rtn?.c_data6,'abc22');
        expect(Testlog009_Rtn?.c_data7,'abc23');
        expect(Testlog009_Rtn?.c_data8,'abc24');
        expect(Testlog009_Rtn?.c_data9,'abc25');
        expect(Testlog009_Rtn?.c_data10,'abc26');
        expect(Testlog009_Rtn?.n_data1,1.227);
        expect(Testlog009_Rtn?.n_data2,1.228);
        expect(Testlog009_Rtn?.n_data3,1.229);
        expect(Testlog009_Rtn?.n_data4,1.230);
        expect(Testlog009_Rtn?.n_data5,1.231);
        expect(Testlog009_Rtn?.n_data6,1.232);
        expect(Testlog009_Rtn?.n_data7,1.233);
        expect(Testlog009_Rtn?.n_data8,1.234);
        expect(Testlog009_Rtn?.n_data9,1.235);
        expect(Testlog009_Rtn?.n_data10,1.236);
        expect(Testlog009_Rtn?.n_data11,1.237);
        expect(Testlog009_Rtn?.n_data12,1.238);
        expect(Testlog009_Rtn?.n_data13,1.239);
        expect(Testlog009_Rtn?.n_data14,1.240);
        expect(Testlog009_Rtn?.n_data15,1.241);
        expect(Testlog009_Rtn?.n_data16,1.242);
        expect(Testlog009_Rtn?.n_data17,1.243);
        expect(Testlog009_Rtn?.n_data18,1.244);
        expect(Testlog009_Rtn?.n_data19,1.245);
        expect(Testlog009_Rtn?.n_data20,1.246);
        expect(Testlog009_Rtn?.n_data21,1.247);
        expect(Testlog009_Rtn?.n_data22,1.248);
        expect(Testlog009_Rtn?.n_data23,1.249);
        expect(Testlog009_Rtn?.n_data24,1.250);
        expect(Testlog009_Rtn?.n_data25,1.251);
        expect(Testlog009_Rtn?.n_data26,1.252);
        expect(Testlog009_Rtn?.n_data27,1.253);
        expect(Testlog009_Rtn?.n_data28,1.254);
        expect(Testlog009_Rtn?.n_data29,1.255);
        expect(Testlog009_Rtn?.n_data30,1.256);
        expect(Testlog009_Rtn?.d_data1,'abc57');
        expect(Testlog009_Rtn?.d_data2,'abc58');
        expect(Testlog009_Rtn?.d_data3,'abc59');
        expect(Testlog009_Rtn?.d_data4,'abc60');
        expect(Testlog009_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog09> Testlog009_AllRtn2 = await db.selectAllData(Testlog009_1);
      int count2 = Testlog009_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog009_1);
      print('********** テスト終了：log009_CDataLog09_01 **********\n\n');
    });

    // ********************************************************
    // テストlog010 : CDataLog10
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log010_CDataLog10_01', () async {
      print('\n********** テスト実行：log010_CDataLog10_01 **********');
      CDataLog10 Testlog010_1 = CDataLog10();
      Testlog010_1.serial_no = 'abc12';
      Testlog010_1.seq_no = 9913;
      Testlog010_1.cnct_seq_no = 9914;
      Testlog010_1.func_cd = 9915;
      Testlog010_1.func_seq_no = 9916;
      Testlog010_1.c_data1 = 'abc17';
      Testlog010_1.c_data2 = 'abc18';
      Testlog010_1.c_data3 = 'abc19';
      Testlog010_1.c_data4 = 'abc20';
      Testlog010_1.c_data5 = 'abc21';
      Testlog010_1.c_data6 = 'abc22';
      Testlog010_1.c_data7 = 'abc23';
      Testlog010_1.c_data8 = 'abc24';
      Testlog010_1.c_data9 = 'abc25';
      Testlog010_1.c_data10 = 'abc26';
      Testlog010_1.n_data1 = 1.227;
      Testlog010_1.n_data2 = 1.228;
      Testlog010_1.n_data3 = 1.229;
      Testlog010_1.n_data4 = 1.230;
      Testlog010_1.n_data5 = 1.231;
      Testlog010_1.n_data6 = 1.232;
      Testlog010_1.n_data7 = 1.233;
      Testlog010_1.n_data8 = 1.234;
      Testlog010_1.n_data9 = 1.235;
      Testlog010_1.n_data10 = 1.236;
      Testlog010_1.n_data11 = 1.237;
      Testlog010_1.n_data12 = 1.238;
      Testlog010_1.n_data13 = 1.239;
      Testlog010_1.n_data14 = 1.240;
      Testlog010_1.n_data15 = 1.241;
      Testlog010_1.n_data16 = 1.242;
      Testlog010_1.n_data17 = 1.243;
      Testlog010_1.n_data18 = 1.244;
      Testlog010_1.n_data19 = 1.245;
      Testlog010_1.n_data20 = 1.246;
      Testlog010_1.n_data21 = 1.247;
      Testlog010_1.n_data22 = 1.248;
      Testlog010_1.n_data23 = 1.249;
      Testlog010_1.n_data24 = 1.250;
      Testlog010_1.n_data25 = 1.251;
      Testlog010_1.n_data26 = 1.252;
      Testlog010_1.n_data27 = 1.253;
      Testlog010_1.n_data28 = 1.254;
      Testlog010_1.n_data29 = 1.255;
      Testlog010_1.n_data30 = 1.256;
      Testlog010_1.d_data1 = 'abc57';
      Testlog010_1.d_data2 = 'abc58';
      Testlog010_1.d_data3 = 'abc59';
      Testlog010_1.d_data4 = 'abc60';
      Testlog010_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog10> Testlog010_AllRtn = await db.selectAllData(Testlog010_1);
      int count = Testlog010_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog010_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog10 Testlog010_2 = CDataLog10();
      //Keyの値を設定する
      Testlog010_2.serial_no = 'abc12';
      Testlog010_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog10? Testlog010_Rtn = await db.selectDataByPrimaryKey(Testlog010_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog010_Rtn == null) {
        print('\n********** 異常発生：log010_CDataLog10_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog010_Rtn?.serial_no,'abc12');
        expect(Testlog010_Rtn?.seq_no,9913);
        expect(Testlog010_Rtn?.cnct_seq_no,9914);
        expect(Testlog010_Rtn?.func_cd,9915);
        expect(Testlog010_Rtn?.func_seq_no,9916);
        expect(Testlog010_Rtn?.c_data1,'abc17');
        expect(Testlog010_Rtn?.c_data2,'abc18');
        expect(Testlog010_Rtn?.c_data3,'abc19');
        expect(Testlog010_Rtn?.c_data4,'abc20');
        expect(Testlog010_Rtn?.c_data5,'abc21');
        expect(Testlog010_Rtn?.c_data6,'abc22');
        expect(Testlog010_Rtn?.c_data7,'abc23');
        expect(Testlog010_Rtn?.c_data8,'abc24');
        expect(Testlog010_Rtn?.c_data9,'abc25');
        expect(Testlog010_Rtn?.c_data10,'abc26');
        expect(Testlog010_Rtn?.n_data1,1.227);
        expect(Testlog010_Rtn?.n_data2,1.228);
        expect(Testlog010_Rtn?.n_data3,1.229);
        expect(Testlog010_Rtn?.n_data4,1.230);
        expect(Testlog010_Rtn?.n_data5,1.231);
        expect(Testlog010_Rtn?.n_data6,1.232);
        expect(Testlog010_Rtn?.n_data7,1.233);
        expect(Testlog010_Rtn?.n_data8,1.234);
        expect(Testlog010_Rtn?.n_data9,1.235);
        expect(Testlog010_Rtn?.n_data10,1.236);
        expect(Testlog010_Rtn?.n_data11,1.237);
        expect(Testlog010_Rtn?.n_data12,1.238);
        expect(Testlog010_Rtn?.n_data13,1.239);
        expect(Testlog010_Rtn?.n_data14,1.240);
        expect(Testlog010_Rtn?.n_data15,1.241);
        expect(Testlog010_Rtn?.n_data16,1.242);
        expect(Testlog010_Rtn?.n_data17,1.243);
        expect(Testlog010_Rtn?.n_data18,1.244);
        expect(Testlog010_Rtn?.n_data19,1.245);
        expect(Testlog010_Rtn?.n_data20,1.246);
        expect(Testlog010_Rtn?.n_data21,1.247);
        expect(Testlog010_Rtn?.n_data22,1.248);
        expect(Testlog010_Rtn?.n_data23,1.249);
        expect(Testlog010_Rtn?.n_data24,1.250);
        expect(Testlog010_Rtn?.n_data25,1.251);
        expect(Testlog010_Rtn?.n_data26,1.252);
        expect(Testlog010_Rtn?.n_data27,1.253);
        expect(Testlog010_Rtn?.n_data28,1.254);
        expect(Testlog010_Rtn?.n_data29,1.255);
        expect(Testlog010_Rtn?.n_data30,1.256);
        expect(Testlog010_Rtn?.d_data1,'abc57');
        expect(Testlog010_Rtn?.d_data2,'abc58');
        expect(Testlog010_Rtn?.d_data3,'abc59');
        expect(Testlog010_Rtn?.d_data4,'abc60');
        expect(Testlog010_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog10> Testlog010_AllRtn2 = await db.selectAllData(Testlog010_1);
      int count2 = Testlog010_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog010_1);
      print('********** テスト終了：log010_CDataLog10_01 **********\n\n');
    });

    // ********************************************************
    // テストlog011 : CDataLog11
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log011_CDataLog11_01', () async {
      print('\n********** テスト実行：log011_CDataLog11_01 **********');
      CDataLog11 Testlog011_1 = CDataLog11();
      Testlog011_1.serial_no = 'abc12';
      Testlog011_1.seq_no = 9913;
      Testlog011_1.cnct_seq_no = 9914;
      Testlog011_1.func_cd = 9915;
      Testlog011_1.func_seq_no = 9916;
      Testlog011_1.c_data1 = 'abc17';
      Testlog011_1.c_data2 = 'abc18';
      Testlog011_1.c_data3 = 'abc19';
      Testlog011_1.c_data4 = 'abc20';
      Testlog011_1.c_data5 = 'abc21';
      Testlog011_1.c_data6 = 'abc22';
      Testlog011_1.c_data7 = 'abc23';
      Testlog011_1.c_data8 = 'abc24';
      Testlog011_1.c_data9 = 'abc25';
      Testlog011_1.c_data10 = 'abc26';
      Testlog011_1.n_data1 = 1.227;
      Testlog011_1.n_data2 = 1.228;
      Testlog011_1.n_data3 = 1.229;
      Testlog011_1.n_data4 = 1.230;
      Testlog011_1.n_data5 = 1.231;
      Testlog011_1.n_data6 = 1.232;
      Testlog011_1.n_data7 = 1.233;
      Testlog011_1.n_data8 = 1.234;
      Testlog011_1.n_data9 = 1.235;
      Testlog011_1.n_data10 = 1.236;
      Testlog011_1.n_data11 = 1.237;
      Testlog011_1.n_data12 = 1.238;
      Testlog011_1.n_data13 = 1.239;
      Testlog011_1.n_data14 = 1.240;
      Testlog011_1.n_data15 = 1.241;
      Testlog011_1.n_data16 = 1.242;
      Testlog011_1.n_data17 = 1.243;
      Testlog011_1.n_data18 = 1.244;
      Testlog011_1.n_data19 = 1.245;
      Testlog011_1.n_data20 = 1.246;
      Testlog011_1.n_data21 = 1.247;
      Testlog011_1.n_data22 = 1.248;
      Testlog011_1.n_data23 = 1.249;
      Testlog011_1.n_data24 = 1.250;
      Testlog011_1.n_data25 = 1.251;
      Testlog011_1.n_data26 = 1.252;
      Testlog011_1.n_data27 = 1.253;
      Testlog011_1.n_data28 = 1.254;
      Testlog011_1.n_data29 = 1.255;
      Testlog011_1.n_data30 = 1.256;
      Testlog011_1.d_data1 = 'abc57';
      Testlog011_1.d_data2 = 'abc58';
      Testlog011_1.d_data3 = 'abc59';
      Testlog011_1.d_data4 = 'abc60';
      Testlog011_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog11> Testlog011_AllRtn = await db.selectAllData(Testlog011_1);
      int count = Testlog011_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog011_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog11 Testlog011_2 = CDataLog11();
      //Keyの値を設定する
      Testlog011_2.serial_no = 'abc12';
      Testlog011_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog11? Testlog011_Rtn = await db.selectDataByPrimaryKey(Testlog011_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog011_Rtn == null) {
        print('\n********** 異常発生：log011_CDataLog11_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog011_Rtn?.serial_no,'abc12');
        expect(Testlog011_Rtn?.seq_no,9913);
        expect(Testlog011_Rtn?.cnct_seq_no,9914);
        expect(Testlog011_Rtn?.func_cd,9915);
        expect(Testlog011_Rtn?.func_seq_no,9916);
        expect(Testlog011_Rtn?.c_data1,'abc17');
        expect(Testlog011_Rtn?.c_data2,'abc18');
        expect(Testlog011_Rtn?.c_data3,'abc19');
        expect(Testlog011_Rtn?.c_data4,'abc20');
        expect(Testlog011_Rtn?.c_data5,'abc21');
        expect(Testlog011_Rtn?.c_data6,'abc22');
        expect(Testlog011_Rtn?.c_data7,'abc23');
        expect(Testlog011_Rtn?.c_data8,'abc24');
        expect(Testlog011_Rtn?.c_data9,'abc25');
        expect(Testlog011_Rtn?.c_data10,'abc26');
        expect(Testlog011_Rtn?.n_data1,1.227);
        expect(Testlog011_Rtn?.n_data2,1.228);
        expect(Testlog011_Rtn?.n_data3,1.229);
        expect(Testlog011_Rtn?.n_data4,1.230);
        expect(Testlog011_Rtn?.n_data5,1.231);
        expect(Testlog011_Rtn?.n_data6,1.232);
        expect(Testlog011_Rtn?.n_data7,1.233);
        expect(Testlog011_Rtn?.n_data8,1.234);
        expect(Testlog011_Rtn?.n_data9,1.235);
        expect(Testlog011_Rtn?.n_data10,1.236);
        expect(Testlog011_Rtn?.n_data11,1.237);
        expect(Testlog011_Rtn?.n_data12,1.238);
        expect(Testlog011_Rtn?.n_data13,1.239);
        expect(Testlog011_Rtn?.n_data14,1.240);
        expect(Testlog011_Rtn?.n_data15,1.241);
        expect(Testlog011_Rtn?.n_data16,1.242);
        expect(Testlog011_Rtn?.n_data17,1.243);
        expect(Testlog011_Rtn?.n_data18,1.244);
        expect(Testlog011_Rtn?.n_data19,1.245);
        expect(Testlog011_Rtn?.n_data20,1.246);
        expect(Testlog011_Rtn?.n_data21,1.247);
        expect(Testlog011_Rtn?.n_data22,1.248);
        expect(Testlog011_Rtn?.n_data23,1.249);
        expect(Testlog011_Rtn?.n_data24,1.250);
        expect(Testlog011_Rtn?.n_data25,1.251);
        expect(Testlog011_Rtn?.n_data26,1.252);
        expect(Testlog011_Rtn?.n_data27,1.253);
        expect(Testlog011_Rtn?.n_data28,1.254);
        expect(Testlog011_Rtn?.n_data29,1.255);
        expect(Testlog011_Rtn?.n_data30,1.256);
        expect(Testlog011_Rtn?.d_data1,'abc57');
        expect(Testlog011_Rtn?.d_data2,'abc58');
        expect(Testlog011_Rtn?.d_data3,'abc59');
        expect(Testlog011_Rtn?.d_data4,'abc60');
        expect(Testlog011_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog11> Testlog011_AllRtn2 = await db.selectAllData(Testlog011_1);
      int count2 = Testlog011_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog011_1);
      print('********** テスト終了：log011_CDataLog11_01 **********\n\n');
    });

    // ********************************************************
    // テストlog012 : CDataLog12
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log012_CDataLog12_01', () async {
      print('\n********** テスト実行：log012_CDataLog12_01 **********');
      CDataLog12 Testlog012_1 = CDataLog12();
      Testlog012_1.serial_no = 'abc12';
      Testlog012_1.seq_no = 9913;
      Testlog012_1.cnct_seq_no = 9914;
      Testlog012_1.func_cd = 9915;
      Testlog012_1.func_seq_no = 9916;
      Testlog012_1.c_data1 = 'abc17';
      Testlog012_1.c_data2 = 'abc18';
      Testlog012_1.c_data3 = 'abc19';
      Testlog012_1.c_data4 = 'abc20';
      Testlog012_1.c_data5 = 'abc21';
      Testlog012_1.c_data6 = 'abc22';
      Testlog012_1.c_data7 = 'abc23';
      Testlog012_1.c_data8 = 'abc24';
      Testlog012_1.c_data9 = 'abc25';
      Testlog012_1.c_data10 = 'abc26';
      Testlog012_1.n_data1 = 1.227;
      Testlog012_1.n_data2 = 1.228;
      Testlog012_1.n_data3 = 1.229;
      Testlog012_1.n_data4 = 1.230;
      Testlog012_1.n_data5 = 1.231;
      Testlog012_1.n_data6 = 1.232;
      Testlog012_1.n_data7 = 1.233;
      Testlog012_1.n_data8 = 1.234;
      Testlog012_1.n_data9 = 1.235;
      Testlog012_1.n_data10 = 1.236;
      Testlog012_1.n_data11 = 1.237;
      Testlog012_1.n_data12 = 1.238;
      Testlog012_1.n_data13 = 1.239;
      Testlog012_1.n_data14 = 1.240;
      Testlog012_1.n_data15 = 1.241;
      Testlog012_1.n_data16 = 1.242;
      Testlog012_1.n_data17 = 1.243;
      Testlog012_1.n_data18 = 1.244;
      Testlog012_1.n_data19 = 1.245;
      Testlog012_1.n_data20 = 1.246;
      Testlog012_1.n_data21 = 1.247;
      Testlog012_1.n_data22 = 1.248;
      Testlog012_1.n_data23 = 1.249;
      Testlog012_1.n_data24 = 1.250;
      Testlog012_1.n_data25 = 1.251;
      Testlog012_1.n_data26 = 1.252;
      Testlog012_1.n_data27 = 1.253;
      Testlog012_1.n_data28 = 1.254;
      Testlog012_1.n_data29 = 1.255;
      Testlog012_1.n_data30 = 1.256;
      Testlog012_1.d_data1 = 'abc57';
      Testlog012_1.d_data2 = 'abc58';
      Testlog012_1.d_data3 = 'abc59';
      Testlog012_1.d_data4 = 'abc60';
      Testlog012_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog12> Testlog012_AllRtn = await db.selectAllData(Testlog012_1);
      int count = Testlog012_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog012_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog12 Testlog012_2 = CDataLog12();
      //Keyの値を設定する
      Testlog012_2.serial_no = 'abc12';
      Testlog012_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog12? Testlog012_Rtn = await db.selectDataByPrimaryKey(Testlog012_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog012_Rtn == null) {
        print('\n********** 異常発生：log012_CDataLog12_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog012_Rtn?.serial_no,'abc12');
        expect(Testlog012_Rtn?.seq_no,9913);
        expect(Testlog012_Rtn?.cnct_seq_no,9914);
        expect(Testlog012_Rtn?.func_cd,9915);
        expect(Testlog012_Rtn?.func_seq_no,9916);
        expect(Testlog012_Rtn?.c_data1,'abc17');
        expect(Testlog012_Rtn?.c_data2,'abc18');
        expect(Testlog012_Rtn?.c_data3,'abc19');
        expect(Testlog012_Rtn?.c_data4,'abc20');
        expect(Testlog012_Rtn?.c_data5,'abc21');
        expect(Testlog012_Rtn?.c_data6,'abc22');
        expect(Testlog012_Rtn?.c_data7,'abc23');
        expect(Testlog012_Rtn?.c_data8,'abc24');
        expect(Testlog012_Rtn?.c_data9,'abc25');
        expect(Testlog012_Rtn?.c_data10,'abc26');
        expect(Testlog012_Rtn?.n_data1,1.227);
        expect(Testlog012_Rtn?.n_data2,1.228);
        expect(Testlog012_Rtn?.n_data3,1.229);
        expect(Testlog012_Rtn?.n_data4,1.230);
        expect(Testlog012_Rtn?.n_data5,1.231);
        expect(Testlog012_Rtn?.n_data6,1.232);
        expect(Testlog012_Rtn?.n_data7,1.233);
        expect(Testlog012_Rtn?.n_data8,1.234);
        expect(Testlog012_Rtn?.n_data9,1.235);
        expect(Testlog012_Rtn?.n_data10,1.236);
        expect(Testlog012_Rtn?.n_data11,1.237);
        expect(Testlog012_Rtn?.n_data12,1.238);
        expect(Testlog012_Rtn?.n_data13,1.239);
        expect(Testlog012_Rtn?.n_data14,1.240);
        expect(Testlog012_Rtn?.n_data15,1.241);
        expect(Testlog012_Rtn?.n_data16,1.242);
        expect(Testlog012_Rtn?.n_data17,1.243);
        expect(Testlog012_Rtn?.n_data18,1.244);
        expect(Testlog012_Rtn?.n_data19,1.245);
        expect(Testlog012_Rtn?.n_data20,1.246);
        expect(Testlog012_Rtn?.n_data21,1.247);
        expect(Testlog012_Rtn?.n_data22,1.248);
        expect(Testlog012_Rtn?.n_data23,1.249);
        expect(Testlog012_Rtn?.n_data24,1.250);
        expect(Testlog012_Rtn?.n_data25,1.251);
        expect(Testlog012_Rtn?.n_data26,1.252);
        expect(Testlog012_Rtn?.n_data27,1.253);
        expect(Testlog012_Rtn?.n_data28,1.254);
        expect(Testlog012_Rtn?.n_data29,1.255);
        expect(Testlog012_Rtn?.n_data30,1.256);
        expect(Testlog012_Rtn?.d_data1,'abc57');
        expect(Testlog012_Rtn?.d_data2,'abc58');
        expect(Testlog012_Rtn?.d_data3,'abc59');
        expect(Testlog012_Rtn?.d_data4,'abc60');
        expect(Testlog012_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog12> Testlog012_AllRtn2 = await db.selectAllData(Testlog012_1);
      int count2 = Testlog012_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog012_1);
      print('********** テスト終了：log012_CDataLog12_01 **********\n\n');
    });

    // ********************************************************
    // テストlog013 : CDataLog13
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log013_CDataLog13_01', () async {
      print('\n********** テスト実行：log013_CDataLog13_01 **********');
      CDataLog13 Testlog013_1 = CDataLog13();
      Testlog013_1.serial_no = 'abc12';
      Testlog013_1.seq_no = 9913;
      Testlog013_1.cnct_seq_no = 9914;
      Testlog013_1.func_cd = 9915;
      Testlog013_1.func_seq_no = 9916;
      Testlog013_1.c_data1 = 'abc17';
      Testlog013_1.c_data2 = 'abc18';
      Testlog013_1.c_data3 = 'abc19';
      Testlog013_1.c_data4 = 'abc20';
      Testlog013_1.c_data5 = 'abc21';
      Testlog013_1.c_data6 = 'abc22';
      Testlog013_1.c_data7 = 'abc23';
      Testlog013_1.c_data8 = 'abc24';
      Testlog013_1.c_data9 = 'abc25';
      Testlog013_1.c_data10 = 'abc26';
      Testlog013_1.n_data1 = 1.227;
      Testlog013_1.n_data2 = 1.228;
      Testlog013_1.n_data3 = 1.229;
      Testlog013_1.n_data4 = 1.230;
      Testlog013_1.n_data5 = 1.231;
      Testlog013_1.n_data6 = 1.232;
      Testlog013_1.n_data7 = 1.233;
      Testlog013_1.n_data8 = 1.234;
      Testlog013_1.n_data9 = 1.235;
      Testlog013_1.n_data10 = 1.236;
      Testlog013_1.n_data11 = 1.237;
      Testlog013_1.n_data12 = 1.238;
      Testlog013_1.n_data13 = 1.239;
      Testlog013_1.n_data14 = 1.240;
      Testlog013_1.n_data15 = 1.241;
      Testlog013_1.n_data16 = 1.242;
      Testlog013_1.n_data17 = 1.243;
      Testlog013_1.n_data18 = 1.244;
      Testlog013_1.n_data19 = 1.245;
      Testlog013_1.n_data20 = 1.246;
      Testlog013_1.n_data21 = 1.247;
      Testlog013_1.n_data22 = 1.248;
      Testlog013_1.n_data23 = 1.249;
      Testlog013_1.n_data24 = 1.250;
      Testlog013_1.n_data25 = 1.251;
      Testlog013_1.n_data26 = 1.252;
      Testlog013_1.n_data27 = 1.253;
      Testlog013_1.n_data28 = 1.254;
      Testlog013_1.n_data29 = 1.255;
      Testlog013_1.n_data30 = 1.256;
      Testlog013_1.d_data1 = 'abc57';
      Testlog013_1.d_data2 = 'abc58';
      Testlog013_1.d_data3 = 'abc59';
      Testlog013_1.d_data4 = 'abc60';
      Testlog013_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog13> Testlog013_AllRtn = await db.selectAllData(Testlog013_1);
      int count = Testlog013_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog013_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog13 Testlog013_2 = CDataLog13();
      //Keyの値を設定する
      Testlog013_2.serial_no = 'abc12';
      Testlog013_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog13? Testlog013_Rtn = await db.selectDataByPrimaryKey(Testlog013_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog013_Rtn == null) {
        print('\n********** 異常発生：log013_CDataLog13_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog013_Rtn?.serial_no,'abc12');
        expect(Testlog013_Rtn?.seq_no,9913);
        expect(Testlog013_Rtn?.cnct_seq_no,9914);
        expect(Testlog013_Rtn?.func_cd,9915);
        expect(Testlog013_Rtn?.func_seq_no,9916);
        expect(Testlog013_Rtn?.c_data1,'abc17');
        expect(Testlog013_Rtn?.c_data2,'abc18');
        expect(Testlog013_Rtn?.c_data3,'abc19');
        expect(Testlog013_Rtn?.c_data4,'abc20');
        expect(Testlog013_Rtn?.c_data5,'abc21');
        expect(Testlog013_Rtn?.c_data6,'abc22');
        expect(Testlog013_Rtn?.c_data7,'abc23');
        expect(Testlog013_Rtn?.c_data8,'abc24');
        expect(Testlog013_Rtn?.c_data9,'abc25');
        expect(Testlog013_Rtn?.c_data10,'abc26');
        expect(Testlog013_Rtn?.n_data1,1.227);
        expect(Testlog013_Rtn?.n_data2,1.228);
        expect(Testlog013_Rtn?.n_data3,1.229);
        expect(Testlog013_Rtn?.n_data4,1.230);
        expect(Testlog013_Rtn?.n_data5,1.231);
        expect(Testlog013_Rtn?.n_data6,1.232);
        expect(Testlog013_Rtn?.n_data7,1.233);
        expect(Testlog013_Rtn?.n_data8,1.234);
        expect(Testlog013_Rtn?.n_data9,1.235);
        expect(Testlog013_Rtn?.n_data10,1.236);
        expect(Testlog013_Rtn?.n_data11,1.237);
        expect(Testlog013_Rtn?.n_data12,1.238);
        expect(Testlog013_Rtn?.n_data13,1.239);
        expect(Testlog013_Rtn?.n_data14,1.240);
        expect(Testlog013_Rtn?.n_data15,1.241);
        expect(Testlog013_Rtn?.n_data16,1.242);
        expect(Testlog013_Rtn?.n_data17,1.243);
        expect(Testlog013_Rtn?.n_data18,1.244);
        expect(Testlog013_Rtn?.n_data19,1.245);
        expect(Testlog013_Rtn?.n_data20,1.246);
        expect(Testlog013_Rtn?.n_data21,1.247);
        expect(Testlog013_Rtn?.n_data22,1.248);
        expect(Testlog013_Rtn?.n_data23,1.249);
        expect(Testlog013_Rtn?.n_data24,1.250);
        expect(Testlog013_Rtn?.n_data25,1.251);
        expect(Testlog013_Rtn?.n_data26,1.252);
        expect(Testlog013_Rtn?.n_data27,1.253);
        expect(Testlog013_Rtn?.n_data28,1.254);
        expect(Testlog013_Rtn?.n_data29,1.255);
        expect(Testlog013_Rtn?.n_data30,1.256);
        expect(Testlog013_Rtn?.d_data1,'abc57');
        expect(Testlog013_Rtn?.d_data2,'abc58');
        expect(Testlog013_Rtn?.d_data3,'abc59');
        expect(Testlog013_Rtn?.d_data4,'abc60');
        expect(Testlog013_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog13> Testlog013_AllRtn2 = await db.selectAllData(Testlog013_1);
      int count2 = Testlog013_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog013_1);
      print('********** テスト終了：log013_CDataLog13_01 **********\n\n');
    });

    // ********************************************************
    // テストlog014 : CDataLog14
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log014_CDataLog14_01', () async {
      print('\n********** テスト実行：log014_CDataLog14_01 **********');
      CDataLog14 Testlog014_1 = CDataLog14();
      Testlog014_1.serial_no = 'abc12';
      Testlog014_1.seq_no = 9913;
      Testlog014_1.cnct_seq_no = 9914;
      Testlog014_1.func_cd = 9915;
      Testlog014_1.func_seq_no = 9916;
      Testlog014_1.c_data1 = 'abc17';
      Testlog014_1.c_data2 = 'abc18';
      Testlog014_1.c_data3 = 'abc19';
      Testlog014_1.c_data4 = 'abc20';
      Testlog014_1.c_data5 = 'abc21';
      Testlog014_1.c_data6 = 'abc22';
      Testlog014_1.c_data7 = 'abc23';
      Testlog014_1.c_data8 = 'abc24';
      Testlog014_1.c_data9 = 'abc25';
      Testlog014_1.c_data10 = 'abc26';
      Testlog014_1.n_data1 = 1.227;
      Testlog014_1.n_data2 = 1.228;
      Testlog014_1.n_data3 = 1.229;
      Testlog014_1.n_data4 = 1.230;
      Testlog014_1.n_data5 = 1.231;
      Testlog014_1.n_data6 = 1.232;
      Testlog014_1.n_data7 = 1.233;
      Testlog014_1.n_data8 = 1.234;
      Testlog014_1.n_data9 = 1.235;
      Testlog014_1.n_data10 = 1.236;
      Testlog014_1.n_data11 = 1.237;
      Testlog014_1.n_data12 = 1.238;
      Testlog014_1.n_data13 = 1.239;
      Testlog014_1.n_data14 = 1.240;
      Testlog014_1.n_data15 = 1.241;
      Testlog014_1.n_data16 = 1.242;
      Testlog014_1.n_data17 = 1.243;
      Testlog014_1.n_data18 = 1.244;
      Testlog014_1.n_data19 = 1.245;
      Testlog014_1.n_data20 = 1.246;
      Testlog014_1.n_data21 = 1.247;
      Testlog014_1.n_data22 = 1.248;
      Testlog014_1.n_data23 = 1.249;
      Testlog014_1.n_data24 = 1.250;
      Testlog014_1.n_data25 = 1.251;
      Testlog014_1.n_data26 = 1.252;
      Testlog014_1.n_data27 = 1.253;
      Testlog014_1.n_data28 = 1.254;
      Testlog014_1.n_data29 = 1.255;
      Testlog014_1.n_data30 = 1.256;
      Testlog014_1.d_data1 = 'abc57';
      Testlog014_1.d_data2 = 'abc58';
      Testlog014_1.d_data3 = 'abc59';
      Testlog014_1.d_data4 = 'abc60';
      Testlog014_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog14> Testlog014_AllRtn = await db.selectAllData(Testlog014_1);
      int count = Testlog014_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog014_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog14 Testlog014_2 = CDataLog14();
      //Keyの値を設定する
      Testlog014_2.serial_no = 'abc12';
      Testlog014_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog14? Testlog014_Rtn = await db.selectDataByPrimaryKey(Testlog014_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog014_Rtn == null) {
        print('\n********** 異常発生：log014_CDataLog14_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog014_Rtn?.serial_no,'abc12');
        expect(Testlog014_Rtn?.seq_no,9913);
        expect(Testlog014_Rtn?.cnct_seq_no,9914);
        expect(Testlog014_Rtn?.func_cd,9915);
        expect(Testlog014_Rtn?.func_seq_no,9916);
        expect(Testlog014_Rtn?.c_data1,'abc17');
        expect(Testlog014_Rtn?.c_data2,'abc18');
        expect(Testlog014_Rtn?.c_data3,'abc19');
        expect(Testlog014_Rtn?.c_data4,'abc20');
        expect(Testlog014_Rtn?.c_data5,'abc21');
        expect(Testlog014_Rtn?.c_data6,'abc22');
        expect(Testlog014_Rtn?.c_data7,'abc23');
        expect(Testlog014_Rtn?.c_data8,'abc24');
        expect(Testlog014_Rtn?.c_data9,'abc25');
        expect(Testlog014_Rtn?.c_data10,'abc26');
        expect(Testlog014_Rtn?.n_data1,1.227);
        expect(Testlog014_Rtn?.n_data2,1.228);
        expect(Testlog014_Rtn?.n_data3,1.229);
        expect(Testlog014_Rtn?.n_data4,1.230);
        expect(Testlog014_Rtn?.n_data5,1.231);
        expect(Testlog014_Rtn?.n_data6,1.232);
        expect(Testlog014_Rtn?.n_data7,1.233);
        expect(Testlog014_Rtn?.n_data8,1.234);
        expect(Testlog014_Rtn?.n_data9,1.235);
        expect(Testlog014_Rtn?.n_data10,1.236);
        expect(Testlog014_Rtn?.n_data11,1.237);
        expect(Testlog014_Rtn?.n_data12,1.238);
        expect(Testlog014_Rtn?.n_data13,1.239);
        expect(Testlog014_Rtn?.n_data14,1.240);
        expect(Testlog014_Rtn?.n_data15,1.241);
        expect(Testlog014_Rtn?.n_data16,1.242);
        expect(Testlog014_Rtn?.n_data17,1.243);
        expect(Testlog014_Rtn?.n_data18,1.244);
        expect(Testlog014_Rtn?.n_data19,1.245);
        expect(Testlog014_Rtn?.n_data20,1.246);
        expect(Testlog014_Rtn?.n_data21,1.247);
        expect(Testlog014_Rtn?.n_data22,1.248);
        expect(Testlog014_Rtn?.n_data23,1.249);
        expect(Testlog014_Rtn?.n_data24,1.250);
        expect(Testlog014_Rtn?.n_data25,1.251);
        expect(Testlog014_Rtn?.n_data26,1.252);
        expect(Testlog014_Rtn?.n_data27,1.253);
        expect(Testlog014_Rtn?.n_data28,1.254);
        expect(Testlog014_Rtn?.n_data29,1.255);
        expect(Testlog014_Rtn?.n_data30,1.256);
        expect(Testlog014_Rtn?.d_data1,'abc57');
        expect(Testlog014_Rtn?.d_data2,'abc58');
        expect(Testlog014_Rtn?.d_data3,'abc59');
        expect(Testlog014_Rtn?.d_data4,'abc60');
        expect(Testlog014_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog14> Testlog014_AllRtn2 = await db.selectAllData(Testlog014_1);
      int count2 = Testlog014_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog014_1);
      print('********** テスト終了：log014_CDataLog14_01 **********\n\n');
    });

    // ********************************************************
    // テストlog015 : CDataLog15
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log015_CDataLog15_01', () async {
      print('\n********** テスト実行：log015_CDataLog15_01 **********');
      CDataLog15 Testlog015_1 = CDataLog15();
      Testlog015_1.serial_no = 'abc12';
      Testlog015_1.seq_no = 9913;
      Testlog015_1.cnct_seq_no = 9914;
      Testlog015_1.func_cd = 9915;
      Testlog015_1.func_seq_no = 9916;
      Testlog015_1.c_data1 = 'abc17';
      Testlog015_1.c_data2 = 'abc18';
      Testlog015_1.c_data3 = 'abc19';
      Testlog015_1.c_data4 = 'abc20';
      Testlog015_1.c_data5 = 'abc21';
      Testlog015_1.c_data6 = 'abc22';
      Testlog015_1.c_data7 = 'abc23';
      Testlog015_1.c_data8 = 'abc24';
      Testlog015_1.c_data9 = 'abc25';
      Testlog015_1.c_data10 = 'abc26';
      Testlog015_1.n_data1 = 1.227;
      Testlog015_1.n_data2 = 1.228;
      Testlog015_1.n_data3 = 1.229;
      Testlog015_1.n_data4 = 1.230;
      Testlog015_1.n_data5 = 1.231;
      Testlog015_1.n_data6 = 1.232;
      Testlog015_1.n_data7 = 1.233;
      Testlog015_1.n_data8 = 1.234;
      Testlog015_1.n_data9 = 1.235;
      Testlog015_1.n_data10 = 1.236;
      Testlog015_1.n_data11 = 1.237;
      Testlog015_1.n_data12 = 1.238;
      Testlog015_1.n_data13 = 1.239;
      Testlog015_1.n_data14 = 1.240;
      Testlog015_1.n_data15 = 1.241;
      Testlog015_1.n_data16 = 1.242;
      Testlog015_1.n_data17 = 1.243;
      Testlog015_1.n_data18 = 1.244;
      Testlog015_1.n_data19 = 1.245;
      Testlog015_1.n_data20 = 1.246;
      Testlog015_1.n_data21 = 1.247;
      Testlog015_1.n_data22 = 1.248;
      Testlog015_1.n_data23 = 1.249;
      Testlog015_1.n_data24 = 1.250;
      Testlog015_1.n_data25 = 1.251;
      Testlog015_1.n_data26 = 1.252;
      Testlog015_1.n_data27 = 1.253;
      Testlog015_1.n_data28 = 1.254;
      Testlog015_1.n_data29 = 1.255;
      Testlog015_1.n_data30 = 1.256;
      Testlog015_1.d_data1 = 'abc57';
      Testlog015_1.d_data2 = 'abc58';
      Testlog015_1.d_data3 = 'abc59';
      Testlog015_1.d_data4 = 'abc60';
      Testlog015_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog15> Testlog015_AllRtn = await db.selectAllData(Testlog015_1);
      int count = Testlog015_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog015_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog15 Testlog015_2 = CDataLog15();
      //Keyの値を設定する
      Testlog015_2.serial_no = 'abc12';
      Testlog015_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog15? Testlog015_Rtn = await db.selectDataByPrimaryKey(Testlog015_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog015_Rtn == null) {
        print('\n********** 異常発生：log015_CDataLog15_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog015_Rtn?.serial_no,'abc12');
        expect(Testlog015_Rtn?.seq_no,9913);
        expect(Testlog015_Rtn?.cnct_seq_no,9914);
        expect(Testlog015_Rtn?.func_cd,9915);
        expect(Testlog015_Rtn?.func_seq_no,9916);
        expect(Testlog015_Rtn?.c_data1,'abc17');
        expect(Testlog015_Rtn?.c_data2,'abc18');
        expect(Testlog015_Rtn?.c_data3,'abc19');
        expect(Testlog015_Rtn?.c_data4,'abc20');
        expect(Testlog015_Rtn?.c_data5,'abc21');
        expect(Testlog015_Rtn?.c_data6,'abc22');
        expect(Testlog015_Rtn?.c_data7,'abc23');
        expect(Testlog015_Rtn?.c_data8,'abc24');
        expect(Testlog015_Rtn?.c_data9,'abc25');
        expect(Testlog015_Rtn?.c_data10,'abc26');
        expect(Testlog015_Rtn?.n_data1,1.227);
        expect(Testlog015_Rtn?.n_data2,1.228);
        expect(Testlog015_Rtn?.n_data3,1.229);
        expect(Testlog015_Rtn?.n_data4,1.230);
        expect(Testlog015_Rtn?.n_data5,1.231);
        expect(Testlog015_Rtn?.n_data6,1.232);
        expect(Testlog015_Rtn?.n_data7,1.233);
        expect(Testlog015_Rtn?.n_data8,1.234);
        expect(Testlog015_Rtn?.n_data9,1.235);
        expect(Testlog015_Rtn?.n_data10,1.236);
        expect(Testlog015_Rtn?.n_data11,1.237);
        expect(Testlog015_Rtn?.n_data12,1.238);
        expect(Testlog015_Rtn?.n_data13,1.239);
        expect(Testlog015_Rtn?.n_data14,1.240);
        expect(Testlog015_Rtn?.n_data15,1.241);
        expect(Testlog015_Rtn?.n_data16,1.242);
        expect(Testlog015_Rtn?.n_data17,1.243);
        expect(Testlog015_Rtn?.n_data18,1.244);
        expect(Testlog015_Rtn?.n_data19,1.245);
        expect(Testlog015_Rtn?.n_data20,1.246);
        expect(Testlog015_Rtn?.n_data21,1.247);
        expect(Testlog015_Rtn?.n_data22,1.248);
        expect(Testlog015_Rtn?.n_data23,1.249);
        expect(Testlog015_Rtn?.n_data24,1.250);
        expect(Testlog015_Rtn?.n_data25,1.251);
        expect(Testlog015_Rtn?.n_data26,1.252);
        expect(Testlog015_Rtn?.n_data27,1.253);
        expect(Testlog015_Rtn?.n_data28,1.254);
        expect(Testlog015_Rtn?.n_data29,1.255);
        expect(Testlog015_Rtn?.n_data30,1.256);
        expect(Testlog015_Rtn?.d_data1,'abc57');
        expect(Testlog015_Rtn?.d_data2,'abc58');
        expect(Testlog015_Rtn?.d_data3,'abc59');
        expect(Testlog015_Rtn?.d_data4,'abc60');
        expect(Testlog015_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog15> Testlog015_AllRtn2 = await db.selectAllData(Testlog015_1);
      int count2 = Testlog015_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog015_1);
      print('********** テスト終了：log015_CDataLog15_01 **********\n\n');
    });

    // ********************************************************
    // テストlog016 : CDataLog16
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log016_CDataLog16_01', () async {
      print('\n********** テスト実行：log016_CDataLog16_01 **********');
      CDataLog16 Testlog016_1 = CDataLog16();
      Testlog016_1.serial_no = 'abc12';
      Testlog016_1.seq_no = 9913;
      Testlog016_1.cnct_seq_no = 9914;
      Testlog016_1.func_cd = 9915;
      Testlog016_1.func_seq_no = 9916;
      Testlog016_1.c_data1 = 'abc17';
      Testlog016_1.c_data2 = 'abc18';
      Testlog016_1.c_data3 = 'abc19';
      Testlog016_1.c_data4 = 'abc20';
      Testlog016_1.c_data5 = 'abc21';
      Testlog016_1.c_data6 = 'abc22';
      Testlog016_1.c_data7 = 'abc23';
      Testlog016_1.c_data8 = 'abc24';
      Testlog016_1.c_data9 = 'abc25';
      Testlog016_1.c_data10 = 'abc26';
      Testlog016_1.n_data1 = 1.227;
      Testlog016_1.n_data2 = 1.228;
      Testlog016_1.n_data3 = 1.229;
      Testlog016_1.n_data4 = 1.230;
      Testlog016_1.n_data5 = 1.231;
      Testlog016_1.n_data6 = 1.232;
      Testlog016_1.n_data7 = 1.233;
      Testlog016_1.n_data8 = 1.234;
      Testlog016_1.n_data9 = 1.235;
      Testlog016_1.n_data10 = 1.236;
      Testlog016_1.n_data11 = 1.237;
      Testlog016_1.n_data12 = 1.238;
      Testlog016_1.n_data13 = 1.239;
      Testlog016_1.n_data14 = 1.240;
      Testlog016_1.n_data15 = 1.241;
      Testlog016_1.n_data16 = 1.242;
      Testlog016_1.n_data17 = 1.243;
      Testlog016_1.n_data18 = 1.244;
      Testlog016_1.n_data19 = 1.245;
      Testlog016_1.n_data20 = 1.246;
      Testlog016_1.n_data21 = 1.247;
      Testlog016_1.n_data22 = 1.248;
      Testlog016_1.n_data23 = 1.249;
      Testlog016_1.n_data24 = 1.250;
      Testlog016_1.n_data25 = 1.251;
      Testlog016_1.n_data26 = 1.252;
      Testlog016_1.n_data27 = 1.253;
      Testlog016_1.n_data28 = 1.254;
      Testlog016_1.n_data29 = 1.255;
      Testlog016_1.n_data30 = 1.256;
      Testlog016_1.d_data1 = 'abc57';
      Testlog016_1.d_data2 = 'abc58';
      Testlog016_1.d_data3 = 'abc59';
      Testlog016_1.d_data4 = 'abc60';
      Testlog016_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog16> Testlog016_AllRtn = await db.selectAllData(Testlog016_1);
      int count = Testlog016_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog016_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog16 Testlog016_2 = CDataLog16();
      //Keyの値を設定する
      Testlog016_2.serial_no = 'abc12';
      Testlog016_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog16? Testlog016_Rtn = await db.selectDataByPrimaryKey(Testlog016_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog016_Rtn == null) {
        print('\n********** 異常発生：log016_CDataLog16_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog016_Rtn?.serial_no,'abc12');
        expect(Testlog016_Rtn?.seq_no,9913);
        expect(Testlog016_Rtn?.cnct_seq_no,9914);
        expect(Testlog016_Rtn?.func_cd,9915);
        expect(Testlog016_Rtn?.func_seq_no,9916);
        expect(Testlog016_Rtn?.c_data1,'abc17');
        expect(Testlog016_Rtn?.c_data2,'abc18');
        expect(Testlog016_Rtn?.c_data3,'abc19');
        expect(Testlog016_Rtn?.c_data4,'abc20');
        expect(Testlog016_Rtn?.c_data5,'abc21');
        expect(Testlog016_Rtn?.c_data6,'abc22');
        expect(Testlog016_Rtn?.c_data7,'abc23');
        expect(Testlog016_Rtn?.c_data8,'abc24');
        expect(Testlog016_Rtn?.c_data9,'abc25');
        expect(Testlog016_Rtn?.c_data10,'abc26');
        expect(Testlog016_Rtn?.n_data1,1.227);
        expect(Testlog016_Rtn?.n_data2,1.228);
        expect(Testlog016_Rtn?.n_data3,1.229);
        expect(Testlog016_Rtn?.n_data4,1.230);
        expect(Testlog016_Rtn?.n_data5,1.231);
        expect(Testlog016_Rtn?.n_data6,1.232);
        expect(Testlog016_Rtn?.n_data7,1.233);
        expect(Testlog016_Rtn?.n_data8,1.234);
        expect(Testlog016_Rtn?.n_data9,1.235);
        expect(Testlog016_Rtn?.n_data10,1.236);
        expect(Testlog016_Rtn?.n_data11,1.237);
        expect(Testlog016_Rtn?.n_data12,1.238);
        expect(Testlog016_Rtn?.n_data13,1.239);
        expect(Testlog016_Rtn?.n_data14,1.240);
        expect(Testlog016_Rtn?.n_data15,1.241);
        expect(Testlog016_Rtn?.n_data16,1.242);
        expect(Testlog016_Rtn?.n_data17,1.243);
        expect(Testlog016_Rtn?.n_data18,1.244);
        expect(Testlog016_Rtn?.n_data19,1.245);
        expect(Testlog016_Rtn?.n_data20,1.246);
        expect(Testlog016_Rtn?.n_data21,1.247);
        expect(Testlog016_Rtn?.n_data22,1.248);
        expect(Testlog016_Rtn?.n_data23,1.249);
        expect(Testlog016_Rtn?.n_data24,1.250);
        expect(Testlog016_Rtn?.n_data25,1.251);
        expect(Testlog016_Rtn?.n_data26,1.252);
        expect(Testlog016_Rtn?.n_data27,1.253);
        expect(Testlog016_Rtn?.n_data28,1.254);
        expect(Testlog016_Rtn?.n_data29,1.255);
        expect(Testlog016_Rtn?.n_data30,1.256);
        expect(Testlog016_Rtn?.d_data1,'abc57');
        expect(Testlog016_Rtn?.d_data2,'abc58');
        expect(Testlog016_Rtn?.d_data3,'abc59');
        expect(Testlog016_Rtn?.d_data4,'abc60');
        expect(Testlog016_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog16> Testlog016_AllRtn2 = await db.selectAllData(Testlog016_1);
      int count2 = Testlog016_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog016_1);
      print('********** テスト終了：log016_CDataLog16_01 **********\n\n');
    });

    // ********************************************************
    // テストlog017 : CDataLog17
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log017_CDataLog17_01', () async {
      print('\n********** テスト実行：log017_CDataLog17_01 **********');
      CDataLog17 Testlog017_1 = CDataLog17();
      Testlog017_1.serial_no = 'abc12';
      Testlog017_1.seq_no = 9913;
      Testlog017_1.cnct_seq_no = 9914;
      Testlog017_1.func_cd = 9915;
      Testlog017_1.func_seq_no = 9916;
      Testlog017_1.c_data1 = 'abc17';
      Testlog017_1.c_data2 = 'abc18';
      Testlog017_1.c_data3 = 'abc19';
      Testlog017_1.c_data4 = 'abc20';
      Testlog017_1.c_data5 = 'abc21';
      Testlog017_1.c_data6 = 'abc22';
      Testlog017_1.c_data7 = 'abc23';
      Testlog017_1.c_data8 = 'abc24';
      Testlog017_1.c_data9 = 'abc25';
      Testlog017_1.c_data10 = 'abc26';
      Testlog017_1.n_data1 = 1.227;
      Testlog017_1.n_data2 = 1.228;
      Testlog017_1.n_data3 = 1.229;
      Testlog017_1.n_data4 = 1.230;
      Testlog017_1.n_data5 = 1.231;
      Testlog017_1.n_data6 = 1.232;
      Testlog017_1.n_data7 = 1.233;
      Testlog017_1.n_data8 = 1.234;
      Testlog017_1.n_data9 = 1.235;
      Testlog017_1.n_data10 = 1.236;
      Testlog017_1.n_data11 = 1.237;
      Testlog017_1.n_data12 = 1.238;
      Testlog017_1.n_data13 = 1.239;
      Testlog017_1.n_data14 = 1.240;
      Testlog017_1.n_data15 = 1.241;
      Testlog017_1.n_data16 = 1.242;
      Testlog017_1.n_data17 = 1.243;
      Testlog017_1.n_data18 = 1.244;
      Testlog017_1.n_data19 = 1.245;
      Testlog017_1.n_data20 = 1.246;
      Testlog017_1.n_data21 = 1.247;
      Testlog017_1.n_data22 = 1.248;
      Testlog017_1.n_data23 = 1.249;
      Testlog017_1.n_data24 = 1.250;
      Testlog017_1.n_data25 = 1.251;
      Testlog017_1.n_data26 = 1.252;
      Testlog017_1.n_data27 = 1.253;
      Testlog017_1.n_data28 = 1.254;
      Testlog017_1.n_data29 = 1.255;
      Testlog017_1.n_data30 = 1.256;
      Testlog017_1.d_data1 = 'abc57';
      Testlog017_1.d_data2 = 'abc58';
      Testlog017_1.d_data3 = 'abc59';
      Testlog017_1.d_data4 = 'abc60';
      Testlog017_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog17> Testlog017_AllRtn = await db.selectAllData(Testlog017_1);
      int count = Testlog017_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog017_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog17 Testlog017_2 = CDataLog17();
      //Keyの値を設定する
      Testlog017_2.serial_no = 'abc12';
      Testlog017_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog17? Testlog017_Rtn = await db.selectDataByPrimaryKey(Testlog017_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog017_Rtn == null) {
        print('\n********** 異常発生：log017_CDataLog17_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog017_Rtn?.serial_no,'abc12');
        expect(Testlog017_Rtn?.seq_no,9913);
        expect(Testlog017_Rtn?.cnct_seq_no,9914);
        expect(Testlog017_Rtn?.func_cd,9915);
        expect(Testlog017_Rtn?.func_seq_no,9916);
        expect(Testlog017_Rtn?.c_data1,'abc17');
        expect(Testlog017_Rtn?.c_data2,'abc18');
        expect(Testlog017_Rtn?.c_data3,'abc19');
        expect(Testlog017_Rtn?.c_data4,'abc20');
        expect(Testlog017_Rtn?.c_data5,'abc21');
        expect(Testlog017_Rtn?.c_data6,'abc22');
        expect(Testlog017_Rtn?.c_data7,'abc23');
        expect(Testlog017_Rtn?.c_data8,'abc24');
        expect(Testlog017_Rtn?.c_data9,'abc25');
        expect(Testlog017_Rtn?.c_data10,'abc26');
        expect(Testlog017_Rtn?.n_data1,1.227);
        expect(Testlog017_Rtn?.n_data2,1.228);
        expect(Testlog017_Rtn?.n_data3,1.229);
        expect(Testlog017_Rtn?.n_data4,1.230);
        expect(Testlog017_Rtn?.n_data5,1.231);
        expect(Testlog017_Rtn?.n_data6,1.232);
        expect(Testlog017_Rtn?.n_data7,1.233);
        expect(Testlog017_Rtn?.n_data8,1.234);
        expect(Testlog017_Rtn?.n_data9,1.235);
        expect(Testlog017_Rtn?.n_data10,1.236);
        expect(Testlog017_Rtn?.n_data11,1.237);
        expect(Testlog017_Rtn?.n_data12,1.238);
        expect(Testlog017_Rtn?.n_data13,1.239);
        expect(Testlog017_Rtn?.n_data14,1.240);
        expect(Testlog017_Rtn?.n_data15,1.241);
        expect(Testlog017_Rtn?.n_data16,1.242);
        expect(Testlog017_Rtn?.n_data17,1.243);
        expect(Testlog017_Rtn?.n_data18,1.244);
        expect(Testlog017_Rtn?.n_data19,1.245);
        expect(Testlog017_Rtn?.n_data20,1.246);
        expect(Testlog017_Rtn?.n_data21,1.247);
        expect(Testlog017_Rtn?.n_data22,1.248);
        expect(Testlog017_Rtn?.n_data23,1.249);
        expect(Testlog017_Rtn?.n_data24,1.250);
        expect(Testlog017_Rtn?.n_data25,1.251);
        expect(Testlog017_Rtn?.n_data26,1.252);
        expect(Testlog017_Rtn?.n_data27,1.253);
        expect(Testlog017_Rtn?.n_data28,1.254);
        expect(Testlog017_Rtn?.n_data29,1.255);
        expect(Testlog017_Rtn?.n_data30,1.256);
        expect(Testlog017_Rtn?.d_data1,'abc57');
        expect(Testlog017_Rtn?.d_data2,'abc58');
        expect(Testlog017_Rtn?.d_data3,'abc59');
        expect(Testlog017_Rtn?.d_data4,'abc60');
        expect(Testlog017_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog17> Testlog017_AllRtn2 = await db.selectAllData(Testlog017_1);
      int count2 = Testlog017_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog017_1);
      print('********** テスト終了：log017_CDataLog17_01 **********\n\n');
    });

    // ********************************************************
    // テストlog018 : CDataLog18
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log018_CDataLog18_01', () async {
      print('\n********** テスト実行：log018_CDataLog18_01 **********');
      CDataLog18 Testlog018_1 = CDataLog18();
      Testlog018_1.serial_no = 'abc12';
      Testlog018_1.seq_no = 9913;
      Testlog018_1.cnct_seq_no = 9914;
      Testlog018_1.func_cd = 9915;
      Testlog018_1.func_seq_no = 9916;
      Testlog018_1.c_data1 = 'abc17';
      Testlog018_1.c_data2 = 'abc18';
      Testlog018_1.c_data3 = 'abc19';
      Testlog018_1.c_data4 = 'abc20';
      Testlog018_1.c_data5 = 'abc21';
      Testlog018_1.c_data6 = 'abc22';
      Testlog018_1.c_data7 = 'abc23';
      Testlog018_1.c_data8 = 'abc24';
      Testlog018_1.c_data9 = 'abc25';
      Testlog018_1.c_data10 = 'abc26';
      Testlog018_1.n_data1 = 1.227;
      Testlog018_1.n_data2 = 1.228;
      Testlog018_1.n_data3 = 1.229;
      Testlog018_1.n_data4 = 1.230;
      Testlog018_1.n_data5 = 1.231;
      Testlog018_1.n_data6 = 1.232;
      Testlog018_1.n_data7 = 1.233;
      Testlog018_1.n_data8 = 1.234;
      Testlog018_1.n_data9 = 1.235;
      Testlog018_1.n_data10 = 1.236;
      Testlog018_1.n_data11 = 1.237;
      Testlog018_1.n_data12 = 1.238;
      Testlog018_1.n_data13 = 1.239;
      Testlog018_1.n_data14 = 1.240;
      Testlog018_1.n_data15 = 1.241;
      Testlog018_1.n_data16 = 1.242;
      Testlog018_1.n_data17 = 1.243;
      Testlog018_1.n_data18 = 1.244;
      Testlog018_1.n_data19 = 1.245;
      Testlog018_1.n_data20 = 1.246;
      Testlog018_1.n_data21 = 1.247;
      Testlog018_1.n_data22 = 1.248;
      Testlog018_1.n_data23 = 1.249;
      Testlog018_1.n_data24 = 1.250;
      Testlog018_1.n_data25 = 1.251;
      Testlog018_1.n_data26 = 1.252;
      Testlog018_1.n_data27 = 1.253;
      Testlog018_1.n_data28 = 1.254;
      Testlog018_1.n_data29 = 1.255;
      Testlog018_1.n_data30 = 1.256;
      Testlog018_1.d_data1 = 'abc57';
      Testlog018_1.d_data2 = 'abc58';
      Testlog018_1.d_data3 = 'abc59';
      Testlog018_1.d_data4 = 'abc60';
      Testlog018_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog18> Testlog018_AllRtn = await db.selectAllData(Testlog018_1);
      int count = Testlog018_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog018_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog18 Testlog018_2 = CDataLog18();
      //Keyの値を設定する
      Testlog018_2.serial_no = 'abc12';
      Testlog018_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog18? Testlog018_Rtn = await db.selectDataByPrimaryKey(Testlog018_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog018_Rtn == null) {
        print('\n********** 異常発生：log018_CDataLog18_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog018_Rtn?.serial_no,'abc12');
        expect(Testlog018_Rtn?.seq_no,9913);
        expect(Testlog018_Rtn?.cnct_seq_no,9914);
        expect(Testlog018_Rtn?.func_cd,9915);
        expect(Testlog018_Rtn?.func_seq_no,9916);
        expect(Testlog018_Rtn?.c_data1,'abc17');
        expect(Testlog018_Rtn?.c_data2,'abc18');
        expect(Testlog018_Rtn?.c_data3,'abc19');
        expect(Testlog018_Rtn?.c_data4,'abc20');
        expect(Testlog018_Rtn?.c_data5,'abc21');
        expect(Testlog018_Rtn?.c_data6,'abc22');
        expect(Testlog018_Rtn?.c_data7,'abc23');
        expect(Testlog018_Rtn?.c_data8,'abc24');
        expect(Testlog018_Rtn?.c_data9,'abc25');
        expect(Testlog018_Rtn?.c_data10,'abc26');
        expect(Testlog018_Rtn?.n_data1,1.227);
        expect(Testlog018_Rtn?.n_data2,1.228);
        expect(Testlog018_Rtn?.n_data3,1.229);
        expect(Testlog018_Rtn?.n_data4,1.230);
        expect(Testlog018_Rtn?.n_data5,1.231);
        expect(Testlog018_Rtn?.n_data6,1.232);
        expect(Testlog018_Rtn?.n_data7,1.233);
        expect(Testlog018_Rtn?.n_data8,1.234);
        expect(Testlog018_Rtn?.n_data9,1.235);
        expect(Testlog018_Rtn?.n_data10,1.236);
        expect(Testlog018_Rtn?.n_data11,1.237);
        expect(Testlog018_Rtn?.n_data12,1.238);
        expect(Testlog018_Rtn?.n_data13,1.239);
        expect(Testlog018_Rtn?.n_data14,1.240);
        expect(Testlog018_Rtn?.n_data15,1.241);
        expect(Testlog018_Rtn?.n_data16,1.242);
        expect(Testlog018_Rtn?.n_data17,1.243);
        expect(Testlog018_Rtn?.n_data18,1.244);
        expect(Testlog018_Rtn?.n_data19,1.245);
        expect(Testlog018_Rtn?.n_data20,1.246);
        expect(Testlog018_Rtn?.n_data21,1.247);
        expect(Testlog018_Rtn?.n_data22,1.248);
        expect(Testlog018_Rtn?.n_data23,1.249);
        expect(Testlog018_Rtn?.n_data24,1.250);
        expect(Testlog018_Rtn?.n_data25,1.251);
        expect(Testlog018_Rtn?.n_data26,1.252);
        expect(Testlog018_Rtn?.n_data27,1.253);
        expect(Testlog018_Rtn?.n_data28,1.254);
        expect(Testlog018_Rtn?.n_data29,1.255);
        expect(Testlog018_Rtn?.n_data30,1.256);
        expect(Testlog018_Rtn?.d_data1,'abc57');
        expect(Testlog018_Rtn?.d_data2,'abc58');
        expect(Testlog018_Rtn?.d_data3,'abc59');
        expect(Testlog018_Rtn?.d_data4,'abc60');
        expect(Testlog018_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog18> Testlog018_AllRtn2 = await db.selectAllData(Testlog018_1);
      int count2 = Testlog018_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog018_1);
      print('********** テスト終了：log018_CDataLog18_01 **********\n\n');
    });

    // ********************************************************
    // テストlog019 : CDataLog19
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log019_CDataLog19_01', () async {
      print('\n********** テスト実行：log019_CDataLog19_01 **********');
      CDataLog19 Testlog019_1 = CDataLog19();
      Testlog019_1.serial_no = 'abc12';
      Testlog019_1.seq_no = 9913;
      Testlog019_1.cnct_seq_no = 9914;
      Testlog019_1.func_cd = 9915;
      Testlog019_1.func_seq_no = 9916;
      Testlog019_1.c_data1 = 'abc17';
      Testlog019_1.c_data2 = 'abc18';
      Testlog019_1.c_data3 = 'abc19';
      Testlog019_1.c_data4 = 'abc20';
      Testlog019_1.c_data5 = 'abc21';
      Testlog019_1.c_data6 = 'abc22';
      Testlog019_1.c_data7 = 'abc23';
      Testlog019_1.c_data8 = 'abc24';
      Testlog019_1.c_data9 = 'abc25';
      Testlog019_1.c_data10 = 'abc26';
      Testlog019_1.n_data1 = 1.227;
      Testlog019_1.n_data2 = 1.228;
      Testlog019_1.n_data3 = 1.229;
      Testlog019_1.n_data4 = 1.230;
      Testlog019_1.n_data5 = 1.231;
      Testlog019_1.n_data6 = 1.232;
      Testlog019_1.n_data7 = 1.233;
      Testlog019_1.n_data8 = 1.234;
      Testlog019_1.n_data9 = 1.235;
      Testlog019_1.n_data10 = 1.236;
      Testlog019_1.n_data11 = 1.237;
      Testlog019_1.n_data12 = 1.238;
      Testlog019_1.n_data13 = 1.239;
      Testlog019_1.n_data14 = 1.240;
      Testlog019_1.n_data15 = 1.241;
      Testlog019_1.n_data16 = 1.242;
      Testlog019_1.n_data17 = 1.243;
      Testlog019_1.n_data18 = 1.244;
      Testlog019_1.n_data19 = 1.245;
      Testlog019_1.n_data20 = 1.246;
      Testlog019_1.n_data21 = 1.247;
      Testlog019_1.n_data22 = 1.248;
      Testlog019_1.n_data23 = 1.249;
      Testlog019_1.n_data24 = 1.250;
      Testlog019_1.n_data25 = 1.251;
      Testlog019_1.n_data26 = 1.252;
      Testlog019_1.n_data27 = 1.253;
      Testlog019_1.n_data28 = 1.254;
      Testlog019_1.n_data29 = 1.255;
      Testlog019_1.n_data30 = 1.256;
      Testlog019_1.d_data1 = 'abc57';
      Testlog019_1.d_data2 = 'abc58';
      Testlog019_1.d_data3 = 'abc59';
      Testlog019_1.d_data4 = 'abc60';
      Testlog019_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog19> Testlog019_AllRtn = await db.selectAllData(Testlog019_1);
      int count = Testlog019_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog019_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog19 Testlog019_2 = CDataLog19();
      //Keyの値を設定する
      Testlog019_2.serial_no = 'abc12';
      Testlog019_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog19? Testlog019_Rtn = await db.selectDataByPrimaryKey(Testlog019_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog019_Rtn == null) {
        print('\n********** 異常発生：log019_CDataLog19_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog019_Rtn?.serial_no,'abc12');
        expect(Testlog019_Rtn?.seq_no,9913);
        expect(Testlog019_Rtn?.cnct_seq_no,9914);
        expect(Testlog019_Rtn?.func_cd,9915);
        expect(Testlog019_Rtn?.func_seq_no,9916);
        expect(Testlog019_Rtn?.c_data1,'abc17');
        expect(Testlog019_Rtn?.c_data2,'abc18');
        expect(Testlog019_Rtn?.c_data3,'abc19');
        expect(Testlog019_Rtn?.c_data4,'abc20');
        expect(Testlog019_Rtn?.c_data5,'abc21');
        expect(Testlog019_Rtn?.c_data6,'abc22');
        expect(Testlog019_Rtn?.c_data7,'abc23');
        expect(Testlog019_Rtn?.c_data8,'abc24');
        expect(Testlog019_Rtn?.c_data9,'abc25');
        expect(Testlog019_Rtn?.c_data10,'abc26');
        expect(Testlog019_Rtn?.n_data1,1.227);
        expect(Testlog019_Rtn?.n_data2,1.228);
        expect(Testlog019_Rtn?.n_data3,1.229);
        expect(Testlog019_Rtn?.n_data4,1.230);
        expect(Testlog019_Rtn?.n_data5,1.231);
        expect(Testlog019_Rtn?.n_data6,1.232);
        expect(Testlog019_Rtn?.n_data7,1.233);
        expect(Testlog019_Rtn?.n_data8,1.234);
        expect(Testlog019_Rtn?.n_data9,1.235);
        expect(Testlog019_Rtn?.n_data10,1.236);
        expect(Testlog019_Rtn?.n_data11,1.237);
        expect(Testlog019_Rtn?.n_data12,1.238);
        expect(Testlog019_Rtn?.n_data13,1.239);
        expect(Testlog019_Rtn?.n_data14,1.240);
        expect(Testlog019_Rtn?.n_data15,1.241);
        expect(Testlog019_Rtn?.n_data16,1.242);
        expect(Testlog019_Rtn?.n_data17,1.243);
        expect(Testlog019_Rtn?.n_data18,1.244);
        expect(Testlog019_Rtn?.n_data19,1.245);
        expect(Testlog019_Rtn?.n_data20,1.246);
        expect(Testlog019_Rtn?.n_data21,1.247);
        expect(Testlog019_Rtn?.n_data22,1.248);
        expect(Testlog019_Rtn?.n_data23,1.249);
        expect(Testlog019_Rtn?.n_data24,1.250);
        expect(Testlog019_Rtn?.n_data25,1.251);
        expect(Testlog019_Rtn?.n_data26,1.252);
        expect(Testlog019_Rtn?.n_data27,1.253);
        expect(Testlog019_Rtn?.n_data28,1.254);
        expect(Testlog019_Rtn?.n_data29,1.255);
        expect(Testlog019_Rtn?.n_data30,1.256);
        expect(Testlog019_Rtn?.d_data1,'abc57');
        expect(Testlog019_Rtn?.d_data2,'abc58');
        expect(Testlog019_Rtn?.d_data3,'abc59');
        expect(Testlog019_Rtn?.d_data4,'abc60');
        expect(Testlog019_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog19> Testlog019_AllRtn2 = await db.selectAllData(Testlog019_1);
      int count2 = Testlog019_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog019_1);
      print('********** テスト終了：log019_CDataLog19_01 **********\n\n');
    });

    // ********************************************************
    // テストlog020 : CDataLog20
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log020_CDataLog20_01', () async {
      print('\n********** テスト実行：log020_CDataLog20_01 **********');
      CDataLog20 Testlog020_1 = CDataLog20();
      Testlog020_1.serial_no = 'abc12';
      Testlog020_1.seq_no = 9913;
      Testlog020_1.cnct_seq_no = 9914;
      Testlog020_1.func_cd = 9915;
      Testlog020_1.func_seq_no = 9916;
      Testlog020_1.c_data1 = 'abc17';
      Testlog020_1.c_data2 = 'abc18';
      Testlog020_1.c_data3 = 'abc19';
      Testlog020_1.c_data4 = 'abc20';
      Testlog020_1.c_data5 = 'abc21';
      Testlog020_1.c_data6 = 'abc22';
      Testlog020_1.c_data7 = 'abc23';
      Testlog020_1.c_data8 = 'abc24';
      Testlog020_1.c_data9 = 'abc25';
      Testlog020_1.c_data10 = 'abc26';
      Testlog020_1.n_data1 = 1.227;
      Testlog020_1.n_data2 = 1.228;
      Testlog020_1.n_data3 = 1.229;
      Testlog020_1.n_data4 = 1.230;
      Testlog020_1.n_data5 = 1.231;
      Testlog020_1.n_data6 = 1.232;
      Testlog020_1.n_data7 = 1.233;
      Testlog020_1.n_data8 = 1.234;
      Testlog020_1.n_data9 = 1.235;
      Testlog020_1.n_data10 = 1.236;
      Testlog020_1.n_data11 = 1.237;
      Testlog020_1.n_data12 = 1.238;
      Testlog020_1.n_data13 = 1.239;
      Testlog020_1.n_data14 = 1.240;
      Testlog020_1.n_data15 = 1.241;
      Testlog020_1.n_data16 = 1.242;
      Testlog020_1.n_data17 = 1.243;
      Testlog020_1.n_data18 = 1.244;
      Testlog020_1.n_data19 = 1.245;
      Testlog020_1.n_data20 = 1.246;
      Testlog020_1.n_data21 = 1.247;
      Testlog020_1.n_data22 = 1.248;
      Testlog020_1.n_data23 = 1.249;
      Testlog020_1.n_data24 = 1.250;
      Testlog020_1.n_data25 = 1.251;
      Testlog020_1.n_data26 = 1.252;
      Testlog020_1.n_data27 = 1.253;
      Testlog020_1.n_data28 = 1.254;
      Testlog020_1.n_data29 = 1.255;
      Testlog020_1.n_data30 = 1.256;
      Testlog020_1.d_data1 = 'abc57';
      Testlog020_1.d_data2 = 'abc58';
      Testlog020_1.d_data3 = 'abc59';
      Testlog020_1.d_data4 = 'abc60';
      Testlog020_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog20> Testlog020_AllRtn = await db.selectAllData(Testlog020_1);
      int count = Testlog020_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog020_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog20 Testlog020_2 = CDataLog20();
      //Keyの値を設定する
      Testlog020_2.serial_no = 'abc12';
      Testlog020_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog20? Testlog020_Rtn = await db.selectDataByPrimaryKey(Testlog020_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog020_Rtn == null) {
        print('\n********** 異常発生：log020_CDataLog20_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog020_Rtn?.serial_no,'abc12');
        expect(Testlog020_Rtn?.seq_no,9913);
        expect(Testlog020_Rtn?.cnct_seq_no,9914);
        expect(Testlog020_Rtn?.func_cd,9915);
        expect(Testlog020_Rtn?.func_seq_no,9916);
        expect(Testlog020_Rtn?.c_data1,'abc17');
        expect(Testlog020_Rtn?.c_data2,'abc18');
        expect(Testlog020_Rtn?.c_data3,'abc19');
        expect(Testlog020_Rtn?.c_data4,'abc20');
        expect(Testlog020_Rtn?.c_data5,'abc21');
        expect(Testlog020_Rtn?.c_data6,'abc22');
        expect(Testlog020_Rtn?.c_data7,'abc23');
        expect(Testlog020_Rtn?.c_data8,'abc24');
        expect(Testlog020_Rtn?.c_data9,'abc25');
        expect(Testlog020_Rtn?.c_data10,'abc26');
        expect(Testlog020_Rtn?.n_data1,1.227);
        expect(Testlog020_Rtn?.n_data2,1.228);
        expect(Testlog020_Rtn?.n_data3,1.229);
        expect(Testlog020_Rtn?.n_data4,1.230);
        expect(Testlog020_Rtn?.n_data5,1.231);
        expect(Testlog020_Rtn?.n_data6,1.232);
        expect(Testlog020_Rtn?.n_data7,1.233);
        expect(Testlog020_Rtn?.n_data8,1.234);
        expect(Testlog020_Rtn?.n_data9,1.235);
        expect(Testlog020_Rtn?.n_data10,1.236);
        expect(Testlog020_Rtn?.n_data11,1.237);
        expect(Testlog020_Rtn?.n_data12,1.238);
        expect(Testlog020_Rtn?.n_data13,1.239);
        expect(Testlog020_Rtn?.n_data14,1.240);
        expect(Testlog020_Rtn?.n_data15,1.241);
        expect(Testlog020_Rtn?.n_data16,1.242);
        expect(Testlog020_Rtn?.n_data17,1.243);
        expect(Testlog020_Rtn?.n_data18,1.244);
        expect(Testlog020_Rtn?.n_data19,1.245);
        expect(Testlog020_Rtn?.n_data20,1.246);
        expect(Testlog020_Rtn?.n_data21,1.247);
        expect(Testlog020_Rtn?.n_data22,1.248);
        expect(Testlog020_Rtn?.n_data23,1.249);
        expect(Testlog020_Rtn?.n_data24,1.250);
        expect(Testlog020_Rtn?.n_data25,1.251);
        expect(Testlog020_Rtn?.n_data26,1.252);
        expect(Testlog020_Rtn?.n_data27,1.253);
        expect(Testlog020_Rtn?.n_data28,1.254);
        expect(Testlog020_Rtn?.n_data29,1.255);
        expect(Testlog020_Rtn?.n_data30,1.256);
        expect(Testlog020_Rtn?.d_data1,'abc57');
        expect(Testlog020_Rtn?.d_data2,'abc58');
        expect(Testlog020_Rtn?.d_data3,'abc59');
        expect(Testlog020_Rtn?.d_data4,'abc60');
        expect(Testlog020_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog20> Testlog020_AllRtn2 = await db.selectAllData(Testlog020_1);
      int count2 = Testlog020_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog020_1);
      print('********** テスト終了：log020_CDataLog20_01 **********\n\n');
    });

    // ********************************************************
    // テストlog021 : CDataLog21
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log021_CDataLog21_01', () async {
      print('\n********** テスト実行：log021_CDataLog21_01 **********');
      CDataLog21 Testlog021_1 = CDataLog21();
      Testlog021_1.serial_no = 'abc12';
      Testlog021_1.seq_no = 9913;
      Testlog021_1.cnct_seq_no = 9914;
      Testlog021_1.func_cd = 9915;
      Testlog021_1.func_seq_no = 9916;
      Testlog021_1.c_data1 = 'abc17';
      Testlog021_1.c_data2 = 'abc18';
      Testlog021_1.c_data3 = 'abc19';
      Testlog021_1.c_data4 = 'abc20';
      Testlog021_1.c_data5 = 'abc21';
      Testlog021_1.c_data6 = 'abc22';
      Testlog021_1.c_data7 = 'abc23';
      Testlog021_1.c_data8 = 'abc24';
      Testlog021_1.c_data9 = 'abc25';
      Testlog021_1.c_data10 = 'abc26';
      Testlog021_1.n_data1 = 1.227;
      Testlog021_1.n_data2 = 1.228;
      Testlog021_1.n_data3 = 1.229;
      Testlog021_1.n_data4 = 1.230;
      Testlog021_1.n_data5 = 1.231;
      Testlog021_1.n_data6 = 1.232;
      Testlog021_1.n_data7 = 1.233;
      Testlog021_1.n_data8 = 1.234;
      Testlog021_1.n_data9 = 1.235;
      Testlog021_1.n_data10 = 1.236;
      Testlog021_1.n_data11 = 1.237;
      Testlog021_1.n_data12 = 1.238;
      Testlog021_1.n_data13 = 1.239;
      Testlog021_1.n_data14 = 1.240;
      Testlog021_1.n_data15 = 1.241;
      Testlog021_1.n_data16 = 1.242;
      Testlog021_1.n_data17 = 1.243;
      Testlog021_1.n_data18 = 1.244;
      Testlog021_1.n_data19 = 1.245;
      Testlog021_1.n_data20 = 1.246;
      Testlog021_1.n_data21 = 1.247;
      Testlog021_1.n_data22 = 1.248;
      Testlog021_1.n_data23 = 1.249;
      Testlog021_1.n_data24 = 1.250;
      Testlog021_1.n_data25 = 1.251;
      Testlog021_1.n_data26 = 1.252;
      Testlog021_1.n_data27 = 1.253;
      Testlog021_1.n_data28 = 1.254;
      Testlog021_1.n_data29 = 1.255;
      Testlog021_1.n_data30 = 1.256;
      Testlog021_1.d_data1 = 'abc57';
      Testlog021_1.d_data2 = 'abc58';
      Testlog021_1.d_data3 = 'abc59';
      Testlog021_1.d_data4 = 'abc60';
      Testlog021_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog21> Testlog021_AllRtn = await db.selectAllData(Testlog021_1);
      int count = Testlog021_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog021_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog21 Testlog021_2 = CDataLog21();
      //Keyの値を設定する
      Testlog021_2.serial_no = 'abc12';
      Testlog021_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog21? Testlog021_Rtn = await db.selectDataByPrimaryKey(Testlog021_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog021_Rtn == null) {
        print('\n********** 異常発生：log021_CDataLog21_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog021_Rtn?.serial_no,'abc12');
        expect(Testlog021_Rtn?.seq_no,9913);
        expect(Testlog021_Rtn?.cnct_seq_no,9914);
        expect(Testlog021_Rtn?.func_cd,9915);
        expect(Testlog021_Rtn?.func_seq_no,9916);
        expect(Testlog021_Rtn?.c_data1,'abc17');
        expect(Testlog021_Rtn?.c_data2,'abc18');
        expect(Testlog021_Rtn?.c_data3,'abc19');
        expect(Testlog021_Rtn?.c_data4,'abc20');
        expect(Testlog021_Rtn?.c_data5,'abc21');
        expect(Testlog021_Rtn?.c_data6,'abc22');
        expect(Testlog021_Rtn?.c_data7,'abc23');
        expect(Testlog021_Rtn?.c_data8,'abc24');
        expect(Testlog021_Rtn?.c_data9,'abc25');
        expect(Testlog021_Rtn?.c_data10,'abc26');
        expect(Testlog021_Rtn?.n_data1,1.227);
        expect(Testlog021_Rtn?.n_data2,1.228);
        expect(Testlog021_Rtn?.n_data3,1.229);
        expect(Testlog021_Rtn?.n_data4,1.230);
        expect(Testlog021_Rtn?.n_data5,1.231);
        expect(Testlog021_Rtn?.n_data6,1.232);
        expect(Testlog021_Rtn?.n_data7,1.233);
        expect(Testlog021_Rtn?.n_data8,1.234);
        expect(Testlog021_Rtn?.n_data9,1.235);
        expect(Testlog021_Rtn?.n_data10,1.236);
        expect(Testlog021_Rtn?.n_data11,1.237);
        expect(Testlog021_Rtn?.n_data12,1.238);
        expect(Testlog021_Rtn?.n_data13,1.239);
        expect(Testlog021_Rtn?.n_data14,1.240);
        expect(Testlog021_Rtn?.n_data15,1.241);
        expect(Testlog021_Rtn?.n_data16,1.242);
        expect(Testlog021_Rtn?.n_data17,1.243);
        expect(Testlog021_Rtn?.n_data18,1.244);
        expect(Testlog021_Rtn?.n_data19,1.245);
        expect(Testlog021_Rtn?.n_data20,1.246);
        expect(Testlog021_Rtn?.n_data21,1.247);
        expect(Testlog021_Rtn?.n_data22,1.248);
        expect(Testlog021_Rtn?.n_data23,1.249);
        expect(Testlog021_Rtn?.n_data24,1.250);
        expect(Testlog021_Rtn?.n_data25,1.251);
        expect(Testlog021_Rtn?.n_data26,1.252);
        expect(Testlog021_Rtn?.n_data27,1.253);
        expect(Testlog021_Rtn?.n_data28,1.254);
        expect(Testlog021_Rtn?.n_data29,1.255);
        expect(Testlog021_Rtn?.n_data30,1.256);
        expect(Testlog021_Rtn?.d_data1,'abc57');
        expect(Testlog021_Rtn?.d_data2,'abc58');
        expect(Testlog021_Rtn?.d_data3,'abc59');
        expect(Testlog021_Rtn?.d_data4,'abc60');
        expect(Testlog021_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog21> Testlog021_AllRtn2 = await db.selectAllData(Testlog021_1);
      int count2 = Testlog021_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog021_1);
      print('********** テスト終了：log021_CDataLog21_01 **********\n\n');
    });

    // ********************************************************
    // テストlog022 : CDataLog22
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log022_CDataLog22_01', () async {
      print('\n********** テスト実行：log022_CDataLog22_01 **********');
      CDataLog22 Testlog022_1 = CDataLog22();
      Testlog022_1.serial_no = 'abc12';
      Testlog022_1.seq_no = 9913;
      Testlog022_1.cnct_seq_no = 9914;
      Testlog022_1.func_cd = 9915;
      Testlog022_1.func_seq_no = 9916;
      Testlog022_1.c_data1 = 'abc17';
      Testlog022_1.c_data2 = 'abc18';
      Testlog022_1.c_data3 = 'abc19';
      Testlog022_1.c_data4 = 'abc20';
      Testlog022_1.c_data5 = 'abc21';
      Testlog022_1.c_data6 = 'abc22';
      Testlog022_1.c_data7 = 'abc23';
      Testlog022_1.c_data8 = 'abc24';
      Testlog022_1.c_data9 = 'abc25';
      Testlog022_1.c_data10 = 'abc26';
      Testlog022_1.n_data1 = 1.227;
      Testlog022_1.n_data2 = 1.228;
      Testlog022_1.n_data3 = 1.229;
      Testlog022_1.n_data4 = 1.230;
      Testlog022_1.n_data5 = 1.231;
      Testlog022_1.n_data6 = 1.232;
      Testlog022_1.n_data7 = 1.233;
      Testlog022_1.n_data8 = 1.234;
      Testlog022_1.n_data9 = 1.235;
      Testlog022_1.n_data10 = 1.236;
      Testlog022_1.n_data11 = 1.237;
      Testlog022_1.n_data12 = 1.238;
      Testlog022_1.n_data13 = 1.239;
      Testlog022_1.n_data14 = 1.240;
      Testlog022_1.n_data15 = 1.241;
      Testlog022_1.n_data16 = 1.242;
      Testlog022_1.n_data17 = 1.243;
      Testlog022_1.n_data18 = 1.244;
      Testlog022_1.n_data19 = 1.245;
      Testlog022_1.n_data20 = 1.246;
      Testlog022_1.n_data21 = 1.247;
      Testlog022_1.n_data22 = 1.248;
      Testlog022_1.n_data23 = 1.249;
      Testlog022_1.n_data24 = 1.250;
      Testlog022_1.n_data25 = 1.251;
      Testlog022_1.n_data26 = 1.252;
      Testlog022_1.n_data27 = 1.253;
      Testlog022_1.n_data28 = 1.254;
      Testlog022_1.n_data29 = 1.255;
      Testlog022_1.n_data30 = 1.256;
      Testlog022_1.d_data1 = 'abc57';
      Testlog022_1.d_data2 = 'abc58';
      Testlog022_1.d_data3 = 'abc59';
      Testlog022_1.d_data4 = 'abc60';
      Testlog022_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog22> Testlog022_AllRtn = await db.selectAllData(Testlog022_1);
      int count = Testlog022_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog022_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog22 Testlog022_2 = CDataLog22();
      //Keyの値を設定する
      Testlog022_2.serial_no = 'abc12';
      Testlog022_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog22? Testlog022_Rtn = await db.selectDataByPrimaryKey(Testlog022_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog022_Rtn == null) {
        print('\n********** 異常発生：log022_CDataLog22_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog022_Rtn?.serial_no,'abc12');
        expect(Testlog022_Rtn?.seq_no,9913);
        expect(Testlog022_Rtn?.cnct_seq_no,9914);
        expect(Testlog022_Rtn?.func_cd,9915);
        expect(Testlog022_Rtn?.func_seq_no,9916);
        expect(Testlog022_Rtn?.c_data1,'abc17');
        expect(Testlog022_Rtn?.c_data2,'abc18');
        expect(Testlog022_Rtn?.c_data3,'abc19');
        expect(Testlog022_Rtn?.c_data4,'abc20');
        expect(Testlog022_Rtn?.c_data5,'abc21');
        expect(Testlog022_Rtn?.c_data6,'abc22');
        expect(Testlog022_Rtn?.c_data7,'abc23');
        expect(Testlog022_Rtn?.c_data8,'abc24');
        expect(Testlog022_Rtn?.c_data9,'abc25');
        expect(Testlog022_Rtn?.c_data10,'abc26');
        expect(Testlog022_Rtn?.n_data1,1.227);
        expect(Testlog022_Rtn?.n_data2,1.228);
        expect(Testlog022_Rtn?.n_data3,1.229);
        expect(Testlog022_Rtn?.n_data4,1.230);
        expect(Testlog022_Rtn?.n_data5,1.231);
        expect(Testlog022_Rtn?.n_data6,1.232);
        expect(Testlog022_Rtn?.n_data7,1.233);
        expect(Testlog022_Rtn?.n_data8,1.234);
        expect(Testlog022_Rtn?.n_data9,1.235);
        expect(Testlog022_Rtn?.n_data10,1.236);
        expect(Testlog022_Rtn?.n_data11,1.237);
        expect(Testlog022_Rtn?.n_data12,1.238);
        expect(Testlog022_Rtn?.n_data13,1.239);
        expect(Testlog022_Rtn?.n_data14,1.240);
        expect(Testlog022_Rtn?.n_data15,1.241);
        expect(Testlog022_Rtn?.n_data16,1.242);
        expect(Testlog022_Rtn?.n_data17,1.243);
        expect(Testlog022_Rtn?.n_data18,1.244);
        expect(Testlog022_Rtn?.n_data19,1.245);
        expect(Testlog022_Rtn?.n_data20,1.246);
        expect(Testlog022_Rtn?.n_data21,1.247);
        expect(Testlog022_Rtn?.n_data22,1.248);
        expect(Testlog022_Rtn?.n_data23,1.249);
        expect(Testlog022_Rtn?.n_data24,1.250);
        expect(Testlog022_Rtn?.n_data25,1.251);
        expect(Testlog022_Rtn?.n_data26,1.252);
        expect(Testlog022_Rtn?.n_data27,1.253);
        expect(Testlog022_Rtn?.n_data28,1.254);
        expect(Testlog022_Rtn?.n_data29,1.255);
        expect(Testlog022_Rtn?.n_data30,1.256);
        expect(Testlog022_Rtn?.d_data1,'abc57');
        expect(Testlog022_Rtn?.d_data2,'abc58');
        expect(Testlog022_Rtn?.d_data3,'abc59');
        expect(Testlog022_Rtn?.d_data4,'abc60');
        expect(Testlog022_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog22> Testlog022_AllRtn2 = await db.selectAllData(Testlog022_1);
      int count2 = Testlog022_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog022_1);
      print('********** テスト終了：log022_CDataLog22_01 **********\n\n');
    });

    // ********************************************************
    // テストlog023 : CDataLog23
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log023_CDataLog23_01', () async {
      print('\n********** テスト実行：log023_CDataLog23_01 **********');
      CDataLog23 Testlog023_1 = CDataLog23();
      Testlog023_1.serial_no = 'abc12';
      Testlog023_1.seq_no = 9913;
      Testlog023_1.cnct_seq_no = 9914;
      Testlog023_1.func_cd = 9915;
      Testlog023_1.func_seq_no = 9916;
      Testlog023_1.c_data1 = 'abc17';
      Testlog023_1.c_data2 = 'abc18';
      Testlog023_1.c_data3 = 'abc19';
      Testlog023_1.c_data4 = 'abc20';
      Testlog023_1.c_data5 = 'abc21';
      Testlog023_1.c_data6 = 'abc22';
      Testlog023_1.c_data7 = 'abc23';
      Testlog023_1.c_data8 = 'abc24';
      Testlog023_1.c_data9 = 'abc25';
      Testlog023_1.c_data10 = 'abc26';
      Testlog023_1.n_data1 = 1.227;
      Testlog023_1.n_data2 = 1.228;
      Testlog023_1.n_data3 = 1.229;
      Testlog023_1.n_data4 = 1.230;
      Testlog023_1.n_data5 = 1.231;
      Testlog023_1.n_data6 = 1.232;
      Testlog023_1.n_data7 = 1.233;
      Testlog023_1.n_data8 = 1.234;
      Testlog023_1.n_data9 = 1.235;
      Testlog023_1.n_data10 = 1.236;
      Testlog023_1.n_data11 = 1.237;
      Testlog023_1.n_data12 = 1.238;
      Testlog023_1.n_data13 = 1.239;
      Testlog023_1.n_data14 = 1.240;
      Testlog023_1.n_data15 = 1.241;
      Testlog023_1.n_data16 = 1.242;
      Testlog023_1.n_data17 = 1.243;
      Testlog023_1.n_data18 = 1.244;
      Testlog023_1.n_data19 = 1.245;
      Testlog023_1.n_data20 = 1.246;
      Testlog023_1.n_data21 = 1.247;
      Testlog023_1.n_data22 = 1.248;
      Testlog023_1.n_data23 = 1.249;
      Testlog023_1.n_data24 = 1.250;
      Testlog023_1.n_data25 = 1.251;
      Testlog023_1.n_data26 = 1.252;
      Testlog023_1.n_data27 = 1.253;
      Testlog023_1.n_data28 = 1.254;
      Testlog023_1.n_data29 = 1.255;
      Testlog023_1.n_data30 = 1.256;
      Testlog023_1.d_data1 = 'abc57';
      Testlog023_1.d_data2 = 'abc58';
      Testlog023_1.d_data3 = 'abc59';
      Testlog023_1.d_data4 = 'abc60';
      Testlog023_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog23> Testlog023_AllRtn = await db.selectAllData(Testlog023_1);
      int count = Testlog023_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog023_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog23 Testlog023_2 = CDataLog23();
      //Keyの値を設定する
      Testlog023_2.serial_no = 'abc12';
      Testlog023_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog23? Testlog023_Rtn = await db.selectDataByPrimaryKey(Testlog023_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog023_Rtn == null) {
        print('\n********** 異常発生：log023_CDataLog23_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog023_Rtn?.serial_no,'abc12');
        expect(Testlog023_Rtn?.seq_no,9913);
        expect(Testlog023_Rtn?.cnct_seq_no,9914);
        expect(Testlog023_Rtn?.func_cd,9915);
        expect(Testlog023_Rtn?.func_seq_no,9916);
        expect(Testlog023_Rtn?.c_data1,'abc17');
        expect(Testlog023_Rtn?.c_data2,'abc18');
        expect(Testlog023_Rtn?.c_data3,'abc19');
        expect(Testlog023_Rtn?.c_data4,'abc20');
        expect(Testlog023_Rtn?.c_data5,'abc21');
        expect(Testlog023_Rtn?.c_data6,'abc22');
        expect(Testlog023_Rtn?.c_data7,'abc23');
        expect(Testlog023_Rtn?.c_data8,'abc24');
        expect(Testlog023_Rtn?.c_data9,'abc25');
        expect(Testlog023_Rtn?.c_data10,'abc26');
        expect(Testlog023_Rtn?.n_data1,1.227);
        expect(Testlog023_Rtn?.n_data2,1.228);
        expect(Testlog023_Rtn?.n_data3,1.229);
        expect(Testlog023_Rtn?.n_data4,1.230);
        expect(Testlog023_Rtn?.n_data5,1.231);
        expect(Testlog023_Rtn?.n_data6,1.232);
        expect(Testlog023_Rtn?.n_data7,1.233);
        expect(Testlog023_Rtn?.n_data8,1.234);
        expect(Testlog023_Rtn?.n_data9,1.235);
        expect(Testlog023_Rtn?.n_data10,1.236);
        expect(Testlog023_Rtn?.n_data11,1.237);
        expect(Testlog023_Rtn?.n_data12,1.238);
        expect(Testlog023_Rtn?.n_data13,1.239);
        expect(Testlog023_Rtn?.n_data14,1.240);
        expect(Testlog023_Rtn?.n_data15,1.241);
        expect(Testlog023_Rtn?.n_data16,1.242);
        expect(Testlog023_Rtn?.n_data17,1.243);
        expect(Testlog023_Rtn?.n_data18,1.244);
        expect(Testlog023_Rtn?.n_data19,1.245);
        expect(Testlog023_Rtn?.n_data20,1.246);
        expect(Testlog023_Rtn?.n_data21,1.247);
        expect(Testlog023_Rtn?.n_data22,1.248);
        expect(Testlog023_Rtn?.n_data23,1.249);
        expect(Testlog023_Rtn?.n_data24,1.250);
        expect(Testlog023_Rtn?.n_data25,1.251);
        expect(Testlog023_Rtn?.n_data26,1.252);
        expect(Testlog023_Rtn?.n_data27,1.253);
        expect(Testlog023_Rtn?.n_data28,1.254);
        expect(Testlog023_Rtn?.n_data29,1.255);
        expect(Testlog023_Rtn?.n_data30,1.256);
        expect(Testlog023_Rtn?.d_data1,'abc57');
        expect(Testlog023_Rtn?.d_data2,'abc58');
        expect(Testlog023_Rtn?.d_data3,'abc59');
        expect(Testlog023_Rtn?.d_data4,'abc60');
        expect(Testlog023_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog23> Testlog023_AllRtn2 = await db.selectAllData(Testlog023_1);
      int count2 = Testlog023_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog023_1);
      print('********** テスト終了：log023_CDataLog23_01 **********\n\n');
    });

    // ********************************************************
    // テストlog024 : CDataLog24
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log024_CDataLog24_01', () async {
      print('\n********** テスト実行：log024_CDataLog24_01 **********');
      CDataLog24 Testlog024_1 = CDataLog24();
      Testlog024_1.serial_no = 'abc12';
      Testlog024_1.seq_no = 9913;
      Testlog024_1.cnct_seq_no = 9914;
      Testlog024_1.func_cd = 9915;
      Testlog024_1.func_seq_no = 9916;
      Testlog024_1.c_data1 = 'abc17';
      Testlog024_1.c_data2 = 'abc18';
      Testlog024_1.c_data3 = 'abc19';
      Testlog024_1.c_data4 = 'abc20';
      Testlog024_1.c_data5 = 'abc21';
      Testlog024_1.c_data6 = 'abc22';
      Testlog024_1.c_data7 = 'abc23';
      Testlog024_1.c_data8 = 'abc24';
      Testlog024_1.c_data9 = 'abc25';
      Testlog024_1.c_data10 = 'abc26';
      Testlog024_1.n_data1 = 1.227;
      Testlog024_1.n_data2 = 1.228;
      Testlog024_1.n_data3 = 1.229;
      Testlog024_1.n_data4 = 1.230;
      Testlog024_1.n_data5 = 1.231;
      Testlog024_1.n_data6 = 1.232;
      Testlog024_1.n_data7 = 1.233;
      Testlog024_1.n_data8 = 1.234;
      Testlog024_1.n_data9 = 1.235;
      Testlog024_1.n_data10 = 1.236;
      Testlog024_1.n_data11 = 1.237;
      Testlog024_1.n_data12 = 1.238;
      Testlog024_1.n_data13 = 1.239;
      Testlog024_1.n_data14 = 1.240;
      Testlog024_1.n_data15 = 1.241;
      Testlog024_1.n_data16 = 1.242;
      Testlog024_1.n_data17 = 1.243;
      Testlog024_1.n_data18 = 1.244;
      Testlog024_1.n_data19 = 1.245;
      Testlog024_1.n_data20 = 1.246;
      Testlog024_1.n_data21 = 1.247;
      Testlog024_1.n_data22 = 1.248;
      Testlog024_1.n_data23 = 1.249;
      Testlog024_1.n_data24 = 1.250;
      Testlog024_1.n_data25 = 1.251;
      Testlog024_1.n_data26 = 1.252;
      Testlog024_1.n_data27 = 1.253;
      Testlog024_1.n_data28 = 1.254;
      Testlog024_1.n_data29 = 1.255;
      Testlog024_1.n_data30 = 1.256;
      Testlog024_1.d_data1 = 'abc57';
      Testlog024_1.d_data2 = 'abc58';
      Testlog024_1.d_data3 = 'abc59';
      Testlog024_1.d_data4 = 'abc60';
      Testlog024_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog24> Testlog024_AllRtn = await db.selectAllData(Testlog024_1);
      int count = Testlog024_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog024_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog24 Testlog024_2 = CDataLog24();
      //Keyの値を設定する
      Testlog024_2.serial_no = 'abc12';
      Testlog024_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog24? Testlog024_Rtn = await db.selectDataByPrimaryKey(Testlog024_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog024_Rtn == null) {
        print('\n********** 異常発生：log024_CDataLog24_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog024_Rtn?.serial_no,'abc12');
        expect(Testlog024_Rtn?.seq_no,9913);
        expect(Testlog024_Rtn?.cnct_seq_no,9914);
        expect(Testlog024_Rtn?.func_cd,9915);
        expect(Testlog024_Rtn?.func_seq_no,9916);
        expect(Testlog024_Rtn?.c_data1,'abc17');
        expect(Testlog024_Rtn?.c_data2,'abc18');
        expect(Testlog024_Rtn?.c_data3,'abc19');
        expect(Testlog024_Rtn?.c_data4,'abc20');
        expect(Testlog024_Rtn?.c_data5,'abc21');
        expect(Testlog024_Rtn?.c_data6,'abc22');
        expect(Testlog024_Rtn?.c_data7,'abc23');
        expect(Testlog024_Rtn?.c_data8,'abc24');
        expect(Testlog024_Rtn?.c_data9,'abc25');
        expect(Testlog024_Rtn?.c_data10,'abc26');
        expect(Testlog024_Rtn?.n_data1,1.227);
        expect(Testlog024_Rtn?.n_data2,1.228);
        expect(Testlog024_Rtn?.n_data3,1.229);
        expect(Testlog024_Rtn?.n_data4,1.230);
        expect(Testlog024_Rtn?.n_data5,1.231);
        expect(Testlog024_Rtn?.n_data6,1.232);
        expect(Testlog024_Rtn?.n_data7,1.233);
        expect(Testlog024_Rtn?.n_data8,1.234);
        expect(Testlog024_Rtn?.n_data9,1.235);
        expect(Testlog024_Rtn?.n_data10,1.236);
        expect(Testlog024_Rtn?.n_data11,1.237);
        expect(Testlog024_Rtn?.n_data12,1.238);
        expect(Testlog024_Rtn?.n_data13,1.239);
        expect(Testlog024_Rtn?.n_data14,1.240);
        expect(Testlog024_Rtn?.n_data15,1.241);
        expect(Testlog024_Rtn?.n_data16,1.242);
        expect(Testlog024_Rtn?.n_data17,1.243);
        expect(Testlog024_Rtn?.n_data18,1.244);
        expect(Testlog024_Rtn?.n_data19,1.245);
        expect(Testlog024_Rtn?.n_data20,1.246);
        expect(Testlog024_Rtn?.n_data21,1.247);
        expect(Testlog024_Rtn?.n_data22,1.248);
        expect(Testlog024_Rtn?.n_data23,1.249);
        expect(Testlog024_Rtn?.n_data24,1.250);
        expect(Testlog024_Rtn?.n_data25,1.251);
        expect(Testlog024_Rtn?.n_data26,1.252);
        expect(Testlog024_Rtn?.n_data27,1.253);
        expect(Testlog024_Rtn?.n_data28,1.254);
        expect(Testlog024_Rtn?.n_data29,1.255);
        expect(Testlog024_Rtn?.n_data30,1.256);
        expect(Testlog024_Rtn?.d_data1,'abc57');
        expect(Testlog024_Rtn?.d_data2,'abc58');
        expect(Testlog024_Rtn?.d_data3,'abc59');
        expect(Testlog024_Rtn?.d_data4,'abc60');
        expect(Testlog024_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog24> Testlog024_AllRtn2 = await db.selectAllData(Testlog024_1);
      int count2 = Testlog024_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog024_1);
      print('********** テスト終了：log024_CDataLog24_01 **********\n\n');
    });

    // ********************************************************
    // テストlog025 : CDataLog25
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log025_CDataLog25_01', () async {
      print('\n********** テスト実行：log025_CDataLog25_01 **********');
      CDataLog25 Testlog025_1 = CDataLog25();
      Testlog025_1.serial_no = 'abc12';
      Testlog025_1.seq_no = 9913;
      Testlog025_1.cnct_seq_no = 9914;
      Testlog025_1.func_cd = 9915;
      Testlog025_1.func_seq_no = 9916;
      Testlog025_1.c_data1 = 'abc17';
      Testlog025_1.c_data2 = 'abc18';
      Testlog025_1.c_data3 = 'abc19';
      Testlog025_1.c_data4 = 'abc20';
      Testlog025_1.c_data5 = 'abc21';
      Testlog025_1.c_data6 = 'abc22';
      Testlog025_1.c_data7 = 'abc23';
      Testlog025_1.c_data8 = 'abc24';
      Testlog025_1.c_data9 = 'abc25';
      Testlog025_1.c_data10 = 'abc26';
      Testlog025_1.n_data1 = 1.227;
      Testlog025_1.n_data2 = 1.228;
      Testlog025_1.n_data3 = 1.229;
      Testlog025_1.n_data4 = 1.230;
      Testlog025_1.n_data5 = 1.231;
      Testlog025_1.n_data6 = 1.232;
      Testlog025_1.n_data7 = 1.233;
      Testlog025_1.n_data8 = 1.234;
      Testlog025_1.n_data9 = 1.235;
      Testlog025_1.n_data10 = 1.236;
      Testlog025_1.n_data11 = 1.237;
      Testlog025_1.n_data12 = 1.238;
      Testlog025_1.n_data13 = 1.239;
      Testlog025_1.n_data14 = 1.240;
      Testlog025_1.n_data15 = 1.241;
      Testlog025_1.n_data16 = 1.242;
      Testlog025_1.n_data17 = 1.243;
      Testlog025_1.n_data18 = 1.244;
      Testlog025_1.n_data19 = 1.245;
      Testlog025_1.n_data20 = 1.246;
      Testlog025_1.n_data21 = 1.247;
      Testlog025_1.n_data22 = 1.248;
      Testlog025_1.n_data23 = 1.249;
      Testlog025_1.n_data24 = 1.250;
      Testlog025_1.n_data25 = 1.251;
      Testlog025_1.n_data26 = 1.252;
      Testlog025_1.n_data27 = 1.253;
      Testlog025_1.n_data28 = 1.254;
      Testlog025_1.n_data29 = 1.255;
      Testlog025_1.n_data30 = 1.256;
      Testlog025_1.d_data1 = 'abc57';
      Testlog025_1.d_data2 = 'abc58';
      Testlog025_1.d_data3 = 'abc59';
      Testlog025_1.d_data4 = 'abc60';
      Testlog025_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog25> Testlog025_AllRtn = await db.selectAllData(Testlog025_1);
      int count = Testlog025_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog025_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog25 Testlog025_2 = CDataLog25();
      //Keyの値を設定する
      Testlog025_2.serial_no = 'abc12';
      Testlog025_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog25? Testlog025_Rtn = await db.selectDataByPrimaryKey(Testlog025_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog025_Rtn == null) {
        print('\n********** 異常発生：log025_CDataLog25_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog025_Rtn?.serial_no,'abc12');
        expect(Testlog025_Rtn?.seq_no,9913);
        expect(Testlog025_Rtn?.cnct_seq_no,9914);
        expect(Testlog025_Rtn?.func_cd,9915);
        expect(Testlog025_Rtn?.func_seq_no,9916);
        expect(Testlog025_Rtn?.c_data1,'abc17');
        expect(Testlog025_Rtn?.c_data2,'abc18');
        expect(Testlog025_Rtn?.c_data3,'abc19');
        expect(Testlog025_Rtn?.c_data4,'abc20');
        expect(Testlog025_Rtn?.c_data5,'abc21');
        expect(Testlog025_Rtn?.c_data6,'abc22');
        expect(Testlog025_Rtn?.c_data7,'abc23');
        expect(Testlog025_Rtn?.c_data8,'abc24');
        expect(Testlog025_Rtn?.c_data9,'abc25');
        expect(Testlog025_Rtn?.c_data10,'abc26');
        expect(Testlog025_Rtn?.n_data1,1.227);
        expect(Testlog025_Rtn?.n_data2,1.228);
        expect(Testlog025_Rtn?.n_data3,1.229);
        expect(Testlog025_Rtn?.n_data4,1.230);
        expect(Testlog025_Rtn?.n_data5,1.231);
        expect(Testlog025_Rtn?.n_data6,1.232);
        expect(Testlog025_Rtn?.n_data7,1.233);
        expect(Testlog025_Rtn?.n_data8,1.234);
        expect(Testlog025_Rtn?.n_data9,1.235);
        expect(Testlog025_Rtn?.n_data10,1.236);
        expect(Testlog025_Rtn?.n_data11,1.237);
        expect(Testlog025_Rtn?.n_data12,1.238);
        expect(Testlog025_Rtn?.n_data13,1.239);
        expect(Testlog025_Rtn?.n_data14,1.240);
        expect(Testlog025_Rtn?.n_data15,1.241);
        expect(Testlog025_Rtn?.n_data16,1.242);
        expect(Testlog025_Rtn?.n_data17,1.243);
        expect(Testlog025_Rtn?.n_data18,1.244);
        expect(Testlog025_Rtn?.n_data19,1.245);
        expect(Testlog025_Rtn?.n_data20,1.246);
        expect(Testlog025_Rtn?.n_data21,1.247);
        expect(Testlog025_Rtn?.n_data22,1.248);
        expect(Testlog025_Rtn?.n_data23,1.249);
        expect(Testlog025_Rtn?.n_data24,1.250);
        expect(Testlog025_Rtn?.n_data25,1.251);
        expect(Testlog025_Rtn?.n_data26,1.252);
        expect(Testlog025_Rtn?.n_data27,1.253);
        expect(Testlog025_Rtn?.n_data28,1.254);
        expect(Testlog025_Rtn?.n_data29,1.255);
        expect(Testlog025_Rtn?.n_data30,1.256);
        expect(Testlog025_Rtn?.d_data1,'abc57');
        expect(Testlog025_Rtn?.d_data2,'abc58');
        expect(Testlog025_Rtn?.d_data3,'abc59');
        expect(Testlog025_Rtn?.d_data4,'abc60');
        expect(Testlog025_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog25> Testlog025_AllRtn2 = await db.selectAllData(Testlog025_1);
      int count2 = Testlog025_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog025_1);
      print('********** テスト終了：log025_CDataLog25_01 **********\n\n');
    });

    // ********************************************************
    // テストlog026 : CDataLog26
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log026_CDataLog26_01', () async {
      print('\n********** テスト実行：log026_CDataLog26_01 **********');
      CDataLog26 Testlog026_1 = CDataLog26();
      Testlog026_1.serial_no = 'abc12';
      Testlog026_1.seq_no = 9913;
      Testlog026_1.cnct_seq_no = 9914;
      Testlog026_1.func_cd = 9915;
      Testlog026_1.func_seq_no = 9916;
      Testlog026_1.c_data1 = 'abc17';
      Testlog026_1.c_data2 = 'abc18';
      Testlog026_1.c_data3 = 'abc19';
      Testlog026_1.c_data4 = 'abc20';
      Testlog026_1.c_data5 = 'abc21';
      Testlog026_1.c_data6 = 'abc22';
      Testlog026_1.c_data7 = 'abc23';
      Testlog026_1.c_data8 = 'abc24';
      Testlog026_1.c_data9 = 'abc25';
      Testlog026_1.c_data10 = 'abc26';
      Testlog026_1.n_data1 = 1.227;
      Testlog026_1.n_data2 = 1.228;
      Testlog026_1.n_data3 = 1.229;
      Testlog026_1.n_data4 = 1.230;
      Testlog026_1.n_data5 = 1.231;
      Testlog026_1.n_data6 = 1.232;
      Testlog026_1.n_data7 = 1.233;
      Testlog026_1.n_data8 = 1.234;
      Testlog026_1.n_data9 = 1.235;
      Testlog026_1.n_data10 = 1.236;
      Testlog026_1.n_data11 = 1.237;
      Testlog026_1.n_data12 = 1.238;
      Testlog026_1.n_data13 = 1.239;
      Testlog026_1.n_data14 = 1.240;
      Testlog026_1.n_data15 = 1.241;
      Testlog026_1.n_data16 = 1.242;
      Testlog026_1.n_data17 = 1.243;
      Testlog026_1.n_data18 = 1.244;
      Testlog026_1.n_data19 = 1.245;
      Testlog026_1.n_data20 = 1.246;
      Testlog026_1.n_data21 = 1.247;
      Testlog026_1.n_data22 = 1.248;
      Testlog026_1.n_data23 = 1.249;
      Testlog026_1.n_data24 = 1.250;
      Testlog026_1.n_data25 = 1.251;
      Testlog026_1.n_data26 = 1.252;
      Testlog026_1.n_data27 = 1.253;
      Testlog026_1.n_data28 = 1.254;
      Testlog026_1.n_data29 = 1.255;
      Testlog026_1.n_data30 = 1.256;
      Testlog026_1.d_data1 = 'abc57';
      Testlog026_1.d_data2 = 'abc58';
      Testlog026_1.d_data3 = 'abc59';
      Testlog026_1.d_data4 = 'abc60';
      Testlog026_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog26> Testlog026_AllRtn = await db.selectAllData(Testlog026_1);
      int count = Testlog026_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog026_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog26 Testlog026_2 = CDataLog26();
      //Keyの値を設定する
      Testlog026_2.serial_no = 'abc12';
      Testlog026_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog26? Testlog026_Rtn = await db.selectDataByPrimaryKey(Testlog026_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog026_Rtn == null) {
        print('\n********** 異常発生：log026_CDataLog26_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog026_Rtn?.serial_no,'abc12');
        expect(Testlog026_Rtn?.seq_no,9913);
        expect(Testlog026_Rtn?.cnct_seq_no,9914);
        expect(Testlog026_Rtn?.func_cd,9915);
        expect(Testlog026_Rtn?.func_seq_no,9916);
        expect(Testlog026_Rtn?.c_data1,'abc17');
        expect(Testlog026_Rtn?.c_data2,'abc18');
        expect(Testlog026_Rtn?.c_data3,'abc19');
        expect(Testlog026_Rtn?.c_data4,'abc20');
        expect(Testlog026_Rtn?.c_data5,'abc21');
        expect(Testlog026_Rtn?.c_data6,'abc22');
        expect(Testlog026_Rtn?.c_data7,'abc23');
        expect(Testlog026_Rtn?.c_data8,'abc24');
        expect(Testlog026_Rtn?.c_data9,'abc25');
        expect(Testlog026_Rtn?.c_data10,'abc26');
        expect(Testlog026_Rtn?.n_data1,1.227);
        expect(Testlog026_Rtn?.n_data2,1.228);
        expect(Testlog026_Rtn?.n_data3,1.229);
        expect(Testlog026_Rtn?.n_data4,1.230);
        expect(Testlog026_Rtn?.n_data5,1.231);
        expect(Testlog026_Rtn?.n_data6,1.232);
        expect(Testlog026_Rtn?.n_data7,1.233);
        expect(Testlog026_Rtn?.n_data8,1.234);
        expect(Testlog026_Rtn?.n_data9,1.235);
        expect(Testlog026_Rtn?.n_data10,1.236);
        expect(Testlog026_Rtn?.n_data11,1.237);
        expect(Testlog026_Rtn?.n_data12,1.238);
        expect(Testlog026_Rtn?.n_data13,1.239);
        expect(Testlog026_Rtn?.n_data14,1.240);
        expect(Testlog026_Rtn?.n_data15,1.241);
        expect(Testlog026_Rtn?.n_data16,1.242);
        expect(Testlog026_Rtn?.n_data17,1.243);
        expect(Testlog026_Rtn?.n_data18,1.244);
        expect(Testlog026_Rtn?.n_data19,1.245);
        expect(Testlog026_Rtn?.n_data20,1.246);
        expect(Testlog026_Rtn?.n_data21,1.247);
        expect(Testlog026_Rtn?.n_data22,1.248);
        expect(Testlog026_Rtn?.n_data23,1.249);
        expect(Testlog026_Rtn?.n_data24,1.250);
        expect(Testlog026_Rtn?.n_data25,1.251);
        expect(Testlog026_Rtn?.n_data26,1.252);
        expect(Testlog026_Rtn?.n_data27,1.253);
        expect(Testlog026_Rtn?.n_data28,1.254);
        expect(Testlog026_Rtn?.n_data29,1.255);
        expect(Testlog026_Rtn?.n_data30,1.256);
        expect(Testlog026_Rtn?.d_data1,'abc57');
        expect(Testlog026_Rtn?.d_data2,'abc58');
        expect(Testlog026_Rtn?.d_data3,'abc59');
        expect(Testlog026_Rtn?.d_data4,'abc60');
        expect(Testlog026_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog26> Testlog026_AllRtn2 = await db.selectAllData(Testlog026_1);
      int count2 = Testlog026_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog026_1);
      print('********** テスト終了：log026_CDataLog26_01 **********\n\n');
    });

    // ********************************************************
    // テストlog027 : CDataLog27
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log027_CDataLog27_01', () async {
      print('\n********** テスト実行：log027_CDataLog27_01 **********');
      CDataLog27 Testlog027_1 = CDataLog27();
      Testlog027_1.serial_no = 'abc12';
      Testlog027_1.seq_no = 9913;
      Testlog027_1.cnct_seq_no = 9914;
      Testlog027_1.func_cd = 9915;
      Testlog027_1.func_seq_no = 9916;
      Testlog027_1.c_data1 = 'abc17';
      Testlog027_1.c_data2 = 'abc18';
      Testlog027_1.c_data3 = 'abc19';
      Testlog027_1.c_data4 = 'abc20';
      Testlog027_1.c_data5 = 'abc21';
      Testlog027_1.c_data6 = 'abc22';
      Testlog027_1.c_data7 = 'abc23';
      Testlog027_1.c_data8 = 'abc24';
      Testlog027_1.c_data9 = 'abc25';
      Testlog027_1.c_data10 = 'abc26';
      Testlog027_1.n_data1 = 1.227;
      Testlog027_1.n_data2 = 1.228;
      Testlog027_1.n_data3 = 1.229;
      Testlog027_1.n_data4 = 1.230;
      Testlog027_1.n_data5 = 1.231;
      Testlog027_1.n_data6 = 1.232;
      Testlog027_1.n_data7 = 1.233;
      Testlog027_1.n_data8 = 1.234;
      Testlog027_1.n_data9 = 1.235;
      Testlog027_1.n_data10 = 1.236;
      Testlog027_1.n_data11 = 1.237;
      Testlog027_1.n_data12 = 1.238;
      Testlog027_1.n_data13 = 1.239;
      Testlog027_1.n_data14 = 1.240;
      Testlog027_1.n_data15 = 1.241;
      Testlog027_1.n_data16 = 1.242;
      Testlog027_1.n_data17 = 1.243;
      Testlog027_1.n_data18 = 1.244;
      Testlog027_1.n_data19 = 1.245;
      Testlog027_1.n_data20 = 1.246;
      Testlog027_1.n_data21 = 1.247;
      Testlog027_1.n_data22 = 1.248;
      Testlog027_1.n_data23 = 1.249;
      Testlog027_1.n_data24 = 1.250;
      Testlog027_1.n_data25 = 1.251;
      Testlog027_1.n_data26 = 1.252;
      Testlog027_1.n_data27 = 1.253;
      Testlog027_1.n_data28 = 1.254;
      Testlog027_1.n_data29 = 1.255;
      Testlog027_1.n_data30 = 1.256;
      Testlog027_1.d_data1 = 'abc57';
      Testlog027_1.d_data2 = 'abc58';
      Testlog027_1.d_data3 = 'abc59';
      Testlog027_1.d_data4 = 'abc60';
      Testlog027_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog27> Testlog027_AllRtn = await db.selectAllData(Testlog027_1);
      int count = Testlog027_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog027_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog27 Testlog027_2 = CDataLog27();
      //Keyの値を設定する
      Testlog027_2.serial_no = 'abc12';
      Testlog027_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog27? Testlog027_Rtn = await db.selectDataByPrimaryKey(Testlog027_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog027_Rtn == null) {
        print('\n********** 異常発生：log027_CDataLog27_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog027_Rtn?.serial_no,'abc12');
        expect(Testlog027_Rtn?.seq_no,9913);
        expect(Testlog027_Rtn?.cnct_seq_no,9914);
        expect(Testlog027_Rtn?.func_cd,9915);
        expect(Testlog027_Rtn?.func_seq_no,9916);
        expect(Testlog027_Rtn?.c_data1,'abc17');
        expect(Testlog027_Rtn?.c_data2,'abc18');
        expect(Testlog027_Rtn?.c_data3,'abc19');
        expect(Testlog027_Rtn?.c_data4,'abc20');
        expect(Testlog027_Rtn?.c_data5,'abc21');
        expect(Testlog027_Rtn?.c_data6,'abc22');
        expect(Testlog027_Rtn?.c_data7,'abc23');
        expect(Testlog027_Rtn?.c_data8,'abc24');
        expect(Testlog027_Rtn?.c_data9,'abc25');
        expect(Testlog027_Rtn?.c_data10,'abc26');
        expect(Testlog027_Rtn?.n_data1,1.227);
        expect(Testlog027_Rtn?.n_data2,1.228);
        expect(Testlog027_Rtn?.n_data3,1.229);
        expect(Testlog027_Rtn?.n_data4,1.230);
        expect(Testlog027_Rtn?.n_data5,1.231);
        expect(Testlog027_Rtn?.n_data6,1.232);
        expect(Testlog027_Rtn?.n_data7,1.233);
        expect(Testlog027_Rtn?.n_data8,1.234);
        expect(Testlog027_Rtn?.n_data9,1.235);
        expect(Testlog027_Rtn?.n_data10,1.236);
        expect(Testlog027_Rtn?.n_data11,1.237);
        expect(Testlog027_Rtn?.n_data12,1.238);
        expect(Testlog027_Rtn?.n_data13,1.239);
        expect(Testlog027_Rtn?.n_data14,1.240);
        expect(Testlog027_Rtn?.n_data15,1.241);
        expect(Testlog027_Rtn?.n_data16,1.242);
        expect(Testlog027_Rtn?.n_data17,1.243);
        expect(Testlog027_Rtn?.n_data18,1.244);
        expect(Testlog027_Rtn?.n_data19,1.245);
        expect(Testlog027_Rtn?.n_data20,1.246);
        expect(Testlog027_Rtn?.n_data21,1.247);
        expect(Testlog027_Rtn?.n_data22,1.248);
        expect(Testlog027_Rtn?.n_data23,1.249);
        expect(Testlog027_Rtn?.n_data24,1.250);
        expect(Testlog027_Rtn?.n_data25,1.251);
        expect(Testlog027_Rtn?.n_data26,1.252);
        expect(Testlog027_Rtn?.n_data27,1.253);
        expect(Testlog027_Rtn?.n_data28,1.254);
        expect(Testlog027_Rtn?.n_data29,1.255);
        expect(Testlog027_Rtn?.n_data30,1.256);
        expect(Testlog027_Rtn?.d_data1,'abc57');
        expect(Testlog027_Rtn?.d_data2,'abc58');
        expect(Testlog027_Rtn?.d_data3,'abc59');
        expect(Testlog027_Rtn?.d_data4,'abc60');
        expect(Testlog027_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog27> Testlog027_AllRtn2 = await db.selectAllData(Testlog027_1);
      int count2 = Testlog027_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog027_1);
      print('********** テスト終了：log027_CDataLog27_01 **********\n\n');
    });

    // ********************************************************
    // テストlog028 : CDataLog28
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log028_CDataLog28_01', () async {
      print('\n********** テスト実行：log028_CDataLog28_01 **********');
      CDataLog28 Testlog028_1 = CDataLog28();
      Testlog028_1.serial_no = 'abc12';
      Testlog028_1.seq_no = 9913;
      Testlog028_1.cnct_seq_no = 9914;
      Testlog028_1.func_cd = 9915;
      Testlog028_1.func_seq_no = 9916;
      Testlog028_1.c_data1 = 'abc17';
      Testlog028_1.c_data2 = 'abc18';
      Testlog028_1.c_data3 = 'abc19';
      Testlog028_1.c_data4 = 'abc20';
      Testlog028_1.c_data5 = 'abc21';
      Testlog028_1.c_data6 = 'abc22';
      Testlog028_1.c_data7 = 'abc23';
      Testlog028_1.c_data8 = 'abc24';
      Testlog028_1.c_data9 = 'abc25';
      Testlog028_1.c_data10 = 'abc26';
      Testlog028_1.n_data1 = 1.227;
      Testlog028_1.n_data2 = 1.228;
      Testlog028_1.n_data3 = 1.229;
      Testlog028_1.n_data4 = 1.230;
      Testlog028_1.n_data5 = 1.231;
      Testlog028_1.n_data6 = 1.232;
      Testlog028_1.n_data7 = 1.233;
      Testlog028_1.n_data8 = 1.234;
      Testlog028_1.n_data9 = 1.235;
      Testlog028_1.n_data10 = 1.236;
      Testlog028_1.n_data11 = 1.237;
      Testlog028_1.n_data12 = 1.238;
      Testlog028_1.n_data13 = 1.239;
      Testlog028_1.n_data14 = 1.240;
      Testlog028_1.n_data15 = 1.241;
      Testlog028_1.n_data16 = 1.242;
      Testlog028_1.n_data17 = 1.243;
      Testlog028_1.n_data18 = 1.244;
      Testlog028_1.n_data19 = 1.245;
      Testlog028_1.n_data20 = 1.246;
      Testlog028_1.n_data21 = 1.247;
      Testlog028_1.n_data22 = 1.248;
      Testlog028_1.n_data23 = 1.249;
      Testlog028_1.n_data24 = 1.250;
      Testlog028_1.n_data25 = 1.251;
      Testlog028_1.n_data26 = 1.252;
      Testlog028_1.n_data27 = 1.253;
      Testlog028_1.n_data28 = 1.254;
      Testlog028_1.n_data29 = 1.255;
      Testlog028_1.n_data30 = 1.256;
      Testlog028_1.d_data1 = 'abc57';
      Testlog028_1.d_data2 = 'abc58';
      Testlog028_1.d_data3 = 'abc59';
      Testlog028_1.d_data4 = 'abc60';
      Testlog028_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog28> Testlog028_AllRtn = await db.selectAllData(Testlog028_1);
      int count = Testlog028_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog028_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog28 Testlog028_2 = CDataLog28();
      //Keyの値を設定する
      Testlog028_2.serial_no = 'abc12';
      Testlog028_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog28? Testlog028_Rtn = await db.selectDataByPrimaryKey(Testlog028_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog028_Rtn == null) {
        print('\n********** 異常発生：log028_CDataLog28_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog028_Rtn?.serial_no,'abc12');
        expect(Testlog028_Rtn?.seq_no,9913);
        expect(Testlog028_Rtn?.cnct_seq_no,9914);
        expect(Testlog028_Rtn?.func_cd,9915);
        expect(Testlog028_Rtn?.func_seq_no,9916);
        expect(Testlog028_Rtn?.c_data1,'abc17');
        expect(Testlog028_Rtn?.c_data2,'abc18');
        expect(Testlog028_Rtn?.c_data3,'abc19');
        expect(Testlog028_Rtn?.c_data4,'abc20');
        expect(Testlog028_Rtn?.c_data5,'abc21');
        expect(Testlog028_Rtn?.c_data6,'abc22');
        expect(Testlog028_Rtn?.c_data7,'abc23');
        expect(Testlog028_Rtn?.c_data8,'abc24');
        expect(Testlog028_Rtn?.c_data9,'abc25');
        expect(Testlog028_Rtn?.c_data10,'abc26');
        expect(Testlog028_Rtn?.n_data1,1.227);
        expect(Testlog028_Rtn?.n_data2,1.228);
        expect(Testlog028_Rtn?.n_data3,1.229);
        expect(Testlog028_Rtn?.n_data4,1.230);
        expect(Testlog028_Rtn?.n_data5,1.231);
        expect(Testlog028_Rtn?.n_data6,1.232);
        expect(Testlog028_Rtn?.n_data7,1.233);
        expect(Testlog028_Rtn?.n_data8,1.234);
        expect(Testlog028_Rtn?.n_data9,1.235);
        expect(Testlog028_Rtn?.n_data10,1.236);
        expect(Testlog028_Rtn?.n_data11,1.237);
        expect(Testlog028_Rtn?.n_data12,1.238);
        expect(Testlog028_Rtn?.n_data13,1.239);
        expect(Testlog028_Rtn?.n_data14,1.240);
        expect(Testlog028_Rtn?.n_data15,1.241);
        expect(Testlog028_Rtn?.n_data16,1.242);
        expect(Testlog028_Rtn?.n_data17,1.243);
        expect(Testlog028_Rtn?.n_data18,1.244);
        expect(Testlog028_Rtn?.n_data19,1.245);
        expect(Testlog028_Rtn?.n_data20,1.246);
        expect(Testlog028_Rtn?.n_data21,1.247);
        expect(Testlog028_Rtn?.n_data22,1.248);
        expect(Testlog028_Rtn?.n_data23,1.249);
        expect(Testlog028_Rtn?.n_data24,1.250);
        expect(Testlog028_Rtn?.n_data25,1.251);
        expect(Testlog028_Rtn?.n_data26,1.252);
        expect(Testlog028_Rtn?.n_data27,1.253);
        expect(Testlog028_Rtn?.n_data28,1.254);
        expect(Testlog028_Rtn?.n_data29,1.255);
        expect(Testlog028_Rtn?.n_data30,1.256);
        expect(Testlog028_Rtn?.d_data1,'abc57');
        expect(Testlog028_Rtn?.d_data2,'abc58');
        expect(Testlog028_Rtn?.d_data3,'abc59');
        expect(Testlog028_Rtn?.d_data4,'abc60');
        expect(Testlog028_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog28> Testlog028_AllRtn2 = await db.selectAllData(Testlog028_1);
      int count2 = Testlog028_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog028_1);
      print('********** テスト終了：log028_CDataLog28_01 **********\n\n');
    });

    // ********************************************************
    // テストlog029 : CDataLog29
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log029_CDataLog29_01', () async {
      print('\n********** テスト実行：log029_CDataLog29_01 **********');
      CDataLog29 Testlog029_1 = CDataLog29();
      Testlog029_1.serial_no = 'abc12';
      Testlog029_1.seq_no = 9913;
      Testlog029_1.cnct_seq_no = 9914;
      Testlog029_1.func_cd = 9915;
      Testlog029_1.func_seq_no = 9916;
      Testlog029_1.c_data1 = 'abc17';
      Testlog029_1.c_data2 = 'abc18';
      Testlog029_1.c_data3 = 'abc19';
      Testlog029_1.c_data4 = 'abc20';
      Testlog029_1.c_data5 = 'abc21';
      Testlog029_1.c_data6 = 'abc22';
      Testlog029_1.c_data7 = 'abc23';
      Testlog029_1.c_data8 = 'abc24';
      Testlog029_1.c_data9 = 'abc25';
      Testlog029_1.c_data10 = 'abc26';
      Testlog029_1.n_data1 = 1.227;
      Testlog029_1.n_data2 = 1.228;
      Testlog029_1.n_data3 = 1.229;
      Testlog029_1.n_data4 = 1.230;
      Testlog029_1.n_data5 = 1.231;
      Testlog029_1.n_data6 = 1.232;
      Testlog029_1.n_data7 = 1.233;
      Testlog029_1.n_data8 = 1.234;
      Testlog029_1.n_data9 = 1.235;
      Testlog029_1.n_data10 = 1.236;
      Testlog029_1.n_data11 = 1.237;
      Testlog029_1.n_data12 = 1.238;
      Testlog029_1.n_data13 = 1.239;
      Testlog029_1.n_data14 = 1.240;
      Testlog029_1.n_data15 = 1.241;
      Testlog029_1.n_data16 = 1.242;
      Testlog029_1.n_data17 = 1.243;
      Testlog029_1.n_data18 = 1.244;
      Testlog029_1.n_data19 = 1.245;
      Testlog029_1.n_data20 = 1.246;
      Testlog029_1.n_data21 = 1.247;
      Testlog029_1.n_data22 = 1.248;
      Testlog029_1.n_data23 = 1.249;
      Testlog029_1.n_data24 = 1.250;
      Testlog029_1.n_data25 = 1.251;
      Testlog029_1.n_data26 = 1.252;
      Testlog029_1.n_data27 = 1.253;
      Testlog029_1.n_data28 = 1.254;
      Testlog029_1.n_data29 = 1.255;
      Testlog029_1.n_data30 = 1.256;
      Testlog029_1.d_data1 = 'abc57';
      Testlog029_1.d_data2 = 'abc58';
      Testlog029_1.d_data3 = 'abc59';
      Testlog029_1.d_data4 = 'abc60';
      Testlog029_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog29> Testlog029_AllRtn = await db.selectAllData(Testlog029_1);
      int count = Testlog029_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog029_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog29 Testlog029_2 = CDataLog29();
      //Keyの値を設定する
      Testlog029_2.serial_no = 'abc12';
      Testlog029_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog29? Testlog029_Rtn = await db.selectDataByPrimaryKey(Testlog029_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog029_Rtn == null) {
        print('\n********** 異常発生：log029_CDataLog29_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog029_Rtn?.serial_no,'abc12');
        expect(Testlog029_Rtn?.seq_no,9913);
        expect(Testlog029_Rtn?.cnct_seq_no,9914);
        expect(Testlog029_Rtn?.func_cd,9915);
        expect(Testlog029_Rtn?.func_seq_no,9916);
        expect(Testlog029_Rtn?.c_data1,'abc17');
        expect(Testlog029_Rtn?.c_data2,'abc18');
        expect(Testlog029_Rtn?.c_data3,'abc19');
        expect(Testlog029_Rtn?.c_data4,'abc20');
        expect(Testlog029_Rtn?.c_data5,'abc21');
        expect(Testlog029_Rtn?.c_data6,'abc22');
        expect(Testlog029_Rtn?.c_data7,'abc23');
        expect(Testlog029_Rtn?.c_data8,'abc24');
        expect(Testlog029_Rtn?.c_data9,'abc25');
        expect(Testlog029_Rtn?.c_data10,'abc26');
        expect(Testlog029_Rtn?.n_data1,1.227);
        expect(Testlog029_Rtn?.n_data2,1.228);
        expect(Testlog029_Rtn?.n_data3,1.229);
        expect(Testlog029_Rtn?.n_data4,1.230);
        expect(Testlog029_Rtn?.n_data5,1.231);
        expect(Testlog029_Rtn?.n_data6,1.232);
        expect(Testlog029_Rtn?.n_data7,1.233);
        expect(Testlog029_Rtn?.n_data8,1.234);
        expect(Testlog029_Rtn?.n_data9,1.235);
        expect(Testlog029_Rtn?.n_data10,1.236);
        expect(Testlog029_Rtn?.n_data11,1.237);
        expect(Testlog029_Rtn?.n_data12,1.238);
        expect(Testlog029_Rtn?.n_data13,1.239);
        expect(Testlog029_Rtn?.n_data14,1.240);
        expect(Testlog029_Rtn?.n_data15,1.241);
        expect(Testlog029_Rtn?.n_data16,1.242);
        expect(Testlog029_Rtn?.n_data17,1.243);
        expect(Testlog029_Rtn?.n_data18,1.244);
        expect(Testlog029_Rtn?.n_data19,1.245);
        expect(Testlog029_Rtn?.n_data20,1.246);
        expect(Testlog029_Rtn?.n_data21,1.247);
        expect(Testlog029_Rtn?.n_data22,1.248);
        expect(Testlog029_Rtn?.n_data23,1.249);
        expect(Testlog029_Rtn?.n_data24,1.250);
        expect(Testlog029_Rtn?.n_data25,1.251);
        expect(Testlog029_Rtn?.n_data26,1.252);
        expect(Testlog029_Rtn?.n_data27,1.253);
        expect(Testlog029_Rtn?.n_data28,1.254);
        expect(Testlog029_Rtn?.n_data29,1.255);
        expect(Testlog029_Rtn?.n_data30,1.256);
        expect(Testlog029_Rtn?.d_data1,'abc57');
        expect(Testlog029_Rtn?.d_data2,'abc58');
        expect(Testlog029_Rtn?.d_data3,'abc59');
        expect(Testlog029_Rtn?.d_data4,'abc60');
        expect(Testlog029_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog29> Testlog029_AllRtn2 = await db.selectAllData(Testlog029_1);
      int count2 = Testlog029_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog029_1);
      print('********** テスト終了：log029_CDataLog29_01 **********\n\n');
    });

    // ********************************************************
    // テストlog030 : CDataLog30
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log030_CDataLog30_01', () async {
      print('\n********** テスト実行：log030_CDataLog30_01 **********');
      CDataLog30 Testlog030_1 = CDataLog30();
      Testlog030_1.serial_no = 'abc12';
      Testlog030_1.seq_no = 9913;
      Testlog030_1.cnct_seq_no = 9914;
      Testlog030_1.func_cd = 9915;
      Testlog030_1.func_seq_no = 9916;
      Testlog030_1.c_data1 = 'abc17';
      Testlog030_1.c_data2 = 'abc18';
      Testlog030_1.c_data3 = 'abc19';
      Testlog030_1.c_data4 = 'abc20';
      Testlog030_1.c_data5 = 'abc21';
      Testlog030_1.c_data6 = 'abc22';
      Testlog030_1.c_data7 = 'abc23';
      Testlog030_1.c_data8 = 'abc24';
      Testlog030_1.c_data9 = 'abc25';
      Testlog030_1.c_data10 = 'abc26';
      Testlog030_1.n_data1 = 1.227;
      Testlog030_1.n_data2 = 1.228;
      Testlog030_1.n_data3 = 1.229;
      Testlog030_1.n_data4 = 1.230;
      Testlog030_1.n_data5 = 1.231;
      Testlog030_1.n_data6 = 1.232;
      Testlog030_1.n_data7 = 1.233;
      Testlog030_1.n_data8 = 1.234;
      Testlog030_1.n_data9 = 1.235;
      Testlog030_1.n_data10 = 1.236;
      Testlog030_1.n_data11 = 1.237;
      Testlog030_1.n_data12 = 1.238;
      Testlog030_1.n_data13 = 1.239;
      Testlog030_1.n_data14 = 1.240;
      Testlog030_1.n_data15 = 1.241;
      Testlog030_1.n_data16 = 1.242;
      Testlog030_1.n_data17 = 1.243;
      Testlog030_1.n_data18 = 1.244;
      Testlog030_1.n_data19 = 1.245;
      Testlog030_1.n_data20 = 1.246;
      Testlog030_1.n_data21 = 1.247;
      Testlog030_1.n_data22 = 1.248;
      Testlog030_1.n_data23 = 1.249;
      Testlog030_1.n_data24 = 1.250;
      Testlog030_1.n_data25 = 1.251;
      Testlog030_1.n_data26 = 1.252;
      Testlog030_1.n_data27 = 1.253;
      Testlog030_1.n_data28 = 1.254;
      Testlog030_1.n_data29 = 1.255;
      Testlog030_1.n_data30 = 1.256;
      Testlog030_1.d_data1 = 'abc57';
      Testlog030_1.d_data2 = 'abc58';
      Testlog030_1.d_data3 = 'abc59';
      Testlog030_1.d_data4 = 'abc60';
      Testlog030_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog30> Testlog030_AllRtn = await db.selectAllData(Testlog030_1);
      int count = Testlog030_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog030_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog30 Testlog030_2 = CDataLog30();
      //Keyの値を設定する
      Testlog030_2.serial_no = 'abc12';
      Testlog030_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog30? Testlog030_Rtn = await db.selectDataByPrimaryKey(Testlog030_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog030_Rtn == null) {
        print('\n********** 異常発生：log030_CDataLog30_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog030_Rtn?.serial_no,'abc12');
        expect(Testlog030_Rtn?.seq_no,9913);
        expect(Testlog030_Rtn?.cnct_seq_no,9914);
        expect(Testlog030_Rtn?.func_cd,9915);
        expect(Testlog030_Rtn?.func_seq_no,9916);
        expect(Testlog030_Rtn?.c_data1,'abc17');
        expect(Testlog030_Rtn?.c_data2,'abc18');
        expect(Testlog030_Rtn?.c_data3,'abc19');
        expect(Testlog030_Rtn?.c_data4,'abc20');
        expect(Testlog030_Rtn?.c_data5,'abc21');
        expect(Testlog030_Rtn?.c_data6,'abc22');
        expect(Testlog030_Rtn?.c_data7,'abc23');
        expect(Testlog030_Rtn?.c_data8,'abc24');
        expect(Testlog030_Rtn?.c_data9,'abc25');
        expect(Testlog030_Rtn?.c_data10,'abc26');
        expect(Testlog030_Rtn?.n_data1,1.227);
        expect(Testlog030_Rtn?.n_data2,1.228);
        expect(Testlog030_Rtn?.n_data3,1.229);
        expect(Testlog030_Rtn?.n_data4,1.230);
        expect(Testlog030_Rtn?.n_data5,1.231);
        expect(Testlog030_Rtn?.n_data6,1.232);
        expect(Testlog030_Rtn?.n_data7,1.233);
        expect(Testlog030_Rtn?.n_data8,1.234);
        expect(Testlog030_Rtn?.n_data9,1.235);
        expect(Testlog030_Rtn?.n_data10,1.236);
        expect(Testlog030_Rtn?.n_data11,1.237);
        expect(Testlog030_Rtn?.n_data12,1.238);
        expect(Testlog030_Rtn?.n_data13,1.239);
        expect(Testlog030_Rtn?.n_data14,1.240);
        expect(Testlog030_Rtn?.n_data15,1.241);
        expect(Testlog030_Rtn?.n_data16,1.242);
        expect(Testlog030_Rtn?.n_data17,1.243);
        expect(Testlog030_Rtn?.n_data18,1.244);
        expect(Testlog030_Rtn?.n_data19,1.245);
        expect(Testlog030_Rtn?.n_data20,1.246);
        expect(Testlog030_Rtn?.n_data21,1.247);
        expect(Testlog030_Rtn?.n_data22,1.248);
        expect(Testlog030_Rtn?.n_data23,1.249);
        expect(Testlog030_Rtn?.n_data24,1.250);
        expect(Testlog030_Rtn?.n_data25,1.251);
        expect(Testlog030_Rtn?.n_data26,1.252);
        expect(Testlog030_Rtn?.n_data27,1.253);
        expect(Testlog030_Rtn?.n_data28,1.254);
        expect(Testlog030_Rtn?.n_data29,1.255);
        expect(Testlog030_Rtn?.n_data30,1.256);
        expect(Testlog030_Rtn?.d_data1,'abc57');
        expect(Testlog030_Rtn?.d_data2,'abc58');
        expect(Testlog030_Rtn?.d_data3,'abc59');
        expect(Testlog030_Rtn?.d_data4,'abc60');
        expect(Testlog030_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog30> Testlog030_AllRtn2 = await db.selectAllData(Testlog030_1);
      int count2 = Testlog030_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog030_1);
      print('********** テスト終了：log030_CDataLog30_01 **********\n\n');
    });

    // ********************************************************
    // テストlog031 : CDataLog31
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log031_CDataLog31_01', () async {
      print('\n********** テスト実行：log031_CDataLog31_01 **********');
      CDataLog31 Testlog031_1 = CDataLog31();
      Testlog031_1.serial_no = 'abc12';
      Testlog031_1.seq_no = 9913;
      Testlog031_1.cnct_seq_no = 9914;
      Testlog031_1.func_cd = 9915;
      Testlog031_1.func_seq_no = 9916;
      Testlog031_1.c_data1 = 'abc17';
      Testlog031_1.c_data2 = 'abc18';
      Testlog031_1.c_data3 = 'abc19';
      Testlog031_1.c_data4 = 'abc20';
      Testlog031_1.c_data5 = 'abc21';
      Testlog031_1.c_data6 = 'abc22';
      Testlog031_1.c_data7 = 'abc23';
      Testlog031_1.c_data8 = 'abc24';
      Testlog031_1.c_data9 = 'abc25';
      Testlog031_1.c_data10 = 'abc26';
      Testlog031_1.n_data1 = 1.227;
      Testlog031_1.n_data2 = 1.228;
      Testlog031_1.n_data3 = 1.229;
      Testlog031_1.n_data4 = 1.230;
      Testlog031_1.n_data5 = 1.231;
      Testlog031_1.n_data6 = 1.232;
      Testlog031_1.n_data7 = 1.233;
      Testlog031_1.n_data8 = 1.234;
      Testlog031_1.n_data9 = 1.235;
      Testlog031_1.n_data10 = 1.236;
      Testlog031_1.n_data11 = 1.237;
      Testlog031_1.n_data12 = 1.238;
      Testlog031_1.n_data13 = 1.239;
      Testlog031_1.n_data14 = 1.240;
      Testlog031_1.n_data15 = 1.241;
      Testlog031_1.n_data16 = 1.242;
      Testlog031_1.n_data17 = 1.243;
      Testlog031_1.n_data18 = 1.244;
      Testlog031_1.n_data19 = 1.245;
      Testlog031_1.n_data20 = 1.246;
      Testlog031_1.n_data21 = 1.247;
      Testlog031_1.n_data22 = 1.248;
      Testlog031_1.n_data23 = 1.249;
      Testlog031_1.n_data24 = 1.250;
      Testlog031_1.n_data25 = 1.251;
      Testlog031_1.n_data26 = 1.252;
      Testlog031_1.n_data27 = 1.253;
      Testlog031_1.n_data28 = 1.254;
      Testlog031_1.n_data29 = 1.255;
      Testlog031_1.n_data30 = 1.256;
      Testlog031_1.d_data1 = 'abc57';
      Testlog031_1.d_data2 = 'abc58';
      Testlog031_1.d_data3 = 'abc59';
      Testlog031_1.d_data4 = 'abc60';
      Testlog031_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog31> Testlog031_AllRtn = await db.selectAllData(Testlog031_1);
      int count = Testlog031_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog031_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog31 Testlog031_2 = CDataLog31();
      //Keyの値を設定する
      Testlog031_2.serial_no = 'abc12';
      Testlog031_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog31? Testlog031_Rtn = await db.selectDataByPrimaryKey(Testlog031_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog031_Rtn == null) {
        print('\n********** 異常発生：log031_CDataLog31_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog031_Rtn?.serial_no,'abc12');
        expect(Testlog031_Rtn?.seq_no,9913);
        expect(Testlog031_Rtn?.cnct_seq_no,9914);
        expect(Testlog031_Rtn?.func_cd,9915);
        expect(Testlog031_Rtn?.func_seq_no,9916);
        expect(Testlog031_Rtn?.c_data1,'abc17');
        expect(Testlog031_Rtn?.c_data2,'abc18');
        expect(Testlog031_Rtn?.c_data3,'abc19');
        expect(Testlog031_Rtn?.c_data4,'abc20');
        expect(Testlog031_Rtn?.c_data5,'abc21');
        expect(Testlog031_Rtn?.c_data6,'abc22');
        expect(Testlog031_Rtn?.c_data7,'abc23');
        expect(Testlog031_Rtn?.c_data8,'abc24');
        expect(Testlog031_Rtn?.c_data9,'abc25');
        expect(Testlog031_Rtn?.c_data10,'abc26');
        expect(Testlog031_Rtn?.n_data1,1.227);
        expect(Testlog031_Rtn?.n_data2,1.228);
        expect(Testlog031_Rtn?.n_data3,1.229);
        expect(Testlog031_Rtn?.n_data4,1.230);
        expect(Testlog031_Rtn?.n_data5,1.231);
        expect(Testlog031_Rtn?.n_data6,1.232);
        expect(Testlog031_Rtn?.n_data7,1.233);
        expect(Testlog031_Rtn?.n_data8,1.234);
        expect(Testlog031_Rtn?.n_data9,1.235);
        expect(Testlog031_Rtn?.n_data10,1.236);
        expect(Testlog031_Rtn?.n_data11,1.237);
        expect(Testlog031_Rtn?.n_data12,1.238);
        expect(Testlog031_Rtn?.n_data13,1.239);
        expect(Testlog031_Rtn?.n_data14,1.240);
        expect(Testlog031_Rtn?.n_data15,1.241);
        expect(Testlog031_Rtn?.n_data16,1.242);
        expect(Testlog031_Rtn?.n_data17,1.243);
        expect(Testlog031_Rtn?.n_data18,1.244);
        expect(Testlog031_Rtn?.n_data19,1.245);
        expect(Testlog031_Rtn?.n_data20,1.246);
        expect(Testlog031_Rtn?.n_data21,1.247);
        expect(Testlog031_Rtn?.n_data22,1.248);
        expect(Testlog031_Rtn?.n_data23,1.249);
        expect(Testlog031_Rtn?.n_data24,1.250);
        expect(Testlog031_Rtn?.n_data25,1.251);
        expect(Testlog031_Rtn?.n_data26,1.252);
        expect(Testlog031_Rtn?.n_data27,1.253);
        expect(Testlog031_Rtn?.n_data28,1.254);
        expect(Testlog031_Rtn?.n_data29,1.255);
        expect(Testlog031_Rtn?.n_data30,1.256);
        expect(Testlog031_Rtn?.d_data1,'abc57');
        expect(Testlog031_Rtn?.d_data2,'abc58');
        expect(Testlog031_Rtn?.d_data3,'abc59');
        expect(Testlog031_Rtn?.d_data4,'abc60');
        expect(Testlog031_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog31> Testlog031_AllRtn2 = await db.selectAllData(Testlog031_1);
      int count2 = Testlog031_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog031_1);
      print('********** テスト終了：log031_CDataLog31_01 **********\n\n');
    });

    // ********************************************************
    // テストlog032 : CDataLogReserv
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log032_CDataLogReserv_01', () async {
      print('\n********** テスト実行：log032_CDataLogReserv_01 **********');
      CDataLogReserv Testlog032_1 = CDataLogReserv();
      Testlog032_1.serial_no = 'abc12';
      Testlog032_1.seq_no = 9913;
      Testlog032_1.cnct_seq_no = 9914;
      Testlog032_1.func_cd = 9915;
      Testlog032_1.func_seq_no = 9916;
      Testlog032_1.c_data1 = 'abc17';
      Testlog032_1.c_data2 = 'abc18';
      Testlog032_1.c_data3 = 'abc19';
      Testlog032_1.c_data4 = 'abc20';
      Testlog032_1.c_data5 = 'abc21';
      Testlog032_1.c_data6 = 'abc22';
      Testlog032_1.c_data7 = 'abc23';
      Testlog032_1.c_data8 = 'abc24';
      Testlog032_1.c_data9 = 'abc25';
      Testlog032_1.c_data10 = 'abc26';
      Testlog032_1.n_data1 = 1.227;
      Testlog032_1.n_data2 = 1.228;
      Testlog032_1.n_data3 = 1.229;
      Testlog032_1.n_data4 = 1.230;
      Testlog032_1.n_data5 = 1.231;
      Testlog032_1.n_data6 = 1.232;
      Testlog032_1.n_data7 = 1.233;
      Testlog032_1.n_data8 = 1.234;
      Testlog032_1.n_data9 = 1.235;
      Testlog032_1.n_data10 = 1.236;
      Testlog032_1.n_data11 = 1.237;
      Testlog032_1.n_data12 = 1.238;
      Testlog032_1.n_data13 = 1.239;
      Testlog032_1.n_data14 = 1.240;
      Testlog032_1.n_data15 = 1.241;
      Testlog032_1.n_data16 = 1.242;
      Testlog032_1.n_data17 = 1.243;
      Testlog032_1.n_data18 = 1.244;
      Testlog032_1.n_data19 = 1.245;
      Testlog032_1.n_data20 = 1.246;
      Testlog032_1.n_data21 = 1.247;
      Testlog032_1.n_data22 = 1.248;
      Testlog032_1.n_data23 = 1.249;
      Testlog032_1.n_data24 = 1.250;
      Testlog032_1.n_data25 = 1.251;
      Testlog032_1.n_data26 = 1.252;
      Testlog032_1.n_data27 = 1.253;
      Testlog032_1.n_data28 = 1.254;
      Testlog032_1.n_data29 = 1.255;
      Testlog032_1.n_data30 = 1.256;
      Testlog032_1.d_data1 = 'abc57';
      Testlog032_1.d_data2 = 'abc58';
      Testlog032_1.d_data3 = 'abc59';
      Testlog032_1.d_data4 = 'abc60';
      Testlog032_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLogReserv> Testlog032_AllRtn = await db.selectAllData(Testlog032_1);
      int count = Testlog032_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog032_1);

      //データ取得に必要なオブジェクトを用意
      CDataLogReserv Testlog032_2 = CDataLogReserv();
      //Keyの値を設定する
      Testlog032_2.serial_no = 'abc12';
      Testlog032_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLogReserv? Testlog032_Rtn = await db.selectDataByPrimaryKey(Testlog032_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog032_Rtn == null) {
        print('\n********** 異常発生：log032_CDataLogReserv_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog032_Rtn?.serial_no,'abc12');
        expect(Testlog032_Rtn?.seq_no,9913);
        expect(Testlog032_Rtn?.cnct_seq_no,9914);
        expect(Testlog032_Rtn?.func_cd,9915);
        expect(Testlog032_Rtn?.func_seq_no,9916);
        expect(Testlog032_Rtn?.c_data1,'abc17');
        expect(Testlog032_Rtn?.c_data2,'abc18');
        expect(Testlog032_Rtn?.c_data3,'abc19');
        expect(Testlog032_Rtn?.c_data4,'abc20');
        expect(Testlog032_Rtn?.c_data5,'abc21');
        expect(Testlog032_Rtn?.c_data6,'abc22');
        expect(Testlog032_Rtn?.c_data7,'abc23');
        expect(Testlog032_Rtn?.c_data8,'abc24');
        expect(Testlog032_Rtn?.c_data9,'abc25');
        expect(Testlog032_Rtn?.c_data10,'abc26');
        expect(Testlog032_Rtn?.n_data1,1.227);
        expect(Testlog032_Rtn?.n_data2,1.228);
        expect(Testlog032_Rtn?.n_data3,1.229);
        expect(Testlog032_Rtn?.n_data4,1.230);
        expect(Testlog032_Rtn?.n_data5,1.231);
        expect(Testlog032_Rtn?.n_data6,1.232);
        expect(Testlog032_Rtn?.n_data7,1.233);
        expect(Testlog032_Rtn?.n_data8,1.234);
        expect(Testlog032_Rtn?.n_data9,1.235);
        expect(Testlog032_Rtn?.n_data10,1.236);
        expect(Testlog032_Rtn?.n_data11,1.237);
        expect(Testlog032_Rtn?.n_data12,1.238);
        expect(Testlog032_Rtn?.n_data13,1.239);
        expect(Testlog032_Rtn?.n_data14,1.240);
        expect(Testlog032_Rtn?.n_data15,1.241);
        expect(Testlog032_Rtn?.n_data16,1.242);
        expect(Testlog032_Rtn?.n_data17,1.243);
        expect(Testlog032_Rtn?.n_data18,1.244);
        expect(Testlog032_Rtn?.n_data19,1.245);
        expect(Testlog032_Rtn?.n_data20,1.246);
        expect(Testlog032_Rtn?.n_data21,1.247);
        expect(Testlog032_Rtn?.n_data22,1.248);
        expect(Testlog032_Rtn?.n_data23,1.249);
        expect(Testlog032_Rtn?.n_data24,1.250);
        expect(Testlog032_Rtn?.n_data25,1.251);
        expect(Testlog032_Rtn?.n_data26,1.252);
        expect(Testlog032_Rtn?.n_data27,1.253);
        expect(Testlog032_Rtn?.n_data28,1.254);
        expect(Testlog032_Rtn?.n_data29,1.255);
        expect(Testlog032_Rtn?.n_data30,1.256);
        expect(Testlog032_Rtn?.d_data1,'abc57');
        expect(Testlog032_Rtn?.d_data2,'abc58');
        expect(Testlog032_Rtn?.d_data3,'abc59');
        expect(Testlog032_Rtn?.d_data4,'abc60');
        expect(Testlog032_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLogReserv> Testlog032_AllRtn2 = await db.selectAllData(Testlog032_1);
      int count2 = Testlog032_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog032_1);
      print('********** テスト終了：log032_CDataLogReserv_01 **********\n\n');
    });

    // ********************************************************
    // テストlog033 : CDataLogReserv01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log033_CDataLogReserv01_01', () async {
      print('\n********** テスト実行：log033_CDataLogReserv01_01 **********');
      CDataLogReserv01 Testlog033_1 = CDataLogReserv01();
      Testlog033_1.serial_no = 'abc12';
      Testlog033_1.seq_no = 9913;
      Testlog033_1.cnct_seq_no = 9914;
      Testlog033_1.func_cd = 9915;
      Testlog033_1.func_seq_no = 9916;
      Testlog033_1.c_data1 = 'abc17';
      Testlog033_1.c_data2 = 'abc18';
      Testlog033_1.c_data3 = 'abc19';
      Testlog033_1.c_data4 = 'abc20';
      Testlog033_1.c_data5 = 'abc21';
      Testlog033_1.c_data6 = 'abc22';
      Testlog033_1.c_data7 = 'abc23';
      Testlog033_1.c_data8 = 'abc24';
      Testlog033_1.c_data9 = 'abc25';
      Testlog033_1.c_data10 = 'abc26';
      Testlog033_1.n_data1 = 1.227;
      Testlog033_1.n_data2 = 1.228;
      Testlog033_1.n_data3 = 1.229;
      Testlog033_1.n_data4 = 1.230;
      Testlog033_1.n_data5 = 1.231;
      Testlog033_1.n_data6 = 1.232;
      Testlog033_1.n_data7 = 1.233;
      Testlog033_1.n_data8 = 1.234;
      Testlog033_1.n_data9 = 1.235;
      Testlog033_1.n_data10 = 1.236;
      Testlog033_1.n_data11 = 1.237;
      Testlog033_1.n_data12 = 1.238;
      Testlog033_1.n_data13 = 1.239;
      Testlog033_1.n_data14 = 1.240;
      Testlog033_1.n_data15 = 1.241;
      Testlog033_1.n_data16 = 1.242;
      Testlog033_1.n_data17 = 1.243;
      Testlog033_1.n_data18 = 1.244;
      Testlog033_1.n_data19 = 1.245;
      Testlog033_1.n_data20 = 1.246;
      Testlog033_1.n_data21 = 1.247;
      Testlog033_1.n_data22 = 1.248;
      Testlog033_1.n_data23 = 1.249;
      Testlog033_1.n_data24 = 1.250;
      Testlog033_1.n_data25 = 1.251;
      Testlog033_1.n_data26 = 1.252;
      Testlog033_1.n_data27 = 1.253;
      Testlog033_1.n_data28 = 1.254;
      Testlog033_1.n_data29 = 1.255;
      Testlog033_1.n_data30 = 1.256;
      Testlog033_1.d_data1 = 'abc57';
      Testlog033_1.d_data2 = 'abc58';
      Testlog033_1.d_data3 = 'abc59';
      Testlog033_1.d_data4 = 'abc60';
      Testlog033_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLogReserv01> Testlog033_AllRtn = await db.selectAllData(Testlog033_1);
      int count = Testlog033_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog033_1);

      //データ取得に必要なオブジェクトを用意
      CDataLogReserv01 Testlog033_2 = CDataLogReserv01();
      //Keyの値を設定する
      Testlog033_2.serial_no = 'abc12';
      Testlog033_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLogReserv01? Testlog033_Rtn = await db.selectDataByPrimaryKey(Testlog033_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog033_Rtn == null) {
        print('\n********** 異常発生：log033_CDataLogReserv01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog033_Rtn?.serial_no,'abc12');
        expect(Testlog033_Rtn?.seq_no,9913);
        expect(Testlog033_Rtn?.cnct_seq_no,9914);
        expect(Testlog033_Rtn?.func_cd,9915);
        expect(Testlog033_Rtn?.func_seq_no,9916);
        expect(Testlog033_Rtn?.c_data1,'abc17');
        expect(Testlog033_Rtn?.c_data2,'abc18');
        expect(Testlog033_Rtn?.c_data3,'abc19');
        expect(Testlog033_Rtn?.c_data4,'abc20');
        expect(Testlog033_Rtn?.c_data5,'abc21');
        expect(Testlog033_Rtn?.c_data6,'abc22');
        expect(Testlog033_Rtn?.c_data7,'abc23');
        expect(Testlog033_Rtn?.c_data8,'abc24');
        expect(Testlog033_Rtn?.c_data9,'abc25');
        expect(Testlog033_Rtn?.c_data10,'abc26');
        expect(Testlog033_Rtn?.n_data1,1.227);
        expect(Testlog033_Rtn?.n_data2,1.228);
        expect(Testlog033_Rtn?.n_data3,1.229);
        expect(Testlog033_Rtn?.n_data4,1.230);
        expect(Testlog033_Rtn?.n_data5,1.231);
        expect(Testlog033_Rtn?.n_data6,1.232);
        expect(Testlog033_Rtn?.n_data7,1.233);
        expect(Testlog033_Rtn?.n_data8,1.234);
        expect(Testlog033_Rtn?.n_data9,1.235);
        expect(Testlog033_Rtn?.n_data10,1.236);
        expect(Testlog033_Rtn?.n_data11,1.237);
        expect(Testlog033_Rtn?.n_data12,1.238);
        expect(Testlog033_Rtn?.n_data13,1.239);
        expect(Testlog033_Rtn?.n_data14,1.240);
        expect(Testlog033_Rtn?.n_data15,1.241);
        expect(Testlog033_Rtn?.n_data16,1.242);
        expect(Testlog033_Rtn?.n_data17,1.243);
        expect(Testlog033_Rtn?.n_data18,1.244);
        expect(Testlog033_Rtn?.n_data19,1.245);
        expect(Testlog033_Rtn?.n_data20,1.246);
        expect(Testlog033_Rtn?.n_data21,1.247);
        expect(Testlog033_Rtn?.n_data22,1.248);
        expect(Testlog033_Rtn?.n_data23,1.249);
        expect(Testlog033_Rtn?.n_data24,1.250);
        expect(Testlog033_Rtn?.n_data25,1.251);
        expect(Testlog033_Rtn?.n_data26,1.252);
        expect(Testlog033_Rtn?.n_data27,1.253);
        expect(Testlog033_Rtn?.n_data28,1.254);
        expect(Testlog033_Rtn?.n_data29,1.255);
        expect(Testlog033_Rtn?.n_data30,1.256);
        expect(Testlog033_Rtn?.d_data1,'abc57');
        expect(Testlog033_Rtn?.d_data2,'abc58');
        expect(Testlog033_Rtn?.d_data3,'abc59');
        expect(Testlog033_Rtn?.d_data4,'abc60');
        expect(Testlog033_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLogReserv01> Testlog033_AllRtn2 = await db.selectAllData(Testlog033_1);
      int count2 = Testlog033_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog033_1);
      print('********** テスト終了：log033_CDataLogReserv01_01 **********\n\n');
    });

    // ********************************************************
    // テストlog034 : CHeaderLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log034_CHeaderLog01_01', () async {
      print('\n********** テスト実行：log034_CHeaderLog01_01 **********');
      CHeaderLog01 Testlog034_1 = CHeaderLog01();
      Testlog034_1.serial_no = 'abc01';
      Testlog034_1.comp_cd = 9913;
      Testlog034_1.stre_cd = 9914;
      Testlog034_1.mac_no = 9915;
      Testlog034_1.receipt_no = 9916;
      Testlog034_1.print_no = 9917;
      Testlog034_1.cshr_no = 9918;
      Testlog034_1.chkr_no = 9919;
      Testlog034_1.cust_no = 'abc20';
      Testlog034_1.sale_date = 'abc21';
      Testlog034_1.starttime = 'abc22';
      Testlog034_1.endtime = 'abc23';
      Testlog034_1.ope_mode_flg = 9924;
      Testlog034_1.inout_flg = 9925;
      Testlog034_1.prn_typ = 9926;
      Testlog034_1.void_serial_no = 'abc27';
      Testlog034_1.qc_serial_no = 'abc28';
      Testlog034_1.void_kind = 9929;
      Testlog034_1.void_sale_date = 'abc30';
      Testlog034_1.data_log_cnt = 9931;
      Testlog034_1.ej_log_cnt = 9932;
      Testlog034_1.status_log_cnt = 9933;
      Testlog034_1.tran_flg = 9934;
      Testlog034_1.sub_tran_flg = 9935;
      Testlog034_1.off_entry_flg = 9936;
      Testlog034_1.various_flg_1 = 9937;
      Testlog034_1.various_flg_2 = 9938;
      Testlog034_1.various_flg_3 = 9939;
      Testlog034_1.various_num_1 = 9940;
      Testlog034_1.various_num_2 = 9941;
      Testlog034_1.various_num_3 = 9942;
      Testlog034_1.various_data = 'abc43';
      Testlog034_1.various_flg_4 = 9944;
      Testlog034_1.various_flg_5 = 9945;
      Testlog034_1.various_flg_6 = 9946;
      Testlog034_1.various_flg_7 = 9947;
      Testlog034_1.various_flg_8 = 9948;
      Testlog034_1.various_flg_9 = 9949;
      Testlog034_1.various_flg_10 = 9950;
      Testlog034_1.various_flg_11 = 9951;
      Testlog034_1.various_flg_12 = 9952;
      Testlog034_1.various_flg_13 = 9953;
      Testlog034_1.reserv_flg = 9954;
      Testlog034_1.reserv_stre_cd = 9955;
      Testlog034_1.reserv_status = 9956;
      Testlog034_1.reserv_chg_cnt = 9957;
      Testlog034_1.reserv_cd = 'abc58';
      Testlog034_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog01> Testlog034_AllRtn = await db.selectAllData(Testlog034_1);
      int count = Testlog034_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog034_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog01 Testlog034_2 = CHeaderLog01();
      //Keyの値を設定する
      Testlog034_2.serial_no = 'abc01';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog01? Testlog034_Rtn = await db.selectDataByPrimaryKey(Testlog034_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog034_Rtn == null) {
        print('\n********** 異常発生：log034_CHeaderLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog034_Rtn?.serial_no,'abc01');
        expect(Testlog034_Rtn?.comp_cd,9913);
        expect(Testlog034_Rtn?.stre_cd,9914);
        expect(Testlog034_Rtn?.mac_no,9915);
        expect(Testlog034_Rtn?.receipt_no,9916);
        expect(Testlog034_Rtn?.print_no,9917);
        expect(Testlog034_Rtn?.cshr_no,9918);
        expect(Testlog034_Rtn?.chkr_no,9919);
        expect(Testlog034_Rtn?.cust_no,'abc20');
        expect(Testlog034_Rtn?.sale_date,'abc21');
        expect(Testlog034_Rtn?.starttime,'abc22');
        expect(Testlog034_Rtn?.endtime,'abc23');
        expect(Testlog034_Rtn?.ope_mode_flg,9924);
        expect(Testlog034_Rtn?.inout_flg,9925);
        expect(Testlog034_Rtn?.prn_typ,9926);
        expect(Testlog034_Rtn?.void_serial_no,'abc27');
        expect(Testlog034_Rtn?.qc_serial_no,'abc28');
        expect(Testlog034_Rtn?.void_kind,9929);
        expect(Testlog034_Rtn?.void_sale_date,'abc30');
        expect(Testlog034_Rtn?.data_log_cnt,9931);
        expect(Testlog034_Rtn?.ej_log_cnt,9932);
        expect(Testlog034_Rtn?.status_log_cnt,9933);
        expect(Testlog034_Rtn?.tran_flg,9934);
        expect(Testlog034_Rtn?.sub_tran_flg,9935);
        expect(Testlog034_Rtn?.off_entry_flg,9936);
        expect(Testlog034_Rtn?.various_flg_1,9937);
        expect(Testlog034_Rtn?.various_flg_2,9938);
        expect(Testlog034_Rtn?.various_flg_3,9939);
        expect(Testlog034_Rtn?.various_num_1,9940);
        expect(Testlog034_Rtn?.various_num_2,9941);
        expect(Testlog034_Rtn?.various_num_3,9942);
        expect(Testlog034_Rtn?.various_data,'abc43');
        expect(Testlog034_Rtn?.various_flg_4,9944);
        expect(Testlog034_Rtn?.various_flg_5,9945);
        expect(Testlog034_Rtn?.various_flg_6,9946);
        expect(Testlog034_Rtn?.various_flg_7,9947);
        expect(Testlog034_Rtn?.various_flg_8,9948);
        expect(Testlog034_Rtn?.various_flg_9,9949);
        expect(Testlog034_Rtn?.various_flg_10,9950);
        expect(Testlog034_Rtn?.various_flg_11,9951);
        expect(Testlog034_Rtn?.various_flg_12,9952);
        expect(Testlog034_Rtn?.various_flg_13,9953);
        expect(Testlog034_Rtn?.reserv_flg,9954);
        expect(Testlog034_Rtn?.reserv_stre_cd,9955);
        expect(Testlog034_Rtn?.reserv_status,9956);
        expect(Testlog034_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog034_Rtn?.reserv_cd,'abc58');
        expect(Testlog034_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog01> Testlog034_AllRtn2 = await db.selectAllData(Testlog034_1);
      int count2 = Testlog034_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog034_1);
      print('********** テスト終了：log034_CHeaderLog01_01 **********\n\n');
    });

    // ********************************************************
    // テストlog035 : CHeaderLog02
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log035_CHeaderLog02_01', () async {
      print('\n********** テスト実行：log035_CHeaderLog02_01 **********');
      CHeaderLog02 Testlog035_1 = CHeaderLog02();
      Testlog035_1.serial_no = 'abc02';
      Testlog035_1.comp_cd = 9913;
      Testlog035_1.stre_cd = 9914;
      Testlog035_1.mac_no = 9915;
      Testlog035_1.receipt_no = 9916;
      Testlog035_1.print_no = 9917;
      Testlog035_1.cshr_no = 9918;
      Testlog035_1.chkr_no = 9919;
      Testlog035_1.cust_no = 'abc20';
      Testlog035_1.sale_date = 'abc21';
      Testlog035_1.starttime = 'abc22';
      Testlog035_1.endtime = 'abc23';
      Testlog035_1.ope_mode_flg = 9924;
      Testlog035_1.inout_flg = 9925;
      Testlog035_1.prn_typ = 9926;
      Testlog035_1.void_serial_no = 'abc27';
      Testlog035_1.qc_serial_no = 'abc28';
      Testlog035_1.void_kind = 9929;
      Testlog035_1.void_sale_date = 'abc30';
      Testlog035_1.data_log_cnt = 9931;
      Testlog035_1.ej_log_cnt = 9932;
      Testlog035_1.status_log_cnt = 9933;
      Testlog035_1.tran_flg = 9934;
      Testlog035_1.sub_tran_flg = 9935;
      Testlog035_1.off_entry_flg = 9936;
      Testlog035_1.various_flg_1 = 9937;
      Testlog035_1.various_flg_2 = 9938;
      Testlog035_1.various_flg_3 = 9939;
      Testlog035_1.various_num_1 = 9940;
      Testlog035_1.various_num_2 = 9941;
      Testlog035_1.various_num_3 = 9942;
      Testlog035_1.various_data = 'abc43';
      Testlog035_1.various_flg_4 = 9944;
      Testlog035_1.various_flg_5 = 9945;
      Testlog035_1.various_flg_6 = 9946;
      Testlog035_1.various_flg_7 = 9947;
      Testlog035_1.various_flg_8 = 9948;
      Testlog035_1.various_flg_9 = 9949;
      Testlog035_1.various_flg_10 = 9950;
      Testlog035_1.various_flg_11 = 9951;
      Testlog035_1.various_flg_12 = 9952;
      Testlog035_1.various_flg_13 = 9953;
      Testlog035_1.reserv_flg = 9954;
      Testlog035_1.reserv_stre_cd = 9955;
      Testlog035_1.reserv_status = 9956;
      Testlog035_1.reserv_chg_cnt = 9957;
      Testlog035_1.reserv_cd = 'abc58';
      Testlog035_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog02> Testlog035_AllRtn = await db.selectAllData(Testlog035_1);
      int count = Testlog035_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog035_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog02 Testlog035_2 = CHeaderLog02();
      //Keyの値を設定する
      Testlog035_2.serial_no = 'abc02';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog02? Testlog035_Rtn = await db.selectDataByPrimaryKey(Testlog035_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog035_Rtn == null) {
        print('\n********** 異常発生：log035_CHeaderLog02_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog035_Rtn?.serial_no,'abc02');
        expect(Testlog035_Rtn?.comp_cd,9913);
        expect(Testlog035_Rtn?.stre_cd,9914);
        expect(Testlog035_Rtn?.mac_no,9915);
        expect(Testlog035_Rtn?.receipt_no,9916);
        expect(Testlog035_Rtn?.print_no,9917);
        expect(Testlog035_Rtn?.cshr_no,9918);
        expect(Testlog035_Rtn?.chkr_no,9919);
        expect(Testlog035_Rtn?.cust_no,'abc20');
        expect(Testlog035_Rtn?.sale_date,'abc21');
        expect(Testlog035_Rtn?.starttime,'abc22');
        expect(Testlog035_Rtn?.endtime,'abc23');
        expect(Testlog035_Rtn?.ope_mode_flg,9924);
        expect(Testlog035_Rtn?.inout_flg,9925);
        expect(Testlog035_Rtn?.prn_typ,9926);
        expect(Testlog035_Rtn?.void_serial_no,'abc27');
        expect(Testlog035_Rtn?.qc_serial_no,'abc28');
        expect(Testlog035_Rtn?.void_kind,9929);
        expect(Testlog035_Rtn?.void_sale_date,'abc30');
        expect(Testlog035_Rtn?.data_log_cnt,9931);
        expect(Testlog035_Rtn?.ej_log_cnt,9932);
        expect(Testlog035_Rtn?.status_log_cnt,9933);
        expect(Testlog035_Rtn?.tran_flg,9934);
        expect(Testlog035_Rtn?.sub_tran_flg,9935);
        expect(Testlog035_Rtn?.off_entry_flg,9936);
        expect(Testlog035_Rtn?.various_flg_1,9937);
        expect(Testlog035_Rtn?.various_flg_2,9938);
        expect(Testlog035_Rtn?.various_flg_3,9939);
        expect(Testlog035_Rtn?.various_num_1,9940);
        expect(Testlog035_Rtn?.various_num_2,9941);
        expect(Testlog035_Rtn?.various_num_3,9942);
        expect(Testlog035_Rtn?.various_data,'abc43');
        expect(Testlog035_Rtn?.various_flg_4,9944);
        expect(Testlog035_Rtn?.various_flg_5,9945);
        expect(Testlog035_Rtn?.various_flg_6,9946);
        expect(Testlog035_Rtn?.various_flg_7,9947);
        expect(Testlog035_Rtn?.various_flg_8,9948);
        expect(Testlog035_Rtn?.various_flg_9,9949);
        expect(Testlog035_Rtn?.various_flg_10,9950);
        expect(Testlog035_Rtn?.various_flg_11,9951);
        expect(Testlog035_Rtn?.various_flg_12,9952);
        expect(Testlog035_Rtn?.various_flg_13,9953);
        expect(Testlog035_Rtn?.reserv_flg,9954);
        expect(Testlog035_Rtn?.reserv_stre_cd,9955);
        expect(Testlog035_Rtn?.reserv_status,9956);
        expect(Testlog035_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog035_Rtn?.reserv_cd,'abc58');
        expect(Testlog035_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog02> Testlog035_AllRtn2 = await db.selectAllData(Testlog035_1);
      int count2 = Testlog035_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog035_1);
      print('********** テスト終了：log035_CHeaderLog02_01 **********\n\n');
    });

    // ********************************************************
    // テストlog036 : CHeaderLog03
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log036_CHeaderLog03_01', () async {
      print('\n********** テスト実行：log036_CHeaderLog03_01 **********');
      CHeaderLog03 Testlog036_1 = CHeaderLog03();
      Testlog036_1.serial_no = 'abc03';
      Testlog036_1.comp_cd = 9913;
      Testlog036_1.stre_cd = 9914;
      Testlog036_1.mac_no = 9915;
      Testlog036_1.receipt_no = 9916;
      Testlog036_1.print_no = 9917;
      Testlog036_1.cshr_no = 9918;
      Testlog036_1.chkr_no = 9919;
      Testlog036_1.cust_no = 'abc20';
      Testlog036_1.sale_date = 'abc21';
      Testlog036_1.starttime = 'abc22';
      Testlog036_1.endtime = 'abc23';
      Testlog036_1.ope_mode_flg = 9924;
      Testlog036_1.inout_flg = 9925;
      Testlog036_1.prn_typ = 9926;
      Testlog036_1.void_serial_no = 'abc27';
      Testlog036_1.qc_serial_no = 'abc28';
      Testlog036_1.void_kind = 9929;
      Testlog036_1.void_sale_date = 'abc30';
      Testlog036_1.data_log_cnt = 9931;
      Testlog036_1.ej_log_cnt = 9932;
      Testlog036_1.status_log_cnt = 9933;
      Testlog036_1.tran_flg = 9934;
      Testlog036_1.sub_tran_flg = 9935;
      Testlog036_1.off_entry_flg = 9936;
      Testlog036_1.various_flg_1 = 9937;
      Testlog036_1.various_flg_2 = 9938;
      Testlog036_1.various_flg_3 = 9939;
      Testlog036_1.various_num_1 = 9940;
      Testlog036_1.various_num_2 = 9941;
      Testlog036_1.various_num_3 = 9942;
      Testlog036_1.various_data = 'abc43';
      Testlog036_1.various_flg_4 = 9944;
      Testlog036_1.various_flg_5 = 9945;
      Testlog036_1.various_flg_6 = 9946;
      Testlog036_1.various_flg_7 = 9947;
      Testlog036_1.various_flg_8 = 9948;
      Testlog036_1.various_flg_9 = 9949;
      Testlog036_1.various_flg_10 = 9950;
      Testlog036_1.various_flg_11 = 9951;
      Testlog036_1.various_flg_12 = 9952;
      Testlog036_1.various_flg_13 = 9953;
      Testlog036_1.reserv_flg = 9954;
      Testlog036_1.reserv_stre_cd = 9955;
      Testlog036_1.reserv_status = 9956;
      Testlog036_1.reserv_chg_cnt = 9957;
      Testlog036_1.reserv_cd = 'abc58';
      Testlog036_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog03> Testlog036_AllRtn = await db.selectAllData(Testlog036_1);
      int count = Testlog036_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog036_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog03 Testlog036_2 = CHeaderLog03();
      //Keyの値を設定する
      Testlog036_2.serial_no = 'abc03';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog03? Testlog036_Rtn = await db.selectDataByPrimaryKey(Testlog036_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog036_Rtn == null) {
        print('\n********** 異常発生：log036_CHeaderLog03_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog036_Rtn?.serial_no,'abc03');
        expect(Testlog036_Rtn?.comp_cd,9913);
        expect(Testlog036_Rtn?.stre_cd,9914);
        expect(Testlog036_Rtn?.mac_no,9915);
        expect(Testlog036_Rtn?.receipt_no,9916);
        expect(Testlog036_Rtn?.print_no,9917);
        expect(Testlog036_Rtn?.cshr_no,9918);
        expect(Testlog036_Rtn?.chkr_no,9919);
        expect(Testlog036_Rtn?.cust_no,'abc20');
        expect(Testlog036_Rtn?.sale_date,'abc21');
        expect(Testlog036_Rtn?.starttime,'abc22');
        expect(Testlog036_Rtn?.endtime,'abc23');
        expect(Testlog036_Rtn?.ope_mode_flg,9924);
        expect(Testlog036_Rtn?.inout_flg,9925);
        expect(Testlog036_Rtn?.prn_typ,9926);
        expect(Testlog036_Rtn?.void_serial_no,'abc27');
        expect(Testlog036_Rtn?.qc_serial_no,'abc28');
        expect(Testlog036_Rtn?.void_kind,9929);
        expect(Testlog036_Rtn?.void_sale_date,'abc30');
        expect(Testlog036_Rtn?.data_log_cnt,9931);
        expect(Testlog036_Rtn?.ej_log_cnt,9932);
        expect(Testlog036_Rtn?.status_log_cnt,9933);
        expect(Testlog036_Rtn?.tran_flg,9934);
        expect(Testlog036_Rtn?.sub_tran_flg,9935);
        expect(Testlog036_Rtn?.off_entry_flg,9936);
        expect(Testlog036_Rtn?.various_flg_1,9937);
        expect(Testlog036_Rtn?.various_flg_2,9938);
        expect(Testlog036_Rtn?.various_flg_3,9939);
        expect(Testlog036_Rtn?.various_num_1,9940);
        expect(Testlog036_Rtn?.various_num_2,9941);
        expect(Testlog036_Rtn?.various_num_3,9942);
        expect(Testlog036_Rtn?.various_data,'abc43');
        expect(Testlog036_Rtn?.various_flg_4,9944);
        expect(Testlog036_Rtn?.various_flg_5,9945);
        expect(Testlog036_Rtn?.various_flg_6,9946);
        expect(Testlog036_Rtn?.various_flg_7,9947);
        expect(Testlog036_Rtn?.various_flg_8,9948);
        expect(Testlog036_Rtn?.various_flg_9,9949);
        expect(Testlog036_Rtn?.various_flg_10,9950);
        expect(Testlog036_Rtn?.various_flg_11,9951);
        expect(Testlog036_Rtn?.various_flg_12,9952);
        expect(Testlog036_Rtn?.various_flg_13,9953);
        expect(Testlog036_Rtn?.reserv_flg,9954);
        expect(Testlog036_Rtn?.reserv_stre_cd,9955);
        expect(Testlog036_Rtn?.reserv_status,9956);
        expect(Testlog036_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog036_Rtn?.reserv_cd,'abc58');
        expect(Testlog036_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog03> Testlog036_AllRtn2 = await db.selectAllData(Testlog036_1);
      int count2 = Testlog036_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog036_1);
      print('********** テスト終了：log036_CHeaderLog03_01 **********\n\n');
    });

    // ********************************************************
    // テストlog037 : CHeaderLog04
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log037_CHeaderLog04_01', () async {
      print('\n********** テスト実行：log037_CHeaderLog04_01 **********');
      CHeaderLog04 Testlog037_1 = CHeaderLog04();
      Testlog037_1.serial_no = 'abc04';
      Testlog037_1.comp_cd = 9913;
      Testlog037_1.stre_cd = 9914;
      Testlog037_1.mac_no = 9915;
      Testlog037_1.receipt_no = 9916;
      Testlog037_1.print_no = 9917;
      Testlog037_1.cshr_no = 9918;
      Testlog037_1.chkr_no = 9919;
      Testlog037_1.cust_no = 'abc20';
      Testlog037_1.sale_date = 'abc21';
      Testlog037_1.starttime = 'abc22';
      Testlog037_1.endtime = 'abc23';
      Testlog037_1.ope_mode_flg = 9924;
      Testlog037_1.inout_flg = 9925;
      Testlog037_1.prn_typ = 9926;
      Testlog037_1.void_serial_no = 'abc27';
      Testlog037_1.qc_serial_no = 'abc28';
      Testlog037_1.void_kind = 9929;
      Testlog037_1.void_sale_date = 'abc30';
      Testlog037_1.data_log_cnt = 9931;
      Testlog037_1.ej_log_cnt = 9932;
      Testlog037_1.status_log_cnt = 9933;
      Testlog037_1.tran_flg = 9934;
      Testlog037_1.sub_tran_flg = 9935;
      Testlog037_1.off_entry_flg = 9936;
      Testlog037_1.various_flg_1 = 9937;
      Testlog037_1.various_flg_2 = 9938;
      Testlog037_1.various_flg_3 = 9939;
      Testlog037_1.various_num_1 = 9940;
      Testlog037_1.various_num_2 = 9941;
      Testlog037_1.various_num_3 = 9942;
      Testlog037_1.various_data = 'abc43';
      Testlog037_1.various_flg_4 = 9944;
      Testlog037_1.various_flg_5 = 9945;
      Testlog037_1.various_flg_6 = 9946;
      Testlog037_1.various_flg_7 = 9947;
      Testlog037_1.various_flg_8 = 9948;
      Testlog037_1.various_flg_9 = 9949;
      Testlog037_1.various_flg_10 = 9950;
      Testlog037_1.various_flg_11 = 9951;
      Testlog037_1.various_flg_12 = 9952;
      Testlog037_1.various_flg_13 = 9953;
      Testlog037_1.reserv_flg = 9954;
      Testlog037_1.reserv_stre_cd = 9955;
      Testlog037_1.reserv_status = 9956;
      Testlog037_1.reserv_chg_cnt = 9957;
      Testlog037_1.reserv_cd = 'abc58';
      Testlog037_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog04> Testlog037_AllRtn = await db.selectAllData(Testlog037_1);
      int count = Testlog037_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog037_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog04 Testlog037_2 = CHeaderLog04();
      //Keyの値を設定する
      Testlog037_2.serial_no = 'abc04';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog04? Testlog037_Rtn = await db.selectDataByPrimaryKey(Testlog037_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog037_Rtn == null) {
        print('\n********** 異常発生：log037_CHeaderLog04_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog037_Rtn?.serial_no,'abc04');
        expect(Testlog037_Rtn?.comp_cd,9913);
        expect(Testlog037_Rtn?.stre_cd,9914);
        expect(Testlog037_Rtn?.mac_no,9915);
        expect(Testlog037_Rtn?.receipt_no,9916);
        expect(Testlog037_Rtn?.print_no,9917);
        expect(Testlog037_Rtn?.cshr_no,9918);
        expect(Testlog037_Rtn?.chkr_no,9919);
        expect(Testlog037_Rtn?.cust_no,'abc20');
        expect(Testlog037_Rtn?.sale_date,'abc21');
        expect(Testlog037_Rtn?.starttime,'abc22');
        expect(Testlog037_Rtn?.endtime,'abc23');
        expect(Testlog037_Rtn?.ope_mode_flg,9924);
        expect(Testlog037_Rtn?.inout_flg,9925);
        expect(Testlog037_Rtn?.prn_typ,9926);
        expect(Testlog037_Rtn?.void_serial_no,'abc27');
        expect(Testlog037_Rtn?.qc_serial_no,'abc28');
        expect(Testlog037_Rtn?.void_kind,9929);
        expect(Testlog037_Rtn?.void_sale_date,'abc30');
        expect(Testlog037_Rtn?.data_log_cnt,9931);
        expect(Testlog037_Rtn?.ej_log_cnt,9932);
        expect(Testlog037_Rtn?.status_log_cnt,9933);
        expect(Testlog037_Rtn?.tran_flg,9934);
        expect(Testlog037_Rtn?.sub_tran_flg,9935);
        expect(Testlog037_Rtn?.off_entry_flg,9936);
        expect(Testlog037_Rtn?.various_flg_1,9937);
        expect(Testlog037_Rtn?.various_flg_2,9938);
        expect(Testlog037_Rtn?.various_flg_3,9939);
        expect(Testlog037_Rtn?.various_num_1,9940);
        expect(Testlog037_Rtn?.various_num_2,9941);
        expect(Testlog037_Rtn?.various_num_3,9942);
        expect(Testlog037_Rtn?.various_data,'abc43');
        expect(Testlog037_Rtn?.various_flg_4,9944);
        expect(Testlog037_Rtn?.various_flg_5,9945);
        expect(Testlog037_Rtn?.various_flg_6,9946);
        expect(Testlog037_Rtn?.various_flg_7,9947);
        expect(Testlog037_Rtn?.various_flg_8,9948);
        expect(Testlog037_Rtn?.various_flg_9,9949);
        expect(Testlog037_Rtn?.various_flg_10,9950);
        expect(Testlog037_Rtn?.various_flg_11,9951);
        expect(Testlog037_Rtn?.various_flg_12,9952);
        expect(Testlog037_Rtn?.various_flg_13,9953);
        expect(Testlog037_Rtn?.reserv_flg,9954);
        expect(Testlog037_Rtn?.reserv_stre_cd,9955);
        expect(Testlog037_Rtn?.reserv_status,9956);
        expect(Testlog037_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog037_Rtn?.reserv_cd,'abc58');
        expect(Testlog037_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog04> Testlog037_AllRtn2 = await db.selectAllData(Testlog037_1);
      int count2 = Testlog037_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog037_1);
      print('********** テスト終了：log037_CHeaderLog04_01 **********\n\n');
    });

    // ********************************************************
    // テストlog038 : CHeaderLog05
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log038_CHeaderLog05_01', () async {
      print('\n********** テスト実行：log038_CHeaderLog05_01 **********');
      CHeaderLog05 Testlog038_1 = CHeaderLog05();
      Testlog038_1.serial_no = 'abc05';
      Testlog038_1.comp_cd = 9913;
      Testlog038_1.stre_cd = 9914;
      Testlog038_1.mac_no = 9915;
      Testlog038_1.receipt_no = 9916;
      Testlog038_1.print_no = 9917;
      Testlog038_1.cshr_no = 9918;
      Testlog038_1.chkr_no = 9919;
      Testlog038_1.cust_no = 'abc20';
      Testlog038_1.sale_date = 'abc21';
      Testlog038_1.starttime = 'abc22';
      Testlog038_1.endtime = 'abc23';
      Testlog038_1.ope_mode_flg = 9924;
      Testlog038_1.inout_flg = 9925;
      Testlog038_1.prn_typ = 9926;
      Testlog038_1.void_serial_no = 'abc27';
      Testlog038_1.qc_serial_no = 'abc28';
      Testlog038_1.void_kind = 9929;
      Testlog038_1.void_sale_date = 'abc30';
      Testlog038_1.data_log_cnt = 9931;
      Testlog038_1.ej_log_cnt = 9932;
      Testlog038_1.status_log_cnt = 9933;
      Testlog038_1.tran_flg = 9934;
      Testlog038_1.sub_tran_flg = 9935;
      Testlog038_1.off_entry_flg = 9936;
      Testlog038_1.various_flg_1 = 9937;
      Testlog038_1.various_flg_2 = 9938;
      Testlog038_1.various_flg_3 = 9939;
      Testlog038_1.various_num_1 = 9940;
      Testlog038_1.various_num_2 = 9941;
      Testlog038_1.various_num_3 = 9942;
      Testlog038_1.various_data = 'abc43';
      Testlog038_1.various_flg_4 = 9944;
      Testlog038_1.various_flg_5 = 9945;
      Testlog038_1.various_flg_6 = 9946;
      Testlog038_1.various_flg_7 = 9947;
      Testlog038_1.various_flg_8 = 9948;
      Testlog038_1.various_flg_9 = 9949;
      Testlog038_1.various_flg_10 = 9950;
      Testlog038_1.various_flg_11 = 9951;
      Testlog038_1.various_flg_12 = 9952;
      Testlog038_1.various_flg_13 = 9953;
      Testlog038_1.reserv_flg = 9954;
      Testlog038_1.reserv_stre_cd = 9955;
      Testlog038_1.reserv_status = 9956;
      Testlog038_1.reserv_chg_cnt = 9957;
      Testlog038_1.reserv_cd = 'abc58';
      Testlog038_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog05> Testlog038_AllRtn = await db.selectAllData(Testlog038_1);
      int count = Testlog038_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog038_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog05 Testlog038_2 = CHeaderLog05();
      //Keyの値を設定する
      Testlog038_2.serial_no = 'abc05';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog05? Testlog038_Rtn = await db.selectDataByPrimaryKey(Testlog038_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog038_Rtn == null) {
        print('\n********** 異常発生：log038_CHeaderLog05_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog038_Rtn?.serial_no,'abc05');
        expect(Testlog038_Rtn?.comp_cd,9913);
        expect(Testlog038_Rtn?.stre_cd,9914);
        expect(Testlog038_Rtn?.mac_no,9915);
        expect(Testlog038_Rtn?.receipt_no,9916);
        expect(Testlog038_Rtn?.print_no,9917);
        expect(Testlog038_Rtn?.cshr_no,9918);
        expect(Testlog038_Rtn?.chkr_no,9919);
        expect(Testlog038_Rtn?.cust_no,'abc20');
        expect(Testlog038_Rtn?.sale_date,'abc21');
        expect(Testlog038_Rtn?.starttime,'abc22');
        expect(Testlog038_Rtn?.endtime,'abc23');
        expect(Testlog038_Rtn?.ope_mode_flg,9924);
        expect(Testlog038_Rtn?.inout_flg,9925);
        expect(Testlog038_Rtn?.prn_typ,9926);
        expect(Testlog038_Rtn?.void_serial_no,'abc27');
        expect(Testlog038_Rtn?.qc_serial_no,'abc28');
        expect(Testlog038_Rtn?.void_kind,9929);
        expect(Testlog038_Rtn?.void_sale_date,'abc30');
        expect(Testlog038_Rtn?.data_log_cnt,9931);
        expect(Testlog038_Rtn?.ej_log_cnt,9932);
        expect(Testlog038_Rtn?.status_log_cnt,9933);
        expect(Testlog038_Rtn?.tran_flg,9934);
        expect(Testlog038_Rtn?.sub_tran_flg,9935);
        expect(Testlog038_Rtn?.off_entry_flg,9936);
        expect(Testlog038_Rtn?.various_flg_1,9937);
        expect(Testlog038_Rtn?.various_flg_2,9938);
        expect(Testlog038_Rtn?.various_flg_3,9939);
        expect(Testlog038_Rtn?.various_num_1,9940);
        expect(Testlog038_Rtn?.various_num_2,9941);
        expect(Testlog038_Rtn?.various_num_3,9942);
        expect(Testlog038_Rtn?.various_data,'abc43');
        expect(Testlog038_Rtn?.various_flg_4,9944);
        expect(Testlog038_Rtn?.various_flg_5,9945);
        expect(Testlog038_Rtn?.various_flg_6,9946);
        expect(Testlog038_Rtn?.various_flg_7,9947);
        expect(Testlog038_Rtn?.various_flg_8,9948);
        expect(Testlog038_Rtn?.various_flg_9,9949);
        expect(Testlog038_Rtn?.various_flg_10,9950);
        expect(Testlog038_Rtn?.various_flg_11,9951);
        expect(Testlog038_Rtn?.various_flg_12,9952);
        expect(Testlog038_Rtn?.various_flg_13,9953);
        expect(Testlog038_Rtn?.reserv_flg,9954);
        expect(Testlog038_Rtn?.reserv_stre_cd,9955);
        expect(Testlog038_Rtn?.reserv_status,9956);
        expect(Testlog038_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog038_Rtn?.reserv_cd,'abc58');
        expect(Testlog038_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog05> Testlog038_AllRtn2 = await db.selectAllData(Testlog038_1);
      int count2 = Testlog038_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog038_1);
      print('********** テスト終了：log038_CHeaderLog05_01 **********\n\n');
    });

    // ********************************************************
    // テストlog039 : CHeaderLog06
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log039_CHeaderLog06_01', () async {
      print('\n********** テスト実行：log039_CHeaderLog06_01 **********');
      CHeaderLog06 Testlog039_1 = CHeaderLog06();
      Testlog039_1.serial_no = 'abc06';
      Testlog039_1.comp_cd = 9913;
      Testlog039_1.stre_cd = 9914;
      Testlog039_1.mac_no = 9915;
      Testlog039_1.receipt_no = 9916;
      Testlog039_1.print_no = 9917;
      Testlog039_1.cshr_no = 9918;
      Testlog039_1.chkr_no = 9919;
      Testlog039_1.cust_no = 'abc20';
      Testlog039_1.sale_date = 'abc21';
      Testlog039_1.starttime = 'abc22';
      Testlog039_1.endtime = 'abc23';
      Testlog039_1.ope_mode_flg = 9924;
      Testlog039_1.inout_flg = 9925;
      Testlog039_1.prn_typ = 9926;
      Testlog039_1.void_serial_no = 'abc27';
      Testlog039_1.qc_serial_no = 'abc28';
      Testlog039_1.void_kind = 9929;
      Testlog039_1.void_sale_date = 'abc30';
      Testlog039_1.data_log_cnt = 9931;
      Testlog039_1.ej_log_cnt = 9932;
      Testlog039_1.status_log_cnt = 9933;
      Testlog039_1.tran_flg = 9934;
      Testlog039_1.sub_tran_flg = 9935;
      Testlog039_1.off_entry_flg = 9936;
      Testlog039_1.various_flg_1 = 9937;
      Testlog039_1.various_flg_2 = 9938;
      Testlog039_1.various_flg_3 = 9939;
      Testlog039_1.various_num_1 = 9940;
      Testlog039_1.various_num_2 = 9941;
      Testlog039_1.various_num_3 = 9942;
      Testlog039_1.various_data = 'abc43';
      Testlog039_1.various_flg_4 = 9944;
      Testlog039_1.various_flg_5 = 9945;
      Testlog039_1.various_flg_6 = 9946;
      Testlog039_1.various_flg_7 = 9947;
      Testlog039_1.various_flg_8 = 9948;
      Testlog039_1.various_flg_9 = 9949;
      Testlog039_1.various_flg_10 = 9950;
      Testlog039_1.various_flg_11 = 9951;
      Testlog039_1.various_flg_12 = 9952;
      Testlog039_1.various_flg_13 = 9953;
      Testlog039_1.reserv_flg = 9954;
      Testlog039_1.reserv_stre_cd = 9955;
      Testlog039_1.reserv_status = 9956;
      Testlog039_1.reserv_chg_cnt = 9957;
      Testlog039_1.reserv_cd = 'abc58';
      Testlog039_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog06> Testlog039_AllRtn = await db.selectAllData(Testlog039_1);
      int count = Testlog039_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog039_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog06 Testlog039_2 = CHeaderLog06();
      //Keyの値を設定する
      Testlog039_2.serial_no = 'abc06';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog06? Testlog039_Rtn = await db.selectDataByPrimaryKey(Testlog039_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog039_Rtn == null) {
        print('\n********** 異常発生：log039_CHeaderLog06_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog039_Rtn?.serial_no,'abc06');
        expect(Testlog039_Rtn?.comp_cd,9913);
        expect(Testlog039_Rtn?.stre_cd,9914);
        expect(Testlog039_Rtn?.mac_no,9915);
        expect(Testlog039_Rtn?.receipt_no,9916);
        expect(Testlog039_Rtn?.print_no,9917);
        expect(Testlog039_Rtn?.cshr_no,9918);
        expect(Testlog039_Rtn?.chkr_no,9919);
        expect(Testlog039_Rtn?.cust_no,'abc20');
        expect(Testlog039_Rtn?.sale_date,'abc21');
        expect(Testlog039_Rtn?.starttime,'abc22');
        expect(Testlog039_Rtn?.endtime,'abc23');
        expect(Testlog039_Rtn?.ope_mode_flg,9924);
        expect(Testlog039_Rtn?.inout_flg,9925);
        expect(Testlog039_Rtn?.prn_typ,9926);
        expect(Testlog039_Rtn?.void_serial_no,'abc27');
        expect(Testlog039_Rtn?.qc_serial_no,'abc28');
        expect(Testlog039_Rtn?.void_kind,9929);
        expect(Testlog039_Rtn?.void_sale_date,'abc30');
        expect(Testlog039_Rtn?.data_log_cnt,9931);
        expect(Testlog039_Rtn?.ej_log_cnt,9932);
        expect(Testlog039_Rtn?.status_log_cnt,9933);
        expect(Testlog039_Rtn?.tran_flg,9934);
        expect(Testlog039_Rtn?.sub_tran_flg,9935);
        expect(Testlog039_Rtn?.off_entry_flg,9936);
        expect(Testlog039_Rtn?.various_flg_1,9937);
        expect(Testlog039_Rtn?.various_flg_2,9938);
        expect(Testlog039_Rtn?.various_flg_3,9939);
        expect(Testlog039_Rtn?.various_num_1,9940);
        expect(Testlog039_Rtn?.various_num_2,9941);
        expect(Testlog039_Rtn?.various_num_3,9942);
        expect(Testlog039_Rtn?.various_data,'abc43');
        expect(Testlog039_Rtn?.various_flg_4,9944);
        expect(Testlog039_Rtn?.various_flg_5,9945);
        expect(Testlog039_Rtn?.various_flg_6,9946);
        expect(Testlog039_Rtn?.various_flg_7,9947);
        expect(Testlog039_Rtn?.various_flg_8,9948);
        expect(Testlog039_Rtn?.various_flg_9,9949);
        expect(Testlog039_Rtn?.various_flg_10,9950);
        expect(Testlog039_Rtn?.various_flg_11,9951);
        expect(Testlog039_Rtn?.various_flg_12,9952);
        expect(Testlog039_Rtn?.various_flg_13,9953);
        expect(Testlog039_Rtn?.reserv_flg,9954);
        expect(Testlog039_Rtn?.reserv_stre_cd,9955);
        expect(Testlog039_Rtn?.reserv_status,9956);
        expect(Testlog039_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog039_Rtn?.reserv_cd,'abc58');
        expect(Testlog039_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog06> Testlog039_AllRtn2 = await db.selectAllData(Testlog039_1);
      int count2 = Testlog039_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog039_1);
      print('********** テスト終了：log039_CHeaderLog06_01 **********\n\n');
    });

    // ********************************************************
    // テストlog040 : CHeaderLog07
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log040_CHeaderLog07_01', () async {
      print('\n********** テスト実行：log040_CHeaderLog07_01 **********');
      CHeaderLog07 Testlog040_1 = CHeaderLog07();
      Testlog040_1.serial_no = 'abc07';
      Testlog040_1.comp_cd = 9913;
      Testlog040_1.stre_cd = 9914;
      Testlog040_1.mac_no = 9915;
      Testlog040_1.receipt_no = 9916;
      Testlog040_1.print_no = 9917;
      Testlog040_1.cshr_no = 9918;
      Testlog040_1.chkr_no = 9919;
      Testlog040_1.cust_no = 'abc20';
      Testlog040_1.sale_date = 'abc21';
      Testlog040_1.starttime = 'abc22';
      Testlog040_1.endtime = 'abc23';
      Testlog040_1.ope_mode_flg = 9924;
      Testlog040_1.inout_flg = 9925;
      Testlog040_1.prn_typ = 9926;
      Testlog040_1.void_serial_no = 'abc27';
      Testlog040_1.qc_serial_no = 'abc28';
      Testlog040_1.void_kind = 9929;
      Testlog040_1.void_sale_date = 'abc30';
      Testlog040_1.data_log_cnt = 9931;
      Testlog040_1.ej_log_cnt = 9932;
      Testlog040_1.status_log_cnt = 9933;
      Testlog040_1.tran_flg = 9934;
      Testlog040_1.sub_tran_flg = 9935;
      Testlog040_1.off_entry_flg = 9936;
      Testlog040_1.various_flg_1 = 9937;
      Testlog040_1.various_flg_2 = 9938;
      Testlog040_1.various_flg_3 = 9939;
      Testlog040_1.various_num_1 = 9940;
      Testlog040_1.various_num_2 = 9941;
      Testlog040_1.various_num_3 = 9942;
      Testlog040_1.various_data = 'abc43';
      Testlog040_1.various_flg_4 = 9944;
      Testlog040_1.various_flg_5 = 9945;
      Testlog040_1.various_flg_6 = 9946;
      Testlog040_1.various_flg_7 = 9947;
      Testlog040_1.various_flg_8 = 9948;
      Testlog040_1.various_flg_9 = 9949;
      Testlog040_1.various_flg_10 = 9950;
      Testlog040_1.various_flg_11 = 9951;
      Testlog040_1.various_flg_12 = 9952;
      Testlog040_1.various_flg_13 = 9953;
      Testlog040_1.reserv_flg = 9954;
      Testlog040_1.reserv_stre_cd = 9955;
      Testlog040_1.reserv_status = 9956;
      Testlog040_1.reserv_chg_cnt = 9957;
      Testlog040_1.reserv_cd = 'abc58';
      Testlog040_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog07> Testlog040_AllRtn = await db.selectAllData(Testlog040_1);
      int count = Testlog040_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog040_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog07 Testlog040_2 = CHeaderLog07();
      //Keyの値を設定する
      Testlog040_2.serial_no = 'abc07';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog07? Testlog040_Rtn = await db.selectDataByPrimaryKey(Testlog040_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog040_Rtn == null) {
        print('\n********** 異常発生：log040_CHeaderLog07_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog040_Rtn?.serial_no,'abc07');
        expect(Testlog040_Rtn?.comp_cd,9913);
        expect(Testlog040_Rtn?.stre_cd,9914);
        expect(Testlog040_Rtn?.mac_no,9915);
        expect(Testlog040_Rtn?.receipt_no,9916);
        expect(Testlog040_Rtn?.print_no,9917);
        expect(Testlog040_Rtn?.cshr_no,9918);
        expect(Testlog040_Rtn?.chkr_no,9919);
        expect(Testlog040_Rtn?.cust_no,'abc20');
        expect(Testlog040_Rtn?.sale_date,'abc21');
        expect(Testlog040_Rtn?.starttime,'abc22');
        expect(Testlog040_Rtn?.endtime,'abc23');
        expect(Testlog040_Rtn?.ope_mode_flg,9924);
        expect(Testlog040_Rtn?.inout_flg,9925);
        expect(Testlog040_Rtn?.prn_typ,9926);
        expect(Testlog040_Rtn?.void_serial_no,'abc27');
        expect(Testlog040_Rtn?.qc_serial_no,'abc28');
        expect(Testlog040_Rtn?.void_kind,9929);
        expect(Testlog040_Rtn?.void_sale_date,'abc30');
        expect(Testlog040_Rtn?.data_log_cnt,9931);
        expect(Testlog040_Rtn?.ej_log_cnt,9932);
        expect(Testlog040_Rtn?.status_log_cnt,9933);
        expect(Testlog040_Rtn?.tran_flg,9934);
        expect(Testlog040_Rtn?.sub_tran_flg,9935);
        expect(Testlog040_Rtn?.off_entry_flg,9936);
        expect(Testlog040_Rtn?.various_flg_1,9937);
        expect(Testlog040_Rtn?.various_flg_2,9938);
        expect(Testlog040_Rtn?.various_flg_3,9939);
        expect(Testlog040_Rtn?.various_num_1,9940);
        expect(Testlog040_Rtn?.various_num_2,9941);
        expect(Testlog040_Rtn?.various_num_3,9942);
        expect(Testlog040_Rtn?.various_data,'abc43');
        expect(Testlog040_Rtn?.various_flg_4,9944);
        expect(Testlog040_Rtn?.various_flg_5,9945);
        expect(Testlog040_Rtn?.various_flg_6,9946);
        expect(Testlog040_Rtn?.various_flg_7,9947);
        expect(Testlog040_Rtn?.various_flg_8,9948);
        expect(Testlog040_Rtn?.various_flg_9,9949);
        expect(Testlog040_Rtn?.various_flg_10,9950);
        expect(Testlog040_Rtn?.various_flg_11,9951);
        expect(Testlog040_Rtn?.various_flg_12,9952);
        expect(Testlog040_Rtn?.various_flg_13,9953);
        expect(Testlog040_Rtn?.reserv_flg,9954);
        expect(Testlog040_Rtn?.reserv_stre_cd,9955);
        expect(Testlog040_Rtn?.reserv_status,9956);
        expect(Testlog040_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog040_Rtn?.reserv_cd,'abc58');
        expect(Testlog040_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog07> Testlog040_AllRtn2 = await db.selectAllData(Testlog040_1);
      int count2 = Testlog040_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog040_1);
      print('********** テスト終了：log040_CHeaderLog07_01 **********\n\n');
    });

    // ********************************************************
    // テストlog041 : CHeaderLog08
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log041_CHeaderLog08_01', () async {
      print('\n********** テスト実行：log041_CHeaderLog08_01 **********');
      CHeaderLog08 Testlog041_1 = CHeaderLog08();
      Testlog041_1.serial_no = 'abc08';
      Testlog041_1.comp_cd = 9913;
      Testlog041_1.stre_cd = 9914;
      Testlog041_1.mac_no = 9915;
      Testlog041_1.receipt_no = 9916;
      Testlog041_1.print_no = 9917;
      Testlog041_1.cshr_no = 9918;
      Testlog041_1.chkr_no = 9919;
      Testlog041_1.cust_no = 'abc20';
      Testlog041_1.sale_date = 'abc21';
      Testlog041_1.starttime = 'abc22';
      Testlog041_1.endtime = 'abc23';
      Testlog041_1.ope_mode_flg = 9924;
      Testlog041_1.inout_flg = 9925;
      Testlog041_1.prn_typ = 9926;
      Testlog041_1.void_serial_no = 'abc27';
      Testlog041_1.qc_serial_no = 'abc28';
      Testlog041_1.void_kind = 9929;
      Testlog041_1.void_sale_date = 'abc30';
      Testlog041_1.data_log_cnt = 9931;
      Testlog041_1.ej_log_cnt = 9932;
      Testlog041_1.status_log_cnt = 9933;
      Testlog041_1.tran_flg = 9934;
      Testlog041_1.sub_tran_flg = 9935;
      Testlog041_1.off_entry_flg = 9936;
      Testlog041_1.various_flg_1 = 9937;
      Testlog041_1.various_flg_2 = 9938;
      Testlog041_1.various_flg_3 = 9939;
      Testlog041_1.various_num_1 = 9940;
      Testlog041_1.various_num_2 = 9941;
      Testlog041_1.various_num_3 = 9942;
      Testlog041_1.various_data = 'abc43';
      Testlog041_1.various_flg_4 = 9944;
      Testlog041_1.various_flg_5 = 9945;
      Testlog041_1.various_flg_6 = 9946;
      Testlog041_1.various_flg_7 = 9947;
      Testlog041_1.various_flg_8 = 9948;
      Testlog041_1.various_flg_9 = 9949;
      Testlog041_1.various_flg_10 = 9950;
      Testlog041_1.various_flg_11 = 9951;
      Testlog041_1.various_flg_12 = 9952;
      Testlog041_1.various_flg_13 = 9953;
      Testlog041_1.reserv_flg = 9954;
      Testlog041_1.reserv_stre_cd = 9955;
      Testlog041_1.reserv_status = 9956;
      Testlog041_1.reserv_chg_cnt = 9957;
      Testlog041_1.reserv_cd = 'abc58';
      Testlog041_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog08> Testlog041_AllRtn = await db.selectAllData(Testlog041_1);
      int count = Testlog041_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog041_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog08 Testlog041_2 = CHeaderLog08();
      //Keyの値を設定する
      Testlog041_2.serial_no = 'abc08';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog08? Testlog041_Rtn = await db.selectDataByPrimaryKey(Testlog041_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog041_Rtn == null) {
        print('\n********** 異常発生：log041_CHeaderLog08_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog041_Rtn?.serial_no,'abc08');
        expect(Testlog041_Rtn?.comp_cd,9913);
        expect(Testlog041_Rtn?.stre_cd,9914);
        expect(Testlog041_Rtn?.mac_no,9915);
        expect(Testlog041_Rtn?.receipt_no,9916);
        expect(Testlog041_Rtn?.print_no,9917);
        expect(Testlog041_Rtn?.cshr_no,9918);
        expect(Testlog041_Rtn?.chkr_no,9919);
        expect(Testlog041_Rtn?.cust_no,'abc20');
        expect(Testlog041_Rtn?.sale_date,'abc21');
        expect(Testlog041_Rtn?.starttime,'abc22');
        expect(Testlog041_Rtn?.endtime,'abc23');
        expect(Testlog041_Rtn?.ope_mode_flg,9924);
        expect(Testlog041_Rtn?.inout_flg,9925);
        expect(Testlog041_Rtn?.prn_typ,9926);
        expect(Testlog041_Rtn?.void_serial_no,'abc27');
        expect(Testlog041_Rtn?.qc_serial_no,'abc28');
        expect(Testlog041_Rtn?.void_kind,9929);
        expect(Testlog041_Rtn?.void_sale_date,'abc30');
        expect(Testlog041_Rtn?.data_log_cnt,9931);
        expect(Testlog041_Rtn?.ej_log_cnt,9932);
        expect(Testlog041_Rtn?.status_log_cnt,9933);
        expect(Testlog041_Rtn?.tran_flg,9934);
        expect(Testlog041_Rtn?.sub_tran_flg,9935);
        expect(Testlog041_Rtn?.off_entry_flg,9936);
        expect(Testlog041_Rtn?.various_flg_1,9937);
        expect(Testlog041_Rtn?.various_flg_2,9938);
        expect(Testlog041_Rtn?.various_flg_3,9939);
        expect(Testlog041_Rtn?.various_num_1,9940);
        expect(Testlog041_Rtn?.various_num_2,9941);
        expect(Testlog041_Rtn?.various_num_3,9942);
        expect(Testlog041_Rtn?.various_data,'abc43');
        expect(Testlog041_Rtn?.various_flg_4,9944);
        expect(Testlog041_Rtn?.various_flg_5,9945);
        expect(Testlog041_Rtn?.various_flg_6,9946);
        expect(Testlog041_Rtn?.various_flg_7,9947);
        expect(Testlog041_Rtn?.various_flg_8,9948);
        expect(Testlog041_Rtn?.various_flg_9,9949);
        expect(Testlog041_Rtn?.various_flg_10,9950);
        expect(Testlog041_Rtn?.various_flg_11,9951);
        expect(Testlog041_Rtn?.various_flg_12,9952);
        expect(Testlog041_Rtn?.various_flg_13,9953);
        expect(Testlog041_Rtn?.reserv_flg,9954);
        expect(Testlog041_Rtn?.reserv_stre_cd,9955);
        expect(Testlog041_Rtn?.reserv_status,9956);
        expect(Testlog041_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog041_Rtn?.reserv_cd,'abc58');
        expect(Testlog041_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog08> Testlog041_AllRtn2 = await db.selectAllData(Testlog041_1);
      int count2 = Testlog041_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog041_1);
      print('********** テスト終了：log041_CHeaderLog08_01 **********\n\n');
    });

    // ********************************************************
    // テストlog042 : CHeaderLog09
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log042_CHeaderLog09_01', () async {
      print('\n********** テスト実行：log042_CHeaderLog09_01 **********');
      CHeaderLog09 Testlog042_1 = CHeaderLog09();
      Testlog042_1.serial_no = 'abc09';
      Testlog042_1.comp_cd = 9913;
      Testlog042_1.stre_cd = 9914;
      Testlog042_1.mac_no = 9915;
      Testlog042_1.receipt_no = 9916;
      Testlog042_1.print_no = 9917;
      Testlog042_1.cshr_no = 9918;
      Testlog042_1.chkr_no = 9919;
      Testlog042_1.cust_no = 'abc20';
      Testlog042_1.sale_date = 'abc21';
      Testlog042_1.starttime = 'abc22';
      Testlog042_1.endtime = 'abc23';
      Testlog042_1.ope_mode_flg = 9924;
      Testlog042_1.inout_flg = 9925;
      Testlog042_1.prn_typ = 9926;
      Testlog042_1.void_serial_no = 'abc27';
      Testlog042_1.qc_serial_no = 'abc28';
      Testlog042_1.void_kind = 9929;
      Testlog042_1.void_sale_date = 'abc30';
      Testlog042_1.data_log_cnt = 9931;
      Testlog042_1.ej_log_cnt = 9932;
      Testlog042_1.status_log_cnt = 9933;
      Testlog042_1.tran_flg = 9934;
      Testlog042_1.sub_tran_flg = 9935;
      Testlog042_1.off_entry_flg = 9936;
      Testlog042_1.various_flg_1 = 9937;
      Testlog042_1.various_flg_2 = 9938;
      Testlog042_1.various_flg_3 = 9939;
      Testlog042_1.various_num_1 = 9940;
      Testlog042_1.various_num_2 = 9941;
      Testlog042_1.various_num_3 = 9942;
      Testlog042_1.various_data = 'abc43';
      Testlog042_1.various_flg_4 = 9944;
      Testlog042_1.various_flg_5 = 9945;
      Testlog042_1.various_flg_6 = 9946;
      Testlog042_1.various_flg_7 = 9947;
      Testlog042_1.various_flg_8 = 9948;
      Testlog042_1.various_flg_9 = 9949;
      Testlog042_1.various_flg_10 = 9950;
      Testlog042_1.various_flg_11 = 9951;
      Testlog042_1.various_flg_12 = 9952;
      Testlog042_1.various_flg_13 = 9953;
      Testlog042_1.reserv_flg = 9954;
      Testlog042_1.reserv_stre_cd = 9955;
      Testlog042_1.reserv_status = 9956;
      Testlog042_1.reserv_chg_cnt = 9957;
      Testlog042_1.reserv_cd = 'abc58';
      Testlog042_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog09> Testlog042_AllRtn = await db.selectAllData(Testlog042_1);
      int count = Testlog042_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog042_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog09 Testlog042_2 = CHeaderLog09();
      //Keyの値を設定する
      Testlog042_2.serial_no = 'abc09';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog09? Testlog042_Rtn = await db.selectDataByPrimaryKey(Testlog042_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog042_Rtn == null) {
        print('\n********** 異常発生：log042_CHeaderLog09_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog042_Rtn?.serial_no,'abc09');
        expect(Testlog042_Rtn?.comp_cd,9913);
        expect(Testlog042_Rtn?.stre_cd,9914);
        expect(Testlog042_Rtn?.mac_no,9915);
        expect(Testlog042_Rtn?.receipt_no,9916);
        expect(Testlog042_Rtn?.print_no,9917);
        expect(Testlog042_Rtn?.cshr_no,9918);
        expect(Testlog042_Rtn?.chkr_no,9919);
        expect(Testlog042_Rtn?.cust_no,'abc20');
        expect(Testlog042_Rtn?.sale_date,'abc21');
        expect(Testlog042_Rtn?.starttime,'abc22');
        expect(Testlog042_Rtn?.endtime,'abc23');
        expect(Testlog042_Rtn?.ope_mode_flg,9924);
        expect(Testlog042_Rtn?.inout_flg,9925);
        expect(Testlog042_Rtn?.prn_typ,9926);
        expect(Testlog042_Rtn?.void_serial_no,'abc27');
        expect(Testlog042_Rtn?.qc_serial_no,'abc28');
        expect(Testlog042_Rtn?.void_kind,9929);
        expect(Testlog042_Rtn?.void_sale_date,'abc30');
        expect(Testlog042_Rtn?.data_log_cnt,9931);
        expect(Testlog042_Rtn?.ej_log_cnt,9932);
        expect(Testlog042_Rtn?.status_log_cnt,9933);
        expect(Testlog042_Rtn?.tran_flg,9934);
        expect(Testlog042_Rtn?.sub_tran_flg,9935);
        expect(Testlog042_Rtn?.off_entry_flg,9936);
        expect(Testlog042_Rtn?.various_flg_1,9937);
        expect(Testlog042_Rtn?.various_flg_2,9938);
        expect(Testlog042_Rtn?.various_flg_3,9939);
        expect(Testlog042_Rtn?.various_num_1,9940);
        expect(Testlog042_Rtn?.various_num_2,9941);
        expect(Testlog042_Rtn?.various_num_3,9942);
        expect(Testlog042_Rtn?.various_data,'abc43');
        expect(Testlog042_Rtn?.various_flg_4,9944);
        expect(Testlog042_Rtn?.various_flg_5,9945);
        expect(Testlog042_Rtn?.various_flg_6,9946);
        expect(Testlog042_Rtn?.various_flg_7,9947);
        expect(Testlog042_Rtn?.various_flg_8,9948);
        expect(Testlog042_Rtn?.various_flg_9,9949);
        expect(Testlog042_Rtn?.various_flg_10,9950);
        expect(Testlog042_Rtn?.various_flg_11,9951);
        expect(Testlog042_Rtn?.various_flg_12,9952);
        expect(Testlog042_Rtn?.various_flg_13,9953);
        expect(Testlog042_Rtn?.reserv_flg,9954);
        expect(Testlog042_Rtn?.reserv_stre_cd,9955);
        expect(Testlog042_Rtn?.reserv_status,9956);
        expect(Testlog042_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog042_Rtn?.reserv_cd,'abc58');
        expect(Testlog042_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog09> Testlog042_AllRtn2 = await db.selectAllData(Testlog042_1);
      int count2 = Testlog042_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog042_1);
      print('********** テスト終了：log042_CHeaderLog09_01 **********\n\n');
    });

    // ********************************************************
    // テストlog043 : CHeaderLog10
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log043_CHeaderLog10_01', () async {
      print('\n********** テスト実行：log043_CHeaderLog10_01 **********');
      CHeaderLog10 Testlog043_1 = CHeaderLog10();
      Testlog043_1.serial_no = 'abc10';
      Testlog043_1.comp_cd = 9913;
      Testlog043_1.stre_cd = 9914;
      Testlog043_1.mac_no = 9915;
      Testlog043_1.receipt_no = 9916;
      Testlog043_1.print_no = 9917;
      Testlog043_1.cshr_no = 9918;
      Testlog043_1.chkr_no = 9919;
      Testlog043_1.cust_no = 'abc20';
      Testlog043_1.sale_date = 'abc21';
      Testlog043_1.starttime = 'abc22';
      Testlog043_1.endtime = 'abc23';
      Testlog043_1.ope_mode_flg = 9924;
      Testlog043_1.inout_flg = 9925;
      Testlog043_1.prn_typ = 9926;
      Testlog043_1.void_serial_no = 'abc27';
      Testlog043_1.qc_serial_no = 'abc28';
      Testlog043_1.void_kind = 9929;
      Testlog043_1.void_sale_date = 'abc30';
      Testlog043_1.data_log_cnt = 9931;
      Testlog043_1.ej_log_cnt = 9932;
      Testlog043_1.status_log_cnt = 9933;
      Testlog043_1.tran_flg = 9934;
      Testlog043_1.sub_tran_flg = 9935;
      Testlog043_1.off_entry_flg = 9936;
      Testlog043_1.various_flg_1 = 9937;
      Testlog043_1.various_flg_2 = 9938;
      Testlog043_1.various_flg_3 = 9939;
      Testlog043_1.various_num_1 = 9940;
      Testlog043_1.various_num_2 = 9941;
      Testlog043_1.various_num_3 = 9942;
      Testlog043_1.various_data = 'abc43';
      Testlog043_1.various_flg_4 = 9944;
      Testlog043_1.various_flg_5 = 9945;
      Testlog043_1.various_flg_6 = 9946;
      Testlog043_1.various_flg_7 = 9947;
      Testlog043_1.various_flg_8 = 9948;
      Testlog043_1.various_flg_9 = 9949;
      Testlog043_1.various_flg_10 = 9950;
      Testlog043_1.various_flg_11 = 9951;
      Testlog043_1.various_flg_12 = 9952;
      Testlog043_1.various_flg_13 = 9953;
      Testlog043_1.reserv_flg = 9954;
      Testlog043_1.reserv_stre_cd = 9955;
      Testlog043_1.reserv_status = 9956;
      Testlog043_1.reserv_chg_cnt = 9957;
      Testlog043_1.reserv_cd = 'abc58';
      Testlog043_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog10> Testlog043_AllRtn = await db.selectAllData(Testlog043_1);
      int count = Testlog043_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog043_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog10 Testlog043_2 = CHeaderLog10();
      //Keyの値を設定する
      Testlog043_2.serial_no = 'abc10';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog10? Testlog043_Rtn = await db.selectDataByPrimaryKey(Testlog043_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog043_Rtn == null) {
        print('\n********** 異常発生：log043_CHeaderLog10_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog043_Rtn?.serial_no,'abc10');
        expect(Testlog043_Rtn?.comp_cd,9913);
        expect(Testlog043_Rtn?.stre_cd,9914);
        expect(Testlog043_Rtn?.mac_no,9915);
        expect(Testlog043_Rtn?.receipt_no,9916);
        expect(Testlog043_Rtn?.print_no,9917);
        expect(Testlog043_Rtn?.cshr_no,9918);
        expect(Testlog043_Rtn?.chkr_no,9919);
        expect(Testlog043_Rtn?.cust_no,'abc20');
        expect(Testlog043_Rtn?.sale_date,'abc21');
        expect(Testlog043_Rtn?.starttime,'abc22');
        expect(Testlog043_Rtn?.endtime,'abc23');
        expect(Testlog043_Rtn?.ope_mode_flg,9924);
        expect(Testlog043_Rtn?.inout_flg,9925);
        expect(Testlog043_Rtn?.prn_typ,9926);
        expect(Testlog043_Rtn?.void_serial_no,'abc27');
        expect(Testlog043_Rtn?.qc_serial_no,'abc28');
        expect(Testlog043_Rtn?.void_kind,9929);
        expect(Testlog043_Rtn?.void_sale_date,'abc30');
        expect(Testlog043_Rtn?.data_log_cnt,9931);
        expect(Testlog043_Rtn?.ej_log_cnt,9932);
        expect(Testlog043_Rtn?.status_log_cnt,9933);
        expect(Testlog043_Rtn?.tran_flg,9934);
        expect(Testlog043_Rtn?.sub_tran_flg,9935);
        expect(Testlog043_Rtn?.off_entry_flg,9936);
        expect(Testlog043_Rtn?.various_flg_1,9937);
        expect(Testlog043_Rtn?.various_flg_2,9938);
        expect(Testlog043_Rtn?.various_flg_3,9939);
        expect(Testlog043_Rtn?.various_num_1,9940);
        expect(Testlog043_Rtn?.various_num_2,9941);
        expect(Testlog043_Rtn?.various_num_3,9942);
        expect(Testlog043_Rtn?.various_data,'abc43');
        expect(Testlog043_Rtn?.various_flg_4,9944);
        expect(Testlog043_Rtn?.various_flg_5,9945);
        expect(Testlog043_Rtn?.various_flg_6,9946);
        expect(Testlog043_Rtn?.various_flg_7,9947);
        expect(Testlog043_Rtn?.various_flg_8,9948);
        expect(Testlog043_Rtn?.various_flg_9,9949);
        expect(Testlog043_Rtn?.various_flg_10,9950);
        expect(Testlog043_Rtn?.various_flg_11,9951);
        expect(Testlog043_Rtn?.various_flg_12,9952);
        expect(Testlog043_Rtn?.various_flg_13,9953);
        expect(Testlog043_Rtn?.reserv_flg,9954);
        expect(Testlog043_Rtn?.reserv_stre_cd,9955);
        expect(Testlog043_Rtn?.reserv_status,9956);
        expect(Testlog043_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog043_Rtn?.reserv_cd,'abc58');
        expect(Testlog043_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog10> Testlog043_AllRtn2 = await db.selectAllData(Testlog043_1);
      int count2 = Testlog043_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog043_1);
      print('********** テスト終了：log043_CHeaderLog10_01 **********\n\n');
    });

    // ********************************************************
    // テストlog044 : CHeaderLog11
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log044_CHeaderLog11_01', () async {
      print('\n********** テスト実行：log044_CHeaderLog11_01 **********');
      CHeaderLog11 Testlog044_1 = CHeaderLog11();
      Testlog044_1.serial_no = 'abc11';
      Testlog044_1.comp_cd = 9913;
      Testlog044_1.stre_cd = 9914;
      Testlog044_1.mac_no = 9915;
      Testlog044_1.receipt_no = 9916;
      Testlog044_1.print_no = 9917;
      Testlog044_1.cshr_no = 9918;
      Testlog044_1.chkr_no = 9919;
      Testlog044_1.cust_no = 'abc20';
      Testlog044_1.sale_date = 'abc21';
      Testlog044_1.starttime = 'abc22';
      Testlog044_1.endtime = 'abc23';
      Testlog044_1.ope_mode_flg = 9924;
      Testlog044_1.inout_flg = 9925;
      Testlog044_1.prn_typ = 9926;
      Testlog044_1.void_serial_no = 'abc27';
      Testlog044_1.qc_serial_no = 'abc28';
      Testlog044_1.void_kind = 9929;
      Testlog044_1.void_sale_date = 'abc30';
      Testlog044_1.data_log_cnt = 9931;
      Testlog044_1.ej_log_cnt = 9932;
      Testlog044_1.status_log_cnt = 9933;
      Testlog044_1.tran_flg = 9934;
      Testlog044_1.sub_tran_flg = 9935;
      Testlog044_1.off_entry_flg = 9936;
      Testlog044_1.various_flg_1 = 9937;
      Testlog044_1.various_flg_2 = 9938;
      Testlog044_1.various_flg_3 = 9939;
      Testlog044_1.various_num_1 = 9940;
      Testlog044_1.various_num_2 = 9941;
      Testlog044_1.various_num_3 = 9942;
      Testlog044_1.various_data = 'abc43';
      Testlog044_1.various_flg_4 = 9944;
      Testlog044_1.various_flg_5 = 9945;
      Testlog044_1.various_flg_6 = 9946;
      Testlog044_1.various_flg_7 = 9947;
      Testlog044_1.various_flg_8 = 9948;
      Testlog044_1.various_flg_9 = 9949;
      Testlog044_1.various_flg_10 = 9950;
      Testlog044_1.various_flg_11 = 9951;
      Testlog044_1.various_flg_12 = 9952;
      Testlog044_1.various_flg_13 = 9953;
      Testlog044_1.reserv_flg = 9954;
      Testlog044_1.reserv_stre_cd = 9955;
      Testlog044_1.reserv_status = 9956;
      Testlog044_1.reserv_chg_cnt = 9957;
      Testlog044_1.reserv_cd = 'abc58';
      Testlog044_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog11> Testlog044_AllRtn = await db.selectAllData(Testlog044_1);
      int count = Testlog044_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog044_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog11 Testlog044_2 = CHeaderLog11();
      //Keyの値を設定する
      Testlog044_2.serial_no = 'abc11';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog11? Testlog044_Rtn = await db.selectDataByPrimaryKey(Testlog044_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog044_Rtn == null) {
        print('\n********** 異常発生：log044_CHeaderLog11_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog044_Rtn?.serial_no,'abc11');
        expect(Testlog044_Rtn?.comp_cd,9913);
        expect(Testlog044_Rtn?.stre_cd,9914);
        expect(Testlog044_Rtn?.mac_no,9915);
        expect(Testlog044_Rtn?.receipt_no,9916);
        expect(Testlog044_Rtn?.print_no,9917);
        expect(Testlog044_Rtn?.cshr_no,9918);
        expect(Testlog044_Rtn?.chkr_no,9919);
        expect(Testlog044_Rtn?.cust_no,'abc20');
        expect(Testlog044_Rtn?.sale_date,'abc21');
        expect(Testlog044_Rtn?.starttime,'abc22');
        expect(Testlog044_Rtn?.endtime,'abc23');
        expect(Testlog044_Rtn?.ope_mode_flg,9924);
        expect(Testlog044_Rtn?.inout_flg,9925);
        expect(Testlog044_Rtn?.prn_typ,9926);
        expect(Testlog044_Rtn?.void_serial_no,'abc27');
        expect(Testlog044_Rtn?.qc_serial_no,'abc28');
        expect(Testlog044_Rtn?.void_kind,9929);
        expect(Testlog044_Rtn?.void_sale_date,'abc30');
        expect(Testlog044_Rtn?.data_log_cnt,9931);
        expect(Testlog044_Rtn?.ej_log_cnt,9932);
        expect(Testlog044_Rtn?.status_log_cnt,9933);
        expect(Testlog044_Rtn?.tran_flg,9934);
        expect(Testlog044_Rtn?.sub_tran_flg,9935);
        expect(Testlog044_Rtn?.off_entry_flg,9936);
        expect(Testlog044_Rtn?.various_flg_1,9937);
        expect(Testlog044_Rtn?.various_flg_2,9938);
        expect(Testlog044_Rtn?.various_flg_3,9939);
        expect(Testlog044_Rtn?.various_num_1,9940);
        expect(Testlog044_Rtn?.various_num_2,9941);
        expect(Testlog044_Rtn?.various_num_3,9942);
        expect(Testlog044_Rtn?.various_data,'abc43');
        expect(Testlog044_Rtn?.various_flg_4,9944);
        expect(Testlog044_Rtn?.various_flg_5,9945);
        expect(Testlog044_Rtn?.various_flg_6,9946);
        expect(Testlog044_Rtn?.various_flg_7,9947);
        expect(Testlog044_Rtn?.various_flg_8,9948);
        expect(Testlog044_Rtn?.various_flg_9,9949);
        expect(Testlog044_Rtn?.various_flg_10,9950);
        expect(Testlog044_Rtn?.various_flg_11,9951);
        expect(Testlog044_Rtn?.various_flg_12,9952);
        expect(Testlog044_Rtn?.various_flg_13,9953);
        expect(Testlog044_Rtn?.reserv_flg,9954);
        expect(Testlog044_Rtn?.reserv_stre_cd,9955);
        expect(Testlog044_Rtn?.reserv_status,9956);
        expect(Testlog044_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog044_Rtn?.reserv_cd,'abc58');
        expect(Testlog044_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog11> Testlog044_AllRtn2 = await db.selectAllData(Testlog044_1);
      int count2 = Testlog044_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog044_1);
      print('********** テスト終了：log044_CHeaderLog11_01 **********\n\n');
    });

    // ********************************************************
    // テストlog045 : CHeaderLog12
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log045_CHeaderLog12_01', () async {
      print('\n********** テスト実行：log045_CHeaderLog12_01 **********');
      CHeaderLog12 Testlog045_1 = CHeaderLog12();
      Testlog045_1.serial_no = 'abc12';
      Testlog045_1.comp_cd = 9913;
      Testlog045_1.stre_cd = 9914;
      Testlog045_1.mac_no = 9915;
      Testlog045_1.receipt_no = 9916;
      Testlog045_1.print_no = 9917;
      Testlog045_1.cshr_no = 9918;
      Testlog045_1.chkr_no = 9919;
      Testlog045_1.cust_no = 'abc20';
      Testlog045_1.sale_date = 'abc21';
      Testlog045_1.starttime = 'abc22';
      Testlog045_1.endtime = 'abc23';
      Testlog045_1.ope_mode_flg = 9924;
      Testlog045_1.inout_flg = 9925;
      Testlog045_1.prn_typ = 9926;
      Testlog045_1.void_serial_no = 'abc27';
      Testlog045_1.qc_serial_no = 'abc28';
      Testlog045_1.void_kind = 9929;
      Testlog045_1.void_sale_date = 'abc30';
      Testlog045_1.data_log_cnt = 9931;
      Testlog045_1.ej_log_cnt = 9932;
      Testlog045_1.status_log_cnt = 9933;
      Testlog045_1.tran_flg = 9934;
      Testlog045_1.sub_tran_flg = 9935;
      Testlog045_1.off_entry_flg = 9936;
      Testlog045_1.various_flg_1 = 9937;
      Testlog045_1.various_flg_2 = 9938;
      Testlog045_1.various_flg_3 = 9939;
      Testlog045_1.various_num_1 = 9940;
      Testlog045_1.various_num_2 = 9941;
      Testlog045_1.various_num_3 = 9942;
      Testlog045_1.various_data = 'abc43';
      Testlog045_1.various_flg_4 = 9944;
      Testlog045_1.various_flg_5 = 9945;
      Testlog045_1.various_flg_6 = 9946;
      Testlog045_1.various_flg_7 = 9947;
      Testlog045_1.various_flg_8 = 9948;
      Testlog045_1.various_flg_9 = 9949;
      Testlog045_1.various_flg_10 = 9950;
      Testlog045_1.various_flg_11 = 9951;
      Testlog045_1.various_flg_12 = 9952;
      Testlog045_1.various_flg_13 = 9953;
      Testlog045_1.reserv_flg = 9954;
      Testlog045_1.reserv_stre_cd = 9955;
      Testlog045_1.reserv_status = 9956;
      Testlog045_1.reserv_chg_cnt = 9957;
      Testlog045_1.reserv_cd = 'abc58';
      Testlog045_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog12> Testlog045_AllRtn = await db.selectAllData(Testlog045_1);
      int count = Testlog045_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog045_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog12 Testlog045_2 = CHeaderLog12();
      //Keyの値を設定する
      Testlog045_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog12? Testlog045_Rtn = await db.selectDataByPrimaryKey(Testlog045_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog045_Rtn == null) {
        print('\n********** 異常発生：log045_CHeaderLog12_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog045_Rtn?.serial_no,'abc12');
        expect(Testlog045_Rtn?.comp_cd,9913);
        expect(Testlog045_Rtn?.stre_cd,9914);
        expect(Testlog045_Rtn?.mac_no,9915);
        expect(Testlog045_Rtn?.receipt_no,9916);
        expect(Testlog045_Rtn?.print_no,9917);
        expect(Testlog045_Rtn?.cshr_no,9918);
        expect(Testlog045_Rtn?.chkr_no,9919);
        expect(Testlog045_Rtn?.cust_no,'abc20');
        expect(Testlog045_Rtn?.sale_date,'abc21');
        expect(Testlog045_Rtn?.starttime,'abc22');
        expect(Testlog045_Rtn?.endtime,'abc23');
        expect(Testlog045_Rtn?.ope_mode_flg,9924);
        expect(Testlog045_Rtn?.inout_flg,9925);
        expect(Testlog045_Rtn?.prn_typ,9926);
        expect(Testlog045_Rtn?.void_serial_no,'abc27');
        expect(Testlog045_Rtn?.qc_serial_no,'abc28');
        expect(Testlog045_Rtn?.void_kind,9929);
        expect(Testlog045_Rtn?.void_sale_date,'abc30');
        expect(Testlog045_Rtn?.data_log_cnt,9931);
        expect(Testlog045_Rtn?.ej_log_cnt,9932);
        expect(Testlog045_Rtn?.status_log_cnt,9933);
        expect(Testlog045_Rtn?.tran_flg,9934);
        expect(Testlog045_Rtn?.sub_tran_flg,9935);
        expect(Testlog045_Rtn?.off_entry_flg,9936);
        expect(Testlog045_Rtn?.various_flg_1,9937);
        expect(Testlog045_Rtn?.various_flg_2,9938);
        expect(Testlog045_Rtn?.various_flg_3,9939);
        expect(Testlog045_Rtn?.various_num_1,9940);
        expect(Testlog045_Rtn?.various_num_2,9941);
        expect(Testlog045_Rtn?.various_num_3,9942);
        expect(Testlog045_Rtn?.various_data,'abc43');
        expect(Testlog045_Rtn?.various_flg_4,9944);
        expect(Testlog045_Rtn?.various_flg_5,9945);
        expect(Testlog045_Rtn?.various_flg_6,9946);
        expect(Testlog045_Rtn?.various_flg_7,9947);
        expect(Testlog045_Rtn?.various_flg_8,9948);
        expect(Testlog045_Rtn?.various_flg_9,9949);
        expect(Testlog045_Rtn?.various_flg_10,9950);
        expect(Testlog045_Rtn?.various_flg_11,9951);
        expect(Testlog045_Rtn?.various_flg_12,9952);
        expect(Testlog045_Rtn?.various_flg_13,9953);
        expect(Testlog045_Rtn?.reserv_flg,9954);
        expect(Testlog045_Rtn?.reserv_stre_cd,9955);
        expect(Testlog045_Rtn?.reserv_status,9956);
        expect(Testlog045_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog045_Rtn?.reserv_cd,'abc58');
        expect(Testlog045_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog12> Testlog045_AllRtn2 = await db.selectAllData(Testlog045_1);
      int count2 = Testlog045_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog045_1);
      print('********** テスト終了：log045_CHeaderLog12_01 **********\n\n');
    });

    // ********************************************************
    // テストlog046 : CHeaderLog13
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log046_CHeaderLog13_01', () async {
      print('\n********** テスト実行：log046_CHeaderLog13_01 **********');
      CHeaderLog13 Testlog046_1 = CHeaderLog13();
      Testlog046_1.serial_no = 'abc13';
      Testlog046_1.comp_cd = 9913;
      Testlog046_1.stre_cd = 9914;
      Testlog046_1.mac_no = 9915;
      Testlog046_1.receipt_no = 9916;
      Testlog046_1.print_no = 9917;
      Testlog046_1.cshr_no = 9918;
      Testlog046_1.chkr_no = 9919;
      Testlog046_1.cust_no = 'abc20';
      Testlog046_1.sale_date = 'abc21';
      Testlog046_1.starttime = 'abc22';
      Testlog046_1.endtime = 'abc23';
      Testlog046_1.ope_mode_flg = 9924;
      Testlog046_1.inout_flg = 9925;
      Testlog046_1.prn_typ = 9926;
      Testlog046_1.void_serial_no = 'abc27';
      Testlog046_1.qc_serial_no = 'abc28';
      Testlog046_1.void_kind = 9929;
      Testlog046_1.void_sale_date = 'abc30';
      Testlog046_1.data_log_cnt = 9931;
      Testlog046_1.ej_log_cnt = 9932;
      Testlog046_1.status_log_cnt = 9933;
      Testlog046_1.tran_flg = 9934;
      Testlog046_1.sub_tran_flg = 9935;
      Testlog046_1.off_entry_flg = 9936;
      Testlog046_1.various_flg_1 = 9937;
      Testlog046_1.various_flg_2 = 9938;
      Testlog046_1.various_flg_3 = 9939;
      Testlog046_1.various_num_1 = 9940;
      Testlog046_1.various_num_2 = 9941;
      Testlog046_1.various_num_3 = 9942;
      Testlog046_1.various_data = 'abc43';
      Testlog046_1.various_flg_4 = 9944;
      Testlog046_1.various_flg_5 = 9945;
      Testlog046_1.various_flg_6 = 9946;
      Testlog046_1.various_flg_7 = 9947;
      Testlog046_1.various_flg_8 = 9948;
      Testlog046_1.various_flg_9 = 9949;
      Testlog046_1.various_flg_10 = 9950;
      Testlog046_1.various_flg_11 = 9951;
      Testlog046_1.various_flg_12 = 9952;
      Testlog046_1.various_flg_13 = 9953;
      Testlog046_1.reserv_flg = 9954;
      Testlog046_1.reserv_stre_cd = 9955;
      Testlog046_1.reserv_status = 9956;
      Testlog046_1.reserv_chg_cnt = 9957;
      Testlog046_1.reserv_cd = 'abc58';
      Testlog046_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog13> Testlog046_AllRtn = await db.selectAllData(Testlog046_1);
      int count = Testlog046_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog046_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog13 Testlog046_2 = CHeaderLog13();
      //Keyの値を設定する
      Testlog046_2.serial_no = 'abc13';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog13? Testlog046_Rtn = await db.selectDataByPrimaryKey(Testlog046_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog046_Rtn == null) {
        print('\n********** 異常発生：log046_CHeaderLog13_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog046_Rtn?.serial_no,'abc13');
        expect(Testlog046_Rtn?.comp_cd,9913);
        expect(Testlog046_Rtn?.stre_cd,9914);
        expect(Testlog046_Rtn?.mac_no,9915);
        expect(Testlog046_Rtn?.receipt_no,9916);
        expect(Testlog046_Rtn?.print_no,9917);
        expect(Testlog046_Rtn?.cshr_no,9918);
        expect(Testlog046_Rtn?.chkr_no,9919);
        expect(Testlog046_Rtn?.cust_no,'abc20');
        expect(Testlog046_Rtn?.sale_date,'abc21');
        expect(Testlog046_Rtn?.starttime,'abc22');
        expect(Testlog046_Rtn?.endtime,'abc23');
        expect(Testlog046_Rtn?.ope_mode_flg,9924);
        expect(Testlog046_Rtn?.inout_flg,9925);
        expect(Testlog046_Rtn?.prn_typ,9926);
        expect(Testlog046_Rtn?.void_serial_no,'abc27');
        expect(Testlog046_Rtn?.qc_serial_no,'abc28');
        expect(Testlog046_Rtn?.void_kind,9929);
        expect(Testlog046_Rtn?.void_sale_date,'abc30');
        expect(Testlog046_Rtn?.data_log_cnt,9931);
        expect(Testlog046_Rtn?.ej_log_cnt,9932);
        expect(Testlog046_Rtn?.status_log_cnt,9933);
        expect(Testlog046_Rtn?.tran_flg,9934);
        expect(Testlog046_Rtn?.sub_tran_flg,9935);
        expect(Testlog046_Rtn?.off_entry_flg,9936);
        expect(Testlog046_Rtn?.various_flg_1,9937);
        expect(Testlog046_Rtn?.various_flg_2,9938);
        expect(Testlog046_Rtn?.various_flg_3,9939);
        expect(Testlog046_Rtn?.various_num_1,9940);
        expect(Testlog046_Rtn?.various_num_2,9941);
        expect(Testlog046_Rtn?.various_num_3,9942);
        expect(Testlog046_Rtn?.various_data,'abc43');
        expect(Testlog046_Rtn?.various_flg_4,9944);
        expect(Testlog046_Rtn?.various_flg_5,9945);
        expect(Testlog046_Rtn?.various_flg_6,9946);
        expect(Testlog046_Rtn?.various_flg_7,9947);
        expect(Testlog046_Rtn?.various_flg_8,9948);
        expect(Testlog046_Rtn?.various_flg_9,9949);
        expect(Testlog046_Rtn?.various_flg_10,9950);
        expect(Testlog046_Rtn?.various_flg_11,9951);
        expect(Testlog046_Rtn?.various_flg_12,9952);
        expect(Testlog046_Rtn?.various_flg_13,9953);
        expect(Testlog046_Rtn?.reserv_flg,9954);
        expect(Testlog046_Rtn?.reserv_stre_cd,9955);
        expect(Testlog046_Rtn?.reserv_status,9956);
        expect(Testlog046_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog046_Rtn?.reserv_cd,'abc58');
        expect(Testlog046_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog13> Testlog046_AllRtn2 = await db.selectAllData(Testlog046_1);
      int count2 = Testlog046_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog046_1);
      print('********** テスト終了：log046_CHeaderLog13_01 **********\n\n');
    });

    // ********************************************************
    // テストlog047 : CHeaderLog14
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log047_CHeaderLog14_01', () async {
      print('\n********** テスト実行：log047_CHeaderLog14_01 **********');
      CHeaderLog14 Testlog047_1 = CHeaderLog14();
      Testlog047_1.serial_no = 'abc14';
      Testlog047_1.comp_cd = 9913;
      Testlog047_1.stre_cd = 9914;
      Testlog047_1.mac_no = 9915;
      Testlog047_1.receipt_no = 9916;
      Testlog047_1.print_no = 9917;
      Testlog047_1.cshr_no = 9918;
      Testlog047_1.chkr_no = 9919;
      Testlog047_1.cust_no = 'abc20';
      Testlog047_1.sale_date = 'abc21';
      Testlog047_1.starttime = 'abc22';
      Testlog047_1.endtime = 'abc23';
      Testlog047_1.ope_mode_flg = 9924;
      Testlog047_1.inout_flg = 9925;
      Testlog047_1.prn_typ = 9926;
      Testlog047_1.void_serial_no = 'abc27';
      Testlog047_1.qc_serial_no = 'abc28';
      Testlog047_1.void_kind = 9929;
      Testlog047_1.void_sale_date = 'abc30';
      Testlog047_1.data_log_cnt = 9931;
      Testlog047_1.ej_log_cnt = 9932;
      Testlog047_1.status_log_cnt = 9933;
      Testlog047_1.tran_flg = 9934;
      Testlog047_1.sub_tran_flg = 9935;
      Testlog047_1.off_entry_flg = 9936;
      Testlog047_1.various_flg_1 = 9937;
      Testlog047_1.various_flg_2 = 9938;
      Testlog047_1.various_flg_3 = 9939;
      Testlog047_1.various_num_1 = 9940;
      Testlog047_1.various_num_2 = 9941;
      Testlog047_1.various_num_3 = 9942;
      Testlog047_1.various_data = 'abc43';
      Testlog047_1.various_flg_4 = 9944;
      Testlog047_1.various_flg_5 = 9945;
      Testlog047_1.various_flg_6 = 9946;
      Testlog047_1.various_flg_7 = 9947;
      Testlog047_1.various_flg_8 = 9948;
      Testlog047_1.various_flg_9 = 9949;
      Testlog047_1.various_flg_10 = 9950;
      Testlog047_1.various_flg_11 = 9951;
      Testlog047_1.various_flg_12 = 9952;
      Testlog047_1.various_flg_13 = 9953;
      Testlog047_1.reserv_flg = 9954;
      Testlog047_1.reserv_stre_cd = 9955;
      Testlog047_1.reserv_status = 9956;
      Testlog047_1.reserv_chg_cnt = 9957;
      Testlog047_1.reserv_cd = 'abc58';
      Testlog047_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog14> Testlog047_AllRtn = await db.selectAllData(Testlog047_1);
      int count = Testlog047_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog047_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog14 Testlog047_2 = CHeaderLog14();
      //Keyの値を設定する
      Testlog047_2.serial_no = 'abc14';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog14? Testlog047_Rtn = await db.selectDataByPrimaryKey(Testlog047_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog047_Rtn == null) {
        print('\n********** 異常発生：log047_CHeaderLog14_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog047_Rtn?.serial_no,'abc14');
        expect(Testlog047_Rtn?.comp_cd,9913);
        expect(Testlog047_Rtn?.stre_cd,9914);
        expect(Testlog047_Rtn?.mac_no,9915);
        expect(Testlog047_Rtn?.receipt_no,9916);
        expect(Testlog047_Rtn?.print_no,9917);
        expect(Testlog047_Rtn?.cshr_no,9918);
        expect(Testlog047_Rtn?.chkr_no,9919);
        expect(Testlog047_Rtn?.cust_no,'abc20');
        expect(Testlog047_Rtn?.sale_date,'abc21');
        expect(Testlog047_Rtn?.starttime,'abc22');
        expect(Testlog047_Rtn?.endtime,'abc23');
        expect(Testlog047_Rtn?.ope_mode_flg,9924);
        expect(Testlog047_Rtn?.inout_flg,9925);
        expect(Testlog047_Rtn?.prn_typ,9926);
        expect(Testlog047_Rtn?.void_serial_no,'abc27');
        expect(Testlog047_Rtn?.qc_serial_no,'abc28');
        expect(Testlog047_Rtn?.void_kind,9929);
        expect(Testlog047_Rtn?.void_sale_date,'abc30');
        expect(Testlog047_Rtn?.data_log_cnt,9931);
        expect(Testlog047_Rtn?.ej_log_cnt,9932);
        expect(Testlog047_Rtn?.status_log_cnt,9933);
        expect(Testlog047_Rtn?.tran_flg,9934);
        expect(Testlog047_Rtn?.sub_tran_flg,9935);
        expect(Testlog047_Rtn?.off_entry_flg,9936);
        expect(Testlog047_Rtn?.various_flg_1,9937);
        expect(Testlog047_Rtn?.various_flg_2,9938);
        expect(Testlog047_Rtn?.various_flg_3,9939);
        expect(Testlog047_Rtn?.various_num_1,9940);
        expect(Testlog047_Rtn?.various_num_2,9941);
        expect(Testlog047_Rtn?.various_num_3,9942);
        expect(Testlog047_Rtn?.various_data,'abc43');
        expect(Testlog047_Rtn?.various_flg_4,9944);
        expect(Testlog047_Rtn?.various_flg_5,9945);
        expect(Testlog047_Rtn?.various_flg_6,9946);
        expect(Testlog047_Rtn?.various_flg_7,9947);
        expect(Testlog047_Rtn?.various_flg_8,9948);
        expect(Testlog047_Rtn?.various_flg_9,9949);
        expect(Testlog047_Rtn?.various_flg_10,9950);
        expect(Testlog047_Rtn?.various_flg_11,9951);
        expect(Testlog047_Rtn?.various_flg_12,9952);
        expect(Testlog047_Rtn?.various_flg_13,9953);
        expect(Testlog047_Rtn?.reserv_flg,9954);
        expect(Testlog047_Rtn?.reserv_stre_cd,9955);
        expect(Testlog047_Rtn?.reserv_status,9956);
        expect(Testlog047_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog047_Rtn?.reserv_cd,'abc58');
        expect(Testlog047_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog14> Testlog047_AllRtn2 = await db.selectAllData(Testlog047_1);
      int count2 = Testlog047_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog047_1);
      print('********** テスト終了：log047_CHeaderLog14_01 **********\n\n');
    });

    // ********************************************************
    // テストlog048 : CHeaderLog15
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log048_CHeaderLog15_01', () async {
      print('\n********** テスト実行：log048_CHeaderLog15_01 **********');
      CHeaderLog15 Testlog048_1 = CHeaderLog15();
      Testlog048_1.serial_no = 'abc15';
      Testlog048_1.comp_cd = 9913;
      Testlog048_1.stre_cd = 9914;
      Testlog048_1.mac_no = 9915;
      Testlog048_1.receipt_no = 9916;
      Testlog048_1.print_no = 9917;
      Testlog048_1.cshr_no = 9918;
      Testlog048_1.chkr_no = 9919;
      Testlog048_1.cust_no = 'abc20';
      Testlog048_1.sale_date = 'abc21';
      Testlog048_1.starttime = 'abc22';
      Testlog048_1.endtime = 'abc23';
      Testlog048_1.ope_mode_flg = 9924;
      Testlog048_1.inout_flg = 9925;
      Testlog048_1.prn_typ = 9926;
      Testlog048_1.void_serial_no = 'abc27';
      Testlog048_1.qc_serial_no = 'abc28';
      Testlog048_1.void_kind = 9929;
      Testlog048_1.void_sale_date = 'abc30';
      Testlog048_1.data_log_cnt = 9931;
      Testlog048_1.ej_log_cnt = 9932;
      Testlog048_1.status_log_cnt = 9933;
      Testlog048_1.tran_flg = 9934;
      Testlog048_1.sub_tran_flg = 9935;
      Testlog048_1.off_entry_flg = 9936;
      Testlog048_1.various_flg_1 = 9937;
      Testlog048_1.various_flg_2 = 9938;
      Testlog048_1.various_flg_3 = 9939;
      Testlog048_1.various_num_1 = 9940;
      Testlog048_1.various_num_2 = 9941;
      Testlog048_1.various_num_3 = 9942;
      Testlog048_1.various_data = 'abc43';
      Testlog048_1.various_flg_4 = 9944;
      Testlog048_1.various_flg_5 = 9945;
      Testlog048_1.various_flg_6 = 9946;
      Testlog048_1.various_flg_7 = 9947;
      Testlog048_1.various_flg_8 = 9948;
      Testlog048_1.various_flg_9 = 9949;
      Testlog048_1.various_flg_10 = 9950;
      Testlog048_1.various_flg_11 = 9951;
      Testlog048_1.various_flg_12 = 9952;
      Testlog048_1.various_flg_13 = 9953;
      Testlog048_1.reserv_flg = 9954;
      Testlog048_1.reserv_stre_cd = 9955;
      Testlog048_1.reserv_status = 9956;
      Testlog048_1.reserv_chg_cnt = 9957;
      Testlog048_1.reserv_cd = 'abc58';
      Testlog048_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog15> Testlog048_AllRtn = await db.selectAllData(Testlog048_1);
      int count = Testlog048_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog048_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog15 Testlog048_2 = CHeaderLog15();
      //Keyの値を設定する
      Testlog048_2.serial_no = 'abc15';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog15? Testlog048_Rtn = await db.selectDataByPrimaryKey(Testlog048_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog048_Rtn == null) {
        print('\n********** 異常発生：log048_CHeaderLog15_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog048_Rtn?.serial_no,'abc15');
        expect(Testlog048_Rtn?.comp_cd,9913);
        expect(Testlog048_Rtn?.stre_cd,9914);
        expect(Testlog048_Rtn?.mac_no,9915);
        expect(Testlog048_Rtn?.receipt_no,9916);
        expect(Testlog048_Rtn?.print_no,9917);
        expect(Testlog048_Rtn?.cshr_no,9918);
        expect(Testlog048_Rtn?.chkr_no,9919);
        expect(Testlog048_Rtn?.cust_no,'abc20');
        expect(Testlog048_Rtn?.sale_date,'abc21');
        expect(Testlog048_Rtn?.starttime,'abc22');
        expect(Testlog048_Rtn?.endtime,'abc23');
        expect(Testlog048_Rtn?.ope_mode_flg,9924);
        expect(Testlog048_Rtn?.inout_flg,9925);
        expect(Testlog048_Rtn?.prn_typ,9926);
        expect(Testlog048_Rtn?.void_serial_no,'abc27');
        expect(Testlog048_Rtn?.qc_serial_no,'abc28');
        expect(Testlog048_Rtn?.void_kind,9929);
        expect(Testlog048_Rtn?.void_sale_date,'abc30');
        expect(Testlog048_Rtn?.data_log_cnt,9931);
        expect(Testlog048_Rtn?.ej_log_cnt,9932);
        expect(Testlog048_Rtn?.status_log_cnt,9933);
        expect(Testlog048_Rtn?.tran_flg,9934);
        expect(Testlog048_Rtn?.sub_tran_flg,9935);
        expect(Testlog048_Rtn?.off_entry_flg,9936);
        expect(Testlog048_Rtn?.various_flg_1,9937);
        expect(Testlog048_Rtn?.various_flg_2,9938);
        expect(Testlog048_Rtn?.various_flg_3,9939);
        expect(Testlog048_Rtn?.various_num_1,9940);
        expect(Testlog048_Rtn?.various_num_2,9941);
        expect(Testlog048_Rtn?.various_num_3,9942);
        expect(Testlog048_Rtn?.various_data,'abc43');
        expect(Testlog048_Rtn?.various_flg_4,9944);
        expect(Testlog048_Rtn?.various_flg_5,9945);
        expect(Testlog048_Rtn?.various_flg_6,9946);
        expect(Testlog048_Rtn?.various_flg_7,9947);
        expect(Testlog048_Rtn?.various_flg_8,9948);
        expect(Testlog048_Rtn?.various_flg_9,9949);
        expect(Testlog048_Rtn?.various_flg_10,9950);
        expect(Testlog048_Rtn?.various_flg_11,9951);
        expect(Testlog048_Rtn?.various_flg_12,9952);
        expect(Testlog048_Rtn?.various_flg_13,9953);
        expect(Testlog048_Rtn?.reserv_flg,9954);
        expect(Testlog048_Rtn?.reserv_stre_cd,9955);
        expect(Testlog048_Rtn?.reserv_status,9956);
        expect(Testlog048_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog048_Rtn?.reserv_cd,'abc58');
        expect(Testlog048_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog15> Testlog048_AllRtn2 = await db.selectAllData(Testlog048_1);
      int count2 = Testlog048_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog048_1);
      print('********** テスト終了：log048_CHeaderLog15_01 **********\n\n');
    });

    // ********************************************************
    // テストlog049 : CHeaderLog16
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log049_CHeaderLog16_01', () async {
      print('\n********** テスト実行：log049_CHeaderLog16_01 **********');
      CHeaderLog16 Testlog049_1 = CHeaderLog16();
      Testlog049_1.serial_no = 'abc16';
      Testlog049_1.comp_cd = 9913;
      Testlog049_1.stre_cd = 9914;
      Testlog049_1.mac_no = 9915;
      Testlog049_1.receipt_no = 9916;
      Testlog049_1.print_no = 9917;
      Testlog049_1.cshr_no = 9918;
      Testlog049_1.chkr_no = 9919;
      Testlog049_1.cust_no = 'abc20';
      Testlog049_1.sale_date = 'abc21';
      Testlog049_1.starttime = 'abc22';
      Testlog049_1.endtime = 'abc23';
      Testlog049_1.ope_mode_flg = 9924;
      Testlog049_1.inout_flg = 9925;
      Testlog049_1.prn_typ = 9926;
      Testlog049_1.void_serial_no = 'abc27';
      Testlog049_1.qc_serial_no = 'abc28';
      Testlog049_1.void_kind = 9929;
      Testlog049_1.void_sale_date = 'abc30';
      Testlog049_1.data_log_cnt = 9931;
      Testlog049_1.ej_log_cnt = 9932;
      Testlog049_1.status_log_cnt = 9933;
      Testlog049_1.tran_flg = 9934;
      Testlog049_1.sub_tran_flg = 9935;
      Testlog049_1.off_entry_flg = 9936;
      Testlog049_1.various_flg_1 = 9937;
      Testlog049_1.various_flg_2 = 9938;
      Testlog049_1.various_flg_3 = 9939;
      Testlog049_1.various_num_1 = 9940;
      Testlog049_1.various_num_2 = 9941;
      Testlog049_1.various_num_3 = 9942;
      Testlog049_1.various_data = 'abc43';
      Testlog049_1.various_flg_4 = 9944;
      Testlog049_1.various_flg_5 = 9945;
      Testlog049_1.various_flg_6 = 9946;
      Testlog049_1.various_flg_7 = 9947;
      Testlog049_1.various_flg_8 = 9948;
      Testlog049_1.various_flg_9 = 9949;
      Testlog049_1.various_flg_10 = 9950;
      Testlog049_1.various_flg_11 = 9951;
      Testlog049_1.various_flg_12 = 9952;
      Testlog049_1.various_flg_13 = 9953;
      Testlog049_1.reserv_flg = 9954;
      Testlog049_1.reserv_stre_cd = 9955;
      Testlog049_1.reserv_status = 9956;
      Testlog049_1.reserv_chg_cnt = 9957;
      Testlog049_1.reserv_cd = 'abc58';
      Testlog049_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog16> Testlog049_AllRtn = await db.selectAllData(Testlog049_1);
      int count = Testlog049_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog049_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog16 Testlog049_2 = CHeaderLog16();
      //Keyの値を設定する
      Testlog049_2.serial_no = 'abc16';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog16? Testlog049_Rtn = await db.selectDataByPrimaryKey(Testlog049_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog049_Rtn == null) {
        print('\n********** 異常発生：log049_CHeaderLog16_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog049_Rtn?.serial_no,'abc16');
        expect(Testlog049_Rtn?.comp_cd,9913);
        expect(Testlog049_Rtn?.stre_cd,9914);
        expect(Testlog049_Rtn?.mac_no,9915);
        expect(Testlog049_Rtn?.receipt_no,9916);
        expect(Testlog049_Rtn?.print_no,9917);
        expect(Testlog049_Rtn?.cshr_no,9918);
        expect(Testlog049_Rtn?.chkr_no,9919);
        expect(Testlog049_Rtn?.cust_no,'abc20');
        expect(Testlog049_Rtn?.sale_date,'abc21');
        expect(Testlog049_Rtn?.starttime,'abc22');
        expect(Testlog049_Rtn?.endtime,'abc23');
        expect(Testlog049_Rtn?.ope_mode_flg,9924);
        expect(Testlog049_Rtn?.inout_flg,9925);
        expect(Testlog049_Rtn?.prn_typ,9926);
        expect(Testlog049_Rtn?.void_serial_no,'abc27');
        expect(Testlog049_Rtn?.qc_serial_no,'abc28');
        expect(Testlog049_Rtn?.void_kind,9929);
        expect(Testlog049_Rtn?.void_sale_date,'abc30');
        expect(Testlog049_Rtn?.data_log_cnt,9931);
        expect(Testlog049_Rtn?.ej_log_cnt,9932);
        expect(Testlog049_Rtn?.status_log_cnt,9933);
        expect(Testlog049_Rtn?.tran_flg,9934);
        expect(Testlog049_Rtn?.sub_tran_flg,9935);
        expect(Testlog049_Rtn?.off_entry_flg,9936);
        expect(Testlog049_Rtn?.various_flg_1,9937);
        expect(Testlog049_Rtn?.various_flg_2,9938);
        expect(Testlog049_Rtn?.various_flg_3,9939);
        expect(Testlog049_Rtn?.various_num_1,9940);
        expect(Testlog049_Rtn?.various_num_2,9941);
        expect(Testlog049_Rtn?.various_num_3,9942);
        expect(Testlog049_Rtn?.various_data,'abc43');
        expect(Testlog049_Rtn?.various_flg_4,9944);
        expect(Testlog049_Rtn?.various_flg_5,9945);
        expect(Testlog049_Rtn?.various_flg_6,9946);
        expect(Testlog049_Rtn?.various_flg_7,9947);
        expect(Testlog049_Rtn?.various_flg_8,9948);
        expect(Testlog049_Rtn?.various_flg_9,9949);
        expect(Testlog049_Rtn?.various_flg_10,9950);
        expect(Testlog049_Rtn?.various_flg_11,9951);
        expect(Testlog049_Rtn?.various_flg_12,9952);
        expect(Testlog049_Rtn?.various_flg_13,9953);
        expect(Testlog049_Rtn?.reserv_flg,9954);
        expect(Testlog049_Rtn?.reserv_stre_cd,9955);
        expect(Testlog049_Rtn?.reserv_status,9956);
        expect(Testlog049_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog049_Rtn?.reserv_cd,'abc58');
        expect(Testlog049_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog16> Testlog049_AllRtn2 = await db.selectAllData(Testlog049_1);
      int count2 = Testlog049_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog049_1);
      print('********** テスト終了：log049_CHeaderLog16_01 **********\n\n');
    });

    // ********************************************************
    // テストlog050 : CHeaderLog17
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log050_CHeaderLog17_01', () async {
      print('\n********** テスト実行：log050_CHeaderLog17_01 **********');
      CHeaderLog17 Testlog050_1 = CHeaderLog17();
      Testlog050_1.serial_no = 'abc17';
      Testlog050_1.comp_cd = 9913;
      Testlog050_1.stre_cd = 9914;
      Testlog050_1.mac_no = 9915;
      Testlog050_1.receipt_no = 9916;
      Testlog050_1.print_no = 9917;
      Testlog050_1.cshr_no = 9918;
      Testlog050_1.chkr_no = 9919;
      Testlog050_1.cust_no = 'abc20';
      Testlog050_1.sale_date = 'abc21';
      Testlog050_1.starttime = 'abc22';
      Testlog050_1.endtime = 'abc23';
      Testlog050_1.ope_mode_flg = 9924;
      Testlog050_1.inout_flg = 9925;
      Testlog050_1.prn_typ = 9926;
      Testlog050_1.void_serial_no = 'abc27';
      Testlog050_1.qc_serial_no = 'abc28';
      Testlog050_1.void_kind = 9929;
      Testlog050_1.void_sale_date = 'abc30';
      Testlog050_1.data_log_cnt = 9931;
      Testlog050_1.ej_log_cnt = 9932;
      Testlog050_1.status_log_cnt = 9933;
      Testlog050_1.tran_flg = 9934;
      Testlog050_1.sub_tran_flg = 9935;
      Testlog050_1.off_entry_flg = 9936;
      Testlog050_1.various_flg_1 = 9937;
      Testlog050_1.various_flg_2 = 9938;
      Testlog050_1.various_flg_3 = 9939;
      Testlog050_1.various_num_1 = 9940;
      Testlog050_1.various_num_2 = 9941;
      Testlog050_1.various_num_3 = 9942;
      Testlog050_1.various_data = 'abc43';
      Testlog050_1.various_flg_4 = 9944;
      Testlog050_1.various_flg_5 = 9945;
      Testlog050_1.various_flg_6 = 9946;
      Testlog050_1.various_flg_7 = 9947;
      Testlog050_1.various_flg_8 = 9948;
      Testlog050_1.various_flg_9 = 9949;
      Testlog050_1.various_flg_10 = 9950;
      Testlog050_1.various_flg_11 = 9951;
      Testlog050_1.various_flg_12 = 9952;
      Testlog050_1.various_flg_13 = 9953;
      Testlog050_1.reserv_flg = 9954;
      Testlog050_1.reserv_stre_cd = 9955;
      Testlog050_1.reserv_status = 9956;
      Testlog050_1.reserv_chg_cnt = 9957;
      Testlog050_1.reserv_cd = 'abc58';
      Testlog050_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog17> Testlog050_AllRtn = await db.selectAllData(Testlog050_1);
      int count = Testlog050_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog050_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog17 Testlog050_2 = CHeaderLog17();
      //Keyの値を設定する
      Testlog050_2.serial_no = 'abc17';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog17? Testlog050_Rtn = await db.selectDataByPrimaryKey(Testlog050_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog050_Rtn == null) {
        print('\n********** 異常発生：log050_CHeaderLog17_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog050_Rtn?.serial_no,'abc17');
        expect(Testlog050_Rtn?.comp_cd,9913);
        expect(Testlog050_Rtn?.stre_cd,9914);
        expect(Testlog050_Rtn?.mac_no,9915);
        expect(Testlog050_Rtn?.receipt_no,9916);
        expect(Testlog050_Rtn?.print_no,9917);
        expect(Testlog050_Rtn?.cshr_no,9918);
        expect(Testlog050_Rtn?.chkr_no,9919);
        expect(Testlog050_Rtn?.cust_no,'abc20');
        expect(Testlog050_Rtn?.sale_date,'abc21');
        expect(Testlog050_Rtn?.starttime,'abc22');
        expect(Testlog050_Rtn?.endtime,'abc23');
        expect(Testlog050_Rtn?.ope_mode_flg,9924);
        expect(Testlog050_Rtn?.inout_flg,9925);
        expect(Testlog050_Rtn?.prn_typ,9926);
        expect(Testlog050_Rtn?.void_serial_no,'abc27');
        expect(Testlog050_Rtn?.qc_serial_no,'abc28');
        expect(Testlog050_Rtn?.void_kind,9929);
        expect(Testlog050_Rtn?.void_sale_date,'abc30');
        expect(Testlog050_Rtn?.data_log_cnt,9931);
        expect(Testlog050_Rtn?.ej_log_cnt,9932);
        expect(Testlog050_Rtn?.status_log_cnt,9933);
        expect(Testlog050_Rtn?.tran_flg,9934);
        expect(Testlog050_Rtn?.sub_tran_flg,9935);
        expect(Testlog050_Rtn?.off_entry_flg,9936);
        expect(Testlog050_Rtn?.various_flg_1,9937);
        expect(Testlog050_Rtn?.various_flg_2,9938);
        expect(Testlog050_Rtn?.various_flg_3,9939);
        expect(Testlog050_Rtn?.various_num_1,9940);
        expect(Testlog050_Rtn?.various_num_2,9941);
        expect(Testlog050_Rtn?.various_num_3,9942);
        expect(Testlog050_Rtn?.various_data,'abc43');
        expect(Testlog050_Rtn?.various_flg_4,9944);
        expect(Testlog050_Rtn?.various_flg_5,9945);
        expect(Testlog050_Rtn?.various_flg_6,9946);
        expect(Testlog050_Rtn?.various_flg_7,9947);
        expect(Testlog050_Rtn?.various_flg_8,9948);
        expect(Testlog050_Rtn?.various_flg_9,9949);
        expect(Testlog050_Rtn?.various_flg_10,9950);
        expect(Testlog050_Rtn?.various_flg_11,9951);
        expect(Testlog050_Rtn?.various_flg_12,9952);
        expect(Testlog050_Rtn?.various_flg_13,9953);
        expect(Testlog050_Rtn?.reserv_flg,9954);
        expect(Testlog050_Rtn?.reserv_stre_cd,9955);
        expect(Testlog050_Rtn?.reserv_status,9956);
        expect(Testlog050_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog050_Rtn?.reserv_cd,'abc58');
        expect(Testlog050_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog17> Testlog050_AllRtn2 = await db.selectAllData(Testlog050_1);
      int count2 = Testlog050_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog050_1);
      print('********** テスト終了：log050_CHeaderLog17_01 **********\n\n');
    });

    // ********************************************************
    // テストlog051 : CHeaderLog18
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log051_CHeaderLog18_01', () async {
      print('\n********** テスト実行：log051_CHeaderLog18_01 **********');
      CHeaderLog18 Testlog051_1 = CHeaderLog18();
      Testlog051_1.serial_no = 'abc18';
      Testlog051_1.comp_cd = 9913;
      Testlog051_1.stre_cd = 9914;
      Testlog051_1.mac_no = 9915;
      Testlog051_1.receipt_no = 9916;
      Testlog051_1.print_no = 9917;
      Testlog051_1.cshr_no = 9918;
      Testlog051_1.chkr_no = 9919;
      Testlog051_1.cust_no = 'abc20';
      Testlog051_1.sale_date = 'abc21';
      Testlog051_1.starttime = 'abc22';
      Testlog051_1.endtime = 'abc23';
      Testlog051_1.ope_mode_flg = 9924;
      Testlog051_1.inout_flg = 9925;
      Testlog051_1.prn_typ = 9926;
      Testlog051_1.void_serial_no = 'abc27';
      Testlog051_1.qc_serial_no = 'abc28';
      Testlog051_1.void_kind = 9929;
      Testlog051_1.void_sale_date = 'abc30';
      Testlog051_1.data_log_cnt = 9931;
      Testlog051_1.ej_log_cnt = 9932;
      Testlog051_1.status_log_cnt = 9933;
      Testlog051_1.tran_flg = 9934;
      Testlog051_1.sub_tran_flg = 9935;
      Testlog051_1.off_entry_flg = 9936;
      Testlog051_1.various_flg_1 = 9937;
      Testlog051_1.various_flg_2 = 9938;
      Testlog051_1.various_flg_3 = 9939;
      Testlog051_1.various_num_1 = 9940;
      Testlog051_1.various_num_2 = 9941;
      Testlog051_1.various_num_3 = 9942;
      Testlog051_1.various_data = 'abc43';
      Testlog051_1.various_flg_4 = 9944;
      Testlog051_1.various_flg_5 = 9945;
      Testlog051_1.various_flg_6 = 9946;
      Testlog051_1.various_flg_7 = 9947;
      Testlog051_1.various_flg_8 = 9948;
      Testlog051_1.various_flg_9 = 9949;
      Testlog051_1.various_flg_10 = 9950;
      Testlog051_1.various_flg_11 = 9951;
      Testlog051_1.various_flg_12 = 9952;
      Testlog051_1.various_flg_13 = 9953;
      Testlog051_1.reserv_flg = 9954;
      Testlog051_1.reserv_stre_cd = 9955;
      Testlog051_1.reserv_status = 9956;
      Testlog051_1.reserv_chg_cnt = 9957;
      Testlog051_1.reserv_cd = 'abc58';
      Testlog051_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog18> Testlog051_AllRtn = await db.selectAllData(Testlog051_1);
      int count = Testlog051_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog051_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog18 Testlog051_2 = CHeaderLog18();
      //Keyの値を設定する
      Testlog051_2.serial_no = 'abc18';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog18? Testlog051_Rtn = await db.selectDataByPrimaryKey(Testlog051_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog051_Rtn == null) {
        print('\n********** 異常発生：log051_CHeaderLog18_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog051_Rtn?.serial_no,'abc18');
        expect(Testlog051_Rtn?.comp_cd,9913);
        expect(Testlog051_Rtn?.stre_cd,9914);
        expect(Testlog051_Rtn?.mac_no,9915);
        expect(Testlog051_Rtn?.receipt_no,9916);
        expect(Testlog051_Rtn?.print_no,9917);
        expect(Testlog051_Rtn?.cshr_no,9918);
        expect(Testlog051_Rtn?.chkr_no,9919);
        expect(Testlog051_Rtn?.cust_no,'abc20');
        expect(Testlog051_Rtn?.sale_date,'abc21');
        expect(Testlog051_Rtn?.starttime,'abc22');
        expect(Testlog051_Rtn?.endtime,'abc23');
        expect(Testlog051_Rtn?.ope_mode_flg,9924);
        expect(Testlog051_Rtn?.inout_flg,9925);
        expect(Testlog051_Rtn?.prn_typ,9926);
        expect(Testlog051_Rtn?.void_serial_no,'abc27');
        expect(Testlog051_Rtn?.qc_serial_no,'abc28');
        expect(Testlog051_Rtn?.void_kind,9929);
        expect(Testlog051_Rtn?.void_sale_date,'abc30');
        expect(Testlog051_Rtn?.data_log_cnt,9931);
        expect(Testlog051_Rtn?.ej_log_cnt,9932);
        expect(Testlog051_Rtn?.status_log_cnt,9933);
        expect(Testlog051_Rtn?.tran_flg,9934);
        expect(Testlog051_Rtn?.sub_tran_flg,9935);
        expect(Testlog051_Rtn?.off_entry_flg,9936);
        expect(Testlog051_Rtn?.various_flg_1,9937);
        expect(Testlog051_Rtn?.various_flg_2,9938);
        expect(Testlog051_Rtn?.various_flg_3,9939);
        expect(Testlog051_Rtn?.various_num_1,9940);
        expect(Testlog051_Rtn?.various_num_2,9941);
        expect(Testlog051_Rtn?.various_num_3,9942);
        expect(Testlog051_Rtn?.various_data,'abc43');
        expect(Testlog051_Rtn?.various_flg_4,9944);
        expect(Testlog051_Rtn?.various_flg_5,9945);
        expect(Testlog051_Rtn?.various_flg_6,9946);
        expect(Testlog051_Rtn?.various_flg_7,9947);
        expect(Testlog051_Rtn?.various_flg_8,9948);
        expect(Testlog051_Rtn?.various_flg_9,9949);
        expect(Testlog051_Rtn?.various_flg_10,9950);
        expect(Testlog051_Rtn?.various_flg_11,9951);
        expect(Testlog051_Rtn?.various_flg_12,9952);
        expect(Testlog051_Rtn?.various_flg_13,9953);
        expect(Testlog051_Rtn?.reserv_flg,9954);
        expect(Testlog051_Rtn?.reserv_stre_cd,9955);
        expect(Testlog051_Rtn?.reserv_status,9956);
        expect(Testlog051_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog051_Rtn?.reserv_cd,'abc58');
        expect(Testlog051_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog18> Testlog051_AllRtn2 = await db.selectAllData(Testlog051_1);
      int count2 = Testlog051_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog051_1);
      print('********** テスト終了：log051_CHeaderLog18_01 **********\n\n');
    });

    // ********************************************************
    // テストlog052 : CHeaderLog19
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log052_CHeaderLog19_01', () async {
      print('\n********** テスト実行：log052_CHeaderLog19_01 **********');
      CHeaderLog19 Testlog052_1 = CHeaderLog19();
      Testlog052_1.serial_no = 'abc19';
      Testlog052_1.comp_cd = 9913;
      Testlog052_1.stre_cd = 9914;
      Testlog052_1.mac_no = 9915;
      Testlog052_1.receipt_no = 9916;
      Testlog052_1.print_no = 9917;
      Testlog052_1.cshr_no = 9918;
      Testlog052_1.chkr_no = 9919;
      Testlog052_1.cust_no = 'abc20';
      Testlog052_1.sale_date = 'abc21';
      Testlog052_1.starttime = 'abc22';
      Testlog052_1.endtime = 'abc23';
      Testlog052_1.ope_mode_flg = 9924;
      Testlog052_1.inout_flg = 9925;
      Testlog052_1.prn_typ = 9926;
      Testlog052_1.void_serial_no = 'abc27';
      Testlog052_1.qc_serial_no = 'abc28';
      Testlog052_1.void_kind = 9929;
      Testlog052_1.void_sale_date = 'abc30';
      Testlog052_1.data_log_cnt = 9931;
      Testlog052_1.ej_log_cnt = 9932;
      Testlog052_1.status_log_cnt = 9933;
      Testlog052_1.tran_flg = 9934;
      Testlog052_1.sub_tran_flg = 9935;
      Testlog052_1.off_entry_flg = 9936;
      Testlog052_1.various_flg_1 = 9937;
      Testlog052_1.various_flg_2 = 9938;
      Testlog052_1.various_flg_3 = 9939;
      Testlog052_1.various_num_1 = 9940;
      Testlog052_1.various_num_2 = 9941;
      Testlog052_1.various_num_3 = 9942;
      Testlog052_1.various_data = 'abc43';
      Testlog052_1.various_flg_4 = 9944;
      Testlog052_1.various_flg_5 = 9945;
      Testlog052_1.various_flg_6 = 9946;
      Testlog052_1.various_flg_7 = 9947;
      Testlog052_1.various_flg_8 = 9948;
      Testlog052_1.various_flg_9 = 9949;
      Testlog052_1.various_flg_10 = 9950;
      Testlog052_1.various_flg_11 = 9951;
      Testlog052_1.various_flg_12 = 9952;
      Testlog052_1.various_flg_13 = 9953;
      Testlog052_1.reserv_flg = 9954;
      Testlog052_1.reserv_stre_cd = 9955;
      Testlog052_1.reserv_status = 9956;
      Testlog052_1.reserv_chg_cnt = 9957;
      Testlog052_1.reserv_cd = 'abc58';
      Testlog052_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog19> Testlog052_AllRtn = await db.selectAllData(Testlog052_1);
      int count = Testlog052_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog052_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog19 Testlog052_2 = CHeaderLog19();
      //Keyの値を設定する
      Testlog052_2.serial_no = 'abc19';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog19? Testlog052_Rtn = await db.selectDataByPrimaryKey(Testlog052_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog052_Rtn == null) {
        print('\n********** 異常発生：log052_CHeaderLog19_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog052_Rtn?.serial_no,'abc19');
        expect(Testlog052_Rtn?.comp_cd,9913);
        expect(Testlog052_Rtn?.stre_cd,9914);
        expect(Testlog052_Rtn?.mac_no,9915);
        expect(Testlog052_Rtn?.receipt_no,9916);
        expect(Testlog052_Rtn?.print_no,9917);
        expect(Testlog052_Rtn?.cshr_no,9918);
        expect(Testlog052_Rtn?.chkr_no,9919);
        expect(Testlog052_Rtn?.cust_no,'abc20');
        expect(Testlog052_Rtn?.sale_date,'abc21');
        expect(Testlog052_Rtn?.starttime,'abc22');
        expect(Testlog052_Rtn?.endtime,'abc23');
        expect(Testlog052_Rtn?.ope_mode_flg,9924);
        expect(Testlog052_Rtn?.inout_flg,9925);
        expect(Testlog052_Rtn?.prn_typ,9926);
        expect(Testlog052_Rtn?.void_serial_no,'abc27');
        expect(Testlog052_Rtn?.qc_serial_no,'abc28');
        expect(Testlog052_Rtn?.void_kind,9929);
        expect(Testlog052_Rtn?.void_sale_date,'abc30');
        expect(Testlog052_Rtn?.data_log_cnt,9931);
        expect(Testlog052_Rtn?.ej_log_cnt,9932);
        expect(Testlog052_Rtn?.status_log_cnt,9933);
        expect(Testlog052_Rtn?.tran_flg,9934);
        expect(Testlog052_Rtn?.sub_tran_flg,9935);
        expect(Testlog052_Rtn?.off_entry_flg,9936);
        expect(Testlog052_Rtn?.various_flg_1,9937);
        expect(Testlog052_Rtn?.various_flg_2,9938);
        expect(Testlog052_Rtn?.various_flg_3,9939);
        expect(Testlog052_Rtn?.various_num_1,9940);
        expect(Testlog052_Rtn?.various_num_2,9941);
        expect(Testlog052_Rtn?.various_num_3,9942);
        expect(Testlog052_Rtn?.various_data,'abc43');
        expect(Testlog052_Rtn?.various_flg_4,9944);
        expect(Testlog052_Rtn?.various_flg_5,9945);
        expect(Testlog052_Rtn?.various_flg_6,9946);
        expect(Testlog052_Rtn?.various_flg_7,9947);
        expect(Testlog052_Rtn?.various_flg_8,9948);
        expect(Testlog052_Rtn?.various_flg_9,9949);
        expect(Testlog052_Rtn?.various_flg_10,9950);
        expect(Testlog052_Rtn?.various_flg_11,9951);
        expect(Testlog052_Rtn?.various_flg_12,9952);
        expect(Testlog052_Rtn?.various_flg_13,9953);
        expect(Testlog052_Rtn?.reserv_flg,9954);
        expect(Testlog052_Rtn?.reserv_stre_cd,9955);
        expect(Testlog052_Rtn?.reserv_status,9956);
        expect(Testlog052_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog052_Rtn?.reserv_cd,'abc58');
        expect(Testlog052_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog19> Testlog052_AllRtn2 = await db.selectAllData(Testlog052_1);
      int count2 = Testlog052_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog052_1);
      print('********** テスト終了：log052_CHeaderLog19_01 **********\n\n');
    });

    // ********************************************************
    // テストlog053 : CHeaderLog20
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log053_CHeaderLog20_01', () async {
      print('\n********** テスト実行：log053_CHeaderLog20_01 **********');
      CHeaderLog20 Testlog053_1 = CHeaderLog20();
      Testlog053_1.serial_no = 'abc20';
      Testlog053_1.comp_cd = 9913;
      Testlog053_1.stre_cd = 9914;
      Testlog053_1.mac_no = 9915;
      Testlog053_1.receipt_no = 9916;
      Testlog053_1.print_no = 9917;
      Testlog053_1.cshr_no = 9918;
      Testlog053_1.chkr_no = 9919;
      Testlog053_1.cust_no = 'abc20';
      Testlog053_1.sale_date = 'abc21';
      Testlog053_1.starttime = 'abc22';
      Testlog053_1.endtime = 'abc23';
      Testlog053_1.ope_mode_flg = 9924;
      Testlog053_1.inout_flg = 9925;
      Testlog053_1.prn_typ = 9926;
      Testlog053_1.void_serial_no = 'abc27';
      Testlog053_1.qc_serial_no = 'abc28';
      Testlog053_1.void_kind = 9929;
      Testlog053_1.void_sale_date = 'abc30';
      Testlog053_1.data_log_cnt = 9931;
      Testlog053_1.ej_log_cnt = 9932;
      Testlog053_1.status_log_cnt = 9933;
      Testlog053_1.tran_flg = 9934;
      Testlog053_1.sub_tran_flg = 9935;
      Testlog053_1.off_entry_flg = 9936;
      Testlog053_1.various_flg_1 = 9937;
      Testlog053_1.various_flg_2 = 9938;
      Testlog053_1.various_flg_3 = 9939;
      Testlog053_1.various_num_1 = 9940;
      Testlog053_1.various_num_2 = 9941;
      Testlog053_1.various_num_3 = 9942;
      Testlog053_1.various_data = 'abc43';
      Testlog053_1.various_flg_4 = 9944;
      Testlog053_1.various_flg_5 = 9945;
      Testlog053_1.various_flg_6 = 9946;
      Testlog053_1.various_flg_7 = 9947;
      Testlog053_1.various_flg_8 = 9948;
      Testlog053_1.various_flg_9 = 9949;
      Testlog053_1.various_flg_10 = 9950;
      Testlog053_1.various_flg_11 = 9951;
      Testlog053_1.various_flg_12 = 9952;
      Testlog053_1.various_flg_13 = 9953;
      Testlog053_1.reserv_flg = 9954;
      Testlog053_1.reserv_stre_cd = 9955;
      Testlog053_1.reserv_status = 9956;
      Testlog053_1.reserv_chg_cnt = 9957;
      Testlog053_1.reserv_cd = 'abc58';
      Testlog053_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog20> Testlog053_AllRtn = await db.selectAllData(Testlog053_1);
      int count = Testlog053_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog053_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog20 Testlog053_2 = CHeaderLog20();
      //Keyの値を設定する
      Testlog053_2.serial_no = 'abc20';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog20? Testlog053_Rtn = await db.selectDataByPrimaryKey(Testlog053_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog053_Rtn == null) {
        print('\n********** 異常発生：log053_CHeaderLog20_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog053_Rtn?.serial_no,'abc20');
        expect(Testlog053_Rtn?.comp_cd,9913);
        expect(Testlog053_Rtn?.stre_cd,9914);
        expect(Testlog053_Rtn?.mac_no,9915);
        expect(Testlog053_Rtn?.receipt_no,9916);
        expect(Testlog053_Rtn?.print_no,9917);
        expect(Testlog053_Rtn?.cshr_no,9918);
        expect(Testlog053_Rtn?.chkr_no,9919);
        expect(Testlog053_Rtn?.cust_no,'abc20');
        expect(Testlog053_Rtn?.sale_date,'abc21');
        expect(Testlog053_Rtn?.starttime,'abc22');
        expect(Testlog053_Rtn?.endtime,'abc23');
        expect(Testlog053_Rtn?.ope_mode_flg,9924);
        expect(Testlog053_Rtn?.inout_flg,9925);
        expect(Testlog053_Rtn?.prn_typ,9926);
        expect(Testlog053_Rtn?.void_serial_no,'abc27');
        expect(Testlog053_Rtn?.qc_serial_no,'abc28');
        expect(Testlog053_Rtn?.void_kind,9929);
        expect(Testlog053_Rtn?.void_sale_date,'abc30');
        expect(Testlog053_Rtn?.data_log_cnt,9931);
        expect(Testlog053_Rtn?.ej_log_cnt,9932);
        expect(Testlog053_Rtn?.status_log_cnt,9933);
        expect(Testlog053_Rtn?.tran_flg,9934);
        expect(Testlog053_Rtn?.sub_tran_flg,9935);
        expect(Testlog053_Rtn?.off_entry_flg,9936);
        expect(Testlog053_Rtn?.various_flg_1,9937);
        expect(Testlog053_Rtn?.various_flg_2,9938);
        expect(Testlog053_Rtn?.various_flg_3,9939);
        expect(Testlog053_Rtn?.various_num_1,9940);
        expect(Testlog053_Rtn?.various_num_2,9941);
        expect(Testlog053_Rtn?.various_num_3,9942);
        expect(Testlog053_Rtn?.various_data,'abc43');
        expect(Testlog053_Rtn?.various_flg_4,9944);
        expect(Testlog053_Rtn?.various_flg_5,9945);
        expect(Testlog053_Rtn?.various_flg_6,9946);
        expect(Testlog053_Rtn?.various_flg_7,9947);
        expect(Testlog053_Rtn?.various_flg_8,9948);
        expect(Testlog053_Rtn?.various_flg_9,9949);
        expect(Testlog053_Rtn?.various_flg_10,9950);
        expect(Testlog053_Rtn?.various_flg_11,9951);
        expect(Testlog053_Rtn?.various_flg_12,9952);
        expect(Testlog053_Rtn?.various_flg_13,9953);
        expect(Testlog053_Rtn?.reserv_flg,9954);
        expect(Testlog053_Rtn?.reserv_stre_cd,9955);
        expect(Testlog053_Rtn?.reserv_status,9956);
        expect(Testlog053_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog053_Rtn?.reserv_cd,'abc58');
        expect(Testlog053_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog20> Testlog053_AllRtn2 = await db.selectAllData(Testlog053_1);
      int count2 = Testlog053_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog053_1);
      print('********** テスト終了：log053_CHeaderLog20_01 **********\n\n');
    });

    // ********************************************************
    // テストlog054 : CHeaderLog21
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log054_CHeaderLog21_01', () async {
      print('\n********** テスト実行：log054_CHeaderLog21_01 **********');
      CHeaderLog21 Testlog054_1 = CHeaderLog21();
      Testlog054_1.serial_no = 'abc21';
      Testlog054_1.comp_cd = 9913;
      Testlog054_1.stre_cd = 9914;
      Testlog054_1.mac_no = 9915;
      Testlog054_1.receipt_no = 9916;
      Testlog054_1.print_no = 9917;
      Testlog054_1.cshr_no = 9918;
      Testlog054_1.chkr_no = 9919;
      Testlog054_1.cust_no = 'abc20';
      Testlog054_1.sale_date = 'abc21';
      Testlog054_1.starttime = 'abc22';
      Testlog054_1.endtime = 'abc23';
      Testlog054_1.ope_mode_flg = 9924;
      Testlog054_1.inout_flg = 9925;
      Testlog054_1.prn_typ = 9926;
      Testlog054_1.void_serial_no = 'abc27';
      Testlog054_1.qc_serial_no = 'abc28';
      Testlog054_1.void_kind = 9929;
      Testlog054_1.void_sale_date = 'abc30';
      Testlog054_1.data_log_cnt = 9931;
      Testlog054_1.ej_log_cnt = 9932;
      Testlog054_1.status_log_cnt = 9933;
      Testlog054_1.tran_flg = 9934;
      Testlog054_1.sub_tran_flg = 9935;
      Testlog054_1.off_entry_flg = 9936;
      Testlog054_1.various_flg_1 = 9937;
      Testlog054_1.various_flg_2 = 9938;
      Testlog054_1.various_flg_3 = 9939;
      Testlog054_1.various_num_1 = 9940;
      Testlog054_1.various_num_2 = 9941;
      Testlog054_1.various_num_3 = 9942;
      Testlog054_1.various_data = 'abc43';
      Testlog054_1.various_flg_4 = 9944;
      Testlog054_1.various_flg_5 = 9945;
      Testlog054_1.various_flg_6 = 9946;
      Testlog054_1.various_flg_7 = 9947;
      Testlog054_1.various_flg_8 = 9948;
      Testlog054_1.various_flg_9 = 9949;
      Testlog054_1.various_flg_10 = 9950;
      Testlog054_1.various_flg_11 = 9951;
      Testlog054_1.various_flg_12 = 9952;
      Testlog054_1.various_flg_13 = 9953;
      Testlog054_1.reserv_flg = 9954;
      Testlog054_1.reserv_stre_cd = 9955;
      Testlog054_1.reserv_status = 9956;
      Testlog054_1.reserv_chg_cnt = 9957;
      Testlog054_1.reserv_cd = 'abc58';
      Testlog054_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog21> Testlog054_AllRtn = await db.selectAllData(Testlog054_1);
      int count = Testlog054_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog054_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog21 Testlog054_2 = CHeaderLog21();
      //Keyの値を設定する
      Testlog054_2.serial_no = 'abc21';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog21? Testlog054_Rtn = await db.selectDataByPrimaryKey(Testlog054_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog054_Rtn == null) {
        print('\n********** 異常発生：log054_CHeaderLog21_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog054_Rtn?.serial_no,'abc21');
        expect(Testlog054_Rtn?.comp_cd,9913);
        expect(Testlog054_Rtn?.stre_cd,9914);
        expect(Testlog054_Rtn?.mac_no,9915);
        expect(Testlog054_Rtn?.receipt_no,9916);
        expect(Testlog054_Rtn?.print_no,9917);
        expect(Testlog054_Rtn?.cshr_no,9918);
        expect(Testlog054_Rtn?.chkr_no,9919);
        expect(Testlog054_Rtn?.cust_no,'abc20');
        expect(Testlog054_Rtn?.sale_date,'abc21');
        expect(Testlog054_Rtn?.starttime,'abc22');
        expect(Testlog054_Rtn?.endtime,'abc23');
        expect(Testlog054_Rtn?.ope_mode_flg,9924);
        expect(Testlog054_Rtn?.inout_flg,9925);
        expect(Testlog054_Rtn?.prn_typ,9926);
        expect(Testlog054_Rtn?.void_serial_no,'abc27');
        expect(Testlog054_Rtn?.qc_serial_no,'abc28');
        expect(Testlog054_Rtn?.void_kind,9929);
        expect(Testlog054_Rtn?.void_sale_date,'abc30');
        expect(Testlog054_Rtn?.data_log_cnt,9931);
        expect(Testlog054_Rtn?.ej_log_cnt,9932);
        expect(Testlog054_Rtn?.status_log_cnt,9933);
        expect(Testlog054_Rtn?.tran_flg,9934);
        expect(Testlog054_Rtn?.sub_tran_flg,9935);
        expect(Testlog054_Rtn?.off_entry_flg,9936);
        expect(Testlog054_Rtn?.various_flg_1,9937);
        expect(Testlog054_Rtn?.various_flg_2,9938);
        expect(Testlog054_Rtn?.various_flg_3,9939);
        expect(Testlog054_Rtn?.various_num_1,9940);
        expect(Testlog054_Rtn?.various_num_2,9941);
        expect(Testlog054_Rtn?.various_num_3,9942);
        expect(Testlog054_Rtn?.various_data,'abc43');
        expect(Testlog054_Rtn?.various_flg_4,9944);
        expect(Testlog054_Rtn?.various_flg_5,9945);
        expect(Testlog054_Rtn?.various_flg_6,9946);
        expect(Testlog054_Rtn?.various_flg_7,9947);
        expect(Testlog054_Rtn?.various_flg_8,9948);
        expect(Testlog054_Rtn?.various_flg_9,9949);
        expect(Testlog054_Rtn?.various_flg_10,9950);
        expect(Testlog054_Rtn?.various_flg_11,9951);
        expect(Testlog054_Rtn?.various_flg_12,9952);
        expect(Testlog054_Rtn?.various_flg_13,9953);
        expect(Testlog054_Rtn?.reserv_flg,9954);
        expect(Testlog054_Rtn?.reserv_stre_cd,9955);
        expect(Testlog054_Rtn?.reserv_status,9956);
        expect(Testlog054_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog054_Rtn?.reserv_cd,'abc58');
        expect(Testlog054_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog21> Testlog054_AllRtn2 = await db.selectAllData(Testlog054_1);
      int count2 = Testlog054_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog054_1);
      print('********** テスト終了：log054_CHeaderLog21_01 **********\n\n');
    });

    // ********************************************************
    // テストlog055 : CHeaderLog22
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log055_CHeaderLog22_01', () async {
      print('\n********** テスト実行：log055_CHeaderLog22_01 **********');
      CHeaderLog22 Testlog055_1 = CHeaderLog22();
      Testlog055_1.serial_no = 'abc22';
      Testlog055_1.comp_cd = 9913;
      Testlog055_1.stre_cd = 9914;
      Testlog055_1.mac_no = 9915;
      Testlog055_1.receipt_no = 9916;
      Testlog055_1.print_no = 9917;
      Testlog055_1.cshr_no = 9918;
      Testlog055_1.chkr_no = 9919;
      Testlog055_1.cust_no = 'abc20';
      Testlog055_1.sale_date = 'abc21';
      Testlog055_1.starttime = 'abc22';
      Testlog055_1.endtime = 'abc23';
      Testlog055_1.ope_mode_flg = 9924;
      Testlog055_1.inout_flg = 9925;
      Testlog055_1.prn_typ = 9926;
      Testlog055_1.void_serial_no = 'abc27';
      Testlog055_1.qc_serial_no = 'abc28';
      Testlog055_1.void_kind = 9929;
      Testlog055_1.void_sale_date = 'abc30';
      Testlog055_1.data_log_cnt = 9931;
      Testlog055_1.ej_log_cnt = 9932;
      Testlog055_1.status_log_cnt = 9933;
      Testlog055_1.tran_flg = 9934;
      Testlog055_1.sub_tran_flg = 9935;
      Testlog055_1.off_entry_flg = 9936;
      Testlog055_1.various_flg_1 = 9937;
      Testlog055_1.various_flg_2 = 9938;
      Testlog055_1.various_flg_3 = 9939;
      Testlog055_1.various_num_1 = 9940;
      Testlog055_1.various_num_2 = 9941;
      Testlog055_1.various_num_3 = 9942;
      Testlog055_1.various_data = 'abc43';
      Testlog055_1.various_flg_4 = 9944;
      Testlog055_1.various_flg_5 = 9945;
      Testlog055_1.various_flg_6 = 9946;
      Testlog055_1.various_flg_7 = 9947;
      Testlog055_1.various_flg_8 = 9948;
      Testlog055_1.various_flg_9 = 9949;
      Testlog055_1.various_flg_10 = 9950;
      Testlog055_1.various_flg_11 = 9951;
      Testlog055_1.various_flg_12 = 9952;
      Testlog055_1.various_flg_13 = 9953;
      Testlog055_1.reserv_flg = 9954;
      Testlog055_1.reserv_stre_cd = 9955;
      Testlog055_1.reserv_status = 9956;
      Testlog055_1.reserv_chg_cnt = 9957;
      Testlog055_1.reserv_cd = 'abc58';
      Testlog055_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog22> Testlog055_AllRtn = await db.selectAllData(Testlog055_1);
      int count = Testlog055_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog055_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog22 Testlog055_2 = CHeaderLog22();
      //Keyの値を設定する
      Testlog055_2.serial_no = 'abc22';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog22? Testlog055_Rtn = await db.selectDataByPrimaryKey(Testlog055_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog055_Rtn == null) {
        print('\n********** 異常発生：log055_CHeaderLog22_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog055_Rtn?.serial_no,'abc22');
        expect(Testlog055_Rtn?.comp_cd,9913);
        expect(Testlog055_Rtn?.stre_cd,9914);
        expect(Testlog055_Rtn?.mac_no,9915);
        expect(Testlog055_Rtn?.receipt_no,9916);
        expect(Testlog055_Rtn?.print_no,9917);
        expect(Testlog055_Rtn?.cshr_no,9918);
        expect(Testlog055_Rtn?.chkr_no,9919);
        expect(Testlog055_Rtn?.cust_no,'abc20');
        expect(Testlog055_Rtn?.sale_date,'abc21');
        expect(Testlog055_Rtn?.starttime,'abc22');
        expect(Testlog055_Rtn?.endtime,'abc23');
        expect(Testlog055_Rtn?.ope_mode_flg,9924);
        expect(Testlog055_Rtn?.inout_flg,9925);
        expect(Testlog055_Rtn?.prn_typ,9926);
        expect(Testlog055_Rtn?.void_serial_no,'abc27');
        expect(Testlog055_Rtn?.qc_serial_no,'abc28');
        expect(Testlog055_Rtn?.void_kind,9929);
        expect(Testlog055_Rtn?.void_sale_date,'abc30');
        expect(Testlog055_Rtn?.data_log_cnt,9931);
        expect(Testlog055_Rtn?.ej_log_cnt,9932);
        expect(Testlog055_Rtn?.status_log_cnt,9933);
        expect(Testlog055_Rtn?.tran_flg,9934);
        expect(Testlog055_Rtn?.sub_tran_flg,9935);
        expect(Testlog055_Rtn?.off_entry_flg,9936);
        expect(Testlog055_Rtn?.various_flg_1,9937);
        expect(Testlog055_Rtn?.various_flg_2,9938);
        expect(Testlog055_Rtn?.various_flg_3,9939);
        expect(Testlog055_Rtn?.various_num_1,9940);
        expect(Testlog055_Rtn?.various_num_2,9941);
        expect(Testlog055_Rtn?.various_num_3,9942);
        expect(Testlog055_Rtn?.various_data,'abc43');
        expect(Testlog055_Rtn?.various_flg_4,9944);
        expect(Testlog055_Rtn?.various_flg_5,9945);
        expect(Testlog055_Rtn?.various_flg_6,9946);
        expect(Testlog055_Rtn?.various_flg_7,9947);
        expect(Testlog055_Rtn?.various_flg_8,9948);
        expect(Testlog055_Rtn?.various_flg_9,9949);
        expect(Testlog055_Rtn?.various_flg_10,9950);
        expect(Testlog055_Rtn?.various_flg_11,9951);
        expect(Testlog055_Rtn?.various_flg_12,9952);
        expect(Testlog055_Rtn?.various_flg_13,9953);
        expect(Testlog055_Rtn?.reserv_flg,9954);
        expect(Testlog055_Rtn?.reserv_stre_cd,9955);
        expect(Testlog055_Rtn?.reserv_status,9956);
        expect(Testlog055_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog055_Rtn?.reserv_cd,'abc58');
        expect(Testlog055_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog22> Testlog055_AllRtn2 = await db.selectAllData(Testlog055_1);
      int count2 = Testlog055_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog055_1);
      print('********** テスト終了：log055_CHeaderLog22_01 **********\n\n');
    });

    // ********************************************************
    // テストlog056 : CHeaderLog23
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log056_CHeaderLog23_01', () async {
      print('\n********** テスト実行：log056_CHeaderLog23_01 **********');
      CHeaderLog23 Testlog056_1 = CHeaderLog23();
      Testlog056_1.serial_no = 'abc23';
      Testlog056_1.comp_cd = 9913;
      Testlog056_1.stre_cd = 9914;
      Testlog056_1.mac_no = 9915;
      Testlog056_1.receipt_no = 9916;
      Testlog056_1.print_no = 9917;
      Testlog056_1.cshr_no = 9918;
      Testlog056_1.chkr_no = 9919;
      Testlog056_1.cust_no = 'abc20';
      Testlog056_1.sale_date = 'abc21';
      Testlog056_1.starttime = 'abc22';
      Testlog056_1.endtime = 'abc23';
      Testlog056_1.ope_mode_flg = 9924;
      Testlog056_1.inout_flg = 9925;
      Testlog056_1.prn_typ = 9926;
      Testlog056_1.void_serial_no = 'abc27';
      Testlog056_1.qc_serial_no = 'abc28';
      Testlog056_1.void_kind = 9929;
      Testlog056_1.void_sale_date = 'abc30';
      Testlog056_1.data_log_cnt = 9931;
      Testlog056_1.ej_log_cnt = 9932;
      Testlog056_1.status_log_cnt = 9933;
      Testlog056_1.tran_flg = 9934;
      Testlog056_1.sub_tran_flg = 9935;
      Testlog056_1.off_entry_flg = 9936;
      Testlog056_1.various_flg_1 = 9937;
      Testlog056_1.various_flg_2 = 9938;
      Testlog056_1.various_flg_3 = 9939;
      Testlog056_1.various_num_1 = 9940;
      Testlog056_1.various_num_2 = 9941;
      Testlog056_1.various_num_3 = 9942;
      Testlog056_1.various_data = 'abc43';
      Testlog056_1.various_flg_4 = 9944;
      Testlog056_1.various_flg_5 = 9945;
      Testlog056_1.various_flg_6 = 9946;
      Testlog056_1.various_flg_7 = 9947;
      Testlog056_1.various_flg_8 = 9948;
      Testlog056_1.various_flg_9 = 9949;
      Testlog056_1.various_flg_10 = 9950;
      Testlog056_1.various_flg_11 = 9951;
      Testlog056_1.various_flg_12 = 9952;
      Testlog056_1.various_flg_13 = 9953;
      Testlog056_1.reserv_flg = 9954;
      Testlog056_1.reserv_stre_cd = 9955;
      Testlog056_1.reserv_status = 9956;
      Testlog056_1.reserv_chg_cnt = 9957;
      Testlog056_1.reserv_cd = 'abc58';
      Testlog056_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog23> Testlog056_AllRtn = await db.selectAllData(Testlog056_1);
      int count = Testlog056_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog056_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog23 Testlog056_2 = CHeaderLog23();
      //Keyの値を設定する
      Testlog056_2.serial_no = 'abc23';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog23? Testlog056_Rtn = await db.selectDataByPrimaryKey(Testlog056_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog056_Rtn == null) {
        print('\n********** 異常発生：log056_CHeaderLog23_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog056_Rtn?.serial_no,'abc23');
        expect(Testlog056_Rtn?.comp_cd,9913);
        expect(Testlog056_Rtn?.stre_cd,9914);
        expect(Testlog056_Rtn?.mac_no,9915);
        expect(Testlog056_Rtn?.receipt_no,9916);
        expect(Testlog056_Rtn?.print_no,9917);
        expect(Testlog056_Rtn?.cshr_no,9918);
        expect(Testlog056_Rtn?.chkr_no,9919);
        expect(Testlog056_Rtn?.cust_no,'abc20');
        expect(Testlog056_Rtn?.sale_date,'abc21');
        expect(Testlog056_Rtn?.starttime,'abc22');
        expect(Testlog056_Rtn?.endtime,'abc23');
        expect(Testlog056_Rtn?.ope_mode_flg,9924);
        expect(Testlog056_Rtn?.inout_flg,9925);
        expect(Testlog056_Rtn?.prn_typ,9926);
        expect(Testlog056_Rtn?.void_serial_no,'abc27');
        expect(Testlog056_Rtn?.qc_serial_no,'abc28');
        expect(Testlog056_Rtn?.void_kind,9929);
        expect(Testlog056_Rtn?.void_sale_date,'abc30');
        expect(Testlog056_Rtn?.data_log_cnt,9931);
        expect(Testlog056_Rtn?.ej_log_cnt,9932);
        expect(Testlog056_Rtn?.status_log_cnt,9933);
        expect(Testlog056_Rtn?.tran_flg,9934);
        expect(Testlog056_Rtn?.sub_tran_flg,9935);
        expect(Testlog056_Rtn?.off_entry_flg,9936);
        expect(Testlog056_Rtn?.various_flg_1,9937);
        expect(Testlog056_Rtn?.various_flg_2,9938);
        expect(Testlog056_Rtn?.various_flg_3,9939);
        expect(Testlog056_Rtn?.various_num_1,9940);
        expect(Testlog056_Rtn?.various_num_2,9941);
        expect(Testlog056_Rtn?.various_num_3,9942);
        expect(Testlog056_Rtn?.various_data,'abc43');
        expect(Testlog056_Rtn?.various_flg_4,9944);
        expect(Testlog056_Rtn?.various_flg_5,9945);
        expect(Testlog056_Rtn?.various_flg_6,9946);
        expect(Testlog056_Rtn?.various_flg_7,9947);
        expect(Testlog056_Rtn?.various_flg_8,9948);
        expect(Testlog056_Rtn?.various_flg_9,9949);
        expect(Testlog056_Rtn?.various_flg_10,9950);
        expect(Testlog056_Rtn?.various_flg_11,9951);
        expect(Testlog056_Rtn?.various_flg_12,9952);
        expect(Testlog056_Rtn?.various_flg_13,9953);
        expect(Testlog056_Rtn?.reserv_flg,9954);
        expect(Testlog056_Rtn?.reserv_stre_cd,9955);
        expect(Testlog056_Rtn?.reserv_status,9956);
        expect(Testlog056_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog056_Rtn?.reserv_cd,'abc58');
        expect(Testlog056_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog23> Testlog056_AllRtn2 = await db.selectAllData(Testlog056_1);
      int count2 = Testlog056_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog056_1);
      print('********** テスト終了：log056_CHeaderLog23_01 **********\n\n');
    });

    // ********************************************************
    // テストlog057 : CHeaderLog24
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log057_CHeaderLog24_01', () async {
      print('\n********** テスト実行：log057_CHeaderLog24_01 **********');
      CHeaderLog24 Testlog057_1 = CHeaderLog24();
      Testlog057_1.serial_no = 'abc24';
      Testlog057_1.comp_cd = 9913;
      Testlog057_1.stre_cd = 9914;
      Testlog057_1.mac_no = 9915;
      Testlog057_1.receipt_no = 9916;
      Testlog057_1.print_no = 9917;
      Testlog057_1.cshr_no = 9918;
      Testlog057_1.chkr_no = 9919;
      Testlog057_1.cust_no = 'abc20';
      Testlog057_1.sale_date = 'abc21';
      Testlog057_1.starttime = 'abc22';
      Testlog057_1.endtime = 'abc23';
      Testlog057_1.ope_mode_flg = 9924;
      Testlog057_1.inout_flg = 9925;
      Testlog057_1.prn_typ = 9926;
      Testlog057_1.void_serial_no = 'abc27';
      Testlog057_1.qc_serial_no = 'abc28';
      Testlog057_1.void_kind = 9929;
      Testlog057_1.void_sale_date = 'abc30';
      Testlog057_1.data_log_cnt = 9931;
      Testlog057_1.ej_log_cnt = 9932;
      Testlog057_1.status_log_cnt = 9933;
      Testlog057_1.tran_flg = 9934;
      Testlog057_1.sub_tran_flg = 9935;
      Testlog057_1.off_entry_flg = 9936;
      Testlog057_1.various_flg_1 = 9937;
      Testlog057_1.various_flg_2 = 9938;
      Testlog057_1.various_flg_3 = 9939;
      Testlog057_1.various_num_1 = 9940;
      Testlog057_1.various_num_2 = 9941;
      Testlog057_1.various_num_3 = 9942;
      Testlog057_1.various_data = 'abc43';
      Testlog057_1.various_flg_4 = 9944;
      Testlog057_1.various_flg_5 = 9945;
      Testlog057_1.various_flg_6 = 9946;
      Testlog057_1.various_flg_7 = 9947;
      Testlog057_1.various_flg_8 = 9948;
      Testlog057_1.various_flg_9 = 9949;
      Testlog057_1.various_flg_10 = 9950;
      Testlog057_1.various_flg_11 = 9951;
      Testlog057_1.various_flg_12 = 9952;
      Testlog057_1.various_flg_13 = 9953;
      Testlog057_1.reserv_flg = 9954;
      Testlog057_1.reserv_stre_cd = 9955;
      Testlog057_1.reserv_status = 9956;
      Testlog057_1.reserv_chg_cnt = 9957;
      Testlog057_1.reserv_cd = 'abc58';
      Testlog057_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog24> Testlog057_AllRtn = await db.selectAllData(Testlog057_1);
      int count = Testlog057_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog057_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog24 Testlog057_2 = CHeaderLog24();
      //Keyの値を設定する
      Testlog057_2.serial_no = 'abc24';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog24? Testlog057_Rtn = await db.selectDataByPrimaryKey(Testlog057_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog057_Rtn == null) {
        print('\n********** 異常発生：log057_CHeaderLog24_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog057_Rtn?.serial_no,'abc24');
        expect(Testlog057_Rtn?.comp_cd,9913);
        expect(Testlog057_Rtn?.stre_cd,9914);
        expect(Testlog057_Rtn?.mac_no,9915);
        expect(Testlog057_Rtn?.receipt_no,9916);
        expect(Testlog057_Rtn?.print_no,9917);
        expect(Testlog057_Rtn?.cshr_no,9918);
        expect(Testlog057_Rtn?.chkr_no,9919);
        expect(Testlog057_Rtn?.cust_no,'abc20');
        expect(Testlog057_Rtn?.sale_date,'abc21');
        expect(Testlog057_Rtn?.starttime,'abc22');
        expect(Testlog057_Rtn?.endtime,'abc23');
        expect(Testlog057_Rtn?.ope_mode_flg,9924);
        expect(Testlog057_Rtn?.inout_flg,9925);
        expect(Testlog057_Rtn?.prn_typ,9926);
        expect(Testlog057_Rtn?.void_serial_no,'abc27');
        expect(Testlog057_Rtn?.qc_serial_no,'abc28');
        expect(Testlog057_Rtn?.void_kind,9929);
        expect(Testlog057_Rtn?.void_sale_date,'abc30');
        expect(Testlog057_Rtn?.data_log_cnt,9931);
        expect(Testlog057_Rtn?.ej_log_cnt,9932);
        expect(Testlog057_Rtn?.status_log_cnt,9933);
        expect(Testlog057_Rtn?.tran_flg,9934);
        expect(Testlog057_Rtn?.sub_tran_flg,9935);
        expect(Testlog057_Rtn?.off_entry_flg,9936);
        expect(Testlog057_Rtn?.various_flg_1,9937);
        expect(Testlog057_Rtn?.various_flg_2,9938);
        expect(Testlog057_Rtn?.various_flg_3,9939);
        expect(Testlog057_Rtn?.various_num_1,9940);
        expect(Testlog057_Rtn?.various_num_2,9941);
        expect(Testlog057_Rtn?.various_num_3,9942);
        expect(Testlog057_Rtn?.various_data,'abc43');
        expect(Testlog057_Rtn?.various_flg_4,9944);
        expect(Testlog057_Rtn?.various_flg_5,9945);
        expect(Testlog057_Rtn?.various_flg_6,9946);
        expect(Testlog057_Rtn?.various_flg_7,9947);
        expect(Testlog057_Rtn?.various_flg_8,9948);
        expect(Testlog057_Rtn?.various_flg_9,9949);
        expect(Testlog057_Rtn?.various_flg_10,9950);
        expect(Testlog057_Rtn?.various_flg_11,9951);
        expect(Testlog057_Rtn?.various_flg_12,9952);
        expect(Testlog057_Rtn?.various_flg_13,9953);
        expect(Testlog057_Rtn?.reserv_flg,9954);
        expect(Testlog057_Rtn?.reserv_stre_cd,9955);
        expect(Testlog057_Rtn?.reserv_status,9956);
        expect(Testlog057_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog057_Rtn?.reserv_cd,'abc58');
        expect(Testlog057_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog24> Testlog057_AllRtn2 = await db.selectAllData(Testlog057_1);
      int count2 = Testlog057_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog057_1);
      print('********** テスト終了：log057_CHeaderLog24_01 **********\n\n');
    });

    // ********************************************************
    // テストlog058 : CHeaderLog25
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log058_CHeaderLog25_01', () async {
      print('\n********** テスト実行：log058_CHeaderLog25_01 **********');
      CHeaderLog25 Testlog058_1 = CHeaderLog25();
      Testlog058_1.serial_no = 'abc25';
      Testlog058_1.comp_cd = 9913;
      Testlog058_1.stre_cd = 9914;
      Testlog058_1.mac_no = 9915;
      Testlog058_1.receipt_no = 9916;
      Testlog058_1.print_no = 9917;
      Testlog058_1.cshr_no = 9918;
      Testlog058_1.chkr_no = 9919;
      Testlog058_1.cust_no = 'abc20';
      Testlog058_1.sale_date = 'abc21';
      Testlog058_1.starttime = 'abc22';
      Testlog058_1.endtime = 'abc23';
      Testlog058_1.ope_mode_flg = 9924;
      Testlog058_1.inout_flg = 9925;
      Testlog058_1.prn_typ = 9926;
      Testlog058_1.void_serial_no = 'abc27';
      Testlog058_1.qc_serial_no = 'abc28';
      Testlog058_1.void_kind = 9929;
      Testlog058_1.void_sale_date = 'abc30';
      Testlog058_1.data_log_cnt = 9931;
      Testlog058_1.ej_log_cnt = 9932;
      Testlog058_1.status_log_cnt = 9933;
      Testlog058_1.tran_flg = 9934;
      Testlog058_1.sub_tran_flg = 9935;
      Testlog058_1.off_entry_flg = 9936;
      Testlog058_1.various_flg_1 = 9937;
      Testlog058_1.various_flg_2 = 9938;
      Testlog058_1.various_flg_3 = 9939;
      Testlog058_1.various_num_1 = 9940;
      Testlog058_1.various_num_2 = 9941;
      Testlog058_1.various_num_3 = 9942;
      Testlog058_1.various_data = 'abc43';
      Testlog058_1.various_flg_4 = 9944;
      Testlog058_1.various_flg_5 = 9945;
      Testlog058_1.various_flg_6 = 9946;
      Testlog058_1.various_flg_7 = 9947;
      Testlog058_1.various_flg_8 = 9948;
      Testlog058_1.various_flg_9 = 9949;
      Testlog058_1.various_flg_10 = 9950;
      Testlog058_1.various_flg_11 = 9951;
      Testlog058_1.various_flg_12 = 9952;
      Testlog058_1.various_flg_13 = 9953;
      Testlog058_1.reserv_flg = 9954;
      Testlog058_1.reserv_stre_cd = 9955;
      Testlog058_1.reserv_status = 9956;
      Testlog058_1.reserv_chg_cnt = 9957;
      Testlog058_1.reserv_cd = 'abc58';
      Testlog058_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog25> Testlog058_AllRtn = await db.selectAllData(Testlog058_1);
      int count = Testlog058_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog058_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog25 Testlog058_2 = CHeaderLog25();
      //Keyの値を設定する
      Testlog058_2.serial_no = 'abc25';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog25? Testlog058_Rtn = await db.selectDataByPrimaryKey(Testlog058_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog058_Rtn == null) {
        print('\n********** 異常発生：log058_CHeaderLog25_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog058_Rtn?.serial_no,'abc25');
        expect(Testlog058_Rtn?.comp_cd,9913);
        expect(Testlog058_Rtn?.stre_cd,9914);
        expect(Testlog058_Rtn?.mac_no,9915);
        expect(Testlog058_Rtn?.receipt_no,9916);
        expect(Testlog058_Rtn?.print_no,9917);
        expect(Testlog058_Rtn?.cshr_no,9918);
        expect(Testlog058_Rtn?.chkr_no,9919);
        expect(Testlog058_Rtn?.cust_no,'abc20');
        expect(Testlog058_Rtn?.sale_date,'abc21');
        expect(Testlog058_Rtn?.starttime,'abc22');
        expect(Testlog058_Rtn?.endtime,'abc23');
        expect(Testlog058_Rtn?.ope_mode_flg,9924);
        expect(Testlog058_Rtn?.inout_flg,9925);
        expect(Testlog058_Rtn?.prn_typ,9926);
        expect(Testlog058_Rtn?.void_serial_no,'abc27');
        expect(Testlog058_Rtn?.qc_serial_no,'abc28');
        expect(Testlog058_Rtn?.void_kind,9929);
        expect(Testlog058_Rtn?.void_sale_date,'abc30');
        expect(Testlog058_Rtn?.data_log_cnt,9931);
        expect(Testlog058_Rtn?.ej_log_cnt,9932);
        expect(Testlog058_Rtn?.status_log_cnt,9933);
        expect(Testlog058_Rtn?.tran_flg,9934);
        expect(Testlog058_Rtn?.sub_tran_flg,9935);
        expect(Testlog058_Rtn?.off_entry_flg,9936);
        expect(Testlog058_Rtn?.various_flg_1,9937);
        expect(Testlog058_Rtn?.various_flg_2,9938);
        expect(Testlog058_Rtn?.various_flg_3,9939);
        expect(Testlog058_Rtn?.various_num_1,9940);
        expect(Testlog058_Rtn?.various_num_2,9941);
        expect(Testlog058_Rtn?.various_num_3,9942);
        expect(Testlog058_Rtn?.various_data,'abc43');
        expect(Testlog058_Rtn?.various_flg_4,9944);
        expect(Testlog058_Rtn?.various_flg_5,9945);
        expect(Testlog058_Rtn?.various_flg_6,9946);
        expect(Testlog058_Rtn?.various_flg_7,9947);
        expect(Testlog058_Rtn?.various_flg_8,9948);
        expect(Testlog058_Rtn?.various_flg_9,9949);
        expect(Testlog058_Rtn?.various_flg_10,9950);
        expect(Testlog058_Rtn?.various_flg_11,9951);
        expect(Testlog058_Rtn?.various_flg_12,9952);
        expect(Testlog058_Rtn?.various_flg_13,9953);
        expect(Testlog058_Rtn?.reserv_flg,9954);
        expect(Testlog058_Rtn?.reserv_stre_cd,9955);
        expect(Testlog058_Rtn?.reserv_status,9956);
        expect(Testlog058_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog058_Rtn?.reserv_cd,'abc58');
        expect(Testlog058_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog25> Testlog058_AllRtn2 = await db.selectAllData(Testlog058_1);
      int count2 = Testlog058_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog058_1);
      print('********** テスト終了：log058_CHeaderLog25_01 **********\n\n');
    });

    // ********************************************************
    // テストlog059 : CHeaderLog26
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log059_CHeaderLog26_01', () async {
      print('\n********** テスト実行：log059_CHeaderLog26_01 **********');
      CHeaderLog26 Testlog059_1 = CHeaderLog26();
      Testlog059_1.serial_no = 'abc26';
      Testlog059_1.comp_cd = 9913;
      Testlog059_1.stre_cd = 9914;
      Testlog059_1.mac_no = 9915;
      Testlog059_1.receipt_no = 9916;
      Testlog059_1.print_no = 9917;
      Testlog059_1.cshr_no = 9918;
      Testlog059_1.chkr_no = 9919;
      Testlog059_1.cust_no = 'abc20';
      Testlog059_1.sale_date = 'abc21';
      Testlog059_1.starttime = 'abc22';
      Testlog059_1.endtime = 'abc23';
      Testlog059_1.ope_mode_flg = 9924;
      Testlog059_1.inout_flg = 9925;
      Testlog059_1.prn_typ = 9926;
      Testlog059_1.void_serial_no = 'abc27';
      Testlog059_1.qc_serial_no = 'abc28';
      Testlog059_1.void_kind = 9929;
      Testlog059_1.void_sale_date = 'abc30';
      Testlog059_1.data_log_cnt = 9931;
      Testlog059_1.ej_log_cnt = 9932;
      Testlog059_1.status_log_cnt = 9933;
      Testlog059_1.tran_flg = 9934;
      Testlog059_1.sub_tran_flg = 9935;
      Testlog059_1.off_entry_flg = 9936;
      Testlog059_1.various_flg_1 = 9937;
      Testlog059_1.various_flg_2 = 9938;
      Testlog059_1.various_flg_3 = 9939;
      Testlog059_1.various_num_1 = 9940;
      Testlog059_1.various_num_2 = 9941;
      Testlog059_1.various_num_3 = 9942;
      Testlog059_1.various_data = 'abc43';
      Testlog059_1.various_flg_4 = 9944;
      Testlog059_1.various_flg_5 = 9945;
      Testlog059_1.various_flg_6 = 9946;
      Testlog059_1.various_flg_7 = 9947;
      Testlog059_1.various_flg_8 = 9948;
      Testlog059_1.various_flg_9 = 9949;
      Testlog059_1.various_flg_10 = 9950;
      Testlog059_1.various_flg_11 = 9951;
      Testlog059_1.various_flg_12 = 9952;
      Testlog059_1.various_flg_13 = 9953;
      Testlog059_1.reserv_flg = 9954;
      Testlog059_1.reserv_stre_cd = 9955;
      Testlog059_1.reserv_status = 9956;
      Testlog059_1.reserv_chg_cnt = 9957;
      Testlog059_1.reserv_cd = 'abc58';
      Testlog059_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog26> Testlog059_AllRtn = await db.selectAllData(Testlog059_1);
      int count = Testlog059_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog059_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog26 Testlog059_2 = CHeaderLog26();
      //Keyの値を設定する
      Testlog059_2.serial_no = 'abc26';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog26? Testlog059_Rtn = await db.selectDataByPrimaryKey(Testlog059_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog059_Rtn == null) {
        print('\n********** 異常発生：log059_CHeaderLog26_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog059_Rtn?.serial_no,'abc26');
        expect(Testlog059_Rtn?.comp_cd,9913);
        expect(Testlog059_Rtn?.stre_cd,9914);
        expect(Testlog059_Rtn?.mac_no,9915);
        expect(Testlog059_Rtn?.receipt_no,9916);
        expect(Testlog059_Rtn?.print_no,9917);
        expect(Testlog059_Rtn?.cshr_no,9918);
        expect(Testlog059_Rtn?.chkr_no,9919);
        expect(Testlog059_Rtn?.cust_no,'abc20');
        expect(Testlog059_Rtn?.sale_date,'abc21');
        expect(Testlog059_Rtn?.starttime,'abc22');
        expect(Testlog059_Rtn?.endtime,'abc23');
        expect(Testlog059_Rtn?.ope_mode_flg,9924);
        expect(Testlog059_Rtn?.inout_flg,9925);
        expect(Testlog059_Rtn?.prn_typ,9926);
        expect(Testlog059_Rtn?.void_serial_no,'abc27');
        expect(Testlog059_Rtn?.qc_serial_no,'abc28');
        expect(Testlog059_Rtn?.void_kind,9929);
        expect(Testlog059_Rtn?.void_sale_date,'abc30');
        expect(Testlog059_Rtn?.data_log_cnt,9931);
        expect(Testlog059_Rtn?.ej_log_cnt,9932);
        expect(Testlog059_Rtn?.status_log_cnt,9933);
        expect(Testlog059_Rtn?.tran_flg,9934);
        expect(Testlog059_Rtn?.sub_tran_flg,9935);
        expect(Testlog059_Rtn?.off_entry_flg,9936);
        expect(Testlog059_Rtn?.various_flg_1,9937);
        expect(Testlog059_Rtn?.various_flg_2,9938);
        expect(Testlog059_Rtn?.various_flg_3,9939);
        expect(Testlog059_Rtn?.various_num_1,9940);
        expect(Testlog059_Rtn?.various_num_2,9941);
        expect(Testlog059_Rtn?.various_num_3,9942);
        expect(Testlog059_Rtn?.various_data,'abc43');
        expect(Testlog059_Rtn?.various_flg_4,9944);
        expect(Testlog059_Rtn?.various_flg_5,9945);
        expect(Testlog059_Rtn?.various_flg_6,9946);
        expect(Testlog059_Rtn?.various_flg_7,9947);
        expect(Testlog059_Rtn?.various_flg_8,9948);
        expect(Testlog059_Rtn?.various_flg_9,9949);
        expect(Testlog059_Rtn?.various_flg_10,9950);
        expect(Testlog059_Rtn?.various_flg_11,9951);
        expect(Testlog059_Rtn?.various_flg_12,9952);
        expect(Testlog059_Rtn?.various_flg_13,9953);
        expect(Testlog059_Rtn?.reserv_flg,9954);
        expect(Testlog059_Rtn?.reserv_stre_cd,9955);
        expect(Testlog059_Rtn?.reserv_status,9956);
        expect(Testlog059_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog059_Rtn?.reserv_cd,'abc58');
        expect(Testlog059_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog26> Testlog059_AllRtn2 = await db.selectAllData(Testlog059_1);
      int count2 = Testlog059_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog059_1);
      print('********** テスト終了：log059_CHeaderLog26_01 **********\n\n');
    });

    // ********************************************************
    // テストlog060 : CHeaderLog27
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log060_CHeaderLog27_01', () async {
      print('\n********** テスト実行：log060_CHeaderLog27_01 **********');
      CHeaderLog27 Testlog060_1 = CHeaderLog27();
      Testlog060_1.serial_no = 'abc27';
      Testlog060_1.comp_cd = 9913;
      Testlog060_1.stre_cd = 9914;
      Testlog060_1.mac_no = 9915;
      Testlog060_1.receipt_no = 9916;
      Testlog060_1.print_no = 9917;
      Testlog060_1.cshr_no = 9918;
      Testlog060_1.chkr_no = 9919;
      Testlog060_1.cust_no = 'abc20';
      Testlog060_1.sale_date = 'abc21';
      Testlog060_1.starttime = 'abc22';
      Testlog060_1.endtime = 'abc23';
      Testlog060_1.ope_mode_flg = 9924;
      Testlog060_1.inout_flg = 9925;
      Testlog060_1.prn_typ = 9926;
      Testlog060_1.void_serial_no = 'abc27';
      Testlog060_1.qc_serial_no = 'abc28';
      Testlog060_1.void_kind = 9929;
      Testlog060_1.void_sale_date = 'abc30';
      Testlog060_1.data_log_cnt = 9931;
      Testlog060_1.ej_log_cnt = 9932;
      Testlog060_1.status_log_cnt = 9933;
      Testlog060_1.tran_flg = 9934;
      Testlog060_1.sub_tran_flg = 9935;
      Testlog060_1.off_entry_flg = 9936;
      Testlog060_1.various_flg_1 = 9937;
      Testlog060_1.various_flg_2 = 9938;
      Testlog060_1.various_flg_3 = 9939;
      Testlog060_1.various_num_1 = 9940;
      Testlog060_1.various_num_2 = 9941;
      Testlog060_1.various_num_3 = 9942;
      Testlog060_1.various_data = 'abc43';
      Testlog060_1.various_flg_4 = 9944;
      Testlog060_1.various_flg_5 = 9945;
      Testlog060_1.various_flg_6 = 9946;
      Testlog060_1.various_flg_7 = 9947;
      Testlog060_1.various_flg_8 = 9948;
      Testlog060_1.various_flg_9 = 9949;
      Testlog060_1.various_flg_10 = 9950;
      Testlog060_1.various_flg_11 = 9951;
      Testlog060_1.various_flg_12 = 9952;
      Testlog060_1.various_flg_13 = 9953;
      Testlog060_1.reserv_flg = 9954;
      Testlog060_1.reserv_stre_cd = 9955;
      Testlog060_1.reserv_status = 9956;
      Testlog060_1.reserv_chg_cnt = 9957;
      Testlog060_1.reserv_cd = 'abc58';
      Testlog060_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog27> Testlog060_AllRtn = await db.selectAllData(Testlog060_1);
      int count = Testlog060_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog060_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog27 Testlog060_2 = CHeaderLog27();
      //Keyの値を設定する
      Testlog060_2.serial_no = 'abc27';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog27? Testlog060_Rtn = await db.selectDataByPrimaryKey(Testlog060_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog060_Rtn == null) {
        print('\n********** 異常発生：log060_CHeaderLog27_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog060_Rtn?.serial_no,'abc27');
        expect(Testlog060_Rtn?.comp_cd,9913);
        expect(Testlog060_Rtn?.stre_cd,9914);
        expect(Testlog060_Rtn?.mac_no,9915);
        expect(Testlog060_Rtn?.receipt_no,9916);
        expect(Testlog060_Rtn?.print_no,9917);
        expect(Testlog060_Rtn?.cshr_no,9918);
        expect(Testlog060_Rtn?.chkr_no,9919);
        expect(Testlog060_Rtn?.cust_no,'abc20');
        expect(Testlog060_Rtn?.sale_date,'abc21');
        expect(Testlog060_Rtn?.starttime,'abc22');
        expect(Testlog060_Rtn?.endtime,'abc23');
        expect(Testlog060_Rtn?.ope_mode_flg,9924);
        expect(Testlog060_Rtn?.inout_flg,9925);
        expect(Testlog060_Rtn?.prn_typ,9926);
        expect(Testlog060_Rtn?.void_serial_no,'abc27');
        expect(Testlog060_Rtn?.qc_serial_no,'abc28');
        expect(Testlog060_Rtn?.void_kind,9929);
        expect(Testlog060_Rtn?.void_sale_date,'abc30');
        expect(Testlog060_Rtn?.data_log_cnt,9931);
        expect(Testlog060_Rtn?.ej_log_cnt,9932);
        expect(Testlog060_Rtn?.status_log_cnt,9933);
        expect(Testlog060_Rtn?.tran_flg,9934);
        expect(Testlog060_Rtn?.sub_tran_flg,9935);
        expect(Testlog060_Rtn?.off_entry_flg,9936);
        expect(Testlog060_Rtn?.various_flg_1,9937);
        expect(Testlog060_Rtn?.various_flg_2,9938);
        expect(Testlog060_Rtn?.various_flg_3,9939);
        expect(Testlog060_Rtn?.various_num_1,9940);
        expect(Testlog060_Rtn?.various_num_2,9941);
        expect(Testlog060_Rtn?.various_num_3,9942);
        expect(Testlog060_Rtn?.various_data,'abc43');
        expect(Testlog060_Rtn?.various_flg_4,9944);
        expect(Testlog060_Rtn?.various_flg_5,9945);
        expect(Testlog060_Rtn?.various_flg_6,9946);
        expect(Testlog060_Rtn?.various_flg_7,9947);
        expect(Testlog060_Rtn?.various_flg_8,9948);
        expect(Testlog060_Rtn?.various_flg_9,9949);
        expect(Testlog060_Rtn?.various_flg_10,9950);
        expect(Testlog060_Rtn?.various_flg_11,9951);
        expect(Testlog060_Rtn?.various_flg_12,9952);
        expect(Testlog060_Rtn?.various_flg_13,9953);
        expect(Testlog060_Rtn?.reserv_flg,9954);
        expect(Testlog060_Rtn?.reserv_stre_cd,9955);
        expect(Testlog060_Rtn?.reserv_status,9956);
        expect(Testlog060_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog060_Rtn?.reserv_cd,'abc58');
        expect(Testlog060_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog27> Testlog060_AllRtn2 = await db.selectAllData(Testlog060_1);
      int count2 = Testlog060_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog060_1);
      print('********** テスト終了：log060_CHeaderLog27_01 **********\n\n');
    });

    // ********************************************************
    // テストlog061 : CHeaderLog28
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log061_CHeaderLog28_01', () async {
      print('\n********** テスト実行：log061_CHeaderLog28_01 **********');
      CHeaderLog28 Testlog061_1 = CHeaderLog28();
      Testlog061_1.serial_no = 'abc28';
      Testlog061_1.comp_cd = 9913;
      Testlog061_1.stre_cd = 9914;
      Testlog061_1.mac_no = 9915;
      Testlog061_1.receipt_no = 9916;
      Testlog061_1.print_no = 9917;
      Testlog061_1.cshr_no = 9918;
      Testlog061_1.chkr_no = 9919;
      Testlog061_1.cust_no = 'abc20';
      Testlog061_1.sale_date = 'abc21';
      Testlog061_1.starttime = 'abc22';
      Testlog061_1.endtime = 'abc23';
      Testlog061_1.ope_mode_flg = 9924;
      Testlog061_1.inout_flg = 9925;
      Testlog061_1.prn_typ = 9926;
      Testlog061_1.void_serial_no = 'abc27';
      Testlog061_1.qc_serial_no = 'abc28';
      Testlog061_1.void_kind = 9929;
      Testlog061_1.void_sale_date = 'abc30';
      Testlog061_1.data_log_cnt = 9931;
      Testlog061_1.ej_log_cnt = 9932;
      Testlog061_1.status_log_cnt = 9933;
      Testlog061_1.tran_flg = 9934;
      Testlog061_1.sub_tran_flg = 9935;
      Testlog061_1.off_entry_flg = 9936;
      Testlog061_1.various_flg_1 = 9937;
      Testlog061_1.various_flg_2 = 9938;
      Testlog061_1.various_flg_3 = 9939;
      Testlog061_1.various_num_1 = 9940;
      Testlog061_1.various_num_2 = 9941;
      Testlog061_1.various_num_3 = 9942;
      Testlog061_1.various_data = 'abc43';
      Testlog061_1.various_flg_4 = 9944;
      Testlog061_1.various_flg_5 = 9945;
      Testlog061_1.various_flg_6 = 9946;
      Testlog061_1.various_flg_7 = 9947;
      Testlog061_1.various_flg_8 = 9948;
      Testlog061_1.various_flg_9 = 9949;
      Testlog061_1.various_flg_10 = 9950;
      Testlog061_1.various_flg_11 = 9951;
      Testlog061_1.various_flg_12 = 9952;
      Testlog061_1.various_flg_13 = 9953;
      Testlog061_1.reserv_flg = 9954;
      Testlog061_1.reserv_stre_cd = 9955;
      Testlog061_1.reserv_status = 9956;
      Testlog061_1.reserv_chg_cnt = 9957;
      Testlog061_1.reserv_cd = 'abc58';
      Testlog061_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog28> Testlog061_AllRtn = await db.selectAllData(Testlog061_1);
      int count = Testlog061_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog061_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog28 Testlog061_2 = CHeaderLog28();
      //Keyの値を設定する
      Testlog061_2.serial_no = 'abc28';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog28? Testlog061_Rtn = await db.selectDataByPrimaryKey(Testlog061_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog061_Rtn == null) {
        print('\n********** 異常発生：log061_CHeaderLog28_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog061_Rtn?.serial_no,'abc28');
        expect(Testlog061_Rtn?.comp_cd,9913);
        expect(Testlog061_Rtn?.stre_cd,9914);
        expect(Testlog061_Rtn?.mac_no,9915);
        expect(Testlog061_Rtn?.receipt_no,9916);
        expect(Testlog061_Rtn?.print_no,9917);
        expect(Testlog061_Rtn?.cshr_no,9918);
        expect(Testlog061_Rtn?.chkr_no,9919);
        expect(Testlog061_Rtn?.cust_no,'abc20');
        expect(Testlog061_Rtn?.sale_date,'abc21');
        expect(Testlog061_Rtn?.starttime,'abc22');
        expect(Testlog061_Rtn?.endtime,'abc23');
        expect(Testlog061_Rtn?.ope_mode_flg,9924);
        expect(Testlog061_Rtn?.inout_flg,9925);
        expect(Testlog061_Rtn?.prn_typ,9926);
        expect(Testlog061_Rtn?.void_serial_no,'abc27');
        expect(Testlog061_Rtn?.qc_serial_no,'abc28');
        expect(Testlog061_Rtn?.void_kind,9929);
        expect(Testlog061_Rtn?.void_sale_date,'abc30');
        expect(Testlog061_Rtn?.data_log_cnt,9931);
        expect(Testlog061_Rtn?.ej_log_cnt,9932);
        expect(Testlog061_Rtn?.status_log_cnt,9933);
        expect(Testlog061_Rtn?.tran_flg,9934);
        expect(Testlog061_Rtn?.sub_tran_flg,9935);
        expect(Testlog061_Rtn?.off_entry_flg,9936);
        expect(Testlog061_Rtn?.various_flg_1,9937);
        expect(Testlog061_Rtn?.various_flg_2,9938);
        expect(Testlog061_Rtn?.various_flg_3,9939);
        expect(Testlog061_Rtn?.various_num_1,9940);
        expect(Testlog061_Rtn?.various_num_2,9941);
        expect(Testlog061_Rtn?.various_num_3,9942);
        expect(Testlog061_Rtn?.various_data,'abc43');
        expect(Testlog061_Rtn?.various_flg_4,9944);
        expect(Testlog061_Rtn?.various_flg_5,9945);
        expect(Testlog061_Rtn?.various_flg_6,9946);
        expect(Testlog061_Rtn?.various_flg_7,9947);
        expect(Testlog061_Rtn?.various_flg_8,9948);
        expect(Testlog061_Rtn?.various_flg_9,9949);
        expect(Testlog061_Rtn?.various_flg_10,9950);
        expect(Testlog061_Rtn?.various_flg_11,9951);
        expect(Testlog061_Rtn?.various_flg_12,9952);
        expect(Testlog061_Rtn?.various_flg_13,9953);
        expect(Testlog061_Rtn?.reserv_flg,9954);
        expect(Testlog061_Rtn?.reserv_stre_cd,9955);
        expect(Testlog061_Rtn?.reserv_status,9956);
        expect(Testlog061_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog061_Rtn?.reserv_cd,'abc58');
        expect(Testlog061_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog28> Testlog061_AllRtn2 = await db.selectAllData(Testlog061_1);
      int count2 = Testlog061_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog061_1);
      print('********** テスト終了：log061_CHeaderLog28_01 **********\n\n');
    });

    // ********************************************************
    // テストlog062 : CHeaderLog29
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log062_CHeaderLog29_01', () async {
      print('\n********** テスト実行：log062_CHeaderLog29_01 **********');
      CHeaderLog29 Testlog062_1 = CHeaderLog29();
      Testlog062_1.serial_no = 'abc29';
      Testlog062_1.comp_cd = 9913;
      Testlog062_1.stre_cd = 9914;
      Testlog062_1.mac_no = 9915;
      Testlog062_1.receipt_no = 9916;
      Testlog062_1.print_no = 9917;
      Testlog062_1.cshr_no = 9918;
      Testlog062_1.chkr_no = 9919;
      Testlog062_1.cust_no = 'abc20';
      Testlog062_1.sale_date = 'abc21';
      Testlog062_1.starttime = 'abc22';
      Testlog062_1.endtime = 'abc23';
      Testlog062_1.ope_mode_flg = 9924;
      Testlog062_1.inout_flg = 9925;
      Testlog062_1.prn_typ = 9926;
      Testlog062_1.void_serial_no = 'abc27';
      Testlog062_1.qc_serial_no = 'abc28';
      Testlog062_1.void_kind = 9929;
      Testlog062_1.void_sale_date = 'abc30';
      Testlog062_1.data_log_cnt = 9931;
      Testlog062_1.ej_log_cnt = 9932;
      Testlog062_1.status_log_cnt = 9933;
      Testlog062_1.tran_flg = 9934;
      Testlog062_1.sub_tran_flg = 9935;
      Testlog062_1.off_entry_flg = 9936;
      Testlog062_1.various_flg_1 = 9937;
      Testlog062_1.various_flg_2 = 9938;
      Testlog062_1.various_flg_3 = 9939;
      Testlog062_1.various_num_1 = 9940;
      Testlog062_1.various_num_2 = 9941;
      Testlog062_1.various_num_3 = 9942;
      Testlog062_1.various_data = 'abc43';
      Testlog062_1.various_flg_4 = 9944;
      Testlog062_1.various_flg_5 = 9945;
      Testlog062_1.various_flg_6 = 9946;
      Testlog062_1.various_flg_7 = 9947;
      Testlog062_1.various_flg_8 = 9948;
      Testlog062_1.various_flg_9 = 9949;
      Testlog062_1.various_flg_10 = 9950;
      Testlog062_1.various_flg_11 = 9951;
      Testlog062_1.various_flg_12 = 9952;
      Testlog062_1.various_flg_13 = 9953;
      Testlog062_1.reserv_flg = 9954;
      Testlog062_1.reserv_stre_cd = 9955;
      Testlog062_1.reserv_status = 9956;
      Testlog062_1.reserv_chg_cnt = 9957;
      Testlog062_1.reserv_cd = 'abc58';
      Testlog062_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog29> Testlog062_AllRtn = await db.selectAllData(Testlog062_1);
      int count = Testlog062_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog062_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog29 Testlog062_2 = CHeaderLog29();
      //Keyの値を設定する
      Testlog062_2.serial_no = 'abc29';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog29? Testlog062_Rtn = await db.selectDataByPrimaryKey(Testlog062_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog062_Rtn == null) {
        print('\n********** 異常発生：log062_CHeaderLog29_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog062_Rtn?.serial_no,'abc29');
        expect(Testlog062_Rtn?.comp_cd,9913);
        expect(Testlog062_Rtn?.stre_cd,9914);
        expect(Testlog062_Rtn?.mac_no,9915);
        expect(Testlog062_Rtn?.receipt_no,9916);
        expect(Testlog062_Rtn?.print_no,9917);
        expect(Testlog062_Rtn?.cshr_no,9918);
        expect(Testlog062_Rtn?.chkr_no,9919);
        expect(Testlog062_Rtn?.cust_no,'abc20');
        expect(Testlog062_Rtn?.sale_date,'abc21');
        expect(Testlog062_Rtn?.starttime,'abc22');
        expect(Testlog062_Rtn?.endtime,'abc23');
        expect(Testlog062_Rtn?.ope_mode_flg,9924);
        expect(Testlog062_Rtn?.inout_flg,9925);
        expect(Testlog062_Rtn?.prn_typ,9926);
        expect(Testlog062_Rtn?.void_serial_no,'abc27');
        expect(Testlog062_Rtn?.qc_serial_no,'abc28');
        expect(Testlog062_Rtn?.void_kind,9929);
        expect(Testlog062_Rtn?.void_sale_date,'abc30');
        expect(Testlog062_Rtn?.data_log_cnt,9931);
        expect(Testlog062_Rtn?.ej_log_cnt,9932);
        expect(Testlog062_Rtn?.status_log_cnt,9933);
        expect(Testlog062_Rtn?.tran_flg,9934);
        expect(Testlog062_Rtn?.sub_tran_flg,9935);
        expect(Testlog062_Rtn?.off_entry_flg,9936);
        expect(Testlog062_Rtn?.various_flg_1,9937);
        expect(Testlog062_Rtn?.various_flg_2,9938);
        expect(Testlog062_Rtn?.various_flg_3,9939);
        expect(Testlog062_Rtn?.various_num_1,9940);
        expect(Testlog062_Rtn?.various_num_2,9941);
        expect(Testlog062_Rtn?.various_num_3,9942);
        expect(Testlog062_Rtn?.various_data,'abc43');
        expect(Testlog062_Rtn?.various_flg_4,9944);
        expect(Testlog062_Rtn?.various_flg_5,9945);
        expect(Testlog062_Rtn?.various_flg_6,9946);
        expect(Testlog062_Rtn?.various_flg_7,9947);
        expect(Testlog062_Rtn?.various_flg_8,9948);
        expect(Testlog062_Rtn?.various_flg_9,9949);
        expect(Testlog062_Rtn?.various_flg_10,9950);
        expect(Testlog062_Rtn?.various_flg_11,9951);
        expect(Testlog062_Rtn?.various_flg_12,9952);
        expect(Testlog062_Rtn?.various_flg_13,9953);
        expect(Testlog062_Rtn?.reserv_flg,9954);
        expect(Testlog062_Rtn?.reserv_stre_cd,9955);
        expect(Testlog062_Rtn?.reserv_status,9956);
        expect(Testlog062_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog062_Rtn?.reserv_cd,'abc58');
        expect(Testlog062_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog29> Testlog062_AllRtn2 = await db.selectAllData(Testlog062_1);
      int count2 = Testlog062_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog062_1);
      print('********** テスト終了：log062_CHeaderLog29_01 **********\n\n');
    });

    // ********************************************************
    // テストlog063 : CHeaderLog30
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log063_CHeaderLog30_01', () async {
      print('\n********** テスト実行：log063_CHeaderLog30_01 **********');
      CHeaderLog30 Testlog063_1 = CHeaderLog30();
      Testlog063_1.serial_no = 'abc30';
      Testlog063_1.comp_cd = 9913;
      Testlog063_1.stre_cd = 9914;
      Testlog063_1.mac_no = 9915;
      Testlog063_1.receipt_no = 9916;
      Testlog063_1.print_no = 9917;
      Testlog063_1.cshr_no = 9918;
      Testlog063_1.chkr_no = 9919;
      Testlog063_1.cust_no = 'abc20';
      Testlog063_1.sale_date = 'abc21';
      Testlog063_1.starttime = 'abc22';
      Testlog063_1.endtime = 'abc23';
      Testlog063_1.ope_mode_flg = 9924;
      Testlog063_1.inout_flg = 9925;
      Testlog063_1.prn_typ = 9926;
      Testlog063_1.void_serial_no = 'abc27';
      Testlog063_1.qc_serial_no = 'abc28';
      Testlog063_1.void_kind = 9929;
      Testlog063_1.void_sale_date = 'abc30';
      Testlog063_1.data_log_cnt = 9931;
      Testlog063_1.ej_log_cnt = 9932;
      Testlog063_1.status_log_cnt = 9933;
      Testlog063_1.tran_flg = 9934;
      Testlog063_1.sub_tran_flg = 9935;
      Testlog063_1.off_entry_flg = 9936;
      Testlog063_1.various_flg_1 = 9937;
      Testlog063_1.various_flg_2 = 9938;
      Testlog063_1.various_flg_3 = 9939;
      Testlog063_1.various_num_1 = 9940;
      Testlog063_1.various_num_2 = 9941;
      Testlog063_1.various_num_3 = 9942;
      Testlog063_1.various_data = 'abc43';
      Testlog063_1.various_flg_4 = 9944;
      Testlog063_1.various_flg_5 = 9945;
      Testlog063_1.various_flg_6 = 9946;
      Testlog063_1.various_flg_7 = 9947;
      Testlog063_1.various_flg_8 = 9948;
      Testlog063_1.various_flg_9 = 9949;
      Testlog063_1.various_flg_10 = 9950;
      Testlog063_1.various_flg_11 = 9951;
      Testlog063_1.various_flg_12 = 9952;
      Testlog063_1.various_flg_13 = 9953;
      Testlog063_1.reserv_flg = 9954;
      Testlog063_1.reserv_stre_cd = 9955;
      Testlog063_1.reserv_status = 9956;
      Testlog063_1.reserv_chg_cnt = 9957;
      Testlog063_1.reserv_cd = 'abc58';
      Testlog063_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog30> Testlog063_AllRtn = await db.selectAllData(Testlog063_1);
      int count = Testlog063_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog063_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog30 Testlog063_2 = CHeaderLog30();
      //Keyの値を設定する
      Testlog063_2.serial_no = 'abc30';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog30? Testlog063_Rtn = await db.selectDataByPrimaryKey(Testlog063_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog063_Rtn == null) {
        print('\n********** 異常発生：log063_CHeaderLog30_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog063_Rtn?.serial_no,'abc30');
        expect(Testlog063_Rtn?.comp_cd,9913);
        expect(Testlog063_Rtn?.stre_cd,9914);
        expect(Testlog063_Rtn?.mac_no,9915);
        expect(Testlog063_Rtn?.receipt_no,9916);
        expect(Testlog063_Rtn?.print_no,9917);
        expect(Testlog063_Rtn?.cshr_no,9918);
        expect(Testlog063_Rtn?.chkr_no,9919);
        expect(Testlog063_Rtn?.cust_no,'abc20');
        expect(Testlog063_Rtn?.sale_date,'abc21');
        expect(Testlog063_Rtn?.starttime,'abc22');
        expect(Testlog063_Rtn?.endtime,'abc23');
        expect(Testlog063_Rtn?.ope_mode_flg,9924);
        expect(Testlog063_Rtn?.inout_flg,9925);
        expect(Testlog063_Rtn?.prn_typ,9926);
        expect(Testlog063_Rtn?.void_serial_no,'abc27');
        expect(Testlog063_Rtn?.qc_serial_no,'abc28');
        expect(Testlog063_Rtn?.void_kind,9929);
        expect(Testlog063_Rtn?.void_sale_date,'abc30');
        expect(Testlog063_Rtn?.data_log_cnt,9931);
        expect(Testlog063_Rtn?.ej_log_cnt,9932);
        expect(Testlog063_Rtn?.status_log_cnt,9933);
        expect(Testlog063_Rtn?.tran_flg,9934);
        expect(Testlog063_Rtn?.sub_tran_flg,9935);
        expect(Testlog063_Rtn?.off_entry_flg,9936);
        expect(Testlog063_Rtn?.various_flg_1,9937);
        expect(Testlog063_Rtn?.various_flg_2,9938);
        expect(Testlog063_Rtn?.various_flg_3,9939);
        expect(Testlog063_Rtn?.various_num_1,9940);
        expect(Testlog063_Rtn?.various_num_2,9941);
        expect(Testlog063_Rtn?.various_num_3,9942);
        expect(Testlog063_Rtn?.various_data,'abc43');
        expect(Testlog063_Rtn?.various_flg_4,9944);
        expect(Testlog063_Rtn?.various_flg_5,9945);
        expect(Testlog063_Rtn?.various_flg_6,9946);
        expect(Testlog063_Rtn?.various_flg_7,9947);
        expect(Testlog063_Rtn?.various_flg_8,9948);
        expect(Testlog063_Rtn?.various_flg_9,9949);
        expect(Testlog063_Rtn?.various_flg_10,9950);
        expect(Testlog063_Rtn?.various_flg_11,9951);
        expect(Testlog063_Rtn?.various_flg_12,9952);
        expect(Testlog063_Rtn?.various_flg_13,9953);
        expect(Testlog063_Rtn?.reserv_flg,9954);
        expect(Testlog063_Rtn?.reserv_stre_cd,9955);
        expect(Testlog063_Rtn?.reserv_status,9956);
        expect(Testlog063_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog063_Rtn?.reserv_cd,'abc58');
        expect(Testlog063_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog30> Testlog063_AllRtn2 = await db.selectAllData(Testlog063_1);
      int count2 = Testlog063_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog063_1);
      print('********** テスト終了：log063_CHeaderLog30_01 **********\n\n');
    });

    // ********************************************************
    // テストlog064 : CHeaderLog31
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log064_CHeaderLog31_01', () async {
      print('\n********** テスト実行：log064_CHeaderLog31_01 **********');
      CHeaderLog31 Testlog064_1 = CHeaderLog31();
      Testlog064_1.serial_no = 'abc31';
      Testlog064_1.comp_cd = 9913;
      Testlog064_1.stre_cd = 9914;
      Testlog064_1.mac_no = 9915;
      Testlog064_1.receipt_no = 9916;
      Testlog064_1.print_no = 9917;
      Testlog064_1.cshr_no = 9918;
      Testlog064_1.chkr_no = 9919;
      Testlog064_1.cust_no = 'abc20';
      Testlog064_1.sale_date = 'abc21';
      Testlog064_1.starttime = 'abc22';
      Testlog064_1.endtime = 'abc23';
      Testlog064_1.ope_mode_flg = 9924;
      Testlog064_1.inout_flg = 9925;
      Testlog064_1.prn_typ = 9926;
      Testlog064_1.void_serial_no = 'abc27';
      Testlog064_1.qc_serial_no = 'abc28';
      Testlog064_1.void_kind = 9929;
      Testlog064_1.void_sale_date = 'abc30';
      Testlog064_1.data_log_cnt = 9931;
      Testlog064_1.ej_log_cnt = 9932;
      Testlog064_1.status_log_cnt = 9933;
      Testlog064_1.tran_flg = 9934;
      Testlog064_1.sub_tran_flg = 9935;
      Testlog064_1.off_entry_flg = 9936;
      Testlog064_1.various_flg_1 = 9937;
      Testlog064_1.various_flg_2 = 9938;
      Testlog064_1.various_flg_3 = 9939;
      Testlog064_1.various_num_1 = 9940;
      Testlog064_1.various_num_2 = 9941;
      Testlog064_1.various_num_3 = 9942;
      Testlog064_1.various_data = 'abc43';
      Testlog064_1.various_flg_4 = 9944;
      Testlog064_1.various_flg_5 = 9945;
      Testlog064_1.various_flg_6 = 9946;
      Testlog064_1.various_flg_7 = 9947;
      Testlog064_1.various_flg_8 = 9948;
      Testlog064_1.various_flg_9 = 9949;
      Testlog064_1.various_flg_10 = 9950;
      Testlog064_1.various_flg_11 = 9951;
      Testlog064_1.various_flg_12 = 9952;
      Testlog064_1.various_flg_13 = 9953;
      Testlog064_1.reserv_flg = 9954;
      Testlog064_1.reserv_stre_cd = 9955;
      Testlog064_1.reserv_status = 9956;
      Testlog064_1.reserv_chg_cnt = 9957;
      Testlog064_1.reserv_cd = 'abc58';
      Testlog064_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog31> Testlog064_AllRtn = await db.selectAllData(Testlog064_1);
      int count = Testlog064_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog064_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog31 Testlog064_2 = CHeaderLog31();
      //Keyの値を設定する
      Testlog064_2.serial_no = 'abc31';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog31? Testlog064_Rtn = await db.selectDataByPrimaryKey(Testlog064_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog064_Rtn == null) {
        print('\n********** 異常発生：log064_CHeaderLog31_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog064_Rtn?.serial_no,'abc31');
        expect(Testlog064_Rtn?.comp_cd,9913);
        expect(Testlog064_Rtn?.stre_cd,9914);
        expect(Testlog064_Rtn?.mac_no,9915);
        expect(Testlog064_Rtn?.receipt_no,9916);
        expect(Testlog064_Rtn?.print_no,9917);
        expect(Testlog064_Rtn?.cshr_no,9918);
        expect(Testlog064_Rtn?.chkr_no,9919);
        expect(Testlog064_Rtn?.cust_no,'abc20');
        expect(Testlog064_Rtn?.sale_date,'abc21');
        expect(Testlog064_Rtn?.starttime,'abc22');
        expect(Testlog064_Rtn?.endtime,'abc23');
        expect(Testlog064_Rtn?.ope_mode_flg,9924);
        expect(Testlog064_Rtn?.inout_flg,9925);
        expect(Testlog064_Rtn?.prn_typ,9926);
        expect(Testlog064_Rtn?.void_serial_no,'abc27');
        expect(Testlog064_Rtn?.qc_serial_no,'abc28');
        expect(Testlog064_Rtn?.void_kind,9929);
        expect(Testlog064_Rtn?.void_sale_date,'abc30');
        expect(Testlog064_Rtn?.data_log_cnt,9931);
        expect(Testlog064_Rtn?.ej_log_cnt,9932);
        expect(Testlog064_Rtn?.status_log_cnt,9933);
        expect(Testlog064_Rtn?.tran_flg,9934);
        expect(Testlog064_Rtn?.sub_tran_flg,9935);
        expect(Testlog064_Rtn?.off_entry_flg,9936);
        expect(Testlog064_Rtn?.various_flg_1,9937);
        expect(Testlog064_Rtn?.various_flg_2,9938);
        expect(Testlog064_Rtn?.various_flg_3,9939);
        expect(Testlog064_Rtn?.various_num_1,9940);
        expect(Testlog064_Rtn?.various_num_2,9941);
        expect(Testlog064_Rtn?.various_num_3,9942);
        expect(Testlog064_Rtn?.various_data,'abc43');
        expect(Testlog064_Rtn?.various_flg_4,9944);
        expect(Testlog064_Rtn?.various_flg_5,9945);
        expect(Testlog064_Rtn?.various_flg_6,9946);
        expect(Testlog064_Rtn?.various_flg_7,9947);
        expect(Testlog064_Rtn?.various_flg_8,9948);
        expect(Testlog064_Rtn?.various_flg_9,9949);
        expect(Testlog064_Rtn?.various_flg_10,9950);
        expect(Testlog064_Rtn?.various_flg_11,9951);
        expect(Testlog064_Rtn?.various_flg_12,9952);
        expect(Testlog064_Rtn?.various_flg_13,9953);
        expect(Testlog064_Rtn?.reserv_flg,9954);
        expect(Testlog064_Rtn?.reserv_stre_cd,9955);
        expect(Testlog064_Rtn?.reserv_status,9956);
        expect(Testlog064_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog064_Rtn?.reserv_cd,'abc58');
        expect(Testlog064_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog31> Testlog064_AllRtn2 = await db.selectAllData(Testlog064_1);
      int count2 = Testlog064_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog064_1);
      print('********** テスト終了：log064_CHeaderLog31_01 **********\n\n');
    });

    // ********************************************************
    // テストlog065 : CHeaderLogReserv
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log065_CHeaderLogReserv_01', () async {
      print('\n********** テスト実行：log065_CHeaderLogReserv_01 **********');
      CHeaderLogReserv Testlog065_1 = CHeaderLogReserv();
      Testlog065_1.serial_no = 'abc12';
      Testlog065_1.comp_cd = 9913;
      Testlog065_1.stre_cd = 9914;
      Testlog065_1.mac_no = 9915;
      Testlog065_1.receipt_no = 9916;
      Testlog065_1.print_no = 9917;
      Testlog065_1.cshr_no = 9918;
      Testlog065_1.chkr_no = 9919;
      Testlog065_1.cust_no = 'abc20';
      Testlog065_1.sale_date = 'abc21';
      Testlog065_1.starttime = 'abc22';
      Testlog065_1.endtime = 'abc23';
      Testlog065_1.ope_mode_flg = 9924;
      Testlog065_1.inout_flg = 9925;
      Testlog065_1.prn_typ = 9926;
      Testlog065_1.void_serial_no = 'abc27';
      Testlog065_1.qc_serial_no = 'abc28';
      Testlog065_1.void_kind = 9929;
      Testlog065_1.void_sale_date = 'abc30';
      Testlog065_1.data_log_cnt = 9931;
      Testlog065_1.ej_log_cnt = 9932;
      Testlog065_1.status_log_cnt = 9933;
      Testlog065_1.tran_flg = 9934;
      Testlog065_1.sub_tran_flg = 9935;
      Testlog065_1.off_entry_flg = 9936;
      Testlog065_1.various_flg_1 = 9937;
      Testlog065_1.various_flg_2 = 9938;
      Testlog065_1.various_flg_3 = 9939;
      Testlog065_1.various_num_1 = 9940;
      Testlog065_1.various_num_2 = 9941;
      Testlog065_1.various_num_3 = 9942;
      Testlog065_1.various_data = 'abc43';
      Testlog065_1.various_flg_4 = 9944;
      Testlog065_1.various_flg_5 = 9945;
      Testlog065_1.various_flg_6 = 9946;
      Testlog065_1.various_flg_7 = 9947;
      Testlog065_1.various_flg_8 = 9948;
      Testlog065_1.various_flg_9 = 9949;
      Testlog065_1.various_flg_10 = 9950;
      Testlog065_1.various_flg_11 = 9951;
      Testlog065_1.various_flg_12 = 9952;
      Testlog065_1.various_flg_13 = 9953;
      Testlog065_1.reserv_flg = 9954;
      Testlog065_1.reserv_stre_cd = 9955;
      Testlog065_1.reserv_status = 9956;
      Testlog065_1.reserv_chg_cnt = 9957;
      Testlog065_1.reserv_cd = 'abc58';
      Testlog065_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLogReserv> Testlog065_AllRtn = await db.selectAllData(Testlog065_1);
      int count = Testlog065_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog065_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLogReserv Testlog065_2 = CHeaderLogReserv();
      //Keyの値を設定する
      Testlog065_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLogReserv? Testlog065_Rtn = await db.selectDataByPrimaryKey(Testlog065_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog065_Rtn == null) {
        print('\n********** 異常発生：log065_CHeaderLogReserv_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog065_Rtn?.serial_no,'abc12');
        expect(Testlog065_Rtn?.comp_cd,9913);
        expect(Testlog065_Rtn?.stre_cd,9914);
        expect(Testlog065_Rtn?.mac_no,9915);
        expect(Testlog065_Rtn?.receipt_no,9916);
        expect(Testlog065_Rtn?.print_no,9917);
        expect(Testlog065_Rtn?.cshr_no,9918);
        expect(Testlog065_Rtn?.chkr_no,9919);
        expect(Testlog065_Rtn?.cust_no,'abc20');
        expect(Testlog065_Rtn?.sale_date,'abc21');
        expect(Testlog065_Rtn?.starttime,'abc22');
        expect(Testlog065_Rtn?.endtime,'abc23');
        expect(Testlog065_Rtn?.ope_mode_flg,9924);
        expect(Testlog065_Rtn?.inout_flg,9925);
        expect(Testlog065_Rtn?.prn_typ,9926);
        expect(Testlog065_Rtn?.void_serial_no,'abc27');
        expect(Testlog065_Rtn?.qc_serial_no,'abc28');
        expect(Testlog065_Rtn?.void_kind,9929);
        expect(Testlog065_Rtn?.void_sale_date,'abc30');
        expect(Testlog065_Rtn?.data_log_cnt,9931);
        expect(Testlog065_Rtn?.ej_log_cnt,9932);
        expect(Testlog065_Rtn?.status_log_cnt,9933);
        expect(Testlog065_Rtn?.tran_flg,9934);
        expect(Testlog065_Rtn?.sub_tran_flg,9935);
        expect(Testlog065_Rtn?.off_entry_flg,9936);
        expect(Testlog065_Rtn?.various_flg_1,9937);
        expect(Testlog065_Rtn?.various_flg_2,9938);
        expect(Testlog065_Rtn?.various_flg_3,9939);
        expect(Testlog065_Rtn?.various_num_1,9940);
        expect(Testlog065_Rtn?.various_num_2,9941);
        expect(Testlog065_Rtn?.various_num_3,9942);
        expect(Testlog065_Rtn?.various_data,'abc43');
        expect(Testlog065_Rtn?.various_flg_4,9944);
        expect(Testlog065_Rtn?.various_flg_5,9945);
        expect(Testlog065_Rtn?.various_flg_6,9946);
        expect(Testlog065_Rtn?.various_flg_7,9947);
        expect(Testlog065_Rtn?.various_flg_8,9948);
        expect(Testlog065_Rtn?.various_flg_9,9949);
        expect(Testlog065_Rtn?.various_flg_10,9950);
        expect(Testlog065_Rtn?.various_flg_11,9951);
        expect(Testlog065_Rtn?.various_flg_12,9952);
        expect(Testlog065_Rtn?.various_flg_13,9953);
        expect(Testlog065_Rtn?.reserv_flg,9954);
        expect(Testlog065_Rtn?.reserv_stre_cd,9955);
        expect(Testlog065_Rtn?.reserv_status,9956);
        expect(Testlog065_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog065_Rtn?.reserv_cd,'abc58');
        expect(Testlog065_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLogReserv> Testlog065_AllRtn2 = await db.selectAllData(Testlog065_1);
      int count2 = Testlog065_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog065_1);
      print('********** テスト終了：log065_CHeaderLogReserv_01 **********\n\n');
    });

    // ********************************************************
    // テストlog066 : CHeaderLogReserv01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log066_CHeaderLogReserv01_01', () async {
      print('\n********** テスト実行：log066_CHeaderLogReserv01_01 **********');
      CHeaderLogReserv01 Testlog066_1 = CHeaderLogReserv01();
      Testlog066_1.serial_no = 'abc12';
      Testlog066_1.comp_cd = 9913;
      Testlog066_1.stre_cd = 9914;
      Testlog066_1.mac_no = 9915;
      Testlog066_1.receipt_no = 9916;
      Testlog066_1.print_no = 9917;
      Testlog066_1.cshr_no = 9918;
      Testlog066_1.chkr_no = 9919;
      Testlog066_1.cust_no = 'abc20';
      Testlog066_1.sale_date = 'abc21';
      Testlog066_1.starttime = 'abc22';
      Testlog066_1.endtime = 'abc23';
      Testlog066_1.ope_mode_flg = 9924;
      Testlog066_1.inout_flg = 9925;
      Testlog066_1.prn_typ = 9926;
      Testlog066_1.void_serial_no = 'abc27';
      Testlog066_1.qc_serial_no = 'abc28';
      Testlog066_1.void_kind = 9929;
      Testlog066_1.void_sale_date = 'abc30';
      Testlog066_1.data_log_cnt = 9931;
      Testlog066_1.ej_log_cnt = 9932;
      Testlog066_1.status_log_cnt = 9933;
      Testlog066_1.tran_flg = 9934;
      Testlog066_1.sub_tran_flg = 9935;
      Testlog066_1.off_entry_flg = 9936;
      Testlog066_1.various_flg_1 = 9937;
      Testlog066_1.various_flg_2 = 9938;
      Testlog066_1.various_flg_3 = 9939;
      Testlog066_1.various_num_1 = 9940;
      Testlog066_1.various_num_2 = 9941;
      Testlog066_1.various_num_3 = 9942;
      Testlog066_1.various_data = 'abc43';
      Testlog066_1.various_flg_4 = 9944;
      Testlog066_1.various_flg_5 = 9945;
      Testlog066_1.various_flg_6 = 9946;
      Testlog066_1.various_flg_7 = 9947;
      Testlog066_1.various_flg_8 = 9948;
      Testlog066_1.various_flg_9 = 9949;
      Testlog066_1.various_flg_10 = 9950;
      Testlog066_1.various_flg_11 = 9951;
      Testlog066_1.various_flg_12 = 9952;
      Testlog066_1.various_flg_13 = 9953;
      Testlog066_1.reserv_flg = 9954;
      Testlog066_1.reserv_stre_cd = 9955;
      Testlog066_1.reserv_status = 9956;
      Testlog066_1.reserv_chg_cnt = 9957;
      Testlog066_1.reserv_cd = 'abc58';
      Testlog066_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLogReserv01> Testlog066_AllRtn = await db.selectAllData(Testlog066_1);
      int count = Testlog066_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog066_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLogReserv01 Testlog066_2 = CHeaderLogReserv01();
      //Keyの値を設定する
      Testlog066_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLogReserv01? Testlog066_Rtn = await db.selectDataByPrimaryKey(Testlog066_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog066_Rtn == null) {
        print('\n********** 異常発生：log066_CHeaderLogReserv01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog066_Rtn?.serial_no,'abc12');
        expect(Testlog066_Rtn?.comp_cd,9913);
        expect(Testlog066_Rtn?.stre_cd,9914);
        expect(Testlog066_Rtn?.mac_no,9915);
        expect(Testlog066_Rtn?.receipt_no,9916);
        expect(Testlog066_Rtn?.print_no,9917);
        expect(Testlog066_Rtn?.cshr_no,9918);
        expect(Testlog066_Rtn?.chkr_no,9919);
        expect(Testlog066_Rtn?.cust_no,'abc20');
        expect(Testlog066_Rtn?.sale_date,'abc21');
        expect(Testlog066_Rtn?.starttime,'abc22');
        expect(Testlog066_Rtn?.endtime,'abc23');
        expect(Testlog066_Rtn?.ope_mode_flg,9924);
        expect(Testlog066_Rtn?.inout_flg,9925);
        expect(Testlog066_Rtn?.prn_typ,9926);
        expect(Testlog066_Rtn?.void_serial_no,'abc27');
        expect(Testlog066_Rtn?.qc_serial_no,'abc28');
        expect(Testlog066_Rtn?.void_kind,9929);
        expect(Testlog066_Rtn?.void_sale_date,'abc30');
        expect(Testlog066_Rtn?.data_log_cnt,9931);
        expect(Testlog066_Rtn?.ej_log_cnt,9932);
        expect(Testlog066_Rtn?.status_log_cnt,9933);
        expect(Testlog066_Rtn?.tran_flg,9934);
        expect(Testlog066_Rtn?.sub_tran_flg,9935);
        expect(Testlog066_Rtn?.off_entry_flg,9936);
        expect(Testlog066_Rtn?.various_flg_1,9937);
        expect(Testlog066_Rtn?.various_flg_2,9938);
        expect(Testlog066_Rtn?.various_flg_3,9939);
        expect(Testlog066_Rtn?.various_num_1,9940);
        expect(Testlog066_Rtn?.various_num_2,9941);
        expect(Testlog066_Rtn?.various_num_3,9942);
        expect(Testlog066_Rtn?.various_data,'abc43');
        expect(Testlog066_Rtn?.various_flg_4,9944);
        expect(Testlog066_Rtn?.various_flg_5,9945);
        expect(Testlog066_Rtn?.various_flg_6,9946);
        expect(Testlog066_Rtn?.various_flg_7,9947);
        expect(Testlog066_Rtn?.various_flg_8,9948);
        expect(Testlog066_Rtn?.various_flg_9,9949);
        expect(Testlog066_Rtn?.various_flg_10,9950);
        expect(Testlog066_Rtn?.various_flg_11,9951);
        expect(Testlog066_Rtn?.various_flg_12,9952);
        expect(Testlog066_Rtn?.various_flg_13,9953);
        expect(Testlog066_Rtn?.reserv_flg,9954);
        expect(Testlog066_Rtn?.reserv_stre_cd,9955);
        expect(Testlog066_Rtn?.reserv_status,9956);
        expect(Testlog066_Rtn?.reserv_chg_cnt,9957);
        expect(Testlog066_Rtn?.reserv_cd,'abc58');
        expect(Testlog066_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLogReserv01> Testlog066_AllRtn2 = await db.selectAllData(Testlog066_1);
      int count2 = Testlog066_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog066_1);
      print('********** テスト終了：log066_CHeaderLogReserv01_01 **********\n\n');
    });
  });
}