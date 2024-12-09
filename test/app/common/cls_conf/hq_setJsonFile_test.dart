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
import '../../../../lib/app/common/cls_conf/hq_setJsonFile.dart';

late Hq_setJsonFile hq_set;

void main(){
  hq_setJsonFile_test();
}

void hq_setJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "hq_set.json";
  const String section = "netDoA_counter";
  const String key = "hqhist_cd_up";
  const defaultData = 0;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Hq_setJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Hq_setJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Hq_setJsonFile().setDefault();
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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await hq_set.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(hq_set,true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        hq_set.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await hq_set.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(hq_set,true);

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
      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①：loadを実行する。
      await hq_set.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hq_set.netDoA_counter.hqhist_cd_up;
      hq_set.netDoA_counter.hqhist_cd_up = testData1;
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_cd_up != testData1, true);
      expect(hq_set.netDoA_counter.hqhist_cd_up == prefixData, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = hq_set.netDoA_counter.hqhist_cd_up;
      hq_set.netDoA_counter.hqhist_cd_up = testData1;
      expect(hq_set.netDoA_counter.hqhist_cd_up, testData1);

      // ③saveを実行する。
      await hq_set.save();

      // ④loadを実行する。
      await hq_set.load();

      expect(hq_set.netDoA_counter.hqhist_cd_up != prefixData, true);
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);
      allPropatyCheck(hq_set,false);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hq_set.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await hq_set.save();

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await hq_set.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(hq_set.netDoA_counter.hqhist_cd_up, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = hq_set.netDoA_counter.hqhist_cd_up;
      hq_set.netDoA_counter.hqhist_cd_up = testData1;

      // ③ saveを実行する。
      await hq_set.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(hq_set.netDoA_counter.hqhist_cd_up, testData1);

      // ④ loadを実行する。
      await hq_set.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);
      allPropatyCheck(hq_set,false);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await hq_set.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(hq_set,true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②任意のプロパティの値を変更する。
      hq_set.netDoA_counter.hqhist_cd_up = testData1;
      expect(hq_set.netDoA_counter.hqhist_cd_up, testData1);

      // ③saveを実行する。
      await hq_set.save();
      expect(hq_set.netDoA_counter.hqhist_cd_up, testData1);

      // ④loadを実行する。
      await hq_set.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(hq_set,true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await hq_set.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await hq_set.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hq_set.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await hq_set.setValueWithName(section, "test_key", testData1);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②任意のプロパティを変更する。
      hq_set.netDoA_counter.hqhist_cd_up = testData1;

      // ③saveを実行する。
      await hq_set.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hq_set.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②任意のプロパティを変更する。
      hq_set.netDoA_counter.hqhist_cd_up = testData1;

      // ③saveを実行する。
      await hq_set.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hq_set.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②任意のプロパティを変更する。
      hq_set.netDoA_counter.hqhist_cd_up = testData1;

      // ③saveを実行する。
      await hq_set.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await hq_set.getValueWithName(section, "test_key");
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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await hq_set.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      hq_set.netDoA_counter.hqhist_cd_up = testData1;
      expect(hq_set.netDoA_counter.hqhist_cd_up, testData1);

      // ④saveを実行する。
      await hq_set.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(hq_set.netDoA_counter.hqhist_cd_up, testData1);
      
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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await hq_set.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await hq_set.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData2, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await hq_set.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await hq_set.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData2, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await hq_set.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await hq_set.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await hq_set.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      allPropatyCheck(hq_set,true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await hq_set.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + hq_set.netDoA_counter.hqhist_cd_up.toString());
      allPropatyCheck(hq_set,true);

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

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netDoA_counter.hqhist_cd_up;
      print(hq_set.netDoA_counter.hqhist_cd_up);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netDoA_counter.hqhist_cd_up = testData1;
      print(hq_set.netDoA_counter.hqhist_cd_up);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netDoA_counter.hqhist_cd_up = testData2;
      print(hq_set.netDoA_counter.hqhist_cd_up);
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_cd_up == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netDoA_counter.hqhist_cd_up = defalut;
      print(hq_set.netDoA_counter.hqhist_cd_up);
      expect(hq_set.netDoA_counter.hqhist_cd_up == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_cd_up == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netDoA_counter.hqhist_cd_down;
      print(hq_set.netDoA_counter.hqhist_cd_down);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netDoA_counter.hqhist_cd_down = testData1;
      print(hq_set.netDoA_counter.hqhist_cd_down);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netDoA_counter.hqhist_cd_down == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netDoA_counter.hqhist_cd_down == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netDoA_counter.hqhist_cd_down = testData2;
      print(hq_set.netDoA_counter.hqhist_cd_down);
      expect(hq_set.netDoA_counter.hqhist_cd_down == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_cd_down == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netDoA_counter.hqhist_cd_down = defalut;
      print(hq_set.netDoA_counter.hqhist_cd_down);
      expect(hq_set.netDoA_counter.hqhist_cd_down == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_cd_down == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netDoA_counter.hqtmp_mst_cd_up;
      print(hq_set.netDoA_counter.hqtmp_mst_cd_up);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netDoA_counter.hqtmp_mst_cd_up = testData1;
      print(hq_set.netDoA_counter.hqtmp_mst_cd_up);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netDoA_counter.hqtmp_mst_cd_up == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netDoA_counter.hqtmp_mst_cd_up == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netDoA_counter.hqtmp_mst_cd_up = testData2;
      print(hq_set.netDoA_counter.hqtmp_mst_cd_up);
      expect(hq_set.netDoA_counter.hqtmp_mst_cd_up == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqtmp_mst_cd_up == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netDoA_counter.hqtmp_mst_cd_up = defalut;
      print(hq_set.netDoA_counter.hqtmp_mst_cd_up);
      expect(hq_set.netDoA_counter.hqtmp_mst_cd_up == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqtmp_mst_cd_up == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netDoA_counter.lgyoumu_serial_no;
      print(hq_set.netDoA_counter.lgyoumu_serial_no);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netDoA_counter.lgyoumu_serial_no = testData1;
      print(hq_set.netDoA_counter.lgyoumu_serial_no);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netDoA_counter.lgyoumu_serial_no == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netDoA_counter.lgyoumu_serial_no == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netDoA_counter.lgyoumu_serial_no = testData2;
      print(hq_set.netDoA_counter.lgyoumu_serial_no);
      expect(hq_set.netDoA_counter.lgyoumu_serial_no == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.lgyoumu_serial_no == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netDoA_counter.lgyoumu_serial_no = defalut;
      print(hq_set.netDoA_counter.lgyoumu_serial_no);
      expect(hq_set.netDoA_counter.lgyoumu_serial_no == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.lgyoumu_serial_no == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netDoA_counter.hqhist_date_up;
      print(hq_set.netDoA_counter.hqhist_date_up);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netDoA_counter.hqhist_date_up = testData1s;
      print(hq_set.netDoA_counter.hqhist_date_up);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netDoA_counter.hqhist_date_up == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netDoA_counter.hqhist_date_up == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netDoA_counter.hqhist_date_up = testData2s;
      print(hq_set.netDoA_counter.hqhist_date_up);
      expect(hq_set.netDoA_counter.hqhist_date_up == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_date_up == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netDoA_counter.hqhist_date_up = defalut;
      print(hq_set.netDoA_counter.hqhist_date_up);
      expect(hq_set.netDoA_counter.hqhist_date_up == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_date_up == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netDoA_counter.hqhist_date_down;
      print(hq_set.netDoA_counter.hqhist_date_down);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netDoA_counter.hqhist_date_down = testData1s;
      print(hq_set.netDoA_counter.hqhist_date_down);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netDoA_counter.hqhist_date_down == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netDoA_counter.hqhist_date_down == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netDoA_counter.hqhist_date_down = testData2s;
      print(hq_set.netDoA_counter.hqhist_date_down);
      expect(hq_set.netDoA_counter.hqhist_date_down == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_date_down == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netDoA_counter.hqhist_date_down = defalut;
      print(hq_set.netDoA_counter.hqhist_date_down);
      expect(hq_set.netDoA_counter.hqhist_date_down == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netDoA_counter.hqhist_date_down == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_counter.TranS3_hist_cd;
      print(hq_set.css_counter.TranS3_hist_cd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_counter.TranS3_hist_cd = testData1s;
      print(hq_set.css_counter.TranS3_hist_cd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_counter.TranS3_hist_cd == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_counter.TranS3_hist_cd == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_counter.TranS3_hist_cd = testData2s;
      print(hq_set.css_counter.TranS3_hist_cd);
      expect(hq_set.css_counter.TranS3_hist_cd == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_counter.TranS3_hist_cd == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_counter.TranS3_hist_cd = defalut;
      print(hq_set.css_counter.TranS3_hist_cd);
      expect(hq_set.css_counter.TranS3_hist_cd == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_counter.TranS3_hist_cd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.cnct_usb;
      print(hq_set.hq_cmn_option.cnct_usb);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.cnct_usb = testData1;
      print(hq_set.hq_cmn_option.cnct_usb);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.cnct_usb == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.cnct_usb == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.cnct_usb = testData2;
      print(hq_set.hq_cmn_option.cnct_usb);
      expect(hq_set.hq_cmn_option.cnct_usb == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.cnct_usb == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.cnct_usb = defalut;
      print(hq_set.hq_cmn_option.cnct_usb);
      expect(hq_set.hq_cmn_option.cnct_usb == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.cnct_usb == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.open_resend;
      print(hq_set.hq_cmn_option.open_resend);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.open_resend = testData1;
      print(hq_set.hq_cmn_option.open_resend);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.open_resend == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.open_resend == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.open_resend = testData2;
      print(hq_set.hq_cmn_option.open_resend);
      expect(hq_set.hq_cmn_option.open_resend == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.open_resend == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.open_resend = defalut;
      print(hq_set.hq_cmn_option.open_resend);
      expect(hq_set.hq_cmn_option.open_resend == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.open_resend == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.ts_lgyoumu;
      print(hq_set.hq_cmn_option.ts_lgyoumu);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.ts_lgyoumu = testData1;
      print(hq_set.hq_cmn_option.ts_lgyoumu);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.ts_lgyoumu == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.ts_lgyoumu == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.ts_lgyoumu = testData2;
      print(hq_set.hq_cmn_option.ts_lgyoumu);
      expect(hq_set.hq_cmn_option.ts_lgyoumu == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.ts_lgyoumu == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.ts_lgyoumu = defalut;
      print(hq_set.hq_cmn_option.ts_lgyoumu);
      expect(hq_set.hq_cmn_option.ts_lgyoumu == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.ts_lgyoumu == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_suffix_digit;
      print(hq_set.hq_cmn_option.gyoumu_suffix_digit);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_suffix_digit = testData1;
      print(hq_set.hq_cmn_option.gyoumu_suffix_digit);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_suffix_digit == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_suffix_digit == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_suffix_digit = testData2;
      print(hq_set.hq_cmn_option.gyoumu_suffix_digit);
      expect(hq_set.hq_cmn_option.gyoumu_suffix_digit == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_suffix_digit == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_suffix_digit = defalut;
      print(hq_set.hq_cmn_option.gyoumu_suffix_digit);
      expect(hq_set.hq_cmn_option.gyoumu_suffix_digit == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_suffix_digit == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_charcode;
      print(hq_set.hq_cmn_option.gyoumu_charcode);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_charcode = testData1;
      print(hq_set.hq_cmn_option.gyoumu_charcode);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_charcode == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_charcode == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_charcode = testData2;
      print(hq_set.hq_cmn_option.gyoumu_charcode);
      expect(hq_set.hq_cmn_option.gyoumu_charcode == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_charcode == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_charcode = defalut;
      print(hq_set.hq_cmn_option.gyoumu_charcode);
      expect(hq_set.hq_cmn_option.gyoumu_charcode == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_charcode == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_newline;
      print(hq_set.hq_cmn_option.gyoumu_newline);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_newline = testData1;
      print(hq_set.hq_cmn_option.gyoumu_newline);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_newline == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_newline == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_newline = testData2;
      print(hq_set.hq_cmn_option.gyoumu_newline);
      expect(hq_set.hq_cmn_option.gyoumu_newline == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_newline == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_newline = defalut;
      print(hq_set.hq_cmn_option.gyoumu_newline);
      expect(hq_set.hq_cmn_option.gyoumu_newline == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_newline == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_date_set;
      print(hq_set.hq_cmn_option.gyoumu_date_set);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_date_set = testData1;
      print(hq_set.hq_cmn_option.gyoumu_date_set);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_date_set == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_date_set == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_date_set = testData2;
      print(hq_set.hq_cmn_option.gyoumu_date_set);
      expect(hq_set.hq_cmn_option.gyoumu_date_set == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_date_set == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_date_set = defalut;
      print(hq_set.hq_cmn_option.gyoumu_date_set);
      expect(hq_set.hq_cmn_option.gyoumu_date_set == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_date_set == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_day_name;
      print(hq_set.hq_cmn_option.gyoumu_day_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_day_name = testData1;
      print(hq_set.hq_cmn_option.gyoumu_day_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_day_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_day_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_day_name = testData2;
      print(hq_set.hq_cmn_option.gyoumu_day_name);
      expect(hq_set.hq_cmn_option.gyoumu_day_name == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_day_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_day_name = defalut;
      print(hq_set.hq_cmn_option.gyoumu_day_name);
      expect(hq_set.hq_cmn_option.gyoumu_day_name == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_day_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_ment_tran;
      print(hq_set.hq_cmn_option.gyoumu_ment_tran);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_ment_tran = testData1;
      print(hq_set.hq_cmn_option.gyoumu_ment_tran);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_ment_tran == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_ment_tran == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_ment_tran = testData2;
      print(hq_set.hq_cmn_option.gyoumu_ment_tran);
      expect(hq_set.hq_cmn_option.gyoumu_ment_tran == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_ment_tran == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_ment_tran = defalut;
      print(hq_set.hq_cmn_option.gyoumu_ment_tran);
      expect(hq_set.hq_cmn_option.gyoumu_ment_tran == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_ment_tran == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.gyoumu_cnv_tax_typ;
      print(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.gyoumu_cnv_tax_typ = testData1;
      print(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.gyoumu_cnv_tax_typ = testData2;
      print(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ);
      expect(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.gyoumu_cnv_tax_typ = defalut;
      print(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ);
      expect(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.gyoumu_cnv_tax_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.zero_gyoumu_nosend;
      print(hq_set.hq_cmn_option.zero_gyoumu_nosend);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.zero_gyoumu_nosend = testData1;
      print(hq_set.hq_cmn_option.zero_gyoumu_nosend);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.zero_gyoumu_nosend == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.zero_gyoumu_nosend == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.zero_gyoumu_nosend = testData2;
      print(hq_set.hq_cmn_option.zero_gyoumu_nosend);
      expect(hq_set.hq_cmn_option.zero_gyoumu_nosend == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.zero_gyoumu_nosend == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.zero_gyoumu_nosend = defalut;
      print(hq_set.hq_cmn_option.zero_gyoumu_nosend);
      expect(hq_set.hq_cmn_option.zero_gyoumu_nosend == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.zero_gyoumu_nosend == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.cnct_2nd;
      print(hq_set.hq_cmn_option.cnct_2nd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.cnct_2nd = testData1;
      print(hq_set.hq_cmn_option.cnct_2nd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.cnct_2nd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.cnct_2nd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.cnct_2nd = testData2;
      print(hq_set.hq_cmn_option.cnct_2nd);
      expect(hq_set.hq_cmn_option.cnct_2nd == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.cnct_2nd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.cnct_2nd = defalut;
      print(hq_set.hq_cmn_option.cnct_2nd);
      expect(hq_set.hq_cmn_option.cnct_2nd == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.cnct_2nd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.timing_2nd;
      print(hq_set.hq_cmn_option.timing_2nd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.timing_2nd = testData1;
      print(hq_set.hq_cmn_option.timing_2nd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.timing_2nd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.timing_2nd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.timing_2nd = testData2;
      print(hq_set.hq_cmn_option.timing_2nd);
      expect(hq_set.hq_cmn_option.timing_2nd == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.timing_2nd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.timing_2nd = defalut;
      print(hq_set.hq_cmn_option.timing_2nd);
      expect(hq_set.hq_cmn_option.timing_2nd == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.timing_2nd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.sndrcv_1st;
      print(hq_set.hq_cmn_option.sndrcv_1st);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.sndrcv_1st = testData1;
      print(hq_set.hq_cmn_option.sndrcv_1st);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.sndrcv_1st == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.sndrcv_1st == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.sndrcv_1st = testData2;
      print(hq_set.hq_cmn_option.sndrcv_1st);
      expect(hq_set.hq_cmn_option.sndrcv_1st == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.sndrcv_1st == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.sndrcv_1st = defalut;
      print(hq_set.hq_cmn_option.sndrcv_1st);
      expect(hq_set.hq_cmn_option.sndrcv_1st == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.sndrcv_1st == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.sndrcv_2nd;
      print(hq_set.hq_cmn_option.sndrcv_2nd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.sndrcv_2nd = testData1;
      print(hq_set.hq_cmn_option.sndrcv_2nd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.sndrcv_2nd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.sndrcv_2nd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.sndrcv_2nd = testData2;
      print(hq_set.hq_cmn_option.sndrcv_2nd);
      expect(hq_set.hq_cmn_option.sndrcv_2nd == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.sndrcv_2nd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.sndrcv_2nd = defalut;
      print(hq_set.hq_cmn_option.sndrcv_2nd);
      expect(hq_set.hq_cmn_option.sndrcv_2nd == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.sndrcv_2nd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_cmn_option.namechg_2nd;
      print(hq_set.hq_cmn_option.namechg_2nd);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_cmn_option.namechg_2nd = testData1;
      print(hq_set.hq_cmn_option.namechg_2nd);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_cmn_option.namechg_2nd == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_cmn_option.namechg_2nd == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_cmn_option.namechg_2nd = testData2;
      print(hq_set.hq_cmn_option.namechg_2nd);
      expect(hq_set.hq_cmn_option.namechg_2nd == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.namechg_2nd == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_cmn_option.namechg_2nd = defalut;
      print(hq_set.hq_cmn_option.namechg_2nd);
      expect(hq_set.hq_cmn_option.namechg_2nd == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_cmn_option.namechg_2nd == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_cycle.value;
      print(hq_set.hq_down_cycle.value);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_cycle.value = testData1;
      print(hq_set.hq_down_cycle.value);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_cycle.value == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_cycle.value == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_cycle.value = testData2;
      print(hq_set.hq_down_cycle.value);
      expect(hq_set.hq_down_cycle.value == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_cycle.value == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_cycle.value = defalut;
      print(hq_set.hq_down_cycle.value);
      expect(hq_set.hq_down_cycle.value == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_cycle.value == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value1;
      print(hq_set.hq_down_specify.value1);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value1 = testData1s;
      print(hq_set.hq_down_specify.value1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value1 = testData2s;
      print(hq_set.hq_down_specify.value1);
      expect(hq_set.hq_down_specify.value1 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value1 = defalut;
      print(hq_set.hq_down_specify.value1);
      expect(hq_set.hq_down_specify.value1 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value2;
      print(hq_set.hq_down_specify.value2);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value2 = testData1s;
      print(hq_set.hq_down_specify.value2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value2 = testData2s;
      print(hq_set.hq_down_specify.value2);
      expect(hq_set.hq_down_specify.value2 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value2 = defalut;
      print(hq_set.hq_down_specify.value2);
      expect(hq_set.hq_down_specify.value2 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value3;
      print(hq_set.hq_down_specify.value3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value3 = testData1s;
      print(hq_set.hq_down_specify.value3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value3 = testData2s;
      print(hq_set.hq_down_specify.value3);
      expect(hq_set.hq_down_specify.value3 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value3 = defalut;
      print(hq_set.hq_down_specify.value3);
      expect(hq_set.hq_down_specify.value3 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value4;
      print(hq_set.hq_down_specify.value4);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value4 = testData1s;
      print(hq_set.hq_down_specify.value4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value4 = testData2s;
      print(hq_set.hq_down_specify.value4);
      expect(hq_set.hq_down_specify.value4 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value4 = defalut;
      print(hq_set.hq_down_specify.value4);
      expect(hq_set.hq_down_specify.value4 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value5;
      print(hq_set.hq_down_specify.value5);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value5 = testData1s;
      print(hq_set.hq_down_specify.value5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value5 = testData2s;
      print(hq_set.hq_down_specify.value5);
      expect(hq_set.hq_down_specify.value5 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value5 = defalut;
      print(hq_set.hq_down_specify.value5);
      expect(hq_set.hq_down_specify.value5 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value6;
      print(hq_set.hq_down_specify.value6);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value6 = testData1s;
      print(hq_set.hq_down_specify.value6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value6 = testData2s;
      print(hq_set.hq_down_specify.value6);
      expect(hq_set.hq_down_specify.value6 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value6 = defalut;
      print(hq_set.hq_down_specify.value6);
      expect(hq_set.hq_down_specify.value6 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value7;
      print(hq_set.hq_down_specify.value7);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value7 = testData1s;
      print(hq_set.hq_down_specify.value7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value7 = testData2s;
      print(hq_set.hq_down_specify.value7);
      expect(hq_set.hq_down_specify.value7 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value7 = defalut;
      print(hq_set.hq_down_specify.value7);
      expect(hq_set.hq_down_specify.value7 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value8;
      print(hq_set.hq_down_specify.value8);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value8 = testData1s;
      print(hq_set.hq_down_specify.value8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value8 = testData2s;
      print(hq_set.hq_down_specify.value8);
      expect(hq_set.hq_down_specify.value8 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value8 = defalut;
      print(hq_set.hq_down_specify.value8);
      expect(hq_set.hq_down_specify.value8 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value9;
      print(hq_set.hq_down_specify.value9);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value9 = testData1s;
      print(hq_set.hq_down_specify.value9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value9 = testData2s;
      print(hq_set.hq_down_specify.value9);
      expect(hq_set.hq_down_specify.value9 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value9 = defalut;
      print(hq_set.hq_down_specify.value9);
      expect(hq_set.hq_down_specify.value9 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value10;
      print(hq_set.hq_down_specify.value10);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value10 = testData1s;
      print(hq_set.hq_down_specify.value10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value10 = testData2s;
      print(hq_set.hq_down_specify.value10);
      expect(hq_set.hq_down_specify.value10 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value10 = defalut;
      print(hq_set.hq_down_specify.value10);
      expect(hq_set.hq_down_specify.value10 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value11;
      print(hq_set.hq_down_specify.value11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value11 = testData1s;
      print(hq_set.hq_down_specify.value11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value11 = testData2s;
      print(hq_set.hq_down_specify.value11);
      expect(hq_set.hq_down_specify.value11 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value11 = defalut;
      print(hq_set.hq_down_specify.value11);
      expect(hq_set.hq_down_specify.value11 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_down_specify.value12;
      print(hq_set.hq_down_specify.value12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_down_specify.value12 = testData1s;
      print(hq_set.hq_down_specify.value12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_down_specify.value12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_down_specify.value12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_down_specify.value12 = testData2s;
      print(hq_set.hq_down_specify.value12);
      expect(hq_set.hq_down_specify.value12 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_down_specify.value12 = defalut;
      print(hq_set.hq_down_specify.value12);
      expect(hq_set.hq_down_specify.value12 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_down_specify.value12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_cycle.value;
      print(hq_set.hq_up_cycle.value);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_cycle.value = testData1;
      print(hq_set.hq_up_cycle.value);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_cycle.value == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_cycle.value == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_cycle.value = testData2;
      print(hq_set.hq_up_cycle.value);
      expect(hq_set.hq_up_cycle.value == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_cycle.value == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_cycle.value = defalut;
      print(hq_set.hq_up_cycle.value);
      expect(hq_set.hq_up_cycle.value == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_cycle.value == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value1;
      print(hq_set.hq_up_specify.value1);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value1 = testData1s;
      print(hq_set.hq_up_specify.value1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value1 = testData2s;
      print(hq_set.hq_up_specify.value1);
      expect(hq_set.hq_up_specify.value1 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value1 = defalut;
      print(hq_set.hq_up_specify.value1);
      expect(hq_set.hq_up_specify.value1 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value2;
      print(hq_set.hq_up_specify.value2);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value2 = testData1s;
      print(hq_set.hq_up_specify.value2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value2 = testData2s;
      print(hq_set.hq_up_specify.value2);
      expect(hq_set.hq_up_specify.value2 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value2 = defalut;
      print(hq_set.hq_up_specify.value2);
      expect(hq_set.hq_up_specify.value2 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value3;
      print(hq_set.hq_up_specify.value3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value3 = testData1s;
      print(hq_set.hq_up_specify.value3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value3 = testData2s;
      print(hq_set.hq_up_specify.value3);
      expect(hq_set.hq_up_specify.value3 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value3 = defalut;
      print(hq_set.hq_up_specify.value3);
      expect(hq_set.hq_up_specify.value3 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value4;
      print(hq_set.hq_up_specify.value4);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value4 = testData1s;
      print(hq_set.hq_up_specify.value4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value4 = testData2s;
      print(hq_set.hq_up_specify.value4);
      expect(hq_set.hq_up_specify.value4 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value4 = defalut;
      print(hq_set.hq_up_specify.value4);
      expect(hq_set.hq_up_specify.value4 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value5;
      print(hq_set.hq_up_specify.value5);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value5 = testData1s;
      print(hq_set.hq_up_specify.value5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value5 = testData2s;
      print(hq_set.hq_up_specify.value5);
      expect(hq_set.hq_up_specify.value5 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value5 = defalut;
      print(hq_set.hq_up_specify.value5);
      expect(hq_set.hq_up_specify.value5 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value6;
      print(hq_set.hq_up_specify.value6);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value6 = testData1s;
      print(hq_set.hq_up_specify.value6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value6 = testData2s;
      print(hq_set.hq_up_specify.value6);
      expect(hq_set.hq_up_specify.value6 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value6 = defalut;
      print(hq_set.hq_up_specify.value6);
      expect(hq_set.hq_up_specify.value6 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value7;
      print(hq_set.hq_up_specify.value7);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value7 = testData1s;
      print(hq_set.hq_up_specify.value7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value7 = testData2s;
      print(hq_set.hq_up_specify.value7);
      expect(hq_set.hq_up_specify.value7 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value7 = defalut;
      print(hq_set.hq_up_specify.value7);
      expect(hq_set.hq_up_specify.value7 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value8;
      print(hq_set.hq_up_specify.value8);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value8 = testData1s;
      print(hq_set.hq_up_specify.value8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value8 = testData2s;
      print(hq_set.hq_up_specify.value8);
      expect(hq_set.hq_up_specify.value8 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value8 = defalut;
      print(hq_set.hq_up_specify.value8);
      expect(hq_set.hq_up_specify.value8 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value9;
      print(hq_set.hq_up_specify.value9);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value9 = testData1s;
      print(hq_set.hq_up_specify.value9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value9 = testData2s;
      print(hq_set.hq_up_specify.value9);
      expect(hq_set.hq_up_specify.value9 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value9 = defalut;
      print(hq_set.hq_up_specify.value9);
      expect(hq_set.hq_up_specify.value9 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value10;
      print(hq_set.hq_up_specify.value10);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value10 = testData1s;
      print(hq_set.hq_up_specify.value10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value10 = testData2s;
      print(hq_set.hq_up_specify.value10);
      expect(hq_set.hq_up_specify.value10 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value10 = defalut;
      print(hq_set.hq_up_specify.value10);
      expect(hq_set.hq_up_specify.value10 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value11;
      print(hq_set.hq_up_specify.value11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value11 = testData1s;
      print(hq_set.hq_up_specify.value11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value11 = testData2s;
      print(hq_set.hq_up_specify.value11);
      expect(hq_set.hq_up_specify.value11 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value11 = defalut;
      print(hq_set.hq_up_specify.value11);
      expect(hq_set.hq_up_specify.value11 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_up_specify.value12;
      print(hq_set.hq_up_specify.value12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_up_specify.value12 = testData1s;
      print(hq_set.hq_up_specify.value12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_up_specify.value12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_up_specify.value12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_up_specify.value12 = testData2s;
      print(hq_set.hq_up_specify.value12);
      expect(hq_set.hq_up_specify.value12 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_up_specify.value12 = defalut;
      print(hq_set.hq_up_specify.value12);
      expect(hq_set.hq_up_specify.value12 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_up_specify.value12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran11;
      print(hq_set.tran_info.css_tran11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran11 = testData1s;
      print(hq_set.tran_info.css_tran11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran11 = testData2s;
      print(hq_set.tran_info.css_tran11);
      expect(hq_set.tran_info.css_tran11 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran11 = defalut;
      print(hq_set.tran_info.css_tran11);
      expect(hq_set.tran_info.css_tran11 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran12;
      print(hq_set.tran_info.css_tran12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran12 = testData1s;
      print(hq_set.tran_info.css_tran12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran12 = testData2s;
      print(hq_set.tran_info.css_tran12);
      expect(hq_set.tran_info.css_tran12 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran12 = defalut;
      print(hq_set.tran_info.css_tran12);
      expect(hq_set.tran_info.css_tran12 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran13;
      print(hq_set.tran_info.css_tran13);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran13 = testData1s;
      print(hq_set.tran_info.css_tran13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran13 = testData2s;
      print(hq_set.tran_info.css_tran13);
      expect(hq_set.tran_info.css_tran13 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran13 = defalut;
      print(hq_set.tran_info.css_tran13);
      expect(hq_set.tran_info.css_tran13 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran15;
      print(hq_set.tran_info.css_tran15);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran15 = testData1s;
      print(hq_set.tran_info.css_tran15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran15 = testData2s;
      print(hq_set.tran_info.css_tran15);
      expect(hq_set.tran_info.css_tran15 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran15 = defalut;
      print(hq_set.tran_info.css_tran15);
      expect(hq_set.tran_info.css_tran15 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran21;
      print(hq_set.tran_info.css_tran21);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran21 = testData1s;
      print(hq_set.tran_info.css_tran21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran21 = testData2s;
      print(hq_set.tran_info.css_tran21);
      expect(hq_set.tran_info.css_tran21 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran21 = defalut;
      print(hq_set.tran_info.css_tran21);
      expect(hq_set.tran_info.css_tran21 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran22;
      print(hq_set.tran_info.css_tran22);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran22 = testData1s;
      print(hq_set.tran_info.css_tran22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran22 = testData2s;
      print(hq_set.tran_info.css_tran22);
      expect(hq_set.tran_info.css_tran22 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran22 = defalut;
      print(hq_set.tran_info.css_tran22);
      expect(hq_set.tran_info.css_tran22 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran24;
      print(hq_set.tran_info.css_tran24);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran24 = testData1s;
      print(hq_set.tran_info.css_tran24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran24 = testData2s;
      print(hq_set.tran_info.css_tran24);
      expect(hq_set.tran_info.css_tran24 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran24 = defalut;
      print(hq_set.tran_info.css_tran24);
      expect(hq_set.tran_info.css_tran24 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran25;
      print(hq_set.tran_info.css_tran25);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran25 = testData1s;
      print(hq_set.tran_info.css_tran25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran25 = testData2s;
      print(hq_set.tran_info.css_tran25);
      expect(hq_set.tran_info.css_tran25 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran25 = defalut;
      print(hq_set.tran_info.css_tran25);
      expect(hq_set.tran_info.css_tran25 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran26;
      print(hq_set.tran_info.css_tran26);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran26 = testData1s;
      print(hq_set.tran_info.css_tran26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran26 = testData2s;
      print(hq_set.tran_info.css_tran26);
      expect(hq_set.tran_info.css_tran26 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran26 = defalut;
      print(hq_set.tran_info.css_tran26);
      expect(hq_set.tran_info.css_tran26 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran27;
      print(hq_set.tran_info.css_tran27);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran27 = testData1s;
      print(hq_set.tran_info.css_tran27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran27 = testData2s;
      print(hq_set.tran_info.css_tran27);
      expect(hq_set.tran_info.css_tran27 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran27 = defalut;
      print(hq_set.tran_info.css_tran27);
      expect(hq_set.tran_info.css_tran27 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran28;
      print(hq_set.tran_info.css_tran28);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran28 = testData1s;
      print(hq_set.tran_info.css_tran28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran28 = testData2s;
      print(hq_set.tran_info.css_tran28);
      expect(hq_set.tran_info.css_tran28 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran28 = defalut;
      print(hq_set.tran_info.css_tran28);
      expect(hq_set.tran_info.css_tran28 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran29;
      print(hq_set.tran_info.css_tran29);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran29 = testData1s;
      print(hq_set.tran_info.css_tran29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran29 = testData2s;
      print(hq_set.tran_info.css_tran29);
      expect(hq_set.tran_info.css_tran29 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran29 = defalut;
      print(hq_set.tran_info.css_tran29);
      expect(hq_set.tran_info.css_tran29 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran2E;
      print(hq_set.tran_info.css_tran2E);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran2E = testData1s;
      print(hq_set.tran_info.css_tran2E);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran2E == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran2E == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran2E = testData2s;
      print(hq_set.tran_info.css_tran2E);
      expect(hq_set.tran_info.css_tran2E == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran2E == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran2E = defalut;
      print(hq_set.tran_info.css_tran2E);
      expect(hq_set.tran_info.css_tran2E == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran2E == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran2F;
      print(hq_set.tran_info.css_tran2F);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran2F = testData1s;
      print(hq_set.tran_info.css_tran2F);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran2F == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran2F == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran2F = testData2s;
      print(hq_set.tran_info.css_tran2F);
      expect(hq_set.tran_info.css_tran2F == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran2F == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran2F = defalut;
      print(hq_set.tran_info.css_tran2F);
      expect(hq_set.tran_info.css_tran2F == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran2F == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran55;
      print(hq_set.tran_info.css_tran55);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran55 = testData1s;
      print(hq_set.tran_info.css_tran55);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran55 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran55 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran55 = testData2s;
      print(hq_set.tran_info.css_tran55);
      expect(hq_set.tran_info.css_tran55 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran55 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran55 = defalut;
      print(hq_set.tran_info.css_tran55);
      expect(hq_set.tran_info.css_tran55 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran55 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranT2;
      print(hq_set.tran_info.css_tranT2);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranT2 = testData1s;
      print(hq_set.tran_info.css_tranT2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranT2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranT2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranT2 = testData2s;
      print(hq_set.tran_info.css_tranT2);
      expect(hq_set.tran_info.css_tranT2 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranT2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranT2 = defalut;
      print(hq_set.tran_info.css_tranT2);
      expect(hq_set.tran_info.css_tranT2 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranT2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranW3;
      print(hq_set.tran_info.css_tranW3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranW3 = testData1s;
      print(hq_set.tran_info.css_tranW3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranW3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranW3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranW3 = testData2s;
      print(hq_set.tran_info.css_tranW3);
      expect(hq_set.tran_info.css_tranW3 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranW3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranW3 = defalut;
      print(hq_set.tran_info.css_tranW3);
      expect(hq_set.tran_info.css_tranW3 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranW3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranW4;
      print(hq_set.tran_info.css_tranW4);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranW4 = testData1s;
      print(hq_set.tran_info.css_tranW4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranW4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranW4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranW4 = testData2s;
      print(hq_set.tran_info.css_tranW4);
      expect(hq_set.tran_info.css_tranW4 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranW4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranW4 = defalut;
      print(hq_set.tran_info.css_tranW4);
      expect(hq_set.tran_info.css_tranW4 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranW4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranS3;
      print(hq_set.tran_info.css_tranS3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranS3 = testData1s;
      print(hq_set.tran_info.css_tranS3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranS3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranS3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranS3 = testData2s;
      print(hq_set.tran_info.css_tranS3);
      expect(hq_set.tran_info.css_tranS3 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranS3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranS3 = defalut;
      print(hq_set.tran_info.css_tranS3);
      expect(hq_set.tran_info.css_tranS3 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranS3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran8A;
      print(hq_set.tran_info.css_tran8A);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran8A = testData1s;
      print(hq_set.tran_info.css_tran8A);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran8A == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran8A == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran8A = testData2s;
      print(hq_set.tran_info.css_tran8A);
      expect(hq_set.tran_info.css_tran8A == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran8A == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran8A = defalut;
      print(hq_set.tran_info.css_tran8A);
      expect(hq_set.tran_info.css_tran8A == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran8A == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran51_33;
      print(hq_set.tran_info.css_tran51_33);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran51_33 = testData1s;
      print(hq_set.tran_info.css_tran51_33);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran51_33 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran51_33 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran51_33 = testData2s;
      print(hq_set.tran_info.css_tran51_33);
      expect(hq_set.tran_info.css_tran51_33 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran51_33 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran51_33 = defalut;
      print(hq_set.tran_info.css_tran51_33);
      expect(hq_set.tran_info.css_tran51_33 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran51_33 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran52_34;
      print(hq_set.tran_info.css_tran52_34);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran52_34 = testData1s;
      print(hq_set.tran_info.css_tran52_34);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran52_34 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran52_34 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran52_34 = testData2s;
      print(hq_set.tran_info.css_tran52_34);
      expect(hq_set.tran_info.css_tran52_34 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran52_34 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran52_34 = defalut;
      print(hq_set.tran_info.css_tran52_34);
      expect(hq_set.tran_info.css_tran52_34 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran52_34 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran56_35;
      print(hq_set.tran_info.css_tran56_35);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran56_35 = testData1s;
      print(hq_set.tran_info.css_tran56_35);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran56_35 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran56_35 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran56_35 = testData2s;
      print(hq_set.tran_info.css_tran56_35);
      expect(hq_set.tran_info.css_tran56_35 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran56_35 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran56_35 = defalut;
      print(hq_set.tran_info.css_tran56_35);
      expect(hq_set.tran_info.css_tran56_35 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran56_35 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran57_36;
      print(hq_set.tran_info.css_tran57_36);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran57_36 = testData1s;
      print(hq_set.tran_info.css_tran57_36);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran57_36 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran57_36 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran57_36 = testData2s;
      print(hq_set.tran_info.css_tran57_36);
      expect(hq_set.tran_info.css_tran57_36 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran57_36 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran57_36 = defalut;
      print(hq_set.tran_info.css_tran57_36);
      expect(hq_set.tran_info.css_tran57_36 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran57_36 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran4A;
      print(hq_set.tran_info.css_tran4A);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran4A = testData1s;
      print(hq_set.tran_info.css_tran4A);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran4A == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran4A == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran4A = testData2s;
      print(hq_set.tran_info.css_tran4A);
      expect(hq_set.tran_info.css_tran4A == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran4A == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran4A = defalut;
      print(hq_set.tran_info.css_tran4A);
      expect(hq_set.tran_info.css_tran4A == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran4A == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran4B;
      print(hq_set.tran_info.css_tran4B);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran4B = testData1s;
      print(hq_set.tran_info.css_tran4B);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran4B == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran4B == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran4B = testData2s;
      print(hq_set.tran_info.css_tran4B);
      expect(hq_set.tran_info.css_tran4B == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran4B == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran4B = defalut;
      print(hq_set.tran_info.css_tran4B);
      expect(hq_set.tran_info.css_tran4B == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran4B == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran4C;
      print(hq_set.tran_info.css_tran4C);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran4C = testData1s;
      print(hq_set.tran_info.css_tran4C);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran4C == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran4C == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran4C = testData2s;
      print(hq_set.tran_info.css_tran4C);
      expect(hq_set.tran_info.css_tran4C == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran4C == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran4C = defalut;
      print(hq_set.tran_info.css_tran4C);
      expect(hq_set.tran_info.css_tran4C == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran4C == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran76;
      print(hq_set.tran_info.css_tran76);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran76 = testData1s;
      print(hq_set.tran_info.css_tran76);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran76 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran76 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran76 = testData2s;
      print(hq_set.tran_info.css_tran76);
      expect(hq_set.tran_info.css_tran76 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran76 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran76 = defalut;
      print(hq_set.tran_info.css_tran76);
      expect(hq_set.tran_info.css_tran76 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran76 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran73;
      print(hq_set.tran_info.css_tran73);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran73 = testData1s;
      print(hq_set.tran_info.css_tran73);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran73 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran73 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran73 = testData2s;
      print(hq_set.tran_info.css_tran73);
      expect(hq_set.tran_info.css_tran73 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran73 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran73 = defalut;
      print(hq_set.tran_info.css_tran73);
      expect(hq_set.tran_info.css_tran73 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran73 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran71;
      print(hq_set.tran_info.css_tran71);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran71 = testData1s;
      print(hq_set.tran_info.css_tran71);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran71 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran71 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran71 = testData2s;
      print(hq_set.tran_info.css_tran71);
      expect(hq_set.tran_info.css_tran71 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran71 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran71 = defalut;
      print(hq_set.tran_info.css_tran71);
      expect(hq_set.tran_info.css_tran71 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran71 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran72;
      print(hq_set.tran_info.css_tran72);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran72 = testData1s;
      print(hq_set.tran_info.css_tran72);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran72 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran72 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran72 = testData2s;
      print(hq_set.tran_info.css_tran72);
      expect(hq_set.tran_info.css_tran72 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran72 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran72 = defalut;
      print(hq_set.tran_info.css_tran72);
      expect(hq_set.tran_info.css_tran72 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran72 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tran7X;
      print(hq_set.tran_info.css_tran7X);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tran7X = testData1s;
      print(hq_set.tran_info.css_tran7X);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tran7X == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tran7X == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tran7X = testData2s;
      print(hq_set.tran_info.css_tran7X);
      expect(hq_set.tran_info.css_tran7X == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran7X == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tran7X = defalut;
      print(hq_set.tran_info.css_tran7X);
      expect(hq_set.tran_info.css_tran7X == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tran7X == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA1;
      print(hq_set.tran_info.css_tranA1);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA1 = testData1s;
      print(hq_set.tran_info.css_tranA1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA1 = testData2s;
      print(hq_set.tran_info.css_tranA1);
      expect(hq_set.tran_info.css_tranA1 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA1 = defalut;
      print(hq_set.tran_info.css_tranA1);
      expect(hq_set.tran_info.css_tranA1 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA3;
      print(hq_set.tran_info.css_tranA3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA3 = testData1s;
      print(hq_set.tran_info.css_tranA3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA3 = testData2s;
      print(hq_set.tran_info.css_tranA3);
      expect(hq_set.tran_info.css_tranA3 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA3 = defalut;
      print(hq_set.tran_info.css_tranA3);
      expect(hq_set.tran_info.css_tranA3 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA4;
      print(hq_set.tran_info.css_tranA4);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA4 = testData1s;
      print(hq_set.tran_info.css_tranA4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA4 = testData2s;
      print(hq_set.tran_info.css_tranA4);
      expect(hq_set.tran_info.css_tranA4 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA4 = defalut;
      print(hq_set.tran_info.css_tranA4);
      expect(hq_set.tran_info.css_tranA4 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA6;
      print(hq_set.tran_info.css_tranA6);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA6 = testData1s;
      print(hq_set.tran_info.css_tranA6);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA6 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA6 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA6 = testData2s;
      print(hq_set.tran_info.css_tranA6);
      expect(hq_set.tran_info.css_tranA6 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA6 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA6 = defalut;
      print(hq_set.tran_info.css_tranA6);
      expect(hq_set.tran_info.css_tranA6 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA6 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA7;
      print(hq_set.tran_info.css_tranA7);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA7 = testData1s;
      print(hq_set.tran_info.css_tranA7);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA7 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA7 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA7 = testData2s;
      print(hq_set.tran_info.css_tranA7);
      expect(hq_set.tran_info.css_tranA7 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA7 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA7 = defalut;
      print(hq_set.tran_info.css_tranA7);
      expect(hq_set.tran_info.css_tranA7 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA7 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA8;
      print(hq_set.tran_info.css_tranA8);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA8 = testData1s;
      print(hq_set.tran_info.css_tranA8);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA8 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA8 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA8 = testData2s;
      print(hq_set.tran_info.css_tranA8);
      expect(hq_set.tran_info.css_tranA8 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA8 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA8 = defalut;
      print(hq_set.tran_info.css_tranA8);
      expect(hq_set.tran_info.css_tranA8 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA8 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranA9;
      print(hq_set.tran_info.css_tranA9);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranA9 = testData1s;
      print(hq_set.tran_info.css_tranA9);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranA9 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranA9 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranA9 = testData2s;
      print(hq_set.tran_info.css_tranA9);
      expect(hq_set.tran_info.css_tranA9 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA9 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranA9 = defalut;
      print(hq_set.tran_info.css_tranA9);
      expect(hq_set.tran_info.css_tranA9 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranA9 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranC2;
      print(hq_set.tran_info.css_tranC2);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranC2 = testData1s;
      print(hq_set.tran_info.css_tranC2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranC2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranC2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranC2 = testData2s;
      print(hq_set.tran_info.css_tranC2);
      expect(hq_set.tran_info.css_tranC2 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranC2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranC2 = defalut;
      print(hq_set.tran_info.css_tranC2);
      expect(hq_set.tran_info.css_tranC2 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranC2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranTL_IL;
      print(hq_set.tran_info.css_tranTL_IL);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranTL_IL = testData1s;
      print(hq_set.tran_info.css_tranTL_IL);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranTL_IL == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranTL_IL == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranTL_IL = testData2s;
      print(hq_set.tran_info.css_tranTL_IL);
      expect(hq_set.tran_info.css_tranTL_IL == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranTL_IL == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranTL_IL = defalut;
      print(hq_set.tran_info.css_tranTL_IL);
      expect(hq_set.tran_info.css_tranTL_IL == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranTL_IL == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.tran_info.css_tranT3_I3;
      print(hq_set.tran_info.css_tranT3_I3);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.tran_info.css_tranT3_I3 = testData1s;
      print(hq_set.tran_info.css_tranT3_I3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.tran_info.css_tranT3_I3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.tran_info.css_tranT3_I3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.tran_info.css_tranT3_I3 = testData2s;
      print(hq_set.tran_info.css_tranT3_I3);
      expect(hq_set.tran_info.css_tranT3_I3 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranT3_I3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.tran_info.css_tranT3_I3 = defalut;
      print(hq_set.tran_info.css_tranT3_I3);
      expect(hq_set.tran_info.css_tranT3_I3 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.tran_info.css_tranT3_I3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.useMax;
      print(hq_set.hq_TLIL.useMax);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.useMax = testData1;
      print(hq_set.hq_TLIL.useMax);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.useMax == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.useMax == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.useMax = testData2;
      print(hq_set.hq_TLIL.useMax);
      expect(hq_set.hq_TLIL.useMax == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.useMax == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.useMax = defalut;
      print(hq_set.hq_TLIL.useMax);
      expect(hq_set.hq_TLIL.useMax == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.useMax == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_001;
      print(hq_set.hq_TLIL.Flag_001);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_001 = testData1;
      print(hq_set.hq_TLIL.Flag_001);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_001 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_001 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_001 = testData2;
      print(hq_set.hq_TLIL.Flag_001);
      expect(hq_set.hq_TLIL.Flag_001 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_001 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_001 = defalut;
      print(hq_set.hq_TLIL.Flag_001);
      expect(hq_set.hq_TLIL.Flag_001 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_001 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_001;
      print(hq_set.hq_TLIL.Mode_001);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_001 = testData1;
      print(hq_set.hq_TLIL.Mode_001);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_001 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_001 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_001 = testData2;
      print(hq_set.hq_TLIL.Mode_001);
      expect(hq_set.hq_TLIL.Mode_001 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_001 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_001 = defalut;
      print(hq_set.hq_TLIL.Mode_001);
      expect(hq_set.hq_TLIL.Mode_001 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_001 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_002;
      print(hq_set.hq_TLIL.Flag_002);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_002 = testData1;
      print(hq_set.hq_TLIL.Flag_002);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_002 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_002 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_002 = testData2;
      print(hq_set.hq_TLIL.Flag_002);
      expect(hq_set.hq_TLIL.Flag_002 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_002 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_002 = defalut;
      print(hq_set.hq_TLIL.Flag_002);
      expect(hq_set.hq_TLIL.Flag_002 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_002 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_002;
      print(hq_set.hq_TLIL.Mode_002);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_002 = testData1;
      print(hq_set.hq_TLIL.Mode_002);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_002 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_002 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_002 = testData2;
      print(hq_set.hq_TLIL.Mode_002);
      expect(hq_set.hq_TLIL.Mode_002 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_002 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_002 = defalut;
      print(hq_set.hq_TLIL.Mode_002);
      expect(hq_set.hq_TLIL.Mode_002 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_002 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_003;
      print(hq_set.hq_TLIL.Flag_003);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_003 = testData1;
      print(hq_set.hq_TLIL.Flag_003);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_003 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_003 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_003 = testData2;
      print(hq_set.hq_TLIL.Flag_003);
      expect(hq_set.hq_TLIL.Flag_003 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_003 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_003 = defalut;
      print(hq_set.hq_TLIL.Flag_003);
      expect(hq_set.hq_TLIL.Flag_003 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_003 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_003;
      print(hq_set.hq_TLIL.Mode_003);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_003 = testData1;
      print(hq_set.hq_TLIL.Mode_003);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_003 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_003 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_003 = testData2;
      print(hq_set.hq_TLIL.Mode_003);
      expect(hq_set.hq_TLIL.Mode_003 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_003 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_003 = defalut;
      print(hq_set.hq_TLIL.Mode_003);
      expect(hq_set.hq_TLIL.Mode_003 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_003 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_004;
      print(hq_set.hq_TLIL.Flag_004);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_004 = testData1;
      print(hq_set.hq_TLIL.Flag_004);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_004 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_004 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_004 = testData2;
      print(hq_set.hq_TLIL.Flag_004);
      expect(hq_set.hq_TLIL.Flag_004 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_004 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_004 = defalut;
      print(hq_set.hq_TLIL.Flag_004);
      expect(hq_set.hq_TLIL.Flag_004 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_004 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_004;
      print(hq_set.hq_TLIL.Mode_004);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_004 = testData1;
      print(hq_set.hq_TLIL.Mode_004);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_004 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_004 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_004 = testData2;
      print(hq_set.hq_TLIL.Mode_004);
      expect(hq_set.hq_TLIL.Mode_004 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_004 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_004 = defalut;
      print(hq_set.hq_TLIL.Mode_004);
      expect(hq_set.hq_TLIL.Mode_004 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_004 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_005;
      print(hq_set.hq_TLIL.Flag_005);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_005 = testData1;
      print(hq_set.hq_TLIL.Flag_005);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_005 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_005 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_005 = testData2;
      print(hq_set.hq_TLIL.Flag_005);
      expect(hq_set.hq_TLIL.Flag_005 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_005 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_005 = defalut;
      print(hq_set.hq_TLIL.Flag_005);
      expect(hq_set.hq_TLIL.Flag_005 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_005 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_005;
      print(hq_set.hq_TLIL.Mode_005);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_005 = testData1;
      print(hq_set.hq_TLIL.Mode_005);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_005 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_005 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_005 = testData2;
      print(hq_set.hq_TLIL.Mode_005);
      expect(hq_set.hq_TLIL.Mode_005 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_005 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_005 = defalut;
      print(hq_set.hq_TLIL.Mode_005);
      expect(hq_set.hq_TLIL.Mode_005 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_005 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_006;
      print(hq_set.hq_TLIL.Flag_006);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_006 = testData1;
      print(hq_set.hq_TLIL.Flag_006);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_006 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_006 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_006 = testData2;
      print(hq_set.hq_TLIL.Flag_006);
      expect(hq_set.hq_TLIL.Flag_006 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_006 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_006 = defalut;
      print(hq_set.hq_TLIL.Flag_006);
      expect(hq_set.hq_TLIL.Flag_006 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_006 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_006;
      print(hq_set.hq_TLIL.Mode_006);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_006 = testData1;
      print(hq_set.hq_TLIL.Mode_006);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_006 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_006 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_006 = testData2;
      print(hq_set.hq_TLIL.Mode_006);
      expect(hq_set.hq_TLIL.Mode_006 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_006 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_006 = defalut;
      print(hq_set.hq_TLIL.Mode_006);
      expect(hq_set.hq_TLIL.Mode_006 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_006 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_007;
      print(hq_set.hq_TLIL.Flag_007);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_007 = testData1;
      print(hq_set.hq_TLIL.Flag_007);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_007 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_007 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_007 = testData2;
      print(hq_set.hq_TLIL.Flag_007);
      expect(hq_set.hq_TLIL.Flag_007 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_007 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_007 = defalut;
      print(hq_set.hq_TLIL.Flag_007);
      expect(hq_set.hq_TLIL.Flag_007 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_007 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_007;
      print(hq_set.hq_TLIL.Mode_007);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_007 = testData1;
      print(hq_set.hq_TLIL.Mode_007);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_007 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_007 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_007 = testData2;
      print(hq_set.hq_TLIL.Mode_007);
      expect(hq_set.hq_TLIL.Mode_007 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_007 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_007 = defalut;
      print(hq_set.hq_TLIL.Mode_007);
      expect(hq_set.hq_TLIL.Mode_007 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_007 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_008;
      print(hq_set.hq_TLIL.Flag_008);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_008 = testData1;
      print(hq_set.hq_TLIL.Flag_008);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_008 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_008 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_008 = testData2;
      print(hq_set.hq_TLIL.Flag_008);
      expect(hq_set.hq_TLIL.Flag_008 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_008 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_008 = defalut;
      print(hq_set.hq_TLIL.Flag_008);
      expect(hq_set.hq_TLIL.Flag_008 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_008 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_008;
      print(hq_set.hq_TLIL.Mode_008);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_008 = testData1;
      print(hq_set.hq_TLIL.Mode_008);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_008 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_008 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_008 = testData2;
      print(hq_set.hq_TLIL.Mode_008);
      expect(hq_set.hq_TLIL.Mode_008 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_008 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_008 = defalut;
      print(hq_set.hq_TLIL.Mode_008);
      expect(hq_set.hq_TLIL.Mode_008 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_008 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Flag_009;
      print(hq_set.hq_TLIL.Flag_009);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Flag_009 = testData1;
      print(hq_set.hq_TLIL.Flag_009);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Flag_009 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Flag_009 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Flag_009 = testData2;
      print(hq_set.hq_TLIL.Flag_009);
      expect(hq_set.hq_TLIL.Flag_009 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_009 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Flag_009 = defalut;
      print(hq_set.hq_TLIL.Flag_009);
      expect(hq_set.hq_TLIL.Flag_009 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Flag_009 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.hq_TLIL.Mode_009;
      print(hq_set.hq_TLIL.Mode_009);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.hq_TLIL.Mode_009 = testData1;
      print(hq_set.hq_TLIL.Mode_009);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.hq_TLIL.Mode_009 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.hq_TLIL.Mode_009 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.hq_TLIL.Mode_009 = testData2;
      print(hq_set.hq_TLIL.Mode_009);
      expect(hq_set.hq_TLIL.Mode_009 == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_009 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.hq_TLIL.Mode_009 = defalut;
      print(hq_set.hq_TLIL.Mode_009);
      expect(hq_set.hq_TLIL.Mode_009 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.hq_TLIL.Mode_009 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_max;
      print(hq_set.netdoa_day_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_max = testData1;
      print(hq_set.netdoa_day_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_max = testData2;
      print(hq_set.netdoa_day_info.info_max);
      expect(hq_set.netdoa_day_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_max = defalut;
      print(hq_set.netdoa_day_info.info_max);
      expect(hq_set.netdoa_day_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_01;
      print(hq_set.netdoa_day_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_01 = testData1s;
      print(hq_set.netdoa_day_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_01 = testData2s;
      print(hq_set.netdoa_day_info.info_01);
      expect(hq_set.netdoa_day_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_01 = defalut;
      print(hq_set.netdoa_day_info.info_01);
      expect(hq_set.netdoa_day_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_02;
      print(hq_set.netdoa_day_info.info_02);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_02 = testData1s;
      print(hq_set.netdoa_day_info.info_02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_02 = testData2s;
      print(hq_set.netdoa_day_info.info_02);
      expect(hq_set.netdoa_day_info.info_02 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_02 = defalut;
      print(hq_set.netdoa_day_info.info_02);
      expect(hq_set.netdoa_day_info.info_02 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_03;
      print(hq_set.netdoa_day_info.info_03);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_03 = testData1s;
      print(hq_set.netdoa_day_info.info_03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_03 = testData2s;
      print(hq_set.netdoa_day_info.info_03);
      expect(hq_set.netdoa_day_info.info_03 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_03 = defalut;
      print(hq_set.netdoa_day_info.info_03);
      expect(hq_set.netdoa_day_info.info_03 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_04;
      print(hq_set.netdoa_day_info.info_04);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_04 = testData1s;
      print(hq_set.netdoa_day_info.info_04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_04 = testData2s;
      print(hq_set.netdoa_day_info.info_04);
      expect(hq_set.netdoa_day_info.info_04 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_04 = defalut;
      print(hq_set.netdoa_day_info.info_04);
      expect(hq_set.netdoa_day_info.info_04 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_05;
      print(hq_set.netdoa_day_info.info_05);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_05 = testData1s;
      print(hq_set.netdoa_day_info.info_05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_05 = testData2s;
      print(hq_set.netdoa_day_info.info_05);
      expect(hq_set.netdoa_day_info.info_05 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_05 = defalut;
      print(hq_set.netdoa_day_info.info_05);
      expect(hq_set.netdoa_day_info.info_05 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_06;
      print(hq_set.netdoa_day_info.info_06);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_06 = testData1s;
      print(hq_set.netdoa_day_info.info_06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_06 = testData2s;
      print(hq_set.netdoa_day_info.info_06);
      expect(hq_set.netdoa_day_info.info_06 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_06 = defalut;
      print(hq_set.netdoa_day_info.info_06);
      expect(hq_set.netdoa_day_info.info_06 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_07;
      print(hq_set.netdoa_day_info.info_07);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_07 = testData1s;
      print(hq_set.netdoa_day_info.info_07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_07 = testData2s;
      print(hq_set.netdoa_day_info.info_07);
      expect(hq_set.netdoa_day_info.info_07 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_07 = defalut;
      print(hq_set.netdoa_day_info.info_07);
      expect(hq_set.netdoa_day_info.info_07 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_08;
      print(hq_set.netdoa_day_info.info_08);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_08 = testData1s;
      print(hq_set.netdoa_day_info.info_08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_08 = testData2s;
      print(hq_set.netdoa_day_info.info_08);
      expect(hq_set.netdoa_day_info.info_08 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_08 = defalut;
      print(hq_set.netdoa_day_info.info_08);
      expect(hq_set.netdoa_day_info.info_08 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_09;
      print(hq_set.netdoa_day_info.info_09);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_09 = testData1s;
      print(hq_set.netdoa_day_info.info_09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_09 = testData2s;
      print(hq_set.netdoa_day_info.info_09);
      expect(hq_set.netdoa_day_info.info_09 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_09 = defalut;
      print(hq_set.netdoa_day_info.info_09);
      expect(hq_set.netdoa_day_info.info_09 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_10;
      print(hq_set.netdoa_day_info.info_10);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_10 = testData1s;
      print(hq_set.netdoa_day_info.info_10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_10 = testData2s;
      print(hq_set.netdoa_day_info.info_10);
      expect(hq_set.netdoa_day_info.info_10 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_10 = defalut;
      print(hq_set.netdoa_day_info.info_10);
      expect(hq_set.netdoa_day_info.info_10 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_11;
      print(hq_set.netdoa_day_info.info_11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_11 = testData1s;
      print(hq_set.netdoa_day_info.info_11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_11 = testData2s;
      print(hq_set.netdoa_day_info.info_11);
      expect(hq_set.netdoa_day_info.info_11 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_11 = defalut;
      print(hq_set.netdoa_day_info.info_11);
      expect(hq_set.netdoa_day_info.info_11 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_12;
      print(hq_set.netdoa_day_info.info_12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_12 = testData1s;
      print(hq_set.netdoa_day_info.info_12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_12 = testData2s;
      print(hq_set.netdoa_day_info.info_12);
      expect(hq_set.netdoa_day_info.info_12 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_12 = defalut;
      print(hq_set.netdoa_day_info.info_12);
      expect(hq_set.netdoa_day_info.info_12 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_13;
      print(hq_set.netdoa_day_info.info_13);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_13 = testData1s;
      print(hq_set.netdoa_day_info.info_13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_13 = testData2s;
      print(hq_set.netdoa_day_info.info_13);
      expect(hq_set.netdoa_day_info.info_13 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_13 = defalut;
      print(hq_set.netdoa_day_info.info_13);
      expect(hq_set.netdoa_day_info.info_13 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_14;
      print(hq_set.netdoa_day_info.info_14);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_14 = testData1s;
      print(hq_set.netdoa_day_info.info_14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_14 = testData2s;
      print(hq_set.netdoa_day_info.info_14);
      expect(hq_set.netdoa_day_info.info_14 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_14 = defalut;
      print(hq_set.netdoa_day_info.info_14);
      expect(hq_set.netdoa_day_info.info_14 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_15;
      print(hq_set.netdoa_day_info.info_15);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_15 = testData1s;
      print(hq_set.netdoa_day_info.info_15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_15 = testData2s;
      print(hq_set.netdoa_day_info.info_15);
      expect(hq_set.netdoa_day_info.info_15 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_15 = defalut;
      print(hq_set.netdoa_day_info.info_15);
      expect(hq_set.netdoa_day_info.info_15 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_16;
      print(hq_set.netdoa_day_info.info_16);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_16 = testData1s;
      print(hq_set.netdoa_day_info.info_16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_16 = testData2s;
      print(hq_set.netdoa_day_info.info_16);
      expect(hq_set.netdoa_day_info.info_16 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_16 = defalut;
      print(hq_set.netdoa_day_info.info_16);
      expect(hq_set.netdoa_day_info.info_16 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_17;
      print(hq_set.netdoa_day_info.info_17);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_17 = testData1s;
      print(hq_set.netdoa_day_info.info_17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_17 = testData2s;
      print(hq_set.netdoa_day_info.info_17);
      expect(hq_set.netdoa_day_info.info_17 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_17 = defalut;
      print(hq_set.netdoa_day_info.info_17);
      expect(hq_set.netdoa_day_info.info_17 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_18;
      print(hq_set.netdoa_day_info.info_18);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_18 = testData1s;
      print(hq_set.netdoa_day_info.info_18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_18 = testData2s;
      print(hq_set.netdoa_day_info.info_18);
      expect(hq_set.netdoa_day_info.info_18 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_18 = defalut;
      print(hq_set.netdoa_day_info.info_18);
      expect(hq_set.netdoa_day_info.info_18 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_19;
      print(hq_set.netdoa_day_info.info_19);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_19 = testData1s;
      print(hq_set.netdoa_day_info.info_19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_19 = testData2s;
      print(hq_set.netdoa_day_info.info_19);
      expect(hq_set.netdoa_day_info.info_19 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_19 = defalut;
      print(hq_set.netdoa_day_info.info_19);
      expect(hq_set.netdoa_day_info.info_19 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_20;
      print(hq_set.netdoa_day_info.info_20);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_20 = testData1s;
      print(hq_set.netdoa_day_info.info_20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_20 = testData2s;
      print(hq_set.netdoa_day_info.info_20);
      expect(hq_set.netdoa_day_info.info_20 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_20 = defalut;
      print(hq_set.netdoa_day_info.info_20);
      expect(hq_set.netdoa_day_info.info_20 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_day_info.info_21;
      print(hq_set.netdoa_day_info.info_21);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_day_info.info_21 = testData1s;
      print(hq_set.netdoa_day_info.info_21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_day_info.info_21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_day_info.info_21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_day_info.info_21 = testData2s;
      print(hq_set.netdoa_day_info.info_21);
      expect(hq_set.netdoa_day_info.info_21 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_day_info.info_21 = defalut;
      print(hq_set.netdoa_day_info.info_21);
      expect(hq_set.netdoa_day_info.info_21 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_day_info.info_21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_max;
      print(hq_set.netdoa_cls_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_max = testData1;
      print(hq_set.netdoa_cls_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_max = testData2;
      print(hq_set.netdoa_cls_info.info_max);
      expect(hq_set.netdoa_cls_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_max = defalut;
      print(hq_set.netdoa_cls_info.info_max);
      expect(hq_set.netdoa_cls_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_01;
      print(hq_set.netdoa_cls_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_01 = testData1s;
      print(hq_set.netdoa_cls_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_01 = testData2s;
      print(hq_set.netdoa_cls_info.info_01);
      expect(hq_set.netdoa_cls_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_01 = defalut;
      print(hq_set.netdoa_cls_info.info_01);
      expect(hq_set.netdoa_cls_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_02;
      print(hq_set.netdoa_cls_info.info_02);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_02 = testData1s;
      print(hq_set.netdoa_cls_info.info_02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_02 = testData2s;
      print(hq_set.netdoa_cls_info.info_02);
      expect(hq_set.netdoa_cls_info.info_02 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_02 = defalut;
      print(hq_set.netdoa_cls_info.info_02);
      expect(hq_set.netdoa_cls_info.info_02 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_03;
      print(hq_set.netdoa_cls_info.info_03);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_03 = testData1s;
      print(hq_set.netdoa_cls_info.info_03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_03 = testData2s;
      print(hq_set.netdoa_cls_info.info_03);
      expect(hq_set.netdoa_cls_info.info_03 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_03 = defalut;
      print(hq_set.netdoa_cls_info.info_03);
      expect(hq_set.netdoa_cls_info.info_03 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_04;
      print(hq_set.netdoa_cls_info.info_04);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_04 = testData1s;
      print(hq_set.netdoa_cls_info.info_04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_04 = testData2s;
      print(hq_set.netdoa_cls_info.info_04);
      expect(hq_set.netdoa_cls_info.info_04 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_04 = defalut;
      print(hq_set.netdoa_cls_info.info_04);
      expect(hq_set.netdoa_cls_info.info_04 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_05;
      print(hq_set.netdoa_cls_info.info_05);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_05 = testData1s;
      print(hq_set.netdoa_cls_info.info_05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_05 = testData2s;
      print(hq_set.netdoa_cls_info.info_05);
      expect(hq_set.netdoa_cls_info.info_05 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_05 = defalut;
      print(hq_set.netdoa_cls_info.info_05);
      expect(hq_set.netdoa_cls_info.info_05 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_06;
      print(hq_set.netdoa_cls_info.info_06);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_06 = testData1s;
      print(hq_set.netdoa_cls_info.info_06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_06 = testData2s;
      print(hq_set.netdoa_cls_info.info_06);
      expect(hq_set.netdoa_cls_info.info_06 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_06 = defalut;
      print(hq_set.netdoa_cls_info.info_06);
      expect(hq_set.netdoa_cls_info.info_06 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_07;
      print(hq_set.netdoa_cls_info.info_07);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_07 = testData1s;
      print(hq_set.netdoa_cls_info.info_07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_07 = testData2s;
      print(hq_set.netdoa_cls_info.info_07);
      expect(hq_set.netdoa_cls_info.info_07 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_07 = defalut;
      print(hq_set.netdoa_cls_info.info_07);
      expect(hq_set.netdoa_cls_info.info_07 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_08;
      print(hq_set.netdoa_cls_info.info_08);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_08 = testData1s;
      print(hq_set.netdoa_cls_info.info_08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_08 = testData2s;
      print(hq_set.netdoa_cls_info.info_08);
      expect(hq_set.netdoa_cls_info.info_08 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_08 = defalut;
      print(hq_set.netdoa_cls_info.info_08);
      expect(hq_set.netdoa_cls_info.info_08 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_09;
      print(hq_set.netdoa_cls_info.info_09);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_09 = testData1s;
      print(hq_set.netdoa_cls_info.info_09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_09 = testData2s;
      print(hq_set.netdoa_cls_info.info_09);
      expect(hq_set.netdoa_cls_info.info_09 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_09 = defalut;
      print(hq_set.netdoa_cls_info.info_09);
      expect(hq_set.netdoa_cls_info.info_09 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_10;
      print(hq_set.netdoa_cls_info.info_10);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_10 = testData1s;
      print(hq_set.netdoa_cls_info.info_10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_10 = testData2s;
      print(hq_set.netdoa_cls_info.info_10);
      expect(hq_set.netdoa_cls_info.info_10 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_10 = defalut;
      print(hq_set.netdoa_cls_info.info_10);
      expect(hq_set.netdoa_cls_info.info_10 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_11;
      print(hq_set.netdoa_cls_info.info_11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_11 = testData1s;
      print(hq_set.netdoa_cls_info.info_11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_11 = testData2s;
      print(hq_set.netdoa_cls_info.info_11);
      expect(hq_set.netdoa_cls_info.info_11 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_11 = defalut;
      print(hq_set.netdoa_cls_info.info_11);
      expect(hq_set.netdoa_cls_info.info_11 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_12;
      print(hq_set.netdoa_cls_info.info_12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_12 = testData1s;
      print(hq_set.netdoa_cls_info.info_12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_12 = testData2s;
      print(hq_set.netdoa_cls_info.info_12);
      expect(hq_set.netdoa_cls_info.info_12 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_12 = defalut;
      print(hq_set.netdoa_cls_info.info_12);
      expect(hq_set.netdoa_cls_info.info_12 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_13;
      print(hq_set.netdoa_cls_info.info_13);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_13 = testData1s;
      print(hq_set.netdoa_cls_info.info_13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_13 = testData2s;
      print(hq_set.netdoa_cls_info.info_13);
      expect(hq_set.netdoa_cls_info.info_13 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_13 = defalut;
      print(hq_set.netdoa_cls_info.info_13);
      expect(hq_set.netdoa_cls_info.info_13 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_14;
      print(hq_set.netdoa_cls_info.info_14);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_14 = testData1s;
      print(hq_set.netdoa_cls_info.info_14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_14 = testData2s;
      print(hq_set.netdoa_cls_info.info_14);
      expect(hq_set.netdoa_cls_info.info_14 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_14 = defalut;
      print(hq_set.netdoa_cls_info.info_14);
      expect(hq_set.netdoa_cls_info.info_14 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_15;
      print(hq_set.netdoa_cls_info.info_15);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_15 = testData1s;
      print(hq_set.netdoa_cls_info.info_15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_15 = testData2s;
      print(hq_set.netdoa_cls_info.info_15);
      expect(hq_set.netdoa_cls_info.info_15 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_15 = defalut;
      print(hq_set.netdoa_cls_info.info_15);
      expect(hq_set.netdoa_cls_info.info_15 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_16;
      print(hq_set.netdoa_cls_info.info_16);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_16 = testData1s;
      print(hq_set.netdoa_cls_info.info_16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_16 = testData2s;
      print(hq_set.netdoa_cls_info.info_16);
      expect(hq_set.netdoa_cls_info.info_16 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_16 = defalut;
      print(hq_set.netdoa_cls_info.info_16);
      expect(hq_set.netdoa_cls_info.info_16 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_17;
      print(hq_set.netdoa_cls_info.info_17);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_17 = testData1s;
      print(hq_set.netdoa_cls_info.info_17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_17 = testData2s;
      print(hq_set.netdoa_cls_info.info_17);
      expect(hq_set.netdoa_cls_info.info_17 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_17 = defalut;
      print(hq_set.netdoa_cls_info.info_17);
      expect(hq_set.netdoa_cls_info.info_17 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_18;
      print(hq_set.netdoa_cls_info.info_18);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_18 = testData1s;
      print(hq_set.netdoa_cls_info.info_18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_18 = testData2s;
      print(hq_set.netdoa_cls_info.info_18);
      expect(hq_set.netdoa_cls_info.info_18 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_18 = defalut;
      print(hq_set.netdoa_cls_info.info_18);
      expect(hq_set.netdoa_cls_info.info_18 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_19;
      print(hq_set.netdoa_cls_info.info_19);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_19 = testData1s;
      print(hq_set.netdoa_cls_info.info_19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_19 = testData2s;
      print(hq_set.netdoa_cls_info.info_19);
      expect(hq_set.netdoa_cls_info.info_19 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_19 = defalut;
      print(hq_set.netdoa_cls_info.info_19);
      expect(hq_set.netdoa_cls_info.info_19 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_20;
      print(hq_set.netdoa_cls_info.info_20);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_20 = testData1s;
      print(hq_set.netdoa_cls_info.info_20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_20 = testData2s;
      print(hq_set.netdoa_cls_info.info_20);
      expect(hq_set.netdoa_cls_info.info_20 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_20 = defalut;
      print(hq_set.netdoa_cls_info.info_20);
      expect(hq_set.netdoa_cls_info.info_20 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_21;
      print(hq_set.netdoa_cls_info.info_21);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_21 = testData1s;
      print(hq_set.netdoa_cls_info.info_21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_21 = testData2s;
      print(hq_set.netdoa_cls_info.info_21);
      expect(hq_set.netdoa_cls_info.info_21 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_21 = defalut;
      print(hq_set.netdoa_cls_info.info_21);
      expect(hq_set.netdoa_cls_info.info_21 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_22;
      print(hq_set.netdoa_cls_info.info_22);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_22 = testData1s;
      print(hq_set.netdoa_cls_info.info_22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_22 = testData2s;
      print(hq_set.netdoa_cls_info.info_22);
      expect(hq_set.netdoa_cls_info.info_22 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_22 = defalut;
      print(hq_set.netdoa_cls_info.info_22);
      expect(hq_set.netdoa_cls_info.info_22 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_23;
      print(hq_set.netdoa_cls_info.info_23);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_23 = testData1s;
      print(hq_set.netdoa_cls_info.info_23);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_23 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_23 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_23 = testData2s;
      print(hq_set.netdoa_cls_info.info_23);
      expect(hq_set.netdoa_cls_info.info_23 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_23 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_23 = defalut;
      print(hq_set.netdoa_cls_info.info_23);
      expect(hq_set.netdoa_cls_info.info_23 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_23 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_24;
      print(hq_set.netdoa_cls_info.info_24);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_24 = testData1s;
      print(hq_set.netdoa_cls_info.info_24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_24 = testData2s;
      print(hq_set.netdoa_cls_info.info_24);
      expect(hq_set.netdoa_cls_info.info_24 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_24 = defalut;
      print(hq_set.netdoa_cls_info.info_24);
      expect(hq_set.netdoa_cls_info.info_24 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_25;
      print(hq_set.netdoa_cls_info.info_25);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_25 = testData1s;
      print(hq_set.netdoa_cls_info.info_25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_25 = testData2s;
      print(hq_set.netdoa_cls_info.info_25);
      expect(hq_set.netdoa_cls_info.info_25 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_25 = defalut;
      print(hq_set.netdoa_cls_info.info_25);
      expect(hq_set.netdoa_cls_info.info_25 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_26;
      print(hq_set.netdoa_cls_info.info_26);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_26 = testData1s;
      print(hq_set.netdoa_cls_info.info_26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_26 = testData2s;
      print(hq_set.netdoa_cls_info.info_26);
      expect(hq_set.netdoa_cls_info.info_26 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_26 = defalut;
      print(hq_set.netdoa_cls_info.info_26);
      expect(hq_set.netdoa_cls_info.info_26 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_27;
      print(hq_set.netdoa_cls_info.info_27);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_27 = testData1s;
      print(hq_set.netdoa_cls_info.info_27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_27 = testData2s;
      print(hq_set.netdoa_cls_info.info_27);
      expect(hq_set.netdoa_cls_info.info_27 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_27 = defalut;
      print(hq_set.netdoa_cls_info.info_27);
      expect(hq_set.netdoa_cls_info.info_27 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_28;
      print(hq_set.netdoa_cls_info.info_28);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_28 = testData1s;
      print(hq_set.netdoa_cls_info.info_28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_28 = testData2s;
      print(hq_set.netdoa_cls_info.info_28);
      expect(hq_set.netdoa_cls_info.info_28 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_28 = defalut;
      print(hq_set.netdoa_cls_info.info_28);
      expect(hq_set.netdoa_cls_info.info_28 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_29;
      print(hq_set.netdoa_cls_info.info_29);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_29 = testData1s;
      print(hq_set.netdoa_cls_info.info_29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_29 = testData2s;
      print(hq_set.netdoa_cls_info.info_29);
      expect(hq_set.netdoa_cls_info.info_29 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_29 = defalut;
      print(hq_set.netdoa_cls_info.info_29);
      expect(hq_set.netdoa_cls_info.info_29 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_cls_info.info_30;
      print(hq_set.netdoa_cls_info.info_30);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_cls_info.info_30 = testData1s;
      print(hq_set.netdoa_cls_info.info_30);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_cls_info.info_30 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_cls_info.info_30 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_cls_info.info_30 = testData2s;
      print(hq_set.netdoa_cls_info.info_30);
      expect(hq_set.netdoa_cls_info.info_30 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_30 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_cls_info.info_30 = defalut;
      print(hq_set.netdoa_cls_info.info_30);
      expect(hq_set.netdoa_cls_info.info_30 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_cls_info.info_30 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_ej_info.info_max;
      print(hq_set.netdoa_ej_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_ej_info.info_max = testData1;
      print(hq_set.netdoa_ej_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_ej_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_ej_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_ej_info.info_max = testData2;
      print(hq_set.netdoa_ej_info.info_max);
      expect(hq_set.netdoa_ej_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_ej_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_ej_info.info_max = defalut;
      print(hq_set.netdoa_ej_info.info_max);
      expect(hq_set.netdoa_ej_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_ej_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_ej_info.info_01;
      print(hq_set.netdoa_ej_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_ej_info.info_01 = testData1s;
      print(hq_set.netdoa_ej_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_ej_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_ej_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_ej_info.info_01 = testData2s;
      print(hq_set.netdoa_ej_info.info_01);
      expect(hq_set.netdoa_ej_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_ej_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_ej_info.info_01 = defalut;
      print(hq_set.netdoa_ej_info.info_01);
      expect(hq_set.netdoa_ej_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_ej_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.ts_day_info.info_max;
      print(hq_set.ts_day_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.ts_day_info.info_max = testData1;
      print(hq_set.ts_day_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.ts_day_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.ts_day_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.ts_day_info.info_max = testData2;
      print(hq_set.ts_day_info.info_max);
      expect(hq_set.ts_day_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_day_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.ts_day_info.info_max = defalut;
      print(hq_set.ts_day_info.info_max);
      expect(hq_set.ts_day_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_day_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.ts_day_info.info_01;
      print(hq_set.ts_day_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.ts_day_info.info_01 = testData1s;
      print(hq_set.ts_day_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.ts_day_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.ts_day_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.ts_day_info.info_01 = testData2s;
      print(hq_set.ts_day_info.info_01);
      expect(hq_set.ts_day_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_day_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.ts_day_info.info_01 = defalut;
      print(hq_set.ts_day_info.info_01);
      expect(hq_set.ts_day_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_day_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.ts_cls_info.info_max;
      print(hq_set.ts_cls_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.ts_cls_info.info_max = testData1;
      print(hq_set.ts_cls_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.ts_cls_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.ts_cls_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.ts_cls_info.info_max = testData2;
      print(hq_set.ts_cls_info.info_max);
      expect(hq_set.ts_cls_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_cls_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.ts_cls_info.info_max = defalut;
      print(hq_set.ts_cls_info.info_max);
      expect(hq_set.ts_cls_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_cls_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.ts_cls_info.info_01;
      print(hq_set.ts_cls_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.ts_cls_info.info_01 = testData1s;
      print(hq_set.ts_cls_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.ts_cls_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.ts_cls_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.ts_cls_info.info_01 = testData2s;
      print(hq_set.ts_cls_info.info_01);
      expect(hq_set.ts_cls_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_cls_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.ts_cls_info.info_01 = defalut;
      print(hq_set.ts_cls_info.info_01);
      expect(hq_set.ts_cls_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.ts_cls_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_max;
      print(hq_set.netdoa_mstsend.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_max = testData1;
      print(hq_set.netdoa_mstsend.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_max = testData2;
      print(hq_set.netdoa_mstsend.info_max);
      expect(hq_set.netdoa_mstsend.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_max = defalut;
      print(hq_set.netdoa_mstsend.info_max);
      expect(hq_set.netdoa_mstsend.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_01;
      print(hq_set.netdoa_mstsend.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_01 = testData1s;
      print(hq_set.netdoa_mstsend.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_01 = testData2s;
      print(hq_set.netdoa_mstsend.info_01);
      expect(hq_set.netdoa_mstsend.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_01 = defalut;
      print(hq_set.netdoa_mstsend.info_01);
      expect(hq_set.netdoa_mstsend.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_02;
      print(hq_set.netdoa_mstsend.info_02);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_02 = testData1s;
      print(hq_set.netdoa_mstsend.info_02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_02 = testData2s;
      print(hq_set.netdoa_mstsend.info_02);
      expect(hq_set.netdoa_mstsend.info_02 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_02 = defalut;
      print(hq_set.netdoa_mstsend.info_02);
      expect(hq_set.netdoa_mstsend.info_02 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_03;
      print(hq_set.netdoa_mstsend.info_03);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_03 = testData1s;
      print(hq_set.netdoa_mstsend.info_03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_03 = testData2s;
      print(hq_set.netdoa_mstsend.info_03);
      expect(hq_set.netdoa_mstsend.info_03 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_03 = defalut;
      print(hq_set.netdoa_mstsend.info_03);
      expect(hq_set.netdoa_mstsend.info_03 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_04;
      print(hq_set.netdoa_mstsend.info_04);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_04 = testData1s;
      print(hq_set.netdoa_mstsend.info_04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_04 = testData2s;
      print(hq_set.netdoa_mstsend.info_04);
      expect(hq_set.netdoa_mstsend.info_04 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_04 = defalut;
      print(hq_set.netdoa_mstsend.info_04);
      expect(hq_set.netdoa_mstsend.info_04 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_05;
      print(hq_set.netdoa_mstsend.info_05);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_05 = testData1s;
      print(hq_set.netdoa_mstsend.info_05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_05 = testData2s;
      print(hq_set.netdoa_mstsend.info_05);
      expect(hq_set.netdoa_mstsend.info_05 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_05 = defalut;
      print(hq_set.netdoa_mstsend.info_05);
      expect(hq_set.netdoa_mstsend.info_05 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_06;
      print(hq_set.netdoa_mstsend.info_06);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_06 = testData1s;
      print(hq_set.netdoa_mstsend.info_06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_06 = testData2s;
      print(hq_set.netdoa_mstsend.info_06);
      expect(hq_set.netdoa_mstsend.info_06 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_06 = defalut;
      print(hq_set.netdoa_mstsend.info_06);
      expect(hq_set.netdoa_mstsend.info_06 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_07;
      print(hq_set.netdoa_mstsend.info_07);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_07 = testData1s;
      print(hq_set.netdoa_mstsend.info_07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_07 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_07 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_07 = testData2s;
      print(hq_set.netdoa_mstsend.info_07);
      expect(hq_set.netdoa_mstsend.info_07 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_07 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_07 = defalut;
      print(hq_set.netdoa_mstsend.info_07);
      expect(hq_set.netdoa_mstsend.info_07 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_08;
      print(hq_set.netdoa_mstsend.info_08);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_08 = testData1s;
      print(hq_set.netdoa_mstsend.info_08);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_08 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_08 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_08 = testData2s;
      print(hq_set.netdoa_mstsend.info_08);
      expect(hq_set.netdoa_mstsend.info_08 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_08 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_08 = defalut;
      print(hq_set.netdoa_mstsend.info_08);
      expect(hq_set.netdoa_mstsend.info_08 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_08 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_09;
      print(hq_set.netdoa_mstsend.info_09);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_09 = testData1s;
      print(hq_set.netdoa_mstsend.info_09);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_09 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_09 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_09 = testData2s;
      print(hq_set.netdoa_mstsend.info_09);
      expect(hq_set.netdoa_mstsend.info_09 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_09 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_09 = defalut;
      print(hq_set.netdoa_mstsend.info_09);
      expect(hq_set.netdoa_mstsend.info_09 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_09 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_10;
      print(hq_set.netdoa_mstsend.info_10);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_10 = testData1s;
      print(hq_set.netdoa_mstsend.info_10);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_10 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_10 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_10 = testData2s;
      print(hq_set.netdoa_mstsend.info_10);
      expect(hq_set.netdoa_mstsend.info_10 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_10 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_10 = defalut;
      print(hq_set.netdoa_mstsend.info_10);
      expect(hq_set.netdoa_mstsend.info_10 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_10 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_11;
      print(hq_set.netdoa_mstsend.info_11);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_11 = testData1s;
      print(hq_set.netdoa_mstsend.info_11);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_11 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_11 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_11 = testData2s;
      print(hq_set.netdoa_mstsend.info_11);
      expect(hq_set.netdoa_mstsend.info_11 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_11 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_11 = defalut;
      print(hq_set.netdoa_mstsend.info_11);
      expect(hq_set.netdoa_mstsend.info_11 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_11 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_12;
      print(hq_set.netdoa_mstsend.info_12);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_12 = testData1s;
      print(hq_set.netdoa_mstsend.info_12);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_12 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_12 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_12 = testData2s;
      print(hq_set.netdoa_mstsend.info_12);
      expect(hq_set.netdoa_mstsend.info_12 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_12 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_12 = defalut;
      print(hq_set.netdoa_mstsend.info_12);
      expect(hq_set.netdoa_mstsend.info_12 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_12 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_13;
      print(hq_set.netdoa_mstsend.info_13);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_13 = testData1s;
      print(hq_set.netdoa_mstsend.info_13);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_13 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_13 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_13 = testData2s;
      print(hq_set.netdoa_mstsend.info_13);
      expect(hq_set.netdoa_mstsend.info_13 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_13 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_13 = defalut;
      print(hq_set.netdoa_mstsend.info_13);
      expect(hq_set.netdoa_mstsend.info_13 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_13 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_14;
      print(hq_set.netdoa_mstsend.info_14);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_14 = testData1s;
      print(hq_set.netdoa_mstsend.info_14);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_14 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_14 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_14 = testData2s;
      print(hq_set.netdoa_mstsend.info_14);
      expect(hq_set.netdoa_mstsend.info_14 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_14 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_14 = defalut;
      print(hq_set.netdoa_mstsend.info_14);
      expect(hq_set.netdoa_mstsend.info_14 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_14 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_15;
      print(hq_set.netdoa_mstsend.info_15);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_15 = testData1s;
      print(hq_set.netdoa_mstsend.info_15);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_15 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_15 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_15 = testData2s;
      print(hq_set.netdoa_mstsend.info_15);
      expect(hq_set.netdoa_mstsend.info_15 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_15 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_15 = defalut;
      print(hq_set.netdoa_mstsend.info_15);
      expect(hq_set.netdoa_mstsend.info_15 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_15 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_16;
      print(hq_set.netdoa_mstsend.info_16);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_16 = testData1s;
      print(hq_set.netdoa_mstsend.info_16);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_16 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_16 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_16 = testData2s;
      print(hq_set.netdoa_mstsend.info_16);
      expect(hq_set.netdoa_mstsend.info_16 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_16 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_16 = defalut;
      print(hq_set.netdoa_mstsend.info_16);
      expect(hq_set.netdoa_mstsend.info_16 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_16 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_17;
      print(hq_set.netdoa_mstsend.info_17);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_17 = testData1s;
      print(hq_set.netdoa_mstsend.info_17);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_17 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_17 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_17 = testData2s;
      print(hq_set.netdoa_mstsend.info_17);
      expect(hq_set.netdoa_mstsend.info_17 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_17 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_17 = defalut;
      print(hq_set.netdoa_mstsend.info_17);
      expect(hq_set.netdoa_mstsend.info_17 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_17 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_18;
      print(hq_set.netdoa_mstsend.info_18);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_18 = testData1s;
      print(hq_set.netdoa_mstsend.info_18);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_18 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_18 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_18 = testData2s;
      print(hq_set.netdoa_mstsend.info_18);
      expect(hq_set.netdoa_mstsend.info_18 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_18 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_18 = defalut;
      print(hq_set.netdoa_mstsend.info_18);
      expect(hq_set.netdoa_mstsend.info_18 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_18 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_19;
      print(hq_set.netdoa_mstsend.info_19);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_19 = testData1s;
      print(hq_set.netdoa_mstsend.info_19);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_19 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_19 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_19 = testData2s;
      print(hq_set.netdoa_mstsend.info_19);
      expect(hq_set.netdoa_mstsend.info_19 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_19 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_19 = defalut;
      print(hq_set.netdoa_mstsend.info_19);
      expect(hq_set.netdoa_mstsend.info_19 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_19 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_20;
      print(hq_set.netdoa_mstsend.info_20);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_20 = testData1s;
      print(hq_set.netdoa_mstsend.info_20);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_20 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_20 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_20 = testData2s;
      print(hq_set.netdoa_mstsend.info_20);
      expect(hq_set.netdoa_mstsend.info_20 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_20 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_20 = defalut;
      print(hq_set.netdoa_mstsend.info_20);
      expect(hq_set.netdoa_mstsend.info_20 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_20 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_21;
      print(hq_set.netdoa_mstsend.info_21);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_21 = testData1s;
      print(hq_set.netdoa_mstsend.info_21);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_21 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_21 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_21 = testData2s;
      print(hq_set.netdoa_mstsend.info_21);
      expect(hq_set.netdoa_mstsend.info_21 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_21 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_21 = defalut;
      print(hq_set.netdoa_mstsend.info_21);
      expect(hq_set.netdoa_mstsend.info_21 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_21 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_22;
      print(hq_set.netdoa_mstsend.info_22);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_22 = testData1s;
      print(hq_set.netdoa_mstsend.info_22);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_22 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_22 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_22 = testData2s;
      print(hq_set.netdoa_mstsend.info_22);
      expect(hq_set.netdoa_mstsend.info_22 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_22 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_22 = defalut;
      print(hq_set.netdoa_mstsend.info_22);
      expect(hq_set.netdoa_mstsend.info_22 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_22 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_23;
      print(hq_set.netdoa_mstsend.info_23);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_23 = testData1s;
      print(hq_set.netdoa_mstsend.info_23);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_23 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_23 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_23 = testData2s;
      print(hq_set.netdoa_mstsend.info_23);
      expect(hq_set.netdoa_mstsend.info_23 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_23 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_23 = defalut;
      print(hq_set.netdoa_mstsend.info_23);
      expect(hq_set.netdoa_mstsend.info_23 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_23 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_24;
      print(hq_set.netdoa_mstsend.info_24);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_24 = testData1s;
      print(hq_set.netdoa_mstsend.info_24);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_24 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_24 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_24 = testData2s;
      print(hq_set.netdoa_mstsend.info_24);
      expect(hq_set.netdoa_mstsend.info_24 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_24 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_24 = defalut;
      print(hq_set.netdoa_mstsend.info_24);
      expect(hq_set.netdoa_mstsend.info_24 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_24 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_25;
      print(hq_set.netdoa_mstsend.info_25);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_25 = testData1s;
      print(hq_set.netdoa_mstsend.info_25);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_25 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_25 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_25 = testData2s;
      print(hq_set.netdoa_mstsend.info_25);
      expect(hq_set.netdoa_mstsend.info_25 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_25 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_25 = defalut;
      print(hq_set.netdoa_mstsend.info_25);
      expect(hq_set.netdoa_mstsend.info_25 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_25 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_26;
      print(hq_set.netdoa_mstsend.info_26);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_26 = testData1s;
      print(hq_set.netdoa_mstsend.info_26);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_26 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_26 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_26 = testData2s;
      print(hq_set.netdoa_mstsend.info_26);
      expect(hq_set.netdoa_mstsend.info_26 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_26 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_26 = defalut;
      print(hq_set.netdoa_mstsend.info_26);
      expect(hq_set.netdoa_mstsend.info_26 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_26 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_27;
      print(hq_set.netdoa_mstsend.info_27);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_27 = testData1s;
      print(hq_set.netdoa_mstsend.info_27);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_27 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_27 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_27 = testData2s;
      print(hq_set.netdoa_mstsend.info_27);
      expect(hq_set.netdoa_mstsend.info_27 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_27 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_27 = defalut;
      print(hq_set.netdoa_mstsend.info_27);
      expect(hq_set.netdoa_mstsend.info_27 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_27 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_28;
      print(hq_set.netdoa_mstsend.info_28);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_28 = testData1s;
      print(hq_set.netdoa_mstsend.info_28);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_28 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_28 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_28 = testData2s;
      print(hq_set.netdoa_mstsend.info_28);
      expect(hq_set.netdoa_mstsend.info_28 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_28 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_28 = defalut;
      print(hq_set.netdoa_mstsend.info_28);
      expect(hq_set.netdoa_mstsend.info_28 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_28 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_29;
      print(hq_set.netdoa_mstsend.info_29);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_29 = testData1s;
      print(hq_set.netdoa_mstsend.info_29);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_29 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_29 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_29 = testData2s;
      print(hq_set.netdoa_mstsend.info_29);
      expect(hq_set.netdoa_mstsend.info_29 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_29 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_29 = defalut;
      print(hq_set.netdoa_mstsend.info_29);
      expect(hq_set.netdoa_mstsend.info_29 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_29 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_30;
      print(hq_set.netdoa_mstsend.info_30);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_30 = testData1s;
      print(hq_set.netdoa_mstsend.info_30);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_30 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_30 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_30 = testData2s;
      print(hq_set.netdoa_mstsend.info_30);
      expect(hq_set.netdoa_mstsend.info_30 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_30 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_30 = defalut;
      print(hq_set.netdoa_mstsend.info_30);
      expect(hq_set.netdoa_mstsend.info_30 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_30 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_31;
      print(hq_set.netdoa_mstsend.info_31);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_31 = testData1s;
      print(hq_set.netdoa_mstsend.info_31);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_31 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_31 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_31 = testData2s;
      print(hq_set.netdoa_mstsend.info_31);
      expect(hq_set.netdoa_mstsend.info_31 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_31 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_31 = defalut;
      print(hq_set.netdoa_mstsend.info_31);
      expect(hq_set.netdoa_mstsend.info_31 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_31 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_32;
      print(hq_set.netdoa_mstsend.info_32);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_32 = testData1s;
      print(hq_set.netdoa_mstsend.info_32);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_32 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_32 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_32 = testData2s;
      print(hq_set.netdoa_mstsend.info_32);
      expect(hq_set.netdoa_mstsend.info_32 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_32 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_32 = defalut;
      print(hq_set.netdoa_mstsend.info_32);
      expect(hq_set.netdoa_mstsend.info_32 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_32 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_33;
      print(hq_set.netdoa_mstsend.info_33);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_33 = testData1s;
      print(hq_set.netdoa_mstsend.info_33);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_33 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_33 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_33 = testData2s;
      print(hq_set.netdoa_mstsend.info_33);
      expect(hq_set.netdoa_mstsend.info_33 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_33 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_33 = defalut;
      print(hq_set.netdoa_mstsend.info_33);
      expect(hq_set.netdoa_mstsend.info_33 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_33 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_34;
      print(hq_set.netdoa_mstsend.info_34);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_34 = testData1s;
      print(hq_set.netdoa_mstsend.info_34);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_34 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_34 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_34 = testData2s;
      print(hq_set.netdoa_mstsend.info_34);
      expect(hq_set.netdoa_mstsend.info_34 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_34 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_34 = defalut;
      print(hq_set.netdoa_mstsend.info_34);
      expect(hq_set.netdoa_mstsend.info_34 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_34 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.netdoa_mstsend.info_35;
      print(hq_set.netdoa_mstsend.info_35);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.netdoa_mstsend.info_35 = testData1s;
      print(hq_set.netdoa_mstsend.info_35);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.netdoa_mstsend.info_35 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.netdoa_mstsend.info_35 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.netdoa_mstsend.info_35 = testData2s;
      print(hq_set.netdoa_mstsend.info_35);
      expect(hq_set.netdoa_mstsend.info_35 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_35 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.netdoa_mstsend.info_35 = defalut;
      print(hq_set.netdoa_mstsend.info_35);
      expect(hq_set.netdoa_mstsend.info_35 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.netdoa_mstsend.info_35 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_day_info.info_max;
      print(hq_set.css_day_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_day_info.info_max = testData1;
      print(hq_set.css_day_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_day_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_day_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_day_info.info_max = testData2;
      print(hq_set.css_day_info.info_max);
      expect(hq_set.css_day_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_day_info.info_max = defalut;
      print(hq_set.css_day_info.info_max);
      expect(hq_set.css_day_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_day_info.info_01;
      print(hq_set.css_day_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_day_info.info_01 = testData1s;
      print(hq_set.css_day_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_day_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_day_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_day_info.info_01 = testData2s;
      print(hq_set.css_day_info.info_01);
      expect(hq_set.css_day_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_day_info.info_01 = defalut;
      print(hq_set.css_day_info.info_01);
      expect(hq_set.css_day_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_day_info.info_02;
      print(hq_set.css_day_info.info_02);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_day_info.info_02 = testData1s;
      print(hq_set.css_day_info.info_02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_day_info.info_02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_day_info.info_02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_day_info.info_02 = testData2s;
      print(hq_set.css_day_info.info_02);
      expect(hq_set.css_day_info.info_02 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_day_info.info_02 = defalut;
      print(hq_set.css_day_info.info_02);
      expect(hq_set.css_day_info.info_02 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_day_info.info_03;
      print(hq_set.css_day_info.info_03);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_day_info.info_03 = testData1s;
      print(hq_set.css_day_info.info_03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_day_info.info_03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_day_info.info_03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_day_info.info_03 = testData2s;
      print(hq_set.css_day_info.info_03);
      expect(hq_set.css_day_info.info_03 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_day_info.info_03 = defalut;
      print(hq_set.css_day_info.info_03);
      expect(hq_set.css_day_info.info_03 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_day_info.info_04;
      print(hq_set.css_day_info.info_04);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_day_info.info_04 = testData1s;
      print(hq_set.css_day_info.info_04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_day_info.info_04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_day_info.info_04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_day_info.info_04 = testData2s;
      print(hq_set.css_day_info.info_04);
      expect(hq_set.css_day_info.info_04 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_day_info.info_04 = defalut;
      print(hq_set.css_day_info.info_04);
      expect(hq_set.css_day_info.info_04 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_day_info.info_04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_max;
      print(hq_set.css_cls_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_max = testData1;
      print(hq_set.css_cls_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_max = testData2;
      print(hq_set.css_cls_info.info_max);
      expect(hq_set.css_cls_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_max = defalut;
      print(hq_set.css_cls_info.info_max);
      expect(hq_set.css_cls_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_01;
      print(hq_set.css_cls_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_01 = testData1s;
      print(hq_set.css_cls_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_01 = testData2s;
      print(hq_set.css_cls_info.info_01);
      expect(hq_set.css_cls_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_01 = defalut;
      print(hq_set.css_cls_info.info_01);
      expect(hq_set.css_cls_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_02;
      print(hq_set.css_cls_info.info_02);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_02 = testData1s;
      print(hq_set.css_cls_info.info_02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_02 = testData2s;
      print(hq_set.css_cls_info.info_02);
      expect(hq_set.css_cls_info.info_02 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_02 = defalut;
      print(hq_set.css_cls_info.info_02);
      expect(hq_set.css_cls_info.info_02 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_03;
      print(hq_set.css_cls_info.info_03);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_03 = testData1s;
      print(hq_set.css_cls_info.info_03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_03 = testData2s;
      print(hq_set.css_cls_info.info_03);
      expect(hq_set.css_cls_info.info_03 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_03 = defalut;
      print(hq_set.css_cls_info.info_03);
      expect(hq_set.css_cls_info.info_03 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_04;
      print(hq_set.css_cls_info.info_04);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_04 = testData1s;
      print(hq_set.css_cls_info.info_04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_04 = testData2s;
      print(hq_set.css_cls_info.info_04);
      expect(hq_set.css_cls_info.info_04 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_04 = defalut;
      print(hq_set.css_cls_info.info_04);
      expect(hq_set.css_cls_info.info_04 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_05;
      print(hq_set.css_cls_info.info_05);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_05 = testData1s;
      print(hq_set.css_cls_info.info_05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_05 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_05 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_05 = testData2s;
      print(hq_set.css_cls_info.info_05);
      expect(hq_set.css_cls_info.info_05 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_05 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_05 = defalut;
      print(hq_set.css_cls_info.info_05);
      expect(hq_set.css_cls_info.info_05 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_cls_info.info_06;
      print(hq_set.css_cls_info.info_06);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_cls_info.info_06 = testData1s;
      print(hq_set.css_cls_info.info_06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_cls_info.info_06 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_cls_info.info_06 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_cls_info.info_06 = testData2s;
      print(hq_set.css_cls_info.info_06);
      expect(hq_set.css_cls_info.info_06 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_06 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_cls_info.info_06 = defalut;
      print(hq_set.css_cls_info.info_06);
      expect(hq_set.css_cls_info.info_06 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_cls_info.info_06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_odr_info.info_max;
      print(hq_set.css_odr_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_odr_info.info_max = testData1;
      print(hq_set.css_odr_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_odr_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_odr_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_odr_info.info_max = testData2;
      print(hq_set.css_odr_info.info_max);
      expect(hq_set.css_odr_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_odr_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_odr_info.info_max = defalut;
      print(hq_set.css_odr_info.info_max);
      expect(hq_set.css_odr_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_odr_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

    test('00242_element_check_00219', () async {
      print("\n********** テスト実行：00242_element_check_00219 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_odr_info.info_01;
      print(hq_set.css_odr_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_odr_info.info_01 = testData1s;
      print(hq_set.css_odr_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_odr_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_odr_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_odr_info.info_01 = testData2s;
      print(hq_set.css_odr_info.info_01);
      expect(hq_set.css_odr_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_odr_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_odr_info.info_01 = defalut;
      print(hq_set.css_odr_info.info_01);
      expect(hq_set.css_odr_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_odr_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00242_element_check_00219 **********\n\n");
    });

    test('00243_element_check_00220', () async {
      print("\n********** テスト実行：00243_element_check_00220 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_mst_create.info_max;
      print(hq_set.css_mst_create.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_mst_create.info_max = testData1;
      print(hq_set.css_mst_create.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_mst_create.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_mst_create.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_mst_create.info_max = testData2;
      print(hq_set.css_mst_create.info_max);
      expect(hq_set.css_mst_create.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_mst_create.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_mst_create.info_max = defalut;
      print(hq_set.css_mst_create.info_max);
      expect(hq_set.css_mst_create.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_mst_create.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00243_element_check_00220 **********\n\n");
    });

    test('00244_element_check_00221', () async {
      print("\n********** テスト実行：00244_element_check_00221 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.css_mst_create.info_01;
      print(hq_set.css_mst_create.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.css_mst_create.info_01 = testData1s;
      print(hq_set.css_mst_create.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.css_mst_create.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.css_mst_create.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.css_mst_create.info_01 = testData2s;
      print(hq_set.css_mst_create.info_01);
      expect(hq_set.css_mst_create.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_mst_create.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.css_mst_create.info_01 = defalut;
      print(hq_set.css_mst_create.info_01);
      expect(hq_set.css_mst_create.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.css_mst_create.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00244_element_check_00221 **********\n\n");
    });

    test('00245_element_check_00222', () async {
      print("\n********** テスト実行：00245_element_check_00222 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.cls_text_info.info_max;
      print(hq_set.cls_text_info.info_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.cls_text_info.info_max = testData1;
      print(hq_set.cls_text_info.info_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.cls_text_info.info_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.cls_text_info.info_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.cls_text_info.info_max = testData2;
      print(hq_set.cls_text_info.info_max);
      expect(hq_set.cls_text_info.info_max == testData2, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.cls_text_info.info_max = defalut;
      print(hq_set.cls_text_info.info_max);
      expect(hq_set.cls_text_info.info_max == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00245_element_check_00222 **********\n\n");
    });

    test('00246_element_check_00223', () async {
      print("\n********** テスト実行：00246_element_check_00223 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.cls_text_info.info_01;
      print(hq_set.cls_text_info.info_01);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.cls_text_info.info_01 = testData1s;
      print(hq_set.cls_text_info.info_01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.cls_text_info.info_01 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.cls_text_info.info_01 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.cls_text_info.info_01 = testData2s;
      print(hq_set.cls_text_info.info_01);
      expect(hq_set.cls_text_info.info_01 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_01 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.cls_text_info.info_01 = defalut;
      print(hq_set.cls_text_info.info_01);
      expect(hq_set.cls_text_info.info_01 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00246_element_check_00223 **********\n\n");
    });

    test('00247_element_check_00224', () async {
      print("\n********** テスト実行：00247_element_check_00224 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.cls_text_info.info_02;
      print(hq_set.cls_text_info.info_02);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.cls_text_info.info_02 = testData1s;
      print(hq_set.cls_text_info.info_02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.cls_text_info.info_02 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.cls_text_info.info_02 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.cls_text_info.info_02 = testData2s;
      print(hq_set.cls_text_info.info_02);
      expect(hq_set.cls_text_info.info_02 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_02 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.cls_text_info.info_02 = defalut;
      print(hq_set.cls_text_info.info_02);
      expect(hq_set.cls_text_info.info_02 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00247_element_check_00224 **********\n\n");
    });

    test('00248_element_check_00225', () async {
      print("\n********** テスト実行：00248_element_check_00225 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.cls_text_info.info_03;
      print(hq_set.cls_text_info.info_03);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.cls_text_info.info_03 = testData1s;
      print(hq_set.cls_text_info.info_03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.cls_text_info.info_03 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.cls_text_info.info_03 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.cls_text_info.info_03 = testData2s;
      print(hq_set.cls_text_info.info_03);
      expect(hq_set.cls_text_info.info_03 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_03 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.cls_text_info.info_03 = defalut;
      print(hq_set.cls_text_info.info_03);
      expect(hq_set.cls_text_info.info_03 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00248_element_check_00225 **********\n\n");
    });

    test('00249_element_check_00226', () async {
      print("\n********** テスト実行：00249_element_check_00226 **********");

      hq_set = Hq_setJsonFile();
      allPropatyCheckInit(hq_set);

      // ①loadを実行する。
      await hq_set.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = hq_set.cls_text_info.info_04;
      print(hq_set.cls_text_info.info_04);

      // ②指定したプロパティにテストデータ1を書き込む。
      hq_set.cls_text_info.info_04 = testData1s;
      print(hq_set.cls_text_info.info_04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(hq_set.cls_text_info.info_04 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await hq_set.save();
      await hq_set.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(hq_set.cls_text_info.info_04 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      hq_set.cls_text_info.info_04 = testData2s;
      print(hq_set.cls_text_info.info_04);
      expect(hq_set.cls_text_info.info_04 == testData2s, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_04 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      hq_set.cls_text_info.info_04 = defalut;
      print(hq_set.cls_text_info.info_04);
      expect(hq_set.cls_text_info.info_04 == defalut, true);
      await hq_set.save();
      await hq_set.load();
      expect(hq_set.cls_text_info.info_04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(hq_set, true);

      print("********** テスト終了：00249_element_check_00226 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Hq_setJsonFile test)
{
  expect(test.netDoA_counter.hqhist_cd_up, 0);
  expect(test.netDoA_counter.hqhist_cd_down, 0);
  expect(test.netDoA_counter.hqtmp_mst_cd_up, 0);
  expect(test.netDoA_counter.lgyoumu_serial_no, 0);
  expect(test.netDoA_counter.hqhist_date_up, "");
  expect(test.netDoA_counter.hqhist_date_down, "");
  expect(test.css_counter.TranS3_hist_cd, "");
  expect(test.hq_cmn_option.cnct_usb, 0);
  expect(test.hq_cmn_option.open_resend, 0);
  expect(test.hq_cmn_option.ts_lgyoumu, 0);
  expect(test.hq_cmn_option.gyoumu_suffix_digit, 0);
  expect(test.hq_cmn_option.gyoumu_charcode, 0);
  expect(test.hq_cmn_option.gyoumu_newline, 0);
  expect(test.hq_cmn_option.gyoumu_date_set, 0);
  expect(test.hq_cmn_option.gyoumu_day_name, 0);
  expect(test.hq_cmn_option.gyoumu_ment_tran, 0);
  expect(test.hq_cmn_option.gyoumu_cnv_tax_typ, 0);
  expect(test.hq_cmn_option.zero_gyoumu_nosend, 0);
  expect(test.hq_cmn_option.cnct_2nd, 0);
  expect(test.hq_cmn_option.timing_2nd, 0);
  expect(test.hq_cmn_option.sndrcv_1st, 0);
  expect(test.hq_cmn_option.sndrcv_2nd, 0);
  expect(test.hq_cmn_option.namechg_2nd, 0);
  expect(test.hq_down_cycle.value, 0);
  expect(test.hq_down_specify.value1, "");
  expect(test.hq_down_specify.value2, "");
  expect(test.hq_down_specify.value3, "");
  expect(test.hq_down_specify.value4, "");
  expect(test.hq_down_specify.value5, "");
  expect(test.hq_down_specify.value6, "");
  expect(test.hq_down_specify.value7, "");
  expect(test.hq_down_specify.value8, "");
  expect(test.hq_down_specify.value9, "");
  expect(test.hq_down_specify.value10, "");
  expect(test.hq_down_specify.value11, "");
  expect(test.hq_down_specify.value12, "");
  expect(test.hq_up_cycle.value, 0);
  expect(test.hq_up_specify.value1, "");
  expect(test.hq_up_specify.value2, "");
  expect(test.hq_up_specify.value3, "");
  expect(test.hq_up_specify.value4, "");
  expect(test.hq_up_specify.value5, "");
  expect(test.hq_up_specify.value6, "");
  expect(test.hq_up_specify.value7, "");
  expect(test.hq_up_specify.value8, "");
  expect(test.hq_up_specify.value9, "");
  expect(test.hq_up_specify.value10, "");
  expect(test.hq_up_specify.value11, "");
  expect(test.hq_up_specify.value12, "");
  expect(test.tran_info.css_tran11, "");
  expect(test.tran_info.css_tran12, "");
  expect(test.tran_info.css_tran13, "");
  expect(test.tran_info.css_tran15, "");
  expect(test.tran_info.css_tran21, "");
  expect(test.tran_info.css_tran22, "");
  expect(test.tran_info.css_tran24, "");
  expect(test.tran_info.css_tran25, "");
  expect(test.tran_info.css_tran26, "");
  expect(test.tran_info.css_tran27, "");
  expect(test.tran_info.css_tran28, "");
  expect(test.tran_info.css_tran29, "");
  expect(test.tran_info.css_tran2E, "");
  expect(test.tran_info.css_tran2F, "");
  expect(test.tran_info.css_tran55, "");
  expect(test.tran_info.css_tranT2, "");
  expect(test.tran_info.css_tranW3, "");
  expect(test.tran_info.css_tranW4, "");
  expect(test.tran_info.css_tranS3, "");
  expect(test.tran_info.css_tran8A, "");
  expect(test.tran_info.css_tran51_33, "");
  expect(test.tran_info.css_tran52_34, "");
  expect(test.tran_info.css_tran56_35, "");
  expect(test.tran_info.css_tran57_36, "");
  expect(test.tran_info.css_tran4A, "");
  expect(test.tran_info.css_tran4B, "");
  expect(test.tran_info.css_tran4C, "");
  expect(test.tran_info.css_tran76, "");
  expect(test.tran_info.css_tran73, "");
  expect(test.tran_info.css_tran71, "");
  expect(test.tran_info.css_tran72, "");
  expect(test.tran_info.css_tran7X, "");
  expect(test.tran_info.css_tranA1, "");
  expect(test.tran_info.css_tranA3, "");
  expect(test.tran_info.css_tranA4, "");
  expect(test.tran_info.css_tranA6, "");
  expect(test.tran_info.css_tranA7, "");
  expect(test.tran_info.css_tranA8, "");
  expect(test.tran_info.css_tranA9, "");
  expect(test.tran_info.css_tranC2, "");
  expect(test.tran_info.css_tranTL_IL, "");
  expect(test.tran_info.css_tranT3_I3, "");
  expect(test.hq_TLIL.useMax, 0);
  expect(test.hq_TLIL.Flag_001, 0);
  expect(test.hq_TLIL.Mode_001, 0);
  expect(test.hq_TLIL.Flag_002, 0);
  expect(test.hq_TLIL.Mode_002, 0);
  expect(test.hq_TLIL.Flag_003, 0);
  expect(test.hq_TLIL.Mode_003, 0);
  expect(test.hq_TLIL.Flag_004, 0);
  expect(test.hq_TLIL.Mode_004, 0);
  expect(test.hq_TLIL.Flag_005, 0);
  expect(test.hq_TLIL.Mode_005, 0);
  expect(test.hq_TLIL.Flag_006, 0);
  expect(test.hq_TLIL.Mode_006, 0);
  expect(test.hq_TLIL.Flag_007, 0);
  expect(test.hq_TLIL.Mode_007, 0);
  expect(test.hq_TLIL.Flag_008, 0);
  expect(test.hq_TLIL.Mode_008, 0);
  expect(test.hq_TLIL.Flag_009, 0);
  expect(test.hq_TLIL.Mode_009, 0);
  expect(test.netdoa_day_info.info_max, 0);
  expect(test.netdoa_day_info.info_01, "");
  expect(test.netdoa_day_info.info_02, "");
  expect(test.netdoa_day_info.info_03, "");
  expect(test.netdoa_day_info.info_04, "");
  expect(test.netdoa_day_info.info_05, "");
  expect(test.netdoa_day_info.info_06, "");
  expect(test.netdoa_day_info.info_07, "");
  expect(test.netdoa_day_info.info_08, "");
  expect(test.netdoa_day_info.info_09, "");
  expect(test.netdoa_day_info.info_10, "");
  expect(test.netdoa_day_info.info_11, "");
  expect(test.netdoa_day_info.info_12, "");
  expect(test.netdoa_day_info.info_13, "");
  expect(test.netdoa_day_info.info_14, "");
  expect(test.netdoa_day_info.info_15, "");
  expect(test.netdoa_day_info.info_16, "");
  expect(test.netdoa_day_info.info_17, "");
  expect(test.netdoa_day_info.info_18, "");
  expect(test.netdoa_day_info.info_19, "");
  expect(test.netdoa_day_info.info_20, "");
  expect(test.netdoa_day_info.info_21, "");
  expect(test.netdoa_cls_info.info_max, 0);
  expect(test.netdoa_cls_info.info_01, "");
  expect(test.netdoa_cls_info.info_02, "");
  expect(test.netdoa_cls_info.info_03, "");
  expect(test.netdoa_cls_info.info_04, "");
  expect(test.netdoa_cls_info.info_05, "");
  expect(test.netdoa_cls_info.info_06, "");
  expect(test.netdoa_cls_info.info_07, "");
  expect(test.netdoa_cls_info.info_08, "");
  expect(test.netdoa_cls_info.info_09, "");
  expect(test.netdoa_cls_info.info_10, "");
  expect(test.netdoa_cls_info.info_11, "");
  expect(test.netdoa_cls_info.info_12, "");
  expect(test.netdoa_cls_info.info_13, "");
  expect(test.netdoa_cls_info.info_14, "");
  expect(test.netdoa_cls_info.info_15, "");
  expect(test.netdoa_cls_info.info_16, "");
  expect(test.netdoa_cls_info.info_17, "");
  expect(test.netdoa_cls_info.info_18, "");
  expect(test.netdoa_cls_info.info_19, "");
  expect(test.netdoa_cls_info.info_20, "");
  expect(test.netdoa_cls_info.info_21, "");
  expect(test.netdoa_cls_info.info_22, "");
  expect(test.netdoa_cls_info.info_23, "");
  expect(test.netdoa_cls_info.info_24, "");
  expect(test.netdoa_cls_info.info_25, "");
  expect(test.netdoa_cls_info.info_26, "");
  expect(test.netdoa_cls_info.info_27, "");
  expect(test.netdoa_cls_info.info_28, "");
  expect(test.netdoa_cls_info.info_29, "");
  expect(test.netdoa_cls_info.info_30, "");
  expect(test.netdoa_ej_info.info_max, 0);
  expect(test.netdoa_ej_info.info_01, "");
  expect(test.ts_day_info.info_max, 0);
  expect(test.ts_day_info.info_01, "");
  expect(test.ts_cls_info.info_max, 0);
  expect(test.ts_cls_info.info_01, "");
  expect(test.netdoa_mstsend.info_max, 0);
  expect(test.netdoa_mstsend.info_01, "");
  expect(test.netdoa_mstsend.info_02, "");
  expect(test.netdoa_mstsend.info_03, "");
  expect(test.netdoa_mstsend.info_04, "");
  expect(test.netdoa_mstsend.info_05, "");
  expect(test.netdoa_mstsend.info_06, "");
  expect(test.netdoa_mstsend.info_07, "");
  expect(test.netdoa_mstsend.info_08, "");
  expect(test.netdoa_mstsend.info_09, "");
  expect(test.netdoa_mstsend.info_10, "");
  expect(test.netdoa_mstsend.info_11, "");
  expect(test.netdoa_mstsend.info_12, "");
  expect(test.netdoa_mstsend.info_13, "");
  expect(test.netdoa_mstsend.info_14, "");
  expect(test.netdoa_mstsend.info_15, "");
  expect(test.netdoa_mstsend.info_16, "");
  expect(test.netdoa_mstsend.info_17, "");
  expect(test.netdoa_mstsend.info_18, "");
  expect(test.netdoa_mstsend.info_19, "");
  expect(test.netdoa_mstsend.info_20, "");
  expect(test.netdoa_mstsend.info_21, "");
  expect(test.netdoa_mstsend.info_22, "");
  expect(test.netdoa_mstsend.info_23, "");
  expect(test.netdoa_mstsend.info_24, "");
  expect(test.netdoa_mstsend.info_25, "");
  expect(test.netdoa_mstsend.info_26, "");
  expect(test.netdoa_mstsend.info_27, "");
  expect(test.netdoa_mstsend.info_28, "");
  expect(test.netdoa_mstsend.info_29, "");
  expect(test.netdoa_mstsend.info_30, "");
  expect(test.netdoa_mstsend.info_31, "");
  expect(test.netdoa_mstsend.info_32, "");
  expect(test.netdoa_mstsend.info_33, "");
  expect(test.netdoa_mstsend.info_34, "");
  expect(test.netdoa_mstsend.info_35, "");
  expect(test.css_day_info.info_max, 0);
  expect(test.css_day_info.info_01, "");
  expect(test.css_day_info.info_02, "");
  expect(test.css_day_info.info_03, "");
  expect(test.css_day_info.info_04, "");
  expect(test.css_cls_info.info_max, 0);
  expect(test.css_cls_info.info_01, "");
  expect(test.css_cls_info.info_02, "");
  expect(test.css_cls_info.info_03, "");
  expect(test.css_cls_info.info_04, "");
  expect(test.css_cls_info.info_05, "");
  expect(test.css_cls_info.info_06, "");
  expect(test.css_odr_info.info_max, 0);
  expect(test.css_odr_info.info_01, "");
  expect(test.css_mst_create.info_max, 0);
  expect(test.css_mst_create.info_01, "");
  expect(test.cls_text_info.info_max, 0);
  expect(test.cls_text_info.info_01, "");
  expect(test.cls_text_info.info_02, "");
  expect(test.cls_text_info.info_03, "");
  expect(test.cls_text_info.info_04, "");
}

void allPropatyCheck(Hq_setJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.netDoA_counter.hqhist_cd_up, 0);
  }
  expect(test.netDoA_counter.hqhist_cd_down, 0);
  expect(test.netDoA_counter.hqtmp_mst_cd_up, 0);
  expect(test.netDoA_counter.lgyoumu_serial_no, 0);
  expect(test.netDoA_counter.hqhist_date_up, "0000-00-00 00:00:00");
  expect(test.netDoA_counter.hqhist_date_down, "0000-00-00 00:00:00");
  expect(test.css_counter.TranS3_hist_cd, "0,0");
  expect(test.hq_cmn_option.cnct_usb, 0);
  expect(test.hq_cmn_option.open_resend, 1);
  expect(test.hq_cmn_option.ts_lgyoumu, 1);
  expect(test.hq_cmn_option.gyoumu_suffix_digit, 0);
  expect(test.hq_cmn_option.gyoumu_charcode, 0);
  expect(test.hq_cmn_option.gyoumu_newline, 0);
  expect(test.hq_cmn_option.gyoumu_date_set, 0);
  expect(test.hq_cmn_option.gyoumu_day_name, 0);
  expect(test.hq_cmn_option.gyoumu_ment_tran, 0);
  expect(test.hq_cmn_option.gyoumu_cnv_tax_typ, 0);
  expect(test.hq_cmn_option.zero_gyoumu_nosend, 0);
  expect(test.hq_cmn_option.cnct_2nd, 0);
  expect(test.hq_cmn_option.timing_2nd, 1);
  expect(test.hq_cmn_option.sndrcv_1st, 0);
  expect(test.hq_cmn_option.sndrcv_2nd, 0);
  expect(test.hq_cmn_option.namechg_2nd, 0);
  expect(test.hq_down_cycle.value, 5);
  expect(test.hq_down_specify.value1, "");
  expect(test.hq_down_specify.value2, "");
  expect(test.hq_down_specify.value3, "");
  expect(test.hq_down_specify.value4, "");
  expect(test.hq_down_specify.value5, "");
  expect(test.hq_down_specify.value6, "");
  expect(test.hq_down_specify.value7, "");
  expect(test.hq_down_specify.value8, "");
  expect(test.hq_down_specify.value9, "");
  expect(test.hq_down_specify.value10, "");
  expect(test.hq_down_specify.value11, "");
  expect(test.hq_down_specify.value12, "");
  expect(test.hq_up_cycle.value, 15);
  expect(test.hq_up_specify.value1, "");
  expect(test.hq_up_specify.value2, "");
  expect(test.hq_up_specify.value3, "");
  expect(test.hq_up_specify.value4, "");
  expect(test.hq_up_specify.value5, "");
  expect(test.hq_up_specify.value6, "");
  expect(test.hq_up_specify.value7, "");
  expect(test.hq_up_specify.value8, "");
  expect(test.hq_up_specify.value9, "");
  expect(test.hq_up_specify.value10, "");
  expect(test.hq_up_specify.value11, "");
  expect(test.hq_up_specify.value12, "");
  expect(test.tran_info.css_tran11, "2,0");
  expect(test.tran_info.css_tran12, "1,0");
  expect(test.tran_info.css_tran13, "1,0");
  expect(test.tran_info.css_tran15, "1,0");
  expect(test.tran_info.css_tran21, "1,0");
  expect(test.tran_info.css_tran22, "2,0");
  expect(test.tran_info.css_tran24, "2,0");
  expect(test.tran_info.css_tran25, "2,0");
  expect(test.tran_info.css_tran26, "2,0");
  expect(test.tran_info.css_tran27, "1,0");
  expect(test.tran_info.css_tran28, "0,0");
  expect(test.tran_info.css_tran29, "1,0");
  expect(test.tran_info.css_tran2E, "0,0");
  expect(test.tran_info.css_tran2F, "0,0");
  expect(test.tran_info.css_tran55, "1,0");
  expect(test.tran_info.css_tranT2, "0,0");
  expect(test.tran_info.css_tranW3, "1,0");
  expect(test.tran_info.css_tranW4, "0,0");
  expect(test.tran_info.css_tranS3, "0,0");
  expect(test.tran_info.css_tran8A, "0,0");
  expect(test.tran_info.css_tran51_33, "0,0");
  expect(test.tran_info.css_tran52_34, "0,0");
  expect(test.tran_info.css_tran56_35, "0,0");
  expect(test.tran_info.css_tran57_36, "0,0");
  expect(test.tran_info.css_tran4A, "0,0");
  expect(test.tran_info.css_tran4B, "0,0");
  expect(test.tran_info.css_tran4C, "0,0");
  expect(test.tran_info.css_tran76, "1,0");
  expect(test.tran_info.css_tran73, "1,0");
  expect(test.tran_info.css_tran71, "1,0");
  expect(test.tran_info.css_tran72, "1,0");
  expect(test.tran_info.css_tran7X, "0,0");
  expect(test.tran_info.css_tranA1, "0,0");
  expect(test.tran_info.css_tranA3, "0,0");
  expect(test.tran_info.css_tranA4, "0,0");
  expect(test.tran_info.css_tranA6, "0,0");
  expect(test.tran_info.css_tranA7, "0,0");
  expect(test.tran_info.css_tranA8, "0,0");
  expect(test.tran_info.css_tranA9, "0,0");
  expect(test.tran_info.css_tranC2, "0,0");
  expect(test.tran_info.css_tranTL_IL, "-1,0");
  expect(test.tran_info.css_tranT3_I3, "-1,0");
  expect(test.hq_TLIL.useMax, 9);
  expect(test.hq_TLIL.Flag_001, 1);
  expect(test.hq_TLIL.Mode_001, 1);
  expect(test.hq_TLIL.Flag_002, 1);
  expect(test.hq_TLIL.Mode_002, 3);
  expect(test.hq_TLIL.Flag_003, 1);
  expect(test.hq_TLIL.Mode_003, 4);
  expect(test.hq_TLIL.Flag_004, 0);
  expect(test.hq_TLIL.Mode_004, 60);
  expect(test.hq_TLIL.Flag_005, 1);
  expect(test.hq_TLIL.Mode_005, 61);
  expect(test.hq_TLIL.Flag_006, 0);
  expect(test.hq_TLIL.Mode_006, 63);
  expect(test.hq_TLIL.Flag_007, 1);
  expect(test.hq_TLIL.Mode_007, 81);
  expect(test.hq_TLIL.Flag_008, 0);
  expect(test.hq_TLIL.Mode_008, 83);
  expect(test.hq_TLIL.Flag_009, 0);
  expect(test.hq_TLIL.Mode_009, 11);
  expect(test.netdoa_day_info.info_max, 21);
  expect(test.netdoa_day_info.info_01, "1,3,reg_dly_deal");
  expect(test.netdoa_day_info.info_02, "1,3,reg_dly_flow");
  expect(test.netdoa_day_info.info_03, "1,3,reg_dly_plu");
  expect(test.netdoa_day_info.info_04, "1,3,reg_dly_acr");
  expect(test.netdoa_day_info.info_05, "1,3,reg_dly_brgn");
  expect(test.netdoa_day_info.info_06, "1,3,reg_dly_mach");
  expect(test.netdoa_day_info.info_07, "1,4,version.json");
  expect(test.netdoa_day_info.info_08, "1,4,hq_set.json");
  expect(test.netdoa_day_info.info_09, "1,3,reg_dly_mdl");
  expect(test.netdoa_day_info.info_10, "1,3,reg_dly_sml");
  expect(test.netdoa_day_info.info_11, "1,5,LGYOUMU");
  expect(test.netdoa_day_info.info_12, "0,2,c_ej_log");
  expect(test.netdoa_day_info.info_13, "0,2,c_data_log");
  expect(test.netdoa_day_info.info_14, "0,2,c_status_log");
  expect(test.netdoa_day_info.info_15, "0,2,c_header_log");
  expect(test.netdoa_day_info.info_16, "1,3,reg_dly_cdpayflow");
  expect(test.netdoa_day_info.info_17, "1,1,rdly_deal_hour");
  expect(test.netdoa_day_info.info_18, "1,7,business_file");
  expect(test.netdoa_day_info.info_19, "1,3,reg_dly_tax_deal");
  expect(test.netdoa_day_info.info_20, "1,12,log/hist_err.sql");
  expect(test.netdoa_day_info.info_21, "1,11,OGYOUMU");
  expect(test.netdoa_cls_info.info_max, 30);
  expect(test.netdoa_cls_info.info_01, "1,3,reg_dly_deal");
  expect(test.netdoa_cls_info.info_02, "1,3,reg_dly_flow");
  expect(test.netdoa_cls_info.info_03, "1,3,reg_dly_plu");
  expect(test.netdoa_cls_info.info_04, "1,3,reg_dly_acr");
  expect(test.netdoa_cls_info.info_05, "1,3,reg_dly_brgn");
  expect(test.netdoa_cls_info.info_06, "1,3,reg_dly_mach");
  expect(test.netdoa_cls_info.info_07, "1,4,version.json");
  expect(test.netdoa_cls_info.info_08, "1,4,hq_set.json");
  expect(test.netdoa_cls_info.info_09, "1,3,reg_dly_mdl");
  expect(test.netdoa_cls_info.info_10, "1,3,reg_dly_sml");
  expect(test.netdoa_cls_info.info_11, "1,5,LGYOUMU");
  expect(test.netdoa_cls_info.info_12, "1,4,sys.json");
  expect(test.netdoa_cls_info.info_13, "1,1,c_cls_mst");
  expect(test.netdoa_cls_info.info_14, "1,1,s_brgn_mst");
  expect(test.netdoa_cls_info.info_15, "1,1,s_bdlitem_mst");
  expect(test.netdoa_cls_info.info_16, "1,1,s_bdlsch_mst");
  expect(test.netdoa_cls_info.info_17, "1,1,s_stmitem_mst");
  expect(test.netdoa_cls_info.info_18, "1,1,s_stmsch_mst");
  expect(test.netdoa_cls_info.info_19, "0,2,c_ej_log");
  expect(test.netdoa_cls_info.info_20, "0,2,c_data_log");
  expect(test.netdoa_cls_info.info_21, "0,2,c_status_log");
  expect(test.netdoa_cls_info.info_22, "0,2,c_header_log");
  expect(test.netdoa_cls_info.info_23, "1,3,reg_dly_cdpayflow");
  expect(test.netdoa_cls_info.info_24, "1,1,rdly_deal_hour");
  expect(test.netdoa_cls_info.info_25, "1,7,business_file");
  expect(test.netdoa_cls_info.info_26, "1,3,reg_dly_tax_deal");
  expect(test.netdoa_cls_info.info_27, "0,9,ATTENDTIME");
  expect(test.netdoa_cls_info.info_28, "1,12,log/hist_err.sql");
  expect(test.netdoa_cls_info.info_29, "1,1,s_cust_ttl_tbl");
  expect(test.netdoa_cls_info.info_30, "1,11,OGYOUMU");
  expect(test.netdoa_ej_info.info_max, 1);
  expect(test.netdoa_ej_info.info_01, "1,2,c_ej_log");
  expect(test.ts_day_info.info_max, 1);
  expect(test.ts_day_info.info_01, "1,5,LGYOUMU");
  expect(test.ts_cls_info.info_max, 1);
  expect(test.ts_cls_info.info_01, "1,5,LGYOUMU");
  expect(test.netdoa_mstsend.info_max, 35);
  expect(test.netdoa_mstsend.info_01, "0,1,c_cls_mst");
  expect(test.netdoa_mstsend.info_02, "0,1,c_plu_mst");
  expect(test.netdoa_mstsend.info_03, "0,1,s_brgn_mst");
  expect(test.netdoa_mstsend.info_04, "0,1,s_bdlsch_mst");
  expect(test.netdoa_mstsend.info_05, "0,1,s_bdlitem_mst");
  expect(test.netdoa_mstsend.info_06, "0,1,s_stmsch_mst");
  expect(test.netdoa_mstsend.info_07, "0,1,s_stmitem_mst");
  expect(test.netdoa_mstsend.info_08, "0,1,c_img_mst");
  expect(test.netdoa_mstsend.info_09, "0,1,c_preset_mst");
  expect(test.netdoa_mstsend.info_10, "0,1,c_tax_mst");
  expect(test.netdoa_mstsend.info_11, "0,1,c_instre_mst");
  expect(test.netdoa_mstsend.info_12, "0,1,c_staff_mst");
  expect(test.netdoa_mstsend.info_13, "0,1,c_staffauth_mst");
  expect(test.netdoa_mstsend.info_14, "0,1,c_keyauth_mst");
  expect(test.netdoa_mstsend.info_15, "0,1,c_menuauth_mst");
  expect(test.netdoa_mstsend.info_16, "0,1,c_operationauth_mst");
  expect(test.netdoa_mstsend.info_17, "0,1,c_keyfnc_mst");
  expect(test.netdoa_mstsend.info_18, "0,1,c_keyopt_mst");
  expect(test.netdoa_mstsend.info_19, "0,1,c_producer_mst");
  expect(test.netdoa_mstsend.info_20, "0,1,c_divide_mst");
  expect(test.netdoa_mstsend.info_21, "0,1,c_msg_mst");
  expect(test.netdoa_mstsend.info_22, "0,1,c_msglayout_mst");
  expect(test.netdoa_mstsend.info_23, "0,1,c_msgsch_mst");
  expect(test.netdoa_mstsend.info_24, "0,1,c_msgsch_layout_mst");
  expect(test.netdoa_mstsend.info_25, "0,1,c_appl_grp_mst");
  expect(test.netdoa_mstsend.info_26, "0,1,c_keykind_mst");
  expect(test.netdoa_mstsend.info_27, "0,1,c_keykind_grp_mst");
  expect(test.netdoa_mstsend.info_28, "0,1,c_operation_mst");
  expect(test.netdoa_mstsend.info_29, "0,1,c_keyopt_set_mst");
  expect(test.netdoa_mstsend.info_30, "0,1,c_keyopt_sub_mst");
  expect(test.netdoa_mstsend.info_31, "0,1,c_scanplu_mst");
  expect(test.netdoa_mstsend.info_32, "0,1,p_promsch_mst");
  expect(test.netdoa_mstsend.info_33, "0,1,p_promitem_mst");
  expect(test.netdoa_mstsend.info_34, "0,1,c_loypln_mst");
  expect(test.netdoa_mstsend.info_35, "0,1,c_loyplu_mst");
  expect(test.css_day_info.info_max, 4);
  expect(test.css_day_info.info_01, "1,6,RGYOUMU");
  expect(test.css_day_info.info_02, "1,10,CGYOUMU");
  expect(test.css_day_info.info_03, "1,5,LGYOUMU");
  expect(test.css_day_info.info_04, "1,11,OGYOUMU");
  expect(test.css_cls_info.info_max, 6);
  expect(test.css_cls_info.info_01, "1,6,RGYOUMU");
  expect(test.css_cls_info.info_02, "1,10,CGYOUMU");
  expect(test.css_cls_info.info_03, "1,14,IGYOUMU");
  expect(test.css_cls_info.info_04, "1,15,DGYOUMU");
  expect(test.css_cls_info.info_05, "1,5,LGYOUMU");
  expect(test.css_cls_info.info_06, "1,11,OGYOUMU");
  expect(test.css_odr_info.info_max, 1);
  expect(test.css_odr_info.info_01, "1,8,HGYOUMU");
  expect(test.css_mst_create.info_max, 1);
  expect(test.css_mst_create.info_01, "1,13,AGYOUMU");
  expect(test.cls_text_info.info_max, 4);
  expect(test.cls_text_info.info_01, "0,2,c_ej_log");
  expect(test.cls_text_info.info_02, "0,2,c_data_log");
  expect(test.cls_text_info.info_03, "0,2,c_status_log");
  expect(test.cls_text_info.info_04, "0,2,c_header_log");
}

