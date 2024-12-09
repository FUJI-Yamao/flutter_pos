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
import '../../../../lib/app/common/cls_conf/auto_updateJsonFile.dart';

late Auto_updateJsonFile auto_update;

void main(){
  auto_updateJsonFile_test();
}

void auto_updateJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "auto_update.json";
  const String section = "comm";
  const String key = "rest_url";
  const defaultData = "http://118.243.93.122/autoupdates?";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Auto_updateJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Auto_updateJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Auto_updateJsonFile().setDefault();
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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await auto_update.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(auto_update,true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        auto_update.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await auto_update.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(auto_update,true);

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
      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①：loadを実行する。
      await auto_update.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = auto_update.comm.rest_url;
      auto_update.comm.rest_url = testData1s;
      expect(auto_update.comm.rest_url == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await auto_update.load();
      expect(auto_update.comm.rest_url != testData1s, true);
      expect(auto_update.comm.rest_url == prefixData, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = auto_update.comm.rest_url;
      auto_update.comm.rest_url = testData1s;
      expect(auto_update.comm.rest_url, testData1s);

      // ③saveを実行する。
      await auto_update.save();

      // ④loadを実行する。
      await auto_update.load();

      expect(auto_update.comm.rest_url != prefixData, true);
      expect(auto_update.comm.rest_url == testData1s, true);
      allPropatyCheck(auto_update,false);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await auto_update.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await auto_update.save();

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await auto_update.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(auto_update.comm.rest_url, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = auto_update.comm.rest_url;
      auto_update.comm.rest_url = testData1s;

      // ③ saveを実行する。
      await auto_update.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(auto_update.comm.rest_url, testData1s);

      // ④ loadを実行する。
      await auto_update.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(auto_update.comm.rest_url == testData1s, true);
      allPropatyCheck(auto_update,false);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await auto_update.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(auto_update,true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②任意のプロパティの値を変更する。
      auto_update.comm.rest_url = testData1s;
      expect(auto_update.comm.rest_url, testData1s);

      // ③saveを実行する。
      await auto_update.save();
      expect(auto_update.comm.rest_url, testData1s);

      // ④loadを実行する。
      await auto_update.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(auto_update,true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await auto_update.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await auto_update.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(auto_update.comm.rest_url == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await auto_update.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await auto_update.setValueWithName(section, "test_key", testData1s);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②任意のプロパティを変更する。
      auto_update.comm.rest_url = testData1s;

      // ③saveを実行する。
      await auto_update.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await auto_update.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②任意のプロパティを変更する。
      auto_update.comm.rest_url = testData1s;

      // ③saveを実行する。
      await auto_update.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await auto_update.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②任意のプロパティを変更する。
      auto_update.comm.rest_url = testData1s;

      // ③saveを実行する。
      await auto_update.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await auto_update.getValueWithName(section, "test_key");
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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await auto_update.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      auto_update.comm.rest_url = testData1s;
      expect(auto_update.comm.rest_url, testData1s);

      // ④saveを実行する。
      await auto_update.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(auto_update.comm.rest_url, testData1s);
      
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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await auto_update.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      expect(auto_update.comm.rest_url == testData1s, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await auto_update.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      expect(auto_update.comm.rest_url == testData2s, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await auto_update.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      expect(auto_update.comm.rest_url == testData1s, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await auto_update.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      expect(auto_update.comm.rest_url == testData2s, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await auto_update.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      expect(auto_update.comm.rest_url == testData1s, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await auto_update.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      expect(auto_update.comm.rest_url == testData1s, true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await auto_update.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      allPropatyCheck(auto_update,true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await auto_update.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + auto_update.comm.rest_url.toString());
      allPropatyCheck(auto_update,true);

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

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.rest_url;
      print(auto_update.comm.rest_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.rest_url = testData1s;
      print(auto_update.comm.rest_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.rest_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.rest_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.rest_url = testData2s;
      print(auto_update.comm.rest_url);
      expect(auto_update.comm.rest_url == testData2s, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.rest_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.rest_url = defalut;
      print(auto_update.comm.rest_url);
      expect(auto_update.comm.rest_url == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.rest_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.get_result_url;
      print(auto_update.comm.get_result_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.get_result_url = testData1s;
      print(auto_update.comm.get_result_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.get_result_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.get_result_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.get_result_url = testData2s;
      print(auto_update.comm.get_result_url);
      expect(auto_update.comm.get_result_url == testData2s, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.get_result_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.get_result_url = defalut;
      print(auto_update.comm.get_result_url);
      expect(auto_update.comm.get_result_url == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.get_result_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.vup_result_url;
      print(auto_update.comm.vup_result_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.vup_result_url = testData1s;
      print(auto_update.comm.vup_result_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.vup_result_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.vup_result_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.vup_result_url = testData2s;
      print(auto_update.comm.vup_result_url);
      expect(auto_update.comm.vup_result_url == testData2s, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.vup_result_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.vup_result_url = defalut;
      print(auto_update.comm.vup_result_url);
      expect(auto_update.comm.vup_result_url == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.vup_result_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.time_out;
      print(auto_update.comm.time_out);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.time_out = testData1;
      print(auto_update.comm.time_out);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.time_out == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.time_out == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.time_out = testData2;
      print(auto_update.comm.time_out);
      expect(auto_update.comm.time_out == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.time_out == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.time_out = defalut;
      print(auto_update.comm.time_out);
      expect(auto_update.comm.time_out == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.time_out == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.retry;
      print(auto_update.comm.retry);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.retry = testData1;
      print(auto_update.comm.retry);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.retry == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.retry == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.retry = testData2;
      print(auto_update.comm.retry);
      expect(auto_update.comm.retry == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.retry == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.retry = defalut;
      print(auto_update.comm.retry);
      expect(auto_update.comm.retry == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.retry == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.zhq_rest_url;
      print(auto_update.comm.zhq_rest_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.zhq_rest_url = testData1s;
      print(auto_update.comm.zhq_rest_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.zhq_rest_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.zhq_rest_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.zhq_rest_url = testData2s;
      print(auto_update.comm.zhq_rest_url);
      expect(auto_update.comm.zhq_rest_url == testData2s, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.zhq_rest_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.zhq_rest_url = defalut;
      print(auto_update.comm.zhq_rest_url);
      expect(auto_update.comm.zhq_rest_url == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.zhq_rest_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.zhq_get_result_url;
      print(auto_update.comm.zhq_get_result_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.zhq_get_result_url = testData1s;
      print(auto_update.comm.zhq_get_result_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.zhq_get_result_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.zhq_get_result_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.zhq_get_result_url = testData2s;
      print(auto_update.comm.zhq_get_result_url);
      expect(auto_update.comm.zhq_get_result_url == testData2s, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.zhq_get_result_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.zhq_get_result_url = defalut;
      print(auto_update.comm.zhq_get_result_url);
      expect(auto_update.comm.zhq_get_result_url == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.zhq_get_result_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.zhq_vup_result_url;
      print(auto_update.comm.zhq_vup_result_url);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.zhq_vup_result_url = testData1s;
      print(auto_update.comm.zhq_vup_result_url);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.zhq_vup_result_url == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.zhq_vup_result_url == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.zhq_vup_result_url = testData2s;
      print(auto_update.comm.zhq_vup_result_url);
      expect(auto_update.comm.zhq_vup_result_url == testData2s, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.zhq_vup_result_url == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.zhq_vup_result_url = defalut;
      print(auto_update.comm.zhq_vup_result_url);
      expect(auto_update.comm.zhq_vup_result_url == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.zhq_vup_result_url == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.comm.nxt_rest_ctrl;
      print(auto_update.comm.nxt_rest_ctrl);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.comm.nxt_rest_ctrl = testData1;
      print(auto_update.comm.nxt_rest_ctrl);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.comm.nxt_rest_ctrl == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.comm.nxt_rest_ctrl == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.comm.nxt_rest_ctrl = testData2;
      print(auto_update.comm.nxt_rest_ctrl);
      expect(auto_update.comm.nxt_rest_ctrl == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.nxt_rest_ctrl == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.comm.nxt_rest_ctrl = defalut;
      print(auto_update.comm.nxt_rest_ctrl);
      expect(auto_update.comm.nxt_rest_ctrl == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.comm.nxt_rest_ctrl == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.system.system;
      print(auto_update.system.system);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.system.system = testData1;
      print(auto_update.system.system);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.system.system == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.system.system == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.system.system = testData2;
      print(auto_update.system.system);
      expect(auto_update.system.system == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.system.system == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.system.system = defalut;
      print(auto_update.system.system);
      expect(auto_update.system.system == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.system.system == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver01.ver01_name;
      print(auto_update.ver01.ver01_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver01.ver01_name = testData1;
      print(auto_update.ver01.ver01_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver01.ver01_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver01.ver01_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver01.ver01_name = testData2;
      print(auto_update.ver01.ver01_name);
      expect(auto_update.ver01.ver01_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.ver01_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver01.ver01_name = defalut;
      print(auto_update.ver01.ver01_name);
      expect(auto_update.ver01.ver01_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.ver01_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver01.date01;
      print(auto_update.ver01.date01);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver01.date01 = testData1;
      print(auto_update.ver01.date01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver01.date01 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver01.date01 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver01.date01 = testData2;
      print(auto_update.ver01.date01);
      expect(auto_update.ver01.date01 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.date01 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver01.date01 = defalut;
      print(auto_update.ver01.date01);
      expect(auto_update.ver01.date01 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.date01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver01.updateid01;
      print(auto_update.ver01.updateid01);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver01.updateid01 = testData1;
      print(auto_update.ver01.updateid01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver01.updateid01 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver01.updateid01 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver01.updateid01 = testData2;
      print(auto_update.ver01.updateid01);
      expect(auto_update.ver01.updateid01 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.updateid01 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver01.updateid01 = defalut;
      print(auto_update.ver01.updateid01);
      expect(auto_update.ver01.updateid01 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.updateid01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver01.power01;
      print(auto_update.ver01.power01);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver01.power01 = testData1;
      print(auto_update.ver01.power01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver01.power01 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver01.power01 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver01.power01 = testData2;
      print(auto_update.ver01.power01);
      expect(auto_update.ver01.power01 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.power01 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver01.power01 = defalut;
      print(auto_update.ver01.power01);
      expect(auto_update.ver01.power01 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver01.power01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver02.ver02_name;
      print(auto_update.ver02.ver02_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver02.ver02_name = testData1;
      print(auto_update.ver02.ver02_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver02.ver02_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver02.ver02_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver02.ver02_name = testData2;
      print(auto_update.ver02.ver02_name);
      expect(auto_update.ver02.ver02_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.ver02_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver02.ver02_name = defalut;
      print(auto_update.ver02.ver02_name);
      expect(auto_update.ver02.ver02_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.ver02_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver02.date02;
      print(auto_update.ver02.date02);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver02.date02 = testData1;
      print(auto_update.ver02.date02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver02.date02 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver02.date02 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver02.date02 = testData2;
      print(auto_update.ver02.date02);
      expect(auto_update.ver02.date02 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.date02 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver02.date02 = defalut;
      print(auto_update.ver02.date02);
      expect(auto_update.ver02.date02 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.date02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver02.updateid02;
      print(auto_update.ver02.updateid02);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver02.updateid02 = testData1;
      print(auto_update.ver02.updateid02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver02.updateid02 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver02.updateid02 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver02.updateid02 = testData2;
      print(auto_update.ver02.updateid02);
      expect(auto_update.ver02.updateid02 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.updateid02 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver02.updateid02 = defalut;
      print(auto_update.ver02.updateid02);
      expect(auto_update.ver02.updateid02 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.updateid02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver02.power02;
      print(auto_update.ver02.power02);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver02.power02 = testData1;
      print(auto_update.ver02.power02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver02.power02 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver02.power02 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver02.power02 = testData2;
      print(auto_update.ver02.power02);
      expect(auto_update.ver02.power02 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.power02 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver02.power02 = defalut;
      print(auto_update.ver02.power02);
      expect(auto_update.ver02.power02 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver02.power02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver03.ver03_name;
      print(auto_update.ver03.ver03_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver03.ver03_name = testData1;
      print(auto_update.ver03.ver03_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver03.ver03_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver03.ver03_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver03.ver03_name = testData2;
      print(auto_update.ver03.ver03_name);
      expect(auto_update.ver03.ver03_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.ver03_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver03.ver03_name = defalut;
      print(auto_update.ver03.ver03_name);
      expect(auto_update.ver03.ver03_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.ver03_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver03.date03;
      print(auto_update.ver03.date03);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver03.date03 = testData1;
      print(auto_update.ver03.date03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver03.date03 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver03.date03 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver03.date03 = testData2;
      print(auto_update.ver03.date03);
      expect(auto_update.ver03.date03 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.date03 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver03.date03 = defalut;
      print(auto_update.ver03.date03);
      expect(auto_update.ver03.date03 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.date03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver03.updateid03;
      print(auto_update.ver03.updateid03);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver03.updateid03 = testData1;
      print(auto_update.ver03.updateid03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver03.updateid03 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver03.updateid03 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver03.updateid03 = testData2;
      print(auto_update.ver03.updateid03);
      expect(auto_update.ver03.updateid03 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.updateid03 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver03.updateid03 = defalut;
      print(auto_update.ver03.updateid03);
      expect(auto_update.ver03.updateid03 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.updateid03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver03.power03;
      print(auto_update.ver03.power03);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver03.power03 = testData1;
      print(auto_update.ver03.power03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver03.power03 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver03.power03 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver03.power03 = testData2;
      print(auto_update.ver03.power03);
      expect(auto_update.ver03.power03 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.power03 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver03.power03 = defalut;
      print(auto_update.ver03.power03);
      expect(auto_update.ver03.power03 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.power03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver03.stat03;
      print(auto_update.ver03.stat03);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver03.stat03 = testData1;
      print(auto_update.ver03.stat03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver03.stat03 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver03.stat03 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver03.stat03 = testData2;
      print(auto_update.ver03.stat03);
      expect(auto_update.ver03.stat03 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.stat03 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver03.stat03 = defalut;
      print(auto_update.ver03.stat03);
      expect(auto_update.ver03.stat03 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver03.stat03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver04.ver04_name;
      print(auto_update.ver04.ver04_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver04.ver04_name = testData1;
      print(auto_update.ver04.ver04_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver04.ver04_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver04.ver04_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver04.ver04_name = testData2;
      print(auto_update.ver04.ver04_name);
      expect(auto_update.ver04.ver04_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.ver04_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver04.ver04_name = defalut;
      print(auto_update.ver04.ver04_name);
      expect(auto_update.ver04.ver04_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.ver04_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver04.date04;
      print(auto_update.ver04.date04);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver04.date04 = testData1;
      print(auto_update.ver04.date04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver04.date04 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver04.date04 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver04.date04 = testData2;
      print(auto_update.ver04.date04);
      expect(auto_update.ver04.date04 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.date04 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver04.date04 = defalut;
      print(auto_update.ver04.date04);
      expect(auto_update.ver04.date04 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.date04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver04.updateid04;
      print(auto_update.ver04.updateid04);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver04.updateid04 = testData1;
      print(auto_update.ver04.updateid04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver04.updateid04 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver04.updateid04 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver04.updateid04 = testData2;
      print(auto_update.ver04.updateid04);
      expect(auto_update.ver04.updateid04 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.updateid04 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver04.updateid04 = defalut;
      print(auto_update.ver04.updateid04);
      expect(auto_update.ver04.updateid04 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.updateid04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver04.power04;
      print(auto_update.ver04.power04);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver04.power04 = testData1;
      print(auto_update.ver04.power04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver04.power04 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver04.power04 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver04.power04 = testData2;
      print(auto_update.ver04.power04);
      expect(auto_update.ver04.power04 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.power04 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver04.power04 = defalut;
      print(auto_update.ver04.power04);
      expect(auto_update.ver04.power04 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver04.power04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver05.ver05_name;
      print(auto_update.ver05.ver05_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver05.ver05_name = testData1;
      print(auto_update.ver05.ver05_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver05.ver05_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver05.ver05_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver05.ver05_name = testData2;
      print(auto_update.ver05.ver05_name);
      expect(auto_update.ver05.ver05_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.ver05_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver05.ver05_name = defalut;
      print(auto_update.ver05.ver05_name);
      expect(auto_update.ver05.ver05_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.ver05_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver05.date05;
      print(auto_update.ver05.date05);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver05.date05 = testData1;
      print(auto_update.ver05.date05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver05.date05 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver05.date05 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver05.date05 = testData2;
      print(auto_update.ver05.date05);
      expect(auto_update.ver05.date05 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.date05 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver05.date05 = defalut;
      print(auto_update.ver05.date05);
      expect(auto_update.ver05.date05 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.date05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver05.updateid05;
      print(auto_update.ver05.updateid05);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver05.updateid05 = testData1;
      print(auto_update.ver05.updateid05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver05.updateid05 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver05.updateid05 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver05.updateid05 = testData2;
      print(auto_update.ver05.updateid05);
      expect(auto_update.ver05.updateid05 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.updateid05 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver05.updateid05 = defalut;
      print(auto_update.ver05.updateid05);
      expect(auto_update.ver05.updateid05 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.updateid05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver05.power05;
      print(auto_update.ver05.power05);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver05.power05 = testData1;
      print(auto_update.ver05.power05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver05.power05 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver05.power05 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver05.power05 = testData2;
      print(auto_update.ver05.power05);
      expect(auto_update.ver05.power05 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.power05 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver05.power05 = defalut;
      print(auto_update.ver05.power05);
      expect(auto_update.ver05.power05 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver05.power05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver06.ver06_name;
      print(auto_update.ver06.ver06_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver06.ver06_name = testData1;
      print(auto_update.ver06.ver06_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver06.ver06_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver06.ver06_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver06.ver06_name = testData2;
      print(auto_update.ver06.ver06_name);
      expect(auto_update.ver06.ver06_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.ver06_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver06.ver06_name = defalut;
      print(auto_update.ver06.ver06_name);
      expect(auto_update.ver06.ver06_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.ver06_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver06.date06;
      print(auto_update.ver06.date06);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver06.date06 = testData1;
      print(auto_update.ver06.date06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver06.date06 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver06.date06 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver06.date06 = testData2;
      print(auto_update.ver06.date06);
      expect(auto_update.ver06.date06 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.date06 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver06.date06 = defalut;
      print(auto_update.ver06.date06);
      expect(auto_update.ver06.date06 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.date06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver06.updateid06;
      print(auto_update.ver06.updateid06);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver06.updateid06 = testData1;
      print(auto_update.ver06.updateid06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver06.updateid06 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver06.updateid06 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver06.updateid06 = testData2;
      print(auto_update.ver06.updateid06);
      expect(auto_update.ver06.updateid06 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.updateid06 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver06.updateid06 = defalut;
      print(auto_update.ver06.updateid06);
      expect(auto_update.ver06.updateid06 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.updateid06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver06.power06;
      print(auto_update.ver06.power06);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver06.power06 = testData1;
      print(auto_update.ver06.power06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver06.power06 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver06.power06 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver06.power06 = testData2;
      print(auto_update.ver06.power06);
      expect(auto_update.ver06.power06 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.power06 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver06.power06 = defalut;
      print(auto_update.ver06.power06);
      expect(auto_update.ver06.power06 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver06.power06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver07.ver07_name;
      print(auto_update.ver07.ver07_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver07.ver07_name = testData1;
      print(auto_update.ver07.ver07_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver07.ver07_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver07.ver07_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver07.ver07_name = testData2;
      print(auto_update.ver07.ver07_name);
      expect(auto_update.ver07.ver07_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.ver07_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver07.ver07_name = defalut;
      print(auto_update.ver07.ver07_name);
      expect(auto_update.ver07.ver07_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.ver07_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver07.date07;
      print(auto_update.ver07.date07);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver07.date07 = testData1;
      print(auto_update.ver07.date07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver07.date07 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver07.date07 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver07.date07 = testData2;
      print(auto_update.ver07.date07);
      expect(auto_update.ver07.date07 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.date07 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver07.date07 = defalut;
      print(auto_update.ver07.date07);
      expect(auto_update.ver07.date07 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.date07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver07.updateid07;
      print(auto_update.ver07.updateid07);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver07.updateid07 = testData1;
      print(auto_update.ver07.updateid07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver07.updateid07 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver07.updateid07 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver07.updateid07 = testData2;
      print(auto_update.ver07.updateid07);
      expect(auto_update.ver07.updateid07 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.updateid07 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver07.updateid07 = defalut;
      print(auto_update.ver07.updateid07);
      expect(auto_update.ver07.updateid07 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.updateid07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.ver07.power07;
      print(auto_update.ver07.power07);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.ver07.power07 = testData1;
      print(auto_update.ver07.power07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.ver07.power07 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.ver07.power07 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.ver07.power07 = testData2;
      print(auto_update.ver07.power07);
      expect(auto_update.ver07.power07 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.power07 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.ver07.power07 = defalut;
      print(auto_update.ver07.power07);
      expect(auto_update.ver07.power07 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.ver07.power07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get01;
      print(auto_update.result.get01);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get01 = testData1;
      print(auto_update.result.get01);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get01 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get01 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get01 = testData2;
      print(auto_update.result.get01);
      expect(auto_update.result.get01 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get01 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get01 = defalut;
      print(auto_update.result.get01);
      expect(auto_update.result.get01 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get01 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get02;
      print(auto_update.result.get02);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get02 = testData1;
      print(auto_update.result.get02);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get02 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get02 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get02 = testData2;
      print(auto_update.result.get02);
      expect(auto_update.result.get02 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get02 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get02 = defalut;
      print(auto_update.result.get02);
      expect(auto_update.result.get02 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get02 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get03;
      print(auto_update.result.get03);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get03 = testData1;
      print(auto_update.result.get03);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get03 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get03 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get03 = testData2;
      print(auto_update.result.get03);
      expect(auto_update.result.get03 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get03 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get03 = defalut;
      print(auto_update.result.get03);
      expect(auto_update.result.get03 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get03 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get04;
      print(auto_update.result.get04);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get04 = testData1;
      print(auto_update.result.get04);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get04 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get04 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get04 = testData2;
      print(auto_update.result.get04);
      expect(auto_update.result.get04 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get04 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get04 = defalut;
      print(auto_update.result.get04);
      expect(auto_update.result.get04 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get04 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get05;
      print(auto_update.result.get05);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get05 = testData1;
      print(auto_update.result.get05);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get05 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get05 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get05 = testData2;
      print(auto_update.result.get05);
      expect(auto_update.result.get05 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get05 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get05 = defalut;
      print(auto_update.result.get05);
      expect(auto_update.result.get05 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get05 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get06;
      print(auto_update.result.get06);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get06 = testData1;
      print(auto_update.result.get06);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get06 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get06 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get06 = testData2;
      print(auto_update.result.get06);
      expect(auto_update.result.get06 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get06 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get06 = defalut;
      print(auto_update.result.get06);
      expect(auto_update.result.get06 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get06 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.get07;
      print(auto_update.result.get07);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.get07 = testData1;
      print(auto_update.result.get07);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.get07 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.get07 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.get07 = testData2;
      print(auto_update.result.get07);
      expect(auto_update.result.get07 == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get07 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.get07 = defalut;
      print(auto_update.result.get07);
      expect(auto_update.result.get07 == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.get07 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      auto_update = Auto_updateJsonFile();
      allPropatyCheckInit(auto_update);

      // ①loadを実行する。
      await auto_update.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = auto_update.result.file_name;
      print(auto_update.result.file_name);

      // ②指定したプロパティにテストデータ1を書き込む。
      auto_update.result.file_name = testData1;
      print(auto_update.result.file_name);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(auto_update.result.file_name == testData1, true);

      // ④saveを実行後、loadを実行する。
      await auto_update.save();
      await auto_update.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(auto_update.result.file_name == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      auto_update.result.file_name = testData2;
      print(auto_update.result.file_name);
      expect(auto_update.result.file_name == testData2, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.file_name == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      auto_update.result.file_name = defalut;
      print(auto_update.result.file_name);
      expect(auto_update.result.file_name == defalut, true);
      await auto_update.save();
      await auto_update.load();
      expect(auto_update.result.file_name == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(auto_update, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Auto_updateJsonFile test)
{
  expect(test.comm.rest_url, "");
  expect(test.comm.get_result_url, "");
  expect(test.comm.vup_result_url, "");
  expect(test.comm.time_out, 0);
  expect(test.comm.retry, 0);
  expect(test.comm.zhq_rest_url, "");
  expect(test.comm.zhq_get_result_url, "");
  expect(test.comm.zhq_vup_result_url, "");
  expect(test.comm.nxt_rest_ctrl, 0);
  expect(test.system.system, 0);
  expect(test.ver01.ver01_name, 0);
  expect(test.ver01.date01, 0);
  expect(test.ver01.updateid01, 0);
  expect(test.ver01.power01, 0);
  expect(test.ver02.ver02_name, 0);
  expect(test.ver02.date02, 0);
  expect(test.ver02.updateid02, 0);
  expect(test.ver02.power02, 0);
  expect(test.ver03.ver03_name, 0);
  expect(test.ver03.date03, 0);
  expect(test.ver03.updateid03, 0);
  expect(test.ver03.power03, 0);
  expect(test.ver03.stat03, 0);
  expect(test.ver04.ver04_name, 0);
  expect(test.ver04.date04, 0);
  expect(test.ver04.updateid04, 0);
  expect(test.ver04.power04, 0);
  expect(test.ver05.ver05_name, 0);
  expect(test.ver05.date05, 0);
  expect(test.ver05.updateid05, 0);
  expect(test.ver05.power05, 0);
  expect(test.ver06.ver06_name, 0);
  expect(test.ver06.date06, 0);
  expect(test.ver06.updateid06, 0);
  expect(test.ver06.power06, 0);
  expect(test.ver07.ver07_name, 0);
  expect(test.ver07.date07, 0);
  expect(test.ver07.updateid07, 0);
  expect(test.ver07.power07, 0);
  expect(test.result.get01, 0);
  expect(test.result.get02, 0);
  expect(test.result.get03, 0);
  expect(test.result.get04, 0);
  expect(test.result.get05, 0);
  expect(test.result.get06, 0);
  expect(test.result.get07, 0);
  expect(test.result.file_name, 0);
}

void allPropatyCheck(Auto_updateJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.comm.rest_url, "http://118.243.93.122/autoupdates?");
  }
  expect(test.comm.get_result_url, "http://118.243.93.122/getfileresults?");
  expect(test.comm.vup_result_url, "http://118.243.93.122/updateresults?");
  expect(test.comm.time_out, 180);
  expect(test.comm.retry, 3);
  expect(test.comm.zhq_rest_url, "http://10.147.1.102/autoupdates?");
  expect(test.comm.zhq_get_result_url, "http://10.147.1.102/getfileresults?");
  expect(test.comm.zhq_vup_result_url, "http://10.147.1.102/updateresults?");
  expect(test.comm.nxt_rest_ctrl, 1);
  expect(test.system.system, 0);
  expect(test.ver01.ver01_name, 0);
  expect(test.ver01.date01, 0);
  expect(test.ver01.updateid01, 0);
  expect(test.ver01.power01, 0);
  expect(test.ver02.ver02_name, 0);
  expect(test.ver02.date02, 0);
  expect(test.ver02.updateid02, 0);
  expect(test.ver02.power02, 0);
  expect(test.ver03.ver03_name, 0);
  expect(test.ver03.date03, 0);
  expect(test.ver03.updateid03, 0);
  expect(test.ver03.power03, 0);
  expect(test.ver03.stat03, 0);
  expect(test.ver04.ver04_name, 0);
  expect(test.ver04.date04, 0);
  expect(test.ver04.updateid04, 0);
  expect(test.ver04.power04, 0);
  expect(test.ver05.ver05_name, 0);
  expect(test.ver05.date05, 0);
  expect(test.ver05.updateid05, 0);
  expect(test.ver05.power05, 0);
  expect(test.ver06.ver06_name, 0);
  expect(test.ver06.date06, 0);
  expect(test.ver06.updateid06, 0);
  expect(test.ver06.power06, 0);
  expect(test.ver07.ver07_name, 0);
  expect(test.ver07.date07, 0);
  expect(test.ver07.updateid07, 0);
  expect(test.ver07.power07, 0);
  expect(test.result.get01, 0);
  expect(test.result.get02, 0);
  expect(test.result.get03, 0);
  expect(test.result.get04, 0);
  expect(test.result.get05, 0);
  expect(test.result.get06, 0);
  expect(test.result.get07, 0);
  expect(test.result.file_name, 0);
}

