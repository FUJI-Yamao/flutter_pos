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
本テストでは、以下の64tableを対象にする
status_logs_table_access.dart 実績ステータスログ 日付別 33tables
ej_logs_table_access.dart 実績ジャーナルデータログ 日付別 31tables
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
    // テストlog067 : CStatusLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log067_CStatusLog01_01', () async {
      print('\n********** テスト実行：log067_CStatusLog01_01 **********');
      CStatusLog01 Testlog067_1 = CStatusLog01();
      Testlog067_1.serial_no = 'abc12';
      Testlog067_1.seq_no = 9913;
      Testlog067_1.cnct_seq_no = 9914;
      Testlog067_1.func_cd = 9915;
      Testlog067_1.func_seq_no = 9916;
      Testlog067_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog01> Testlog067_AllRtn = await db.selectAllData(Testlog067_1);
      int count = Testlog067_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog067_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog01 Testlog067_2 = CStatusLog01();
      //Keyの値を設定する
      Testlog067_2.serial_no = 'abc12';
      Testlog067_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog01? Testlog067_Rtn = await db.selectDataByPrimaryKey(Testlog067_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog067_Rtn == null) {
        print('\n********** 異常発生：log067_CStatusLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog067_Rtn?.serial_no,'abc12');
        expect(Testlog067_Rtn?.seq_no,9913);
        expect(Testlog067_Rtn?.cnct_seq_no,9914);
        expect(Testlog067_Rtn?.func_cd,9915);
        expect(Testlog067_Rtn?.func_seq_no,9916);
        expect(Testlog067_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog01> Testlog067_AllRtn2 = await db.selectAllData(Testlog067_1);
      int count2 = Testlog067_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog067_1);
      print('********** テスト終了：log067_CStatusLog01_01 **********\n\n');
    });

    // ********************************************************
    // テストlog068 : CStatusLog02
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log068_CStatusLog02_01', () async {
      print('\n********** テスト実行：log068_CStatusLog02_01 **********');
      CStatusLog02 Testlog068_1 = CStatusLog02();
      Testlog068_1.serial_no = 'abc12';
      Testlog068_1.seq_no = 9913;
      Testlog068_1.cnct_seq_no = 9914;
      Testlog068_1.func_cd = 9915;
      Testlog068_1.func_seq_no = 9916;
      Testlog068_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog02> Testlog068_AllRtn = await db.selectAllData(Testlog068_1);
      int count = Testlog068_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog068_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog02 Testlog068_2 = CStatusLog02();
      //Keyの値を設定する
      Testlog068_2.serial_no = 'abc12';
      Testlog068_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog02? Testlog068_Rtn = await db.selectDataByPrimaryKey(Testlog068_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog068_Rtn == null) {
        print('\n********** 異常発生：log068_CStatusLog02_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog068_Rtn?.serial_no,'abc12');
        expect(Testlog068_Rtn?.seq_no,9913);
        expect(Testlog068_Rtn?.cnct_seq_no,9914);
        expect(Testlog068_Rtn?.func_cd,9915);
        expect(Testlog068_Rtn?.func_seq_no,9916);
        expect(Testlog068_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog02> Testlog068_AllRtn2 = await db.selectAllData(Testlog068_1);
      int count2 = Testlog068_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog068_1);
      print('********** テスト終了：log068_CStatusLog02_01 **********\n\n');
    });

    // ********************************************************
    // テストlog069 : CStatusLog03
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log069_CStatusLog03_01', () async {
      print('\n********** テスト実行：log069_CStatusLog03_01 **********');
      CStatusLog03 Testlog069_1 = CStatusLog03();
      Testlog069_1.serial_no = 'abc12';
      Testlog069_1.seq_no = 9913;
      Testlog069_1.cnct_seq_no = 9914;
      Testlog069_1.func_cd = 9915;
      Testlog069_1.func_seq_no = 9916;
      Testlog069_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog03> Testlog069_AllRtn = await db.selectAllData(Testlog069_1);
      int count = Testlog069_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog069_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog03 Testlog069_2 = CStatusLog03();
      //Keyの値を設定する
      Testlog069_2.serial_no = 'abc12';
      Testlog069_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog03? Testlog069_Rtn = await db.selectDataByPrimaryKey(Testlog069_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog069_Rtn == null) {
        print('\n********** 異常発生：log069_CStatusLog03_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog069_Rtn?.serial_no,'abc12');
        expect(Testlog069_Rtn?.seq_no,9913);
        expect(Testlog069_Rtn?.cnct_seq_no,9914);
        expect(Testlog069_Rtn?.func_cd,9915);
        expect(Testlog069_Rtn?.func_seq_no,9916);
        expect(Testlog069_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog03> Testlog069_AllRtn2 = await db.selectAllData(Testlog069_1);
      int count2 = Testlog069_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog069_1);
      print('********** テスト終了：log069_CStatusLog03_01 **********\n\n');
    });

    // ********************************************************
    // テストlog070 : CStatusLog04
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log070_CStatusLog04_01', () async {
      print('\n********** テスト実行：log070_CStatusLog04_01 **********');
      CStatusLog04 Testlog070_1 = CStatusLog04();
      Testlog070_1.serial_no = 'abc12';
      Testlog070_1.seq_no = 9913;
      Testlog070_1.cnct_seq_no = 9914;
      Testlog070_1.func_cd = 9915;
      Testlog070_1.func_seq_no = 9916;
      Testlog070_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog04> Testlog070_AllRtn = await db.selectAllData(Testlog070_1);
      int count = Testlog070_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog070_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog04 Testlog070_2 = CStatusLog04();
      //Keyの値を設定する
      Testlog070_2.serial_no = 'abc12';
      Testlog070_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog04? Testlog070_Rtn = await db.selectDataByPrimaryKey(Testlog070_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog070_Rtn == null) {
        print('\n********** 異常発生：log070_CStatusLog04_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog070_Rtn?.serial_no,'abc12');
        expect(Testlog070_Rtn?.seq_no,9913);
        expect(Testlog070_Rtn?.cnct_seq_no,9914);
        expect(Testlog070_Rtn?.func_cd,9915);
        expect(Testlog070_Rtn?.func_seq_no,9916);
        expect(Testlog070_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog04> Testlog070_AllRtn2 = await db.selectAllData(Testlog070_1);
      int count2 = Testlog070_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog070_1);
      print('********** テスト終了：log070_CStatusLog04_01 **********\n\n');
    });

    // ********************************************************
    // テストlog071 : CStatusLog05
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log071_CStatusLog05_01', () async {
      print('\n********** テスト実行：log071_CStatusLog05_01 **********');
      CStatusLog05 Testlog071_1 = CStatusLog05();
      Testlog071_1.serial_no = 'abc12';
      Testlog071_1.seq_no = 9913;
      Testlog071_1.cnct_seq_no = 9914;
      Testlog071_1.func_cd = 9915;
      Testlog071_1.func_seq_no = 9916;
      Testlog071_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog05> Testlog071_AllRtn = await db.selectAllData(Testlog071_1);
      int count = Testlog071_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog071_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog05 Testlog071_2 = CStatusLog05();
      //Keyの値を設定する
      Testlog071_2.serial_no = 'abc12';
      Testlog071_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog05? Testlog071_Rtn = await db.selectDataByPrimaryKey(Testlog071_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog071_Rtn == null) {
        print('\n********** 異常発生：log071_CStatusLog05_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog071_Rtn?.serial_no,'abc12');
        expect(Testlog071_Rtn?.seq_no,9913);
        expect(Testlog071_Rtn?.cnct_seq_no,9914);
        expect(Testlog071_Rtn?.func_cd,9915);
        expect(Testlog071_Rtn?.func_seq_no,9916);
        expect(Testlog071_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog05> Testlog071_AllRtn2 = await db.selectAllData(Testlog071_1);
      int count2 = Testlog071_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog071_1);
      print('********** テスト終了：log071_CStatusLog05_01 **********\n\n');
    });

    // ********************************************************
    // テストlog072 : CStatusLog06
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log072_CStatusLog06_01', () async {
      print('\n********** テスト実行：log072_CStatusLog06_01 **********');
      CStatusLog06 Testlog072_1 = CStatusLog06();
      Testlog072_1.serial_no = 'abc12';
      Testlog072_1.seq_no = 9913;
      Testlog072_1.cnct_seq_no = 9914;
      Testlog072_1.func_cd = 9915;
      Testlog072_1.func_seq_no = 9916;
      Testlog072_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog06> Testlog072_AllRtn = await db.selectAllData(Testlog072_1);
      int count = Testlog072_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog072_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog06 Testlog072_2 = CStatusLog06();
      //Keyの値を設定する
      Testlog072_2.serial_no = 'abc12';
      Testlog072_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog06? Testlog072_Rtn = await db.selectDataByPrimaryKey(Testlog072_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog072_Rtn == null) {
        print('\n********** 異常発生：log072_CStatusLog06_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog072_Rtn?.serial_no,'abc12');
        expect(Testlog072_Rtn?.seq_no,9913);
        expect(Testlog072_Rtn?.cnct_seq_no,9914);
        expect(Testlog072_Rtn?.func_cd,9915);
        expect(Testlog072_Rtn?.func_seq_no,9916);
        expect(Testlog072_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog06> Testlog072_AllRtn2 = await db.selectAllData(Testlog072_1);
      int count2 = Testlog072_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog072_1);
      print('********** テスト終了：log072_CStatusLog06_01 **********\n\n');
    });

    // ********************************************************
    // テストlog073 : CStatusLog07
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log073_CStatusLog07_01', () async {
      print('\n********** テスト実行：log073_CStatusLog07_01 **********');
      CStatusLog07 Testlog073_1 = CStatusLog07();
      Testlog073_1.serial_no = 'abc12';
      Testlog073_1.seq_no = 9913;
      Testlog073_1.cnct_seq_no = 9914;
      Testlog073_1.func_cd = 9915;
      Testlog073_1.func_seq_no = 9916;
      Testlog073_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog07> Testlog073_AllRtn = await db.selectAllData(Testlog073_1);
      int count = Testlog073_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog073_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog07 Testlog073_2 = CStatusLog07();
      //Keyの値を設定する
      Testlog073_2.serial_no = 'abc12';
      Testlog073_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog07? Testlog073_Rtn = await db.selectDataByPrimaryKey(Testlog073_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog073_Rtn == null) {
        print('\n********** 異常発生：log073_CStatusLog07_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog073_Rtn?.serial_no,'abc12');
        expect(Testlog073_Rtn?.seq_no,9913);
        expect(Testlog073_Rtn?.cnct_seq_no,9914);
        expect(Testlog073_Rtn?.func_cd,9915);
        expect(Testlog073_Rtn?.func_seq_no,9916);
        expect(Testlog073_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog07> Testlog073_AllRtn2 = await db.selectAllData(Testlog073_1);
      int count2 = Testlog073_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog073_1);
      print('********** テスト終了：log073_CStatusLog07_01 **********\n\n');
    });

    // ********************************************************
    // テストlog074 : CStatusLog08
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log074_CStatusLog08_01', () async {
      print('\n********** テスト実行：log074_CStatusLog08_01 **********');
      CStatusLog08 Testlog074_1 = CStatusLog08();
      Testlog074_1.serial_no = 'abc12';
      Testlog074_1.seq_no = 9913;
      Testlog074_1.cnct_seq_no = 9914;
      Testlog074_1.func_cd = 9915;
      Testlog074_1.func_seq_no = 9916;
      Testlog074_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog08> Testlog074_AllRtn = await db.selectAllData(Testlog074_1);
      int count = Testlog074_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog074_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog08 Testlog074_2 = CStatusLog08();
      //Keyの値を設定する
      Testlog074_2.serial_no = 'abc12';
      Testlog074_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog08? Testlog074_Rtn = await db.selectDataByPrimaryKey(Testlog074_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog074_Rtn == null) {
        print('\n********** 異常発生：log074_CStatusLog08_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog074_Rtn?.serial_no,'abc12');
        expect(Testlog074_Rtn?.seq_no,9913);
        expect(Testlog074_Rtn?.cnct_seq_no,9914);
        expect(Testlog074_Rtn?.func_cd,9915);
        expect(Testlog074_Rtn?.func_seq_no,9916);
        expect(Testlog074_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog08> Testlog074_AllRtn2 = await db.selectAllData(Testlog074_1);
      int count2 = Testlog074_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog074_1);
      print('********** テスト終了：log074_CStatusLog08_01 **********\n\n');
    });

    // ********************************************************
    // テストlog075 : CStatusLog09
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log075_CStatusLog09_01', () async {
      print('\n********** テスト実行：log075_CStatusLog09_01 **********');
      CStatusLog09 Testlog075_1 = CStatusLog09();
      Testlog075_1.serial_no = 'abc12';
      Testlog075_1.seq_no = 9913;
      Testlog075_1.cnct_seq_no = 9914;
      Testlog075_1.func_cd = 9915;
      Testlog075_1.func_seq_no = 9916;
      Testlog075_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog09> Testlog075_AllRtn = await db.selectAllData(Testlog075_1);
      int count = Testlog075_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog075_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog09 Testlog075_2 = CStatusLog09();
      //Keyの値を設定する
      Testlog075_2.serial_no = 'abc12';
      Testlog075_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog09? Testlog075_Rtn = await db.selectDataByPrimaryKey(Testlog075_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog075_Rtn == null) {
        print('\n********** 異常発生：log075_CStatusLog09_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog075_Rtn?.serial_no,'abc12');
        expect(Testlog075_Rtn?.seq_no,9913);
        expect(Testlog075_Rtn?.cnct_seq_no,9914);
        expect(Testlog075_Rtn?.func_cd,9915);
        expect(Testlog075_Rtn?.func_seq_no,9916);
        expect(Testlog075_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog09> Testlog075_AllRtn2 = await db.selectAllData(Testlog075_1);
      int count2 = Testlog075_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog075_1);
      print('********** テスト終了：log075_CStatusLog09_01 **********\n\n');
    });

    // ********************************************************
    // テストlog076 : CStatusLog10
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log076_CStatusLog10_01', () async {
      print('\n********** テスト実行：log076_CStatusLog10_01 **********');
      CStatusLog10 Testlog076_1 = CStatusLog10();
      Testlog076_1.serial_no = 'abc12';
      Testlog076_1.seq_no = 9913;
      Testlog076_1.cnct_seq_no = 9914;
      Testlog076_1.func_cd = 9915;
      Testlog076_1.func_seq_no = 9916;
      Testlog076_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog10> Testlog076_AllRtn = await db.selectAllData(Testlog076_1);
      int count = Testlog076_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog076_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog10 Testlog076_2 = CStatusLog10();
      //Keyの値を設定する
      Testlog076_2.serial_no = 'abc12';
      Testlog076_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog10? Testlog076_Rtn = await db.selectDataByPrimaryKey(Testlog076_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog076_Rtn == null) {
        print('\n********** 異常発生：log076_CStatusLog10_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog076_Rtn?.serial_no,'abc12');
        expect(Testlog076_Rtn?.seq_no,9913);
        expect(Testlog076_Rtn?.cnct_seq_no,9914);
        expect(Testlog076_Rtn?.func_cd,9915);
        expect(Testlog076_Rtn?.func_seq_no,9916);
        expect(Testlog076_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog10> Testlog076_AllRtn2 = await db.selectAllData(Testlog076_1);
      int count2 = Testlog076_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog076_1);
      print('********** テスト終了：log076_CStatusLog10_01 **********\n\n');
    });

    // ********************************************************
    // テストlog077 : CStatusLog11
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log077_CStatusLog11_01', () async {
      print('\n********** テスト実行：log077_CStatusLog11_01 **********');
      CStatusLog11 Testlog077_1 = CStatusLog11();
      Testlog077_1.serial_no = 'abc12';
      Testlog077_1.seq_no = 9913;
      Testlog077_1.cnct_seq_no = 9914;
      Testlog077_1.func_cd = 9915;
      Testlog077_1.func_seq_no = 9916;
      Testlog077_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog11> Testlog077_AllRtn = await db.selectAllData(Testlog077_1);
      int count = Testlog077_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog077_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog11 Testlog077_2 = CStatusLog11();
      //Keyの値を設定する
      Testlog077_2.serial_no = 'abc12';
      Testlog077_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog11? Testlog077_Rtn = await db.selectDataByPrimaryKey(Testlog077_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog077_Rtn == null) {
        print('\n********** 異常発生：log077_CStatusLog11_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog077_Rtn?.serial_no,'abc12');
        expect(Testlog077_Rtn?.seq_no,9913);
        expect(Testlog077_Rtn?.cnct_seq_no,9914);
        expect(Testlog077_Rtn?.func_cd,9915);
        expect(Testlog077_Rtn?.func_seq_no,9916);
        expect(Testlog077_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog11> Testlog077_AllRtn2 = await db.selectAllData(Testlog077_1);
      int count2 = Testlog077_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog077_1);
      print('********** テスト終了：log077_CStatusLog11_01 **********\n\n');
    });

    // ********************************************************
    // テストlog078 : CStatusLog12
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log078_CStatusLog12_01', () async {
      print('\n********** テスト実行：log078_CStatusLog12_01 **********');
      CStatusLog12 Testlog078_1 = CStatusLog12();
      Testlog078_1.serial_no = 'abc12';
      Testlog078_1.seq_no = 9913;
      Testlog078_1.cnct_seq_no = 9914;
      Testlog078_1.func_cd = 9915;
      Testlog078_1.func_seq_no = 9916;
      Testlog078_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog12> Testlog078_AllRtn = await db.selectAllData(Testlog078_1);
      int count = Testlog078_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog078_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog12 Testlog078_2 = CStatusLog12();
      //Keyの値を設定する
      Testlog078_2.serial_no = 'abc12';
      Testlog078_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog12? Testlog078_Rtn = await db.selectDataByPrimaryKey(Testlog078_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog078_Rtn == null) {
        print('\n********** 異常発生：log078_CStatusLog12_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog078_Rtn?.serial_no,'abc12');
        expect(Testlog078_Rtn?.seq_no,9913);
        expect(Testlog078_Rtn?.cnct_seq_no,9914);
        expect(Testlog078_Rtn?.func_cd,9915);
        expect(Testlog078_Rtn?.func_seq_no,9916);
        expect(Testlog078_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog12> Testlog078_AllRtn2 = await db.selectAllData(Testlog078_1);
      int count2 = Testlog078_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog078_1);
      print('********** テスト終了：log078_CStatusLog12_01 **********\n\n');
    });

    // ********************************************************
    // テストlog079 : CStatusLog13
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log079_CStatusLog13_01', () async {
      print('\n********** テスト実行：log079_CStatusLog13_01 **********');
      CStatusLog13 Testlog079_1 = CStatusLog13();
      Testlog079_1.serial_no = 'abc12';
      Testlog079_1.seq_no = 9913;
      Testlog079_1.cnct_seq_no = 9914;
      Testlog079_1.func_cd = 9915;
      Testlog079_1.func_seq_no = 9916;
      Testlog079_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog13> Testlog079_AllRtn = await db.selectAllData(Testlog079_1);
      int count = Testlog079_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog079_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog13 Testlog079_2 = CStatusLog13();
      //Keyの値を設定する
      Testlog079_2.serial_no = 'abc12';
      Testlog079_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog13? Testlog079_Rtn = await db.selectDataByPrimaryKey(Testlog079_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog079_Rtn == null) {
        print('\n********** 異常発生：log079_CStatusLog13_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog079_Rtn?.serial_no,'abc12');
        expect(Testlog079_Rtn?.seq_no,9913);
        expect(Testlog079_Rtn?.cnct_seq_no,9914);
        expect(Testlog079_Rtn?.func_cd,9915);
        expect(Testlog079_Rtn?.func_seq_no,9916);
        expect(Testlog079_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog13> Testlog079_AllRtn2 = await db.selectAllData(Testlog079_1);
      int count2 = Testlog079_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog079_1);
      print('********** テスト終了：log079_CStatusLog13_01 **********\n\n');
    });

    // ********************************************************
    // テストlog080 : CStatusLog14
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log080_CStatusLog14_01', () async {
      print('\n********** テスト実行：log080_CStatusLog14_01 **********');
      CStatusLog14 Testlog080_1 = CStatusLog14();
      Testlog080_1.serial_no = 'abc12';
      Testlog080_1.seq_no = 9913;
      Testlog080_1.cnct_seq_no = 9914;
      Testlog080_1.func_cd = 9915;
      Testlog080_1.func_seq_no = 9916;
      Testlog080_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog14> Testlog080_AllRtn = await db.selectAllData(Testlog080_1);
      int count = Testlog080_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog080_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog14 Testlog080_2 = CStatusLog14();
      //Keyの値を設定する
      Testlog080_2.serial_no = 'abc12';
      Testlog080_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog14? Testlog080_Rtn = await db.selectDataByPrimaryKey(Testlog080_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog080_Rtn == null) {
        print('\n********** 異常発生：log080_CStatusLog14_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog080_Rtn?.serial_no,'abc12');
        expect(Testlog080_Rtn?.seq_no,9913);
        expect(Testlog080_Rtn?.cnct_seq_no,9914);
        expect(Testlog080_Rtn?.func_cd,9915);
        expect(Testlog080_Rtn?.func_seq_no,9916);
        expect(Testlog080_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog14> Testlog080_AllRtn2 = await db.selectAllData(Testlog080_1);
      int count2 = Testlog080_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog080_1);
      print('********** テスト終了：log080_CStatusLog14_01 **********\n\n');
    });

    // ********************************************************
    // テストlog081 : CStatusLog15
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log081_CStatusLog15_01', () async {
      print('\n********** テスト実行：log081_CStatusLog15_01 **********');
      CStatusLog15 Testlog081_1 = CStatusLog15();
      Testlog081_1.serial_no = 'abc12';
      Testlog081_1.seq_no = 9913;
      Testlog081_1.cnct_seq_no = 9914;
      Testlog081_1.func_cd = 9915;
      Testlog081_1.func_seq_no = 9916;
      Testlog081_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog15> Testlog081_AllRtn = await db.selectAllData(Testlog081_1);
      int count = Testlog081_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog081_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog15 Testlog081_2 = CStatusLog15();
      //Keyの値を設定する
      Testlog081_2.serial_no = 'abc12';
      Testlog081_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog15? Testlog081_Rtn = await db.selectDataByPrimaryKey(Testlog081_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog081_Rtn == null) {
        print('\n********** 異常発生：log081_CStatusLog15_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog081_Rtn?.serial_no,'abc12');
        expect(Testlog081_Rtn?.seq_no,9913);
        expect(Testlog081_Rtn?.cnct_seq_no,9914);
        expect(Testlog081_Rtn?.func_cd,9915);
        expect(Testlog081_Rtn?.func_seq_no,9916);
        expect(Testlog081_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog15> Testlog081_AllRtn2 = await db.selectAllData(Testlog081_1);
      int count2 = Testlog081_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog081_1);
      print('********** テスト終了：log081_CStatusLog15_01 **********\n\n');
    });

    // ********************************************************
    // テストlog082 : CStatusLog16
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log082_CStatusLog16_01', () async {
      print('\n********** テスト実行：log082_CStatusLog16_01 **********');
      CStatusLog16 Testlog082_1 = CStatusLog16();
      Testlog082_1.serial_no = 'abc12';
      Testlog082_1.seq_no = 9913;
      Testlog082_1.cnct_seq_no = 9914;
      Testlog082_1.func_cd = 9915;
      Testlog082_1.func_seq_no = 9916;
      Testlog082_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog16> Testlog082_AllRtn = await db.selectAllData(Testlog082_1);
      int count = Testlog082_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog082_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog16 Testlog082_2 = CStatusLog16();
      //Keyの値を設定する
      Testlog082_2.serial_no = 'abc12';
      Testlog082_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog16? Testlog082_Rtn = await db.selectDataByPrimaryKey(Testlog082_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog082_Rtn == null) {
        print('\n********** 異常発生：log082_CStatusLog16_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog082_Rtn?.serial_no,'abc12');
        expect(Testlog082_Rtn?.seq_no,9913);
        expect(Testlog082_Rtn?.cnct_seq_no,9914);
        expect(Testlog082_Rtn?.func_cd,9915);
        expect(Testlog082_Rtn?.func_seq_no,9916);
        expect(Testlog082_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog16> Testlog082_AllRtn2 = await db.selectAllData(Testlog082_1);
      int count2 = Testlog082_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog082_1);
      print('********** テスト終了：log082_CStatusLog16_01 **********\n\n');
    });

    // ********************************************************
    // テストlog083 : CStatusLog17
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log083_CStatusLog17_01', () async {
      print('\n********** テスト実行：log083_CStatusLog17_01 **********');
      CStatusLog17 Testlog083_1 = CStatusLog17();
      Testlog083_1.serial_no = 'abc12';
      Testlog083_1.seq_no = 9913;
      Testlog083_1.cnct_seq_no = 9914;
      Testlog083_1.func_cd = 9915;
      Testlog083_1.func_seq_no = 9916;
      Testlog083_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog17> Testlog083_AllRtn = await db.selectAllData(Testlog083_1);
      int count = Testlog083_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog083_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog17 Testlog083_2 = CStatusLog17();
      //Keyの値を設定する
      Testlog083_2.serial_no = 'abc12';
      Testlog083_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog17? Testlog083_Rtn = await db.selectDataByPrimaryKey(Testlog083_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog083_Rtn == null) {
        print('\n********** 異常発生：log083_CStatusLog17_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog083_Rtn?.serial_no,'abc12');
        expect(Testlog083_Rtn?.seq_no,9913);
        expect(Testlog083_Rtn?.cnct_seq_no,9914);
        expect(Testlog083_Rtn?.func_cd,9915);
        expect(Testlog083_Rtn?.func_seq_no,9916);
        expect(Testlog083_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog17> Testlog083_AllRtn2 = await db.selectAllData(Testlog083_1);
      int count2 = Testlog083_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog083_1);
      print('********** テスト終了：log083_CStatusLog17_01 **********\n\n');
    });

    // ********************************************************
    // テストlog084 : CStatusLog18
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log084_CStatusLog18_01', () async {
      print('\n********** テスト実行：log084_CStatusLog18_01 **********');
      CStatusLog18 Testlog084_1 = CStatusLog18();
      Testlog084_1.serial_no = 'abc12';
      Testlog084_1.seq_no = 9913;
      Testlog084_1.cnct_seq_no = 9914;
      Testlog084_1.func_cd = 9915;
      Testlog084_1.func_seq_no = 9916;
      Testlog084_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog18> Testlog084_AllRtn = await db.selectAllData(Testlog084_1);
      int count = Testlog084_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog084_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog18 Testlog084_2 = CStatusLog18();
      //Keyの値を設定する
      Testlog084_2.serial_no = 'abc12';
      Testlog084_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog18? Testlog084_Rtn = await db.selectDataByPrimaryKey(Testlog084_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog084_Rtn == null) {
        print('\n********** 異常発生：log084_CStatusLog18_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog084_Rtn?.serial_no,'abc12');
        expect(Testlog084_Rtn?.seq_no,9913);
        expect(Testlog084_Rtn?.cnct_seq_no,9914);
        expect(Testlog084_Rtn?.func_cd,9915);
        expect(Testlog084_Rtn?.func_seq_no,9916);
        expect(Testlog084_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog18> Testlog084_AllRtn2 = await db.selectAllData(Testlog084_1);
      int count2 = Testlog084_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog084_1);
      print('********** テスト終了：log084_CStatusLog18_01 **********\n\n');
    });

    // ********************************************************
    // テストlog085 : CStatusLog19
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log085_CStatusLog19_01', () async {
      print('\n********** テスト実行：log085_CStatusLog19_01 **********');
      CStatusLog19 Testlog085_1 = CStatusLog19();
      Testlog085_1.serial_no = 'abc12';
      Testlog085_1.seq_no = 9913;
      Testlog085_1.cnct_seq_no = 9914;
      Testlog085_1.func_cd = 9915;
      Testlog085_1.func_seq_no = 9916;
      Testlog085_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog19> Testlog085_AllRtn = await db.selectAllData(Testlog085_1);
      int count = Testlog085_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog085_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog19 Testlog085_2 = CStatusLog19();
      //Keyの値を設定する
      Testlog085_2.serial_no = 'abc12';
      Testlog085_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog19? Testlog085_Rtn = await db.selectDataByPrimaryKey(Testlog085_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog085_Rtn == null) {
        print('\n********** 異常発生：log085_CStatusLog19_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog085_Rtn?.serial_no,'abc12');
        expect(Testlog085_Rtn?.seq_no,9913);
        expect(Testlog085_Rtn?.cnct_seq_no,9914);
        expect(Testlog085_Rtn?.func_cd,9915);
        expect(Testlog085_Rtn?.func_seq_no,9916);
        expect(Testlog085_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog19> Testlog085_AllRtn2 = await db.selectAllData(Testlog085_1);
      int count2 = Testlog085_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog085_1);
      print('********** テスト終了：log085_CStatusLog19_01 **********\n\n');
    });

    // ********************************************************
    // テストlog086 : CStatusLog20
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log086_CStatusLog20_01', () async {
      print('\n********** テスト実行：log086_CStatusLog20_01 **********');
      CStatusLog20 Testlog086_1 = CStatusLog20();
      Testlog086_1.serial_no = 'abc12';
      Testlog086_1.seq_no = 9913;
      Testlog086_1.cnct_seq_no = 9914;
      Testlog086_1.func_cd = 9915;
      Testlog086_1.func_seq_no = 9916;
      Testlog086_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog20> Testlog086_AllRtn = await db.selectAllData(Testlog086_1);
      int count = Testlog086_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog086_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog20 Testlog086_2 = CStatusLog20();
      //Keyの値を設定する
      Testlog086_2.serial_no = 'abc12';
      Testlog086_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog20? Testlog086_Rtn = await db.selectDataByPrimaryKey(Testlog086_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog086_Rtn == null) {
        print('\n********** 異常発生：log086_CStatusLog20_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog086_Rtn?.serial_no,'abc12');
        expect(Testlog086_Rtn?.seq_no,9913);
        expect(Testlog086_Rtn?.cnct_seq_no,9914);
        expect(Testlog086_Rtn?.func_cd,9915);
        expect(Testlog086_Rtn?.func_seq_no,9916);
        expect(Testlog086_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog20> Testlog086_AllRtn2 = await db.selectAllData(Testlog086_1);
      int count2 = Testlog086_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog086_1);
      print('********** テスト終了：log086_CStatusLog20_01 **********\n\n');
    });

    // ********************************************************
    // テストlog087 : CStatusLog21
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log087_CStatusLog21_01', () async {
      print('\n********** テスト実行：log087_CStatusLog21_01 **********');
      CStatusLog21 Testlog087_1 = CStatusLog21();
      Testlog087_1.serial_no = 'abc12';
      Testlog087_1.seq_no = 9913;
      Testlog087_1.cnct_seq_no = 9914;
      Testlog087_1.func_cd = 9915;
      Testlog087_1.func_seq_no = 9916;
      Testlog087_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog21> Testlog087_AllRtn = await db.selectAllData(Testlog087_1);
      int count = Testlog087_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog087_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog21 Testlog087_2 = CStatusLog21();
      //Keyの値を設定する
      Testlog087_2.serial_no = 'abc12';
      Testlog087_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog21? Testlog087_Rtn = await db.selectDataByPrimaryKey(Testlog087_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog087_Rtn == null) {
        print('\n********** 異常発生：log087_CStatusLog21_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog087_Rtn?.serial_no,'abc12');
        expect(Testlog087_Rtn?.seq_no,9913);
        expect(Testlog087_Rtn?.cnct_seq_no,9914);
        expect(Testlog087_Rtn?.func_cd,9915);
        expect(Testlog087_Rtn?.func_seq_no,9916);
        expect(Testlog087_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog21> Testlog087_AllRtn2 = await db.selectAllData(Testlog087_1);
      int count2 = Testlog087_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog087_1);
      print('********** テスト終了：log087_CStatusLog21_01 **********\n\n');
    });

    // ********************************************************
    // テストlog088 : CStatusLog22
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log088_CStatusLog22_01', () async {
      print('\n********** テスト実行：log088_CStatusLog22_01 **********');
      CStatusLog22 Testlog088_1 = CStatusLog22();
      Testlog088_1.serial_no = 'abc12';
      Testlog088_1.seq_no = 9913;
      Testlog088_1.cnct_seq_no = 9914;
      Testlog088_1.func_cd = 9915;
      Testlog088_1.func_seq_no = 9916;
      Testlog088_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog22> Testlog088_AllRtn = await db.selectAllData(Testlog088_1);
      int count = Testlog088_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog088_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog22 Testlog088_2 = CStatusLog22();
      //Keyの値を設定する
      Testlog088_2.serial_no = 'abc12';
      Testlog088_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog22? Testlog088_Rtn = await db.selectDataByPrimaryKey(Testlog088_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog088_Rtn == null) {
        print('\n********** 異常発生：log088_CStatusLog22_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog088_Rtn?.serial_no,'abc12');
        expect(Testlog088_Rtn?.seq_no,9913);
        expect(Testlog088_Rtn?.cnct_seq_no,9914);
        expect(Testlog088_Rtn?.func_cd,9915);
        expect(Testlog088_Rtn?.func_seq_no,9916);
        expect(Testlog088_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog22> Testlog088_AllRtn2 = await db.selectAllData(Testlog088_1);
      int count2 = Testlog088_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog088_1);
      print('********** テスト終了：log088_CStatusLog22_01 **********\n\n');
    });

    // ********************************************************
    // テストlog089 : CStatusLog23
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log089_CStatusLog23_01', () async {
      print('\n********** テスト実行：log089_CStatusLog23_01 **********');
      CStatusLog23 Testlog089_1 = CStatusLog23();
      Testlog089_1.serial_no = 'abc12';
      Testlog089_1.seq_no = 9913;
      Testlog089_1.cnct_seq_no = 9914;
      Testlog089_1.func_cd = 9915;
      Testlog089_1.func_seq_no = 9916;
      Testlog089_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog23> Testlog089_AllRtn = await db.selectAllData(Testlog089_1);
      int count = Testlog089_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog089_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog23 Testlog089_2 = CStatusLog23();
      //Keyの値を設定する
      Testlog089_2.serial_no = 'abc12';
      Testlog089_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog23? Testlog089_Rtn = await db.selectDataByPrimaryKey(Testlog089_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog089_Rtn == null) {
        print('\n********** 異常発生：log089_CStatusLog23_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog089_Rtn?.serial_no,'abc12');
        expect(Testlog089_Rtn?.seq_no,9913);
        expect(Testlog089_Rtn?.cnct_seq_no,9914);
        expect(Testlog089_Rtn?.func_cd,9915);
        expect(Testlog089_Rtn?.func_seq_no,9916);
        expect(Testlog089_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog23> Testlog089_AllRtn2 = await db.selectAllData(Testlog089_1);
      int count2 = Testlog089_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog089_1);
      print('********** テスト終了：log089_CStatusLog23_01 **********\n\n');
    });

    // ********************************************************
    // テストlog090 : CStatusLog24
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log090_CStatusLog24_01', () async {
      print('\n********** テスト実行：log090_CStatusLog24_01 **********');
      CStatusLog24 Testlog090_1 = CStatusLog24();
      Testlog090_1.serial_no = 'abc12';
      Testlog090_1.seq_no = 9913;
      Testlog090_1.cnct_seq_no = 9914;
      Testlog090_1.func_cd = 9915;
      Testlog090_1.func_seq_no = 9916;
      Testlog090_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog24> Testlog090_AllRtn = await db.selectAllData(Testlog090_1);
      int count = Testlog090_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog090_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog24 Testlog090_2 = CStatusLog24();
      //Keyの値を設定する
      Testlog090_2.serial_no = 'abc12';
      Testlog090_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog24? Testlog090_Rtn = await db.selectDataByPrimaryKey(Testlog090_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog090_Rtn == null) {
        print('\n********** 異常発生：log090_CStatusLog24_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog090_Rtn?.serial_no,'abc12');
        expect(Testlog090_Rtn?.seq_no,9913);
        expect(Testlog090_Rtn?.cnct_seq_no,9914);
        expect(Testlog090_Rtn?.func_cd,9915);
        expect(Testlog090_Rtn?.func_seq_no,9916);
        expect(Testlog090_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog24> Testlog090_AllRtn2 = await db.selectAllData(Testlog090_1);
      int count2 = Testlog090_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog090_1);
      print('********** テスト終了：log090_CStatusLog24_01 **********\n\n');
    });

    // ********************************************************
    // テストlog091 : CStatusLog25
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log091_CStatusLog25_01', () async {
      print('\n********** テスト実行：log091_CStatusLog25_01 **********');
      CStatusLog25 Testlog091_1 = CStatusLog25();
      Testlog091_1.serial_no = 'abc12';
      Testlog091_1.seq_no = 9913;
      Testlog091_1.cnct_seq_no = 9914;
      Testlog091_1.func_cd = 9915;
      Testlog091_1.func_seq_no = 9916;
      Testlog091_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog25> Testlog091_AllRtn = await db.selectAllData(Testlog091_1);
      int count = Testlog091_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog091_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog25 Testlog091_2 = CStatusLog25();
      //Keyの値を設定する
      Testlog091_2.serial_no = 'abc12';
      Testlog091_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog25? Testlog091_Rtn = await db.selectDataByPrimaryKey(Testlog091_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog091_Rtn == null) {
        print('\n********** 異常発生：log091_CStatusLog25_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog091_Rtn?.serial_no,'abc12');
        expect(Testlog091_Rtn?.seq_no,9913);
        expect(Testlog091_Rtn?.cnct_seq_no,9914);
        expect(Testlog091_Rtn?.func_cd,9915);
        expect(Testlog091_Rtn?.func_seq_no,9916);
        expect(Testlog091_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog25> Testlog091_AllRtn2 = await db.selectAllData(Testlog091_1);
      int count2 = Testlog091_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog091_1);
      print('********** テスト終了：log091_CStatusLog25_01 **********\n\n');
    });

    // ********************************************************
    // テストlog092 : CStatusLog26
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log092_CStatusLog26_01', () async {
      print('\n********** テスト実行：log092_CStatusLog26_01 **********');
      CStatusLog26 Testlog092_1 = CStatusLog26();
      Testlog092_1.serial_no = 'abc12';
      Testlog092_1.seq_no = 9913;
      Testlog092_1.cnct_seq_no = 9914;
      Testlog092_1.func_cd = 9915;
      Testlog092_1.func_seq_no = 9916;
      Testlog092_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog26> Testlog092_AllRtn = await db.selectAllData(Testlog092_1);
      int count = Testlog092_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog092_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog26 Testlog092_2 = CStatusLog26();
      //Keyの値を設定する
      Testlog092_2.serial_no = 'abc12';
      Testlog092_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog26? Testlog092_Rtn = await db.selectDataByPrimaryKey(Testlog092_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog092_Rtn == null) {
        print('\n********** 異常発生：log092_CStatusLog26_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog092_Rtn?.serial_no,'abc12');
        expect(Testlog092_Rtn?.seq_no,9913);
        expect(Testlog092_Rtn?.cnct_seq_no,9914);
        expect(Testlog092_Rtn?.func_cd,9915);
        expect(Testlog092_Rtn?.func_seq_no,9916);
        expect(Testlog092_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog26> Testlog092_AllRtn2 = await db.selectAllData(Testlog092_1);
      int count2 = Testlog092_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog092_1);
      print('********** テスト終了：log092_CStatusLog26_01 **********\n\n');
    });

    // ********************************************************
    // テストlog093 : CStatusLog27
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log093_CStatusLog27_01', () async {
      print('\n********** テスト実行：log093_CStatusLog27_01 **********');
      CStatusLog27 Testlog093_1 = CStatusLog27();
      Testlog093_1.serial_no = 'abc12';
      Testlog093_1.seq_no = 9913;
      Testlog093_1.cnct_seq_no = 9914;
      Testlog093_1.func_cd = 9915;
      Testlog093_1.func_seq_no = 9916;
      Testlog093_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog27> Testlog093_AllRtn = await db.selectAllData(Testlog093_1);
      int count = Testlog093_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog093_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog27 Testlog093_2 = CStatusLog27();
      //Keyの値を設定する
      Testlog093_2.serial_no = 'abc12';
      Testlog093_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog27? Testlog093_Rtn = await db.selectDataByPrimaryKey(Testlog093_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog093_Rtn == null) {
        print('\n********** 異常発生：log093_CStatusLog27_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog093_Rtn?.serial_no,'abc12');
        expect(Testlog093_Rtn?.seq_no,9913);
        expect(Testlog093_Rtn?.cnct_seq_no,9914);
        expect(Testlog093_Rtn?.func_cd,9915);
        expect(Testlog093_Rtn?.func_seq_no,9916);
        expect(Testlog093_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog27> Testlog093_AllRtn2 = await db.selectAllData(Testlog093_1);
      int count2 = Testlog093_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog093_1);
      print('********** テスト終了：log093_CStatusLog27_01 **********\n\n');
    });

    // ********************************************************
    // テストlog094 : CStatusLog28
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log094_CStatusLog28_01', () async {
      print('\n********** テスト実行：log094_CStatusLog28_01 **********');
      CStatusLog28 Testlog094_1 = CStatusLog28();
      Testlog094_1.serial_no = 'abc12';
      Testlog094_1.seq_no = 9913;
      Testlog094_1.cnct_seq_no = 9914;
      Testlog094_1.func_cd = 9915;
      Testlog094_1.func_seq_no = 9916;
      Testlog094_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog28> Testlog094_AllRtn = await db.selectAllData(Testlog094_1);
      int count = Testlog094_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog094_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog28 Testlog094_2 = CStatusLog28();
      //Keyの値を設定する
      Testlog094_2.serial_no = 'abc12';
      Testlog094_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog28? Testlog094_Rtn = await db.selectDataByPrimaryKey(Testlog094_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog094_Rtn == null) {
        print('\n********** 異常発生：log094_CStatusLog28_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog094_Rtn?.serial_no,'abc12');
        expect(Testlog094_Rtn?.seq_no,9913);
        expect(Testlog094_Rtn?.cnct_seq_no,9914);
        expect(Testlog094_Rtn?.func_cd,9915);
        expect(Testlog094_Rtn?.func_seq_no,9916);
        expect(Testlog094_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog28> Testlog094_AllRtn2 = await db.selectAllData(Testlog094_1);
      int count2 = Testlog094_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog094_1);
      print('********** テスト終了：log094_CStatusLog28_01 **********\n\n');
    });

    // ********************************************************
    // テストlog095 : CStatusLog29
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log095_CStatusLog29_01', () async {
      print('\n********** テスト実行：log095_CStatusLog29_01 **********');
      CStatusLog29 Testlog095_1 = CStatusLog29();
      Testlog095_1.serial_no = 'abc12';
      Testlog095_1.seq_no = 9913;
      Testlog095_1.cnct_seq_no = 9914;
      Testlog095_1.func_cd = 9915;
      Testlog095_1.func_seq_no = 9916;
      Testlog095_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog29> Testlog095_AllRtn = await db.selectAllData(Testlog095_1);
      int count = Testlog095_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog095_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog29 Testlog095_2 = CStatusLog29();
      //Keyの値を設定する
      Testlog095_2.serial_no = 'abc12';
      Testlog095_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog29? Testlog095_Rtn = await db.selectDataByPrimaryKey(Testlog095_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog095_Rtn == null) {
        print('\n********** 異常発生：log095_CStatusLog29_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog095_Rtn?.serial_no,'abc12');
        expect(Testlog095_Rtn?.seq_no,9913);
        expect(Testlog095_Rtn?.cnct_seq_no,9914);
        expect(Testlog095_Rtn?.func_cd,9915);
        expect(Testlog095_Rtn?.func_seq_no,9916);
        expect(Testlog095_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog29> Testlog095_AllRtn2 = await db.selectAllData(Testlog095_1);
      int count2 = Testlog095_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog095_1);
      print('********** テスト終了：log095_CStatusLog29_01 **********\n\n');
    });

    // ********************************************************
    // テストlog096 : CStatusLog30
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log096_CStatusLog30_01', () async {
      print('\n********** テスト実行：log096_CStatusLog30_01 **********');
      CStatusLog30 Testlog096_1 = CStatusLog30();
      Testlog096_1.serial_no = 'abc12';
      Testlog096_1.seq_no = 9913;
      Testlog096_1.cnct_seq_no = 9914;
      Testlog096_1.func_cd = 9915;
      Testlog096_1.func_seq_no = 9916;
      Testlog096_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog30> Testlog096_AllRtn = await db.selectAllData(Testlog096_1);
      int count = Testlog096_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog096_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog30 Testlog096_2 = CStatusLog30();
      //Keyの値を設定する
      Testlog096_2.serial_no = 'abc12';
      Testlog096_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog30? Testlog096_Rtn = await db.selectDataByPrimaryKey(Testlog096_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog096_Rtn == null) {
        print('\n********** 異常発生：log096_CStatusLog30_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog096_Rtn?.serial_no,'abc12');
        expect(Testlog096_Rtn?.seq_no,9913);
        expect(Testlog096_Rtn?.cnct_seq_no,9914);
        expect(Testlog096_Rtn?.func_cd,9915);
        expect(Testlog096_Rtn?.func_seq_no,9916);
        expect(Testlog096_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog30> Testlog096_AllRtn2 = await db.selectAllData(Testlog096_1);
      int count2 = Testlog096_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog096_1);
      print('********** テスト終了：log096_CStatusLog30_01 **********\n\n');
    });

    // ********************************************************
    // テストlog097 : CStatusLog31
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log097_CStatusLog31_01', () async {
      print('\n********** テスト実行：log097_CStatusLog31_01 **********');
      CStatusLog31 Testlog097_1 = CStatusLog31();
      Testlog097_1.serial_no = 'abc12';
      Testlog097_1.seq_no = 9913;
      Testlog097_1.cnct_seq_no = 9914;
      Testlog097_1.func_cd = 9915;
      Testlog097_1.func_seq_no = 9916;
      Testlog097_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog31> Testlog097_AllRtn = await db.selectAllData(Testlog097_1);
      int count = Testlog097_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog097_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog31 Testlog097_2 = CStatusLog31();
      //Keyの値を設定する
      Testlog097_2.serial_no = 'abc12';
      Testlog097_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog31? Testlog097_Rtn = await db.selectDataByPrimaryKey(Testlog097_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog097_Rtn == null) {
        print('\n********** 異常発生：log097_CStatusLog31_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog097_Rtn?.serial_no,'abc12');
        expect(Testlog097_Rtn?.seq_no,9913);
        expect(Testlog097_Rtn?.cnct_seq_no,9914);
        expect(Testlog097_Rtn?.func_cd,9915);
        expect(Testlog097_Rtn?.func_seq_no,9916);
        expect(Testlog097_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog31> Testlog097_AllRtn2 = await db.selectAllData(Testlog097_1);
      int count2 = Testlog097_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog097_1);
      print('********** テスト終了：log097_CStatusLog31_01 **********\n\n');
    });

    // ********************************************************
    // テストlog098 : CStatusLogReserv
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log098_CStatusLogReserv_01', () async {
      print('\n********** テスト実行：log098_CStatusLogReserv_01 **********');
      CStatusLogReserv Testlog098_1 = CStatusLogReserv();
      Testlog098_1.serial_no = 'abc12';
      Testlog098_1.seq_no = 9913;
      Testlog098_1.cnct_seq_no = 9914;
      Testlog098_1.func_cd = 9915;
      Testlog098_1.func_seq_no = 9916;
      Testlog098_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLogReserv> Testlog098_AllRtn = await db.selectAllData(Testlog098_1);
      int count = Testlog098_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog098_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLogReserv Testlog098_2 = CStatusLogReserv();
      //Keyの値を設定する
      Testlog098_2.serial_no = 'abc12';
      Testlog098_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLogReserv? Testlog098_Rtn = await db.selectDataByPrimaryKey(Testlog098_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog098_Rtn == null) {
        print('\n********** 異常発生：log098_CStatusLogReserv_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog098_Rtn?.serial_no,'abc12');
        expect(Testlog098_Rtn?.seq_no,9913);
        expect(Testlog098_Rtn?.cnct_seq_no,9914);
        expect(Testlog098_Rtn?.func_cd,9915);
        expect(Testlog098_Rtn?.func_seq_no,9916);
        expect(Testlog098_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLogReserv> Testlog098_AllRtn2 = await db.selectAllData(Testlog098_1);
      int count2 = Testlog098_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog098_1);
      print('********** テスト終了：log098_CStatusLogReserv_01 **********\n\n');
    });

    // ********************************************************
    // テストlog099 : CStatusLogReserv01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log099_CStatusLogReserv01_01', () async {
      print('\n********** テスト実行：log099_CStatusLogReserv01_01 **********');
      CStatusLogReserv01 Testlog099_1 = CStatusLogReserv01();
      Testlog099_1.serial_no = 'abc12';
      Testlog099_1.seq_no = 9913;
      Testlog099_1.cnct_seq_no = 9914;
      Testlog099_1.func_cd = 9915;
      Testlog099_1.func_seq_no = 9916;
      Testlog099_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLogReserv01> Testlog099_AllRtn = await db.selectAllData(Testlog099_1);
      int count = Testlog099_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog099_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLogReserv01 Testlog099_2 = CStatusLogReserv01();
      //Keyの値を設定する
      Testlog099_2.serial_no = 'abc12';
      Testlog099_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLogReserv01? Testlog099_Rtn = await db.selectDataByPrimaryKey(Testlog099_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog099_Rtn == null) {
        print('\n********** 異常発生：log099_CStatusLogReserv01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog099_Rtn?.serial_no,'abc12');
        expect(Testlog099_Rtn?.seq_no,9913);
        expect(Testlog099_Rtn?.cnct_seq_no,9914);
        expect(Testlog099_Rtn?.func_cd,9915);
        expect(Testlog099_Rtn?.func_seq_no,9916);
        expect(Testlog099_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLogReserv01> Testlog099_AllRtn2 = await db.selectAllData(Testlog099_1);
      int count2 = Testlog099_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog099_1);
      print('********** テスト終了：log099_CStatusLogReserv01_01 **********\n\n');
    });

    // ********************************************************
    // テストlog100 : CEjLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log100_CEjLog01_01', () async {
      print('\n********** テスト実行：log100_CEjLog01_01 **********');
      CEjLog01 Testlog100_1 = CEjLog01();
      Testlog100_1.serial_no = 'abc12';
      Testlog100_1.comp_cd = 9913;
      Testlog100_1.stre_cd = 9914;
      Testlog100_1.mac_no = 9915;
      Testlog100_1.print_no = 9916;
      Testlog100_1.seq_no = 9917;
      Testlog100_1.receipt_no = 9918;
      Testlog100_1.end_rec_flg = 9919;
      Testlog100_1.only_ejlog_flg = 9920;
      Testlog100_1.cshr_no = 9921;
      Testlog100_1.chkr_no = 9922;
      Testlog100_1.now_sale_datetime = 'abc23';
      Testlog100_1.sale_date = 'abc24';
      Testlog100_1.ope_mode_flg = 9925;
      Testlog100_1.print_data = 'abc26';
      Testlog100_1.sub_only_ejlog_flg = 9927;
      Testlog100_1.trankey_search = 'abc28';
      Testlog100_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog01> Testlog100_AllRtn = await db.selectAllData(Testlog100_1);
      int count = Testlog100_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog100_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog01 Testlog100_2 = CEjLog01();
      //Keyの値を設定する
      Testlog100_2.serial_no = 'abc12';
      Testlog100_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog01? Testlog100_Rtn = await db.selectDataByPrimaryKey(Testlog100_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog100_Rtn == null) {
        print('\n********** 異常発生：log100_CEjLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog100_Rtn?.serial_no,'abc12');
        expect(Testlog100_Rtn?.comp_cd,9913);
        expect(Testlog100_Rtn?.stre_cd,9914);
        expect(Testlog100_Rtn?.mac_no,9915);
        expect(Testlog100_Rtn?.print_no,9916);
        expect(Testlog100_Rtn?.seq_no,9917);
        expect(Testlog100_Rtn?.receipt_no,9918);
        expect(Testlog100_Rtn?.end_rec_flg,9919);
        expect(Testlog100_Rtn?.only_ejlog_flg,9920);
        expect(Testlog100_Rtn?.cshr_no,9921);
        expect(Testlog100_Rtn?.chkr_no,9922);
        expect(Testlog100_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog100_Rtn?.sale_date,'abc24');
        expect(Testlog100_Rtn?.ope_mode_flg,9925);
        expect(Testlog100_Rtn?.print_data,'abc26');
        expect(Testlog100_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog100_Rtn?.trankey_search,'abc28');
        expect(Testlog100_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog01> Testlog100_AllRtn2 = await db.selectAllData(Testlog100_1);
      int count2 = Testlog100_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog100_1);
      print('********** テスト終了：log100_CEjLog01_01 **********\n\n');
    });

    // ********************************************************
    // テストlog101 : CEjLog02
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log101_CEjLog02_01', () async {
      print('\n********** テスト実行：log101_CEjLog02_01 **********');
      CEjLog02 Testlog101_1 = CEjLog02();
      Testlog101_1.serial_no = 'abc12';
      Testlog101_1.comp_cd = 9913;
      Testlog101_1.stre_cd = 9914;
      Testlog101_1.mac_no = 9915;
      Testlog101_1.print_no = 9916;
      Testlog101_1.seq_no = 9917;
      Testlog101_1.receipt_no = 9918;
      Testlog101_1.end_rec_flg = 9919;
      Testlog101_1.only_ejlog_flg = 9920;
      Testlog101_1.cshr_no = 9921;
      Testlog101_1.chkr_no = 9922;
      Testlog101_1.now_sale_datetime = 'abc23';
      Testlog101_1.sale_date = 'abc24';
      Testlog101_1.ope_mode_flg = 9925;
      Testlog101_1.print_data = 'abc26';
      Testlog101_1.sub_only_ejlog_flg = 9927;
      Testlog101_1.trankey_search = 'abc28';
      Testlog101_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog02> Testlog101_AllRtn = await db.selectAllData(Testlog101_1);
      int count = Testlog101_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog101_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog02 Testlog101_2 = CEjLog02();
      //Keyの値を設定する
      Testlog101_2.serial_no = 'abc12';
      Testlog101_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog02? Testlog101_Rtn = await db.selectDataByPrimaryKey(Testlog101_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog101_Rtn == null) {
        print('\n********** 異常発生：log101_CEjLog02_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog101_Rtn?.serial_no,'abc12');
        expect(Testlog101_Rtn?.comp_cd,9913);
        expect(Testlog101_Rtn?.stre_cd,9914);
        expect(Testlog101_Rtn?.mac_no,9915);
        expect(Testlog101_Rtn?.print_no,9916);
        expect(Testlog101_Rtn?.seq_no,9917);
        expect(Testlog101_Rtn?.receipt_no,9918);
        expect(Testlog101_Rtn?.end_rec_flg,9919);
        expect(Testlog101_Rtn?.only_ejlog_flg,9920);
        expect(Testlog101_Rtn?.cshr_no,9921);
        expect(Testlog101_Rtn?.chkr_no,9922);
        expect(Testlog101_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog101_Rtn?.sale_date,'abc24');
        expect(Testlog101_Rtn?.ope_mode_flg,9925);
        expect(Testlog101_Rtn?.print_data,'abc26');
        expect(Testlog101_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog101_Rtn?.trankey_search,'abc28');
        expect(Testlog101_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog02> Testlog101_AllRtn2 = await db.selectAllData(Testlog101_1);
      int count2 = Testlog101_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog101_1);
      print('********** テスト終了：log101_CEjLog02_01 **********\n\n');
    });

    // ********************************************************
    // テストlog102 : CEjLog03
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log102_CEjLog03_01', () async {
      print('\n********** テスト実行：log102_CEjLog03_01 **********');
      CEjLog03 Testlog102_1 = CEjLog03();
      Testlog102_1.serial_no = 'abc12';
      Testlog102_1.comp_cd = 9913;
      Testlog102_1.stre_cd = 9914;
      Testlog102_1.mac_no = 9915;
      Testlog102_1.print_no = 9916;
      Testlog102_1.seq_no = 9917;
      Testlog102_1.receipt_no = 9918;
      Testlog102_1.end_rec_flg = 9919;
      Testlog102_1.only_ejlog_flg = 9920;
      Testlog102_1.cshr_no = 9921;
      Testlog102_1.chkr_no = 9922;
      Testlog102_1.now_sale_datetime = 'abc23';
      Testlog102_1.sale_date = 'abc24';
      Testlog102_1.ope_mode_flg = 9925;
      Testlog102_1.print_data = 'abc26';
      Testlog102_1.sub_only_ejlog_flg = 9927;
      Testlog102_1.trankey_search = 'abc28';
      Testlog102_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog03> Testlog102_AllRtn = await db.selectAllData(Testlog102_1);
      int count = Testlog102_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog102_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog03 Testlog102_2 = CEjLog03();
      //Keyの値を設定する
      Testlog102_2.serial_no = 'abc12';
      Testlog102_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog03? Testlog102_Rtn = await db.selectDataByPrimaryKey(Testlog102_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog102_Rtn == null) {
        print('\n********** 異常発生：log102_CEjLog03_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog102_Rtn?.serial_no,'abc12');
        expect(Testlog102_Rtn?.comp_cd,9913);
        expect(Testlog102_Rtn?.stre_cd,9914);
        expect(Testlog102_Rtn?.mac_no,9915);
        expect(Testlog102_Rtn?.print_no,9916);
        expect(Testlog102_Rtn?.seq_no,9917);
        expect(Testlog102_Rtn?.receipt_no,9918);
        expect(Testlog102_Rtn?.end_rec_flg,9919);
        expect(Testlog102_Rtn?.only_ejlog_flg,9920);
        expect(Testlog102_Rtn?.cshr_no,9921);
        expect(Testlog102_Rtn?.chkr_no,9922);
        expect(Testlog102_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog102_Rtn?.sale_date,'abc24');
        expect(Testlog102_Rtn?.ope_mode_flg,9925);
        expect(Testlog102_Rtn?.print_data,'abc26');
        expect(Testlog102_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog102_Rtn?.trankey_search,'abc28');
        expect(Testlog102_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog03> Testlog102_AllRtn2 = await db.selectAllData(Testlog102_1);
      int count2 = Testlog102_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog102_1);
      print('********** テスト終了：log102_CEjLog03_01 **********\n\n');
    });

    // ********************************************************
    // テストlog103 : CEjLog04
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log103_CEjLog04_01', () async {
      print('\n********** テスト実行：log103_CEjLog04_01 **********');
      CEjLog04 Testlog103_1 = CEjLog04();
      Testlog103_1.serial_no = 'abc12';
      Testlog103_1.comp_cd = 9913;
      Testlog103_1.stre_cd = 9914;
      Testlog103_1.mac_no = 9915;
      Testlog103_1.print_no = 9916;
      Testlog103_1.seq_no = 9917;
      Testlog103_1.receipt_no = 9918;
      Testlog103_1.end_rec_flg = 9919;
      Testlog103_1.only_ejlog_flg = 9920;
      Testlog103_1.cshr_no = 9921;
      Testlog103_1.chkr_no = 9922;
      Testlog103_1.now_sale_datetime = 'abc23';
      Testlog103_1.sale_date = 'abc24';
      Testlog103_1.ope_mode_flg = 9925;
      Testlog103_1.print_data = 'abc26';
      Testlog103_1.sub_only_ejlog_flg = 9927;
      Testlog103_1.trankey_search = 'abc28';
      Testlog103_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog04> Testlog103_AllRtn = await db.selectAllData(Testlog103_1);
      int count = Testlog103_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog103_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog04 Testlog103_2 = CEjLog04();
      //Keyの値を設定する
      Testlog103_2.serial_no = 'abc12';
      Testlog103_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog04? Testlog103_Rtn = await db.selectDataByPrimaryKey(Testlog103_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog103_Rtn == null) {
        print('\n********** 異常発生：log103_CEjLog04_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog103_Rtn?.serial_no,'abc12');
        expect(Testlog103_Rtn?.comp_cd,9913);
        expect(Testlog103_Rtn?.stre_cd,9914);
        expect(Testlog103_Rtn?.mac_no,9915);
        expect(Testlog103_Rtn?.print_no,9916);
        expect(Testlog103_Rtn?.seq_no,9917);
        expect(Testlog103_Rtn?.receipt_no,9918);
        expect(Testlog103_Rtn?.end_rec_flg,9919);
        expect(Testlog103_Rtn?.only_ejlog_flg,9920);
        expect(Testlog103_Rtn?.cshr_no,9921);
        expect(Testlog103_Rtn?.chkr_no,9922);
        expect(Testlog103_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog103_Rtn?.sale_date,'abc24');
        expect(Testlog103_Rtn?.ope_mode_flg,9925);
        expect(Testlog103_Rtn?.print_data,'abc26');
        expect(Testlog103_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog103_Rtn?.trankey_search,'abc28');
        expect(Testlog103_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog04> Testlog103_AllRtn2 = await db.selectAllData(Testlog103_1);
      int count2 = Testlog103_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog103_1);
      print('********** テスト終了：log103_CEjLog04_01 **********\n\n');
    });

    // ********************************************************
    // テストlog104 : CEjLog05
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log104_CEjLog05_01', () async {
      print('\n********** テスト実行：log104_CEjLog05_01 **********');
      CEjLog05 Testlog104_1 = CEjLog05();
      Testlog104_1.serial_no = 'abc12';
      Testlog104_1.comp_cd = 9913;
      Testlog104_1.stre_cd = 9914;
      Testlog104_1.mac_no = 9915;
      Testlog104_1.print_no = 9916;
      Testlog104_1.seq_no = 9917;
      Testlog104_1.receipt_no = 9918;
      Testlog104_1.end_rec_flg = 9919;
      Testlog104_1.only_ejlog_flg = 9920;
      Testlog104_1.cshr_no = 9921;
      Testlog104_1.chkr_no = 9922;
      Testlog104_1.now_sale_datetime = 'abc23';
      Testlog104_1.sale_date = 'abc24';
      Testlog104_1.ope_mode_flg = 9925;
      Testlog104_1.print_data = 'abc26';
      Testlog104_1.sub_only_ejlog_flg = 9927;
      Testlog104_1.trankey_search = 'abc28';
      Testlog104_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog05> Testlog104_AllRtn = await db.selectAllData(Testlog104_1);
      int count = Testlog104_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog104_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog05 Testlog104_2 = CEjLog05();
      //Keyの値を設定する
      Testlog104_2.serial_no = 'abc12';
      Testlog104_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog05? Testlog104_Rtn = await db.selectDataByPrimaryKey(Testlog104_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog104_Rtn == null) {
        print('\n********** 異常発生：log104_CEjLog05_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog104_Rtn?.serial_no,'abc12');
        expect(Testlog104_Rtn?.comp_cd,9913);
        expect(Testlog104_Rtn?.stre_cd,9914);
        expect(Testlog104_Rtn?.mac_no,9915);
        expect(Testlog104_Rtn?.print_no,9916);
        expect(Testlog104_Rtn?.seq_no,9917);
        expect(Testlog104_Rtn?.receipt_no,9918);
        expect(Testlog104_Rtn?.end_rec_flg,9919);
        expect(Testlog104_Rtn?.only_ejlog_flg,9920);
        expect(Testlog104_Rtn?.cshr_no,9921);
        expect(Testlog104_Rtn?.chkr_no,9922);
        expect(Testlog104_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog104_Rtn?.sale_date,'abc24');
        expect(Testlog104_Rtn?.ope_mode_flg,9925);
        expect(Testlog104_Rtn?.print_data,'abc26');
        expect(Testlog104_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog104_Rtn?.trankey_search,'abc28');
        expect(Testlog104_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog05> Testlog104_AllRtn2 = await db.selectAllData(Testlog104_1);
      int count2 = Testlog104_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog104_1);
      print('********** テスト終了：log104_CEjLog05_01 **********\n\n');
    });

    // ********************************************************
    // テストlog105 : CEjLog06
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log105_CEjLog06_01', () async {
      print('\n********** テスト実行：log105_CEjLog06_01 **********');
      CEjLog06 Testlog105_1 = CEjLog06();
      Testlog105_1.serial_no = 'abc12';
      Testlog105_1.comp_cd = 9913;
      Testlog105_1.stre_cd = 9914;
      Testlog105_1.mac_no = 9915;
      Testlog105_1.print_no = 9916;
      Testlog105_1.seq_no = 9917;
      Testlog105_1.receipt_no = 9918;
      Testlog105_1.end_rec_flg = 9919;
      Testlog105_1.only_ejlog_flg = 9920;
      Testlog105_1.cshr_no = 9921;
      Testlog105_1.chkr_no = 9922;
      Testlog105_1.now_sale_datetime = 'abc23';
      Testlog105_1.sale_date = 'abc24';
      Testlog105_1.ope_mode_flg = 9925;
      Testlog105_1.print_data = 'abc26';
      Testlog105_1.sub_only_ejlog_flg = 9927;
      Testlog105_1.trankey_search = 'abc28';
      Testlog105_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog06> Testlog105_AllRtn = await db.selectAllData(Testlog105_1);
      int count = Testlog105_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog105_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog06 Testlog105_2 = CEjLog06();
      //Keyの値を設定する
      Testlog105_2.serial_no = 'abc12';
      Testlog105_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog06? Testlog105_Rtn = await db.selectDataByPrimaryKey(Testlog105_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog105_Rtn == null) {
        print('\n********** 異常発生：log105_CEjLog06_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog105_Rtn?.serial_no,'abc12');
        expect(Testlog105_Rtn?.comp_cd,9913);
        expect(Testlog105_Rtn?.stre_cd,9914);
        expect(Testlog105_Rtn?.mac_no,9915);
        expect(Testlog105_Rtn?.print_no,9916);
        expect(Testlog105_Rtn?.seq_no,9917);
        expect(Testlog105_Rtn?.receipt_no,9918);
        expect(Testlog105_Rtn?.end_rec_flg,9919);
        expect(Testlog105_Rtn?.only_ejlog_flg,9920);
        expect(Testlog105_Rtn?.cshr_no,9921);
        expect(Testlog105_Rtn?.chkr_no,9922);
        expect(Testlog105_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog105_Rtn?.sale_date,'abc24');
        expect(Testlog105_Rtn?.ope_mode_flg,9925);
        expect(Testlog105_Rtn?.print_data,'abc26');
        expect(Testlog105_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog105_Rtn?.trankey_search,'abc28');
        expect(Testlog105_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog06> Testlog105_AllRtn2 = await db.selectAllData(Testlog105_1);
      int count2 = Testlog105_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog105_1);
      print('********** テスト終了：log105_CEjLog06_01 **********\n\n');
    });

    // ********************************************************
    // テストlog106 : CEjLog07
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log106_CEjLog07_01', () async {
      print('\n********** テスト実行：log106_CEjLog07_01 **********');
      CEjLog07 Testlog106_1 = CEjLog07();
      Testlog106_1.serial_no = 'abc12';
      Testlog106_1.comp_cd = 9913;
      Testlog106_1.stre_cd = 9914;
      Testlog106_1.mac_no = 9915;
      Testlog106_1.print_no = 9916;
      Testlog106_1.seq_no = 9917;
      Testlog106_1.receipt_no = 9918;
      Testlog106_1.end_rec_flg = 9919;
      Testlog106_1.only_ejlog_flg = 9920;
      Testlog106_1.cshr_no = 9921;
      Testlog106_1.chkr_no = 9922;
      Testlog106_1.now_sale_datetime = 'abc23';
      Testlog106_1.sale_date = 'abc24';
      Testlog106_1.ope_mode_flg = 9925;
      Testlog106_1.print_data = 'abc26';
      Testlog106_1.sub_only_ejlog_flg = 9927;
      Testlog106_1.trankey_search = 'abc28';
      Testlog106_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog07> Testlog106_AllRtn = await db.selectAllData(Testlog106_1);
      int count = Testlog106_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog106_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog07 Testlog106_2 = CEjLog07();
      //Keyの値を設定する
      Testlog106_2.serial_no = 'abc12';
      Testlog106_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog07? Testlog106_Rtn = await db.selectDataByPrimaryKey(Testlog106_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog106_Rtn == null) {
        print('\n********** 異常発生：log106_CEjLog07_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog106_Rtn?.serial_no,'abc12');
        expect(Testlog106_Rtn?.comp_cd,9913);
        expect(Testlog106_Rtn?.stre_cd,9914);
        expect(Testlog106_Rtn?.mac_no,9915);
        expect(Testlog106_Rtn?.print_no,9916);
        expect(Testlog106_Rtn?.seq_no,9917);
        expect(Testlog106_Rtn?.receipt_no,9918);
        expect(Testlog106_Rtn?.end_rec_flg,9919);
        expect(Testlog106_Rtn?.only_ejlog_flg,9920);
        expect(Testlog106_Rtn?.cshr_no,9921);
        expect(Testlog106_Rtn?.chkr_no,9922);
        expect(Testlog106_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog106_Rtn?.sale_date,'abc24');
        expect(Testlog106_Rtn?.ope_mode_flg,9925);
        expect(Testlog106_Rtn?.print_data,'abc26');
        expect(Testlog106_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog106_Rtn?.trankey_search,'abc28');
        expect(Testlog106_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog07> Testlog106_AllRtn2 = await db.selectAllData(Testlog106_1);
      int count2 = Testlog106_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog106_1);
      print('********** テスト終了：log106_CEjLog07_01 **********\n\n');
    });

    // ********************************************************
    // テストlog107 : CEjLog08
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log107_CEjLog08_01', () async {
      print('\n********** テスト実行：log107_CEjLog08_01 **********');
      CEjLog08 Testlog107_1 = CEjLog08();
      Testlog107_1.serial_no = 'abc12';
      Testlog107_1.comp_cd = 9913;
      Testlog107_1.stre_cd = 9914;
      Testlog107_1.mac_no = 9915;
      Testlog107_1.print_no = 9916;
      Testlog107_1.seq_no = 9917;
      Testlog107_1.receipt_no = 9918;
      Testlog107_1.end_rec_flg = 9919;
      Testlog107_1.only_ejlog_flg = 9920;
      Testlog107_1.cshr_no = 9921;
      Testlog107_1.chkr_no = 9922;
      Testlog107_1.now_sale_datetime = 'abc23';
      Testlog107_1.sale_date = 'abc24';
      Testlog107_1.ope_mode_flg = 9925;
      Testlog107_1.print_data = 'abc26';
      Testlog107_1.sub_only_ejlog_flg = 9927;
      Testlog107_1.trankey_search = 'abc28';
      Testlog107_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog08> Testlog107_AllRtn = await db.selectAllData(Testlog107_1);
      int count = Testlog107_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog107_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog08 Testlog107_2 = CEjLog08();
      //Keyの値を設定する
      Testlog107_2.serial_no = 'abc12';
      Testlog107_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog08? Testlog107_Rtn = await db.selectDataByPrimaryKey(Testlog107_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog107_Rtn == null) {
        print('\n********** 異常発生：log107_CEjLog08_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog107_Rtn?.serial_no,'abc12');
        expect(Testlog107_Rtn?.comp_cd,9913);
        expect(Testlog107_Rtn?.stre_cd,9914);
        expect(Testlog107_Rtn?.mac_no,9915);
        expect(Testlog107_Rtn?.print_no,9916);
        expect(Testlog107_Rtn?.seq_no,9917);
        expect(Testlog107_Rtn?.receipt_no,9918);
        expect(Testlog107_Rtn?.end_rec_flg,9919);
        expect(Testlog107_Rtn?.only_ejlog_flg,9920);
        expect(Testlog107_Rtn?.cshr_no,9921);
        expect(Testlog107_Rtn?.chkr_no,9922);
        expect(Testlog107_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog107_Rtn?.sale_date,'abc24');
        expect(Testlog107_Rtn?.ope_mode_flg,9925);
        expect(Testlog107_Rtn?.print_data,'abc26');
        expect(Testlog107_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog107_Rtn?.trankey_search,'abc28');
        expect(Testlog107_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog08> Testlog107_AllRtn2 = await db.selectAllData(Testlog107_1);
      int count2 = Testlog107_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog107_1);
      print('********** テスト終了：log107_CEjLog08_01 **********\n\n');
    });

    // ********************************************************
    // テストlog108 : CEjLog09
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log108_CEjLog09_01', () async {
      print('\n********** テスト実行：log108_CEjLog09_01 **********');
      CEjLog09 Testlog108_1 = CEjLog09();
      Testlog108_1.serial_no = 'abc12';
      Testlog108_1.comp_cd = 9913;
      Testlog108_1.stre_cd = 9914;
      Testlog108_1.mac_no = 9915;
      Testlog108_1.print_no = 9916;
      Testlog108_1.seq_no = 9917;
      Testlog108_1.receipt_no = 9918;
      Testlog108_1.end_rec_flg = 9919;
      Testlog108_1.only_ejlog_flg = 9920;
      Testlog108_1.cshr_no = 9921;
      Testlog108_1.chkr_no = 9922;
      Testlog108_1.now_sale_datetime = 'abc23';
      Testlog108_1.sale_date = 'abc24';
      Testlog108_1.ope_mode_flg = 9925;
      Testlog108_1.print_data = 'abc26';
      Testlog108_1.sub_only_ejlog_flg = 9927;
      Testlog108_1.trankey_search = 'abc28';
      Testlog108_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog09> Testlog108_AllRtn = await db.selectAllData(Testlog108_1);
      int count = Testlog108_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog108_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog09 Testlog108_2 = CEjLog09();
      //Keyの値を設定する
      Testlog108_2.serial_no = 'abc12';
      Testlog108_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog09? Testlog108_Rtn = await db.selectDataByPrimaryKey(Testlog108_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog108_Rtn == null) {
        print('\n********** 異常発生：log108_CEjLog09_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog108_Rtn?.serial_no,'abc12');
        expect(Testlog108_Rtn?.comp_cd,9913);
        expect(Testlog108_Rtn?.stre_cd,9914);
        expect(Testlog108_Rtn?.mac_no,9915);
        expect(Testlog108_Rtn?.print_no,9916);
        expect(Testlog108_Rtn?.seq_no,9917);
        expect(Testlog108_Rtn?.receipt_no,9918);
        expect(Testlog108_Rtn?.end_rec_flg,9919);
        expect(Testlog108_Rtn?.only_ejlog_flg,9920);
        expect(Testlog108_Rtn?.cshr_no,9921);
        expect(Testlog108_Rtn?.chkr_no,9922);
        expect(Testlog108_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog108_Rtn?.sale_date,'abc24');
        expect(Testlog108_Rtn?.ope_mode_flg,9925);
        expect(Testlog108_Rtn?.print_data,'abc26');
        expect(Testlog108_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog108_Rtn?.trankey_search,'abc28');
        expect(Testlog108_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog09> Testlog108_AllRtn2 = await db.selectAllData(Testlog108_1);
      int count2 = Testlog108_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog108_1);
      print('********** テスト終了：log108_CEjLog09_01 **********\n\n');
    });

    // ********************************************************
    // テストlog109 : CEjLog10
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log109_CEjLog10_01', () async {
      print('\n********** テスト実行：log109_CEjLog10_01 **********');
      CEjLog10 Testlog109_1 = CEjLog10();
      Testlog109_1.serial_no = 'abc12';
      Testlog109_1.comp_cd = 9913;
      Testlog109_1.stre_cd = 9914;
      Testlog109_1.mac_no = 9915;
      Testlog109_1.print_no = 9916;
      Testlog109_1.seq_no = 9917;
      Testlog109_1.receipt_no = 9918;
      Testlog109_1.end_rec_flg = 9919;
      Testlog109_1.only_ejlog_flg = 9920;
      Testlog109_1.cshr_no = 9921;
      Testlog109_1.chkr_no = 9922;
      Testlog109_1.now_sale_datetime = 'abc23';
      Testlog109_1.sale_date = 'abc24';
      Testlog109_1.ope_mode_flg = 9925;
      Testlog109_1.print_data = 'abc26';
      Testlog109_1.sub_only_ejlog_flg = 9927;
      Testlog109_1.trankey_search = 'abc28';
      Testlog109_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog10> Testlog109_AllRtn = await db.selectAllData(Testlog109_1);
      int count = Testlog109_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog109_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog10 Testlog109_2 = CEjLog10();
      //Keyの値を設定する
      Testlog109_2.serial_no = 'abc12';
      Testlog109_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog10? Testlog109_Rtn = await db.selectDataByPrimaryKey(Testlog109_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog109_Rtn == null) {
        print('\n********** 異常発生：log109_CEjLog10_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog109_Rtn?.serial_no,'abc12');
        expect(Testlog109_Rtn?.comp_cd,9913);
        expect(Testlog109_Rtn?.stre_cd,9914);
        expect(Testlog109_Rtn?.mac_no,9915);
        expect(Testlog109_Rtn?.print_no,9916);
        expect(Testlog109_Rtn?.seq_no,9917);
        expect(Testlog109_Rtn?.receipt_no,9918);
        expect(Testlog109_Rtn?.end_rec_flg,9919);
        expect(Testlog109_Rtn?.only_ejlog_flg,9920);
        expect(Testlog109_Rtn?.cshr_no,9921);
        expect(Testlog109_Rtn?.chkr_no,9922);
        expect(Testlog109_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog109_Rtn?.sale_date,'abc24');
        expect(Testlog109_Rtn?.ope_mode_flg,9925);
        expect(Testlog109_Rtn?.print_data,'abc26');
        expect(Testlog109_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog109_Rtn?.trankey_search,'abc28');
        expect(Testlog109_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog10> Testlog109_AllRtn2 = await db.selectAllData(Testlog109_1);
      int count2 = Testlog109_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog109_1);
      print('********** テスト終了：log109_CEjLog10_01 **********\n\n');
    });

    // ********************************************************
    // テストlog110 : CEjLog11
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log110_CEjLog11_01', () async {
      print('\n********** テスト実行：log110_CEjLog11_01 **********');
      CEjLog11 Testlog110_1 = CEjLog11();
      Testlog110_1.serial_no = 'abc12';
      Testlog110_1.comp_cd = 9913;
      Testlog110_1.stre_cd = 9914;
      Testlog110_1.mac_no = 9915;
      Testlog110_1.print_no = 9916;
      Testlog110_1.seq_no = 9917;
      Testlog110_1.receipt_no = 9918;
      Testlog110_1.end_rec_flg = 9919;
      Testlog110_1.only_ejlog_flg = 9920;
      Testlog110_1.cshr_no = 9921;
      Testlog110_1.chkr_no = 9922;
      Testlog110_1.now_sale_datetime = 'abc23';
      Testlog110_1.sale_date = 'abc24';
      Testlog110_1.ope_mode_flg = 9925;
      Testlog110_1.print_data = 'abc26';
      Testlog110_1.sub_only_ejlog_flg = 9927;
      Testlog110_1.trankey_search = 'abc28';
      Testlog110_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog11> Testlog110_AllRtn = await db.selectAllData(Testlog110_1);
      int count = Testlog110_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog110_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog11 Testlog110_2 = CEjLog11();
      //Keyの値を設定する
      Testlog110_2.serial_no = 'abc12';
      Testlog110_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog11? Testlog110_Rtn = await db.selectDataByPrimaryKey(Testlog110_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog110_Rtn == null) {
        print('\n********** 異常発生：log110_CEjLog11_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog110_Rtn?.serial_no,'abc12');
        expect(Testlog110_Rtn?.comp_cd,9913);
        expect(Testlog110_Rtn?.stre_cd,9914);
        expect(Testlog110_Rtn?.mac_no,9915);
        expect(Testlog110_Rtn?.print_no,9916);
        expect(Testlog110_Rtn?.seq_no,9917);
        expect(Testlog110_Rtn?.receipt_no,9918);
        expect(Testlog110_Rtn?.end_rec_flg,9919);
        expect(Testlog110_Rtn?.only_ejlog_flg,9920);
        expect(Testlog110_Rtn?.cshr_no,9921);
        expect(Testlog110_Rtn?.chkr_no,9922);
        expect(Testlog110_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog110_Rtn?.sale_date,'abc24');
        expect(Testlog110_Rtn?.ope_mode_flg,9925);
        expect(Testlog110_Rtn?.print_data,'abc26');
        expect(Testlog110_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog110_Rtn?.trankey_search,'abc28');
        expect(Testlog110_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog11> Testlog110_AllRtn2 = await db.selectAllData(Testlog110_1);
      int count2 = Testlog110_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog110_1);
      print('********** テスト終了：log110_CEjLog11_01 **********\n\n');
    });

    // ********************************************************
    // テストlog111 : CEjLog12
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log111_CEjLog12_01', () async {
      print('\n********** テスト実行：log111_CEjLog12_01 **********');
      CEjLog12 Testlog111_1 = CEjLog12();
      Testlog111_1.serial_no = 'abc12';
      Testlog111_1.comp_cd = 9913;
      Testlog111_1.stre_cd = 9914;
      Testlog111_1.mac_no = 9915;
      Testlog111_1.print_no = 9916;
      Testlog111_1.seq_no = 9917;
      Testlog111_1.receipt_no = 9918;
      Testlog111_1.end_rec_flg = 9919;
      Testlog111_1.only_ejlog_flg = 9920;
      Testlog111_1.cshr_no = 9921;
      Testlog111_1.chkr_no = 9922;
      Testlog111_1.now_sale_datetime = 'abc23';
      Testlog111_1.sale_date = 'abc24';
      Testlog111_1.ope_mode_flg = 9925;
      Testlog111_1.print_data = 'abc26';
      Testlog111_1.sub_only_ejlog_flg = 9927;
      Testlog111_1.trankey_search = 'abc28';
      Testlog111_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog12> Testlog111_AllRtn = await db.selectAllData(Testlog111_1);
      int count = Testlog111_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog111_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog12 Testlog111_2 = CEjLog12();
      //Keyの値を設定する
      Testlog111_2.serial_no = 'abc12';
      Testlog111_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog12? Testlog111_Rtn = await db.selectDataByPrimaryKey(Testlog111_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog111_Rtn == null) {
        print('\n********** 異常発生：log111_CEjLog12_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog111_Rtn?.serial_no,'abc12');
        expect(Testlog111_Rtn?.comp_cd,9913);
        expect(Testlog111_Rtn?.stre_cd,9914);
        expect(Testlog111_Rtn?.mac_no,9915);
        expect(Testlog111_Rtn?.print_no,9916);
        expect(Testlog111_Rtn?.seq_no,9917);
        expect(Testlog111_Rtn?.receipt_no,9918);
        expect(Testlog111_Rtn?.end_rec_flg,9919);
        expect(Testlog111_Rtn?.only_ejlog_flg,9920);
        expect(Testlog111_Rtn?.cshr_no,9921);
        expect(Testlog111_Rtn?.chkr_no,9922);
        expect(Testlog111_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog111_Rtn?.sale_date,'abc24');
        expect(Testlog111_Rtn?.ope_mode_flg,9925);
        expect(Testlog111_Rtn?.print_data,'abc26');
        expect(Testlog111_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog111_Rtn?.trankey_search,'abc28');
        expect(Testlog111_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog12> Testlog111_AllRtn2 = await db.selectAllData(Testlog111_1);
      int count2 = Testlog111_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog111_1);
      print('********** テスト終了：log111_CEjLog12_01 **********\n\n');
    });

    // ********************************************************
    // テストlog112 : CEjLog13
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log112_CEjLog13_01', () async {
      print('\n********** テスト実行：log112_CEjLog13_01 **********');
      CEjLog13 Testlog112_1 = CEjLog13();
      Testlog112_1.serial_no = 'abc12';
      Testlog112_1.comp_cd = 9913;
      Testlog112_1.stre_cd = 9914;
      Testlog112_1.mac_no = 9915;
      Testlog112_1.print_no = 9916;
      Testlog112_1.seq_no = 9917;
      Testlog112_1.receipt_no = 9918;
      Testlog112_1.end_rec_flg = 9919;
      Testlog112_1.only_ejlog_flg = 9920;
      Testlog112_1.cshr_no = 9921;
      Testlog112_1.chkr_no = 9922;
      Testlog112_1.now_sale_datetime = 'abc23';
      Testlog112_1.sale_date = 'abc24';
      Testlog112_1.ope_mode_flg = 9925;
      Testlog112_1.print_data = 'abc26';
      Testlog112_1.sub_only_ejlog_flg = 9927;
      Testlog112_1.trankey_search = 'abc28';
      Testlog112_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog13> Testlog112_AllRtn = await db.selectAllData(Testlog112_1);
      int count = Testlog112_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog112_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog13 Testlog112_2 = CEjLog13();
      //Keyの値を設定する
      Testlog112_2.serial_no = 'abc12';
      Testlog112_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog13? Testlog112_Rtn = await db.selectDataByPrimaryKey(Testlog112_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog112_Rtn == null) {
        print('\n********** 異常発生：log112_CEjLog13_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog112_Rtn?.serial_no,'abc12');
        expect(Testlog112_Rtn?.comp_cd,9913);
        expect(Testlog112_Rtn?.stre_cd,9914);
        expect(Testlog112_Rtn?.mac_no,9915);
        expect(Testlog112_Rtn?.print_no,9916);
        expect(Testlog112_Rtn?.seq_no,9917);
        expect(Testlog112_Rtn?.receipt_no,9918);
        expect(Testlog112_Rtn?.end_rec_flg,9919);
        expect(Testlog112_Rtn?.only_ejlog_flg,9920);
        expect(Testlog112_Rtn?.cshr_no,9921);
        expect(Testlog112_Rtn?.chkr_no,9922);
        expect(Testlog112_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog112_Rtn?.sale_date,'abc24');
        expect(Testlog112_Rtn?.ope_mode_flg,9925);
        expect(Testlog112_Rtn?.print_data,'abc26');
        expect(Testlog112_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog112_Rtn?.trankey_search,'abc28');
        expect(Testlog112_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog13> Testlog112_AllRtn2 = await db.selectAllData(Testlog112_1);
      int count2 = Testlog112_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog112_1);
      print('********** テスト終了：log112_CEjLog13_01 **********\n\n');
    });

    // ********************************************************
    // テストlog113 : CEjLog14
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log113_CEjLog14_01', () async {
      print('\n********** テスト実行：log113_CEjLog14_01 **********');
      CEjLog14 Testlog113_1 = CEjLog14();
      Testlog113_1.serial_no = 'abc12';
      Testlog113_1.comp_cd = 9913;
      Testlog113_1.stre_cd = 9914;
      Testlog113_1.mac_no = 9915;
      Testlog113_1.print_no = 9916;
      Testlog113_1.seq_no = 9917;
      Testlog113_1.receipt_no = 9918;
      Testlog113_1.end_rec_flg = 9919;
      Testlog113_1.only_ejlog_flg = 9920;
      Testlog113_1.cshr_no = 9921;
      Testlog113_1.chkr_no = 9922;
      Testlog113_1.now_sale_datetime = 'abc23';
      Testlog113_1.sale_date = 'abc24';
      Testlog113_1.ope_mode_flg = 9925;
      Testlog113_1.print_data = 'abc26';
      Testlog113_1.sub_only_ejlog_flg = 9927;
      Testlog113_1.trankey_search = 'abc28';
      Testlog113_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog14> Testlog113_AllRtn = await db.selectAllData(Testlog113_1);
      int count = Testlog113_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog113_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog14 Testlog113_2 = CEjLog14();
      //Keyの値を設定する
      Testlog113_2.serial_no = 'abc12';
      Testlog113_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog14? Testlog113_Rtn = await db.selectDataByPrimaryKey(Testlog113_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog113_Rtn == null) {
        print('\n********** 異常発生：log113_CEjLog14_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog113_Rtn?.serial_no,'abc12');
        expect(Testlog113_Rtn?.comp_cd,9913);
        expect(Testlog113_Rtn?.stre_cd,9914);
        expect(Testlog113_Rtn?.mac_no,9915);
        expect(Testlog113_Rtn?.print_no,9916);
        expect(Testlog113_Rtn?.seq_no,9917);
        expect(Testlog113_Rtn?.receipt_no,9918);
        expect(Testlog113_Rtn?.end_rec_flg,9919);
        expect(Testlog113_Rtn?.only_ejlog_flg,9920);
        expect(Testlog113_Rtn?.cshr_no,9921);
        expect(Testlog113_Rtn?.chkr_no,9922);
        expect(Testlog113_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog113_Rtn?.sale_date,'abc24');
        expect(Testlog113_Rtn?.ope_mode_flg,9925);
        expect(Testlog113_Rtn?.print_data,'abc26');
        expect(Testlog113_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog113_Rtn?.trankey_search,'abc28');
        expect(Testlog113_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog14> Testlog113_AllRtn2 = await db.selectAllData(Testlog113_1);
      int count2 = Testlog113_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog113_1);
      print('********** テスト終了：log113_CEjLog14_01 **********\n\n');
    });

    // ********************************************************
    // テストlog114 : CEjLog15
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log114_CEjLog15_01', () async {
      print('\n********** テスト実行：log114_CEjLog15_01 **********');
      CEjLog15 Testlog114_1 = CEjLog15();
      Testlog114_1.serial_no = 'abc12';
      Testlog114_1.comp_cd = 9913;
      Testlog114_1.stre_cd = 9914;
      Testlog114_1.mac_no = 9915;
      Testlog114_1.print_no = 9916;
      Testlog114_1.seq_no = 9917;
      Testlog114_1.receipt_no = 9918;
      Testlog114_1.end_rec_flg = 9919;
      Testlog114_1.only_ejlog_flg = 9920;
      Testlog114_1.cshr_no = 9921;
      Testlog114_1.chkr_no = 9922;
      Testlog114_1.now_sale_datetime = 'abc23';
      Testlog114_1.sale_date = 'abc24';
      Testlog114_1.ope_mode_flg = 9925;
      Testlog114_1.print_data = 'abc26';
      Testlog114_1.sub_only_ejlog_flg = 9927;
      Testlog114_1.trankey_search = 'abc28';
      Testlog114_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog15> Testlog114_AllRtn = await db.selectAllData(Testlog114_1);
      int count = Testlog114_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog114_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog15 Testlog114_2 = CEjLog15();
      //Keyの値を設定する
      Testlog114_2.serial_no = 'abc12';
      Testlog114_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog15? Testlog114_Rtn = await db.selectDataByPrimaryKey(Testlog114_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog114_Rtn == null) {
        print('\n********** 異常発生：log114_CEjLog15_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog114_Rtn?.serial_no,'abc12');
        expect(Testlog114_Rtn?.comp_cd,9913);
        expect(Testlog114_Rtn?.stre_cd,9914);
        expect(Testlog114_Rtn?.mac_no,9915);
        expect(Testlog114_Rtn?.print_no,9916);
        expect(Testlog114_Rtn?.seq_no,9917);
        expect(Testlog114_Rtn?.receipt_no,9918);
        expect(Testlog114_Rtn?.end_rec_flg,9919);
        expect(Testlog114_Rtn?.only_ejlog_flg,9920);
        expect(Testlog114_Rtn?.cshr_no,9921);
        expect(Testlog114_Rtn?.chkr_no,9922);
        expect(Testlog114_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog114_Rtn?.sale_date,'abc24');
        expect(Testlog114_Rtn?.ope_mode_flg,9925);
        expect(Testlog114_Rtn?.print_data,'abc26');
        expect(Testlog114_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog114_Rtn?.trankey_search,'abc28');
        expect(Testlog114_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog15> Testlog114_AllRtn2 = await db.selectAllData(Testlog114_1);
      int count2 = Testlog114_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog114_1);
      print('********** テスト終了：log114_CEjLog15_01 **********\n\n');
    });

    // ********************************************************
    // テストlog115 : CEjLog16
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log115_CEjLog16_01', () async {
      print('\n********** テスト実行：log115_CEjLog16_01 **********');
      CEjLog16 Testlog115_1 = CEjLog16();
      Testlog115_1.serial_no = 'abc12';
      Testlog115_1.comp_cd = 9913;
      Testlog115_1.stre_cd = 9914;
      Testlog115_1.mac_no = 9915;
      Testlog115_1.print_no = 9916;
      Testlog115_1.seq_no = 9917;
      Testlog115_1.receipt_no = 9918;
      Testlog115_1.end_rec_flg = 9919;
      Testlog115_1.only_ejlog_flg = 9920;
      Testlog115_1.cshr_no = 9921;
      Testlog115_1.chkr_no = 9922;
      Testlog115_1.now_sale_datetime = 'abc23';
      Testlog115_1.sale_date = 'abc24';
      Testlog115_1.ope_mode_flg = 9925;
      Testlog115_1.print_data = 'abc26';
      Testlog115_1.sub_only_ejlog_flg = 9927;
      Testlog115_1.trankey_search = 'abc28';
      Testlog115_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog16> Testlog115_AllRtn = await db.selectAllData(Testlog115_1);
      int count = Testlog115_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog115_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog16 Testlog115_2 = CEjLog16();
      //Keyの値を設定する
      Testlog115_2.serial_no = 'abc12';
      Testlog115_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog16? Testlog115_Rtn = await db.selectDataByPrimaryKey(Testlog115_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog115_Rtn == null) {
        print('\n********** 異常発生：log115_CEjLog16_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog115_Rtn?.serial_no,'abc12');
        expect(Testlog115_Rtn?.comp_cd,9913);
        expect(Testlog115_Rtn?.stre_cd,9914);
        expect(Testlog115_Rtn?.mac_no,9915);
        expect(Testlog115_Rtn?.print_no,9916);
        expect(Testlog115_Rtn?.seq_no,9917);
        expect(Testlog115_Rtn?.receipt_no,9918);
        expect(Testlog115_Rtn?.end_rec_flg,9919);
        expect(Testlog115_Rtn?.only_ejlog_flg,9920);
        expect(Testlog115_Rtn?.cshr_no,9921);
        expect(Testlog115_Rtn?.chkr_no,9922);
        expect(Testlog115_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog115_Rtn?.sale_date,'abc24');
        expect(Testlog115_Rtn?.ope_mode_flg,9925);
        expect(Testlog115_Rtn?.print_data,'abc26');
        expect(Testlog115_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog115_Rtn?.trankey_search,'abc28');
        expect(Testlog115_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog16> Testlog115_AllRtn2 = await db.selectAllData(Testlog115_1);
      int count2 = Testlog115_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog115_1);
      print('********** テスト終了：log115_CEjLog16_01 **********\n\n');
    });

    // ********************************************************
    // テストlog116 : CEjLog17
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log116_CEjLog17_01', () async {
      print('\n********** テスト実行：log116_CEjLog17_01 **********');
      CEjLog17 Testlog116_1 = CEjLog17();
      Testlog116_1.serial_no = 'abc12';
      Testlog116_1.comp_cd = 9913;
      Testlog116_1.stre_cd = 9914;
      Testlog116_1.mac_no = 9915;
      Testlog116_1.print_no = 9916;
      Testlog116_1.seq_no = 9917;
      Testlog116_1.receipt_no = 9918;
      Testlog116_1.end_rec_flg = 9919;
      Testlog116_1.only_ejlog_flg = 9920;
      Testlog116_1.cshr_no = 9921;
      Testlog116_1.chkr_no = 9922;
      Testlog116_1.now_sale_datetime = 'abc23';
      Testlog116_1.sale_date = 'abc24';
      Testlog116_1.ope_mode_flg = 9925;
      Testlog116_1.print_data = 'abc26';
      Testlog116_1.sub_only_ejlog_flg = 9927;
      Testlog116_1.trankey_search = 'abc28';
      Testlog116_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog17> Testlog116_AllRtn = await db.selectAllData(Testlog116_1);
      int count = Testlog116_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog116_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog17 Testlog116_2 = CEjLog17();
      //Keyの値を設定する
      Testlog116_2.serial_no = 'abc12';
      Testlog116_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog17? Testlog116_Rtn = await db.selectDataByPrimaryKey(Testlog116_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog116_Rtn == null) {
        print('\n********** 異常発生：log116_CEjLog17_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog116_Rtn?.serial_no,'abc12');
        expect(Testlog116_Rtn?.comp_cd,9913);
        expect(Testlog116_Rtn?.stre_cd,9914);
        expect(Testlog116_Rtn?.mac_no,9915);
        expect(Testlog116_Rtn?.print_no,9916);
        expect(Testlog116_Rtn?.seq_no,9917);
        expect(Testlog116_Rtn?.receipt_no,9918);
        expect(Testlog116_Rtn?.end_rec_flg,9919);
        expect(Testlog116_Rtn?.only_ejlog_flg,9920);
        expect(Testlog116_Rtn?.cshr_no,9921);
        expect(Testlog116_Rtn?.chkr_no,9922);
        expect(Testlog116_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog116_Rtn?.sale_date,'abc24');
        expect(Testlog116_Rtn?.ope_mode_flg,9925);
        expect(Testlog116_Rtn?.print_data,'abc26');
        expect(Testlog116_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog116_Rtn?.trankey_search,'abc28');
        expect(Testlog116_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog17> Testlog116_AllRtn2 = await db.selectAllData(Testlog116_1);
      int count2 = Testlog116_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog116_1);
      print('********** テスト終了：log116_CEjLog17_01 **********\n\n');
    });

    // ********************************************************
    // テストlog117 : CEjLog18
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log117_CEjLog18_01', () async {
      print('\n********** テスト実行：log117_CEjLog18_01 **********');
      CEjLog18 Testlog117_1 = CEjLog18();
      Testlog117_1.serial_no = 'abc12';
      Testlog117_1.comp_cd = 9913;
      Testlog117_1.stre_cd = 9914;
      Testlog117_1.mac_no = 9915;
      Testlog117_1.print_no = 9916;
      Testlog117_1.seq_no = 9917;
      Testlog117_1.receipt_no = 9918;
      Testlog117_1.end_rec_flg = 9919;
      Testlog117_1.only_ejlog_flg = 9920;
      Testlog117_1.cshr_no = 9921;
      Testlog117_1.chkr_no = 9922;
      Testlog117_1.now_sale_datetime = 'abc23';
      Testlog117_1.sale_date = 'abc24';
      Testlog117_1.ope_mode_flg = 9925;
      Testlog117_1.print_data = 'abc26';
      Testlog117_1.sub_only_ejlog_flg = 9927;
      Testlog117_1.trankey_search = 'abc28';
      Testlog117_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog18> Testlog117_AllRtn = await db.selectAllData(Testlog117_1);
      int count = Testlog117_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog117_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog18 Testlog117_2 = CEjLog18();
      //Keyの値を設定する
      Testlog117_2.serial_no = 'abc12';
      Testlog117_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog18? Testlog117_Rtn = await db.selectDataByPrimaryKey(Testlog117_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog117_Rtn == null) {
        print('\n********** 異常発生：log117_CEjLog18_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog117_Rtn?.serial_no,'abc12');
        expect(Testlog117_Rtn?.comp_cd,9913);
        expect(Testlog117_Rtn?.stre_cd,9914);
        expect(Testlog117_Rtn?.mac_no,9915);
        expect(Testlog117_Rtn?.print_no,9916);
        expect(Testlog117_Rtn?.seq_no,9917);
        expect(Testlog117_Rtn?.receipt_no,9918);
        expect(Testlog117_Rtn?.end_rec_flg,9919);
        expect(Testlog117_Rtn?.only_ejlog_flg,9920);
        expect(Testlog117_Rtn?.cshr_no,9921);
        expect(Testlog117_Rtn?.chkr_no,9922);
        expect(Testlog117_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog117_Rtn?.sale_date,'abc24');
        expect(Testlog117_Rtn?.ope_mode_flg,9925);
        expect(Testlog117_Rtn?.print_data,'abc26');
        expect(Testlog117_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog117_Rtn?.trankey_search,'abc28');
        expect(Testlog117_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog18> Testlog117_AllRtn2 = await db.selectAllData(Testlog117_1);
      int count2 = Testlog117_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog117_1);
      print('********** テスト終了：log117_CEjLog18_01 **********\n\n');
    });

    // ********************************************************
    // テストlog118 : CEjLog19
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log118_CEjLog19_01', () async {
      print('\n********** テスト実行：log118_CEjLog19_01 **********');
      CEjLog19 Testlog118_1 = CEjLog19();
      Testlog118_1.serial_no = 'abc12';
      Testlog118_1.comp_cd = 9913;
      Testlog118_1.stre_cd = 9914;
      Testlog118_1.mac_no = 9915;
      Testlog118_1.print_no = 9916;
      Testlog118_1.seq_no = 9917;
      Testlog118_1.receipt_no = 9918;
      Testlog118_1.end_rec_flg = 9919;
      Testlog118_1.only_ejlog_flg = 9920;
      Testlog118_1.cshr_no = 9921;
      Testlog118_1.chkr_no = 9922;
      Testlog118_1.now_sale_datetime = 'abc23';
      Testlog118_1.sale_date = 'abc24';
      Testlog118_1.ope_mode_flg = 9925;
      Testlog118_1.print_data = 'abc26';
      Testlog118_1.sub_only_ejlog_flg = 9927;
      Testlog118_1.trankey_search = 'abc28';
      Testlog118_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog19> Testlog118_AllRtn = await db.selectAllData(Testlog118_1);
      int count = Testlog118_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog118_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog19 Testlog118_2 = CEjLog19();
      //Keyの値を設定する
      Testlog118_2.serial_no = 'abc12';
      Testlog118_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog19? Testlog118_Rtn = await db.selectDataByPrimaryKey(Testlog118_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog118_Rtn == null) {
        print('\n********** 異常発生：log118_CEjLog19_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog118_Rtn?.serial_no,'abc12');
        expect(Testlog118_Rtn?.comp_cd,9913);
        expect(Testlog118_Rtn?.stre_cd,9914);
        expect(Testlog118_Rtn?.mac_no,9915);
        expect(Testlog118_Rtn?.print_no,9916);
        expect(Testlog118_Rtn?.seq_no,9917);
        expect(Testlog118_Rtn?.receipt_no,9918);
        expect(Testlog118_Rtn?.end_rec_flg,9919);
        expect(Testlog118_Rtn?.only_ejlog_flg,9920);
        expect(Testlog118_Rtn?.cshr_no,9921);
        expect(Testlog118_Rtn?.chkr_no,9922);
        expect(Testlog118_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog118_Rtn?.sale_date,'abc24');
        expect(Testlog118_Rtn?.ope_mode_flg,9925);
        expect(Testlog118_Rtn?.print_data,'abc26');
        expect(Testlog118_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog118_Rtn?.trankey_search,'abc28');
        expect(Testlog118_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog19> Testlog118_AllRtn2 = await db.selectAllData(Testlog118_1);
      int count2 = Testlog118_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog118_1);
      print('********** テスト終了：log118_CEjLog19_01 **********\n\n');
    });

    // ********************************************************
    // テストlog119 : CEjLog20
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log119_CEjLog20_01', () async {
      print('\n********** テスト実行：log119_CEjLog20_01 **********');
      CEjLog20 Testlog119_1 = CEjLog20();
      Testlog119_1.serial_no = 'abc12';
      Testlog119_1.comp_cd = 9913;
      Testlog119_1.stre_cd = 9914;
      Testlog119_1.mac_no = 9915;
      Testlog119_1.print_no = 9916;
      Testlog119_1.seq_no = 9917;
      Testlog119_1.receipt_no = 9918;
      Testlog119_1.end_rec_flg = 9919;
      Testlog119_1.only_ejlog_flg = 9920;
      Testlog119_1.cshr_no = 9921;
      Testlog119_1.chkr_no = 9922;
      Testlog119_1.now_sale_datetime = 'abc23';
      Testlog119_1.sale_date = 'abc24';
      Testlog119_1.ope_mode_flg = 9925;
      Testlog119_1.print_data = 'abc26';
      Testlog119_1.sub_only_ejlog_flg = 9927;
      Testlog119_1.trankey_search = 'abc28';
      Testlog119_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog20> Testlog119_AllRtn = await db.selectAllData(Testlog119_1);
      int count = Testlog119_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog119_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog20 Testlog119_2 = CEjLog20();
      //Keyの値を設定する
      Testlog119_2.serial_no = 'abc12';
      Testlog119_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog20? Testlog119_Rtn = await db.selectDataByPrimaryKey(Testlog119_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog119_Rtn == null) {
        print('\n********** 異常発生：log119_CEjLog20_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog119_Rtn?.serial_no,'abc12');
        expect(Testlog119_Rtn?.comp_cd,9913);
        expect(Testlog119_Rtn?.stre_cd,9914);
        expect(Testlog119_Rtn?.mac_no,9915);
        expect(Testlog119_Rtn?.print_no,9916);
        expect(Testlog119_Rtn?.seq_no,9917);
        expect(Testlog119_Rtn?.receipt_no,9918);
        expect(Testlog119_Rtn?.end_rec_flg,9919);
        expect(Testlog119_Rtn?.only_ejlog_flg,9920);
        expect(Testlog119_Rtn?.cshr_no,9921);
        expect(Testlog119_Rtn?.chkr_no,9922);
        expect(Testlog119_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog119_Rtn?.sale_date,'abc24');
        expect(Testlog119_Rtn?.ope_mode_flg,9925);
        expect(Testlog119_Rtn?.print_data,'abc26');
        expect(Testlog119_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog119_Rtn?.trankey_search,'abc28');
        expect(Testlog119_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog20> Testlog119_AllRtn2 = await db.selectAllData(Testlog119_1);
      int count2 = Testlog119_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog119_1);
      print('********** テスト終了：log119_CEjLog20_01 **********\n\n');
    });

    // ********************************************************
    // テストlog120 : CEjLog21
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log120_CEjLog21_01', () async {
      print('\n********** テスト実行：log120_CEjLog21_01 **********');
      CEjLog21 Testlog120_1 = CEjLog21();
      Testlog120_1.serial_no = 'abc12';
      Testlog120_1.comp_cd = 9913;
      Testlog120_1.stre_cd = 9914;
      Testlog120_1.mac_no = 9915;
      Testlog120_1.print_no = 9916;
      Testlog120_1.seq_no = 9917;
      Testlog120_1.receipt_no = 9918;
      Testlog120_1.end_rec_flg = 9919;
      Testlog120_1.only_ejlog_flg = 9920;
      Testlog120_1.cshr_no = 9921;
      Testlog120_1.chkr_no = 9922;
      Testlog120_1.now_sale_datetime = 'abc23';
      Testlog120_1.sale_date = 'abc24';
      Testlog120_1.ope_mode_flg = 9925;
      Testlog120_1.print_data = 'abc26';
      Testlog120_1.sub_only_ejlog_flg = 9927;
      Testlog120_1.trankey_search = 'abc28';
      Testlog120_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog21> Testlog120_AllRtn = await db.selectAllData(Testlog120_1);
      int count = Testlog120_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog120_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog21 Testlog120_2 = CEjLog21();
      //Keyの値を設定する
      Testlog120_2.serial_no = 'abc12';
      Testlog120_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog21? Testlog120_Rtn = await db.selectDataByPrimaryKey(Testlog120_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog120_Rtn == null) {
        print('\n********** 異常発生：log120_CEjLog21_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog120_Rtn?.serial_no,'abc12');
        expect(Testlog120_Rtn?.comp_cd,9913);
        expect(Testlog120_Rtn?.stre_cd,9914);
        expect(Testlog120_Rtn?.mac_no,9915);
        expect(Testlog120_Rtn?.print_no,9916);
        expect(Testlog120_Rtn?.seq_no,9917);
        expect(Testlog120_Rtn?.receipt_no,9918);
        expect(Testlog120_Rtn?.end_rec_flg,9919);
        expect(Testlog120_Rtn?.only_ejlog_flg,9920);
        expect(Testlog120_Rtn?.cshr_no,9921);
        expect(Testlog120_Rtn?.chkr_no,9922);
        expect(Testlog120_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog120_Rtn?.sale_date,'abc24');
        expect(Testlog120_Rtn?.ope_mode_flg,9925);
        expect(Testlog120_Rtn?.print_data,'abc26');
        expect(Testlog120_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog120_Rtn?.trankey_search,'abc28');
        expect(Testlog120_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog21> Testlog120_AllRtn2 = await db.selectAllData(Testlog120_1);
      int count2 = Testlog120_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog120_1);
      print('********** テスト終了：log120_CEjLog21_01 **********\n\n');
    });

    // ********************************************************
    // テストlog121 : CEjLog22
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log121_CEjLog22_01', () async {
      print('\n********** テスト実行：log121_CEjLog22_01 **********');
      CEjLog22 Testlog121_1 = CEjLog22();
      Testlog121_1.serial_no = 'abc12';
      Testlog121_1.comp_cd = 9913;
      Testlog121_1.stre_cd = 9914;
      Testlog121_1.mac_no = 9915;
      Testlog121_1.print_no = 9916;
      Testlog121_1.seq_no = 9917;
      Testlog121_1.receipt_no = 9918;
      Testlog121_1.end_rec_flg = 9919;
      Testlog121_1.only_ejlog_flg = 9920;
      Testlog121_1.cshr_no = 9921;
      Testlog121_1.chkr_no = 9922;
      Testlog121_1.now_sale_datetime = 'abc23';
      Testlog121_1.sale_date = 'abc24';
      Testlog121_1.ope_mode_flg = 9925;
      Testlog121_1.print_data = 'abc26';
      Testlog121_1.sub_only_ejlog_flg = 9927;
      Testlog121_1.trankey_search = 'abc28';
      Testlog121_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog22> Testlog121_AllRtn = await db.selectAllData(Testlog121_1);
      int count = Testlog121_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog121_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog22 Testlog121_2 = CEjLog22();
      //Keyの値を設定する
      Testlog121_2.serial_no = 'abc12';
      Testlog121_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog22? Testlog121_Rtn = await db.selectDataByPrimaryKey(Testlog121_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog121_Rtn == null) {
        print('\n********** 異常発生：log121_CEjLog22_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog121_Rtn?.serial_no,'abc12');
        expect(Testlog121_Rtn?.comp_cd,9913);
        expect(Testlog121_Rtn?.stre_cd,9914);
        expect(Testlog121_Rtn?.mac_no,9915);
        expect(Testlog121_Rtn?.print_no,9916);
        expect(Testlog121_Rtn?.seq_no,9917);
        expect(Testlog121_Rtn?.receipt_no,9918);
        expect(Testlog121_Rtn?.end_rec_flg,9919);
        expect(Testlog121_Rtn?.only_ejlog_flg,9920);
        expect(Testlog121_Rtn?.cshr_no,9921);
        expect(Testlog121_Rtn?.chkr_no,9922);
        expect(Testlog121_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog121_Rtn?.sale_date,'abc24');
        expect(Testlog121_Rtn?.ope_mode_flg,9925);
        expect(Testlog121_Rtn?.print_data,'abc26');
        expect(Testlog121_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog121_Rtn?.trankey_search,'abc28');
        expect(Testlog121_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog22> Testlog121_AllRtn2 = await db.selectAllData(Testlog121_1);
      int count2 = Testlog121_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog121_1);
      print('********** テスト終了：log121_CEjLog22_01 **********\n\n');
    });

    // ********************************************************
    // テストlog122 : CEjLog23
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log122_CEjLog23_01', () async {
      print('\n********** テスト実行：log122_CEjLog23_01 **********');
      CEjLog23 Testlog122_1 = CEjLog23();
      Testlog122_1.serial_no = 'abc12';
      Testlog122_1.comp_cd = 9913;
      Testlog122_1.stre_cd = 9914;
      Testlog122_1.mac_no = 9915;
      Testlog122_1.print_no = 9916;
      Testlog122_1.seq_no = 9917;
      Testlog122_1.receipt_no = 9918;
      Testlog122_1.end_rec_flg = 9919;
      Testlog122_1.only_ejlog_flg = 9920;
      Testlog122_1.cshr_no = 9921;
      Testlog122_1.chkr_no = 9922;
      Testlog122_1.now_sale_datetime = 'abc23';
      Testlog122_1.sale_date = 'abc24';
      Testlog122_1.ope_mode_flg = 9925;
      Testlog122_1.print_data = 'abc26';
      Testlog122_1.sub_only_ejlog_flg = 9927;
      Testlog122_1.trankey_search = 'abc28';
      Testlog122_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog23> Testlog122_AllRtn = await db.selectAllData(Testlog122_1);
      int count = Testlog122_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog122_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog23 Testlog122_2 = CEjLog23();
      //Keyの値を設定する
      Testlog122_2.serial_no = 'abc12';
      Testlog122_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog23? Testlog122_Rtn = await db.selectDataByPrimaryKey(Testlog122_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog122_Rtn == null) {
        print('\n********** 異常発生：log122_CEjLog23_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog122_Rtn?.serial_no,'abc12');
        expect(Testlog122_Rtn?.comp_cd,9913);
        expect(Testlog122_Rtn?.stre_cd,9914);
        expect(Testlog122_Rtn?.mac_no,9915);
        expect(Testlog122_Rtn?.print_no,9916);
        expect(Testlog122_Rtn?.seq_no,9917);
        expect(Testlog122_Rtn?.receipt_no,9918);
        expect(Testlog122_Rtn?.end_rec_flg,9919);
        expect(Testlog122_Rtn?.only_ejlog_flg,9920);
        expect(Testlog122_Rtn?.cshr_no,9921);
        expect(Testlog122_Rtn?.chkr_no,9922);
        expect(Testlog122_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog122_Rtn?.sale_date,'abc24');
        expect(Testlog122_Rtn?.ope_mode_flg,9925);
        expect(Testlog122_Rtn?.print_data,'abc26');
        expect(Testlog122_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog122_Rtn?.trankey_search,'abc28');
        expect(Testlog122_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog23> Testlog122_AllRtn2 = await db.selectAllData(Testlog122_1);
      int count2 = Testlog122_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog122_1);
      print('********** テスト終了：log122_CEjLog23_01 **********\n\n');
    });

    // ********************************************************
    // テストlog123 : CEjLog24
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log123_CEjLog24_01', () async {
      print('\n********** テスト実行：log123_CEjLog24_01 **********');
      CEjLog24 Testlog123_1 = CEjLog24();
      Testlog123_1.serial_no = 'abc12';
      Testlog123_1.comp_cd = 9913;
      Testlog123_1.stre_cd = 9914;
      Testlog123_1.mac_no = 9915;
      Testlog123_1.print_no = 9916;
      Testlog123_1.seq_no = 9917;
      Testlog123_1.receipt_no = 9918;
      Testlog123_1.end_rec_flg = 9919;
      Testlog123_1.only_ejlog_flg = 9920;
      Testlog123_1.cshr_no = 9921;
      Testlog123_1.chkr_no = 9922;
      Testlog123_1.now_sale_datetime = 'abc23';
      Testlog123_1.sale_date = 'abc24';
      Testlog123_1.ope_mode_flg = 9925;
      Testlog123_1.print_data = 'abc26';
      Testlog123_1.sub_only_ejlog_flg = 9927;
      Testlog123_1.trankey_search = 'abc28';
      Testlog123_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog24> Testlog123_AllRtn = await db.selectAllData(Testlog123_1);
      int count = Testlog123_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog123_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog24 Testlog123_2 = CEjLog24();
      //Keyの値を設定する
      Testlog123_2.serial_no = 'abc12';
      Testlog123_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog24? Testlog123_Rtn = await db.selectDataByPrimaryKey(Testlog123_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog123_Rtn == null) {
        print('\n********** 異常発生：log123_CEjLog24_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog123_Rtn?.serial_no,'abc12');
        expect(Testlog123_Rtn?.comp_cd,9913);
        expect(Testlog123_Rtn?.stre_cd,9914);
        expect(Testlog123_Rtn?.mac_no,9915);
        expect(Testlog123_Rtn?.print_no,9916);
        expect(Testlog123_Rtn?.seq_no,9917);
        expect(Testlog123_Rtn?.receipt_no,9918);
        expect(Testlog123_Rtn?.end_rec_flg,9919);
        expect(Testlog123_Rtn?.only_ejlog_flg,9920);
        expect(Testlog123_Rtn?.cshr_no,9921);
        expect(Testlog123_Rtn?.chkr_no,9922);
        expect(Testlog123_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog123_Rtn?.sale_date,'abc24');
        expect(Testlog123_Rtn?.ope_mode_flg,9925);
        expect(Testlog123_Rtn?.print_data,'abc26');
        expect(Testlog123_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog123_Rtn?.trankey_search,'abc28');
        expect(Testlog123_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog24> Testlog123_AllRtn2 = await db.selectAllData(Testlog123_1);
      int count2 = Testlog123_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog123_1);
      print('********** テスト終了：log123_CEjLog24_01 **********\n\n');
    });

    // ********************************************************
    // テストlog124 : CEjLog25
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log124_CEjLog25_01', () async {
      print('\n********** テスト実行：log124_CEjLog25_01 **********');
      CEjLog25 Testlog124_1 = CEjLog25();
      Testlog124_1.serial_no = 'abc12';
      Testlog124_1.comp_cd = 9913;
      Testlog124_1.stre_cd = 9914;
      Testlog124_1.mac_no = 9915;
      Testlog124_1.print_no = 9916;
      Testlog124_1.seq_no = 9917;
      Testlog124_1.receipt_no = 9918;
      Testlog124_1.end_rec_flg = 9919;
      Testlog124_1.only_ejlog_flg = 9920;
      Testlog124_1.cshr_no = 9921;
      Testlog124_1.chkr_no = 9922;
      Testlog124_1.now_sale_datetime = 'abc23';
      Testlog124_1.sale_date = 'abc24';
      Testlog124_1.ope_mode_flg = 9925;
      Testlog124_1.print_data = 'abc26';
      Testlog124_1.sub_only_ejlog_flg = 9927;
      Testlog124_1.trankey_search = 'abc28';
      Testlog124_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog25> Testlog124_AllRtn = await db.selectAllData(Testlog124_1);
      int count = Testlog124_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog124_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog25 Testlog124_2 = CEjLog25();
      //Keyの値を設定する
      Testlog124_2.serial_no = 'abc12';
      Testlog124_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog25? Testlog124_Rtn = await db.selectDataByPrimaryKey(Testlog124_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog124_Rtn == null) {
        print('\n********** 異常発生：log124_CEjLog25_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog124_Rtn?.serial_no,'abc12');
        expect(Testlog124_Rtn?.comp_cd,9913);
        expect(Testlog124_Rtn?.stre_cd,9914);
        expect(Testlog124_Rtn?.mac_no,9915);
        expect(Testlog124_Rtn?.print_no,9916);
        expect(Testlog124_Rtn?.seq_no,9917);
        expect(Testlog124_Rtn?.receipt_no,9918);
        expect(Testlog124_Rtn?.end_rec_flg,9919);
        expect(Testlog124_Rtn?.only_ejlog_flg,9920);
        expect(Testlog124_Rtn?.cshr_no,9921);
        expect(Testlog124_Rtn?.chkr_no,9922);
        expect(Testlog124_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog124_Rtn?.sale_date,'abc24');
        expect(Testlog124_Rtn?.ope_mode_flg,9925);
        expect(Testlog124_Rtn?.print_data,'abc26');
        expect(Testlog124_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog124_Rtn?.trankey_search,'abc28');
        expect(Testlog124_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog25> Testlog124_AllRtn2 = await db.selectAllData(Testlog124_1);
      int count2 = Testlog124_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog124_1);
      print('********** テスト終了：log124_CEjLog25_01 **********\n\n');
    });

    // ********************************************************
    // テストlog125 : CEjLog26
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log125_CEjLog26_01', () async {
      print('\n********** テスト実行：log125_CEjLog26_01 **********');
      CEjLog26 Testlog125_1 = CEjLog26();
      Testlog125_1.serial_no = 'abc12';
      Testlog125_1.comp_cd = 9913;
      Testlog125_1.stre_cd = 9914;
      Testlog125_1.mac_no = 9915;
      Testlog125_1.print_no = 9916;
      Testlog125_1.seq_no = 9917;
      Testlog125_1.receipt_no = 9918;
      Testlog125_1.end_rec_flg = 9919;
      Testlog125_1.only_ejlog_flg = 9920;
      Testlog125_1.cshr_no = 9921;
      Testlog125_1.chkr_no = 9922;
      Testlog125_1.now_sale_datetime = 'abc23';
      Testlog125_1.sale_date = 'abc24';
      Testlog125_1.ope_mode_flg = 9925;
      Testlog125_1.print_data = 'abc26';
      Testlog125_1.sub_only_ejlog_flg = 9927;
      Testlog125_1.trankey_search = 'abc28';
      Testlog125_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog26> Testlog125_AllRtn = await db.selectAllData(Testlog125_1);
      int count = Testlog125_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog125_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog26 Testlog125_2 = CEjLog26();
      //Keyの値を設定する
      Testlog125_2.serial_no = 'abc12';
      Testlog125_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog26? Testlog125_Rtn = await db.selectDataByPrimaryKey(Testlog125_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog125_Rtn == null) {
        print('\n********** 異常発生：log125_CEjLog26_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog125_Rtn?.serial_no,'abc12');
        expect(Testlog125_Rtn?.comp_cd,9913);
        expect(Testlog125_Rtn?.stre_cd,9914);
        expect(Testlog125_Rtn?.mac_no,9915);
        expect(Testlog125_Rtn?.print_no,9916);
        expect(Testlog125_Rtn?.seq_no,9917);
        expect(Testlog125_Rtn?.receipt_no,9918);
        expect(Testlog125_Rtn?.end_rec_flg,9919);
        expect(Testlog125_Rtn?.only_ejlog_flg,9920);
        expect(Testlog125_Rtn?.cshr_no,9921);
        expect(Testlog125_Rtn?.chkr_no,9922);
        expect(Testlog125_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog125_Rtn?.sale_date,'abc24');
        expect(Testlog125_Rtn?.ope_mode_flg,9925);
        expect(Testlog125_Rtn?.print_data,'abc26');
        expect(Testlog125_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog125_Rtn?.trankey_search,'abc28');
        expect(Testlog125_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog26> Testlog125_AllRtn2 = await db.selectAllData(Testlog125_1);
      int count2 = Testlog125_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog125_1);
      print('********** テスト終了：log125_CEjLog26_01 **********\n\n');
    });

    // ********************************************************
    // テストlog126 : CEjLog27
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log126_CEjLog27_01', () async {
      print('\n********** テスト実行：log126_CEjLog27_01 **********');
      CEjLog27 Testlog126_1 = CEjLog27();
      Testlog126_1.serial_no = 'abc12';
      Testlog126_1.comp_cd = 9913;
      Testlog126_1.stre_cd = 9914;
      Testlog126_1.mac_no = 9915;
      Testlog126_1.print_no = 9916;
      Testlog126_1.seq_no = 9917;
      Testlog126_1.receipt_no = 9918;
      Testlog126_1.end_rec_flg = 9919;
      Testlog126_1.only_ejlog_flg = 9920;
      Testlog126_1.cshr_no = 9921;
      Testlog126_1.chkr_no = 9922;
      Testlog126_1.now_sale_datetime = 'abc23';
      Testlog126_1.sale_date = 'abc24';
      Testlog126_1.ope_mode_flg = 9925;
      Testlog126_1.print_data = 'abc26';
      Testlog126_1.sub_only_ejlog_flg = 9927;
      Testlog126_1.trankey_search = 'abc28';
      Testlog126_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog27> Testlog126_AllRtn = await db.selectAllData(Testlog126_1);
      int count = Testlog126_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog126_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog27 Testlog126_2 = CEjLog27();
      //Keyの値を設定する
      Testlog126_2.serial_no = 'abc12';
      Testlog126_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog27? Testlog126_Rtn = await db.selectDataByPrimaryKey(Testlog126_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog126_Rtn == null) {
        print('\n********** 異常発生：log126_CEjLog27_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog126_Rtn?.serial_no,'abc12');
        expect(Testlog126_Rtn?.comp_cd,9913);
        expect(Testlog126_Rtn?.stre_cd,9914);
        expect(Testlog126_Rtn?.mac_no,9915);
        expect(Testlog126_Rtn?.print_no,9916);
        expect(Testlog126_Rtn?.seq_no,9917);
        expect(Testlog126_Rtn?.receipt_no,9918);
        expect(Testlog126_Rtn?.end_rec_flg,9919);
        expect(Testlog126_Rtn?.only_ejlog_flg,9920);
        expect(Testlog126_Rtn?.cshr_no,9921);
        expect(Testlog126_Rtn?.chkr_no,9922);
        expect(Testlog126_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog126_Rtn?.sale_date,'abc24');
        expect(Testlog126_Rtn?.ope_mode_flg,9925);
        expect(Testlog126_Rtn?.print_data,'abc26');
        expect(Testlog126_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog126_Rtn?.trankey_search,'abc28');
        expect(Testlog126_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog27> Testlog126_AllRtn2 = await db.selectAllData(Testlog126_1);
      int count2 = Testlog126_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog126_1);
      print('********** テスト終了：log126_CEjLog27_01 **********\n\n');
    });

    // ********************************************************
    // テストlog127 : CEjLog28
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log127_CEjLog28_01', () async {
      print('\n********** テスト実行：log127_CEjLog28_01 **********');
      CEjLog28 Testlog127_1 = CEjLog28();
      Testlog127_1.serial_no = 'abc12';
      Testlog127_1.comp_cd = 9913;
      Testlog127_1.stre_cd = 9914;
      Testlog127_1.mac_no = 9915;
      Testlog127_1.print_no = 9916;
      Testlog127_1.seq_no = 9917;
      Testlog127_1.receipt_no = 9918;
      Testlog127_1.end_rec_flg = 9919;
      Testlog127_1.only_ejlog_flg = 9920;
      Testlog127_1.cshr_no = 9921;
      Testlog127_1.chkr_no = 9922;
      Testlog127_1.now_sale_datetime = 'abc23';
      Testlog127_1.sale_date = 'abc24';
      Testlog127_1.ope_mode_flg = 9925;
      Testlog127_1.print_data = 'abc26';
      Testlog127_1.sub_only_ejlog_flg = 9927;
      Testlog127_1.trankey_search = 'abc28';
      Testlog127_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog28> Testlog127_AllRtn = await db.selectAllData(Testlog127_1);
      int count = Testlog127_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog127_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog28 Testlog127_2 = CEjLog28();
      //Keyの値を設定する
      Testlog127_2.serial_no = 'abc12';
      Testlog127_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog28? Testlog127_Rtn = await db.selectDataByPrimaryKey(Testlog127_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog127_Rtn == null) {
        print('\n********** 異常発生：log127_CEjLog28_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog127_Rtn?.serial_no,'abc12');
        expect(Testlog127_Rtn?.comp_cd,9913);
        expect(Testlog127_Rtn?.stre_cd,9914);
        expect(Testlog127_Rtn?.mac_no,9915);
        expect(Testlog127_Rtn?.print_no,9916);
        expect(Testlog127_Rtn?.seq_no,9917);
        expect(Testlog127_Rtn?.receipt_no,9918);
        expect(Testlog127_Rtn?.end_rec_flg,9919);
        expect(Testlog127_Rtn?.only_ejlog_flg,9920);
        expect(Testlog127_Rtn?.cshr_no,9921);
        expect(Testlog127_Rtn?.chkr_no,9922);
        expect(Testlog127_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog127_Rtn?.sale_date,'abc24');
        expect(Testlog127_Rtn?.ope_mode_flg,9925);
        expect(Testlog127_Rtn?.print_data,'abc26');
        expect(Testlog127_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog127_Rtn?.trankey_search,'abc28');
        expect(Testlog127_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog28> Testlog127_AllRtn2 = await db.selectAllData(Testlog127_1);
      int count2 = Testlog127_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog127_1);
      print('********** テスト終了：log127_CEjLog28_01 **********\n\n');
    });

    // ********************************************************
    // テストlog128 : CEjLog29
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log128_CEjLog29_01', () async {
      print('\n********** テスト実行：log128_CEjLog29_01 **********');
      CEjLog29 Testlog128_1 = CEjLog29();
      Testlog128_1.serial_no = 'abc12';
      Testlog128_1.comp_cd = 9913;
      Testlog128_1.stre_cd = 9914;
      Testlog128_1.mac_no = 9915;
      Testlog128_1.print_no = 9916;
      Testlog128_1.seq_no = 9917;
      Testlog128_1.receipt_no = 9918;
      Testlog128_1.end_rec_flg = 9919;
      Testlog128_1.only_ejlog_flg = 9920;
      Testlog128_1.cshr_no = 9921;
      Testlog128_1.chkr_no = 9922;
      Testlog128_1.now_sale_datetime = 'abc23';
      Testlog128_1.sale_date = 'abc24';
      Testlog128_1.ope_mode_flg = 9925;
      Testlog128_1.print_data = 'abc26';
      Testlog128_1.sub_only_ejlog_flg = 9927;
      Testlog128_1.trankey_search = 'abc28';
      Testlog128_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog29> Testlog128_AllRtn = await db.selectAllData(Testlog128_1);
      int count = Testlog128_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog128_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog29 Testlog128_2 = CEjLog29();
      //Keyの値を設定する
      Testlog128_2.serial_no = 'abc12';
      Testlog128_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog29? Testlog128_Rtn = await db.selectDataByPrimaryKey(Testlog128_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog128_Rtn == null) {
        print('\n********** 異常発生：log128_CEjLog29_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog128_Rtn?.serial_no,'abc12');
        expect(Testlog128_Rtn?.comp_cd,9913);
        expect(Testlog128_Rtn?.stre_cd,9914);
        expect(Testlog128_Rtn?.mac_no,9915);
        expect(Testlog128_Rtn?.print_no,9916);
        expect(Testlog128_Rtn?.seq_no,9917);
        expect(Testlog128_Rtn?.receipt_no,9918);
        expect(Testlog128_Rtn?.end_rec_flg,9919);
        expect(Testlog128_Rtn?.only_ejlog_flg,9920);
        expect(Testlog128_Rtn?.cshr_no,9921);
        expect(Testlog128_Rtn?.chkr_no,9922);
        expect(Testlog128_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog128_Rtn?.sale_date,'abc24');
        expect(Testlog128_Rtn?.ope_mode_flg,9925);
        expect(Testlog128_Rtn?.print_data,'abc26');
        expect(Testlog128_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog128_Rtn?.trankey_search,'abc28');
        expect(Testlog128_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog29> Testlog128_AllRtn2 = await db.selectAllData(Testlog128_1);
      int count2 = Testlog128_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog128_1);
      print('********** テスト終了：log128_CEjLog29_01 **********\n\n');
    });

    // ********************************************************
    // テストlog129 : CEjLog30
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log129_CEjLog30_01', () async {
      print('\n********** テスト実行：log129_CEjLog30_01 **********');
      CEjLog30 Testlog129_1 = CEjLog30();
      Testlog129_1.serial_no = 'abc12';
      Testlog129_1.comp_cd = 9913;
      Testlog129_1.stre_cd = 9914;
      Testlog129_1.mac_no = 9915;
      Testlog129_1.print_no = 9916;
      Testlog129_1.seq_no = 9917;
      Testlog129_1.receipt_no = 9918;
      Testlog129_1.end_rec_flg = 9919;
      Testlog129_1.only_ejlog_flg = 9920;
      Testlog129_1.cshr_no = 9921;
      Testlog129_1.chkr_no = 9922;
      Testlog129_1.now_sale_datetime = 'abc23';
      Testlog129_1.sale_date = 'abc24';
      Testlog129_1.ope_mode_flg = 9925;
      Testlog129_1.print_data = 'abc26';
      Testlog129_1.sub_only_ejlog_flg = 9927;
      Testlog129_1.trankey_search = 'abc28';
      Testlog129_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog30> Testlog129_AllRtn = await db.selectAllData(Testlog129_1);
      int count = Testlog129_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog129_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog30 Testlog129_2 = CEjLog30();
      //Keyの値を設定する
      Testlog129_2.serial_no = 'abc12';
      Testlog129_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog30? Testlog129_Rtn = await db.selectDataByPrimaryKey(Testlog129_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog129_Rtn == null) {
        print('\n********** 異常発生：log129_CEjLog30_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog129_Rtn?.serial_no,'abc12');
        expect(Testlog129_Rtn?.comp_cd,9913);
        expect(Testlog129_Rtn?.stre_cd,9914);
        expect(Testlog129_Rtn?.mac_no,9915);
        expect(Testlog129_Rtn?.print_no,9916);
        expect(Testlog129_Rtn?.seq_no,9917);
        expect(Testlog129_Rtn?.receipt_no,9918);
        expect(Testlog129_Rtn?.end_rec_flg,9919);
        expect(Testlog129_Rtn?.only_ejlog_flg,9920);
        expect(Testlog129_Rtn?.cshr_no,9921);
        expect(Testlog129_Rtn?.chkr_no,9922);
        expect(Testlog129_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog129_Rtn?.sale_date,'abc24');
        expect(Testlog129_Rtn?.ope_mode_flg,9925);
        expect(Testlog129_Rtn?.print_data,'abc26');
        expect(Testlog129_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog129_Rtn?.trankey_search,'abc28');
        expect(Testlog129_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog30> Testlog129_AllRtn2 = await db.selectAllData(Testlog129_1);
      int count2 = Testlog129_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog129_1);
      print('********** テスト終了：log129_CEjLog30_01 **********\n\n');
    });

    // ********************************************************
    // テストlog130 : CEjLog31
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('log130_CEjLog31_01', () async {
      print('\n********** テスト実行：log130_CEjLog31_01 **********');
      CEjLog31 Testlog130_1 = CEjLog31();
      Testlog130_1.serial_no = 'abc12';
      Testlog130_1.comp_cd = 9913;
      Testlog130_1.stre_cd = 9914;
      Testlog130_1.mac_no = 9915;
      Testlog130_1.print_no = 9916;
      Testlog130_1.seq_no = 9917;
      Testlog130_1.receipt_no = 9918;
      Testlog130_1.end_rec_flg = 9919;
      Testlog130_1.only_ejlog_flg = 9920;
      Testlog130_1.cshr_no = 9921;
      Testlog130_1.chkr_no = 9922;
      Testlog130_1.now_sale_datetime = 'abc23';
      Testlog130_1.sale_date = 'abc24';
      Testlog130_1.ope_mode_flg = 9925;
      Testlog130_1.print_data = 'abc26';
      Testlog130_1.sub_only_ejlog_flg = 9927;
      Testlog130_1.trankey_search = 'abc28';
      Testlog130_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog31> Testlog130_AllRtn = await db.selectAllData(Testlog130_1);
      int count = Testlog130_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Testlog130_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog31 Testlog130_2 = CEjLog31();
      //Keyの値を設定する
      Testlog130_2.serial_no = 'abc12';
      Testlog130_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog31? Testlog130_Rtn = await db.selectDataByPrimaryKey(Testlog130_2);
      //取得行がない場合、nullが返ってきます
      if (Testlog130_Rtn == null) {
        print('\n********** 異常発生：log130_CEjLog31_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Testlog130_Rtn?.serial_no,'abc12');
        expect(Testlog130_Rtn?.comp_cd,9913);
        expect(Testlog130_Rtn?.stre_cd,9914);
        expect(Testlog130_Rtn?.mac_no,9915);
        expect(Testlog130_Rtn?.print_no,9916);
        expect(Testlog130_Rtn?.seq_no,9917);
        expect(Testlog130_Rtn?.receipt_no,9918);
        expect(Testlog130_Rtn?.end_rec_flg,9919);
        expect(Testlog130_Rtn?.only_ejlog_flg,9920);
        expect(Testlog130_Rtn?.cshr_no,9921);
        expect(Testlog130_Rtn?.chkr_no,9922);
        expect(Testlog130_Rtn?.now_sale_datetime,'abc23');
        expect(Testlog130_Rtn?.sale_date,'abc24');
        expect(Testlog130_Rtn?.ope_mode_flg,9925);
        expect(Testlog130_Rtn?.print_data,'abc26');
        expect(Testlog130_Rtn?.sub_only_ejlog_flg,9927);
        expect(Testlog130_Rtn?.trankey_search,'abc28');
        expect(Testlog130_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog31> Testlog130_AllRtn2 = await db.selectAllData(Testlog130_1);
      int count2 = Testlog130_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Testlog130_1);
      print('********** テスト終了：log130_CEjLog31_01 **********\n\n');
    });
  });
}