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
import '../../../../lib/app/common/cls_conf/hqhistJsonFile.dart';

late HqhistJsonFile hqhist;

void main(){
  hqhistJsonFile_test();
}

void hqhistJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "hqhist.json";
  const String section = "cycle";
  const String key = "value";
  const defaultData = 9999;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('HqhistJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await HqhistJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await HqhistJsonFile().setDefault();
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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await hqhist.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(hqhist,true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        hqhist.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await hqhist.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(hqhist,true);

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
      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①：loadを実行する。
      await hqhist.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hqhist.cycle.value;
      hqhist.cycle.value = testData1;
      expect(hqhist.cycle.value == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await hqhist.load();
      expect(hqhist.cycle.value != testData1, true);
      expect(hqhist.cycle.value == prefixData, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hqhist.cycle.value;
      hqhist.cycle.value = testData1;
      expect(hqhist.cycle.value, testData1);

      // ③saveを実行する。
      await hqhist.save();

      // ④loadを実行する。
      await hqhist.load();

      expect(hqhist.cycle.value != prefixData, true);
      expect(hqhist.cycle.value == testData1, true);
      allPropatyCheck(hqhist,false);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hqhist.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await hqhist.save();

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hqhist.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(hqhist.cycle.value, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = hqhist.cycle.value;
      hqhist.cycle.value = testData1;

      // ③ saveを実行する。
      await hqhist.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(hqhist.cycle.value, testData1);

      // ④ loadを実行する。
      await hqhist.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(hqhist.cycle.value == testData1, true);
      allPropatyCheck(hqhist,false);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await hqhist.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(hqhist,true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②任意のプロパティの値を変更する。
      hqhist.cycle.value = testData1;
      expect(hqhist.cycle.value, testData1);

      // ③saveを実行する。
      await hqhist.save();
      expect(hqhist.cycle.value, testData1);

      // ④loadを実行する。
      await hqhist.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(hqhist,true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await hqhist.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await hqhist.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hqhist.cycle.value == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hqhist.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hqhist.setValueWithName(section, "test_key", testData1);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②任意のプロパティを変更する。
      hqhist.cycle.value = testData1;

      // ③saveを実行する。
      await hqhist.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hqhist.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②任意のプロパティを変更する。
      hqhist.cycle.value = testData1;

      // ③saveを実行する。
      await hqhist.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hqhist.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②任意のプロパティを変更する。
      hqhist.cycle.value = testData1;

      // ③saveを実行する。
      await hqhist.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hqhist.getValueWithName(section, "test_key");
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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await hqhist.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      hqhist.cycle.value = testData1;
      expect(hqhist.cycle.value, testData1);

      // ④saveを実行する。
      await hqhist.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hqhist.cycle.value, testData1);
      
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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await hqhist.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      expect(hqhist.cycle.value == testData1, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await hqhist.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      expect(hqhist.cycle.value == testData2, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await hqhist.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      expect(hqhist.cycle.value == testData1, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await hqhist.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      expect(hqhist.cycle.value == testData2, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await hqhist.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      expect(hqhist.cycle.value == testData1, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await hqhist.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      expect(hqhist.cycle.value == testData1, true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await hqhist.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      allPropatyCheck(hqhist,true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await hqhist.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hqhist.cycle.value.toString());
      allPropatyCheck(hqhist,true);

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

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.cycle.value;
      print(hqhist.cycle.value);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.cycle.value = testData1;
      print(hqhist.cycle.value);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.cycle.value == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.cycle.value == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.cycle.value = testData2;
      print(hqhist.cycle.value);
      expect(hqhist.cycle.value == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.cycle.value == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.cycle.value = defalut;
      print(hqhist.cycle.value);
      expect(hqhist.cycle.value == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.cycle.value == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value1;
      print(hqhist.specify.value1);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value1 = testData1s;
      print(hqhist.specify.value1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value1 = testData2s;
      print(hqhist.specify.value1);
      expect(hqhist.specify.value1 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value1 = defalut;
      print(hqhist.specify.value1);
      expect(hqhist.specify.value1 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value2;
      print(hqhist.specify.value2);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value2 = testData1s;
      print(hqhist.specify.value2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value2 = testData2s;
      print(hqhist.specify.value2);
      expect(hqhist.specify.value2 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value2 = defalut;
      print(hqhist.specify.value2);
      expect(hqhist.specify.value2 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value3;
      print(hqhist.specify.value3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value3 = testData1s;
      print(hqhist.specify.value3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value3 = testData2s;
      print(hqhist.specify.value3);
      expect(hqhist.specify.value3 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value3 = defalut;
      print(hqhist.specify.value3);
      expect(hqhist.specify.value3 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value4;
      print(hqhist.specify.value4);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value4 = testData1s;
      print(hqhist.specify.value4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value4 = testData2s;
      print(hqhist.specify.value4);
      expect(hqhist.specify.value4 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value4 = defalut;
      print(hqhist.specify.value4);
      expect(hqhist.specify.value4 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value5;
      print(hqhist.specify.value5);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value5 = testData1s;
      print(hqhist.specify.value5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value5 = testData2s;
      print(hqhist.specify.value5);
      expect(hqhist.specify.value5 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value5 = defalut;
      print(hqhist.specify.value5);
      expect(hqhist.specify.value5 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value6;
      print(hqhist.specify.value6);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value6 = testData1s;
      print(hqhist.specify.value6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value6 = testData2s;
      print(hqhist.specify.value6);
      expect(hqhist.specify.value6 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value6 = defalut;
      print(hqhist.specify.value6);
      expect(hqhist.specify.value6 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value7;
      print(hqhist.specify.value7);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value7 = testData1s;
      print(hqhist.specify.value7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value7 = testData2s;
      print(hqhist.specify.value7);
      expect(hqhist.specify.value7 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value7 = defalut;
      print(hqhist.specify.value7);
      expect(hqhist.specify.value7 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value8;
      print(hqhist.specify.value8);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value8 = testData1s;
      print(hqhist.specify.value8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value8 = testData2s;
      print(hqhist.specify.value8);
      expect(hqhist.specify.value8 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value8 = defalut;
      print(hqhist.specify.value8);
      expect(hqhist.specify.value8 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value9;
      print(hqhist.specify.value9);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value9 = testData1s;
      print(hqhist.specify.value9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value9 = testData2s;
      print(hqhist.specify.value9);
      expect(hqhist.specify.value9 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value9 = defalut;
      print(hqhist.specify.value9);
      expect(hqhist.specify.value9 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value10;
      print(hqhist.specify.value10);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value10 = testData1s;
      print(hqhist.specify.value10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value10 = testData2s;
      print(hqhist.specify.value10);
      expect(hqhist.specify.value10 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value10 = defalut;
      print(hqhist.specify.value10);
      expect(hqhist.specify.value10 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value11;
      print(hqhist.specify.value11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value11 = testData1s;
      print(hqhist.specify.value11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value11 = testData2s;
      print(hqhist.specify.value11);
      expect(hqhist.specify.value11 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value11 = defalut;
      print(hqhist.specify.value11);
      expect(hqhist.specify.value11 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.specify.value12;
      print(hqhist.specify.value12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.specify.value12 = testData1s;
      print(hqhist.specify.value12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.specify.value12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.specify.value12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.specify.value12 = testData2s;
      print(hqhist.specify.value12);
      expect(hqhist.specify.value12 == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.specify.value12 = defalut;
      print(hqhist.specify.value12);
      expect(hqhist.specify.value12 == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.specify.value12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.hqhist_cd_down;
      print(hqhist.counter.hqhist_cd_down);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.hqhist_cd_down = testData1;
      print(hqhist.counter.hqhist_cd_down);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.hqhist_cd_down == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.hqhist_cd_down == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.hqhist_cd_down = testData2;
      print(hqhist.counter.hqhist_cd_down);
      expect(hqhist.counter.hqhist_cd_down == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.hqhist_cd_down == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.hqhist_cd_down = defalut;
      print(hqhist.counter.hqhist_cd_down);
      expect(hqhist.counter.hqhist_cd_down == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.hqhist_cd_down == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.hqhist_cd_up;
      print(hqhist.counter.hqhist_cd_up);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.hqhist_cd_up = testData1;
      print(hqhist.counter.hqhist_cd_up);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.hqhist_cd_up == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.hqhist_cd_up == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.hqhist_cd_up = testData2;
      print(hqhist.counter.hqhist_cd_up);
      expect(hqhist.counter.hqhist_cd_up == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.hqhist_cd_up == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.hqhist_cd_up = defalut;
      print(hqhist.counter.hqhist_cd_up);
      expect(hqhist.counter.hqhist_cd_up == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.hqhist_cd_up == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.hqtmp_mst_cd_up;
      print(hqhist.counter.hqtmp_mst_cd_up);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.hqtmp_mst_cd_up = testData1;
      print(hqhist.counter.hqtmp_mst_cd_up);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.hqtmp_mst_cd_up == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.hqtmp_mst_cd_up == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.hqtmp_mst_cd_up = testData2;
      print(hqhist.counter.hqtmp_mst_cd_up);
      expect(hqhist.counter.hqtmp_mst_cd_up == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.hqtmp_mst_cd_up == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.hqtmp_mst_cd_up = defalut;
      print(hqhist.counter.hqtmp_mst_cd_up);
      expect(hqhist.counter.hqtmp_mst_cd_up == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.hqtmp_mst_cd_up == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.last_ttllog_serial_no;
      print(hqhist.counter.last_ttllog_serial_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.last_ttllog_serial_no = testData1;
      print(hqhist.counter.last_ttllog_serial_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.last_ttllog_serial_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.last_ttllog_serial_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.last_ttllog_serial_no = testData2;
      print(hqhist.counter.last_ttllog_serial_no);
      expect(hqhist.counter.last_ttllog_serial_no == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.last_ttllog_serial_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.last_ttllog_serial_no = defalut;
      print(hqhist.counter.last_ttllog_serial_no);
      expect(hqhist.counter.last_ttllog_serial_no == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.last_ttllog_serial_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.nippou_cnt;
      print(hqhist.counter.nippou_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.nippou_cnt = testData1;
      print(hqhist.counter.nippou_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.nippou_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.nippou_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.nippou_cnt = testData2;
      print(hqhist.counter.nippou_cnt);
      expect(hqhist.counter.nippou_cnt == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.nippou_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.nippou_cnt = defalut;
      print(hqhist.counter.nippou_cnt);
      expect(hqhist.counter.nippou_cnt == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.nippou_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.meisai_cnt;
      print(hqhist.counter.meisai_cnt);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.meisai_cnt = testData1;
      print(hqhist.counter.meisai_cnt);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.meisai_cnt == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.meisai_cnt == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.meisai_cnt = testData2;
      print(hqhist.counter.meisai_cnt);
      expect(hqhist.counter.meisai_cnt == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.meisai_cnt == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.meisai_cnt = defalut;
      print(hqhist.counter.meisai_cnt);
      expect(hqhist.counter.meisai_cnt == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.meisai_cnt == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.TranS3_hist_cd;
      print(hqhist.counter.TranS3_hist_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.TranS3_hist_cd = testData1s;
      print(hqhist.counter.TranS3_hist_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.TranS3_hist_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.TranS3_hist_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.TranS3_hist_cd = testData2s;
      print(hqhist.counter.TranS3_hist_cd);
      expect(hqhist.counter.TranS3_hist_cd == testData2s, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.TranS3_hist_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.TranS3_hist_cd = defalut;
      print(hqhist.counter.TranS3_hist_cd);
      expect(hqhist.counter.TranS3_hist_cd == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.TranS3_hist_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      hqhist = HqhistJsonFile();
      allPropatyCheckInit(hqhist);

      // ①loadを実行する。
      await hqhist.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hqhist.counter.last_ttllog_serial_no2nd;
      print(hqhist.counter.last_ttllog_serial_no2nd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hqhist.counter.last_ttllog_serial_no2nd = testData1;
      print(hqhist.counter.last_ttllog_serial_no2nd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hqhist.counter.last_ttllog_serial_no2nd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hqhist.save();
      await hqhist.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hqhist.counter.last_ttllog_serial_no2nd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hqhist.counter.last_ttllog_serial_no2nd = testData2;
      print(hqhist.counter.last_ttllog_serial_no2nd);
      expect(hqhist.counter.last_ttllog_serial_no2nd == testData2, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.last_ttllog_serial_no2nd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hqhist.counter.last_ttllog_serial_no2nd = defalut;
      print(hqhist.counter.last_ttllog_serial_no2nd);
      expect(hqhist.counter.last_ttllog_serial_no2nd == defalut, true);
      await hqhist.save();
      await hqhist.load();
      expect(hqhist.counter.last_ttllog_serial_no2nd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hqhist, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

  });
}

void allPropatyCheckInit(HqhistJsonFile test)
{
  expect(test.cycle.value, 0);
  expect(test.specify.value1, "");
  expect(test.specify.value2, "");
  expect(test.specify.value3, "");
  expect(test.specify.value4, "");
  expect(test.specify.value5, "");
  expect(test.specify.value6, "");
  expect(test.specify.value7, "");
  expect(test.specify.value8, "");
  expect(test.specify.value9, "");
  expect(test.specify.value10, "");
  expect(test.specify.value11, "");
  expect(test.specify.value12, "");
  expect(test.counter.hqhist_cd_down, 0);
  expect(test.counter.hqhist_cd_up, 0);
  expect(test.counter.hqtmp_mst_cd_up, 0);
  expect(test.counter.last_ttllog_serial_no, 0);
  expect(test.counter.nippou_cnt, 0);
  expect(test.counter.meisai_cnt, 0);
  expect(test.counter.TranS3_hist_cd, "");
  expect(test.counter.last_ttllog_serial_no2nd, 0);
}

void allPropatyCheck(HqhistJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.cycle.value, 9999);
  }
  expect(test.specify.value1, "");
  expect(test.specify.value2, "");
  expect(test.specify.value3, "");
  expect(test.specify.value4, "");
  expect(test.specify.value5, "");
  expect(test.specify.value6, "");
  expect(test.specify.value7, "");
  expect(test.specify.value8, "");
  expect(test.specify.value9, "");
  expect(test.specify.value10, "");
  expect(test.specify.value11, "");
  expect(test.specify.value12, "");
  expect(test.counter.hqhist_cd_down, 0);
  expect(test.counter.hqhist_cd_up, 0);
  expect(test.counter.hqtmp_mst_cd_up, 0);
  expect(test.counter.last_ttllog_serial_no, 0);
  expect(test.counter.nippou_cnt, 0);
  expect(test.counter.meisai_cnt, 0);
  expect(test.counter.TranS3_hist_cd, "0,0");
  expect(test.counter.last_ttllog_serial_no2nd, 0);
}

