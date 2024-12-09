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
import '../../../../lib/app/common/cls_conf/fjssJsonFile.dart';

late FjssJsonFile fjss;

void main(){
  fjssJsonFile_test();
}

void fjssJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/aa/";
  const String testDir = "test_assets";
  const String fileName = "fjss.json";
  const String section = "fjss_system";
  const String key = "send_start";
  const defaultData = 0;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('FjssJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await FjssJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await FjssJsonFile().setDefault();
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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await fjss.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(fjss,true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        fjss.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await fjss.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(fjss,true);

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
      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①：loadを実行する。
      await fjss.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = fjss.fjss_system.send_start;
      fjss.fjss_system.send_start = testData1;
      expect(fjss.fjss_system.send_start == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await fjss.load();
      expect(fjss.fjss_system.send_start != testData1, true);
      expect(fjss.fjss_system.send_start == prefixData, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = fjss.fjss_system.send_start;
      fjss.fjss_system.send_start = testData1;
      expect(fjss.fjss_system.send_start, testData1);

      // ③saveを実行する。
      await fjss.save();

      // ④loadを実行する。
      await fjss.load();

      expect(fjss.fjss_system.send_start != prefixData, true);
      expect(fjss.fjss_system.send_start == testData1, true);
      allPropatyCheck(fjss,false);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await fjss.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await fjss.save();

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await fjss.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(fjss.fjss_system.send_start, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = fjss.fjss_system.send_start;
      fjss.fjss_system.send_start = testData1;

      // ③ saveを実行する。
      await fjss.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(fjss.fjss_system.send_start, testData1);

      // ④ loadを実行する。
      await fjss.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(fjss.fjss_system.send_start == testData1, true);
      allPropatyCheck(fjss,false);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await fjss.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(fjss,true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②任意のプロパティの値を変更する。
      fjss.fjss_system.send_start = testData1;
      expect(fjss.fjss_system.send_start, testData1);

      // ③saveを実行する。
      await fjss.save();
      expect(fjss.fjss_system.send_start, testData1);

      // ④loadを実行する。
      await fjss.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(fjss,true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await fjss.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await fjss.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(fjss.fjss_system.send_start == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await fjss.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await fjss.setValueWithName(section, "test_key", testData1);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②任意のプロパティを変更する。
      fjss.fjss_system.send_start = testData1;

      // ③saveを実行する。
      await fjss.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await fjss.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②任意のプロパティを変更する。
      fjss.fjss_system.send_start = testData1;

      // ③saveを実行する。
      await fjss.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await fjss.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②任意のプロパティを変更する。
      fjss.fjss_system.send_start = testData1;

      // ③saveを実行する。
      await fjss.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await fjss.getValueWithName(section, "test_key");
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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await fjss.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      fjss.fjss_system.send_start = testData1;
      expect(fjss.fjss_system.send_start, testData1);

      // ④saveを実行する。
      await fjss.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(fjss.fjss_system.send_start, testData1);
      
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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await fjss.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData1, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await fjss.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData2, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await fjss.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData1, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await fjss.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData2, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await fjss.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData1, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await fjss.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData1, true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await fjss.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      allPropatyCheck(fjss,true);

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

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await fjss.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + fjss.fjss_system.send_start.toString());
      allPropatyCheck(fjss,true);

      print("********** テスト終了：00023_restoreJson_08 **********\n\n");
    });

    // ********************************************************
    // テスト00020 : 言語切換（changeLanguage）
    // 事前条件：assets/confに対象JSONファイルが存在すること。
    // 試験手順：①当該フォルダと同階層にex、cn、twのフォルダを作成する。
    //         ②任意のプロパティ値を変更し、①の各フォルダにJSONのコピーを作成する。
    //         ③changeLanguageを実行し、exフォルダに切り替える。
    //         ④loadを実行する。
    //         ⑤changeLanguageを実行し、cnフォルダに切り替える。
    //         ⑥loadを実行する。
    //         ⑦changeLanguageを実行し、twフォルダに切り替える。
    //         ⑧loadを実行する。
    // 期待結果：手順④、⑥、⑧実行後、手順①で作成したJSONファイルのプロパティ値を読み込むこと。
    // ********************************************************
    test('00020_changeLanguage', () async {
      print("\n********** テスト実行：00020_changeLanguage_01 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①当該フォルダと同階層にex、cn、twのフォルダを作成する。
      // ②任意のプロパティ値を変更し、①の各フォルダにJSONのコピーを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern9, section, key, testData1, testData2, testData3);
      await getTestDate(confPath, fileName, testFunc.getPattern9);

      // ③changeLanguageを実行し、exフォルダに切り替える。
      // ④loadを実行する。
      fjss.changeLanguage(JsonLanguage.ex);
      await fjss.load();
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData1, true);
      allPropatyCheck(fjss,false);
      // ⑤changeLanguageを実行し、cnフォルダに切り替える。
      // ⑥loadを実行する。
      fjss.changeLanguage(JsonLanguage.cn);
      await fjss.load();
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData2, true);
      allPropatyCheck(fjss,false);
      // ⑦changeLanguageを実行し、twフォルダに切り替える。
      // ⑧loadを実行する。
      fjss.changeLanguage(JsonLanguage.tw);
      await fjss.load();
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == testData3, true);
      allPropatyCheck(fjss,false);
      // ⑨changeLanguageを実行し、aaフォルダに切り替える。
      // ⑩loadを実行する。
      fjss.changeLanguage(JsonLanguage.aa);
      await fjss.load();
      print("check:" + fjss.fjss_system.send_start.toString());
      expect(fjss.fjss_system.send_start == defaultData, true);
      allPropatyCheck(fjss,false);

      print("********** テスト終了：00020_changeLanguage_01 **********\n\n");
    });

    // ********************************************************
    // テスト00025 ～ : 要素取得・設定
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
     test('00025_element_check_00001', () async {
      print("\n********** テスト実行：00025_element_check_00001 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.fjss_system.send_start;
      print(fjss.fjss_system.send_start);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.fjss_system.send_start = testData1;
      print(fjss.fjss_system.send_start);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.fjss_system.send_start == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.fjss_system.send_start == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.fjss_system.send_start = testData2;
      print(fjss.fjss_system.send_start);
      expect(fjss.fjss_system.send_start == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.fjss_system.send_start == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.fjss_system.send_start = defalut;
      print(fjss.fjss_system.send_start);
      expect(fjss.fjss_system.send_start == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.fjss_system.send_start == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00025_element_check_00001 **********\n\n");
    });

    test('00026_element_check_00002', () async {
      print("\n********** テスト実行：00026_element_check_00002 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.fjss_system.sendcnt;
      print(fjss.fjss_system.sendcnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.fjss_system.sendcnt = testData1;
      print(fjss.fjss_system.sendcnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.fjss_system.sendcnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.fjss_system.sendcnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.fjss_system.sendcnt = testData2;
      print(fjss.fjss_system.sendcnt);
      expect(fjss.fjss_system.sendcnt == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.fjss_system.sendcnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.fjss_system.sendcnt = defalut;
      print(fjss.fjss_system.sendcnt);
      expect(fjss.fjss_system.sendcnt == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.fjss_system.sendcnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00026_element_check_00002 **********\n\n");
    });

    test('00027_element_check_00003', () async {
      print("\n********** テスト実行：00027_element_check_00003 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.fjss_system.senditemcnt;
      print(fjss.fjss_system.senditemcnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.fjss_system.senditemcnt = testData1;
      print(fjss.fjss_system.senditemcnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.fjss_system.senditemcnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.fjss_system.senditemcnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.fjss_system.senditemcnt = testData2;
      print(fjss.fjss_system.senditemcnt);
      expect(fjss.fjss_system.senditemcnt == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.fjss_system.senditemcnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.fjss_system.senditemcnt = defalut;
      print(fjss.fjss_system.senditemcnt);
      expect(fjss.fjss_system.senditemcnt == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.fjss_system.senditemcnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00027_element_check_00003 **********\n\n");
    });

    test('00028_element_check_00004', () async {
      print("\n********** テスト実行：00028_element_check_00004 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.csv_dly.dly_clothes;
      print(fjss.csv_dly.dly_clothes);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.csv_dly.dly_clothes = testData1;
      print(fjss.csv_dly.dly_clothes);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.csv_dly.dly_clothes == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.csv_dly.dly_clothes == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.csv_dly.dly_clothes = testData2;
      print(fjss.csv_dly.dly_clothes);
      expect(fjss.csv_dly.dly_clothes == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.csv_dly.dly_clothes == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.csv_dly.dly_clothes = defalut;
      print(fjss.csv_dly.dly_clothes);
      expect(fjss.csv_dly.dly_clothes == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.csv_dly.dly_clothes == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00028_element_check_00004 **********\n\n");
    });

    test('00029_element_check_00005', () async {
      print("\n********** テスト実行：00029_element_check_00005 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.csv_dly.dlyclothes_week;
      print(fjss.csv_dly.dlyclothes_week);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.csv_dly.dlyclothes_week = testData1;
      print(fjss.csv_dly.dlyclothes_week);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.csv_dly.dlyclothes_week == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.csv_dly.dlyclothes_week == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.csv_dly.dlyclothes_week = testData2;
      print(fjss.csv_dly.dlyclothes_week);
      expect(fjss.csv_dly.dlyclothes_week == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.csv_dly.dlyclothes_week == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.csv_dly.dlyclothes_week = defalut;
      print(fjss.csv_dly.dlyclothes_week);
      expect(fjss.csv_dly.dlyclothes_week == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.csv_dly.dlyclothes_week == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00029_element_check_00005 **********\n\n");
    });

    test('00030_element_check_00006', () async {
      print("\n********** テスト実行：00030_element_check_00006 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.csv_dly.dlyclothes_day;
      print(fjss.csv_dly.dlyclothes_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.csv_dly.dlyclothes_day = testData1;
      print(fjss.csv_dly.dlyclothes_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.csv_dly.dlyclothes_day == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.csv_dly.dlyclothes_day == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.csv_dly.dlyclothes_day = testData2;
      print(fjss.csv_dly.dlyclothes_day);
      expect(fjss.csv_dly.dlyclothes_day == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.csv_dly.dlyclothes_day == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.csv_dly.dlyclothes_day = defalut;
      print(fjss.csv_dly.dlyclothes_day);
      expect(fjss.csv_dly.dlyclothes_day == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.csv_dly.dlyclothes_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00030_element_check_00006 **********\n\n");
    });

    test('00031_element_check_00007', () async {
      print("\n********** テスト実行：00031_element_check_00007 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.max_item.total_item;
      print(fjss.max_item.total_item);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.max_item.total_item = testData1;
      print(fjss.max_item.total_item);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.max_item.total_item == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.max_item.total_item == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.max_item.total_item = testData2;
      print(fjss.max_item.total_item);
      expect(fjss.max_item.total_item == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.max_item.total_item == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.max_item.total_item = defalut;
      print(fjss.max_item.total_item);
      expect(fjss.max_item.total_item == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.max_item.total_item == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00031_element_check_00007 **********\n\n");
    });

    test('00032_element_check_00008', () async {
      print("\n********** テスト実行：00032_element_check_00008 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.page.total_page;
      print(fjss.page.total_page);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.page.total_page = testData1;
      print(fjss.page.total_page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.page.total_page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.page.total_page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.page.total_page = testData2;
      print(fjss.page.total_page);
      expect(fjss.page.total_page == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.page.total_page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.page.total_page = defalut;
      print(fjss.page.total_page);
      expect(fjss.page.total_page == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.page.total_page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00032_element_check_00008 **********\n\n");
    });

    test('00033_element_check_00009', () async {
      print("\n********** テスト実行：00033_element_check_00009 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.page.onoff0;
      print(fjss.page.onoff0);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.page.onoff0 = testData1;
      print(fjss.page.onoff0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.page.onoff0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.page.onoff0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.page.onoff0 = testData2;
      print(fjss.page.onoff0);
      expect(fjss.page.onoff0 == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.page.onoff0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.page.onoff0 = defalut;
      print(fjss.page.onoff0);
      expect(fjss.page.onoff0 == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.page.onoff0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00033_element_check_00009 **********\n\n");
    });

    test('00034_element_check_00010', () async {
      print("\n********** テスト実行：00034_element_check_00010 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.onoff;
      print(fjss.item0.onoff);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.onoff = testData1;
      print(fjss.item0.onoff);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.onoff == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.onoff == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.onoff = testData2;
      print(fjss.item0.onoff);
      expect(fjss.item0.onoff == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.onoff == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.onoff = defalut;
      print(fjss.item0.onoff);
      expect(fjss.item0.onoff == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.onoff == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00034_element_check_00010 **********\n\n");
    });

    test('00035_element_check_00011', () async {
      print("\n********** テスト実行：00035_element_check_00011 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.page;
      print(fjss.item0.page);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.page = testData1;
      print(fjss.item0.page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.page = testData2;
      print(fjss.item0.page);
      expect(fjss.item0.page == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.page = defalut;
      print(fjss.item0.page);
      expect(fjss.item0.page == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00035_element_check_00011 **********\n\n");
    });

    test('00036_element_check_00012', () async {
      print("\n********** テスト実行：00036_element_check_00012 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.position;
      print(fjss.item0.position);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.position = testData1;
      print(fjss.item0.position);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.position == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.position == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.position = testData2;
      print(fjss.item0.position);
      expect(fjss.item0.position == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.position == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.position = defalut;
      print(fjss.item0.position);
      expect(fjss.item0.position == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.position == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00036_element_check_00012 **********\n\n");
    });

    test('00037_element_check_00013', () async {
      print("\n********** テスト実行：00037_element_check_00013 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.table1;
      print(fjss.item0.table1);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.table1 = testData1s;
      print(fjss.item0.table1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.table1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.table1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.table1 = testData2s;
      print(fjss.item0.table1);
      expect(fjss.item0.table1 == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.table1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.table1 = defalut;
      print(fjss.item0.table1);
      expect(fjss.item0.table1 == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.table1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00037_element_check_00013 **********\n\n");
    });

    test('00038_element_check_00014', () async {
      print("\n********** テスト実行：00038_element_check_00014 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.total;
      print(fjss.item0.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.total = testData1;
      print(fjss.item0.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.total == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.total == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.total = testData2;
      print(fjss.item0.total);
      expect(fjss.item0.total == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.total == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.total = defalut;
      print(fjss.item0.total);
      expect(fjss.item0.total == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00038_element_check_00014 **********\n\n");
    });

    test('00039_element_check_00015', () async {
      print("\n********** テスト実行：00039_element_check_00015 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.t_exe1;
      print(fjss.item0.t_exe1);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.t_exe1 = testData1s;
      print(fjss.item0.t_exe1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.t_exe1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.t_exe1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.t_exe1 = testData2s;
      print(fjss.item0.t_exe1);
      expect(fjss.item0.t_exe1 == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.t_exe1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.t_exe1 = defalut;
      print(fjss.item0.t_exe1);
      expect(fjss.item0.t_exe1 == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.t_exe1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00039_element_check_00015 **********\n\n");
    });

    test('00040_element_check_00016', () async {
      print("\n********** テスト実行：00040_element_check_00016 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.section;
      print(fjss.item0.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.section = testData1s;
      print(fjss.item0.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.section = testData2s;
      print(fjss.item0.section);
      expect(fjss.item0.section == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.section = defalut;
      print(fjss.item0.section);
      expect(fjss.item0.section == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00040_element_check_00016 **********\n\n");
    });

    test('00041_element_check_00017', () async {
      print("\n********** テスト実行：00041_element_check_00017 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.keyword;
      print(fjss.item0.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.keyword = testData1s;
      print(fjss.item0.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.keyword = testData2s;
      print(fjss.item0.keyword);
      expect(fjss.item0.keyword == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.keyword = defalut;
      print(fjss.item0.keyword);
      expect(fjss.item0.keyword == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00041_element_check_00017 **********\n\n");
    });

    test('00042_element_check_00018', () async {
      print("\n********** テスト実行：00042_element_check_00018 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.backup_day;
      print(fjss.item0.backup_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.backup_day = testData1s;
      print(fjss.item0.backup_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.backup_day == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.backup_day == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.backup_day = testData2s;
      print(fjss.item0.backup_day);
      expect(fjss.item0.backup_day == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.backup_day == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.backup_day = defalut;
      print(fjss.item0.backup_day);
      expect(fjss.item0.backup_day == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.backup_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00042_element_check_00018 **********\n\n");
    });

    test('00043_element_check_00019', () async {
      print("\n********** テスト実行：00043_element_check_00019 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item0.select_dsp;
      print(fjss.item0.select_dsp);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item0.select_dsp = testData1;
      print(fjss.item0.select_dsp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item0.select_dsp == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item0.select_dsp == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item0.select_dsp = testData2;
      print(fjss.item0.select_dsp);
      expect(fjss.item0.select_dsp == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.select_dsp == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item0.select_dsp = defalut;
      print(fjss.item0.select_dsp);
      expect(fjss.item0.select_dsp == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item0.select_dsp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00043_element_check_00019 **********\n\n");
    });

    test('00044_element_check_00020', () async {
      print("\n********** テスト実行：00044_element_check_00020 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.onoff;
      print(fjss.item1.onoff);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.onoff = testData1;
      print(fjss.item1.onoff);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.onoff == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.onoff == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.onoff = testData2;
      print(fjss.item1.onoff);
      expect(fjss.item1.onoff == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.onoff == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.onoff = defalut;
      print(fjss.item1.onoff);
      expect(fjss.item1.onoff == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.onoff == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00044_element_check_00020 **********\n\n");
    });

    test('00045_element_check_00021', () async {
      print("\n********** テスト実行：00045_element_check_00021 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.page;
      print(fjss.item1.page);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.page = testData1;
      print(fjss.item1.page);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.page == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.page == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.page = testData2;
      print(fjss.item1.page);
      expect(fjss.item1.page == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.page == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.page = defalut;
      print(fjss.item1.page);
      expect(fjss.item1.page == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.page == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00045_element_check_00021 **********\n\n");
    });

    test('00046_element_check_00022', () async {
      print("\n********** テスト実行：00046_element_check_00022 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.position;
      print(fjss.item1.position);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.position = testData1;
      print(fjss.item1.position);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.position == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.position == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.position = testData2;
      print(fjss.item1.position);
      expect(fjss.item1.position == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.position == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.position = defalut;
      print(fjss.item1.position);
      expect(fjss.item1.position == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.position == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00046_element_check_00022 **********\n\n");
    });

    test('00047_element_check_00023', () async {
      print("\n********** テスト実行：00047_element_check_00023 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.table1;
      print(fjss.item1.table1);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.table1 = testData1s;
      print(fjss.item1.table1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.table1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.table1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.table1 = testData2s;
      print(fjss.item1.table1);
      expect(fjss.item1.table1 == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.table1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.table1 = defalut;
      print(fjss.item1.table1);
      expect(fjss.item1.table1 == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.table1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00047_element_check_00023 **********\n\n");
    });

    test('00048_element_check_00024', () async {
      print("\n********** テスト実行：00048_element_check_00024 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.total;
      print(fjss.item1.total);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.total = testData1;
      print(fjss.item1.total);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.total == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.total == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.total = testData2;
      print(fjss.item1.total);
      expect(fjss.item1.total == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.total == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.total = defalut;
      print(fjss.item1.total);
      expect(fjss.item1.total == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.total == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00048_element_check_00024 **********\n\n");
    });

    test('00049_element_check_00025', () async {
      print("\n********** テスト実行：00049_element_check_00025 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.t_exe1;
      print(fjss.item1.t_exe1);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.t_exe1 = testData1s;
      print(fjss.item1.t_exe1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.t_exe1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.t_exe1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.t_exe1 = testData2s;
      print(fjss.item1.t_exe1);
      expect(fjss.item1.t_exe1 == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.t_exe1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.t_exe1 = defalut;
      print(fjss.item1.t_exe1);
      expect(fjss.item1.t_exe1 == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.t_exe1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00049_element_check_00025 **********\n\n");
    });

    test('00050_element_check_00026', () async {
      print("\n********** テスト実行：00050_element_check_00026 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.section;
      print(fjss.item1.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.section = testData1s;
      print(fjss.item1.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.section = testData2s;
      print(fjss.item1.section);
      expect(fjss.item1.section == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.section = defalut;
      print(fjss.item1.section);
      expect(fjss.item1.section == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00050_element_check_00026 **********\n\n");
    });

    test('00051_element_check_00027', () async {
      print("\n********** テスト実行：00051_element_check_00027 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.keyword;
      print(fjss.item1.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.keyword = testData1s;
      print(fjss.item1.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.keyword = testData2s;
      print(fjss.item1.keyword);
      expect(fjss.item1.keyword == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.keyword = defalut;
      print(fjss.item1.keyword);
      expect(fjss.item1.keyword == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00051_element_check_00027 **********\n\n");
    });

    test('00052_element_check_00028', () async {
      print("\n********** テスト実行：00052_element_check_00028 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.keyword2;
      print(fjss.item1.keyword2);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.keyword2 = testData1s;
      print(fjss.item1.keyword2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.keyword2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.keyword2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.keyword2 = testData2s;
      print(fjss.item1.keyword2);
      expect(fjss.item1.keyword2 == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.keyword2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.keyword2 = defalut;
      print(fjss.item1.keyword2);
      expect(fjss.item1.keyword2 == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.keyword2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00052_element_check_00028 **********\n\n");
    });

    test('00053_element_check_00029', () async {
      print("\n********** テスト実行：00053_element_check_00029 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.backup_day;
      print(fjss.item1.backup_day);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.backup_day = testData1s;
      print(fjss.item1.backup_day);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.backup_day == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.backup_day == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.backup_day = testData2s;
      print(fjss.item1.backup_day);
      expect(fjss.item1.backup_day == testData2s, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.backup_day == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.backup_day = defalut;
      print(fjss.item1.backup_day);
      expect(fjss.item1.backup_day == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.backup_day == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00053_element_check_00029 **********\n\n");
    });

    test('00054_element_check_00030', () async {
      print("\n********** テスト実行：00054_element_check_00030 **********");

      fjss = FjssJsonFile();
      allPropatyCheckInit(fjss);

      // ①loadを実行する。
      await fjss.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = fjss.item1.select_dsp;
      print(fjss.item1.select_dsp);

      // ②指定したプロパティにテストデータ1を書き込む。
      fjss.item1.select_dsp = testData1;
      print(fjss.item1.select_dsp);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(fjss.item1.select_dsp == testData1, true);

      // ④saveを実行後、loadを実行する。
      await fjss.save();
      await fjss.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(fjss.item1.select_dsp == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      fjss.item1.select_dsp = testData2;
      print(fjss.item1.select_dsp);
      expect(fjss.item1.select_dsp == testData2, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.select_dsp == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      fjss.item1.select_dsp = defalut;
      print(fjss.item1.select_dsp);
      expect(fjss.item1.select_dsp == defalut, true);
      await fjss.save();
      await fjss.load();
      expect(fjss.item1.select_dsp == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(fjss, true);

      print("********** テスト終了：00054_element_check_00030 **********\n\n");
    });

  });
}

void allPropatyCheckInit(FjssJsonFile test)
{
  expect(test.fjss_system.send_start, 0);
  expect(test.fjss_system.sendcnt, 0);
  expect(test.fjss_system.senditemcnt, 0);
  expect(test.csv_dly.dly_clothes, 0);
  expect(test.csv_dly.dlyclothes_week, 0);
  expect(test.csv_dly.dlyclothes_day, 0);
  expect(test.max_item.total_item, 0);
  expect(test.page.total_page, 0);
  expect(test.page.onoff0, 0);
  expect(test.item0.onoff, 0);
  expect(test.item0.page, 0);
  expect(test.item0.position, 0);
  expect(test.item0.table1, "");
  expect(test.item0.total, 0);
  expect(test.item0.t_exe1, "");
  expect(test.item0.section, "");
  expect(test.item0.keyword, "");
  expect(test.item0.backup_day, "");
  expect(test.item0.select_dsp, 0);
  expect(test.item1.onoff, 0);
  expect(test.item1.page, 0);
  expect(test.item1.position, 0);
  expect(test.item1.table1, "");
  expect(test.item1.total, 0);
  expect(test.item1.t_exe1, "");
  expect(test.item1.section, "");
  expect(test.item1.keyword, "");
  expect(test.item1.keyword2, "");
  expect(test.item1.backup_day, "");
  expect(test.item1.select_dsp, 0);
}

void allPropatyCheck(FjssJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.fjss_system.send_start, 0);
  }
  expect(test.fjss_system.sendcnt, 0);
  expect(test.fjss_system.senditemcnt, 0);
  expect(test.csv_dly.dly_clothes, 1);
  expect(test.csv_dly.dlyclothes_week, 0);
  expect(test.csv_dly.dlyclothes_day, 1);
  expect(test.max_item.total_item, 2);
  expect(test.page.total_page, 1);
  expect(test.page.onoff0, 0);
  expect(test.item0.onoff, 0);
  expect(test.item0.page, 1);
  expect(test.item0.position, 1);
  expect(test.item0.table1, "衣料商品");
  expect(test.item0.total, 1);
  expect(test.item0.t_exe1, "KEDI");
  expect(test.item0.section, "csv_dly");
  expect(test.item0.keyword, "dly_clothes");
  expect(test.item0.backup_day, "0000-00-00");
  expect(test.item0.select_dsp, 0);
  expect(test.item1.onoff, 0);
  expect(test.item1.page, 1);
  expect(test.item1.position, 13);
  expect(test.item1.table1, "電子ｼﾞｬｰﾅﾙ累計");
  expect(test.item1.total, 1);
  expect(test.item1.t_exe1, "c_ejlog");
  expect(test.item1.section, "csv_dly");
  expect(test.item1.keyword, "dly_ejlog_manual");
  expect(test.item1.keyword2, "dlyejlog_week");
  expect(test.item1.backup_day, "0000-00-00");
  expect(test.item1.select_dsp, 0);
}

