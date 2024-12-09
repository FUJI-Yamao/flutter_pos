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
import '../../../../lib/app/common/cls_conf/ecs_specJsonFile.dart';

late Ecs_specJsonFile ecs_spec;

void main(){
  ecs_specJsonFile_test();
}

void ecs_specJsonFile_test()
{
  TestWidgetsFlutterBinding.ensureInitialized();
  const String confPath = "conf/";
  const String testDir = "test_assets";
  const String fileName = "ecs_spec.json";
  const String section = "ecs_spec";
  const String key = "ecs_gp0_1_0";
  const defaultData = 0;
  const testData1  =  987654321;    // テストデータ1
  const testData1s = "987654321";
  const testData2  =  192834675;    // テストデータ2
  const testData2s = "192834675";
  const testData3  =  129834765;    // テストデータ3
  const testData3s = "129834765";

  group('Ecs_specJsonFile',()
  {
    setUp(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      // 当該JSONファイルをデフォルトに戻す。
      await Ecs_specJsonFile().setDefault();
    });

    // 各テストの事後処理
    tearDown(() async{
      // 当該JSONファイルをデフォルトに戻す。
      await Ecs_specJsonFile().setDefault();
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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // 前提状態構築
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      // ⓪：事前状態確認（対象JSONファイルが存在しないこと。）
      expect(fileBefore.exists() == false, false);

      await ecs_spec.load();

      final File fileAfter = File(jsonPath);
      // ①-1：load実行により対象JSONファイルが作成されていること。
      expect(fileAfter.existsSync(), true);

      // ②：対象JSONファイルの各プロパティ値を読み込んでいること。
      allPropatyCheck(ecs_spec,true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == false) {
        ecs_spec.setDefault();
        debugPrint("setDefault実行");
      }
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      await ecs_spec.load();

      // 対象JSONファイルの各プロパティ値を読み込んでいること。
      // 00001実行後で、デフォルト値前提
      allPropatyCheck(ecs_spec,true);

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
      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①：loadを実行する。
      await ecs_spec.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = ecs_spec.ecs_spec.ecs_gp0_1_0;
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

      // ③loadを実行する。
      //   当該プロパティ値の変更が取り消されること。
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 != testData1, true);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == prefixData, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②任意のプロパティの値を変更する。
      final prefixData = ecs_spec.ecs_spec.ecs_gp0_1_0;
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, testData1);

      // ③saveを実行する。
      await ecs_spec.save();

      // ④loadを実行する。
      await ecs_spec.load();

      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 != prefixData, true);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);
      allPropatyCheck(ecs_spec,false);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await ecs_spec.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();

      // ② saveを実行する。
      await ecs_spec.save();

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      // ⓪：事前状態確認（対象JSONファイルが存在すること。）
      expect(fileBefore.existsSync(), true);

      // ① loadを実行する。
      await ecs_spec.load();

      // save実行前のJSONファイルを保存する。
      final String jsonBefor = await fileBefore.readAsString();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, defaultData);

      // ②任意のプロパティの値を変更する。
      final prefixData = ecs_spec.ecs_spec.ecs_gp0_1_0;
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;

      // ③ saveを実行する。
      await ecs_spec.save();

      final File fileAfter1 = File(jsonPath);
      expect(fileAfter1.existsSync(), true);

      // アプリ用フォルダにある対象JSONファイルの内容に変化ががあること。
      // 手順②で変更した内容になっていること。
      final String jsonAfter1 = await fileAfter1.readAsString();
      expect(jsonBefor.replaceAll("\r\n", "\n") != jsonAfter1.replaceAll("\r\n", "\n"), true);
      expect(testData1 != prefixData, true);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, testData1);

      // ④ loadを実行する。
      await ecs_spec.load();

      // アプリ用フォルダにある対象JSONファイルの内容が同じであること。
      // 手順②で変更した内容であること。
      final String jsonAfter2 = await fileAfter1.readAsString();
      expect(jsonAfter1.replaceAll("\r\n", "\n") == jsonAfter2.replaceAll("\r\n", "\n"), true);

      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);
      allPropatyCheck(ecs_spec,false);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①アプリ用フォルダにある対象JSONファイルを削除する。
      Directory appDir = Directory(EnvironmentData.TPRX_HOME);
      final String jsonPath = join(appDir.path, confPath, fileName);
      final File fileBefore = File(jsonPath);
      if (fileBefore.existsSync() == true) {
        fileBefore.deleteSync();
      }
      expect(fileBefore.existsSync() , false);

      // ②setDefaultを実行する。
      await ecs_spec.setDefault();
      expect(fileBefore.existsSync() , true);
      allPropatyCheck(ecs_spec,true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②任意のプロパティの値を変更する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, testData1);

      // ③saveを実行する。
      await ecs_spec.save();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, testData1);

      // ④loadを実行する。
      await ecs_spec.setDefault();

      // （デフォルト値と同じであること。）
      allPropatyCheck(ecs_spec,true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      await ecs_spec.setValueWithName(section, key, testData1);

      // ②loadを実行する。
      await ecs_spec.load();

      // 手順②実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

      print("********** テスト終了：00009_setValueWithName_01 **********\n\n");
    });

    test('00010_setValueWithName_02', () async {
      print("\n********** テスト実行：00010_setValueWithName_02 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await ecs_spec.setValueWithName("test_section", key, testData1);


      // 手順実行後、手順①で設定したプロパティ変更後の内容でプロパティ値が設定されていること。
      expect(value.result, false);
      expect(value.cause == json_result.element_not_found, true);

      print("********** テスト終了：00010_setValueWithName_02 **********\n\n");
    });

    test('00011_setValueWithName_03', () async {
      print("\n********** テスト実行：00011_setValueWithName_03 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①任意のセクション名、キー名、値にてsetValueWithNameを実行する。
      final value = await ecs_spec.setValueWithName(section, "test_key", testData1);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②任意のプロパティを変更する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;

      // ③saveを実行する。
      await ecs_spec.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await ecs_spec.getValueWithName(section, key);
      //print(testData.toString() + " == " + verify.value.toString());
      expect(testData1 == verify.value, true);

      print("********** テスト終了：00012_getValueWithName_01**********\n\n");
    });

    test('00013_getValueWithName_02', () async {
      print("\n********** テスト実行：00013_getValueWithName_02********** ");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②任意のプロパティを変更する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;

      // ③saveを実行する。
      await ecs_spec.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await ecs_spec.getValueWithName("test_section", key);
      //print(testData.toString() + " == " + verify.value.toString());

      expect(verify.result, false);
      expect(verify.cause == json_result.element_not_found, true);

      print("********** テスト終了：00013_getValueWithName_02**********\n\n");
    });

    test('00014_getValueWithName_03', () async {
      print("\n********** テスト実行：00014_getValueWithName_03********** ");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②任意のプロパティを変更する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;

      // ③saveを実行する。
      await ecs_spec.save();

      // ④①で指定したプロパティに相当するセクション名、キー名にて
      //   getValueWithNameを実行する。
      final verify = await ecs_spec.getValueWithName(section, "test_key");
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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①任意のフォルダのパスを引数としてsetAbsolutePathを実行する。
      final appDir = Directory(EnvironmentData.TPRX_HOME);
      JsonPath().absolutePath = join(appDir.path, testDir);

      // ②loadを実行する。
      await ecs_spec.load();

      // 手順②実行後に①で指定したパスに/assets/conf/当該JSONファイルが作成されていること。
      final String jsonPath = join(appDir.path, testDir, confPath, fileName);
      //print("存在確認先：" + jsonPath);
      final File file = File(jsonPath);
      expect(file.existsSync() == true , true);

      // ③任意のプロパティ値を変更する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, testData1);

      // ④saveを実行する。
      await ecs_spec.save();

      // 手順④実行後、プロパティ変更後の内容でプロパティ値が設定されていること。
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0, testData1);
      
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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ②Jsonファイルの任意のプロパティの値を変更する。
      // ④バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern1, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern1);

      // ⑤loadを実行する。
      await ecs_spec.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ②任意のプロパティの値を変更する。
      // ④バックアップファイルを作成する。
      await makeTestData(confPath, fileName, testFunc.makePattern2, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern2);

      // ⑤loadを実行する。
      await ecs_spec.load();

      // 手順⑤実行後、手順②で変更した内容でプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData2, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern3, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern3);

      // ③loadを実行する。
      await ecs_spec.load();

      // 手順③実行後、①の内容ででプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern4, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern4);

      // ③loadを実行する。
      await ecs_spec.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData2, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern5, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern5);

      // ③loadを実行する。
      await ecs_spec.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①バックアップファイルを作成する。
      // ②任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern6, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern6);

      // ③loadを実行する。
      await ecs_spec.load();

      // 手順③実行後、②の内容ででプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern7, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern7);

      // ③loadを実行する。
      await ecs_spec.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      allPropatyCheck(ecs_spec,true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①任意のプロパティの値を変更した内容でJSONファイルを更新し、破損状態とする。
      // ②バックアップファイルを作成し、破損状態とする。
      await makeTestData(confPath, fileName, testFunc.makePattern8, section, key, testData1, testData2);
      await getTestDate(confPath, fileName, testFunc.getPattern8);

      // ③loadを実行する。
      await ecs_spec.load();

      // デフォルトの内容でプロパティ値が設定されていること。
      print("check:" + ecs_spec.ecs_spec.ecs_gp0_1_0.toString());
      allPropatyCheck(ecs_spec,true);

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

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_1_0;
      print(ecs_spec.ecs_spec.ecs_gp0_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00024_element_check_00001 **********\n\n");
    });

    test('00025_element_check_00002', () async {
      print("\n********** テスト実行：00025_element_check_00002 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_1_2;
      print(ecs_spec.ecs_spec.ecs_gp0_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00025_element_check_00002 **********\n\n");
    });

    test('00026_element_check_00003', () async {
      print("\n********** テスト実行：00026_element_check_00003 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_2_0;
      print(ecs_spec.ecs_spec.ecs_gp0_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00026_element_check_00003 **********\n\n");
    });

    test('00027_element_check_00004', () async {
      print("\n********** テスト実行：00027_element_check_00004 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_2_2;
      print(ecs_spec.ecs_spec.ecs_gp0_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00027_element_check_00004 **********\n\n");
    });

    test('00028_element_check_00005', () async {
      print("\n********** テスト実行：00028_element_check_00005 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_3_0;
      print(ecs_spec.ecs_spec.ecs_gp0_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00028_element_check_00005 **********\n\n");
    });

    test('00029_element_check_00006', () async {
      print("\n********** テスト実行：00029_element_check_00006 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_3_1;
      print(ecs_spec.ecs_spec.ecs_gp0_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00029_element_check_00006 **********\n\n");
    });

    test('00030_element_check_00007', () async {
      print("\n********** テスト実行：00030_element_check_00007 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_3_2;
      print(ecs_spec.ecs_spec.ecs_gp0_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00030_element_check_00007 **********\n\n");
    });

    test('00031_element_check_00008', () async {
      print("\n********** テスト実行：00031_element_check_00008 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_3_3;
      print(ecs_spec.ecs_spec.ecs_gp0_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp0_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00031_element_check_00008 **********\n\n");
    });

    test('00032_element_check_00009', () async {
      print("\n********** テスト実行：00032_element_check_00009 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_4_0;
      print(ecs_spec.ecs_spec.ecs_gp0_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00032_element_check_00009 **********\n\n");
    });

    test('00033_element_check_00010', () async {
      print("\n********** テスト実行：00033_element_check_00010 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_5_0;
      print(ecs_spec.ecs_spec.ecs_gp0_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp0_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00033_element_check_00010 **********\n\n");
    });

    test('00034_element_check_00011', () async {
      print("\n********** テスト実行：00034_element_check_00011 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp0_5_2;
      print(ecs_spec.ecs_spec.ecs_gp0_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp0_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp0_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp0_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp0_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp0_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp0_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp0_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp0_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp0_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00034_element_check_00011 **********\n\n");
    });

    test('00035_element_check_00012', () async {
      print("\n********** テスト実行：00035_element_check_00012 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_1_0;
      print(ecs_spec.ecs_spec.ecs_gp1_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00035_element_check_00012 **********\n\n");
    });

    test('00036_element_check_00013', () async {
      print("\n********** テスト実行：00036_element_check_00013 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_1_2;
      print(ecs_spec.ecs_spec.ecs_gp1_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00036_element_check_00013 **********\n\n");
    });

    test('00037_element_check_00014', () async {
      print("\n********** テスト実行：00037_element_check_00014 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_2_0;
      print(ecs_spec.ecs_spec.ecs_gp1_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00037_element_check_00014 **********\n\n");
    });

    test('00038_element_check_00015', () async {
      print("\n********** テスト実行：00038_element_check_00015 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_2_2;
      print(ecs_spec.ecs_spec.ecs_gp1_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00038_element_check_00015 **********\n\n");
    });

    test('00039_element_check_00016', () async {
      print("\n********** テスト実行：00039_element_check_00016 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_3_0;
      print(ecs_spec.ecs_spec.ecs_gp1_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00039_element_check_00016 **********\n\n");
    });

    test('00040_element_check_00017', () async {
      print("\n********** テスト実行：00040_element_check_00017 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_3_1;
      print(ecs_spec.ecs_spec.ecs_gp1_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp1_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp1_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00040_element_check_00017 **********\n\n");
    });

    test('00041_element_check_00018', () async {
      print("\n********** テスト実行：00041_element_check_00018 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_3_2;
      print(ecs_spec.ecs_spec.ecs_gp1_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00041_element_check_00018 **********\n\n");
    });

    test('00042_element_check_00019', () async {
      print("\n********** テスト実行：00042_element_check_00019 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_4_0;
      print(ecs_spec.ecs_spec.ecs_gp1_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00042_element_check_00019 **********\n\n");
    });

    test('00043_element_check_00020', () async {
      print("\n********** テスト実行：00043_element_check_00020 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_4_2;
      print(ecs_spec.ecs_spec.ecs_gp1_4_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_4_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_4_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_4_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_4_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_4_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_4_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_4_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_4_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp1_4_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_4_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00043_element_check_00020 **********\n\n");
    });

    test('00044_element_check_00021', () async {
      print("\n********** テスト実行：00044_element_check_00021 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_4_3;
      print(ecs_spec.ecs_spec.ecs_gp1_4_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_4_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_4_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_4_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_4_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_4_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_4_3);
      expect(ecs_spec.ecs_spec.ecs_gp1_4_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_4_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_4_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_4_3);
      expect(ecs_spec.ecs_spec.ecs_gp1_4_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_4_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00044_element_check_00021 **********\n\n");
    });

    test('00045_element_check_00022', () async {
      print("\n********** テスト実行：00045_element_check_00022 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1_5_0;
      print(ecs_spec.ecs_spec.ecs_gp1_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp1_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00045_element_check_00022 **********\n\n");
    });

    test('00046_element_check_00023', () async {
      print("\n********** テスト実行：00046_element_check_00023 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_1_0;
      print(ecs_spec.ecs_spec.ecs_gp2_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00046_element_check_00023 **********\n\n");
    });

    test('00047_element_check_00024', () async {
      print("\n********** テスト実行：00047_element_check_00024 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_1_2;
      print(ecs_spec.ecs_spec.ecs_gp2_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp2_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp2_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00047_element_check_00024 **********\n\n");
    });

    test('00048_element_check_00025', () async {
      print("\n********** テスト実行：00048_element_check_00025 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_2_0;
      print(ecs_spec.ecs_spec.ecs_gp2_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00048_element_check_00025 **********\n\n");
    });

    test('00049_element_check_00026', () async {
      print("\n********** テスト実行：00049_element_check_00026 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_2_2;
      print(ecs_spec.ecs_spec.ecs_gp2_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp2_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp2_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00049_element_check_00026 **********\n\n");
    });

    test('00050_element_check_00027', () async {
      print("\n********** テスト実行：00050_element_check_00027 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_3_0;
      print(ecs_spec.ecs_spec.ecs_gp2_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00050_element_check_00027 **********\n\n");
    });

    test('00051_element_check_00028', () async {
      print("\n********** テスト実行：00051_element_check_00028 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_3_1;
      print(ecs_spec.ecs_spec.ecs_gp2_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp2_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp2_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00051_element_check_00028 **********\n\n");
    });

    test('00052_element_check_00029', () async {
      print("\n********** テスト実行：00052_element_check_00029 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_3_2;
      print(ecs_spec.ecs_spec.ecs_gp2_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp2_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp2_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00052_element_check_00029 **********\n\n");
    });

    test('00053_element_check_00030', () async {
      print("\n********** テスト実行：00053_element_check_00030 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_4_0;
      print(ecs_spec.ecs_spec.ecs_gp2_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00053_element_check_00030 **********\n\n");
    });

    test('00054_element_check_00031', () async {
      print("\n********** テスト実行：00054_element_check_00031 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_4_1;
      print(ecs_spec.ecs_spec.ecs_gp2_4_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_4_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_4_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_4_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_4_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_4_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_4_1);
      expect(ecs_spec.ecs_spec.ecs_gp2_4_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_4_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_4_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_4_1);
      expect(ecs_spec.ecs_spec.ecs_gp2_4_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_4_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00054_element_check_00031 **********\n\n");
    });

    test('00055_element_check_00032', () async {
      print("\n********** テスト実行：00055_element_check_00032 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp2_5_0;
      print(ecs_spec.ecs_spec.ecs_gp2_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp2_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp2_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp2_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp2_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp2_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp2_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp2_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp2_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp2_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00055_element_check_00032 **********\n\n");
    });

    test('00056_element_check_00033', () async {
      print("\n********** テスト実行：00056_element_check_00033 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_1_0;
      print(ecs_spec.ecs_spec.ecs_gp3_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00056_element_check_00033 **********\n\n");
    });

    test('00057_element_check_00034', () async {
      print("\n********** テスト実行：00057_element_check_00034 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_1_1;
      print(ecs_spec.ecs_spec.ecs_gp3_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00057_element_check_00034 **********\n\n");
    });

    test('00058_element_check_00035', () async {
      print("\n********** テスト実行：00058_element_check_00035 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_1_2;
      print(ecs_spec.ecs_spec.ecs_gp3_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00058_element_check_00035 **********\n\n");
    });

    test('00059_element_check_00036', () async {
      print("\n********** テスト実行：00059_element_check_00036 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_1_3;
      print(ecs_spec.ecs_spec.ecs_gp3_1_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_1_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_1_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_1_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_1_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp3_1_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_1_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00059_element_check_00036 **********\n\n");
    });

    test('00060_element_check_00037', () async {
      print("\n********** テスト実行：00060_element_check_00037 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_2_0;
      print(ecs_spec.ecs_spec.ecs_gp3_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00060_element_check_00037 **********\n\n");
    });

    test('00061_element_check_00038', () async {
      print("\n********** テスト実行：00061_element_check_00038 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_2_1;
      print(ecs_spec.ecs_spec.ecs_gp3_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00061_element_check_00038 **********\n\n");
    });

    test('00062_element_check_00039', () async {
      print("\n********** テスト実行：00062_element_check_00039 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_2_2;
      print(ecs_spec.ecs_spec.ecs_gp3_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00062_element_check_00039 **********\n\n");
    });

    test('00063_element_check_00040', () async {
      print("\n********** テスト実行：00063_element_check_00040 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_2_3;
      print(ecs_spec.ecs_spec.ecs_gp3_2_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_2_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_2_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_2_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_2_3);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_2_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_2_3);
      expect(ecs_spec.ecs_spec.ecs_gp3_2_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_2_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00063_element_check_00040 **********\n\n");
    });

    test('00064_element_check_00041', () async {
      print("\n********** テスト実行：00064_element_check_00041 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_3_0;
      print(ecs_spec.ecs_spec.ecs_gp3_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00064_element_check_00041 **********\n\n");
    });

    test('00065_element_check_00042', () async {
      print("\n********** テスト実行：00065_element_check_00042 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_3_2;
      print(ecs_spec.ecs_spec.ecs_gp3_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp3_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp3_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00065_element_check_00042 **********\n\n");
    });

    test('00066_element_check_00043', () async {
      print("\n********** テスト実行：00066_element_check_00043 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp3_4_0;
      print(ecs_spec.ecs_spec.ecs_gp3_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp3_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp3_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp3_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp3_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp3_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp3_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp3_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp3_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp3_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00066_element_check_00043 **********\n\n");
    });

    test('00067_element_check_00044', () async {
      print("\n********** テスト実行：00067_element_check_00044 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_1_0;
      print(ecs_spec.ecs_spec.ecs_gp4_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00067_element_check_00044 **********\n\n");
    });

    test('00068_element_check_00045', () async {
      print("\n********** テスト実行：00068_element_check_00045 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_1_1;
      print(ecs_spec.ecs_spec.ecs_gp4_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00068_element_check_00045 **********\n\n");
    });

    test('00069_element_check_00046', () async {
      print("\n********** テスト実行：00069_element_check_00046 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_1_2;
      print(ecs_spec.ecs_spec.ecs_gp4_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00069_element_check_00046 **********\n\n");
    });

    test('00070_element_check_00047', () async {
      print("\n********** テスト実行：00070_element_check_00047 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_1_3;
      print(ecs_spec.ecs_spec.ecs_gp4_1_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_1_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_1_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_1_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_1_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp4_1_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_1_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00070_element_check_00047 **********\n\n");
    });

    test('00071_element_check_00048', () async {
      print("\n********** テスト実行：00071_element_check_00048 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_2_0;
      print(ecs_spec.ecs_spec.ecs_gp4_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00071_element_check_00048 **********\n\n");
    });

    test('00072_element_check_00049', () async {
      print("\n********** テスト実行：00072_element_check_00049 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_2_1;
      print(ecs_spec.ecs_spec.ecs_gp4_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00072_element_check_00049 **********\n\n");
    });

    test('00073_element_check_00050', () async {
      print("\n********** テスト実行：00073_element_check_00050 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_2_2;
      print(ecs_spec.ecs_spec.ecs_gp4_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00073_element_check_00050 **********\n\n");
    });

    test('00074_element_check_00051', () async {
      print("\n********** テスト実行：00074_element_check_00051 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_2_3;
      print(ecs_spec.ecs_spec.ecs_gp4_2_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_2_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_2_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_2_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_2_3);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_2_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_2_3);
      expect(ecs_spec.ecs_spec.ecs_gp4_2_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_2_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00074_element_check_00051 **********\n\n");
    });

    test('00075_element_check_00052', () async {
      print("\n********** テスト実行：00075_element_check_00052 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_3_0;
      print(ecs_spec.ecs_spec.ecs_gp4_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00075_element_check_00052 **********\n\n");
    });

    test('00076_element_check_00053', () async {
      print("\n********** テスト実行：00076_element_check_00053 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_3_1;
      print(ecs_spec.ecs_spec.ecs_gp4_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00076_element_check_00053 **********\n\n");
    });

    test('00077_element_check_00054', () async {
      print("\n********** テスト実行：00077_element_check_00054 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_3_2;
      print(ecs_spec.ecs_spec.ecs_gp4_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00077_element_check_00054 **********\n\n");
    });

    test('00078_element_check_00055', () async {
      print("\n********** テスト実行：00078_element_check_00055 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_3_3;
      print(ecs_spec.ecs_spec.ecs_gp4_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp4_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00078_element_check_00055 **********\n\n");
    });

    test('00079_element_check_00056', () async {
      print("\n********** テスト実行：00079_element_check_00056 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_4_0;
      print(ecs_spec.ecs_spec.ecs_gp4_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp4_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00079_element_check_00056 **********\n\n");
    });

    test('00080_element_check_00057', () async {
      print("\n********** テスト実行：00080_element_check_00057 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp4_4_2;
      print(ecs_spec.ecs_spec.ecs_gp4_4_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp4_4_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp4_4_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_4_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp4_4_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp4_4_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp4_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_4_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_4_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp4_4_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp4_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp4_4_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp4_4_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00080_element_check_00057 **********\n\n");
    });

    test('00081_element_check_00058', () async {
      print("\n********** テスト実行：00081_element_check_00058 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp5_1_0;
      print(ecs_spec.ecs_spec.ecs_gp5_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp5_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp5_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp5_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp5_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp5_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp5_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp5_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp5_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00081_element_check_00058 **********\n\n");
    });

    test('00082_element_check_00059', () async {
      print("\n********** テスト実行：00082_element_check_00059 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp5_3_0;
      print(ecs_spec.ecs_spec.ecs_gp5_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp5_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp5_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp5_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp5_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp5_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp5_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp5_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp5_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00082_element_check_00059 **********\n\n");
    });

    test('00083_element_check_00060', () async {
      print("\n********** テスト実行：00083_element_check_00060 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp5_5_0;
      print(ecs_spec.ecs_spec.ecs_gp5_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp5_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp5_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp5_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp5_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp5_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp5_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp5_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp5_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00083_element_check_00060 **********\n\n");
    });

    test('00084_element_check_00061', () async {
      print("\n********** テスト実行：00084_element_check_00061 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp5_5_1;
      print(ecs_spec.ecs_spec.ecs_gp5_5_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp5_5_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp5_5_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_5_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_5_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp5_5_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp5_5_1);
      expect(ecs_spec.ecs_spec.ecs_gp5_5_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_5_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp5_5_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp5_5_1);
      expect(ecs_spec.ecs_spec.ecs_gp5_5_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_5_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00084_element_check_00061 **********\n\n");
    });

    test('00085_element_check_00062', () async {
      print("\n********** テスト実行：00085_element_check_00062 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp5_5_2;
      print(ecs_spec.ecs_spec.ecs_gp5_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp5_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp5_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp5_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp5_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp5_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp5_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp5_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp5_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp5_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp5_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00085_element_check_00062 **********\n\n");
    });

    test('00086_element_check_00063', () async {
      print("\n********** テスト実行：00086_element_check_00063 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp6_1_0;
      print(ecs_spec.ecs_spec.ecs_gp6_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp6_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp6_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp6_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp6_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp6_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp6_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp6_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp6_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp6_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp6_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp6_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp6_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00086_element_check_00063 **********\n\n");
    });

    test('00087_element_check_00064', () async {
      print("\n********** テスト実行：00087_element_check_00064 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp6_3_0;
      print(ecs_spec.ecs_spec.ecs_gp6_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp6_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp6_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp6_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp6_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp6_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp6_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp6_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp6_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp6_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp6_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp6_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp6_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00087_element_check_00064 **********\n\n");
    });

    test('00088_element_check_00065', () async {
      print("\n********** テスト実行：00088_element_check_00065 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp6_5_0;
      print(ecs_spec.ecs_spec.ecs_gp6_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp6_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp6_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp6_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp6_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp6_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp6_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp6_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp6_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp6_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp6_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp6_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp6_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00088_element_check_00065 **********\n\n");
    });

    test('00089_element_check_00066', () async {
      print("\n********** テスト実行：00089_element_check_00066 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_1_0;
      print(ecs_spec.ecs_spec.ecs_gp7_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00089_element_check_00066 **********\n\n");
    });

    test('00090_element_check_00067', () async {
      print("\n********** テスト実行：00090_element_check_00067 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_1_1;
      print(ecs_spec.ecs_spec.ecs_gp7_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp7_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp7_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00090_element_check_00067 **********\n\n");
    });

    test('00091_element_check_00068', () async {
      print("\n********** テスト実行：00091_element_check_00068 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_1_2;
      print(ecs_spec.ecs_spec.ecs_gp7_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp7_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp7_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00091_element_check_00068 **********\n\n");
    });

    test('00092_element_check_00069', () async {
      print("\n********** テスト実行：00092_element_check_00069 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_2_0;
      print(ecs_spec.ecs_spec.ecs_gp7_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00092_element_check_00069 **********\n\n");
    });

    test('00093_element_check_00070', () async {
      print("\n********** テスト実行：00093_element_check_00070 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_2_1;
      print(ecs_spec.ecs_spec.ecs_gp7_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp7_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp7_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00093_element_check_00070 **********\n\n");
    });

    test('00094_element_check_00071', () async {
      print("\n********** テスト実行：00094_element_check_00071 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_2_2;
      print(ecs_spec.ecs_spec.ecs_gp7_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp7_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp7_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00094_element_check_00071 **********\n\n");
    });

    test('00095_element_check_00072', () async {
      print("\n********** テスト実行：00095_element_check_00072 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_3_0;
      print(ecs_spec.ecs_spec.ecs_gp7_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00095_element_check_00072 **********\n\n");
    });

    test('00096_element_check_00073', () async {
      print("\n********** テスト実行：00096_element_check_00073 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_5_0;
      print(ecs_spec.ecs_spec.ecs_gp7_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp7_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00096_element_check_00073 **********\n\n");
    });

    test('00097_element_check_00074', () async {
      print("\n********** テスト実行：00097_element_check_00074 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp7_5_2;
      print(ecs_spec.ecs_spec.ecs_gp7_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp7_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp7_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp7_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp7_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp7_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp7_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp7_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp7_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp7_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp7_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00097_element_check_00074 **********\n\n");
    });

    test('00098_element_check_00075', () async {
      print("\n********** テスト実行：00098_element_check_00075 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_1_0;
      print(ecs_spec.ecs_spec.ecs_gp8_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00098_element_check_00075 **********\n\n");
    });

    test('00099_element_check_00076', () async {
      print("\n********** テスト実行：00099_element_check_00076 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_1_1;
      print(ecs_spec.ecs_spec.ecs_gp8_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp8_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp8_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00099_element_check_00076 **********\n\n");
    });

    test('00100_element_check_00077', () async {
      print("\n********** テスト実行：00100_element_check_00077 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_1_3;
      print(ecs_spec.ecs_spec.ecs_gp8_1_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_1_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_1_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_1_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_1_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_1_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp8_1_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_1_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_1_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp8_1_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_1_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00100_element_check_00077 **********\n\n");
    });

    test('00101_element_check_00078', () async {
      print("\n********** テスト実行：00101_element_check_00078 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_2_0;
      print(ecs_spec.ecs_spec.ecs_gp8_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00101_element_check_00078 **********\n\n");
    });

    test('00102_element_check_00079', () async {
      print("\n********** テスト実行：00102_element_check_00079 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_2_1;
      print(ecs_spec.ecs_spec.ecs_gp8_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp8_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp8_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00102_element_check_00079 **********\n\n");
    });

    test('00103_element_check_00080', () async {
      print("\n********** テスト実行：00103_element_check_00080 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_2_2;
      print(ecs_spec.ecs_spec.ecs_gp8_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp8_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp8_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00103_element_check_00080 **********\n\n");
    });

    test('00104_element_check_00081', () async {
      print("\n********** テスト実行：00104_element_check_00081 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_3_0;
      print(ecs_spec.ecs_spec.ecs_gp8_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00104_element_check_00081 **********\n\n");
    });

    test('00105_element_check_00082', () async {
      print("\n********** テスト実行：00105_element_check_00082 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_3_1;
      print(ecs_spec.ecs_spec.ecs_gp8_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp8_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp8_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00105_element_check_00082 **********\n\n");
    });

    test('00106_element_check_00083', () async {
      print("\n********** テスト実行：00106_element_check_00083 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_3_2;
      print(ecs_spec.ecs_spec.ecs_gp8_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp8_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp8_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00106_element_check_00083 **********\n\n");
    });

    test('00107_element_check_00084', () async {
      print("\n********** テスト実行：00107_element_check_00084 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp8_4_0;
      print(ecs_spec.ecs_spec.ecs_gp8_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp8_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp8_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp8_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp8_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp8_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp8_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp8_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp8_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp8_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00107_element_check_00084 **********\n\n");
    });

    test('00108_element_check_00085', () async {
      print("\n********** テスト実行：00108_element_check_00085 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_1_0;
      print(ecs_spec.ecs_spec.ecs_gp9_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00108_element_check_00085 **********\n\n");
    });

    test('00109_element_check_00086', () async {
      print("\n********** テスト実行：00109_element_check_00086 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_1_1;
      print(ecs_spec.ecs_spec.ecs_gp9_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp9_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_1_1);
      expect(ecs_spec.ecs_spec.ecs_gp9_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00109_element_check_00086 **********\n\n");
    });

    test('00110_element_check_00087', () async {
      print("\n********** テスト実行：00110_element_check_00087 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_1_2;
      print(ecs_spec.ecs_spec.ecs_gp9_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp9_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp9_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00110_element_check_00087 **********\n\n");
    });

    test('00111_element_check_00088', () async {
      print("\n********** テスト実行：00111_element_check_00088 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_2_0;
      print(ecs_spec.ecs_spec.ecs_gp9_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00111_element_check_00088 **********\n\n");
    });

    test('00112_element_check_00089', () async {
      print("\n********** テスト実行：00112_element_check_00089 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_4_0;
      print(ecs_spec.ecs_spec.ecs_gp9_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00112_element_check_00089 **********\n\n");
    });

    test('00113_element_check_00090', () async {
      print("\n********** テスト実行：00113_element_check_00090 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_4_2;
      print(ecs_spec.ecs_spec.ecs_gp9_4_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_4_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_4_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_4_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_4_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_4_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp9_4_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_4_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_4_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp9_4_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_4_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00113_element_check_00090 **********\n\n");
    });

    test('00114_element_check_00091', () async {
      print("\n********** テスト実行：00114_element_check_00091 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_5_0;
      print(ecs_spec.ecs_spec.ecs_gp9_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00114_element_check_00091 **********\n\n");
    });

    test('00115_element_check_00092', () async {
      print("\n********** テスト実行：00115_element_check_00092 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_5_1;
      print(ecs_spec.ecs_spec.ecs_gp9_5_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_5_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_5_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_5_1);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_5_1);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00115_element_check_00092 **********\n\n");
    });

    test('00116_element_check_00093', () async {
      print("\n********** テスト実行：00116_element_check_00093 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_5_2;
      print(ecs_spec.ecs_spec.ecs_gp9_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00116_element_check_00093 **********\n\n");
    });

    test('00117_element_check_00094', () async {
      print("\n********** テスト実行：00117_element_check_00094 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp9_5_3;
      print(ecs_spec.ecs_spec.ecs_gp9_5_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp9_5_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp9_5_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp9_5_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp9_5_3);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp9_5_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp9_5_3);
      expect(ecs_spec.ecs_spec.ecs_gp9_5_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp9_5_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00117_element_check_00094 **********\n\n");
    });

    test('00118_element_check_00095', () async {
      print("\n********** テスト実行：00118_element_check_00095 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_1_0;
      print(ecs_spec.ecs_spec.ecs_gpa_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00118_element_check_00095 **********\n\n");
    });

    test('00119_element_check_00096', () async {
      print("\n********** テスト実行：00119_element_check_00096 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_1_1;
      print(ecs_spec.ecs_spec.ecs_gpa_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_1_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_1_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00119_element_check_00096 **********\n\n");
    });

    test('00120_element_check_00097', () async {
      print("\n********** テスト実行：00120_element_check_00097 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_1_2;
      print(ecs_spec.ecs_spec.ecs_gpa_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpa_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpa_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00120_element_check_00097 **********\n\n");
    });

    test('00121_element_check_00098', () async {
      print("\n********** テスト実行：00121_element_check_00098 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_2_0;
      print(ecs_spec.ecs_spec.ecs_gpa_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00121_element_check_00098 **********\n\n");
    });

    test('00122_element_check_00099', () async {
      print("\n********** テスト実行：00122_element_check_00099 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_2_1;
      print(ecs_spec.ecs_spec.ecs_gpa_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_2_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_2_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00122_element_check_00099 **********\n\n");
    });

    test('00123_element_check_00100', () async {
      print("\n********** テスト実行：00123_element_check_00100 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_2_2;
      print(ecs_spec.ecs_spec.ecs_gpa_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_2_2);
      expect(ecs_spec.ecs_spec.ecs_gpa_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_2_2);
      expect(ecs_spec.ecs_spec.ecs_gpa_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00123_element_check_00100 **********\n\n");
    });

    test('00124_element_check_00101', () async {
      print("\n********** テスト実行：00124_element_check_00101 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_3_0;
      print(ecs_spec.ecs_spec.ecs_gpa_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00124_element_check_00101 **********\n\n");
    });

    test('00125_element_check_00102', () async {
      print("\n********** テスト実行：00125_element_check_00102 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_3_1;
      print(ecs_spec.ecs_spec.ecs_gpa_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_3_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_3_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00125_element_check_00102 **********\n\n");
    });

    test('00126_element_check_00103', () async {
      print("\n********** テスト実行：00126_element_check_00103 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_3_2;
      print(ecs_spec.ecs_spec.ecs_gpa_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpa_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpa_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00126_element_check_00103 **********\n\n");
    });

    test('00127_element_check_00104', () async {
      print("\n********** テスト実行：00127_element_check_00104 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_4_0;
      print(ecs_spec.ecs_spec.ecs_gpa_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00127_element_check_00104 **********\n\n");
    });

    test('00128_element_check_00105', () async {
      print("\n********** テスト実行：00128_element_check_00105 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_4_3;
      print(ecs_spec.ecs_spec.ecs_gpa_4_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_4_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_4_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_4_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_4_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_4_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_4_3);
      expect(ecs_spec.ecs_spec.ecs_gpa_4_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_4_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_4_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_4_3);
      expect(ecs_spec.ecs_spec.ecs_gpa_4_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_4_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00128_element_check_00105 **********\n\n");
    });

    test('00129_element_check_00106', () async {
      print("\n********** テスト実行：00129_element_check_00106 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_5_0;
      print(ecs_spec.ecs_spec.ecs_gpa_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpa_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00129_element_check_00106 **********\n\n");
    });

    test('00130_element_check_00107', () async {
      print("\n********** テスト実行：00130_element_check_00107 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpa_5_1;
      print(ecs_spec.ecs_spec.ecs_gpa_5_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpa_5_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpa_5_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_5_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpa_5_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpa_5_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpa_5_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_5_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_5_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpa_5_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpa_5_1);
      expect(ecs_spec.ecs_spec.ecs_gpa_5_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpa_5_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00130_element_check_00107 **********\n\n");
    });

    test('00131_element_check_00108', () async {
      print("\n********** テスト実行：00131_element_check_00108 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_1_0;
      print(ecs_spec.ecs_spec.ecs_gpb_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00131_element_check_00108 **********\n\n");
    });

    test('00132_element_check_00109', () async {
      print("\n********** テスト実行：00132_element_check_00109 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_1_2;
      print(ecs_spec.ecs_spec.ecs_gpb_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00132_element_check_00109 **********\n\n");
    });

    test('00133_element_check_00110', () async {
      print("\n********** テスト実行：00133_element_check_00110 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_2_0;
      print(ecs_spec.ecs_spec.ecs_gpb_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00133_element_check_00110 **********\n\n");
    });

    test('00134_element_check_00111', () async {
      print("\n********** テスト実行：00134_element_check_00111 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_2_1;
      print(ecs_spec.ecs_spec.ecs_gpb_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_2_1);
      expect(ecs_spec.ecs_spec.ecs_gpb_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_2_1);
      expect(ecs_spec.ecs_spec.ecs_gpb_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00134_element_check_00111 **********\n\n");
    });

    test('00135_element_check_00112', () async {
      print("\n********** テスト実行：00135_element_check_00112 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_2_2;
      print(ecs_spec.ecs_spec.ecs_gpb_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_2_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_2_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00135_element_check_00112 **********\n\n");
    });

    test('00136_element_check_00113', () async {
      print("\n********** テスト実行：00136_element_check_00113 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_3_0;
      print(ecs_spec.ecs_spec.ecs_gpb_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00136_element_check_00113 **********\n\n");
    });

    test('00137_element_check_00114', () async {
      print("\n********** テスト実行：00137_element_check_00114 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_3_2;
      print(ecs_spec.ecs_spec.ecs_gpb_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00137_element_check_00114 **********\n\n");
    });

    test('00138_element_check_00115', () async {
      print("\n********** テスト実行：00138_element_check_00115 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_4_0;
      print(ecs_spec.ecs_spec.ecs_gpb_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00138_element_check_00115 **********\n\n");
    });

    test('00139_element_check_00116', () async {
      print("\n********** テスト実行：00139_element_check_00116 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_4_2;
      print(ecs_spec.ecs_spec.ecs_gpb_4_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_4_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_4_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_4_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_4_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_4_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_4_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_4_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_4_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_4_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_4_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_4_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_4_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00139_element_check_00116 **********\n\n");
    });

    test('00140_element_check_00117', () async {
      print("\n********** テスト実行：00140_element_check_00117 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_4_3;
      print(ecs_spec.ecs_spec.ecs_gpb_4_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_4_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_4_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_4_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_4_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_4_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_4_3);
      expect(ecs_spec.ecs_spec.ecs_gpb_4_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_4_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_4_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_4_3);
      expect(ecs_spec.ecs_spec.ecs_gpb_4_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_4_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00140_element_check_00117 **********\n\n");
    });

    test('00141_element_check_00118', () async {
      print("\n********** テスト実行：00141_element_check_00118 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_5_0;
      print(ecs_spec.ecs_spec.ecs_gpb_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpb_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00141_element_check_00118 **********\n\n");
    });

    test('00142_element_check_00119', () async {
      print("\n********** テスト実行：00142_element_check_00119 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpb_5_2;
      print(ecs_spec.ecs_spec.ecs_gpb_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpb_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpb_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpb_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpb_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpb_5_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpb_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpb_5_2);
      expect(ecs_spec.ecs_spec.ecs_gpb_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpb_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00142_element_check_00119 **********\n\n");
    });

    test('00143_element_check_00120', () async {
      print("\n********** テスト実行：00143_element_check_00120 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_1_0;
      print(ecs_spec.ecs_spec.ecs_gpc_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00143_element_check_00120 **********\n\n");
    });

    test('00144_element_check_00121', () async {
      print("\n********** テスト実行：00144_element_check_00121 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_3_0;
      print(ecs_spec.ecs_spec.ecs_gpc_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00144_element_check_00121 **********\n\n");
    });

    test('00145_element_check_00122', () async {
      print("\n********** テスト実行：00145_element_check_00122 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_3_2;
      print(ecs_spec.ecs_spec.ecs_gpc_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpc_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpc_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00145_element_check_00122 **********\n\n");
    });

    test('00146_element_check_00123', () async {
      print("\n********** テスト実行：00146_element_check_00123 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_3_3;
      print(ecs_spec.ecs_spec.ecs_gpc_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_3_3);
      expect(ecs_spec.ecs_spec.ecs_gpc_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_3_3);
      expect(ecs_spec.ecs_spec.ecs_gpc_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00146_element_check_00123 **********\n\n");
    });

    test('00147_element_check_00124', () async {
      print("\n********** テスト実行：00147_element_check_00124 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_4_0;
      print(ecs_spec.ecs_spec.ecs_gpc_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00147_element_check_00124 **********\n\n");
    });

    test('00148_element_check_00125', () async {
      print("\n********** テスト実行：00148_element_check_00125 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_4_3;
      print(ecs_spec.ecs_spec.ecs_gpc_4_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_4_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_4_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_4_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_4_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_4_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_4_3);
      expect(ecs_spec.ecs_spec.ecs_gpc_4_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_4_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_4_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_4_3);
      expect(ecs_spec.ecs_spec.ecs_gpc_4_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_4_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00148_element_check_00125 **********\n\n");
    });

    test('00149_element_check_00126', () async {
      print("\n********** テスト実行：00149_element_check_00126 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_5_0;
      print(ecs_spec.ecs_spec.ecs_gpc_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00149_element_check_00126 **********\n\n");
    });

    test('00150_element_check_00127', () async {
      print("\n********** テスト実行：00150_element_check_00127 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_5_1;
      print(ecs_spec.ecs_spec.ecs_gpc_5_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_5_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_5_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_5_1);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_5_1);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00150_element_check_00127 **********\n\n");
    });

    test('00151_element_check_00128', () async {
      print("\n********** テスト実行：00151_element_check_00128 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_5_2;
      print(ecs_spec.ecs_spec.ecs_gpc_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_5_2);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_5_2);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00151_element_check_00128 **********\n\n");
    });

    test('00152_element_check_00129', () async {
      print("\n********** テスト実行：00152_element_check_00129 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpc_5_3;
      print(ecs_spec.ecs_spec.ecs_gpc_5_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpc_5_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpc_5_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpc_5_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpc_5_3);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpc_5_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpc_5_3);
      expect(ecs_spec.ecs_spec.ecs_gpc_5_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpc_5_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00152_element_check_00129 **********\n\n");
    });

    test('00153_element_check_00130', () async {
      print("\n********** テスト実行：00153_element_check_00130 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_1_0;
      print(ecs_spec.ecs_spec.ecs_gpd_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00153_element_check_00130 **********\n\n");
    });

    test('00154_element_check_00131', () async {
      print("\n********** テスト実行：00154_element_check_00131 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_1_2;
      print(ecs_spec.ecs_spec.ecs_gpd_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpd_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpd_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00154_element_check_00131 **********\n\n");
    });

    test('00155_element_check_00132', () async {
      print("\n********** テスト実行：00155_element_check_00132 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_2_0;
      print(ecs_spec.ecs_spec.ecs_gpd_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00155_element_check_00132 **********\n\n");
    });

    test('00156_element_check_00133', () async {
      print("\n********** テスト実行：00156_element_check_00133 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_2_3;
      print(ecs_spec.ecs_spec.ecs_gpd_2_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_2_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_2_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_2_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_2_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_2_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_2_3);
      expect(ecs_spec.ecs_spec.ecs_gpd_2_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_2_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_2_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_2_3);
      expect(ecs_spec.ecs_spec.ecs_gpd_2_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_2_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00156_element_check_00133 **********\n\n");
    });

    test('00157_element_check_00134', () async {
      print("\n********** テスト実行：00157_element_check_00134 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_3_0;
      print(ecs_spec.ecs_spec.ecs_gpd_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00157_element_check_00134 **********\n\n");
    });

    test('00158_element_check_00135', () async {
      print("\n********** テスト実行：00158_element_check_00135 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_3_2;
      print(ecs_spec.ecs_spec.ecs_gpd_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpd_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_3_2);
      expect(ecs_spec.ecs_spec.ecs_gpd_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00158_element_check_00135 **********\n\n");
    });

    test('00159_element_check_00136', () async {
      print("\n********** テスト実行：00159_element_check_00136 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_4_0;
      print(ecs_spec.ecs_spec.ecs_gpd_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00159_element_check_00136 **********\n\n");
    });

    test('00160_element_check_00137', () async {
      print("\n********** テスト実行：00160_element_check_00137 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_5_0;
      print(ecs_spec.ecs_spec.ecs_gpd_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpd_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00160_element_check_00137 **********\n\n");
    });

    test('00161_element_check_00138', () async {
      print("\n********** テスト実行：00161_element_check_00138 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_5_1;
      print(ecs_spec.ecs_spec.ecs_gpd_5_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_5_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_5_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_5_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_5_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_5_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_5_1);
      expect(ecs_spec.ecs_spec.ecs_gpd_5_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_5_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_5_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_5_1);
      expect(ecs_spec.ecs_spec.ecs_gpd_5_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_5_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00161_element_check_00138 **********\n\n");
    });

    test('00162_element_check_00139', () async {
      print("\n********** テスト実行：00162_element_check_00139 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpd_5_3;
      print(ecs_spec.ecs_spec.ecs_gpd_5_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpd_5_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpd_5_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_5_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpd_5_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpd_5_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpd_5_3);
      expect(ecs_spec.ecs_spec.ecs_gpd_5_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_5_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpd_5_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpd_5_3);
      expect(ecs_spec.ecs_spec.ecs_gpd_5_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpd_5_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00162_element_check_00139 **********\n\n");
    });

    test('00163_element_check_00140', () async {
      print("\n********** テスト実行：00163_element_check_00140 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_1_0;
      print(ecs_spec.ecs_spec.ecs_gpe_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00163_element_check_00140 **********\n\n");
    });

    test('00164_element_check_00141', () async {
      print("\n********** テスト実行：00164_element_check_00141 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_1_3;
      print(ecs_spec.ecs_spec.ecs_gpe_1_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_1_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_1_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_1_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_1_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_1_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_1_3);
      expect(ecs_spec.ecs_spec.ecs_gpe_1_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_1_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_1_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_1_3);
      expect(ecs_spec.ecs_spec.ecs_gpe_1_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_1_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00164_element_check_00141 **********\n\n");
    });

    test('00165_element_check_00142', () async {
      print("\n********** テスト実行：00165_element_check_00142 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_2_0;
      print(ecs_spec.ecs_spec.ecs_gpe_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00165_element_check_00142 **********\n\n");
    });

    test('00166_element_check_00143', () async {
      print("\n********** テスト実行：00166_element_check_00143 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_2_2;
      print(ecs_spec.ecs_spec.ecs_gpe_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_2_2);
      expect(ecs_spec.ecs_spec.ecs_gpe_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_2_2);
      expect(ecs_spec.ecs_spec.ecs_gpe_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00166_element_check_00143 **********\n\n");
    });

    test('00167_element_check_00144', () async {
      print("\n********** テスト実行：00167_element_check_00144 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_2_3;
      print(ecs_spec.ecs_spec.ecs_gpe_2_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_2_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_2_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_2_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_2_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_2_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_2_3);
      expect(ecs_spec.ecs_spec.ecs_gpe_2_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_2_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_2_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_2_3);
      expect(ecs_spec.ecs_spec.ecs_gpe_2_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_2_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00167_element_check_00144 **********\n\n");
    });

    test('00168_element_check_00145', () async {
      print("\n********** テスト実行：00168_element_check_00145 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_3_0;
      print(ecs_spec.ecs_spec.ecs_gpe_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_3_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00168_element_check_00145 **********\n\n");
    });

    test('00169_element_check_00146', () async {
      print("\n********** テスト実行：00169_element_check_00146 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_3_1;
      print(ecs_spec.ecs_spec.ecs_gpe_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_3_1);
      expect(ecs_spec.ecs_spec.ecs_gpe_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_3_1);
      expect(ecs_spec.ecs_spec.ecs_gpe_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00169_element_check_00146 **********\n\n");
    });

    test('00170_element_check_00147', () async {
      print("\n********** テスト実行：00170_element_check_00147 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_3_3;
      print(ecs_spec.ecs_spec.ecs_gpe_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_3_3);
      expect(ecs_spec.ecs_spec.ecs_gpe_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_3_3);
      expect(ecs_spec.ecs_spec.ecs_gpe_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00170_element_check_00147 **********\n\n");
    });

    test('00171_element_check_00148', () async {
      print("\n********** テスト実行：00171_element_check_00148 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_4_0;
      print(ecs_spec.ecs_spec.ecs_gpe_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_4_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00171_element_check_00148 **********\n\n");
    });

    test('00172_element_check_00149', () async {
      print("\n********** テスト実行：00172_element_check_00149 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_4_1;
      print(ecs_spec.ecs_spec.ecs_gpe_4_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_4_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_4_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_4_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_4_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_4_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_4_1);
      expect(ecs_spec.ecs_spec.ecs_gpe_4_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_4_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_4_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_4_1);
      expect(ecs_spec.ecs_spec.ecs_gpe_4_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_4_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00172_element_check_00149 **********\n\n");
    });

    test('00173_element_check_00150', () async {
      print("\n********** テスト実行：00173_element_check_00150 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpe_5_0;
      print(ecs_spec.ecs_spec.ecs_gpe_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpe_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpe_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpe_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpe_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpe_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpe_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpe_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpe_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpe_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00173_element_check_00150 **********\n\n");
    });

    test('00174_element_check_00151', () async {
      print("\n********** テスト実行：00174_element_check_00151 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpf_1_0;
      print(ecs_spec.ecs_spec.ecs_gpf_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpf_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpf_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpf_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpf_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpf_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpf_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpf_1_0);
      expect(ecs_spec.ecs_spec.ecs_gpf_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00174_element_check_00151 **********\n\n");
    });

    test('00175_element_check_00152', () async {
      print("\n********** テスト実行：00175_element_check_00152 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpf_1_1;
      print(ecs_spec.ecs_spec.ecs_gpf_1_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpf_1_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpf_1_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_1_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_1_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpf_1_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpf_1_1);
      expect(ecs_spec.ecs_spec.ecs_gpf_1_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_1_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpf_1_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpf_1_1);
      expect(ecs_spec.ecs_spec.ecs_gpf_1_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_1_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00175_element_check_00152 **********\n\n");
    });

    test('00176_element_check_00153', () async {
      print("\n********** テスト実行：00176_element_check_00153 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpf_1_2;
      print(ecs_spec.ecs_spec.ecs_gpf_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpf_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpf_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpf_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpf_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpf_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpf_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpf_1_2);
      expect(ecs_spec.ecs_spec.ecs_gpf_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00176_element_check_00153 **********\n\n");
    });

    test('00177_element_check_00154', () async {
      print("\n********** テスト実行：00177_element_check_00154 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpf_2_0;
      print(ecs_spec.ecs_spec.ecs_gpf_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpf_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpf_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpf_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpf_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpf_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpf_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpf_2_0);
      expect(ecs_spec.ecs_spec.ecs_gpf_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00177_element_check_00154 **********\n\n");
    });

    test('00178_element_check_00155', () async {
      print("\n********** テスト実行：00178_element_check_00155 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gpf_5_0;
      print(ecs_spec.ecs_spec.ecs_gpf_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gpf_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gpf_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gpf_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gpf_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gpf_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpf_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gpf_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gpf_5_0);
      expect(ecs_spec.ecs_spec.ecs_gpf_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gpf_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00178_element_check_00155 **********\n\n");
    });

    test('00179_element_check_00156', () async {
      print("\n********** テスト実行：00179_element_check_00156 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp11_2_0;
      print(ecs_spec.ecs_spec.ecs_gp11_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp11_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp11_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp11_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp11_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp11_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp11_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp11_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp11_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp11_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp11_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp11_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp11_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00179_element_check_00156 **********\n\n");
    });

    test('00180_element_check_00157', () async {
      print("\n********** テスト実行：00180_element_check_00157 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp11_2_2;
      print(ecs_spec.ecs_spec.ecs_gp11_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp11_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp11_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp11_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp11_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp11_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp11_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp11_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp11_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp11_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp11_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp11_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp11_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00180_element_check_00157 **********\n\n");
    });

    test('00181_element_check_00158', () async {
      print("\n********** テスト実行：00181_element_check_00158 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp12_1_0;
      print(ecs_spec.ecs_spec.ecs_gp12_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp12_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp12_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp12_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp12_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp12_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp12_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp12_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp12_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00181_element_check_00158 **********\n\n");
    });

    test('00182_element_check_00159', () async {
      print("\n********** テスト実行：00182_element_check_00159 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp12_3_0;
      print(ecs_spec.ecs_spec.ecs_gp12_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp12_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp12_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp12_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp12_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00182_element_check_00159 **********\n\n");
    });

    test('00183_element_check_00160', () async {
      print("\n********** テスト実行：00183_element_check_00160 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp12_3_1;
      print(ecs_spec.ecs_spec.ecs_gp12_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp12_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp12_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp12_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp12_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00183_element_check_00160 **********\n\n");
    });

    test('00184_element_check_00161', () async {
      print("\n********** テスト実行：00184_element_check_00161 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp12_3_2;
      print(ecs_spec.ecs_spec.ecs_gp12_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp12_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp12_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp12_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp12_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00184_element_check_00161 **********\n\n");
    });

    test('00185_element_check_00162', () async {
      print("\n********** テスト実行：00185_element_check_00162 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp12_3_3;
      print(ecs_spec.ecs_spec.ecs_gp12_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp12_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp12_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp12_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp12_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp12_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp12_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00185_element_check_00162 **********\n\n");
    });

    test('00186_element_check_00163', () async {
      print("\n********** テスト実行：00186_element_check_00163 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp12_4_0;
      print(ecs_spec.ecs_spec.ecs_gp12_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp12_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp12_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp12_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp12_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp12_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp12_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp12_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp12_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp12_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp12_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00186_element_check_00163 **********\n\n");
    });

    test('00187_element_check_00164', () async {
      print("\n********** テスト実行：00187_element_check_00164 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp13_1_0;
      print(ecs_spec.ecs_spec.ecs_gp13_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp13_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp13_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp13_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp13_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp13_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp13_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00187_element_check_00164 **********\n\n");
    });

    test('00188_element_check_00165', () async {
      print("\n********** テスト実行：00188_element_check_00165 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp13_2_0;
      print(ecs_spec.ecs_spec.ecs_gp13_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp13_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp13_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp13_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp13_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp13_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp13_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00188_element_check_00165 **********\n\n");
    });

    test('00189_element_check_00166', () async {
      print("\n********** テスト実行：00189_element_check_00166 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp13_2_2;
      print(ecs_spec.ecs_spec.ecs_gp13_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp13_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp13_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp13_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp13_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp13_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp13_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp13_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp13_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00189_element_check_00166 **********\n\n");
    });

    test('00190_element_check_00167', () async {
      print("\n********** テスト実行：00190_element_check_00167 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp13_3_0;
      print(ecs_spec.ecs_spec.ecs_gp13_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp13_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp13_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp13_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp13_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp13_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp13_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00190_element_check_00167 **********\n\n");
    });

    test('00191_element_check_00168', () async {
      print("\n********** テスト実行：00191_element_check_00168 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp13_4_0;
      print(ecs_spec.ecs_spec.ecs_gp13_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp13_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp13_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp13_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp13_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp13_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp13_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00191_element_check_00168 **********\n\n");
    });

    test('00192_element_check_00169', () async {
      print("\n********** テスト実行：00192_element_check_00169 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp13_5_0;
      print(ecs_spec.ecs_spec.ecs_gp13_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp13_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp13_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp13_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp13_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp13_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp13_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp13_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp13_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp13_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00192_element_check_00169 **********\n\n");
    });

    test('00193_element_check_00170', () async {
      print("\n********** テスト実行：00193_element_check_00170 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_2_0;
      print(ecs_spec.ecs_spec.ecs_gp14_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp14_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp14_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00193_element_check_00170 **********\n\n");
    });

    test('00194_element_check_00171', () async {
      print("\n********** テスト実行：00194_element_check_00171 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_2_1;
      print(ecs_spec.ecs_spec.ecs_gp14_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp14_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp14_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00194_element_check_00171 **********\n\n");
    });

    test('00195_element_check_00172', () async {
      print("\n********** テスト実行：00195_element_check_00172 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_2_2;
      print(ecs_spec.ecs_spec.ecs_gp14_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp14_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp14_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00195_element_check_00172 **********\n\n");
    });

    test('00196_element_check_00173', () async {
      print("\n********** テスト実行：00196_element_check_00173 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_3_0;
      print(ecs_spec.ecs_spec.ecs_gp14_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00196_element_check_00173 **********\n\n");
    });

    test('00197_element_check_00174', () async {
      print("\n********** テスト実行：00197_element_check_00174 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_3_1;
      print(ecs_spec.ecs_spec.ecs_gp14_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00197_element_check_00174 **********\n\n");
    });

    test('00198_element_check_00175', () async {
      print("\n********** テスト実行：00198_element_check_00175 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_3_2;
      print(ecs_spec.ecs_spec.ecs_gp14_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00198_element_check_00175 **********\n\n");
    });

    test('00199_element_check_00176', () async {
      print("\n********** テスト実行：00199_element_check_00176 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_3_3;
      print(ecs_spec.ecs_spec.ecs_gp14_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp14_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00199_element_check_00176 **********\n\n");
    });

    test('00200_element_check_00177', () async {
      print("\n********** テスト実行：00200_element_check_00177 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp14_4_0;
      print(ecs_spec.ecs_spec.ecs_gp14_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp14_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp14_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp14_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp14_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp14_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp14_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp14_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp14_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp14_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp14_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00200_element_check_00177 **********\n\n");
    });

    test('00201_element_check_00178', () async {
      print("\n********** テスト実行：00201_element_check_00178 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp15_1_0;
      print(ecs_spec.ecs_spec.ecs_gp15_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp15_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp15_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp15_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp15_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp15_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp15_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00201_element_check_00178 **********\n\n");
    });

    test('00202_element_check_00179', () async {
      print("\n********** テスト実行：00202_element_check_00179 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp15_1_2;
      print(ecs_spec.ecs_spec.ecs_gp15_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp15_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp15_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp15_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp15_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp15_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp15_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp15_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp15_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00202_element_check_00179 **********\n\n");
    });

    test('00203_element_check_00180', () async {
      print("\n********** テスト実行：00203_element_check_00180 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp15_2_0;
      print(ecs_spec.ecs_spec.ecs_gp15_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp15_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp15_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp15_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp15_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp15_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp15_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00203_element_check_00180 **********\n\n");
    });

    test('00204_element_check_00181', () async {
      print("\n********** テスト実行：00204_element_check_00181 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp15_3_0;
      print(ecs_spec.ecs_spec.ecs_gp15_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp15_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp15_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp15_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp15_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp15_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp15_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00204_element_check_00181 **********\n\n");
    });

    test('00205_element_check_00182', () async {
      print("\n********** テスト実行：00205_element_check_00182 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp15_5_0;
      print(ecs_spec.ecs_spec.ecs_gp15_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp15_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp15_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp15_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp15_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp15_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp15_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp15_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp15_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp15_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00205_element_check_00182 **********\n\n");
    });

    test('00206_element_check_00183', () async {
      print("\n********** テスト実行：00206_element_check_00183 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp17_1_0;
      print(ecs_spec.ecs_spec.ecs_gp17_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp17_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp17_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp17_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp17_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp17_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp17_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp17_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp17_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00206_element_check_00183 **********\n\n");
    });

    test('00207_element_check_00184', () async {
      print("\n********** テスト実行：00207_element_check_00184 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp17_1_2;
      print(ecs_spec.ecs_spec.ecs_gp17_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp17_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp17_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp17_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp17_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp17_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp17_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp17_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp17_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00207_element_check_00184 **********\n\n");
    });

    test('00208_element_check_00185', () async {
      print("\n********** テスト実行：00208_element_check_00185 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp17_1_3;
      print(ecs_spec.ecs_spec.ecs_gp17_1_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp17_1_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp17_1_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_1_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_1_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp17_1_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp17_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp17_1_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_1_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp17_1_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp17_1_3);
      expect(ecs_spec.ecs_spec.ecs_gp17_1_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_1_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00208_element_check_00185 **********\n\n");
    });

    test('00209_element_check_00186', () async {
      print("\n********** テスト実行：00209_element_check_00186 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp17_2_0;
      print(ecs_spec.ecs_spec.ecs_gp17_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp17_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp17_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp17_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp17_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp17_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp17_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp17_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp17_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00209_element_check_00186 **********\n\n");
    });

    test('00210_element_check_00187', () async {
      print("\n********** テスト実行：00210_element_check_00187 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp17_2_1;
      print(ecs_spec.ecs_spec.ecs_gp17_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp17_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp17_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp17_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp17_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp17_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp17_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp17_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp17_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00210_element_check_00187 **********\n\n");
    });

    test('00211_element_check_00188', () async {
      print("\n********** テスト実行：00211_element_check_00188 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp17_5_0;
      print(ecs_spec.ecs_spec.ecs_gp17_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp17_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp17_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp17_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp17_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp17_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp17_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp17_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp17_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp17_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp17_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00211_element_check_00188 **********\n\n");
    });

    test('00212_element_check_00189', () async {
      print("\n********** テスト実行：00212_element_check_00189 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_2_0;
      print(ecs_spec.ecs_spec.ecs_gp18_2_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_2_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_2_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_2_0);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00212_element_check_00189 **********\n\n");
    });

    test('00213_element_check_00190', () async {
      print("\n********** テスト実行：00213_element_check_00190 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_2_1;
      print(ecs_spec.ecs_spec.ecs_gp18_2_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_2_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_2_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_2_1);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00213_element_check_00190 **********\n\n");
    });

    test('00214_element_check_00191', () async {
      print("\n********** テスト実行：00214_element_check_00191 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_2_2;
      print(ecs_spec.ecs_spec.ecs_gp18_2_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_2_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_2_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_2_2);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00214_element_check_00191 **********\n\n");
    });

    test('00215_element_check_00192', () async {
      print("\n********** テスト実行：00215_element_check_00192 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_2_3;
      print(ecs_spec.ecs_spec.ecs_gp18_2_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_2_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_2_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_2_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_2_3);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_2_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_2_3);
      expect(ecs_spec.ecs_spec.ecs_gp18_2_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_2_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00215_element_check_00192 **********\n\n");
    });

    test('00216_element_check_00193', () async {
      print("\n********** テスト実行：00216_element_check_00193 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_3_0;
      print(ecs_spec.ecs_spec.ecs_gp18_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00216_element_check_00193 **********\n\n");
    });

    test('00217_element_check_00194', () async {
      print("\n********** テスト実行：00217_element_check_00194 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_3_1;
      print(ecs_spec.ecs_spec.ecs_gp18_3_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_3_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_3_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_3_1);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00217_element_check_00194 **********\n\n");
    });

    test('00218_element_check_00195', () async {
      print("\n********** テスト実行：00218_element_check_00195 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_3_2;
      print(ecs_spec.ecs_spec.ecs_gp18_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00218_element_check_00195 **********\n\n");
    });

    test('00219_element_check_00196', () async {
      print("\n********** テスト実行：00219_element_check_00196 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_3_3;
      print(ecs_spec.ecs_spec.ecs_gp18_3_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_3_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_3_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_3_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_3_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_3_3);
      expect(ecs_spec.ecs_spec.ecs_gp18_3_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_3_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00219_element_check_00196 **********\n\n");
    });

    test('00220_element_check_00197', () async {
      print("\n********** テスト実行：00220_element_check_00197 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_4_2;
      print(ecs_spec.ecs_spec.ecs_gp18_4_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_4_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_4_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_4_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_4_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_4_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp18_4_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_4_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_4_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_4_2);
      expect(ecs_spec.ecs_spec.ecs_gp18_4_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_4_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00220_element_check_00197 **********\n\n");
    });

    test('00221_element_check_00198', () async {
      print("\n********** テスト実行：00221_element_check_00198 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_4_3;
      print(ecs_spec.ecs_spec.ecs_gp18_4_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_4_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_4_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_4_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_4_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_4_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_4_3);
      expect(ecs_spec.ecs_spec.ecs_gp18_4_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_4_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_4_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_4_3);
      expect(ecs_spec.ecs_spec.ecs_gp18_4_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_4_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00221_element_check_00198 **********\n\n");
    });

    test('00222_element_check_00199', () async {
      print("\n********** テスト実行：00222_element_check_00199 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp18_5_0;
      print(ecs_spec.ecs_spec.ecs_gp18_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp18_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp18_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp18_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp18_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp18_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp18_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp18_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp18_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp18_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp18_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00222_element_check_00199 **********\n\n");
    });

    test('00223_element_check_00200', () async {
      print("\n********** テスト実行：00223_element_check_00200 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp19_1_0;
      print(ecs_spec.ecs_spec.ecs_gp19_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp19_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp19_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp19_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp19_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp19_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp19_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp19_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp19_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00223_element_check_00200 **********\n\n");
    });

    test('00224_element_check_00201', () async {
      print("\n********** テスト実行：00224_element_check_00201 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp19_3_2;
      print(ecs_spec.ecs_spec.ecs_gp19_3_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp19_3_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp19_3_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_3_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_3_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp19_3_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp19_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp19_3_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_3_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp19_3_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp19_3_2);
      expect(ecs_spec.ecs_spec.ecs_gp19_3_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_3_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00224_element_check_00201 **********\n\n");
    });

    test('00225_element_check_00202', () async {
      print("\n********** テスト実行：00225_element_check_00202 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp19_4_0;
      print(ecs_spec.ecs_spec.ecs_gp19_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp19_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp19_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp19_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp19_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp19_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp19_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp19_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp19_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00225_element_check_00202 **********\n\n");
    });

    test('00226_element_check_00203', () async {
      print("\n********** テスト実行：00226_element_check_00203 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp19_5_0;
      print(ecs_spec.ecs_spec.ecs_gp19_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp19_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp19_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp19_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp19_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp19_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp19_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp19_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp19_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp19_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp19_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00226_element_check_00203 **********\n\n");
    });

    test('00227_element_check_00204', () async {
      print("\n********** テスト実行：00227_element_check_00204 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_1_2;
      print(ecs_spec.ecs_spec.ecs_gp1a_1_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_1_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_1_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_1_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_1_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_1_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp1a_1_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_1_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_1_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_1_2);
      expect(ecs_spec.ecs_spec.ecs_gp1a_1_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_1_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00227_element_check_00204 **********\n\n");
    });

    test('00228_element_check_00205', () async {
      print("\n********** テスト実行：00228_element_check_00205 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_3_0;
      print(ecs_spec.ecs_spec.ecs_gp1a_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp1a_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp1a_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00228_element_check_00205 **********\n\n");
    });

    test('00229_element_check_00206', () async {
      print("\n********** テスト実行：00229_element_check_00206 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_4_0;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00229_element_check_00206 **********\n\n");
    });

    test('00230_element_check_00207', () async {
      print("\n********** テスト実行：00230_element_check_00207 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_4_3;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_3);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_4_3 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_3);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_3 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_3 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_4_3 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_3);
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_3 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_3 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_4_3 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_4_3);
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_3 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_4_3 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00230_element_check_00207 **********\n\n");
    });

    test('00231_element_check_00208', () async {
      print("\n********** テスト実行：00231_element_check_00208 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_5_0;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00231_element_check_00208 **********\n\n");
    });

    test('00232_element_check_00209', () async {
      print("\n********** テスト実行：00232_element_check_00209 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_5_1;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_1);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_5_1 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_1);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_1 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_1 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_5_1 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_1);
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_1 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_1 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_5_1 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_1);
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_1 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_1 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00232_element_check_00209 **********\n\n");
    });

    test('00233_element_check_00210', () async {
      print("\n********** テスト実行：00233_element_check_00210 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1a_5_2;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1a_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1a_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1a_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1a_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1a_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00233_element_check_00210 **********\n\n");
    });

    test('00234_element_check_00211', () async {
      print("\n********** テスト実行：00234_element_check_00211 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1e_1_0;
      print(ecs_spec.ecs_spec.ecs_gp1e_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1e_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1e_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1e_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1e_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1e_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1e_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp1e_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1e_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1e_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1e_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp1e_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1e_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00234_element_check_00211 **********\n\n");
    });

    test('00235_element_check_00212', () async {
      print("\n********** テスト実行：00235_element_check_00212 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1e_4_0;
      print(ecs_spec.ecs_spec.ecs_gp1e_4_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1e_4_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1e_4_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1e_4_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1e_4_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1e_4_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1e_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp1e_4_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1e_4_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1e_4_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1e_4_0);
      expect(ecs_spec.ecs_spec.ecs_gp1e_4_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1e_4_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00235_element_check_00212 **********\n\n");
    });

    test('00236_element_check_00213', () async {
      print("\n********** テスト実行：00236_element_check_00213 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1f_1_0;
      print(ecs_spec.ecs_spec.ecs_gp1f_1_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1f_1_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1f_1_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_1_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_1_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1f_1_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1f_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp1f_1_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_1_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1f_1_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1f_1_0);
      expect(ecs_spec.ecs_spec.ecs_gp1f_1_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_1_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00236_element_check_00213 **********\n\n");
    });

    test('00237_element_check_00214', () async {
      print("\n********** テスト実行：00237_element_check_00214 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1f_3_0;
      print(ecs_spec.ecs_spec.ecs_gp1f_3_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1f_3_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1f_3_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_3_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_3_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1f_3_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1f_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp1f_3_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_3_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1f_3_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1f_3_0);
      expect(ecs_spec.ecs_spec.ecs_gp1f_3_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_3_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00237_element_check_00214 **********\n\n");
    });

    test('00238_element_check_00215', () async {
      print("\n********** テスト実行：00238_element_check_00215 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1f_5_0;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_0);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1f_5_0 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_0);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_0 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_0 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1f_5_0 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_0 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_0 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1f_5_0 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_0);
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_0 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_0 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00238_element_check_00215 **********\n\n");
    });

    test('00239_element_check_00216', () async {
      print("\n********** テスト実行：00239_element_check_00216 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.ecs_spec.ecs_gp1f_5_2;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_2);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.ecs_spec.ecs_gp1f_5_2 = testData1;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_2);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_2 == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_2 == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.ecs_spec.ecs_gp1f_5_2 = testData2;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_2 == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_2 == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.ecs_spec.ecs_gp1f_5_2 = defalut;
      print(ecs_spec.ecs_spec.ecs_gp1f_5_2);
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_2 == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.ecs_spec.ecs_gp1f_5_2 == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00239_element_check_00216 **********\n\n");
    });

    test('00240_element_check_00217', () async {
      print("\n********** テスト実行：00240_element_check_00217 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.datetime.save_datetime;
      print(ecs_spec.datetime.save_datetime);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.datetime.save_datetime = testData1s;
      print(ecs_spec.datetime.save_datetime);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.datetime.save_datetime == testData1s, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.datetime.save_datetime == testData1s, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.datetime.save_datetime = testData2s;
      print(ecs_spec.datetime.save_datetime);
      expect(ecs_spec.datetime.save_datetime == testData2s, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.datetime.save_datetime == testData2s, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.datetime.save_datetime = defalut;
      print(ecs_spec.datetime.save_datetime);
      expect(ecs_spec.datetime.save_datetime == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.datetime.save_datetime == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00240_element_check_00217 **********\n\n");
    });

    test('00241_element_check_00218', () async {
      print("\n********** テスト実行：00241_element_check_00218 **********");

      ecs_spec = Ecs_specJsonFile();
      allPropatyCheckInit(ecs_spec);

      // ①loadを実行する。
      await ecs_spec.load();

      // ②指定したプロパティの初期値を取得する。
      final defalut = ecs_spec.datetime.acb_select;
      print(ecs_spec.datetime.acb_select);

      // ②指定したプロパティにテストデータ1を書き込む。
      ecs_spec.datetime.acb_select = testData1;
      print(ecs_spec.datetime.acb_select);

      // ③指定したプロパティにテストデータを書き込み後に読み込み、一致していることを確認する。
      expect(ecs_spec.datetime.acb_select == testData1, true);

      // ④saveを実行後、loadを実行する。
      await ecs_spec.save();
      await ecs_spec.load();

      // ⑤同じプロパティを読み込み、データに変化がないことを確認する。
      expect(ecs_spec.datetime.acb_select == testData1, true);

      // ⑥③～⑤を異なるテストデータで実施する。
      ecs_spec.datetime.acb_select = testData2;
      print(ecs_spec.datetime.acb_select);
      expect(ecs_spec.datetime.acb_select == testData2, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.datetime.acb_select == testData2, true);

      // ⑦③～⑤を手順①で取得した初期値で実施する。
      ecs_spec.datetime.acb_select = defalut;
      print(ecs_spec.datetime.acb_select);
      expect(ecs_spec.datetime.acb_select == defalut, true);
      await ecs_spec.save();
      await ecs_spec.load();
      expect(ecs_spec.datetime.acb_select == defalut, true);

      // ⑧全てのプロパティが初期値になっていることを確認する。
      allPropatyCheck(ecs_spec, true);

      print("********** テスト終了：00241_element_check_00218 **********\n\n");
    });

  });
}

void allPropatyCheckInit(Ecs_specJsonFile test)
{
  expect(test.ecs_spec.ecs_gp0_1_0, 0);
  expect(test.ecs_spec.ecs_gp0_1_2, 0);
  expect(test.ecs_spec.ecs_gp0_2_0, 0);
  expect(test.ecs_spec.ecs_gp0_2_2, 0);
  expect(test.ecs_spec.ecs_gp0_3_0, 0);
  expect(test.ecs_spec.ecs_gp0_3_1, 0);
  expect(test.ecs_spec.ecs_gp0_3_2, 0);
  expect(test.ecs_spec.ecs_gp0_3_3, 0);
  expect(test.ecs_spec.ecs_gp0_4_0, 0);
  expect(test.ecs_spec.ecs_gp0_5_0, 0);
  expect(test.ecs_spec.ecs_gp0_5_2, 0);
  expect(test.ecs_spec.ecs_gp1_1_0, 0);
  expect(test.ecs_spec.ecs_gp1_1_2, 0);
  expect(test.ecs_spec.ecs_gp1_2_0, 0);
  expect(test.ecs_spec.ecs_gp1_2_2, 0);
  expect(test.ecs_spec.ecs_gp1_3_0, 0);
  expect(test.ecs_spec.ecs_gp1_3_1, 0);
  expect(test.ecs_spec.ecs_gp1_3_2, 0);
  expect(test.ecs_spec.ecs_gp1_4_0, 0);
  expect(test.ecs_spec.ecs_gp1_4_2, 0);
  expect(test.ecs_spec.ecs_gp1_4_3, 0);
  expect(test.ecs_spec.ecs_gp1_5_0, 0);
  expect(test.ecs_spec.ecs_gp2_1_0, 0);
  expect(test.ecs_spec.ecs_gp2_1_2, 0);
  expect(test.ecs_spec.ecs_gp2_2_0, 0);
  expect(test.ecs_spec.ecs_gp2_2_2, 0);
  expect(test.ecs_spec.ecs_gp2_3_0, 0);
  expect(test.ecs_spec.ecs_gp2_3_1, 0);
  expect(test.ecs_spec.ecs_gp2_3_2, 0);
  expect(test.ecs_spec.ecs_gp2_4_0, 0);
  expect(test.ecs_spec.ecs_gp2_4_1, 0);
  expect(test.ecs_spec.ecs_gp2_5_0, 0);
  expect(test.ecs_spec.ecs_gp3_1_0, 0);
  expect(test.ecs_spec.ecs_gp3_1_1, 0);
  expect(test.ecs_spec.ecs_gp3_1_2, 0);
  expect(test.ecs_spec.ecs_gp3_1_3, 0);
  expect(test.ecs_spec.ecs_gp3_2_0, 0);
  expect(test.ecs_spec.ecs_gp3_2_1, 0);
  expect(test.ecs_spec.ecs_gp3_2_2, 0);
  expect(test.ecs_spec.ecs_gp3_2_3, 0);
  expect(test.ecs_spec.ecs_gp3_3_0, 0);
  expect(test.ecs_spec.ecs_gp3_3_2, 0);
  expect(test.ecs_spec.ecs_gp3_4_0, 0);
  expect(test.ecs_spec.ecs_gp4_1_0, 0);
  expect(test.ecs_spec.ecs_gp4_1_1, 0);
  expect(test.ecs_spec.ecs_gp4_1_2, 0);
  expect(test.ecs_spec.ecs_gp4_1_3, 0);
  expect(test.ecs_spec.ecs_gp4_2_0, 0);
  expect(test.ecs_spec.ecs_gp4_2_1, 0);
  expect(test.ecs_spec.ecs_gp4_2_2, 0);
  expect(test.ecs_spec.ecs_gp4_2_3, 0);
  expect(test.ecs_spec.ecs_gp4_3_0, 0);
  expect(test.ecs_spec.ecs_gp4_3_1, 0);
  expect(test.ecs_spec.ecs_gp4_3_2, 0);
  expect(test.ecs_spec.ecs_gp4_3_3, 0);
  expect(test.ecs_spec.ecs_gp4_4_0, 0);
  expect(test.ecs_spec.ecs_gp4_4_2, 0);
  expect(test.ecs_spec.ecs_gp5_1_0, 0);
  expect(test.ecs_spec.ecs_gp5_3_0, 0);
  expect(test.ecs_spec.ecs_gp5_5_0, 0);
  expect(test.ecs_spec.ecs_gp5_5_1, 0);
  expect(test.ecs_spec.ecs_gp5_5_2, 0);
  expect(test.ecs_spec.ecs_gp6_1_0, 0);
  expect(test.ecs_spec.ecs_gp6_3_0, 0);
  expect(test.ecs_spec.ecs_gp6_5_0, 0);
  expect(test.ecs_spec.ecs_gp7_1_0, 0);
  expect(test.ecs_spec.ecs_gp7_1_1, 0);
  expect(test.ecs_spec.ecs_gp7_1_2, 0);
  expect(test.ecs_spec.ecs_gp7_2_0, 0);
  expect(test.ecs_spec.ecs_gp7_2_1, 0);
  expect(test.ecs_spec.ecs_gp7_2_2, 0);
  expect(test.ecs_spec.ecs_gp7_3_0, 0);
  expect(test.ecs_spec.ecs_gp7_5_0, 0);
  expect(test.ecs_spec.ecs_gp7_5_2, 0);
  expect(test.ecs_spec.ecs_gp8_1_0, 0);
  expect(test.ecs_spec.ecs_gp8_1_1, 0);
  expect(test.ecs_spec.ecs_gp8_1_3, 0);
  expect(test.ecs_spec.ecs_gp8_2_0, 0);
  expect(test.ecs_spec.ecs_gp8_2_1, 0);
  expect(test.ecs_spec.ecs_gp8_2_2, 0);
  expect(test.ecs_spec.ecs_gp8_3_0, 0);
  expect(test.ecs_spec.ecs_gp8_3_1, 0);
  expect(test.ecs_spec.ecs_gp8_3_2, 0);
  expect(test.ecs_spec.ecs_gp8_4_0, 0);
  expect(test.ecs_spec.ecs_gp9_1_0, 0);
  expect(test.ecs_spec.ecs_gp9_1_1, 0);
  expect(test.ecs_spec.ecs_gp9_1_2, 0);
  expect(test.ecs_spec.ecs_gp9_2_0, 0);
  expect(test.ecs_spec.ecs_gp9_4_0, 0);
  expect(test.ecs_spec.ecs_gp9_4_2, 0);
  expect(test.ecs_spec.ecs_gp9_5_0, 0);
  expect(test.ecs_spec.ecs_gp9_5_1, 0);
  expect(test.ecs_spec.ecs_gp9_5_2, 0);
  expect(test.ecs_spec.ecs_gp9_5_3, 0);
  expect(test.ecs_spec.ecs_gpa_1_0, 0);
  expect(test.ecs_spec.ecs_gpa_1_1, 0);
  expect(test.ecs_spec.ecs_gpa_1_2, 0);
  expect(test.ecs_spec.ecs_gpa_2_0, 0);
  expect(test.ecs_spec.ecs_gpa_2_1, 0);
  expect(test.ecs_spec.ecs_gpa_2_2, 0);
  expect(test.ecs_spec.ecs_gpa_3_0, 0);
  expect(test.ecs_spec.ecs_gpa_3_1, 0);
  expect(test.ecs_spec.ecs_gpa_3_2, 0);
  expect(test.ecs_spec.ecs_gpa_4_0, 0);
  expect(test.ecs_spec.ecs_gpa_4_3, 0);
  expect(test.ecs_spec.ecs_gpa_5_0, 0);
  expect(test.ecs_spec.ecs_gpa_5_1, 0);
  expect(test.ecs_spec.ecs_gpb_1_0, 0);
  expect(test.ecs_spec.ecs_gpb_1_2, 0);
  expect(test.ecs_spec.ecs_gpb_2_0, 0);
  expect(test.ecs_spec.ecs_gpb_2_1, 0);
  expect(test.ecs_spec.ecs_gpb_2_2, 0);
  expect(test.ecs_spec.ecs_gpb_3_0, 0);
  expect(test.ecs_spec.ecs_gpb_3_2, 0);
  expect(test.ecs_spec.ecs_gpb_4_0, 0);
  expect(test.ecs_spec.ecs_gpb_4_2, 0);
  expect(test.ecs_spec.ecs_gpb_4_3, 0);
  expect(test.ecs_spec.ecs_gpb_5_0, 0);
  expect(test.ecs_spec.ecs_gpb_5_2, 0);
  expect(test.ecs_spec.ecs_gpc_1_0, 0);
  expect(test.ecs_spec.ecs_gpc_3_0, 0);
  expect(test.ecs_spec.ecs_gpc_3_2, 0);
  expect(test.ecs_spec.ecs_gpc_3_3, 0);
  expect(test.ecs_spec.ecs_gpc_4_0, 0);
  expect(test.ecs_spec.ecs_gpc_4_3, 0);
  expect(test.ecs_spec.ecs_gpc_5_0, 0);
  expect(test.ecs_spec.ecs_gpc_5_1, 0);
  expect(test.ecs_spec.ecs_gpc_5_2, 0);
  expect(test.ecs_spec.ecs_gpc_5_3, 0);
  expect(test.ecs_spec.ecs_gpd_1_0, 0);
  expect(test.ecs_spec.ecs_gpd_1_2, 0);
  expect(test.ecs_spec.ecs_gpd_2_0, 0);
  expect(test.ecs_spec.ecs_gpd_2_3, 0);
  expect(test.ecs_spec.ecs_gpd_3_0, 0);
  expect(test.ecs_spec.ecs_gpd_3_2, 0);
  expect(test.ecs_spec.ecs_gpd_4_0, 0);
  expect(test.ecs_spec.ecs_gpd_5_0, 0);
  expect(test.ecs_spec.ecs_gpd_5_1, 0);
  expect(test.ecs_spec.ecs_gpd_5_3, 0);
  expect(test.ecs_spec.ecs_gpe_1_0, 0);
  expect(test.ecs_spec.ecs_gpe_1_3, 0);
  expect(test.ecs_spec.ecs_gpe_2_0, 0);
  expect(test.ecs_spec.ecs_gpe_2_2, 0);
  expect(test.ecs_spec.ecs_gpe_2_3, 0);
  expect(test.ecs_spec.ecs_gpe_3_0, 0);
  expect(test.ecs_spec.ecs_gpe_3_1, 0);
  expect(test.ecs_spec.ecs_gpe_3_3, 0);
  expect(test.ecs_spec.ecs_gpe_4_0, 0);
  expect(test.ecs_spec.ecs_gpe_4_1, 0);
  expect(test.ecs_spec.ecs_gpe_5_0, 0);
  expect(test.ecs_spec.ecs_gpf_1_0, 0);
  expect(test.ecs_spec.ecs_gpf_1_1, 0);
  expect(test.ecs_spec.ecs_gpf_1_2, 0);
  expect(test.ecs_spec.ecs_gpf_2_0, 0);
  expect(test.ecs_spec.ecs_gpf_5_0, 0);
  expect(test.ecs_spec.ecs_gp11_2_0, 0);
  expect(test.ecs_spec.ecs_gp11_2_2, 0);
  expect(test.ecs_spec.ecs_gp12_1_0, 0);
  expect(test.ecs_spec.ecs_gp12_3_0, 0);
  expect(test.ecs_spec.ecs_gp12_3_1, 0);
  expect(test.ecs_spec.ecs_gp12_3_2, 0);
  expect(test.ecs_spec.ecs_gp12_3_3, 0);
  expect(test.ecs_spec.ecs_gp12_4_0, 0);
  expect(test.ecs_spec.ecs_gp13_1_0, 0);
  expect(test.ecs_spec.ecs_gp13_2_0, 0);
  expect(test.ecs_spec.ecs_gp13_2_2, 0);
  expect(test.ecs_spec.ecs_gp13_3_0, 0);
  expect(test.ecs_spec.ecs_gp13_4_0, 0);
  expect(test.ecs_spec.ecs_gp13_5_0, 0);
  expect(test.ecs_spec.ecs_gp14_2_0, 0);
  expect(test.ecs_spec.ecs_gp14_2_1, 0);
  expect(test.ecs_spec.ecs_gp14_2_2, 0);
  expect(test.ecs_spec.ecs_gp14_3_0, 0);
  expect(test.ecs_spec.ecs_gp14_3_1, 0);
  expect(test.ecs_spec.ecs_gp14_3_2, 0);
  expect(test.ecs_spec.ecs_gp14_3_3, 0);
  expect(test.ecs_spec.ecs_gp14_4_0, 0);
  expect(test.ecs_spec.ecs_gp15_1_0, 0);
  expect(test.ecs_spec.ecs_gp15_1_2, 0);
  expect(test.ecs_spec.ecs_gp15_2_0, 0);
  expect(test.ecs_spec.ecs_gp15_3_0, 0);
  expect(test.ecs_spec.ecs_gp15_5_0, 0);
  expect(test.ecs_spec.ecs_gp17_1_0, 0);
  expect(test.ecs_spec.ecs_gp17_1_2, 0);
  expect(test.ecs_spec.ecs_gp17_1_3, 0);
  expect(test.ecs_spec.ecs_gp17_2_0, 0);
  expect(test.ecs_spec.ecs_gp17_2_1, 0);
  expect(test.ecs_spec.ecs_gp17_5_0, 0);
  expect(test.ecs_spec.ecs_gp18_2_0, 0);
  expect(test.ecs_spec.ecs_gp18_2_1, 0);
  expect(test.ecs_spec.ecs_gp18_2_2, 0);
  expect(test.ecs_spec.ecs_gp18_2_3, 0);
  expect(test.ecs_spec.ecs_gp18_3_0, 0);
  expect(test.ecs_spec.ecs_gp18_3_1, 0);
  expect(test.ecs_spec.ecs_gp18_3_2, 0);
  expect(test.ecs_spec.ecs_gp18_3_3, 0);
  expect(test.ecs_spec.ecs_gp18_4_2, 0);
  expect(test.ecs_spec.ecs_gp18_4_3, 0);
  expect(test.ecs_spec.ecs_gp18_5_0, 0);
  expect(test.ecs_spec.ecs_gp19_1_0, 0);
  expect(test.ecs_spec.ecs_gp19_3_2, 0);
  expect(test.ecs_spec.ecs_gp19_4_0, 0);
  expect(test.ecs_spec.ecs_gp19_5_0, 0);
  expect(test.ecs_spec.ecs_gp1a_1_2, 0);
  expect(test.ecs_spec.ecs_gp1a_3_0, 0);
  expect(test.ecs_spec.ecs_gp1a_4_0, 0);
  expect(test.ecs_spec.ecs_gp1a_4_3, 0);
  expect(test.ecs_spec.ecs_gp1a_5_0, 0);
  expect(test.ecs_spec.ecs_gp1a_5_1, 0);
  expect(test.ecs_spec.ecs_gp1a_5_2, 0);
  expect(test.ecs_spec.ecs_gp1e_1_0, 0);
  expect(test.ecs_spec.ecs_gp1e_4_0, 0);
  expect(test.ecs_spec.ecs_gp1f_1_0, 0);
  expect(test.ecs_spec.ecs_gp1f_3_0, 0);
  expect(test.ecs_spec.ecs_gp1f_5_0, 0);
  expect(test.ecs_spec.ecs_gp1f_5_2, 0);
  expect(test.datetime.save_datetime, "");
  expect(test.datetime.acb_select, 0);
}

void allPropatyCheck(Ecs_specJsonFile test, bool firstItemCheck)
{
  if(firstItemCheck == true) {
    expect(test.ecs_spec.ecs_gp0_1_0, 0);
  }
  expect(test.ecs_spec.ecs_gp0_1_2, 0);
  expect(test.ecs_spec.ecs_gp0_2_0, 0);
  expect(test.ecs_spec.ecs_gp0_2_2, 0);
  expect(test.ecs_spec.ecs_gp0_3_0, 0);
  expect(test.ecs_spec.ecs_gp0_3_1, 0);
  expect(test.ecs_spec.ecs_gp0_3_2, 0);
  expect(test.ecs_spec.ecs_gp0_3_3, 0);
  expect(test.ecs_spec.ecs_gp0_4_0, 0);
  expect(test.ecs_spec.ecs_gp0_5_0, 0);
  expect(test.ecs_spec.ecs_gp0_5_2, 0);
  expect(test.ecs_spec.ecs_gp1_1_0, 0);
  expect(test.ecs_spec.ecs_gp1_1_2, 0);
  expect(test.ecs_spec.ecs_gp1_2_0, 0);
  expect(test.ecs_spec.ecs_gp1_2_2, 0);
  expect(test.ecs_spec.ecs_gp1_3_0, 0);
  expect(test.ecs_spec.ecs_gp1_3_1, 0);
  expect(test.ecs_spec.ecs_gp1_3_2, 0);
  expect(test.ecs_spec.ecs_gp1_4_0, 0);
  expect(test.ecs_spec.ecs_gp1_4_2, 0);
  expect(test.ecs_spec.ecs_gp1_4_3, 0);
  expect(test.ecs_spec.ecs_gp1_5_0, 0);
  expect(test.ecs_spec.ecs_gp2_1_0, 0);
  expect(test.ecs_spec.ecs_gp2_1_2, 0);
  expect(test.ecs_spec.ecs_gp2_2_0, 0);
  expect(test.ecs_spec.ecs_gp2_2_2, 0);
  expect(test.ecs_spec.ecs_gp2_3_0, 0);
  expect(test.ecs_spec.ecs_gp2_3_1, 0);
  expect(test.ecs_spec.ecs_gp2_3_2, 0);
  expect(test.ecs_spec.ecs_gp2_4_0, 0);
  expect(test.ecs_spec.ecs_gp2_4_1, 0);
  expect(test.ecs_spec.ecs_gp2_5_0, 0);
  expect(test.ecs_spec.ecs_gp3_1_0, 0);
  expect(test.ecs_spec.ecs_gp3_1_1, 0);
  expect(test.ecs_spec.ecs_gp3_1_2, 0);
  expect(test.ecs_spec.ecs_gp3_1_3, 0);
  expect(test.ecs_spec.ecs_gp3_2_0, 0);
  expect(test.ecs_spec.ecs_gp3_2_1, 0);
  expect(test.ecs_spec.ecs_gp3_2_2, 0);
  expect(test.ecs_spec.ecs_gp3_2_3, 0);
  expect(test.ecs_spec.ecs_gp3_3_0, 0);
  expect(test.ecs_spec.ecs_gp3_3_2, 0);
  expect(test.ecs_spec.ecs_gp3_4_0, 0);
  expect(test.ecs_spec.ecs_gp4_1_0, 0);
  expect(test.ecs_spec.ecs_gp4_1_1, 0);
  expect(test.ecs_spec.ecs_gp4_1_2, 0);
  expect(test.ecs_spec.ecs_gp4_1_3, 0);
  expect(test.ecs_spec.ecs_gp4_2_0, 0);
  expect(test.ecs_spec.ecs_gp4_2_1, 0);
  expect(test.ecs_spec.ecs_gp4_2_2, 0);
  expect(test.ecs_spec.ecs_gp4_2_3, 0);
  expect(test.ecs_spec.ecs_gp4_3_0, 0);
  expect(test.ecs_spec.ecs_gp4_3_1, 0);
  expect(test.ecs_spec.ecs_gp4_3_2, 0);
  expect(test.ecs_spec.ecs_gp4_3_3, 0);
  expect(test.ecs_spec.ecs_gp4_4_0, 0);
  expect(test.ecs_spec.ecs_gp4_4_2, 0);
  expect(test.ecs_spec.ecs_gp5_1_0, 0);
  expect(test.ecs_spec.ecs_gp5_3_0, 0);
  expect(test.ecs_spec.ecs_gp5_5_0, 0);
  expect(test.ecs_spec.ecs_gp5_5_1, 0);
  expect(test.ecs_spec.ecs_gp5_5_2, 0);
  expect(test.ecs_spec.ecs_gp6_1_0, 0);
  expect(test.ecs_spec.ecs_gp6_3_0, 0);
  expect(test.ecs_spec.ecs_gp6_5_0, 0);
  expect(test.ecs_spec.ecs_gp7_1_0, 0);
  expect(test.ecs_spec.ecs_gp7_1_1, 0);
  expect(test.ecs_spec.ecs_gp7_1_2, 0);
  expect(test.ecs_spec.ecs_gp7_2_0, 0);
  expect(test.ecs_spec.ecs_gp7_2_1, 0);
  expect(test.ecs_spec.ecs_gp7_2_2, 0);
  expect(test.ecs_spec.ecs_gp7_3_0, 0);
  expect(test.ecs_spec.ecs_gp7_5_0, 0);
  expect(test.ecs_spec.ecs_gp7_5_2, 0);
  expect(test.ecs_spec.ecs_gp8_1_0, 0);
  expect(test.ecs_spec.ecs_gp8_1_1, 0);
  expect(test.ecs_spec.ecs_gp8_1_3, 0);
  expect(test.ecs_spec.ecs_gp8_2_0, 0);
  expect(test.ecs_spec.ecs_gp8_2_1, 0);
  expect(test.ecs_spec.ecs_gp8_2_2, 0);
  expect(test.ecs_spec.ecs_gp8_3_0, 0);
  expect(test.ecs_spec.ecs_gp8_3_1, 0);
  expect(test.ecs_spec.ecs_gp8_3_2, 0);
  expect(test.ecs_spec.ecs_gp8_4_0, 0);
  expect(test.ecs_spec.ecs_gp9_1_0, 0);
  expect(test.ecs_spec.ecs_gp9_1_1, 0);
  expect(test.ecs_spec.ecs_gp9_1_2, 0);
  expect(test.ecs_spec.ecs_gp9_2_0, 0);
  expect(test.ecs_spec.ecs_gp9_4_0, 0);
  expect(test.ecs_spec.ecs_gp9_4_2, 0);
  expect(test.ecs_spec.ecs_gp9_5_0, 0);
  expect(test.ecs_spec.ecs_gp9_5_1, 0);
  expect(test.ecs_spec.ecs_gp9_5_2, 0);
  expect(test.ecs_spec.ecs_gp9_5_3, 0);
  expect(test.ecs_spec.ecs_gpa_1_0, 0);
  expect(test.ecs_spec.ecs_gpa_1_1, 0);
  expect(test.ecs_spec.ecs_gpa_1_2, 0);
  expect(test.ecs_spec.ecs_gpa_2_0, 0);
  expect(test.ecs_spec.ecs_gpa_2_1, 0);
  expect(test.ecs_spec.ecs_gpa_2_2, 0);
  expect(test.ecs_spec.ecs_gpa_3_0, 0);
  expect(test.ecs_spec.ecs_gpa_3_1, 0);
  expect(test.ecs_spec.ecs_gpa_3_2, 0);
  expect(test.ecs_spec.ecs_gpa_4_0, 0);
  expect(test.ecs_spec.ecs_gpa_4_3, 0);
  expect(test.ecs_spec.ecs_gpa_5_0, 0);
  expect(test.ecs_spec.ecs_gpa_5_1, 0);
  expect(test.ecs_spec.ecs_gpb_1_0, 0);
  expect(test.ecs_spec.ecs_gpb_1_2, 0);
  expect(test.ecs_spec.ecs_gpb_2_0, 0);
  expect(test.ecs_spec.ecs_gpb_2_1, 0);
  expect(test.ecs_spec.ecs_gpb_2_2, 0);
  expect(test.ecs_spec.ecs_gpb_3_0, 0);
  expect(test.ecs_spec.ecs_gpb_3_2, 0);
  expect(test.ecs_spec.ecs_gpb_4_0, 0);
  expect(test.ecs_spec.ecs_gpb_4_2, 0);
  expect(test.ecs_spec.ecs_gpb_4_3, 0);
  expect(test.ecs_spec.ecs_gpb_5_0, 0);
  expect(test.ecs_spec.ecs_gpb_5_2, 0);
  expect(test.ecs_spec.ecs_gpc_1_0, 0);
  expect(test.ecs_spec.ecs_gpc_3_0, 0);
  expect(test.ecs_spec.ecs_gpc_3_2, 0);
  expect(test.ecs_spec.ecs_gpc_3_3, 0);
  expect(test.ecs_spec.ecs_gpc_4_0, 0);
  expect(test.ecs_spec.ecs_gpc_4_3, 0);
  expect(test.ecs_spec.ecs_gpc_5_0, 0);
  expect(test.ecs_spec.ecs_gpc_5_1, 0);
  expect(test.ecs_spec.ecs_gpc_5_2, 0);
  expect(test.ecs_spec.ecs_gpc_5_3, 0);
  expect(test.ecs_spec.ecs_gpd_1_0, 0);
  expect(test.ecs_spec.ecs_gpd_1_2, 0);
  expect(test.ecs_spec.ecs_gpd_2_0, 0);
  expect(test.ecs_spec.ecs_gpd_2_3, 0);
  expect(test.ecs_spec.ecs_gpd_3_0, 0);
  expect(test.ecs_spec.ecs_gpd_3_2, 0);
  expect(test.ecs_spec.ecs_gpd_4_0, 0);
  expect(test.ecs_spec.ecs_gpd_5_0, 0);
  expect(test.ecs_spec.ecs_gpd_5_1, 0);
  expect(test.ecs_spec.ecs_gpd_5_3, 0);
  expect(test.ecs_spec.ecs_gpe_1_0, 0);
  expect(test.ecs_spec.ecs_gpe_1_3, 0);
  expect(test.ecs_spec.ecs_gpe_2_0, 0);
  expect(test.ecs_spec.ecs_gpe_2_2, 0);
  expect(test.ecs_spec.ecs_gpe_2_3, 0);
  expect(test.ecs_spec.ecs_gpe_3_0, 0);
  expect(test.ecs_spec.ecs_gpe_3_1, 0);
  expect(test.ecs_spec.ecs_gpe_3_3, 0);
  expect(test.ecs_spec.ecs_gpe_4_0, 0);
  expect(test.ecs_spec.ecs_gpe_4_1, 0);
  expect(test.ecs_spec.ecs_gpe_5_0, 0);
  expect(test.ecs_spec.ecs_gpf_1_0, 0);
  expect(test.ecs_spec.ecs_gpf_1_1, 0);
  expect(test.ecs_spec.ecs_gpf_1_2, 0);
  expect(test.ecs_spec.ecs_gpf_2_0, 0);
  expect(test.ecs_spec.ecs_gpf_5_0, 0);
  expect(test.ecs_spec.ecs_gp11_2_0, 0);
  expect(test.ecs_spec.ecs_gp11_2_2, 0);
  expect(test.ecs_spec.ecs_gp12_1_0, 0);
  expect(test.ecs_spec.ecs_gp12_3_0, 0);
  expect(test.ecs_spec.ecs_gp12_3_1, 0);
  expect(test.ecs_spec.ecs_gp12_3_2, 0);
  expect(test.ecs_spec.ecs_gp12_3_3, 0);
  expect(test.ecs_spec.ecs_gp12_4_0, 0);
  expect(test.ecs_spec.ecs_gp13_1_0, 0);
  expect(test.ecs_spec.ecs_gp13_2_0, 0);
  expect(test.ecs_spec.ecs_gp13_2_2, 0);
  expect(test.ecs_spec.ecs_gp13_3_0, 0);
  expect(test.ecs_spec.ecs_gp13_4_0, 0);
  expect(test.ecs_spec.ecs_gp13_5_0, 0);
  expect(test.ecs_spec.ecs_gp14_2_0, 0);
  expect(test.ecs_spec.ecs_gp14_2_1, 0);
  expect(test.ecs_spec.ecs_gp14_2_2, 0);
  expect(test.ecs_spec.ecs_gp14_3_0, 0);
  expect(test.ecs_spec.ecs_gp14_3_1, 0);
  expect(test.ecs_spec.ecs_gp14_3_2, 0);
  expect(test.ecs_spec.ecs_gp14_3_3, 0);
  expect(test.ecs_spec.ecs_gp14_4_0, 0);
  expect(test.ecs_spec.ecs_gp15_1_0, 0);
  expect(test.ecs_spec.ecs_gp15_1_2, 0);
  expect(test.ecs_spec.ecs_gp15_2_0, 0);
  expect(test.ecs_spec.ecs_gp15_3_0, 0);
  expect(test.ecs_spec.ecs_gp15_5_0, 0);
  expect(test.ecs_spec.ecs_gp17_1_0, 0);
  expect(test.ecs_spec.ecs_gp17_1_2, 0);
  expect(test.ecs_spec.ecs_gp17_1_3, 0);
  expect(test.ecs_spec.ecs_gp17_2_0, 0);
  expect(test.ecs_spec.ecs_gp17_2_1, 0);
  expect(test.ecs_spec.ecs_gp17_5_0, 0);
  expect(test.ecs_spec.ecs_gp18_2_0, 0);
  expect(test.ecs_spec.ecs_gp18_2_1, 0);
  expect(test.ecs_spec.ecs_gp18_2_2, 0);
  expect(test.ecs_spec.ecs_gp18_2_3, 0);
  expect(test.ecs_spec.ecs_gp18_3_0, 0);
  expect(test.ecs_spec.ecs_gp18_3_1, 0);
  expect(test.ecs_spec.ecs_gp18_3_2, 0);
  expect(test.ecs_spec.ecs_gp18_3_3, 0);
  expect(test.ecs_spec.ecs_gp18_4_2, 0);
  expect(test.ecs_spec.ecs_gp18_4_3, 0);
  expect(test.ecs_spec.ecs_gp18_5_0, 0);
  expect(test.ecs_spec.ecs_gp19_1_0, 0);
  expect(test.ecs_spec.ecs_gp19_3_2, 0);
  expect(test.ecs_spec.ecs_gp19_4_0, 0);
  expect(test.ecs_spec.ecs_gp19_5_0, 0);
  expect(test.ecs_spec.ecs_gp1a_1_2, 0);
  expect(test.ecs_spec.ecs_gp1a_3_0, 0);
  expect(test.ecs_spec.ecs_gp1a_4_0, 0);
  expect(test.ecs_spec.ecs_gp1a_4_3, 0);
  expect(test.ecs_spec.ecs_gp1a_5_0, 0);
  expect(test.ecs_spec.ecs_gp1a_5_1, 0);
  expect(test.ecs_spec.ecs_gp1a_5_2, 0);
  expect(test.ecs_spec.ecs_gp1e_1_0, 0);
  expect(test.ecs_spec.ecs_gp1e_4_0, 0);
  expect(test.ecs_spec.ecs_gp1f_1_0, 0);
  expect(test.ecs_spec.ecs_gp1f_3_0, 0);
  expect(test.ecs_spec.ecs_gp1f_5_0, 0);
  expect(test.ecs_spec.ecs_gp1f_5_2, 0);
  expect(test.datetime.save_datetime, "0000/00/00 00:00");
  expect(test.datetime.acb_select, 0);
}

