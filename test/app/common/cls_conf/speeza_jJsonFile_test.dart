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
import '../../../../lib/app/common/cls_conf/speeza_jJsonFile.dart';

late Speeza_jJsonFile speeza_j;

void main(){
  speeza_jJsonFile_test();
}

void speeza_jJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "speeza_j.json";
  const String section = "common";
  const String key = "page_max";
  const defaultData = 10;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Speeza_jJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Speeza_jJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Speeza_jJsonFile().setDefault();
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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await speeza_j.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(speeza_j,true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        speeza_j.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await speeza_j.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(speeza_j,true);

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
      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①：loadを実行する。
      await speeza_j.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = speeza_j.common.page_max;
      speeza_j.common.page_max = testData1;
      expect(speeza_j.common.page_max == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await speeza_j.load();
      expect(speeza_j.common.page_max != testData1, true);
      expect(speeza_j.common.page_max == prefixData, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = speeza_j.common.page_max;
      speeza_j.common.page_max = testData1;
      expect(speeza_j.common.page_max, testData1);

      // ③saveを実行する。
      await speeza_j.save();

      // ④loadを実行する。
      await speeza_j.load();

      expect(speeza_j.common.page_max != prefixData, true);
      expect(speeza_j.common.page_max == testData1, true);
      allPropatyCheck(speeza_j,false);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await speeza_j.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await speeza_j.save();

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await speeza_j.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(speeza_j.common.page_max, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = speeza_j.common.page_max;
      speeza_j.common.page_max = testData1;

      // ③ saveを実行する。
      await speeza_j.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(speeza_j.common.page_max, testData1);

      // ④ loadを実行する。
      await speeza_j.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(speeza_j.common.page_max == testData1, true);
      allPropatyCheck(speeza_j,false);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await speeza_j.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(speeza_j,true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②任意のプロパティの値を変更する。
      speeza_j.common.page_max = testData1;
      expect(speeza_j.common.page_max, testData1);

      // ③saveを実行する。
      await speeza_j.save();
      expect(speeza_j.common.page_max, testData1);

      // ④loadを実行する。
      await speeza_j.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(speeza_j,true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await speeza_j.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await speeza_j.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(speeza_j.common.page_max == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await speeza_j.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await speeza_j.setValueWithName(section, "test_key", testData1);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②任意のプロパティを変更する。
      speeza_j.common.page_max = testData1;

      // ③saveを実行する。
      await speeza_j.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await speeza_j.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②任意のプロパティを変更する。
      speeza_j.common.page_max = testData1;

      // ③saveを実行する。
      await speeza_j.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await speeza_j.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②任意のプロパティを変更する。
      speeza_j.common.page_max = testData1;

      // ③saveを実行する。
      await speeza_j.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await speeza_j.getValueWithName(section, "test_key");
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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await speeza_j.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      speeza_j.common.page_max = testData1;
      expect(speeza_j.common.page_max, testData1);

      // ④saveを実行する。
      await speeza_j.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(speeza_j.common.page_max, testData1);
      
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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await speeza_j.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      expect(speeza_j.common.page_max == testData1, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await speeza_j.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      expect(speeza_j.common.page_max == testData2, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await speeza_j.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      expect(speeza_j.common.page_max == testData1, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await speeza_j.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      expect(speeza_j.common.page_max == testData2, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await speeza_j.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      expect(speeza_j.common.page_max == testData1, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await speeza_j.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      expect(speeza_j.common.page_max == testData1, true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await speeza_j.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      allPropatyCheck(speeza_j,true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await speeza_j.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + speeza_j.common.page_max.toString());
      allPropatyCheck(speeza_j,true);

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

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.common.page_max;
      print(speeza_j.common.page_max);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.common.page_max = testData1;
      print(speeza_j.common.page_max);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.common.page_max == testData1, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.common.page_max == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.common.page_max = testData2;
      print(speeza_j.common.page_max);
      expect(speeza_j.common.page_max == testData2, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.common.page_max == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.common.page_max = defalut;
      print(speeza_j.common.page_max);
      expect(speeza_j.common.page_max == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.common.page_max == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.title;
      print(speeza_j.screen0.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.title = testData1s;
      print(speeza_j.screen0.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.title = testData2s;
      print(speeza_j.screen0.title);
      expect(speeza_j.screen0.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.title = defalut;
      print(speeza_j.screen0.title);
      expect(speeza_j.screen0.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line1;
      print(speeza_j.screen0.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line1 = testData1s;
      print(speeza_j.screen0.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line1 = testData2s;
      print(speeza_j.screen0.line1);
      expect(speeza_j.screen0.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line1 = defalut;
      print(speeza_j.screen0.line1);
      expect(speeza_j.screen0.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line2;
      print(speeza_j.screen0.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line2 = testData1s;
      print(speeza_j.screen0.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line2 = testData2s;
      print(speeza_j.screen0.line2);
      expect(speeza_j.screen0.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line2 = defalut;
      print(speeza_j.screen0.line2);
      expect(speeza_j.screen0.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line1_ex;
      print(speeza_j.screen0.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line1_ex = testData1s;
      print(speeza_j.screen0.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line1_ex = testData2s;
      print(speeza_j.screen0.line1_ex);
      expect(speeza_j.screen0.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line1_ex = defalut;
      print(speeza_j.screen0.line1_ex);
      expect(speeza_j.screen0.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line2_ex;
      print(speeza_j.screen0.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line2_ex = testData1s;
      print(speeza_j.screen0.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line2_ex = testData2s;
      print(speeza_j.screen0.line2_ex);
      expect(speeza_j.screen0.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line2_ex = defalut;
      print(speeza_j.screen0.line2_ex);
      expect(speeza_j.screen0.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line1_cn;
      print(speeza_j.screen0.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line1_cn = testData1s;
      print(speeza_j.screen0.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line1_cn = testData2s;
      print(speeza_j.screen0.line1_cn);
      expect(speeza_j.screen0.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line1_cn = defalut;
      print(speeza_j.screen0.line1_cn);
      expect(speeza_j.screen0.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line2_cn;
      print(speeza_j.screen0.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line2_cn = testData1s;
      print(speeza_j.screen0.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line2_cn = testData2s;
      print(speeza_j.screen0.line2_cn);
      expect(speeza_j.screen0.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line2_cn = defalut;
      print(speeza_j.screen0.line2_cn);
      expect(speeza_j.screen0.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line1_kor;
      print(speeza_j.screen0.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line1_kor = testData1s;
      print(speeza_j.screen0.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line1_kor = testData2s;
      print(speeza_j.screen0.line1_kor);
      expect(speeza_j.screen0.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line1_kor = defalut;
      print(speeza_j.screen0.line1_kor);
      expect(speeza_j.screen0.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.line2_kor;
      print(speeza_j.screen0.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.line2_kor = testData1s;
      print(speeza_j.screen0.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.line2_kor = testData2s;
      print(speeza_j.screen0.line2_kor);
      expect(speeza_j.screen0.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.line2_kor = defalut;
      print(speeza_j.screen0.line2_kor);
      expect(speeza_j.screen0.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg1;
      print(speeza_j.screen0.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg1 = testData1s;
      print(speeza_j.screen0.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg1 = testData2s;
      print(speeza_j.screen0.msg1);
      expect(speeza_j.screen0.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg1 = defalut;
      print(speeza_j.screen0.msg1);
      expect(speeza_j.screen0.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg2;
      print(speeza_j.screen0.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg2 = testData1s;
      print(speeza_j.screen0.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg2 = testData2s;
      print(speeza_j.screen0.msg2);
      expect(speeza_j.screen0.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg2 = defalut;
      print(speeza_j.screen0.msg2);
      expect(speeza_j.screen0.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg3;
      print(speeza_j.screen0.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg3 = testData1s;
      print(speeza_j.screen0.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg3 = testData2s;
      print(speeza_j.screen0.msg3);
      expect(speeza_j.screen0.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg3 = defalut;
      print(speeza_j.screen0.msg3);
      expect(speeza_j.screen0.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg4;
      print(speeza_j.screen0.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg4 = testData1s;
      print(speeza_j.screen0.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg4 = testData2s;
      print(speeza_j.screen0.msg4);
      expect(speeza_j.screen0.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg4 = defalut;
      print(speeza_j.screen0.msg4);
      expect(speeza_j.screen0.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg1_ex;
      print(speeza_j.screen0.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg1_ex = testData1s;
      print(speeza_j.screen0.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg1_ex = testData2s;
      print(speeza_j.screen0.msg1_ex);
      expect(speeza_j.screen0.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg1_ex = defalut;
      print(speeza_j.screen0.msg1_ex);
      expect(speeza_j.screen0.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg2_ex;
      print(speeza_j.screen0.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg2_ex = testData1s;
      print(speeza_j.screen0.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg2_ex = testData2s;
      print(speeza_j.screen0.msg2_ex);
      expect(speeza_j.screen0.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg2_ex = defalut;
      print(speeza_j.screen0.msg2_ex);
      expect(speeza_j.screen0.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg3_ex;
      print(speeza_j.screen0.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg3_ex = testData1s;
      print(speeza_j.screen0.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg3_ex = testData2s;
      print(speeza_j.screen0.msg3_ex);
      expect(speeza_j.screen0.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg3_ex = defalut;
      print(speeza_j.screen0.msg3_ex);
      expect(speeza_j.screen0.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg4_ex;
      print(speeza_j.screen0.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg4_ex = testData1s;
      print(speeza_j.screen0.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg4_ex = testData2s;
      print(speeza_j.screen0.msg4_ex);
      expect(speeza_j.screen0.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg4_ex = defalut;
      print(speeza_j.screen0.msg4_ex);
      expect(speeza_j.screen0.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg1_cn;
      print(speeza_j.screen0.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg1_cn = testData1s;
      print(speeza_j.screen0.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg1_cn = testData2s;
      print(speeza_j.screen0.msg1_cn);
      expect(speeza_j.screen0.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg1_cn = defalut;
      print(speeza_j.screen0.msg1_cn);
      expect(speeza_j.screen0.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg2_cn;
      print(speeza_j.screen0.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg2_cn = testData1s;
      print(speeza_j.screen0.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg2_cn = testData2s;
      print(speeza_j.screen0.msg2_cn);
      expect(speeza_j.screen0.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg2_cn = defalut;
      print(speeza_j.screen0.msg2_cn);
      expect(speeza_j.screen0.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg3_cn;
      print(speeza_j.screen0.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg3_cn = testData1s;
      print(speeza_j.screen0.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg3_cn = testData2s;
      print(speeza_j.screen0.msg3_cn);
      expect(speeza_j.screen0.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg3_cn = defalut;
      print(speeza_j.screen0.msg3_cn);
      expect(speeza_j.screen0.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg4_cn;
      print(speeza_j.screen0.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg4_cn = testData1s;
      print(speeza_j.screen0.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg4_cn = testData2s;
      print(speeza_j.screen0.msg4_cn);
      expect(speeza_j.screen0.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg4_cn = defalut;
      print(speeza_j.screen0.msg4_cn);
      expect(speeza_j.screen0.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg1_kor;
      print(speeza_j.screen0.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg1_kor = testData1s;
      print(speeza_j.screen0.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg1_kor = testData2s;
      print(speeza_j.screen0.msg1_kor);
      expect(speeza_j.screen0.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg1_kor = defalut;
      print(speeza_j.screen0.msg1_kor);
      expect(speeza_j.screen0.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg2_kor;
      print(speeza_j.screen0.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg2_kor = testData1s;
      print(speeza_j.screen0.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg2_kor = testData2s;
      print(speeza_j.screen0.msg2_kor);
      expect(speeza_j.screen0.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg2_kor = defalut;
      print(speeza_j.screen0.msg2_kor);
      expect(speeza_j.screen0.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg3_kor;
      print(speeza_j.screen0.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg3_kor = testData1s;
      print(speeza_j.screen0.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg3_kor = testData2s;
      print(speeza_j.screen0.msg3_kor);
      expect(speeza_j.screen0.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg3_kor = defalut;
      print(speeza_j.screen0.msg3_kor);
      expect(speeza_j.screen0.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.msg4_kor;
      print(speeza_j.screen0.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.msg4_kor = testData1s;
      print(speeza_j.screen0.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.msg4_kor = testData2s;
      print(speeza_j.screen0.msg4_kor);
      expect(speeza_j.screen0.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.msg4_kor = defalut;
      print(speeza_j.screen0.msg4_kor);
      expect(speeza_j.screen0.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc1;
      print(speeza_j.screen0.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc1 = testData1s;
      print(speeza_j.screen0.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc1 = testData2s;
      print(speeza_j.screen0.etc1);
      expect(speeza_j.screen0.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc1 = defalut;
      print(speeza_j.screen0.etc1);
      expect(speeza_j.screen0.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc2;
      print(speeza_j.screen0.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc2 = testData1s;
      print(speeza_j.screen0.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc2 = testData2s;
      print(speeza_j.screen0.etc2);
      expect(speeza_j.screen0.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc2 = defalut;
      print(speeza_j.screen0.etc2);
      expect(speeza_j.screen0.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc3;
      print(speeza_j.screen0.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc3 = testData1s;
      print(speeza_j.screen0.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc3 = testData2s;
      print(speeza_j.screen0.etc3);
      expect(speeza_j.screen0.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc3 = defalut;
      print(speeza_j.screen0.etc3);
      expect(speeza_j.screen0.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc4;
      print(speeza_j.screen0.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc4 = testData1s;
      print(speeza_j.screen0.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc4 = testData2s;
      print(speeza_j.screen0.etc4);
      expect(speeza_j.screen0.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc4 = defalut;
      print(speeza_j.screen0.etc4);
      expect(speeza_j.screen0.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc5;
      print(speeza_j.screen0.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc5 = testData1s;
      print(speeza_j.screen0.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc5 = testData2s;
      print(speeza_j.screen0.etc5);
      expect(speeza_j.screen0.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc5 = defalut;
      print(speeza_j.screen0.etc5);
      expect(speeza_j.screen0.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc1_ex;
      print(speeza_j.screen0.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc1_ex = testData1s;
      print(speeza_j.screen0.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc1_ex = testData2s;
      print(speeza_j.screen0.etc1_ex);
      expect(speeza_j.screen0.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc1_ex = defalut;
      print(speeza_j.screen0.etc1_ex);
      expect(speeza_j.screen0.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc2_ex;
      print(speeza_j.screen0.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc2_ex = testData1s;
      print(speeza_j.screen0.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc2_ex = testData2s;
      print(speeza_j.screen0.etc2_ex);
      expect(speeza_j.screen0.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc2_ex = defalut;
      print(speeza_j.screen0.etc2_ex);
      expect(speeza_j.screen0.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc3_ex;
      print(speeza_j.screen0.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc3_ex = testData1s;
      print(speeza_j.screen0.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc3_ex = testData2s;
      print(speeza_j.screen0.etc3_ex);
      expect(speeza_j.screen0.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc3_ex = defalut;
      print(speeza_j.screen0.etc3_ex);
      expect(speeza_j.screen0.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc4_ex;
      print(speeza_j.screen0.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc4_ex = testData1s;
      print(speeza_j.screen0.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc4_ex = testData2s;
      print(speeza_j.screen0.etc4_ex);
      expect(speeza_j.screen0.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc4_ex = defalut;
      print(speeza_j.screen0.etc4_ex);
      expect(speeza_j.screen0.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc5_ex;
      print(speeza_j.screen0.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc5_ex = testData1s;
      print(speeza_j.screen0.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc5_ex = testData2s;
      print(speeza_j.screen0.etc5_ex);
      expect(speeza_j.screen0.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc5_ex = defalut;
      print(speeza_j.screen0.etc5_ex);
      expect(speeza_j.screen0.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc1_cn;
      print(speeza_j.screen0.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc1_cn = testData1s;
      print(speeza_j.screen0.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc1_cn = testData2s;
      print(speeza_j.screen0.etc1_cn);
      expect(speeza_j.screen0.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc1_cn = defalut;
      print(speeza_j.screen0.etc1_cn);
      expect(speeza_j.screen0.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc2_cn;
      print(speeza_j.screen0.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc2_cn = testData1s;
      print(speeza_j.screen0.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc2_cn = testData2s;
      print(speeza_j.screen0.etc2_cn);
      expect(speeza_j.screen0.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc2_cn = defalut;
      print(speeza_j.screen0.etc2_cn);
      expect(speeza_j.screen0.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc3_cn;
      print(speeza_j.screen0.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc3_cn = testData1s;
      print(speeza_j.screen0.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc3_cn = testData2s;
      print(speeza_j.screen0.etc3_cn);
      expect(speeza_j.screen0.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc3_cn = defalut;
      print(speeza_j.screen0.etc3_cn);
      expect(speeza_j.screen0.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc4_cn;
      print(speeza_j.screen0.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc4_cn = testData1s;
      print(speeza_j.screen0.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc4_cn = testData2s;
      print(speeza_j.screen0.etc4_cn);
      expect(speeza_j.screen0.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc4_cn = defalut;
      print(speeza_j.screen0.etc4_cn);
      expect(speeza_j.screen0.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc5_cn;
      print(speeza_j.screen0.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc5_cn = testData1s;
      print(speeza_j.screen0.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc5_cn = testData2s;
      print(speeza_j.screen0.etc5_cn);
      expect(speeza_j.screen0.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc5_cn = defalut;
      print(speeza_j.screen0.etc5_cn);
      expect(speeza_j.screen0.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc1_kor;
      print(speeza_j.screen0.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc1_kor = testData1s;
      print(speeza_j.screen0.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc1_kor = testData2s;
      print(speeza_j.screen0.etc1_kor);
      expect(speeza_j.screen0.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc1_kor = defalut;
      print(speeza_j.screen0.etc1_kor);
      expect(speeza_j.screen0.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc2_kor;
      print(speeza_j.screen0.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc2_kor = testData1s;
      print(speeza_j.screen0.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc2_kor = testData2s;
      print(speeza_j.screen0.etc2_kor);
      expect(speeza_j.screen0.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc2_kor = defalut;
      print(speeza_j.screen0.etc2_kor);
      expect(speeza_j.screen0.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc3_kor;
      print(speeza_j.screen0.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc3_kor = testData1s;
      print(speeza_j.screen0.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc3_kor = testData2s;
      print(speeza_j.screen0.etc3_kor);
      expect(speeza_j.screen0.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc3_kor = defalut;
      print(speeza_j.screen0.etc3_kor);
      expect(speeza_j.screen0.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc4_kor;
      print(speeza_j.screen0.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc4_kor = testData1s;
      print(speeza_j.screen0.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc4_kor = testData2s;
      print(speeza_j.screen0.etc4_kor);
      expect(speeza_j.screen0.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc4_kor = defalut;
      print(speeza_j.screen0.etc4_kor);
      expect(speeza_j.screen0.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen0.etc5_kor;
      print(speeza_j.screen0.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen0.etc5_kor = testData1s;
      print(speeza_j.screen0.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen0.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen0.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen0.etc5_kor = testData2s;
      print(speeza_j.screen0.etc5_kor);
      expect(speeza_j.screen0.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen0.etc5_kor = defalut;
      print(speeza_j.screen0.etc5_kor);
      expect(speeza_j.screen0.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen0.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.title;
      print(speeza_j.screen1.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.title = testData1s;
      print(speeza_j.screen1.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.title = testData2s;
      print(speeza_j.screen1.title);
      expect(speeza_j.screen1.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.title = defalut;
      print(speeza_j.screen1.title);
      expect(speeza_j.screen1.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line1;
      print(speeza_j.screen1.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line1 = testData1s;
      print(speeza_j.screen1.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line1 = testData2s;
      print(speeza_j.screen1.line1);
      expect(speeza_j.screen1.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line1 = defalut;
      print(speeza_j.screen1.line1);
      expect(speeza_j.screen1.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line2;
      print(speeza_j.screen1.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line2 = testData1s;
      print(speeza_j.screen1.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line2 = testData2s;
      print(speeza_j.screen1.line2);
      expect(speeza_j.screen1.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line2 = defalut;
      print(speeza_j.screen1.line2);
      expect(speeza_j.screen1.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line1_ex;
      print(speeza_j.screen1.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line1_ex = testData1s;
      print(speeza_j.screen1.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line1_ex = testData2s;
      print(speeza_j.screen1.line1_ex);
      expect(speeza_j.screen1.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line1_ex = defalut;
      print(speeza_j.screen1.line1_ex);
      expect(speeza_j.screen1.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line2_ex;
      print(speeza_j.screen1.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line2_ex = testData1s;
      print(speeza_j.screen1.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line2_ex = testData2s;
      print(speeza_j.screen1.line2_ex);
      expect(speeza_j.screen1.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line2_ex = defalut;
      print(speeza_j.screen1.line2_ex);
      expect(speeza_j.screen1.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line1_cn;
      print(speeza_j.screen1.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line1_cn = testData1s;
      print(speeza_j.screen1.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line1_cn = testData2s;
      print(speeza_j.screen1.line1_cn);
      expect(speeza_j.screen1.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line1_cn = defalut;
      print(speeza_j.screen1.line1_cn);
      expect(speeza_j.screen1.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line2_cn;
      print(speeza_j.screen1.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line2_cn = testData1s;
      print(speeza_j.screen1.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line2_cn = testData2s;
      print(speeza_j.screen1.line2_cn);
      expect(speeza_j.screen1.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line2_cn = defalut;
      print(speeza_j.screen1.line2_cn);
      expect(speeza_j.screen1.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line1_kor;
      print(speeza_j.screen1.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line1_kor = testData1s;
      print(speeza_j.screen1.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line1_kor = testData2s;
      print(speeza_j.screen1.line1_kor);
      expect(speeza_j.screen1.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line1_kor = defalut;
      print(speeza_j.screen1.line1_kor);
      expect(speeza_j.screen1.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.line2_kor;
      print(speeza_j.screen1.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.line2_kor = testData1s;
      print(speeza_j.screen1.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.line2_kor = testData2s;
      print(speeza_j.screen1.line2_kor);
      expect(speeza_j.screen1.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.line2_kor = defalut;
      print(speeza_j.screen1.line2_kor);
      expect(speeza_j.screen1.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg1;
      print(speeza_j.screen1.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg1 = testData1s;
      print(speeza_j.screen1.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg1 = testData2s;
      print(speeza_j.screen1.msg1);
      expect(speeza_j.screen1.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg1 = defalut;
      print(speeza_j.screen1.msg1);
      expect(speeza_j.screen1.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg2;
      print(speeza_j.screen1.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg2 = testData1s;
      print(speeza_j.screen1.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg2 = testData2s;
      print(speeza_j.screen1.msg2);
      expect(speeza_j.screen1.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg2 = defalut;
      print(speeza_j.screen1.msg2);
      expect(speeza_j.screen1.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg3;
      print(speeza_j.screen1.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg3 = testData1s;
      print(speeza_j.screen1.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg3 = testData2s;
      print(speeza_j.screen1.msg3);
      expect(speeza_j.screen1.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg3 = defalut;
      print(speeza_j.screen1.msg3);
      expect(speeza_j.screen1.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg4;
      print(speeza_j.screen1.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg4 = testData1s;
      print(speeza_j.screen1.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg4 = testData2s;
      print(speeza_j.screen1.msg4);
      expect(speeza_j.screen1.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg4 = defalut;
      print(speeza_j.screen1.msg4);
      expect(speeza_j.screen1.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg1_ex;
      print(speeza_j.screen1.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg1_ex = testData1s;
      print(speeza_j.screen1.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg1_ex = testData2s;
      print(speeza_j.screen1.msg1_ex);
      expect(speeza_j.screen1.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg1_ex = defalut;
      print(speeza_j.screen1.msg1_ex);
      expect(speeza_j.screen1.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg2_ex;
      print(speeza_j.screen1.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg2_ex = testData1s;
      print(speeza_j.screen1.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg2_ex = testData2s;
      print(speeza_j.screen1.msg2_ex);
      expect(speeza_j.screen1.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg2_ex = defalut;
      print(speeza_j.screen1.msg2_ex);
      expect(speeza_j.screen1.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg3_ex;
      print(speeza_j.screen1.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg3_ex = testData1s;
      print(speeza_j.screen1.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg3_ex = testData2s;
      print(speeza_j.screen1.msg3_ex);
      expect(speeza_j.screen1.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg3_ex = defalut;
      print(speeza_j.screen1.msg3_ex);
      expect(speeza_j.screen1.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg4_ex;
      print(speeza_j.screen1.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg4_ex = testData1s;
      print(speeza_j.screen1.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg4_ex = testData2s;
      print(speeza_j.screen1.msg4_ex);
      expect(speeza_j.screen1.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg4_ex = defalut;
      print(speeza_j.screen1.msg4_ex);
      expect(speeza_j.screen1.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg1_cn;
      print(speeza_j.screen1.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg1_cn = testData1s;
      print(speeza_j.screen1.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg1_cn = testData2s;
      print(speeza_j.screen1.msg1_cn);
      expect(speeza_j.screen1.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg1_cn = defalut;
      print(speeza_j.screen1.msg1_cn);
      expect(speeza_j.screen1.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg2_cn;
      print(speeza_j.screen1.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg2_cn = testData1s;
      print(speeza_j.screen1.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg2_cn = testData2s;
      print(speeza_j.screen1.msg2_cn);
      expect(speeza_j.screen1.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg2_cn = defalut;
      print(speeza_j.screen1.msg2_cn);
      expect(speeza_j.screen1.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg3_cn;
      print(speeza_j.screen1.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg3_cn = testData1s;
      print(speeza_j.screen1.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg3_cn = testData2s;
      print(speeza_j.screen1.msg3_cn);
      expect(speeza_j.screen1.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg3_cn = defalut;
      print(speeza_j.screen1.msg3_cn);
      expect(speeza_j.screen1.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg4_cn;
      print(speeza_j.screen1.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg4_cn = testData1s;
      print(speeza_j.screen1.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg4_cn = testData2s;
      print(speeza_j.screen1.msg4_cn);
      expect(speeza_j.screen1.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg4_cn = defalut;
      print(speeza_j.screen1.msg4_cn);
      expect(speeza_j.screen1.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg1_kor;
      print(speeza_j.screen1.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg1_kor = testData1s;
      print(speeza_j.screen1.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg1_kor = testData2s;
      print(speeza_j.screen1.msg1_kor);
      expect(speeza_j.screen1.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg1_kor = defalut;
      print(speeza_j.screen1.msg1_kor);
      expect(speeza_j.screen1.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg2_kor;
      print(speeza_j.screen1.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg2_kor = testData1s;
      print(speeza_j.screen1.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg2_kor = testData2s;
      print(speeza_j.screen1.msg2_kor);
      expect(speeza_j.screen1.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg2_kor = defalut;
      print(speeza_j.screen1.msg2_kor);
      expect(speeza_j.screen1.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg3_kor;
      print(speeza_j.screen1.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg3_kor = testData1s;
      print(speeza_j.screen1.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg3_kor = testData2s;
      print(speeza_j.screen1.msg3_kor);
      expect(speeza_j.screen1.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg3_kor = defalut;
      print(speeza_j.screen1.msg3_kor);
      expect(speeza_j.screen1.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.msg4_kor;
      print(speeza_j.screen1.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.msg4_kor = testData1s;
      print(speeza_j.screen1.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.msg4_kor = testData2s;
      print(speeza_j.screen1.msg4_kor);
      expect(speeza_j.screen1.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.msg4_kor = defalut;
      print(speeza_j.screen1.msg4_kor);
      expect(speeza_j.screen1.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc1;
      print(speeza_j.screen1.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc1 = testData1s;
      print(speeza_j.screen1.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc1 = testData2s;
      print(speeza_j.screen1.etc1);
      expect(speeza_j.screen1.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc1 = defalut;
      print(speeza_j.screen1.etc1);
      expect(speeza_j.screen1.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc2;
      print(speeza_j.screen1.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc2 = testData1s;
      print(speeza_j.screen1.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc2 = testData2s;
      print(speeza_j.screen1.etc2);
      expect(speeza_j.screen1.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc2 = defalut;
      print(speeza_j.screen1.etc2);
      expect(speeza_j.screen1.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc3;
      print(speeza_j.screen1.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc3 = testData1s;
      print(speeza_j.screen1.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc3 = testData2s;
      print(speeza_j.screen1.etc3);
      expect(speeza_j.screen1.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc3 = defalut;
      print(speeza_j.screen1.etc3);
      expect(speeza_j.screen1.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc4;
      print(speeza_j.screen1.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc4 = testData1s;
      print(speeza_j.screen1.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc4 = testData2s;
      print(speeza_j.screen1.etc4);
      expect(speeza_j.screen1.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc4 = defalut;
      print(speeza_j.screen1.etc4);
      expect(speeza_j.screen1.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc5;
      print(speeza_j.screen1.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc5 = testData1s;
      print(speeza_j.screen1.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc5 = testData2s;
      print(speeza_j.screen1.etc5);
      expect(speeza_j.screen1.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc5 = defalut;
      print(speeza_j.screen1.etc5);
      expect(speeza_j.screen1.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc1_ex;
      print(speeza_j.screen1.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc1_ex = testData1s;
      print(speeza_j.screen1.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc1_ex = testData2s;
      print(speeza_j.screen1.etc1_ex);
      expect(speeza_j.screen1.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc1_ex = defalut;
      print(speeza_j.screen1.etc1_ex);
      expect(speeza_j.screen1.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc2_ex;
      print(speeza_j.screen1.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc2_ex = testData1s;
      print(speeza_j.screen1.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc2_ex = testData2s;
      print(speeza_j.screen1.etc2_ex);
      expect(speeza_j.screen1.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc2_ex = defalut;
      print(speeza_j.screen1.etc2_ex);
      expect(speeza_j.screen1.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc3_ex;
      print(speeza_j.screen1.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc3_ex = testData1s;
      print(speeza_j.screen1.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc3_ex = testData2s;
      print(speeza_j.screen1.etc3_ex);
      expect(speeza_j.screen1.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc3_ex = defalut;
      print(speeza_j.screen1.etc3_ex);
      expect(speeza_j.screen1.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc4_ex;
      print(speeza_j.screen1.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc4_ex = testData1s;
      print(speeza_j.screen1.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc4_ex = testData2s;
      print(speeza_j.screen1.etc4_ex);
      expect(speeza_j.screen1.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc4_ex = defalut;
      print(speeza_j.screen1.etc4_ex);
      expect(speeza_j.screen1.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc5_ex;
      print(speeza_j.screen1.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc5_ex = testData1s;
      print(speeza_j.screen1.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc5_ex = testData2s;
      print(speeza_j.screen1.etc5_ex);
      expect(speeza_j.screen1.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc5_ex = defalut;
      print(speeza_j.screen1.etc5_ex);
      expect(speeza_j.screen1.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc1_cn;
      print(speeza_j.screen1.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc1_cn = testData1s;
      print(speeza_j.screen1.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc1_cn = testData2s;
      print(speeza_j.screen1.etc1_cn);
      expect(speeza_j.screen1.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc1_cn = defalut;
      print(speeza_j.screen1.etc1_cn);
      expect(speeza_j.screen1.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc2_cn;
      print(speeza_j.screen1.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc2_cn = testData1s;
      print(speeza_j.screen1.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc2_cn = testData2s;
      print(speeza_j.screen1.etc2_cn);
      expect(speeza_j.screen1.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc2_cn = defalut;
      print(speeza_j.screen1.etc2_cn);
      expect(speeza_j.screen1.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc3_cn;
      print(speeza_j.screen1.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc3_cn = testData1s;
      print(speeza_j.screen1.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc3_cn = testData2s;
      print(speeza_j.screen1.etc3_cn);
      expect(speeza_j.screen1.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc3_cn = defalut;
      print(speeza_j.screen1.etc3_cn);
      expect(speeza_j.screen1.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc4_cn;
      print(speeza_j.screen1.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc4_cn = testData1s;
      print(speeza_j.screen1.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc4_cn = testData2s;
      print(speeza_j.screen1.etc4_cn);
      expect(speeza_j.screen1.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc4_cn = defalut;
      print(speeza_j.screen1.etc4_cn);
      expect(speeza_j.screen1.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc5_cn;
      print(speeza_j.screen1.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc5_cn = testData1s;
      print(speeza_j.screen1.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc5_cn = testData2s;
      print(speeza_j.screen1.etc5_cn);
      expect(speeza_j.screen1.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc5_cn = defalut;
      print(speeza_j.screen1.etc5_cn);
      expect(speeza_j.screen1.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc1_kor;
      print(speeza_j.screen1.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc1_kor = testData1s;
      print(speeza_j.screen1.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc1_kor = testData2s;
      print(speeza_j.screen1.etc1_kor);
      expect(speeza_j.screen1.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc1_kor = defalut;
      print(speeza_j.screen1.etc1_kor);
      expect(speeza_j.screen1.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc2_kor;
      print(speeza_j.screen1.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc2_kor = testData1s;
      print(speeza_j.screen1.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc2_kor = testData2s;
      print(speeza_j.screen1.etc2_kor);
      expect(speeza_j.screen1.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc2_kor = defalut;
      print(speeza_j.screen1.etc2_kor);
      expect(speeza_j.screen1.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc3_kor;
      print(speeza_j.screen1.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc3_kor = testData1s;
      print(speeza_j.screen1.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc3_kor = testData2s;
      print(speeza_j.screen1.etc3_kor);
      expect(speeza_j.screen1.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc3_kor = defalut;
      print(speeza_j.screen1.etc3_kor);
      expect(speeza_j.screen1.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc4_kor;
      print(speeza_j.screen1.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc4_kor = testData1s;
      print(speeza_j.screen1.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc4_kor = testData2s;
      print(speeza_j.screen1.etc4_kor);
      expect(speeza_j.screen1.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc4_kor = defalut;
      print(speeza_j.screen1.etc4_kor);
      expect(speeza_j.screen1.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen1.etc5_kor;
      print(speeza_j.screen1.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen1.etc5_kor = testData1s;
      print(speeza_j.screen1.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen1.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen1.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen1.etc5_kor = testData2s;
      print(speeza_j.screen1.etc5_kor);
      expect(speeza_j.screen1.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen1.etc5_kor = defalut;
      print(speeza_j.screen1.etc5_kor);
      expect(speeza_j.screen1.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen1.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.title;
      print(speeza_j.screen2.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.title = testData1s;
      print(speeza_j.screen2.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.title = testData2s;
      print(speeza_j.screen2.title);
      expect(speeza_j.screen2.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.title = defalut;
      print(speeza_j.screen2.title);
      expect(speeza_j.screen2.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line1;
      print(speeza_j.screen2.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line1 = testData1s;
      print(speeza_j.screen2.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line1 = testData2s;
      print(speeza_j.screen2.line1);
      expect(speeza_j.screen2.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line1 = defalut;
      print(speeza_j.screen2.line1);
      expect(speeza_j.screen2.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line2;
      print(speeza_j.screen2.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line2 = testData1s;
      print(speeza_j.screen2.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line2 = testData2s;
      print(speeza_j.screen2.line2);
      expect(speeza_j.screen2.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line2 = defalut;
      print(speeza_j.screen2.line2);
      expect(speeza_j.screen2.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line1_ex;
      print(speeza_j.screen2.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line1_ex = testData1s;
      print(speeza_j.screen2.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line1_ex = testData2s;
      print(speeza_j.screen2.line1_ex);
      expect(speeza_j.screen2.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line1_ex = defalut;
      print(speeza_j.screen2.line1_ex);
      expect(speeza_j.screen2.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line2_ex;
      print(speeza_j.screen2.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line2_ex = testData1s;
      print(speeza_j.screen2.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line2_ex = testData2s;
      print(speeza_j.screen2.line2_ex);
      expect(speeza_j.screen2.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line2_ex = defalut;
      print(speeza_j.screen2.line2_ex);
      expect(speeza_j.screen2.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line1_cn;
      print(speeza_j.screen2.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line1_cn = testData1s;
      print(speeza_j.screen2.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line1_cn = testData2s;
      print(speeza_j.screen2.line1_cn);
      expect(speeza_j.screen2.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line1_cn = defalut;
      print(speeza_j.screen2.line1_cn);
      expect(speeza_j.screen2.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line2_cn;
      print(speeza_j.screen2.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line2_cn = testData1s;
      print(speeza_j.screen2.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line2_cn = testData2s;
      print(speeza_j.screen2.line2_cn);
      expect(speeza_j.screen2.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line2_cn = defalut;
      print(speeza_j.screen2.line2_cn);
      expect(speeza_j.screen2.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line1_kor;
      print(speeza_j.screen2.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line1_kor = testData1s;
      print(speeza_j.screen2.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line1_kor = testData2s;
      print(speeza_j.screen2.line1_kor);
      expect(speeza_j.screen2.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line1_kor = defalut;
      print(speeza_j.screen2.line1_kor);
      expect(speeza_j.screen2.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.line2_kor;
      print(speeza_j.screen2.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.line2_kor = testData1s;
      print(speeza_j.screen2.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.line2_kor = testData2s;
      print(speeza_j.screen2.line2_kor);
      expect(speeza_j.screen2.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.line2_kor = defalut;
      print(speeza_j.screen2.line2_kor);
      expect(speeza_j.screen2.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg1;
      print(speeza_j.screen2.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg1 = testData1s;
      print(speeza_j.screen2.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg1 = testData2s;
      print(speeza_j.screen2.msg1);
      expect(speeza_j.screen2.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg1 = defalut;
      print(speeza_j.screen2.msg1);
      expect(speeza_j.screen2.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg2;
      print(speeza_j.screen2.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg2 = testData1s;
      print(speeza_j.screen2.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg2 = testData2s;
      print(speeza_j.screen2.msg2);
      expect(speeza_j.screen2.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg2 = defalut;
      print(speeza_j.screen2.msg2);
      expect(speeza_j.screen2.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg3;
      print(speeza_j.screen2.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg3 = testData1s;
      print(speeza_j.screen2.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg3 = testData2s;
      print(speeza_j.screen2.msg3);
      expect(speeza_j.screen2.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg3 = defalut;
      print(speeza_j.screen2.msg3);
      expect(speeza_j.screen2.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg4;
      print(speeza_j.screen2.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg4 = testData1s;
      print(speeza_j.screen2.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg4 = testData2s;
      print(speeza_j.screen2.msg4);
      expect(speeza_j.screen2.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg4 = defalut;
      print(speeza_j.screen2.msg4);
      expect(speeza_j.screen2.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg1_ex;
      print(speeza_j.screen2.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg1_ex = testData1s;
      print(speeza_j.screen2.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg1_ex = testData2s;
      print(speeza_j.screen2.msg1_ex);
      expect(speeza_j.screen2.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg1_ex = defalut;
      print(speeza_j.screen2.msg1_ex);
      expect(speeza_j.screen2.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg2_ex;
      print(speeza_j.screen2.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg2_ex = testData1s;
      print(speeza_j.screen2.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg2_ex = testData2s;
      print(speeza_j.screen2.msg2_ex);
      expect(speeza_j.screen2.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg2_ex = defalut;
      print(speeza_j.screen2.msg2_ex);
      expect(speeza_j.screen2.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg3_ex;
      print(speeza_j.screen2.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg3_ex = testData1s;
      print(speeza_j.screen2.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg3_ex = testData2s;
      print(speeza_j.screen2.msg3_ex);
      expect(speeza_j.screen2.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg3_ex = defalut;
      print(speeza_j.screen2.msg3_ex);
      expect(speeza_j.screen2.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg4_ex;
      print(speeza_j.screen2.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg4_ex = testData1s;
      print(speeza_j.screen2.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg4_ex = testData2s;
      print(speeza_j.screen2.msg4_ex);
      expect(speeza_j.screen2.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg4_ex = defalut;
      print(speeza_j.screen2.msg4_ex);
      expect(speeza_j.screen2.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg1_cn;
      print(speeza_j.screen2.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg1_cn = testData1s;
      print(speeza_j.screen2.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg1_cn = testData2s;
      print(speeza_j.screen2.msg1_cn);
      expect(speeza_j.screen2.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg1_cn = defalut;
      print(speeza_j.screen2.msg1_cn);
      expect(speeza_j.screen2.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg2_cn;
      print(speeza_j.screen2.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg2_cn = testData1s;
      print(speeza_j.screen2.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg2_cn = testData2s;
      print(speeza_j.screen2.msg2_cn);
      expect(speeza_j.screen2.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg2_cn = defalut;
      print(speeza_j.screen2.msg2_cn);
      expect(speeza_j.screen2.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg3_cn;
      print(speeza_j.screen2.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg3_cn = testData1s;
      print(speeza_j.screen2.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg3_cn = testData2s;
      print(speeza_j.screen2.msg3_cn);
      expect(speeza_j.screen2.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg3_cn = defalut;
      print(speeza_j.screen2.msg3_cn);
      expect(speeza_j.screen2.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg4_cn;
      print(speeza_j.screen2.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg4_cn = testData1s;
      print(speeza_j.screen2.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg4_cn = testData2s;
      print(speeza_j.screen2.msg4_cn);
      expect(speeza_j.screen2.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg4_cn = defalut;
      print(speeza_j.screen2.msg4_cn);
      expect(speeza_j.screen2.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg1_kor;
      print(speeza_j.screen2.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg1_kor = testData1s;
      print(speeza_j.screen2.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg1_kor = testData2s;
      print(speeza_j.screen2.msg1_kor);
      expect(speeza_j.screen2.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg1_kor = defalut;
      print(speeza_j.screen2.msg1_kor);
      expect(speeza_j.screen2.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg2_kor;
      print(speeza_j.screen2.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg2_kor = testData1s;
      print(speeza_j.screen2.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg2_kor = testData2s;
      print(speeza_j.screen2.msg2_kor);
      expect(speeza_j.screen2.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg2_kor = defalut;
      print(speeza_j.screen2.msg2_kor);
      expect(speeza_j.screen2.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg3_kor;
      print(speeza_j.screen2.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg3_kor = testData1s;
      print(speeza_j.screen2.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg3_kor = testData2s;
      print(speeza_j.screen2.msg3_kor);
      expect(speeza_j.screen2.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg3_kor = defalut;
      print(speeza_j.screen2.msg3_kor);
      expect(speeza_j.screen2.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.msg4_kor;
      print(speeza_j.screen2.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.msg4_kor = testData1s;
      print(speeza_j.screen2.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.msg4_kor = testData2s;
      print(speeza_j.screen2.msg4_kor);
      expect(speeza_j.screen2.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.msg4_kor = defalut;
      print(speeza_j.screen2.msg4_kor);
      expect(speeza_j.screen2.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc1;
      print(speeza_j.screen2.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc1 = testData1s;
      print(speeza_j.screen2.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc1 = testData2s;
      print(speeza_j.screen2.etc1);
      expect(speeza_j.screen2.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc1 = defalut;
      print(speeza_j.screen2.etc1);
      expect(speeza_j.screen2.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc2;
      print(speeza_j.screen2.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc2 = testData1s;
      print(speeza_j.screen2.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc2 = testData2s;
      print(speeza_j.screen2.etc2);
      expect(speeza_j.screen2.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc2 = defalut;
      print(speeza_j.screen2.etc2);
      expect(speeza_j.screen2.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc3;
      print(speeza_j.screen2.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc3 = testData1s;
      print(speeza_j.screen2.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc3 = testData2s;
      print(speeza_j.screen2.etc3);
      expect(speeza_j.screen2.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc3 = defalut;
      print(speeza_j.screen2.etc3);
      expect(speeza_j.screen2.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc4;
      print(speeza_j.screen2.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc4 = testData1s;
      print(speeza_j.screen2.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc4 = testData2s;
      print(speeza_j.screen2.etc4);
      expect(speeza_j.screen2.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc4 = defalut;
      print(speeza_j.screen2.etc4);
      expect(speeza_j.screen2.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc5;
      print(speeza_j.screen2.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc5 = testData1s;
      print(speeza_j.screen2.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc5 = testData2s;
      print(speeza_j.screen2.etc5);
      expect(speeza_j.screen2.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc5 = defalut;
      print(speeza_j.screen2.etc5);
      expect(speeza_j.screen2.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc1_ex;
      print(speeza_j.screen2.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc1_ex = testData1s;
      print(speeza_j.screen2.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc1_ex = testData2s;
      print(speeza_j.screen2.etc1_ex);
      expect(speeza_j.screen2.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc1_ex = defalut;
      print(speeza_j.screen2.etc1_ex);
      expect(speeza_j.screen2.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc2_ex;
      print(speeza_j.screen2.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc2_ex = testData1s;
      print(speeza_j.screen2.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc2_ex = testData2s;
      print(speeza_j.screen2.etc2_ex);
      expect(speeza_j.screen2.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc2_ex = defalut;
      print(speeza_j.screen2.etc2_ex);
      expect(speeza_j.screen2.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc3_ex;
      print(speeza_j.screen2.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc3_ex = testData1s;
      print(speeza_j.screen2.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc3_ex = testData2s;
      print(speeza_j.screen2.etc3_ex);
      expect(speeza_j.screen2.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc3_ex = defalut;
      print(speeza_j.screen2.etc3_ex);
      expect(speeza_j.screen2.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc4_ex;
      print(speeza_j.screen2.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc4_ex = testData1s;
      print(speeza_j.screen2.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc4_ex = testData2s;
      print(speeza_j.screen2.etc4_ex);
      expect(speeza_j.screen2.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc4_ex = defalut;
      print(speeza_j.screen2.etc4_ex);
      expect(speeza_j.screen2.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc5_ex;
      print(speeza_j.screen2.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc5_ex = testData1s;
      print(speeza_j.screen2.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc5_ex = testData2s;
      print(speeza_j.screen2.etc5_ex);
      expect(speeza_j.screen2.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc5_ex = defalut;
      print(speeza_j.screen2.etc5_ex);
      expect(speeza_j.screen2.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc1_cn;
      print(speeza_j.screen2.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc1_cn = testData1s;
      print(speeza_j.screen2.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc1_cn = testData2s;
      print(speeza_j.screen2.etc1_cn);
      expect(speeza_j.screen2.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc1_cn = defalut;
      print(speeza_j.screen2.etc1_cn);
      expect(speeza_j.screen2.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc2_cn;
      print(speeza_j.screen2.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc2_cn = testData1s;
      print(speeza_j.screen2.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc2_cn = testData2s;
      print(speeza_j.screen2.etc2_cn);
      expect(speeza_j.screen2.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc2_cn = defalut;
      print(speeza_j.screen2.etc2_cn);
      expect(speeza_j.screen2.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc3_cn;
      print(speeza_j.screen2.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc3_cn = testData1s;
      print(speeza_j.screen2.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc3_cn = testData2s;
      print(speeza_j.screen2.etc3_cn);
      expect(speeza_j.screen2.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc3_cn = defalut;
      print(speeza_j.screen2.etc3_cn);
      expect(speeza_j.screen2.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc4_cn;
      print(speeza_j.screen2.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc4_cn = testData1s;
      print(speeza_j.screen2.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc4_cn = testData2s;
      print(speeza_j.screen2.etc4_cn);
      expect(speeza_j.screen2.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc4_cn = defalut;
      print(speeza_j.screen2.etc4_cn);
      expect(speeza_j.screen2.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc5_cn;
      print(speeza_j.screen2.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc5_cn = testData1s;
      print(speeza_j.screen2.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc5_cn = testData2s;
      print(speeza_j.screen2.etc5_cn);
      expect(speeza_j.screen2.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc5_cn = defalut;
      print(speeza_j.screen2.etc5_cn);
      expect(speeza_j.screen2.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc1_kor;
      print(speeza_j.screen2.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc1_kor = testData1s;
      print(speeza_j.screen2.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc1_kor = testData2s;
      print(speeza_j.screen2.etc1_kor);
      expect(speeza_j.screen2.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc1_kor = defalut;
      print(speeza_j.screen2.etc1_kor);
      expect(speeza_j.screen2.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc2_kor;
      print(speeza_j.screen2.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc2_kor = testData1s;
      print(speeza_j.screen2.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc2_kor = testData2s;
      print(speeza_j.screen2.etc2_kor);
      expect(speeza_j.screen2.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc2_kor = defalut;
      print(speeza_j.screen2.etc2_kor);
      expect(speeza_j.screen2.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc3_kor;
      print(speeza_j.screen2.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc3_kor = testData1s;
      print(speeza_j.screen2.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc3_kor = testData2s;
      print(speeza_j.screen2.etc3_kor);
      expect(speeza_j.screen2.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc3_kor = defalut;
      print(speeza_j.screen2.etc3_kor);
      expect(speeza_j.screen2.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc4_kor;
      print(speeza_j.screen2.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc4_kor = testData1s;
      print(speeza_j.screen2.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc4_kor = testData2s;
      print(speeza_j.screen2.etc4_kor);
      expect(speeza_j.screen2.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc4_kor = defalut;
      print(speeza_j.screen2.etc4_kor);
      expect(speeza_j.screen2.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen2.etc5_kor;
      print(speeza_j.screen2.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen2.etc5_kor = testData1s;
      print(speeza_j.screen2.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen2.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen2.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen2.etc5_kor = testData2s;
      print(speeza_j.screen2.etc5_kor);
      expect(speeza_j.screen2.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen2.etc5_kor = defalut;
      print(speeza_j.screen2.etc5_kor);
      expect(speeza_j.screen2.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen2.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.title;
      print(speeza_j.screen3.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.title = testData1s;
      print(speeza_j.screen3.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.title = testData2s;
      print(speeza_j.screen3.title);
      expect(speeza_j.screen3.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.title = defalut;
      print(speeza_j.screen3.title);
      expect(speeza_j.screen3.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line1;
      print(speeza_j.screen3.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line1 = testData1s;
      print(speeza_j.screen3.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line1 = testData2s;
      print(speeza_j.screen3.line1);
      expect(speeza_j.screen3.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line1 = defalut;
      print(speeza_j.screen3.line1);
      expect(speeza_j.screen3.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line2;
      print(speeza_j.screen3.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line2 = testData1s;
      print(speeza_j.screen3.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line2 = testData2s;
      print(speeza_j.screen3.line2);
      expect(speeza_j.screen3.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line2 = defalut;
      print(speeza_j.screen3.line2);
      expect(speeza_j.screen3.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line1_ex;
      print(speeza_j.screen3.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line1_ex = testData1s;
      print(speeza_j.screen3.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line1_ex = testData2s;
      print(speeza_j.screen3.line1_ex);
      expect(speeza_j.screen3.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line1_ex = defalut;
      print(speeza_j.screen3.line1_ex);
      expect(speeza_j.screen3.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line2_ex;
      print(speeza_j.screen3.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line2_ex = testData1s;
      print(speeza_j.screen3.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line2_ex = testData2s;
      print(speeza_j.screen3.line2_ex);
      expect(speeza_j.screen3.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line2_ex = defalut;
      print(speeza_j.screen3.line2_ex);
      expect(speeza_j.screen3.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line1_cn;
      print(speeza_j.screen3.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line1_cn = testData1s;
      print(speeza_j.screen3.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line1_cn = testData2s;
      print(speeza_j.screen3.line1_cn);
      expect(speeza_j.screen3.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line1_cn = defalut;
      print(speeza_j.screen3.line1_cn);
      expect(speeza_j.screen3.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line2_cn;
      print(speeza_j.screen3.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line2_cn = testData1s;
      print(speeza_j.screen3.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line2_cn = testData2s;
      print(speeza_j.screen3.line2_cn);
      expect(speeza_j.screen3.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line2_cn = defalut;
      print(speeza_j.screen3.line2_cn);
      expect(speeza_j.screen3.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line1_kor;
      print(speeza_j.screen3.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line1_kor = testData1s;
      print(speeza_j.screen3.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line1_kor = testData2s;
      print(speeza_j.screen3.line1_kor);
      expect(speeza_j.screen3.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line1_kor = defalut;
      print(speeza_j.screen3.line1_kor);
      expect(speeza_j.screen3.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.line2_kor;
      print(speeza_j.screen3.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.line2_kor = testData1s;
      print(speeza_j.screen3.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.line2_kor = testData2s;
      print(speeza_j.screen3.line2_kor);
      expect(speeza_j.screen3.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.line2_kor = defalut;
      print(speeza_j.screen3.line2_kor);
      expect(speeza_j.screen3.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg1;
      print(speeza_j.screen3.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg1 = testData1s;
      print(speeza_j.screen3.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg1 = testData2s;
      print(speeza_j.screen3.msg1);
      expect(speeza_j.screen3.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg1 = defalut;
      print(speeza_j.screen3.msg1);
      expect(speeza_j.screen3.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg2;
      print(speeza_j.screen3.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg2 = testData1s;
      print(speeza_j.screen3.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg2 = testData2s;
      print(speeza_j.screen3.msg2);
      expect(speeza_j.screen3.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg2 = defalut;
      print(speeza_j.screen3.msg2);
      expect(speeza_j.screen3.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg3;
      print(speeza_j.screen3.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg3 = testData1s;
      print(speeza_j.screen3.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg3 = testData2s;
      print(speeza_j.screen3.msg3);
      expect(speeza_j.screen3.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg3 = defalut;
      print(speeza_j.screen3.msg3);
      expect(speeza_j.screen3.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg4;
      print(speeza_j.screen3.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg4 = testData1s;
      print(speeza_j.screen3.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg4 = testData2s;
      print(speeza_j.screen3.msg4);
      expect(speeza_j.screen3.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg4 = defalut;
      print(speeza_j.screen3.msg4);
      expect(speeza_j.screen3.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg1_ex;
      print(speeza_j.screen3.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg1_ex = testData1s;
      print(speeza_j.screen3.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg1_ex = testData2s;
      print(speeza_j.screen3.msg1_ex);
      expect(speeza_j.screen3.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg1_ex = defalut;
      print(speeza_j.screen3.msg1_ex);
      expect(speeza_j.screen3.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg2_ex;
      print(speeza_j.screen3.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg2_ex = testData1s;
      print(speeza_j.screen3.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg2_ex = testData2s;
      print(speeza_j.screen3.msg2_ex);
      expect(speeza_j.screen3.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg2_ex = defalut;
      print(speeza_j.screen3.msg2_ex);
      expect(speeza_j.screen3.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg3_ex;
      print(speeza_j.screen3.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg3_ex = testData1s;
      print(speeza_j.screen3.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg3_ex = testData2s;
      print(speeza_j.screen3.msg3_ex);
      expect(speeza_j.screen3.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg3_ex = defalut;
      print(speeza_j.screen3.msg3_ex);
      expect(speeza_j.screen3.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg4_ex;
      print(speeza_j.screen3.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg4_ex = testData1s;
      print(speeza_j.screen3.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg4_ex = testData2s;
      print(speeza_j.screen3.msg4_ex);
      expect(speeza_j.screen3.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg4_ex = defalut;
      print(speeza_j.screen3.msg4_ex);
      expect(speeza_j.screen3.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg1_cn;
      print(speeza_j.screen3.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg1_cn = testData1s;
      print(speeza_j.screen3.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg1_cn = testData2s;
      print(speeza_j.screen3.msg1_cn);
      expect(speeza_j.screen3.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg1_cn = defalut;
      print(speeza_j.screen3.msg1_cn);
      expect(speeza_j.screen3.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg2_cn;
      print(speeza_j.screen3.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg2_cn = testData1s;
      print(speeza_j.screen3.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg2_cn = testData2s;
      print(speeza_j.screen3.msg2_cn);
      expect(speeza_j.screen3.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg2_cn = defalut;
      print(speeza_j.screen3.msg2_cn);
      expect(speeza_j.screen3.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg3_cn;
      print(speeza_j.screen3.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg3_cn = testData1s;
      print(speeza_j.screen3.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg3_cn = testData2s;
      print(speeza_j.screen3.msg3_cn);
      expect(speeza_j.screen3.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg3_cn = defalut;
      print(speeza_j.screen3.msg3_cn);
      expect(speeza_j.screen3.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg4_cn;
      print(speeza_j.screen3.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg4_cn = testData1s;
      print(speeza_j.screen3.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg4_cn = testData2s;
      print(speeza_j.screen3.msg4_cn);
      expect(speeza_j.screen3.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg4_cn = defalut;
      print(speeza_j.screen3.msg4_cn);
      expect(speeza_j.screen3.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg1_kor;
      print(speeza_j.screen3.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg1_kor = testData1s;
      print(speeza_j.screen3.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg1_kor = testData2s;
      print(speeza_j.screen3.msg1_kor);
      expect(speeza_j.screen3.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg1_kor = defalut;
      print(speeza_j.screen3.msg1_kor);
      expect(speeza_j.screen3.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg2_kor;
      print(speeza_j.screen3.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg2_kor = testData1s;
      print(speeza_j.screen3.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg2_kor = testData2s;
      print(speeza_j.screen3.msg2_kor);
      expect(speeza_j.screen3.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg2_kor = defalut;
      print(speeza_j.screen3.msg2_kor);
      expect(speeza_j.screen3.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg3_kor;
      print(speeza_j.screen3.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg3_kor = testData1s;
      print(speeza_j.screen3.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg3_kor = testData2s;
      print(speeza_j.screen3.msg3_kor);
      expect(speeza_j.screen3.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg3_kor = defalut;
      print(speeza_j.screen3.msg3_kor);
      expect(speeza_j.screen3.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.msg4_kor;
      print(speeza_j.screen3.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.msg4_kor = testData1s;
      print(speeza_j.screen3.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.msg4_kor = testData2s;
      print(speeza_j.screen3.msg4_kor);
      expect(speeza_j.screen3.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.msg4_kor = defalut;
      print(speeza_j.screen3.msg4_kor);
      expect(speeza_j.screen3.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc1;
      print(speeza_j.screen3.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc1 = testData1s;
      print(speeza_j.screen3.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc1 = testData2s;
      print(speeza_j.screen3.etc1);
      expect(speeza_j.screen3.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc1 = defalut;
      print(speeza_j.screen3.etc1);
      expect(speeza_j.screen3.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc2;
      print(speeza_j.screen3.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc2 = testData1s;
      print(speeza_j.screen3.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc2 = testData2s;
      print(speeza_j.screen3.etc2);
      expect(speeza_j.screen3.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc2 = defalut;
      print(speeza_j.screen3.etc2);
      expect(speeza_j.screen3.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc3;
      print(speeza_j.screen3.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc3 = testData1s;
      print(speeza_j.screen3.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc3 = testData2s;
      print(speeza_j.screen3.etc3);
      expect(speeza_j.screen3.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc3 = defalut;
      print(speeza_j.screen3.etc3);
      expect(speeza_j.screen3.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc4;
      print(speeza_j.screen3.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc4 = testData1s;
      print(speeza_j.screen3.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc4 = testData2s;
      print(speeza_j.screen3.etc4);
      expect(speeza_j.screen3.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc4 = defalut;
      print(speeza_j.screen3.etc4);
      expect(speeza_j.screen3.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc5;
      print(speeza_j.screen3.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc5 = testData1s;
      print(speeza_j.screen3.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc5 = testData2s;
      print(speeza_j.screen3.etc5);
      expect(speeza_j.screen3.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc5 = defalut;
      print(speeza_j.screen3.etc5);
      expect(speeza_j.screen3.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc1_ex;
      print(speeza_j.screen3.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc1_ex = testData1s;
      print(speeza_j.screen3.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc1_ex = testData2s;
      print(speeza_j.screen3.etc1_ex);
      expect(speeza_j.screen3.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc1_ex = defalut;
      print(speeza_j.screen3.etc1_ex);
      expect(speeza_j.screen3.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc2_ex;
      print(speeza_j.screen3.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc2_ex = testData1s;
      print(speeza_j.screen3.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc2_ex = testData2s;
      print(speeza_j.screen3.etc2_ex);
      expect(speeza_j.screen3.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc2_ex = defalut;
      print(speeza_j.screen3.etc2_ex);
      expect(speeza_j.screen3.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc3_ex;
      print(speeza_j.screen3.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc3_ex = testData1s;
      print(speeza_j.screen3.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc3_ex = testData2s;
      print(speeza_j.screen3.etc3_ex);
      expect(speeza_j.screen3.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc3_ex = defalut;
      print(speeza_j.screen3.etc3_ex);
      expect(speeza_j.screen3.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc4_ex;
      print(speeza_j.screen3.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc4_ex = testData1s;
      print(speeza_j.screen3.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc4_ex = testData2s;
      print(speeza_j.screen3.etc4_ex);
      expect(speeza_j.screen3.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc4_ex = defalut;
      print(speeza_j.screen3.etc4_ex);
      expect(speeza_j.screen3.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc5_ex;
      print(speeza_j.screen3.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc5_ex = testData1s;
      print(speeza_j.screen3.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc5_ex = testData2s;
      print(speeza_j.screen3.etc5_ex);
      expect(speeza_j.screen3.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc5_ex = defalut;
      print(speeza_j.screen3.etc5_ex);
      expect(speeza_j.screen3.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc1_cn;
      print(speeza_j.screen3.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc1_cn = testData1s;
      print(speeza_j.screen3.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc1_cn = testData2s;
      print(speeza_j.screen3.etc1_cn);
      expect(speeza_j.screen3.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc1_cn = defalut;
      print(speeza_j.screen3.etc1_cn);
      expect(speeza_j.screen3.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc2_cn;
      print(speeza_j.screen3.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc2_cn = testData1s;
      print(speeza_j.screen3.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc2_cn = testData2s;
      print(speeza_j.screen3.etc2_cn);
      expect(speeza_j.screen3.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc2_cn = defalut;
      print(speeza_j.screen3.etc2_cn);
      expect(speeza_j.screen3.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc3_cn;
      print(speeza_j.screen3.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc3_cn = testData1s;
      print(speeza_j.screen3.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc3_cn = testData2s;
      print(speeza_j.screen3.etc3_cn);
      expect(speeza_j.screen3.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc3_cn = defalut;
      print(speeza_j.screen3.etc3_cn);
      expect(speeza_j.screen3.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc4_cn;
      print(speeza_j.screen3.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc4_cn = testData1s;
      print(speeza_j.screen3.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc4_cn = testData2s;
      print(speeza_j.screen3.etc4_cn);
      expect(speeza_j.screen3.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc4_cn = defalut;
      print(speeza_j.screen3.etc4_cn);
      expect(speeza_j.screen3.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc5_cn;
      print(speeza_j.screen3.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc5_cn = testData1s;
      print(speeza_j.screen3.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc5_cn = testData2s;
      print(speeza_j.screen3.etc5_cn);
      expect(speeza_j.screen3.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc5_cn = defalut;
      print(speeza_j.screen3.etc5_cn);
      expect(speeza_j.screen3.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc1_kor;
      print(speeza_j.screen3.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc1_kor = testData1s;
      print(speeza_j.screen3.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc1_kor = testData2s;
      print(speeza_j.screen3.etc1_kor);
      expect(speeza_j.screen3.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc1_kor = defalut;
      print(speeza_j.screen3.etc1_kor);
      expect(speeza_j.screen3.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc2_kor;
      print(speeza_j.screen3.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc2_kor = testData1s;
      print(speeza_j.screen3.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc2_kor = testData2s;
      print(speeza_j.screen3.etc2_kor);
      expect(speeza_j.screen3.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc2_kor = defalut;
      print(speeza_j.screen3.etc2_kor);
      expect(speeza_j.screen3.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc3_kor;
      print(speeza_j.screen3.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc3_kor = testData1s;
      print(speeza_j.screen3.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc3_kor = testData2s;
      print(speeza_j.screen3.etc3_kor);
      expect(speeza_j.screen3.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc3_kor = defalut;
      print(speeza_j.screen3.etc3_kor);
      expect(speeza_j.screen3.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc4_kor;
      print(speeza_j.screen3.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc4_kor = testData1s;
      print(speeza_j.screen3.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc4_kor = testData2s;
      print(speeza_j.screen3.etc4_kor);
      expect(speeza_j.screen3.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc4_kor = defalut;
      print(speeza_j.screen3.etc4_kor);
      expect(speeza_j.screen3.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen3.etc5_kor;
      print(speeza_j.screen3.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen3.etc5_kor = testData1s;
      print(speeza_j.screen3.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen3.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen3.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen3.etc5_kor = testData2s;
      print(speeza_j.screen3.etc5_kor);
      expect(speeza_j.screen3.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen3.etc5_kor = defalut;
      print(speeza_j.screen3.etc5_kor);
      expect(speeza_j.screen3.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen3.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.title;
      print(speeza_j.screen4.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.title = testData1s;
      print(speeza_j.screen4.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.title = testData2s;
      print(speeza_j.screen4.title);
      expect(speeza_j.screen4.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.title = defalut;
      print(speeza_j.screen4.title);
      expect(speeza_j.screen4.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line1;
      print(speeza_j.screen4.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line1 = testData1s;
      print(speeza_j.screen4.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line1 = testData2s;
      print(speeza_j.screen4.line1);
      expect(speeza_j.screen4.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line1 = defalut;
      print(speeza_j.screen4.line1);
      expect(speeza_j.screen4.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line2;
      print(speeza_j.screen4.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line2 = testData1s;
      print(speeza_j.screen4.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line2 = testData2s;
      print(speeza_j.screen4.line2);
      expect(speeza_j.screen4.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line2 = defalut;
      print(speeza_j.screen4.line2);
      expect(speeza_j.screen4.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line1_ex;
      print(speeza_j.screen4.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line1_ex = testData1s;
      print(speeza_j.screen4.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line1_ex = testData2s;
      print(speeza_j.screen4.line1_ex);
      expect(speeza_j.screen4.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line1_ex = defalut;
      print(speeza_j.screen4.line1_ex);
      expect(speeza_j.screen4.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line2_ex;
      print(speeza_j.screen4.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line2_ex = testData1s;
      print(speeza_j.screen4.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line2_ex = testData2s;
      print(speeza_j.screen4.line2_ex);
      expect(speeza_j.screen4.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line2_ex = defalut;
      print(speeza_j.screen4.line2_ex);
      expect(speeza_j.screen4.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line1_cn;
      print(speeza_j.screen4.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line1_cn = testData1s;
      print(speeza_j.screen4.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line1_cn = testData2s;
      print(speeza_j.screen4.line1_cn);
      expect(speeza_j.screen4.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line1_cn = defalut;
      print(speeza_j.screen4.line1_cn);
      expect(speeza_j.screen4.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line2_cn;
      print(speeza_j.screen4.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line2_cn = testData1s;
      print(speeza_j.screen4.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line2_cn = testData2s;
      print(speeza_j.screen4.line2_cn);
      expect(speeza_j.screen4.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line2_cn = defalut;
      print(speeza_j.screen4.line2_cn);
      expect(speeza_j.screen4.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line1_kor;
      print(speeza_j.screen4.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line1_kor = testData1s;
      print(speeza_j.screen4.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line1_kor = testData2s;
      print(speeza_j.screen4.line1_kor);
      expect(speeza_j.screen4.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line1_kor = defalut;
      print(speeza_j.screen4.line1_kor);
      expect(speeza_j.screen4.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.line2_kor;
      print(speeza_j.screen4.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.line2_kor = testData1s;
      print(speeza_j.screen4.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.line2_kor = testData2s;
      print(speeza_j.screen4.line2_kor);
      expect(speeza_j.screen4.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.line2_kor = defalut;
      print(speeza_j.screen4.line2_kor);
      expect(speeza_j.screen4.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg1;
      print(speeza_j.screen4.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg1 = testData1s;
      print(speeza_j.screen4.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg1 = testData2s;
      print(speeza_j.screen4.msg1);
      expect(speeza_j.screen4.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg1 = defalut;
      print(speeza_j.screen4.msg1);
      expect(speeza_j.screen4.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg2;
      print(speeza_j.screen4.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg2 = testData1s;
      print(speeza_j.screen4.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg2 = testData2s;
      print(speeza_j.screen4.msg2);
      expect(speeza_j.screen4.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg2 = defalut;
      print(speeza_j.screen4.msg2);
      expect(speeza_j.screen4.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg3;
      print(speeza_j.screen4.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg3 = testData1s;
      print(speeza_j.screen4.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg3 = testData2s;
      print(speeza_j.screen4.msg3);
      expect(speeza_j.screen4.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg3 = defalut;
      print(speeza_j.screen4.msg3);
      expect(speeza_j.screen4.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg4;
      print(speeza_j.screen4.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg4 = testData1s;
      print(speeza_j.screen4.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg4 = testData2s;
      print(speeza_j.screen4.msg4);
      expect(speeza_j.screen4.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg4 = defalut;
      print(speeza_j.screen4.msg4);
      expect(speeza_j.screen4.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg1_ex;
      print(speeza_j.screen4.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg1_ex = testData1s;
      print(speeza_j.screen4.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg1_ex = testData2s;
      print(speeza_j.screen4.msg1_ex);
      expect(speeza_j.screen4.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg1_ex = defalut;
      print(speeza_j.screen4.msg1_ex);
      expect(speeza_j.screen4.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg2_ex;
      print(speeza_j.screen4.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg2_ex = testData1s;
      print(speeza_j.screen4.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg2_ex = testData2s;
      print(speeza_j.screen4.msg2_ex);
      expect(speeza_j.screen4.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg2_ex = defalut;
      print(speeza_j.screen4.msg2_ex);
      expect(speeza_j.screen4.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg3_ex;
      print(speeza_j.screen4.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg3_ex = testData1s;
      print(speeza_j.screen4.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg3_ex = testData2s;
      print(speeza_j.screen4.msg3_ex);
      expect(speeza_j.screen4.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg3_ex = defalut;
      print(speeza_j.screen4.msg3_ex);
      expect(speeza_j.screen4.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg4_ex;
      print(speeza_j.screen4.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg4_ex = testData1s;
      print(speeza_j.screen4.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg4_ex = testData2s;
      print(speeza_j.screen4.msg4_ex);
      expect(speeza_j.screen4.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg4_ex = defalut;
      print(speeza_j.screen4.msg4_ex);
      expect(speeza_j.screen4.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg1_cn;
      print(speeza_j.screen4.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg1_cn = testData1s;
      print(speeza_j.screen4.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg1_cn = testData2s;
      print(speeza_j.screen4.msg1_cn);
      expect(speeza_j.screen4.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg1_cn = defalut;
      print(speeza_j.screen4.msg1_cn);
      expect(speeza_j.screen4.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg2_cn;
      print(speeza_j.screen4.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg2_cn = testData1s;
      print(speeza_j.screen4.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg2_cn = testData2s;
      print(speeza_j.screen4.msg2_cn);
      expect(speeza_j.screen4.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg2_cn = defalut;
      print(speeza_j.screen4.msg2_cn);
      expect(speeza_j.screen4.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg3_cn;
      print(speeza_j.screen4.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg3_cn = testData1s;
      print(speeza_j.screen4.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg3_cn = testData2s;
      print(speeza_j.screen4.msg3_cn);
      expect(speeza_j.screen4.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg3_cn = defalut;
      print(speeza_j.screen4.msg3_cn);
      expect(speeza_j.screen4.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg4_cn;
      print(speeza_j.screen4.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg4_cn = testData1s;
      print(speeza_j.screen4.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg4_cn = testData2s;
      print(speeza_j.screen4.msg4_cn);
      expect(speeza_j.screen4.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg4_cn = defalut;
      print(speeza_j.screen4.msg4_cn);
      expect(speeza_j.screen4.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg1_kor;
      print(speeza_j.screen4.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg1_kor = testData1s;
      print(speeza_j.screen4.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg1_kor = testData2s;
      print(speeza_j.screen4.msg1_kor);
      expect(speeza_j.screen4.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg1_kor = defalut;
      print(speeza_j.screen4.msg1_kor);
      expect(speeza_j.screen4.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg2_kor;
      print(speeza_j.screen4.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg2_kor = testData1s;
      print(speeza_j.screen4.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg2_kor = testData2s;
      print(speeza_j.screen4.msg2_kor);
      expect(speeza_j.screen4.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg2_kor = defalut;
      print(speeza_j.screen4.msg2_kor);
      expect(speeza_j.screen4.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg3_kor;
      print(speeza_j.screen4.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg3_kor = testData1s;
      print(speeza_j.screen4.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg3_kor = testData2s;
      print(speeza_j.screen4.msg3_kor);
      expect(speeza_j.screen4.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg3_kor = defalut;
      print(speeza_j.screen4.msg3_kor);
      expect(speeza_j.screen4.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.msg4_kor;
      print(speeza_j.screen4.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.msg4_kor = testData1s;
      print(speeza_j.screen4.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.msg4_kor = testData2s;
      print(speeza_j.screen4.msg4_kor);
      expect(speeza_j.screen4.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.msg4_kor = defalut;
      print(speeza_j.screen4.msg4_kor);
      expect(speeza_j.screen4.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc1;
      print(speeza_j.screen4.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc1 = testData1s;
      print(speeza_j.screen4.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc1 = testData2s;
      print(speeza_j.screen4.etc1);
      expect(speeza_j.screen4.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc1 = defalut;
      print(speeza_j.screen4.etc1);
      expect(speeza_j.screen4.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc2;
      print(speeza_j.screen4.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc2 = testData1s;
      print(speeza_j.screen4.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc2 = testData2s;
      print(speeza_j.screen4.etc2);
      expect(speeza_j.screen4.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc2 = defalut;
      print(speeza_j.screen4.etc2);
      expect(speeza_j.screen4.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc3;
      print(speeza_j.screen4.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc3 = testData1s;
      print(speeza_j.screen4.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc3 = testData2s;
      print(speeza_j.screen4.etc3);
      expect(speeza_j.screen4.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc3 = defalut;
      print(speeza_j.screen4.etc3);
      expect(speeza_j.screen4.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc4;
      print(speeza_j.screen4.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc4 = testData1s;
      print(speeza_j.screen4.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc4 = testData2s;
      print(speeza_j.screen4.etc4);
      expect(speeza_j.screen4.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc4 = defalut;
      print(speeza_j.screen4.etc4);
      expect(speeza_j.screen4.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc5;
      print(speeza_j.screen4.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc5 = testData1s;
      print(speeza_j.screen4.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc5 = testData2s;
      print(speeza_j.screen4.etc5);
      expect(speeza_j.screen4.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc5 = defalut;
      print(speeza_j.screen4.etc5);
      expect(speeza_j.screen4.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc1_ex;
      print(speeza_j.screen4.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc1_ex = testData1s;
      print(speeza_j.screen4.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc1_ex = testData2s;
      print(speeza_j.screen4.etc1_ex);
      expect(speeza_j.screen4.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc1_ex = defalut;
      print(speeza_j.screen4.etc1_ex);
      expect(speeza_j.screen4.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc2_ex;
      print(speeza_j.screen4.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc2_ex = testData1s;
      print(speeza_j.screen4.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc2_ex = testData2s;
      print(speeza_j.screen4.etc2_ex);
      expect(speeza_j.screen4.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc2_ex = defalut;
      print(speeza_j.screen4.etc2_ex);
      expect(speeza_j.screen4.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc3_ex;
      print(speeza_j.screen4.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc3_ex = testData1s;
      print(speeza_j.screen4.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc3_ex = testData2s;
      print(speeza_j.screen4.etc3_ex);
      expect(speeza_j.screen4.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc3_ex = defalut;
      print(speeza_j.screen4.etc3_ex);
      expect(speeza_j.screen4.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc4_ex;
      print(speeza_j.screen4.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc4_ex = testData1s;
      print(speeza_j.screen4.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc4_ex = testData2s;
      print(speeza_j.screen4.etc4_ex);
      expect(speeza_j.screen4.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc4_ex = defalut;
      print(speeza_j.screen4.etc4_ex);
      expect(speeza_j.screen4.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc5_ex;
      print(speeza_j.screen4.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc5_ex = testData1s;
      print(speeza_j.screen4.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc5_ex = testData2s;
      print(speeza_j.screen4.etc5_ex);
      expect(speeza_j.screen4.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc5_ex = defalut;
      print(speeza_j.screen4.etc5_ex);
      expect(speeza_j.screen4.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc1_cn;
      print(speeza_j.screen4.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc1_cn = testData1s;
      print(speeza_j.screen4.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc1_cn = testData2s;
      print(speeza_j.screen4.etc1_cn);
      expect(speeza_j.screen4.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc1_cn = defalut;
      print(speeza_j.screen4.etc1_cn);
      expect(speeza_j.screen4.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc2_cn;
      print(speeza_j.screen4.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc2_cn = testData1s;
      print(speeza_j.screen4.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc2_cn = testData2s;
      print(speeza_j.screen4.etc2_cn);
      expect(speeza_j.screen4.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc2_cn = defalut;
      print(speeza_j.screen4.etc2_cn);
      expect(speeza_j.screen4.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

    test('00242_element_check_00219', () async {
      print("\n********** テスト実行：00242_element_check_00219 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc3_cn;
      print(speeza_j.screen4.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc3_cn = testData1s;
      print(speeza_j.screen4.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc3_cn = testData2s;
      print(speeza_j.screen4.etc3_cn);
      expect(speeza_j.screen4.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc3_cn = defalut;
      print(speeza_j.screen4.etc3_cn);
      expect(speeza_j.screen4.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00242_element_check_00219 **********\n\n");
    });

    test('00243_element_check_00220', () async {
      print("\n********** テスト実行：00243_element_check_00220 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc4_cn;
      print(speeza_j.screen4.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc4_cn = testData1s;
      print(speeza_j.screen4.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc4_cn = testData2s;
      print(speeza_j.screen4.etc4_cn);
      expect(speeza_j.screen4.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc4_cn = defalut;
      print(speeza_j.screen4.etc4_cn);
      expect(speeza_j.screen4.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00243_element_check_00220 **********\n\n");
    });

    test('00244_element_check_00221', () async {
      print("\n********** テスト実行：00244_element_check_00221 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc5_cn;
      print(speeza_j.screen4.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc5_cn = testData1s;
      print(speeza_j.screen4.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc5_cn = testData2s;
      print(speeza_j.screen4.etc5_cn);
      expect(speeza_j.screen4.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc5_cn = defalut;
      print(speeza_j.screen4.etc5_cn);
      expect(speeza_j.screen4.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00244_element_check_00221 **********\n\n");
    });

    test('00245_element_check_00222', () async {
      print("\n********** テスト実行：00245_element_check_00222 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc1_kor;
      print(speeza_j.screen4.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc1_kor = testData1s;
      print(speeza_j.screen4.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc1_kor = testData2s;
      print(speeza_j.screen4.etc1_kor);
      expect(speeza_j.screen4.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc1_kor = defalut;
      print(speeza_j.screen4.etc1_kor);
      expect(speeza_j.screen4.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00245_element_check_00222 **********\n\n");
    });

    test('00246_element_check_00223', () async {
      print("\n********** テスト実行：00246_element_check_00223 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc2_kor;
      print(speeza_j.screen4.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc2_kor = testData1s;
      print(speeza_j.screen4.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc2_kor = testData2s;
      print(speeza_j.screen4.etc2_kor);
      expect(speeza_j.screen4.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc2_kor = defalut;
      print(speeza_j.screen4.etc2_kor);
      expect(speeza_j.screen4.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00246_element_check_00223 **********\n\n");
    });

    test('00247_element_check_00224', () async {
      print("\n********** テスト実行：00247_element_check_00224 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc3_kor;
      print(speeza_j.screen4.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc3_kor = testData1s;
      print(speeza_j.screen4.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc3_kor = testData2s;
      print(speeza_j.screen4.etc3_kor);
      expect(speeza_j.screen4.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc3_kor = defalut;
      print(speeza_j.screen4.etc3_kor);
      expect(speeza_j.screen4.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00247_element_check_00224 **********\n\n");
    });

    test('00248_element_check_00225', () async {
      print("\n********** テスト実行：00248_element_check_00225 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc4_kor;
      print(speeza_j.screen4.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc4_kor = testData1s;
      print(speeza_j.screen4.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc4_kor = testData2s;
      print(speeza_j.screen4.etc4_kor);
      expect(speeza_j.screen4.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc4_kor = defalut;
      print(speeza_j.screen4.etc4_kor);
      expect(speeza_j.screen4.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00248_element_check_00225 **********\n\n");
    });

    test('00249_element_check_00226', () async {
      print("\n********** テスト実行：00249_element_check_00226 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen4.etc5_kor;
      print(speeza_j.screen4.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen4.etc5_kor = testData1s;
      print(speeza_j.screen4.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen4.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen4.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen4.etc5_kor = testData2s;
      print(speeza_j.screen4.etc5_kor);
      expect(speeza_j.screen4.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen4.etc5_kor = defalut;
      print(speeza_j.screen4.etc5_kor);
      expect(speeza_j.screen4.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen4.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00249_element_check_00226 **********\n\n");
    });

    test('00250_element_check_00227', () async {
      print("\n********** テスト実行：00250_element_check_00227 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.title;
      print(speeza_j.screen5.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.title = testData1s;
      print(speeza_j.screen5.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.title = testData2s;
      print(speeza_j.screen5.title);
      expect(speeza_j.screen5.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.title = defalut;
      print(speeza_j.screen5.title);
      expect(speeza_j.screen5.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00250_element_check_00227 **********\n\n");
    });

    test('00251_element_check_00228', () async {
      print("\n********** テスト実行：00251_element_check_00228 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line1;
      print(speeza_j.screen5.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line1 = testData1s;
      print(speeza_j.screen5.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line1 = testData2s;
      print(speeza_j.screen5.line1);
      expect(speeza_j.screen5.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line1 = defalut;
      print(speeza_j.screen5.line1);
      expect(speeza_j.screen5.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00251_element_check_00228 **********\n\n");
    });

    test('00252_element_check_00229', () async {
      print("\n********** テスト実行：00252_element_check_00229 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line2;
      print(speeza_j.screen5.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line2 = testData1s;
      print(speeza_j.screen5.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line2 = testData2s;
      print(speeza_j.screen5.line2);
      expect(speeza_j.screen5.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line2 = defalut;
      print(speeza_j.screen5.line2);
      expect(speeza_j.screen5.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00252_element_check_00229 **********\n\n");
    });

    test('00253_element_check_00230', () async {
      print("\n********** テスト実行：00253_element_check_00230 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line1_ex;
      print(speeza_j.screen5.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line1_ex = testData1s;
      print(speeza_j.screen5.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line1_ex = testData2s;
      print(speeza_j.screen5.line1_ex);
      expect(speeza_j.screen5.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line1_ex = defalut;
      print(speeza_j.screen5.line1_ex);
      expect(speeza_j.screen5.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00253_element_check_00230 **********\n\n");
    });

    test('00254_element_check_00231', () async {
      print("\n********** テスト実行：00254_element_check_00231 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line2_ex;
      print(speeza_j.screen5.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line2_ex = testData1s;
      print(speeza_j.screen5.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line2_ex = testData2s;
      print(speeza_j.screen5.line2_ex);
      expect(speeza_j.screen5.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line2_ex = defalut;
      print(speeza_j.screen5.line2_ex);
      expect(speeza_j.screen5.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00254_element_check_00231 **********\n\n");
    });

    test('00255_element_check_00232', () async {
      print("\n********** テスト実行：00255_element_check_00232 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line1_cn;
      print(speeza_j.screen5.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line1_cn = testData1s;
      print(speeza_j.screen5.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line1_cn = testData2s;
      print(speeza_j.screen5.line1_cn);
      expect(speeza_j.screen5.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line1_cn = defalut;
      print(speeza_j.screen5.line1_cn);
      expect(speeza_j.screen5.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00255_element_check_00232 **********\n\n");
    });

    test('00256_element_check_00233', () async {
      print("\n********** テスト実行：00256_element_check_00233 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line2_cn;
      print(speeza_j.screen5.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line2_cn = testData1s;
      print(speeza_j.screen5.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line2_cn = testData2s;
      print(speeza_j.screen5.line2_cn);
      expect(speeza_j.screen5.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line2_cn = defalut;
      print(speeza_j.screen5.line2_cn);
      expect(speeza_j.screen5.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00256_element_check_00233 **********\n\n");
    });

    test('00257_element_check_00234', () async {
      print("\n********** テスト実行：00257_element_check_00234 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line1_kor;
      print(speeza_j.screen5.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line1_kor = testData1s;
      print(speeza_j.screen5.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line1_kor = testData2s;
      print(speeza_j.screen5.line1_kor);
      expect(speeza_j.screen5.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line1_kor = defalut;
      print(speeza_j.screen5.line1_kor);
      expect(speeza_j.screen5.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00257_element_check_00234 **********\n\n");
    });

    test('00258_element_check_00235', () async {
      print("\n********** テスト実行：00258_element_check_00235 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.line2_kor;
      print(speeza_j.screen5.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.line2_kor = testData1s;
      print(speeza_j.screen5.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.line2_kor = testData2s;
      print(speeza_j.screen5.line2_kor);
      expect(speeza_j.screen5.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.line2_kor = defalut;
      print(speeza_j.screen5.line2_kor);
      expect(speeza_j.screen5.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00258_element_check_00235 **********\n\n");
    });

    test('00259_element_check_00236', () async {
      print("\n********** テスト実行：00259_element_check_00236 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg1;
      print(speeza_j.screen5.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg1 = testData1s;
      print(speeza_j.screen5.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg1 = testData2s;
      print(speeza_j.screen5.msg1);
      expect(speeza_j.screen5.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg1 = defalut;
      print(speeza_j.screen5.msg1);
      expect(speeza_j.screen5.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00259_element_check_00236 **********\n\n");
    });

    test('00260_element_check_00237', () async {
      print("\n********** テスト実行：00260_element_check_00237 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg2;
      print(speeza_j.screen5.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg2 = testData1s;
      print(speeza_j.screen5.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg2 = testData2s;
      print(speeza_j.screen5.msg2);
      expect(speeza_j.screen5.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg2 = defalut;
      print(speeza_j.screen5.msg2);
      expect(speeza_j.screen5.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00260_element_check_00237 **********\n\n");
    });

    test('00261_element_check_00238', () async {
      print("\n********** テスト実行：00261_element_check_00238 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg3;
      print(speeza_j.screen5.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg3 = testData1s;
      print(speeza_j.screen5.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg3 = testData2s;
      print(speeza_j.screen5.msg3);
      expect(speeza_j.screen5.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg3 = defalut;
      print(speeza_j.screen5.msg3);
      expect(speeza_j.screen5.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00261_element_check_00238 **********\n\n");
    });

    test('00262_element_check_00239', () async {
      print("\n********** テスト実行：00262_element_check_00239 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg4;
      print(speeza_j.screen5.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg4 = testData1s;
      print(speeza_j.screen5.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg4 = testData2s;
      print(speeza_j.screen5.msg4);
      expect(speeza_j.screen5.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg4 = defalut;
      print(speeza_j.screen5.msg4);
      expect(speeza_j.screen5.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00262_element_check_00239 **********\n\n");
    });

    test('00263_element_check_00240', () async {
      print("\n********** テスト実行：00263_element_check_00240 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg1_ex;
      print(speeza_j.screen5.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg1_ex = testData1s;
      print(speeza_j.screen5.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg1_ex = testData2s;
      print(speeza_j.screen5.msg1_ex);
      expect(speeza_j.screen5.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg1_ex = defalut;
      print(speeza_j.screen5.msg1_ex);
      expect(speeza_j.screen5.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00263_element_check_00240 **********\n\n");
    });

    test('00264_element_check_00241', () async {
      print("\n********** テスト実行：00264_element_check_00241 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg2_ex;
      print(speeza_j.screen5.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg2_ex = testData1s;
      print(speeza_j.screen5.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg2_ex = testData2s;
      print(speeza_j.screen5.msg2_ex);
      expect(speeza_j.screen5.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg2_ex = defalut;
      print(speeza_j.screen5.msg2_ex);
      expect(speeza_j.screen5.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00264_element_check_00241 **********\n\n");
    });

    test('00265_element_check_00242', () async {
      print("\n********** テスト実行：00265_element_check_00242 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg3_ex;
      print(speeza_j.screen5.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg3_ex = testData1s;
      print(speeza_j.screen5.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg3_ex = testData2s;
      print(speeza_j.screen5.msg3_ex);
      expect(speeza_j.screen5.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg3_ex = defalut;
      print(speeza_j.screen5.msg3_ex);
      expect(speeza_j.screen5.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00265_element_check_00242 **********\n\n");
    });

    test('00266_element_check_00243', () async {
      print("\n********** テスト実行：00266_element_check_00243 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg4_ex;
      print(speeza_j.screen5.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg4_ex = testData1s;
      print(speeza_j.screen5.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg4_ex = testData2s;
      print(speeza_j.screen5.msg4_ex);
      expect(speeza_j.screen5.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg4_ex = defalut;
      print(speeza_j.screen5.msg4_ex);
      expect(speeza_j.screen5.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00266_element_check_00243 **********\n\n");
    });

    test('00267_element_check_00244', () async {
      print("\n********** テスト実行：00267_element_check_00244 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg1_cn;
      print(speeza_j.screen5.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg1_cn = testData1s;
      print(speeza_j.screen5.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg1_cn = testData2s;
      print(speeza_j.screen5.msg1_cn);
      expect(speeza_j.screen5.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg1_cn = defalut;
      print(speeza_j.screen5.msg1_cn);
      expect(speeza_j.screen5.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00267_element_check_00244 **********\n\n");
    });

    test('00268_element_check_00245', () async {
      print("\n********** テスト実行：00268_element_check_00245 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg2_cn;
      print(speeza_j.screen5.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg2_cn = testData1s;
      print(speeza_j.screen5.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg2_cn = testData2s;
      print(speeza_j.screen5.msg2_cn);
      expect(speeza_j.screen5.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg2_cn = defalut;
      print(speeza_j.screen5.msg2_cn);
      expect(speeza_j.screen5.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00268_element_check_00245 **********\n\n");
    });

    test('00269_element_check_00246', () async {
      print("\n********** テスト実行：00269_element_check_00246 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg3_cn;
      print(speeza_j.screen5.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg3_cn = testData1s;
      print(speeza_j.screen5.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg3_cn = testData2s;
      print(speeza_j.screen5.msg3_cn);
      expect(speeza_j.screen5.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg3_cn = defalut;
      print(speeza_j.screen5.msg3_cn);
      expect(speeza_j.screen5.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00269_element_check_00246 **********\n\n");
    });

    test('00270_element_check_00247', () async {
      print("\n********** テスト実行：00270_element_check_00247 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg4_cn;
      print(speeza_j.screen5.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg4_cn = testData1s;
      print(speeza_j.screen5.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg4_cn = testData2s;
      print(speeza_j.screen5.msg4_cn);
      expect(speeza_j.screen5.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg4_cn = defalut;
      print(speeza_j.screen5.msg4_cn);
      expect(speeza_j.screen5.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00270_element_check_00247 **********\n\n");
    });

    test('00271_element_check_00248', () async {
      print("\n********** テスト実行：00271_element_check_00248 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg1_kor;
      print(speeza_j.screen5.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg1_kor = testData1s;
      print(speeza_j.screen5.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg1_kor = testData2s;
      print(speeza_j.screen5.msg1_kor);
      expect(speeza_j.screen5.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg1_kor = defalut;
      print(speeza_j.screen5.msg1_kor);
      expect(speeza_j.screen5.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00271_element_check_00248 **********\n\n");
    });

    test('00272_element_check_00249', () async {
      print("\n********** テスト実行：00272_element_check_00249 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg2_kor;
      print(speeza_j.screen5.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg2_kor = testData1s;
      print(speeza_j.screen5.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg2_kor = testData2s;
      print(speeza_j.screen5.msg2_kor);
      expect(speeza_j.screen5.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg2_kor = defalut;
      print(speeza_j.screen5.msg2_kor);
      expect(speeza_j.screen5.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00272_element_check_00249 **********\n\n");
    });

    test('00273_element_check_00250', () async {
      print("\n********** テスト実行：00273_element_check_00250 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg3_kor;
      print(speeza_j.screen5.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg3_kor = testData1s;
      print(speeza_j.screen5.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg3_kor = testData2s;
      print(speeza_j.screen5.msg3_kor);
      expect(speeza_j.screen5.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg3_kor = defalut;
      print(speeza_j.screen5.msg3_kor);
      expect(speeza_j.screen5.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00273_element_check_00250 **********\n\n");
    });

    test('00274_element_check_00251', () async {
      print("\n********** テスト実行：00274_element_check_00251 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.msg4_kor;
      print(speeza_j.screen5.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.msg4_kor = testData1s;
      print(speeza_j.screen5.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.msg4_kor = testData2s;
      print(speeza_j.screen5.msg4_kor);
      expect(speeza_j.screen5.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.msg4_kor = defalut;
      print(speeza_j.screen5.msg4_kor);
      expect(speeza_j.screen5.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00274_element_check_00251 **********\n\n");
    });

    test('00275_element_check_00252', () async {
      print("\n********** テスト実行：00275_element_check_00252 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc1;
      print(speeza_j.screen5.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc1 = testData1s;
      print(speeza_j.screen5.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc1 = testData2s;
      print(speeza_j.screen5.etc1);
      expect(speeza_j.screen5.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc1 = defalut;
      print(speeza_j.screen5.etc1);
      expect(speeza_j.screen5.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00275_element_check_00252 **********\n\n");
    });

    test('00276_element_check_00253', () async {
      print("\n********** テスト実行：00276_element_check_00253 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc2;
      print(speeza_j.screen5.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc2 = testData1s;
      print(speeza_j.screen5.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc2 = testData2s;
      print(speeza_j.screen5.etc2);
      expect(speeza_j.screen5.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc2 = defalut;
      print(speeza_j.screen5.etc2);
      expect(speeza_j.screen5.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00276_element_check_00253 **********\n\n");
    });

    test('00277_element_check_00254', () async {
      print("\n********** テスト実行：00277_element_check_00254 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc3;
      print(speeza_j.screen5.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc3 = testData1s;
      print(speeza_j.screen5.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc3 = testData2s;
      print(speeza_j.screen5.etc3);
      expect(speeza_j.screen5.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc3 = defalut;
      print(speeza_j.screen5.etc3);
      expect(speeza_j.screen5.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00277_element_check_00254 **********\n\n");
    });

    test('00278_element_check_00255', () async {
      print("\n********** テスト実行：00278_element_check_00255 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc4;
      print(speeza_j.screen5.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc4 = testData1s;
      print(speeza_j.screen5.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc4 = testData2s;
      print(speeza_j.screen5.etc4);
      expect(speeza_j.screen5.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc4 = defalut;
      print(speeza_j.screen5.etc4);
      expect(speeza_j.screen5.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00278_element_check_00255 **********\n\n");
    });

    test('00279_element_check_00256', () async {
      print("\n********** テスト実行：00279_element_check_00256 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc5;
      print(speeza_j.screen5.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc5 = testData1s;
      print(speeza_j.screen5.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc5 = testData2s;
      print(speeza_j.screen5.etc5);
      expect(speeza_j.screen5.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc5 = defalut;
      print(speeza_j.screen5.etc5);
      expect(speeza_j.screen5.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00279_element_check_00256 **********\n\n");
    });

    test('00280_element_check_00257', () async {
      print("\n********** テスト実行：00280_element_check_00257 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc1_ex;
      print(speeza_j.screen5.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc1_ex = testData1s;
      print(speeza_j.screen5.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc1_ex = testData2s;
      print(speeza_j.screen5.etc1_ex);
      expect(speeza_j.screen5.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc1_ex = defalut;
      print(speeza_j.screen5.etc1_ex);
      expect(speeza_j.screen5.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00280_element_check_00257 **********\n\n");
    });

    test('00281_element_check_00258', () async {
      print("\n********** テスト実行：00281_element_check_00258 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc2_ex;
      print(speeza_j.screen5.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc2_ex = testData1s;
      print(speeza_j.screen5.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc2_ex = testData2s;
      print(speeza_j.screen5.etc2_ex);
      expect(speeza_j.screen5.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc2_ex = defalut;
      print(speeza_j.screen5.etc2_ex);
      expect(speeza_j.screen5.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00281_element_check_00258 **********\n\n");
    });

    test('00282_element_check_00259', () async {
      print("\n********** テスト実行：00282_element_check_00259 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc3_ex;
      print(speeza_j.screen5.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc3_ex = testData1s;
      print(speeza_j.screen5.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc3_ex = testData2s;
      print(speeza_j.screen5.etc3_ex);
      expect(speeza_j.screen5.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc3_ex = defalut;
      print(speeza_j.screen5.etc3_ex);
      expect(speeza_j.screen5.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00282_element_check_00259 **********\n\n");
    });

    test('00283_element_check_00260', () async {
      print("\n********** テスト実行：00283_element_check_00260 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc4_ex;
      print(speeza_j.screen5.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc4_ex = testData1s;
      print(speeza_j.screen5.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc4_ex = testData2s;
      print(speeza_j.screen5.etc4_ex);
      expect(speeza_j.screen5.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc4_ex = defalut;
      print(speeza_j.screen5.etc4_ex);
      expect(speeza_j.screen5.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00283_element_check_00260 **********\n\n");
    });

    test('00284_element_check_00261', () async {
      print("\n********** テスト実行：00284_element_check_00261 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc5_ex;
      print(speeza_j.screen5.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc5_ex = testData1s;
      print(speeza_j.screen5.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc5_ex = testData2s;
      print(speeza_j.screen5.etc5_ex);
      expect(speeza_j.screen5.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc5_ex = defalut;
      print(speeza_j.screen5.etc5_ex);
      expect(speeza_j.screen5.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00284_element_check_00261 **********\n\n");
    });

    test('00285_element_check_00262', () async {
      print("\n********** テスト実行：00285_element_check_00262 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc1_cn;
      print(speeza_j.screen5.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc1_cn = testData1s;
      print(speeza_j.screen5.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc1_cn = testData2s;
      print(speeza_j.screen5.etc1_cn);
      expect(speeza_j.screen5.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc1_cn = defalut;
      print(speeza_j.screen5.etc1_cn);
      expect(speeza_j.screen5.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00285_element_check_00262 **********\n\n");
    });

    test('00286_element_check_00263', () async {
      print("\n********** テスト実行：00286_element_check_00263 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc2_cn;
      print(speeza_j.screen5.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc2_cn = testData1s;
      print(speeza_j.screen5.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc2_cn = testData2s;
      print(speeza_j.screen5.etc2_cn);
      expect(speeza_j.screen5.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc2_cn = defalut;
      print(speeza_j.screen5.etc2_cn);
      expect(speeza_j.screen5.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00286_element_check_00263 **********\n\n");
    });

    test('00287_element_check_00264', () async {
      print("\n********** テスト実行：00287_element_check_00264 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc3_cn;
      print(speeza_j.screen5.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc3_cn = testData1s;
      print(speeza_j.screen5.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc3_cn = testData2s;
      print(speeza_j.screen5.etc3_cn);
      expect(speeza_j.screen5.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc3_cn = defalut;
      print(speeza_j.screen5.etc3_cn);
      expect(speeza_j.screen5.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00287_element_check_00264 **********\n\n");
    });

    test('00288_element_check_00265', () async {
      print("\n********** テスト実行：00288_element_check_00265 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc4_cn;
      print(speeza_j.screen5.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc4_cn = testData1s;
      print(speeza_j.screen5.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc4_cn = testData2s;
      print(speeza_j.screen5.etc4_cn);
      expect(speeza_j.screen5.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc4_cn = defalut;
      print(speeza_j.screen5.etc4_cn);
      expect(speeza_j.screen5.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00288_element_check_00265 **********\n\n");
    });

    test('00289_element_check_00266', () async {
      print("\n********** テスト実行：00289_element_check_00266 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc5_cn;
      print(speeza_j.screen5.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc5_cn = testData1s;
      print(speeza_j.screen5.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc5_cn = testData2s;
      print(speeza_j.screen5.etc5_cn);
      expect(speeza_j.screen5.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc5_cn = defalut;
      print(speeza_j.screen5.etc5_cn);
      expect(speeza_j.screen5.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00289_element_check_00266 **********\n\n");
    });

    test('00290_element_check_00267', () async {
      print("\n********** テスト実行：00290_element_check_00267 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc1_kor;
      print(speeza_j.screen5.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc1_kor = testData1s;
      print(speeza_j.screen5.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc1_kor = testData2s;
      print(speeza_j.screen5.etc1_kor);
      expect(speeza_j.screen5.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc1_kor = defalut;
      print(speeza_j.screen5.etc1_kor);
      expect(speeza_j.screen5.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00290_element_check_00267 **********\n\n");
    });

    test('00291_element_check_00268', () async {
      print("\n********** テスト実行：00291_element_check_00268 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc2_kor;
      print(speeza_j.screen5.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc2_kor = testData1s;
      print(speeza_j.screen5.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc2_kor = testData2s;
      print(speeza_j.screen5.etc2_kor);
      expect(speeza_j.screen5.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc2_kor = defalut;
      print(speeza_j.screen5.etc2_kor);
      expect(speeza_j.screen5.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00291_element_check_00268 **********\n\n");
    });

    test('00292_element_check_00269', () async {
      print("\n********** テスト実行：00292_element_check_00269 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc3_kor;
      print(speeza_j.screen5.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc3_kor = testData1s;
      print(speeza_j.screen5.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc3_kor = testData2s;
      print(speeza_j.screen5.etc3_kor);
      expect(speeza_j.screen5.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc3_kor = defalut;
      print(speeza_j.screen5.etc3_kor);
      expect(speeza_j.screen5.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00292_element_check_00269 **********\n\n");
    });

    test('00293_element_check_00270', () async {
      print("\n********** テスト実行：00293_element_check_00270 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc4_kor;
      print(speeza_j.screen5.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc4_kor = testData1s;
      print(speeza_j.screen5.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc4_kor = testData2s;
      print(speeza_j.screen5.etc4_kor);
      expect(speeza_j.screen5.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc4_kor = defalut;
      print(speeza_j.screen5.etc4_kor);
      expect(speeza_j.screen5.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00293_element_check_00270 **********\n\n");
    });

    test('00294_element_check_00271', () async {
      print("\n********** テスト実行：00294_element_check_00271 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen5.etc5_kor;
      print(speeza_j.screen5.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen5.etc5_kor = testData1s;
      print(speeza_j.screen5.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen5.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen5.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen5.etc5_kor = testData2s;
      print(speeza_j.screen5.etc5_kor);
      expect(speeza_j.screen5.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen5.etc5_kor = defalut;
      print(speeza_j.screen5.etc5_kor);
      expect(speeza_j.screen5.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen5.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00294_element_check_00271 **********\n\n");
    });

    test('00295_element_check_00272', () async {
      print("\n********** テスト実行：00295_element_check_00272 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.title;
      print(speeza_j.screen6.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.title = testData1s;
      print(speeza_j.screen6.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.title = testData2s;
      print(speeza_j.screen6.title);
      expect(speeza_j.screen6.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.title = defalut;
      print(speeza_j.screen6.title);
      expect(speeza_j.screen6.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00295_element_check_00272 **********\n\n");
    });

    test('00296_element_check_00273', () async {
      print("\n********** テスト実行：00296_element_check_00273 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line1;
      print(speeza_j.screen6.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line1 = testData1s;
      print(speeza_j.screen6.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line1 = testData2s;
      print(speeza_j.screen6.line1);
      expect(speeza_j.screen6.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line1 = defalut;
      print(speeza_j.screen6.line1);
      expect(speeza_j.screen6.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00296_element_check_00273 **********\n\n");
    });

    test('00297_element_check_00274', () async {
      print("\n********** テスト実行：00297_element_check_00274 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line2;
      print(speeza_j.screen6.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line2 = testData1s;
      print(speeza_j.screen6.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line2 = testData2s;
      print(speeza_j.screen6.line2);
      expect(speeza_j.screen6.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line2 = defalut;
      print(speeza_j.screen6.line2);
      expect(speeza_j.screen6.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00297_element_check_00274 **********\n\n");
    });

    test('00298_element_check_00275', () async {
      print("\n********** テスト実行：00298_element_check_00275 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line1_ex;
      print(speeza_j.screen6.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line1_ex = testData1s;
      print(speeza_j.screen6.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line1_ex = testData2s;
      print(speeza_j.screen6.line1_ex);
      expect(speeza_j.screen6.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line1_ex = defalut;
      print(speeza_j.screen6.line1_ex);
      expect(speeza_j.screen6.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00298_element_check_00275 **********\n\n");
    });

    test('00299_element_check_00276', () async {
      print("\n********** テスト実行：00299_element_check_00276 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line2_ex;
      print(speeza_j.screen6.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line2_ex = testData1s;
      print(speeza_j.screen6.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line2_ex = testData2s;
      print(speeza_j.screen6.line2_ex);
      expect(speeza_j.screen6.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line2_ex = defalut;
      print(speeza_j.screen6.line2_ex);
      expect(speeza_j.screen6.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00299_element_check_00276 **********\n\n");
    });

    test('00300_element_check_00277', () async {
      print("\n********** テスト実行：00300_element_check_00277 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line1_cn;
      print(speeza_j.screen6.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line1_cn = testData1s;
      print(speeza_j.screen6.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line1_cn = testData2s;
      print(speeza_j.screen6.line1_cn);
      expect(speeza_j.screen6.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line1_cn = defalut;
      print(speeza_j.screen6.line1_cn);
      expect(speeza_j.screen6.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00300_element_check_00277 **********\n\n");
    });

    test('00301_element_check_00278', () async {
      print("\n********** テスト実行：00301_element_check_00278 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line2_cn;
      print(speeza_j.screen6.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line2_cn = testData1s;
      print(speeza_j.screen6.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line2_cn = testData2s;
      print(speeza_j.screen6.line2_cn);
      expect(speeza_j.screen6.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line2_cn = defalut;
      print(speeza_j.screen6.line2_cn);
      expect(speeza_j.screen6.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00301_element_check_00278 **********\n\n");
    });

    test('00302_element_check_00279', () async {
      print("\n********** テスト実行：00302_element_check_00279 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line1_kor;
      print(speeza_j.screen6.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line1_kor = testData1s;
      print(speeza_j.screen6.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line1_kor = testData2s;
      print(speeza_j.screen6.line1_kor);
      expect(speeza_j.screen6.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line1_kor = defalut;
      print(speeza_j.screen6.line1_kor);
      expect(speeza_j.screen6.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00302_element_check_00279 **********\n\n");
    });

    test('00303_element_check_00280', () async {
      print("\n********** テスト実行：00303_element_check_00280 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.line2_kor;
      print(speeza_j.screen6.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.line2_kor = testData1s;
      print(speeza_j.screen6.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.line2_kor = testData2s;
      print(speeza_j.screen6.line2_kor);
      expect(speeza_j.screen6.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.line2_kor = defalut;
      print(speeza_j.screen6.line2_kor);
      expect(speeza_j.screen6.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00303_element_check_00280 **********\n\n");
    });

    test('00304_element_check_00281', () async {
      print("\n********** テスト実行：00304_element_check_00281 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg1;
      print(speeza_j.screen6.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg1 = testData1s;
      print(speeza_j.screen6.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg1 = testData2s;
      print(speeza_j.screen6.msg1);
      expect(speeza_j.screen6.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg1 = defalut;
      print(speeza_j.screen6.msg1);
      expect(speeza_j.screen6.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00304_element_check_00281 **********\n\n");
    });

    test('00305_element_check_00282', () async {
      print("\n********** テスト実行：00305_element_check_00282 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg2;
      print(speeza_j.screen6.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg2 = testData1s;
      print(speeza_j.screen6.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg2 = testData2s;
      print(speeza_j.screen6.msg2);
      expect(speeza_j.screen6.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg2 = defalut;
      print(speeza_j.screen6.msg2);
      expect(speeza_j.screen6.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00305_element_check_00282 **********\n\n");
    });

    test('00306_element_check_00283', () async {
      print("\n********** テスト実行：00306_element_check_00283 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg3;
      print(speeza_j.screen6.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg3 = testData1s;
      print(speeza_j.screen6.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg3 = testData2s;
      print(speeza_j.screen6.msg3);
      expect(speeza_j.screen6.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg3 = defalut;
      print(speeza_j.screen6.msg3);
      expect(speeza_j.screen6.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00306_element_check_00283 **********\n\n");
    });

    test('00307_element_check_00284', () async {
      print("\n********** テスト実行：00307_element_check_00284 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg4;
      print(speeza_j.screen6.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg4 = testData1s;
      print(speeza_j.screen6.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg4 = testData2s;
      print(speeza_j.screen6.msg4);
      expect(speeza_j.screen6.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg4 = defalut;
      print(speeza_j.screen6.msg4);
      expect(speeza_j.screen6.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00307_element_check_00284 **********\n\n");
    });

    test('00308_element_check_00285', () async {
      print("\n********** テスト実行：00308_element_check_00285 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg1_ex;
      print(speeza_j.screen6.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg1_ex = testData1s;
      print(speeza_j.screen6.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg1_ex = testData2s;
      print(speeza_j.screen6.msg1_ex);
      expect(speeza_j.screen6.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg1_ex = defalut;
      print(speeza_j.screen6.msg1_ex);
      expect(speeza_j.screen6.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00308_element_check_00285 **********\n\n");
    });

    test('00309_element_check_00286', () async {
      print("\n********** テスト実行：00309_element_check_00286 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg2_ex;
      print(speeza_j.screen6.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg2_ex = testData1s;
      print(speeza_j.screen6.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg2_ex = testData2s;
      print(speeza_j.screen6.msg2_ex);
      expect(speeza_j.screen6.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg2_ex = defalut;
      print(speeza_j.screen6.msg2_ex);
      expect(speeza_j.screen6.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00309_element_check_00286 **********\n\n");
    });

    test('00310_element_check_00287', () async {
      print("\n********** テスト実行：00310_element_check_00287 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg3_ex;
      print(speeza_j.screen6.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg3_ex = testData1s;
      print(speeza_j.screen6.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg3_ex = testData2s;
      print(speeza_j.screen6.msg3_ex);
      expect(speeza_j.screen6.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg3_ex = defalut;
      print(speeza_j.screen6.msg3_ex);
      expect(speeza_j.screen6.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00310_element_check_00287 **********\n\n");
    });

    test('00311_element_check_00288', () async {
      print("\n********** テスト実行：00311_element_check_00288 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg4_ex;
      print(speeza_j.screen6.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg4_ex = testData1s;
      print(speeza_j.screen6.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg4_ex = testData2s;
      print(speeza_j.screen6.msg4_ex);
      expect(speeza_j.screen6.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg4_ex = defalut;
      print(speeza_j.screen6.msg4_ex);
      expect(speeza_j.screen6.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00311_element_check_00288 **********\n\n");
    });

    test('00312_element_check_00289', () async {
      print("\n********** テスト実行：00312_element_check_00289 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg1_cn;
      print(speeza_j.screen6.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg1_cn = testData1s;
      print(speeza_j.screen6.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg1_cn = testData2s;
      print(speeza_j.screen6.msg1_cn);
      expect(speeza_j.screen6.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg1_cn = defalut;
      print(speeza_j.screen6.msg1_cn);
      expect(speeza_j.screen6.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00312_element_check_00289 **********\n\n");
    });

    test('00313_element_check_00290', () async {
      print("\n********** テスト実行：00313_element_check_00290 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg2_cn;
      print(speeza_j.screen6.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg2_cn = testData1s;
      print(speeza_j.screen6.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg2_cn = testData2s;
      print(speeza_j.screen6.msg2_cn);
      expect(speeza_j.screen6.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg2_cn = defalut;
      print(speeza_j.screen6.msg2_cn);
      expect(speeza_j.screen6.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00313_element_check_00290 **********\n\n");
    });

    test('00314_element_check_00291', () async {
      print("\n********** テスト実行：00314_element_check_00291 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg3_cn;
      print(speeza_j.screen6.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg3_cn = testData1s;
      print(speeza_j.screen6.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg3_cn = testData2s;
      print(speeza_j.screen6.msg3_cn);
      expect(speeza_j.screen6.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg3_cn = defalut;
      print(speeza_j.screen6.msg3_cn);
      expect(speeza_j.screen6.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00314_element_check_00291 **********\n\n");
    });

    test('00315_element_check_00292', () async {
      print("\n********** テスト実行：00315_element_check_00292 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg4_cn;
      print(speeza_j.screen6.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg4_cn = testData1s;
      print(speeza_j.screen6.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg4_cn = testData2s;
      print(speeza_j.screen6.msg4_cn);
      expect(speeza_j.screen6.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg4_cn = defalut;
      print(speeza_j.screen6.msg4_cn);
      expect(speeza_j.screen6.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00315_element_check_00292 **********\n\n");
    });

    test('00316_element_check_00293', () async {
      print("\n********** テスト実行：00316_element_check_00293 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg1_kor;
      print(speeza_j.screen6.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg1_kor = testData1s;
      print(speeza_j.screen6.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg1_kor = testData2s;
      print(speeza_j.screen6.msg1_kor);
      expect(speeza_j.screen6.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg1_kor = defalut;
      print(speeza_j.screen6.msg1_kor);
      expect(speeza_j.screen6.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00316_element_check_00293 **********\n\n");
    });

    test('00317_element_check_00294', () async {
      print("\n********** テスト実行：00317_element_check_00294 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg2_kor;
      print(speeza_j.screen6.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg2_kor = testData1s;
      print(speeza_j.screen6.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg2_kor = testData2s;
      print(speeza_j.screen6.msg2_kor);
      expect(speeza_j.screen6.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg2_kor = defalut;
      print(speeza_j.screen6.msg2_kor);
      expect(speeza_j.screen6.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00317_element_check_00294 **********\n\n");
    });

    test('00318_element_check_00295', () async {
      print("\n********** テスト実行：00318_element_check_00295 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg3_kor;
      print(speeza_j.screen6.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg3_kor = testData1s;
      print(speeza_j.screen6.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg3_kor = testData2s;
      print(speeza_j.screen6.msg3_kor);
      expect(speeza_j.screen6.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg3_kor = defalut;
      print(speeza_j.screen6.msg3_kor);
      expect(speeza_j.screen6.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00318_element_check_00295 **********\n\n");
    });

    test('00319_element_check_00296', () async {
      print("\n********** テスト実行：00319_element_check_00296 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.msg4_kor;
      print(speeza_j.screen6.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.msg4_kor = testData1s;
      print(speeza_j.screen6.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.msg4_kor = testData2s;
      print(speeza_j.screen6.msg4_kor);
      expect(speeza_j.screen6.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.msg4_kor = defalut;
      print(speeza_j.screen6.msg4_kor);
      expect(speeza_j.screen6.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00319_element_check_00296 **********\n\n");
    });

    test('00320_element_check_00297', () async {
      print("\n********** テスト実行：00320_element_check_00297 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc1;
      print(speeza_j.screen6.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc1 = testData1s;
      print(speeza_j.screen6.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc1 = testData2s;
      print(speeza_j.screen6.etc1);
      expect(speeza_j.screen6.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc1 = defalut;
      print(speeza_j.screen6.etc1);
      expect(speeza_j.screen6.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00320_element_check_00297 **********\n\n");
    });

    test('00321_element_check_00298', () async {
      print("\n********** テスト実行：00321_element_check_00298 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc2;
      print(speeza_j.screen6.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc2 = testData1s;
      print(speeza_j.screen6.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc2 = testData2s;
      print(speeza_j.screen6.etc2);
      expect(speeza_j.screen6.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc2 = defalut;
      print(speeza_j.screen6.etc2);
      expect(speeza_j.screen6.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00321_element_check_00298 **********\n\n");
    });

    test('00322_element_check_00299', () async {
      print("\n********** テスト実行：00322_element_check_00299 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc3;
      print(speeza_j.screen6.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc3 = testData1s;
      print(speeza_j.screen6.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc3 = testData2s;
      print(speeza_j.screen6.etc3);
      expect(speeza_j.screen6.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc3 = defalut;
      print(speeza_j.screen6.etc3);
      expect(speeza_j.screen6.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00322_element_check_00299 **********\n\n");
    });

    test('00323_element_check_00300', () async {
      print("\n********** テスト実行：00323_element_check_00300 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc4;
      print(speeza_j.screen6.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc4 = testData1s;
      print(speeza_j.screen6.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc4 = testData2s;
      print(speeza_j.screen6.etc4);
      expect(speeza_j.screen6.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc4 = defalut;
      print(speeza_j.screen6.etc4);
      expect(speeza_j.screen6.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00323_element_check_00300 **********\n\n");
    });

    test('00324_element_check_00301', () async {
      print("\n********** テスト実行：00324_element_check_00301 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc5;
      print(speeza_j.screen6.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc5 = testData1s;
      print(speeza_j.screen6.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc5 = testData2s;
      print(speeza_j.screen6.etc5);
      expect(speeza_j.screen6.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc5 = defalut;
      print(speeza_j.screen6.etc5);
      expect(speeza_j.screen6.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00324_element_check_00301 **********\n\n");
    });

    test('00325_element_check_00302', () async {
      print("\n********** テスト実行：00325_element_check_00302 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc1_ex;
      print(speeza_j.screen6.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc1_ex = testData1s;
      print(speeza_j.screen6.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc1_ex = testData2s;
      print(speeza_j.screen6.etc1_ex);
      expect(speeza_j.screen6.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc1_ex = defalut;
      print(speeza_j.screen6.etc1_ex);
      expect(speeza_j.screen6.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00325_element_check_00302 **********\n\n");
    });

    test('00326_element_check_00303', () async {
      print("\n********** テスト実行：00326_element_check_00303 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc2_ex;
      print(speeza_j.screen6.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc2_ex = testData1s;
      print(speeza_j.screen6.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc2_ex = testData2s;
      print(speeza_j.screen6.etc2_ex);
      expect(speeza_j.screen6.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc2_ex = defalut;
      print(speeza_j.screen6.etc2_ex);
      expect(speeza_j.screen6.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00326_element_check_00303 **********\n\n");
    });

    test('00327_element_check_00304', () async {
      print("\n********** テスト実行：00327_element_check_00304 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc3_ex;
      print(speeza_j.screen6.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc3_ex = testData1s;
      print(speeza_j.screen6.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc3_ex = testData2s;
      print(speeza_j.screen6.etc3_ex);
      expect(speeza_j.screen6.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc3_ex = defalut;
      print(speeza_j.screen6.etc3_ex);
      expect(speeza_j.screen6.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00327_element_check_00304 **********\n\n");
    });

    test('00328_element_check_00305', () async {
      print("\n********** テスト実行：00328_element_check_00305 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc4_ex;
      print(speeza_j.screen6.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc4_ex = testData1s;
      print(speeza_j.screen6.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc4_ex = testData2s;
      print(speeza_j.screen6.etc4_ex);
      expect(speeza_j.screen6.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc4_ex = defalut;
      print(speeza_j.screen6.etc4_ex);
      expect(speeza_j.screen6.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00328_element_check_00305 **********\n\n");
    });

    test('00329_element_check_00306', () async {
      print("\n********** テスト実行：00329_element_check_00306 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc5_ex;
      print(speeza_j.screen6.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc5_ex = testData1s;
      print(speeza_j.screen6.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc5_ex = testData2s;
      print(speeza_j.screen6.etc5_ex);
      expect(speeza_j.screen6.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc5_ex = defalut;
      print(speeza_j.screen6.etc5_ex);
      expect(speeza_j.screen6.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00329_element_check_00306 **********\n\n");
    });

    test('00330_element_check_00307', () async {
      print("\n********** テスト実行：00330_element_check_00307 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc1_cn;
      print(speeza_j.screen6.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc1_cn = testData1s;
      print(speeza_j.screen6.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc1_cn = testData2s;
      print(speeza_j.screen6.etc1_cn);
      expect(speeza_j.screen6.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc1_cn = defalut;
      print(speeza_j.screen6.etc1_cn);
      expect(speeza_j.screen6.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00330_element_check_00307 **********\n\n");
    });

    test('00331_element_check_00308', () async {
      print("\n********** テスト実行：00331_element_check_00308 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc2_cn;
      print(speeza_j.screen6.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc2_cn = testData1s;
      print(speeza_j.screen6.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc2_cn = testData2s;
      print(speeza_j.screen6.etc2_cn);
      expect(speeza_j.screen6.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc2_cn = defalut;
      print(speeza_j.screen6.etc2_cn);
      expect(speeza_j.screen6.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00331_element_check_00308 **********\n\n");
    });

    test('00332_element_check_00309', () async {
      print("\n********** テスト実行：00332_element_check_00309 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc3_cn;
      print(speeza_j.screen6.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc3_cn = testData1s;
      print(speeza_j.screen6.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc3_cn = testData2s;
      print(speeza_j.screen6.etc3_cn);
      expect(speeza_j.screen6.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc3_cn = defalut;
      print(speeza_j.screen6.etc3_cn);
      expect(speeza_j.screen6.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00332_element_check_00309 **********\n\n");
    });

    test('00333_element_check_00310', () async {
      print("\n********** テスト実行：00333_element_check_00310 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc4_cn;
      print(speeza_j.screen6.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc4_cn = testData1s;
      print(speeza_j.screen6.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc4_cn = testData2s;
      print(speeza_j.screen6.etc4_cn);
      expect(speeza_j.screen6.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc4_cn = defalut;
      print(speeza_j.screen6.etc4_cn);
      expect(speeza_j.screen6.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00333_element_check_00310 **********\n\n");
    });

    test('00334_element_check_00311', () async {
      print("\n********** テスト実行：00334_element_check_00311 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc5_cn;
      print(speeza_j.screen6.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc5_cn = testData1s;
      print(speeza_j.screen6.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc5_cn = testData2s;
      print(speeza_j.screen6.etc5_cn);
      expect(speeza_j.screen6.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc5_cn = defalut;
      print(speeza_j.screen6.etc5_cn);
      expect(speeza_j.screen6.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00334_element_check_00311 **********\n\n");
    });

    test('00335_element_check_00312', () async {
      print("\n********** テスト実行：00335_element_check_00312 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc1_kor;
      print(speeza_j.screen6.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc1_kor = testData1s;
      print(speeza_j.screen6.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc1_kor = testData2s;
      print(speeza_j.screen6.etc1_kor);
      expect(speeza_j.screen6.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc1_kor = defalut;
      print(speeza_j.screen6.etc1_kor);
      expect(speeza_j.screen6.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00335_element_check_00312 **********\n\n");
    });

    test('00336_element_check_00313', () async {
      print("\n********** テスト実行：00336_element_check_00313 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc2_kor;
      print(speeza_j.screen6.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc2_kor = testData1s;
      print(speeza_j.screen6.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc2_kor = testData2s;
      print(speeza_j.screen6.etc2_kor);
      expect(speeza_j.screen6.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc2_kor = defalut;
      print(speeza_j.screen6.etc2_kor);
      expect(speeza_j.screen6.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00336_element_check_00313 **********\n\n");
    });

    test('00337_element_check_00314', () async {
      print("\n********** テスト実行：00337_element_check_00314 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc3_kor;
      print(speeza_j.screen6.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc3_kor = testData1s;
      print(speeza_j.screen6.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc3_kor = testData2s;
      print(speeza_j.screen6.etc3_kor);
      expect(speeza_j.screen6.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc3_kor = defalut;
      print(speeza_j.screen6.etc3_kor);
      expect(speeza_j.screen6.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00337_element_check_00314 **********\n\n");
    });

    test('00338_element_check_00315', () async {
      print("\n********** テスト実行：00338_element_check_00315 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc4_kor;
      print(speeza_j.screen6.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc4_kor = testData1s;
      print(speeza_j.screen6.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc4_kor = testData2s;
      print(speeza_j.screen6.etc4_kor);
      expect(speeza_j.screen6.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc4_kor = defalut;
      print(speeza_j.screen6.etc4_kor);
      expect(speeza_j.screen6.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00338_element_check_00315 **********\n\n");
    });

    test('00339_element_check_00316', () async {
      print("\n********** テスト実行：00339_element_check_00316 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen6.etc5_kor;
      print(speeza_j.screen6.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen6.etc5_kor = testData1s;
      print(speeza_j.screen6.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen6.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen6.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen6.etc5_kor = testData2s;
      print(speeza_j.screen6.etc5_kor);
      expect(speeza_j.screen6.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen6.etc5_kor = defalut;
      print(speeza_j.screen6.etc5_kor);
      expect(speeza_j.screen6.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen6.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00339_element_check_00316 **********\n\n");
    });

    test('00340_element_check_00317', () async {
      print("\n********** テスト実行：00340_element_check_00317 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.title;
      print(speeza_j.screen7.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.title = testData1s;
      print(speeza_j.screen7.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.title = testData2s;
      print(speeza_j.screen7.title);
      expect(speeza_j.screen7.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.title = defalut;
      print(speeza_j.screen7.title);
      expect(speeza_j.screen7.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00340_element_check_00317 **********\n\n");
    });

    test('00341_element_check_00318', () async {
      print("\n********** テスト実行：00341_element_check_00318 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line1;
      print(speeza_j.screen7.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line1 = testData1s;
      print(speeza_j.screen7.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line1 = testData2s;
      print(speeza_j.screen7.line1);
      expect(speeza_j.screen7.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line1 = defalut;
      print(speeza_j.screen7.line1);
      expect(speeza_j.screen7.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00341_element_check_00318 **********\n\n");
    });

    test('00342_element_check_00319', () async {
      print("\n********** テスト実行：00342_element_check_00319 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line2;
      print(speeza_j.screen7.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line2 = testData1s;
      print(speeza_j.screen7.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line2 = testData2s;
      print(speeza_j.screen7.line2);
      expect(speeza_j.screen7.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line2 = defalut;
      print(speeza_j.screen7.line2);
      expect(speeza_j.screen7.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00342_element_check_00319 **********\n\n");
    });

    test('00343_element_check_00320', () async {
      print("\n********** テスト実行：00343_element_check_00320 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line1_ex;
      print(speeza_j.screen7.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line1_ex = testData1s;
      print(speeza_j.screen7.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line1_ex = testData2s;
      print(speeza_j.screen7.line1_ex);
      expect(speeza_j.screen7.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line1_ex = defalut;
      print(speeza_j.screen7.line1_ex);
      expect(speeza_j.screen7.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00343_element_check_00320 **********\n\n");
    });

    test('00344_element_check_00321', () async {
      print("\n********** テスト実行：00344_element_check_00321 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line2_ex;
      print(speeza_j.screen7.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line2_ex = testData1s;
      print(speeza_j.screen7.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line2_ex = testData2s;
      print(speeza_j.screen7.line2_ex);
      expect(speeza_j.screen7.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line2_ex = defalut;
      print(speeza_j.screen7.line2_ex);
      expect(speeza_j.screen7.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00344_element_check_00321 **********\n\n");
    });

    test('00345_element_check_00322', () async {
      print("\n********** テスト実行：00345_element_check_00322 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line1_cn;
      print(speeza_j.screen7.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line1_cn = testData1s;
      print(speeza_j.screen7.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line1_cn = testData2s;
      print(speeza_j.screen7.line1_cn);
      expect(speeza_j.screen7.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line1_cn = defalut;
      print(speeza_j.screen7.line1_cn);
      expect(speeza_j.screen7.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00345_element_check_00322 **********\n\n");
    });

    test('00346_element_check_00323', () async {
      print("\n********** テスト実行：00346_element_check_00323 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line2_cn;
      print(speeza_j.screen7.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line2_cn = testData1s;
      print(speeza_j.screen7.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line2_cn = testData2s;
      print(speeza_j.screen7.line2_cn);
      expect(speeza_j.screen7.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line2_cn = defalut;
      print(speeza_j.screen7.line2_cn);
      expect(speeza_j.screen7.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00346_element_check_00323 **********\n\n");
    });

    test('00347_element_check_00324', () async {
      print("\n********** テスト実行：00347_element_check_00324 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line1_kor;
      print(speeza_j.screen7.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line1_kor = testData1s;
      print(speeza_j.screen7.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line1_kor = testData2s;
      print(speeza_j.screen7.line1_kor);
      expect(speeza_j.screen7.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line1_kor = defalut;
      print(speeza_j.screen7.line1_kor);
      expect(speeza_j.screen7.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00347_element_check_00324 **********\n\n");
    });

    test('00348_element_check_00325', () async {
      print("\n********** テスト実行：00348_element_check_00325 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.line2_kor;
      print(speeza_j.screen7.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.line2_kor = testData1s;
      print(speeza_j.screen7.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.line2_kor = testData2s;
      print(speeza_j.screen7.line2_kor);
      expect(speeza_j.screen7.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.line2_kor = defalut;
      print(speeza_j.screen7.line2_kor);
      expect(speeza_j.screen7.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00348_element_check_00325 **********\n\n");
    });

    test('00349_element_check_00326', () async {
      print("\n********** テスト実行：00349_element_check_00326 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg1;
      print(speeza_j.screen7.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg1 = testData1s;
      print(speeza_j.screen7.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg1 = testData2s;
      print(speeza_j.screen7.msg1);
      expect(speeza_j.screen7.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg1 = defalut;
      print(speeza_j.screen7.msg1);
      expect(speeza_j.screen7.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00349_element_check_00326 **********\n\n");
    });

    test('00350_element_check_00327', () async {
      print("\n********** テスト実行：00350_element_check_00327 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg2;
      print(speeza_j.screen7.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg2 = testData1s;
      print(speeza_j.screen7.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg2 = testData2s;
      print(speeza_j.screen7.msg2);
      expect(speeza_j.screen7.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg2 = defalut;
      print(speeza_j.screen7.msg2);
      expect(speeza_j.screen7.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00350_element_check_00327 **********\n\n");
    });

    test('00351_element_check_00328', () async {
      print("\n********** テスト実行：00351_element_check_00328 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg3;
      print(speeza_j.screen7.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg3 = testData1s;
      print(speeza_j.screen7.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg3 = testData2s;
      print(speeza_j.screen7.msg3);
      expect(speeza_j.screen7.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg3 = defalut;
      print(speeza_j.screen7.msg3);
      expect(speeza_j.screen7.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00351_element_check_00328 **********\n\n");
    });

    test('00352_element_check_00329', () async {
      print("\n********** テスト実行：00352_element_check_00329 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg4;
      print(speeza_j.screen7.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg4 = testData1s;
      print(speeza_j.screen7.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg4 = testData2s;
      print(speeza_j.screen7.msg4);
      expect(speeza_j.screen7.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg4 = defalut;
      print(speeza_j.screen7.msg4);
      expect(speeza_j.screen7.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00352_element_check_00329 **********\n\n");
    });

    test('00353_element_check_00330', () async {
      print("\n********** テスト実行：00353_element_check_00330 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg1_ex;
      print(speeza_j.screen7.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg1_ex = testData1s;
      print(speeza_j.screen7.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg1_ex = testData2s;
      print(speeza_j.screen7.msg1_ex);
      expect(speeza_j.screen7.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg1_ex = defalut;
      print(speeza_j.screen7.msg1_ex);
      expect(speeza_j.screen7.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00353_element_check_00330 **********\n\n");
    });

    test('00354_element_check_00331', () async {
      print("\n********** テスト実行：00354_element_check_00331 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg2_ex;
      print(speeza_j.screen7.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg2_ex = testData1s;
      print(speeza_j.screen7.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg2_ex = testData2s;
      print(speeza_j.screen7.msg2_ex);
      expect(speeza_j.screen7.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg2_ex = defalut;
      print(speeza_j.screen7.msg2_ex);
      expect(speeza_j.screen7.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00354_element_check_00331 **********\n\n");
    });

    test('00355_element_check_00332', () async {
      print("\n********** テスト実行：00355_element_check_00332 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg3_ex;
      print(speeza_j.screen7.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg3_ex = testData1s;
      print(speeza_j.screen7.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg3_ex = testData2s;
      print(speeza_j.screen7.msg3_ex);
      expect(speeza_j.screen7.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg3_ex = defalut;
      print(speeza_j.screen7.msg3_ex);
      expect(speeza_j.screen7.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00355_element_check_00332 **********\n\n");
    });

    test('00356_element_check_00333', () async {
      print("\n********** テスト実行：00356_element_check_00333 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg4_ex;
      print(speeza_j.screen7.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg4_ex = testData1s;
      print(speeza_j.screen7.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg4_ex = testData2s;
      print(speeza_j.screen7.msg4_ex);
      expect(speeza_j.screen7.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg4_ex = defalut;
      print(speeza_j.screen7.msg4_ex);
      expect(speeza_j.screen7.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00356_element_check_00333 **********\n\n");
    });

    test('00357_element_check_00334', () async {
      print("\n********** テスト実行：00357_element_check_00334 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg1_cn;
      print(speeza_j.screen7.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg1_cn = testData1s;
      print(speeza_j.screen7.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg1_cn = testData2s;
      print(speeza_j.screen7.msg1_cn);
      expect(speeza_j.screen7.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg1_cn = defalut;
      print(speeza_j.screen7.msg1_cn);
      expect(speeza_j.screen7.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00357_element_check_00334 **********\n\n");
    });

    test('00358_element_check_00335', () async {
      print("\n********** テスト実行：00358_element_check_00335 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg2_cn;
      print(speeza_j.screen7.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg2_cn = testData1s;
      print(speeza_j.screen7.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg2_cn = testData2s;
      print(speeza_j.screen7.msg2_cn);
      expect(speeza_j.screen7.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg2_cn = defalut;
      print(speeza_j.screen7.msg2_cn);
      expect(speeza_j.screen7.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00358_element_check_00335 **********\n\n");
    });

    test('00359_element_check_00336', () async {
      print("\n********** テスト実行：00359_element_check_00336 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg3_cn;
      print(speeza_j.screen7.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg3_cn = testData1s;
      print(speeza_j.screen7.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg3_cn = testData2s;
      print(speeza_j.screen7.msg3_cn);
      expect(speeza_j.screen7.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg3_cn = defalut;
      print(speeza_j.screen7.msg3_cn);
      expect(speeza_j.screen7.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00359_element_check_00336 **********\n\n");
    });

    test('00360_element_check_00337', () async {
      print("\n********** テスト実行：00360_element_check_00337 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg4_cn;
      print(speeza_j.screen7.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg4_cn = testData1s;
      print(speeza_j.screen7.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg4_cn = testData2s;
      print(speeza_j.screen7.msg4_cn);
      expect(speeza_j.screen7.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg4_cn = defalut;
      print(speeza_j.screen7.msg4_cn);
      expect(speeza_j.screen7.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00360_element_check_00337 **********\n\n");
    });

    test('00361_element_check_00338', () async {
      print("\n********** テスト実行：00361_element_check_00338 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg1_kor;
      print(speeza_j.screen7.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg1_kor = testData1s;
      print(speeza_j.screen7.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg1_kor = testData2s;
      print(speeza_j.screen7.msg1_kor);
      expect(speeza_j.screen7.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg1_kor = defalut;
      print(speeza_j.screen7.msg1_kor);
      expect(speeza_j.screen7.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00361_element_check_00338 **********\n\n");
    });

    test('00362_element_check_00339', () async {
      print("\n********** テスト実行：00362_element_check_00339 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg2_kor;
      print(speeza_j.screen7.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg2_kor = testData1s;
      print(speeza_j.screen7.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg2_kor = testData2s;
      print(speeza_j.screen7.msg2_kor);
      expect(speeza_j.screen7.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg2_kor = defalut;
      print(speeza_j.screen7.msg2_kor);
      expect(speeza_j.screen7.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00362_element_check_00339 **********\n\n");
    });

    test('00363_element_check_00340', () async {
      print("\n********** テスト実行：00363_element_check_00340 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg3_kor;
      print(speeza_j.screen7.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg3_kor = testData1s;
      print(speeza_j.screen7.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg3_kor = testData2s;
      print(speeza_j.screen7.msg3_kor);
      expect(speeza_j.screen7.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg3_kor = defalut;
      print(speeza_j.screen7.msg3_kor);
      expect(speeza_j.screen7.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00363_element_check_00340 **********\n\n");
    });

    test('00364_element_check_00341', () async {
      print("\n********** テスト実行：00364_element_check_00341 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.msg4_kor;
      print(speeza_j.screen7.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.msg4_kor = testData1s;
      print(speeza_j.screen7.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.msg4_kor = testData2s;
      print(speeza_j.screen7.msg4_kor);
      expect(speeza_j.screen7.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.msg4_kor = defalut;
      print(speeza_j.screen7.msg4_kor);
      expect(speeza_j.screen7.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00364_element_check_00341 **********\n\n");
    });

    test('00365_element_check_00342', () async {
      print("\n********** テスト実行：00365_element_check_00342 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc1;
      print(speeza_j.screen7.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc1 = testData1s;
      print(speeza_j.screen7.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc1 = testData2s;
      print(speeza_j.screen7.etc1);
      expect(speeza_j.screen7.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc1 = defalut;
      print(speeza_j.screen7.etc1);
      expect(speeza_j.screen7.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00365_element_check_00342 **********\n\n");
    });

    test('00366_element_check_00343', () async {
      print("\n********** テスト実行：00366_element_check_00343 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc2;
      print(speeza_j.screen7.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc2 = testData1s;
      print(speeza_j.screen7.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc2 = testData2s;
      print(speeza_j.screen7.etc2);
      expect(speeza_j.screen7.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc2 = defalut;
      print(speeza_j.screen7.etc2);
      expect(speeza_j.screen7.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00366_element_check_00343 **********\n\n");
    });

    test('00367_element_check_00344', () async {
      print("\n********** テスト実行：00367_element_check_00344 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc3;
      print(speeza_j.screen7.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc3 = testData1s;
      print(speeza_j.screen7.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc3 = testData2s;
      print(speeza_j.screen7.etc3);
      expect(speeza_j.screen7.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc3 = defalut;
      print(speeza_j.screen7.etc3);
      expect(speeza_j.screen7.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00367_element_check_00344 **********\n\n");
    });

    test('00368_element_check_00345', () async {
      print("\n********** テスト実行：00368_element_check_00345 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc4;
      print(speeza_j.screen7.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc4 = testData1s;
      print(speeza_j.screen7.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc4 = testData2s;
      print(speeza_j.screen7.etc4);
      expect(speeza_j.screen7.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc4 = defalut;
      print(speeza_j.screen7.etc4);
      expect(speeza_j.screen7.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00368_element_check_00345 **********\n\n");
    });

    test('00369_element_check_00346', () async {
      print("\n********** テスト実行：00369_element_check_00346 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc5;
      print(speeza_j.screen7.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc5 = testData1s;
      print(speeza_j.screen7.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc5 = testData2s;
      print(speeza_j.screen7.etc5);
      expect(speeza_j.screen7.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc5 = defalut;
      print(speeza_j.screen7.etc5);
      expect(speeza_j.screen7.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00369_element_check_00346 **********\n\n");
    });

    test('00370_element_check_00347', () async {
      print("\n********** テスト実行：00370_element_check_00347 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc1_ex;
      print(speeza_j.screen7.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc1_ex = testData1s;
      print(speeza_j.screen7.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc1_ex = testData2s;
      print(speeza_j.screen7.etc1_ex);
      expect(speeza_j.screen7.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc1_ex = defalut;
      print(speeza_j.screen7.etc1_ex);
      expect(speeza_j.screen7.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00370_element_check_00347 **********\n\n");
    });

    test('00371_element_check_00348', () async {
      print("\n********** テスト実行：00371_element_check_00348 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc2_ex;
      print(speeza_j.screen7.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc2_ex = testData1s;
      print(speeza_j.screen7.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc2_ex = testData2s;
      print(speeza_j.screen7.etc2_ex);
      expect(speeza_j.screen7.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc2_ex = defalut;
      print(speeza_j.screen7.etc2_ex);
      expect(speeza_j.screen7.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00371_element_check_00348 **********\n\n");
    });

    test('00372_element_check_00349', () async {
      print("\n********** テスト実行：00372_element_check_00349 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc3_ex;
      print(speeza_j.screen7.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc3_ex = testData1s;
      print(speeza_j.screen7.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc3_ex = testData2s;
      print(speeza_j.screen7.etc3_ex);
      expect(speeza_j.screen7.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc3_ex = defalut;
      print(speeza_j.screen7.etc3_ex);
      expect(speeza_j.screen7.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00372_element_check_00349 **********\n\n");
    });

    test('00373_element_check_00350', () async {
      print("\n********** テスト実行：00373_element_check_00350 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc4_ex;
      print(speeza_j.screen7.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc4_ex = testData1s;
      print(speeza_j.screen7.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc4_ex = testData2s;
      print(speeza_j.screen7.etc4_ex);
      expect(speeza_j.screen7.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc4_ex = defalut;
      print(speeza_j.screen7.etc4_ex);
      expect(speeza_j.screen7.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00373_element_check_00350 **********\n\n");
    });

    test('00374_element_check_00351', () async {
      print("\n********** テスト実行：00374_element_check_00351 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc5_ex;
      print(speeza_j.screen7.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc5_ex = testData1s;
      print(speeza_j.screen7.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc5_ex = testData2s;
      print(speeza_j.screen7.etc5_ex);
      expect(speeza_j.screen7.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc5_ex = defalut;
      print(speeza_j.screen7.etc5_ex);
      expect(speeza_j.screen7.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00374_element_check_00351 **********\n\n");
    });

    test('00375_element_check_00352', () async {
      print("\n********** テスト実行：00375_element_check_00352 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc1_cn;
      print(speeza_j.screen7.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc1_cn = testData1s;
      print(speeza_j.screen7.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc1_cn = testData2s;
      print(speeza_j.screen7.etc1_cn);
      expect(speeza_j.screen7.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc1_cn = defalut;
      print(speeza_j.screen7.etc1_cn);
      expect(speeza_j.screen7.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00375_element_check_00352 **********\n\n");
    });

    test('00376_element_check_00353', () async {
      print("\n********** テスト実行：00376_element_check_00353 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc2_cn;
      print(speeza_j.screen7.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc2_cn = testData1s;
      print(speeza_j.screen7.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc2_cn = testData2s;
      print(speeza_j.screen7.etc2_cn);
      expect(speeza_j.screen7.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc2_cn = defalut;
      print(speeza_j.screen7.etc2_cn);
      expect(speeza_j.screen7.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00376_element_check_00353 **********\n\n");
    });

    test('00377_element_check_00354', () async {
      print("\n********** テスト実行：00377_element_check_00354 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc3_cn;
      print(speeza_j.screen7.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc3_cn = testData1s;
      print(speeza_j.screen7.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc3_cn = testData2s;
      print(speeza_j.screen7.etc3_cn);
      expect(speeza_j.screen7.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc3_cn = defalut;
      print(speeza_j.screen7.etc3_cn);
      expect(speeza_j.screen7.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00377_element_check_00354 **********\n\n");
    });

    test('00378_element_check_00355', () async {
      print("\n********** テスト実行：00378_element_check_00355 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc4_cn;
      print(speeza_j.screen7.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc4_cn = testData1s;
      print(speeza_j.screen7.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc4_cn = testData2s;
      print(speeza_j.screen7.etc4_cn);
      expect(speeza_j.screen7.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc4_cn = defalut;
      print(speeza_j.screen7.etc4_cn);
      expect(speeza_j.screen7.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00378_element_check_00355 **********\n\n");
    });

    test('00379_element_check_00356', () async {
      print("\n********** テスト実行：00379_element_check_00356 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc5_cn;
      print(speeza_j.screen7.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc5_cn = testData1s;
      print(speeza_j.screen7.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc5_cn = testData2s;
      print(speeza_j.screen7.etc5_cn);
      expect(speeza_j.screen7.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc5_cn = defalut;
      print(speeza_j.screen7.etc5_cn);
      expect(speeza_j.screen7.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00379_element_check_00356 **********\n\n");
    });

    test('00380_element_check_00357', () async {
      print("\n********** テスト実行：00380_element_check_00357 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc1_kor;
      print(speeza_j.screen7.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc1_kor = testData1s;
      print(speeza_j.screen7.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc1_kor = testData2s;
      print(speeza_j.screen7.etc1_kor);
      expect(speeza_j.screen7.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc1_kor = defalut;
      print(speeza_j.screen7.etc1_kor);
      expect(speeza_j.screen7.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00380_element_check_00357 **********\n\n");
    });

    test('00381_element_check_00358', () async {
      print("\n********** テスト実行：00381_element_check_00358 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc2_kor;
      print(speeza_j.screen7.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc2_kor = testData1s;
      print(speeza_j.screen7.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc2_kor = testData2s;
      print(speeza_j.screen7.etc2_kor);
      expect(speeza_j.screen7.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc2_kor = defalut;
      print(speeza_j.screen7.etc2_kor);
      expect(speeza_j.screen7.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00381_element_check_00358 **********\n\n");
    });

    test('00382_element_check_00359', () async {
      print("\n********** テスト実行：00382_element_check_00359 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc3_kor;
      print(speeza_j.screen7.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc3_kor = testData1s;
      print(speeza_j.screen7.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc3_kor = testData2s;
      print(speeza_j.screen7.etc3_kor);
      expect(speeza_j.screen7.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc3_kor = defalut;
      print(speeza_j.screen7.etc3_kor);
      expect(speeza_j.screen7.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00382_element_check_00359 **********\n\n");
    });

    test('00383_element_check_00360', () async {
      print("\n********** テスト実行：00383_element_check_00360 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc4_kor;
      print(speeza_j.screen7.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc4_kor = testData1s;
      print(speeza_j.screen7.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc4_kor = testData2s;
      print(speeza_j.screen7.etc4_kor);
      expect(speeza_j.screen7.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc4_kor = defalut;
      print(speeza_j.screen7.etc4_kor);
      expect(speeza_j.screen7.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00383_element_check_00360 **********\n\n");
    });

    test('00384_element_check_00361', () async {
      print("\n********** テスト実行：00384_element_check_00361 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen7.etc5_kor;
      print(speeza_j.screen7.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen7.etc5_kor = testData1s;
      print(speeza_j.screen7.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen7.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen7.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen7.etc5_kor = testData2s;
      print(speeza_j.screen7.etc5_kor);
      expect(speeza_j.screen7.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen7.etc5_kor = defalut;
      print(speeza_j.screen7.etc5_kor);
      expect(speeza_j.screen7.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen7.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00384_element_check_00361 **********\n\n");
    });

    test('00385_element_check_00362', () async {
      print("\n********** テスト実行：00385_element_check_00362 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.title;
      print(speeza_j.screen8.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.title = testData1s;
      print(speeza_j.screen8.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.title = testData2s;
      print(speeza_j.screen8.title);
      expect(speeza_j.screen8.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.title = defalut;
      print(speeza_j.screen8.title);
      expect(speeza_j.screen8.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00385_element_check_00362 **********\n\n");
    });

    test('00386_element_check_00363', () async {
      print("\n********** テスト実行：00386_element_check_00363 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line1;
      print(speeza_j.screen8.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line1 = testData1s;
      print(speeza_j.screen8.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line1 = testData2s;
      print(speeza_j.screen8.line1);
      expect(speeza_j.screen8.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line1 = defalut;
      print(speeza_j.screen8.line1);
      expect(speeza_j.screen8.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00386_element_check_00363 **********\n\n");
    });

    test('00387_element_check_00364', () async {
      print("\n********** テスト実行：00387_element_check_00364 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line2;
      print(speeza_j.screen8.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line2 = testData1s;
      print(speeza_j.screen8.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line2 = testData2s;
      print(speeza_j.screen8.line2);
      expect(speeza_j.screen8.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line2 = defalut;
      print(speeza_j.screen8.line2);
      expect(speeza_j.screen8.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00387_element_check_00364 **********\n\n");
    });

    test('00388_element_check_00365', () async {
      print("\n********** テスト実行：00388_element_check_00365 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line1_ex;
      print(speeza_j.screen8.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line1_ex = testData1s;
      print(speeza_j.screen8.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line1_ex = testData2s;
      print(speeza_j.screen8.line1_ex);
      expect(speeza_j.screen8.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line1_ex = defalut;
      print(speeza_j.screen8.line1_ex);
      expect(speeza_j.screen8.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00388_element_check_00365 **********\n\n");
    });

    test('00389_element_check_00366', () async {
      print("\n********** テスト実行：00389_element_check_00366 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line2_ex;
      print(speeza_j.screen8.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line2_ex = testData1s;
      print(speeza_j.screen8.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line2_ex = testData2s;
      print(speeza_j.screen8.line2_ex);
      expect(speeza_j.screen8.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line2_ex = defalut;
      print(speeza_j.screen8.line2_ex);
      expect(speeza_j.screen8.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00389_element_check_00366 **********\n\n");
    });

    test('00390_element_check_00367', () async {
      print("\n********** テスト実行：00390_element_check_00367 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line1_cn;
      print(speeza_j.screen8.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line1_cn = testData1s;
      print(speeza_j.screen8.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line1_cn = testData2s;
      print(speeza_j.screen8.line1_cn);
      expect(speeza_j.screen8.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line1_cn = defalut;
      print(speeza_j.screen8.line1_cn);
      expect(speeza_j.screen8.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00390_element_check_00367 **********\n\n");
    });

    test('00391_element_check_00368', () async {
      print("\n********** テスト実行：00391_element_check_00368 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line2_cn;
      print(speeza_j.screen8.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line2_cn = testData1s;
      print(speeza_j.screen8.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line2_cn = testData2s;
      print(speeza_j.screen8.line2_cn);
      expect(speeza_j.screen8.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line2_cn = defalut;
      print(speeza_j.screen8.line2_cn);
      expect(speeza_j.screen8.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00391_element_check_00368 **********\n\n");
    });

    test('00392_element_check_00369', () async {
      print("\n********** テスト実行：00392_element_check_00369 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line1_kor;
      print(speeza_j.screen8.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line1_kor = testData1s;
      print(speeza_j.screen8.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line1_kor = testData2s;
      print(speeza_j.screen8.line1_kor);
      expect(speeza_j.screen8.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line1_kor = defalut;
      print(speeza_j.screen8.line1_kor);
      expect(speeza_j.screen8.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00392_element_check_00369 **********\n\n");
    });

    test('00393_element_check_00370', () async {
      print("\n********** テスト実行：00393_element_check_00370 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.line2_kor;
      print(speeza_j.screen8.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.line2_kor = testData1s;
      print(speeza_j.screen8.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.line2_kor = testData2s;
      print(speeza_j.screen8.line2_kor);
      expect(speeza_j.screen8.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.line2_kor = defalut;
      print(speeza_j.screen8.line2_kor);
      expect(speeza_j.screen8.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00393_element_check_00370 **********\n\n");
    });

    test('00394_element_check_00371', () async {
      print("\n********** テスト実行：00394_element_check_00371 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg1;
      print(speeza_j.screen8.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg1 = testData1s;
      print(speeza_j.screen8.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg1 = testData2s;
      print(speeza_j.screen8.msg1);
      expect(speeza_j.screen8.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg1 = defalut;
      print(speeza_j.screen8.msg1);
      expect(speeza_j.screen8.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00394_element_check_00371 **********\n\n");
    });

    test('00395_element_check_00372', () async {
      print("\n********** テスト実行：00395_element_check_00372 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg2;
      print(speeza_j.screen8.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg2 = testData1s;
      print(speeza_j.screen8.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg2 = testData2s;
      print(speeza_j.screen8.msg2);
      expect(speeza_j.screen8.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg2 = defalut;
      print(speeza_j.screen8.msg2);
      expect(speeza_j.screen8.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00395_element_check_00372 **********\n\n");
    });

    test('00396_element_check_00373', () async {
      print("\n********** テスト実行：00396_element_check_00373 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg3;
      print(speeza_j.screen8.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg3 = testData1s;
      print(speeza_j.screen8.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg3 = testData2s;
      print(speeza_j.screen8.msg3);
      expect(speeza_j.screen8.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg3 = defalut;
      print(speeza_j.screen8.msg3);
      expect(speeza_j.screen8.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00396_element_check_00373 **********\n\n");
    });

    test('00397_element_check_00374', () async {
      print("\n********** テスト実行：00397_element_check_00374 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg4;
      print(speeza_j.screen8.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg4 = testData1s;
      print(speeza_j.screen8.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg4 = testData2s;
      print(speeza_j.screen8.msg4);
      expect(speeza_j.screen8.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg4 = defalut;
      print(speeza_j.screen8.msg4);
      expect(speeza_j.screen8.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00397_element_check_00374 **********\n\n");
    });

    test('00398_element_check_00375', () async {
      print("\n********** テスト実行：00398_element_check_00375 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg1_ex;
      print(speeza_j.screen8.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg1_ex = testData1s;
      print(speeza_j.screen8.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg1_ex = testData2s;
      print(speeza_j.screen8.msg1_ex);
      expect(speeza_j.screen8.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg1_ex = defalut;
      print(speeza_j.screen8.msg1_ex);
      expect(speeza_j.screen8.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00398_element_check_00375 **********\n\n");
    });

    test('00399_element_check_00376', () async {
      print("\n********** テスト実行：00399_element_check_00376 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg2_ex;
      print(speeza_j.screen8.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg2_ex = testData1s;
      print(speeza_j.screen8.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg2_ex = testData2s;
      print(speeza_j.screen8.msg2_ex);
      expect(speeza_j.screen8.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg2_ex = defalut;
      print(speeza_j.screen8.msg2_ex);
      expect(speeza_j.screen8.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00399_element_check_00376 **********\n\n");
    });

    test('00400_element_check_00377', () async {
      print("\n********** テスト実行：00400_element_check_00377 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg3_ex;
      print(speeza_j.screen8.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg3_ex = testData1s;
      print(speeza_j.screen8.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg3_ex = testData2s;
      print(speeza_j.screen8.msg3_ex);
      expect(speeza_j.screen8.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg3_ex = defalut;
      print(speeza_j.screen8.msg3_ex);
      expect(speeza_j.screen8.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00400_element_check_00377 **********\n\n");
    });

    test('00401_element_check_00378', () async {
      print("\n********** テスト実行：00401_element_check_00378 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg4_ex;
      print(speeza_j.screen8.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg4_ex = testData1s;
      print(speeza_j.screen8.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg4_ex = testData2s;
      print(speeza_j.screen8.msg4_ex);
      expect(speeza_j.screen8.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg4_ex = defalut;
      print(speeza_j.screen8.msg4_ex);
      expect(speeza_j.screen8.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00401_element_check_00378 **********\n\n");
    });

    test('00402_element_check_00379', () async {
      print("\n********** テスト実行：00402_element_check_00379 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg1_cn;
      print(speeza_j.screen8.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg1_cn = testData1s;
      print(speeza_j.screen8.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg1_cn = testData2s;
      print(speeza_j.screen8.msg1_cn);
      expect(speeza_j.screen8.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg1_cn = defalut;
      print(speeza_j.screen8.msg1_cn);
      expect(speeza_j.screen8.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00402_element_check_00379 **********\n\n");
    });

    test('00403_element_check_00380', () async {
      print("\n********** テスト実行：00403_element_check_00380 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg2_cn;
      print(speeza_j.screen8.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg2_cn = testData1s;
      print(speeza_j.screen8.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg2_cn = testData2s;
      print(speeza_j.screen8.msg2_cn);
      expect(speeza_j.screen8.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg2_cn = defalut;
      print(speeza_j.screen8.msg2_cn);
      expect(speeza_j.screen8.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00403_element_check_00380 **********\n\n");
    });

    test('00404_element_check_00381', () async {
      print("\n********** テスト実行：00404_element_check_00381 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg3_cn;
      print(speeza_j.screen8.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg3_cn = testData1s;
      print(speeza_j.screen8.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg3_cn = testData2s;
      print(speeza_j.screen8.msg3_cn);
      expect(speeza_j.screen8.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg3_cn = defalut;
      print(speeza_j.screen8.msg3_cn);
      expect(speeza_j.screen8.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00404_element_check_00381 **********\n\n");
    });

    test('00405_element_check_00382', () async {
      print("\n********** テスト実行：00405_element_check_00382 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg4_cn;
      print(speeza_j.screen8.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg4_cn = testData1s;
      print(speeza_j.screen8.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg4_cn = testData2s;
      print(speeza_j.screen8.msg4_cn);
      expect(speeza_j.screen8.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg4_cn = defalut;
      print(speeza_j.screen8.msg4_cn);
      expect(speeza_j.screen8.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00405_element_check_00382 **********\n\n");
    });

    test('00406_element_check_00383', () async {
      print("\n********** テスト実行：00406_element_check_00383 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg1_kor;
      print(speeza_j.screen8.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg1_kor = testData1s;
      print(speeza_j.screen8.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg1_kor = testData2s;
      print(speeza_j.screen8.msg1_kor);
      expect(speeza_j.screen8.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg1_kor = defalut;
      print(speeza_j.screen8.msg1_kor);
      expect(speeza_j.screen8.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00406_element_check_00383 **********\n\n");
    });

    test('00407_element_check_00384', () async {
      print("\n********** テスト実行：00407_element_check_00384 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg2_kor;
      print(speeza_j.screen8.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg2_kor = testData1s;
      print(speeza_j.screen8.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg2_kor = testData2s;
      print(speeza_j.screen8.msg2_kor);
      expect(speeza_j.screen8.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg2_kor = defalut;
      print(speeza_j.screen8.msg2_kor);
      expect(speeza_j.screen8.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00407_element_check_00384 **********\n\n");
    });

    test('00408_element_check_00385', () async {
      print("\n********** テスト実行：00408_element_check_00385 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg3_kor;
      print(speeza_j.screen8.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg3_kor = testData1s;
      print(speeza_j.screen8.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg3_kor = testData2s;
      print(speeza_j.screen8.msg3_kor);
      expect(speeza_j.screen8.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg3_kor = defalut;
      print(speeza_j.screen8.msg3_kor);
      expect(speeza_j.screen8.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00408_element_check_00385 **********\n\n");
    });

    test('00409_element_check_00386', () async {
      print("\n********** テスト実行：00409_element_check_00386 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.msg4_kor;
      print(speeza_j.screen8.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.msg4_kor = testData1s;
      print(speeza_j.screen8.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.msg4_kor = testData2s;
      print(speeza_j.screen8.msg4_kor);
      expect(speeza_j.screen8.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.msg4_kor = defalut;
      print(speeza_j.screen8.msg4_kor);
      expect(speeza_j.screen8.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00409_element_check_00386 **********\n\n");
    });

    test('00410_element_check_00387', () async {
      print("\n********** テスト実行：00410_element_check_00387 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc1;
      print(speeza_j.screen8.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc1 = testData1s;
      print(speeza_j.screen8.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc1 = testData2s;
      print(speeza_j.screen8.etc1);
      expect(speeza_j.screen8.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc1 = defalut;
      print(speeza_j.screen8.etc1);
      expect(speeza_j.screen8.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00410_element_check_00387 **********\n\n");
    });

    test('00411_element_check_00388', () async {
      print("\n********** テスト実行：00411_element_check_00388 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc2;
      print(speeza_j.screen8.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc2 = testData1s;
      print(speeza_j.screen8.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc2 = testData2s;
      print(speeza_j.screen8.etc2);
      expect(speeza_j.screen8.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc2 = defalut;
      print(speeza_j.screen8.etc2);
      expect(speeza_j.screen8.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00411_element_check_00388 **********\n\n");
    });

    test('00412_element_check_00389', () async {
      print("\n********** テスト実行：00412_element_check_00389 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc3;
      print(speeza_j.screen8.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc3 = testData1s;
      print(speeza_j.screen8.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc3 = testData2s;
      print(speeza_j.screen8.etc3);
      expect(speeza_j.screen8.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc3 = defalut;
      print(speeza_j.screen8.etc3);
      expect(speeza_j.screen8.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00412_element_check_00389 **********\n\n");
    });

    test('00413_element_check_00390', () async {
      print("\n********** テスト実行：00413_element_check_00390 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc4;
      print(speeza_j.screen8.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc4 = testData1s;
      print(speeza_j.screen8.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc4 = testData2s;
      print(speeza_j.screen8.etc4);
      expect(speeza_j.screen8.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc4 = defalut;
      print(speeza_j.screen8.etc4);
      expect(speeza_j.screen8.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00413_element_check_00390 **********\n\n");
    });

    test('00414_element_check_00391', () async {
      print("\n********** テスト実行：00414_element_check_00391 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc5;
      print(speeza_j.screen8.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc5 = testData1s;
      print(speeza_j.screen8.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc5 = testData2s;
      print(speeza_j.screen8.etc5);
      expect(speeza_j.screen8.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc5 = defalut;
      print(speeza_j.screen8.etc5);
      expect(speeza_j.screen8.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00414_element_check_00391 **********\n\n");
    });

    test('00415_element_check_00392', () async {
      print("\n********** テスト実行：00415_element_check_00392 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc1_ex;
      print(speeza_j.screen8.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc1_ex = testData1s;
      print(speeza_j.screen8.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc1_ex = testData2s;
      print(speeza_j.screen8.etc1_ex);
      expect(speeza_j.screen8.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc1_ex = defalut;
      print(speeza_j.screen8.etc1_ex);
      expect(speeza_j.screen8.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00415_element_check_00392 **********\n\n");
    });

    test('00416_element_check_00393', () async {
      print("\n********** テスト実行：00416_element_check_00393 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc2_ex;
      print(speeza_j.screen8.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc2_ex = testData1s;
      print(speeza_j.screen8.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc2_ex = testData2s;
      print(speeza_j.screen8.etc2_ex);
      expect(speeza_j.screen8.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc2_ex = defalut;
      print(speeza_j.screen8.etc2_ex);
      expect(speeza_j.screen8.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00416_element_check_00393 **********\n\n");
    });

    test('00417_element_check_00394', () async {
      print("\n********** テスト実行：00417_element_check_00394 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc3_ex;
      print(speeza_j.screen8.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc3_ex = testData1s;
      print(speeza_j.screen8.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc3_ex = testData2s;
      print(speeza_j.screen8.etc3_ex);
      expect(speeza_j.screen8.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc3_ex = defalut;
      print(speeza_j.screen8.etc3_ex);
      expect(speeza_j.screen8.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00417_element_check_00394 **********\n\n");
    });

    test('00418_element_check_00395', () async {
      print("\n********** テスト実行：00418_element_check_00395 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc4_ex;
      print(speeza_j.screen8.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc4_ex = testData1s;
      print(speeza_j.screen8.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc4_ex = testData2s;
      print(speeza_j.screen8.etc4_ex);
      expect(speeza_j.screen8.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc4_ex = defalut;
      print(speeza_j.screen8.etc4_ex);
      expect(speeza_j.screen8.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00418_element_check_00395 **********\n\n");
    });

    test('00419_element_check_00396', () async {
      print("\n********** テスト実行：00419_element_check_00396 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc5_ex;
      print(speeza_j.screen8.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc5_ex = testData1s;
      print(speeza_j.screen8.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc5_ex = testData2s;
      print(speeza_j.screen8.etc5_ex);
      expect(speeza_j.screen8.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc5_ex = defalut;
      print(speeza_j.screen8.etc5_ex);
      expect(speeza_j.screen8.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00419_element_check_00396 **********\n\n");
    });

    test('00420_element_check_00397', () async {
      print("\n********** テスト実行：00420_element_check_00397 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc1_cn;
      print(speeza_j.screen8.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc1_cn = testData1s;
      print(speeza_j.screen8.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc1_cn = testData2s;
      print(speeza_j.screen8.etc1_cn);
      expect(speeza_j.screen8.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc1_cn = defalut;
      print(speeza_j.screen8.etc1_cn);
      expect(speeza_j.screen8.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00420_element_check_00397 **********\n\n");
    });

    test('00421_element_check_00398', () async {
      print("\n********** テスト実行：00421_element_check_00398 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc2_cn;
      print(speeza_j.screen8.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc2_cn = testData1s;
      print(speeza_j.screen8.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc2_cn = testData2s;
      print(speeza_j.screen8.etc2_cn);
      expect(speeza_j.screen8.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc2_cn = defalut;
      print(speeza_j.screen8.etc2_cn);
      expect(speeza_j.screen8.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00421_element_check_00398 **********\n\n");
    });

    test('00422_element_check_00399', () async {
      print("\n********** テスト実行：00422_element_check_00399 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc3_cn;
      print(speeza_j.screen8.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc3_cn = testData1s;
      print(speeza_j.screen8.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc3_cn = testData2s;
      print(speeza_j.screen8.etc3_cn);
      expect(speeza_j.screen8.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc3_cn = defalut;
      print(speeza_j.screen8.etc3_cn);
      expect(speeza_j.screen8.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00422_element_check_00399 **********\n\n");
    });

    test('00423_element_check_00400', () async {
      print("\n********** テスト実行：00423_element_check_00400 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc4_cn;
      print(speeza_j.screen8.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc4_cn = testData1s;
      print(speeza_j.screen8.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc4_cn = testData2s;
      print(speeza_j.screen8.etc4_cn);
      expect(speeza_j.screen8.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc4_cn = defalut;
      print(speeza_j.screen8.etc4_cn);
      expect(speeza_j.screen8.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00423_element_check_00400 **********\n\n");
    });

    test('00424_element_check_00401', () async {
      print("\n********** テスト実行：00424_element_check_00401 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc5_cn;
      print(speeza_j.screen8.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc5_cn = testData1s;
      print(speeza_j.screen8.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc5_cn = testData2s;
      print(speeza_j.screen8.etc5_cn);
      expect(speeza_j.screen8.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc5_cn = defalut;
      print(speeza_j.screen8.etc5_cn);
      expect(speeza_j.screen8.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00424_element_check_00401 **********\n\n");
    });

    test('00425_element_check_00402', () async {
      print("\n********** テスト実行：00425_element_check_00402 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc1_kor;
      print(speeza_j.screen8.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc1_kor = testData1s;
      print(speeza_j.screen8.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc1_kor = testData2s;
      print(speeza_j.screen8.etc1_kor);
      expect(speeza_j.screen8.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc1_kor = defalut;
      print(speeza_j.screen8.etc1_kor);
      expect(speeza_j.screen8.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00425_element_check_00402 **********\n\n");
    });

    test('00426_element_check_00403', () async {
      print("\n********** テスト実行：00426_element_check_00403 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc2_kor;
      print(speeza_j.screen8.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc2_kor = testData1s;
      print(speeza_j.screen8.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc2_kor = testData2s;
      print(speeza_j.screen8.etc2_kor);
      expect(speeza_j.screen8.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc2_kor = defalut;
      print(speeza_j.screen8.etc2_kor);
      expect(speeza_j.screen8.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00426_element_check_00403 **********\n\n");
    });

    test('00427_element_check_00404', () async {
      print("\n********** テスト実行：00427_element_check_00404 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc3_kor;
      print(speeza_j.screen8.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc3_kor = testData1s;
      print(speeza_j.screen8.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc3_kor = testData2s;
      print(speeza_j.screen8.etc3_kor);
      expect(speeza_j.screen8.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc3_kor = defalut;
      print(speeza_j.screen8.etc3_kor);
      expect(speeza_j.screen8.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00427_element_check_00404 **********\n\n");
    });

    test('00428_element_check_00405', () async {
      print("\n********** テスト実行：00428_element_check_00405 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc4_kor;
      print(speeza_j.screen8.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc4_kor = testData1s;
      print(speeza_j.screen8.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc4_kor = testData2s;
      print(speeza_j.screen8.etc4_kor);
      expect(speeza_j.screen8.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc4_kor = defalut;
      print(speeza_j.screen8.etc4_kor);
      expect(speeza_j.screen8.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00428_element_check_00405 **********\n\n");
    });

    test('00429_element_check_00406', () async {
      print("\n********** テスト実行：00429_element_check_00406 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen8.etc5_kor;
      print(speeza_j.screen8.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen8.etc5_kor = testData1s;
      print(speeza_j.screen8.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen8.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen8.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen8.etc5_kor = testData2s;
      print(speeza_j.screen8.etc5_kor);
      expect(speeza_j.screen8.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen8.etc5_kor = defalut;
      print(speeza_j.screen8.etc5_kor);
      expect(speeza_j.screen8.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen8.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00429_element_check_00406 **********\n\n");
    });

    test('00430_element_check_00407', () async {
      print("\n********** テスト実行：00430_element_check_00407 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.title;
      print(speeza_j.screen9.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.title = testData1s;
      print(speeza_j.screen9.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.title = testData2s;
      print(speeza_j.screen9.title);
      expect(speeza_j.screen9.title == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.title = defalut;
      print(speeza_j.screen9.title);
      expect(speeza_j.screen9.title == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00430_element_check_00407 **********\n\n");
    });

    test('00431_element_check_00408', () async {
      print("\n********** テスト実行：00431_element_check_00408 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line1;
      print(speeza_j.screen9.line1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line1 = testData1s;
      print(speeza_j.screen9.line1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line1 = testData2s;
      print(speeza_j.screen9.line1);
      expect(speeza_j.screen9.line1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line1 = defalut;
      print(speeza_j.screen9.line1);
      expect(speeza_j.screen9.line1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00431_element_check_00408 **********\n\n");
    });

    test('00432_element_check_00409', () async {
      print("\n********** テスト実行：00432_element_check_00409 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line2;
      print(speeza_j.screen9.line2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line2 = testData1s;
      print(speeza_j.screen9.line2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line2 = testData2s;
      print(speeza_j.screen9.line2);
      expect(speeza_j.screen9.line2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line2 = defalut;
      print(speeza_j.screen9.line2);
      expect(speeza_j.screen9.line2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00432_element_check_00409 **********\n\n");
    });

    test('00433_element_check_00410', () async {
      print("\n********** テスト実行：00433_element_check_00410 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line1_ex;
      print(speeza_j.screen9.line1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line1_ex = testData1s;
      print(speeza_j.screen9.line1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line1_ex = testData2s;
      print(speeza_j.screen9.line1_ex);
      expect(speeza_j.screen9.line1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line1_ex = defalut;
      print(speeza_j.screen9.line1_ex);
      expect(speeza_j.screen9.line1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00433_element_check_00410 **********\n\n");
    });

    test('00434_element_check_00411', () async {
      print("\n********** テスト実行：00434_element_check_00411 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line2_ex;
      print(speeza_j.screen9.line2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line2_ex = testData1s;
      print(speeza_j.screen9.line2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line2_ex = testData2s;
      print(speeza_j.screen9.line2_ex);
      expect(speeza_j.screen9.line2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line2_ex = defalut;
      print(speeza_j.screen9.line2_ex);
      expect(speeza_j.screen9.line2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00434_element_check_00411 **********\n\n");
    });

    test('00435_element_check_00412', () async {
      print("\n********** テスト実行：00435_element_check_00412 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line1_cn;
      print(speeza_j.screen9.line1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line1_cn = testData1s;
      print(speeza_j.screen9.line1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line1_cn = testData2s;
      print(speeza_j.screen9.line1_cn);
      expect(speeza_j.screen9.line1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line1_cn = defalut;
      print(speeza_j.screen9.line1_cn);
      expect(speeza_j.screen9.line1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00435_element_check_00412 **********\n\n");
    });

    test('00436_element_check_00413', () async {
      print("\n********** テスト実行：00436_element_check_00413 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line2_cn;
      print(speeza_j.screen9.line2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line2_cn = testData1s;
      print(speeza_j.screen9.line2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line2_cn = testData2s;
      print(speeza_j.screen9.line2_cn);
      expect(speeza_j.screen9.line2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line2_cn = defalut;
      print(speeza_j.screen9.line2_cn);
      expect(speeza_j.screen9.line2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00436_element_check_00413 **********\n\n");
    });

    test('00437_element_check_00414', () async {
      print("\n********** テスト実行：00437_element_check_00414 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line1_kor;
      print(speeza_j.screen9.line1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line1_kor = testData1s;
      print(speeza_j.screen9.line1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line1_kor = testData2s;
      print(speeza_j.screen9.line1_kor);
      expect(speeza_j.screen9.line1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line1_kor = defalut;
      print(speeza_j.screen9.line1_kor);
      expect(speeza_j.screen9.line1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00437_element_check_00414 **********\n\n");
    });

    test('00438_element_check_00415', () async {
      print("\n********** テスト実行：00438_element_check_00415 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.line2_kor;
      print(speeza_j.screen9.line2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.line2_kor = testData1s;
      print(speeza_j.screen9.line2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.line2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.line2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.line2_kor = testData2s;
      print(speeza_j.screen9.line2_kor);
      expect(speeza_j.screen9.line2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.line2_kor = defalut;
      print(speeza_j.screen9.line2_kor);
      expect(speeza_j.screen9.line2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.line2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00438_element_check_00415 **********\n\n");
    });

    test('00439_element_check_00416', () async {
      print("\n********** テスト実行：00439_element_check_00416 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg1;
      print(speeza_j.screen9.msg1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg1 = testData1s;
      print(speeza_j.screen9.msg1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg1 = testData2s;
      print(speeza_j.screen9.msg1);
      expect(speeza_j.screen9.msg1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg1 = defalut;
      print(speeza_j.screen9.msg1);
      expect(speeza_j.screen9.msg1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00439_element_check_00416 **********\n\n");
    });

    test('00440_element_check_00417', () async {
      print("\n********** テスト実行：00440_element_check_00417 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg2;
      print(speeza_j.screen9.msg2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg2 = testData1s;
      print(speeza_j.screen9.msg2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg2 = testData2s;
      print(speeza_j.screen9.msg2);
      expect(speeza_j.screen9.msg2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg2 = defalut;
      print(speeza_j.screen9.msg2);
      expect(speeza_j.screen9.msg2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00440_element_check_00417 **********\n\n");
    });

    test('00441_element_check_00418', () async {
      print("\n********** テスト実行：00441_element_check_00418 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg3;
      print(speeza_j.screen9.msg3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg3 = testData1s;
      print(speeza_j.screen9.msg3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg3 = testData2s;
      print(speeza_j.screen9.msg3);
      expect(speeza_j.screen9.msg3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg3 = defalut;
      print(speeza_j.screen9.msg3);
      expect(speeza_j.screen9.msg3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00441_element_check_00418 **********\n\n");
    });

    test('00442_element_check_00419', () async {
      print("\n********** テスト実行：00442_element_check_00419 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg4;
      print(speeza_j.screen9.msg4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg4 = testData1s;
      print(speeza_j.screen9.msg4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg4 = testData2s;
      print(speeza_j.screen9.msg4);
      expect(speeza_j.screen9.msg4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg4 = defalut;
      print(speeza_j.screen9.msg4);
      expect(speeza_j.screen9.msg4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00442_element_check_00419 **********\n\n");
    });

    test('00443_element_check_00420', () async {
      print("\n********** テスト実行：00443_element_check_00420 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg1_ex;
      print(speeza_j.screen9.msg1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg1_ex = testData1s;
      print(speeza_j.screen9.msg1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg1_ex = testData2s;
      print(speeza_j.screen9.msg1_ex);
      expect(speeza_j.screen9.msg1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg1_ex = defalut;
      print(speeza_j.screen9.msg1_ex);
      expect(speeza_j.screen9.msg1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00443_element_check_00420 **********\n\n");
    });

    test('00444_element_check_00421', () async {
      print("\n********** テスト実行：00444_element_check_00421 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg2_ex;
      print(speeza_j.screen9.msg2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg2_ex = testData1s;
      print(speeza_j.screen9.msg2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg2_ex = testData2s;
      print(speeza_j.screen9.msg2_ex);
      expect(speeza_j.screen9.msg2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg2_ex = defalut;
      print(speeza_j.screen9.msg2_ex);
      expect(speeza_j.screen9.msg2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00444_element_check_00421 **********\n\n");
    });

    test('00445_element_check_00422', () async {
      print("\n********** テスト実行：00445_element_check_00422 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg3_ex;
      print(speeza_j.screen9.msg3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg3_ex = testData1s;
      print(speeza_j.screen9.msg3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg3_ex = testData2s;
      print(speeza_j.screen9.msg3_ex);
      expect(speeza_j.screen9.msg3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg3_ex = defalut;
      print(speeza_j.screen9.msg3_ex);
      expect(speeza_j.screen9.msg3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00445_element_check_00422 **********\n\n");
    });

    test('00446_element_check_00423', () async {
      print("\n********** テスト実行：00446_element_check_00423 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg4_ex;
      print(speeza_j.screen9.msg4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg4_ex = testData1s;
      print(speeza_j.screen9.msg4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg4_ex = testData2s;
      print(speeza_j.screen9.msg4_ex);
      expect(speeza_j.screen9.msg4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg4_ex = defalut;
      print(speeza_j.screen9.msg4_ex);
      expect(speeza_j.screen9.msg4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00446_element_check_00423 **********\n\n");
    });

    test('00447_element_check_00424', () async {
      print("\n********** テスト実行：00447_element_check_00424 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg1_cn;
      print(speeza_j.screen9.msg1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg1_cn = testData1s;
      print(speeza_j.screen9.msg1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg1_cn = testData2s;
      print(speeza_j.screen9.msg1_cn);
      expect(speeza_j.screen9.msg1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg1_cn = defalut;
      print(speeza_j.screen9.msg1_cn);
      expect(speeza_j.screen9.msg1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00447_element_check_00424 **********\n\n");
    });

    test('00448_element_check_00425', () async {
      print("\n********** テスト実行：00448_element_check_00425 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg2_cn;
      print(speeza_j.screen9.msg2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg2_cn = testData1s;
      print(speeza_j.screen9.msg2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg2_cn = testData2s;
      print(speeza_j.screen9.msg2_cn);
      expect(speeza_j.screen9.msg2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg2_cn = defalut;
      print(speeza_j.screen9.msg2_cn);
      expect(speeza_j.screen9.msg2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00448_element_check_00425 **********\n\n");
    });

    test('00449_element_check_00426', () async {
      print("\n********** テスト実行：00449_element_check_00426 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg3_cn;
      print(speeza_j.screen9.msg3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg3_cn = testData1s;
      print(speeza_j.screen9.msg3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg3_cn = testData2s;
      print(speeza_j.screen9.msg3_cn);
      expect(speeza_j.screen9.msg3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg3_cn = defalut;
      print(speeza_j.screen9.msg3_cn);
      expect(speeza_j.screen9.msg3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00449_element_check_00426 **********\n\n");
    });

    test('00450_element_check_00427', () async {
      print("\n********** テスト実行：00450_element_check_00427 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg4_cn;
      print(speeza_j.screen9.msg4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg4_cn = testData1s;
      print(speeza_j.screen9.msg4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg4_cn = testData2s;
      print(speeza_j.screen9.msg4_cn);
      expect(speeza_j.screen9.msg4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg4_cn = defalut;
      print(speeza_j.screen9.msg4_cn);
      expect(speeza_j.screen9.msg4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00450_element_check_00427 **********\n\n");
    });

    test('00451_element_check_00428', () async {
      print("\n********** テスト実行：00451_element_check_00428 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg1_kor;
      print(speeza_j.screen9.msg1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg1_kor = testData1s;
      print(speeza_j.screen9.msg1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg1_kor = testData2s;
      print(speeza_j.screen9.msg1_kor);
      expect(speeza_j.screen9.msg1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg1_kor = defalut;
      print(speeza_j.screen9.msg1_kor);
      expect(speeza_j.screen9.msg1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00451_element_check_00428 **********\n\n");
    });

    test('00452_element_check_00429', () async {
      print("\n********** テスト実行：00452_element_check_00429 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg2_kor;
      print(speeza_j.screen9.msg2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg2_kor = testData1s;
      print(speeza_j.screen9.msg2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg2_kor = testData2s;
      print(speeza_j.screen9.msg2_kor);
      expect(speeza_j.screen9.msg2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg2_kor = defalut;
      print(speeza_j.screen9.msg2_kor);
      expect(speeza_j.screen9.msg2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00452_element_check_00429 **********\n\n");
    });

    test('00453_element_check_00430', () async {
      print("\n********** テスト実行：00453_element_check_00430 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg3_kor;
      print(speeza_j.screen9.msg3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg3_kor = testData1s;
      print(speeza_j.screen9.msg3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg3_kor = testData2s;
      print(speeza_j.screen9.msg3_kor);
      expect(speeza_j.screen9.msg3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg3_kor = defalut;
      print(speeza_j.screen9.msg3_kor);
      expect(speeza_j.screen9.msg3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00453_element_check_00430 **********\n\n");
    });

    test('00454_element_check_00431', () async {
      print("\n********** テスト実行：00454_element_check_00431 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.msg4_kor;
      print(speeza_j.screen9.msg4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.msg4_kor = testData1s;
      print(speeza_j.screen9.msg4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.msg4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.msg4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.msg4_kor = testData2s;
      print(speeza_j.screen9.msg4_kor);
      expect(speeza_j.screen9.msg4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.msg4_kor = defalut;
      print(speeza_j.screen9.msg4_kor);
      expect(speeza_j.screen9.msg4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.msg4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00454_element_check_00431 **********\n\n");
    });

    test('00455_element_check_00432', () async {
      print("\n********** テスト実行：00455_element_check_00432 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc1;
      print(speeza_j.screen9.etc1);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc1 = testData1s;
      print(speeza_j.screen9.etc1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc1 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc1 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc1 = testData2s;
      print(speeza_j.screen9.etc1);
      expect(speeza_j.screen9.etc1 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc1 = defalut;
      print(speeza_j.screen9.etc1);
      expect(speeza_j.screen9.etc1 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00455_element_check_00432 **********\n\n");
    });

    test('00456_element_check_00433', () async {
      print("\n********** テスト実行：00456_element_check_00433 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc2;
      print(speeza_j.screen9.etc2);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc2 = testData1s;
      print(speeza_j.screen9.etc2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc2 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc2 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc2 = testData2s;
      print(speeza_j.screen9.etc2);
      expect(speeza_j.screen9.etc2 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc2 = defalut;
      print(speeza_j.screen9.etc2);
      expect(speeza_j.screen9.etc2 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00456_element_check_00433 **********\n\n");
    });

    test('00457_element_check_00434', () async {
      print("\n********** テスト実行：00457_element_check_00434 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc3;
      print(speeza_j.screen9.etc3);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc3 = testData1s;
      print(speeza_j.screen9.etc3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc3 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc3 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc3 = testData2s;
      print(speeza_j.screen9.etc3);
      expect(speeza_j.screen9.etc3 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc3 = defalut;
      print(speeza_j.screen9.etc3);
      expect(speeza_j.screen9.etc3 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00457_element_check_00434 **********\n\n");
    });

    test('00458_element_check_00435', () async {
      print("\n********** テスト実行：00458_element_check_00435 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc4;
      print(speeza_j.screen9.etc4);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc4 = testData1s;
      print(speeza_j.screen9.etc4);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc4 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc4 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc4 = testData2s;
      print(speeza_j.screen9.etc4);
      expect(speeza_j.screen9.etc4 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc4 = defalut;
      print(speeza_j.screen9.etc4);
      expect(speeza_j.screen9.etc4 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00458_element_check_00435 **********\n\n");
    });

    test('00459_element_check_00436', () async {
      print("\n********** テスト実行：00459_element_check_00436 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc5;
      print(speeza_j.screen9.etc5);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc5 = testData1s;
      print(speeza_j.screen9.etc5);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc5 == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc5 == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc5 = testData2s;
      print(speeza_j.screen9.etc5);
      expect(speeza_j.screen9.etc5 == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5 == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc5 = defalut;
      print(speeza_j.screen9.etc5);
      expect(speeza_j.screen9.etc5 == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00459_element_check_00436 **********\n\n");
    });

    test('00460_element_check_00437', () async {
      print("\n********** テスト実行：00460_element_check_00437 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc1_ex;
      print(speeza_j.screen9.etc1_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc1_ex = testData1s;
      print(speeza_j.screen9.etc1_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc1_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc1_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc1_ex = testData2s;
      print(speeza_j.screen9.etc1_ex);
      expect(speeza_j.screen9.etc1_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc1_ex = defalut;
      print(speeza_j.screen9.etc1_ex);
      expect(speeza_j.screen9.etc1_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00460_element_check_00437 **********\n\n");
    });

    test('00461_element_check_00438', () async {
      print("\n********** テスト実行：00461_element_check_00438 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc2_ex;
      print(speeza_j.screen9.etc2_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc2_ex = testData1s;
      print(speeza_j.screen9.etc2_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc2_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc2_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc2_ex = testData2s;
      print(speeza_j.screen9.etc2_ex);
      expect(speeza_j.screen9.etc2_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc2_ex = defalut;
      print(speeza_j.screen9.etc2_ex);
      expect(speeza_j.screen9.etc2_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00461_element_check_00438 **********\n\n");
    });

    test('00462_element_check_00439', () async {
      print("\n********** テスト実行：00462_element_check_00439 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc3_ex;
      print(speeza_j.screen9.etc3_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc3_ex = testData1s;
      print(speeza_j.screen9.etc3_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc3_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc3_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc3_ex = testData2s;
      print(speeza_j.screen9.etc3_ex);
      expect(speeza_j.screen9.etc3_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc3_ex = defalut;
      print(speeza_j.screen9.etc3_ex);
      expect(speeza_j.screen9.etc3_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00462_element_check_00439 **********\n\n");
    });

    test('00463_element_check_00440', () async {
      print("\n********** テスト実行：00463_element_check_00440 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc4_ex;
      print(speeza_j.screen9.etc4_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc4_ex = testData1s;
      print(speeza_j.screen9.etc4_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc4_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc4_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc4_ex = testData2s;
      print(speeza_j.screen9.etc4_ex);
      expect(speeza_j.screen9.etc4_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc4_ex = defalut;
      print(speeza_j.screen9.etc4_ex);
      expect(speeza_j.screen9.etc4_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00463_element_check_00440 **********\n\n");
    });

    test('00464_element_check_00441', () async {
      print("\n********** テスト実行：00464_element_check_00441 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc5_ex;
      print(speeza_j.screen9.etc5_ex);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc5_ex = testData1s;
      print(speeza_j.screen9.etc5_ex);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc5_ex == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc5_ex == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc5_ex = testData2s;
      print(speeza_j.screen9.etc5_ex);
      expect(speeza_j.screen9.etc5_ex == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5_ex == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc5_ex = defalut;
      print(speeza_j.screen9.etc5_ex);
      expect(speeza_j.screen9.etc5_ex == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5_ex == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00464_element_check_00441 **********\n\n");
    });

    test('00465_element_check_00442', () async {
      print("\n********** テスト実行：00465_element_check_00442 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc1_cn;
      print(speeza_j.screen9.etc1_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc1_cn = testData1s;
      print(speeza_j.screen9.etc1_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc1_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc1_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc1_cn = testData2s;
      print(speeza_j.screen9.etc1_cn);
      expect(speeza_j.screen9.etc1_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc1_cn = defalut;
      print(speeza_j.screen9.etc1_cn);
      expect(speeza_j.screen9.etc1_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00465_element_check_00442 **********\n\n");
    });

    test('00466_element_check_00443', () async {
      print("\n********** テスト実行：00466_element_check_00443 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc2_cn;
      print(speeza_j.screen9.etc2_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc2_cn = testData1s;
      print(speeza_j.screen9.etc2_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc2_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc2_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc2_cn = testData2s;
      print(speeza_j.screen9.etc2_cn);
      expect(speeza_j.screen9.etc2_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc2_cn = defalut;
      print(speeza_j.screen9.etc2_cn);
      expect(speeza_j.screen9.etc2_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00466_element_check_00443 **********\n\n");
    });

    test('00467_element_check_00444', () async {
      print("\n********** テスト実行：00467_element_check_00444 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc3_cn;
      print(speeza_j.screen9.etc3_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc3_cn = testData1s;
      print(speeza_j.screen9.etc3_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc3_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc3_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc3_cn = testData2s;
      print(speeza_j.screen9.etc3_cn);
      expect(speeza_j.screen9.etc3_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc3_cn = defalut;
      print(speeza_j.screen9.etc3_cn);
      expect(speeza_j.screen9.etc3_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00467_element_check_00444 **********\n\n");
    });

    test('00468_element_check_00445', () async {
      print("\n********** テスト実行：00468_element_check_00445 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc4_cn;
      print(speeza_j.screen9.etc4_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc4_cn = testData1s;
      print(speeza_j.screen9.etc4_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc4_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc4_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc4_cn = testData2s;
      print(speeza_j.screen9.etc4_cn);
      expect(speeza_j.screen9.etc4_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc4_cn = defalut;
      print(speeza_j.screen9.etc4_cn);
      expect(speeza_j.screen9.etc4_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00468_element_check_00445 **********\n\n");
    });

    test('00469_element_check_00446', () async {
      print("\n********** テスト実行：00469_element_check_00446 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc5_cn;
      print(speeza_j.screen9.etc5_cn);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc5_cn = testData1s;
      print(speeza_j.screen9.etc5_cn);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc5_cn == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc5_cn == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc5_cn = testData2s;
      print(speeza_j.screen9.etc5_cn);
      expect(speeza_j.screen9.etc5_cn == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5_cn == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc5_cn = defalut;
      print(speeza_j.screen9.etc5_cn);
      expect(speeza_j.screen9.etc5_cn == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5_cn == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00469_element_check_00446 **********\n\n");
    });

    test('00470_element_check_00447', () async {
      print("\n********** テスト実行：00470_element_check_00447 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc1_kor;
      print(speeza_j.screen9.etc1_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc1_kor = testData1s;
      print(speeza_j.screen9.etc1_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc1_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc1_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc1_kor = testData2s;
      print(speeza_j.screen9.etc1_kor);
      expect(speeza_j.screen9.etc1_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc1_kor = defalut;
      print(speeza_j.screen9.etc1_kor);
      expect(speeza_j.screen9.etc1_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc1_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00470_element_check_00447 **********\n\n");
    });

    test('00471_element_check_00448', () async {
      print("\n********** テスト実行：00471_element_check_00448 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc2_kor;
      print(speeza_j.screen9.etc2_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc2_kor = testData1s;
      print(speeza_j.screen9.etc2_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc2_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc2_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc2_kor = testData2s;
      print(speeza_j.screen9.etc2_kor);
      expect(speeza_j.screen9.etc2_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc2_kor = defalut;
      print(speeza_j.screen9.etc2_kor);
      expect(speeza_j.screen9.etc2_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc2_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00471_element_check_00448 **********\n\n");
    });

    test('00472_element_check_00449', () async {
      print("\n********** テスト実行：00472_element_check_00449 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc3_kor;
      print(speeza_j.screen9.etc3_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc3_kor = testData1s;
      print(speeza_j.screen9.etc3_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc3_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc3_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc3_kor = testData2s;
      print(speeza_j.screen9.etc3_kor);
      expect(speeza_j.screen9.etc3_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc3_kor = defalut;
      print(speeza_j.screen9.etc3_kor);
      expect(speeza_j.screen9.etc3_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc3_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00472_element_check_00449 **********\n\n");
    });

    test('00473_element_check_00450', () async {
      print("\n********** テスト実行：00473_element_check_00450 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc4_kor;
      print(speeza_j.screen9.etc4_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc4_kor = testData1s;
      print(speeza_j.screen9.etc4_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc4_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc4_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc4_kor = testData2s;
      print(speeza_j.screen9.etc4_kor);
      expect(speeza_j.screen9.etc4_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc4_kor = defalut;
      print(speeza_j.screen9.etc4_kor);
      expect(speeza_j.screen9.etc4_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc4_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00473_element_check_00450 **********\n\n");
    });

    test('00474_element_check_00451', () async {
      print("\n********** テスト実行：00474_element_check_00451 **********");

      speeza_j = Speeza_jJsonFile();
      allPropatyCheckInit(speeza_j);

      // ①loadを実行する。
      await speeza_j.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = speeza_j.screen9.etc5_kor;
      print(speeza_j.screen9.etc5_kor);

      // ②指定したプロパティにテストデータ1を書き込む。
      speeza_j.screen9.etc5_kor = testData1s;
      print(speeza_j.screen9.etc5_kor);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(speeza_j.screen9.etc5_kor == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await speeza_j.save();
      await speeza_j.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(speeza_j.screen9.etc5_kor == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      speeza_j.screen9.etc5_kor = testData2s;
      print(speeza_j.screen9.etc5_kor);
      expect(speeza_j.screen9.etc5_kor == testData2s, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5_kor == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      speeza_j.screen9.etc5_kor = defalut;
      print(speeza_j.screen9.etc5_kor);
      expect(speeza_j.screen9.etc5_kor == defalut, true);
      await speeza_j.save();
      await speeza_j.load();
      expect(speeza_j.screen9.etc5_kor == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(speeza_j, true);

      print("********** テスト終了：00474_element_check_00451 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Speeza_jJsonFile test)
{
  expect(test.common.page_max, 0);
  expect(test.screen0.title, "");
  expect(test.screen0.line1, "");
  expect(test.screen0.line2, "");
  expect(test.screen0.line1_ex, "");
  expect(test.screen0.line2_ex, "");
  expect(test.screen0.line1_cn, "");
  expect(test.screen0.line2_cn, "");
  expect(test.screen0.line1_kor, "");
  expect(test.screen0.line2_kor, "");
  expect(test.screen0.msg1, "");
  expect(test.screen0.msg2, "");
  expect(test.screen0.msg3, "");
  expect(test.screen0.msg4, "");
  expect(test.screen0.msg1_ex, "");
  expect(test.screen0.msg2_ex, "");
  expect(test.screen0.msg3_ex, "");
  expect(test.screen0.msg4_ex, "");
  expect(test.screen0.msg1_cn, "");
  expect(test.screen0.msg2_cn, "");
  expect(test.screen0.msg3_cn, "");
  expect(test.screen0.msg4_cn, "");
  expect(test.screen0.msg1_kor, "");
  expect(test.screen0.msg2_kor, "");
  expect(test.screen0.msg3_kor, "");
  expect(test.screen0.msg4_kor, "");
  expect(test.screen0.etc1, "");
  expect(test.screen0.etc2, "");
  expect(test.screen0.etc3, "");
  expect(test.screen0.etc4, "");
  expect(test.screen0.etc5, "");
  expect(test.screen0.etc1_ex, "");
  expect(test.screen0.etc2_ex, "");
  expect(test.screen0.etc3_ex, "");
  expect(test.screen0.etc4_ex, "");
  expect(test.screen0.etc5_ex, "");
  expect(test.screen0.etc1_cn, "");
  expect(test.screen0.etc2_cn, "");
  expect(test.screen0.etc3_cn, "");
  expect(test.screen0.etc4_cn, "");
  expect(test.screen0.etc5_cn, "");
  expect(test.screen0.etc1_kor, "");
  expect(test.screen0.etc2_kor, "");
  expect(test.screen0.etc3_kor, "");
  expect(test.screen0.etc4_kor, "");
  expect(test.screen0.etc5_kor, "");
  expect(test.screen1.title, "");
  expect(test.screen1.line1, "");
  expect(test.screen1.line2, "");
  expect(test.screen1.line1_ex, "");
  expect(test.screen1.line2_ex, "");
  expect(test.screen1.line1_cn, "");
  expect(test.screen1.line2_cn, "");
  expect(test.screen1.line1_kor, "");
  expect(test.screen1.line2_kor, "");
  expect(test.screen1.msg1, "");
  expect(test.screen1.msg2, "");
  expect(test.screen1.msg3, "");
  expect(test.screen1.msg4, "");
  expect(test.screen1.msg1_ex, "");
  expect(test.screen1.msg2_ex, "");
  expect(test.screen1.msg3_ex, "");
  expect(test.screen1.msg4_ex, "");
  expect(test.screen1.msg1_cn, "");
  expect(test.screen1.msg2_cn, "");
  expect(test.screen1.msg3_cn, "");
  expect(test.screen1.msg4_cn, "");
  expect(test.screen1.msg1_kor, "");
  expect(test.screen1.msg2_kor, "");
  expect(test.screen1.msg3_kor, "");
  expect(test.screen1.msg4_kor, "");
  expect(test.screen1.etc1, "");
  expect(test.screen1.etc2, "");
  expect(test.screen1.etc3, "");
  expect(test.screen1.etc4, "");
  expect(test.screen1.etc5, "");
  expect(test.screen1.etc1_ex, "");
  expect(test.screen1.etc2_ex, "");
  expect(test.screen1.etc3_ex, "");
  expect(test.screen1.etc4_ex, "");
  expect(test.screen1.etc5_ex, "");
  expect(test.screen1.etc1_cn, "");
  expect(test.screen1.etc2_cn, "");
  expect(test.screen1.etc3_cn, "");
  expect(test.screen1.etc4_cn, "");
  expect(test.screen1.etc5_cn, "");
  expect(test.screen1.etc1_kor, "");
  expect(test.screen1.etc2_kor, "");
  expect(test.screen1.etc3_kor, "");
  expect(test.screen1.etc4_kor, "");
  expect(test.screen1.etc5_kor, "");
  expect(test.screen2.title, "");
  expect(test.screen2.line1, "");
  expect(test.screen2.line2, "");
  expect(test.screen2.line1_ex, "");
  expect(test.screen2.line2_ex, "");
  expect(test.screen2.line1_cn, "");
  expect(test.screen2.line2_cn, "");
  expect(test.screen2.line1_kor, "");
  expect(test.screen2.line2_kor, "");
  expect(test.screen2.msg1, "");
  expect(test.screen2.msg2, "");
  expect(test.screen2.msg3, "");
  expect(test.screen2.msg4, "");
  expect(test.screen2.msg1_ex, "");
  expect(test.screen2.msg2_ex, "");
  expect(test.screen2.msg3_ex, "");
  expect(test.screen2.msg4_ex, "");
  expect(test.screen2.msg1_cn, "");
  expect(test.screen2.msg2_cn, "");
  expect(test.screen2.msg3_cn, "");
  expect(test.screen2.msg4_cn, "");
  expect(test.screen2.msg1_kor, "");
  expect(test.screen2.msg2_kor, "");
  expect(test.screen2.msg3_kor, "");
  expect(test.screen2.msg4_kor, "");
  expect(test.screen2.etc1, "");
  expect(test.screen2.etc2, "");
  expect(test.screen2.etc3, "");
  expect(test.screen2.etc4, "");
  expect(test.screen2.etc5, "");
  expect(test.screen2.etc1_ex, "");
  expect(test.screen2.etc2_ex, "");
  expect(test.screen2.etc3_ex, "");
  expect(test.screen2.etc4_ex, "");
  expect(test.screen2.etc5_ex, "");
  expect(test.screen2.etc1_cn, "");
  expect(test.screen2.etc2_cn, "");
  expect(test.screen2.etc3_cn, "");
  expect(test.screen2.etc4_cn, "");
  expect(test.screen2.etc5_cn, "");
  expect(test.screen2.etc1_kor, "");
  expect(test.screen2.etc2_kor, "");
  expect(test.screen2.etc3_kor, "");
  expect(test.screen2.etc4_kor, "");
  expect(test.screen2.etc5_kor, "");
  expect(test.screen3.title, "");
  expect(test.screen3.line1, "");
  expect(test.screen3.line2, "");
  expect(test.screen3.line1_ex, "");
  expect(test.screen3.line2_ex, "");
  expect(test.screen3.line1_cn, "");
  expect(test.screen3.line2_cn, "");
  expect(test.screen3.line1_kor, "");
  expect(test.screen3.line2_kor, "");
  expect(test.screen3.msg1, "");
  expect(test.screen3.msg2, "");
  expect(test.screen3.msg3, "");
  expect(test.screen3.msg4, "");
  expect(test.screen3.msg1_ex, "");
  expect(test.screen3.msg2_ex, "");
  expect(test.screen3.msg3_ex, "");
  expect(test.screen3.msg4_ex, "");
  expect(test.screen3.msg1_cn, "");
  expect(test.screen3.msg2_cn, "");
  expect(test.screen3.msg3_cn, "");
  expect(test.screen3.msg4_cn, "");
  expect(test.screen3.msg1_kor, "");
  expect(test.screen3.msg2_kor, "");
  expect(test.screen3.msg3_kor, "");
  expect(test.screen3.msg4_kor, "");
  expect(test.screen3.etc1, "");
  expect(test.screen3.etc2, "");
  expect(test.screen3.etc3, "");
  expect(test.screen3.etc4, "");
  expect(test.screen3.etc5, "");
  expect(test.screen3.etc1_ex, "");
  expect(test.screen3.etc2_ex, "");
  expect(test.screen3.etc3_ex, "");
  expect(test.screen3.etc4_ex, "");
  expect(test.screen3.etc5_ex, "");
  expect(test.screen3.etc1_cn, "");
  expect(test.screen3.etc2_cn, "");
  expect(test.screen3.etc3_cn, "");
  expect(test.screen3.etc4_cn, "");
  expect(test.screen3.etc5_cn, "");
  expect(test.screen3.etc1_kor, "");
  expect(test.screen3.etc2_kor, "");
  expect(test.screen3.etc3_kor, "");
  expect(test.screen3.etc4_kor, "");
  expect(test.screen3.etc5_kor, "");
  expect(test.screen4.title, "");
  expect(test.screen4.line1, "");
  expect(test.screen4.line2, "");
  expect(test.screen4.line1_ex, "");
  expect(test.screen4.line2_ex, "");
  expect(test.screen4.line1_cn, "");
  expect(test.screen4.line2_cn, "");
  expect(test.screen4.line1_kor, "");
  expect(test.screen4.line2_kor, "");
  expect(test.screen4.msg1, "");
  expect(test.screen4.msg2, "");
  expect(test.screen4.msg3, "");
  expect(test.screen4.msg4, "");
  expect(test.screen4.msg1_ex, "");
  expect(test.screen4.msg2_ex, "");
  expect(test.screen4.msg3_ex, "");
  expect(test.screen4.msg4_ex, "");
  expect(test.screen4.msg1_cn, "");
  expect(test.screen4.msg2_cn, "");
  expect(test.screen4.msg3_cn, "");
  expect(test.screen4.msg4_cn, "");
  expect(test.screen4.msg1_kor, "");
  expect(test.screen4.msg2_kor, "");
  expect(test.screen4.msg3_kor, "");
  expect(test.screen4.msg4_kor, "");
  expect(test.screen4.etc1, "");
  expect(test.screen4.etc2, "");
  expect(test.screen4.etc3, "");
  expect(test.screen4.etc4, "");
  expect(test.screen4.etc5, "");
  expect(test.screen4.etc1_ex, "");
  expect(test.screen4.etc2_ex, "");
  expect(test.screen4.etc3_ex, "");
  expect(test.screen4.etc4_ex, "");
  expect(test.screen4.etc5_ex, "");
  expect(test.screen4.etc1_cn, "");
  expect(test.screen4.etc2_cn, "");
  expect(test.screen4.etc3_cn, "");
  expect(test.screen4.etc4_cn, "");
  expect(test.screen4.etc5_cn, "");
  expect(test.screen4.etc1_kor, "");
  expect(test.screen4.etc2_kor, "");
  expect(test.screen4.etc3_kor, "");
  expect(test.screen4.etc4_kor, "");
  expect(test.screen4.etc5_kor, "");
  expect(test.screen5.title, "");
  expect(test.screen5.line1, "");
  expect(test.screen5.line2, "");
  expect(test.screen5.line1_ex, "");
  expect(test.screen5.line2_ex, "");
  expect(test.screen5.line1_cn, "");
  expect(test.screen5.line2_cn, "");
  expect(test.screen5.line1_kor, "");
  expect(test.screen5.line2_kor, "");
  expect(test.screen5.msg1, "");
  expect(test.screen5.msg2, "");
  expect(test.screen5.msg3, "");
  expect(test.screen5.msg4, "");
  expect(test.screen5.msg1_ex, "");
  expect(test.screen5.msg2_ex, "");
  expect(test.screen5.msg3_ex, "");
  expect(test.screen5.msg4_ex, "");
  expect(test.screen5.msg1_cn, "");
  expect(test.screen5.msg2_cn, "");
  expect(test.screen5.msg3_cn, "");
  expect(test.screen5.msg4_cn, "");
  expect(test.screen5.msg1_kor, "");
  expect(test.screen5.msg2_kor, "");
  expect(test.screen5.msg3_kor, "");
  expect(test.screen5.msg4_kor, "");
  expect(test.screen5.etc1, "");
  expect(test.screen5.etc2, "");
  expect(test.screen5.etc3, "");
  expect(test.screen5.etc4, "");
  expect(test.screen5.etc5, "");
  expect(test.screen5.etc1_ex, "");
  expect(test.screen5.etc2_ex, "");
  expect(test.screen5.etc3_ex, "");
  expect(test.screen5.etc4_ex, "");
  expect(test.screen5.etc5_ex, "");
  expect(test.screen5.etc1_cn, "");
  expect(test.screen5.etc2_cn, "");
  expect(test.screen5.etc3_cn, "");
  expect(test.screen5.etc4_cn, "");
  expect(test.screen5.etc5_cn, "");
  expect(test.screen5.etc1_kor, "");
  expect(test.screen5.etc2_kor, "");
  expect(test.screen5.etc3_kor, "");
  expect(test.screen5.etc4_kor, "");
  expect(test.screen5.etc5_kor, "");
  expect(test.screen6.title, "");
  expect(test.screen6.line1, "");
  expect(test.screen6.line2, "");
  expect(test.screen6.line1_ex, "");
  expect(test.screen6.line2_ex, "");
  expect(test.screen6.line1_cn, "");
  expect(test.screen6.line2_cn, "");
  expect(test.screen6.line1_kor, "");
  expect(test.screen6.line2_kor, "");
  expect(test.screen6.msg1, "");
  expect(test.screen6.msg2, "");
  expect(test.screen6.msg3, "");
  expect(test.screen6.msg4, "");
  expect(test.screen6.msg1_ex, "");
  expect(test.screen6.msg2_ex, "");
  expect(test.screen6.msg3_ex, "");
  expect(test.screen6.msg4_ex, "");
  expect(test.screen6.msg1_cn, "");
  expect(test.screen6.msg2_cn, "");
  expect(test.screen6.msg3_cn, "");
  expect(test.screen6.msg4_cn, "");
  expect(test.screen6.msg1_kor, "");
  expect(test.screen6.msg2_kor, "");
  expect(test.screen6.msg3_kor, "");
  expect(test.screen6.msg4_kor, "");
  expect(test.screen6.etc1, "");
  expect(test.screen6.etc2, "");
  expect(test.screen6.etc3, "");
  expect(test.screen6.etc4, "");
  expect(test.screen6.etc5, "");
  expect(test.screen6.etc1_ex, "");
  expect(test.screen6.etc2_ex, "");
  expect(test.screen6.etc3_ex, "");
  expect(test.screen6.etc4_ex, "");
  expect(test.screen6.etc5_ex, "");
  expect(test.screen6.etc1_cn, "");
  expect(test.screen6.etc2_cn, "");
  expect(test.screen6.etc3_cn, "");
  expect(test.screen6.etc4_cn, "");
  expect(test.screen6.etc5_cn, "");
  expect(test.screen6.etc1_kor, "");
  expect(test.screen6.etc2_kor, "");
  expect(test.screen6.etc3_kor, "");
  expect(test.screen6.etc4_kor, "");
  expect(test.screen6.etc5_kor, "");
  expect(test.screen7.title, "");
  expect(test.screen7.line1, "");
  expect(test.screen7.line2, "");
  expect(test.screen7.line1_ex, "");
  expect(test.screen7.line2_ex, "");
  expect(test.screen7.line1_cn, "");
  expect(test.screen7.line2_cn, "");
  expect(test.screen7.line1_kor, "");
  expect(test.screen7.line2_kor, "");
  expect(test.screen7.msg1, "");
  expect(test.screen7.msg2, "");
  expect(test.screen7.msg3, "");
  expect(test.screen7.msg4, "");
  expect(test.screen7.msg1_ex, "");
  expect(test.screen7.msg2_ex, "");
  expect(test.screen7.msg3_ex, "");
  expect(test.screen7.msg4_ex, "");
  expect(test.screen7.msg1_cn, "");
  expect(test.screen7.msg2_cn, "");
  expect(test.screen7.msg3_cn, "");
  expect(test.screen7.msg4_cn, "");
  expect(test.screen7.msg1_kor, "");
  expect(test.screen7.msg2_kor, "");
  expect(test.screen7.msg3_kor, "");
  expect(test.screen7.msg4_kor, "");
  expect(test.screen7.etc1, "");
  expect(test.screen7.etc2, "");
  expect(test.screen7.etc3, "");
  expect(test.screen7.etc4, "");
  expect(test.screen7.etc5, "");
  expect(test.screen7.etc1_ex, "");
  expect(test.screen7.etc2_ex, "");
  expect(test.screen7.etc3_ex, "");
  expect(test.screen7.etc4_ex, "");
  expect(test.screen7.etc5_ex, "");
  expect(test.screen7.etc1_cn, "");
  expect(test.screen7.etc2_cn, "");
  expect(test.screen7.etc3_cn, "");
  expect(test.screen7.etc4_cn, "");
  expect(test.screen7.etc5_cn, "");
  expect(test.screen7.etc1_kor, "");
  expect(test.screen7.etc2_kor, "");
  expect(test.screen7.etc3_kor, "");
  expect(test.screen7.etc4_kor, "");
  expect(test.screen7.etc5_kor, "");
  expect(test.screen8.title, "");
  expect(test.screen8.line1, "");
  expect(test.screen8.line2, "");
  expect(test.screen8.line1_ex, "");
  expect(test.screen8.line2_ex, "");
  expect(test.screen8.line1_cn, "");
  expect(test.screen8.line2_cn, "");
  expect(test.screen8.line1_kor, "");
  expect(test.screen8.line2_kor, "");
  expect(test.screen8.msg1, "");
  expect(test.screen8.msg2, "");
  expect(test.screen8.msg3, "");
  expect(test.screen8.msg4, "");
  expect(test.screen8.msg1_ex, "");
  expect(test.screen8.msg2_ex, "");
  expect(test.screen8.msg3_ex, "");
  expect(test.screen8.msg4_ex, "");
  expect(test.screen8.msg1_cn, "");
  expect(test.screen8.msg2_cn, "");
  expect(test.screen8.msg3_cn, "");
  expect(test.screen8.msg4_cn, "");
  expect(test.screen8.msg1_kor, "");
  expect(test.screen8.msg2_kor, "");
  expect(test.screen8.msg3_kor, "");
  expect(test.screen8.msg4_kor, "");
  expect(test.screen8.etc1, "");
  expect(test.screen8.etc2, "");
  expect(test.screen8.etc3, "");
  expect(test.screen8.etc4, "");
  expect(test.screen8.etc5, "");
  expect(test.screen8.etc1_ex, "");
  expect(test.screen8.etc2_ex, "");
  expect(test.screen8.etc3_ex, "");
  expect(test.screen8.etc4_ex, "");
  expect(test.screen8.etc5_ex, "");
  expect(test.screen8.etc1_cn, "");
  expect(test.screen8.etc2_cn, "");
  expect(test.screen8.etc3_cn, "");
  expect(test.screen8.etc4_cn, "");
  expect(test.screen8.etc5_cn, "");
  expect(test.screen8.etc1_kor, "");
  expect(test.screen8.etc2_kor, "");
  expect(test.screen8.etc3_kor, "");
  expect(test.screen8.etc4_kor, "");
  expect(test.screen8.etc5_kor, "");
  expect(test.screen9.title, "");
  expect(test.screen9.line1, "");
  expect(test.screen9.line2, "");
  expect(test.screen9.line1_ex, "");
  expect(test.screen9.line2_ex, "");
  expect(test.screen9.line1_cn, "");
  expect(test.screen9.line2_cn, "");
  expect(test.screen9.line1_kor, "");
  expect(test.screen9.line2_kor, "");
  expect(test.screen9.msg1, "");
  expect(test.screen9.msg2, "");
  expect(test.screen9.msg3, "");
  expect(test.screen9.msg4, "");
  expect(test.screen9.msg1_ex, "");
  expect(test.screen9.msg2_ex, "");
  expect(test.screen9.msg3_ex, "");
  expect(test.screen9.msg4_ex, "");
  expect(test.screen9.msg1_cn, "");
  expect(test.screen9.msg2_cn, "");
  expect(test.screen9.msg3_cn, "");
  expect(test.screen9.msg4_cn, "");
  expect(test.screen9.msg1_kor, "");
  expect(test.screen9.msg2_kor, "");
  expect(test.screen9.msg3_kor, "");
  expect(test.screen9.msg4_kor, "");
  expect(test.screen9.etc1, "");
  expect(test.screen9.etc2, "");
  expect(test.screen9.etc3, "");
  expect(test.screen9.etc4, "");
  expect(test.screen9.etc5, "");
  expect(test.screen9.etc1_ex, "");
  expect(test.screen9.etc2_ex, "");
  expect(test.screen9.etc3_ex, "");
  expect(test.screen9.etc4_ex, "");
  expect(test.screen9.etc5_ex, "");
  expect(test.screen9.etc1_cn, "");
  expect(test.screen9.etc2_cn, "");
  expect(test.screen9.etc3_cn, "");
  expect(test.screen9.etc4_cn, "");
  expect(test.screen9.etc5_cn, "");
  expect(test.screen9.etc1_kor, "");
  expect(test.screen9.etc2_kor, "");
  expect(test.screen9.etc3_kor, "");
  expect(test.screen9.etc4_kor, "");
  expect(test.screen9.etc5_kor, "");
}

void allPropatyCheck(Speeza_jJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.common.page_max, 10);
  }
  expect(test.screen0.title, "スタート画面");
  expect(test.screen0.line1, "いらっしゃいませ");
  expect(test.screen0.line2, "");
  expect(test.screen0.line1_ex, "");
  expect(test.screen0.line2_ex, "");
  expect(test.screen0.line1_cn, "");
  expect(test.screen0.line2_cn, "");
  expect(test.screen0.line1_kor, "");
  expect(test.screen0.line2_kor, "");
  expect(test.screen0.msg1, "ボタンを選択し");
  expect(test.screen0.msg2, "登録をスタートしてください");
  expect(test.screen0.msg3, "");
  expect(test.screen0.msg4, "");
  expect(test.screen0.msg1_ex, "");
  expect(test.screen0.msg2_ex, "");
  expect(test.screen0.msg3_ex, "");
  expect(test.screen0.msg4_ex, "");
  expect(test.screen0.msg1_cn, "");
  expect(test.screen0.msg2_cn, "");
  expect(test.screen0.msg3_cn, "");
  expect(test.screen0.msg4_cn, "");
  expect(test.screen0.msg1_kor, "");
  expect(test.screen0.msg2_kor, "");
  expect(test.screen0.msg3_kor, "");
  expect(test.screen0.msg4_kor, "");
  expect(test.screen0.etc1, "");
  expect(test.screen0.etc2, "");
  expect(test.screen0.etc3, "");
  expect(test.screen0.etc4, "");
  expect(test.screen0.etc5, "");
  expect(test.screen0.etc1_ex, "");
  expect(test.screen0.etc2_ex, "");
  expect(test.screen0.etc3_ex, "");
  expect(test.screen0.etc4_ex, "");
  expect(test.screen0.etc5_ex, "");
  expect(test.screen0.etc1_cn, "");
  expect(test.screen0.etc2_cn, "");
  expect(test.screen0.etc3_cn, "");
  expect(test.screen0.etc4_cn, "");
  expect(test.screen0.etc5_cn, "");
  expect(test.screen0.etc1_kor, "");
  expect(test.screen0.etc2_kor, "");
  expect(test.screen0.etc3_kor, "");
  expect(test.screen0.etc4_kor, "");
  expect(test.screen0.etc5_kor, "");
  expect(test.screen1.title, "スタート画面");
  expect(test.screen1.line1, "");
  expect(test.screen1.line2, "");
  expect(test.screen1.line1_ex, "");
  expect(test.screen1.line2_ex, "");
  expect(test.screen1.line1_cn, "");
  expect(test.screen1.line2_cn, "");
  expect(test.screen1.line1_kor, "");
  expect(test.screen1.line2_kor, "");
  expect(test.screen1.msg1, "登録スタートボタンを押すか");
  expect(test.screen1.msg2, "商品をスキャンしてください。");
  expect(test.screen1.msg3, "");
  expect(test.screen1.msg4, "");
  expect(test.screen1.msg1_ex, "");
  expect(test.screen1.msg2_ex, "");
  expect(test.screen1.msg3_ex, "");
  expect(test.screen1.msg4_ex, "");
  expect(test.screen1.msg1_cn, "");
  expect(test.screen1.msg2_cn, "");
  expect(test.screen1.msg3_cn, "");
  expect(test.screen1.msg4_cn, "");
  expect(test.screen1.msg1_kor, "");
  expect(test.screen1.msg2_kor, "");
  expect(test.screen1.msg3_kor, "");
  expect(test.screen1.msg4_kor, "");
  expect(test.screen1.etc1, "");
  expect(test.screen1.etc2, "");
  expect(test.screen1.etc3, "");
  expect(test.screen1.etc4, "");
  expect(test.screen1.etc5, "");
  expect(test.screen1.etc1_ex, "");
  expect(test.screen1.etc2_ex, "");
  expect(test.screen1.etc3_ex, "");
  expect(test.screen1.etc4_ex, "");
  expect(test.screen1.etc5_ex, "");
  expect(test.screen1.etc1_cn, "");
  expect(test.screen1.etc2_cn, "");
  expect(test.screen1.etc3_cn, "");
  expect(test.screen1.etc4_cn, "");
  expect(test.screen1.etc5_cn, "");
  expect(test.screen1.etc1_kor, "");
  expect(test.screen1.etc2_kor, "");
  expect(test.screen1.etc3_kor, "");
  expect(test.screen1.etc4_kor, "");
  expect(test.screen1.etc5_kor, "");
  expect(test.screen2.title, "商品登録画面");
  expect(test.screen2.line1, "商品を登録してください");
  expect(test.screen2.line2, "");
  expect(test.screen2.line1_ex, "");
  expect(test.screen2.line2_ex, "");
  expect(test.screen2.line1_cn, "");
  expect(test.screen2.line2_cn, "");
  expect(test.screen2.line1_kor, "");
  expect(test.screen2.line2_kor, "");
  expect(test.screen2.msg1, "バーコードが無い商品は");
  expect(test.screen2.msg2, "下から品目をお選びください");
  expect(test.screen2.msg3, "");
  expect(test.screen2.msg4, "");
  expect(test.screen2.msg1_ex, "");
  expect(test.screen2.msg2_ex, "");
  expect(test.screen2.msg3_ex, "");
  expect(test.screen2.msg4_ex, "");
  expect(test.screen2.msg1_cn, "");
  expect(test.screen2.msg2_cn, "");
  expect(test.screen2.msg3_cn, "");
  expect(test.screen2.msg4_cn, "");
  expect(test.screen2.msg1_kor, "");
  expect(test.screen2.msg2_kor, "");
  expect(test.screen2.msg3_kor, "");
  expect(test.screen2.msg4_kor, "");
  expect(test.screen2.etc1, "買上点数");
  expect(test.screen2.etc2, "点");
  expect(test.screen2.etc3, "合計");
  expect(test.screen2.etc4, "値下合計");
  expect(test.screen2.etc5, "残額");
  expect(test.screen2.etc1_ex, "");
  expect(test.screen2.etc2_ex, "");
  expect(test.screen2.etc3_ex, "");
  expect(test.screen2.etc4_ex, "");
  expect(test.screen2.etc5_ex, "");
  expect(test.screen2.etc1_cn, "");
  expect(test.screen2.etc2_cn, "");
  expect(test.screen2.etc3_cn, "");
  expect(test.screen2.etc4_cn, "");
  expect(test.screen2.etc5_cn, "");
  expect(test.screen2.etc1_kor, "");
  expect(test.screen2.etc2_kor, "");
  expect(test.screen2.etc3_kor, "");
  expect(test.screen2.etc4_kor, "");
  expect(test.screen2.etc5_kor, "");
  expect(test.screen3.title, "商品登録画面");
  expect(test.screen3.line1, "");
  expect(test.screen3.line2, "");
  expect(test.screen3.line1_ex, "");
  expect(test.screen3.line2_ex, "");
  expect(test.screen3.line1_cn, "");
  expect(test.screen3.line2_cn, "");
  expect(test.screen3.line1_kor, "");
  expect(test.screen3.line2_kor, "");
  expect(test.screen3.msg1, "商品のバーコードを");
  expect(test.screen3.msg2, "スキャナーに近づけて");
  expect(test.screen3.msg3, "登録を行ってください。");
  expect(test.screen3.msg4, "");
  expect(test.screen3.msg1_ex, "");
  expect(test.screen3.msg2_ex, "");
  expect(test.screen3.msg3_ex, "");
  expect(test.screen3.msg4_ex, "");
  expect(test.screen3.msg1_cn, "");
  expect(test.screen3.msg2_cn, "");
  expect(test.screen3.msg3_cn, "");
  expect(test.screen3.msg4_cn, "");
  expect(test.screen3.msg1_kor, "");
  expect(test.screen3.msg2_kor, "");
  expect(test.screen3.msg3_kor, "");
  expect(test.screen3.msg4_kor, "");
  expect(test.screen3.etc1, "価格");
  expect(test.screen3.etc2, "個数");
  expect(test.screen3.etc3, "値下");
  expect(test.screen3.etc4, "");
  expect(test.screen3.etc5, "");
  expect(test.screen3.etc1_ex, "");
  expect(test.screen3.etc2_ex, "");
  expect(test.screen3.etc3_ex, "");
  expect(test.screen3.etc4_ex, "");
  expect(test.screen3.etc5_ex, "");
  expect(test.screen3.etc1_cn, "");
  expect(test.screen3.etc2_cn, "");
  expect(test.screen3.etc3_cn, "");
  expect(test.screen3.etc4_cn, "");
  expect(test.screen3.etc5_cn, "");
  expect(test.screen3.etc1_kor, "");
  expect(test.screen3.etc2_kor, "");
  expect(test.screen3.etc3_kor, "");
  expect(test.screen3.etc4_kor, "");
  expect(test.screen3.etc5_kor, "");
  expect(test.screen4.title, "商品登録画面");
  expect(test.screen4.line1, "");
  expect(test.screen4.line2, "");
  expect(test.screen4.line1_ex, "");
  expect(test.screen4.line2_ex, "");
  expect(test.screen4.line1_cn, "");
  expect(test.screen4.line2_cn, "");
  expect(test.screen4.line1_kor, "");
  expect(test.screen4.line2_kor, "");
  expect(test.screen4.msg1, "バーコードが無い商品は");
  expect(test.screen4.msg2, "下のボタン↓を押してください");
  expect(test.screen4.msg3, "");
  expect(test.screen4.msg4, "");
  expect(test.screen4.msg1_ex, "");
  expect(test.screen4.msg2_ex, "");
  expect(test.screen4.msg3_ex, "");
  expect(test.screen4.msg4_ex, "");
  expect(test.screen4.msg1_cn, "");
  expect(test.screen4.msg2_cn, "");
  expect(test.screen4.msg3_cn, "");
  expect(test.screen4.msg4_cn, "");
  expect(test.screen4.msg1_kor, "");
  expect(test.screen4.msg2_kor, "");
  expect(test.screen4.msg3_kor, "");
  expect(test.screen4.msg4_kor, "");
  expect(test.screen4.etc1, "価格");
  expect(test.screen4.etc2, "個数");
  expect(test.screen4.etc3, "値下");
  expect(test.screen4.etc4, "");
  expect(test.screen4.etc5, "");
  expect(test.screen4.etc1_ex, "");
  expect(test.screen4.etc2_ex, "");
  expect(test.screen4.etc3_ex, "");
  expect(test.screen4.etc4_ex, "");
  expect(test.screen4.etc5_ex, "");
  expect(test.screen4.etc1_cn, "");
  expect(test.screen4.etc2_cn, "");
  expect(test.screen4.etc3_cn, "");
  expect(test.screen4.etc4_cn, "");
  expect(test.screen4.etc5_cn, "");
  expect(test.screen4.etc1_kor, "");
  expect(test.screen4.etc2_kor, "");
  expect(test.screen4.etc3_kor, "");
  expect(test.screen4.etc4_kor, "");
  expect(test.screen4.etc5_kor, "");
  expect(test.screen5.title, "プリセット画面");
  expect(test.screen5.line1, "");
  expect(test.screen5.line2, "商品を選択してください");
  expect(test.screen5.line1_ex, "");
  expect(test.screen5.line2_ex, "");
  expect(test.screen5.line1_cn, "");
  expect(test.screen5.line2_cn, "");
  expect(test.screen5.line1_kor, "");
  expect(test.screen5.line2_kor, "");
  expect(test.screen5.msg1, "");
  expect(test.screen5.msg2, "");
  expect(test.screen5.msg3, "");
  expect(test.screen5.msg4, "");
  expect(test.screen5.msg1_ex, "");
  expect(test.screen5.msg2_ex, "");
  expect(test.screen5.msg3_ex, "");
  expect(test.screen5.msg4_ex, "");
  expect(test.screen5.msg1_cn, "");
  expect(test.screen5.msg2_cn, "");
  expect(test.screen5.msg3_cn, "");
  expect(test.screen5.msg4_cn, "");
  expect(test.screen5.msg1_kor, "");
  expect(test.screen5.msg2_kor, "");
  expect(test.screen5.msg3_kor, "");
  expect(test.screen5.msg4_kor, "");
  expect(test.screen5.etc1, "価格");
  expect(test.screen5.etc2, "個数");
  expect(test.screen5.etc3, "値下");
  expect(test.screen5.etc4, "");
  expect(test.screen5.etc5, "");
  expect(test.screen5.etc1_ex, "");
  expect(test.screen5.etc2_ex, "");
  expect(test.screen5.etc3_ex, "");
  expect(test.screen5.etc4_ex, "");
  expect(test.screen5.etc5_ex, "");
  expect(test.screen5.etc1_cn, "");
  expect(test.screen5.etc2_cn, "");
  expect(test.screen5.etc3_cn, "");
  expect(test.screen5.etc4_cn, "");
  expect(test.screen5.etc5_cn, "");
  expect(test.screen5.etc1_kor, "");
  expect(test.screen5.etc2_kor, "");
  expect(test.screen5.etc3_kor, "");
  expect(test.screen5.etc4_kor, "");
  expect(test.screen5.etc5_kor, "");
  expect(test.screen6.title, "プリセット個数入力画面");
  expect(test.screen6.line1, "個数を入力し");
  expect(test.screen6.line2, "決定を押してください");
  expect(test.screen6.line1_ex, "");
  expect(test.screen6.line2_ex, "");
  expect(test.screen6.line1_cn, "");
  expect(test.screen6.line2_cn, "");
  expect(test.screen6.line1_kor, "");
  expect(test.screen6.line2_kor, "");
  expect(test.screen6.msg1, "個数を訂正する場合はクリア");
  expect(test.screen6.msg2, "ボタンを押してください");
  expect(test.screen6.msg3, "");
  expect(test.screen6.msg4, "");
  expect(test.screen6.msg1_ex, "");
  expect(test.screen6.msg2_ex, "");
  expect(test.screen6.msg3_ex, "");
  expect(test.screen6.msg4_ex, "");
  expect(test.screen6.msg1_cn, "");
  expect(test.screen6.msg2_cn, "");
  expect(test.screen6.msg3_cn, "");
  expect(test.screen6.msg4_cn, "");
  expect(test.screen6.msg1_kor, "");
  expect(test.screen6.msg2_kor, "");
  expect(test.screen6.msg3_kor, "");
  expect(test.screen6.msg4_kor, "");
  expect(test.screen6.etc1, "価格");
  expect(test.screen6.etc2, "個数");
  expect(test.screen6.etc3, "値下");
  expect(test.screen6.etc4, "");
  expect(test.screen6.etc5, "");
  expect(test.screen6.etc1_ex, "");
  expect(test.screen6.etc2_ex, "");
  expect(test.screen6.etc3_ex, "");
  expect(test.screen6.etc4_ex, "");
  expect(test.screen6.etc5_ex, "");
  expect(test.screen6.etc1_cn, "");
  expect(test.screen6.etc2_cn, "");
  expect(test.screen6.etc3_cn, "");
  expect(test.screen6.etc4_cn, "");
  expect(test.screen6.etc5_cn, "");
  expect(test.screen6.etc1_kor, "");
  expect(test.screen6.etc2_kor, "");
  expect(test.screen6.etc3_kor, "");
  expect(test.screen6.etc4_kor, "");
  expect(test.screen6.etc5_kor, "");
  expect(test.screen7.title, "商品登録中画面");
  expect(test.screen7.line1, "商品は");
  expect(test.screen7.line2, "買い物袋に入れてください");
  expect(test.screen7.line1_ex, "");
  expect(test.screen7.line2_ex, "");
  expect(test.screen7.line1_cn, "");
  expect(test.screen7.line2_cn, "");
  expect(test.screen7.line1_kor, "");
  expect(test.screen7.line2_kor, "");
  expect(test.screen7.msg1, "登録した商品は");
  expect(test.screen7.msg2, "買い物袋に入れてください");
  expect(test.screen7.msg3, "次の商品登録はこの画面が");
  expect(test.screen7.msg4, "消えてから行ってください");
  expect(test.screen7.msg1_ex, "");
  expect(test.screen7.msg2_ex, "");
  expect(test.screen7.msg3_ex, "");
  expect(test.screen7.msg4_ex, "");
  expect(test.screen7.msg1_cn, "");
  expect(test.screen7.msg2_cn, "");
  expect(test.screen7.msg3_cn, "");
  expect(test.screen7.msg4_cn, "");
  expect(test.screen7.msg1_kor, "");
  expect(test.screen7.msg2_kor, "");
  expect(test.screen7.msg3_kor, "");
  expect(test.screen7.msg4_kor, "");
  expect(test.screen7.etc1, "登録中");
  expect(test.screen7.etc2, "価格");
  expect(test.screen7.etc3, "");
  expect(test.screen7.etc4, "");
  expect(test.screen7.etc5, "");
  expect(test.screen7.etc1_ex, "");
  expect(test.screen7.etc2_ex, "");
  expect(test.screen7.etc3_ex, "");
  expect(test.screen7.etc4_ex, "");
  expect(test.screen7.etc5_ex, "");
  expect(test.screen7.etc1_cn, "");
  expect(test.screen7.etc2_cn, "");
  expect(test.screen7.etc3_cn, "");
  expect(test.screen7.etc4_cn, "");
  expect(test.screen7.etc5_cn, "");
  expect(test.screen7.etc1_kor, "");
  expect(test.screen7.etc2_kor, "");
  expect(test.screen7.etc3_kor, "");
  expect(test.screen7.etc4_kor, "");
  expect(test.screen7.etc5_kor, "");
  expect(test.screen8.title, "クリニックモード読込画面");
  expect(test.screen8.line1, "バーコードをスキャンしてください");
  expect(test.screen8.line2, "");
  expect(test.screen8.line1_ex, "");
  expect(test.screen8.line2_ex, "");
  expect(test.screen8.line1_cn, "");
  expect(test.screen8.line2_cn, "");
  expect(test.screen8.line1_kor, "");
  expect(test.screen8.line2_kor, "");
  expect(test.screen8.msg1, "バーコードを");
  expect(test.screen8.msg2, "スキャナーに近づけて");
  expect(test.screen8.msg3, "精算を行ってください。");
  expect(test.screen8.msg4, "");
  expect(test.screen8.msg1_ex, "");
  expect(test.screen8.msg2_ex, "");
  expect(test.screen8.msg3_ex, "");
  expect(test.screen8.msg4_ex, "");
  expect(test.screen8.msg1_cn, "");
  expect(test.screen8.msg2_cn, "");
  expect(test.screen8.msg3_cn, "");
  expect(test.screen8.msg4_cn, "");
  expect(test.screen8.msg1_kor, "");
  expect(test.screen8.msg2_kor, "");
  expect(test.screen8.msg3_kor, "");
  expect(test.screen8.msg4_kor, "");
  expect(test.screen8.etc1, "点数");
  expect(test.screen8.etc2, "");
  expect(test.screen8.etc3, "");
  expect(test.screen8.etc4, "");
  expect(test.screen8.etc5, "");
  expect(test.screen8.etc1_ex, "");
  expect(test.screen8.etc2_ex, "");
  expect(test.screen8.etc3_ex, "");
  expect(test.screen8.etc4_ex, "");
  expect(test.screen8.etc5_ex, "");
  expect(test.screen8.etc1_cn, "");
  expect(test.screen8.etc2_cn, "");
  expect(test.screen8.etc3_cn, "");
  expect(test.screen8.etc4_cn, "");
  expect(test.screen8.etc5_cn, "");
  expect(test.screen8.etc1_kor, "");
  expect(test.screen8.etc2_kor, "");
  expect(test.screen8.etc3_kor, "");
  expect(test.screen8.etc4_kor, "");
  expect(test.screen8.etc5_kor, "");
  expect(test.screen9.title, "クリニックモード読込中画面");
  expect(test.screen9.line1, "読み込んでいます");
  expect(test.screen9.line2, "");
  expect(test.screen9.line1_ex, "");
  expect(test.screen9.line2_ex, "");
  expect(test.screen9.line1_cn, "");
  expect(test.screen9.line2_cn, "");
  expect(test.screen9.line1_kor, "");
  expect(test.screen9.line2_kor, "");
  expect(test.screen9.msg1, "次のバーコードをスキャンする");
  expect(test.screen9.msg2, "場合はこの画面が消えてから");
  expect(test.screen9.msg3, "行ってください");
  expect(test.screen9.msg4, "");
  expect(test.screen9.msg1_ex, "");
  expect(test.screen9.msg2_ex, "");
  expect(test.screen9.msg3_ex, "");
  expect(test.screen9.msg4_ex, "");
  expect(test.screen9.msg1_cn, "");
  expect(test.screen9.msg2_cn, "");
  expect(test.screen9.msg3_cn, "");
  expect(test.screen9.msg4_cn, "");
  expect(test.screen9.msg1_kor, "");
  expect(test.screen9.msg2_kor, "");
  expect(test.screen9.msg3_kor, "");
  expect(test.screen9.msg4_kor, "");
  expect(test.screen9.etc1, "読込中");
  expect(test.screen9.etc2, "価格");
  expect(test.screen9.etc3, "");
  expect(test.screen9.etc4, "");
  expect(test.screen9.etc5, "");
  expect(test.screen9.etc1_ex, "");
  expect(test.screen9.etc2_ex, "");
  expect(test.screen9.etc3_ex, "");
  expect(test.screen9.etc4_ex, "");
  expect(test.screen9.etc5_ex, "");
  expect(test.screen9.etc1_cn, "");
  expect(test.screen9.etc2_cn, "");
  expect(test.screen9.etc3_cn, "");
  expect(test.screen9.etc4_cn, "");
  expect(test.screen9.etc5_cn, "");
  expect(test.screen9.etc1_kor, "");
  expect(test.screen9.etc2_kor, "");
  expect(test.screen9.etc3_kor, "");
  expect(test.screen9.etc4_kor, "");
  expect(test.screen9.etc5_kor, "");
}

