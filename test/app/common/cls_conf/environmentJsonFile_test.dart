/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_test/flutter_test.dart';import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'unitTestParts.dart';

import '../../../../lib/app/common/cls_conf/configJsonFile.dart';
import '../../../../lib/app/common/cls_conf/environmentJsonFile.dart';

late EnvironmentJsonFile environment;

void main(){
  environmentJsonFile_test();
}

void environmentJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "environment.json";
  const String section = "environment";
  const String key = "HOME";
  const defaultData = "/pj/tprx";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('EnvironmentJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await EnvironmentJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await EnvironmentJsonFile().setDefault();
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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await environment.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(environment,true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        environment.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await environment.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(environment,true);

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
      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①：loadを実行する。
      await environment.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = environment.environment.HOME;
      environment.environment.HOME = testData1s;
      expect(environment.environment.HOME == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await environment.load();
      expect(environment.environment.HOME != testData1s, true);
      expect(environment.environment.HOME == prefixData, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = environment.environment.HOME;
      environment.environment.HOME = testData1s;
      expect(environment.environment.HOME, testData1s);

      // ③saveを実行する。
      await environment.save();

      // ④loadを実行する。
      await environment.load();

      expect(environment.environment.HOME != prefixData, true);
      expect(environment.environment.HOME == testData1s, true);
      allPropatyCheck(environment,false);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await environment.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await environment.save();

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await environment.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(environment.environment.HOME, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = environment.environment.HOME;
      environment.environment.HOME = testData1s;

      // ③ saveを実行する。
      await environment.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(environment.environment.HOME, testData1s);

      // ④ loadを実行する。
      await environment.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(environment.environment.HOME == testData1s, true);
      allPropatyCheck(environment,false);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await environment.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(environment,true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②任意のプロパティの値を変更する。
      environment.environment.HOME = testData1s;
      expect(environment.environment.HOME, testData1s);

      // ③saveを実行する。
      await environment.save();
      expect(environment.environment.HOME, testData1s);

      // ④loadを実行する。
      await environment.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(environment,true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await environment.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await environment.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(environment.environment.HOME == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await environment.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await environment.setValueWithName(section, "test_key", testData1s);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②任意のプロパティを変更する。
      environment.environment.HOME = testData1s;

      // ③saveを実行する。
      await environment.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await environment.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②任意のプロパティを変更する。
      environment.environment.HOME = testData1s;

      // ③saveを実行する。
      await environment.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await environment.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②任意のプロパティを変更する。
      environment.environment.HOME = testData1s;

      // ③saveを実行する。
      await environment.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await environment.getValueWithName(section, "test_key");
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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await environment.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      environment.environment.HOME = testData1s;
      expect(environment.environment.HOME, testData1s);

      // ④saveを実行する。
      await environment.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(environment.environment.HOME, testData1s);
      
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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await environment.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      expect(environment.environment.HOME == testData1s, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await environment.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      expect(environment.environment.HOME == testData2s, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await environment.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      expect(environment.environment.HOME == testData1s, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await environment.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      expect(environment.environment.HOME == testData2s, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await environment.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      expect(environment.environment.HOME == testData1s, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await environment.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      expect(environment.environment.HOME == testData1s, true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await environment.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      allPropatyCheck(environment,true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await environment.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + environment.environment.HOME.toString());
      allPropatyCheck(environment,true);

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

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.HOME;
      print(environment.environment.HOME);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.HOME = testData1s;
      print(environment.environment.HOME);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.HOME == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.HOME == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.HOME = testData2s;
      print(environment.environment.HOME);
      expect(environment.environment.HOME == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.HOME == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.HOME = defalut;
      print(environment.environment.HOME);
      expect(environment.environment.HOME == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.HOME == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PATH;
      print(environment.environment.PATH);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PATH = testData1s;
      print(environment.environment.PATH);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PATH == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PATH == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PATH = testData2s;
      print(environment.environment.PATH);
      expect(environment.environment.PATH == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PATH == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PATH = defalut;
      print(environment.environment.PATH);
      expect(environment.environment.PATH == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PATH == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.SHELL;
      print(environment.environment.SHELL);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.SHELL = testData1s;
      print(environment.environment.SHELL);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.SHELL == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.SHELL == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.SHELL = testData2s;
      print(environment.environment.SHELL);
      expect(environment.environment.SHELL == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.SHELL == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.SHELL = defalut;
      print(environment.environment.SHELL);
      expect(environment.environment.SHELL == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.SHELL == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.BASE_ENV;
      print(environment.environment.BASE_ENV);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.BASE_ENV = testData1s;
      print(environment.environment.BASE_ENV);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.BASE_ENV == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.BASE_ENV == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.BASE_ENV = testData2s;
      print(environment.environment.BASE_ENV);
      expect(environment.environment.BASE_ENV == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.BASE_ENV == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.BASE_ENV = defalut;
      print(environment.environment.BASE_ENV);
      expect(environment.environment.BASE_ENV == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.BASE_ENV == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.LC_ALL;
      print(environment.environment.LC_ALL);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.LC_ALL = testData1s;
      print(environment.environment.LC_ALL);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.LC_ALL == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.LC_ALL == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.LC_ALL = testData2s;
      print(environment.environment.LC_ALL);
      expect(environment.environment.LC_ALL == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.LC_ALL == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.LC_ALL = defalut;
      print(environment.environment.LC_ALL);
      expect(environment.environment.LC_ALL == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.LC_ALL == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.LANG;
      print(environment.environment.LANG);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.LANG = testData1s;
      print(environment.environment.LANG);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.LANG == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.LANG == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.LANG = testData2s;
      print(environment.environment.LANG);
      expect(environment.environment.LANG == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.LANG == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.LANG = defalut;
      print(environment.environment.LANG);
      expect(environment.environment.LANG == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.LANG == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.LINGUAS;
      print(environment.environment.LINGUAS);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.LINGUAS = testData1s;
      print(environment.environment.LINGUAS);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.LINGUAS == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.LINGUAS == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.LINGUAS = testData2s;
      print(environment.environment.LINGUAS);
      expect(environment.environment.LINGUAS == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.LINGUAS == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.LINGUAS = defalut;
      print(environment.environment.LINGUAS);
      expect(environment.environment.LINGUAS == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.LINGUAS == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.TPRX_HOME;
      print(environment.environment.TPRX_HOME);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.TPRX_HOME = testData1s;
      print(environment.environment.TPRX_HOME);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.TPRX_HOME == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.TPRX_HOME == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.TPRX_HOME = testData2s;
      print(environment.environment.TPRX_HOME);
      expect(environment.environment.TPRX_HOME == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.TPRX_HOME == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.TPRX_HOME = defalut;
      print(environment.environment.TPRX_HOME);
      expect(environment.environment.TPRX_HOME == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.TPRX_HOME == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.DISPLAY;
      print(environment.environment.DISPLAY);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.DISPLAY = testData1s;
      print(environment.environment.DISPLAY);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.DISPLAY == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.DISPLAY == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.DISPLAY = testData2s;
      print(environment.environment.DISPLAY);
      expect(environment.environment.DISPLAY == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.DISPLAY == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.DISPLAY = defalut;
      print(environment.environment.DISPLAY);
      expect(environment.environment.DISPLAY == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.DISPLAY == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.WINDOW;
      print(environment.environment.WINDOW);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.WINDOW = testData1s;
      print(environment.environment.WINDOW);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.WINDOW == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.WINDOW == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.WINDOW = testData2s;
      print(environment.environment.WINDOW);
      expect(environment.environment.WINDOW == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.WINDOW == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.WINDOW = defalut;
      print(environment.environment.WINDOW);
      expect(environment.environment.WINDOW == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.WINDOW == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.CONTENT_LENGTH;
      print(environment.environment.CONTENT_LENGTH);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.CONTENT_LENGTH = testData1s;
      print(environment.environment.CONTENT_LENGTH);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.CONTENT_LENGTH == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.CONTENT_LENGTH == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.CONTENT_LENGTH = testData2s;
      print(environment.environment.CONTENT_LENGTH);
      expect(environment.environment.CONTENT_LENGTH == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.CONTENT_LENGTH == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.CONTENT_LENGTH = defalut;
      print(environment.environment.CONTENT_LENGTH);
      expect(environment.environment.CONTENT_LENGTH == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.CONTENT_LENGTH == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGPASSWORD;
      print(environment.environment.PGPASSWORD);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGPASSWORD = testData1s;
      print(environment.environment.PGPASSWORD);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGPASSWORD == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGPASSWORD == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGPASSWORD = testData2s;
      print(environment.environment.PGPASSWORD);
      expect(environment.environment.PGPASSWORD == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGPASSWORD == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGPASSWORD = defalut;
      print(environment.environment.PGPASSWORD);
      expect(environment.environment.PGPASSWORD == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGPASSWORD == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGUSER;
      print(environment.environment.PGUSER);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGUSER = testData1s;
      print(environment.environment.PGUSER);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGUSER == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGUSER == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGUSER = testData2s;
      print(environment.environment.PGUSER);
      expect(environment.environment.PGUSER == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGUSER == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGUSER = defalut;
      print(environment.environment.PGUSER);
      expect(environment.environment.PGUSER == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGUSER == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGDATA;
      print(environment.environment.PGDATA);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGDATA = testData1s;
      print(environment.environment.PGDATA);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGDATA == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGDATA == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGDATA = testData2s;
      print(environment.environment.PGDATA);
      expect(environment.environment.PGDATA == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGDATA == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGDATA = defalut;
      print(environment.environment.PGDATA);
      expect(environment.environment.PGDATA == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGDATA == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGDATABASE;
      print(environment.environment.PGDATABASE);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGDATABASE = testData1s;
      print(environment.environment.PGDATABASE);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGDATABASE == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGDATABASE == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGDATABASE = testData2s;
      print(environment.environment.PGDATABASE);
      expect(environment.environment.PGDATABASE == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGDATABASE == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGDATABASE = defalut;
      print(environment.environment.PGDATABASE);
      expect(environment.environment.PGDATABASE == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGDATABASE == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGHOST;
      print(environment.environment.PGHOST);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGHOST = testData1s;
      print(environment.environment.PGHOST);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGHOST == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGHOST == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGHOST = testData2s;
      print(environment.environment.PGHOST);
      expect(environment.environment.PGHOST == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGHOST == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGHOST = defalut;
      print(environment.environment.PGHOST);
      expect(environment.environment.PGHOST == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGHOST == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGOPTIONS;
      print(environment.environment.PGOPTIONS);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGOPTIONS = testData1s;
      print(environment.environment.PGOPTIONS);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGOPTIONS == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGOPTIONS == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGOPTIONS = testData2s;
      print(environment.environment.PGOPTIONS);
      expect(environment.environment.PGOPTIONS == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGOPTIONS == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGOPTIONS = defalut;
      print(environment.environment.PGOPTIONS);
      expect(environment.environment.PGOPTIONS == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGOPTIONS == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGPORT;
      print(environment.environment.PGPORT);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGPORT = testData1s;
      print(environment.environment.PGPORT);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGPORT == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGPORT == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGPORT = testData2s;
      print(environment.environment.PGPORT);
      expect(environment.environment.PGPORT == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGPORT == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGPORT = defalut;
      print(environment.environment.PGPORT);
      expect(environment.environment.PGPORT == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGPORT == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGTTY;
      print(environment.environment.PGTTY);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGTTY = testData1s;
      print(environment.environment.PGTTY);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGTTY == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGTTY == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGTTY = testData2s;
      print(environment.environment.PGTTY);
      expect(environment.environment.PGTTY == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGTTY == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGTTY = defalut;
      print(environment.environment.PGTTY);
      expect(environment.environment.PGTTY == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGTTY == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.PGCLIENTENCODING;
      print(environment.environment.PGCLIENTENCODING);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.PGCLIENTENCODING = testData1s;
      print(environment.environment.PGCLIENTENCODING);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.PGCLIENTENCODING == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.PGCLIENTENCODING == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.PGCLIENTENCODING = testData2s;
      print(environment.environment.PGCLIENTENCODING);
      expect(environment.environment.PGCLIENTENCODING == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGCLIENTENCODING == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.PGCLIENTENCODING = defalut;
      print(environment.environment.PGCLIENTENCODING);
      expect(environment.environment.PGCLIENTENCODING == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.PGCLIENTENCODING == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.SMX_HOME;
      print(environment.environment.SMX_HOME);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.SMX_HOME = testData1s;
      print(environment.environment.SMX_HOME);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.SMX_HOME == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.SMX_HOME == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.SMX_HOME = testData2s;
      print(environment.environment.SMX_HOME);
      expect(environment.environment.SMX_HOME == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.SMX_HOME == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.SMX_HOME = defalut;
      print(environment.environment.SMX_HOME);
      expect(environment.environment.SMX_HOME == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.SMX_HOME == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      environment = EnvironmentJsonFile();
      allPropatyCheckInit(environment);

      // ①loadを実行する。
      await environment.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = environment.environment.TUO_SEND_ENV;
      print(environment.environment.TUO_SEND_ENV);

      // ②指定したプロパティにテストデータ1を書き込む。
      environment.environment.TUO_SEND_ENV = testData1s;
      print(environment.environment.TUO_SEND_ENV);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(environment.environment.TUO_SEND_ENV == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await environment.save();
      await environment.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(environment.environment.TUO_SEND_ENV == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      environment.environment.TUO_SEND_ENV = testData2s;
      print(environment.environment.TUO_SEND_ENV);
      expect(environment.environment.TUO_SEND_ENV == testData2s, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.TUO_SEND_ENV == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      environment.environment.TUO_SEND_ENV = defalut;
      print(environment.environment.TUO_SEND_ENV);
      expect(environment.environment.TUO_SEND_ENV == defalut, true);
      await environment.save();
      await environment.load();
      expect(environment.environment.TUO_SEND_ENV == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(environment, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

  });
}

void allPropatyCheckInit(EnvironmentJsonFile test)
{
  expect(test.environment.HOME, "");
  expect(test.environment.PATH, "");
  expect(test.environment.SHELL, "");
  expect(test.environment.BASE_ENV, "");
  expect(test.environment.LC_ALL, "");
  expect(test.environment.LANG, "");
  expect(test.environment.LINGUAS, "");
  expect(test.environment.TPRX_HOME, "");
  expect(test.environment.DISPLAY, "");
  expect(test.environment.WINDOW, "");
  expect(test.environment.CONTENT_LENGTH, "");
  expect(test.environment.PGPASSWORD, "");
  expect(test.environment.PGUSER, "");
  expect(test.environment.PGDATA, "");
  expect(test.environment.PGDATABASE, "");
  expect(test.environment.PGHOST, "");
  expect(test.environment.PGOPTIONS, "");
  expect(test.environment.PGPORT, "");
  expect(test.environment.PGTTY, "");
  expect(test.environment.PGCLIENTENCODING, "");
  expect(test.environment.SMX_HOME, "");
  expect(test.environment.TUO_SEND_ENV, "");
}

void allPropatyCheck(EnvironmentJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.environment.HOME, "/pj/tprx");
  }
  expect(test.environment.PATH, "");
  expect(test.environment.SHELL, "/bin/bash");
  expect(test.environment.BASE_ENV, "");
  expect(test.environment.LC_ALL, "");
  expect(test.environment.LANG, "");
  expect(test.environment.LINGUAS, "");
  expect(test.environment.TPRX_HOME, "/pj/tprx/");
  expect(test.environment.DISPLAY, "");
  expect(test.environment.WINDOW, "");
  expect(test.environment.CONTENT_LENGTH, "");
  expect(test.environment.PGPASSWORD, "");
  expect(test.environment.PGUSER, "");
  expect(test.environment.PGDATA, "/usr/local/pgsql/data");
  expect(test.environment.PGDATABASE, "");
  expect(test.environment.PGHOST, "");
  expect(test.environment.PGOPTIONS, "");
  expect(test.environment.PGPORT, "");
  expect(test.environment.PGTTY, "");
  expect(test.environment.PGCLIENTENCODING, "");
  expect(test.environment.SMX_HOME, "");
  expect(test.environment.TUO_SEND_ENV, "");
}

