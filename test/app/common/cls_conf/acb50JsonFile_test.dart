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
import '../../../../lib/app/common/cls_conf/acb50JsonFile.dart';

late Acb50JsonFile acb50;

void main(){
  acb50JsonFile_test();
}

void acb50JsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "acb50.json";
  const String section = "settings";
  const String key = "port";
  const defaultData = "com1";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Acb50JsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Acb50JsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Acb50JsonFile().setDefault();
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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await acb50.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(acb50,true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        acb50.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await acb50.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(acb50,true);

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
      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①：loadを実行する。
      await acb50.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = acb50.settings.port;
      acb50.settings.port = testData1s;
      expect(acb50.settings.port == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await acb50.load();
      expect(acb50.settings.port != testData1s, true);
      expect(acb50.settings.port == prefixData, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = acb50.settings.port;
      acb50.settings.port = testData1s;
      expect(acb50.settings.port, testData1s);

      // ③saveを実行する。
      await acb50.save();

      // ④loadを実行する。
      await acb50.load();

      expect(acb50.settings.port != prefixData, true);
      expect(acb50.settings.port == testData1s, true);
      allPropatyCheck(acb50,false);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await acb50.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await acb50.save();

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await acb50.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(acb50.settings.port, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = acb50.settings.port;
      acb50.settings.port = testData1s;

      // ③ saveを実行する。
      await acb50.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(acb50.settings.port, testData1s);

      // ④ loadを実行する。
      await acb50.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(acb50.settings.port == testData1s, true);
      allPropatyCheck(acb50,false);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await acb50.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(acb50,true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②任意のプロパティの値を変更する。
      acb50.settings.port = testData1s;
      expect(acb50.settings.port, testData1s);

      // ③saveを実行する。
      await acb50.save();
      expect(acb50.settings.port, testData1s);

      // ④loadを実行する。
      await acb50.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(acb50,true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await acb50.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await acb50.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(acb50.settings.port == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await acb50.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await acb50.setValueWithName(section, "test_key", testData1s);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②任意のプロパティを変更する。
      acb50.settings.port = testData1s;

      // ③saveを実行する。
      await acb50.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await acb50.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②任意のプロパティを変更する。
      acb50.settings.port = testData1s;

      // ③saveを実行する。
      await acb50.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await acb50.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②任意のプロパティを変更する。
      acb50.settings.port = testData1s;

      // ③saveを実行する。
      await acb50.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await acb50.getValueWithName(section, "test_key");
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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await acb50.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      acb50.settings.port = testData1s;
      expect(acb50.settings.port, testData1s);

      // ④saveを実行する。
      await acb50.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(acb50.settings.port, testData1s);
      
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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await acb50.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      expect(acb50.settings.port == testData1s, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await acb50.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      expect(acb50.settings.port == testData2s, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await acb50.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      expect(acb50.settings.port == testData1s, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await acb50.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      expect(acb50.settings.port == testData2s, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await acb50.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      expect(acb50.settings.port == testData1s, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await acb50.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      expect(acb50.settings.port == testData1s, true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await acb50.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      allPropatyCheck(acb50,true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await acb50.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + acb50.settings.port.toString());
      allPropatyCheck(acb50,true);

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

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.port;
      print(acb50.settings.port);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.port = testData1s;
      print(acb50.settings.port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.port == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.port == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.port = testData2s;
      print(acb50.settings.port);
      expect(acb50.settings.port == testData2s, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.port == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.port = defalut;
      print(acb50.settings.port);
      expect(acb50.settings.port == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.baudrate;
      print(acb50.settings.baudrate);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.baudrate = testData1;
      print(acb50.settings.baudrate);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.baudrate == testData1, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.baudrate == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.baudrate = testData2;
      print(acb50.settings.baudrate);
      expect(acb50.settings.baudrate == testData2, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.baudrate == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.baudrate = defalut;
      print(acb50.settings.baudrate);
      expect(acb50.settings.baudrate == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.baudrate == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.databit;
      print(acb50.settings.databit);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.databit = testData1;
      print(acb50.settings.databit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.databit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.databit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.databit = testData2;
      print(acb50.settings.databit);
      expect(acb50.settings.databit == testData2, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.databit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.databit = defalut;
      print(acb50.settings.databit);
      expect(acb50.settings.databit == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.databit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.startbit;
      print(acb50.settings.startbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.startbit = testData1;
      print(acb50.settings.startbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.startbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.startbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.startbit = testData2;
      print(acb50.settings.startbit);
      expect(acb50.settings.startbit == testData2, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.startbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.startbit = defalut;
      print(acb50.settings.startbit);
      expect(acb50.settings.startbit == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.startbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.stopbit;
      print(acb50.settings.stopbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.stopbit = testData1;
      print(acb50.settings.stopbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.stopbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.stopbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.stopbit = testData2;
      print(acb50.settings.stopbit);
      expect(acb50.settings.stopbit == testData2, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.stopbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.stopbit = defalut;
      print(acb50.settings.stopbit);
      expect(acb50.settings.stopbit == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.stopbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.parity;
      print(acb50.settings.parity);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.parity = testData1s;
      print(acb50.settings.parity);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.parity == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.parity == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.parity = testData2s;
      print(acb50.settings.parity);
      expect(acb50.settings.parity == testData2s, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.parity == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.parity = defalut;
      print(acb50.settings.parity);
      expect(acb50.settings.parity == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.parity == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      acb50 = Acb50JsonFile();
      allPropatyCheckInit(acb50);

      // ①loadを実行する。
      await acb50.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = acb50.settings.bill;
      print(acb50.settings.bill);

      // ②指定したプロパティにテストデータ1を書き込む。
      acb50.settings.bill = testData1s;
      print(acb50.settings.bill);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(acb50.settings.bill == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await acb50.save();
      await acb50.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(acb50.settings.bill == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      acb50.settings.bill = testData2s;
      print(acb50.settings.bill);
      expect(acb50.settings.bill == testData2s, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.bill == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      acb50.settings.bill = defalut;
      print(acb50.settings.bill);
      expect(acb50.settings.bill == defalut, true);
      await acb50.save();
      await acb50.load();
      expect(acb50.settings.bill == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(acb50, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Acb50JsonFile test)
{
  expect(test.settings.port, "");
  expect(test.settings.baudrate, 0);
  expect(test.settings.databit, 0);
  expect(test.settings.startbit, 0);
  expect(test.settings.stopbit, 0);
  expect(test.settings.parity, "");
  expect(test.settings.bill, "");
}

void allPropatyCheck(Acb50JsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.settings.port, "com1");
  }
  expect(test.settings.baudrate, 2400);
  expect(test.settings.databit, 7);
  expect(test.settings.startbit, 1);
  expect(test.settings.stopbit, 1);
  expect(test.settings.parity, "even");
  expect(test.settings.bill, "no");
}
