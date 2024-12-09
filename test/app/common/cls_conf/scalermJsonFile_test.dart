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
import '../../../../lib/app/common/cls_conf/scalermJsonFile.dart';

late ScalermJsonFile scalerm;

void main(){
  scalermJsonFile_test();
}

void scalermJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "scalerm.json";
  const String section = "settings";
  const String key = "port";
  const defaultData = "/dev/ttyS1";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('ScalermJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await ScalermJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await ScalermJsonFile().setDefault();
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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await scalerm.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(scalerm,true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        scalerm.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await scalerm.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(scalerm,true);

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
      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①：loadを実行する。
      await scalerm.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = scalerm.settings.port;
      scalerm.settings.port = testData1s;
      expect(scalerm.settings.port == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await scalerm.load();
      expect(scalerm.settings.port != testData1s, true);
      expect(scalerm.settings.port == prefixData, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = scalerm.settings.port;
      scalerm.settings.port = testData1s;
      expect(scalerm.settings.port, testData1s);

      // ③saveを実行する。
      await scalerm.save();

      // ④loadを実行する。
      await scalerm.load();

      expect(scalerm.settings.port != prefixData, true);
      expect(scalerm.settings.port == testData1s, true);
      allPropatyCheck(scalerm,false);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await scalerm.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await scalerm.save();

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await scalerm.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(scalerm.settings.port, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = scalerm.settings.port;
      scalerm.settings.port = testData1s;

      // ③ saveを実行する。
      await scalerm.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(scalerm.settings.port, testData1s);

      // ④ loadを実行する。
      await scalerm.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(scalerm.settings.port == testData1s, true);
      allPropatyCheck(scalerm,false);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await scalerm.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(scalerm,true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②任意のプロパティの値を変更する。
      scalerm.settings.port = testData1s;
      expect(scalerm.settings.port, testData1s);

      // ③saveを実行する。
      await scalerm.save();
      expect(scalerm.settings.port, testData1s);

      // ④loadを実行する。
      await scalerm.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(scalerm,true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await scalerm.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await scalerm.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(scalerm.settings.port == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await scalerm.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await scalerm.setValueWithName(section, "test_key", testData1s);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②任意のプロパティを変更する。
      scalerm.settings.port = testData1s;

      // ③saveを実行する。
      await scalerm.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await scalerm.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②任意のプロパティを変更する。
      scalerm.settings.port = testData1s;

      // ③saveを実行する。
      await scalerm.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await scalerm.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②任意のプロパティを変更する。
      scalerm.settings.port = testData1s;

      // ③saveを実行する。
      await scalerm.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await scalerm.getValueWithName(section, "test_key");
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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await scalerm.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      scalerm.settings.port = testData1s;
      expect(scalerm.settings.port, testData1s);

      // ④saveを実行する。
      await scalerm.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(scalerm.settings.port, testData1s);
      
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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await scalerm.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      expect(scalerm.settings.port == testData1s, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await scalerm.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      expect(scalerm.settings.port == testData2s, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await scalerm.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      expect(scalerm.settings.port == testData1s, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await scalerm.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      expect(scalerm.settings.port == testData2s, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await scalerm.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      expect(scalerm.settings.port == testData1s, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await scalerm.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      expect(scalerm.settings.port == testData1s, true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await scalerm.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      allPropatyCheck(scalerm,true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await scalerm.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + scalerm.settings.port.toString());
      allPropatyCheck(scalerm,true);

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

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.port;
      print(scalerm.settings.port);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.port = testData1s;
      print(scalerm.settings.port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.port == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.port == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.port = testData2s;
      print(scalerm.settings.port);
      expect(scalerm.settings.port == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.port == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.port = defalut;
      print(scalerm.settings.port);
      expect(scalerm.settings.port == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.port2;
      print(scalerm.settings.port2);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.port2 = testData1s;
      print(scalerm.settings.port2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.port2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.port2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.port2 = testData2s;
      print(scalerm.settings.port2);
      expect(scalerm.settings.port2 == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.port2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.port2 = defalut;
      print(scalerm.settings.port2);
      expect(scalerm.settings.port2 == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.port2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.baudrate;
      print(scalerm.settings.baudrate);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.baudrate = testData1;
      print(scalerm.settings.baudrate);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.baudrate == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.baudrate == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.baudrate = testData2;
      print(scalerm.settings.baudrate);
      expect(scalerm.settings.baudrate == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.baudrate == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.baudrate = defalut;
      print(scalerm.settings.baudrate);
      expect(scalerm.settings.baudrate == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.baudrate == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.databit;
      print(scalerm.settings.databit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.databit = testData1;
      print(scalerm.settings.databit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.databit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.databit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.databit = testData2;
      print(scalerm.settings.databit);
      expect(scalerm.settings.databit == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.databit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.databit = defalut;
      print(scalerm.settings.databit);
      expect(scalerm.settings.databit == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.databit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.startbit;
      print(scalerm.settings.startbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.startbit = testData1;
      print(scalerm.settings.startbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.startbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.startbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.startbit = testData2;
      print(scalerm.settings.startbit);
      expect(scalerm.settings.startbit == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.startbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.startbit = defalut;
      print(scalerm.settings.startbit);
      expect(scalerm.settings.startbit == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.startbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.stopbit;
      print(scalerm.settings.stopbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.stopbit = testData1;
      print(scalerm.settings.stopbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.stopbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.stopbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.stopbit = testData2;
      print(scalerm.settings.stopbit);
      expect(scalerm.settings.stopbit == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.stopbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.stopbit = defalut;
      print(scalerm.settings.stopbit);
      expect(scalerm.settings.stopbit == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.stopbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.parity;
      print(scalerm.settings.parity);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.parity = testData1s;
      print(scalerm.settings.parity);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.parity == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.parity == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.parity = testData2s;
      print(scalerm.settings.parity);
      expect(scalerm.settings.parity == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.parity == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.parity = defalut;
      print(scalerm.settings.parity);
      expect(scalerm.settings.parity == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.parity == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.bill;
      print(scalerm.settings.bill);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.bill = testData1s;
      print(scalerm.settings.bill);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.bill == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.bill == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.bill = testData2s;
      print(scalerm.settings.bill);
      expect(scalerm.settings.bill == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.bill == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.bill = defalut;
      print(scalerm.settings.bill);
      expect(scalerm.settings.bill == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.bill == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.id;
      print(scalerm.settings.id);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.id = testData1;
      print(scalerm.settings.id);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.id == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.id == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.id = testData2;
      print(scalerm.settings.id);
      expect(scalerm.settings.id == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.id == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.id = defalut;
      print(scalerm.settings.id);
      expect(scalerm.settings.id == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.id == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.stability_cond;
      print(scalerm.settings.stability_cond);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.stability_cond = testData1s;
      print(scalerm.settings.stability_cond);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.stability_cond == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.stability_cond == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.stability_cond = testData2s;
      print(scalerm.settings.stability_cond);
      expect(scalerm.settings.stability_cond == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.stability_cond == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.stability_cond = defalut;
      print(scalerm.settings.stability_cond);
      expect(scalerm.settings.stability_cond == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.stability_cond == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.tare_accumutation;
      print(scalerm.settings.tare_accumutation);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.tare_accumutation = testData1;
      print(scalerm.settings.tare_accumutation);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.tare_accumutation == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.tare_accumutation == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.tare_accumutation = testData2;
      print(scalerm.settings.tare_accumutation);
      expect(scalerm.settings.tare_accumutation == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_accumutation == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.tare_accumutation = defalut;
      print(scalerm.settings.tare_accumutation);
      expect(scalerm.settings.tare_accumutation == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_accumutation == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.tare_subtraction;
      print(scalerm.settings.tare_subtraction);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.tare_subtraction = testData1;
      print(scalerm.settings.tare_subtraction);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.tare_subtraction == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.tare_subtraction == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.tare_subtraction = testData2;
      print(scalerm.settings.tare_subtraction);
      expect(scalerm.settings.tare_subtraction == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_subtraction == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.tare_subtraction = defalut;
      print(scalerm.settings.tare_subtraction);
      expect(scalerm.settings.tare_subtraction == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_subtraction == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.start_range;
      print(scalerm.settings.start_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.start_range = testData1s;
      print(scalerm.settings.start_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.start_range == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.start_range == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.start_range = testData2s;
      print(scalerm.settings.start_range);
      expect(scalerm.settings.start_range == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.start_range == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.start_range = defalut;
      print(scalerm.settings.start_range);
      expect(scalerm.settings.start_range == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.start_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.auto_zero_reset;
      print(scalerm.settings.auto_zero_reset);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.auto_zero_reset = testData1;
      print(scalerm.settings.auto_zero_reset);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.auto_zero_reset == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.auto_zero_reset == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.auto_zero_reset = testData2;
      print(scalerm.settings.auto_zero_reset);
      expect(scalerm.settings.auto_zero_reset == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.auto_zero_reset == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.auto_zero_reset = defalut;
      print(scalerm.settings.auto_zero_reset);
      expect(scalerm.settings.auto_zero_reset == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.auto_zero_reset == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.auto_tare_clear;
      print(scalerm.settings.auto_tare_clear);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.auto_tare_clear = testData1;
      print(scalerm.settings.auto_tare_clear);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.auto_tare_clear == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.auto_tare_clear == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.auto_tare_clear = testData2;
      print(scalerm.settings.auto_tare_clear);
      expect(scalerm.settings.auto_tare_clear == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.auto_tare_clear == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.auto_tare_clear = defalut;
      print(scalerm.settings.auto_tare_clear);
      expect(scalerm.settings.auto_tare_clear == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.auto_tare_clear == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.priority_tare;
      print(scalerm.settings.priority_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.priority_tare = testData1;
      print(scalerm.settings.priority_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.priority_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.priority_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.priority_tare = testData2;
      print(scalerm.settings.priority_tare);
      expect(scalerm.settings.priority_tare == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.priority_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.priority_tare = defalut;
      print(scalerm.settings.priority_tare);
      expect(scalerm.settings.priority_tare == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.priority_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.auto_clear_cond;
      print(scalerm.settings.auto_clear_cond);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.auto_clear_cond = testData1;
      print(scalerm.settings.auto_clear_cond);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.auto_clear_cond == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.auto_clear_cond == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.auto_clear_cond = testData2;
      print(scalerm.settings.auto_clear_cond);
      expect(scalerm.settings.auto_clear_cond == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.auto_clear_cond == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.auto_clear_cond = defalut;
      print(scalerm.settings.auto_clear_cond);
      expect(scalerm.settings.auto_clear_cond == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.auto_clear_cond == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.tare_auto_clear;
      print(scalerm.settings.tare_auto_clear);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.tare_auto_clear = testData1;
      print(scalerm.settings.tare_auto_clear);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.tare_auto_clear == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.tare_auto_clear == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.tare_auto_clear = testData2;
      print(scalerm.settings.tare_auto_clear);
      expect(scalerm.settings.tare_auto_clear == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_auto_clear == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.tare_auto_clear = defalut;
      print(scalerm.settings.tare_auto_clear);
      expect(scalerm.settings.tare_auto_clear == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_auto_clear == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.zero_lamp;
      print(scalerm.settings.zero_lamp);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.zero_lamp = testData1;
      print(scalerm.settings.zero_lamp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.zero_lamp == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.zero_lamp == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.zero_lamp = testData2;
      print(scalerm.settings.zero_lamp);
      expect(scalerm.settings.zero_lamp == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.zero_lamp == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.zero_lamp = defalut;
      print(scalerm.settings.zero_lamp);
      expect(scalerm.settings.zero_lamp == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.zero_lamp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.manual_tare_cancel;
      print(scalerm.settings.manual_tare_cancel);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.manual_tare_cancel = testData1;
      print(scalerm.settings.manual_tare_cancel);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.manual_tare_cancel == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.manual_tare_cancel == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.manual_tare_cancel = testData2;
      print(scalerm.settings.manual_tare_cancel);
      expect(scalerm.settings.manual_tare_cancel == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.manual_tare_cancel == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.manual_tare_cancel = defalut;
      print(scalerm.settings.manual_tare_cancel);
      expect(scalerm.settings.manual_tare_cancel == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.manual_tare_cancel == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.digital_tare;
      print(scalerm.settings.digital_tare);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.digital_tare = testData1;
      print(scalerm.settings.digital_tare);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.digital_tare == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.digital_tare == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.digital_tare = testData2;
      print(scalerm.settings.digital_tare);
      expect(scalerm.settings.digital_tare == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.digital_tare == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.digital_tare = defalut;
      print(scalerm.settings.digital_tare);
      expect(scalerm.settings.digital_tare == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.digital_tare == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.weight_reset;
      print(scalerm.settings.weight_reset);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.weight_reset = testData1;
      print(scalerm.settings.weight_reset);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.weight_reset == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.weight_reset == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.weight_reset = testData2;
      print(scalerm.settings.weight_reset);
      expect(scalerm.settings.weight_reset == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.weight_reset == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.weight_reset = defalut;
      print(scalerm.settings.weight_reset);
      expect(scalerm.settings.weight_reset == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.weight_reset == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.zero_tracking;
      print(scalerm.settings.zero_tracking);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.zero_tracking = testData1;
      print(scalerm.settings.zero_tracking);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.zero_tracking == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.zero_tracking == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.zero_tracking = testData2;
      print(scalerm.settings.zero_tracking);
      expect(scalerm.settings.zero_tracking == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.zero_tracking == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.zero_tracking = defalut;
      print(scalerm.settings.zero_tracking);
      expect(scalerm.settings.zero_tracking == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.zero_tracking == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.pos_of_decimal_point;
      print(scalerm.settings.pos_of_decimal_point);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.pos_of_decimal_point = testData1s;
      print(scalerm.settings.pos_of_decimal_point);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.pos_of_decimal_point == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.pos_of_decimal_point == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.pos_of_decimal_point = testData2s;
      print(scalerm.settings.pos_of_decimal_point);
      expect(scalerm.settings.pos_of_decimal_point == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.pos_of_decimal_point == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.pos_of_decimal_point = defalut;
      print(scalerm.settings.pos_of_decimal_point);
      expect(scalerm.settings.pos_of_decimal_point == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.pos_of_decimal_point == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.rezero_range;
      print(scalerm.settings.rezero_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.rezero_range = testData1s;
      print(scalerm.settings.rezero_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.rezero_range == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.rezero_range == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.rezero_range = testData2s;
      print(scalerm.settings.rezero_range);
      expect(scalerm.settings.rezero_range == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.rezero_range == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.rezero_range = defalut;
      print(scalerm.settings.rezero_range);
      expect(scalerm.settings.rezero_range == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.rezero_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.rezero_func;
      print(scalerm.settings.rezero_func);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.rezero_func = testData1;
      print(scalerm.settings.rezero_func);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.rezero_func == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.rezero_func == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.rezero_func = testData2;
      print(scalerm.settings.rezero_func);
      expect(scalerm.settings.rezero_func == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.rezero_func == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.rezero_func = defalut;
      print(scalerm.settings.rezero_func);
      expect(scalerm.settings.rezero_func == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.rezero_func == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.single_or_multi;
      print(scalerm.settings.single_or_multi);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.single_or_multi = testData1;
      print(scalerm.settings.single_or_multi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.single_or_multi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.single_or_multi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.single_or_multi = testData2;
      print(scalerm.settings.single_or_multi);
      expect(scalerm.settings.single_or_multi == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.single_or_multi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.single_or_multi = defalut;
      print(scalerm.settings.single_or_multi);
      expect(scalerm.settings.single_or_multi == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.single_or_multi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.negative_disp;
      print(scalerm.settings.negative_disp);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.negative_disp = testData1s;
      print(scalerm.settings.negative_disp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.negative_disp == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.negative_disp == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.negative_disp = testData2s;
      print(scalerm.settings.negative_disp);
      expect(scalerm.settings.negative_disp == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.negative_disp == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.negative_disp = defalut;
      print(scalerm.settings.negative_disp);
      expect(scalerm.settings.negative_disp == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.negative_disp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.tare_range;
      print(scalerm.settings.tare_range);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.tare_range = testData1;
      print(scalerm.settings.tare_range);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.tare_range == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.tare_range == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.tare_range = testData2;
      print(scalerm.settings.tare_range);
      expect(scalerm.settings.tare_range == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_range == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.tare_range = defalut;
      print(scalerm.settings.tare_range);
      expect(scalerm.settings.tare_range == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.tare_range == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.type_of_point;
      print(scalerm.settings.type_of_point);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.type_of_point = testData1;
      print(scalerm.settings.type_of_point);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.type_of_point == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.type_of_point == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.type_of_point = testData2;
      print(scalerm.settings.type_of_point);
      expect(scalerm.settings.type_of_point == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.type_of_point == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.type_of_point = defalut;
      print(scalerm.settings.type_of_point);
      expect(scalerm.settings.type_of_point == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.type_of_point == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.settings.digital_filter;
      print(scalerm.settings.digital_filter);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.settings.digital_filter = testData1s;
      print(scalerm.settings.digital_filter);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.settings.digital_filter == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.settings.digital_filter == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.settings.digital_filter = testData2s;
      print(scalerm.settings.digital_filter);
      expect(scalerm.settings.digital_filter == testData2s, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.digital_filter == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.settings.digital_filter = defalut;
      print(scalerm.settings.digital_filter);
      expect(scalerm.settings.digital_filter == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.settings.digital_filter == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      scalerm = ScalermJsonFile();
      allPropatyCheckInit(scalerm);

      // ①loadを実行する。
      await scalerm.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = scalerm.info.version;
      print(scalerm.info.version);

      // ②指定したプロパティにテストデータ1を書き込む。
      scalerm.info.version = testData1;
      print(scalerm.info.version);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(scalerm.info.version == testData1, true);

      // ④saveを実行後、loadを実行する。
      await scalerm.save();
      await scalerm.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(scalerm.info.version == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      scalerm.info.version = testData2;
      print(scalerm.info.version);
      expect(scalerm.info.version == testData2, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.info.version == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      scalerm.info.version = defalut;
      print(scalerm.info.version);
      expect(scalerm.info.version == defalut, true);
      await scalerm.save();
      await scalerm.load();
      expect(scalerm.info.version == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(scalerm, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

  });
}

void allPropatyCheckInit(ScalermJsonFile test)
{
  expect(test.settings.port, "");
  expect(test.settings.port2, "");
  expect(test.settings.baudrate, 0);
  expect(test.settings.databit, 0);
  expect(test.settings.startbit, 0);
  expect(test.settings.stopbit, 0);
  expect(test.settings.parity, "");
  expect(test.settings.bill, "");
  expect(test.settings.id, 0);
  expect(test.settings.stability_cond, "");
  expect(test.settings.tare_accumutation, 0);
  expect(test.settings.tare_subtraction, 0);
  expect(test.settings.start_range, "");
  expect(test.settings.auto_zero_reset, 0);
  expect(test.settings.auto_tare_clear, 0);
  expect(test.settings.priority_tare, 0);
  expect(test.settings.auto_clear_cond, 0);
  expect(test.settings.tare_auto_clear, 0);
  expect(test.settings.zero_lamp, 0);
  expect(test.settings.manual_tare_cancel, 0);
  expect(test.settings.digital_tare, 0);
  expect(test.settings.weight_reset, 0);
  expect(test.settings.zero_tracking, 0);
  expect(test.settings.pos_of_decimal_point, "");
  expect(test.settings.rezero_range, "");
  expect(test.settings.rezero_func, 0);
  expect(test.settings.single_or_multi, 0);
  expect(test.settings.negative_disp, "");
  expect(test.settings.tare_range, 0);
  expect(test.settings.type_of_point, 0);
  expect(test.settings.digital_filter, "");
  expect(test.info.version, 0);
}

void allPropatyCheck(ScalermJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.settings.port, "/dev/ttyS1");
  }
  expect(test.settings.port2, "/dev/ttyS3");
  expect(test.settings.baudrate, 19200);
  expect(test.settings.databit, 8);
  expect(test.settings.startbit, 1);
  expect(test.settings.stopbit, 1);
  expect(test.settings.parity, "even");
  expect(test.settings.bill, "no");
  expect(test.settings.id, 1);
  expect(test.settings.stability_cond, "01");
  expect(test.settings.tare_accumutation, 0);
  expect(test.settings.tare_subtraction, 1);
  expect(test.settings.start_range, "00");
  expect(test.settings.auto_zero_reset, 1);
  expect(test.settings.auto_tare_clear, 0);
  expect(test.settings.priority_tare, 1);
  expect(test.settings.auto_clear_cond, 0);
  expect(test.settings.tare_auto_clear, 1);
  expect(test.settings.zero_lamp, 0);
  expect(test.settings.manual_tare_cancel, 0);
  expect(test.settings.digital_tare, 0);
  expect(test.settings.weight_reset, 0);
  expect(test.settings.zero_tracking, 0);
  expect(test.settings.pos_of_decimal_point, "000");
  expect(test.settings.rezero_range, "000");
  expect(test.settings.rezero_func, 0);
  expect(test.settings.single_or_multi, 1);
  expect(test.settings.negative_disp, "00");
  expect(test.settings.tare_range, 0);
  expect(test.settings.type_of_point, 0);
  expect(test.settings.digital_filter, "01");
  expect(test.info.version, 0);
}

