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
import '../../../../lib/app/common/cls_conf/consistency_acxJsonFile.dart';

late Consistency_acxJsonFile consistency_acx;

void main(){
  consistency_acxJsonFile_test();
}

void consistency_acxJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "consistency_acx.json";
  const String section = "version";
  const String key = "title";
  const defaultData = "バージョン";
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Consistency_acxJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Consistency_acxJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Consistency_acxJsonFile().setDefault();
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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await consistency_acx.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(consistency_acx,true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        consistency_acx.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await consistency_acx.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(consistency_acx,true);

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
      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①：loadを実行する。
      await consistency_acx.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = consistency_acx.version.title;
      consistency_acx.version.title = testData1s;
      expect(consistency_acx.version.title == testData1s, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await consistency_acx.load();
      expect(consistency_acx.version.title != testData1s, true);
      expect(consistency_acx.version.title == prefixData, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = consistency_acx.version.title;
      consistency_acx.version.title = testData1s;
      expect(consistency_acx.version.title, testData1s);

      // ③saveを実行する。
      await consistency_acx.save();

      // ④loadを実行する。
      await consistency_acx.load();

      expect(consistency_acx.version.title != prefixData, true);
      expect(consistency_acx.version.title == testData1s, true);
      allPropatyCheck(consistency_acx,false);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await consistency_acx.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await consistency_acx.save();

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await consistency_acx.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(consistency_acx.version.title, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = consistency_acx.version.title;
      consistency_acx.version.title = testData1s;

      // ③ saveを実行する。
      await consistency_acx.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1s != prefixData, true);
      expect(consistency_acx.version.title, testData1s);

      // ④ loadを実行する。
      await consistency_acx.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(consistency_acx.version.title == testData1s, true);
      allPropatyCheck(consistency_acx,false);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await consistency_acx.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(consistency_acx,true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②任意のプロパティの値を変更する。
      consistency_acx.version.title = testData1s;
      expect(consistency_acx.version.title, testData1s);

      // ③saveを実行する。
      await consistency_acx.save();
      expect(consistency_acx.version.title, testData1s);

      // ④loadを実行する。
      await consistency_acx.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(consistency_acx,true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await consistency_acx.setValueWithName(section, key, testData1s);

      // ②loadを実行する。
      await consistency_acx.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(consistency_acx.version.title == testData1s, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await consistency_acx.setValueWithName("test_section", key, testData1s);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await consistency_acx.setValueWithName(section, "test_key", testData1s);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②任意のプロパティを変更する。
      consistency_acx.version.title = testData1s;

      // ③saveを実行する。
      await consistency_acx.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await consistency_acx.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1s == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②任意のプロパティを変更する。
      consistency_acx.version.title = testData1s;

      // ③saveを実行する。
      await consistency_acx.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await consistency_acx.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②任意のプロパティを変更する。
      consistency_acx.version.title = testData1s;

      // ③saveを実行する。
      await consistency_acx.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await consistency_acx.getValueWithName(section, "test_key");
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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await consistency_acx.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      consistency_acx.version.title = testData1s;
      expect(consistency_acx.version.title, testData1s);

      // ④saveを実行する。
      await consistency_acx.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(consistency_acx.version.title, testData1s);
      
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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await consistency_acx.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      expect(consistency_acx.version.title == testData1s, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await consistency_acx.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      expect(consistency_acx.version.title == testData2s, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await consistency_acx.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      expect(consistency_acx.version.title == testData1s, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await consistency_acx.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      expect(consistency_acx.version.title == testData2s, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await consistency_acx.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      expect(consistency_acx.version.title == testData1s, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await consistency_acx.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      expect(consistency_acx.version.title == testData1s, true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await consistency_acx.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      allPropatyCheck(consistency_acx,true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1s, testData2s);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await consistency_acx.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + consistency_acx.version.title.toString());
      allPropatyCheck(consistency_acx,true);

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

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.title;
      print(consistency_acx.version.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.title = testData1s;
      print(consistency_acx.version.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.title = testData2s;
      print(consistency_acx.version.title);
      expect(consistency_acx.version.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.title = defalut;
      print(consistency_acx.version.title);
      expect(consistency_acx.version.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.obj;
      print(consistency_acx.version.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.obj = testData1;
      print(consistency_acx.version.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.obj = testData2;
      print(consistency_acx.version.obj);
      expect(consistency_acx.version.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.obj = defalut;
      print(consistency_acx.version.obj);
      expect(consistency_acx.version.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.condi;
      print(consistency_acx.version.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.condi = testData1;
      print(consistency_acx.version.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.condi = testData2;
      print(consistency_acx.version.condi);
      expect(consistency_acx.version.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.condi = defalut;
      print(consistency_acx.version.condi);
      expect(consistency_acx.version.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.typ;
      print(consistency_acx.version.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.typ = testData1;
      print(consistency_acx.version.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.typ = testData2;
      print(consistency_acx.version.typ);
      expect(consistency_acx.version.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.typ = defalut;
      print(consistency_acx.version.typ);
      expect(consistency_acx.version.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.ini_typ;
      print(consistency_acx.version.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.ini_typ = testData1;
      print(consistency_acx.version.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.ini_typ = testData2;
      print(consistency_acx.version.ini_typ);
      expect(consistency_acx.version.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.ini_typ = defalut;
      print(consistency_acx.version.ini_typ);
      expect(consistency_acx.version.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.file;
      print(consistency_acx.version.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.file = testData1s;
      print(consistency_acx.version.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.file = testData2s;
      print(consistency_acx.version.file);
      expect(consistency_acx.version.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.file = defalut;
      print(consistency_acx.version.file);
      expect(consistency_acx.version.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.section;
      print(consistency_acx.version.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.section = testData1s;
      print(consistency_acx.version.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.section = testData2s;
      print(consistency_acx.version.section);
      expect(consistency_acx.version.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.section = defalut;
      print(consistency_acx.version.section);
      expect(consistency_acx.version.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.version.keyword;
      print(consistency_acx.version.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.version.keyword = testData1s;
      print(consistency_acx.version.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.version.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.version.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.version.keyword = testData2s;
      print(consistency_acx.version.keyword);
      expect(consistency_acx.version.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.version.keyword = defalut;
      print(consistency_acx.version.keyword);
      expect(consistency_acx.version.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.version.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.title;
      print(consistency_acx.acr_cnct.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.title = testData1s;
      print(consistency_acx.acr_cnct.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.title = testData2s;
      print(consistency_acx.acr_cnct.title);
      expect(consistency_acx.acr_cnct.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.title = defalut;
      print(consistency_acx.acr_cnct.title);
      expect(consistency_acx.acr_cnct.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.obj;
      print(consistency_acx.acr_cnct.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.obj = testData1;
      print(consistency_acx.acr_cnct.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.obj = testData2;
      print(consistency_acx.acr_cnct.obj);
      expect(consistency_acx.acr_cnct.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.obj = defalut;
      print(consistency_acx.acr_cnct.obj);
      expect(consistency_acx.acr_cnct.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.condi;
      print(consistency_acx.acr_cnct.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.condi = testData1;
      print(consistency_acx.acr_cnct.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.condi = testData2;
      print(consistency_acx.acr_cnct.condi);
      expect(consistency_acx.acr_cnct.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.condi = defalut;
      print(consistency_acx.acr_cnct.condi);
      expect(consistency_acx.acr_cnct.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.typ;
      print(consistency_acx.acr_cnct.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.typ = testData1;
      print(consistency_acx.acr_cnct.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.typ = testData2;
      print(consistency_acx.acr_cnct.typ);
      expect(consistency_acx.acr_cnct.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.typ = defalut;
      print(consistency_acx.acr_cnct.typ);
      expect(consistency_acx.acr_cnct.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.ini_typ;
      print(consistency_acx.acr_cnct.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.ini_typ = testData1;
      print(consistency_acx.acr_cnct.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.ini_typ = testData2;
      print(consistency_acx.acr_cnct.ini_typ);
      expect(consistency_acx.acr_cnct.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.ini_typ = defalut;
      print(consistency_acx.acr_cnct.ini_typ);
      expect(consistency_acx.acr_cnct.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.file;
      print(consistency_acx.acr_cnct.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.file = testData1s;
      print(consistency_acx.acr_cnct.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.file = testData2s;
      print(consistency_acx.acr_cnct.file);
      expect(consistency_acx.acr_cnct.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.file = defalut;
      print(consistency_acx.acr_cnct.file);
      expect(consistency_acx.acr_cnct.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.section;
      print(consistency_acx.acr_cnct.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.section = testData1s;
      print(consistency_acx.acr_cnct.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.section = testData2s;
      print(consistency_acx.acr_cnct.section);
      expect(consistency_acx.acr_cnct.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.section = defalut;
      print(consistency_acx.acr_cnct.section);
      expect(consistency_acx.acr_cnct.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr_cnct.keyword;
      print(consistency_acx.acr_cnct.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr_cnct.keyword = testData1s;
      print(consistency_acx.acr_cnct.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr_cnct.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr_cnct.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr_cnct.keyword = testData2s;
      print(consistency_acx.acr_cnct.keyword);
      expect(consistency_acx.acr_cnct.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr_cnct.keyword = defalut;
      print(consistency_acx.acr_cnct.keyword);
      expect(consistency_acx.acr_cnct.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr_cnct.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.title;
      print(consistency_acx.acb_deccin.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.title = testData1s;
      print(consistency_acx.acb_deccin.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.title = testData2s;
      print(consistency_acx.acb_deccin.title);
      expect(consistency_acx.acb_deccin.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.title = defalut;
      print(consistency_acx.acb_deccin.title);
      expect(consistency_acx.acb_deccin.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.obj;
      print(consistency_acx.acb_deccin.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.obj = testData1;
      print(consistency_acx.acb_deccin.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.obj = testData2;
      print(consistency_acx.acb_deccin.obj);
      expect(consistency_acx.acb_deccin.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.obj = defalut;
      print(consistency_acx.acb_deccin.obj);
      expect(consistency_acx.acb_deccin.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.condi;
      print(consistency_acx.acb_deccin.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.condi = testData1;
      print(consistency_acx.acb_deccin.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.condi = testData2;
      print(consistency_acx.acb_deccin.condi);
      expect(consistency_acx.acb_deccin.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.condi = defalut;
      print(consistency_acx.acb_deccin.condi);
      expect(consistency_acx.acb_deccin.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.typ;
      print(consistency_acx.acb_deccin.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.typ = testData1;
      print(consistency_acx.acb_deccin.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.typ = testData2;
      print(consistency_acx.acb_deccin.typ);
      expect(consistency_acx.acb_deccin.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.typ = defalut;
      print(consistency_acx.acb_deccin.typ);
      expect(consistency_acx.acb_deccin.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.ini_typ;
      print(consistency_acx.acb_deccin.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.ini_typ = testData1;
      print(consistency_acx.acb_deccin.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.ini_typ = testData2;
      print(consistency_acx.acb_deccin.ini_typ);
      expect(consistency_acx.acb_deccin.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.ini_typ = defalut;
      print(consistency_acx.acb_deccin.ini_typ);
      expect(consistency_acx.acb_deccin.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.file;
      print(consistency_acx.acb_deccin.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.file = testData1s;
      print(consistency_acx.acb_deccin.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.file = testData2s;
      print(consistency_acx.acb_deccin.file);
      expect(consistency_acx.acb_deccin.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.file = defalut;
      print(consistency_acx.acb_deccin.file);
      expect(consistency_acx.acb_deccin.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.section;
      print(consistency_acx.acb_deccin.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.section = testData1s;
      print(consistency_acx.acb_deccin.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.section = testData2s;
      print(consistency_acx.acb_deccin.section);
      expect(consistency_acx.acb_deccin.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.section = defalut;
      print(consistency_acx.acb_deccin.section);
      expect(consistency_acx.acb_deccin.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_deccin.keyword;
      print(consistency_acx.acb_deccin.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_deccin.keyword = testData1s;
      print(consistency_acx.acb_deccin.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_deccin.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_deccin.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_deccin.keyword = testData2s;
      print(consistency_acx.acb_deccin.keyword);
      expect(consistency_acx.acb_deccin.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_deccin.keyword = defalut;
      print(consistency_acx.acb_deccin.keyword);
      expect(consistency_acx.acb_deccin.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_deccin.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.title;
      print(consistency_acx.acb_select.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.title = testData1s;
      print(consistency_acx.acb_select.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.title = testData2s;
      print(consistency_acx.acb_select.title);
      expect(consistency_acx.acb_select.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.title = defalut;
      print(consistency_acx.acb_select.title);
      expect(consistency_acx.acb_select.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.obj;
      print(consistency_acx.acb_select.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.obj = testData1;
      print(consistency_acx.acb_select.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.obj = testData2;
      print(consistency_acx.acb_select.obj);
      expect(consistency_acx.acb_select.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.obj = defalut;
      print(consistency_acx.acb_select.obj);
      expect(consistency_acx.acb_select.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.condi;
      print(consistency_acx.acb_select.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.condi = testData1;
      print(consistency_acx.acb_select.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.condi = testData2;
      print(consistency_acx.acb_select.condi);
      expect(consistency_acx.acb_select.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.condi = defalut;
      print(consistency_acx.acb_select.condi);
      expect(consistency_acx.acb_select.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.typ;
      print(consistency_acx.acb_select.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.typ = testData1;
      print(consistency_acx.acb_select.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.typ = testData2;
      print(consistency_acx.acb_select.typ);
      expect(consistency_acx.acb_select.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.typ = defalut;
      print(consistency_acx.acb_select.typ);
      expect(consistency_acx.acb_select.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.ini_typ;
      print(consistency_acx.acb_select.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.ini_typ = testData1;
      print(consistency_acx.acb_select.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.ini_typ = testData2;
      print(consistency_acx.acb_select.ini_typ);
      expect(consistency_acx.acb_select.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.ini_typ = defalut;
      print(consistency_acx.acb_select.ini_typ);
      expect(consistency_acx.acb_select.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.file;
      print(consistency_acx.acb_select.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.file = testData1s;
      print(consistency_acx.acb_select.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.file = testData2s;
      print(consistency_acx.acb_select.file);
      expect(consistency_acx.acb_select.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.file = defalut;
      print(consistency_acx.acb_select.file);
      expect(consistency_acx.acb_select.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.section;
      print(consistency_acx.acb_select.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.section = testData1s;
      print(consistency_acx.acb_select.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.section = testData2s;
      print(consistency_acx.acb_select.section);
      expect(consistency_acx.acb_select.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.section = defalut;
      print(consistency_acx.acb_select.section);
      expect(consistency_acx.acb_select.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb_select.keyword;
      print(consistency_acx.acb_select.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb_select.keyword = testData1s;
      print(consistency_acx.acb_select.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb_select.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb_select.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb_select.keyword = testData2s;
      print(consistency_acx.acb_select.keyword);
      expect(consistency_acx.acb_select.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb_select.keyword = defalut;
      print(consistency_acx.acb_select.keyword);
      expect(consistency_acx.acb_select.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb_select.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.title;
      print(consistency_acx.auto_deccin.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.title = testData1s;
      print(consistency_acx.auto_deccin.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.title = testData2s;
      print(consistency_acx.auto_deccin.title);
      expect(consistency_acx.auto_deccin.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.title = defalut;
      print(consistency_acx.auto_deccin.title);
      expect(consistency_acx.auto_deccin.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.obj;
      print(consistency_acx.auto_deccin.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.obj = testData1;
      print(consistency_acx.auto_deccin.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.obj = testData2;
      print(consistency_acx.auto_deccin.obj);
      expect(consistency_acx.auto_deccin.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.obj = defalut;
      print(consistency_acx.auto_deccin.obj);
      expect(consistency_acx.auto_deccin.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.condi;
      print(consistency_acx.auto_deccin.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.condi = testData1;
      print(consistency_acx.auto_deccin.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.condi = testData2;
      print(consistency_acx.auto_deccin.condi);
      expect(consistency_acx.auto_deccin.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.condi = defalut;
      print(consistency_acx.auto_deccin.condi);
      expect(consistency_acx.auto_deccin.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.typ;
      print(consistency_acx.auto_deccin.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.typ = testData1;
      print(consistency_acx.auto_deccin.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.typ = testData2;
      print(consistency_acx.auto_deccin.typ);
      expect(consistency_acx.auto_deccin.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.typ = defalut;
      print(consistency_acx.auto_deccin.typ);
      expect(consistency_acx.auto_deccin.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.ini_typ;
      print(consistency_acx.auto_deccin.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.ini_typ = testData1;
      print(consistency_acx.auto_deccin.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.ini_typ = testData2;
      print(consistency_acx.auto_deccin.ini_typ);
      expect(consistency_acx.auto_deccin.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.ini_typ = defalut;
      print(consistency_acx.auto_deccin.ini_typ);
      expect(consistency_acx.auto_deccin.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.file;
      print(consistency_acx.auto_deccin.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.file = testData1s;
      print(consistency_acx.auto_deccin.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.file = testData2s;
      print(consistency_acx.auto_deccin.file);
      expect(consistency_acx.auto_deccin.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.file = defalut;
      print(consistency_acx.auto_deccin.file);
      expect(consistency_acx.auto_deccin.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.section;
      print(consistency_acx.auto_deccin.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.section = testData1s;
      print(consistency_acx.auto_deccin.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.section = testData2s;
      print(consistency_acx.auto_deccin.section);
      expect(consistency_acx.auto_deccin.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.section = defalut;
      print(consistency_acx.auto_deccin.section);
      expect(consistency_acx.auto_deccin.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.auto_deccin.keyword;
      print(consistency_acx.auto_deccin.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.auto_deccin.keyword = testData1s;
      print(consistency_acx.auto_deccin.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.auto_deccin.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.auto_deccin.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.auto_deccin.keyword = testData2s;
      print(consistency_acx.auto_deccin.keyword);
      expect(consistency_acx.auto_deccin.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.auto_deccin.keyword = defalut;
      print(consistency_acx.auto_deccin.keyword);
      expect(consistency_acx.auto_deccin.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.auto_deccin.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.title;
      print(consistency_acx.acr50_ssw14_0.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.title = testData1s;
      print(consistency_acx.acr50_ssw14_0.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.title = testData2s;
      print(consistency_acx.acr50_ssw14_0.title);
      expect(consistency_acx.acr50_ssw14_0.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.title = defalut;
      print(consistency_acx.acr50_ssw14_0.title);
      expect(consistency_acx.acr50_ssw14_0.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.obj;
      print(consistency_acx.acr50_ssw14_0.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.obj = testData1;
      print(consistency_acx.acr50_ssw14_0.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.obj = testData2;
      print(consistency_acx.acr50_ssw14_0.obj);
      expect(consistency_acx.acr50_ssw14_0.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.obj = defalut;
      print(consistency_acx.acr50_ssw14_0.obj);
      expect(consistency_acx.acr50_ssw14_0.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.condi;
      print(consistency_acx.acr50_ssw14_0.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.condi = testData1;
      print(consistency_acx.acr50_ssw14_0.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.condi = testData2;
      print(consistency_acx.acr50_ssw14_0.condi);
      expect(consistency_acx.acr50_ssw14_0.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.condi = defalut;
      print(consistency_acx.acr50_ssw14_0.condi);
      expect(consistency_acx.acr50_ssw14_0.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.typ;
      print(consistency_acx.acr50_ssw14_0.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.typ = testData1;
      print(consistency_acx.acr50_ssw14_0.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.typ = testData2;
      print(consistency_acx.acr50_ssw14_0.typ);
      expect(consistency_acx.acr50_ssw14_0.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.typ = defalut;
      print(consistency_acx.acr50_ssw14_0.typ);
      expect(consistency_acx.acr50_ssw14_0.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.ini_typ;
      print(consistency_acx.acr50_ssw14_0.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.ini_typ = testData1;
      print(consistency_acx.acr50_ssw14_0.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.ini_typ = testData2;
      print(consistency_acx.acr50_ssw14_0.ini_typ);
      expect(consistency_acx.acr50_ssw14_0.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.ini_typ = defalut;
      print(consistency_acx.acr50_ssw14_0.ini_typ);
      expect(consistency_acx.acr50_ssw14_0.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.file;
      print(consistency_acx.acr50_ssw14_0.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.file = testData1s;
      print(consistency_acx.acr50_ssw14_0.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.file = testData2s;
      print(consistency_acx.acr50_ssw14_0.file);
      expect(consistency_acx.acr50_ssw14_0.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.file = defalut;
      print(consistency_acx.acr50_ssw14_0.file);
      expect(consistency_acx.acr50_ssw14_0.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.section;
      print(consistency_acx.acr50_ssw14_0.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.section = testData1s;
      print(consistency_acx.acr50_ssw14_0.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.section = testData2s;
      print(consistency_acx.acr50_ssw14_0.section);
      expect(consistency_acx.acr50_ssw14_0.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.section = defalut;
      print(consistency_acx.acr50_ssw14_0.section);
      expect(consistency_acx.acr50_ssw14_0.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_0.keyword;
      print(consistency_acx.acr50_ssw14_0.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_0.keyword = testData1s;
      print(consistency_acx.acr50_ssw14_0.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_0.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_0.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_0.keyword = testData2s;
      print(consistency_acx.acr50_ssw14_0.keyword);
      expect(consistency_acx.acr50_ssw14_0.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_0.keyword = defalut;
      print(consistency_acx.acr50_ssw14_0.keyword);
      expect(consistency_acx.acr50_ssw14_0.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_0.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.title;
      print(consistency_acx.acr50_ssw14_1_2.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.title = testData1s;
      print(consistency_acx.acr50_ssw14_1_2.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.title = testData2s;
      print(consistency_acx.acr50_ssw14_1_2.title);
      expect(consistency_acx.acr50_ssw14_1_2.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.title = defalut;
      print(consistency_acx.acr50_ssw14_1_2.title);
      expect(consistency_acx.acr50_ssw14_1_2.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.obj;
      print(consistency_acx.acr50_ssw14_1_2.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.obj = testData1;
      print(consistency_acx.acr50_ssw14_1_2.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.obj = testData2;
      print(consistency_acx.acr50_ssw14_1_2.obj);
      expect(consistency_acx.acr50_ssw14_1_2.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.obj = defalut;
      print(consistency_acx.acr50_ssw14_1_2.obj);
      expect(consistency_acx.acr50_ssw14_1_2.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.condi;
      print(consistency_acx.acr50_ssw14_1_2.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.condi = testData1;
      print(consistency_acx.acr50_ssw14_1_2.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.condi = testData2;
      print(consistency_acx.acr50_ssw14_1_2.condi);
      expect(consistency_acx.acr50_ssw14_1_2.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.condi = defalut;
      print(consistency_acx.acr50_ssw14_1_2.condi);
      expect(consistency_acx.acr50_ssw14_1_2.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.typ;
      print(consistency_acx.acr50_ssw14_1_2.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.typ = testData1;
      print(consistency_acx.acr50_ssw14_1_2.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.typ = testData2;
      print(consistency_acx.acr50_ssw14_1_2.typ);
      expect(consistency_acx.acr50_ssw14_1_2.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.typ = defalut;
      print(consistency_acx.acr50_ssw14_1_2.typ);
      expect(consistency_acx.acr50_ssw14_1_2.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.ini_typ;
      print(consistency_acx.acr50_ssw14_1_2.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.ini_typ = testData1;
      print(consistency_acx.acr50_ssw14_1_2.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.ini_typ = testData2;
      print(consistency_acx.acr50_ssw14_1_2.ini_typ);
      expect(consistency_acx.acr50_ssw14_1_2.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.ini_typ = defalut;
      print(consistency_acx.acr50_ssw14_1_2.ini_typ);
      expect(consistency_acx.acr50_ssw14_1_2.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.file;
      print(consistency_acx.acr50_ssw14_1_2.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.file = testData1s;
      print(consistency_acx.acr50_ssw14_1_2.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.file = testData2s;
      print(consistency_acx.acr50_ssw14_1_2.file);
      expect(consistency_acx.acr50_ssw14_1_2.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.file = defalut;
      print(consistency_acx.acr50_ssw14_1_2.file);
      expect(consistency_acx.acr50_ssw14_1_2.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.section;
      print(consistency_acx.acr50_ssw14_1_2.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.section = testData1s;
      print(consistency_acx.acr50_ssw14_1_2.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.section = testData2s;
      print(consistency_acx.acr50_ssw14_1_2.section);
      expect(consistency_acx.acr50_ssw14_1_2.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.section = defalut;
      print(consistency_acx.acr50_ssw14_1_2.section);
      expect(consistency_acx.acr50_ssw14_1_2.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_1_2.keyword;
      print(consistency_acx.acr50_ssw14_1_2.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_1_2.keyword = testData1s;
      print(consistency_acx.acr50_ssw14_1_2.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_1_2.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_1_2.keyword = testData2s;
      print(consistency_acx.acr50_ssw14_1_2.keyword);
      expect(consistency_acx.acr50_ssw14_1_2.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_1_2.keyword = defalut;
      print(consistency_acx.acr50_ssw14_1_2.keyword);
      expect(consistency_acx.acr50_ssw14_1_2.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_1_2.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.title;
      print(consistency_acx.acr50_ssw14_3_4.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.title = testData1s;
      print(consistency_acx.acr50_ssw14_3_4.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.title = testData2s;
      print(consistency_acx.acr50_ssw14_3_4.title);
      expect(consistency_acx.acr50_ssw14_3_4.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.title = defalut;
      print(consistency_acx.acr50_ssw14_3_4.title);
      expect(consistency_acx.acr50_ssw14_3_4.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.obj;
      print(consistency_acx.acr50_ssw14_3_4.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.obj = testData1;
      print(consistency_acx.acr50_ssw14_3_4.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.obj = testData2;
      print(consistency_acx.acr50_ssw14_3_4.obj);
      expect(consistency_acx.acr50_ssw14_3_4.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.obj = defalut;
      print(consistency_acx.acr50_ssw14_3_4.obj);
      expect(consistency_acx.acr50_ssw14_3_4.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.condi;
      print(consistency_acx.acr50_ssw14_3_4.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.condi = testData1;
      print(consistency_acx.acr50_ssw14_3_4.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.condi = testData2;
      print(consistency_acx.acr50_ssw14_3_4.condi);
      expect(consistency_acx.acr50_ssw14_3_4.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.condi = defalut;
      print(consistency_acx.acr50_ssw14_3_4.condi);
      expect(consistency_acx.acr50_ssw14_3_4.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.typ;
      print(consistency_acx.acr50_ssw14_3_4.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.typ = testData1;
      print(consistency_acx.acr50_ssw14_3_4.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.typ = testData2;
      print(consistency_acx.acr50_ssw14_3_4.typ);
      expect(consistency_acx.acr50_ssw14_3_4.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.typ = defalut;
      print(consistency_acx.acr50_ssw14_3_4.typ);
      expect(consistency_acx.acr50_ssw14_3_4.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.ini_typ;
      print(consistency_acx.acr50_ssw14_3_4.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.ini_typ = testData1;
      print(consistency_acx.acr50_ssw14_3_4.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.ini_typ = testData2;
      print(consistency_acx.acr50_ssw14_3_4.ini_typ);
      expect(consistency_acx.acr50_ssw14_3_4.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.ini_typ = defalut;
      print(consistency_acx.acr50_ssw14_3_4.ini_typ);
      expect(consistency_acx.acr50_ssw14_3_4.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.file;
      print(consistency_acx.acr50_ssw14_3_4.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.file = testData1s;
      print(consistency_acx.acr50_ssw14_3_4.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.file = testData2s;
      print(consistency_acx.acr50_ssw14_3_4.file);
      expect(consistency_acx.acr50_ssw14_3_4.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.file = defalut;
      print(consistency_acx.acr50_ssw14_3_4.file);
      expect(consistency_acx.acr50_ssw14_3_4.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.section;
      print(consistency_acx.acr50_ssw14_3_4.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.section = testData1s;
      print(consistency_acx.acr50_ssw14_3_4.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.section = testData2s;
      print(consistency_acx.acr50_ssw14_3_4.section);
      expect(consistency_acx.acr50_ssw14_3_4.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.section = defalut;
      print(consistency_acx.acr50_ssw14_3_4.section);
      expect(consistency_acx.acr50_ssw14_3_4.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_3_4.keyword;
      print(consistency_acx.acr50_ssw14_3_4.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_3_4.keyword = testData1s;
      print(consistency_acx.acr50_ssw14_3_4.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_3_4.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_3_4.keyword = testData2s;
      print(consistency_acx.acr50_ssw14_3_4.keyword);
      expect(consistency_acx.acr50_ssw14_3_4.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_3_4.keyword = defalut;
      print(consistency_acx.acr50_ssw14_3_4.keyword);
      expect(consistency_acx.acr50_ssw14_3_4.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_3_4.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.title;
      print(consistency_acx.acr50_ssw14_5.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.title = testData1s;
      print(consistency_acx.acr50_ssw14_5.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.title = testData2s;
      print(consistency_acx.acr50_ssw14_5.title);
      expect(consistency_acx.acr50_ssw14_5.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.title = defalut;
      print(consistency_acx.acr50_ssw14_5.title);
      expect(consistency_acx.acr50_ssw14_5.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.obj;
      print(consistency_acx.acr50_ssw14_5.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.obj = testData1;
      print(consistency_acx.acr50_ssw14_5.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.obj = testData2;
      print(consistency_acx.acr50_ssw14_5.obj);
      expect(consistency_acx.acr50_ssw14_5.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.obj = defalut;
      print(consistency_acx.acr50_ssw14_5.obj);
      expect(consistency_acx.acr50_ssw14_5.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.condi;
      print(consistency_acx.acr50_ssw14_5.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.condi = testData1;
      print(consistency_acx.acr50_ssw14_5.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.condi = testData2;
      print(consistency_acx.acr50_ssw14_5.condi);
      expect(consistency_acx.acr50_ssw14_5.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.condi = defalut;
      print(consistency_acx.acr50_ssw14_5.condi);
      expect(consistency_acx.acr50_ssw14_5.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.typ;
      print(consistency_acx.acr50_ssw14_5.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.typ = testData1;
      print(consistency_acx.acr50_ssw14_5.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.typ = testData2;
      print(consistency_acx.acr50_ssw14_5.typ);
      expect(consistency_acx.acr50_ssw14_5.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.typ = defalut;
      print(consistency_acx.acr50_ssw14_5.typ);
      expect(consistency_acx.acr50_ssw14_5.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.ini_typ;
      print(consistency_acx.acr50_ssw14_5.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.ini_typ = testData1;
      print(consistency_acx.acr50_ssw14_5.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.ini_typ = testData2;
      print(consistency_acx.acr50_ssw14_5.ini_typ);
      expect(consistency_acx.acr50_ssw14_5.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.ini_typ = defalut;
      print(consistency_acx.acr50_ssw14_5.ini_typ);
      expect(consistency_acx.acr50_ssw14_5.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.file;
      print(consistency_acx.acr50_ssw14_5.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.file = testData1s;
      print(consistency_acx.acr50_ssw14_5.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.file = testData2s;
      print(consistency_acx.acr50_ssw14_5.file);
      expect(consistency_acx.acr50_ssw14_5.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.file = defalut;
      print(consistency_acx.acr50_ssw14_5.file);
      expect(consistency_acx.acr50_ssw14_5.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.section;
      print(consistency_acx.acr50_ssw14_5.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.section = testData1s;
      print(consistency_acx.acr50_ssw14_5.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.section = testData2s;
      print(consistency_acx.acr50_ssw14_5.section);
      expect(consistency_acx.acr50_ssw14_5.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.section = defalut;
      print(consistency_acx.acr50_ssw14_5.section);
      expect(consistency_acx.acr50_ssw14_5.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_5.keyword;
      print(consistency_acx.acr50_ssw14_5.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_5.keyword = testData1s;
      print(consistency_acx.acr50_ssw14_5.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_5.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_5.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_5.keyword = testData2s;
      print(consistency_acx.acr50_ssw14_5.keyword);
      expect(consistency_acx.acr50_ssw14_5.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_5.keyword = defalut;
      print(consistency_acx.acr50_ssw14_5.keyword);
      expect(consistency_acx.acr50_ssw14_5.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_5.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.title;
      print(consistency_acx.acr50_ssw14_7.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.title = testData1s;
      print(consistency_acx.acr50_ssw14_7.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.title = testData2s;
      print(consistency_acx.acr50_ssw14_7.title);
      expect(consistency_acx.acr50_ssw14_7.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.title = defalut;
      print(consistency_acx.acr50_ssw14_7.title);
      expect(consistency_acx.acr50_ssw14_7.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.obj;
      print(consistency_acx.acr50_ssw14_7.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.obj = testData1;
      print(consistency_acx.acr50_ssw14_7.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.obj = testData2;
      print(consistency_acx.acr50_ssw14_7.obj);
      expect(consistency_acx.acr50_ssw14_7.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.obj = defalut;
      print(consistency_acx.acr50_ssw14_7.obj);
      expect(consistency_acx.acr50_ssw14_7.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.condi;
      print(consistency_acx.acr50_ssw14_7.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.condi = testData1;
      print(consistency_acx.acr50_ssw14_7.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.condi = testData2;
      print(consistency_acx.acr50_ssw14_7.condi);
      expect(consistency_acx.acr50_ssw14_7.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.condi = defalut;
      print(consistency_acx.acr50_ssw14_7.condi);
      expect(consistency_acx.acr50_ssw14_7.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.typ;
      print(consistency_acx.acr50_ssw14_7.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.typ = testData1;
      print(consistency_acx.acr50_ssw14_7.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.typ = testData2;
      print(consistency_acx.acr50_ssw14_7.typ);
      expect(consistency_acx.acr50_ssw14_7.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.typ = defalut;
      print(consistency_acx.acr50_ssw14_7.typ);
      expect(consistency_acx.acr50_ssw14_7.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.ini_typ;
      print(consistency_acx.acr50_ssw14_7.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.ini_typ = testData1;
      print(consistency_acx.acr50_ssw14_7.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.ini_typ = testData2;
      print(consistency_acx.acr50_ssw14_7.ini_typ);
      expect(consistency_acx.acr50_ssw14_7.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.ini_typ = defalut;
      print(consistency_acx.acr50_ssw14_7.ini_typ);
      expect(consistency_acx.acr50_ssw14_7.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.file;
      print(consistency_acx.acr50_ssw14_7.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.file = testData1s;
      print(consistency_acx.acr50_ssw14_7.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.file = testData2s;
      print(consistency_acx.acr50_ssw14_7.file);
      expect(consistency_acx.acr50_ssw14_7.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.file = defalut;
      print(consistency_acx.acr50_ssw14_7.file);
      expect(consistency_acx.acr50_ssw14_7.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.section;
      print(consistency_acx.acr50_ssw14_7.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.section = testData1s;
      print(consistency_acx.acr50_ssw14_7.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.section = testData2s;
      print(consistency_acx.acr50_ssw14_7.section);
      expect(consistency_acx.acr50_ssw14_7.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.section = defalut;
      print(consistency_acx.acr50_ssw14_7.section);
      expect(consistency_acx.acr50_ssw14_7.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acr50_ssw14_7.keyword;
      print(consistency_acx.acr50_ssw14_7.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acr50_ssw14_7.keyword = testData1s;
      print(consistency_acx.acr50_ssw14_7.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acr50_ssw14_7.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acr50_ssw14_7.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acr50_ssw14_7.keyword = testData2s;
      print(consistency_acx.acr50_ssw14_7.keyword);
      expect(consistency_acx.acr50_ssw14_7.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acr50_ssw14_7.keyword = defalut;
      print(consistency_acx.acr50_ssw14_7.keyword);
      expect(consistency_acx.acr50_ssw14_7.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acr50_ssw14_7.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.title;
      print(consistency_acx.pick_end.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.title = testData1s;
      print(consistency_acx.pick_end.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.title = testData2s;
      print(consistency_acx.pick_end.title);
      expect(consistency_acx.pick_end.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.title = defalut;
      print(consistency_acx.pick_end.title);
      expect(consistency_acx.pick_end.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.obj;
      print(consistency_acx.pick_end.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.obj = testData1;
      print(consistency_acx.pick_end.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.obj = testData2;
      print(consistency_acx.pick_end.obj);
      expect(consistency_acx.pick_end.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.obj = defalut;
      print(consistency_acx.pick_end.obj);
      expect(consistency_acx.pick_end.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.condi;
      print(consistency_acx.pick_end.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.condi = testData1;
      print(consistency_acx.pick_end.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.condi = testData2;
      print(consistency_acx.pick_end.condi);
      expect(consistency_acx.pick_end.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.condi = defalut;
      print(consistency_acx.pick_end.condi);
      expect(consistency_acx.pick_end.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.typ;
      print(consistency_acx.pick_end.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.typ = testData1;
      print(consistency_acx.pick_end.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.typ = testData2;
      print(consistency_acx.pick_end.typ);
      expect(consistency_acx.pick_end.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.typ = defalut;
      print(consistency_acx.pick_end.typ);
      expect(consistency_acx.pick_end.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.ini_typ;
      print(consistency_acx.pick_end.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.ini_typ = testData1;
      print(consistency_acx.pick_end.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.ini_typ = testData2;
      print(consistency_acx.pick_end.ini_typ);
      expect(consistency_acx.pick_end.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.ini_typ = defalut;
      print(consistency_acx.pick_end.ini_typ);
      expect(consistency_acx.pick_end.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.file;
      print(consistency_acx.pick_end.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.file = testData1s;
      print(consistency_acx.pick_end.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.file = testData2s;
      print(consistency_acx.pick_end.file);
      expect(consistency_acx.pick_end.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.file = defalut;
      print(consistency_acx.pick_end.file);
      expect(consistency_acx.pick_end.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.section;
      print(consistency_acx.pick_end.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.section = testData1s;
      print(consistency_acx.pick_end.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.section = testData2s;
      print(consistency_acx.pick_end.section);
      expect(consistency_acx.pick_end.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.section = defalut;
      print(consistency_acx.pick_end.section);
      expect(consistency_acx.pick_end.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.pick_end.keyword;
      print(consistency_acx.pick_end.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.pick_end.keyword = testData1s;
      print(consistency_acx.pick_end.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.pick_end.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.pick_end.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.pick_end.keyword = testData2s;
      print(consistency_acx.pick_end.keyword);
      expect(consistency_acx.pick_end.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.pick_end.keyword = defalut;
      print(consistency_acx.pick_end.keyword);
      expect(consistency_acx.pick_end.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.pick_end.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.title;
      print(consistency_acx.acxreal_system.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.title = testData1s;
      print(consistency_acx.acxreal_system.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.title = testData2s;
      print(consistency_acx.acxreal_system.title);
      expect(consistency_acx.acxreal_system.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.title = defalut;
      print(consistency_acx.acxreal_system.title);
      expect(consistency_acx.acxreal_system.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.obj;
      print(consistency_acx.acxreal_system.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.obj = testData1;
      print(consistency_acx.acxreal_system.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.obj = testData2;
      print(consistency_acx.acxreal_system.obj);
      expect(consistency_acx.acxreal_system.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.obj = defalut;
      print(consistency_acx.acxreal_system.obj);
      expect(consistency_acx.acxreal_system.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.condi;
      print(consistency_acx.acxreal_system.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.condi = testData1;
      print(consistency_acx.acxreal_system.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.condi = testData2;
      print(consistency_acx.acxreal_system.condi);
      expect(consistency_acx.acxreal_system.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.condi = defalut;
      print(consistency_acx.acxreal_system.condi);
      expect(consistency_acx.acxreal_system.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.typ;
      print(consistency_acx.acxreal_system.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.typ = testData1;
      print(consistency_acx.acxreal_system.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.typ = testData2;
      print(consistency_acx.acxreal_system.typ);
      expect(consistency_acx.acxreal_system.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.typ = defalut;
      print(consistency_acx.acxreal_system.typ);
      expect(consistency_acx.acxreal_system.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.ini_typ;
      print(consistency_acx.acxreal_system.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.ini_typ = testData1;
      print(consistency_acx.acxreal_system.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.ini_typ = testData2;
      print(consistency_acx.acxreal_system.ini_typ);
      expect(consistency_acx.acxreal_system.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.ini_typ = defalut;
      print(consistency_acx.acxreal_system.ini_typ);
      expect(consistency_acx.acxreal_system.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.file;
      print(consistency_acx.acxreal_system.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.file = testData1s;
      print(consistency_acx.acxreal_system.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.file = testData2s;
      print(consistency_acx.acxreal_system.file);
      expect(consistency_acx.acxreal_system.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.file = defalut;
      print(consistency_acx.acxreal_system.file);
      expect(consistency_acx.acxreal_system.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.section;
      print(consistency_acx.acxreal_system.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.section = testData1s;
      print(consistency_acx.acxreal_system.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.section = testData2s;
      print(consistency_acx.acxreal_system.section);
      expect(consistency_acx.acxreal_system.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.section = defalut;
      print(consistency_acx.acxreal_system.section);
      expect(consistency_acx.acxreal_system.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_system.keyword;
      print(consistency_acx.acxreal_system.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_system.keyword = testData1s;
      print(consistency_acx.acxreal_system.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_system.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_system.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_system.keyword = testData2s;
      print(consistency_acx.acxreal_system.keyword);
      expect(consistency_acx.acxreal_system.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_system.keyword = defalut;
      print(consistency_acx.acxreal_system.keyword);
      expect(consistency_acx.acxreal_system.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_system.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.title;
      print(consistency_acx.acxreal_interval.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.title = testData1s;
      print(consistency_acx.acxreal_interval.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.title = testData2s;
      print(consistency_acx.acxreal_interval.title);
      expect(consistency_acx.acxreal_interval.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.title = defalut;
      print(consistency_acx.acxreal_interval.title);
      expect(consistency_acx.acxreal_interval.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.obj;
      print(consistency_acx.acxreal_interval.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.obj = testData1;
      print(consistency_acx.acxreal_interval.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.obj = testData2;
      print(consistency_acx.acxreal_interval.obj);
      expect(consistency_acx.acxreal_interval.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.obj = defalut;
      print(consistency_acx.acxreal_interval.obj);
      expect(consistency_acx.acxreal_interval.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.condi;
      print(consistency_acx.acxreal_interval.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.condi = testData1;
      print(consistency_acx.acxreal_interval.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.condi = testData2;
      print(consistency_acx.acxreal_interval.condi);
      expect(consistency_acx.acxreal_interval.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.condi = defalut;
      print(consistency_acx.acxreal_interval.condi);
      expect(consistency_acx.acxreal_interval.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.typ;
      print(consistency_acx.acxreal_interval.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.typ = testData1;
      print(consistency_acx.acxreal_interval.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.typ = testData2;
      print(consistency_acx.acxreal_interval.typ);
      expect(consistency_acx.acxreal_interval.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.typ = defalut;
      print(consistency_acx.acxreal_interval.typ);
      expect(consistency_acx.acxreal_interval.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.ini_typ;
      print(consistency_acx.acxreal_interval.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.ini_typ = testData1;
      print(consistency_acx.acxreal_interval.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.ini_typ = testData2;
      print(consistency_acx.acxreal_interval.ini_typ);
      expect(consistency_acx.acxreal_interval.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.ini_typ = defalut;
      print(consistency_acx.acxreal_interval.ini_typ);
      expect(consistency_acx.acxreal_interval.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.file;
      print(consistency_acx.acxreal_interval.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.file = testData1s;
      print(consistency_acx.acxreal_interval.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.file = testData2s;
      print(consistency_acx.acxreal_interval.file);
      expect(consistency_acx.acxreal_interval.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.file = defalut;
      print(consistency_acx.acxreal_interval.file);
      expect(consistency_acx.acxreal_interval.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.section;
      print(consistency_acx.acxreal_interval.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.section = testData1s;
      print(consistency_acx.acxreal_interval.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.section = testData2s;
      print(consistency_acx.acxreal_interval.section);
      expect(consistency_acx.acxreal_interval.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.section = defalut;
      print(consistency_acx.acxreal_interval.section);
      expect(consistency_acx.acxreal_interval.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acxreal_interval.keyword;
      print(consistency_acx.acxreal_interval.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acxreal_interval.keyword = testData1s;
      print(consistency_acx.acxreal_interval.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acxreal_interval.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acxreal_interval.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acxreal_interval.keyword = testData2s;
      print(consistency_acx.acxreal_interval.keyword);
      expect(consistency_acx.acxreal_interval.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acxreal_interval.keyword = defalut;
      print(consistency_acx.acxreal_interval.keyword);
      expect(consistency_acx.acxreal_interval.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acxreal_interval.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.title;
      print(consistency_acx.ecs_pick_positn10000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.title = testData1s;
      print(consistency_acx.ecs_pick_positn10000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.title = testData2s;
      print(consistency_acx.ecs_pick_positn10000.title);
      expect(consistency_acx.ecs_pick_positn10000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.title = defalut;
      print(consistency_acx.ecs_pick_positn10000.title);
      expect(consistency_acx.ecs_pick_positn10000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.obj;
      print(consistency_acx.ecs_pick_positn10000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.obj = testData1;
      print(consistency_acx.ecs_pick_positn10000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.obj = testData2;
      print(consistency_acx.ecs_pick_positn10000.obj);
      expect(consistency_acx.ecs_pick_positn10000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.obj = defalut;
      print(consistency_acx.ecs_pick_positn10000.obj);
      expect(consistency_acx.ecs_pick_positn10000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.condi;
      print(consistency_acx.ecs_pick_positn10000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.condi = testData1;
      print(consistency_acx.ecs_pick_positn10000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.condi = testData2;
      print(consistency_acx.ecs_pick_positn10000.condi);
      expect(consistency_acx.ecs_pick_positn10000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.condi = defalut;
      print(consistency_acx.ecs_pick_positn10000.condi);
      expect(consistency_acx.ecs_pick_positn10000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.typ;
      print(consistency_acx.ecs_pick_positn10000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.typ = testData1;
      print(consistency_acx.ecs_pick_positn10000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.typ = testData2;
      print(consistency_acx.ecs_pick_positn10000.typ);
      expect(consistency_acx.ecs_pick_positn10000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.typ = defalut;
      print(consistency_acx.ecs_pick_positn10000.typ);
      expect(consistency_acx.ecs_pick_positn10000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.ini_typ;
      print(consistency_acx.ecs_pick_positn10000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.ini_typ = testData1;
      print(consistency_acx.ecs_pick_positn10000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.ini_typ = testData2;
      print(consistency_acx.ecs_pick_positn10000.ini_typ);
      expect(consistency_acx.ecs_pick_positn10000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.ini_typ = defalut;
      print(consistency_acx.ecs_pick_positn10000.ini_typ);
      expect(consistency_acx.ecs_pick_positn10000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.file;
      print(consistency_acx.ecs_pick_positn10000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.file = testData1s;
      print(consistency_acx.ecs_pick_positn10000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.file = testData2s;
      print(consistency_acx.ecs_pick_positn10000.file);
      expect(consistency_acx.ecs_pick_positn10000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.file = defalut;
      print(consistency_acx.ecs_pick_positn10000.file);
      expect(consistency_acx.ecs_pick_positn10000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.section;
      print(consistency_acx.ecs_pick_positn10000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.section = testData1s;
      print(consistency_acx.ecs_pick_positn10000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.section = testData2s;
      print(consistency_acx.ecs_pick_positn10000.section);
      expect(consistency_acx.ecs_pick_positn10000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.section = defalut;
      print(consistency_acx.ecs_pick_positn10000.section);
      expect(consistency_acx.ecs_pick_positn10000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn10000.keyword;
      print(consistency_acx.ecs_pick_positn10000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn10000.keyword = testData1s;
      print(consistency_acx.ecs_pick_positn10000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn10000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn10000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn10000.keyword = testData2s;
      print(consistency_acx.ecs_pick_positn10000.keyword);
      expect(consistency_acx.ecs_pick_positn10000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn10000.keyword = defalut;
      print(consistency_acx.ecs_pick_positn10000.keyword);
      expect(consistency_acx.ecs_pick_positn10000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn10000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.title;
      print(consistency_acx.ecs_pick_positn5000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.title = testData1s;
      print(consistency_acx.ecs_pick_positn5000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.title = testData2s;
      print(consistency_acx.ecs_pick_positn5000.title);
      expect(consistency_acx.ecs_pick_positn5000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.title = defalut;
      print(consistency_acx.ecs_pick_positn5000.title);
      expect(consistency_acx.ecs_pick_positn5000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.obj;
      print(consistency_acx.ecs_pick_positn5000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.obj = testData1;
      print(consistency_acx.ecs_pick_positn5000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.obj = testData2;
      print(consistency_acx.ecs_pick_positn5000.obj);
      expect(consistency_acx.ecs_pick_positn5000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.obj = defalut;
      print(consistency_acx.ecs_pick_positn5000.obj);
      expect(consistency_acx.ecs_pick_positn5000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.condi;
      print(consistency_acx.ecs_pick_positn5000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.condi = testData1;
      print(consistency_acx.ecs_pick_positn5000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.condi = testData2;
      print(consistency_acx.ecs_pick_positn5000.condi);
      expect(consistency_acx.ecs_pick_positn5000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.condi = defalut;
      print(consistency_acx.ecs_pick_positn5000.condi);
      expect(consistency_acx.ecs_pick_positn5000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.typ;
      print(consistency_acx.ecs_pick_positn5000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.typ = testData1;
      print(consistency_acx.ecs_pick_positn5000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.typ = testData2;
      print(consistency_acx.ecs_pick_positn5000.typ);
      expect(consistency_acx.ecs_pick_positn5000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.typ = defalut;
      print(consistency_acx.ecs_pick_positn5000.typ);
      expect(consistency_acx.ecs_pick_positn5000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.ini_typ;
      print(consistency_acx.ecs_pick_positn5000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.ini_typ = testData1;
      print(consistency_acx.ecs_pick_positn5000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.ini_typ = testData2;
      print(consistency_acx.ecs_pick_positn5000.ini_typ);
      expect(consistency_acx.ecs_pick_positn5000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.ini_typ = defalut;
      print(consistency_acx.ecs_pick_positn5000.ini_typ);
      expect(consistency_acx.ecs_pick_positn5000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.file;
      print(consistency_acx.ecs_pick_positn5000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.file = testData1s;
      print(consistency_acx.ecs_pick_positn5000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.file = testData2s;
      print(consistency_acx.ecs_pick_positn5000.file);
      expect(consistency_acx.ecs_pick_positn5000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.file = defalut;
      print(consistency_acx.ecs_pick_positn5000.file);
      expect(consistency_acx.ecs_pick_positn5000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.section;
      print(consistency_acx.ecs_pick_positn5000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.section = testData1s;
      print(consistency_acx.ecs_pick_positn5000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.section = testData2s;
      print(consistency_acx.ecs_pick_positn5000.section);
      expect(consistency_acx.ecs_pick_positn5000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.section = defalut;
      print(consistency_acx.ecs_pick_positn5000.section);
      expect(consistency_acx.ecs_pick_positn5000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn5000.keyword;
      print(consistency_acx.ecs_pick_positn5000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn5000.keyword = testData1s;
      print(consistency_acx.ecs_pick_positn5000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn5000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn5000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn5000.keyword = testData2s;
      print(consistency_acx.ecs_pick_positn5000.keyword);
      expect(consistency_acx.ecs_pick_positn5000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn5000.keyword = defalut;
      print(consistency_acx.ecs_pick_positn5000.keyword);
      expect(consistency_acx.ecs_pick_positn5000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn5000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.title;
      print(consistency_acx.ecs_pick_positn2000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.title = testData1s;
      print(consistency_acx.ecs_pick_positn2000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.title = testData2s;
      print(consistency_acx.ecs_pick_positn2000.title);
      expect(consistency_acx.ecs_pick_positn2000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.title = defalut;
      print(consistency_acx.ecs_pick_positn2000.title);
      expect(consistency_acx.ecs_pick_positn2000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.obj;
      print(consistency_acx.ecs_pick_positn2000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.obj = testData1;
      print(consistency_acx.ecs_pick_positn2000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.obj = testData2;
      print(consistency_acx.ecs_pick_positn2000.obj);
      expect(consistency_acx.ecs_pick_positn2000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.obj = defalut;
      print(consistency_acx.ecs_pick_positn2000.obj);
      expect(consistency_acx.ecs_pick_positn2000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.condi;
      print(consistency_acx.ecs_pick_positn2000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.condi = testData1;
      print(consistency_acx.ecs_pick_positn2000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.condi = testData2;
      print(consistency_acx.ecs_pick_positn2000.condi);
      expect(consistency_acx.ecs_pick_positn2000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.condi = defalut;
      print(consistency_acx.ecs_pick_positn2000.condi);
      expect(consistency_acx.ecs_pick_positn2000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.typ;
      print(consistency_acx.ecs_pick_positn2000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.typ = testData1;
      print(consistency_acx.ecs_pick_positn2000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.typ = testData2;
      print(consistency_acx.ecs_pick_positn2000.typ);
      expect(consistency_acx.ecs_pick_positn2000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.typ = defalut;
      print(consistency_acx.ecs_pick_positn2000.typ);
      expect(consistency_acx.ecs_pick_positn2000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.ini_typ;
      print(consistency_acx.ecs_pick_positn2000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.ini_typ = testData1;
      print(consistency_acx.ecs_pick_positn2000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.ini_typ = testData2;
      print(consistency_acx.ecs_pick_positn2000.ini_typ);
      expect(consistency_acx.ecs_pick_positn2000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.ini_typ = defalut;
      print(consistency_acx.ecs_pick_positn2000.ini_typ);
      expect(consistency_acx.ecs_pick_positn2000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.file;
      print(consistency_acx.ecs_pick_positn2000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.file = testData1s;
      print(consistency_acx.ecs_pick_positn2000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.file = testData2s;
      print(consistency_acx.ecs_pick_positn2000.file);
      expect(consistency_acx.ecs_pick_positn2000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.file = defalut;
      print(consistency_acx.ecs_pick_positn2000.file);
      expect(consistency_acx.ecs_pick_positn2000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.section;
      print(consistency_acx.ecs_pick_positn2000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.section = testData1s;
      print(consistency_acx.ecs_pick_positn2000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.section = testData2s;
      print(consistency_acx.ecs_pick_positn2000.section);
      expect(consistency_acx.ecs_pick_positn2000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.section = defalut;
      print(consistency_acx.ecs_pick_positn2000.section);
      expect(consistency_acx.ecs_pick_positn2000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn2000.keyword;
      print(consistency_acx.ecs_pick_positn2000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn2000.keyword = testData1s;
      print(consistency_acx.ecs_pick_positn2000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn2000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn2000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn2000.keyword = testData2s;
      print(consistency_acx.ecs_pick_positn2000.keyword);
      expect(consistency_acx.ecs_pick_positn2000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn2000.keyword = defalut;
      print(consistency_acx.ecs_pick_positn2000.keyword);
      expect(consistency_acx.ecs_pick_positn2000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn2000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.title;
      print(consistency_acx.ecs_pick_positn1000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.title = testData1s;
      print(consistency_acx.ecs_pick_positn1000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.title = testData2s;
      print(consistency_acx.ecs_pick_positn1000.title);
      expect(consistency_acx.ecs_pick_positn1000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.title = defalut;
      print(consistency_acx.ecs_pick_positn1000.title);
      expect(consistency_acx.ecs_pick_positn1000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.obj;
      print(consistency_acx.ecs_pick_positn1000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.obj = testData1;
      print(consistency_acx.ecs_pick_positn1000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.obj = testData2;
      print(consistency_acx.ecs_pick_positn1000.obj);
      expect(consistency_acx.ecs_pick_positn1000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.obj = defalut;
      print(consistency_acx.ecs_pick_positn1000.obj);
      expect(consistency_acx.ecs_pick_positn1000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.condi;
      print(consistency_acx.ecs_pick_positn1000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.condi = testData1;
      print(consistency_acx.ecs_pick_positn1000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.condi = testData2;
      print(consistency_acx.ecs_pick_positn1000.condi);
      expect(consistency_acx.ecs_pick_positn1000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.condi = defalut;
      print(consistency_acx.ecs_pick_positn1000.condi);
      expect(consistency_acx.ecs_pick_positn1000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.typ;
      print(consistency_acx.ecs_pick_positn1000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.typ = testData1;
      print(consistency_acx.ecs_pick_positn1000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.typ = testData2;
      print(consistency_acx.ecs_pick_positn1000.typ);
      expect(consistency_acx.ecs_pick_positn1000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.typ = defalut;
      print(consistency_acx.ecs_pick_positn1000.typ);
      expect(consistency_acx.ecs_pick_positn1000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.ini_typ;
      print(consistency_acx.ecs_pick_positn1000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.ini_typ = testData1;
      print(consistency_acx.ecs_pick_positn1000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.ini_typ = testData2;
      print(consistency_acx.ecs_pick_positn1000.ini_typ);
      expect(consistency_acx.ecs_pick_positn1000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.ini_typ = defalut;
      print(consistency_acx.ecs_pick_positn1000.ini_typ);
      expect(consistency_acx.ecs_pick_positn1000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.file;
      print(consistency_acx.ecs_pick_positn1000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.file = testData1s;
      print(consistency_acx.ecs_pick_positn1000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.file = testData2s;
      print(consistency_acx.ecs_pick_positn1000.file);
      expect(consistency_acx.ecs_pick_positn1000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.file = defalut;
      print(consistency_acx.ecs_pick_positn1000.file);
      expect(consistency_acx.ecs_pick_positn1000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.section;
      print(consistency_acx.ecs_pick_positn1000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.section = testData1s;
      print(consistency_acx.ecs_pick_positn1000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.section = testData2s;
      print(consistency_acx.ecs_pick_positn1000.section);
      expect(consistency_acx.ecs_pick_positn1000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.section = defalut;
      print(consistency_acx.ecs_pick_positn1000.section);
      expect(consistency_acx.ecs_pick_positn1000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_pick_positn1000.keyword;
      print(consistency_acx.ecs_pick_positn1000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_pick_positn1000.keyword = testData1s;
      print(consistency_acx.ecs_pick_positn1000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_pick_positn1000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_pick_positn1000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_pick_positn1000.keyword = testData2s;
      print(consistency_acx.ecs_pick_positn1000.keyword);
      expect(consistency_acx.ecs_pick_positn1000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_pick_positn1000.keyword = defalut;
      print(consistency_acx.ecs_pick_positn1000.keyword);
      expect(consistency_acx.ecs_pick_positn1000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_pick_positn1000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.title;
      print(consistency_acx.acx_pick_data10000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.title = testData1s;
      print(consistency_acx.acx_pick_data10000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.title = testData2s;
      print(consistency_acx.acx_pick_data10000.title);
      expect(consistency_acx.acx_pick_data10000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.title = defalut;
      print(consistency_acx.acx_pick_data10000.title);
      expect(consistency_acx.acx_pick_data10000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.obj;
      print(consistency_acx.acx_pick_data10000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.obj = testData1;
      print(consistency_acx.acx_pick_data10000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.obj = testData2;
      print(consistency_acx.acx_pick_data10000.obj);
      expect(consistency_acx.acx_pick_data10000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.obj = defalut;
      print(consistency_acx.acx_pick_data10000.obj);
      expect(consistency_acx.acx_pick_data10000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.condi;
      print(consistency_acx.acx_pick_data10000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.condi = testData1;
      print(consistency_acx.acx_pick_data10000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.condi = testData2;
      print(consistency_acx.acx_pick_data10000.condi);
      expect(consistency_acx.acx_pick_data10000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.condi = defalut;
      print(consistency_acx.acx_pick_data10000.condi);
      expect(consistency_acx.acx_pick_data10000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.typ;
      print(consistency_acx.acx_pick_data10000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.typ = testData1;
      print(consistency_acx.acx_pick_data10000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.typ = testData2;
      print(consistency_acx.acx_pick_data10000.typ);
      expect(consistency_acx.acx_pick_data10000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.typ = defalut;
      print(consistency_acx.acx_pick_data10000.typ);
      expect(consistency_acx.acx_pick_data10000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.ini_typ;
      print(consistency_acx.acx_pick_data10000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.ini_typ = testData1;
      print(consistency_acx.acx_pick_data10000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.ini_typ = testData2;
      print(consistency_acx.acx_pick_data10000.ini_typ);
      expect(consistency_acx.acx_pick_data10000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.ini_typ = defalut;
      print(consistency_acx.acx_pick_data10000.ini_typ);
      expect(consistency_acx.acx_pick_data10000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.file;
      print(consistency_acx.acx_pick_data10000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.file = testData1s;
      print(consistency_acx.acx_pick_data10000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.file = testData2s;
      print(consistency_acx.acx_pick_data10000.file);
      expect(consistency_acx.acx_pick_data10000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.file = defalut;
      print(consistency_acx.acx_pick_data10000.file);
      expect(consistency_acx.acx_pick_data10000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.section;
      print(consistency_acx.acx_pick_data10000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.section = testData1s;
      print(consistency_acx.acx_pick_data10000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.section = testData2s;
      print(consistency_acx.acx_pick_data10000.section);
      expect(consistency_acx.acx_pick_data10000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.section = defalut;
      print(consistency_acx.acx_pick_data10000.section);
      expect(consistency_acx.acx_pick_data10000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10000.keyword;
      print(consistency_acx.acx_pick_data10000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10000.keyword = testData1s;
      print(consistency_acx.acx_pick_data10000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10000.keyword = testData2s;
      print(consistency_acx.acx_pick_data10000.keyword);
      expect(consistency_acx.acx_pick_data10000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10000.keyword = defalut;
      print(consistency_acx.acx_pick_data10000.keyword);
      expect(consistency_acx.acx_pick_data10000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.title;
      print(consistency_acx.acx_pick_data5000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.title = testData1s;
      print(consistency_acx.acx_pick_data5000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.title = testData2s;
      print(consistency_acx.acx_pick_data5000.title);
      expect(consistency_acx.acx_pick_data5000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.title = defalut;
      print(consistency_acx.acx_pick_data5000.title);
      expect(consistency_acx.acx_pick_data5000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.obj;
      print(consistency_acx.acx_pick_data5000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.obj = testData1;
      print(consistency_acx.acx_pick_data5000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.obj = testData2;
      print(consistency_acx.acx_pick_data5000.obj);
      expect(consistency_acx.acx_pick_data5000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.obj = defalut;
      print(consistency_acx.acx_pick_data5000.obj);
      expect(consistency_acx.acx_pick_data5000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.condi;
      print(consistency_acx.acx_pick_data5000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.condi = testData1;
      print(consistency_acx.acx_pick_data5000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.condi = testData2;
      print(consistency_acx.acx_pick_data5000.condi);
      expect(consistency_acx.acx_pick_data5000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.condi = defalut;
      print(consistency_acx.acx_pick_data5000.condi);
      expect(consistency_acx.acx_pick_data5000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.typ;
      print(consistency_acx.acx_pick_data5000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.typ = testData1;
      print(consistency_acx.acx_pick_data5000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.typ = testData2;
      print(consistency_acx.acx_pick_data5000.typ);
      expect(consistency_acx.acx_pick_data5000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.typ = defalut;
      print(consistency_acx.acx_pick_data5000.typ);
      expect(consistency_acx.acx_pick_data5000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.ini_typ;
      print(consistency_acx.acx_pick_data5000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.ini_typ = testData1;
      print(consistency_acx.acx_pick_data5000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.ini_typ = testData2;
      print(consistency_acx.acx_pick_data5000.ini_typ);
      expect(consistency_acx.acx_pick_data5000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.ini_typ = defalut;
      print(consistency_acx.acx_pick_data5000.ini_typ);
      expect(consistency_acx.acx_pick_data5000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.file;
      print(consistency_acx.acx_pick_data5000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.file = testData1s;
      print(consistency_acx.acx_pick_data5000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.file = testData2s;
      print(consistency_acx.acx_pick_data5000.file);
      expect(consistency_acx.acx_pick_data5000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.file = defalut;
      print(consistency_acx.acx_pick_data5000.file);
      expect(consistency_acx.acx_pick_data5000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.section;
      print(consistency_acx.acx_pick_data5000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.section = testData1s;
      print(consistency_acx.acx_pick_data5000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.section = testData2s;
      print(consistency_acx.acx_pick_data5000.section);
      expect(consistency_acx.acx_pick_data5000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.section = defalut;
      print(consistency_acx.acx_pick_data5000.section);
      expect(consistency_acx.acx_pick_data5000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5000.keyword;
      print(consistency_acx.acx_pick_data5000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5000.keyword = testData1s;
      print(consistency_acx.acx_pick_data5000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5000.keyword = testData2s;
      print(consistency_acx.acx_pick_data5000.keyword);
      expect(consistency_acx.acx_pick_data5000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5000.keyword = defalut;
      print(consistency_acx.acx_pick_data5000.keyword);
      expect(consistency_acx.acx_pick_data5000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.title;
      print(consistency_acx.acx_pick_data2000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.title = testData1s;
      print(consistency_acx.acx_pick_data2000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.title = testData2s;
      print(consistency_acx.acx_pick_data2000.title);
      expect(consistency_acx.acx_pick_data2000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.title = defalut;
      print(consistency_acx.acx_pick_data2000.title);
      expect(consistency_acx.acx_pick_data2000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.obj;
      print(consistency_acx.acx_pick_data2000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.obj = testData1;
      print(consistency_acx.acx_pick_data2000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.obj = testData2;
      print(consistency_acx.acx_pick_data2000.obj);
      expect(consistency_acx.acx_pick_data2000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.obj = defalut;
      print(consistency_acx.acx_pick_data2000.obj);
      expect(consistency_acx.acx_pick_data2000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.condi;
      print(consistency_acx.acx_pick_data2000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.condi = testData1;
      print(consistency_acx.acx_pick_data2000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.condi = testData2;
      print(consistency_acx.acx_pick_data2000.condi);
      expect(consistency_acx.acx_pick_data2000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.condi = defalut;
      print(consistency_acx.acx_pick_data2000.condi);
      expect(consistency_acx.acx_pick_data2000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.typ;
      print(consistency_acx.acx_pick_data2000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.typ = testData1;
      print(consistency_acx.acx_pick_data2000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.typ = testData2;
      print(consistency_acx.acx_pick_data2000.typ);
      expect(consistency_acx.acx_pick_data2000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.typ = defalut;
      print(consistency_acx.acx_pick_data2000.typ);
      expect(consistency_acx.acx_pick_data2000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.ini_typ;
      print(consistency_acx.acx_pick_data2000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.ini_typ = testData1;
      print(consistency_acx.acx_pick_data2000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.ini_typ = testData2;
      print(consistency_acx.acx_pick_data2000.ini_typ);
      expect(consistency_acx.acx_pick_data2000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.ini_typ = defalut;
      print(consistency_acx.acx_pick_data2000.ini_typ);
      expect(consistency_acx.acx_pick_data2000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.file;
      print(consistency_acx.acx_pick_data2000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.file = testData1s;
      print(consistency_acx.acx_pick_data2000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.file = testData2s;
      print(consistency_acx.acx_pick_data2000.file);
      expect(consistency_acx.acx_pick_data2000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.file = defalut;
      print(consistency_acx.acx_pick_data2000.file);
      expect(consistency_acx.acx_pick_data2000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.section;
      print(consistency_acx.acx_pick_data2000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.section = testData1s;
      print(consistency_acx.acx_pick_data2000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.section = testData2s;
      print(consistency_acx.acx_pick_data2000.section);
      expect(consistency_acx.acx_pick_data2000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.section = defalut;
      print(consistency_acx.acx_pick_data2000.section);
      expect(consistency_acx.acx_pick_data2000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data2000.keyword;
      print(consistency_acx.acx_pick_data2000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data2000.keyword = testData1s;
      print(consistency_acx.acx_pick_data2000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data2000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data2000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data2000.keyword = testData2s;
      print(consistency_acx.acx_pick_data2000.keyword);
      expect(consistency_acx.acx_pick_data2000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data2000.keyword = defalut;
      print(consistency_acx.acx_pick_data2000.keyword);
      expect(consistency_acx.acx_pick_data2000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data2000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.title;
      print(consistency_acx.acx_pick_data1000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.title = testData1s;
      print(consistency_acx.acx_pick_data1000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.title = testData2s;
      print(consistency_acx.acx_pick_data1000.title);
      expect(consistency_acx.acx_pick_data1000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.title = defalut;
      print(consistency_acx.acx_pick_data1000.title);
      expect(consistency_acx.acx_pick_data1000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.obj;
      print(consistency_acx.acx_pick_data1000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.obj = testData1;
      print(consistency_acx.acx_pick_data1000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.obj = testData2;
      print(consistency_acx.acx_pick_data1000.obj);
      expect(consistency_acx.acx_pick_data1000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.obj = defalut;
      print(consistency_acx.acx_pick_data1000.obj);
      expect(consistency_acx.acx_pick_data1000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.condi;
      print(consistency_acx.acx_pick_data1000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.condi = testData1;
      print(consistency_acx.acx_pick_data1000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.condi = testData2;
      print(consistency_acx.acx_pick_data1000.condi);
      expect(consistency_acx.acx_pick_data1000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.condi = defalut;
      print(consistency_acx.acx_pick_data1000.condi);
      expect(consistency_acx.acx_pick_data1000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.typ;
      print(consistency_acx.acx_pick_data1000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.typ = testData1;
      print(consistency_acx.acx_pick_data1000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.typ = testData2;
      print(consistency_acx.acx_pick_data1000.typ);
      expect(consistency_acx.acx_pick_data1000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.typ = defalut;
      print(consistency_acx.acx_pick_data1000.typ);
      expect(consistency_acx.acx_pick_data1000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.ini_typ;
      print(consistency_acx.acx_pick_data1000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.ini_typ = testData1;
      print(consistency_acx.acx_pick_data1000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.ini_typ = testData2;
      print(consistency_acx.acx_pick_data1000.ini_typ);
      expect(consistency_acx.acx_pick_data1000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.ini_typ = defalut;
      print(consistency_acx.acx_pick_data1000.ini_typ);
      expect(consistency_acx.acx_pick_data1000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.file;
      print(consistency_acx.acx_pick_data1000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.file = testData1s;
      print(consistency_acx.acx_pick_data1000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.file = testData2s;
      print(consistency_acx.acx_pick_data1000.file);
      expect(consistency_acx.acx_pick_data1000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.file = defalut;
      print(consistency_acx.acx_pick_data1000.file);
      expect(consistency_acx.acx_pick_data1000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.section;
      print(consistency_acx.acx_pick_data1000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.section = testData1s;
      print(consistency_acx.acx_pick_data1000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.section = testData2s;
      print(consistency_acx.acx_pick_data1000.section);
      expect(consistency_acx.acx_pick_data1000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.section = defalut;
      print(consistency_acx.acx_pick_data1000.section);
      expect(consistency_acx.acx_pick_data1000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1000.keyword;
      print(consistency_acx.acx_pick_data1000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1000.keyword = testData1s;
      print(consistency_acx.acx_pick_data1000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1000.keyword = testData2s;
      print(consistency_acx.acx_pick_data1000.keyword);
      expect(consistency_acx.acx_pick_data1000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1000.keyword = defalut;
      print(consistency_acx.acx_pick_data1000.keyword);
      expect(consistency_acx.acx_pick_data1000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.title;
      print(consistency_acx.acx_pick_data500.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.title = testData1s;
      print(consistency_acx.acx_pick_data500.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.title = testData2s;
      print(consistency_acx.acx_pick_data500.title);
      expect(consistency_acx.acx_pick_data500.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.title = defalut;
      print(consistency_acx.acx_pick_data500.title);
      expect(consistency_acx.acx_pick_data500.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.obj;
      print(consistency_acx.acx_pick_data500.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.obj = testData1;
      print(consistency_acx.acx_pick_data500.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.obj = testData2;
      print(consistency_acx.acx_pick_data500.obj);
      expect(consistency_acx.acx_pick_data500.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.obj = defalut;
      print(consistency_acx.acx_pick_data500.obj);
      expect(consistency_acx.acx_pick_data500.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.condi;
      print(consistency_acx.acx_pick_data500.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.condi = testData1;
      print(consistency_acx.acx_pick_data500.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.condi = testData2;
      print(consistency_acx.acx_pick_data500.condi);
      expect(consistency_acx.acx_pick_data500.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.condi = defalut;
      print(consistency_acx.acx_pick_data500.condi);
      expect(consistency_acx.acx_pick_data500.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.typ;
      print(consistency_acx.acx_pick_data500.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.typ = testData1;
      print(consistency_acx.acx_pick_data500.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.typ = testData2;
      print(consistency_acx.acx_pick_data500.typ);
      expect(consistency_acx.acx_pick_data500.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.typ = defalut;
      print(consistency_acx.acx_pick_data500.typ);
      expect(consistency_acx.acx_pick_data500.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.ini_typ;
      print(consistency_acx.acx_pick_data500.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.ini_typ = testData1;
      print(consistency_acx.acx_pick_data500.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.ini_typ = testData2;
      print(consistency_acx.acx_pick_data500.ini_typ);
      expect(consistency_acx.acx_pick_data500.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.ini_typ = defalut;
      print(consistency_acx.acx_pick_data500.ini_typ);
      expect(consistency_acx.acx_pick_data500.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.file;
      print(consistency_acx.acx_pick_data500.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.file = testData1s;
      print(consistency_acx.acx_pick_data500.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.file = testData2s;
      print(consistency_acx.acx_pick_data500.file);
      expect(consistency_acx.acx_pick_data500.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.file = defalut;
      print(consistency_acx.acx_pick_data500.file);
      expect(consistency_acx.acx_pick_data500.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.section;
      print(consistency_acx.acx_pick_data500.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.section = testData1s;
      print(consistency_acx.acx_pick_data500.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.section = testData2s;
      print(consistency_acx.acx_pick_data500.section);
      expect(consistency_acx.acx_pick_data500.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.section = defalut;
      print(consistency_acx.acx_pick_data500.section);
      expect(consistency_acx.acx_pick_data500.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data500.keyword;
      print(consistency_acx.acx_pick_data500.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data500.keyword = testData1s;
      print(consistency_acx.acx_pick_data500.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data500.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data500.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data500.keyword = testData2s;
      print(consistency_acx.acx_pick_data500.keyword);
      expect(consistency_acx.acx_pick_data500.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data500.keyword = defalut;
      print(consistency_acx.acx_pick_data500.keyword);
      expect(consistency_acx.acx_pick_data500.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data500.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.title;
      print(consistency_acx.acx_pick_data100.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.title = testData1s;
      print(consistency_acx.acx_pick_data100.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.title = testData2s;
      print(consistency_acx.acx_pick_data100.title);
      expect(consistency_acx.acx_pick_data100.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.title = defalut;
      print(consistency_acx.acx_pick_data100.title);
      expect(consistency_acx.acx_pick_data100.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.obj;
      print(consistency_acx.acx_pick_data100.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.obj = testData1;
      print(consistency_acx.acx_pick_data100.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.obj = testData2;
      print(consistency_acx.acx_pick_data100.obj);
      expect(consistency_acx.acx_pick_data100.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.obj = defalut;
      print(consistency_acx.acx_pick_data100.obj);
      expect(consistency_acx.acx_pick_data100.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.condi;
      print(consistency_acx.acx_pick_data100.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.condi = testData1;
      print(consistency_acx.acx_pick_data100.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.condi = testData2;
      print(consistency_acx.acx_pick_data100.condi);
      expect(consistency_acx.acx_pick_data100.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.condi = defalut;
      print(consistency_acx.acx_pick_data100.condi);
      expect(consistency_acx.acx_pick_data100.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.typ;
      print(consistency_acx.acx_pick_data100.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.typ = testData1;
      print(consistency_acx.acx_pick_data100.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.typ = testData2;
      print(consistency_acx.acx_pick_data100.typ);
      expect(consistency_acx.acx_pick_data100.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.typ = defalut;
      print(consistency_acx.acx_pick_data100.typ);
      expect(consistency_acx.acx_pick_data100.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.ini_typ;
      print(consistency_acx.acx_pick_data100.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.ini_typ = testData1;
      print(consistency_acx.acx_pick_data100.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.ini_typ = testData2;
      print(consistency_acx.acx_pick_data100.ini_typ);
      expect(consistency_acx.acx_pick_data100.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.ini_typ = defalut;
      print(consistency_acx.acx_pick_data100.ini_typ);
      expect(consistency_acx.acx_pick_data100.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.file;
      print(consistency_acx.acx_pick_data100.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.file = testData1s;
      print(consistency_acx.acx_pick_data100.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.file = testData2s;
      print(consistency_acx.acx_pick_data100.file);
      expect(consistency_acx.acx_pick_data100.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.file = defalut;
      print(consistency_acx.acx_pick_data100.file);
      expect(consistency_acx.acx_pick_data100.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.section;
      print(consistency_acx.acx_pick_data100.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.section = testData1s;
      print(consistency_acx.acx_pick_data100.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.section = testData2s;
      print(consistency_acx.acx_pick_data100.section);
      expect(consistency_acx.acx_pick_data100.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.section = defalut;
      print(consistency_acx.acx_pick_data100.section);
      expect(consistency_acx.acx_pick_data100.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data100.keyword;
      print(consistency_acx.acx_pick_data100.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data100.keyword = testData1s;
      print(consistency_acx.acx_pick_data100.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data100.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data100.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data100.keyword = testData2s;
      print(consistency_acx.acx_pick_data100.keyword);
      expect(consistency_acx.acx_pick_data100.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data100.keyword = defalut;
      print(consistency_acx.acx_pick_data100.keyword);
      expect(consistency_acx.acx_pick_data100.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data100.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.title;
      print(consistency_acx.acx_pick_data50.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.title = testData1s;
      print(consistency_acx.acx_pick_data50.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.title = testData2s;
      print(consistency_acx.acx_pick_data50.title);
      expect(consistency_acx.acx_pick_data50.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.title = defalut;
      print(consistency_acx.acx_pick_data50.title);
      expect(consistency_acx.acx_pick_data50.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.obj;
      print(consistency_acx.acx_pick_data50.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.obj = testData1;
      print(consistency_acx.acx_pick_data50.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.obj = testData2;
      print(consistency_acx.acx_pick_data50.obj);
      expect(consistency_acx.acx_pick_data50.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.obj = defalut;
      print(consistency_acx.acx_pick_data50.obj);
      expect(consistency_acx.acx_pick_data50.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.condi;
      print(consistency_acx.acx_pick_data50.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.condi = testData1;
      print(consistency_acx.acx_pick_data50.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.condi = testData2;
      print(consistency_acx.acx_pick_data50.condi);
      expect(consistency_acx.acx_pick_data50.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.condi = defalut;
      print(consistency_acx.acx_pick_data50.condi);
      expect(consistency_acx.acx_pick_data50.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.typ;
      print(consistency_acx.acx_pick_data50.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.typ = testData1;
      print(consistency_acx.acx_pick_data50.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.typ = testData2;
      print(consistency_acx.acx_pick_data50.typ);
      expect(consistency_acx.acx_pick_data50.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.typ = defalut;
      print(consistency_acx.acx_pick_data50.typ);
      expect(consistency_acx.acx_pick_data50.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.ini_typ;
      print(consistency_acx.acx_pick_data50.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.ini_typ = testData1;
      print(consistency_acx.acx_pick_data50.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.ini_typ = testData2;
      print(consistency_acx.acx_pick_data50.ini_typ);
      expect(consistency_acx.acx_pick_data50.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.ini_typ = defalut;
      print(consistency_acx.acx_pick_data50.ini_typ);
      expect(consistency_acx.acx_pick_data50.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.file;
      print(consistency_acx.acx_pick_data50.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.file = testData1s;
      print(consistency_acx.acx_pick_data50.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.file = testData2s;
      print(consistency_acx.acx_pick_data50.file);
      expect(consistency_acx.acx_pick_data50.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.file = defalut;
      print(consistency_acx.acx_pick_data50.file);
      expect(consistency_acx.acx_pick_data50.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.section;
      print(consistency_acx.acx_pick_data50.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.section = testData1s;
      print(consistency_acx.acx_pick_data50.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.section = testData2s;
      print(consistency_acx.acx_pick_data50.section);
      expect(consistency_acx.acx_pick_data50.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.section = defalut;
      print(consistency_acx.acx_pick_data50.section);
      expect(consistency_acx.acx_pick_data50.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data50.keyword;
      print(consistency_acx.acx_pick_data50.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data50.keyword = testData1s;
      print(consistency_acx.acx_pick_data50.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data50.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data50.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data50.keyword = testData2s;
      print(consistency_acx.acx_pick_data50.keyword);
      expect(consistency_acx.acx_pick_data50.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data50.keyword = defalut;
      print(consistency_acx.acx_pick_data50.keyword);
      expect(consistency_acx.acx_pick_data50.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data50.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.title;
      print(consistency_acx.acx_pick_data10.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.title = testData1s;
      print(consistency_acx.acx_pick_data10.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.title = testData2s;
      print(consistency_acx.acx_pick_data10.title);
      expect(consistency_acx.acx_pick_data10.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.title = defalut;
      print(consistency_acx.acx_pick_data10.title);
      expect(consistency_acx.acx_pick_data10.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.obj;
      print(consistency_acx.acx_pick_data10.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.obj = testData1;
      print(consistency_acx.acx_pick_data10.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.obj = testData2;
      print(consistency_acx.acx_pick_data10.obj);
      expect(consistency_acx.acx_pick_data10.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.obj = defalut;
      print(consistency_acx.acx_pick_data10.obj);
      expect(consistency_acx.acx_pick_data10.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.condi;
      print(consistency_acx.acx_pick_data10.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.condi = testData1;
      print(consistency_acx.acx_pick_data10.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.condi = testData2;
      print(consistency_acx.acx_pick_data10.condi);
      expect(consistency_acx.acx_pick_data10.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.condi = defalut;
      print(consistency_acx.acx_pick_data10.condi);
      expect(consistency_acx.acx_pick_data10.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.typ;
      print(consistency_acx.acx_pick_data10.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.typ = testData1;
      print(consistency_acx.acx_pick_data10.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.typ = testData2;
      print(consistency_acx.acx_pick_data10.typ);
      expect(consistency_acx.acx_pick_data10.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.typ = defalut;
      print(consistency_acx.acx_pick_data10.typ);
      expect(consistency_acx.acx_pick_data10.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.ini_typ;
      print(consistency_acx.acx_pick_data10.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.ini_typ = testData1;
      print(consistency_acx.acx_pick_data10.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.ini_typ = testData2;
      print(consistency_acx.acx_pick_data10.ini_typ);
      expect(consistency_acx.acx_pick_data10.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.ini_typ = defalut;
      print(consistency_acx.acx_pick_data10.ini_typ);
      expect(consistency_acx.acx_pick_data10.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.file;
      print(consistency_acx.acx_pick_data10.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.file = testData1s;
      print(consistency_acx.acx_pick_data10.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.file = testData2s;
      print(consistency_acx.acx_pick_data10.file);
      expect(consistency_acx.acx_pick_data10.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.file = defalut;
      print(consistency_acx.acx_pick_data10.file);
      expect(consistency_acx.acx_pick_data10.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.section;
      print(consistency_acx.acx_pick_data10.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.section = testData1s;
      print(consistency_acx.acx_pick_data10.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.section = testData2s;
      print(consistency_acx.acx_pick_data10.section);
      expect(consistency_acx.acx_pick_data10.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.section = defalut;
      print(consistency_acx.acx_pick_data10.section);
      expect(consistency_acx.acx_pick_data10.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data10.keyword;
      print(consistency_acx.acx_pick_data10.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data10.keyword = testData1s;
      print(consistency_acx.acx_pick_data10.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data10.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data10.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data10.keyword = testData2s;
      print(consistency_acx.acx_pick_data10.keyword);
      expect(consistency_acx.acx_pick_data10.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data10.keyword = defalut;
      print(consistency_acx.acx_pick_data10.keyword);
      expect(consistency_acx.acx_pick_data10.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data10.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.title;
      print(consistency_acx.acx_pick_data5.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.title = testData1s;
      print(consistency_acx.acx_pick_data5.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.title = testData2s;
      print(consistency_acx.acx_pick_data5.title);
      expect(consistency_acx.acx_pick_data5.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.title = defalut;
      print(consistency_acx.acx_pick_data5.title);
      expect(consistency_acx.acx_pick_data5.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.obj;
      print(consistency_acx.acx_pick_data5.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.obj = testData1;
      print(consistency_acx.acx_pick_data5.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.obj = testData2;
      print(consistency_acx.acx_pick_data5.obj);
      expect(consistency_acx.acx_pick_data5.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.obj = defalut;
      print(consistency_acx.acx_pick_data5.obj);
      expect(consistency_acx.acx_pick_data5.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.condi;
      print(consistency_acx.acx_pick_data5.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.condi = testData1;
      print(consistency_acx.acx_pick_data5.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.condi = testData2;
      print(consistency_acx.acx_pick_data5.condi);
      expect(consistency_acx.acx_pick_data5.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.condi = defalut;
      print(consistency_acx.acx_pick_data5.condi);
      expect(consistency_acx.acx_pick_data5.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.typ;
      print(consistency_acx.acx_pick_data5.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.typ = testData1;
      print(consistency_acx.acx_pick_data5.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.typ = testData2;
      print(consistency_acx.acx_pick_data5.typ);
      expect(consistency_acx.acx_pick_data5.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.typ = defalut;
      print(consistency_acx.acx_pick_data5.typ);
      expect(consistency_acx.acx_pick_data5.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.ini_typ;
      print(consistency_acx.acx_pick_data5.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.ini_typ = testData1;
      print(consistency_acx.acx_pick_data5.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.ini_typ = testData2;
      print(consistency_acx.acx_pick_data5.ini_typ);
      expect(consistency_acx.acx_pick_data5.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.ini_typ = defalut;
      print(consistency_acx.acx_pick_data5.ini_typ);
      expect(consistency_acx.acx_pick_data5.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.file;
      print(consistency_acx.acx_pick_data5.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.file = testData1s;
      print(consistency_acx.acx_pick_data5.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.file = testData2s;
      print(consistency_acx.acx_pick_data5.file);
      expect(consistency_acx.acx_pick_data5.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.file = defalut;
      print(consistency_acx.acx_pick_data5.file);
      expect(consistency_acx.acx_pick_data5.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.section;
      print(consistency_acx.acx_pick_data5.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.section = testData1s;
      print(consistency_acx.acx_pick_data5.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.section = testData2s;
      print(consistency_acx.acx_pick_data5.section);
      expect(consistency_acx.acx_pick_data5.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.section = defalut;
      print(consistency_acx.acx_pick_data5.section);
      expect(consistency_acx.acx_pick_data5.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data5.keyword;
      print(consistency_acx.acx_pick_data5.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data5.keyword = testData1s;
      print(consistency_acx.acx_pick_data5.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data5.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data5.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data5.keyword = testData2s;
      print(consistency_acx.acx_pick_data5.keyword);
      expect(consistency_acx.acx_pick_data5.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data5.keyword = defalut;
      print(consistency_acx.acx_pick_data5.keyword);
      expect(consistency_acx.acx_pick_data5.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data5.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.title;
      print(consistency_acx.acx_pick_data1.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.title = testData1s;
      print(consistency_acx.acx_pick_data1.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.title = testData2s;
      print(consistency_acx.acx_pick_data1.title);
      expect(consistency_acx.acx_pick_data1.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.title = defalut;
      print(consistency_acx.acx_pick_data1.title);
      expect(consistency_acx.acx_pick_data1.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.obj;
      print(consistency_acx.acx_pick_data1.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.obj = testData1;
      print(consistency_acx.acx_pick_data1.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.obj = testData2;
      print(consistency_acx.acx_pick_data1.obj);
      expect(consistency_acx.acx_pick_data1.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.obj = defalut;
      print(consistency_acx.acx_pick_data1.obj);
      expect(consistency_acx.acx_pick_data1.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.condi;
      print(consistency_acx.acx_pick_data1.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.condi = testData1;
      print(consistency_acx.acx_pick_data1.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.condi = testData2;
      print(consistency_acx.acx_pick_data1.condi);
      expect(consistency_acx.acx_pick_data1.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.condi = defalut;
      print(consistency_acx.acx_pick_data1.condi);
      expect(consistency_acx.acx_pick_data1.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.typ;
      print(consistency_acx.acx_pick_data1.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.typ = testData1;
      print(consistency_acx.acx_pick_data1.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.typ = testData2;
      print(consistency_acx.acx_pick_data1.typ);
      expect(consistency_acx.acx_pick_data1.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.typ = defalut;
      print(consistency_acx.acx_pick_data1.typ);
      expect(consistency_acx.acx_pick_data1.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.ini_typ;
      print(consistency_acx.acx_pick_data1.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.ini_typ = testData1;
      print(consistency_acx.acx_pick_data1.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.ini_typ = testData2;
      print(consistency_acx.acx_pick_data1.ini_typ);
      expect(consistency_acx.acx_pick_data1.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.ini_typ = defalut;
      print(consistency_acx.acx_pick_data1.ini_typ);
      expect(consistency_acx.acx_pick_data1.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.file;
      print(consistency_acx.acx_pick_data1.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.file = testData1s;
      print(consistency_acx.acx_pick_data1.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.file = testData2s;
      print(consistency_acx.acx_pick_data1.file);
      expect(consistency_acx.acx_pick_data1.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.file = defalut;
      print(consistency_acx.acx_pick_data1.file);
      expect(consistency_acx.acx_pick_data1.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.section;
      print(consistency_acx.acx_pick_data1.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.section = testData1s;
      print(consistency_acx.acx_pick_data1.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.section = testData2s;
      print(consistency_acx.acx_pick_data1.section);
      expect(consistency_acx.acx_pick_data1.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.section = defalut;
      print(consistency_acx.acx_pick_data1.section);
      expect(consistency_acx.acx_pick_data1.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_pick_data1.keyword;
      print(consistency_acx.acx_pick_data1.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_pick_data1.keyword = testData1s;
      print(consistency_acx.acx_pick_data1.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_pick_data1.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_pick_data1.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_pick_data1.keyword = testData2s;
      print(consistency_acx.acx_pick_data1.keyword);
      expect(consistency_acx.acx_pick_data1.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_pick_data1.keyword = defalut;
      print(consistency_acx.acx_pick_data1.keyword);
      expect(consistency_acx.acx_pick_data1.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_pick_data1.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.title;
      print(consistency_acx.ecs_recalc_reject.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.title = testData1s;
      print(consistency_acx.ecs_recalc_reject.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.title = testData2s;
      print(consistency_acx.ecs_recalc_reject.title);
      expect(consistency_acx.ecs_recalc_reject.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.title = defalut;
      print(consistency_acx.ecs_recalc_reject.title);
      expect(consistency_acx.ecs_recalc_reject.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.obj;
      print(consistency_acx.ecs_recalc_reject.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.obj = testData1;
      print(consistency_acx.ecs_recalc_reject.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.obj = testData2;
      print(consistency_acx.ecs_recalc_reject.obj);
      expect(consistency_acx.ecs_recalc_reject.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.obj = defalut;
      print(consistency_acx.ecs_recalc_reject.obj);
      expect(consistency_acx.ecs_recalc_reject.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

    test('00242_element_check_00219', () async {
      print("\n********** テスト実行：00242_element_check_00219 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.condi;
      print(consistency_acx.ecs_recalc_reject.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.condi = testData1;
      print(consistency_acx.ecs_recalc_reject.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.condi = testData2;
      print(consistency_acx.ecs_recalc_reject.condi);
      expect(consistency_acx.ecs_recalc_reject.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.condi = defalut;
      print(consistency_acx.ecs_recalc_reject.condi);
      expect(consistency_acx.ecs_recalc_reject.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00242_element_check_00219 **********\n\n");
    });

    test('00243_element_check_00220', () async {
      print("\n********** テスト実行：00243_element_check_00220 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.typ;
      print(consistency_acx.ecs_recalc_reject.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.typ = testData1;
      print(consistency_acx.ecs_recalc_reject.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.typ = testData2;
      print(consistency_acx.ecs_recalc_reject.typ);
      expect(consistency_acx.ecs_recalc_reject.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.typ = defalut;
      print(consistency_acx.ecs_recalc_reject.typ);
      expect(consistency_acx.ecs_recalc_reject.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00243_element_check_00220 **********\n\n");
    });

    test('00244_element_check_00221', () async {
      print("\n********** テスト実行：00244_element_check_00221 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.ini_typ;
      print(consistency_acx.ecs_recalc_reject.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.ini_typ = testData1;
      print(consistency_acx.ecs_recalc_reject.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.ini_typ = testData2;
      print(consistency_acx.ecs_recalc_reject.ini_typ);
      expect(consistency_acx.ecs_recalc_reject.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.ini_typ = defalut;
      print(consistency_acx.ecs_recalc_reject.ini_typ);
      expect(consistency_acx.ecs_recalc_reject.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00244_element_check_00221 **********\n\n");
    });

    test('00245_element_check_00222', () async {
      print("\n********** テスト実行：00245_element_check_00222 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.file;
      print(consistency_acx.ecs_recalc_reject.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.file = testData1s;
      print(consistency_acx.ecs_recalc_reject.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.file = testData2s;
      print(consistency_acx.ecs_recalc_reject.file);
      expect(consistency_acx.ecs_recalc_reject.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.file = defalut;
      print(consistency_acx.ecs_recalc_reject.file);
      expect(consistency_acx.ecs_recalc_reject.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00245_element_check_00222 **********\n\n");
    });

    test('00246_element_check_00223', () async {
      print("\n********** テスト実行：00246_element_check_00223 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.section;
      print(consistency_acx.ecs_recalc_reject.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.section = testData1s;
      print(consistency_acx.ecs_recalc_reject.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.section = testData2s;
      print(consistency_acx.ecs_recalc_reject.section);
      expect(consistency_acx.ecs_recalc_reject.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.section = defalut;
      print(consistency_acx.ecs_recalc_reject.section);
      expect(consistency_acx.ecs_recalc_reject.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00246_element_check_00223 **********\n\n");
    });

    test('00247_element_check_00224', () async {
      print("\n********** テスト実行：00247_element_check_00224 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.ecs_recalc_reject.keyword;
      print(consistency_acx.ecs_recalc_reject.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.ecs_recalc_reject.keyword = testData1s;
      print(consistency_acx.ecs_recalc_reject.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.ecs_recalc_reject.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.ecs_recalc_reject.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.ecs_recalc_reject.keyword = testData2s;
      print(consistency_acx.ecs_recalc_reject.keyword);
      expect(consistency_acx.ecs_recalc_reject.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.ecs_recalc_reject.keyword = defalut;
      print(consistency_acx.ecs_recalc_reject.keyword);
      expect(consistency_acx.ecs_recalc_reject.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.ecs_recalc_reject.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00247_element_check_00224 **********\n\n");
    });

    test('00248_element_check_00225', () async {
      print("\n********** テスト実行：00248_element_check_00225 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.title;
      print(consistency_acx.sst1_error_disp.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.title = testData1s;
      print(consistency_acx.sst1_error_disp.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.title = testData2s;
      print(consistency_acx.sst1_error_disp.title);
      expect(consistency_acx.sst1_error_disp.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.title = defalut;
      print(consistency_acx.sst1_error_disp.title);
      expect(consistency_acx.sst1_error_disp.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00248_element_check_00225 **********\n\n");
    });

    test('00249_element_check_00226', () async {
      print("\n********** テスト実行：00249_element_check_00226 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.obj;
      print(consistency_acx.sst1_error_disp.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.obj = testData1;
      print(consistency_acx.sst1_error_disp.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.obj = testData2;
      print(consistency_acx.sst1_error_disp.obj);
      expect(consistency_acx.sst1_error_disp.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.obj = defalut;
      print(consistency_acx.sst1_error_disp.obj);
      expect(consistency_acx.sst1_error_disp.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00249_element_check_00226 **********\n\n");
    });

    test('00250_element_check_00227', () async {
      print("\n********** テスト実行：00250_element_check_00227 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.condi;
      print(consistency_acx.sst1_error_disp.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.condi = testData1;
      print(consistency_acx.sst1_error_disp.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.condi = testData2;
      print(consistency_acx.sst1_error_disp.condi);
      expect(consistency_acx.sst1_error_disp.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.condi = defalut;
      print(consistency_acx.sst1_error_disp.condi);
      expect(consistency_acx.sst1_error_disp.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00250_element_check_00227 **********\n\n");
    });

    test('00251_element_check_00228', () async {
      print("\n********** テスト実行：00251_element_check_00228 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.typ;
      print(consistency_acx.sst1_error_disp.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.typ = testData1;
      print(consistency_acx.sst1_error_disp.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.typ = testData2;
      print(consistency_acx.sst1_error_disp.typ);
      expect(consistency_acx.sst1_error_disp.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.typ = defalut;
      print(consistency_acx.sst1_error_disp.typ);
      expect(consistency_acx.sst1_error_disp.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00251_element_check_00228 **********\n\n");
    });

    test('00252_element_check_00229', () async {
      print("\n********** テスト実行：00252_element_check_00229 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.ini_typ;
      print(consistency_acx.sst1_error_disp.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.ini_typ = testData1;
      print(consistency_acx.sst1_error_disp.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.ini_typ = testData2;
      print(consistency_acx.sst1_error_disp.ini_typ);
      expect(consistency_acx.sst1_error_disp.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.ini_typ = defalut;
      print(consistency_acx.sst1_error_disp.ini_typ);
      expect(consistency_acx.sst1_error_disp.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00252_element_check_00229 **********\n\n");
    });

    test('00253_element_check_00230', () async {
      print("\n********** テスト実行：00253_element_check_00230 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.file;
      print(consistency_acx.sst1_error_disp.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.file = testData1s;
      print(consistency_acx.sst1_error_disp.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.file = testData2s;
      print(consistency_acx.sst1_error_disp.file);
      expect(consistency_acx.sst1_error_disp.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.file = defalut;
      print(consistency_acx.sst1_error_disp.file);
      expect(consistency_acx.sst1_error_disp.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00253_element_check_00230 **********\n\n");
    });

    test('00254_element_check_00231', () async {
      print("\n********** テスト実行：00254_element_check_00231 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.section;
      print(consistency_acx.sst1_error_disp.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.section = testData1s;
      print(consistency_acx.sst1_error_disp.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.section = testData2s;
      print(consistency_acx.sst1_error_disp.section);
      expect(consistency_acx.sst1_error_disp.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.section = defalut;
      print(consistency_acx.sst1_error_disp.section);
      expect(consistency_acx.sst1_error_disp.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00254_element_check_00231 **********\n\n");
    });

    test('00255_element_check_00232', () async {
      print("\n********** テスト実行：00255_element_check_00232 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_error_disp.keyword;
      print(consistency_acx.sst1_error_disp.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_error_disp.keyword = testData1s;
      print(consistency_acx.sst1_error_disp.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_error_disp.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_error_disp.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_error_disp.keyword = testData2s;
      print(consistency_acx.sst1_error_disp.keyword);
      expect(consistency_acx.sst1_error_disp.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_error_disp.keyword = defalut;
      print(consistency_acx.sst1_error_disp.keyword);
      expect(consistency_acx.sst1_error_disp.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_error_disp.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00255_element_check_00232 **********\n\n");
    });

    test('00256_element_check_00233', () async {
      print("\n********** テスト実行：00256_element_check_00233 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.title;
      print(consistency_acx.sst1_cin_retry.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.title = testData1s;
      print(consistency_acx.sst1_cin_retry.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.title = testData2s;
      print(consistency_acx.sst1_cin_retry.title);
      expect(consistency_acx.sst1_cin_retry.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.title = defalut;
      print(consistency_acx.sst1_cin_retry.title);
      expect(consistency_acx.sst1_cin_retry.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00256_element_check_00233 **********\n\n");
    });

    test('00257_element_check_00234', () async {
      print("\n********** テスト実行：00257_element_check_00234 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.obj;
      print(consistency_acx.sst1_cin_retry.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.obj = testData1;
      print(consistency_acx.sst1_cin_retry.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.obj = testData2;
      print(consistency_acx.sst1_cin_retry.obj);
      expect(consistency_acx.sst1_cin_retry.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.obj = defalut;
      print(consistency_acx.sst1_cin_retry.obj);
      expect(consistency_acx.sst1_cin_retry.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00257_element_check_00234 **********\n\n");
    });

    test('00258_element_check_00235', () async {
      print("\n********** テスト実行：00258_element_check_00235 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.condi;
      print(consistency_acx.sst1_cin_retry.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.condi = testData1;
      print(consistency_acx.sst1_cin_retry.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.condi = testData2;
      print(consistency_acx.sst1_cin_retry.condi);
      expect(consistency_acx.sst1_cin_retry.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.condi = defalut;
      print(consistency_acx.sst1_cin_retry.condi);
      expect(consistency_acx.sst1_cin_retry.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00258_element_check_00235 **********\n\n");
    });

    test('00259_element_check_00236', () async {
      print("\n********** テスト実行：00259_element_check_00236 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.typ;
      print(consistency_acx.sst1_cin_retry.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.typ = testData1;
      print(consistency_acx.sst1_cin_retry.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.typ = testData2;
      print(consistency_acx.sst1_cin_retry.typ);
      expect(consistency_acx.sst1_cin_retry.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.typ = defalut;
      print(consistency_acx.sst1_cin_retry.typ);
      expect(consistency_acx.sst1_cin_retry.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00259_element_check_00236 **********\n\n");
    });

    test('00260_element_check_00237', () async {
      print("\n********** テスト実行：00260_element_check_00237 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.ini_typ;
      print(consistency_acx.sst1_cin_retry.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.ini_typ = testData1;
      print(consistency_acx.sst1_cin_retry.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.ini_typ = testData2;
      print(consistency_acx.sst1_cin_retry.ini_typ);
      expect(consistency_acx.sst1_cin_retry.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.ini_typ = defalut;
      print(consistency_acx.sst1_cin_retry.ini_typ);
      expect(consistency_acx.sst1_cin_retry.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00260_element_check_00237 **********\n\n");
    });

    test('00261_element_check_00238', () async {
      print("\n********** テスト実行：00261_element_check_00238 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.file;
      print(consistency_acx.sst1_cin_retry.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.file = testData1s;
      print(consistency_acx.sst1_cin_retry.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.file = testData2s;
      print(consistency_acx.sst1_cin_retry.file);
      expect(consistency_acx.sst1_cin_retry.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.file = defalut;
      print(consistency_acx.sst1_cin_retry.file);
      expect(consistency_acx.sst1_cin_retry.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00261_element_check_00238 **********\n\n");
    });

    test('00262_element_check_00239', () async {
      print("\n********** テスト実行：00262_element_check_00239 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.section;
      print(consistency_acx.sst1_cin_retry.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.section = testData1s;
      print(consistency_acx.sst1_cin_retry.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.section = testData2s;
      print(consistency_acx.sst1_cin_retry.section);
      expect(consistency_acx.sst1_cin_retry.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.section = defalut;
      print(consistency_acx.sst1_cin_retry.section);
      expect(consistency_acx.sst1_cin_retry.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00262_element_check_00239 **********\n\n");
    });

    test('00263_element_check_00240', () async {
      print("\n********** テスト実行：00263_element_check_00240 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.sst1_cin_retry.keyword;
      print(consistency_acx.sst1_cin_retry.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.sst1_cin_retry.keyword = testData1s;
      print(consistency_acx.sst1_cin_retry.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.sst1_cin_retry.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.sst1_cin_retry.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.sst1_cin_retry.keyword = testData2s;
      print(consistency_acx.sst1_cin_retry.keyword);
      expect(consistency_acx.sst1_cin_retry.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.sst1_cin_retry.keyword = defalut;
      print(consistency_acx.sst1_cin_retry.keyword);
      expect(consistency_acx.sst1_cin_retry.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.sst1_cin_retry.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00263_element_check_00240 **********\n\n");
    });

    test('00264_element_check_00241', () async {
      print("\n********** テスト実行：00264_element_check_00241 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.title;
      print(consistency_acx.acx_resv_min5000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.title = testData1s;
      print(consistency_acx.acx_resv_min5000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.title = testData2s;
      print(consistency_acx.acx_resv_min5000.title);
      expect(consistency_acx.acx_resv_min5000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.title = defalut;
      print(consistency_acx.acx_resv_min5000.title);
      expect(consistency_acx.acx_resv_min5000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00264_element_check_00241 **********\n\n");
    });

    test('00265_element_check_00242', () async {
      print("\n********** テスト実行：00265_element_check_00242 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.obj;
      print(consistency_acx.acx_resv_min5000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.obj = testData1;
      print(consistency_acx.acx_resv_min5000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.obj = testData2;
      print(consistency_acx.acx_resv_min5000.obj);
      expect(consistency_acx.acx_resv_min5000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.obj = defalut;
      print(consistency_acx.acx_resv_min5000.obj);
      expect(consistency_acx.acx_resv_min5000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00265_element_check_00242 **********\n\n");
    });

    test('00266_element_check_00243', () async {
      print("\n********** テスト実行：00266_element_check_00243 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.condi;
      print(consistency_acx.acx_resv_min5000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.condi = testData1;
      print(consistency_acx.acx_resv_min5000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.condi = testData2;
      print(consistency_acx.acx_resv_min5000.condi);
      expect(consistency_acx.acx_resv_min5000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.condi = defalut;
      print(consistency_acx.acx_resv_min5000.condi);
      expect(consistency_acx.acx_resv_min5000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00266_element_check_00243 **********\n\n");
    });

    test('00267_element_check_00244', () async {
      print("\n********** テスト実行：00267_element_check_00244 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.typ;
      print(consistency_acx.acx_resv_min5000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.typ = testData1;
      print(consistency_acx.acx_resv_min5000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.typ = testData2;
      print(consistency_acx.acx_resv_min5000.typ);
      expect(consistency_acx.acx_resv_min5000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.typ = defalut;
      print(consistency_acx.acx_resv_min5000.typ);
      expect(consistency_acx.acx_resv_min5000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00267_element_check_00244 **********\n\n");
    });

    test('00268_element_check_00245', () async {
      print("\n********** テスト実行：00268_element_check_00245 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.ini_typ;
      print(consistency_acx.acx_resv_min5000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.ini_typ = testData1;
      print(consistency_acx.acx_resv_min5000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.ini_typ = testData2;
      print(consistency_acx.acx_resv_min5000.ini_typ);
      expect(consistency_acx.acx_resv_min5000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.ini_typ = defalut;
      print(consistency_acx.acx_resv_min5000.ini_typ);
      expect(consistency_acx.acx_resv_min5000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00268_element_check_00245 **********\n\n");
    });

    test('00269_element_check_00246', () async {
      print("\n********** テスト実行：00269_element_check_00246 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.file;
      print(consistency_acx.acx_resv_min5000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.file = testData1s;
      print(consistency_acx.acx_resv_min5000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.file = testData2s;
      print(consistency_acx.acx_resv_min5000.file);
      expect(consistency_acx.acx_resv_min5000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.file = defalut;
      print(consistency_acx.acx_resv_min5000.file);
      expect(consistency_acx.acx_resv_min5000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00269_element_check_00246 **********\n\n");
    });

    test('00270_element_check_00247', () async {
      print("\n********** テスト実行：00270_element_check_00247 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.section;
      print(consistency_acx.acx_resv_min5000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.section = testData1s;
      print(consistency_acx.acx_resv_min5000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.section = testData2s;
      print(consistency_acx.acx_resv_min5000.section);
      expect(consistency_acx.acx_resv_min5000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.section = defalut;
      print(consistency_acx.acx_resv_min5000.section);
      expect(consistency_acx.acx_resv_min5000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00270_element_check_00247 **********\n\n");
    });

    test('00271_element_check_00248', () async {
      print("\n********** テスト実行：00271_element_check_00248 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5000.keyword;
      print(consistency_acx.acx_resv_min5000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5000.keyword = testData1s;
      print(consistency_acx.acx_resv_min5000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5000.keyword = testData2s;
      print(consistency_acx.acx_resv_min5000.keyword);
      expect(consistency_acx.acx_resv_min5000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5000.keyword = defalut;
      print(consistency_acx.acx_resv_min5000.keyword);
      expect(consistency_acx.acx_resv_min5000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00271_element_check_00248 **********\n\n");
    });

    test('00272_element_check_00249', () async {
      print("\n********** テスト実行：00272_element_check_00249 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.title;
      print(consistency_acx.acx_resv_min2000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.title = testData1s;
      print(consistency_acx.acx_resv_min2000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.title = testData2s;
      print(consistency_acx.acx_resv_min2000.title);
      expect(consistency_acx.acx_resv_min2000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.title = defalut;
      print(consistency_acx.acx_resv_min2000.title);
      expect(consistency_acx.acx_resv_min2000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00272_element_check_00249 **********\n\n");
    });

    test('00273_element_check_00250', () async {
      print("\n********** テスト実行：00273_element_check_00250 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.obj;
      print(consistency_acx.acx_resv_min2000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.obj = testData1;
      print(consistency_acx.acx_resv_min2000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.obj = testData2;
      print(consistency_acx.acx_resv_min2000.obj);
      expect(consistency_acx.acx_resv_min2000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.obj = defalut;
      print(consistency_acx.acx_resv_min2000.obj);
      expect(consistency_acx.acx_resv_min2000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00273_element_check_00250 **********\n\n");
    });

    test('00274_element_check_00251', () async {
      print("\n********** テスト実行：00274_element_check_00251 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.condi;
      print(consistency_acx.acx_resv_min2000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.condi = testData1;
      print(consistency_acx.acx_resv_min2000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.condi = testData2;
      print(consistency_acx.acx_resv_min2000.condi);
      expect(consistency_acx.acx_resv_min2000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.condi = defalut;
      print(consistency_acx.acx_resv_min2000.condi);
      expect(consistency_acx.acx_resv_min2000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00274_element_check_00251 **********\n\n");
    });

    test('00275_element_check_00252', () async {
      print("\n********** テスト実行：00275_element_check_00252 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.typ;
      print(consistency_acx.acx_resv_min2000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.typ = testData1;
      print(consistency_acx.acx_resv_min2000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.typ = testData2;
      print(consistency_acx.acx_resv_min2000.typ);
      expect(consistency_acx.acx_resv_min2000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.typ = defalut;
      print(consistency_acx.acx_resv_min2000.typ);
      expect(consistency_acx.acx_resv_min2000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00275_element_check_00252 **********\n\n");
    });

    test('00276_element_check_00253', () async {
      print("\n********** テスト実行：00276_element_check_00253 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.ini_typ;
      print(consistency_acx.acx_resv_min2000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.ini_typ = testData1;
      print(consistency_acx.acx_resv_min2000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.ini_typ = testData2;
      print(consistency_acx.acx_resv_min2000.ini_typ);
      expect(consistency_acx.acx_resv_min2000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.ini_typ = defalut;
      print(consistency_acx.acx_resv_min2000.ini_typ);
      expect(consistency_acx.acx_resv_min2000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00276_element_check_00253 **********\n\n");
    });

    test('00277_element_check_00254', () async {
      print("\n********** テスト実行：00277_element_check_00254 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.file;
      print(consistency_acx.acx_resv_min2000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.file = testData1s;
      print(consistency_acx.acx_resv_min2000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.file = testData2s;
      print(consistency_acx.acx_resv_min2000.file);
      expect(consistency_acx.acx_resv_min2000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.file = defalut;
      print(consistency_acx.acx_resv_min2000.file);
      expect(consistency_acx.acx_resv_min2000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00277_element_check_00254 **********\n\n");
    });

    test('00278_element_check_00255', () async {
      print("\n********** テスト実行：00278_element_check_00255 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.section;
      print(consistency_acx.acx_resv_min2000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.section = testData1s;
      print(consistency_acx.acx_resv_min2000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.section = testData2s;
      print(consistency_acx.acx_resv_min2000.section);
      expect(consistency_acx.acx_resv_min2000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.section = defalut;
      print(consistency_acx.acx_resv_min2000.section);
      expect(consistency_acx.acx_resv_min2000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00278_element_check_00255 **********\n\n");
    });

    test('00279_element_check_00256', () async {
      print("\n********** テスト実行：00279_element_check_00256 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min2000.keyword;
      print(consistency_acx.acx_resv_min2000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min2000.keyword = testData1s;
      print(consistency_acx.acx_resv_min2000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min2000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min2000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min2000.keyword = testData2s;
      print(consistency_acx.acx_resv_min2000.keyword);
      expect(consistency_acx.acx_resv_min2000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min2000.keyword = defalut;
      print(consistency_acx.acx_resv_min2000.keyword);
      expect(consistency_acx.acx_resv_min2000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min2000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00279_element_check_00256 **********\n\n");
    });

    test('00280_element_check_00257', () async {
      print("\n********** テスト実行：00280_element_check_00257 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.title;
      print(consistency_acx.acx_resv_min1000.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.title = testData1s;
      print(consistency_acx.acx_resv_min1000.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.title = testData2s;
      print(consistency_acx.acx_resv_min1000.title);
      expect(consistency_acx.acx_resv_min1000.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.title = defalut;
      print(consistency_acx.acx_resv_min1000.title);
      expect(consistency_acx.acx_resv_min1000.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00280_element_check_00257 **********\n\n");
    });

    test('00281_element_check_00258', () async {
      print("\n********** テスト実行：00281_element_check_00258 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.obj;
      print(consistency_acx.acx_resv_min1000.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.obj = testData1;
      print(consistency_acx.acx_resv_min1000.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.obj = testData2;
      print(consistency_acx.acx_resv_min1000.obj);
      expect(consistency_acx.acx_resv_min1000.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.obj = defalut;
      print(consistency_acx.acx_resv_min1000.obj);
      expect(consistency_acx.acx_resv_min1000.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00281_element_check_00258 **********\n\n");
    });

    test('00282_element_check_00259', () async {
      print("\n********** テスト実行：00282_element_check_00259 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.condi;
      print(consistency_acx.acx_resv_min1000.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.condi = testData1;
      print(consistency_acx.acx_resv_min1000.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.condi = testData2;
      print(consistency_acx.acx_resv_min1000.condi);
      expect(consistency_acx.acx_resv_min1000.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.condi = defalut;
      print(consistency_acx.acx_resv_min1000.condi);
      expect(consistency_acx.acx_resv_min1000.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00282_element_check_00259 **********\n\n");
    });

    test('00283_element_check_00260', () async {
      print("\n********** テスト実行：00283_element_check_00260 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.typ;
      print(consistency_acx.acx_resv_min1000.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.typ = testData1;
      print(consistency_acx.acx_resv_min1000.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.typ = testData2;
      print(consistency_acx.acx_resv_min1000.typ);
      expect(consistency_acx.acx_resv_min1000.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.typ = defalut;
      print(consistency_acx.acx_resv_min1000.typ);
      expect(consistency_acx.acx_resv_min1000.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00283_element_check_00260 **********\n\n");
    });

    test('00284_element_check_00261', () async {
      print("\n********** テスト実行：00284_element_check_00261 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.ini_typ;
      print(consistency_acx.acx_resv_min1000.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.ini_typ = testData1;
      print(consistency_acx.acx_resv_min1000.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.ini_typ = testData2;
      print(consistency_acx.acx_resv_min1000.ini_typ);
      expect(consistency_acx.acx_resv_min1000.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.ini_typ = defalut;
      print(consistency_acx.acx_resv_min1000.ini_typ);
      expect(consistency_acx.acx_resv_min1000.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00284_element_check_00261 **********\n\n");
    });

    test('00285_element_check_00262', () async {
      print("\n********** テスト実行：00285_element_check_00262 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.file;
      print(consistency_acx.acx_resv_min1000.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.file = testData1s;
      print(consistency_acx.acx_resv_min1000.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.file = testData2s;
      print(consistency_acx.acx_resv_min1000.file);
      expect(consistency_acx.acx_resv_min1000.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.file = defalut;
      print(consistency_acx.acx_resv_min1000.file);
      expect(consistency_acx.acx_resv_min1000.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00285_element_check_00262 **********\n\n");
    });

    test('00286_element_check_00263', () async {
      print("\n********** テスト実行：00286_element_check_00263 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.section;
      print(consistency_acx.acx_resv_min1000.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.section = testData1s;
      print(consistency_acx.acx_resv_min1000.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.section = testData2s;
      print(consistency_acx.acx_resv_min1000.section);
      expect(consistency_acx.acx_resv_min1000.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.section = defalut;
      print(consistency_acx.acx_resv_min1000.section);
      expect(consistency_acx.acx_resv_min1000.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00286_element_check_00263 **********\n\n");
    });

    test('00287_element_check_00264', () async {
      print("\n********** テスト実行：00287_element_check_00264 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1000.keyword;
      print(consistency_acx.acx_resv_min1000.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1000.keyword = testData1s;
      print(consistency_acx.acx_resv_min1000.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1000.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1000.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1000.keyword = testData2s;
      print(consistency_acx.acx_resv_min1000.keyword);
      expect(consistency_acx.acx_resv_min1000.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1000.keyword = defalut;
      print(consistency_acx.acx_resv_min1000.keyword);
      expect(consistency_acx.acx_resv_min1000.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1000.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00287_element_check_00264 **********\n\n");
    });

    test('00288_element_check_00265', () async {
      print("\n********** テスト実行：00288_element_check_00265 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.title;
      print(consistency_acx.acx_resv_min500.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.title = testData1s;
      print(consistency_acx.acx_resv_min500.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.title = testData2s;
      print(consistency_acx.acx_resv_min500.title);
      expect(consistency_acx.acx_resv_min500.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.title = defalut;
      print(consistency_acx.acx_resv_min500.title);
      expect(consistency_acx.acx_resv_min500.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00288_element_check_00265 **********\n\n");
    });

    test('00289_element_check_00266', () async {
      print("\n********** テスト実行：00289_element_check_00266 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.obj;
      print(consistency_acx.acx_resv_min500.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.obj = testData1;
      print(consistency_acx.acx_resv_min500.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.obj = testData2;
      print(consistency_acx.acx_resv_min500.obj);
      expect(consistency_acx.acx_resv_min500.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.obj = defalut;
      print(consistency_acx.acx_resv_min500.obj);
      expect(consistency_acx.acx_resv_min500.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00289_element_check_00266 **********\n\n");
    });

    test('00290_element_check_00267', () async {
      print("\n********** テスト実行：00290_element_check_00267 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.condi;
      print(consistency_acx.acx_resv_min500.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.condi = testData1;
      print(consistency_acx.acx_resv_min500.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.condi = testData2;
      print(consistency_acx.acx_resv_min500.condi);
      expect(consistency_acx.acx_resv_min500.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.condi = defalut;
      print(consistency_acx.acx_resv_min500.condi);
      expect(consistency_acx.acx_resv_min500.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00290_element_check_00267 **********\n\n");
    });

    test('00291_element_check_00268', () async {
      print("\n********** テスト実行：00291_element_check_00268 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.typ;
      print(consistency_acx.acx_resv_min500.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.typ = testData1;
      print(consistency_acx.acx_resv_min500.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.typ = testData2;
      print(consistency_acx.acx_resv_min500.typ);
      expect(consistency_acx.acx_resv_min500.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.typ = defalut;
      print(consistency_acx.acx_resv_min500.typ);
      expect(consistency_acx.acx_resv_min500.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00291_element_check_00268 **********\n\n");
    });

    test('00292_element_check_00269', () async {
      print("\n********** テスト実行：00292_element_check_00269 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.ini_typ;
      print(consistency_acx.acx_resv_min500.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.ini_typ = testData1;
      print(consistency_acx.acx_resv_min500.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.ini_typ = testData2;
      print(consistency_acx.acx_resv_min500.ini_typ);
      expect(consistency_acx.acx_resv_min500.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.ini_typ = defalut;
      print(consistency_acx.acx_resv_min500.ini_typ);
      expect(consistency_acx.acx_resv_min500.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00292_element_check_00269 **********\n\n");
    });

    test('00293_element_check_00270', () async {
      print("\n********** テスト実行：00293_element_check_00270 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.file;
      print(consistency_acx.acx_resv_min500.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.file = testData1s;
      print(consistency_acx.acx_resv_min500.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.file = testData2s;
      print(consistency_acx.acx_resv_min500.file);
      expect(consistency_acx.acx_resv_min500.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.file = defalut;
      print(consistency_acx.acx_resv_min500.file);
      expect(consistency_acx.acx_resv_min500.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00293_element_check_00270 **********\n\n");
    });

    test('00294_element_check_00271', () async {
      print("\n********** テスト実行：00294_element_check_00271 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.section;
      print(consistency_acx.acx_resv_min500.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.section = testData1s;
      print(consistency_acx.acx_resv_min500.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.section = testData2s;
      print(consistency_acx.acx_resv_min500.section);
      expect(consistency_acx.acx_resv_min500.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.section = defalut;
      print(consistency_acx.acx_resv_min500.section);
      expect(consistency_acx.acx_resv_min500.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00294_element_check_00271 **********\n\n");
    });

    test('00295_element_check_00272', () async {
      print("\n********** テスト実行：00295_element_check_00272 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min500.keyword;
      print(consistency_acx.acx_resv_min500.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min500.keyword = testData1s;
      print(consistency_acx.acx_resv_min500.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min500.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min500.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min500.keyword = testData2s;
      print(consistency_acx.acx_resv_min500.keyword);
      expect(consistency_acx.acx_resv_min500.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min500.keyword = defalut;
      print(consistency_acx.acx_resv_min500.keyword);
      expect(consistency_acx.acx_resv_min500.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min500.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00295_element_check_00272 **********\n\n");
    });

    test('00296_element_check_00273', () async {
      print("\n********** テスト実行：00296_element_check_00273 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.title;
      print(consistency_acx.acx_resv_min100.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.title = testData1s;
      print(consistency_acx.acx_resv_min100.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.title = testData2s;
      print(consistency_acx.acx_resv_min100.title);
      expect(consistency_acx.acx_resv_min100.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.title = defalut;
      print(consistency_acx.acx_resv_min100.title);
      expect(consistency_acx.acx_resv_min100.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00296_element_check_00273 **********\n\n");
    });

    test('00297_element_check_00274', () async {
      print("\n********** テスト実行：00297_element_check_00274 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.obj;
      print(consistency_acx.acx_resv_min100.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.obj = testData1;
      print(consistency_acx.acx_resv_min100.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.obj = testData2;
      print(consistency_acx.acx_resv_min100.obj);
      expect(consistency_acx.acx_resv_min100.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.obj = defalut;
      print(consistency_acx.acx_resv_min100.obj);
      expect(consistency_acx.acx_resv_min100.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00297_element_check_00274 **********\n\n");
    });

    test('00298_element_check_00275', () async {
      print("\n********** テスト実行：00298_element_check_00275 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.condi;
      print(consistency_acx.acx_resv_min100.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.condi = testData1;
      print(consistency_acx.acx_resv_min100.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.condi = testData2;
      print(consistency_acx.acx_resv_min100.condi);
      expect(consistency_acx.acx_resv_min100.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.condi = defalut;
      print(consistency_acx.acx_resv_min100.condi);
      expect(consistency_acx.acx_resv_min100.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00298_element_check_00275 **********\n\n");
    });

    test('00299_element_check_00276', () async {
      print("\n********** テスト実行：00299_element_check_00276 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.typ;
      print(consistency_acx.acx_resv_min100.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.typ = testData1;
      print(consistency_acx.acx_resv_min100.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.typ = testData2;
      print(consistency_acx.acx_resv_min100.typ);
      expect(consistency_acx.acx_resv_min100.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.typ = defalut;
      print(consistency_acx.acx_resv_min100.typ);
      expect(consistency_acx.acx_resv_min100.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00299_element_check_00276 **********\n\n");
    });

    test('00300_element_check_00277', () async {
      print("\n********** テスト実行：00300_element_check_00277 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.ini_typ;
      print(consistency_acx.acx_resv_min100.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.ini_typ = testData1;
      print(consistency_acx.acx_resv_min100.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.ini_typ = testData2;
      print(consistency_acx.acx_resv_min100.ini_typ);
      expect(consistency_acx.acx_resv_min100.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.ini_typ = defalut;
      print(consistency_acx.acx_resv_min100.ini_typ);
      expect(consistency_acx.acx_resv_min100.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00300_element_check_00277 **********\n\n");
    });

    test('00301_element_check_00278', () async {
      print("\n********** テスト実行：00301_element_check_00278 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.file;
      print(consistency_acx.acx_resv_min100.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.file = testData1s;
      print(consistency_acx.acx_resv_min100.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.file = testData2s;
      print(consistency_acx.acx_resv_min100.file);
      expect(consistency_acx.acx_resv_min100.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.file = defalut;
      print(consistency_acx.acx_resv_min100.file);
      expect(consistency_acx.acx_resv_min100.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00301_element_check_00278 **********\n\n");
    });

    test('00302_element_check_00279', () async {
      print("\n********** テスト実行：00302_element_check_00279 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.section;
      print(consistency_acx.acx_resv_min100.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.section = testData1s;
      print(consistency_acx.acx_resv_min100.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.section = testData2s;
      print(consistency_acx.acx_resv_min100.section);
      expect(consistency_acx.acx_resv_min100.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.section = defalut;
      print(consistency_acx.acx_resv_min100.section);
      expect(consistency_acx.acx_resv_min100.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00302_element_check_00279 **********\n\n");
    });

    test('00303_element_check_00280', () async {
      print("\n********** テスト実行：00303_element_check_00280 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min100.keyword;
      print(consistency_acx.acx_resv_min100.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min100.keyword = testData1s;
      print(consistency_acx.acx_resv_min100.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min100.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min100.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min100.keyword = testData2s;
      print(consistency_acx.acx_resv_min100.keyword);
      expect(consistency_acx.acx_resv_min100.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min100.keyword = defalut;
      print(consistency_acx.acx_resv_min100.keyword);
      expect(consistency_acx.acx_resv_min100.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min100.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00303_element_check_00280 **********\n\n");
    });

    test('00304_element_check_00281', () async {
      print("\n********** テスト実行：00304_element_check_00281 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.title;
      print(consistency_acx.acx_resv_min50.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.title = testData1s;
      print(consistency_acx.acx_resv_min50.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.title = testData2s;
      print(consistency_acx.acx_resv_min50.title);
      expect(consistency_acx.acx_resv_min50.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.title = defalut;
      print(consistency_acx.acx_resv_min50.title);
      expect(consistency_acx.acx_resv_min50.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00304_element_check_00281 **********\n\n");
    });

    test('00305_element_check_00282', () async {
      print("\n********** テスト実行：00305_element_check_00282 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.obj;
      print(consistency_acx.acx_resv_min50.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.obj = testData1;
      print(consistency_acx.acx_resv_min50.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.obj = testData2;
      print(consistency_acx.acx_resv_min50.obj);
      expect(consistency_acx.acx_resv_min50.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.obj = defalut;
      print(consistency_acx.acx_resv_min50.obj);
      expect(consistency_acx.acx_resv_min50.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00305_element_check_00282 **********\n\n");
    });

    test('00306_element_check_00283', () async {
      print("\n********** テスト実行：00306_element_check_00283 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.condi;
      print(consistency_acx.acx_resv_min50.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.condi = testData1;
      print(consistency_acx.acx_resv_min50.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.condi = testData2;
      print(consistency_acx.acx_resv_min50.condi);
      expect(consistency_acx.acx_resv_min50.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.condi = defalut;
      print(consistency_acx.acx_resv_min50.condi);
      expect(consistency_acx.acx_resv_min50.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00306_element_check_00283 **********\n\n");
    });

    test('00307_element_check_00284', () async {
      print("\n********** テスト実行：00307_element_check_00284 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.typ;
      print(consistency_acx.acx_resv_min50.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.typ = testData1;
      print(consistency_acx.acx_resv_min50.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.typ = testData2;
      print(consistency_acx.acx_resv_min50.typ);
      expect(consistency_acx.acx_resv_min50.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.typ = defalut;
      print(consistency_acx.acx_resv_min50.typ);
      expect(consistency_acx.acx_resv_min50.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00307_element_check_00284 **********\n\n");
    });

    test('00308_element_check_00285', () async {
      print("\n********** テスト実行：00308_element_check_00285 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.ini_typ;
      print(consistency_acx.acx_resv_min50.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.ini_typ = testData1;
      print(consistency_acx.acx_resv_min50.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.ini_typ = testData2;
      print(consistency_acx.acx_resv_min50.ini_typ);
      expect(consistency_acx.acx_resv_min50.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.ini_typ = defalut;
      print(consistency_acx.acx_resv_min50.ini_typ);
      expect(consistency_acx.acx_resv_min50.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00308_element_check_00285 **********\n\n");
    });

    test('00309_element_check_00286', () async {
      print("\n********** テスト実行：00309_element_check_00286 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.file;
      print(consistency_acx.acx_resv_min50.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.file = testData1s;
      print(consistency_acx.acx_resv_min50.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.file = testData2s;
      print(consistency_acx.acx_resv_min50.file);
      expect(consistency_acx.acx_resv_min50.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.file = defalut;
      print(consistency_acx.acx_resv_min50.file);
      expect(consistency_acx.acx_resv_min50.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00309_element_check_00286 **********\n\n");
    });

    test('00310_element_check_00287', () async {
      print("\n********** テスト実行：00310_element_check_00287 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.section;
      print(consistency_acx.acx_resv_min50.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.section = testData1s;
      print(consistency_acx.acx_resv_min50.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.section = testData2s;
      print(consistency_acx.acx_resv_min50.section);
      expect(consistency_acx.acx_resv_min50.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.section = defalut;
      print(consistency_acx.acx_resv_min50.section);
      expect(consistency_acx.acx_resv_min50.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00310_element_check_00287 **********\n\n");
    });

    test('00311_element_check_00288', () async {
      print("\n********** テスト実行：00311_element_check_00288 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min50.keyword;
      print(consistency_acx.acx_resv_min50.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min50.keyword = testData1s;
      print(consistency_acx.acx_resv_min50.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min50.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min50.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min50.keyword = testData2s;
      print(consistency_acx.acx_resv_min50.keyword);
      expect(consistency_acx.acx_resv_min50.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min50.keyword = defalut;
      print(consistency_acx.acx_resv_min50.keyword);
      expect(consistency_acx.acx_resv_min50.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min50.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00311_element_check_00288 **********\n\n");
    });

    test('00312_element_check_00289', () async {
      print("\n********** テスト実行：00312_element_check_00289 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.title;
      print(consistency_acx.acx_resv_min10.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.title = testData1s;
      print(consistency_acx.acx_resv_min10.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.title = testData2s;
      print(consistency_acx.acx_resv_min10.title);
      expect(consistency_acx.acx_resv_min10.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.title = defalut;
      print(consistency_acx.acx_resv_min10.title);
      expect(consistency_acx.acx_resv_min10.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00312_element_check_00289 **********\n\n");
    });

    test('00313_element_check_00290', () async {
      print("\n********** テスト実行：00313_element_check_00290 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.obj;
      print(consistency_acx.acx_resv_min10.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.obj = testData1;
      print(consistency_acx.acx_resv_min10.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.obj = testData2;
      print(consistency_acx.acx_resv_min10.obj);
      expect(consistency_acx.acx_resv_min10.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.obj = defalut;
      print(consistency_acx.acx_resv_min10.obj);
      expect(consistency_acx.acx_resv_min10.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00313_element_check_00290 **********\n\n");
    });

    test('00314_element_check_00291', () async {
      print("\n********** テスト実行：00314_element_check_00291 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.condi;
      print(consistency_acx.acx_resv_min10.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.condi = testData1;
      print(consistency_acx.acx_resv_min10.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.condi = testData2;
      print(consistency_acx.acx_resv_min10.condi);
      expect(consistency_acx.acx_resv_min10.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.condi = defalut;
      print(consistency_acx.acx_resv_min10.condi);
      expect(consistency_acx.acx_resv_min10.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00314_element_check_00291 **********\n\n");
    });

    test('00315_element_check_00292', () async {
      print("\n********** テスト実行：00315_element_check_00292 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.typ;
      print(consistency_acx.acx_resv_min10.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.typ = testData1;
      print(consistency_acx.acx_resv_min10.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.typ = testData2;
      print(consistency_acx.acx_resv_min10.typ);
      expect(consistency_acx.acx_resv_min10.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.typ = defalut;
      print(consistency_acx.acx_resv_min10.typ);
      expect(consistency_acx.acx_resv_min10.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00315_element_check_00292 **********\n\n");
    });

    test('00316_element_check_00293', () async {
      print("\n********** テスト実行：00316_element_check_00293 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.ini_typ;
      print(consistency_acx.acx_resv_min10.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.ini_typ = testData1;
      print(consistency_acx.acx_resv_min10.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.ini_typ = testData2;
      print(consistency_acx.acx_resv_min10.ini_typ);
      expect(consistency_acx.acx_resv_min10.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.ini_typ = defalut;
      print(consistency_acx.acx_resv_min10.ini_typ);
      expect(consistency_acx.acx_resv_min10.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00316_element_check_00293 **********\n\n");
    });

    test('00317_element_check_00294', () async {
      print("\n********** テスト実行：00317_element_check_00294 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.file;
      print(consistency_acx.acx_resv_min10.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.file = testData1s;
      print(consistency_acx.acx_resv_min10.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.file = testData2s;
      print(consistency_acx.acx_resv_min10.file);
      expect(consistency_acx.acx_resv_min10.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.file = defalut;
      print(consistency_acx.acx_resv_min10.file);
      expect(consistency_acx.acx_resv_min10.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00317_element_check_00294 **********\n\n");
    });

    test('00318_element_check_00295', () async {
      print("\n********** テスト実行：00318_element_check_00295 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.section;
      print(consistency_acx.acx_resv_min10.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.section = testData1s;
      print(consistency_acx.acx_resv_min10.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.section = testData2s;
      print(consistency_acx.acx_resv_min10.section);
      expect(consistency_acx.acx_resv_min10.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.section = defalut;
      print(consistency_acx.acx_resv_min10.section);
      expect(consistency_acx.acx_resv_min10.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00318_element_check_00295 **********\n\n");
    });

    test('00319_element_check_00296', () async {
      print("\n********** テスト実行：00319_element_check_00296 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min10.keyword;
      print(consistency_acx.acx_resv_min10.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min10.keyword = testData1s;
      print(consistency_acx.acx_resv_min10.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min10.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min10.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min10.keyword = testData2s;
      print(consistency_acx.acx_resv_min10.keyword);
      expect(consistency_acx.acx_resv_min10.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min10.keyword = defalut;
      print(consistency_acx.acx_resv_min10.keyword);
      expect(consistency_acx.acx_resv_min10.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min10.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00319_element_check_00296 **********\n\n");
    });

    test('00320_element_check_00297', () async {
      print("\n********** テスト実行：00320_element_check_00297 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.title;
      print(consistency_acx.acx_resv_min5.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.title = testData1s;
      print(consistency_acx.acx_resv_min5.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.title = testData2s;
      print(consistency_acx.acx_resv_min5.title);
      expect(consistency_acx.acx_resv_min5.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.title = defalut;
      print(consistency_acx.acx_resv_min5.title);
      expect(consistency_acx.acx_resv_min5.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00320_element_check_00297 **********\n\n");
    });

    test('00321_element_check_00298', () async {
      print("\n********** テスト実行：00321_element_check_00298 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.obj;
      print(consistency_acx.acx_resv_min5.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.obj = testData1;
      print(consistency_acx.acx_resv_min5.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.obj = testData2;
      print(consistency_acx.acx_resv_min5.obj);
      expect(consistency_acx.acx_resv_min5.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.obj = defalut;
      print(consistency_acx.acx_resv_min5.obj);
      expect(consistency_acx.acx_resv_min5.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00321_element_check_00298 **********\n\n");
    });

    test('00322_element_check_00299', () async {
      print("\n********** テスト実行：00322_element_check_00299 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.condi;
      print(consistency_acx.acx_resv_min5.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.condi = testData1;
      print(consistency_acx.acx_resv_min5.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.condi = testData2;
      print(consistency_acx.acx_resv_min5.condi);
      expect(consistency_acx.acx_resv_min5.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.condi = defalut;
      print(consistency_acx.acx_resv_min5.condi);
      expect(consistency_acx.acx_resv_min5.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00322_element_check_00299 **********\n\n");
    });

    test('00323_element_check_00300', () async {
      print("\n********** テスト実行：00323_element_check_00300 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.typ;
      print(consistency_acx.acx_resv_min5.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.typ = testData1;
      print(consistency_acx.acx_resv_min5.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.typ = testData2;
      print(consistency_acx.acx_resv_min5.typ);
      expect(consistency_acx.acx_resv_min5.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.typ = defalut;
      print(consistency_acx.acx_resv_min5.typ);
      expect(consistency_acx.acx_resv_min5.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00323_element_check_00300 **********\n\n");
    });

    test('00324_element_check_00301', () async {
      print("\n********** テスト実行：00324_element_check_00301 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.ini_typ;
      print(consistency_acx.acx_resv_min5.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.ini_typ = testData1;
      print(consistency_acx.acx_resv_min5.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.ini_typ = testData2;
      print(consistency_acx.acx_resv_min5.ini_typ);
      expect(consistency_acx.acx_resv_min5.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.ini_typ = defalut;
      print(consistency_acx.acx_resv_min5.ini_typ);
      expect(consistency_acx.acx_resv_min5.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00324_element_check_00301 **********\n\n");
    });

    test('00325_element_check_00302', () async {
      print("\n********** テスト実行：00325_element_check_00302 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.file;
      print(consistency_acx.acx_resv_min5.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.file = testData1s;
      print(consistency_acx.acx_resv_min5.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.file = testData2s;
      print(consistency_acx.acx_resv_min5.file);
      expect(consistency_acx.acx_resv_min5.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.file = defalut;
      print(consistency_acx.acx_resv_min5.file);
      expect(consistency_acx.acx_resv_min5.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00325_element_check_00302 **********\n\n");
    });

    test('00326_element_check_00303', () async {
      print("\n********** テスト実行：00326_element_check_00303 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.section;
      print(consistency_acx.acx_resv_min5.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.section = testData1s;
      print(consistency_acx.acx_resv_min5.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.section = testData2s;
      print(consistency_acx.acx_resv_min5.section);
      expect(consistency_acx.acx_resv_min5.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.section = defalut;
      print(consistency_acx.acx_resv_min5.section);
      expect(consistency_acx.acx_resv_min5.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00326_element_check_00303 **********\n\n");
    });

    test('00327_element_check_00304', () async {
      print("\n********** テスト実行：00327_element_check_00304 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min5.keyword;
      print(consistency_acx.acx_resv_min5.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min5.keyword = testData1s;
      print(consistency_acx.acx_resv_min5.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min5.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min5.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min5.keyword = testData2s;
      print(consistency_acx.acx_resv_min5.keyword);
      expect(consistency_acx.acx_resv_min5.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min5.keyword = defalut;
      print(consistency_acx.acx_resv_min5.keyword);
      expect(consistency_acx.acx_resv_min5.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min5.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00327_element_check_00304 **********\n\n");
    });

    test('00328_element_check_00305', () async {
      print("\n********** テスト実行：00328_element_check_00305 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.title;
      print(consistency_acx.acx_resv_min1.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.title = testData1s;
      print(consistency_acx.acx_resv_min1.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.title = testData2s;
      print(consistency_acx.acx_resv_min1.title);
      expect(consistency_acx.acx_resv_min1.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.title = defalut;
      print(consistency_acx.acx_resv_min1.title);
      expect(consistency_acx.acx_resv_min1.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00328_element_check_00305 **********\n\n");
    });

    test('00329_element_check_00306', () async {
      print("\n********** テスト実行：00329_element_check_00306 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.obj;
      print(consistency_acx.acx_resv_min1.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.obj = testData1;
      print(consistency_acx.acx_resv_min1.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.obj = testData2;
      print(consistency_acx.acx_resv_min1.obj);
      expect(consistency_acx.acx_resv_min1.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.obj = defalut;
      print(consistency_acx.acx_resv_min1.obj);
      expect(consistency_acx.acx_resv_min1.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00329_element_check_00306 **********\n\n");
    });

    test('00330_element_check_00307', () async {
      print("\n********** テスト実行：00330_element_check_00307 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.condi;
      print(consistency_acx.acx_resv_min1.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.condi = testData1;
      print(consistency_acx.acx_resv_min1.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.condi = testData2;
      print(consistency_acx.acx_resv_min1.condi);
      expect(consistency_acx.acx_resv_min1.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.condi = defalut;
      print(consistency_acx.acx_resv_min1.condi);
      expect(consistency_acx.acx_resv_min1.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00330_element_check_00307 **********\n\n");
    });

    test('00331_element_check_00308', () async {
      print("\n********** テスト実行：00331_element_check_00308 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.typ;
      print(consistency_acx.acx_resv_min1.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.typ = testData1;
      print(consistency_acx.acx_resv_min1.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.typ = testData2;
      print(consistency_acx.acx_resv_min1.typ);
      expect(consistency_acx.acx_resv_min1.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.typ = defalut;
      print(consistency_acx.acx_resv_min1.typ);
      expect(consistency_acx.acx_resv_min1.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00331_element_check_00308 **********\n\n");
    });

    test('00332_element_check_00309', () async {
      print("\n********** テスト実行：00332_element_check_00309 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.ini_typ;
      print(consistency_acx.acx_resv_min1.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.ini_typ = testData1;
      print(consistency_acx.acx_resv_min1.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.ini_typ = testData2;
      print(consistency_acx.acx_resv_min1.ini_typ);
      expect(consistency_acx.acx_resv_min1.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.ini_typ = defalut;
      print(consistency_acx.acx_resv_min1.ini_typ);
      expect(consistency_acx.acx_resv_min1.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00332_element_check_00309 **********\n\n");
    });

    test('00333_element_check_00310', () async {
      print("\n********** テスト実行：00333_element_check_00310 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.file;
      print(consistency_acx.acx_resv_min1.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.file = testData1s;
      print(consistency_acx.acx_resv_min1.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.file = testData2s;
      print(consistency_acx.acx_resv_min1.file);
      expect(consistency_acx.acx_resv_min1.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.file = defalut;
      print(consistency_acx.acx_resv_min1.file);
      expect(consistency_acx.acx_resv_min1.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00333_element_check_00310 **********\n\n");
    });

    test('00334_element_check_00311', () async {
      print("\n********** テスト実行：00334_element_check_00311 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.section;
      print(consistency_acx.acx_resv_min1.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.section = testData1s;
      print(consistency_acx.acx_resv_min1.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.section = testData2s;
      print(consistency_acx.acx_resv_min1.section);
      expect(consistency_acx.acx_resv_min1.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.section = defalut;
      print(consistency_acx.acx_resv_min1.section);
      expect(consistency_acx.acx_resv_min1.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00334_element_check_00311 **********\n\n");
    });

    test('00335_element_check_00312', () async {
      print("\n********** テスト実行：00335_element_check_00312 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acx_resv_min1.keyword;
      print(consistency_acx.acx_resv_min1.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acx_resv_min1.keyword = testData1s;
      print(consistency_acx.acx_resv_min1.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acx_resv_min1.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acx_resv_min1.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acx_resv_min1.keyword = testData2s;
      print(consistency_acx.acx_resv_min1.keyword);
      expect(consistency_acx.acx_resv_min1.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acx_resv_min1.keyword = defalut;
      print(consistency_acx.acx_resv_min1.keyword);
      expect(consistency_acx.acx_resv_min1.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acx_resv_min1.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00335_element_check_00312 **********\n\n");
    });

    test('00336_element_check_00313', () async {
      print("\n********** テスト実行：00336_element_check_00313 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.title;
      print(consistency_acx.acb50_ssw13_0.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.title = testData1s;
      print(consistency_acx.acb50_ssw13_0.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.title = testData2s;
      print(consistency_acx.acb50_ssw13_0.title);
      expect(consistency_acx.acb50_ssw13_0.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.title = defalut;
      print(consistency_acx.acb50_ssw13_0.title);
      expect(consistency_acx.acb50_ssw13_0.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00336_element_check_00313 **********\n\n");
    });

    test('00337_element_check_00314', () async {
      print("\n********** テスト実行：00337_element_check_00314 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.obj;
      print(consistency_acx.acb50_ssw13_0.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.obj = testData1;
      print(consistency_acx.acb50_ssw13_0.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.obj = testData2;
      print(consistency_acx.acb50_ssw13_0.obj);
      expect(consistency_acx.acb50_ssw13_0.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.obj = defalut;
      print(consistency_acx.acb50_ssw13_0.obj);
      expect(consistency_acx.acb50_ssw13_0.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00337_element_check_00314 **********\n\n");
    });

    test('00338_element_check_00315', () async {
      print("\n********** テスト実行：00338_element_check_00315 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.condi;
      print(consistency_acx.acb50_ssw13_0.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.condi = testData1;
      print(consistency_acx.acb50_ssw13_0.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.condi = testData2;
      print(consistency_acx.acb50_ssw13_0.condi);
      expect(consistency_acx.acb50_ssw13_0.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.condi = defalut;
      print(consistency_acx.acb50_ssw13_0.condi);
      expect(consistency_acx.acb50_ssw13_0.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00338_element_check_00315 **********\n\n");
    });

    test('00339_element_check_00316', () async {
      print("\n********** テスト実行：00339_element_check_00316 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.typ;
      print(consistency_acx.acb50_ssw13_0.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.typ = testData1;
      print(consistency_acx.acb50_ssw13_0.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.typ = testData2;
      print(consistency_acx.acb50_ssw13_0.typ);
      expect(consistency_acx.acb50_ssw13_0.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.typ = defalut;
      print(consistency_acx.acb50_ssw13_0.typ);
      expect(consistency_acx.acb50_ssw13_0.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00339_element_check_00316 **********\n\n");
    });

    test('00340_element_check_00317', () async {
      print("\n********** テスト実行：00340_element_check_00317 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.ini_typ;
      print(consistency_acx.acb50_ssw13_0.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.ini_typ = testData1;
      print(consistency_acx.acb50_ssw13_0.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.ini_typ = testData2;
      print(consistency_acx.acb50_ssw13_0.ini_typ);
      expect(consistency_acx.acb50_ssw13_0.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.ini_typ = defalut;
      print(consistency_acx.acb50_ssw13_0.ini_typ);
      expect(consistency_acx.acb50_ssw13_0.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00340_element_check_00317 **********\n\n");
    });

    test('00341_element_check_00318', () async {
      print("\n********** テスト実行：00341_element_check_00318 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.file;
      print(consistency_acx.acb50_ssw13_0.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.file = testData1s;
      print(consistency_acx.acb50_ssw13_0.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.file = testData2s;
      print(consistency_acx.acb50_ssw13_0.file);
      expect(consistency_acx.acb50_ssw13_0.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.file = defalut;
      print(consistency_acx.acb50_ssw13_0.file);
      expect(consistency_acx.acb50_ssw13_0.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00341_element_check_00318 **********\n\n");
    });

    test('00342_element_check_00319', () async {
      print("\n********** テスト実行：00342_element_check_00319 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.section;
      print(consistency_acx.acb50_ssw13_0.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.section = testData1s;
      print(consistency_acx.acb50_ssw13_0.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.section = testData2s;
      print(consistency_acx.acb50_ssw13_0.section);
      expect(consistency_acx.acb50_ssw13_0.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.section = defalut;
      print(consistency_acx.acb50_ssw13_0.section);
      expect(consistency_acx.acb50_ssw13_0.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00342_element_check_00319 **********\n\n");
    });

    test('00343_element_check_00320', () async {
      print("\n********** テスト実行：00343_element_check_00320 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_0.keyword;
      print(consistency_acx.acb50_ssw13_0.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_0.keyword = testData1s;
      print(consistency_acx.acb50_ssw13_0.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_0.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_0.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_0.keyword = testData2s;
      print(consistency_acx.acb50_ssw13_0.keyword);
      expect(consistency_acx.acb50_ssw13_0.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_0.keyword = defalut;
      print(consistency_acx.acb50_ssw13_0.keyword);
      expect(consistency_acx.acb50_ssw13_0.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_0.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00343_element_check_00320 **********\n\n");
    });

    test('00344_element_check_00321', () async {
      print("\n********** テスト実行：00344_element_check_00321 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.title;
      print(consistency_acx.acb50_ssw13_1_2.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.title = testData1s;
      print(consistency_acx.acb50_ssw13_1_2.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.title = testData2s;
      print(consistency_acx.acb50_ssw13_1_2.title);
      expect(consistency_acx.acb50_ssw13_1_2.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.title = defalut;
      print(consistency_acx.acb50_ssw13_1_2.title);
      expect(consistency_acx.acb50_ssw13_1_2.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00344_element_check_00321 **********\n\n");
    });

    test('00345_element_check_00322', () async {
      print("\n********** テスト実行：00345_element_check_00322 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.obj;
      print(consistency_acx.acb50_ssw13_1_2.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.obj = testData1;
      print(consistency_acx.acb50_ssw13_1_2.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.obj = testData2;
      print(consistency_acx.acb50_ssw13_1_2.obj);
      expect(consistency_acx.acb50_ssw13_1_2.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.obj = defalut;
      print(consistency_acx.acb50_ssw13_1_2.obj);
      expect(consistency_acx.acb50_ssw13_1_2.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00345_element_check_00322 **********\n\n");
    });

    test('00346_element_check_00323', () async {
      print("\n********** テスト実行：00346_element_check_00323 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.condi;
      print(consistency_acx.acb50_ssw13_1_2.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.condi = testData1;
      print(consistency_acx.acb50_ssw13_1_2.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.condi = testData2;
      print(consistency_acx.acb50_ssw13_1_2.condi);
      expect(consistency_acx.acb50_ssw13_1_2.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.condi = defalut;
      print(consistency_acx.acb50_ssw13_1_2.condi);
      expect(consistency_acx.acb50_ssw13_1_2.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00346_element_check_00323 **********\n\n");
    });

    test('00347_element_check_00324', () async {
      print("\n********** テスト実行：00347_element_check_00324 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.typ;
      print(consistency_acx.acb50_ssw13_1_2.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.typ = testData1;
      print(consistency_acx.acb50_ssw13_1_2.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.typ = testData2;
      print(consistency_acx.acb50_ssw13_1_2.typ);
      expect(consistency_acx.acb50_ssw13_1_2.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.typ = defalut;
      print(consistency_acx.acb50_ssw13_1_2.typ);
      expect(consistency_acx.acb50_ssw13_1_2.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00347_element_check_00324 **********\n\n");
    });

    test('00348_element_check_00325', () async {
      print("\n********** テスト実行：00348_element_check_00325 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.ini_typ;
      print(consistency_acx.acb50_ssw13_1_2.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.ini_typ = testData1;
      print(consistency_acx.acb50_ssw13_1_2.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.ini_typ = testData2;
      print(consistency_acx.acb50_ssw13_1_2.ini_typ);
      expect(consistency_acx.acb50_ssw13_1_2.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.ini_typ = defalut;
      print(consistency_acx.acb50_ssw13_1_2.ini_typ);
      expect(consistency_acx.acb50_ssw13_1_2.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00348_element_check_00325 **********\n\n");
    });

    test('00349_element_check_00326', () async {
      print("\n********** テスト実行：00349_element_check_00326 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.file;
      print(consistency_acx.acb50_ssw13_1_2.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.file = testData1s;
      print(consistency_acx.acb50_ssw13_1_2.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.file = testData2s;
      print(consistency_acx.acb50_ssw13_1_2.file);
      expect(consistency_acx.acb50_ssw13_1_2.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.file = defalut;
      print(consistency_acx.acb50_ssw13_1_2.file);
      expect(consistency_acx.acb50_ssw13_1_2.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00349_element_check_00326 **********\n\n");
    });

    test('00350_element_check_00327', () async {
      print("\n********** テスト実行：00350_element_check_00327 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.section;
      print(consistency_acx.acb50_ssw13_1_2.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.section = testData1s;
      print(consistency_acx.acb50_ssw13_1_2.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.section = testData2s;
      print(consistency_acx.acb50_ssw13_1_2.section);
      expect(consistency_acx.acb50_ssw13_1_2.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.section = defalut;
      print(consistency_acx.acb50_ssw13_1_2.section);
      expect(consistency_acx.acb50_ssw13_1_2.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00350_element_check_00327 **********\n\n");
    });

    test('00351_element_check_00328', () async {
      print("\n********** テスト実行：00351_element_check_00328 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_1_2.keyword;
      print(consistency_acx.acb50_ssw13_1_2.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_1_2.keyword = testData1s;
      print(consistency_acx.acb50_ssw13_1_2.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_1_2.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_1_2.keyword = testData2s;
      print(consistency_acx.acb50_ssw13_1_2.keyword);
      expect(consistency_acx.acb50_ssw13_1_2.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_1_2.keyword = defalut;
      print(consistency_acx.acb50_ssw13_1_2.keyword);
      expect(consistency_acx.acb50_ssw13_1_2.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_1_2.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00351_element_check_00328 **********\n\n");
    });

    test('00352_element_check_00329', () async {
      print("\n********** テスト実行：00352_element_check_00329 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.title;
      print(consistency_acx.acb50_ssw13_3_4.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.title = testData1s;
      print(consistency_acx.acb50_ssw13_3_4.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.title = testData2s;
      print(consistency_acx.acb50_ssw13_3_4.title);
      expect(consistency_acx.acb50_ssw13_3_4.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.title = defalut;
      print(consistency_acx.acb50_ssw13_3_4.title);
      expect(consistency_acx.acb50_ssw13_3_4.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00352_element_check_00329 **********\n\n");
    });

    test('00353_element_check_00330', () async {
      print("\n********** テスト実行：00353_element_check_00330 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.obj;
      print(consistency_acx.acb50_ssw13_3_4.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.obj = testData1;
      print(consistency_acx.acb50_ssw13_3_4.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.obj = testData2;
      print(consistency_acx.acb50_ssw13_3_4.obj);
      expect(consistency_acx.acb50_ssw13_3_4.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.obj = defalut;
      print(consistency_acx.acb50_ssw13_3_4.obj);
      expect(consistency_acx.acb50_ssw13_3_4.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00353_element_check_00330 **********\n\n");
    });

    test('00354_element_check_00331', () async {
      print("\n********** テスト実行：00354_element_check_00331 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.condi;
      print(consistency_acx.acb50_ssw13_3_4.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.condi = testData1;
      print(consistency_acx.acb50_ssw13_3_4.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.condi = testData2;
      print(consistency_acx.acb50_ssw13_3_4.condi);
      expect(consistency_acx.acb50_ssw13_3_4.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.condi = defalut;
      print(consistency_acx.acb50_ssw13_3_4.condi);
      expect(consistency_acx.acb50_ssw13_3_4.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00354_element_check_00331 **********\n\n");
    });

    test('00355_element_check_00332', () async {
      print("\n********** テスト実行：00355_element_check_00332 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.typ;
      print(consistency_acx.acb50_ssw13_3_4.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.typ = testData1;
      print(consistency_acx.acb50_ssw13_3_4.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.typ = testData2;
      print(consistency_acx.acb50_ssw13_3_4.typ);
      expect(consistency_acx.acb50_ssw13_3_4.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.typ = defalut;
      print(consistency_acx.acb50_ssw13_3_4.typ);
      expect(consistency_acx.acb50_ssw13_3_4.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00355_element_check_00332 **********\n\n");
    });

    test('00356_element_check_00333', () async {
      print("\n********** テスト実行：00356_element_check_00333 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.ini_typ;
      print(consistency_acx.acb50_ssw13_3_4.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.ini_typ = testData1;
      print(consistency_acx.acb50_ssw13_3_4.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.ini_typ = testData2;
      print(consistency_acx.acb50_ssw13_3_4.ini_typ);
      expect(consistency_acx.acb50_ssw13_3_4.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.ini_typ = defalut;
      print(consistency_acx.acb50_ssw13_3_4.ini_typ);
      expect(consistency_acx.acb50_ssw13_3_4.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00356_element_check_00333 **********\n\n");
    });

    test('00357_element_check_00334', () async {
      print("\n********** テスト実行：00357_element_check_00334 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.file;
      print(consistency_acx.acb50_ssw13_3_4.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.file = testData1s;
      print(consistency_acx.acb50_ssw13_3_4.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.file = testData2s;
      print(consistency_acx.acb50_ssw13_3_4.file);
      expect(consistency_acx.acb50_ssw13_3_4.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.file = defalut;
      print(consistency_acx.acb50_ssw13_3_4.file);
      expect(consistency_acx.acb50_ssw13_3_4.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00357_element_check_00334 **********\n\n");
    });

    test('00358_element_check_00335', () async {
      print("\n********** テスト実行：00358_element_check_00335 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.section;
      print(consistency_acx.acb50_ssw13_3_4.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.section = testData1s;
      print(consistency_acx.acb50_ssw13_3_4.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.section = testData2s;
      print(consistency_acx.acb50_ssw13_3_4.section);
      expect(consistency_acx.acb50_ssw13_3_4.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.section = defalut;
      print(consistency_acx.acb50_ssw13_3_4.section);
      expect(consistency_acx.acb50_ssw13_3_4.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00358_element_check_00335 **********\n\n");
    });

    test('00359_element_check_00336', () async {
      print("\n********** テスト実行：00359_element_check_00336 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_3_4.keyword;
      print(consistency_acx.acb50_ssw13_3_4.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_3_4.keyword = testData1s;
      print(consistency_acx.acb50_ssw13_3_4.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_3_4.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_3_4.keyword = testData2s;
      print(consistency_acx.acb50_ssw13_3_4.keyword);
      expect(consistency_acx.acb50_ssw13_3_4.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_3_4.keyword = defalut;
      print(consistency_acx.acb50_ssw13_3_4.keyword);
      expect(consistency_acx.acb50_ssw13_3_4.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_3_4.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00359_element_check_00336 **********\n\n");
    });

    test('00360_element_check_00337', () async {
      print("\n********** テスト実行：00360_element_check_00337 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.title;
      print(consistency_acx.acb50_ssw13_5.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.title = testData1s;
      print(consistency_acx.acb50_ssw13_5.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.title = testData2s;
      print(consistency_acx.acb50_ssw13_5.title);
      expect(consistency_acx.acb50_ssw13_5.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.title = defalut;
      print(consistency_acx.acb50_ssw13_5.title);
      expect(consistency_acx.acb50_ssw13_5.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00360_element_check_00337 **********\n\n");
    });

    test('00361_element_check_00338', () async {
      print("\n********** テスト実行：00361_element_check_00338 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.obj;
      print(consistency_acx.acb50_ssw13_5.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.obj = testData1;
      print(consistency_acx.acb50_ssw13_5.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.obj = testData2;
      print(consistency_acx.acb50_ssw13_5.obj);
      expect(consistency_acx.acb50_ssw13_5.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.obj = defalut;
      print(consistency_acx.acb50_ssw13_5.obj);
      expect(consistency_acx.acb50_ssw13_5.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00361_element_check_00338 **********\n\n");
    });

    test('00362_element_check_00339', () async {
      print("\n********** テスト実行：00362_element_check_00339 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.condi;
      print(consistency_acx.acb50_ssw13_5.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.condi = testData1;
      print(consistency_acx.acb50_ssw13_5.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.condi = testData2;
      print(consistency_acx.acb50_ssw13_5.condi);
      expect(consistency_acx.acb50_ssw13_5.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.condi = defalut;
      print(consistency_acx.acb50_ssw13_5.condi);
      expect(consistency_acx.acb50_ssw13_5.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00362_element_check_00339 **********\n\n");
    });

    test('00363_element_check_00340', () async {
      print("\n********** テスト実行：00363_element_check_00340 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.typ;
      print(consistency_acx.acb50_ssw13_5.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.typ = testData1;
      print(consistency_acx.acb50_ssw13_5.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.typ = testData2;
      print(consistency_acx.acb50_ssw13_5.typ);
      expect(consistency_acx.acb50_ssw13_5.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.typ = defalut;
      print(consistency_acx.acb50_ssw13_5.typ);
      expect(consistency_acx.acb50_ssw13_5.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00363_element_check_00340 **********\n\n");
    });

    test('00364_element_check_00341', () async {
      print("\n********** テスト実行：00364_element_check_00341 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.ini_typ;
      print(consistency_acx.acb50_ssw13_5.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.ini_typ = testData1;
      print(consistency_acx.acb50_ssw13_5.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.ini_typ = testData2;
      print(consistency_acx.acb50_ssw13_5.ini_typ);
      expect(consistency_acx.acb50_ssw13_5.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.ini_typ = defalut;
      print(consistency_acx.acb50_ssw13_5.ini_typ);
      expect(consistency_acx.acb50_ssw13_5.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00364_element_check_00341 **********\n\n");
    });

    test('00365_element_check_00342', () async {
      print("\n********** テスト実行：00365_element_check_00342 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.file;
      print(consistency_acx.acb50_ssw13_5.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.file = testData1s;
      print(consistency_acx.acb50_ssw13_5.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.file = testData2s;
      print(consistency_acx.acb50_ssw13_5.file);
      expect(consistency_acx.acb50_ssw13_5.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.file = defalut;
      print(consistency_acx.acb50_ssw13_5.file);
      expect(consistency_acx.acb50_ssw13_5.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00365_element_check_00342 **********\n\n");
    });

    test('00366_element_check_00343', () async {
      print("\n********** テスト実行：00366_element_check_00343 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.section;
      print(consistency_acx.acb50_ssw13_5.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.section = testData1s;
      print(consistency_acx.acb50_ssw13_5.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.section = testData2s;
      print(consistency_acx.acb50_ssw13_5.section);
      expect(consistency_acx.acb50_ssw13_5.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.section = defalut;
      print(consistency_acx.acb50_ssw13_5.section);
      expect(consistency_acx.acb50_ssw13_5.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00366_element_check_00343 **********\n\n");
    });

    test('00367_element_check_00344', () async {
      print("\n********** テスト実行：00367_element_check_00344 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_5.keyword;
      print(consistency_acx.acb50_ssw13_5.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_5.keyword = testData1s;
      print(consistency_acx.acb50_ssw13_5.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_5.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_5.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_5.keyword = testData2s;
      print(consistency_acx.acb50_ssw13_5.keyword);
      expect(consistency_acx.acb50_ssw13_5.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_5.keyword = defalut;
      print(consistency_acx.acb50_ssw13_5.keyword);
      expect(consistency_acx.acb50_ssw13_5.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_5.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00367_element_check_00344 **********\n\n");
    });

    test('00368_element_check_00345', () async {
      print("\n********** テスト実行：00368_element_check_00345 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.title;
      print(consistency_acx.acb50_ssw13_6.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.title = testData1s;
      print(consistency_acx.acb50_ssw13_6.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.title = testData2s;
      print(consistency_acx.acb50_ssw13_6.title);
      expect(consistency_acx.acb50_ssw13_6.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.title = defalut;
      print(consistency_acx.acb50_ssw13_6.title);
      expect(consistency_acx.acb50_ssw13_6.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00368_element_check_00345 **********\n\n");
    });

    test('00369_element_check_00346', () async {
      print("\n********** テスト実行：00369_element_check_00346 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.obj;
      print(consistency_acx.acb50_ssw13_6.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.obj = testData1;
      print(consistency_acx.acb50_ssw13_6.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.obj = testData2;
      print(consistency_acx.acb50_ssw13_6.obj);
      expect(consistency_acx.acb50_ssw13_6.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.obj = defalut;
      print(consistency_acx.acb50_ssw13_6.obj);
      expect(consistency_acx.acb50_ssw13_6.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00369_element_check_00346 **********\n\n");
    });

    test('00370_element_check_00347', () async {
      print("\n********** テスト実行：00370_element_check_00347 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.condi;
      print(consistency_acx.acb50_ssw13_6.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.condi = testData1;
      print(consistency_acx.acb50_ssw13_6.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.condi = testData2;
      print(consistency_acx.acb50_ssw13_6.condi);
      expect(consistency_acx.acb50_ssw13_6.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.condi = defalut;
      print(consistency_acx.acb50_ssw13_6.condi);
      expect(consistency_acx.acb50_ssw13_6.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00370_element_check_00347 **********\n\n");
    });

    test('00371_element_check_00348', () async {
      print("\n********** テスト実行：00371_element_check_00348 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.typ;
      print(consistency_acx.acb50_ssw13_6.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.typ = testData1;
      print(consistency_acx.acb50_ssw13_6.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.typ = testData2;
      print(consistency_acx.acb50_ssw13_6.typ);
      expect(consistency_acx.acb50_ssw13_6.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.typ = defalut;
      print(consistency_acx.acb50_ssw13_6.typ);
      expect(consistency_acx.acb50_ssw13_6.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00371_element_check_00348 **********\n\n");
    });

    test('00372_element_check_00349', () async {
      print("\n********** テスト実行：00372_element_check_00349 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.ini_typ;
      print(consistency_acx.acb50_ssw13_6.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.ini_typ = testData1;
      print(consistency_acx.acb50_ssw13_6.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.ini_typ = testData2;
      print(consistency_acx.acb50_ssw13_6.ini_typ);
      expect(consistency_acx.acb50_ssw13_6.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.ini_typ = defalut;
      print(consistency_acx.acb50_ssw13_6.ini_typ);
      expect(consistency_acx.acb50_ssw13_6.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00372_element_check_00349 **********\n\n");
    });

    test('00373_element_check_00350', () async {
      print("\n********** テスト実行：00373_element_check_00350 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.file;
      print(consistency_acx.acb50_ssw13_6.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.file = testData1s;
      print(consistency_acx.acb50_ssw13_6.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.file = testData2s;
      print(consistency_acx.acb50_ssw13_6.file);
      expect(consistency_acx.acb50_ssw13_6.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.file = defalut;
      print(consistency_acx.acb50_ssw13_6.file);
      expect(consistency_acx.acb50_ssw13_6.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00373_element_check_00350 **********\n\n");
    });

    test('00374_element_check_00351', () async {
      print("\n********** テスト実行：00374_element_check_00351 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.section;
      print(consistency_acx.acb50_ssw13_6.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.section = testData1s;
      print(consistency_acx.acb50_ssw13_6.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.section = testData2s;
      print(consistency_acx.acb50_ssw13_6.section);
      expect(consistency_acx.acb50_ssw13_6.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.section = defalut;
      print(consistency_acx.acb50_ssw13_6.section);
      expect(consistency_acx.acb50_ssw13_6.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00374_element_check_00351 **********\n\n");
    });

    test('00375_element_check_00352', () async {
      print("\n********** テスト実行：00375_element_check_00352 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.acb50_ssw13_6.keyword;
      print(consistency_acx.acb50_ssw13_6.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.acb50_ssw13_6.keyword = testData1s;
      print(consistency_acx.acb50_ssw13_6.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.acb50_ssw13_6.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.acb50_ssw13_6.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.acb50_ssw13_6.keyword = testData2s;
      print(consistency_acx.acb50_ssw13_6.keyword);
      expect(consistency_acx.acb50_ssw13_6.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.acb50_ssw13_6.keyword = defalut;
      print(consistency_acx.acb50_ssw13_6.keyword);
      expect(consistency_acx.acb50_ssw13_6.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.acb50_ssw13_6.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00375_element_check_00352 **********\n\n");
    });

    test('00376_element_check_00353', () async {
      print("\n********** テスト実行：00376_element_check_00353 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.title;
      print(consistency_acx.chgdrw_inout_tran.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.title = testData1s;
      print(consistency_acx.chgdrw_inout_tran.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.title = testData2s;
      print(consistency_acx.chgdrw_inout_tran.title);
      expect(consistency_acx.chgdrw_inout_tran.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.title = defalut;
      print(consistency_acx.chgdrw_inout_tran.title);
      expect(consistency_acx.chgdrw_inout_tran.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00376_element_check_00353 **********\n\n");
    });

    test('00377_element_check_00354', () async {
      print("\n********** テスト実行：00377_element_check_00354 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.obj;
      print(consistency_acx.chgdrw_inout_tran.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.obj = testData1;
      print(consistency_acx.chgdrw_inout_tran.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.obj = testData2;
      print(consistency_acx.chgdrw_inout_tran.obj);
      expect(consistency_acx.chgdrw_inout_tran.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.obj = defalut;
      print(consistency_acx.chgdrw_inout_tran.obj);
      expect(consistency_acx.chgdrw_inout_tran.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00377_element_check_00354 **********\n\n");
    });

    test('00378_element_check_00355', () async {
      print("\n********** テスト実行：00378_element_check_00355 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.condi;
      print(consistency_acx.chgdrw_inout_tran.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.condi = testData1;
      print(consistency_acx.chgdrw_inout_tran.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.condi = testData2;
      print(consistency_acx.chgdrw_inout_tran.condi);
      expect(consistency_acx.chgdrw_inout_tran.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.condi = defalut;
      print(consistency_acx.chgdrw_inout_tran.condi);
      expect(consistency_acx.chgdrw_inout_tran.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00378_element_check_00355 **********\n\n");
    });

    test('00379_element_check_00356', () async {
      print("\n********** テスト実行：00379_element_check_00356 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.typ;
      print(consistency_acx.chgdrw_inout_tran.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.typ = testData1;
      print(consistency_acx.chgdrw_inout_tran.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.typ = testData2;
      print(consistency_acx.chgdrw_inout_tran.typ);
      expect(consistency_acx.chgdrw_inout_tran.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.typ = defalut;
      print(consistency_acx.chgdrw_inout_tran.typ);
      expect(consistency_acx.chgdrw_inout_tran.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00379_element_check_00356 **********\n\n");
    });

    test('00380_element_check_00357', () async {
      print("\n********** テスト実行：00380_element_check_00357 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.ini_typ;
      print(consistency_acx.chgdrw_inout_tran.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.ini_typ = testData1;
      print(consistency_acx.chgdrw_inout_tran.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.ini_typ = testData2;
      print(consistency_acx.chgdrw_inout_tran.ini_typ);
      expect(consistency_acx.chgdrw_inout_tran.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.ini_typ = defalut;
      print(consistency_acx.chgdrw_inout_tran.ini_typ);
      expect(consistency_acx.chgdrw_inout_tran.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00380_element_check_00357 **********\n\n");
    });

    test('00381_element_check_00358', () async {
      print("\n********** テスト実行：00381_element_check_00358 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.file;
      print(consistency_acx.chgdrw_inout_tran.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.file = testData1s;
      print(consistency_acx.chgdrw_inout_tran.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.file = testData2s;
      print(consistency_acx.chgdrw_inout_tran.file);
      expect(consistency_acx.chgdrw_inout_tran.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.file = defalut;
      print(consistency_acx.chgdrw_inout_tran.file);
      expect(consistency_acx.chgdrw_inout_tran.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00381_element_check_00358 **********\n\n");
    });

    test('00382_element_check_00359', () async {
      print("\n********** テスト実行：00382_element_check_00359 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.section;
      print(consistency_acx.chgdrw_inout_tran.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.section = testData1s;
      print(consistency_acx.chgdrw_inout_tran.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.section = testData2s;
      print(consistency_acx.chgdrw_inout_tran.section);
      expect(consistency_acx.chgdrw_inout_tran.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.section = defalut;
      print(consistency_acx.chgdrw_inout_tran.section);
      expect(consistency_acx.chgdrw_inout_tran.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00382_element_check_00359 **********\n\n");
    });

    test('00383_element_check_00360', () async {
      print("\n********** テスト実行：00383_element_check_00360 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_inout_tran.keyword;
      print(consistency_acx.chgdrw_inout_tran.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_inout_tran.keyword = testData1s;
      print(consistency_acx.chgdrw_inout_tran.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_inout_tran.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_inout_tran.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_inout_tran.keyword = testData2s;
      print(consistency_acx.chgdrw_inout_tran.keyword);
      expect(consistency_acx.chgdrw_inout_tran.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_inout_tran.keyword = defalut;
      print(consistency_acx.chgdrw_inout_tran.keyword);
      expect(consistency_acx.chgdrw_inout_tran.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_inout_tran.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00383_element_check_00360 **********\n\n");
    });

    test('00384_element_check_00361', () async {
      print("\n********** テスト実行：00384_element_check_00361 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.title;
      print(consistency_acx.chgdrw_loan_tran.title);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.title = testData1s;
      print(consistency_acx.chgdrw_loan_tran.title);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.title == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.title == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.title = testData2s;
      print(consistency_acx.chgdrw_loan_tran.title);
      expect(consistency_acx.chgdrw_loan_tran.title == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.title == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.title = defalut;
      print(consistency_acx.chgdrw_loan_tran.title);
      expect(consistency_acx.chgdrw_loan_tran.title == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.title == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00384_element_check_00361 **********\n\n");
    });

    test('00385_element_check_00362', () async {
      print("\n********** テスト実行：00385_element_check_00362 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.obj;
      print(consistency_acx.chgdrw_loan_tran.obj);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.obj = testData1;
      print(consistency_acx.chgdrw_loan_tran.obj);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.obj == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.obj == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.obj = testData2;
      print(consistency_acx.chgdrw_loan_tran.obj);
      expect(consistency_acx.chgdrw_loan_tran.obj == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.obj == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.obj = defalut;
      print(consistency_acx.chgdrw_loan_tran.obj);
      expect(consistency_acx.chgdrw_loan_tran.obj == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.obj == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00385_element_check_00362 **********\n\n");
    });

    test('00386_element_check_00363', () async {
      print("\n********** テスト実行：00386_element_check_00363 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.condi;
      print(consistency_acx.chgdrw_loan_tran.condi);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.condi = testData1;
      print(consistency_acx.chgdrw_loan_tran.condi);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.condi == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.condi == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.condi = testData2;
      print(consistency_acx.chgdrw_loan_tran.condi);
      expect(consistency_acx.chgdrw_loan_tran.condi == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.condi == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.condi = defalut;
      print(consistency_acx.chgdrw_loan_tran.condi);
      expect(consistency_acx.chgdrw_loan_tran.condi == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.condi == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00386_element_check_00363 **********\n\n");
    });

    test('00387_element_check_00364', () async {
      print("\n********** テスト実行：00387_element_check_00364 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.typ;
      print(consistency_acx.chgdrw_loan_tran.typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.typ = testData1;
      print(consistency_acx.chgdrw_loan_tran.typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.typ = testData2;
      print(consistency_acx.chgdrw_loan_tran.typ);
      expect(consistency_acx.chgdrw_loan_tran.typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.typ = defalut;
      print(consistency_acx.chgdrw_loan_tran.typ);
      expect(consistency_acx.chgdrw_loan_tran.typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00387_element_check_00364 **********\n\n");
    });

    test('00388_element_check_00365', () async {
      print("\n********** テスト実行：00388_element_check_00365 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.ini_typ;
      print(consistency_acx.chgdrw_loan_tran.ini_typ);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.ini_typ = testData1;
      print(consistency_acx.chgdrw_loan_tran.ini_typ);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.ini_typ == testData1, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.ini_typ == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.ini_typ = testData2;
      print(consistency_acx.chgdrw_loan_tran.ini_typ);
      expect(consistency_acx.chgdrw_loan_tran.ini_typ == testData2, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.ini_typ == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.ini_typ = defalut;
      print(consistency_acx.chgdrw_loan_tran.ini_typ);
      expect(consistency_acx.chgdrw_loan_tran.ini_typ == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.ini_typ == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00388_element_check_00365 **********\n\n");
    });

    test('00389_element_check_00366', () async {
      print("\n********** テスト実行：00389_element_check_00366 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.file;
      print(consistency_acx.chgdrw_loan_tran.file);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.file = testData1s;
      print(consistency_acx.chgdrw_loan_tran.file);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.file == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.file == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.file = testData2s;
      print(consistency_acx.chgdrw_loan_tran.file);
      expect(consistency_acx.chgdrw_loan_tran.file == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.file == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.file = defalut;
      print(consistency_acx.chgdrw_loan_tran.file);
      expect(consistency_acx.chgdrw_loan_tran.file == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.file == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00389_element_check_00366 **********\n\n");
    });

    test('00390_element_check_00367', () async {
      print("\n********** テスト実行：00390_element_check_00367 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.section;
      print(consistency_acx.chgdrw_loan_tran.section);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.section = testData1s;
      print(consistency_acx.chgdrw_loan_tran.section);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.section == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.section == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.section = testData2s;
      print(consistency_acx.chgdrw_loan_tran.section);
      expect(consistency_acx.chgdrw_loan_tran.section == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.section == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.section = defalut;
      print(consistency_acx.chgdrw_loan_tran.section);
      expect(consistency_acx.chgdrw_loan_tran.section == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.section == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00390_element_check_00367 **********\n\n");
    });

    test('00391_element_check_00368', () async {
      print("\n********** テスト実行：00391_element_check_00368 **********");

      consistency_acx = Consistency_acxJsonFile();
      allPropatyCheckInit(consistency_acx);

      // ①loadを実行する。
      await consistency_acx.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = consistency_acx.chgdrw_loan_tran.keyword;
      print(consistency_acx.chgdrw_loan_tran.keyword);

      // ②指定したプロパティにテストデータ1を書き込む。
      consistency_acx.chgdrw_loan_tran.keyword = testData1s;
      print(consistency_acx.chgdrw_loan_tran.keyword);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(consistency_acx.chgdrw_loan_tran.keyword == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await consistency_acx.save();
      await consistency_acx.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(consistency_acx.chgdrw_loan_tran.keyword == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      consistency_acx.chgdrw_loan_tran.keyword = testData2s;
      print(consistency_acx.chgdrw_loan_tran.keyword);
      expect(consistency_acx.chgdrw_loan_tran.keyword == testData2s, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.keyword == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      consistency_acx.chgdrw_loan_tran.keyword = defalut;
      print(consistency_acx.chgdrw_loan_tran.keyword);
      expect(consistency_acx.chgdrw_loan_tran.keyword == defalut, true);
      await consistency_acx.save();
      await consistency_acx.load();
      expect(consistency_acx.chgdrw_loan_tran.keyword == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(consistency_acx, true);

      print("********** テスト終了：00391_element_check_00368 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Consistency_acxJsonFile test)
{
  expect(test.version.title, "");
  expect(test.version.obj, 0);
  expect(test.version.condi, 0);
  expect(test.version.typ, 0);
  expect(test.version.ini_typ, 0);
  expect(test.version.file, "");
  expect(test.version.section, "");
  expect(test.version.keyword, "");
  expect(test.acr_cnct.title, "");
  expect(test.acr_cnct.obj, 0);
  expect(test.acr_cnct.condi, 0);
  expect(test.acr_cnct.typ, 0);
  expect(test.acr_cnct.ini_typ, 0);
  expect(test.acr_cnct.file, "");
  expect(test.acr_cnct.section, "");
  expect(test.acr_cnct.keyword, "");
  expect(test.acb_deccin.title, "");
  expect(test.acb_deccin.obj, 0);
  expect(test.acb_deccin.condi, 0);
  expect(test.acb_deccin.typ, 0);
  expect(test.acb_deccin.ini_typ, 0);
  expect(test.acb_deccin.file, "");
  expect(test.acb_deccin.section, "");
  expect(test.acb_deccin.keyword, "");
  expect(test.acb_select.title, "");
  expect(test.acb_select.obj, 0);
  expect(test.acb_select.condi, 0);
  expect(test.acb_select.typ, 0);
  expect(test.acb_select.ini_typ, 0);
  expect(test.acb_select.file, "");
  expect(test.acb_select.section, "");
  expect(test.acb_select.keyword, "");
  expect(test.auto_deccin.title, "");
  expect(test.auto_deccin.obj, 0);
  expect(test.auto_deccin.condi, 0);
  expect(test.auto_deccin.typ, 0);
  expect(test.auto_deccin.ini_typ, 0);
  expect(test.auto_deccin.file, "");
  expect(test.auto_deccin.section, "");
  expect(test.auto_deccin.keyword, "");
  expect(test.acr50_ssw14_0.title, "");
  expect(test.acr50_ssw14_0.obj, 0);
  expect(test.acr50_ssw14_0.condi, 0);
  expect(test.acr50_ssw14_0.typ, 0);
  expect(test.acr50_ssw14_0.ini_typ, 0);
  expect(test.acr50_ssw14_0.file, "");
  expect(test.acr50_ssw14_0.section, "");
  expect(test.acr50_ssw14_0.keyword, "");
  expect(test.acr50_ssw14_1_2.title, "");
  expect(test.acr50_ssw14_1_2.obj, 0);
  expect(test.acr50_ssw14_1_2.condi, 0);
  expect(test.acr50_ssw14_1_2.typ, 0);
  expect(test.acr50_ssw14_1_2.ini_typ, 0);
  expect(test.acr50_ssw14_1_2.file, "");
  expect(test.acr50_ssw14_1_2.section, "");
  expect(test.acr50_ssw14_1_2.keyword, "");
  expect(test.acr50_ssw14_3_4.title, "");
  expect(test.acr50_ssw14_3_4.obj, 0);
  expect(test.acr50_ssw14_3_4.condi, 0);
  expect(test.acr50_ssw14_3_4.typ, 0);
  expect(test.acr50_ssw14_3_4.ini_typ, 0);
  expect(test.acr50_ssw14_3_4.file, "");
  expect(test.acr50_ssw14_3_4.section, "");
  expect(test.acr50_ssw14_3_4.keyword, "");
  expect(test.acr50_ssw14_5.title, "");
  expect(test.acr50_ssw14_5.obj, 0);
  expect(test.acr50_ssw14_5.condi, 0);
  expect(test.acr50_ssw14_5.typ, 0);
  expect(test.acr50_ssw14_5.ini_typ, 0);
  expect(test.acr50_ssw14_5.file, "");
  expect(test.acr50_ssw14_5.section, "");
  expect(test.acr50_ssw14_5.keyword, "");
  expect(test.acr50_ssw14_7.title, "");
  expect(test.acr50_ssw14_7.obj, 0);
  expect(test.acr50_ssw14_7.condi, 0);
  expect(test.acr50_ssw14_7.typ, 0);
  expect(test.acr50_ssw14_7.ini_typ, 0);
  expect(test.acr50_ssw14_7.file, "");
  expect(test.acr50_ssw14_7.section, "");
  expect(test.acr50_ssw14_7.keyword, "");
  expect(test.pick_end.title, "");
  expect(test.pick_end.obj, 0);
  expect(test.pick_end.condi, 0);
  expect(test.pick_end.typ, 0);
  expect(test.pick_end.ini_typ, 0);
  expect(test.pick_end.file, "");
  expect(test.pick_end.section, "");
  expect(test.pick_end.keyword, "");
  expect(test.acxreal_system.title, "");
  expect(test.acxreal_system.obj, 0);
  expect(test.acxreal_system.condi, 0);
  expect(test.acxreal_system.typ, 0);
  expect(test.acxreal_system.ini_typ, 0);
  expect(test.acxreal_system.file, "");
  expect(test.acxreal_system.section, "");
  expect(test.acxreal_system.keyword, "");
  expect(test.acxreal_interval.title, "");
  expect(test.acxreal_interval.obj, 0);
  expect(test.acxreal_interval.condi, 0);
  expect(test.acxreal_interval.typ, 0);
  expect(test.acxreal_interval.ini_typ, 0);
  expect(test.acxreal_interval.file, "");
  expect(test.acxreal_interval.section, "");
  expect(test.acxreal_interval.keyword, "");
  expect(test.ecs_pick_positn10000.title, "");
  expect(test.ecs_pick_positn10000.obj, 0);
  expect(test.ecs_pick_positn10000.condi, 0);
  expect(test.ecs_pick_positn10000.typ, 0);
  expect(test.ecs_pick_positn10000.ini_typ, 0);
  expect(test.ecs_pick_positn10000.file, "");
  expect(test.ecs_pick_positn10000.section, "");
  expect(test.ecs_pick_positn10000.keyword, "");
  expect(test.ecs_pick_positn5000.title, "");
  expect(test.ecs_pick_positn5000.obj, 0);
  expect(test.ecs_pick_positn5000.condi, 0);
  expect(test.ecs_pick_positn5000.typ, 0);
  expect(test.ecs_pick_positn5000.ini_typ, 0);
  expect(test.ecs_pick_positn5000.file, "");
  expect(test.ecs_pick_positn5000.section, "");
  expect(test.ecs_pick_positn5000.keyword, "");
  expect(test.ecs_pick_positn2000.title, "");
  expect(test.ecs_pick_positn2000.obj, 0);
  expect(test.ecs_pick_positn2000.condi, 0);
  expect(test.ecs_pick_positn2000.typ, 0);
  expect(test.ecs_pick_positn2000.ini_typ, 0);
  expect(test.ecs_pick_positn2000.file, "");
  expect(test.ecs_pick_positn2000.section, "");
  expect(test.ecs_pick_positn2000.keyword, "");
  expect(test.ecs_pick_positn1000.title, "");
  expect(test.ecs_pick_positn1000.obj, 0);
  expect(test.ecs_pick_positn1000.condi, 0);
  expect(test.ecs_pick_positn1000.typ, 0);
  expect(test.ecs_pick_positn1000.ini_typ, 0);
  expect(test.ecs_pick_positn1000.file, "");
  expect(test.ecs_pick_positn1000.section, "");
  expect(test.ecs_pick_positn1000.keyword, "");
  expect(test.acx_pick_data10000.title, "");
  expect(test.acx_pick_data10000.obj, 0);
  expect(test.acx_pick_data10000.condi, 0);
  expect(test.acx_pick_data10000.typ, 0);
  expect(test.acx_pick_data10000.ini_typ, 0);
  expect(test.acx_pick_data10000.file, "");
  expect(test.acx_pick_data10000.section, "");
  expect(test.acx_pick_data10000.keyword, "");
  expect(test.acx_pick_data5000.title, "");
  expect(test.acx_pick_data5000.obj, 0);
  expect(test.acx_pick_data5000.condi, 0);
  expect(test.acx_pick_data5000.typ, 0);
  expect(test.acx_pick_data5000.ini_typ, 0);
  expect(test.acx_pick_data5000.file, "");
  expect(test.acx_pick_data5000.section, "");
  expect(test.acx_pick_data5000.keyword, "");
  expect(test.acx_pick_data2000.title, "");
  expect(test.acx_pick_data2000.obj, 0);
  expect(test.acx_pick_data2000.condi, 0);
  expect(test.acx_pick_data2000.typ, 0);
  expect(test.acx_pick_data2000.ini_typ, 0);
  expect(test.acx_pick_data2000.file, "");
  expect(test.acx_pick_data2000.section, "");
  expect(test.acx_pick_data2000.keyword, "");
  expect(test.acx_pick_data1000.title, "");
  expect(test.acx_pick_data1000.obj, 0);
  expect(test.acx_pick_data1000.condi, 0);
  expect(test.acx_pick_data1000.typ, 0);
  expect(test.acx_pick_data1000.ini_typ, 0);
  expect(test.acx_pick_data1000.file, "");
  expect(test.acx_pick_data1000.section, "");
  expect(test.acx_pick_data1000.keyword, "");
  expect(test.acx_pick_data500.title, "");
  expect(test.acx_pick_data500.obj, 0);
  expect(test.acx_pick_data500.condi, 0);
  expect(test.acx_pick_data500.typ, 0);
  expect(test.acx_pick_data500.ini_typ, 0);
  expect(test.acx_pick_data500.file, "");
  expect(test.acx_pick_data500.section, "");
  expect(test.acx_pick_data500.keyword, "");
  expect(test.acx_pick_data100.title, "");
  expect(test.acx_pick_data100.obj, 0);
  expect(test.acx_pick_data100.condi, 0);
  expect(test.acx_pick_data100.typ, 0);
  expect(test.acx_pick_data100.ini_typ, 0);
  expect(test.acx_pick_data100.file, "");
  expect(test.acx_pick_data100.section, "");
  expect(test.acx_pick_data100.keyword, "");
  expect(test.acx_pick_data50.title, "");
  expect(test.acx_pick_data50.obj, 0);
  expect(test.acx_pick_data50.condi, 0);
  expect(test.acx_pick_data50.typ, 0);
  expect(test.acx_pick_data50.ini_typ, 0);
  expect(test.acx_pick_data50.file, "");
  expect(test.acx_pick_data50.section, "");
  expect(test.acx_pick_data50.keyword, "");
  expect(test.acx_pick_data10.title, "");
  expect(test.acx_pick_data10.obj, 0);
  expect(test.acx_pick_data10.condi, 0);
  expect(test.acx_pick_data10.typ, 0);
  expect(test.acx_pick_data10.ini_typ, 0);
  expect(test.acx_pick_data10.file, "");
  expect(test.acx_pick_data10.section, "");
  expect(test.acx_pick_data10.keyword, "");
  expect(test.acx_pick_data5.title, "");
  expect(test.acx_pick_data5.obj, 0);
  expect(test.acx_pick_data5.condi, 0);
  expect(test.acx_pick_data5.typ, 0);
  expect(test.acx_pick_data5.ini_typ, 0);
  expect(test.acx_pick_data5.file, "");
  expect(test.acx_pick_data5.section, "");
  expect(test.acx_pick_data5.keyword, "");
  expect(test.acx_pick_data1.title, "");
  expect(test.acx_pick_data1.obj, 0);
  expect(test.acx_pick_data1.condi, 0);
  expect(test.acx_pick_data1.typ, 0);
  expect(test.acx_pick_data1.ini_typ, 0);
  expect(test.acx_pick_data1.file, "");
  expect(test.acx_pick_data1.section, "");
  expect(test.acx_pick_data1.keyword, "");
  expect(test.ecs_recalc_reject.title, "");
  expect(test.ecs_recalc_reject.obj, 0);
  expect(test.ecs_recalc_reject.condi, 0);
  expect(test.ecs_recalc_reject.typ, 0);
  expect(test.ecs_recalc_reject.ini_typ, 0);
  expect(test.ecs_recalc_reject.file, "");
  expect(test.ecs_recalc_reject.section, "");
  expect(test.ecs_recalc_reject.keyword, "");
  expect(test.sst1_error_disp.title, "");
  expect(test.sst1_error_disp.obj, 0);
  expect(test.sst1_error_disp.condi, 0);
  expect(test.sst1_error_disp.typ, 0);
  expect(test.sst1_error_disp.ini_typ, 0);
  expect(test.sst1_error_disp.file, "");
  expect(test.sst1_error_disp.section, "");
  expect(test.sst1_error_disp.keyword, "");
  expect(test.sst1_cin_retry.title, "");
  expect(test.sst1_cin_retry.obj, 0);
  expect(test.sst1_cin_retry.condi, 0);
  expect(test.sst1_cin_retry.typ, 0);
  expect(test.sst1_cin_retry.ini_typ, 0);
  expect(test.sst1_cin_retry.file, "");
  expect(test.sst1_cin_retry.section, "");
  expect(test.sst1_cin_retry.keyword, "");
  expect(test.acx_resv_min5000.title, "");
  expect(test.acx_resv_min5000.obj, 0);
  expect(test.acx_resv_min5000.condi, 0);
  expect(test.acx_resv_min5000.typ, 0);
  expect(test.acx_resv_min5000.ini_typ, 0);
  expect(test.acx_resv_min5000.file, "");
  expect(test.acx_resv_min5000.section, "");
  expect(test.acx_resv_min5000.keyword, "");
  expect(test.acx_resv_min2000.title, "");
  expect(test.acx_resv_min2000.obj, 0);
  expect(test.acx_resv_min2000.condi, 0);
  expect(test.acx_resv_min2000.typ, 0);
  expect(test.acx_resv_min2000.ini_typ, 0);
  expect(test.acx_resv_min2000.file, "");
  expect(test.acx_resv_min2000.section, "");
  expect(test.acx_resv_min2000.keyword, "");
  expect(test.acx_resv_min1000.title, "");
  expect(test.acx_resv_min1000.obj, 0);
  expect(test.acx_resv_min1000.condi, 0);
  expect(test.acx_resv_min1000.typ, 0);
  expect(test.acx_resv_min1000.ini_typ, 0);
  expect(test.acx_resv_min1000.file, "");
  expect(test.acx_resv_min1000.section, "");
  expect(test.acx_resv_min1000.keyword, "");
  expect(test.acx_resv_min500.title, "");
  expect(test.acx_resv_min500.obj, 0);
  expect(test.acx_resv_min500.condi, 0);
  expect(test.acx_resv_min500.typ, 0);
  expect(test.acx_resv_min500.ini_typ, 0);
  expect(test.acx_resv_min500.file, "");
  expect(test.acx_resv_min500.section, "");
  expect(test.acx_resv_min500.keyword, "");
  expect(test.acx_resv_min100.title, "");
  expect(test.acx_resv_min100.obj, 0);
  expect(test.acx_resv_min100.condi, 0);
  expect(test.acx_resv_min100.typ, 0);
  expect(test.acx_resv_min100.ini_typ, 0);
  expect(test.acx_resv_min100.file, "");
  expect(test.acx_resv_min100.section, "");
  expect(test.acx_resv_min100.keyword, "");
  expect(test.acx_resv_min50.title, "");
  expect(test.acx_resv_min50.obj, 0);
  expect(test.acx_resv_min50.condi, 0);
  expect(test.acx_resv_min50.typ, 0);
  expect(test.acx_resv_min50.ini_typ, 0);
  expect(test.acx_resv_min50.file, "");
  expect(test.acx_resv_min50.section, "");
  expect(test.acx_resv_min50.keyword, "");
  expect(test.acx_resv_min10.title, "");
  expect(test.acx_resv_min10.obj, 0);
  expect(test.acx_resv_min10.condi, 0);
  expect(test.acx_resv_min10.typ, 0);
  expect(test.acx_resv_min10.ini_typ, 0);
  expect(test.acx_resv_min10.file, "");
  expect(test.acx_resv_min10.section, "");
  expect(test.acx_resv_min10.keyword, "");
  expect(test.acx_resv_min5.title, "");
  expect(test.acx_resv_min5.obj, 0);
  expect(test.acx_resv_min5.condi, 0);
  expect(test.acx_resv_min5.typ, 0);
  expect(test.acx_resv_min5.ini_typ, 0);
  expect(test.acx_resv_min5.file, "");
  expect(test.acx_resv_min5.section, "");
  expect(test.acx_resv_min5.keyword, "");
  expect(test.acx_resv_min1.title, "");
  expect(test.acx_resv_min1.obj, 0);
  expect(test.acx_resv_min1.condi, 0);
  expect(test.acx_resv_min1.typ, 0);
  expect(test.acx_resv_min1.ini_typ, 0);
  expect(test.acx_resv_min1.file, "");
  expect(test.acx_resv_min1.section, "");
  expect(test.acx_resv_min1.keyword, "");
  expect(test.acb50_ssw13_0.title, "");
  expect(test.acb50_ssw13_0.obj, 0);
  expect(test.acb50_ssw13_0.condi, 0);
  expect(test.acb50_ssw13_0.typ, 0);
  expect(test.acb50_ssw13_0.ini_typ, 0);
  expect(test.acb50_ssw13_0.file, "");
  expect(test.acb50_ssw13_0.section, "");
  expect(test.acb50_ssw13_0.keyword, "");
  expect(test.acb50_ssw13_1_2.title, "");
  expect(test.acb50_ssw13_1_2.obj, 0);
  expect(test.acb50_ssw13_1_2.condi, 0);
  expect(test.acb50_ssw13_1_2.typ, 0);
  expect(test.acb50_ssw13_1_2.ini_typ, 0);
  expect(test.acb50_ssw13_1_2.file, "");
  expect(test.acb50_ssw13_1_2.section, "");
  expect(test.acb50_ssw13_1_2.keyword, "");
  expect(test.acb50_ssw13_3_4.title, "");
  expect(test.acb50_ssw13_3_4.obj, 0);
  expect(test.acb50_ssw13_3_4.condi, 0);
  expect(test.acb50_ssw13_3_4.typ, 0);
  expect(test.acb50_ssw13_3_4.ini_typ, 0);
  expect(test.acb50_ssw13_3_4.file, "");
  expect(test.acb50_ssw13_3_4.section, "");
  expect(test.acb50_ssw13_3_4.keyword, "");
  expect(test.acb50_ssw13_5.title, "");
  expect(test.acb50_ssw13_5.obj, 0);
  expect(test.acb50_ssw13_5.condi, 0);
  expect(test.acb50_ssw13_5.typ, 0);
  expect(test.acb50_ssw13_5.ini_typ, 0);
  expect(test.acb50_ssw13_5.file, "");
  expect(test.acb50_ssw13_5.section, "");
  expect(test.acb50_ssw13_5.keyword, "");
  expect(test.acb50_ssw13_6.title, "");
  expect(test.acb50_ssw13_6.obj, 0);
  expect(test.acb50_ssw13_6.condi, 0);
  expect(test.acb50_ssw13_6.typ, 0);
  expect(test.acb50_ssw13_6.ini_typ, 0);
  expect(test.acb50_ssw13_6.file, "");
  expect(test.acb50_ssw13_6.section, "");
  expect(test.acb50_ssw13_6.keyword, "");
  expect(test.chgdrw_inout_tran.title, "");
  expect(test.chgdrw_inout_tran.obj, 0);
  expect(test.chgdrw_inout_tran.condi, 0);
  expect(test.chgdrw_inout_tran.typ, 0);
  expect(test.chgdrw_inout_tran.ini_typ, 0);
  expect(test.chgdrw_inout_tran.file, "");
  expect(test.chgdrw_inout_tran.section, "");
  expect(test.chgdrw_inout_tran.keyword, "");
  expect(test.chgdrw_loan_tran.title, "");
  expect(test.chgdrw_loan_tran.obj, 0);
  expect(test.chgdrw_loan_tran.condi, 0);
  expect(test.chgdrw_loan_tran.typ, 0);
  expect(test.chgdrw_loan_tran.ini_typ, 0);
  expect(test.chgdrw_loan_tran.file, "");
  expect(test.chgdrw_loan_tran.section, "");
  expect(test.chgdrw_loan_tran.keyword, "");
}

void allPropatyCheck(Consistency_acxJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.version.title, "バージョン");
  }
  expect(test.version.obj, 0);
  expect(test.version.condi, 0);
  expect(test.version.typ, 2);
  expect(test.version.ini_typ, 1);
  expect(test.version.file, "conf/version.json");
  expect(test.version.section, "apl");
  expect(test.version.keyword, "ver");
  expect(test.acr_cnct.title, "自動釣銭釣札機接続");
  expect(test.acr_cnct.obj, 0);
  expect(test.acr_cnct.condi, 0);
  expect(test.acr_cnct.typ, 2);
  expect(test.acr_cnct.ini_typ, 0);
  expect(test.acr_cnct.file, "conf/mac_info.json");
  expect(test.acr_cnct.section, "internal_flg");
  expect(test.acr_cnct.keyword, "acr_cnct");
  expect(test.acb_deccin.title, "釣銭釣札機接続時の入金確定処理");
  expect(test.acb_deccin.obj, 0);
  expect(test.acb_deccin.condi, 0);
  expect(test.acb_deccin.typ, 2);
  expect(test.acb_deccin.ini_typ, 0);
  expect(test.acb_deccin.file, "conf/mac_info.json");
  expect(test.acb_deccin.section, "internal_flg");
  expect(test.acb_deccin.keyword, "acb_deccin");
  expect(test.acb_select.title, "自動釣銭釣札機の種類");
  expect(test.acb_select.obj, 0);
  expect(test.acb_select.condi, 0);
  expect(test.acb_select.typ, 2);
  expect(test.acb_select.ini_typ, 0);
  expect(test.acb_select.file, "conf/mac_info.json");
  expect(test.acb_select.section, "internal_flg");
  expect(test.acb_select.keyword, "acb_select");
  expect(test.auto_deccin.title, "釣銭釣札機モード変更");
  expect(test.auto_deccin.obj, 0);
  expect(test.auto_deccin.condi, 0);
  expect(test.auto_deccin.typ, 2);
  expect(test.auto_deccin.ini_typ, 0);
  expect(test.auto_deccin.file, "conf/mac_info.json");
  expect(test.auto_deccin.section, "internal_flg");
  expect(test.auto_deccin.keyword, "auto_deccin");
  expect(test.acr50_ssw14_0.title, "待機中スタートボタン押下による補充処理開始");
  expect(test.acr50_ssw14_0.obj, 0);
  expect(test.acr50_ssw14_0.condi, 0);
  expect(test.acr50_ssw14_0.typ, 2);
  expect(test.acr50_ssw14_0.ini_typ, 0);
  expect(test.acr50_ssw14_0.file, "conf/mac_info.json");
  expect(test.acr50_ssw14_0.section, "acx_flg");
  expect(test.acr50_ssw14_0.keyword, "acr50_ssw14_0");
  expect(test.acr50_ssw14_1_2.title, "鍵位置オぺ時の表示内容");
  expect(test.acr50_ssw14_1_2.obj, 0);
  expect(test.acr50_ssw14_1_2.condi, 0);
  expect(test.acr50_ssw14_1_2.typ, 2);
  expect(test.acr50_ssw14_1_2.ini_typ, 0);
  expect(test.acr50_ssw14_1_2.file, "conf/mac_info.json");
  expect(test.acr50_ssw14_1_2.section, "acx_flg");
  expect(test.acr50_ssw14_1_2.keyword, "acr50_ssw14_1_2");
  expect(test.acr50_ssw14_3_4.title, "鍵位置管理時の表示内容");
  expect(test.acr50_ssw14_3_4.obj, 0);
  expect(test.acr50_ssw14_3_4.condi, 0);
  expect(test.acr50_ssw14_3_4.typ, 2);
  expect(test.acr50_ssw14_3_4.ini_typ, 0);
  expect(test.acr50_ssw14_3_4.file, "conf/mac_info.json");
  expect(test.acr50_ssw14_3_4.section, "acx_flg");
  expect(test.acr50_ssw14_3_4.keyword, "acr50_ssw14_3_4");
  expect(test.acr50_ssw14_5.title, "補充処理開始");
  expect(test.acr50_ssw14_5.obj, 0);
  expect(test.acr50_ssw14_5.condi, 0);
  expect(test.acr50_ssw14_5.typ, 2);
  expect(test.acr50_ssw14_5.ini_typ, 0);
  expect(test.acr50_ssw14_5.file, "conf/mac_info.json");
  expect(test.acr50_ssw14_5.section, "acx_flg");
  expect(test.acr50_ssw14_5.keyword, "acr50_ssw14_5");
  expect(test.acr50_ssw14_7.title, "計数開始時の空転処理");
  expect(test.acr50_ssw14_7.obj, 0);
  expect(test.acr50_ssw14_7.condi, 0);
  expect(test.acr50_ssw14_7.typ, 2);
  expect(test.acr50_ssw14_7.ini_typ, 0);
  expect(test.acr50_ssw14_7.file, "conf/mac_info.json");
  expect(test.acr50_ssw14_7.section, "acx_flg");
  expect(test.acr50_ssw14_7.keyword, "acr50_ssw14_7");
  expect(test.pick_end.title, "回収作業終了待ち");
  expect(test.pick_end.obj, 0);
  expect(test.pick_end.condi, 0);
  expect(test.pick_end.typ, 2);
  expect(test.pick_end.ini_typ, 0);
  expect(test.pick_end.file, "conf/mac_info.json");
  expect(test.pick_end.section, "acx_flg");
  expect(test.pick_end.keyword, "pick_end");
  expect(test.acxreal_system.title, "釣銭釣札機リアル問い合わせ");
  expect(test.acxreal_system.obj, 0);
  expect(test.acxreal_system.condi, 0);
  expect(test.acxreal_system.typ, 2);
  expect(test.acxreal_system.ini_typ, 0);
  expect(test.acxreal_system.file, "conf/mac_info.json");
  expect(test.acxreal_system.section, "acx_flg");
  expect(test.acxreal_system.keyword, "acxreal_system");
  expect(test.acxreal_interval.title, "釣銭釣札機　リアル問合せ間隔");
  expect(test.acxreal_interval.obj, 0);
  expect(test.acxreal_interval.condi, 0);
  expect(test.acxreal_interval.typ, 2);
  expect(test.acxreal_interval.ini_typ, 0);
  expect(test.acxreal_interval.file, "conf/mac_info.json");
  expect(test.acxreal_interval.section, "acx_timer");
  expect(test.acxreal_interval.keyword, "acxreal_interval");
  expect(test.ecs_pick_positn10000.title, "回収時紙幣搬送先設定　10000円");
  expect(test.ecs_pick_positn10000.obj, 0);
  expect(test.ecs_pick_positn10000.condi, 0);
  expect(test.ecs_pick_positn10000.typ, 2);
  expect(test.ecs_pick_positn10000.ini_typ, 0);
  expect(test.ecs_pick_positn10000.file, "conf/mac_info.json");
  expect(test.ecs_pick_positn10000.section, "acx_flg");
  expect(test.ecs_pick_positn10000.keyword, "ecs_pick_positn10000");
  expect(test.ecs_pick_positn5000.title, "回収時紙幣搬送先設定　5000円");
  expect(test.ecs_pick_positn5000.obj, 0);
  expect(test.ecs_pick_positn5000.condi, 0);
  expect(test.ecs_pick_positn5000.typ, 2);
  expect(test.ecs_pick_positn5000.ini_typ, 0);
  expect(test.ecs_pick_positn5000.file, "conf/mac_info.json");
  expect(test.ecs_pick_positn5000.section, "acx_flg");
  expect(test.ecs_pick_positn5000.keyword, "ecs_pick_positn5000");
  expect(test.ecs_pick_positn2000.title, "回収時紙幣搬送先設定　2000円");
  expect(test.ecs_pick_positn2000.obj, 0);
  expect(test.ecs_pick_positn2000.condi, 0);
  expect(test.ecs_pick_positn2000.typ, 2);
  expect(test.ecs_pick_positn2000.ini_typ, 0);
  expect(test.ecs_pick_positn2000.file, "conf/mac_info.json");
  expect(test.ecs_pick_positn2000.section, "acx_flg");
  expect(test.ecs_pick_positn2000.keyword, "ecs_pick_positn2000");
  expect(test.ecs_pick_positn1000.title, "回収時紙幣搬送先設定　1000円");
  expect(test.ecs_pick_positn1000.obj, 0);
  expect(test.ecs_pick_positn1000.condi, 0);
  expect(test.ecs_pick_positn1000.typ, 2);
  expect(test.ecs_pick_positn1000.ini_typ, 0);
  expect(test.ecs_pick_positn1000.file, "conf/mac_info.json");
  expect(test.ecs_pick_positn1000.section, "acx_flg");
  expect(test.ecs_pick_positn1000.keyword, "ecs_pick_positn1000");
  expect(test.acx_pick_data10000.title, "釣機回収ユーザー設定枚数　10000円");
  expect(test.acx_pick_data10000.obj, 0);
  expect(test.acx_pick_data10000.condi, 0);
  expect(test.acx_pick_data10000.typ, 2);
  expect(test.acx_pick_data10000.ini_typ, 0);
  expect(test.acx_pick_data10000.file, "conf/mac_info.json");
  expect(test.acx_pick_data10000.section, "acx_flg");
  expect(test.acx_pick_data10000.keyword, "acx_pick_data10000");
  expect(test.acx_pick_data5000.title, "釣機回収ユーザー設定枚数　5000円");
  expect(test.acx_pick_data5000.obj, 0);
  expect(test.acx_pick_data5000.condi, 0);
  expect(test.acx_pick_data5000.typ, 2);
  expect(test.acx_pick_data5000.ini_typ, 0);
  expect(test.acx_pick_data5000.file, "conf/mac_info.json");
  expect(test.acx_pick_data5000.section, "acx_flg");
  expect(test.acx_pick_data5000.keyword, "acx_pick_data5000");
  expect(test.acx_pick_data2000.title, "釣機回収ユーザー設定枚数　2000円");
  expect(test.acx_pick_data2000.obj, 0);
  expect(test.acx_pick_data2000.condi, 0);
  expect(test.acx_pick_data2000.typ, 2);
  expect(test.acx_pick_data2000.ini_typ, 0);
  expect(test.acx_pick_data2000.file, "conf/mac_info.json");
  expect(test.acx_pick_data2000.section, "acx_flg");
  expect(test.acx_pick_data2000.keyword, "acx_pick_data2000");
  expect(test.acx_pick_data1000.title, "釣機回収ユーザー設定枚数　1000円");
  expect(test.acx_pick_data1000.obj, 0);
  expect(test.acx_pick_data1000.condi, 0);
  expect(test.acx_pick_data1000.typ, 2);
  expect(test.acx_pick_data1000.ini_typ, 0);
  expect(test.acx_pick_data1000.file, "conf/mac_info.json");
  expect(test.acx_pick_data1000.section, "acx_flg");
  expect(test.acx_pick_data1000.keyword, "acx_pick_data1000");
  expect(test.acx_pick_data500.title, "釣機回収ユーザー設定枚数　500円");
  expect(test.acx_pick_data500.obj, 0);
  expect(test.acx_pick_data500.condi, 0);
  expect(test.acx_pick_data500.typ, 2);
  expect(test.acx_pick_data500.ini_typ, 0);
  expect(test.acx_pick_data500.file, "conf/mac_info.json");
  expect(test.acx_pick_data500.section, "acx_flg");
  expect(test.acx_pick_data500.keyword, "acx_pick_data500");
  expect(test.acx_pick_data100.title, "釣機回収ユーザー設定枚数　100円");
  expect(test.acx_pick_data100.obj, 0);
  expect(test.acx_pick_data100.condi, 0);
  expect(test.acx_pick_data100.typ, 2);
  expect(test.acx_pick_data100.ini_typ, 0);
  expect(test.acx_pick_data100.file, "conf/mac_info.json");
  expect(test.acx_pick_data100.section, "acx_flg");
  expect(test.acx_pick_data100.keyword, "acx_pick_data100");
  expect(test.acx_pick_data50.title, "釣機回収ユーザー設定枚数　50円");
  expect(test.acx_pick_data50.obj, 0);
  expect(test.acx_pick_data50.condi, 0);
  expect(test.acx_pick_data50.typ, 2);
  expect(test.acx_pick_data50.ini_typ, 0);
  expect(test.acx_pick_data50.file, "conf/mac_info.json");
  expect(test.acx_pick_data50.section, "acx_flg");
  expect(test.acx_pick_data50.keyword, "acx_pick_data50");
  expect(test.acx_pick_data10.title, "釣機回収ユーザー設定枚数　10円");
  expect(test.acx_pick_data10.obj, 0);
  expect(test.acx_pick_data10.condi, 0);
  expect(test.acx_pick_data10.typ, 2);
  expect(test.acx_pick_data10.ini_typ, 0);
  expect(test.acx_pick_data10.file, "conf/mac_info.json");
  expect(test.acx_pick_data10.section, "acx_flg");
  expect(test.acx_pick_data10.keyword, "acx_pick_data10");
  expect(test.acx_pick_data5.title, "釣機回収ユーザー設定枚数　5円");
  expect(test.acx_pick_data5.obj, 0);
  expect(test.acx_pick_data5.condi, 0);
  expect(test.acx_pick_data5.typ, 2);
  expect(test.acx_pick_data5.ini_typ, 0);
  expect(test.acx_pick_data5.file, "conf/mac_info.json");
  expect(test.acx_pick_data5.section, "acx_flg");
  expect(test.acx_pick_data5.keyword, "acx_pick_data5");
  expect(test.acx_pick_data1.title, "釣機回収ユーザー設定枚数　1円");
  expect(test.acx_pick_data1.obj, 0);
  expect(test.acx_pick_data1.condi, 0);
  expect(test.acx_pick_data1.typ, 2);
  expect(test.acx_pick_data1.ini_typ, 0);
  expect(test.acx_pick_data1.file, "conf/mac_info.json");
  expect(test.acx_pick_data1.section, "acx_flg");
  expect(test.acx_pick_data1.keyword, "acx_pick_data1");
  expect(test.ecs_recalc_reject.title, "精査終了時のﾘｼﾞｪｸﾄ貨幣発生時の動作");
  expect(test.ecs_recalc_reject.obj, 0);
  expect(test.ecs_recalc_reject.condi, 0);
  expect(test.ecs_recalc_reject.typ, 2);
  expect(test.ecs_recalc_reject.ini_typ, 0);
  expect(test.ecs_recalc_reject.file, "conf/mac_info.json");
  expect(test.ecs_recalc_reject.section, "acx_flg");
  expect(test.ecs_recalc_reject.keyword, "ecs_recalc_reject");
  expect(test.sst1_error_disp.title, "エラー復旧手順画面表示");
  expect(test.sst1_error_disp.obj, 0);
  expect(test.sst1_error_disp.condi, 0);
  expect(test.sst1_error_disp.typ, 2);
  expect(test.sst1_error_disp.ini_typ, 0);
  expect(test.sst1_error_disp.file, "conf/mac_info.json");
  expect(test.sst1_error_disp.section, "acx_flg");
  expect(test.sst1_error_disp.keyword, "sst1_error_disp");
  expect(test.sst1_cin_retry.title, "硬貨入金時の投入口繰り出し不良リトライ回数");
  expect(test.sst1_cin_retry.obj, 0);
  expect(test.sst1_cin_retry.condi, 0);
  expect(test.sst1_cin_retry.typ, 2);
  expect(test.sst1_cin_retry.ini_typ, 0);
  expect(test.sst1_cin_retry.file, "conf/mac_info.json");
  expect(test.sst1_cin_retry.section, "acx_flg");
  expect(test.sst1_cin_retry.keyword, "sst1_cin_retry");
  expect(test.acx_resv_min5000.title, "釣機最低必要枚数　5000円");
  expect(test.acx_resv_min5000.obj, 0);
  expect(test.acx_resv_min5000.condi, 0);
  expect(test.acx_resv_min5000.typ, 2);
  expect(test.acx_resv_min5000.ini_typ, 0);
  expect(test.acx_resv_min5000.file, "conf/mac_info.json");
  expect(test.acx_resv_min5000.section, "acx_flg");
  expect(test.acx_resv_min5000.keyword, "acx_resv_min5000");
  expect(test.acx_resv_min2000.title, "釣機最低必要枚数　2000円");
  expect(test.acx_resv_min2000.obj, 0);
  expect(test.acx_resv_min2000.condi, 0);
  expect(test.acx_resv_min2000.typ, 2);
  expect(test.acx_resv_min2000.ini_typ, 0);
  expect(test.acx_resv_min2000.file, "conf/mac_info.json");
  expect(test.acx_resv_min2000.section, "acx_flg");
  expect(test.acx_resv_min2000.keyword, "acx_resv_min2000");
  expect(test.acx_resv_min1000.title, "釣機最低必要枚数　1000円");
  expect(test.acx_resv_min1000.obj, 0);
  expect(test.acx_resv_min1000.condi, 0);
  expect(test.acx_resv_min1000.typ, 2);
  expect(test.acx_resv_min1000.ini_typ, 0);
  expect(test.acx_resv_min1000.file, "conf/mac_info.json");
  expect(test.acx_resv_min1000.section, "acx_flg");
  expect(test.acx_resv_min1000.keyword, "acx_resv_min1000");
  expect(test.acx_resv_min500.title, "釣機最低必要枚数　500円");
  expect(test.acx_resv_min500.obj, 0);
  expect(test.acx_resv_min500.condi, 0);
  expect(test.acx_resv_min500.typ, 2);
  expect(test.acx_resv_min500.ini_typ, 0);
  expect(test.acx_resv_min500.file, "conf/mac_info.json");
  expect(test.acx_resv_min500.section, "acx_flg");
  expect(test.acx_resv_min500.keyword, "acx_resv_min500");
  expect(test.acx_resv_min100.title, "釣機最低必要枚数　100円");
  expect(test.acx_resv_min100.obj, 0);
  expect(test.acx_resv_min100.condi, 0);
  expect(test.acx_resv_min100.typ, 2);
  expect(test.acx_resv_min100.ini_typ, 0);
  expect(test.acx_resv_min100.file, "conf/mac_info.json");
  expect(test.acx_resv_min100.section, "acx_flg");
  expect(test.acx_resv_min100.keyword, "acx_resv_min100");
  expect(test.acx_resv_min50.title, "釣機最低必要枚数　50円");
  expect(test.acx_resv_min50.obj, 0);
  expect(test.acx_resv_min50.condi, 0);
  expect(test.acx_resv_min50.typ, 2);
  expect(test.acx_resv_min50.ini_typ, 0);
  expect(test.acx_resv_min50.file, "conf/mac_info.json");
  expect(test.acx_resv_min50.section, "acx_flg");
  expect(test.acx_resv_min50.keyword, "acx_resv_min50");
  expect(test.acx_resv_min10.title, "釣機最低必要枚数　10円");
  expect(test.acx_resv_min10.obj, 0);
  expect(test.acx_resv_min10.condi, 0);
  expect(test.acx_resv_min10.typ, 2);
  expect(test.acx_resv_min10.ini_typ, 0);
  expect(test.acx_resv_min10.file, "conf/mac_info.json");
  expect(test.acx_resv_min10.section, "acx_flg");
  expect(test.acx_resv_min10.keyword, "acx_resv_min10");
  expect(test.acx_resv_min5.title, "釣機最低必要枚数　5円");
  expect(test.acx_resv_min5.obj, 0);
  expect(test.acx_resv_min5.condi, 0);
  expect(test.acx_resv_min5.typ, 2);
  expect(test.acx_resv_min5.ini_typ, 0);
  expect(test.acx_resv_min5.file, "conf/mac_info.json");
  expect(test.acx_resv_min5.section, "acx_flg");
  expect(test.acx_resv_min5.keyword, "acx_resv_min5");
  expect(test.acx_resv_min1.title, "釣機最低必要枚数　1円");
  expect(test.acx_resv_min1.obj, 0);
  expect(test.acx_resv_min1.condi, 0);
  expect(test.acx_resv_min1.typ, 2);
  expect(test.acx_resv_min1.ini_typ, 0);
  expect(test.acx_resv_min1.file, "conf/mac_info.json");
  expect(test.acx_resv_min1.section, "acx_flg");
  expect(test.acx_resv_min1.keyword, "acx_resv_min1");
  expect(test.acb50_ssw13_0.title, "棒金接続");
  expect(test.acb50_ssw13_0.obj, 0);
  expect(test.acb50_ssw13_0.condi, 0);
  expect(test.acb50_ssw13_0.typ, 2);
  expect(test.acb50_ssw13_0.ini_typ, 0);
  expect(test.acb50_ssw13_0.file, "conf/mac_info.json");
  expect(test.acb50_ssw13_0.section, "acx_flg");
  expect(test.acb50_ssw13_0.keyword, "acb50_ssw13_0");
  expect(test.acb50_ssw13_1_2.title, "ドロア開設定");
  expect(test.acb50_ssw13_1_2.obj, 0);
  expect(test.acb50_ssw13_1_2.condi, 0);
  expect(test.acb50_ssw13_1_2.typ, 2);
  expect(test.acb50_ssw13_1_2.ini_typ, 0);
  expect(test.acb50_ssw13_1_2.file, "conf/mac_info.json");
  expect(test.acb50_ssw13_1_2.section, "acx_flg");
  expect(test.acb50_ssw13_1_2.keyword, "acb50_ssw13_1_2");
  expect(test.acb50_ssw13_3_4.title, "精査フォーマット");
  expect(test.acb50_ssw13_3_4.obj, 0);
  expect(test.acb50_ssw13_3_4.condi, 0);
  expect(test.acb50_ssw13_3_4.typ, 2);
  expect(test.acb50_ssw13_3_4.ini_typ, 0);
  expect(test.acb50_ssw13_3_4.file, "conf/mac_info.json");
  expect(test.acb50_ssw13_3_4.section, "acx_flg");
  expect(test.acb50_ssw13_3_4.keyword, "acb50_ssw13_3_4");
  expect(test.acb50_ssw13_5.title, "500円棒金巻き数");
  expect(test.acb50_ssw13_5.obj, 0);
  expect(test.acb50_ssw13_5.condi, 0);
  expect(test.acb50_ssw13_5.typ, 2);
  expect(test.acb50_ssw13_5.ini_typ, 0);
  expect(test.acb50_ssw13_5.file, "conf/mac_info.json");
  expect(test.acb50_ssw13_5.section, "acx_flg");
  expect(test.acb50_ssw13_5.keyword, "acb50_ssw13_5");
  expect(test.acb50_ssw13_6.title, "棒金連動残置");
  expect(test.acb50_ssw13_6.obj, 0);
  expect(test.acb50_ssw13_6.condi, 0);
  expect(test.acb50_ssw13_6.typ, 2);
  expect(test.acb50_ssw13_6.ini_typ, 0);
  expect(test.acb50_ssw13_6.file, "conf/mac_info.json");
  expect(test.acb50_ssw13_6.section, "acx_flg");
  expect(test.acb50_ssw13_6.keyword, "acb50_ssw13_6");
  expect(test.chgdrw_inout_tran.title, "棒金開キーでの在高増減を実績加算");
  expect(test.chgdrw_inout_tran.obj, 0);
  expect(test.chgdrw_inout_tran.condi, 0);
  expect(test.chgdrw_inout_tran.typ, 2);
  expect(test.chgdrw_inout_tran.ini_typ, 0);
  expect(test.chgdrw_inout_tran.file, "conf/mac_info.json");
  expect(test.chgdrw_inout_tran.section, "acx_flg");
  expect(test.chgdrw_inout_tran.keyword, "chgdrw_inout_tran");
  expect(test.chgdrw_loan_tran.title, "釣準備キーでの在高取得時、棒金ドロア在高を加算");
  expect(test.chgdrw_loan_tran.obj, 0);
  expect(test.chgdrw_loan_tran.condi, 0);
  expect(test.chgdrw_loan_tran.typ, 2);
  expect(test.chgdrw_loan_tran.ini_typ, 0);
  expect(test.chgdrw_loan_tran.file, "conf/mac_info.json");
  expect(test.chgdrw_loan_tran.section, "acx_flg");
  expect(test.chgdrw_loan_tran.keyword, "chgdrw_loan_tran");
}

