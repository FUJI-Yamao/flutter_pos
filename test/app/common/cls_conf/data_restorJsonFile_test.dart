﻿/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'unitTestParts.dart';

import '../../../../lib/app/common/cls_conf/configJsonFile.dart';
import '../../../../lib/app/common/cls_conf/data_restorJsonFile.dart';

late Data_restorJsonFile data_restor;

void main(){
  data_restorJsonFile_test();
}

void data_restorJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "data_restor.json";
  const String section = "file01";
  const String key = "typ";
  const defaultData = 40;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Data_restorJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Data_restorJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Data_restorJsonFile().setDefault();
    });

    // ********************************************************
    // テスト00001 : load
    // 前提：アプリ用フォルダに対象JSONファイルが存在しないこと。
    // 試験手順：loadを実行する。
    // 期待結果：①assets/confにある対象JSONファイルがアプリ用フォルダに作成されること。
    // 　　　　　②対象JSONファイルの各プロパティ値を読み込んでいること。
    // ********************************************************
    test('00001_load_01', () async {
      print("\n********** テスト実行：00001_load_01 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await data_restor.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(data_restor,true);

      print("********** テスト終了：00001_load_01 **********\n\n");
    });

    // ********************************************************
    // テスト00002 : load
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：loadを実行する。
    // 期待結果：アプリ用フォルダの対象JSONファイルの各プロパティ値を読み込んでいること。
    // ********************************************************
    test("00002_load_02", () async {
      print("\n********** テスト実行：00002_load_02 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        data_restor.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await data_restor.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(data_restor,true);

      print("********** テスト終了：00002_load_02 **********\n\n");
    });

    // ********************************************************
    // テスト00003 : load
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    // 　　　　　②任意のプロパティの値を変更する。
    // 　　　　　③loadを実行する。
    // 期待結果：当該プロパティ値の変更が取り消されること。
    // ********************************************************
    test('00003_load_03', () async {
      print("\n********** テスト実行：00003_load_03 **********");
      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①：loadを実行する。
      await data_restor.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = data_restor.file01.typ;
      data_restor.file01.typ = testData1;
      expect(data_restor.file01.typ == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await data_restor.load();
      expect(data_restor.file01.typ != testData1, true);
      expect(data_restor.file01.typ == prefixData, true);

      print("********** テスト終了：00003_load_03 **********\n\n");
    });

    // ********************************************************
    // テスト00004 : load
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    // 　　　　　②任意のプロパティの値を変更する。
    // 　　　　　③loadを実行する。
    // 期待結果：当該プロパティ値の変更が取り消されること。
    // ********************************************************
    test('00004_load_04', () async {
      print("\n********** テスト実行：00004_load_04 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = data_restor.file01.typ;
      data_restor.file01.typ = testData1;
      expect(data_restor.file01.typ, testData1);

      // ③saveを実行する。
      await data_restor.save();

      // ④loadを実行する。
      await data_restor.load();

      expect(data_restor.file01.typ != prefixData, true);
      expect(data_restor.file01.typ == testData1, true);
      allPropatyCheck(data_restor,false);

      print("********** テスト終了：00004_load_04 **********\n\n");
    });

    // ********************************************************
    // テスト00005 : save
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    // 　　　　　②saveを実行する。
    // 期待結果：アプリ用フォルダにある対象JSONファイルの内容に変化がないこと。
    // ********************************************************
    test('00005_save_01', () async {
      print("\n********** テスト実行：00005_save_01 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await data_restor.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await data_restor.save();

      final File fileAfter = File(jsonPath);
      expect(fileAfter.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化がないこと。
      final String jsonAfter = await fileAfter.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") == jsonAfter.replaceAll("\r\n", "\n"), true);

      print("********** テスト終了：00201_save_01 **********\n\n");
    });

    // ********************************************************
    // テスト00006 : save
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    //         ②任意のプロパティの値を変更する。
    //         ③saveを実行する。
    // 期待結果：アプリ用フォルダにある対象JSONファイルの当該プロパティの値が
    //         変更した値に変更されていること。
    // ********************************************************
    test('00006_save_02', () async {
      print("\n********** テスト実行：00006_save_02 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await data_restor.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(data_restor.file01.typ, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = data_restor.file01.typ;
      data_restor.file01.typ = testData1;

      // ③ saveを実行する。
      await data_restor.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(data_restor.file01.typ, testData1);

      // ④ loadを実行する。
      await data_restor.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(data_restor.file01.typ == testData1, true);
      allPropatyCheck(data_restor,false);

      print("********** テスト終了：00006_save_02 **********\n\n");
    });

    // ********************************************************
    // テスト00007 : setDefault
    // 事前条件：assets/confに対象JSONファイルが存在すること。
    //         アプリ用フォルダに対象JSONファイルが存在し、任意の編集を施すこと。
    // 試験手順：①アプリ用フォルダにある対象JSONファイルを削除する。
    //         ②setDefaultを実行する。
    // 期待結果：手順②実行後、assets/confにある対象JSONファイルが
    //         アプリ用フォルダに作成されること。
    // ********************************************************
    test('00007_setDefault_01', () async {
      print("\n********** テスト実行：00007_setDefault_01 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await data_restor.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(data_restor,true);

      print("********** テスト終了：00007_setDefault_01 **********\n\n");
    });

    // ********************************************************
    // テスト00008 : setDefault
    // 事前条件：assets/confに対象JSONファイルが存在すること。
    //         アプリ用フォルダに対象JSONファイルが存在し、任意の編集を施すこと。
    // 試験手順：①任意のプロパティの値を変更し、saveを実行する。
    //         ②setDefaultを実行する。
    // 期待結果：手順②実行後、assets/confにある対象JSONファイルの内容で上書きされること。
    //         （変更が取り消されていること）
    // ********************************************************
    test('00008_setDefault_02', () async {
      print("\n********** テスト実行：00008_setDefault_02 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②任意のプロパティの値を変更する。
      data_restor.file01.typ = testData1;
      expect(data_restor.file01.typ, testData1);

      // ③saveを実行する。
      await data_restor.save();
      expect(data_restor.file01.typ, testData1);

      // ④loadを実行する。
      await data_restor.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(data_restor,true);

      print("********** テスト終了：00008_setDefault_02 **********\n\n");
    });

    // ********************************************************
    // テスト00009 : セクション/キー名称による設定（setValueWithName）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
    //         ②loadを実行する。
    // 期待結果：手順②実行後、手順①で設定したプロパティ変更後の内容で
    //         プロパティ値が設定されていること。
    // ********************************************************
    test('00009_setValueWithName_01', () async {
      print("\n********** テスト実行：00009_setValueWithName_01 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await data_restor.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await data_restor.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(data_restor.file01.typ == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await data_restor.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await data_restor.setValueWithName(section, "test_key", testData1);

      // 手順①実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00011_setValueWithName_03 **********\n\n");
    });

    // ********************************************************
    // テスト00010 : セクション/キー名称による取得（getValueWithName）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    //         ②任意のプロパティを変更する。
    //         ③saveを実行する。
    //         ④①で指定したプロパティに相当するセクション名、キー名にて
    //           getValueWithNameを実行する。
    // 期待結果：手順④で設定した値が手順②で設定した値と一致すること。
    // ********************************************************
    test('00012_getValueWithName_01', () async {
      print("\n********** テスト実行：00012_getValueWithName_01********** ");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②任意のプロパティを変更する。
      data_restor.file01.typ = testData1;

      // ③saveを実行する。
      await data_restor.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await data_restor.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②任意のプロパティを変更する。
      data_restor.file01.typ = testData1;

      // ③saveを実行する。
      await data_restor.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await data_restor.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②任意のプロパティを変更する。
      data_restor.file01.typ = testData1;

      // ③saveを実行する。
      await data_restor.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await data_restor.getValueWithName(section, "test_key");
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00014_getValueWithName_03**********\n\n");
    });

    // ********************************************************
    // テスト00015 : 任意フォルダ設定（_setAbsolutePath）
    // 事前条件：assets/confに対象JSONファイルが存在すること。
    // 試験手順：①任意のプロパティ値を変更し、テスト用フォルダにJSONのコピーを作成する。
    //         ②setDefaultを実行する。
    //         ③テスト用フォルダのパスを引数としてsetAbsolutePathを実行する。
    //         ④loadを実行する。
    // 期待結果：手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00015:_setAbsolutePath_01', () async {
      print("\n********** テスト実行：00015_setAbsolutePath_01 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await data_restor.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      data_restor.file01.typ = testData1;
      expect(data_restor.file01.typ, testData1);

      // ④saveを実行する。
      await data_restor.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(data_restor.file01.typ, testData1);
      
      // アプリフォルダのパスを元に戻しておく（このテストだけの後処理）。
      JsonPath().absolutePath = join(appDir.path);

      print("********** テスト終了：00015_setAbsolutePath_01 **********\n\n");
    });

    // ********************************************************
    // テスト00016 : ファイル復元（_restoreJson：バックアップ作成中に電断）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    //         ②任意のプロパティの値を変更する。
    //         ③saveを実行する。
    //         ④バックアップファイルを作成し、破損状態とする。
    //         ⑤loadを実行する。
    // 期待結果：手順③実行後、プロパティ変更前の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00016_restoreJson_01', () async {
      print("\n********** テスト実行：00016_restoreJson_01 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await data_restor.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      expect(data_restor.file01.typ == testData1, true);

      print("********** テスト終了：00016_restoreJson_01 **********\n\n");
    });

    // ********************************************************
    // テスト00017 : ファイル復元（_restoreJson：バックアップ作成直後に電断）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①loadを実行する。
    //         ②任意のプロパティの値を変更する。
    //         ③saveを実行する。
    //         ④バックアップファイルを作成する。
    //         ⑤loadを実行する。
    // 期待結果：手順③実行後、プロパティ変更前の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('0017_restoreJson_02', () async {
      print("\n********** テスト実行：00017_restoreJson_02 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await data_restor.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      expect(data_restor.file01.typ == testData2, true);

      print("********** テスト終了：00017_restoreJson_02 **********\n\n");
    });

    // ********************************************************
    // テスト00018 : ファイル復元（_restoreJson：JSON更新中に電断）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①バックアップファイルを作成する。
    //         ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
    //         ③loadを実行する。
    // 期待結果：手順③実行後、①の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00018_restoreJson_03', () async {
      print("\n********** テスト実行：00018_restoreJson_03 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await data_restor.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      expect(data_restor.file01.typ == testData1, true);

      print("********** テスト終了：00018_restoreJson_03 **********\n\n");
    });

    // ********************************************************
    // テスト00019 : ファイル復元（_restoreJson：JSON作成直後に電断）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①バックアップファイルを作成する。
    //         ②任意のプロパティの値を変更した内容でJSONファイルを更新する。
    //         ③loadを実行する。
    // 期待結果：手順③実行後、②の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00019_restoreJson_04', () async {
      print("\n********** テスト実行：00019_restoreJson_04 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await data_restor.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      expect(data_restor.file01.typ == testData2, true);

      print("********** テスト終了：00019_restoreJson_04 **********\n\n");
    });

    // ********************************************************
    // テスト00020 : ファイル復元（_restoreJson：バックアップ削除中に電断）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①任意のプロパティの値を変更した内容でJSONファイルを更新する。
    //         ②バックアップファイルを作成し、破損状態とする。
    //         ③loadを実行する。
    // 期待結果：手順③実行後、①の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00020_restoreJson_05', () async {
      print("\n********** テスト実行：00020_restoreJson_05 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await data_restor.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      expect(data_restor.file01.typ == testData1, true);

      print("********** テスト終了：00020_restoreJson_05 **********\n\n");
    });

    // ********************************************************
    // テスト00021 : ファイル復元（_restoreJson：バックアップ削除直後に電断）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①任意のプロパティの値を変更する。
    //         ②①の内容でJSONファイルを更新する。
    //         ③loadを実行する。
    // 期待結果：手順③実行後、①の内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00021_restoreJson_06', () async {
      print("\n********** テスト実行：00021_restoreJson_06 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await data_restor.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      expect(data_restor.file01.typ == testData1, true);

      print("********** テスト終了：00021_restoreJson_06 **********\n\n");
    });

    // ********************************************************
    // テスト00022 : ファイル復元（_restoreJson：バックアップとJSON共に破損：バックアップが新しい日付）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
    //         ②バックアップファイルを作成し、破損状態とする。
    //         ③loadを実行する。
    // 期待結果：デフォルトの内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00022_restoreJson_07', () async {
      print("\n********** テスト実行：00022_restoreJson_07 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await data_restor.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      allPropatyCheck(data_restor,true);

      print("********** テスト終了：00022_restoreJson_07 **********\n\n");
    });

    // ********************************************************
    // テスト00023 : ファイル復元（_restoreJson：バックアップとJSON共に破損：JSONが新しい日付）
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    // 試験手順：①バックアップファイルを作成し、破損状態とする。
    //         ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
    //         ③loadを実行する。
    // 期待結果：デフォルトの内容でプロパティ値が設定されていること。
    // ********************************************************
    test('00023_restoreJson_08', () async {
      print("\n********** テスト実行：00023_restoreJson_08 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await data_restor.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + data_restor.file01.typ.toString());
      allPropatyCheck(data_restor,true);

      print("********** テスト終了：00023_restoreJson_08 **********\n\n");
    });

    // ********************************************************
    // テスト00024 ～ : 要素取得・設定
    // 事前条件：アプリ用フォルダに対象JSONファイルが存在すること。
    //         実行前にsetConfigを実行すること。
    // 試験手順：①loadを実行する。
    //         ②指定したプロパティの初期値を取得する。
    //         ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
    //         ④saveを実行後、loadを実行する。
    //         ⑤同じプロパティを読み込み、データに変化がないことを確認する。
    //         ⑥③～⑤を異なるテストデータで実施する。
    //         ⑦③～⑤を手順①で取得した初期値で実施する。
    //         ⑧全てのプロパティが初期値になっていることを確認する。
    // 期待結果：全プロパティ値を取得、設定できること。（１要素、1テストで実施する）
    // ********************************************************
     test('00024_element_check_00001', () async {
      print("\n********** テスト実行：00024_element_check_00001 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file01.typ;
      print(data_restor.file01.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file01.typ = testData1;
      print(data_restor.file01.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file01.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file01.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file01.typ = testData2;
      print(data_restor.file01.typ);
      expect(data_restor.file01.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file01.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file01.typ = defalut;
      print(data_restor.file01.typ);
      expect(data_restor.file01.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file01.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file01.name;
      print(data_restor.file01.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file01.name = testData1s;
      print(data_restor.file01.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file01.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file01.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file01.name = testData2s;
      print(data_restor.file01.name);
      expect(data_restor.file01.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file01.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file01.name = defalut;
      print(data_restor.file01.name);
      expect(data_restor.file01.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file01.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file01.src;
      print(data_restor.file01.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file01.src = testData1s;
      print(data_restor.file01.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file01.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file01.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file01.src = testData2s;
      print(data_restor.file01.src);
      expect(data_restor.file01.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file01.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file01.src = defalut;
      print(data_restor.file01.src);
      expect(data_restor.file01.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file01.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file02.typ;
      print(data_restor.file02.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file02.typ = testData1;
      print(data_restor.file02.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file02.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file02.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file02.typ = testData2;
      print(data_restor.file02.typ);
      expect(data_restor.file02.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file02.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file02.typ = defalut;
      print(data_restor.file02.typ);
      expect(data_restor.file02.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file02.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file02.name;
      print(data_restor.file02.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file02.name = testData1s;
      print(data_restor.file02.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file02.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file02.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file02.name = testData2s;
      print(data_restor.file02.name);
      expect(data_restor.file02.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file02.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file02.name = defalut;
      print(data_restor.file02.name);
      expect(data_restor.file02.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file02.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file02.src;
      print(data_restor.file02.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file02.src = testData1s;
      print(data_restor.file02.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file02.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file02.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file02.src = testData2s;
      print(data_restor.file02.src);
      expect(data_restor.file02.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file02.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file02.src = defalut;
      print(data_restor.file02.src);
      expect(data_restor.file02.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file02.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file03.typ;
      print(data_restor.file03.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file03.typ = testData1;
      print(data_restor.file03.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file03.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file03.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file03.typ = testData2;
      print(data_restor.file03.typ);
      expect(data_restor.file03.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file03.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file03.typ = defalut;
      print(data_restor.file03.typ);
      expect(data_restor.file03.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file03.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file03.name;
      print(data_restor.file03.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file03.name = testData1s;
      print(data_restor.file03.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file03.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file03.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file03.name = testData2s;
      print(data_restor.file03.name);
      expect(data_restor.file03.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file03.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file03.name = defalut;
      print(data_restor.file03.name);
      expect(data_restor.file03.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file03.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file03.src;
      print(data_restor.file03.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file03.src = testData1s;
      print(data_restor.file03.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file03.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file03.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file03.src = testData2s;
      print(data_restor.file03.src);
      expect(data_restor.file03.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file03.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file03.src = defalut;
      print(data_restor.file03.src);
      expect(data_restor.file03.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file03.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file04.typ;
      print(data_restor.file04.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file04.typ = testData1;
      print(data_restor.file04.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file04.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file04.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file04.typ = testData2;
      print(data_restor.file04.typ);
      expect(data_restor.file04.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file04.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file04.typ = defalut;
      print(data_restor.file04.typ);
      expect(data_restor.file04.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file04.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file04.name;
      print(data_restor.file04.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file04.name = testData1s;
      print(data_restor.file04.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file04.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file04.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file04.name = testData2s;
      print(data_restor.file04.name);
      expect(data_restor.file04.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file04.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file04.name = defalut;
      print(data_restor.file04.name);
      expect(data_restor.file04.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file04.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file04.src;
      print(data_restor.file04.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file04.src = testData1s;
      print(data_restor.file04.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file04.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file04.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file04.src = testData2s;
      print(data_restor.file04.src);
      expect(data_restor.file04.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file04.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file04.src = defalut;
      print(data_restor.file04.src);
      expect(data_restor.file04.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file04.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file05.typ;
      print(data_restor.file05.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file05.typ = testData1;
      print(data_restor.file05.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file05.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file05.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file05.typ = testData2;
      print(data_restor.file05.typ);
      expect(data_restor.file05.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file05.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file05.typ = defalut;
      print(data_restor.file05.typ);
      expect(data_restor.file05.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file05.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file05.name;
      print(data_restor.file05.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file05.name = testData1s;
      print(data_restor.file05.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file05.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file05.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file05.name = testData2s;
      print(data_restor.file05.name);
      expect(data_restor.file05.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file05.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file05.name = defalut;
      print(data_restor.file05.name);
      expect(data_restor.file05.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file05.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file05.src;
      print(data_restor.file05.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file05.src = testData1s;
      print(data_restor.file05.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file05.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file05.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file05.src = testData2s;
      print(data_restor.file05.src);
      expect(data_restor.file05.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file05.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file05.src = defalut;
      print(data_restor.file05.src);
      expect(data_restor.file05.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file05.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file06.typ;
      print(data_restor.file06.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file06.typ = testData1;
      print(data_restor.file06.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file06.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file06.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file06.typ = testData2;
      print(data_restor.file06.typ);
      expect(data_restor.file06.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file06.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file06.typ = defalut;
      print(data_restor.file06.typ);
      expect(data_restor.file06.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file06.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file06.name;
      print(data_restor.file06.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file06.name = testData1s;
      print(data_restor.file06.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file06.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file06.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file06.name = testData2s;
      print(data_restor.file06.name);
      expect(data_restor.file06.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file06.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file06.name = defalut;
      print(data_restor.file06.name);
      expect(data_restor.file06.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file06.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file06.src;
      print(data_restor.file06.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file06.src = testData1s;
      print(data_restor.file06.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file06.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file06.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file06.src = testData2s;
      print(data_restor.file06.src);
      expect(data_restor.file06.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file06.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file06.src = defalut;
      print(data_restor.file06.src);
      expect(data_restor.file06.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file06.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file07.typ;
      print(data_restor.file07.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file07.typ = testData1;
      print(data_restor.file07.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file07.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file07.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file07.typ = testData2;
      print(data_restor.file07.typ);
      expect(data_restor.file07.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file07.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file07.typ = defalut;
      print(data_restor.file07.typ);
      expect(data_restor.file07.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file07.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file07.name;
      print(data_restor.file07.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file07.name = testData1s;
      print(data_restor.file07.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file07.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file07.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file07.name = testData2s;
      print(data_restor.file07.name);
      expect(data_restor.file07.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file07.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file07.name = defalut;
      print(data_restor.file07.name);
      expect(data_restor.file07.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file07.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file07.src;
      print(data_restor.file07.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file07.src = testData1s;
      print(data_restor.file07.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file07.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file07.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file07.src = testData2s;
      print(data_restor.file07.src);
      expect(data_restor.file07.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file07.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file07.src = defalut;
      print(data_restor.file07.src);
      expect(data_restor.file07.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file07.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file08.typ;
      print(data_restor.file08.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file08.typ = testData1;
      print(data_restor.file08.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file08.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file08.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file08.typ = testData2;
      print(data_restor.file08.typ);
      expect(data_restor.file08.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file08.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file08.typ = defalut;
      print(data_restor.file08.typ);
      expect(data_restor.file08.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file08.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file08.name;
      print(data_restor.file08.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file08.name = testData1s;
      print(data_restor.file08.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file08.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file08.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file08.name = testData2s;
      print(data_restor.file08.name);
      expect(data_restor.file08.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file08.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file08.name = defalut;
      print(data_restor.file08.name);
      expect(data_restor.file08.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file08.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file08.src;
      print(data_restor.file08.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file08.src = testData1s;
      print(data_restor.file08.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file08.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file08.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file08.src = testData2s;
      print(data_restor.file08.src);
      expect(data_restor.file08.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file08.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file08.src = defalut;
      print(data_restor.file08.src);
      expect(data_restor.file08.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file08.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file09.typ;
      print(data_restor.file09.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file09.typ = testData1;
      print(data_restor.file09.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file09.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file09.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file09.typ = testData2;
      print(data_restor.file09.typ);
      expect(data_restor.file09.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file09.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file09.typ = defalut;
      print(data_restor.file09.typ);
      expect(data_restor.file09.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file09.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file09.name;
      print(data_restor.file09.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file09.name = testData1s;
      print(data_restor.file09.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file09.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file09.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file09.name = testData2s;
      print(data_restor.file09.name);
      expect(data_restor.file09.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file09.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file09.name = defalut;
      print(data_restor.file09.name);
      expect(data_restor.file09.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file09.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file09.src;
      print(data_restor.file09.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file09.src = testData1s;
      print(data_restor.file09.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file09.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file09.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file09.src = testData2s;
      print(data_restor.file09.src);
      expect(data_restor.file09.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file09.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file09.src = defalut;
      print(data_restor.file09.src);
      expect(data_restor.file09.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file09.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file10.typ;
      print(data_restor.file10.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file10.typ = testData1;
      print(data_restor.file10.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file10.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file10.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file10.typ = testData2;
      print(data_restor.file10.typ);
      expect(data_restor.file10.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file10.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file10.typ = defalut;
      print(data_restor.file10.typ);
      expect(data_restor.file10.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file10.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file10.name;
      print(data_restor.file10.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file10.name = testData1s;
      print(data_restor.file10.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file10.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file10.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file10.name = testData2s;
      print(data_restor.file10.name);
      expect(data_restor.file10.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file10.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file10.name = defalut;
      print(data_restor.file10.name);
      expect(data_restor.file10.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file10.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file10.src;
      print(data_restor.file10.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file10.src = testData1s;
      print(data_restor.file10.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file10.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file10.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file10.src = testData2s;
      print(data_restor.file10.src);
      expect(data_restor.file10.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file10.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file10.src = defalut;
      print(data_restor.file10.src);
      expect(data_restor.file10.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file10.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file11.typ;
      print(data_restor.file11.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file11.typ = testData1;
      print(data_restor.file11.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file11.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file11.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file11.typ = testData2;
      print(data_restor.file11.typ);
      expect(data_restor.file11.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file11.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file11.typ = defalut;
      print(data_restor.file11.typ);
      expect(data_restor.file11.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file11.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file11.name;
      print(data_restor.file11.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file11.name = testData1s;
      print(data_restor.file11.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file11.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file11.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file11.name = testData2s;
      print(data_restor.file11.name);
      expect(data_restor.file11.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file11.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file11.name = defalut;
      print(data_restor.file11.name);
      expect(data_restor.file11.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file11.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file11.src;
      print(data_restor.file11.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file11.src = testData1s;
      print(data_restor.file11.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file11.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file11.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file11.src = testData2s;
      print(data_restor.file11.src);
      expect(data_restor.file11.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file11.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file11.src = defalut;
      print(data_restor.file11.src);
      expect(data_restor.file11.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file11.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file12.typ;
      print(data_restor.file12.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file12.typ = testData1;
      print(data_restor.file12.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file12.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file12.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file12.typ = testData2;
      print(data_restor.file12.typ);
      expect(data_restor.file12.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file12.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file12.typ = defalut;
      print(data_restor.file12.typ);
      expect(data_restor.file12.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file12.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file12.name;
      print(data_restor.file12.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file12.name = testData1s;
      print(data_restor.file12.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file12.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file12.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file12.name = testData2s;
      print(data_restor.file12.name);
      expect(data_restor.file12.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file12.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file12.name = defalut;
      print(data_restor.file12.name);
      expect(data_restor.file12.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file12.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file12.src;
      print(data_restor.file12.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file12.src = testData1s;
      print(data_restor.file12.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file12.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file12.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file12.src = testData2s;
      print(data_restor.file12.src);
      expect(data_restor.file12.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file12.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file12.src = defalut;
      print(data_restor.file12.src);
      expect(data_restor.file12.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file12.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file13.typ;
      print(data_restor.file13.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file13.typ = testData1;
      print(data_restor.file13.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file13.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file13.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file13.typ = testData2;
      print(data_restor.file13.typ);
      expect(data_restor.file13.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file13.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file13.typ = defalut;
      print(data_restor.file13.typ);
      expect(data_restor.file13.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file13.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file13.name;
      print(data_restor.file13.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file13.name = testData1s;
      print(data_restor.file13.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file13.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file13.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file13.name = testData2s;
      print(data_restor.file13.name);
      expect(data_restor.file13.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file13.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file13.name = defalut;
      print(data_restor.file13.name);
      expect(data_restor.file13.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file13.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file13.src;
      print(data_restor.file13.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file13.src = testData1s;
      print(data_restor.file13.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file13.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file13.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file13.src = testData2s;
      print(data_restor.file13.src);
      expect(data_restor.file13.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file13.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file13.src = defalut;
      print(data_restor.file13.src);
      expect(data_restor.file13.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file13.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file14.typ;
      print(data_restor.file14.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file14.typ = testData1;
      print(data_restor.file14.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file14.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file14.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file14.typ = testData2;
      print(data_restor.file14.typ);
      expect(data_restor.file14.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file14.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file14.typ = defalut;
      print(data_restor.file14.typ);
      expect(data_restor.file14.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file14.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file14.name;
      print(data_restor.file14.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file14.name = testData1s;
      print(data_restor.file14.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file14.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file14.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file14.name = testData2s;
      print(data_restor.file14.name);
      expect(data_restor.file14.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file14.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file14.name = defalut;
      print(data_restor.file14.name);
      expect(data_restor.file14.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file14.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file14.src;
      print(data_restor.file14.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file14.src = testData1s;
      print(data_restor.file14.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file14.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file14.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file14.src = testData2s;
      print(data_restor.file14.src);
      expect(data_restor.file14.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file14.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file14.src = defalut;
      print(data_restor.file14.src);
      expect(data_restor.file14.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file14.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file15.typ;
      print(data_restor.file15.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file15.typ = testData1;
      print(data_restor.file15.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file15.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file15.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file15.typ = testData2;
      print(data_restor.file15.typ);
      expect(data_restor.file15.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file15.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file15.typ = defalut;
      print(data_restor.file15.typ);
      expect(data_restor.file15.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file15.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file15.name;
      print(data_restor.file15.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file15.name = testData1s;
      print(data_restor.file15.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file15.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file15.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file15.name = testData2s;
      print(data_restor.file15.name);
      expect(data_restor.file15.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file15.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file15.name = defalut;
      print(data_restor.file15.name);
      expect(data_restor.file15.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file15.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file15.src;
      print(data_restor.file15.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file15.src = testData1s;
      print(data_restor.file15.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file15.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file15.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file15.src = testData2s;
      print(data_restor.file15.src);
      expect(data_restor.file15.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file15.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file15.src = defalut;
      print(data_restor.file15.src);
      expect(data_restor.file15.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file15.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file16.typ;
      print(data_restor.file16.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file16.typ = testData1;
      print(data_restor.file16.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file16.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file16.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file16.typ = testData2;
      print(data_restor.file16.typ);
      expect(data_restor.file16.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file16.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file16.typ = defalut;
      print(data_restor.file16.typ);
      expect(data_restor.file16.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file16.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file16.name;
      print(data_restor.file16.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file16.name = testData1s;
      print(data_restor.file16.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file16.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file16.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file16.name = testData2s;
      print(data_restor.file16.name);
      expect(data_restor.file16.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file16.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file16.name = defalut;
      print(data_restor.file16.name);
      expect(data_restor.file16.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file16.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file16.src;
      print(data_restor.file16.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file16.src = testData1s;
      print(data_restor.file16.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file16.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file16.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file16.src = testData2s;
      print(data_restor.file16.src);
      expect(data_restor.file16.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file16.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file16.src = defalut;
      print(data_restor.file16.src);
      expect(data_restor.file16.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file16.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file17.typ;
      print(data_restor.file17.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file17.typ = testData1;
      print(data_restor.file17.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file17.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file17.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file17.typ = testData2;
      print(data_restor.file17.typ);
      expect(data_restor.file17.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file17.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file17.typ = defalut;
      print(data_restor.file17.typ);
      expect(data_restor.file17.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file17.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file17.name;
      print(data_restor.file17.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file17.name = testData1s;
      print(data_restor.file17.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file17.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file17.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file17.name = testData2s;
      print(data_restor.file17.name);
      expect(data_restor.file17.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file17.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file17.name = defalut;
      print(data_restor.file17.name);
      expect(data_restor.file17.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file17.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file17.src;
      print(data_restor.file17.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file17.src = testData1s;
      print(data_restor.file17.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file17.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file17.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file17.src = testData2s;
      print(data_restor.file17.src);
      expect(data_restor.file17.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file17.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file17.src = defalut;
      print(data_restor.file17.src);
      expect(data_restor.file17.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file17.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file18.typ;
      print(data_restor.file18.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file18.typ = testData1;
      print(data_restor.file18.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file18.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file18.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file18.typ = testData2;
      print(data_restor.file18.typ);
      expect(data_restor.file18.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file18.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file18.typ = defalut;
      print(data_restor.file18.typ);
      expect(data_restor.file18.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file18.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file18.name;
      print(data_restor.file18.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file18.name = testData1s;
      print(data_restor.file18.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file18.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file18.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file18.name = testData2s;
      print(data_restor.file18.name);
      expect(data_restor.file18.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file18.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file18.name = defalut;
      print(data_restor.file18.name);
      expect(data_restor.file18.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file18.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file18.src;
      print(data_restor.file18.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file18.src = testData1s;
      print(data_restor.file18.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file18.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file18.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file18.src = testData2s;
      print(data_restor.file18.src);
      expect(data_restor.file18.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file18.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file18.src = defalut;
      print(data_restor.file18.src);
      expect(data_restor.file18.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file18.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file19.typ;
      print(data_restor.file19.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file19.typ = testData1;
      print(data_restor.file19.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file19.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file19.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file19.typ = testData2;
      print(data_restor.file19.typ);
      expect(data_restor.file19.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file19.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file19.typ = defalut;
      print(data_restor.file19.typ);
      expect(data_restor.file19.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file19.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file19.name;
      print(data_restor.file19.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file19.name = testData1s;
      print(data_restor.file19.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file19.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file19.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file19.name = testData2s;
      print(data_restor.file19.name);
      expect(data_restor.file19.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file19.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file19.name = defalut;
      print(data_restor.file19.name);
      expect(data_restor.file19.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file19.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file19.src;
      print(data_restor.file19.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file19.src = testData1s;
      print(data_restor.file19.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file19.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file19.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file19.src = testData2s;
      print(data_restor.file19.src);
      expect(data_restor.file19.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file19.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file19.src = defalut;
      print(data_restor.file19.src);
      expect(data_restor.file19.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file19.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file20.typ;
      print(data_restor.file20.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file20.typ = testData1;
      print(data_restor.file20.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file20.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file20.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file20.typ = testData2;
      print(data_restor.file20.typ);
      expect(data_restor.file20.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file20.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file20.typ = defalut;
      print(data_restor.file20.typ);
      expect(data_restor.file20.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file20.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file20.name;
      print(data_restor.file20.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file20.name = testData1s;
      print(data_restor.file20.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file20.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file20.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file20.name = testData2s;
      print(data_restor.file20.name);
      expect(data_restor.file20.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file20.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file20.name = defalut;
      print(data_restor.file20.name);
      expect(data_restor.file20.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file20.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file20.src;
      print(data_restor.file20.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file20.src = testData1s;
      print(data_restor.file20.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file20.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file20.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file20.src = testData2s;
      print(data_restor.file20.src);
      expect(data_restor.file20.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file20.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file20.src = defalut;
      print(data_restor.file20.src);
      expect(data_restor.file20.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file20.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file21.typ;
      print(data_restor.file21.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file21.typ = testData1;
      print(data_restor.file21.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file21.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file21.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file21.typ = testData2;
      print(data_restor.file21.typ);
      expect(data_restor.file21.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file21.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file21.typ = defalut;
      print(data_restor.file21.typ);
      expect(data_restor.file21.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file21.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file21.name;
      print(data_restor.file21.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file21.name = testData1s;
      print(data_restor.file21.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file21.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file21.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file21.name = testData2s;
      print(data_restor.file21.name);
      expect(data_restor.file21.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file21.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file21.name = defalut;
      print(data_restor.file21.name);
      expect(data_restor.file21.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file21.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file21.src;
      print(data_restor.file21.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file21.src = testData1s;
      print(data_restor.file21.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file21.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file21.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file21.src = testData2s;
      print(data_restor.file21.src);
      expect(data_restor.file21.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file21.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file21.src = defalut;
      print(data_restor.file21.src);
      expect(data_restor.file21.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file21.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file22.typ;
      print(data_restor.file22.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file22.typ = testData1;
      print(data_restor.file22.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file22.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file22.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file22.typ = testData2;
      print(data_restor.file22.typ);
      expect(data_restor.file22.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file22.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file22.typ = defalut;
      print(data_restor.file22.typ);
      expect(data_restor.file22.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file22.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file22.name;
      print(data_restor.file22.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file22.name = testData1s;
      print(data_restor.file22.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file22.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file22.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file22.name = testData2s;
      print(data_restor.file22.name);
      expect(data_restor.file22.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file22.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file22.name = defalut;
      print(data_restor.file22.name);
      expect(data_restor.file22.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file22.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file22.src;
      print(data_restor.file22.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file22.src = testData1s;
      print(data_restor.file22.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file22.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file22.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file22.src = testData2s;
      print(data_restor.file22.src);
      expect(data_restor.file22.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file22.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file22.src = defalut;
      print(data_restor.file22.src);
      expect(data_restor.file22.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file22.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file23.typ;
      print(data_restor.file23.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file23.typ = testData1;
      print(data_restor.file23.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file23.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file23.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file23.typ = testData2;
      print(data_restor.file23.typ);
      expect(data_restor.file23.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file23.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file23.typ = defalut;
      print(data_restor.file23.typ);
      expect(data_restor.file23.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file23.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file23.name;
      print(data_restor.file23.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file23.name = testData1s;
      print(data_restor.file23.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file23.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file23.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file23.name = testData2s;
      print(data_restor.file23.name);
      expect(data_restor.file23.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file23.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file23.name = defalut;
      print(data_restor.file23.name);
      expect(data_restor.file23.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file23.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file23.src;
      print(data_restor.file23.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file23.src = testData1s;
      print(data_restor.file23.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file23.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file23.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file23.src = testData2s;
      print(data_restor.file23.src);
      expect(data_restor.file23.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file23.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file23.src = defalut;
      print(data_restor.file23.src);
      expect(data_restor.file23.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file23.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file24.typ;
      print(data_restor.file24.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file24.typ = testData1;
      print(data_restor.file24.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file24.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file24.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file24.typ = testData2;
      print(data_restor.file24.typ);
      expect(data_restor.file24.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file24.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file24.typ = defalut;
      print(data_restor.file24.typ);
      expect(data_restor.file24.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file24.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file24.name;
      print(data_restor.file24.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file24.name = testData1s;
      print(data_restor.file24.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file24.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file24.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file24.name = testData2s;
      print(data_restor.file24.name);
      expect(data_restor.file24.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file24.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file24.name = defalut;
      print(data_restor.file24.name);
      expect(data_restor.file24.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file24.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file24.src;
      print(data_restor.file24.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file24.src = testData1s;
      print(data_restor.file24.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file24.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file24.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file24.src = testData2s;
      print(data_restor.file24.src);
      expect(data_restor.file24.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file24.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file24.src = defalut;
      print(data_restor.file24.src);
      expect(data_restor.file24.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file24.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file25.typ;
      print(data_restor.file25.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file25.typ = testData1;
      print(data_restor.file25.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file25.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file25.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file25.typ = testData2;
      print(data_restor.file25.typ);
      expect(data_restor.file25.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file25.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file25.typ = defalut;
      print(data_restor.file25.typ);
      expect(data_restor.file25.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file25.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file25.name;
      print(data_restor.file25.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file25.name = testData1s;
      print(data_restor.file25.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file25.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file25.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file25.name = testData2s;
      print(data_restor.file25.name);
      expect(data_restor.file25.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file25.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file25.name = defalut;
      print(data_restor.file25.name);
      expect(data_restor.file25.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file25.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file25.src;
      print(data_restor.file25.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file25.src = testData1s;
      print(data_restor.file25.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file25.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file25.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file25.src = testData2s;
      print(data_restor.file25.src);
      expect(data_restor.file25.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file25.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file25.src = defalut;
      print(data_restor.file25.src);
      expect(data_restor.file25.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file25.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file26.typ;
      print(data_restor.file26.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file26.typ = testData1;
      print(data_restor.file26.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file26.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file26.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file26.typ = testData2;
      print(data_restor.file26.typ);
      expect(data_restor.file26.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file26.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file26.typ = defalut;
      print(data_restor.file26.typ);
      expect(data_restor.file26.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file26.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file26.name;
      print(data_restor.file26.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file26.name = testData1s;
      print(data_restor.file26.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file26.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file26.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file26.name = testData2s;
      print(data_restor.file26.name);
      expect(data_restor.file26.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file26.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file26.name = defalut;
      print(data_restor.file26.name);
      expect(data_restor.file26.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file26.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file26.src;
      print(data_restor.file26.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file26.src = testData1s;
      print(data_restor.file26.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file26.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file26.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file26.src = testData2s;
      print(data_restor.file26.src);
      expect(data_restor.file26.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file26.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file26.src = defalut;
      print(data_restor.file26.src);
      expect(data_restor.file26.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file26.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file27.typ;
      print(data_restor.file27.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file27.typ = testData1;
      print(data_restor.file27.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file27.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file27.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file27.typ = testData2;
      print(data_restor.file27.typ);
      expect(data_restor.file27.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file27.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file27.typ = defalut;
      print(data_restor.file27.typ);
      expect(data_restor.file27.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file27.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file27.name;
      print(data_restor.file27.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file27.name = testData1s;
      print(data_restor.file27.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file27.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file27.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file27.name = testData2s;
      print(data_restor.file27.name);
      expect(data_restor.file27.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file27.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file27.name = defalut;
      print(data_restor.file27.name);
      expect(data_restor.file27.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file27.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file27.src;
      print(data_restor.file27.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file27.src = testData1s;
      print(data_restor.file27.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file27.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file27.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file27.src = testData2s;
      print(data_restor.file27.src);
      expect(data_restor.file27.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file27.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file27.src = defalut;
      print(data_restor.file27.src);
      expect(data_restor.file27.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file27.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file28.typ;
      print(data_restor.file28.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file28.typ = testData1;
      print(data_restor.file28.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file28.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file28.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file28.typ = testData2;
      print(data_restor.file28.typ);
      expect(data_restor.file28.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file28.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file28.typ = defalut;
      print(data_restor.file28.typ);
      expect(data_restor.file28.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file28.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file28.name;
      print(data_restor.file28.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file28.name = testData1s;
      print(data_restor.file28.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file28.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file28.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file28.name = testData2s;
      print(data_restor.file28.name);
      expect(data_restor.file28.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file28.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file28.name = defalut;
      print(data_restor.file28.name);
      expect(data_restor.file28.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file28.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file28.src;
      print(data_restor.file28.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file28.src = testData1s;
      print(data_restor.file28.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file28.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file28.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file28.src = testData2s;
      print(data_restor.file28.src);
      expect(data_restor.file28.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file28.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file28.src = defalut;
      print(data_restor.file28.src);
      expect(data_restor.file28.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file28.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file29.typ;
      print(data_restor.file29.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file29.typ = testData1;
      print(data_restor.file29.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file29.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file29.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file29.typ = testData2;
      print(data_restor.file29.typ);
      expect(data_restor.file29.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file29.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file29.typ = defalut;
      print(data_restor.file29.typ);
      expect(data_restor.file29.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file29.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file29.name;
      print(data_restor.file29.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file29.name = testData1s;
      print(data_restor.file29.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file29.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file29.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file29.name = testData2s;
      print(data_restor.file29.name);
      expect(data_restor.file29.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file29.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file29.name = defalut;
      print(data_restor.file29.name);
      expect(data_restor.file29.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file29.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file29.src;
      print(data_restor.file29.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file29.src = testData1s;
      print(data_restor.file29.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file29.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file29.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file29.src = testData2s;
      print(data_restor.file29.src);
      expect(data_restor.file29.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file29.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file29.src = defalut;
      print(data_restor.file29.src);
      expect(data_restor.file29.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file29.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file30.typ;
      print(data_restor.file30.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file30.typ = testData1;
      print(data_restor.file30.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file30.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file30.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file30.typ = testData2;
      print(data_restor.file30.typ);
      expect(data_restor.file30.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file30.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file30.typ = defalut;
      print(data_restor.file30.typ);
      expect(data_restor.file30.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file30.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file30.name;
      print(data_restor.file30.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file30.name = testData1s;
      print(data_restor.file30.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file30.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file30.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file30.name = testData2s;
      print(data_restor.file30.name);
      expect(data_restor.file30.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file30.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file30.name = defalut;
      print(data_restor.file30.name);
      expect(data_restor.file30.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file30.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file30.src;
      print(data_restor.file30.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file30.src = testData1s;
      print(data_restor.file30.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file30.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file30.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file30.src = testData2s;
      print(data_restor.file30.src);
      expect(data_restor.file30.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file30.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file30.src = defalut;
      print(data_restor.file30.src);
      expect(data_restor.file30.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file30.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file31.typ;
      print(data_restor.file31.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file31.typ = testData1;
      print(data_restor.file31.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file31.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file31.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file31.typ = testData2;
      print(data_restor.file31.typ);
      expect(data_restor.file31.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file31.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file31.typ = defalut;
      print(data_restor.file31.typ);
      expect(data_restor.file31.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file31.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file31.name;
      print(data_restor.file31.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file31.name = testData1s;
      print(data_restor.file31.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file31.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file31.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file31.name = testData2s;
      print(data_restor.file31.name);
      expect(data_restor.file31.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file31.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file31.name = defalut;
      print(data_restor.file31.name);
      expect(data_restor.file31.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file31.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file31.src;
      print(data_restor.file31.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file31.src = testData1s;
      print(data_restor.file31.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file31.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file31.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file31.src = testData2s;
      print(data_restor.file31.src);
      expect(data_restor.file31.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file31.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file31.src = defalut;
      print(data_restor.file31.src);
      expect(data_restor.file31.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file31.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file32.typ;
      print(data_restor.file32.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file32.typ = testData1;
      print(data_restor.file32.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file32.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file32.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file32.typ = testData2;
      print(data_restor.file32.typ);
      expect(data_restor.file32.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file32.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file32.typ = defalut;
      print(data_restor.file32.typ);
      expect(data_restor.file32.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file32.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file32.name;
      print(data_restor.file32.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file32.name = testData1s;
      print(data_restor.file32.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file32.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file32.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file32.name = testData2s;
      print(data_restor.file32.name);
      expect(data_restor.file32.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file32.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file32.name = defalut;
      print(data_restor.file32.name);
      expect(data_restor.file32.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file32.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file32.src;
      print(data_restor.file32.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file32.src = testData1s;
      print(data_restor.file32.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file32.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file32.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file32.src = testData2s;
      print(data_restor.file32.src);
      expect(data_restor.file32.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file32.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file32.src = defalut;
      print(data_restor.file32.src);
      expect(data_restor.file32.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file32.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file33.typ;
      print(data_restor.file33.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file33.typ = testData1;
      print(data_restor.file33.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file33.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file33.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file33.typ = testData2;
      print(data_restor.file33.typ);
      expect(data_restor.file33.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file33.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file33.typ = defalut;
      print(data_restor.file33.typ);
      expect(data_restor.file33.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file33.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file33.name;
      print(data_restor.file33.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file33.name = testData1s;
      print(data_restor.file33.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file33.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file33.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file33.name = testData2s;
      print(data_restor.file33.name);
      expect(data_restor.file33.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file33.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file33.name = defalut;
      print(data_restor.file33.name);
      expect(data_restor.file33.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file33.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file33.src;
      print(data_restor.file33.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file33.src = testData1s;
      print(data_restor.file33.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file33.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file33.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file33.src = testData2s;
      print(data_restor.file33.src);
      expect(data_restor.file33.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file33.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file33.src = defalut;
      print(data_restor.file33.src);
      expect(data_restor.file33.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file33.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file34.typ;
      print(data_restor.file34.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file34.typ = testData1;
      print(data_restor.file34.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file34.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file34.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file34.typ = testData2;
      print(data_restor.file34.typ);
      expect(data_restor.file34.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file34.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file34.typ = defalut;
      print(data_restor.file34.typ);
      expect(data_restor.file34.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file34.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file34.name;
      print(data_restor.file34.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file34.name = testData1s;
      print(data_restor.file34.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file34.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file34.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file34.name = testData2s;
      print(data_restor.file34.name);
      expect(data_restor.file34.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file34.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file34.name = defalut;
      print(data_restor.file34.name);
      expect(data_restor.file34.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file34.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file34.src;
      print(data_restor.file34.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file34.src = testData1s;
      print(data_restor.file34.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file34.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file34.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file34.src = testData2s;
      print(data_restor.file34.src);
      expect(data_restor.file34.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file34.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file34.src = defalut;
      print(data_restor.file34.src);
      expect(data_restor.file34.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file34.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file35.typ;
      print(data_restor.file35.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file35.typ = testData1;
      print(data_restor.file35.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file35.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file35.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file35.typ = testData2;
      print(data_restor.file35.typ);
      expect(data_restor.file35.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file35.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file35.typ = defalut;
      print(data_restor.file35.typ);
      expect(data_restor.file35.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file35.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file35.name;
      print(data_restor.file35.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file35.name = testData1s;
      print(data_restor.file35.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file35.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file35.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file35.name = testData2s;
      print(data_restor.file35.name);
      expect(data_restor.file35.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file35.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file35.name = defalut;
      print(data_restor.file35.name);
      expect(data_restor.file35.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file35.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file35.src;
      print(data_restor.file35.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file35.src = testData1s;
      print(data_restor.file35.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file35.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file35.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file35.src = testData2s;
      print(data_restor.file35.src);
      expect(data_restor.file35.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file35.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file35.src = defalut;
      print(data_restor.file35.src);
      expect(data_restor.file35.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file35.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file36.typ;
      print(data_restor.file36.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file36.typ = testData1;
      print(data_restor.file36.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file36.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file36.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file36.typ = testData2;
      print(data_restor.file36.typ);
      expect(data_restor.file36.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file36.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file36.typ = defalut;
      print(data_restor.file36.typ);
      expect(data_restor.file36.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file36.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file36.name;
      print(data_restor.file36.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file36.name = testData1s;
      print(data_restor.file36.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file36.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file36.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file36.name = testData2s;
      print(data_restor.file36.name);
      expect(data_restor.file36.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file36.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file36.name = defalut;
      print(data_restor.file36.name);
      expect(data_restor.file36.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file36.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file36.src;
      print(data_restor.file36.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file36.src = testData1s;
      print(data_restor.file36.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file36.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file36.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file36.src = testData2s;
      print(data_restor.file36.src);
      expect(data_restor.file36.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file36.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file36.src = defalut;
      print(data_restor.file36.src);
      expect(data_restor.file36.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file36.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file37.typ;
      print(data_restor.file37.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file37.typ = testData1;
      print(data_restor.file37.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file37.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file37.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file37.typ = testData2;
      print(data_restor.file37.typ);
      expect(data_restor.file37.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file37.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file37.typ = defalut;
      print(data_restor.file37.typ);
      expect(data_restor.file37.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file37.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file37.name;
      print(data_restor.file37.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file37.name = testData1s;
      print(data_restor.file37.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file37.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file37.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file37.name = testData2s;
      print(data_restor.file37.name);
      expect(data_restor.file37.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file37.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file37.name = defalut;
      print(data_restor.file37.name);
      expect(data_restor.file37.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file37.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file37.src;
      print(data_restor.file37.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file37.src = testData1s;
      print(data_restor.file37.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file37.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file37.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file37.src = testData2s;
      print(data_restor.file37.src);
      expect(data_restor.file37.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file37.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file37.src = defalut;
      print(data_restor.file37.src);
      expect(data_restor.file37.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file37.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file38.typ;
      print(data_restor.file38.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file38.typ = testData1;
      print(data_restor.file38.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file38.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file38.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file38.typ = testData2;
      print(data_restor.file38.typ);
      expect(data_restor.file38.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file38.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file38.typ = defalut;
      print(data_restor.file38.typ);
      expect(data_restor.file38.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file38.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file38.name;
      print(data_restor.file38.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file38.name = testData1s;
      print(data_restor.file38.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file38.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file38.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file38.name = testData2s;
      print(data_restor.file38.name);
      expect(data_restor.file38.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file38.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file38.name = defalut;
      print(data_restor.file38.name);
      expect(data_restor.file38.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file38.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file38.src;
      print(data_restor.file38.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file38.src = testData1s;
      print(data_restor.file38.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file38.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file38.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file38.src = testData2s;
      print(data_restor.file38.src);
      expect(data_restor.file38.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file38.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file38.src = defalut;
      print(data_restor.file38.src);
      expect(data_restor.file38.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file38.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file39.typ;
      print(data_restor.file39.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file39.typ = testData1;
      print(data_restor.file39.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file39.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file39.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file39.typ = testData2;
      print(data_restor.file39.typ);
      expect(data_restor.file39.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file39.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file39.typ = defalut;
      print(data_restor.file39.typ);
      expect(data_restor.file39.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file39.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file39.name;
      print(data_restor.file39.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file39.name = testData1s;
      print(data_restor.file39.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file39.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file39.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file39.name = testData2s;
      print(data_restor.file39.name);
      expect(data_restor.file39.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file39.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file39.name = defalut;
      print(data_restor.file39.name);
      expect(data_restor.file39.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file39.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file39.src;
      print(data_restor.file39.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file39.src = testData1s;
      print(data_restor.file39.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file39.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file39.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file39.src = testData2s;
      print(data_restor.file39.src);
      expect(data_restor.file39.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file39.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file39.src = defalut;
      print(data_restor.file39.src);
      expect(data_restor.file39.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file39.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file40.typ;
      print(data_restor.file40.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file40.typ = testData1;
      print(data_restor.file40.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file40.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file40.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file40.typ = testData2;
      print(data_restor.file40.typ);
      expect(data_restor.file40.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file40.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file40.typ = defalut;
      print(data_restor.file40.typ);
      expect(data_restor.file40.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file40.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file40.name;
      print(data_restor.file40.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file40.name = testData1s;
      print(data_restor.file40.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file40.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file40.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file40.name = testData2s;
      print(data_restor.file40.name);
      expect(data_restor.file40.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file40.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file40.name = defalut;
      print(data_restor.file40.name);
      expect(data_restor.file40.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file40.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file40.src;
      print(data_restor.file40.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file40.src = testData1s;
      print(data_restor.file40.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file40.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file40.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file40.src = testData2s;
      print(data_restor.file40.src);
      expect(data_restor.file40.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file40.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file40.src = defalut;
      print(data_restor.file40.src);
      expect(data_restor.file40.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file40.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file41.typ;
      print(data_restor.file41.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file41.typ = testData1;
      print(data_restor.file41.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file41.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file41.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file41.typ = testData2;
      print(data_restor.file41.typ);
      expect(data_restor.file41.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file41.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file41.typ = defalut;
      print(data_restor.file41.typ);
      expect(data_restor.file41.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file41.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file41.name;
      print(data_restor.file41.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file41.name = testData1s;
      print(data_restor.file41.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file41.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file41.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file41.name = testData2s;
      print(data_restor.file41.name);
      expect(data_restor.file41.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file41.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file41.name = defalut;
      print(data_restor.file41.name);
      expect(data_restor.file41.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file41.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file41.src;
      print(data_restor.file41.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file41.src = testData1s;
      print(data_restor.file41.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file41.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file41.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file41.src = testData2s;
      print(data_restor.file41.src);
      expect(data_restor.file41.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file41.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file41.src = defalut;
      print(data_restor.file41.src);
      expect(data_restor.file41.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file41.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file42.typ;
      print(data_restor.file42.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file42.typ = testData1;
      print(data_restor.file42.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file42.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file42.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file42.typ = testData2;
      print(data_restor.file42.typ);
      expect(data_restor.file42.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file42.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file42.typ = defalut;
      print(data_restor.file42.typ);
      expect(data_restor.file42.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file42.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file42.name;
      print(data_restor.file42.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file42.name = testData1s;
      print(data_restor.file42.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file42.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file42.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file42.name = testData2s;
      print(data_restor.file42.name);
      expect(data_restor.file42.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file42.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file42.name = defalut;
      print(data_restor.file42.name);
      expect(data_restor.file42.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file42.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file42.src;
      print(data_restor.file42.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file42.src = testData1s;
      print(data_restor.file42.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file42.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file42.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file42.src = testData2s;
      print(data_restor.file42.src);
      expect(data_restor.file42.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file42.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file42.src = defalut;
      print(data_restor.file42.src);
      expect(data_restor.file42.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file42.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file43.typ;
      print(data_restor.file43.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file43.typ = testData1;
      print(data_restor.file43.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file43.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file43.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file43.typ = testData2;
      print(data_restor.file43.typ);
      expect(data_restor.file43.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file43.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file43.typ = defalut;
      print(data_restor.file43.typ);
      expect(data_restor.file43.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file43.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file43.name;
      print(data_restor.file43.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file43.name = testData1s;
      print(data_restor.file43.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file43.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file43.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file43.name = testData2s;
      print(data_restor.file43.name);
      expect(data_restor.file43.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file43.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file43.name = defalut;
      print(data_restor.file43.name);
      expect(data_restor.file43.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file43.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file43.src;
      print(data_restor.file43.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file43.src = testData1s;
      print(data_restor.file43.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file43.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file43.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file43.src = testData2s;
      print(data_restor.file43.src);
      expect(data_restor.file43.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file43.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file43.src = defalut;
      print(data_restor.file43.src);
      expect(data_restor.file43.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file43.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file44.typ;
      print(data_restor.file44.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file44.typ = testData1;
      print(data_restor.file44.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file44.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file44.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file44.typ = testData2;
      print(data_restor.file44.typ);
      expect(data_restor.file44.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file44.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file44.typ = defalut;
      print(data_restor.file44.typ);
      expect(data_restor.file44.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file44.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file44.name;
      print(data_restor.file44.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file44.name = testData1s;
      print(data_restor.file44.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file44.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file44.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file44.name = testData2s;
      print(data_restor.file44.name);
      expect(data_restor.file44.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file44.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file44.name = defalut;
      print(data_restor.file44.name);
      expect(data_restor.file44.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file44.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file44.src;
      print(data_restor.file44.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file44.src = testData1s;
      print(data_restor.file44.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file44.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file44.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file44.src = testData2s;
      print(data_restor.file44.src);
      expect(data_restor.file44.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file44.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file44.src = defalut;
      print(data_restor.file44.src);
      expect(data_restor.file44.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file44.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file45.typ;
      print(data_restor.file45.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file45.typ = testData1;
      print(data_restor.file45.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file45.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file45.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file45.typ = testData2;
      print(data_restor.file45.typ);
      expect(data_restor.file45.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file45.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file45.typ = defalut;
      print(data_restor.file45.typ);
      expect(data_restor.file45.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file45.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file45.name;
      print(data_restor.file45.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file45.name = testData1s;
      print(data_restor.file45.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file45.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file45.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file45.name = testData2s;
      print(data_restor.file45.name);
      expect(data_restor.file45.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file45.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file45.name = defalut;
      print(data_restor.file45.name);
      expect(data_restor.file45.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file45.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file45.src;
      print(data_restor.file45.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file45.src = testData1s;
      print(data_restor.file45.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file45.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file45.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file45.src = testData2s;
      print(data_restor.file45.src);
      expect(data_restor.file45.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file45.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file45.src = defalut;
      print(data_restor.file45.src);
      expect(data_restor.file45.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file45.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file46.typ;
      print(data_restor.file46.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file46.typ = testData1;
      print(data_restor.file46.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file46.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file46.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file46.typ = testData2;
      print(data_restor.file46.typ);
      expect(data_restor.file46.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file46.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file46.typ = defalut;
      print(data_restor.file46.typ);
      expect(data_restor.file46.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file46.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file46.name;
      print(data_restor.file46.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file46.name = testData1s;
      print(data_restor.file46.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file46.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file46.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file46.name = testData2s;
      print(data_restor.file46.name);
      expect(data_restor.file46.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file46.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file46.name = defalut;
      print(data_restor.file46.name);
      expect(data_restor.file46.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file46.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file46.src;
      print(data_restor.file46.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file46.src = testData1s;
      print(data_restor.file46.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file46.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file46.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file46.src = testData2s;
      print(data_restor.file46.src);
      expect(data_restor.file46.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file46.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file46.src = defalut;
      print(data_restor.file46.src);
      expect(data_restor.file46.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file46.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file47.typ;
      print(data_restor.file47.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file47.typ = testData1;
      print(data_restor.file47.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file47.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file47.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file47.typ = testData2;
      print(data_restor.file47.typ);
      expect(data_restor.file47.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file47.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file47.typ = defalut;
      print(data_restor.file47.typ);
      expect(data_restor.file47.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file47.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file47.name;
      print(data_restor.file47.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file47.name = testData1s;
      print(data_restor.file47.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file47.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file47.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file47.name = testData2s;
      print(data_restor.file47.name);
      expect(data_restor.file47.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file47.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file47.name = defalut;
      print(data_restor.file47.name);
      expect(data_restor.file47.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file47.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file47.src;
      print(data_restor.file47.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file47.src = testData1s;
      print(data_restor.file47.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file47.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file47.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file47.src = testData2s;
      print(data_restor.file47.src);
      expect(data_restor.file47.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file47.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file47.src = defalut;
      print(data_restor.file47.src);
      expect(data_restor.file47.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file47.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file48.typ;
      print(data_restor.file48.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file48.typ = testData1;
      print(data_restor.file48.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file48.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file48.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file48.typ = testData2;
      print(data_restor.file48.typ);
      expect(data_restor.file48.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file48.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file48.typ = defalut;
      print(data_restor.file48.typ);
      expect(data_restor.file48.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file48.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file48.name;
      print(data_restor.file48.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file48.name = testData1s;
      print(data_restor.file48.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file48.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file48.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file48.name = testData2s;
      print(data_restor.file48.name);
      expect(data_restor.file48.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file48.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file48.name = defalut;
      print(data_restor.file48.name);
      expect(data_restor.file48.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file48.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file48.src;
      print(data_restor.file48.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file48.src = testData1s;
      print(data_restor.file48.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file48.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file48.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file48.src = testData2s;
      print(data_restor.file48.src);
      expect(data_restor.file48.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file48.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file48.src = defalut;
      print(data_restor.file48.src);
      expect(data_restor.file48.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file48.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file49.typ;
      print(data_restor.file49.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file49.typ = testData1;
      print(data_restor.file49.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file49.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file49.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file49.typ = testData2;
      print(data_restor.file49.typ);
      expect(data_restor.file49.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file49.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file49.typ = defalut;
      print(data_restor.file49.typ);
      expect(data_restor.file49.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file49.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file49.name;
      print(data_restor.file49.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file49.name = testData1s;
      print(data_restor.file49.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file49.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file49.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file49.name = testData2s;
      print(data_restor.file49.name);
      expect(data_restor.file49.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file49.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file49.name = defalut;
      print(data_restor.file49.name);
      expect(data_restor.file49.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file49.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file49.src;
      print(data_restor.file49.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file49.src = testData1s;
      print(data_restor.file49.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file49.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file49.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file49.src = testData2s;
      print(data_restor.file49.src);
      expect(data_restor.file49.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file49.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file49.src = defalut;
      print(data_restor.file49.src);
      expect(data_restor.file49.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file49.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file50.typ;
      print(data_restor.file50.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file50.typ = testData1;
      print(data_restor.file50.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file50.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file50.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file50.typ = testData2;
      print(data_restor.file50.typ);
      expect(data_restor.file50.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file50.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file50.typ = defalut;
      print(data_restor.file50.typ);
      expect(data_restor.file50.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file50.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file50.name;
      print(data_restor.file50.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file50.name = testData1s;
      print(data_restor.file50.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file50.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file50.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file50.name = testData2s;
      print(data_restor.file50.name);
      expect(data_restor.file50.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file50.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file50.name = defalut;
      print(data_restor.file50.name);
      expect(data_restor.file50.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file50.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file50.src;
      print(data_restor.file50.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file50.src = testData1s;
      print(data_restor.file50.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file50.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file50.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file50.src = testData2s;
      print(data_restor.file50.src);
      expect(data_restor.file50.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file50.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file50.src = defalut;
      print(data_restor.file50.src);
      expect(data_restor.file50.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file50.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file51.typ;
      print(data_restor.file51.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file51.typ = testData1;
      print(data_restor.file51.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file51.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file51.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file51.typ = testData2;
      print(data_restor.file51.typ);
      expect(data_restor.file51.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file51.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file51.typ = defalut;
      print(data_restor.file51.typ);
      expect(data_restor.file51.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file51.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file51.name;
      print(data_restor.file51.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file51.name = testData1s;
      print(data_restor.file51.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file51.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file51.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file51.name = testData2s;
      print(data_restor.file51.name);
      expect(data_restor.file51.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file51.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file51.name = defalut;
      print(data_restor.file51.name);
      expect(data_restor.file51.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file51.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file51.src;
      print(data_restor.file51.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file51.src = testData1s;
      print(data_restor.file51.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file51.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file51.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file51.src = testData2s;
      print(data_restor.file51.src);
      expect(data_restor.file51.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file51.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file51.src = defalut;
      print(data_restor.file51.src);
      expect(data_restor.file51.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file51.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file52.typ;
      print(data_restor.file52.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file52.typ = testData1;
      print(data_restor.file52.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file52.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file52.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file52.typ = testData2;
      print(data_restor.file52.typ);
      expect(data_restor.file52.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file52.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file52.typ = defalut;
      print(data_restor.file52.typ);
      expect(data_restor.file52.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file52.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file52.name;
      print(data_restor.file52.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file52.name = testData1s;
      print(data_restor.file52.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file52.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file52.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file52.name = testData2s;
      print(data_restor.file52.name);
      expect(data_restor.file52.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file52.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file52.name = defalut;
      print(data_restor.file52.name);
      expect(data_restor.file52.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file52.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file52.src;
      print(data_restor.file52.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file52.src = testData1s;
      print(data_restor.file52.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file52.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file52.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file52.src = testData2s;
      print(data_restor.file52.src);
      expect(data_restor.file52.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file52.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file52.src = defalut;
      print(data_restor.file52.src);
      expect(data_restor.file52.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file52.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file53.typ;
      print(data_restor.file53.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file53.typ = testData1;
      print(data_restor.file53.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file53.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file53.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file53.typ = testData2;
      print(data_restor.file53.typ);
      expect(data_restor.file53.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file53.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file53.typ = defalut;
      print(data_restor.file53.typ);
      expect(data_restor.file53.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file53.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file53.name;
      print(data_restor.file53.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file53.name = testData1s;
      print(data_restor.file53.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file53.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file53.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file53.name = testData2s;
      print(data_restor.file53.name);
      expect(data_restor.file53.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file53.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file53.name = defalut;
      print(data_restor.file53.name);
      expect(data_restor.file53.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file53.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file53.src;
      print(data_restor.file53.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file53.src = testData1s;
      print(data_restor.file53.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file53.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file53.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file53.src = testData2s;
      print(data_restor.file53.src);
      expect(data_restor.file53.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file53.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file53.src = defalut;
      print(data_restor.file53.src);
      expect(data_restor.file53.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file53.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file54.typ;
      print(data_restor.file54.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file54.typ = testData1;
      print(data_restor.file54.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file54.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file54.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file54.typ = testData2;
      print(data_restor.file54.typ);
      expect(data_restor.file54.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file54.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file54.typ = defalut;
      print(data_restor.file54.typ);
      expect(data_restor.file54.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file54.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file54.name;
      print(data_restor.file54.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file54.name = testData1s;
      print(data_restor.file54.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file54.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file54.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file54.name = testData2s;
      print(data_restor.file54.name);
      expect(data_restor.file54.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file54.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file54.name = defalut;
      print(data_restor.file54.name);
      expect(data_restor.file54.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file54.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file54.src;
      print(data_restor.file54.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file54.src = testData1s;
      print(data_restor.file54.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file54.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file54.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file54.src = testData2s;
      print(data_restor.file54.src);
      expect(data_restor.file54.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file54.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file54.src = defalut;
      print(data_restor.file54.src);
      expect(data_restor.file54.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file54.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file55.typ;
      print(data_restor.file55.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file55.typ = testData1;
      print(data_restor.file55.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file55.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file55.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file55.typ = testData2;
      print(data_restor.file55.typ);
      expect(data_restor.file55.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file55.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file55.typ = defalut;
      print(data_restor.file55.typ);
      expect(data_restor.file55.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file55.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file55.name;
      print(data_restor.file55.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file55.name = testData1s;
      print(data_restor.file55.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file55.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file55.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file55.name = testData2s;
      print(data_restor.file55.name);
      expect(data_restor.file55.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file55.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file55.name = defalut;
      print(data_restor.file55.name);
      expect(data_restor.file55.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file55.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file55.src;
      print(data_restor.file55.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file55.src = testData1s;
      print(data_restor.file55.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file55.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file55.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file55.src = testData2s;
      print(data_restor.file55.src);
      expect(data_restor.file55.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file55.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file55.src = defalut;
      print(data_restor.file55.src);
      expect(data_restor.file55.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file55.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file56.typ;
      print(data_restor.file56.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file56.typ = testData1;
      print(data_restor.file56.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file56.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file56.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file56.typ = testData2;
      print(data_restor.file56.typ);
      expect(data_restor.file56.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file56.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file56.typ = defalut;
      print(data_restor.file56.typ);
      expect(data_restor.file56.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file56.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file56.name;
      print(data_restor.file56.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file56.name = testData1s;
      print(data_restor.file56.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file56.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file56.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file56.name = testData2s;
      print(data_restor.file56.name);
      expect(data_restor.file56.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file56.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file56.name = defalut;
      print(data_restor.file56.name);
      expect(data_restor.file56.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file56.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file56.src;
      print(data_restor.file56.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file56.src = testData1s;
      print(data_restor.file56.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file56.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file56.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file56.src = testData2s;
      print(data_restor.file56.src);
      expect(data_restor.file56.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file56.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file56.src = defalut;
      print(data_restor.file56.src);
      expect(data_restor.file56.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file56.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file57.typ;
      print(data_restor.file57.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file57.typ = testData1;
      print(data_restor.file57.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file57.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file57.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file57.typ = testData2;
      print(data_restor.file57.typ);
      expect(data_restor.file57.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file57.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file57.typ = defalut;
      print(data_restor.file57.typ);
      expect(data_restor.file57.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file57.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file57.name;
      print(data_restor.file57.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file57.name = testData1s;
      print(data_restor.file57.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file57.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file57.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file57.name = testData2s;
      print(data_restor.file57.name);
      expect(data_restor.file57.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file57.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file57.name = defalut;
      print(data_restor.file57.name);
      expect(data_restor.file57.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file57.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file57.src;
      print(data_restor.file57.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file57.src = testData1s;
      print(data_restor.file57.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file57.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file57.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file57.src = testData2s;
      print(data_restor.file57.src);
      expect(data_restor.file57.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file57.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file57.src = defalut;
      print(data_restor.file57.src);
      expect(data_restor.file57.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file57.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file58.typ;
      print(data_restor.file58.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file58.typ = testData1;
      print(data_restor.file58.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file58.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file58.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file58.typ = testData2;
      print(data_restor.file58.typ);
      expect(data_restor.file58.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file58.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file58.typ = defalut;
      print(data_restor.file58.typ);
      expect(data_restor.file58.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file58.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file58.name;
      print(data_restor.file58.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file58.name = testData1s;
      print(data_restor.file58.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file58.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file58.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file58.name = testData2s;
      print(data_restor.file58.name);
      expect(data_restor.file58.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file58.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file58.name = defalut;
      print(data_restor.file58.name);
      expect(data_restor.file58.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file58.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file58.src;
      print(data_restor.file58.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file58.src = testData1s;
      print(data_restor.file58.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file58.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file58.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file58.src = testData2s;
      print(data_restor.file58.src);
      expect(data_restor.file58.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file58.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file58.src = defalut;
      print(data_restor.file58.src);
      expect(data_restor.file58.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file58.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file59.typ;
      print(data_restor.file59.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file59.typ = testData1;
      print(data_restor.file59.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file59.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file59.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file59.typ = testData2;
      print(data_restor.file59.typ);
      expect(data_restor.file59.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file59.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file59.typ = defalut;
      print(data_restor.file59.typ);
      expect(data_restor.file59.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file59.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file59.name;
      print(data_restor.file59.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file59.name = testData1s;
      print(data_restor.file59.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file59.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file59.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file59.name = testData2s;
      print(data_restor.file59.name);
      expect(data_restor.file59.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file59.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file59.name = defalut;
      print(data_restor.file59.name);
      expect(data_restor.file59.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file59.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file59.src;
      print(data_restor.file59.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file59.src = testData1s;
      print(data_restor.file59.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file59.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file59.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file59.src = testData2s;
      print(data_restor.file59.src);
      expect(data_restor.file59.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file59.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file59.src = defalut;
      print(data_restor.file59.src);
      expect(data_restor.file59.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file59.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file60.typ;
      print(data_restor.file60.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file60.typ = testData1;
      print(data_restor.file60.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file60.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file60.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file60.typ = testData2;
      print(data_restor.file60.typ);
      expect(data_restor.file60.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file60.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file60.typ = defalut;
      print(data_restor.file60.typ);
      expect(data_restor.file60.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file60.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file60.name;
      print(data_restor.file60.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file60.name = testData1s;
      print(data_restor.file60.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file60.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file60.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file60.name = testData2s;
      print(data_restor.file60.name);
      expect(data_restor.file60.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file60.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file60.name = defalut;
      print(data_restor.file60.name);
      expect(data_restor.file60.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file60.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file60.src;
      print(data_restor.file60.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file60.src = testData1s;
      print(data_restor.file60.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file60.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file60.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file60.src = testData2s;
      print(data_restor.file60.src);
      expect(data_restor.file60.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file60.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file60.src = defalut;
      print(data_restor.file60.src);
      expect(data_restor.file60.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file60.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file61.typ;
      print(data_restor.file61.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file61.typ = testData1;
      print(data_restor.file61.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file61.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file61.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file61.typ = testData2;
      print(data_restor.file61.typ);
      expect(data_restor.file61.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file61.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file61.typ = defalut;
      print(data_restor.file61.typ);
      expect(data_restor.file61.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file61.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file61.name;
      print(data_restor.file61.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file61.name = testData1s;
      print(data_restor.file61.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file61.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file61.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file61.name = testData2s;
      print(data_restor.file61.name);
      expect(data_restor.file61.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file61.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file61.name = defalut;
      print(data_restor.file61.name);
      expect(data_restor.file61.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file61.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file61.src;
      print(data_restor.file61.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file61.src = testData1s;
      print(data_restor.file61.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file61.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file61.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file61.src = testData2s;
      print(data_restor.file61.src);
      expect(data_restor.file61.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file61.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file61.src = defalut;
      print(data_restor.file61.src);
      expect(data_restor.file61.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file61.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file62.typ;
      print(data_restor.file62.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file62.typ = testData1;
      print(data_restor.file62.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file62.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file62.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file62.typ = testData2;
      print(data_restor.file62.typ);
      expect(data_restor.file62.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file62.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file62.typ = defalut;
      print(data_restor.file62.typ);
      expect(data_restor.file62.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file62.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file62.name;
      print(data_restor.file62.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file62.name = testData1s;
      print(data_restor.file62.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file62.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file62.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file62.name = testData2s;
      print(data_restor.file62.name);
      expect(data_restor.file62.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file62.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file62.name = defalut;
      print(data_restor.file62.name);
      expect(data_restor.file62.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file62.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file62.src;
      print(data_restor.file62.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file62.src = testData1s;
      print(data_restor.file62.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file62.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file62.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file62.src = testData2s;
      print(data_restor.file62.src);
      expect(data_restor.file62.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file62.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file62.src = defalut;
      print(data_restor.file62.src);
      expect(data_restor.file62.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file62.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file63.typ;
      print(data_restor.file63.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file63.typ = testData1;
      print(data_restor.file63.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file63.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file63.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file63.typ = testData2;
      print(data_restor.file63.typ);
      expect(data_restor.file63.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file63.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file63.typ = defalut;
      print(data_restor.file63.typ);
      expect(data_restor.file63.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file63.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file63.name;
      print(data_restor.file63.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file63.name = testData1s;
      print(data_restor.file63.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file63.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file63.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file63.name = testData2s;
      print(data_restor.file63.name);
      expect(data_restor.file63.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file63.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file63.name = defalut;
      print(data_restor.file63.name);
      expect(data_restor.file63.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file63.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file63.src;
      print(data_restor.file63.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file63.src = testData1s;
      print(data_restor.file63.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file63.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file63.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file63.src = testData2s;
      print(data_restor.file63.src);
      expect(data_restor.file63.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file63.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file63.src = defalut;
      print(data_restor.file63.src);
      expect(data_restor.file63.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file63.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file64.typ;
      print(data_restor.file64.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file64.typ = testData1;
      print(data_restor.file64.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file64.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file64.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file64.typ = testData2;
      print(data_restor.file64.typ);
      expect(data_restor.file64.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file64.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file64.typ = defalut;
      print(data_restor.file64.typ);
      expect(data_restor.file64.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file64.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file64.name;
      print(data_restor.file64.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file64.name = testData1s;
      print(data_restor.file64.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file64.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file64.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file64.name = testData2s;
      print(data_restor.file64.name);
      expect(data_restor.file64.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file64.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file64.name = defalut;
      print(data_restor.file64.name);
      expect(data_restor.file64.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file64.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file64.src;
      print(data_restor.file64.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file64.src = testData1s;
      print(data_restor.file64.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file64.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file64.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file64.src = testData2s;
      print(data_restor.file64.src);
      expect(data_restor.file64.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file64.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file64.src = defalut;
      print(data_restor.file64.src);
      expect(data_restor.file64.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file64.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file65.typ;
      print(data_restor.file65.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file65.typ = testData1;
      print(data_restor.file65.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file65.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file65.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file65.typ = testData2;
      print(data_restor.file65.typ);
      expect(data_restor.file65.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file65.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file65.typ = defalut;
      print(data_restor.file65.typ);
      expect(data_restor.file65.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file65.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file65.name;
      print(data_restor.file65.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file65.name = testData1s;
      print(data_restor.file65.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file65.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file65.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file65.name = testData2s;
      print(data_restor.file65.name);
      expect(data_restor.file65.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file65.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file65.name = defalut;
      print(data_restor.file65.name);
      expect(data_restor.file65.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file65.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file65.src;
      print(data_restor.file65.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file65.src = testData1s;
      print(data_restor.file65.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file65.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file65.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file65.src = testData2s;
      print(data_restor.file65.src);
      expect(data_restor.file65.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file65.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file65.src = defalut;
      print(data_restor.file65.src);
      expect(data_restor.file65.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file65.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file66.typ;
      print(data_restor.file66.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file66.typ = testData1;
      print(data_restor.file66.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file66.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file66.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file66.typ = testData2;
      print(data_restor.file66.typ);
      expect(data_restor.file66.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file66.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file66.typ = defalut;
      print(data_restor.file66.typ);
      expect(data_restor.file66.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file66.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file66.name;
      print(data_restor.file66.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file66.name = testData1s;
      print(data_restor.file66.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file66.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file66.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file66.name = testData2s;
      print(data_restor.file66.name);
      expect(data_restor.file66.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file66.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file66.name = defalut;
      print(data_restor.file66.name);
      expect(data_restor.file66.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file66.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file66.src;
      print(data_restor.file66.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file66.src = testData1s;
      print(data_restor.file66.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file66.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file66.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file66.src = testData2s;
      print(data_restor.file66.src);
      expect(data_restor.file66.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file66.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file66.src = defalut;
      print(data_restor.file66.src);
      expect(data_restor.file66.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file66.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file67.typ;
      print(data_restor.file67.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file67.typ = testData1;
      print(data_restor.file67.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file67.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file67.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file67.typ = testData2;
      print(data_restor.file67.typ);
      expect(data_restor.file67.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file67.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file67.typ = defalut;
      print(data_restor.file67.typ);
      expect(data_restor.file67.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file67.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file67.name;
      print(data_restor.file67.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file67.name = testData1s;
      print(data_restor.file67.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file67.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file67.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file67.name = testData2s;
      print(data_restor.file67.name);
      expect(data_restor.file67.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file67.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file67.name = defalut;
      print(data_restor.file67.name);
      expect(data_restor.file67.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file67.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file67.src;
      print(data_restor.file67.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file67.src = testData1s;
      print(data_restor.file67.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file67.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file67.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file67.src = testData2s;
      print(data_restor.file67.src);
      expect(data_restor.file67.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file67.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file67.src = defalut;
      print(data_restor.file67.src);
      expect(data_restor.file67.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file67.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file68.typ;
      print(data_restor.file68.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file68.typ = testData1;
      print(data_restor.file68.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file68.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file68.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file68.typ = testData2;
      print(data_restor.file68.typ);
      expect(data_restor.file68.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file68.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file68.typ = defalut;
      print(data_restor.file68.typ);
      expect(data_restor.file68.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file68.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file68.name;
      print(data_restor.file68.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file68.name = testData1s;
      print(data_restor.file68.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file68.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file68.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file68.name = testData2s;
      print(data_restor.file68.name);
      expect(data_restor.file68.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file68.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file68.name = defalut;
      print(data_restor.file68.name);
      expect(data_restor.file68.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file68.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file68.src;
      print(data_restor.file68.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file68.src = testData1s;
      print(data_restor.file68.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file68.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file68.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file68.src = testData2s;
      print(data_restor.file68.src);
      expect(data_restor.file68.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file68.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file68.src = defalut;
      print(data_restor.file68.src);
      expect(data_restor.file68.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file68.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file69.typ;
      print(data_restor.file69.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file69.typ = testData1;
      print(data_restor.file69.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file69.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file69.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file69.typ = testData2;
      print(data_restor.file69.typ);
      expect(data_restor.file69.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file69.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file69.typ = defalut;
      print(data_restor.file69.typ);
      expect(data_restor.file69.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file69.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file69.name;
      print(data_restor.file69.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file69.name = testData1s;
      print(data_restor.file69.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file69.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file69.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file69.name = testData2s;
      print(data_restor.file69.name);
      expect(data_restor.file69.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file69.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file69.name = defalut;
      print(data_restor.file69.name);
      expect(data_restor.file69.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file69.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file69.src;
      print(data_restor.file69.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file69.src = testData1s;
      print(data_restor.file69.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file69.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file69.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file69.src = testData2s;
      print(data_restor.file69.src);
      expect(data_restor.file69.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file69.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file69.src = defalut;
      print(data_restor.file69.src);
      expect(data_restor.file69.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file69.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file70.typ;
      print(data_restor.file70.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file70.typ = testData1;
      print(data_restor.file70.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file70.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file70.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file70.typ = testData2;
      print(data_restor.file70.typ);
      expect(data_restor.file70.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file70.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file70.typ = defalut;
      print(data_restor.file70.typ);
      expect(data_restor.file70.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file70.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file70.name;
      print(data_restor.file70.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file70.name = testData1s;
      print(data_restor.file70.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file70.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file70.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file70.name = testData2s;
      print(data_restor.file70.name);
      expect(data_restor.file70.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file70.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file70.name = defalut;
      print(data_restor.file70.name);
      expect(data_restor.file70.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file70.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file70.src;
      print(data_restor.file70.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file70.src = testData1s;
      print(data_restor.file70.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file70.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file70.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file70.src = testData2s;
      print(data_restor.file70.src);
      expect(data_restor.file70.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file70.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file70.src = defalut;
      print(data_restor.file70.src);
      expect(data_restor.file70.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file70.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file71.typ;
      print(data_restor.file71.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file71.typ = testData1;
      print(data_restor.file71.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file71.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file71.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file71.typ = testData2;
      print(data_restor.file71.typ);
      expect(data_restor.file71.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file71.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file71.typ = defalut;
      print(data_restor.file71.typ);
      expect(data_restor.file71.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file71.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file71.name;
      print(data_restor.file71.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file71.name = testData1s;
      print(data_restor.file71.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file71.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file71.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file71.name = testData2s;
      print(data_restor.file71.name);
      expect(data_restor.file71.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file71.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file71.name = defalut;
      print(data_restor.file71.name);
      expect(data_restor.file71.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file71.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file71.src;
      print(data_restor.file71.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file71.src = testData1s;
      print(data_restor.file71.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file71.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file71.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file71.src = testData2s;
      print(data_restor.file71.src);
      expect(data_restor.file71.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file71.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file71.src = defalut;
      print(data_restor.file71.src);
      expect(data_restor.file71.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file71.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file72.typ;
      print(data_restor.file72.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file72.typ = testData1;
      print(data_restor.file72.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file72.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file72.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file72.typ = testData2;
      print(data_restor.file72.typ);
      expect(data_restor.file72.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file72.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file72.typ = defalut;
      print(data_restor.file72.typ);
      expect(data_restor.file72.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file72.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file72.name;
      print(data_restor.file72.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file72.name = testData1s;
      print(data_restor.file72.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file72.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file72.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file72.name = testData2s;
      print(data_restor.file72.name);
      expect(data_restor.file72.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file72.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file72.name = defalut;
      print(data_restor.file72.name);
      expect(data_restor.file72.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file72.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file72.src;
      print(data_restor.file72.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file72.src = testData1s;
      print(data_restor.file72.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file72.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file72.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file72.src = testData2s;
      print(data_restor.file72.src);
      expect(data_restor.file72.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file72.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file72.src = defalut;
      print(data_restor.file72.src);
      expect(data_restor.file72.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file72.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file73.typ;
      print(data_restor.file73.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file73.typ = testData1;
      print(data_restor.file73.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file73.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file73.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file73.typ = testData2;
      print(data_restor.file73.typ);
      expect(data_restor.file73.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file73.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file73.typ = defalut;
      print(data_restor.file73.typ);
      expect(data_restor.file73.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file73.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file73.name;
      print(data_restor.file73.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file73.name = testData1s;
      print(data_restor.file73.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file73.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file73.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file73.name = testData2s;
      print(data_restor.file73.name);
      expect(data_restor.file73.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file73.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file73.name = defalut;
      print(data_restor.file73.name);
      expect(data_restor.file73.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file73.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

    test('00242_element_check_00219', () async {
      print("\n********** テスト実行：00242_element_check_00219 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file73.src;
      print(data_restor.file73.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file73.src = testData1s;
      print(data_restor.file73.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file73.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file73.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file73.src = testData2s;
      print(data_restor.file73.src);
      expect(data_restor.file73.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file73.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file73.src = defalut;
      print(data_restor.file73.src);
      expect(data_restor.file73.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file73.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00242_element_check_00219 **********\n\n");
    });

    test('00243_element_check_00220', () async {
      print("\n********** テスト実行：00243_element_check_00220 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file74.typ;
      print(data_restor.file74.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file74.typ = testData1;
      print(data_restor.file74.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file74.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file74.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file74.typ = testData2;
      print(data_restor.file74.typ);
      expect(data_restor.file74.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file74.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file74.typ = defalut;
      print(data_restor.file74.typ);
      expect(data_restor.file74.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file74.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00243_element_check_00220 **********\n\n");
    });

    test('00244_element_check_00221', () async {
      print("\n********** テスト実行：00244_element_check_00221 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file74.name;
      print(data_restor.file74.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file74.name = testData1s;
      print(data_restor.file74.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file74.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file74.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file74.name = testData2s;
      print(data_restor.file74.name);
      expect(data_restor.file74.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file74.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file74.name = defalut;
      print(data_restor.file74.name);
      expect(data_restor.file74.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file74.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00244_element_check_00221 **********\n\n");
    });

    test('00245_element_check_00222', () async {
      print("\n********** テスト実行：00245_element_check_00222 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file74.src;
      print(data_restor.file74.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file74.src = testData1s;
      print(data_restor.file74.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file74.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file74.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file74.src = testData2s;
      print(data_restor.file74.src);
      expect(data_restor.file74.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file74.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file74.src = defalut;
      print(data_restor.file74.src);
      expect(data_restor.file74.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file74.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00245_element_check_00222 **********\n\n");
    });

    test('00246_element_check_00223', () async {
      print("\n********** テスト実行：00246_element_check_00223 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file75.typ;
      print(data_restor.file75.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file75.typ = testData1;
      print(data_restor.file75.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file75.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file75.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file75.typ = testData2;
      print(data_restor.file75.typ);
      expect(data_restor.file75.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file75.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file75.typ = defalut;
      print(data_restor.file75.typ);
      expect(data_restor.file75.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file75.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00246_element_check_00223 **********\n\n");
    });

    test('00247_element_check_00224', () async {
      print("\n********** テスト実行：00247_element_check_00224 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file75.name;
      print(data_restor.file75.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file75.name = testData1s;
      print(data_restor.file75.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file75.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file75.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file75.name = testData2s;
      print(data_restor.file75.name);
      expect(data_restor.file75.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file75.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file75.name = defalut;
      print(data_restor.file75.name);
      expect(data_restor.file75.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file75.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00247_element_check_00224 **********\n\n");
    });

    test('00248_element_check_00225', () async {
      print("\n********** テスト実行：00248_element_check_00225 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file75.src;
      print(data_restor.file75.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file75.src = testData1s;
      print(data_restor.file75.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file75.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file75.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file75.src = testData2s;
      print(data_restor.file75.src);
      expect(data_restor.file75.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file75.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file75.src = defalut;
      print(data_restor.file75.src);
      expect(data_restor.file75.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file75.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00248_element_check_00225 **********\n\n");
    });

    test('00249_element_check_00226', () async {
      print("\n********** テスト実行：00249_element_check_00226 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file76.typ;
      print(data_restor.file76.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file76.typ = testData1;
      print(data_restor.file76.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file76.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file76.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file76.typ = testData2;
      print(data_restor.file76.typ);
      expect(data_restor.file76.typ == testData2, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file76.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file76.typ = defalut;
      print(data_restor.file76.typ);
      expect(data_restor.file76.typ == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file76.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00249_element_check_00226 **********\n\n");
    });

    test('00250_element_check_00227', () async {
      print("\n********** テスト実行：00250_element_check_00227 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file76.name;
      print(data_restor.file76.name);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file76.name = testData1s;
      print(data_restor.file76.name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file76.name == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file76.name == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file76.name = testData2s;
      print(data_restor.file76.name);
      expect(data_restor.file76.name == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file76.name == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file76.name = defalut;
      print(data_restor.file76.name);
      expect(data_restor.file76.name == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file76.name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00250_element_check_00227 **********\n\n");
    });

    test('00251_element_check_00228', () async {
      print("\n********** テスト実行：00251_element_check_00228 **********");

      data_restor = Data_restorJsonFile();
      allPropatyCheckInit(data_restor);

      // ①loadを実行する。
      await data_restor.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = data_restor.file76.src;
      print(data_restor.file76.src);

      // ②指定したプロパティにテストデータ1を書き込む。
      data_restor.file76.src = testData1s;
      print(data_restor.file76.src);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(data_restor.file76.src == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await data_restor.save();
      await data_restor.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(data_restor.file76.src == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      data_restor.file76.src = testData2s;
      print(data_restor.file76.src);
      expect(data_restor.file76.src == testData2s, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file76.src == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      data_restor.file76.src = defalut;
      print(data_restor.file76.src);
      expect(data_restor.file76.src == defalut, true);
      await data_restor.save();
      await data_restor.load();
      expect(data_restor.file76.src == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(data_restor, true);

      print("********** テスト終了：00251_element_check_00228 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Data_restorJsonFile test)
{
  expect(test.file01.typ, 0);
  expect(test.file01.name, "");
  expect(test.file01.src, "");
  expect(test.file02.typ, 0);
  expect(test.file02.name, "");
  expect(test.file02.src, "");
  expect(test.file03.typ, 0);
  expect(test.file03.name, "");
  expect(test.file03.src, "");
  expect(test.file04.typ, 0);
  expect(test.file04.name, "");
  expect(test.file04.src, "");
  expect(test.file05.typ, 0);
  expect(test.file05.name, "");
  expect(test.file05.src, "");
  expect(test.file06.typ, 0);
  expect(test.file06.name, "");
  expect(test.file06.src, "");
  expect(test.file07.typ, 0);
  expect(test.file07.name, "");
  expect(test.file07.src, "");
  expect(test.file08.typ, 0);
  expect(test.file08.name, "");
  expect(test.file08.src, "");
  expect(test.file09.typ, 0);
  expect(test.file09.name, "");
  expect(test.file09.src, "");
  expect(test.file10.typ, 0);
  expect(test.file10.name, "");
  expect(test.file10.src, "");
  expect(test.file11.typ, 0);
  expect(test.file11.name, "");
  expect(test.file11.src, "");
  expect(test.file12.typ, 0);
  expect(test.file12.name, "");
  expect(test.file12.src, "");
  expect(test.file13.typ, 0);
  expect(test.file13.name, "");
  expect(test.file13.src, "");
  expect(test.file14.typ, 0);
  expect(test.file14.name, "");
  expect(test.file14.src, "");
  expect(test.file15.typ, 0);
  expect(test.file15.name, "");
  expect(test.file15.src, "");
  expect(test.file16.typ, 0);
  expect(test.file16.name, "");
  expect(test.file16.src, "");
  expect(test.file17.typ, 0);
  expect(test.file17.name, "");
  expect(test.file17.src, "");
  expect(test.file18.typ, 0);
  expect(test.file18.name, "");
  expect(test.file18.src, "");
  expect(test.file19.typ, 0);
  expect(test.file19.name, "");
  expect(test.file19.src, "");
  expect(test.file20.typ, 0);
  expect(test.file20.name, "");
  expect(test.file20.src, "");
  expect(test.file21.typ, 0);
  expect(test.file21.name, "");
  expect(test.file21.src, "");
  expect(test.file22.typ, 0);
  expect(test.file22.name, "");
  expect(test.file22.src, "");
  expect(test.file23.typ, 0);
  expect(test.file23.name, "");
  expect(test.file23.src, "");
  expect(test.file24.typ, 0);
  expect(test.file24.name, "");
  expect(test.file24.src, "");
  expect(test.file25.typ, 0);
  expect(test.file25.name, "");
  expect(test.file25.src, "");
  expect(test.file26.typ, 0);
  expect(test.file26.name, "");
  expect(test.file26.src, "");
  expect(test.file27.typ, 0);
  expect(test.file27.name, "");
  expect(test.file27.src, "");
  expect(test.file28.typ, 0);
  expect(test.file28.name, "");
  expect(test.file28.src, "");
  expect(test.file29.typ, 0);
  expect(test.file29.name, "");
  expect(test.file29.src, "");
  expect(test.file30.typ, 0);
  expect(test.file30.name, "");
  expect(test.file30.src, "");
  expect(test.file31.typ, 0);
  expect(test.file31.name, "");
  expect(test.file31.src, "");
  expect(test.file32.typ, 0);
  expect(test.file32.name, "");
  expect(test.file32.src, "");
  expect(test.file33.typ, 0);
  expect(test.file33.name, "");
  expect(test.file33.src, "");
  expect(test.file34.typ, 0);
  expect(test.file34.name, "");
  expect(test.file34.src, "");
  expect(test.file35.typ, 0);
  expect(test.file35.name, "");
  expect(test.file35.src, "");
  expect(test.file36.typ, 0);
  expect(test.file36.name, "");
  expect(test.file36.src, "");
  expect(test.file37.typ, 0);
  expect(test.file37.name, "");
  expect(test.file37.src, "");
  expect(test.file38.typ, 0);
  expect(test.file38.name, "");
  expect(test.file38.src, "");
  expect(test.file39.typ, 0);
  expect(test.file39.name, "");
  expect(test.file39.src, "");
  expect(test.file40.typ, 0);
  expect(test.file40.name, "");
  expect(test.file40.src, "");
  expect(test.file41.typ, 0);
  expect(test.file41.name, "");
  expect(test.file41.src, "");
  expect(test.file42.typ, 0);
  expect(test.file42.name, "");
  expect(test.file42.src, "");
  expect(test.file43.typ, 0);
  expect(test.file43.name, "");
  expect(test.file43.src, "");
  expect(test.file44.typ, 0);
  expect(test.file44.name, "");
  expect(test.file44.src, "");
  expect(test.file45.typ, 0);
  expect(test.file45.name, "");
  expect(test.file45.src, "");
  expect(test.file46.typ, 0);
  expect(test.file46.name, "");
  expect(test.file46.src, "");
  expect(test.file47.typ, 0);
  expect(test.file47.name, "");
  expect(test.file47.src, "");
  expect(test.file48.typ, 0);
  expect(test.file48.name, "");
  expect(test.file48.src, "");
  expect(test.file49.typ, 0);
  expect(test.file49.name, "");
  expect(test.file49.src, "");
  expect(test.file50.typ, 0);
  expect(test.file50.name, "");
  expect(test.file50.src, "");
  expect(test.file51.typ, 0);
  expect(test.file51.name, "");
  expect(test.file51.src, "");
  expect(test.file52.typ, 0);
  expect(test.file52.name, "");
  expect(test.file52.src, "");
  expect(test.file53.typ, 0);
  expect(test.file53.name, "");
  expect(test.file53.src, "");
  expect(test.file54.typ, 0);
  expect(test.file54.name, "");
  expect(test.file54.src, "");
  expect(test.file55.typ, 0);
  expect(test.file55.name, "");
  expect(test.file55.src, "");
  expect(test.file56.typ, 0);
  expect(test.file56.name, "");
  expect(test.file56.src, "");
  expect(test.file57.typ, 0);
  expect(test.file57.name, "");
  expect(test.file57.src, "");
  expect(test.file58.typ, 0);
  expect(test.file58.name, "");
  expect(test.file58.src, "");
  expect(test.file59.typ, 0);
  expect(test.file59.name, "");
  expect(test.file59.src, "");
  expect(test.file60.typ, 0);
  expect(test.file60.name, "");
  expect(test.file60.src, "");
  expect(test.file61.typ, 0);
  expect(test.file61.name, "");
  expect(test.file61.src, "");
  expect(test.file62.typ, 0);
  expect(test.file62.name, "");
  expect(test.file62.src, "");
  expect(test.file63.typ, 0);
  expect(test.file63.name, "");
  expect(test.file63.src, "");
  expect(test.file64.typ, 0);
  expect(test.file64.name, "");
  expect(test.file64.src, "");
  expect(test.file65.typ, 0);
  expect(test.file65.name, "");
  expect(test.file65.src, "");
  expect(test.file66.typ, 0);
  expect(test.file66.name, "");
  expect(test.file66.src, "");
  expect(test.file67.typ, 0);
  expect(test.file67.name, "");
  expect(test.file67.src, "");
  expect(test.file68.typ, 0);
  expect(test.file68.name, "");
  expect(test.file68.src, "");
  expect(test.file69.typ, 0);
  expect(test.file69.name, "");
  expect(test.file69.src, "");
  expect(test.file70.typ, 0);
  expect(test.file70.name, "");
  expect(test.file70.src, "");
  expect(test.file71.typ, 0);
  expect(test.file71.name, "");
  expect(test.file71.src, "");
  expect(test.file72.typ, 0);
  expect(test.file72.name, "");
  expect(test.file72.src, "");
  expect(test.file73.typ, 0);
  expect(test.file73.name, "");
  expect(test.file73.src, "");
  expect(test.file74.typ, 0);
  expect(test.file74.name, "");
  expect(test.file74.src, "");
  expect(test.file75.typ, 0);
  expect(test.file75.name, "");
  expect(test.file75.src, "");
  expect(test.file76.typ, 0);
  expect(test.file76.name, "");
  expect(test.file76.src, "");
}

void allPropatyCheck(Data_restorJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.file01.typ, 40);
  }
  expect(test.file01.name, "hosts");
  expect(test.file01.src, "/etc/hosts");
  expect(test.file02.typ, 40);
  expect(test.file02.name, "custom.conf");
  expect(test.file02.src, "conf/custom.conf");
  expect(test.file03.typ, 40);
  expect(test.file03.name, "postgresql.conf");
  expect(test.file03.src, "conf/postgresql.conf");
  expect(test.file04.typ, 41);
  expect(test.file04.name, "レジのロゴ１");
  expect(test.file04.src, "/web21ftp/bmp");
  expect(test.file05.typ, 41);
  expect(test.file05.name, "レジのロゴ２");
  expect(test.file05.src, "bmp/rct");
  expect(test.file06.typ, 40);
  expect(test.file06.name, "freetds.conf");
  expect(test.file06.src, "tool/odbc/freetds.conf");
  expect(test.file07.typ, 40);
  expect(test.file07.name, "odbc.json");
  expect(test.file07.src, "tool/odbc/odbc.json");
  expect(test.file08.typ, 40);
  expect(test.file08.name, "freetds.conf");
  expect(test.file08.src, "/usr/local/etc/freetds.conf");
  expect(test.file09.typ, 40);
  expect(test.file09.name, "odbc.json");
  expect(test.file09.src, "/usr/local/etc/odbc.json");
  expect(test.file10.typ, 40);
  expect(test.file10.name, "logrotate.conf");
  expect(test.file10.src, "/etc/logrotate.conf");
  expect(test.file11.typ, 40);
  expect(test.file11.name, "snmpd.conf");
  expect(test.file11.src, "/etc/snmp/snmpd.conf");
  expect(test.file12.typ, 40);
  expect(test.file12.name, "syslog.conf");
  expect(test.file12.src, "/etc/syslog.conf");
  expect(test.file13.typ, 40);
  expect(test.file13.name, "services");
  expect(test.file13.src, "/etc/services");
  expect(test.file14.typ, 40);
  expect(test.file14.name, "csvbkup.json");
  expect(test.file14.src, "conf/csvbkup.json");
  expect(test.file15.typ, 40);
  expect(test.file15.name, "taxchg_reserve.json");
  expect(test.file15.src, "conf/taxchg_reserve.json");
  expect(test.file16.typ, 40);
  expect(test.file16.name, "sprocket_prn.json");
  expect(test.file16.src, "conf/sprocket_prn.json");
  expect(test.file17.typ, 40);
  expect(test.file17.name, "acr.json");
  expect(test.file17.src, "conf/acr.json");
  expect(test.file18.typ, 40);
  expect(test.file18.name, "acb.json");
  expect(test.file18.src, "conf/acb.json");
  expect(test.file19.typ, 40);
  expect(test.file19.name, "acb20.json");
  expect(test.file19.src, "conf/acb20.json");
  expect(test.file20.typ, 40);
  expect(test.file20.name, "rewrite_card.json");
  expect(test.file20.src, "conf/rewrite_card.json");
  expect(test.file21.typ, 40);
  expect(test.file21.name, "vismac.json");
  expect(test.file21.src, "conf/vismac.json");
  expect(test.file22.typ, 40);
  expect(test.file22.name, "pana_gcat.json");
  expect(test.file22.src, "conf/pana_gcat.json");
  expect(test.file23.typ, 40);
  expect(test.file23.name, "j_debit.json");
  expect(test.file23.src, "conf/j_debit.json");
  expect(test.file24.typ, 40);
  expect(test.file24.name, "scale.json");
  expect(test.file24.src, "conf/scale.json");
  expect(test.file25.typ, 40);
  expect(test.file25.name, "orc.json");
  expect(test.file25.src, "conf/orc.json");
  expect(test.file26.typ, 40);
  expect(test.file26.name, "sg_scale1.json");
  expect(test.file26.src, "conf/sg_scale1.json");
  expect(test.file27.typ, 40);
  expect(test.file27.name, "sg_scale2.json");
  expect(test.file27.src, "conf/sg_scale2.json");
  expect(test.file28.typ, 40);
  expect(test.file28.name, "sm_scale1.json");
  expect(test.file28.src, "conf/sm_scale1.json");
  expect(test.file29.typ, 40);
  expect(test.file29.name, "sm_scale2.json");
  expect(test.file29.src, "conf/sm_scale2.json");
  expect(test.file30.typ, 40);
  expect(test.file30.name, "sip60.json");
  expect(test.file30.src, "conf/sip60.json");
  expect(test.file31.typ, 40);
  expect(test.file31.name, "psp60.json");
  expect(test.file31.src, "conf/psp60.json");
  expect(test.file32.typ, 40);
  expect(test.file32.name, "stpr.json");
  expect(test.file32.src, "conf/stpr.json");
  expect(test.file33.typ, 40);
  expect(test.file33.name, "pana.json");
  expect(test.file33.src, "conf/pana.json");
  expect(test.file34.typ, 40);
  expect(test.file34.name, "gp.json");
  expect(test.file34.src, "conf/gp.json");
  expect(test.file35.typ, 40);
  expect(test.file35.name, "sm_scalesc.json");
  expect(test.file35.src, "conf/sm_scalesc.json");
  expect(test.file36.typ, 40);
  expect(test.file36.name, "sm_scalesc_scl.json");
  expect(test.file36.src, "conf/sm_scalesc_scl.json");
  expect(test.file37.typ, 40);
  expect(test.file37.name, "sm_scalesc_signp.json");
  expect(test.file37.src, "conf/sm_scalesc_signp.json");
  expect(test.file38.typ, 40);
  expect(test.file38.name, "s2pr.json");
  expect(test.file38.src, "conf/s2pr.json");
  expect(test.file39.typ, 40);
  expect(test.file39.name, "acb50.json");
  expect(test.file39.src, "conf/acb50.json");
  expect(test.file40.typ, 40);
  expect(test.file40.name, "pwrctrl.json");
  expect(test.file40.src, "conf/pwrctrl.json");
  expect(test.file41.typ, 40);
  expect(test.file41.name, "pw410.json");
  expect(test.file41.src, "conf/pw410.json");
  expect(test.file42.typ, 40);
  expect(test.file42.name, "ccr.json");
  expect(test.file42.src, "conf/ccr.json");
  expect(test.file43.typ, 40);
  expect(test.file43.name, "psp70.json");
  expect(test.file43.src, "conf/psp70.json");
  expect(test.file44.typ, 40);
  expect(test.file44.name, "dish.json");
  expect(test.file44.src, "conf/dish.json");
  expect(test.file45.typ, 40);
  expect(test.file45.name, "aiv.json");
  expect(test.file45.src, "conf/aiv.json");
  expect(test.file46.typ, 40);
  expect(test.file46.name, "ar_stts_01.json");
  expect(test.file46.src, "conf/ar_stts_01.json");
  expect(test.file47.typ, 40);
  expect(test.file47.name, "gcat_cnct.json");
  expect(test.file47.src, "conf/gcat_cnct.json");
  expect(test.file48.typ, 40);
  expect(test.file48.name, "yomoca.json");
  expect(test.file48.src, "conf/yomoca.json");
  expect(test.file49.typ, 40);
  expect(test.file49.name, "smtplus.json");
  expect(test.file49.src, "conf/smtplus.json");
  expect(test.file50.typ, 40);
  expect(test.file50.name, "suica_cnct.json");
  expect(test.file50.src, "conf/suica_cnct.json");
  expect(test.file51.typ, 40);
  expect(test.file51.name, "rfid.json");
  expect(test.file51.src, "conf/rfid.json");
  expect(test.file52.typ, 40);
  expect(test.file52.name, "disht.json");
  expect(test.file52.src, "conf/disht.json");
  expect(test.file53.typ, 40);
  expect(test.file53.name, "mcp200.json");
  expect(test.file53.src, "conf/mcp200.json");
  expect(test.file54.typ, 40);
  expect(test.file54.name, "fcl.json");
  expect(test.file54.src, "conf/fcl.json");
  expect(test.file55.typ, 40);
  expect(test.file55.name, "jrw_multi.json");
  expect(test.file55.src, "conf/jrw_multi.json");
  expect(test.file56.typ, 40);
  expect(test.file56.name, "ht2980.json");
  expect(test.file56.src, "conf/ht2980.json");
  expect(test.file57.typ, 40);
  expect(test.file57.name, "absv31.json");
  expect(test.file57.src, "conf/absv31.json");
  expect(test.file58.typ, 40);
  expect(test.file58.name, "yamato.json");
  expect(test.file58.src, "conf/yamato.json");
  expect(test.file59.typ, 40);
  expect(test.file59.name, "cct.json");
  expect(test.file59.src, "conf/cct.json");
  expect(test.file60.typ, 40);
  expect(test.file60.name, "usbcam.json");
  expect(test.file60.src, "conf/usbcam.json");
  expect(test.file61.typ, 40);
  expect(test.file61.name, "masr.json");
  expect(test.file61.src, "conf/masr.json");
  expect(test.file62.typ, 40);
  expect(test.file62.name, "jmups.json");
  expect(test.file62.src, "conf/jmups.json");
  expect(test.file63.typ, 40);
  expect(test.file63.name, "fal2.json");
  expect(test.file63.src, "conf/fal2.json");
  expect(test.file64.typ, 40);
  expect(test.file64.name, "sqrc_spec.json");
  expect(test.file64.src, "conf/sqrc_spec.json");
  expect(test.file65.typ, 40);
  expect(test.file65.name, "tprtrp.json");
  expect(test.file65.src, "conf/tprtrp.json");
  expect(test.file66.typ, 40);
  expect(test.file66.name, "iccard.json");
  expect(test.file66.src, "conf/iccard.json");
  expect(test.file67.typ, 40);
  expect(test.file67.name, "powli.json");
  expect(test.file67.src, "conf/powli.json");
  expect(test.file68.typ, 40);
  expect(test.file68.name, "printcap");
  expect(test.file68.src, "/etc/printcap");
  expect(test.file69.typ, 40);
  expect(test.file69.name, "resolv.conf");
  expect(test.file69.src, "/etc/resolv.conf");
  expect(test.file70.typ, 40);
  expect(test.file70.name, "network");
  expect(test.file70.src, "/etc/sysconfig/network");
  expect(test.file71.typ, 40);
  expect(test.file71.name, "ifcfg-eth0");
  expect(test.file71.src, "/etc/sysconfig/network-scripts/ifcfg-eth0");
  expect(test.file72.typ, 40);
  expect(test.file72.name, "ifcfg-enp1s0");
  expect(test.file72.src, "/etc/sysconfig/network-scripts/ifcfg-enp1s0");
  expect(test.file73.typ, 40);
  expect(test.file73.name, "openvpn.conf");
  expect(test.file73.src, "/etc/openvpn/openvpn.conf");
  expect(test.file74.typ, 40);
  expect(test.file74.name, "vega3000.json");
  expect(test.file74.src, "conf/vega3000.json");
  expect(test.file75.typ, 40);
  expect(test.file75.name, "route-eth0");
  expect(test.file75.src, "/etc/sysconfig/network-scripts/route-eth0");
  expect(test.file76.typ, 40);
  expect(test.file76.name, "rfid_utr.json");
  expect(test.file76.src, "conf/rfid_utr.json");
}
