/*
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
import '../../../../lib/app/common/cls_conf/scale_sksJsonFile.dart';

late Scale_sksJsonFile scale_sks;

void main(){
  scale_sksJsonFile_test();
}

void scale_sksJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "scale_sks.json";
  const String section = "settings";
  const String key = "port";
  const defaultData = "";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Scale_sksJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Scale_sksJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Scale_sksJsonFile().setDefault();
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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await scale_sks.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(scale_sks,true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        scale_sks.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await scale_sks.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(scale_sks,true);

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
      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①：loadを実行する。
      await scale_sks.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = scale_sks.settings.port;
      scale_sks.settings.port = testData1s;
      expect(scale_sks.settings.port == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await scale_sks.load();
      expect(scale_sks.settings.port != testData1s, true);
      expect(scale_sks.settings.port == prefixData, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = scale_sks.settings.port;
      scale_sks.settings.port = testData1s;
      expect(scale_sks.settings.port, testData1s);

      // ③saveを実行する。
      await scale_sks.save();

      // ④loadを実行する。
      await scale_sks.load();

      expect(scale_sks.settings.port != prefixData, true);
      expect(scale_sks.settings.port == testData1s, true);
      allPropatyCheck(scale_sks,false);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await scale_sks.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await scale_sks.save();

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await scale_sks.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(scale_sks.settings.port, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = scale_sks.settings.port;
      scale_sks.settings.port = testData1s;

      // ③ saveを実行する。
      await scale_sks.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(scale_sks.settings.port, testData1s);

      // ④ loadを実行する。
      await scale_sks.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(scale_sks.settings.port == testData1s, true);
      allPropatyCheck(scale_sks,false);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await scale_sks.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(scale_sks,true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②任意のプロパティの値を変更する。
      scale_sks.settings.port = testData1s;
      expect(scale_sks.settings.port, testData1s);

      // ③saveを実行する。
      await scale_sks.save();
      expect(scale_sks.settings.port, testData1s);

      // ④loadを実行する。
      await scale_sks.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(scale_sks,true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await scale_sks.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await scale_sks.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(scale_sks.settings.port == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await scale_sks.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await scale_sks.setValueWithName(section, "test_key", testData1s);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②任意のプロパティを変更する。
      scale_sks.settings.port = testData1s;

      // ③saveを実行する。
      await scale_sks.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await scale_sks.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②任意のプロパティを変更する。
      scale_sks.settings.port = testData1s;

      // ③saveを実行する。
      await scale_sks.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await scale_sks.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②任意のプロパティを変更する。
      scale_sks.settings.port = testData1s;

      // ③saveを実行する。
      await scale_sks.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await scale_sks.getValueWithName(section, "test_key");
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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await scale_sks.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      scale_sks.settings.port = testData1s;
      expect(scale_sks.settings.port, testData1s);

      // ④saveを実行する。
      await scale_sks.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(scale_sks.settings.port, testData1s);
      
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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await scale_sks.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      expect(scale_sks.settings.port == testData1s, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await scale_sks.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      expect(scale_sks.settings.port == testData2s, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await scale_sks.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      expect(scale_sks.settings.port == testData1s, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await scale_sks.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      expect(scale_sks.settings.port == testData2s, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await scale_sks.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      expect(scale_sks.settings.port == testData1s, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await scale_sks.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      expect(scale_sks.settings.port == testData1s, true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await scale_sks.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      allPropatyCheck(scale_sks,true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await scale_sks.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + scale_sks.settings.port.toString());
      allPropatyCheck(scale_sks,true);

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

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.port;
      print(scale_sks.settings.port);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.port = testData1s;
      print(scale_sks.settings.port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.port == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.port == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.port = testData2s;
      print(scale_sks.settings.port);
      expect(scale_sks.settings.port == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.port == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.port = defalut;
      print(scale_sks.settings.port);
      expect(scale_sks.settings.port == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.baudrate;
      print(scale_sks.settings.baudrate);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.baudrate = testData1;
      print(scale_sks.settings.baudrate);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.baudrate == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.baudrate == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.baudrate = testData2;
      print(scale_sks.settings.baudrate);
      expect(scale_sks.settings.baudrate == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.baudrate == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.baudrate = defalut;
      print(scale_sks.settings.baudrate);
      expect(scale_sks.settings.baudrate == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.baudrate == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.databit;
      print(scale_sks.settings.databit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.databit = testData1;
      print(scale_sks.settings.databit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.databit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.databit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.databit = testData2;
      print(scale_sks.settings.databit);
      expect(scale_sks.settings.databit == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.databit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.databit = defalut;
      print(scale_sks.settings.databit);
      expect(scale_sks.settings.databit == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.databit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.startbit;
      print(scale_sks.settings.startbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.startbit = testData1;
      print(scale_sks.settings.startbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.startbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.startbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.startbit = testData2;
      print(scale_sks.settings.startbit);
      expect(scale_sks.settings.startbit == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.startbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.startbit = defalut;
      print(scale_sks.settings.startbit);
      expect(scale_sks.settings.startbit == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.startbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.stopbit;
      print(scale_sks.settings.stopbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.stopbit = testData1;
      print(scale_sks.settings.stopbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.stopbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.stopbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.stopbit = testData2;
      print(scale_sks.settings.stopbit);
      expect(scale_sks.settings.stopbit == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.stopbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.stopbit = defalut;
      print(scale_sks.settings.stopbit);
      expect(scale_sks.settings.stopbit == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.stopbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.parity;
      print(scale_sks.settings.parity);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.parity = testData1s;
      print(scale_sks.settings.parity);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.parity == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.parity == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.parity = testData2s;
      print(scale_sks.settings.parity);
      expect(scale_sks.settings.parity == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.parity == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.parity = defalut;
      print(scale_sks.settings.parity);
      expect(scale_sks.settings.parity == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.parity == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.bill;
      print(scale_sks.settings.bill);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.bill = testData1s;
      print(scale_sks.settings.bill);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.bill == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.bill == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.bill = testData2s;
      print(scale_sks.settings.bill);
      expect(scale_sks.settings.bill == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.bill == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.bill = defalut;
      print(scale_sks.settings.bill);
      expect(scale_sks.settings.bill == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.bill == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.id;
      print(scale_sks.settings.id);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.id = testData1;
      print(scale_sks.settings.id);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.id == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.id == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.id = testData2;
      print(scale_sks.settings.id);
      expect(scale_sks.settings.id == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.id == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.id = defalut;
      print(scale_sks.settings.id);
      expect(scale_sks.settings.id == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.id == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.collect_num;
      print(scale_sks.settings.collect_num);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.collect_num = testData1;
      print(scale_sks.settings.collect_num);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.collect_num == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.collect_num == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.collect_num = testData2;
      print(scale_sks.settings.collect_num);
      expect(scale_sks.settings.collect_num == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.collect_num == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.collect_num = defalut;
      print(scale_sks.settings.collect_num);
      expect(scale_sks.settings.collect_num == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.collect_num == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.span_switch;
      print(scale_sks.settings.span_switch);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.span_switch = testData1;
      print(scale_sks.settings.span_switch);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.span_switch == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.span_switch == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.span_switch = testData2;
      print(scale_sks.settings.span_switch);
      expect(scale_sks.settings.span_switch == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.span_switch == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.span_switch = defalut;
      print(scale_sks.settings.span_switch);
      expect(scale_sks.settings.span_switch == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.span_switch == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.protect_span_spec;
      print(scale_sks.settings.protect_span_spec);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.protect_span_spec = testData1;
      print(scale_sks.settings.protect_span_spec);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.protect_span_spec == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.protect_span_spec == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.protect_span_spec = testData2;
      print(scale_sks.settings.protect_span_spec);
      expect(scale_sks.settings.protect_span_spec == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.protect_span_spec == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.protect_span_spec = defalut;
      print(scale_sks.settings.protect_span_spec);
      expect(scale_sks.settings.protect_span_spec == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.protect_span_spec == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.protect_count;
      print(scale_sks.settings.protect_count);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.protect_count = testData1;
      print(scale_sks.settings.protect_count);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.protect_count == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.protect_count == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.protect_count = testData2;
      print(scale_sks.settings.protect_count);
      expect(scale_sks.settings.protect_count == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.protect_count == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.protect_count = defalut;
      print(scale_sks.settings.protect_count);
      expect(scale_sks.settings.protect_count == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.protect_count == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.protect_data;
      print(scale_sks.settings.protect_data);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.protect_data = testData1;
      print(scale_sks.settings.protect_data);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.protect_data == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.protect_data == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.protect_data = testData2;
      print(scale_sks.settings.protect_data);
      expect(scale_sks.settings.protect_data == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.protect_data == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.protect_data = defalut;
      print(scale_sks.settings.protect_data);
      expect(scale_sks.settings.protect_data == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.protect_data == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.data_auth;
      print(scale_sks.settings.data_auth);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.data_auth = testData1;
      print(scale_sks.settings.data_auth);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.data_auth == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.data_auth == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.data_auth = testData2;
      print(scale_sks.settings.data_auth);
      expect(scale_sks.settings.data_auth == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.data_auth == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.data_auth = defalut;
      print(scale_sks.settings.data_auth);
      expect(scale_sks.settings.data_auth == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.data_auth == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.decimal_point_shape;
      print(scale_sks.settings.decimal_point_shape);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.decimal_point_shape = testData1;
      print(scale_sks.settings.decimal_point_shape);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.decimal_point_shape == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.decimal_point_shape == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.decimal_point_shape = testData2;
      print(scale_sks.settings.decimal_point_shape);
      expect(scale_sks.settings.decimal_point_shape == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.decimal_point_shape == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.decimal_point_shape = defalut;
      print(scale_sks.settings.decimal_point_shape);
      expect(scale_sks.settings.decimal_point_shape == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.decimal_point_shape == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.decimal_point_pos;
      print(scale_sks.settings.decimal_point_pos);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.decimal_point_pos = testData1s;
      print(scale_sks.settings.decimal_point_pos);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.decimal_point_pos == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.decimal_point_pos == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.decimal_point_pos = testData2s;
      print(scale_sks.settings.decimal_point_pos);
      expect(scale_sks.settings.decimal_point_pos == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.decimal_point_pos == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.decimal_point_pos = defalut;
      print(scale_sks.settings.decimal_point_pos);
      expect(scale_sks.settings.decimal_point_pos == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.decimal_point_pos == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.tare_auto_clear;
      print(scale_sks.settings.tare_auto_clear);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.tare_auto_clear = testData1;
      print(scale_sks.settings.tare_auto_clear);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.tare_auto_clear == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.tare_auto_clear == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.tare_auto_clear = testData2;
      print(scale_sks.settings.tare_auto_clear);
      expect(scale_sks.settings.tare_auto_clear == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_auto_clear == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.tare_auto_clear = defalut;
      print(scale_sks.settings.tare_auto_clear);
      expect(scale_sks.settings.tare_auto_clear == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_auto_clear == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.preset_tare;
      print(scale_sks.settings.preset_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.preset_tare = testData1;
      print(scale_sks.settings.preset_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.preset_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.preset_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.preset_tare = testData2;
      print(scale_sks.settings.preset_tare);
      expect(scale_sks.settings.preset_tare == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.preset_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.preset_tare = defalut;
      print(scale_sks.settings.preset_tare);
      expect(scale_sks.settings.preset_tare == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.preset_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.digital_tare_subtraction;
      print(scale_sks.settings.digital_tare_subtraction);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.digital_tare_subtraction = testData1;
      print(scale_sks.settings.digital_tare_subtraction);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.digital_tare_subtraction == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.digital_tare_subtraction == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.digital_tare_subtraction = testData2;
      print(scale_sks.settings.digital_tare_subtraction);
      expect(scale_sks.settings.digital_tare_subtraction == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.digital_tare_subtraction == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.digital_tare_subtraction = defalut;
      print(scale_sks.settings.digital_tare_subtraction);
      expect(scale_sks.settings.digital_tare_subtraction == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.digital_tare_subtraction == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.digital_tare_addition;
      print(scale_sks.settings.digital_tare_addition);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.digital_tare_addition = testData1;
      print(scale_sks.settings.digital_tare_addition);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.digital_tare_addition == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.digital_tare_addition == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.digital_tare_addition = testData2;
      print(scale_sks.settings.digital_tare_addition);
      expect(scale_sks.settings.digital_tare_addition == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.digital_tare_addition == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.digital_tare_addition = defalut;
      print(scale_sks.settings.digital_tare_addition);
      expect(scale_sks.settings.digital_tare_addition == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.digital_tare_addition == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.digital_tare;
      print(scale_sks.settings.digital_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.digital_tare = testData1;
      print(scale_sks.settings.digital_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.digital_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.digital_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.digital_tare = testData2;
      print(scale_sks.settings.digital_tare);
      expect(scale_sks.settings.digital_tare == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.digital_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.digital_tare = defalut;
      print(scale_sks.settings.digital_tare);
      expect(scale_sks.settings.digital_tare == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.digital_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.onetouch_tare_subtraction;
      print(scale_sks.settings.onetouch_tare_subtraction);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.onetouch_tare_subtraction = testData1;
      print(scale_sks.settings.onetouch_tare_subtraction);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.onetouch_tare_subtraction == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.onetouch_tare_subtraction == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.onetouch_tare_subtraction = testData2;
      print(scale_sks.settings.onetouch_tare_subtraction);
      expect(scale_sks.settings.onetouch_tare_subtraction == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.onetouch_tare_subtraction == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.onetouch_tare_subtraction = defalut;
      print(scale_sks.settings.onetouch_tare_subtraction);
      expect(scale_sks.settings.onetouch_tare_subtraction == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.onetouch_tare_subtraction == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.onetouch_tare_addition;
      print(scale_sks.settings.onetouch_tare_addition);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.onetouch_tare_addition = testData1;
      print(scale_sks.settings.onetouch_tare_addition);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.onetouch_tare_addition == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.onetouch_tare_addition == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.onetouch_tare_addition = testData2;
      print(scale_sks.settings.onetouch_tare_addition);
      expect(scale_sks.settings.onetouch_tare_addition == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.onetouch_tare_addition == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.onetouch_tare_addition = defalut;
      print(scale_sks.settings.onetouch_tare_addition);
      expect(scale_sks.settings.onetouch_tare_addition == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.onetouch_tare_addition == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.tare_range;
      print(scale_sks.settings.tare_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.tare_range = testData1;
      print(scale_sks.settings.tare_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.tare_range == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.tare_range == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.tare_range = testData2;
      print(scale_sks.settings.tare_range);
      expect(scale_sks.settings.tare_range == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_range == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.tare_range = defalut;
      print(scale_sks.settings.tare_range);
      expect(scale_sks.settings.tare_range == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.priority_preset_digital;
      print(scale_sks.settings.priority_preset_digital);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.priority_preset_digital = testData1;
      print(scale_sks.settings.priority_preset_digital);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.priority_preset_digital == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.priority_preset_digital == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.priority_preset_digital = testData2;
      print(scale_sks.settings.priority_preset_digital);
      expect(scale_sks.settings.priority_preset_digital == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_preset_digital == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.priority_preset_digital = defalut;
      print(scale_sks.settings.priority_preset_digital);
      expect(scale_sks.settings.priority_preset_digital == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_preset_digital == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.priority_preset_onetouch;
      print(scale_sks.settings.priority_preset_onetouch);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.priority_preset_onetouch = testData1;
      print(scale_sks.settings.priority_preset_onetouch);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.priority_preset_onetouch == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.priority_preset_onetouch == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.priority_preset_onetouch = testData2;
      print(scale_sks.settings.priority_preset_onetouch);
      expect(scale_sks.settings.priority_preset_onetouch == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_preset_onetouch == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.priority_preset_onetouch = defalut;
      print(scale_sks.settings.priority_preset_onetouch);
      expect(scale_sks.settings.priority_preset_onetouch == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_preset_onetouch == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.priority_digital_preset;
      print(scale_sks.settings.priority_digital_preset);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.priority_digital_preset = testData1;
      print(scale_sks.settings.priority_digital_preset);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.priority_digital_preset == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.priority_digital_preset == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.priority_digital_preset = testData2;
      print(scale_sks.settings.priority_digital_preset);
      expect(scale_sks.settings.priority_digital_preset == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_digital_preset == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.priority_digital_preset = defalut;
      print(scale_sks.settings.priority_digital_preset);
      expect(scale_sks.settings.priority_digital_preset == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_digital_preset == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.priority_digital_onetouch;
      print(scale_sks.settings.priority_digital_onetouch);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.priority_digital_onetouch = testData1;
      print(scale_sks.settings.priority_digital_onetouch);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.priority_digital_onetouch == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.priority_digital_onetouch == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.priority_digital_onetouch = testData2;
      print(scale_sks.settings.priority_digital_onetouch);
      expect(scale_sks.settings.priority_digital_onetouch == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_digital_onetouch == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.priority_digital_onetouch = defalut;
      print(scale_sks.settings.priority_digital_onetouch);
      expect(scale_sks.settings.priority_digital_onetouch == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_digital_onetouch == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.priority_onetouch_preset;
      print(scale_sks.settings.priority_onetouch_preset);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.priority_onetouch_preset = testData1;
      print(scale_sks.settings.priority_onetouch_preset);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.priority_onetouch_preset == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.priority_onetouch_preset == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.priority_onetouch_preset = testData2;
      print(scale_sks.settings.priority_onetouch_preset);
      expect(scale_sks.settings.priority_onetouch_preset == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_onetouch_preset == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.priority_onetouch_preset = defalut;
      print(scale_sks.settings.priority_onetouch_preset);
      expect(scale_sks.settings.priority_onetouch_preset == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_onetouch_preset == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.priority_onetouch_digital;
      print(scale_sks.settings.priority_onetouch_digital);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.priority_onetouch_digital = testData1;
      print(scale_sks.settings.priority_onetouch_digital);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.priority_onetouch_digital == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.priority_onetouch_digital == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.priority_onetouch_digital = testData2;
      print(scale_sks.settings.priority_onetouch_digital);
      expect(scale_sks.settings.priority_onetouch_digital == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_onetouch_digital == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.priority_onetouch_digital = defalut;
      print(scale_sks.settings.priority_onetouch_digital);
      expect(scale_sks.settings.priority_onetouch_digital == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.priority_onetouch_digital == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.zero_tracking_when_tare;
      print(scale_sks.settings.zero_tracking_when_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.zero_tracking_when_tare = testData1;
      print(scale_sks.settings.zero_tracking_when_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.zero_tracking_when_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.zero_tracking_when_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.zero_tracking_when_tare = testData2;
      print(scale_sks.settings.zero_tracking_when_tare);
      expect(scale_sks.settings.zero_tracking_when_tare == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_tracking_when_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.zero_tracking_when_tare = defalut;
      print(scale_sks.settings.zero_tracking_when_tare);
      expect(scale_sks.settings.zero_tracking_when_tare == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_tracking_when_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.zero_reset_when_tare;
      print(scale_sks.settings.zero_reset_when_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.zero_reset_when_tare = testData1;
      print(scale_sks.settings.zero_reset_when_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.zero_reset_when_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.zero_reset_when_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.zero_reset_when_tare = testData2;
      print(scale_sks.settings.zero_reset_when_tare);
      expect(scale_sks.settings.zero_reset_when_tare == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_reset_when_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.zero_reset_when_tare = defalut;
      print(scale_sks.settings.zero_reset_when_tare);
      expect(scale_sks.settings.zero_reset_when_tare == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_reset_when_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.tare_disp_mode;
      print(scale_sks.settings.tare_disp_mode);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.tare_disp_mode = testData1;
      print(scale_sks.settings.tare_disp_mode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.tare_disp_mode == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.tare_disp_mode == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.tare_disp_mode = testData2;
      print(scale_sks.settings.tare_disp_mode);
      expect(scale_sks.settings.tare_disp_mode == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_disp_mode == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.tare_disp_mode = defalut;
      print(scale_sks.settings.tare_disp_mode);
      expect(scale_sks.settings.tare_disp_mode == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_disp_mode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.negative_disp;
      print(scale_sks.settings.negative_disp);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.negative_disp = testData1s;
      print(scale_sks.settings.negative_disp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.negative_disp == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.negative_disp == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.negative_disp = testData2s;
      print(scale_sks.settings.negative_disp);
      expect(scale_sks.settings.negative_disp == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.negative_disp == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.negative_disp = defalut;
      print(scale_sks.settings.negative_disp);
      expect(scale_sks.settings.negative_disp == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.negative_disp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.interval_typw;
      print(scale_sks.settings.interval_typw);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.interval_typw = testData1;
      print(scale_sks.settings.interval_typw);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.interval_typw == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.interval_typw == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.interval_typw = testData2;
      print(scale_sks.settings.interval_typw);
      expect(scale_sks.settings.interval_typw == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.interval_typw == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.interval_typw = defalut;
      print(scale_sks.settings.interval_typw);
      expect(scale_sks.settings.interval_typw == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.interval_typw == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.input_sensitivity;
      print(scale_sks.settings.input_sensitivity);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.input_sensitivity = testData1;
      print(scale_sks.settings.input_sensitivity);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.input_sensitivity == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.input_sensitivity == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.input_sensitivity = testData2;
      print(scale_sks.settings.input_sensitivity);
      expect(scale_sks.settings.input_sensitivity == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.input_sensitivity == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.input_sensitivity = defalut;
      print(scale_sks.settings.input_sensitivity);
      expect(scale_sks.settings.input_sensitivity == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.input_sensitivity == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.reg_mode_print_range;
      print(scale_sks.settings.reg_mode_print_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.reg_mode_print_range = testData1s;
      print(scale_sks.settings.reg_mode_print_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.reg_mode_print_range == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.reg_mode_print_range == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.reg_mode_print_range = testData2s;
      print(scale_sks.settings.reg_mode_print_range);
      expect(scale_sks.settings.reg_mode_print_range == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.reg_mode_print_range == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.reg_mode_print_range = defalut;
      print(scale_sks.settings.reg_mode_print_range);
      expect(scale_sks.settings.reg_mode_print_range == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.reg_mode_print_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.pricing_mode_print_range;
      print(scale_sks.settings.pricing_mode_print_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.pricing_mode_print_range = testData1s;
      print(scale_sks.settings.pricing_mode_print_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.pricing_mode_print_range == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.pricing_mode_print_range == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.pricing_mode_print_range = testData2s;
      print(scale_sks.settings.pricing_mode_print_range);
      expect(scale_sks.settings.pricing_mode_print_range == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.pricing_mode_print_range == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.pricing_mode_print_range = defalut;
      print(scale_sks.settings.pricing_mode_print_range);
      expect(scale_sks.settings.pricing_mode_print_range == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.pricing_mode_print_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.kg_lb_switching;
      print(scale_sks.settings.kg_lb_switching);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.kg_lb_switching = testData1;
      print(scale_sks.settings.kg_lb_switching);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.kg_lb_switching == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.kg_lb_switching == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.kg_lb_switching = testData2;
      print(scale_sks.settings.kg_lb_switching);
      expect(scale_sks.settings.kg_lb_switching == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.kg_lb_switching == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.kg_lb_switching = defalut;
      print(scale_sks.settings.kg_lb_switching);
      expect(scale_sks.settings.kg_lb_switching == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.kg_lb_switching == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.percentage_tare_rounding;
      print(scale_sks.settings.percentage_tare_rounding);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.percentage_tare_rounding = testData1;
      print(scale_sks.settings.percentage_tare_rounding);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.percentage_tare_rounding == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.percentage_tare_rounding == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.percentage_tare_rounding = testData2;
      print(scale_sks.settings.percentage_tare_rounding);
      expect(scale_sks.settings.percentage_tare_rounding == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.percentage_tare_rounding == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.percentage_tare_rounding = defalut;
      print(scale_sks.settings.percentage_tare_rounding);
      expect(scale_sks.settings.percentage_tare_rounding == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.percentage_tare_rounding == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.tare_rounding_for_upper_range;
      print(scale_sks.settings.tare_rounding_for_upper_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.tare_rounding_for_upper_range = testData1;
      print(scale_sks.settings.tare_rounding_for_upper_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.tare_rounding_for_upper_range == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.tare_rounding_for_upper_range == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.tare_rounding_for_upper_range = testData2;
      print(scale_sks.settings.tare_rounding_for_upper_range);
      expect(scale_sks.settings.tare_rounding_for_upper_range == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_rounding_for_upper_range == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.tare_rounding_for_upper_range = defalut;
      print(scale_sks.settings.tare_rounding_for_upper_range);
      expect(scale_sks.settings.tare_rounding_for_upper_range == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_rounding_for_upper_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.onetouch_tare;
      print(scale_sks.settings.onetouch_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.onetouch_tare = testData1;
      print(scale_sks.settings.onetouch_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.onetouch_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.onetouch_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.onetouch_tare = testData2;
      print(scale_sks.settings.onetouch_tare);
      expect(scale_sks.settings.onetouch_tare == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.onetouch_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.onetouch_tare = defalut;
      print(scale_sks.settings.onetouch_tare);
      expect(scale_sks.settings.onetouch_tare == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.onetouch_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.zero_reset_range_at_start;
      print(scale_sks.settings.zero_reset_range_at_start);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.zero_reset_range_at_start = testData1;
      print(scale_sks.settings.zero_reset_range_at_start);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.zero_reset_range_at_start == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.zero_reset_range_at_start == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.zero_reset_range_at_start = testData2;
      print(scale_sks.settings.zero_reset_range_at_start);
      expect(scale_sks.settings.zero_reset_range_at_start == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_reset_range_at_start == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.zero_reset_range_at_start = defalut;
      print(scale_sks.settings.zero_reset_range_at_start);
      expect(scale_sks.settings.zero_reset_range_at_start == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_reset_range_at_start == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.zero_reset_range;
      print(scale_sks.settings.zero_reset_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.zero_reset_range = testData1;
      print(scale_sks.settings.zero_reset_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.zero_reset_range == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.zero_reset_range == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.zero_reset_range = testData2;
      print(scale_sks.settings.zero_reset_range);
      expect(scale_sks.settings.zero_reset_range == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_reset_range == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.zero_reset_range = defalut;
      print(scale_sks.settings.zero_reset_range);
      expect(scale_sks.settings.zero_reset_range == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_reset_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.use_area;
      print(scale_sks.settings.use_area);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.use_area = testData1;
      print(scale_sks.settings.use_area);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.use_area == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.use_area == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.use_area = testData2;
      print(scale_sks.settings.use_area);
      expect(scale_sks.settings.use_area == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.use_area == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.use_area = defalut;
      print(scale_sks.settings.use_area);
      expect(scale_sks.settings.use_area == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.use_area == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.setting_area;
      print(scale_sks.settings.setting_area);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.setting_area = testData1;
      print(scale_sks.settings.setting_area);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.setting_area == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.setting_area == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.setting_area = testData2;
      print(scale_sks.settings.setting_area);
      expect(scale_sks.settings.setting_area == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.setting_area == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.setting_area = defalut;
      print(scale_sks.settings.setting_area);
      expect(scale_sks.settings.setting_area == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.setting_area == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.price_decimal_point;
      print(scale_sks.settings.price_decimal_point);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.price_decimal_point = testData1;
      print(scale_sks.settings.price_decimal_point);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.price_decimal_point == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.price_decimal_point == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.price_decimal_point = testData2;
      print(scale_sks.settings.price_decimal_point);
      expect(scale_sks.settings.price_decimal_point == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_decimal_point == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.price_decimal_point = defalut;
      print(scale_sks.settings.price_decimal_point);
      expect(scale_sks.settings.price_decimal_point == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_decimal_point == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.unit_price_decimal_point;
      print(scale_sks.settings.unit_price_decimal_point);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.unit_price_decimal_point = testData1;
      print(scale_sks.settings.unit_price_decimal_point);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.unit_price_decimal_point == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.unit_price_decimal_point == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.unit_price_decimal_point = testData2;
      print(scale_sks.settings.unit_price_decimal_point);
      expect(scale_sks.settings.unit_price_decimal_point == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.unit_price_decimal_point == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.unit_price_decimal_point = defalut;
      print(scale_sks.settings.unit_price_decimal_point);
      expect(scale_sks.settings.unit_price_decimal_point == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.unit_price_decimal_point == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.price_decimal_point_pos;
      print(scale_sks.settings.price_decimal_point_pos);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.price_decimal_point_pos = testData1s;
      print(scale_sks.settings.price_decimal_point_pos);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.price_decimal_point_pos == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.price_decimal_point_pos == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.price_decimal_point_pos = testData2s;
      print(scale_sks.settings.price_decimal_point_pos);
      expect(scale_sks.settings.price_decimal_point_pos == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_decimal_point_pos == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.price_decimal_point_pos = defalut;
      print(scale_sks.settings.price_decimal_point_pos);
      expect(scale_sks.settings.price_decimal_point_pos == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_decimal_point_pos == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.unit_price_decimal_point_pos;
      print(scale_sks.settings.unit_price_decimal_point_pos);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.unit_price_decimal_point_pos = testData1s;
      print(scale_sks.settings.unit_price_decimal_point_pos);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.unit_price_decimal_point_pos == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.unit_price_decimal_point_pos == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.unit_price_decimal_point_pos = testData2s;
      print(scale_sks.settings.unit_price_decimal_point_pos);
      expect(scale_sks.settings.unit_price_decimal_point_pos == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.unit_price_decimal_point_pos == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.unit_price_decimal_point_pos = defalut;
      print(scale_sks.settings.unit_price_decimal_point_pos);
      expect(scale_sks.settings.unit_price_decimal_point_pos == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.unit_price_decimal_point_pos == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.second_price_calc;
      print(scale_sks.settings.second_price_calc);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.second_price_calc = testData1s;
      print(scale_sks.settings.second_price_calc);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.second_price_calc == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.second_price_calc == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.second_price_calc = testData2s;
      print(scale_sks.settings.second_price_calc);
      expect(scale_sks.settings.second_price_calc == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.second_price_calc == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.second_price_calc = defalut;
      print(scale_sks.settings.second_price_calc);
      expect(scale_sks.settings.second_price_calc == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.second_price_calc == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.price_calc;
      print(scale_sks.settings.price_calc);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.price_calc = testData1s;
      print(scale_sks.settings.price_calc);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.price_calc == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.price_calc == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.price_calc = testData2s;
      print(scale_sks.settings.price_calc);
      expect(scale_sks.settings.price_calc == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_calc == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.price_calc = defalut;
      print(scale_sks.settings.price_calc);
      expect(scale_sks.settings.price_calc == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_calc == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.special_rounding;
      print(scale_sks.settings.special_rounding);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.special_rounding = testData1s;
      print(scale_sks.settings.special_rounding);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.special_rounding == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.special_rounding == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.special_rounding = testData2s;
      print(scale_sks.settings.special_rounding);
      expect(scale_sks.settings.special_rounding == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.special_rounding == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.special_rounding = defalut;
      print(scale_sks.settings.special_rounding);
      expect(scale_sks.settings.special_rounding == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.special_rounding == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.quote;
      print(scale_sks.settings.quote);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.quote = testData1s;
      print(scale_sks.settings.quote);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.quote == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.quote == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.quote = testData2s;
      print(scale_sks.settings.quote);
      expect(scale_sks.settings.quote == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.quote == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.quote = defalut;
      print(scale_sks.settings.quote);
      expect(scale_sks.settings.quote == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.quote == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.label_issuance_during_tare;
      print(scale_sks.settings.label_issuance_during_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.label_issuance_during_tare = testData1;
      print(scale_sks.settings.label_issuance_during_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.label_issuance_during_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.label_issuance_during_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.label_issuance_during_tare = testData2;
      print(scale_sks.settings.label_issuance_during_tare);
      expect(scale_sks.settings.label_issuance_during_tare == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.label_issuance_during_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.label_issuance_during_tare = defalut;
      print(scale_sks.settings.label_issuance_during_tare);
      expect(scale_sks.settings.label_issuance_during_tare == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.label_issuance_during_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.tare_automatic_update;
      print(scale_sks.settings.tare_automatic_update);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.tare_automatic_update = testData1;
      print(scale_sks.settings.tare_automatic_update);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.tare_automatic_update == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.tare_automatic_update == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.tare_automatic_update = testData2;
      print(scale_sks.settings.tare_automatic_update);
      expect(scale_sks.settings.tare_automatic_update == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_automatic_update == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.tare_automatic_update = defalut;
      print(scale_sks.settings.tare_automatic_update);
      expect(scale_sks.settings.tare_automatic_update == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.tare_automatic_update == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.sws_f_to_f_scale_spec;
      print(scale_sks.settings.sws_f_to_f_scale_spec);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.sws_f_to_f_scale_spec = testData1;
      print(scale_sks.settings.sws_f_to_f_scale_spec);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.sws_f_to_f_scale_spec == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.sws_f_to_f_scale_spec == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.sws_f_to_f_scale_spec = testData2;
      print(scale_sks.settings.sws_f_to_f_scale_spec);
      expect(scale_sks.settings.sws_f_to_f_scale_spec == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.sws_f_to_f_scale_spec == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.sws_f_to_f_scale_spec = defalut;
      print(scale_sks.settings.sws_f_to_f_scale_spec);
      expect(scale_sks.settings.sws_f_to_f_scale_spec == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.sws_f_to_f_scale_spec == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.zero_lamp_pos;
      print(scale_sks.settings.zero_lamp_pos);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.zero_lamp_pos = testData1;
      print(scale_sks.settings.zero_lamp_pos);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.zero_lamp_pos == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.zero_lamp_pos == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.zero_lamp_pos = testData2;
      print(scale_sks.settings.zero_lamp_pos);
      expect(scale_sks.settings.zero_lamp_pos == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_lamp_pos == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.zero_lamp_pos = defalut;
      print(scale_sks.settings.zero_lamp_pos);
      expect(scale_sks.settings.zero_lamp_pos == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.zero_lamp_pos == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.disp_print_type;
      print(scale_sks.settings.disp_print_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.disp_print_type = testData1;
      print(scale_sks.settings.disp_print_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.disp_print_type == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.disp_print_type == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.disp_print_type = testData2;
      print(scale_sks.settings.disp_print_type);
      expect(scale_sks.settings.disp_print_type == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.disp_print_type == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.disp_print_type = defalut;
      print(scale_sks.settings.disp_print_type);
      expect(scale_sks.settings.disp_print_type == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.disp_print_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.programmed_tare_clear;
      print(scale_sks.settings.programmed_tare_clear);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.programmed_tare_clear = testData1;
      print(scale_sks.settings.programmed_tare_clear);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.programmed_tare_clear == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.programmed_tare_clear == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.programmed_tare_clear = testData2;
      print(scale_sks.settings.programmed_tare_clear);
      expect(scale_sks.settings.programmed_tare_clear == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.programmed_tare_clear == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.programmed_tare_clear = defalut;
      print(scale_sks.settings.programmed_tare_clear);
      expect(scale_sks.settings.programmed_tare_clear == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.programmed_tare_clear == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.print_pre_discount_price;
      print(scale_sks.settings.print_pre_discount_price);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.print_pre_discount_price = testData1;
      print(scale_sks.settings.print_pre_discount_price);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.print_pre_discount_price == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.print_pre_discount_price == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.print_pre_discount_price = testData2;
      print(scale_sks.settings.print_pre_discount_price);
      expect(scale_sks.settings.print_pre_discount_price == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.print_pre_discount_price == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.print_pre_discount_price = defalut;
      print(scale_sks.settings.print_pre_discount_price);
      expect(scale_sks.settings.print_pre_discount_price == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.print_pre_discount_price == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.unit_price_digit;
      print(scale_sks.settings.unit_price_digit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.unit_price_digit = testData1;
      print(scale_sks.settings.unit_price_digit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.unit_price_digit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.unit_price_digit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.unit_price_digit = testData2;
      print(scale_sks.settings.unit_price_digit);
      expect(scale_sks.settings.unit_price_digit == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.unit_price_digit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.unit_price_digit = defalut;
      print(scale_sks.settings.unit_price_digit);
      expect(scale_sks.settings.unit_price_digit == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.unit_price_digit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.inverse_calc_of_unit_price;
      print(scale_sks.settings.inverse_calc_of_unit_price);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.inverse_calc_of_unit_price = testData1;
      print(scale_sks.settings.inverse_calc_of_unit_price);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.inverse_calc_of_unit_price == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.inverse_calc_of_unit_price == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.inverse_calc_of_unit_price = testData2;
      print(scale_sks.settings.inverse_calc_of_unit_price);
      expect(scale_sks.settings.inverse_calc_of_unit_price == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.inverse_calc_of_unit_price == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.inverse_calc_of_unit_price = defalut;
      print(scale_sks.settings.inverse_calc_of_unit_price);
      expect(scale_sks.settings.inverse_calc_of_unit_price == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.inverse_calc_of_unit_price == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.weight_manual_input;
      print(scale_sks.settings.weight_manual_input);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.weight_manual_input = testData1;
      print(scale_sks.settings.weight_manual_input);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.weight_manual_input == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.weight_manual_input == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.weight_manual_input = testData2;
      print(scale_sks.settings.weight_manual_input);
      expect(scale_sks.settings.weight_manual_input == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.weight_manual_input == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.weight_manual_input = defalut;
      print(scale_sks.settings.weight_manual_input);
      expect(scale_sks.settings.weight_manual_input == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.weight_manual_input == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.weight_key_in;
      print(scale_sks.settings.weight_key_in);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.weight_key_in = testData1;
      print(scale_sks.settings.weight_key_in);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.weight_key_in == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.weight_key_in == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.weight_key_in = testData2;
      print(scale_sks.settings.weight_key_in);
      expect(scale_sks.settings.weight_key_in == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.weight_key_in == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.weight_key_in = defalut;
      print(scale_sks.settings.weight_key_in);
      expect(scale_sks.settings.weight_key_in == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.weight_key_in == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.ad_type;
      print(scale_sks.settings.ad_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.ad_type = testData1;
      print(scale_sks.settings.ad_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.ad_type == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.ad_type == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.ad_type = testData2;
      print(scale_sks.settings.ad_type);
      expect(scale_sks.settings.ad_type == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.ad_type == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.ad_type = defalut;
      print(scale_sks.settings.ad_type);
      expect(scale_sks.settings.ad_type == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.ad_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.weighing;
      print(scale_sks.settings.weighing);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.weighing = testData1s;
      print(scale_sks.settings.weighing);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.weighing == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.weighing == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.weighing = testData2s;
      print(scale_sks.settings.weighing);
      expect(scale_sks.settings.weighing == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.weighing == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.weighing = defalut;
      print(scale_sks.settings.weighing);
      expect(scale_sks.settings.weighing == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.weighing == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.price_printing_in_barcode;
      print(scale_sks.settings.price_printing_in_barcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.price_printing_in_barcode = testData1;
      print(scale_sks.settings.price_printing_in_barcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.price_printing_in_barcode == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.price_printing_in_barcode == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.price_printing_in_barcode = testData2;
      print(scale_sks.settings.price_printing_in_barcode);
      expect(scale_sks.settings.price_printing_in_barcode == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_printing_in_barcode == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.price_printing_in_barcode = defalut;
      print(scale_sks.settings.price_printing_in_barcode);
      expect(scale_sks.settings.price_printing_in_barcode == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.price_printing_in_barcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.quarter_round;
      print(scale_sks.settings.quarter_round);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.quarter_round = testData1s;
      print(scale_sks.settings.quarter_round);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.quarter_round == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.quarter_round == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.quarter_round = testData2s;
      print(scale_sks.settings.quarter_round);
      expect(scale_sks.settings.quarter_round == testData2s, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.quarter_round == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.quarter_round = defalut;
      print(scale_sks.settings.quarter_round);
      expect(scale_sks.settings.quarter_round == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.quarter_round == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.settings.round_price_type;
      print(scale_sks.settings.round_price_type);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.settings.round_price_type = testData1;
      print(scale_sks.settings.round_price_type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.settings.round_price_type == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.settings.round_price_type == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.settings.round_price_type = testData2;
      print(scale_sks.settings.round_price_type);
      expect(scale_sks.settings.round_price_type == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.round_price_type == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.settings.round_price_type = defalut;
      print(scale_sks.settings.round_price_type);
      expect(scale_sks.settings.round_price_type == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.settings.round_price_type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      scale_sks = Scale_sksJsonFile();
      allPropatyCheckInit(scale_sks);

      // ①loadを実行する。
      await scale_sks.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scale_sks.info.version;
      print(scale_sks.info.version);

      // ②指定したプロパティにテストデータ1を書き込む。
      scale_sks.info.version = testData1;
      print(scale_sks.info.version);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scale_sks.info.version == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scale_sks.save();
      await scale_sks.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scale_sks.info.version == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scale_sks.info.version = testData2;
      print(scale_sks.info.version);
      expect(scale_sks.info.version == testData2, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.info.version == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scale_sks.info.version = defalut;
      print(scale_sks.info.version);
      expect(scale_sks.info.version == defalut, true);
      await scale_sks.save();
      await scale_sks.load();
      expect(scale_sks.info.version == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scale_sks, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Scale_sksJsonFile test)
{
  expect(test.settings.port, "");
  expect(test.settings.baudrate, 0);
  expect(test.settings.databit, 0);
  expect(test.settings.startbit, 0);
  expect(test.settings.stopbit, 0);
  expect(test.settings.parity, "");
  expect(test.settings.bill, "");
  expect(test.settings.id, 0);
  expect(test.settings.collect_num, 0);
  expect(test.settings.span_switch, 0);
  expect(test.settings.protect_span_spec, 0);
  expect(test.settings.protect_count, 0);
  expect(test.settings.protect_data, 0);
  expect(test.settings.data_auth, 0);
  expect(test.settings.decimal_point_shape, 0);
  expect(test.settings.decimal_point_pos, "");
  expect(test.settings.tare_auto_clear, 0);
  expect(test.settings.preset_tare, 0);
  expect(test.settings.digital_tare_subtraction, 0);
  expect(test.settings.digital_tare_addition, 0);
  expect(test.settings.digital_tare, 0);
  expect(test.settings.onetouch_tare_subtraction, 0);
  expect(test.settings.onetouch_tare_addition, 0);
  expect(test.settings.tare_range, 0);
  expect(test.settings.priority_preset_digital, 0);
  expect(test.settings.priority_preset_onetouch, 0);
  expect(test.settings.priority_digital_preset, 0);
  expect(test.settings.priority_digital_onetouch, 0);
  expect(test.settings.priority_onetouch_preset, 0);
  expect(test.settings.priority_onetouch_digital, 0);
  expect(test.settings.zero_tracking_when_tare, 0);
  expect(test.settings.zero_reset_when_tare, 0);
  expect(test.settings.tare_disp_mode, 0);
  expect(test.settings.negative_disp, "");
  expect(test.settings.interval_typw, 0);
  expect(test.settings.input_sensitivity, 0);
  expect(test.settings.reg_mode_print_range, "");
  expect(test.settings.pricing_mode_print_range, "");
  expect(test.settings.kg_lb_switching, 0);
  expect(test.settings.percentage_tare_rounding, 0);
  expect(test.settings.tare_rounding_for_upper_range, 0);
  expect(test.settings.onetouch_tare, 0);
  expect(test.settings.zero_reset_range_at_start, 0);
  expect(test.settings.zero_reset_range, 0);
  expect(test.settings.use_area, 0);
  expect(test.settings.setting_area, 0);
  expect(test.settings.price_decimal_point, 0);
  expect(test.settings.unit_price_decimal_point, 0);
  expect(test.settings.price_decimal_point_pos, "");
  expect(test.settings.unit_price_decimal_point_pos, "");
  expect(test.settings.second_price_calc, "");
  expect(test.settings.price_calc, "");
  expect(test.settings.special_rounding, "");
  expect(test.settings.quote, "");
  expect(test.settings.label_issuance_during_tare, 0);
  expect(test.settings.tare_automatic_update, 0);
  expect(test.settings.sws_f_to_f_scale_spec, 0);
  expect(test.settings.zero_lamp_pos, 0);
  expect(test.settings.disp_print_type, 0);
  expect(test.settings.programmed_tare_clear, 0);
  expect(test.settings.print_pre_discount_price, 0);
  expect(test.settings.unit_price_digit, 0);
  expect(test.settings.inverse_calc_of_unit_price, 0);
  expect(test.settings.weight_manual_input, 0);
  expect(test.settings.weight_key_in, 0);
  expect(test.settings.ad_type, 0);
  expect(test.settings.weighing, "");
  expect(test.settings.price_printing_in_barcode, 0);
  expect(test.settings.quarter_round, "");
  expect(test.settings.round_price_type, 0);
  expect(test.info.version, 0);
}

void allPropatyCheck(Scale_sksJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.settings.port, "");
  }
  expect(test.settings.baudrate, 38400);
  expect(test.settings.databit, 8);
  expect(test.settings.startbit, 1);
  expect(test.settings.stopbit, 1);
  expect(test.settings.parity, "even");
  expect(test.settings.bill, "no");
  expect(test.settings.id, 1);
  expect(test.settings.collect_num, 4);
  expect(test.settings.span_switch, 0);
  expect(test.settings.protect_span_spec, 0);
  expect(test.settings.protect_count, 0);
  expect(test.settings.protect_data, 0);
  expect(test.settings.data_auth, 0);
  expect(test.settings.decimal_point_shape, 0);
  expect(test.settings.decimal_point_pos, "00");
  expect(test.settings.tare_auto_clear, 0);
  expect(test.settings.preset_tare, 1);
  expect(test.settings.digital_tare_subtraction, 1);
  expect(test.settings.digital_tare_addition, 1);
  expect(test.settings.digital_tare, 1);
  expect(test.settings.onetouch_tare_subtraction, 1);
  expect(test.settings.onetouch_tare_addition, 1);
  expect(test.settings.tare_range, 1);
  expect(test.settings.priority_preset_digital, 1);
  expect(test.settings.priority_preset_onetouch, 0);
  expect(test.settings.priority_digital_preset, 1);
  expect(test.settings.priority_digital_onetouch, 0);
  expect(test.settings.priority_onetouch_preset, 0);
  expect(test.settings.priority_onetouch_digital, 0);
  expect(test.settings.zero_tracking_when_tare, 1);
  expect(test.settings.zero_reset_when_tare, 1);
  expect(test.settings.tare_disp_mode, 1);
  expect(test.settings.negative_disp, "00");
  expect(test.settings.interval_typw, 1);
  expect(test.settings.input_sensitivity, 1100);
  expect(test.settings.reg_mode_print_range, "000");
  expect(test.settings.pricing_mode_print_range, "000");
  expect(test.settings.kg_lb_switching, 0);
  expect(test.settings.percentage_tare_rounding, 0);
  expect(test.settings.tare_rounding_for_upper_range, 0);
  expect(test.settings.onetouch_tare, 0);
  expect(test.settings.zero_reset_range_at_start, 0);
  expect(test.settings.zero_reset_range, 0);
  expect(test.settings.use_area, 0);
  expect(test.settings.setting_area, 0);
  expect(test.settings.price_decimal_point, 0);
  expect(test.settings.unit_price_decimal_point, 0);
  expect(test.settings.price_decimal_point_pos, "00");
  expect(test.settings.unit_price_decimal_point_pos, "00");
  expect(test.settings.second_price_calc, "0000");
  expect(test.settings.price_calc, "0000");
  expect(test.settings.special_rounding, "0000");
  expect(test.settings.quote, "000");
  expect(test.settings.label_issuance_during_tare, 0);
  expect(test.settings.tare_automatic_update, 0);
  expect(test.settings.sws_f_to_f_scale_spec, 0);
  expect(test.settings.zero_lamp_pos, 0);
  expect(test.settings.disp_print_type, 0);
  expect(test.settings.programmed_tare_clear, 0);
  expect(test.settings.print_pre_discount_price, 0);
  expect(test.settings.unit_price_digit, 0);
  expect(test.settings.inverse_calc_of_unit_price, 0);
  expect(test.settings.weight_manual_input, 0);
  expect(test.settings.weight_key_in, 0);
  expect(test.settings.ad_type, 0);
  expect(test.settings.weighing, "00000");
  expect(test.settings.price_printing_in_barcode, 0);
  expect(test.settings.quarter_round, "00");
  expect(test.settings.round_price_type, 0);
  expect(test.info.version, 0);
}

