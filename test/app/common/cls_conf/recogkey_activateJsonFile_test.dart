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
import '../../../../lib/app/common/cls_conf/recogkey_activateJsonFile.dart';

late Recogkey_activateJsonFile recogkey_activate;

void main(){
  recogkey_activateJsonFile_test();
}

void recogkey_activateJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "recogkey_activate.json";
  const String section = "server";
  const String key = "head";
  const defaultData = "http://";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Recogkey_activateJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Recogkey_activateJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Recogkey_activateJsonFile().setDefault();
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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await recogkey_activate.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(recogkey_activate,true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        recogkey_activate.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await recogkey_activate.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(recogkey_activate,true);

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
      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①：loadを実行する。
      await recogkey_activate.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = recogkey_activate.server.head;
      recogkey_activate.server.head = testData1s;
      expect(recogkey_activate.server.head == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await recogkey_activate.load();
      expect(recogkey_activate.server.head != testData1s, true);
      expect(recogkey_activate.server.head == prefixData, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = recogkey_activate.server.head;
      recogkey_activate.server.head = testData1s;
      expect(recogkey_activate.server.head, testData1s);

      // ③saveを実行する。
      await recogkey_activate.save();

      // ④loadを実行する。
      await recogkey_activate.load();

      expect(recogkey_activate.server.head != prefixData, true);
      expect(recogkey_activate.server.head == testData1s, true);
      allPropatyCheck(recogkey_activate,false);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await recogkey_activate.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await recogkey_activate.save();

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await recogkey_activate.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(recogkey_activate.server.head, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = recogkey_activate.server.head;
      recogkey_activate.server.head = testData1s;

      // ③ saveを実行する。
      await recogkey_activate.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(recogkey_activate.server.head, testData1s);

      // ④ loadを実行する。
      await recogkey_activate.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(recogkey_activate.server.head == testData1s, true);
      allPropatyCheck(recogkey_activate,false);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await recogkey_activate.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(recogkey_activate,true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②任意のプロパティの値を変更する。
      recogkey_activate.server.head = testData1s;
      expect(recogkey_activate.server.head, testData1s);

      // ③saveを実行する。
      await recogkey_activate.save();
      expect(recogkey_activate.server.head, testData1s);

      // ④loadを実行する。
      await recogkey_activate.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(recogkey_activate,true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await recogkey_activate.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await recogkey_activate.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(recogkey_activate.server.head == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await recogkey_activate.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await recogkey_activate.setValueWithName(section, "test_key", testData1s);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②任意のプロパティを変更する。
      recogkey_activate.server.head = testData1s;

      // ③saveを実行する。
      await recogkey_activate.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await recogkey_activate.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②任意のプロパティを変更する。
      recogkey_activate.server.head = testData1s;

      // ③saveを実行する。
      await recogkey_activate.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await recogkey_activate.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②任意のプロパティを変更する。
      recogkey_activate.server.head = testData1s;

      // ③saveを実行する。
      await recogkey_activate.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await recogkey_activate.getValueWithName(section, "test_key");
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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await recogkey_activate.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      recogkey_activate.server.head = testData1s;
      expect(recogkey_activate.server.head, testData1s);

      // ④saveを実行する。
      await recogkey_activate.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(recogkey_activate.server.head, testData1s);
      
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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await recogkey_activate.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      expect(recogkey_activate.server.head == testData1s, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await recogkey_activate.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      expect(recogkey_activate.server.head == testData2s, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await recogkey_activate.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      expect(recogkey_activate.server.head == testData1s, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await recogkey_activate.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      expect(recogkey_activate.server.head == testData2s, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await recogkey_activate.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      expect(recogkey_activate.server.head == testData1s, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await recogkey_activate.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      expect(recogkey_activate.server.head == testData1s, true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await recogkey_activate.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      allPropatyCheck(recogkey_activate,true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await recogkey_activate.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + recogkey_activate.server.head.toString());
      allPropatyCheck(recogkey_activate,true);

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

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.head;
      print(recogkey_activate.server.head);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.head = testData1s;
      print(recogkey_activate.server.head);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.head == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.head == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.head = testData2s;
      print(recogkey_activate.server.head);
      expect(recogkey_activate.server.head == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.head == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.head = defalut;
      print(recogkey_activate.server.head);
      expect(recogkey_activate.server.head == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.head == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.host;
      print(recogkey_activate.server.host);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.host = testData1s;
      print(recogkey_activate.server.host);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.host == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.host == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.host = testData2s;
      print(recogkey_activate.server.host);
      expect(recogkey_activate.server.host == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.host == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.host = defalut;
      print(recogkey_activate.server.host);
      expect(recogkey_activate.server.host == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.host == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.url;
      print(recogkey_activate.server.url);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.url = testData1s;
      print(recogkey_activate.server.url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.url = testData2s;
      print(recogkey_activate.server.url);
      expect(recogkey_activate.server.url == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.url = defalut;
      print(recogkey_activate.server.url);
      expect(recogkey_activate.server.url == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.time_out;
      print(recogkey_activate.server.time_out);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.time_out = testData1;
      print(recogkey_activate.server.time_out);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.time_out == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.time_out == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.time_out = testData2;
      print(recogkey_activate.server.time_out);
      expect(recogkey_activate.server.time_out == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.time_out == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.time_out = defalut;
      print(recogkey_activate.server.time_out);
      expect(recogkey_activate.server.time_out == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.time_out == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.portal_user;
      print(recogkey_activate.server.portal_user);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.portal_user = testData1s;
      print(recogkey_activate.server.portal_user);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.portal_user == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.portal_user == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.portal_user = testData2s;
      print(recogkey_activate.server.portal_user);
      expect(recogkey_activate.server.portal_user == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.portal_user == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.portal_user = defalut;
      print(recogkey_activate.server.portal_user);
      expect(recogkey_activate.server.portal_user == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.portal_user == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.portal_pass;
      print(recogkey_activate.server.portal_pass);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.portal_pass = testData1s;
      print(recogkey_activate.server.portal_pass);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.portal_pass == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.portal_pass == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.portal_pass = testData2s;
      print(recogkey_activate.server.portal_pass);
      expect(recogkey_activate.server.portal_pass == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.portal_pass == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.portal_pass = defalut;
      print(recogkey_activate.server.portal_pass);
      expect(recogkey_activate.server.portal_pass == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.portal_pass == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.dns1;
      print(recogkey_activate.server.dns1);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.dns1 = testData1s;
      print(recogkey_activate.server.dns1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.dns1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.dns1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.dns1 = testData2s;
      print(recogkey_activate.server.dns1);
      expect(recogkey_activate.server.dns1 == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.dns1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.dns1 = defalut;
      print(recogkey_activate.server.dns1);
      expect(recogkey_activate.server.dns1 == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.dns1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.server.dns2;
      print(recogkey_activate.server.dns2);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.server.dns2 = testData1s;
      print(recogkey_activate.server.dns2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.server.dns2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.server.dns2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.server.dns2 = testData2s;
      print(recogkey_activate.server.dns2);
      expect(recogkey_activate.server.dns2 == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.dns2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.server.dns2 = defalut;
      print(recogkey_activate.server.dns2);
      expect(recogkey_activate.server.dns2 == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.server.dns2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.DATE.date;
      print(recogkey_activate.DATE.date);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.DATE.date = testData1;
      print(recogkey_activate.DATE.date);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.DATE.date == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.DATE.date == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.DATE.date = testData2;
      print(recogkey_activate.DATE.date);
      expect(recogkey_activate.DATE.date == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.DATE.date == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.DATE.date = defalut;
      print(recogkey_activate.DATE.date);
      expect(recogkey_activate.DATE.date == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.DATE.date == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.common.limit;
      print(recogkey_activate.common.limit);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.common.limit = testData1;
      print(recogkey_activate.common.limit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.common.limit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.common.limit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.common.limit = testData2;
      print(recogkey_activate.common.limit);
      expect(recogkey_activate.common.limit == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.common.limit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.common.limit = defalut;
      print(recogkey_activate.common.limit);
      expect(recogkey_activate.common.limit == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.common.limit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.common.mac_addr;
      print(recogkey_activate.common.mac_addr);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.common.mac_addr = testData1s;
      print(recogkey_activate.common.mac_addr);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.common.mac_addr == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.common.mac_addr == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.common.mac_addr = testData2s;
      print(recogkey_activate.common.mac_addr);
      expect(recogkey_activate.common.mac_addr == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.common.mac_addr == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.common.mac_addr = defalut;
      print(recogkey_activate.common.mac_addr);
      expect(recogkey_activate.common.mac_addr == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.common.mac_addr == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.common.chg_flg;
      print(recogkey_activate.common.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.common.chg_flg = testData1;
      print(recogkey_activate.common.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.common.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.common.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.common.chg_flg = testData2;
      print(recogkey_activate.common.chg_flg);
      expect(recogkey_activate.common.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.common.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.common.chg_flg = defalut;
      print(recogkey_activate.common.chg_flg);
      expect(recogkey_activate.common.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.common.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page1.password;
      print(recogkey_activate.page1.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page1.password = testData1s;
      print(recogkey_activate.page1.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page1.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page1.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page1.password = testData2s;
      print(recogkey_activate.page1.password);
      expect(recogkey_activate.page1.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page1.password = defalut;
      print(recogkey_activate.page1.password);
      expect(recogkey_activate.page1.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page1.fcode;
      print(recogkey_activate.page1.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page1.fcode = testData1s;
      print(recogkey_activate.page1.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page1.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page1.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page1.fcode = testData2s;
      print(recogkey_activate.page1.fcode);
      expect(recogkey_activate.page1.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page1.fcode = defalut;
      print(recogkey_activate.page1.fcode);
      expect(recogkey_activate.page1.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page1.chg_flg;
      print(recogkey_activate.page1.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page1.chg_flg = testData1;
      print(recogkey_activate.page1.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page1.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page1.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page1.chg_flg = testData2;
      print(recogkey_activate.page1.chg_flg);
      expect(recogkey_activate.page1.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page1.chg_flg = defalut;
      print(recogkey_activate.page1.chg_flg);
      expect(recogkey_activate.page1.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page1.type;
      print(recogkey_activate.page1.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page1.type = testData1s;
      print(recogkey_activate.page1.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page1.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page1.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page1.type = testData2s;
      print(recogkey_activate.page1.type);
      expect(recogkey_activate.page1.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page1.type = defalut;
      print(recogkey_activate.page1.type);
      expect(recogkey_activate.page1.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page1.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page2.password;
      print(recogkey_activate.page2.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page2.password = testData1s;
      print(recogkey_activate.page2.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page2.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page2.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page2.password = testData2s;
      print(recogkey_activate.page2.password);
      expect(recogkey_activate.page2.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page2.password = defalut;
      print(recogkey_activate.page2.password);
      expect(recogkey_activate.page2.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page2.fcode;
      print(recogkey_activate.page2.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page2.fcode = testData1s;
      print(recogkey_activate.page2.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page2.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page2.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page2.fcode = testData2s;
      print(recogkey_activate.page2.fcode);
      expect(recogkey_activate.page2.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page2.fcode = defalut;
      print(recogkey_activate.page2.fcode);
      expect(recogkey_activate.page2.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page2.chg_flg;
      print(recogkey_activate.page2.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page2.chg_flg = testData1;
      print(recogkey_activate.page2.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page2.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page2.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page2.chg_flg = testData2;
      print(recogkey_activate.page2.chg_flg);
      expect(recogkey_activate.page2.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page2.chg_flg = defalut;
      print(recogkey_activate.page2.chg_flg);
      expect(recogkey_activate.page2.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page2.type;
      print(recogkey_activate.page2.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page2.type = testData1s;
      print(recogkey_activate.page2.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page2.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page2.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page2.type = testData2s;
      print(recogkey_activate.page2.type);
      expect(recogkey_activate.page2.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page2.type = defalut;
      print(recogkey_activate.page2.type);
      expect(recogkey_activate.page2.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page2.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page3.password;
      print(recogkey_activate.page3.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page3.password = testData1s;
      print(recogkey_activate.page3.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page3.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page3.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page3.password = testData2s;
      print(recogkey_activate.page3.password);
      expect(recogkey_activate.page3.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page3.password = defalut;
      print(recogkey_activate.page3.password);
      expect(recogkey_activate.page3.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page3.fcode;
      print(recogkey_activate.page3.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page3.fcode = testData1s;
      print(recogkey_activate.page3.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page3.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page3.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page3.fcode = testData2s;
      print(recogkey_activate.page3.fcode);
      expect(recogkey_activate.page3.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page3.fcode = defalut;
      print(recogkey_activate.page3.fcode);
      expect(recogkey_activate.page3.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page3.chg_flg;
      print(recogkey_activate.page3.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page3.chg_flg = testData1;
      print(recogkey_activate.page3.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page3.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page3.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page3.chg_flg = testData2;
      print(recogkey_activate.page3.chg_flg);
      expect(recogkey_activate.page3.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page3.chg_flg = defalut;
      print(recogkey_activate.page3.chg_flg);
      expect(recogkey_activate.page3.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page3.type;
      print(recogkey_activate.page3.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page3.type = testData1s;
      print(recogkey_activate.page3.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page3.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page3.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page3.type = testData2s;
      print(recogkey_activate.page3.type);
      expect(recogkey_activate.page3.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page3.type = defalut;
      print(recogkey_activate.page3.type);
      expect(recogkey_activate.page3.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page3.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page4.password;
      print(recogkey_activate.page4.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page4.password = testData1s;
      print(recogkey_activate.page4.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page4.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page4.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page4.password = testData2s;
      print(recogkey_activate.page4.password);
      expect(recogkey_activate.page4.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page4.password = defalut;
      print(recogkey_activate.page4.password);
      expect(recogkey_activate.page4.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page4.fcode;
      print(recogkey_activate.page4.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page4.fcode = testData1s;
      print(recogkey_activate.page4.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page4.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page4.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page4.fcode = testData2s;
      print(recogkey_activate.page4.fcode);
      expect(recogkey_activate.page4.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page4.fcode = defalut;
      print(recogkey_activate.page4.fcode);
      expect(recogkey_activate.page4.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page4.chg_flg;
      print(recogkey_activate.page4.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page4.chg_flg = testData1;
      print(recogkey_activate.page4.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page4.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page4.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page4.chg_flg = testData2;
      print(recogkey_activate.page4.chg_flg);
      expect(recogkey_activate.page4.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page4.chg_flg = defalut;
      print(recogkey_activate.page4.chg_flg);
      expect(recogkey_activate.page4.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page4.type;
      print(recogkey_activate.page4.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page4.type = testData1s;
      print(recogkey_activate.page4.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page4.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page4.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page4.type = testData2s;
      print(recogkey_activate.page4.type);
      expect(recogkey_activate.page4.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page4.type = defalut;
      print(recogkey_activate.page4.type);
      expect(recogkey_activate.page4.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page4.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page5.password;
      print(recogkey_activate.page5.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page5.password = testData1s;
      print(recogkey_activate.page5.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page5.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page5.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page5.password = testData2s;
      print(recogkey_activate.page5.password);
      expect(recogkey_activate.page5.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page5.password = defalut;
      print(recogkey_activate.page5.password);
      expect(recogkey_activate.page5.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page5.fcode;
      print(recogkey_activate.page5.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page5.fcode = testData1s;
      print(recogkey_activate.page5.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page5.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page5.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page5.fcode = testData2s;
      print(recogkey_activate.page5.fcode);
      expect(recogkey_activate.page5.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page5.fcode = defalut;
      print(recogkey_activate.page5.fcode);
      expect(recogkey_activate.page5.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page5.chg_flg;
      print(recogkey_activate.page5.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page5.chg_flg = testData1;
      print(recogkey_activate.page5.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page5.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page5.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page5.chg_flg = testData2;
      print(recogkey_activate.page5.chg_flg);
      expect(recogkey_activate.page5.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page5.chg_flg = defalut;
      print(recogkey_activate.page5.chg_flg);
      expect(recogkey_activate.page5.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page5.type;
      print(recogkey_activate.page5.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page5.type = testData1s;
      print(recogkey_activate.page5.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page5.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page5.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page5.type = testData2s;
      print(recogkey_activate.page5.type);
      expect(recogkey_activate.page5.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page5.type = defalut;
      print(recogkey_activate.page5.type);
      expect(recogkey_activate.page5.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page5.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page6.password;
      print(recogkey_activate.page6.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page6.password = testData1s;
      print(recogkey_activate.page6.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page6.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page6.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page6.password = testData2s;
      print(recogkey_activate.page6.password);
      expect(recogkey_activate.page6.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page6.password = defalut;
      print(recogkey_activate.page6.password);
      expect(recogkey_activate.page6.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page6.fcode;
      print(recogkey_activate.page6.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page6.fcode = testData1s;
      print(recogkey_activate.page6.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page6.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page6.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page6.fcode = testData2s;
      print(recogkey_activate.page6.fcode);
      expect(recogkey_activate.page6.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page6.fcode = defalut;
      print(recogkey_activate.page6.fcode);
      expect(recogkey_activate.page6.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page6.chg_flg;
      print(recogkey_activate.page6.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page6.chg_flg = testData1;
      print(recogkey_activate.page6.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page6.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page6.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page6.chg_flg = testData2;
      print(recogkey_activate.page6.chg_flg);
      expect(recogkey_activate.page6.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page6.chg_flg = defalut;
      print(recogkey_activate.page6.chg_flg);
      expect(recogkey_activate.page6.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page6.type;
      print(recogkey_activate.page6.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page6.type = testData1s;
      print(recogkey_activate.page6.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page6.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page6.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page6.type = testData2s;
      print(recogkey_activate.page6.type);
      expect(recogkey_activate.page6.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page6.type = defalut;
      print(recogkey_activate.page6.type);
      expect(recogkey_activate.page6.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page6.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page7.password;
      print(recogkey_activate.page7.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page7.password = testData1s;
      print(recogkey_activate.page7.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page7.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page7.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page7.password = testData2s;
      print(recogkey_activate.page7.password);
      expect(recogkey_activate.page7.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page7.password = defalut;
      print(recogkey_activate.page7.password);
      expect(recogkey_activate.page7.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page7.fcode;
      print(recogkey_activate.page7.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page7.fcode = testData1s;
      print(recogkey_activate.page7.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page7.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page7.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page7.fcode = testData2s;
      print(recogkey_activate.page7.fcode);
      expect(recogkey_activate.page7.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page7.fcode = defalut;
      print(recogkey_activate.page7.fcode);
      expect(recogkey_activate.page7.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page7.chg_flg;
      print(recogkey_activate.page7.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page7.chg_flg = testData1;
      print(recogkey_activate.page7.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page7.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page7.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page7.chg_flg = testData2;
      print(recogkey_activate.page7.chg_flg);
      expect(recogkey_activate.page7.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page7.chg_flg = defalut;
      print(recogkey_activate.page7.chg_flg);
      expect(recogkey_activate.page7.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page7.type;
      print(recogkey_activate.page7.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page7.type = testData1s;
      print(recogkey_activate.page7.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page7.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page7.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page7.type = testData2s;
      print(recogkey_activate.page7.type);
      expect(recogkey_activate.page7.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page7.type = defalut;
      print(recogkey_activate.page7.type);
      expect(recogkey_activate.page7.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page7.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page8.password;
      print(recogkey_activate.page8.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page8.password = testData1s;
      print(recogkey_activate.page8.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page8.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page8.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page8.password = testData2s;
      print(recogkey_activate.page8.password);
      expect(recogkey_activate.page8.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page8.password = defalut;
      print(recogkey_activate.page8.password);
      expect(recogkey_activate.page8.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page8.fcode;
      print(recogkey_activate.page8.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page8.fcode = testData1s;
      print(recogkey_activate.page8.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page8.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page8.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page8.fcode = testData2s;
      print(recogkey_activate.page8.fcode);
      expect(recogkey_activate.page8.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page8.fcode = defalut;
      print(recogkey_activate.page8.fcode);
      expect(recogkey_activate.page8.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page8.chg_flg;
      print(recogkey_activate.page8.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page8.chg_flg = testData1;
      print(recogkey_activate.page8.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page8.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page8.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page8.chg_flg = testData2;
      print(recogkey_activate.page8.chg_flg);
      expect(recogkey_activate.page8.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page8.chg_flg = defalut;
      print(recogkey_activate.page8.chg_flg);
      expect(recogkey_activate.page8.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page8.type;
      print(recogkey_activate.page8.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page8.type = testData1s;
      print(recogkey_activate.page8.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page8.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page8.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page8.type = testData2s;
      print(recogkey_activate.page8.type);
      expect(recogkey_activate.page8.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page8.type = defalut;
      print(recogkey_activate.page8.type);
      expect(recogkey_activate.page8.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page8.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page9.password;
      print(recogkey_activate.page9.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page9.password = testData1s;
      print(recogkey_activate.page9.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page9.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page9.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page9.password = testData2s;
      print(recogkey_activate.page9.password);
      expect(recogkey_activate.page9.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page9.password = defalut;
      print(recogkey_activate.page9.password);
      expect(recogkey_activate.page9.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page9.fcode;
      print(recogkey_activate.page9.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page9.fcode = testData1s;
      print(recogkey_activate.page9.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page9.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page9.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page9.fcode = testData2s;
      print(recogkey_activate.page9.fcode);
      expect(recogkey_activate.page9.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page9.fcode = defalut;
      print(recogkey_activate.page9.fcode);
      expect(recogkey_activate.page9.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page9.chg_flg;
      print(recogkey_activate.page9.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page9.chg_flg = testData1;
      print(recogkey_activate.page9.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page9.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page9.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page9.chg_flg = testData2;
      print(recogkey_activate.page9.chg_flg);
      expect(recogkey_activate.page9.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page9.chg_flg = defalut;
      print(recogkey_activate.page9.chg_flg);
      expect(recogkey_activate.page9.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page9.type;
      print(recogkey_activate.page9.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page9.type = testData1s;
      print(recogkey_activate.page9.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page9.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page9.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page9.type = testData2s;
      print(recogkey_activate.page9.type);
      expect(recogkey_activate.page9.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page9.type = defalut;
      print(recogkey_activate.page9.type);
      expect(recogkey_activate.page9.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page9.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page10.password;
      print(recogkey_activate.page10.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page10.password = testData1s;
      print(recogkey_activate.page10.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page10.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page10.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page10.password = testData2s;
      print(recogkey_activate.page10.password);
      expect(recogkey_activate.page10.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page10.password = defalut;
      print(recogkey_activate.page10.password);
      expect(recogkey_activate.page10.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page10.fcode;
      print(recogkey_activate.page10.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page10.fcode = testData1s;
      print(recogkey_activate.page10.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page10.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page10.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page10.fcode = testData2s;
      print(recogkey_activate.page10.fcode);
      expect(recogkey_activate.page10.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page10.fcode = defalut;
      print(recogkey_activate.page10.fcode);
      expect(recogkey_activate.page10.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page10.chg_flg;
      print(recogkey_activate.page10.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page10.chg_flg = testData1;
      print(recogkey_activate.page10.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page10.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page10.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page10.chg_flg = testData2;
      print(recogkey_activate.page10.chg_flg);
      expect(recogkey_activate.page10.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page10.chg_flg = defalut;
      print(recogkey_activate.page10.chg_flg);
      expect(recogkey_activate.page10.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page10.type;
      print(recogkey_activate.page10.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page10.type = testData1s;
      print(recogkey_activate.page10.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page10.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page10.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page10.type = testData2s;
      print(recogkey_activate.page10.type);
      expect(recogkey_activate.page10.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page10.type = defalut;
      print(recogkey_activate.page10.type);
      expect(recogkey_activate.page10.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page10.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page11.password;
      print(recogkey_activate.page11.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page11.password = testData1s;
      print(recogkey_activate.page11.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page11.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page11.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page11.password = testData2s;
      print(recogkey_activate.page11.password);
      expect(recogkey_activate.page11.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page11.password = defalut;
      print(recogkey_activate.page11.password);
      expect(recogkey_activate.page11.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page11.fcode;
      print(recogkey_activate.page11.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page11.fcode = testData1s;
      print(recogkey_activate.page11.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page11.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page11.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page11.fcode = testData2s;
      print(recogkey_activate.page11.fcode);
      expect(recogkey_activate.page11.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page11.fcode = defalut;
      print(recogkey_activate.page11.fcode);
      expect(recogkey_activate.page11.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page11.chg_flg;
      print(recogkey_activate.page11.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page11.chg_flg = testData1;
      print(recogkey_activate.page11.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page11.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page11.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page11.chg_flg = testData2;
      print(recogkey_activate.page11.chg_flg);
      expect(recogkey_activate.page11.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page11.chg_flg = defalut;
      print(recogkey_activate.page11.chg_flg);
      expect(recogkey_activate.page11.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page11.type;
      print(recogkey_activate.page11.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page11.type = testData1s;
      print(recogkey_activate.page11.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page11.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page11.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page11.type = testData2s;
      print(recogkey_activate.page11.type);
      expect(recogkey_activate.page11.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page11.type = defalut;
      print(recogkey_activate.page11.type);
      expect(recogkey_activate.page11.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page11.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page12.password;
      print(recogkey_activate.page12.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page12.password = testData1s;
      print(recogkey_activate.page12.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page12.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page12.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page12.password = testData2s;
      print(recogkey_activate.page12.password);
      expect(recogkey_activate.page12.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page12.password = defalut;
      print(recogkey_activate.page12.password);
      expect(recogkey_activate.page12.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page12.fcode;
      print(recogkey_activate.page12.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page12.fcode = testData1s;
      print(recogkey_activate.page12.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page12.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page12.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page12.fcode = testData2s;
      print(recogkey_activate.page12.fcode);
      expect(recogkey_activate.page12.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page12.fcode = defalut;
      print(recogkey_activate.page12.fcode);
      expect(recogkey_activate.page12.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page12.chg_flg;
      print(recogkey_activate.page12.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page12.chg_flg = testData1;
      print(recogkey_activate.page12.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page12.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page12.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page12.chg_flg = testData2;
      print(recogkey_activate.page12.chg_flg);
      expect(recogkey_activate.page12.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page12.chg_flg = defalut;
      print(recogkey_activate.page12.chg_flg);
      expect(recogkey_activate.page12.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page12.type;
      print(recogkey_activate.page12.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page12.type = testData1s;
      print(recogkey_activate.page12.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page12.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page12.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page12.type = testData2s;
      print(recogkey_activate.page12.type);
      expect(recogkey_activate.page12.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page12.type = defalut;
      print(recogkey_activate.page12.type);
      expect(recogkey_activate.page12.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page12.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page13.password;
      print(recogkey_activate.page13.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page13.password = testData1s;
      print(recogkey_activate.page13.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page13.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page13.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page13.password = testData2s;
      print(recogkey_activate.page13.password);
      expect(recogkey_activate.page13.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page13.password = defalut;
      print(recogkey_activate.page13.password);
      expect(recogkey_activate.page13.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page13.fcode;
      print(recogkey_activate.page13.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page13.fcode = testData1s;
      print(recogkey_activate.page13.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page13.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page13.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page13.fcode = testData2s;
      print(recogkey_activate.page13.fcode);
      expect(recogkey_activate.page13.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page13.fcode = defalut;
      print(recogkey_activate.page13.fcode);
      expect(recogkey_activate.page13.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page13.chg_flg;
      print(recogkey_activate.page13.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page13.chg_flg = testData1;
      print(recogkey_activate.page13.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page13.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page13.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page13.chg_flg = testData2;
      print(recogkey_activate.page13.chg_flg);
      expect(recogkey_activate.page13.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page13.chg_flg = defalut;
      print(recogkey_activate.page13.chg_flg);
      expect(recogkey_activate.page13.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page13.type;
      print(recogkey_activate.page13.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page13.type = testData1s;
      print(recogkey_activate.page13.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page13.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page13.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page13.type = testData2s;
      print(recogkey_activate.page13.type);
      expect(recogkey_activate.page13.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page13.type = defalut;
      print(recogkey_activate.page13.type);
      expect(recogkey_activate.page13.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page13.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page14.password;
      print(recogkey_activate.page14.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page14.password = testData1s;
      print(recogkey_activate.page14.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page14.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page14.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page14.password = testData2s;
      print(recogkey_activate.page14.password);
      expect(recogkey_activate.page14.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page14.password = defalut;
      print(recogkey_activate.page14.password);
      expect(recogkey_activate.page14.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page14.fcode;
      print(recogkey_activate.page14.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page14.fcode = testData1s;
      print(recogkey_activate.page14.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page14.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page14.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page14.fcode = testData2s;
      print(recogkey_activate.page14.fcode);
      expect(recogkey_activate.page14.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page14.fcode = defalut;
      print(recogkey_activate.page14.fcode);
      expect(recogkey_activate.page14.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page14.chg_flg;
      print(recogkey_activate.page14.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page14.chg_flg = testData1;
      print(recogkey_activate.page14.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page14.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page14.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page14.chg_flg = testData2;
      print(recogkey_activate.page14.chg_flg);
      expect(recogkey_activate.page14.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page14.chg_flg = defalut;
      print(recogkey_activate.page14.chg_flg);
      expect(recogkey_activate.page14.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page14.type;
      print(recogkey_activate.page14.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page14.type = testData1s;
      print(recogkey_activate.page14.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page14.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page14.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page14.type = testData2s;
      print(recogkey_activate.page14.type);
      expect(recogkey_activate.page14.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page14.type = defalut;
      print(recogkey_activate.page14.type);
      expect(recogkey_activate.page14.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page14.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page15.password;
      print(recogkey_activate.page15.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page15.password = testData1s;
      print(recogkey_activate.page15.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page15.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page15.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page15.password = testData2s;
      print(recogkey_activate.page15.password);
      expect(recogkey_activate.page15.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page15.password = defalut;
      print(recogkey_activate.page15.password);
      expect(recogkey_activate.page15.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page15.fcode;
      print(recogkey_activate.page15.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page15.fcode = testData1s;
      print(recogkey_activate.page15.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page15.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page15.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page15.fcode = testData2s;
      print(recogkey_activate.page15.fcode);
      expect(recogkey_activate.page15.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page15.fcode = defalut;
      print(recogkey_activate.page15.fcode);
      expect(recogkey_activate.page15.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page15.chg_flg;
      print(recogkey_activate.page15.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page15.chg_flg = testData1;
      print(recogkey_activate.page15.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page15.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page15.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page15.chg_flg = testData2;
      print(recogkey_activate.page15.chg_flg);
      expect(recogkey_activate.page15.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page15.chg_flg = defalut;
      print(recogkey_activate.page15.chg_flg);
      expect(recogkey_activate.page15.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page15.type;
      print(recogkey_activate.page15.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page15.type = testData1s;
      print(recogkey_activate.page15.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page15.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page15.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page15.type = testData2s;
      print(recogkey_activate.page15.type);
      expect(recogkey_activate.page15.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page15.type = defalut;
      print(recogkey_activate.page15.type);
      expect(recogkey_activate.page15.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page15.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page16.password;
      print(recogkey_activate.page16.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page16.password = testData1s;
      print(recogkey_activate.page16.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page16.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page16.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page16.password = testData2s;
      print(recogkey_activate.page16.password);
      expect(recogkey_activate.page16.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page16.password = defalut;
      print(recogkey_activate.page16.password);
      expect(recogkey_activate.page16.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page16.fcode;
      print(recogkey_activate.page16.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page16.fcode = testData1s;
      print(recogkey_activate.page16.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page16.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page16.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page16.fcode = testData2s;
      print(recogkey_activate.page16.fcode);
      expect(recogkey_activate.page16.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page16.fcode = defalut;
      print(recogkey_activate.page16.fcode);
      expect(recogkey_activate.page16.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page16.chg_flg;
      print(recogkey_activate.page16.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page16.chg_flg = testData1;
      print(recogkey_activate.page16.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page16.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page16.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page16.chg_flg = testData2;
      print(recogkey_activate.page16.chg_flg);
      expect(recogkey_activate.page16.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page16.chg_flg = defalut;
      print(recogkey_activate.page16.chg_flg);
      expect(recogkey_activate.page16.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page16.type;
      print(recogkey_activate.page16.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page16.type = testData1s;
      print(recogkey_activate.page16.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page16.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page16.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page16.type = testData2s;
      print(recogkey_activate.page16.type);
      expect(recogkey_activate.page16.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page16.type = defalut;
      print(recogkey_activate.page16.type);
      expect(recogkey_activate.page16.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page16.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page17.password;
      print(recogkey_activate.page17.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page17.password = testData1s;
      print(recogkey_activate.page17.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page17.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page17.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page17.password = testData2s;
      print(recogkey_activate.page17.password);
      expect(recogkey_activate.page17.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page17.password = defalut;
      print(recogkey_activate.page17.password);
      expect(recogkey_activate.page17.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page17.fcode;
      print(recogkey_activate.page17.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page17.fcode = testData1s;
      print(recogkey_activate.page17.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page17.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page17.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page17.fcode = testData2s;
      print(recogkey_activate.page17.fcode);
      expect(recogkey_activate.page17.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page17.fcode = defalut;
      print(recogkey_activate.page17.fcode);
      expect(recogkey_activate.page17.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page17.chg_flg;
      print(recogkey_activate.page17.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page17.chg_flg = testData1;
      print(recogkey_activate.page17.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page17.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page17.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page17.chg_flg = testData2;
      print(recogkey_activate.page17.chg_flg);
      expect(recogkey_activate.page17.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page17.chg_flg = defalut;
      print(recogkey_activate.page17.chg_flg);
      expect(recogkey_activate.page17.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page17.type;
      print(recogkey_activate.page17.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page17.type = testData1s;
      print(recogkey_activate.page17.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page17.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page17.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page17.type = testData2s;
      print(recogkey_activate.page17.type);
      expect(recogkey_activate.page17.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page17.type = defalut;
      print(recogkey_activate.page17.type);
      expect(recogkey_activate.page17.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page17.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page18.password;
      print(recogkey_activate.page18.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page18.password = testData1s;
      print(recogkey_activate.page18.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page18.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page18.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page18.password = testData2s;
      print(recogkey_activate.page18.password);
      expect(recogkey_activate.page18.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page18.password = defalut;
      print(recogkey_activate.page18.password);
      expect(recogkey_activate.page18.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page18.fcode;
      print(recogkey_activate.page18.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page18.fcode = testData1s;
      print(recogkey_activate.page18.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page18.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page18.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page18.fcode = testData2s;
      print(recogkey_activate.page18.fcode);
      expect(recogkey_activate.page18.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page18.fcode = defalut;
      print(recogkey_activate.page18.fcode);
      expect(recogkey_activate.page18.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page18.chg_flg;
      print(recogkey_activate.page18.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page18.chg_flg = testData1;
      print(recogkey_activate.page18.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page18.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page18.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page18.chg_flg = testData2;
      print(recogkey_activate.page18.chg_flg);
      expect(recogkey_activate.page18.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page18.chg_flg = defalut;
      print(recogkey_activate.page18.chg_flg);
      expect(recogkey_activate.page18.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page18.type;
      print(recogkey_activate.page18.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page18.type = testData1s;
      print(recogkey_activate.page18.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page18.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page18.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page18.type = testData2s;
      print(recogkey_activate.page18.type);
      expect(recogkey_activate.page18.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page18.type = defalut;
      print(recogkey_activate.page18.type);
      expect(recogkey_activate.page18.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page18.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page19.password;
      print(recogkey_activate.page19.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page19.password = testData1s;
      print(recogkey_activate.page19.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page19.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page19.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page19.password = testData2s;
      print(recogkey_activate.page19.password);
      expect(recogkey_activate.page19.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page19.password = defalut;
      print(recogkey_activate.page19.password);
      expect(recogkey_activate.page19.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page19.fcode;
      print(recogkey_activate.page19.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page19.fcode = testData1s;
      print(recogkey_activate.page19.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page19.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page19.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page19.fcode = testData2s;
      print(recogkey_activate.page19.fcode);
      expect(recogkey_activate.page19.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page19.fcode = defalut;
      print(recogkey_activate.page19.fcode);
      expect(recogkey_activate.page19.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page19.chg_flg;
      print(recogkey_activate.page19.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page19.chg_flg = testData1;
      print(recogkey_activate.page19.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page19.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page19.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page19.chg_flg = testData2;
      print(recogkey_activate.page19.chg_flg);
      expect(recogkey_activate.page19.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page19.chg_flg = defalut;
      print(recogkey_activate.page19.chg_flg);
      expect(recogkey_activate.page19.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page19.type;
      print(recogkey_activate.page19.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page19.type = testData1s;
      print(recogkey_activate.page19.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page19.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page19.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page19.type = testData2s;
      print(recogkey_activate.page19.type);
      expect(recogkey_activate.page19.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page19.type = defalut;
      print(recogkey_activate.page19.type);
      expect(recogkey_activate.page19.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page19.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page20.password;
      print(recogkey_activate.page20.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page20.password = testData1s;
      print(recogkey_activate.page20.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page20.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page20.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page20.password = testData2s;
      print(recogkey_activate.page20.password);
      expect(recogkey_activate.page20.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page20.password = defalut;
      print(recogkey_activate.page20.password);
      expect(recogkey_activate.page20.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page20.fcode;
      print(recogkey_activate.page20.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page20.fcode = testData1s;
      print(recogkey_activate.page20.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page20.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page20.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page20.fcode = testData2s;
      print(recogkey_activate.page20.fcode);
      expect(recogkey_activate.page20.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page20.fcode = defalut;
      print(recogkey_activate.page20.fcode);
      expect(recogkey_activate.page20.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page20.chg_flg;
      print(recogkey_activate.page20.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page20.chg_flg = testData1;
      print(recogkey_activate.page20.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page20.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page20.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page20.chg_flg = testData2;
      print(recogkey_activate.page20.chg_flg);
      expect(recogkey_activate.page20.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page20.chg_flg = defalut;
      print(recogkey_activate.page20.chg_flg);
      expect(recogkey_activate.page20.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page20.type;
      print(recogkey_activate.page20.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page20.type = testData1s;
      print(recogkey_activate.page20.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page20.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page20.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page20.type = testData2s;
      print(recogkey_activate.page20.type);
      expect(recogkey_activate.page20.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page20.type = defalut;
      print(recogkey_activate.page20.type);
      expect(recogkey_activate.page20.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page20.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page21.password;
      print(recogkey_activate.page21.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page21.password = testData1s;
      print(recogkey_activate.page21.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page21.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page21.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page21.password = testData2s;
      print(recogkey_activate.page21.password);
      expect(recogkey_activate.page21.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page21.password = defalut;
      print(recogkey_activate.page21.password);
      expect(recogkey_activate.page21.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page21.fcode;
      print(recogkey_activate.page21.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page21.fcode = testData1s;
      print(recogkey_activate.page21.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page21.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page21.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page21.fcode = testData2s;
      print(recogkey_activate.page21.fcode);
      expect(recogkey_activate.page21.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page21.fcode = defalut;
      print(recogkey_activate.page21.fcode);
      expect(recogkey_activate.page21.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page21.chg_flg;
      print(recogkey_activate.page21.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page21.chg_flg = testData1;
      print(recogkey_activate.page21.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page21.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page21.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page21.chg_flg = testData2;
      print(recogkey_activate.page21.chg_flg);
      expect(recogkey_activate.page21.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page21.chg_flg = defalut;
      print(recogkey_activate.page21.chg_flg);
      expect(recogkey_activate.page21.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page21.type;
      print(recogkey_activate.page21.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page21.type = testData1s;
      print(recogkey_activate.page21.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page21.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page21.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page21.type = testData2s;
      print(recogkey_activate.page21.type);
      expect(recogkey_activate.page21.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page21.type = defalut;
      print(recogkey_activate.page21.type);
      expect(recogkey_activate.page21.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page21.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page22.password;
      print(recogkey_activate.page22.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page22.password = testData1s;
      print(recogkey_activate.page22.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page22.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page22.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page22.password = testData2s;
      print(recogkey_activate.page22.password);
      expect(recogkey_activate.page22.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page22.password = defalut;
      print(recogkey_activate.page22.password);
      expect(recogkey_activate.page22.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page22.fcode;
      print(recogkey_activate.page22.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page22.fcode = testData1s;
      print(recogkey_activate.page22.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page22.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page22.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page22.fcode = testData2s;
      print(recogkey_activate.page22.fcode);
      expect(recogkey_activate.page22.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page22.fcode = defalut;
      print(recogkey_activate.page22.fcode);
      expect(recogkey_activate.page22.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page22.chg_flg;
      print(recogkey_activate.page22.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page22.chg_flg = testData1;
      print(recogkey_activate.page22.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page22.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page22.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page22.chg_flg = testData2;
      print(recogkey_activate.page22.chg_flg);
      expect(recogkey_activate.page22.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page22.chg_flg = defalut;
      print(recogkey_activate.page22.chg_flg);
      expect(recogkey_activate.page22.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page22.type;
      print(recogkey_activate.page22.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page22.type = testData1s;
      print(recogkey_activate.page22.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page22.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page22.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page22.type = testData2s;
      print(recogkey_activate.page22.type);
      expect(recogkey_activate.page22.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page22.type = defalut;
      print(recogkey_activate.page22.type);
      expect(recogkey_activate.page22.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page22.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page23.password;
      print(recogkey_activate.page23.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page23.password = testData1s;
      print(recogkey_activate.page23.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page23.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page23.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page23.password = testData2s;
      print(recogkey_activate.page23.password);
      expect(recogkey_activate.page23.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page23.password = defalut;
      print(recogkey_activate.page23.password);
      expect(recogkey_activate.page23.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page23.fcode;
      print(recogkey_activate.page23.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page23.fcode = testData1s;
      print(recogkey_activate.page23.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page23.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page23.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page23.fcode = testData2s;
      print(recogkey_activate.page23.fcode);
      expect(recogkey_activate.page23.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page23.fcode = defalut;
      print(recogkey_activate.page23.fcode);
      expect(recogkey_activate.page23.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page23.chg_flg;
      print(recogkey_activate.page23.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page23.chg_flg = testData1;
      print(recogkey_activate.page23.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page23.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page23.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page23.chg_flg = testData2;
      print(recogkey_activate.page23.chg_flg);
      expect(recogkey_activate.page23.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page23.chg_flg = defalut;
      print(recogkey_activate.page23.chg_flg);
      expect(recogkey_activate.page23.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page23.type;
      print(recogkey_activate.page23.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page23.type = testData1s;
      print(recogkey_activate.page23.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page23.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page23.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page23.type = testData2s;
      print(recogkey_activate.page23.type);
      expect(recogkey_activate.page23.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page23.type = defalut;
      print(recogkey_activate.page23.type);
      expect(recogkey_activate.page23.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page23.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page24.password;
      print(recogkey_activate.page24.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page24.password = testData1s;
      print(recogkey_activate.page24.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page24.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page24.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page24.password = testData2s;
      print(recogkey_activate.page24.password);
      expect(recogkey_activate.page24.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page24.password = defalut;
      print(recogkey_activate.page24.password);
      expect(recogkey_activate.page24.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page24.fcode;
      print(recogkey_activate.page24.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page24.fcode = testData1s;
      print(recogkey_activate.page24.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page24.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page24.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page24.fcode = testData2s;
      print(recogkey_activate.page24.fcode);
      expect(recogkey_activate.page24.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page24.fcode = defalut;
      print(recogkey_activate.page24.fcode);
      expect(recogkey_activate.page24.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page24.chg_flg;
      print(recogkey_activate.page24.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page24.chg_flg = testData1;
      print(recogkey_activate.page24.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page24.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page24.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page24.chg_flg = testData2;
      print(recogkey_activate.page24.chg_flg);
      expect(recogkey_activate.page24.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page24.chg_flg = defalut;
      print(recogkey_activate.page24.chg_flg);
      expect(recogkey_activate.page24.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page24.type;
      print(recogkey_activate.page24.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page24.type = testData1s;
      print(recogkey_activate.page24.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page24.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page24.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page24.type = testData2s;
      print(recogkey_activate.page24.type);
      expect(recogkey_activate.page24.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page24.type = defalut;
      print(recogkey_activate.page24.type);
      expect(recogkey_activate.page24.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page24.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page25.password;
      print(recogkey_activate.page25.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page25.password = testData1s;
      print(recogkey_activate.page25.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page25.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page25.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page25.password = testData2s;
      print(recogkey_activate.page25.password);
      expect(recogkey_activate.page25.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page25.password = defalut;
      print(recogkey_activate.page25.password);
      expect(recogkey_activate.page25.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page25.fcode;
      print(recogkey_activate.page25.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page25.fcode = testData1s;
      print(recogkey_activate.page25.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page25.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page25.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page25.fcode = testData2s;
      print(recogkey_activate.page25.fcode);
      expect(recogkey_activate.page25.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page25.fcode = defalut;
      print(recogkey_activate.page25.fcode);
      expect(recogkey_activate.page25.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page25.chg_flg;
      print(recogkey_activate.page25.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page25.chg_flg = testData1;
      print(recogkey_activate.page25.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page25.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page25.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page25.chg_flg = testData2;
      print(recogkey_activate.page25.chg_flg);
      expect(recogkey_activate.page25.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page25.chg_flg = defalut;
      print(recogkey_activate.page25.chg_flg);
      expect(recogkey_activate.page25.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page25.type;
      print(recogkey_activate.page25.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page25.type = testData1s;
      print(recogkey_activate.page25.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page25.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page25.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page25.type = testData2s;
      print(recogkey_activate.page25.type);
      expect(recogkey_activate.page25.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page25.type = defalut;
      print(recogkey_activate.page25.type);
      expect(recogkey_activate.page25.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page25.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page26.password;
      print(recogkey_activate.page26.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page26.password = testData1s;
      print(recogkey_activate.page26.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page26.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page26.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page26.password = testData2s;
      print(recogkey_activate.page26.password);
      expect(recogkey_activate.page26.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page26.password = defalut;
      print(recogkey_activate.page26.password);
      expect(recogkey_activate.page26.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page26.fcode;
      print(recogkey_activate.page26.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page26.fcode = testData1s;
      print(recogkey_activate.page26.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page26.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page26.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page26.fcode = testData2s;
      print(recogkey_activate.page26.fcode);
      expect(recogkey_activate.page26.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page26.fcode = defalut;
      print(recogkey_activate.page26.fcode);
      expect(recogkey_activate.page26.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page26.chg_flg;
      print(recogkey_activate.page26.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page26.chg_flg = testData1;
      print(recogkey_activate.page26.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page26.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page26.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page26.chg_flg = testData2;
      print(recogkey_activate.page26.chg_flg);
      expect(recogkey_activate.page26.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page26.chg_flg = defalut;
      print(recogkey_activate.page26.chg_flg);
      expect(recogkey_activate.page26.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page26.type;
      print(recogkey_activate.page26.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page26.type = testData1s;
      print(recogkey_activate.page26.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page26.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page26.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page26.type = testData2s;
      print(recogkey_activate.page26.type);
      expect(recogkey_activate.page26.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page26.type = defalut;
      print(recogkey_activate.page26.type);
      expect(recogkey_activate.page26.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page26.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page27.password;
      print(recogkey_activate.page27.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page27.password = testData1s;
      print(recogkey_activate.page27.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page27.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page27.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page27.password = testData2s;
      print(recogkey_activate.page27.password);
      expect(recogkey_activate.page27.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page27.password = defalut;
      print(recogkey_activate.page27.password);
      expect(recogkey_activate.page27.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page27.fcode;
      print(recogkey_activate.page27.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page27.fcode = testData1s;
      print(recogkey_activate.page27.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page27.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page27.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page27.fcode = testData2s;
      print(recogkey_activate.page27.fcode);
      expect(recogkey_activate.page27.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page27.fcode = defalut;
      print(recogkey_activate.page27.fcode);
      expect(recogkey_activate.page27.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page27.chg_flg;
      print(recogkey_activate.page27.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page27.chg_flg = testData1;
      print(recogkey_activate.page27.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page27.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page27.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page27.chg_flg = testData2;
      print(recogkey_activate.page27.chg_flg);
      expect(recogkey_activate.page27.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page27.chg_flg = defalut;
      print(recogkey_activate.page27.chg_flg);
      expect(recogkey_activate.page27.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page27.type;
      print(recogkey_activate.page27.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page27.type = testData1s;
      print(recogkey_activate.page27.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page27.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page27.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page27.type = testData2s;
      print(recogkey_activate.page27.type);
      expect(recogkey_activate.page27.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page27.type = defalut;
      print(recogkey_activate.page27.type);
      expect(recogkey_activate.page27.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page27.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page28.password;
      print(recogkey_activate.page28.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page28.password = testData1s;
      print(recogkey_activate.page28.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page28.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page28.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page28.password = testData2s;
      print(recogkey_activate.page28.password);
      expect(recogkey_activate.page28.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page28.password = defalut;
      print(recogkey_activate.page28.password);
      expect(recogkey_activate.page28.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page28.fcode;
      print(recogkey_activate.page28.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page28.fcode = testData1s;
      print(recogkey_activate.page28.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page28.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page28.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page28.fcode = testData2s;
      print(recogkey_activate.page28.fcode);
      expect(recogkey_activate.page28.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page28.fcode = defalut;
      print(recogkey_activate.page28.fcode);
      expect(recogkey_activate.page28.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page28.chg_flg;
      print(recogkey_activate.page28.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page28.chg_flg = testData1;
      print(recogkey_activate.page28.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page28.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page28.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page28.chg_flg = testData2;
      print(recogkey_activate.page28.chg_flg);
      expect(recogkey_activate.page28.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page28.chg_flg = defalut;
      print(recogkey_activate.page28.chg_flg);
      expect(recogkey_activate.page28.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page28.type;
      print(recogkey_activate.page28.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page28.type = testData1s;
      print(recogkey_activate.page28.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page28.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page28.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page28.type = testData2s;
      print(recogkey_activate.page28.type);
      expect(recogkey_activate.page28.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page28.type = defalut;
      print(recogkey_activate.page28.type);
      expect(recogkey_activate.page28.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page28.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page29.password;
      print(recogkey_activate.page29.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page29.password = testData1s;
      print(recogkey_activate.page29.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page29.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page29.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page29.password = testData2s;
      print(recogkey_activate.page29.password);
      expect(recogkey_activate.page29.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page29.password = defalut;
      print(recogkey_activate.page29.password);
      expect(recogkey_activate.page29.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page29.fcode;
      print(recogkey_activate.page29.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page29.fcode = testData1s;
      print(recogkey_activate.page29.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page29.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page29.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page29.fcode = testData2s;
      print(recogkey_activate.page29.fcode);
      expect(recogkey_activate.page29.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page29.fcode = defalut;
      print(recogkey_activate.page29.fcode);
      expect(recogkey_activate.page29.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page29.chg_flg;
      print(recogkey_activate.page29.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page29.chg_flg = testData1;
      print(recogkey_activate.page29.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page29.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page29.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page29.chg_flg = testData2;
      print(recogkey_activate.page29.chg_flg);
      expect(recogkey_activate.page29.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page29.chg_flg = defalut;
      print(recogkey_activate.page29.chg_flg);
      expect(recogkey_activate.page29.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page29.type;
      print(recogkey_activate.page29.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page29.type = testData1s;
      print(recogkey_activate.page29.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page29.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page29.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page29.type = testData2s;
      print(recogkey_activate.page29.type);
      expect(recogkey_activate.page29.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page29.type = defalut;
      print(recogkey_activate.page29.type);
      expect(recogkey_activate.page29.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page29.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page30.password;
      print(recogkey_activate.page30.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page30.password = testData1s;
      print(recogkey_activate.page30.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page30.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page30.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page30.password = testData2s;
      print(recogkey_activate.page30.password);
      expect(recogkey_activate.page30.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page30.password = defalut;
      print(recogkey_activate.page30.password);
      expect(recogkey_activate.page30.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page30.fcode;
      print(recogkey_activate.page30.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page30.fcode = testData1s;
      print(recogkey_activate.page30.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page30.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page30.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page30.fcode = testData2s;
      print(recogkey_activate.page30.fcode);
      expect(recogkey_activate.page30.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page30.fcode = defalut;
      print(recogkey_activate.page30.fcode);
      expect(recogkey_activate.page30.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page30.chg_flg;
      print(recogkey_activate.page30.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page30.chg_flg = testData1;
      print(recogkey_activate.page30.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page30.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page30.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page30.chg_flg = testData2;
      print(recogkey_activate.page30.chg_flg);
      expect(recogkey_activate.page30.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page30.chg_flg = defalut;
      print(recogkey_activate.page30.chg_flg);
      expect(recogkey_activate.page30.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page30.type;
      print(recogkey_activate.page30.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page30.type = testData1s;
      print(recogkey_activate.page30.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page30.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page30.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page30.type = testData2s;
      print(recogkey_activate.page30.type);
      expect(recogkey_activate.page30.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page30.type = defalut;
      print(recogkey_activate.page30.type);
      expect(recogkey_activate.page30.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page30.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page31.password;
      print(recogkey_activate.page31.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page31.password = testData1s;
      print(recogkey_activate.page31.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page31.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page31.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page31.password = testData2s;
      print(recogkey_activate.page31.password);
      expect(recogkey_activate.page31.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page31.password = defalut;
      print(recogkey_activate.page31.password);
      expect(recogkey_activate.page31.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page31.fcode;
      print(recogkey_activate.page31.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page31.fcode = testData1s;
      print(recogkey_activate.page31.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page31.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page31.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page31.fcode = testData2s;
      print(recogkey_activate.page31.fcode);
      expect(recogkey_activate.page31.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page31.fcode = defalut;
      print(recogkey_activate.page31.fcode);
      expect(recogkey_activate.page31.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page31.chg_flg;
      print(recogkey_activate.page31.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page31.chg_flg = testData1;
      print(recogkey_activate.page31.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page31.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page31.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page31.chg_flg = testData2;
      print(recogkey_activate.page31.chg_flg);
      expect(recogkey_activate.page31.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page31.chg_flg = defalut;
      print(recogkey_activate.page31.chg_flg);
      expect(recogkey_activate.page31.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page31.type;
      print(recogkey_activate.page31.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page31.type = testData1s;
      print(recogkey_activate.page31.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page31.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page31.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page31.type = testData2s;
      print(recogkey_activate.page31.type);
      expect(recogkey_activate.page31.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page31.type = defalut;
      print(recogkey_activate.page31.type);
      expect(recogkey_activate.page31.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page31.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page32.password;
      print(recogkey_activate.page32.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page32.password = testData1s;
      print(recogkey_activate.page32.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page32.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page32.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page32.password = testData2s;
      print(recogkey_activate.page32.password);
      expect(recogkey_activate.page32.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page32.password = defalut;
      print(recogkey_activate.page32.password);
      expect(recogkey_activate.page32.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page32.fcode;
      print(recogkey_activate.page32.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page32.fcode = testData1s;
      print(recogkey_activate.page32.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page32.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page32.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page32.fcode = testData2s;
      print(recogkey_activate.page32.fcode);
      expect(recogkey_activate.page32.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page32.fcode = defalut;
      print(recogkey_activate.page32.fcode);
      expect(recogkey_activate.page32.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page32.chg_flg;
      print(recogkey_activate.page32.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page32.chg_flg = testData1;
      print(recogkey_activate.page32.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page32.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page32.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page32.chg_flg = testData2;
      print(recogkey_activate.page32.chg_flg);
      expect(recogkey_activate.page32.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page32.chg_flg = defalut;
      print(recogkey_activate.page32.chg_flg);
      expect(recogkey_activate.page32.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page32.type;
      print(recogkey_activate.page32.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page32.type = testData1s;
      print(recogkey_activate.page32.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page32.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page32.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page32.type = testData2s;
      print(recogkey_activate.page32.type);
      expect(recogkey_activate.page32.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page32.type = defalut;
      print(recogkey_activate.page32.type);
      expect(recogkey_activate.page32.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page32.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page33.password;
      print(recogkey_activate.page33.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page33.password = testData1s;
      print(recogkey_activate.page33.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page33.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page33.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page33.password = testData2s;
      print(recogkey_activate.page33.password);
      expect(recogkey_activate.page33.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page33.password = defalut;
      print(recogkey_activate.page33.password);
      expect(recogkey_activate.page33.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page33.fcode;
      print(recogkey_activate.page33.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page33.fcode = testData1s;
      print(recogkey_activate.page33.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page33.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page33.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page33.fcode = testData2s;
      print(recogkey_activate.page33.fcode);
      expect(recogkey_activate.page33.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page33.fcode = defalut;
      print(recogkey_activate.page33.fcode);
      expect(recogkey_activate.page33.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page33.chg_flg;
      print(recogkey_activate.page33.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page33.chg_flg = testData1;
      print(recogkey_activate.page33.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page33.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page33.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page33.chg_flg = testData2;
      print(recogkey_activate.page33.chg_flg);
      expect(recogkey_activate.page33.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page33.chg_flg = defalut;
      print(recogkey_activate.page33.chg_flg);
      expect(recogkey_activate.page33.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page33.type;
      print(recogkey_activate.page33.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page33.type = testData1s;
      print(recogkey_activate.page33.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page33.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page33.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page33.type = testData2s;
      print(recogkey_activate.page33.type);
      expect(recogkey_activate.page33.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page33.type = defalut;
      print(recogkey_activate.page33.type);
      expect(recogkey_activate.page33.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page33.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page34.password;
      print(recogkey_activate.page34.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page34.password = testData1s;
      print(recogkey_activate.page34.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page34.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page34.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page34.password = testData2s;
      print(recogkey_activate.page34.password);
      expect(recogkey_activate.page34.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page34.password = defalut;
      print(recogkey_activate.page34.password);
      expect(recogkey_activate.page34.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page34.fcode;
      print(recogkey_activate.page34.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page34.fcode = testData1s;
      print(recogkey_activate.page34.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page34.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page34.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page34.fcode = testData2s;
      print(recogkey_activate.page34.fcode);
      expect(recogkey_activate.page34.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page34.fcode = defalut;
      print(recogkey_activate.page34.fcode);
      expect(recogkey_activate.page34.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page34.chg_flg;
      print(recogkey_activate.page34.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page34.chg_flg = testData1;
      print(recogkey_activate.page34.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page34.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page34.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page34.chg_flg = testData2;
      print(recogkey_activate.page34.chg_flg);
      expect(recogkey_activate.page34.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page34.chg_flg = defalut;
      print(recogkey_activate.page34.chg_flg);
      expect(recogkey_activate.page34.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page34.type;
      print(recogkey_activate.page34.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page34.type = testData1s;
      print(recogkey_activate.page34.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page34.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page34.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page34.type = testData2s;
      print(recogkey_activate.page34.type);
      expect(recogkey_activate.page34.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page34.type = defalut;
      print(recogkey_activate.page34.type);
      expect(recogkey_activate.page34.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page34.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page35.password;
      print(recogkey_activate.page35.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page35.password = testData1s;
      print(recogkey_activate.page35.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page35.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page35.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page35.password = testData2s;
      print(recogkey_activate.page35.password);
      expect(recogkey_activate.page35.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page35.password = defalut;
      print(recogkey_activate.page35.password);
      expect(recogkey_activate.page35.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page35.fcode;
      print(recogkey_activate.page35.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page35.fcode = testData1s;
      print(recogkey_activate.page35.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page35.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page35.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page35.fcode = testData2s;
      print(recogkey_activate.page35.fcode);
      expect(recogkey_activate.page35.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page35.fcode = defalut;
      print(recogkey_activate.page35.fcode);
      expect(recogkey_activate.page35.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page35.chg_flg;
      print(recogkey_activate.page35.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page35.chg_flg = testData1;
      print(recogkey_activate.page35.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page35.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page35.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page35.chg_flg = testData2;
      print(recogkey_activate.page35.chg_flg);
      expect(recogkey_activate.page35.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page35.chg_flg = defalut;
      print(recogkey_activate.page35.chg_flg);
      expect(recogkey_activate.page35.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page35.type;
      print(recogkey_activate.page35.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page35.type = testData1s;
      print(recogkey_activate.page35.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page35.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page35.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page35.type = testData2s;
      print(recogkey_activate.page35.type);
      expect(recogkey_activate.page35.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page35.type = defalut;
      print(recogkey_activate.page35.type);
      expect(recogkey_activate.page35.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page35.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page36.password;
      print(recogkey_activate.page36.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page36.password = testData1s;
      print(recogkey_activate.page36.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page36.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page36.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page36.password = testData2s;
      print(recogkey_activate.page36.password);
      expect(recogkey_activate.page36.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page36.password = defalut;
      print(recogkey_activate.page36.password);
      expect(recogkey_activate.page36.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page36.fcode;
      print(recogkey_activate.page36.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page36.fcode = testData1s;
      print(recogkey_activate.page36.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page36.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page36.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page36.fcode = testData2s;
      print(recogkey_activate.page36.fcode);
      expect(recogkey_activate.page36.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page36.fcode = defalut;
      print(recogkey_activate.page36.fcode);
      expect(recogkey_activate.page36.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page36.chg_flg;
      print(recogkey_activate.page36.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page36.chg_flg = testData1;
      print(recogkey_activate.page36.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page36.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page36.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page36.chg_flg = testData2;
      print(recogkey_activate.page36.chg_flg);
      expect(recogkey_activate.page36.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page36.chg_flg = defalut;
      print(recogkey_activate.page36.chg_flg);
      expect(recogkey_activate.page36.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page36.type;
      print(recogkey_activate.page36.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page36.type = testData1s;
      print(recogkey_activate.page36.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page36.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page36.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page36.type = testData2s;
      print(recogkey_activate.page36.type);
      expect(recogkey_activate.page36.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page36.type = defalut;
      print(recogkey_activate.page36.type);
      expect(recogkey_activate.page36.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page36.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page37.password;
      print(recogkey_activate.page37.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page37.password = testData1s;
      print(recogkey_activate.page37.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page37.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page37.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page37.password = testData2s;
      print(recogkey_activate.page37.password);
      expect(recogkey_activate.page37.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page37.password = defalut;
      print(recogkey_activate.page37.password);
      expect(recogkey_activate.page37.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page37.fcode;
      print(recogkey_activate.page37.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page37.fcode = testData1s;
      print(recogkey_activate.page37.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page37.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page37.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page37.fcode = testData2s;
      print(recogkey_activate.page37.fcode);
      expect(recogkey_activate.page37.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page37.fcode = defalut;
      print(recogkey_activate.page37.fcode);
      expect(recogkey_activate.page37.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page37.chg_flg;
      print(recogkey_activate.page37.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page37.chg_flg = testData1;
      print(recogkey_activate.page37.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page37.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page37.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page37.chg_flg = testData2;
      print(recogkey_activate.page37.chg_flg);
      expect(recogkey_activate.page37.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page37.chg_flg = defalut;
      print(recogkey_activate.page37.chg_flg);
      expect(recogkey_activate.page37.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page37.type;
      print(recogkey_activate.page37.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page37.type = testData1s;
      print(recogkey_activate.page37.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page37.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page37.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page37.type = testData2s;
      print(recogkey_activate.page37.type);
      expect(recogkey_activate.page37.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page37.type = defalut;
      print(recogkey_activate.page37.type);
      expect(recogkey_activate.page37.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page37.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page38.password;
      print(recogkey_activate.page38.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page38.password = testData1s;
      print(recogkey_activate.page38.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page38.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page38.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page38.password = testData2s;
      print(recogkey_activate.page38.password);
      expect(recogkey_activate.page38.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page38.password = defalut;
      print(recogkey_activate.page38.password);
      expect(recogkey_activate.page38.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page38.fcode;
      print(recogkey_activate.page38.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page38.fcode = testData1s;
      print(recogkey_activate.page38.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page38.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page38.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page38.fcode = testData2s;
      print(recogkey_activate.page38.fcode);
      expect(recogkey_activate.page38.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page38.fcode = defalut;
      print(recogkey_activate.page38.fcode);
      expect(recogkey_activate.page38.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page38.chg_flg;
      print(recogkey_activate.page38.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page38.chg_flg = testData1;
      print(recogkey_activate.page38.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page38.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page38.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page38.chg_flg = testData2;
      print(recogkey_activate.page38.chg_flg);
      expect(recogkey_activate.page38.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page38.chg_flg = defalut;
      print(recogkey_activate.page38.chg_flg);
      expect(recogkey_activate.page38.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page38.type;
      print(recogkey_activate.page38.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page38.type = testData1s;
      print(recogkey_activate.page38.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page38.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page38.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page38.type = testData2s;
      print(recogkey_activate.page38.type);
      expect(recogkey_activate.page38.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page38.type = defalut;
      print(recogkey_activate.page38.type);
      expect(recogkey_activate.page38.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page38.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page39.password;
      print(recogkey_activate.page39.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page39.password = testData1s;
      print(recogkey_activate.page39.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page39.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page39.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page39.password = testData2s;
      print(recogkey_activate.page39.password);
      expect(recogkey_activate.page39.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page39.password = defalut;
      print(recogkey_activate.page39.password);
      expect(recogkey_activate.page39.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page39.fcode;
      print(recogkey_activate.page39.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page39.fcode = testData1s;
      print(recogkey_activate.page39.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page39.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page39.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page39.fcode = testData2s;
      print(recogkey_activate.page39.fcode);
      expect(recogkey_activate.page39.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page39.fcode = defalut;
      print(recogkey_activate.page39.fcode);
      expect(recogkey_activate.page39.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page39.chg_flg;
      print(recogkey_activate.page39.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page39.chg_flg = testData1;
      print(recogkey_activate.page39.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page39.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page39.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page39.chg_flg = testData2;
      print(recogkey_activate.page39.chg_flg);
      expect(recogkey_activate.page39.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page39.chg_flg = defalut;
      print(recogkey_activate.page39.chg_flg);
      expect(recogkey_activate.page39.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page39.type;
      print(recogkey_activate.page39.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page39.type = testData1s;
      print(recogkey_activate.page39.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page39.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page39.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page39.type = testData2s;
      print(recogkey_activate.page39.type);
      expect(recogkey_activate.page39.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page39.type = defalut;
      print(recogkey_activate.page39.type);
      expect(recogkey_activate.page39.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page39.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page40.password;
      print(recogkey_activate.page40.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page40.password = testData1s;
      print(recogkey_activate.page40.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page40.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page40.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page40.password = testData2s;
      print(recogkey_activate.page40.password);
      expect(recogkey_activate.page40.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page40.password = defalut;
      print(recogkey_activate.page40.password);
      expect(recogkey_activate.page40.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page40.fcode;
      print(recogkey_activate.page40.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page40.fcode = testData1s;
      print(recogkey_activate.page40.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page40.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page40.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page40.fcode = testData2s;
      print(recogkey_activate.page40.fcode);
      expect(recogkey_activate.page40.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page40.fcode = defalut;
      print(recogkey_activate.page40.fcode);
      expect(recogkey_activate.page40.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page40.chg_flg;
      print(recogkey_activate.page40.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page40.chg_flg = testData1;
      print(recogkey_activate.page40.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page40.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page40.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page40.chg_flg = testData2;
      print(recogkey_activate.page40.chg_flg);
      expect(recogkey_activate.page40.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page40.chg_flg = defalut;
      print(recogkey_activate.page40.chg_flg);
      expect(recogkey_activate.page40.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page40.type;
      print(recogkey_activate.page40.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page40.type = testData1s;
      print(recogkey_activate.page40.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page40.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page40.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page40.type = testData2s;
      print(recogkey_activate.page40.type);
      expect(recogkey_activate.page40.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page40.type = defalut;
      print(recogkey_activate.page40.type);
      expect(recogkey_activate.page40.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page40.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page41.password;
      print(recogkey_activate.page41.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page41.password = testData1s;
      print(recogkey_activate.page41.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page41.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page41.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page41.password = testData2s;
      print(recogkey_activate.page41.password);
      expect(recogkey_activate.page41.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page41.password = defalut;
      print(recogkey_activate.page41.password);
      expect(recogkey_activate.page41.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page41.fcode;
      print(recogkey_activate.page41.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page41.fcode = testData1s;
      print(recogkey_activate.page41.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page41.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page41.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page41.fcode = testData2s;
      print(recogkey_activate.page41.fcode);
      expect(recogkey_activate.page41.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page41.fcode = defalut;
      print(recogkey_activate.page41.fcode);
      expect(recogkey_activate.page41.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page41.chg_flg;
      print(recogkey_activate.page41.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page41.chg_flg = testData1;
      print(recogkey_activate.page41.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page41.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page41.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page41.chg_flg = testData2;
      print(recogkey_activate.page41.chg_flg);
      expect(recogkey_activate.page41.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page41.chg_flg = defalut;
      print(recogkey_activate.page41.chg_flg);
      expect(recogkey_activate.page41.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page41.type;
      print(recogkey_activate.page41.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page41.type = testData1s;
      print(recogkey_activate.page41.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page41.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page41.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page41.type = testData2s;
      print(recogkey_activate.page41.type);
      expect(recogkey_activate.page41.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page41.type = defalut;
      print(recogkey_activate.page41.type);
      expect(recogkey_activate.page41.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page41.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page42.password;
      print(recogkey_activate.page42.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page42.password = testData1s;
      print(recogkey_activate.page42.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page42.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page42.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page42.password = testData2s;
      print(recogkey_activate.page42.password);
      expect(recogkey_activate.page42.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page42.password = defalut;
      print(recogkey_activate.page42.password);
      expect(recogkey_activate.page42.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page42.fcode;
      print(recogkey_activate.page42.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page42.fcode = testData1s;
      print(recogkey_activate.page42.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page42.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page42.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page42.fcode = testData2s;
      print(recogkey_activate.page42.fcode);
      expect(recogkey_activate.page42.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page42.fcode = defalut;
      print(recogkey_activate.page42.fcode);
      expect(recogkey_activate.page42.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page42.chg_flg;
      print(recogkey_activate.page42.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page42.chg_flg = testData1;
      print(recogkey_activate.page42.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page42.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page42.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page42.chg_flg = testData2;
      print(recogkey_activate.page42.chg_flg);
      expect(recogkey_activate.page42.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page42.chg_flg = defalut;
      print(recogkey_activate.page42.chg_flg);
      expect(recogkey_activate.page42.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page42.type;
      print(recogkey_activate.page42.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page42.type = testData1s;
      print(recogkey_activate.page42.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page42.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page42.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page42.type = testData2s;
      print(recogkey_activate.page42.type);
      expect(recogkey_activate.page42.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page42.type = defalut;
      print(recogkey_activate.page42.type);
      expect(recogkey_activate.page42.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page42.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page43.password;
      print(recogkey_activate.page43.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page43.password = testData1s;
      print(recogkey_activate.page43.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page43.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page43.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page43.password = testData2s;
      print(recogkey_activate.page43.password);
      expect(recogkey_activate.page43.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page43.password = defalut;
      print(recogkey_activate.page43.password);
      expect(recogkey_activate.page43.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page43.fcode;
      print(recogkey_activate.page43.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page43.fcode = testData1s;
      print(recogkey_activate.page43.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page43.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page43.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page43.fcode = testData2s;
      print(recogkey_activate.page43.fcode);
      expect(recogkey_activate.page43.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page43.fcode = defalut;
      print(recogkey_activate.page43.fcode);
      expect(recogkey_activate.page43.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page43.chg_flg;
      print(recogkey_activate.page43.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page43.chg_flg = testData1;
      print(recogkey_activate.page43.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page43.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page43.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page43.chg_flg = testData2;
      print(recogkey_activate.page43.chg_flg);
      expect(recogkey_activate.page43.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page43.chg_flg = defalut;
      print(recogkey_activate.page43.chg_flg);
      expect(recogkey_activate.page43.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page43.type;
      print(recogkey_activate.page43.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page43.type = testData1s;
      print(recogkey_activate.page43.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page43.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page43.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page43.type = testData2s;
      print(recogkey_activate.page43.type);
      expect(recogkey_activate.page43.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page43.type = defalut;
      print(recogkey_activate.page43.type);
      expect(recogkey_activate.page43.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page43.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page44.password;
      print(recogkey_activate.page44.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page44.password = testData1s;
      print(recogkey_activate.page44.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page44.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page44.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page44.password = testData2s;
      print(recogkey_activate.page44.password);
      expect(recogkey_activate.page44.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page44.password = defalut;
      print(recogkey_activate.page44.password);
      expect(recogkey_activate.page44.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page44.fcode;
      print(recogkey_activate.page44.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page44.fcode = testData1s;
      print(recogkey_activate.page44.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page44.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page44.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page44.fcode = testData2s;
      print(recogkey_activate.page44.fcode);
      expect(recogkey_activate.page44.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page44.fcode = defalut;
      print(recogkey_activate.page44.fcode);
      expect(recogkey_activate.page44.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page44.chg_flg;
      print(recogkey_activate.page44.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page44.chg_flg = testData1;
      print(recogkey_activate.page44.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page44.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page44.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page44.chg_flg = testData2;
      print(recogkey_activate.page44.chg_flg);
      expect(recogkey_activate.page44.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page44.chg_flg = defalut;
      print(recogkey_activate.page44.chg_flg);
      expect(recogkey_activate.page44.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page44.type;
      print(recogkey_activate.page44.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page44.type = testData1s;
      print(recogkey_activate.page44.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page44.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page44.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page44.type = testData2s;
      print(recogkey_activate.page44.type);
      expect(recogkey_activate.page44.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page44.type = defalut;
      print(recogkey_activate.page44.type);
      expect(recogkey_activate.page44.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page44.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page45.password;
      print(recogkey_activate.page45.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page45.password = testData1s;
      print(recogkey_activate.page45.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page45.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page45.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page45.password = testData2s;
      print(recogkey_activate.page45.password);
      expect(recogkey_activate.page45.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page45.password = defalut;
      print(recogkey_activate.page45.password);
      expect(recogkey_activate.page45.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page45.fcode;
      print(recogkey_activate.page45.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page45.fcode = testData1s;
      print(recogkey_activate.page45.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page45.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page45.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page45.fcode = testData2s;
      print(recogkey_activate.page45.fcode);
      expect(recogkey_activate.page45.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page45.fcode = defalut;
      print(recogkey_activate.page45.fcode);
      expect(recogkey_activate.page45.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page45.chg_flg;
      print(recogkey_activate.page45.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page45.chg_flg = testData1;
      print(recogkey_activate.page45.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page45.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page45.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page45.chg_flg = testData2;
      print(recogkey_activate.page45.chg_flg);
      expect(recogkey_activate.page45.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page45.chg_flg = defalut;
      print(recogkey_activate.page45.chg_flg);
      expect(recogkey_activate.page45.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page45.type;
      print(recogkey_activate.page45.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page45.type = testData1s;
      print(recogkey_activate.page45.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page45.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page45.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page45.type = testData2s;
      print(recogkey_activate.page45.type);
      expect(recogkey_activate.page45.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page45.type = defalut;
      print(recogkey_activate.page45.type);
      expect(recogkey_activate.page45.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page45.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page46.password;
      print(recogkey_activate.page46.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page46.password = testData1s;
      print(recogkey_activate.page46.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page46.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page46.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page46.password = testData2s;
      print(recogkey_activate.page46.password);
      expect(recogkey_activate.page46.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page46.password = defalut;
      print(recogkey_activate.page46.password);
      expect(recogkey_activate.page46.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page46.fcode;
      print(recogkey_activate.page46.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page46.fcode = testData1s;
      print(recogkey_activate.page46.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page46.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page46.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page46.fcode = testData2s;
      print(recogkey_activate.page46.fcode);
      expect(recogkey_activate.page46.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page46.fcode = defalut;
      print(recogkey_activate.page46.fcode);
      expect(recogkey_activate.page46.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page46.chg_flg;
      print(recogkey_activate.page46.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page46.chg_flg = testData1;
      print(recogkey_activate.page46.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page46.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page46.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page46.chg_flg = testData2;
      print(recogkey_activate.page46.chg_flg);
      expect(recogkey_activate.page46.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page46.chg_flg = defalut;
      print(recogkey_activate.page46.chg_flg);
      expect(recogkey_activate.page46.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page46.type;
      print(recogkey_activate.page46.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page46.type = testData1s;
      print(recogkey_activate.page46.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page46.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page46.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page46.type = testData2s;
      print(recogkey_activate.page46.type);
      expect(recogkey_activate.page46.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page46.type = defalut;
      print(recogkey_activate.page46.type);
      expect(recogkey_activate.page46.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page46.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page47.password;
      print(recogkey_activate.page47.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page47.password = testData1s;
      print(recogkey_activate.page47.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page47.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page47.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page47.password = testData2s;
      print(recogkey_activate.page47.password);
      expect(recogkey_activate.page47.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page47.password = defalut;
      print(recogkey_activate.page47.password);
      expect(recogkey_activate.page47.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page47.fcode;
      print(recogkey_activate.page47.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page47.fcode = testData1s;
      print(recogkey_activate.page47.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page47.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page47.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page47.fcode = testData2s;
      print(recogkey_activate.page47.fcode);
      expect(recogkey_activate.page47.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page47.fcode = defalut;
      print(recogkey_activate.page47.fcode);
      expect(recogkey_activate.page47.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page47.chg_flg;
      print(recogkey_activate.page47.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page47.chg_flg = testData1;
      print(recogkey_activate.page47.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page47.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page47.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page47.chg_flg = testData2;
      print(recogkey_activate.page47.chg_flg);
      expect(recogkey_activate.page47.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page47.chg_flg = defalut;
      print(recogkey_activate.page47.chg_flg);
      expect(recogkey_activate.page47.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page47.type;
      print(recogkey_activate.page47.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page47.type = testData1s;
      print(recogkey_activate.page47.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page47.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page47.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page47.type = testData2s;
      print(recogkey_activate.page47.type);
      expect(recogkey_activate.page47.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page47.type = defalut;
      print(recogkey_activate.page47.type);
      expect(recogkey_activate.page47.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page47.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page48.password;
      print(recogkey_activate.page48.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page48.password = testData1s;
      print(recogkey_activate.page48.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page48.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page48.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page48.password = testData2s;
      print(recogkey_activate.page48.password);
      expect(recogkey_activate.page48.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page48.password = defalut;
      print(recogkey_activate.page48.password);
      expect(recogkey_activate.page48.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page48.fcode;
      print(recogkey_activate.page48.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page48.fcode = testData1s;
      print(recogkey_activate.page48.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page48.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page48.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page48.fcode = testData2s;
      print(recogkey_activate.page48.fcode);
      expect(recogkey_activate.page48.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page48.fcode = defalut;
      print(recogkey_activate.page48.fcode);
      expect(recogkey_activate.page48.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page48.chg_flg;
      print(recogkey_activate.page48.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page48.chg_flg = testData1;
      print(recogkey_activate.page48.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page48.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page48.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page48.chg_flg = testData2;
      print(recogkey_activate.page48.chg_flg);
      expect(recogkey_activate.page48.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page48.chg_flg = defalut;
      print(recogkey_activate.page48.chg_flg);
      expect(recogkey_activate.page48.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page48.type;
      print(recogkey_activate.page48.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page48.type = testData1s;
      print(recogkey_activate.page48.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page48.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page48.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page48.type = testData2s;
      print(recogkey_activate.page48.type);
      expect(recogkey_activate.page48.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page48.type = defalut;
      print(recogkey_activate.page48.type);
      expect(recogkey_activate.page48.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page48.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page49.password;
      print(recogkey_activate.page49.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page49.password = testData1s;
      print(recogkey_activate.page49.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page49.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page49.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page49.password = testData2s;
      print(recogkey_activate.page49.password);
      expect(recogkey_activate.page49.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page49.password = defalut;
      print(recogkey_activate.page49.password);
      expect(recogkey_activate.page49.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page49.fcode;
      print(recogkey_activate.page49.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page49.fcode = testData1s;
      print(recogkey_activate.page49.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page49.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page49.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page49.fcode = testData2s;
      print(recogkey_activate.page49.fcode);
      expect(recogkey_activate.page49.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page49.fcode = defalut;
      print(recogkey_activate.page49.fcode);
      expect(recogkey_activate.page49.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page49.chg_flg;
      print(recogkey_activate.page49.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page49.chg_flg = testData1;
      print(recogkey_activate.page49.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page49.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page49.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page49.chg_flg = testData2;
      print(recogkey_activate.page49.chg_flg);
      expect(recogkey_activate.page49.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page49.chg_flg = defalut;
      print(recogkey_activate.page49.chg_flg);
      expect(recogkey_activate.page49.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page49.type;
      print(recogkey_activate.page49.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page49.type = testData1s;
      print(recogkey_activate.page49.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page49.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page49.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page49.type = testData2s;
      print(recogkey_activate.page49.type);
      expect(recogkey_activate.page49.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page49.type = defalut;
      print(recogkey_activate.page49.type);
      expect(recogkey_activate.page49.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page49.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page50.password;
      print(recogkey_activate.page50.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page50.password = testData1s;
      print(recogkey_activate.page50.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page50.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page50.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page50.password = testData2s;
      print(recogkey_activate.page50.password);
      expect(recogkey_activate.page50.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page50.password = defalut;
      print(recogkey_activate.page50.password);
      expect(recogkey_activate.page50.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page50.fcode;
      print(recogkey_activate.page50.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page50.fcode = testData1s;
      print(recogkey_activate.page50.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page50.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page50.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page50.fcode = testData2s;
      print(recogkey_activate.page50.fcode);
      expect(recogkey_activate.page50.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page50.fcode = defalut;
      print(recogkey_activate.page50.fcode);
      expect(recogkey_activate.page50.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page50.chg_flg;
      print(recogkey_activate.page50.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page50.chg_flg = testData1;
      print(recogkey_activate.page50.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page50.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page50.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page50.chg_flg = testData2;
      print(recogkey_activate.page50.chg_flg);
      expect(recogkey_activate.page50.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page50.chg_flg = defalut;
      print(recogkey_activate.page50.chg_flg);
      expect(recogkey_activate.page50.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page50.type;
      print(recogkey_activate.page50.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page50.type = testData1s;
      print(recogkey_activate.page50.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page50.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page50.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page50.type = testData2s;
      print(recogkey_activate.page50.type);
      expect(recogkey_activate.page50.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page50.type = defalut;
      print(recogkey_activate.page50.type);
      expect(recogkey_activate.page50.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page50.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page51.password;
      print(recogkey_activate.page51.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page51.password = testData1s;
      print(recogkey_activate.page51.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page51.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page51.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page51.password = testData2s;
      print(recogkey_activate.page51.password);
      expect(recogkey_activate.page51.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page51.password = defalut;
      print(recogkey_activate.page51.password);
      expect(recogkey_activate.page51.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page51.fcode;
      print(recogkey_activate.page51.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page51.fcode = testData1s;
      print(recogkey_activate.page51.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page51.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page51.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page51.fcode = testData2s;
      print(recogkey_activate.page51.fcode);
      expect(recogkey_activate.page51.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page51.fcode = defalut;
      print(recogkey_activate.page51.fcode);
      expect(recogkey_activate.page51.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page51.chg_flg;
      print(recogkey_activate.page51.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page51.chg_flg = testData1;
      print(recogkey_activate.page51.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page51.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page51.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page51.chg_flg = testData2;
      print(recogkey_activate.page51.chg_flg);
      expect(recogkey_activate.page51.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page51.chg_flg = defalut;
      print(recogkey_activate.page51.chg_flg);
      expect(recogkey_activate.page51.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page51.type;
      print(recogkey_activate.page51.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page51.type = testData1s;
      print(recogkey_activate.page51.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page51.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page51.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page51.type = testData2s;
      print(recogkey_activate.page51.type);
      expect(recogkey_activate.page51.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page51.type = defalut;
      print(recogkey_activate.page51.type);
      expect(recogkey_activate.page51.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page51.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page52.password;
      print(recogkey_activate.page52.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page52.password = testData1s;
      print(recogkey_activate.page52.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page52.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page52.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page52.password = testData2s;
      print(recogkey_activate.page52.password);
      expect(recogkey_activate.page52.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page52.password = defalut;
      print(recogkey_activate.page52.password);
      expect(recogkey_activate.page52.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page52.fcode;
      print(recogkey_activate.page52.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page52.fcode = testData1s;
      print(recogkey_activate.page52.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page52.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page52.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page52.fcode = testData2s;
      print(recogkey_activate.page52.fcode);
      expect(recogkey_activate.page52.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page52.fcode = defalut;
      print(recogkey_activate.page52.fcode);
      expect(recogkey_activate.page52.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

    test('00242_element_check_00219', () async {
      print("\n********** テスト実行：00242_element_check_00219 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page52.chg_flg;
      print(recogkey_activate.page52.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page52.chg_flg = testData1;
      print(recogkey_activate.page52.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page52.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page52.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page52.chg_flg = testData2;
      print(recogkey_activate.page52.chg_flg);
      expect(recogkey_activate.page52.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page52.chg_flg = defalut;
      print(recogkey_activate.page52.chg_flg);
      expect(recogkey_activate.page52.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00242_element_check_00219 **********\n\n");
    });

    test('00243_element_check_00220', () async {
      print("\n********** テスト実行：00243_element_check_00220 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page52.type;
      print(recogkey_activate.page52.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page52.type = testData1s;
      print(recogkey_activate.page52.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page52.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page52.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page52.type = testData2s;
      print(recogkey_activate.page52.type);
      expect(recogkey_activate.page52.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page52.type = defalut;
      print(recogkey_activate.page52.type);
      expect(recogkey_activate.page52.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page52.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00243_element_check_00220 **********\n\n");
    });

    test('00244_element_check_00221', () async {
      print("\n********** テスト実行：00244_element_check_00221 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page53.password;
      print(recogkey_activate.page53.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page53.password = testData1s;
      print(recogkey_activate.page53.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page53.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page53.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page53.password = testData2s;
      print(recogkey_activate.page53.password);
      expect(recogkey_activate.page53.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page53.password = defalut;
      print(recogkey_activate.page53.password);
      expect(recogkey_activate.page53.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00244_element_check_00221 **********\n\n");
    });

    test('00245_element_check_00222', () async {
      print("\n********** テスト実行：00245_element_check_00222 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page53.fcode;
      print(recogkey_activate.page53.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page53.fcode = testData1s;
      print(recogkey_activate.page53.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page53.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page53.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page53.fcode = testData2s;
      print(recogkey_activate.page53.fcode);
      expect(recogkey_activate.page53.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page53.fcode = defalut;
      print(recogkey_activate.page53.fcode);
      expect(recogkey_activate.page53.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00245_element_check_00222 **********\n\n");
    });

    test('00246_element_check_00223', () async {
      print("\n********** テスト実行：00246_element_check_00223 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page53.chg_flg;
      print(recogkey_activate.page53.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page53.chg_flg = testData1;
      print(recogkey_activate.page53.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page53.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page53.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page53.chg_flg = testData2;
      print(recogkey_activate.page53.chg_flg);
      expect(recogkey_activate.page53.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page53.chg_flg = defalut;
      print(recogkey_activate.page53.chg_flg);
      expect(recogkey_activate.page53.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00246_element_check_00223 **********\n\n");
    });

    test('00247_element_check_00224', () async {
      print("\n********** テスト実行：00247_element_check_00224 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page53.type;
      print(recogkey_activate.page53.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page53.type = testData1s;
      print(recogkey_activate.page53.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page53.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page53.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page53.type = testData2s;
      print(recogkey_activate.page53.type);
      expect(recogkey_activate.page53.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page53.type = defalut;
      print(recogkey_activate.page53.type);
      expect(recogkey_activate.page53.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page53.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00247_element_check_00224 **********\n\n");
    });

    test('00248_element_check_00225', () async {
      print("\n********** テスト実行：00248_element_check_00225 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page54.password;
      print(recogkey_activate.page54.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page54.password = testData1s;
      print(recogkey_activate.page54.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page54.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page54.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page54.password = testData2s;
      print(recogkey_activate.page54.password);
      expect(recogkey_activate.page54.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page54.password = defalut;
      print(recogkey_activate.page54.password);
      expect(recogkey_activate.page54.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00248_element_check_00225 **********\n\n");
    });

    test('00249_element_check_00226', () async {
      print("\n********** テスト実行：00249_element_check_00226 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page54.fcode;
      print(recogkey_activate.page54.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page54.fcode = testData1s;
      print(recogkey_activate.page54.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page54.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page54.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page54.fcode = testData2s;
      print(recogkey_activate.page54.fcode);
      expect(recogkey_activate.page54.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page54.fcode = defalut;
      print(recogkey_activate.page54.fcode);
      expect(recogkey_activate.page54.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00249_element_check_00226 **********\n\n");
    });

    test('00250_element_check_00227', () async {
      print("\n********** テスト実行：00250_element_check_00227 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page54.chg_flg;
      print(recogkey_activate.page54.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page54.chg_flg = testData1;
      print(recogkey_activate.page54.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page54.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page54.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page54.chg_flg = testData2;
      print(recogkey_activate.page54.chg_flg);
      expect(recogkey_activate.page54.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page54.chg_flg = defalut;
      print(recogkey_activate.page54.chg_flg);
      expect(recogkey_activate.page54.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00250_element_check_00227 **********\n\n");
    });

    test('00251_element_check_00228', () async {
      print("\n********** テスト実行：00251_element_check_00228 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page54.type;
      print(recogkey_activate.page54.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page54.type = testData1s;
      print(recogkey_activate.page54.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page54.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page54.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page54.type = testData2s;
      print(recogkey_activate.page54.type);
      expect(recogkey_activate.page54.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page54.type = defalut;
      print(recogkey_activate.page54.type);
      expect(recogkey_activate.page54.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page54.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00251_element_check_00228 **********\n\n");
    });

    test('00252_element_check_00229', () async {
      print("\n********** テスト実行：00252_element_check_00229 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page55.password;
      print(recogkey_activate.page55.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page55.password = testData1s;
      print(recogkey_activate.page55.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page55.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page55.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page55.password = testData2s;
      print(recogkey_activate.page55.password);
      expect(recogkey_activate.page55.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page55.password = defalut;
      print(recogkey_activate.page55.password);
      expect(recogkey_activate.page55.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00252_element_check_00229 **********\n\n");
    });

    test('00253_element_check_00230', () async {
      print("\n********** テスト実行：00253_element_check_00230 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page55.fcode;
      print(recogkey_activate.page55.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page55.fcode = testData1s;
      print(recogkey_activate.page55.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page55.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page55.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page55.fcode = testData2s;
      print(recogkey_activate.page55.fcode);
      expect(recogkey_activate.page55.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page55.fcode = defalut;
      print(recogkey_activate.page55.fcode);
      expect(recogkey_activate.page55.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00253_element_check_00230 **********\n\n");
    });

    test('00254_element_check_00231', () async {
      print("\n********** テスト実行：00254_element_check_00231 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page55.chg_flg;
      print(recogkey_activate.page55.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page55.chg_flg = testData1;
      print(recogkey_activate.page55.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page55.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page55.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page55.chg_flg = testData2;
      print(recogkey_activate.page55.chg_flg);
      expect(recogkey_activate.page55.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page55.chg_flg = defalut;
      print(recogkey_activate.page55.chg_flg);
      expect(recogkey_activate.page55.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00254_element_check_00231 **********\n\n");
    });

    test('00255_element_check_00232', () async {
      print("\n********** テスト実行：00255_element_check_00232 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page55.type;
      print(recogkey_activate.page55.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page55.type = testData1s;
      print(recogkey_activate.page55.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page55.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page55.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page55.type = testData2s;
      print(recogkey_activate.page55.type);
      expect(recogkey_activate.page55.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page55.type = defalut;
      print(recogkey_activate.page55.type);
      expect(recogkey_activate.page55.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page55.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00255_element_check_00232 **********\n\n");
    });

    test('00256_element_check_00233', () async {
      print("\n********** テスト実行：00256_element_check_00233 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page56.password;
      print(recogkey_activate.page56.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page56.password = testData1s;
      print(recogkey_activate.page56.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page56.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page56.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page56.password = testData2s;
      print(recogkey_activate.page56.password);
      expect(recogkey_activate.page56.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page56.password = defalut;
      print(recogkey_activate.page56.password);
      expect(recogkey_activate.page56.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00256_element_check_00233 **********\n\n");
    });

    test('00257_element_check_00234', () async {
      print("\n********** テスト実行：00257_element_check_00234 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page56.fcode;
      print(recogkey_activate.page56.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page56.fcode = testData1s;
      print(recogkey_activate.page56.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page56.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page56.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page56.fcode = testData2s;
      print(recogkey_activate.page56.fcode);
      expect(recogkey_activate.page56.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page56.fcode = defalut;
      print(recogkey_activate.page56.fcode);
      expect(recogkey_activate.page56.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00257_element_check_00234 **********\n\n");
    });

    test('00258_element_check_00235', () async {
      print("\n********** テスト実行：00258_element_check_00235 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page56.chg_flg;
      print(recogkey_activate.page56.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page56.chg_flg = testData1;
      print(recogkey_activate.page56.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page56.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page56.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page56.chg_flg = testData2;
      print(recogkey_activate.page56.chg_flg);
      expect(recogkey_activate.page56.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page56.chg_flg = defalut;
      print(recogkey_activate.page56.chg_flg);
      expect(recogkey_activate.page56.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00258_element_check_00235 **********\n\n");
    });

    test('00259_element_check_00236', () async {
      print("\n********** テスト実行：00259_element_check_00236 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page56.type;
      print(recogkey_activate.page56.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page56.type = testData1s;
      print(recogkey_activate.page56.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page56.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page56.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page56.type = testData2s;
      print(recogkey_activate.page56.type);
      expect(recogkey_activate.page56.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page56.type = defalut;
      print(recogkey_activate.page56.type);
      expect(recogkey_activate.page56.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page56.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00259_element_check_00236 **********\n\n");
    });

    test('00260_element_check_00237', () async {
      print("\n********** テスト実行：00260_element_check_00237 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page57.password;
      print(recogkey_activate.page57.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page57.password = testData1s;
      print(recogkey_activate.page57.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page57.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page57.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page57.password = testData2s;
      print(recogkey_activate.page57.password);
      expect(recogkey_activate.page57.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page57.password = defalut;
      print(recogkey_activate.page57.password);
      expect(recogkey_activate.page57.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00260_element_check_00237 **********\n\n");
    });

    test('00261_element_check_00238', () async {
      print("\n********** テスト実行：00261_element_check_00238 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page57.fcode;
      print(recogkey_activate.page57.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page57.fcode = testData1s;
      print(recogkey_activate.page57.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page57.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page57.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page57.fcode = testData2s;
      print(recogkey_activate.page57.fcode);
      expect(recogkey_activate.page57.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page57.fcode = defalut;
      print(recogkey_activate.page57.fcode);
      expect(recogkey_activate.page57.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00261_element_check_00238 **********\n\n");
    });

    test('00262_element_check_00239', () async {
      print("\n********** テスト実行：00262_element_check_00239 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page57.chg_flg;
      print(recogkey_activate.page57.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page57.chg_flg = testData1;
      print(recogkey_activate.page57.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page57.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page57.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page57.chg_flg = testData2;
      print(recogkey_activate.page57.chg_flg);
      expect(recogkey_activate.page57.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page57.chg_flg = defalut;
      print(recogkey_activate.page57.chg_flg);
      expect(recogkey_activate.page57.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00262_element_check_00239 **********\n\n");
    });

    test('00263_element_check_00240', () async {
      print("\n********** テスト実行：00263_element_check_00240 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page57.type;
      print(recogkey_activate.page57.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page57.type = testData1s;
      print(recogkey_activate.page57.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page57.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page57.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page57.type = testData2s;
      print(recogkey_activate.page57.type);
      expect(recogkey_activate.page57.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page57.type = defalut;
      print(recogkey_activate.page57.type);
      expect(recogkey_activate.page57.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page57.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00263_element_check_00240 **********\n\n");
    });

    test('00264_element_check_00241', () async {
      print("\n********** テスト実行：00264_element_check_00241 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page58.password;
      print(recogkey_activate.page58.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page58.password = testData1s;
      print(recogkey_activate.page58.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page58.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page58.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page58.password = testData2s;
      print(recogkey_activate.page58.password);
      expect(recogkey_activate.page58.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page58.password = defalut;
      print(recogkey_activate.page58.password);
      expect(recogkey_activate.page58.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00264_element_check_00241 **********\n\n");
    });

    test('00265_element_check_00242', () async {
      print("\n********** テスト実行：00265_element_check_00242 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page58.fcode;
      print(recogkey_activate.page58.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page58.fcode = testData1s;
      print(recogkey_activate.page58.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page58.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page58.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page58.fcode = testData2s;
      print(recogkey_activate.page58.fcode);
      expect(recogkey_activate.page58.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page58.fcode = defalut;
      print(recogkey_activate.page58.fcode);
      expect(recogkey_activate.page58.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00265_element_check_00242 **********\n\n");
    });

    test('00266_element_check_00243', () async {
      print("\n********** テスト実行：00266_element_check_00243 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page58.chg_flg;
      print(recogkey_activate.page58.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page58.chg_flg = testData1;
      print(recogkey_activate.page58.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page58.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page58.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page58.chg_flg = testData2;
      print(recogkey_activate.page58.chg_flg);
      expect(recogkey_activate.page58.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page58.chg_flg = defalut;
      print(recogkey_activate.page58.chg_flg);
      expect(recogkey_activate.page58.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00266_element_check_00243 **********\n\n");
    });

    test('00267_element_check_00244', () async {
      print("\n********** テスト実行：00267_element_check_00244 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page58.type;
      print(recogkey_activate.page58.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page58.type = testData1s;
      print(recogkey_activate.page58.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page58.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page58.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page58.type = testData2s;
      print(recogkey_activate.page58.type);
      expect(recogkey_activate.page58.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page58.type = defalut;
      print(recogkey_activate.page58.type);
      expect(recogkey_activate.page58.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page58.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00267_element_check_00244 **********\n\n");
    });

    test('00268_element_check_00245', () async {
      print("\n********** テスト実行：00268_element_check_00245 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page59.password;
      print(recogkey_activate.page59.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page59.password = testData1s;
      print(recogkey_activate.page59.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page59.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page59.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page59.password = testData2s;
      print(recogkey_activate.page59.password);
      expect(recogkey_activate.page59.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page59.password = defalut;
      print(recogkey_activate.page59.password);
      expect(recogkey_activate.page59.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00268_element_check_00245 **********\n\n");
    });

    test('00269_element_check_00246', () async {
      print("\n********** テスト実行：00269_element_check_00246 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page59.fcode;
      print(recogkey_activate.page59.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page59.fcode = testData1s;
      print(recogkey_activate.page59.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page59.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page59.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page59.fcode = testData2s;
      print(recogkey_activate.page59.fcode);
      expect(recogkey_activate.page59.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page59.fcode = defalut;
      print(recogkey_activate.page59.fcode);
      expect(recogkey_activate.page59.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00269_element_check_00246 **********\n\n");
    });

    test('00270_element_check_00247', () async {
      print("\n********** テスト実行：00270_element_check_00247 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page59.chg_flg;
      print(recogkey_activate.page59.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page59.chg_flg = testData1;
      print(recogkey_activate.page59.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page59.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page59.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page59.chg_flg = testData2;
      print(recogkey_activate.page59.chg_flg);
      expect(recogkey_activate.page59.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page59.chg_flg = defalut;
      print(recogkey_activate.page59.chg_flg);
      expect(recogkey_activate.page59.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00270_element_check_00247 **********\n\n");
    });

    test('00271_element_check_00248', () async {
      print("\n********** テスト実行：00271_element_check_00248 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page59.type;
      print(recogkey_activate.page59.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page59.type = testData1s;
      print(recogkey_activate.page59.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page59.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page59.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page59.type = testData2s;
      print(recogkey_activate.page59.type);
      expect(recogkey_activate.page59.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page59.type = defalut;
      print(recogkey_activate.page59.type);
      expect(recogkey_activate.page59.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page59.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00271_element_check_00248 **********\n\n");
    });

    test('00272_element_check_00249', () async {
      print("\n********** テスト実行：00272_element_check_00249 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page60.password;
      print(recogkey_activate.page60.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page60.password = testData1s;
      print(recogkey_activate.page60.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page60.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page60.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page60.password = testData2s;
      print(recogkey_activate.page60.password);
      expect(recogkey_activate.page60.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page60.password = defalut;
      print(recogkey_activate.page60.password);
      expect(recogkey_activate.page60.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00272_element_check_00249 **********\n\n");
    });

    test('00273_element_check_00250', () async {
      print("\n********** テスト実行：00273_element_check_00250 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page60.fcode;
      print(recogkey_activate.page60.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page60.fcode = testData1s;
      print(recogkey_activate.page60.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page60.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page60.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page60.fcode = testData2s;
      print(recogkey_activate.page60.fcode);
      expect(recogkey_activate.page60.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page60.fcode = defalut;
      print(recogkey_activate.page60.fcode);
      expect(recogkey_activate.page60.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00273_element_check_00250 **********\n\n");
    });

    test('00274_element_check_00251', () async {
      print("\n********** テスト実行：00274_element_check_00251 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page60.chg_flg;
      print(recogkey_activate.page60.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page60.chg_flg = testData1;
      print(recogkey_activate.page60.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page60.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page60.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page60.chg_flg = testData2;
      print(recogkey_activate.page60.chg_flg);
      expect(recogkey_activate.page60.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page60.chg_flg = defalut;
      print(recogkey_activate.page60.chg_flg);
      expect(recogkey_activate.page60.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00274_element_check_00251 **********\n\n");
    });

    test('00275_element_check_00252', () async {
      print("\n********** テスト実行：00275_element_check_00252 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page60.type;
      print(recogkey_activate.page60.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page60.type = testData1s;
      print(recogkey_activate.page60.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page60.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page60.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page60.type = testData2s;
      print(recogkey_activate.page60.type);
      expect(recogkey_activate.page60.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page60.type = defalut;
      print(recogkey_activate.page60.type);
      expect(recogkey_activate.page60.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page60.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00275_element_check_00252 **********\n\n");
    });

    test('00276_element_check_00253', () async {
      print("\n********** テスト実行：00276_element_check_00253 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page61.password;
      print(recogkey_activate.page61.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page61.password = testData1s;
      print(recogkey_activate.page61.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page61.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page61.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page61.password = testData2s;
      print(recogkey_activate.page61.password);
      expect(recogkey_activate.page61.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page61.password = defalut;
      print(recogkey_activate.page61.password);
      expect(recogkey_activate.page61.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00276_element_check_00253 **********\n\n");
    });

    test('00277_element_check_00254', () async {
      print("\n********** テスト実行：00277_element_check_00254 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page61.fcode;
      print(recogkey_activate.page61.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page61.fcode = testData1s;
      print(recogkey_activate.page61.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page61.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page61.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page61.fcode = testData2s;
      print(recogkey_activate.page61.fcode);
      expect(recogkey_activate.page61.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page61.fcode = defalut;
      print(recogkey_activate.page61.fcode);
      expect(recogkey_activate.page61.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00277_element_check_00254 **********\n\n");
    });

    test('00278_element_check_00255', () async {
      print("\n********** テスト実行：00278_element_check_00255 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page61.chg_flg;
      print(recogkey_activate.page61.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page61.chg_flg = testData1;
      print(recogkey_activate.page61.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page61.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page61.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page61.chg_flg = testData2;
      print(recogkey_activate.page61.chg_flg);
      expect(recogkey_activate.page61.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page61.chg_flg = defalut;
      print(recogkey_activate.page61.chg_flg);
      expect(recogkey_activate.page61.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00278_element_check_00255 **********\n\n");
    });

    test('00279_element_check_00256', () async {
      print("\n********** テスト実行：00279_element_check_00256 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page61.type;
      print(recogkey_activate.page61.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page61.type = testData1s;
      print(recogkey_activate.page61.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page61.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page61.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page61.type = testData2s;
      print(recogkey_activate.page61.type);
      expect(recogkey_activate.page61.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page61.type = defalut;
      print(recogkey_activate.page61.type);
      expect(recogkey_activate.page61.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page61.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00279_element_check_00256 **********\n\n");
    });

    test('00280_element_check_00257', () async {
      print("\n********** テスト実行：00280_element_check_00257 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page62.password;
      print(recogkey_activate.page62.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page62.password = testData1s;
      print(recogkey_activate.page62.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page62.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page62.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page62.password = testData2s;
      print(recogkey_activate.page62.password);
      expect(recogkey_activate.page62.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page62.password = defalut;
      print(recogkey_activate.page62.password);
      expect(recogkey_activate.page62.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00280_element_check_00257 **********\n\n");
    });

    test('00281_element_check_00258', () async {
      print("\n********** テスト実行：00281_element_check_00258 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page62.fcode;
      print(recogkey_activate.page62.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page62.fcode = testData1s;
      print(recogkey_activate.page62.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page62.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page62.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page62.fcode = testData2s;
      print(recogkey_activate.page62.fcode);
      expect(recogkey_activate.page62.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page62.fcode = defalut;
      print(recogkey_activate.page62.fcode);
      expect(recogkey_activate.page62.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00281_element_check_00258 **********\n\n");
    });

    test('00282_element_check_00259', () async {
      print("\n********** テスト実行：00282_element_check_00259 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page62.chg_flg;
      print(recogkey_activate.page62.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page62.chg_flg = testData1;
      print(recogkey_activate.page62.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page62.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page62.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page62.chg_flg = testData2;
      print(recogkey_activate.page62.chg_flg);
      expect(recogkey_activate.page62.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page62.chg_flg = defalut;
      print(recogkey_activate.page62.chg_flg);
      expect(recogkey_activate.page62.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00282_element_check_00259 **********\n\n");
    });

    test('00283_element_check_00260', () async {
      print("\n********** テスト実行：00283_element_check_00260 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page62.type;
      print(recogkey_activate.page62.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page62.type = testData1s;
      print(recogkey_activate.page62.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page62.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page62.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page62.type = testData2s;
      print(recogkey_activate.page62.type);
      expect(recogkey_activate.page62.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page62.type = defalut;
      print(recogkey_activate.page62.type);
      expect(recogkey_activate.page62.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page62.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00283_element_check_00260 **********\n\n");
    });

    test('00284_element_check_00261', () async {
      print("\n********** テスト実行：00284_element_check_00261 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page63.password;
      print(recogkey_activate.page63.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page63.password = testData1s;
      print(recogkey_activate.page63.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page63.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page63.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page63.password = testData2s;
      print(recogkey_activate.page63.password);
      expect(recogkey_activate.page63.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page63.password = defalut;
      print(recogkey_activate.page63.password);
      expect(recogkey_activate.page63.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00284_element_check_00261 **********\n\n");
    });

    test('00285_element_check_00262', () async {
      print("\n********** テスト実行：00285_element_check_00262 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page63.fcode;
      print(recogkey_activate.page63.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page63.fcode = testData1s;
      print(recogkey_activate.page63.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page63.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page63.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page63.fcode = testData2s;
      print(recogkey_activate.page63.fcode);
      expect(recogkey_activate.page63.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page63.fcode = defalut;
      print(recogkey_activate.page63.fcode);
      expect(recogkey_activate.page63.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00285_element_check_00262 **********\n\n");
    });

    test('00286_element_check_00263', () async {
      print("\n********** テスト実行：00286_element_check_00263 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page63.chg_flg;
      print(recogkey_activate.page63.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page63.chg_flg = testData1;
      print(recogkey_activate.page63.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page63.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page63.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page63.chg_flg = testData2;
      print(recogkey_activate.page63.chg_flg);
      expect(recogkey_activate.page63.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page63.chg_flg = defalut;
      print(recogkey_activate.page63.chg_flg);
      expect(recogkey_activate.page63.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00286_element_check_00263 **********\n\n");
    });

    test('00287_element_check_00264', () async {
      print("\n********** テスト実行：00287_element_check_00264 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page63.type;
      print(recogkey_activate.page63.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page63.type = testData1s;
      print(recogkey_activate.page63.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page63.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page63.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page63.type = testData2s;
      print(recogkey_activate.page63.type);
      expect(recogkey_activate.page63.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page63.type = defalut;
      print(recogkey_activate.page63.type);
      expect(recogkey_activate.page63.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page63.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00287_element_check_00264 **********\n\n");
    });

    test('00288_element_check_00265', () async {
      print("\n********** テスト実行：00288_element_check_00265 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page64.password;
      print(recogkey_activate.page64.password);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page64.password = testData1s;
      print(recogkey_activate.page64.password);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page64.password == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page64.password == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page64.password = testData2s;
      print(recogkey_activate.page64.password);
      expect(recogkey_activate.page64.password == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.password == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page64.password = defalut;
      print(recogkey_activate.page64.password);
      expect(recogkey_activate.page64.password == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.password == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00288_element_check_00265 **********\n\n");
    });

    test('00289_element_check_00266', () async {
      print("\n********** テスト実行：00289_element_check_00266 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page64.fcode;
      print(recogkey_activate.page64.fcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page64.fcode = testData1s;
      print(recogkey_activate.page64.fcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page64.fcode == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page64.fcode == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page64.fcode = testData2s;
      print(recogkey_activate.page64.fcode);
      expect(recogkey_activate.page64.fcode == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.fcode == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page64.fcode = defalut;
      print(recogkey_activate.page64.fcode);
      expect(recogkey_activate.page64.fcode == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.fcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00289_element_check_00266 **********\n\n");
    });

    test('00290_element_check_00267', () async {
      print("\n********** テスト実行：00290_element_check_00267 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page64.chg_flg;
      print(recogkey_activate.page64.chg_flg);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page64.chg_flg = testData1;
      print(recogkey_activate.page64.chg_flg);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page64.chg_flg == testData1, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page64.chg_flg == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page64.chg_flg = testData2;
      print(recogkey_activate.page64.chg_flg);
      expect(recogkey_activate.page64.chg_flg == testData2, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.chg_flg == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page64.chg_flg = defalut;
      print(recogkey_activate.page64.chg_flg);
      expect(recogkey_activate.page64.chg_flg == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.chg_flg == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00290_element_check_00267 **********\n\n");
    });

    test('00291_element_check_00268', () async {
      print("\n********** テスト実行：00291_element_check_00268 **********");

      recogkey_activate = Recogkey_activateJsonFile();
      allPropatyCheckInit(recogkey_activate);

      // ①loadを実行する。
      await recogkey_activate.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = recogkey_activate.page64.type;
      print(recogkey_activate.page64.type);

      // ②指定したプロパティにテストデータ1を書き込む。
      recogkey_activate.page64.type = testData1s;
      print(recogkey_activate.page64.type);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(recogkey_activate.page64.type == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await recogkey_activate.save();
      await recogkey_activate.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(recogkey_activate.page64.type == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      recogkey_activate.page64.type = testData2s;
      print(recogkey_activate.page64.type);
      expect(recogkey_activate.page64.type == testData2s, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.type == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      recogkey_activate.page64.type = defalut;
      print(recogkey_activate.page64.type);
      expect(recogkey_activate.page64.type == defalut, true);
      await recogkey_activate.save();
      await recogkey_activate.load();
      expect(recogkey_activate.page64.type == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(recogkey_activate, true);

      print("********** テスト終了：00291_element_check_00268 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Recogkey_activateJsonFile test)
{
  expect(test.server.head, "");
  expect(test.server.host, "");
  expect(test.server.url, "");
  expect(test.server.time_out, 0);
  expect(test.server.portal_user, "");
  expect(test.server.portal_pass, "");
  expect(test.server.dns1, "");
  expect(test.server.dns2, "");
  expect(test.DATE.date, 0);
  expect(test.common.limit, 0);
  expect(test.common.mac_addr, "");
  expect(test.common.chg_flg, 0);
  expect(test.page1.password, "");
  expect(test.page1.fcode, "");
  expect(test.page1.chg_flg, 0);
  expect(test.page1.type, "");
  expect(test.page2.password, "");
  expect(test.page2.fcode, "");
  expect(test.page2.chg_flg, 0);
  expect(test.page2.type, "");
  expect(test.page3.password, "");
  expect(test.page3.fcode, "");
  expect(test.page3.chg_flg, 0);
  expect(test.page3.type, "");
  expect(test.page4.password, "");
  expect(test.page4.fcode, "");
  expect(test.page4.chg_flg, 0);
  expect(test.page4.type, "");
  expect(test.page5.password, "");
  expect(test.page5.fcode, "");
  expect(test.page5.chg_flg, 0);
  expect(test.page5.type, "");
  expect(test.page6.password, "");
  expect(test.page6.fcode, "");
  expect(test.page6.chg_flg, 0);
  expect(test.page6.type, "");
  expect(test.page7.password, "");
  expect(test.page7.fcode, "");
  expect(test.page7.chg_flg, 0);
  expect(test.page7.type, "");
  expect(test.page8.password, "");
  expect(test.page8.fcode, "");
  expect(test.page8.chg_flg, 0);
  expect(test.page8.type, "");
  expect(test.page9.password, "");
  expect(test.page9.fcode, "");
  expect(test.page9.chg_flg, 0);
  expect(test.page9.type, "");
  expect(test.page10.password, "");
  expect(test.page10.fcode, "");
  expect(test.page10.chg_flg, 0);
  expect(test.page10.type, "");
  expect(test.page11.password, "");
  expect(test.page11.fcode, "");
  expect(test.page11.chg_flg, 0);
  expect(test.page11.type, "");
  expect(test.page12.password, "");
  expect(test.page12.fcode, "");
  expect(test.page12.chg_flg, 0);
  expect(test.page12.type, "");
  expect(test.page13.password, "");
  expect(test.page13.fcode, "");
  expect(test.page13.chg_flg, 0);
  expect(test.page13.type, "");
  expect(test.page14.password, "");
  expect(test.page14.fcode, "");
  expect(test.page14.chg_flg, 0);
  expect(test.page14.type, "");
  expect(test.page15.password, "");
  expect(test.page15.fcode, "");
  expect(test.page15.chg_flg, 0);
  expect(test.page15.type, "");
  expect(test.page16.password, "");
  expect(test.page16.fcode, "");
  expect(test.page16.chg_flg, 0);
  expect(test.page16.type, "");
  expect(test.page17.password, "");
  expect(test.page17.fcode, "");
  expect(test.page17.chg_flg, 0);
  expect(test.page17.type, "");
  expect(test.page18.password, "");
  expect(test.page18.fcode, "");
  expect(test.page18.chg_flg, 0);
  expect(test.page18.type, "");
  expect(test.page19.password, "");
  expect(test.page19.fcode, "");
  expect(test.page19.chg_flg, 0);
  expect(test.page19.type, "");
  expect(test.page20.password, "");
  expect(test.page20.fcode, "");
  expect(test.page20.chg_flg, 0);
  expect(test.page20.type, "");
  expect(test.page21.password, "");
  expect(test.page21.fcode, "");
  expect(test.page21.chg_flg, 0);
  expect(test.page21.type, "");
  expect(test.page22.password, "");
  expect(test.page22.fcode, "");
  expect(test.page22.chg_flg, 0);
  expect(test.page22.type, "");
  expect(test.page23.password, "");
  expect(test.page23.fcode, "");
  expect(test.page23.chg_flg, 0);
  expect(test.page23.type, "");
  expect(test.page24.password, "");
  expect(test.page24.fcode, "");
  expect(test.page24.chg_flg, 0);
  expect(test.page24.type, "");
  expect(test.page25.password, "");
  expect(test.page25.fcode, "");
  expect(test.page25.chg_flg, 0);
  expect(test.page25.type, "");
  expect(test.page26.password, "");
  expect(test.page26.fcode, "");
  expect(test.page26.chg_flg, 0);
  expect(test.page26.type, "");
  expect(test.page27.password, "");
  expect(test.page27.fcode, "");
  expect(test.page27.chg_flg, 0);
  expect(test.page27.type, "");
  expect(test.page28.password, "");
  expect(test.page28.fcode, "");
  expect(test.page28.chg_flg, 0);
  expect(test.page28.type, "");
  expect(test.page29.password, "");
  expect(test.page29.fcode, "");
  expect(test.page29.chg_flg, 0);
  expect(test.page29.type, "");
  expect(test.page30.password, "");
  expect(test.page30.fcode, "");
  expect(test.page30.chg_flg, 0);
  expect(test.page30.type, "");
  expect(test.page31.password, "");
  expect(test.page31.fcode, "");
  expect(test.page31.chg_flg, 0);
  expect(test.page31.type, "");
  expect(test.page32.password, "");
  expect(test.page32.fcode, "");
  expect(test.page32.chg_flg, 0);
  expect(test.page32.type, "");
  expect(test.page33.password, "");
  expect(test.page33.fcode, "");
  expect(test.page33.chg_flg, 0);
  expect(test.page33.type, "");
  expect(test.page34.password, "");
  expect(test.page34.fcode, "");
  expect(test.page34.chg_flg, 0);
  expect(test.page34.type, "");
  expect(test.page35.password, "");
  expect(test.page35.fcode, "");
  expect(test.page35.chg_flg, 0);
  expect(test.page35.type, "");
  expect(test.page36.password, "");
  expect(test.page36.fcode, "");
  expect(test.page36.chg_flg, 0);
  expect(test.page36.type, "");
  expect(test.page37.password, "");
  expect(test.page37.fcode, "");
  expect(test.page37.chg_flg, 0);
  expect(test.page37.type, "");
  expect(test.page38.password, "");
  expect(test.page38.fcode, "");
  expect(test.page38.chg_flg, 0);
  expect(test.page38.type, "");
  expect(test.page39.password, "");
  expect(test.page39.fcode, "");
  expect(test.page39.chg_flg, 0);
  expect(test.page39.type, "");
  expect(test.page40.password, "");
  expect(test.page40.fcode, "");
  expect(test.page40.chg_flg, 0);
  expect(test.page40.type, "");
  expect(test.page41.password, "");
  expect(test.page41.fcode, "");
  expect(test.page41.chg_flg, 0);
  expect(test.page41.type, "");
  expect(test.page42.password, "");
  expect(test.page42.fcode, "");
  expect(test.page42.chg_flg, 0);
  expect(test.page42.type, "");
  expect(test.page43.password, "");
  expect(test.page43.fcode, "");
  expect(test.page43.chg_flg, 0);
  expect(test.page43.type, "");
  expect(test.page44.password, "");
  expect(test.page44.fcode, "");
  expect(test.page44.chg_flg, 0);
  expect(test.page44.type, "");
  expect(test.page45.password, "");
  expect(test.page45.fcode, "");
  expect(test.page45.chg_flg, 0);
  expect(test.page45.type, "");
  expect(test.page46.password, "");
  expect(test.page46.fcode, "");
  expect(test.page46.chg_flg, 0);
  expect(test.page46.type, "");
  expect(test.page47.password, "");
  expect(test.page47.fcode, "");
  expect(test.page47.chg_flg, 0);
  expect(test.page47.type, "");
  expect(test.page48.password, "");
  expect(test.page48.fcode, "");
  expect(test.page48.chg_flg, 0);
  expect(test.page48.type, "");
  expect(test.page49.password, "");
  expect(test.page49.fcode, "");
  expect(test.page49.chg_flg, 0);
  expect(test.page49.type, "");
  expect(test.page50.password, "");
  expect(test.page50.fcode, "");
  expect(test.page50.chg_flg, 0);
  expect(test.page50.type, "");
  expect(test.page51.password, "");
  expect(test.page51.fcode, "");
  expect(test.page51.chg_flg, 0);
  expect(test.page51.type, "");
  expect(test.page52.password, "");
  expect(test.page52.fcode, "");
  expect(test.page52.chg_flg, 0);
  expect(test.page52.type, "");
  expect(test.page53.password, "");
  expect(test.page53.fcode, "");
  expect(test.page53.chg_flg, 0);
  expect(test.page53.type, "");
  expect(test.page54.password, "");
  expect(test.page54.fcode, "");
  expect(test.page54.chg_flg, 0);
  expect(test.page54.type, "");
  expect(test.page55.password, "");
  expect(test.page55.fcode, "");
  expect(test.page55.chg_flg, 0);
  expect(test.page55.type, "");
  expect(test.page56.password, "");
  expect(test.page56.fcode, "");
  expect(test.page56.chg_flg, 0);
  expect(test.page56.type, "");
  expect(test.page57.password, "");
  expect(test.page57.fcode, "");
  expect(test.page57.chg_flg, 0);
  expect(test.page57.type, "");
  expect(test.page58.password, "");
  expect(test.page58.fcode, "");
  expect(test.page58.chg_flg, 0);
  expect(test.page58.type, "");
  expect(test.page59.password, "");
  expect(test.page59.fcode, "");
  expect(test.page59.chg_flg, 0);
  expect(test.page59.type, "");
  expect(test.page60.password, "");
  expect(test.page60.fcode, "");
  expect(test.page60.chg_flg, 0);
  expect(test.page60.type, "");
  expect(test.page61.password, "");
  expect(test.page61.fcode, "");
  expect(test.page61.chg_flg, 0);
  expect(test.page61.type, "");
  expect(test.page62.password, "");
  expect(test.page62.fcode, "");
  expect(test.page62.chg_flg, 0);
  expect(test.page62.type, "");
  expect(test.page63.password, "");
  expect(test.page63.fcode, "");
  expect(test.page63.chg_flg, 0);
  expect(test.page63.type, "");
  expect(test.page64.password, "");
  expect(test.page64.fcode, "");
  expect(test.page64.chg_flg, 0);
  expect(test.page64.type, "");
}

void allPropatyCheck(Recogkey_activateJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.server.head, "http://");
  }
  expect(test.server.host, "iot.975194.jp");
  expect(test.server.url, "/api/v1/activate");
  expect(test.server.time_out, 180);
  expect(test.server.portal_user, "use-token-auth");
  expect(test.server.portal_pass, "Teraoka0893");
  expect(test.server.dns1, "8.8.8.8");
  expect(test.server.dns2, "8.8.4.4");
  expect(test.DATE.date, 20180601);
  expect(test.common.limit, 10);
  expect(test.common.mac_addr, "00:07:32:18:31:D5");
  expect(test.common.chg_flg, 0);
  expect(test.page1.password, "");
  expect(test.page1.fcode, "");
  expect(test.page1.chg_flg, 0);
  expect(test.page1.type, "000000000000000000");
  expect(test.page2.password, "");
  expect(test.page2.fcode, "");
  expect(test.page2.chg_flg, 0);
  expect(test.page2.type, "000000000000000000");
  expect(test.page3.password, "");
  expect(test.page3.fcode, "");
  expect(test.page3.chg_flg, 0);
  expect(test.page3.type, "000000000000000000");
  expect(test.page4.password, "");
  expect(test.page4.fcode, "");
  expect(test.page4.chg_flg, 0);
  expect(test.page4.type, "000000000000000000");
  expect(test.page5.password, "");
  expect(test.page5.fcode, "");
  expect(test.page5.chg_flg, 0);
  expect(test.page5.type, "000000000000000000");
  expect(test.page6.password, "");
  expect(test.page6.fcode, "");
  expect(test.page6.chg_flg, 0);
  expect(test.page6.type, "000000000000000000");
  expect(test.page7.password, "");
  expect(test.page7.fcode, "");
  expect(test.page7.chg_flg, 0);
  expect(test.page7.type, "000000000000000000");
  expect(test.page8.password, "");
  expect(test.page8.fcode, "");
  expect(test.page8.chg_flg, 0);
  expect(test.page8.type, "000000000000000000");
  expect(test.page9.password, "");
  expect(test.page9.fcode, "");
  expect(test.page9.chg_flg, 0);
  expect(test.page9.type, "000000000000000000");
  expect(test.page10.password, "");
  expect(test.page10.fcode, "");
  expect(test.page10.chg_flg, 0);
  expect(test.page10.type, "000000000000000000");
  expect(test.page11.password, "");
  expect(test.page11.fcode, "");
  expect(test.page11.chg_flg, 0);
  expect(test.page11.type, "000000000000000000");
  expect(test.page12.password, "");
  expect(test.page12.fcode, "");
  expect(test.page12.chg_flg, 0);
  expect(test.page12.type, "000000000000000000");
  expect(test.page13.password, "");
  expect(test.page13.fcode, "");
  expect(test.page13.chg_flg, 0);
  expect(test.page13.type, "000000000000000000");
  expect(test.page14.password, "");
  expect(test.page14.fcode, "");
  expect(test.page14.chg_flg, 0);
  expect(test.page14.type, "000000000000000000");
  expect(test.page15.password, "");
  expect(test.page15.fcode, "");
  expect(test.page15.chg_flg, 0);
  expect(test.page15.type, "000000000000000000");
  expect(test.page16.password, "");
  expect(test.page16.fcode, "");
  expect(test.page16.chg_flg, 0);
  expect(test.page16.type, "000000000000000000");
  expect(test.page17.password, "");
  expect(test.page17.fcode, "");
  expect(test.page17.chg_flg, 0);
  expect(test.page17.type, "000000000000000000");
  expect(test.page18.password, "");
  expect(test.page18.fcode, "");
  expect(test.page18.chg_flg, 0);
  expect(test.page18.type, "000000000000000000");
  expect(test.page19.password, "");
  expect(test.page19.fcode, "");
  expect(test.page19.chg_flg, 0);
  expect(test.page19.type, "000000000000000000");
  expect(test.page20.password, "");
  expect(test.page20.fcode, "");
  expect(test.page20.chg_flg, 0);
  expect(test.page20.type, "000000000000000000");
  expect(test.page21.password, "");
  expect(test.page21.fcode, "");
  expect(test.page21.chg_flg, 0);
  expect(test.page21.type, "000000000000000000");
  expect(test.page22.password, "");
  expect(test.page22.fcode, "");
  expect(test.page22.chg_flg, 0);
  expect(test.page22.type, "000000000000000000");
  expect(test.page23.password, "");
  expect(test.page23.fcode, "");
  expect(test.page23.chg_flg, 0);
  expect(test.page23.type, "000000000000000000");
  expect(test.page24.password, "");
  expect(test.page24.fcode, "");
  expect(test.page24.chg_flg, 0);
  expect(test.page24.type, "000000000000000000");
  expect(test.page25.password, "");
  expect(test.page25.fcode, "");
  expect(test.page25.chg_flg, 0);
  expect(test.page25.type, "000000000000000000");
  expect(test.page26.password, "");
  expect(test.page26.fcode, "");
  expect(test.page26.chg_flg, 0);
  expect(test.page26.type, "000000000000000000");
  expect(test.page27.password, "");
  expect(test.page27.fcode, "");
  expect(test.page27.chg_flg, 0);
  expect(test.page27.type, "000000000000000000");
  expect(test.page28.password, "");
  expect(test.page28.fcode, "");
  expect(test.page28.chg_flg, 0);
  expect(test.page28.type, "000000000000000000");
  expect(test.page29.password, "");
  expect(test.page29.fcode, "");
  expect(test.page29.chg_flg, 0);
  expect(test.page29.type, "000000000000000000");
  expect(test.page30.password, "");
  expect(test.page30.fcode, "");
  expect(test.page30.chg_flg, 0);
  expect(test.page30.type, "000000000000000000");
  expect(test.page31.password, "");
  expect(test.page31.fcode, "");
  expect(test.page31.chg_flg, 0);
  expect(test.page31.type, "000000000000000000");
  expect(test.page32.password, "");
  expect(test.page32.fcode, "");
  expect(test.page32.chg_flg, 0);
  expect(test.page32.type, "000000000000000000");
  expect(test.page33.password, "");
  expect(test.page33.fcode, "");
  expect(test.page33.chg_flg, 0);
  expect(test.page33.type, "000000000000000000");
  expect(test.page34.password, "");
  expect(test.page34.fcode, "");
  expect(test.page34.chg_flg, 0);
  expect(test.page34.type, "000000000000000000");
  expect(test.page35.password, "");
  expect(test.page35.fcode, "");
  expect(test.page35.chg_flg, 0);
  expect(test.page35.type, "000000000000000000");
  expect(test.page36.password, "");
  expect(test.page36.fcode, "");
  expect(test.page36.chg_flg, 0);
  expect(test.page36.type, "000000000000000000");
  expect(test.page37.password, "");
  expect(test.page37.fcode, "");
  expect(test.page37.chg_flg, 0);
  expect(test.page37.type, "000000000000000000");
  expect(test.page38.password, "");
  expect(test.page38.fcode, "");
  expect(test.page38.chg_flg, 0);
  expect(test.page38.type, "000000000000000000");
  expect(test.page39.password, "");
  expect(test.page39.fcode, "");
  expect(test.page39.chg_flg, 0);
  expect(test.page39.type, "000000000000000000");
  expect(test.page40.password, "");
  expect(test.page40.fcode, "");
  expect(test.page40.chg_flg, 0);
  expect(test.page40.type, "000000000000000000");
  expect(test.page41.password, "");
  expect(test.page41.fcode, "");
  expect(test.page41.chg_flg, 0);
  expect(test.page41.type, "000000000000000000");
  expect(test.page42.password, "");
  expect(test.page42.fcode, "");
  expect(test.page42.chg_flg, 0);
  expect(test.page42.type, "000000000000000000");
  expect(test.page43.password, "");
  expect(test.page43.fcode, "");
  expect(test.page43.chg_flg, 0);
  expect(test.page43.type, "000000000000000000");
  expect(test.page44.password, "");
  expect(test.page44.fcode, "");
  expect(test.page44.chg_flg, 0);
  expect(test.page44.type, "000000000000000000");
  expect(test.page45.password, "");
  expect(test.page45.fcode, "");
  expect(test.page45.chg_flg, 0);
  expect(test.page45.type, "000000000000000000");
  expect(test.page46.password, "");
  expect(test.page46.fcode, "");
  expect(test.page46.chg_flg, 0);
  expect(test.page46.type, "000000000000000000");
  expect(test.page47.password, "");
  expect(test.page47.fcode, "");
  expect(test.page47.chg_flg, 0);
  expect(test.page47.type, "000000000000000000");
  expect(test.page48.password, "");
  expect(test.page48.fcode, "");
  expect(test.page48.chg_flg, 0);
  expect(test.page48.type, "000000000000000000");
  expect(test.page49.password, "");
  expect(test.page49.fcode, "");
  expect(test.page49.chg_flg, 0);
  expect(test.page49.type, "000000000000000000");
  expect(test.page50.password, "");
  expect(test.page50.fcode, "");
  expect(test.page50.chg_flg, 0);
  expect(test.page50.type, "000000000000000000");
  expect(test.page51.password, "");
  expect(test.page51.fcode, "");
  expect(test.page51.chg_flg, 0);
  expect(test.page51.type, "000000000000000000");
  expect(test.page52.password, "");
  expect(test.page52.fcode, "");
  expect(test.page52.chg_flg, 0);
  expect(test.page52.type, "000000000000000000");
  expect(test.page53.password, "");
  expect(test.page53.fcode, "");
  expect(test.page53.chg_flg, 0);
  expect(test.page53.type, "000000000000000000");
  expect(test.page54.password, "");
  expect(test.page54.fcode, "");
  expect(test.page54.chg_flg, 0);
  expect(test.page54.type, "000000000000000000");
  expect(test.page55.password, "");
  expect(test.page55.fcode, "");
  expect(test.page55.chg_flg, 0);
  expect(test.page55.type, "000000000000000000");
  expect(test.page56.password, "");
  expect(test.page56.fcode, "");
  expect(test.page56.chg_flg, 0);
  expect(test.page56.type, "000000000000000000");
  expect(test.page57.password, "");
  expect(test.page57.fcode, "");
  expect(test.page57.chg_flg, 0);
  expect(test.page57.type, "000000000000000000");
  expect(test.page58.password, "");
  expect(test.page58.fcode, "");
  expect(test.page58.chg_flg, 0);
  expect(test.page58.type, "000000000000000000");
  expect(test.page59.password, "");
  expect(test.page59.fcode, "");
  expect(test.page59.chg_flg, 0);
  expect(test.page59.type, "000000000000000000");
  expect(test.page60.password, "");
  expect(test.page60.fcode, "");
  expect(test.page60.chg_flg, 0);
  expect(test.page60.type, "000000000000000000");
  expect(test.page61.password, "");
  expect(test.page61.fcode, "");
  expect(test.page61.chg_flg, 0);
  expect(test.page61.type, "000000000000000000");
  expect(test.page62.password, "");
  expect(test.page62.fcode, "");
  expect(test.page62.chg_flg, 0);
  expect(test.page62.type, "000000000000000000");
  expect(test.page63.password, "");
  expect(test.page63.fcode, "");
  expect(test.page63.chg_flg, 0);
  expect(test.page63.type, "000000000000000000");
  expect(test.page64.password, "");
  expect(test.page64.fcode, "");
  expect(test.page64.chg_flg, 0);
  expect(test.page64.type, "000000000000000000");
}

