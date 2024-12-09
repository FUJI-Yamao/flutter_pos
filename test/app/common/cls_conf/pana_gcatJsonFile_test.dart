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
import '../../../../lib/app/common/cls_conf/pana_gcatJsonFile.dart';

late Pana_gcatJsonFile pana_gcat;

void main(){
  pana_gcatJsonFile_test();
}

void pana_gcatJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "pana_gcat.json";
  const String section = "settings";
  const String key = "port";
  const defaultData = "com3";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Pana_gcatJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Pana_gcatJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Pana_gcatJsonFile().setDefault();
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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await pana_gcat.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(pana_gcat,true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        pana_gcat.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await pana_gcat.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(pana_gcat,true);

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
      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①：loadを実行する。
      await pana_gcat.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = pana_gcat.settings.port;
      pana_gcat.settings.port = testData1s;
      expect(pana_gcat.settings.port == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await pana_gcat.load();
      expect(pana_gcat.settings.port != testData1s, true);
      expect(pana_gcat.settings.port == prefixData, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = pana_gcat.settings.port;
      pana_gcat.settings.port = testData1s;
      expect(pana_gcat.settings.port, testData1s);

      // ③saveを実行する。
      await pana_gcat.save();

      // ④loadを実行する。
      await pana_gcat.load();

      expect(pana_gcat.settings.port != prefixData, true);
      expect(pana_gcat.settings.port == testData1s, true);
      allPropatyCheck(pana_gcat,false);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await pana_gcat.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await pana_gcat.save();

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await pana_gcat.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(pana_gcat.settings.port, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = pana_gcat.settings.port;
      pana_gcat.settings.port = testData1s;

      // ③ saveを実行する。
      await pana_gcat.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(pana_gcat.settings.port, testData1s);

      // ④ loadを実行する。
      await pana_gcat.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(pana_gcat.settings.port == testData1s, true);
      allPropatyCheck(pana_gcat,false);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await pana_gcat.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(pana_gcat,true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②任意のプロパティの値を変更する。
      pana_gcat.settings.port = testData1s;
      expect(pana_gcat.settings.port, testData1s);

      // ③saveを実行する。
      await pana_gcat.save();
      expect(pana_gcat.settings.port, testData1s);

      // ④loadを実行する。
      await pana_gcat.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(pana_gcat,true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await pana_gcat.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await pana_gcat.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(pana_gcat.settings.port == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await pana_gcat.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await pana_gcat.setValueWithName(section, "test_key", testData1s);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②任意のプロパティを変更する。
      pana_gcat.settings.port = testData1s;

      // ③saveを実行する。
      await pana_gcat.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pana_gcat.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②任意のプロパティを変更する。
      pana_gcat.settings.port = testData1s;

      // ③saveを実行する。
      await pana_gcat.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pana_gcat.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②任意のプロパティを変更する。
      pana_gcat.settings.port = testData1s;

      // ③saveを実行する。
      await pana_gcat.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await pana_gcat.getValueWithName(section, "test_key");
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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await pana_gcat.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      pana_gcat.settings.port = testData1s;
      expect(pana_gcat.settings.port, testData1s);

      // ④saveを実行する。
      await pana_gcat.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(pana_gcat.settings.port, testData1s);
      
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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await pana_gcat.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      expect(pana_gcat.settings.port == testData1s, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await pana_gcat.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      expect(pana_gcat.settings.port == testData2s, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await pana_gcat.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      expect(pana_gcat.settings.port == testData1s, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await pana_gcat.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      expect(pana_gcat.settings.port == testData2s, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await pana_gcat.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      expect(pana_gcat.settings.port == testData1s, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await pana_gcat.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      expect(pana_gcat.settings.port == testData1s, true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await pana_gcat.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      allPropatyCheck(pana_gcat,true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await pana_gcat.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + pana_gcat.settings.port.toString());
      allPropatyCheck(pana_gcat,true);

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

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.port;
      print(pana_gcat.settings.port);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.port = testData1s;
      print(pana_gcat.settings.port);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.port == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.port == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.port = testData2s;
      print(pana_gcat.settings.port);
      expect(pana_gcat.settings.port == testData2s, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.port == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.port = defalut;
      print(pana_gcat.settings.port);
      expect(pana_gcat.settings.port == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.port == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.baudrate;
      print(pana_gcat.settings.baudrate);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.baudrate = testData1;
      print(pana_gcat.settings.baudrate);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.baudrate == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.baudrate == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.baudrate = testData2;
      print(pana_gcat.settings.baudrate);
      expect(pana_gcat.settings.baudrate == testData2, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.baudrate == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.baudrate = defalut;
      print(pana_gcat.settings.baudrate);
      expect(pana_gcat.settings.baudrate == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.baudrate == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.databit;
      print(pana_gcat.settings.databit);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.databit = testData1;
      print(pana_gcat.settings.databit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.databit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.databit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.databit = testData2;
      print(pana_gcat.settings.databit);
      expect(pana_gcat.settings.databit == testData2, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.databit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.databit = defalut;
      print(pana_gcat.settings.databit);
      expect(pana_gcat.settings.databit == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.databit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.startbit;
      print(pana_gcat.settings.startbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.startbit = testData1;
      print(pana_gcat.settings.startbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.startbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.startbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.startbit = testData2;
      print(pana_gcat.settings.startbit);
      expect(pana_gcat.settings.startbit == testData2, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.startbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.startbit = defalut;
      print(pana_gcat.settings.startbit);
      expect(pana_gcat.settings.startbit == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.startbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.stopbit;
      print(pana_gcat.settings.stopbit);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.stopbit = testData1;
      print(pana_gcat.settings.stopbit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.stopbit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.stopbit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.stopbit = testData2;
      print(pana_gcat.settings.stopbit);
      expect(pana_gcat.settings.stopbit == testData2, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.stopbit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.stopbit = defalut;
      print(pana_gcat.settings.stopbit);
      expect(pana_gcat.settings.stopbit == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.stopbit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.parity;
      print(pana_gcat.settings.parity);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.parity = testData1s;
      print(pana_gcat.settings.parity);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.parity == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.parity == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.parity = testData2s;
      print(pana_gcat.settings.parity);
      expect(pana_gcat.settings.parity == testData2s, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.parity == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.parity = defalut;
      print(pana_gcat.settings.parity);
      expect(pana_gcat.settings.parity == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.parity == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.bill;
      print(pana_gcat.settings.bill);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.bill = testData1s;
      print(pana_gcat.settings.bill);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.bill == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.bill == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.bill = testData2s;
      print(pana_gcat.settings.bill);
      expect(pana_gcat.settings.bill == testData2s, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.bill == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.bill = defalut;
      print(pana_gcat.settings.bill);
      expect(pana_gcat.settings.bill == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.bill == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      pana_gcat = Pana_gcatJsonFile();
      allPropatyCheckInit(pana_gcat);

      // ①loadを実行する。
      await pana_gcat.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = pana_gcat.settings.tmout_nak_send;
      print(pana_gcat.settings.tmout_nak_send);

      // ②指定したプロパティにテストデータ1を書き込む。
      pana_gcat.settings.tmout_nak_send = testData1;
      print(pana_gcat.settings.tmout_nak_send);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(pana_gcat.settings.tmout_nak_send == testData1, true);

      // ④saveを実行後、loadを実行する。
      await pana_gcat.save();
      await pana_gcat.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(pana_gcat.settings.tmout_nak_send == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      pana_gcat.settings.tmout_nak_send = testData2;
      print(pana_gcat.settings.tmout_nak_send);
      expect(pana_gcat.settings.tmout_nak_send == testData2, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.tmout_nak_send == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      pana_gcat.settings.tmout_nak_send = defalut;
      print(pana_gcat.settings.tmout_nak_send);
      expect(pana_gcat.settings.tmout_nak_send == defalut, true);
      await pana_gcat.save();
      await pana_gcat.load();
      expect(pana_gcat.settings.tmout_nak_send == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(pana_gcat, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Pana_gcatJsonFile test)
{
  expect(test.settings.port, "");
  expect(test.settings.baudrate, 0);
  expect(test.settings.databit, 0);
  expect(test.settings.startbit, 0);
  expect(test.settings.stopbit, 0);
  expect(test.settings.parity, "");
  expect(test.settings.bill, "");
  expect(test.settings.tmout_nak_send, 0);
}

void allPropatyCheck(Pana_gcatJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.settings.port, "com3");
  }
  expect(test.settings.baudrate, 2400);
  expect(test.settings.databit, 8);
  expect(test.settings.startbit, 1);
  expect(test.settings.stopbit, 1);
  expect(test.settings.parity, "even");
  expect(test.settings.bill, "no");
  expect(test.settings.tmout_nak_send, 1);
}

